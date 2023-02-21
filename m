Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4472969E6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBUSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBUSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:05:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4112FCFB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:04:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ko13so6595024plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCAjmH+y9RfcSzdsqktWB2qihaToifWXvEEckSYFn1U=;
        b=cU+qS1cAwy/+6/YsKudl6aFY83WeYfdNkUxRNjXboI53GB2RXfA7NKjWuZmgDz/d1C
         buCc5HCXS4h4PTgFk2RuCicEaCcw7TpdEUAJlIJGR28Xn3xb8YwZys+ge8j3sGGtCWia
         WXtYVfAP31VrjczgWUpI4/RmcX3GdDwJEurlXz1GycoBMnbNEw/RIUtq8NWI9/wXA0FF
         blZexmwat0G0MfAdAljh5/hHVMAP9vSb3/kEIxAmbX9/QC6WBkKDGj76yMaAzkQgQjDc
         HnG0mYMtVCLi9h2zAZiJki93BNA8/17mG2xQ9STIsAPVMzwfTHJyai1ySZ1spHa2Vjhj
         uFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCAjmH+y9RfcSzdsqktWB2qihaToifWXvEEckSYFn1U=;
        b=npcRI4cPf54+Pjl0xcAwcvjdH3PtAwFSJCE1cGyoFKjxnnZ2AKOS7b3fffGCKT6iEz
         sfW6ckJLmAb8TYnAdTjvfWHd2KJ7u/dQc3Xs6/V5LtiNSyNTlHVxQEM0Vt+WHpapnp4I
         /9oJKJrVt+Nt5Lx/3FerW+O0W2lPljFUI1ptHCUPsgUt6mOu+I8USUXdfiqM1Vl+UxpW
         vWgoMevp3TKBbrcZ+EeDt94l+mMgkzIkHFHX4luVU6nLcjqSxxfO3H+h/6w4hPOnV9JH
         ET8jVyEdynbVra9sSZeph8SSMABcQDv5rRSqm/O4bbW3ILCLKB+G+nNE+KxQudKEXGBG
         u2dQ==
X-Gm-Message-State: AO0yUKVO/jGCaCM5ygK3E48xz3FSETThy49C/FSZttL6TRX3YG23Sexg
        bjeg1DTsmJVuZXw9jWTDAnMBm2jFkrL3t4MO4qU=
X-Google-Smtp-Source: AK7set+DPvt4gc1+MMSfea4jAKfm3GuiLqy6YIIuhZXw3q9nS6EVev/33IgWsrSeIZ4R0sI9pU5NSkPSQXtwRvPcVUs=
X-Received: by 2002:a17:902:f783:b0:198:f13d:571b with SMTP id
 q3-20020a170902f78300b00198f13d571bmr730679pln.1.1677002697193; Tue, 21 Feb
 2023 10:04:57 -0800 (PST)
MIME-Version: 1.0
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp> <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
 <CACosJgyjgh+cz6nTrKWVQ9P8Z9_wJGWGQBOjae2MoJrZQ3RmTQ@mail.gmail.com> <Y/T5L1ZIssWY5wQZ@kbusch-mbp>
In-Reply-To: <Y/T5L1ZIssWY5wQZ@kbusch-mbp>
From:   Michal Berger <michallinuxstuff@gmail.com>
Date:   Tue, 21 Feb 2023 19:04:46 +0100
Message-ID: <CACosJgxLbU95SuPo+oPCT-0EyG4p_CpgLAh+WafQxCN0Yn0Lhw@mail.gmail.com>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
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

Oh, that's quite alright -  I asked just to make sure I didn't miss
anything. :) With that said, I just spun up the build (based on
89f5349e) with your commit inside and I can confirm the issue is fixed
on my end (all the attributes are back where they should be).
Appreciate the help!

Regards,
Michal


wt., 21 lut 2023 o 18:02 Keith Busch <kbusch@kernel.org> napisa=C5=82(a):
>
> On Sun, Feb 19, 2023 at 11:54:37PM +0100, Michal Berger wrote:
> > Have there been any patches submitted for testing? I don't see any as
> > part of this thread nor at the bugzilla where the issue was initially
> > reported. :)
>
> I'm sorry, I didn't see your email in the bugzilla. With time running out=
, I
> just posted the patch for upstream with a link to your original report, b=
ut I
> apologize for not getting you CC'ed on it. The fix is included in the 6.2
> release.
