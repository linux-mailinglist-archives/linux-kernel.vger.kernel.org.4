Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4069C2FC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBSWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 17:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBSWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:54:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6DC18B1C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:54:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q22so1590076pls.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq60iPwMT9YyeuZYyBaeVXOCLyMD+LIZs+7sJUezDZU=;
        b=NZYxQ1+X02jZEYiaJJ0FEnR/k09pMGRnpL3WRKgxjY6VkopET8Pl1CsQTko02lD8yj
         HQSoD1Pkg26h3qdJvpRbyfl965FaQfcULt8lYHCNmVx2v+U29mXO7UcsE3q2+gF/rhP5
         wFYNuAmlMe/mCOOHD4HACmSCUNBZx6h6beDZu5LqD3GazOseUVpeN7zkVuIIQzChoItZ
         WnBDtK2BDNhVpkwIRJBEi4j2hw5zcoiaanvs+2rl/7Q6ecpPU9vHA3uLxnrxj52uKpfZ
         4n9IdSLdprAsyBO/gLc6822eWwciBp60bsJVPfjHpjz3oU0xAZIKk+EDJYxihW8EeO93
         Ls7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq60iPwMT9YyeuZYyBaeVXOCLyMD+LIZs+7sJUezDZU=;
        b=V6XrJcPo8/b1sk6DMMNEmCU+HupbNMPldaokP9fgMOg+wcmBxnwgO4OeEAqhh8cBJ4
         pnIv0N3kiq3eoI0H2DafIvxU6kYlPMM37FaUbnEb0aR/mVspIA0ZQyG+B+Ew/InvtjH2
         0/eTQxOCzWiFu6ZQChH9PS9MgfICW6W4nkf0gZ3vSfZfntbPZbCx362fnwPMIREkrw3k
         138TwcpL+hH4p4PtYKE1XKL/sGBCsEazXc5MRVAcUavM2LqOzLJdnWIp0HQ27DRUjyny
         Fx3DcayL03HPcnT6W7Gza5dBT5XqDJLvN++HVDQa12m35dyPmAOC8Y2vZfcziGfoOOI5
         WD4g==
X-Gm-Message-State: AO0yUKX5gGlRLmJPttVkqPwpu/dq2TYDgc7sx8u4+JOVv7T8zwn8FQ45
        ihrLXdhplF5ru4Q+L/ntUpRYo0UA4s2497CWcpMTp85locJs6A==
X-Google-Smtp-Source: AK7set+kG+DUmbdPiJsfJTmx5/zd26OJWhuaT2epIMVOS6lpWkQvJxPNa1l7k/ybyAmYhUoo3ImINDAItkhm0F2qDbA=
X-Received: by 2002:a17:90b:2643:b0:232:d23a:8314 with SMTP id
 pa3-20020a17090b264300b00232d23a8314mr809903pjb.96.1676847288595; Sun, 19 Feb
 2023 14:54:48 -0800 (PST)
MIME-Version: 1.0
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp> <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
In-Reply-To: <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
From:   Michal Berger <michallinuxstuff@gmail.com>
Date:   Sun, 19 Feb 2023 23:54:37 +0100
Message-ID: <CACosJgyjgh+cz6nTrKWVQ9P8Z9_wJGWGQBOjae2MoJrZQ3RmTQ@mail.gmail.com>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have there been any patches submitted for testing? I don't see any as
part of this thread nor at the bugzilla where the issue was initially
reported. :)

Regards,
Michal


pt., 17 lut 2023 o 22:23 Jens Axboe <axboe@kernel.dk> napisa=C5=82(a):
>
> On Thu, Feb 16, 2023 at 8:19 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Thu, Feb 16, 2023 at 10:28:55AM +0100, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> > > Hi, this is your Linux kernel regression tracker.
> > >
> > > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > > kernel developer don't keep an eye on it, I decided to forward it by
> > > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D2170=
37 :
> > >
> > > >  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> > > >
> > > > For the CMB-capable nvme ctrls, kernel was exposing couple of relat=
ed attributes under the sysfs. E.g.
> > > >
> > > >
> > > > # grep . /sys/class/nvme/nvme0/cmb*
> > > > /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> > > > /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> > > > /sys/class/nvme/nvme0/cmbloc:98
> > > > /sys/class/nvme/nvme0/cmbsz:524829
> >
> > The breakage is that the attributes are decided before we've setup the =
cmb
> > regions. I'll send a fix shortly.
>
> Michael, have you tested this? It's queued up for inclusion, but I don't
> see any evidence that this was tested.
>
> --
> Jens Axboe
>
