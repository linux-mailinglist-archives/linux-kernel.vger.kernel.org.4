Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8E74ECD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGKLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGKLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:30:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23D11D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:29:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3159da54e95so1805365f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1689074996; x=1691666996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/uH1e+klm+zs24dqIEDW59pXBhAgUeRKnnXFqc/9+A=;
        b=lYWgFyrTqV7V50Rqrv0wKkxXfRDoiDGtZkuRMugcuCf67af9LOxtgfH0nWOFtigNMc
         DrfaT8Mvj7sGkb4jSwTK4MJgbxqwS7ZY56dhzHbB1c5eGZehDdX9Hhbv+UdYVja6K9LX
         t4uvMaHMJA7d8cihItub2AMOB6vdcD+DDcPAxfz2rhwbspP6Iyp6hKI6QN5pGFlMkQfd
         5nsKsyZ5P5NQ3k6+Z0u2MTneJib8PsdQmapy0cu5JiZTQs/aaKjdKpgIdl7zN+MezXOF
         56hqC7tQucuGfM5sYqTs+8tb9HU63zizqdW+gncLCZrdRNQzT1xPuuCny9rxTK9/1OtW
         7+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689074996; x=1691666996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/uH1e+klm+zs24dqIEDW59pXBhAgUeRKnnXFqc/9+A=;
        b=J/7TvEXxw+cZJ2gq7mWzNBNszjLbPU0wAEHnfZIor3FH3Hmcz0b7DPicAnLpY5+BRg
         aaAv1eVS99iGhrTr7LBzxyU9KfyKx49qtWH0bSj3UBLCedaegdW2zKyw1WHCKPnNcH+N
         SGAaIga4LCt1cdv/AbXAy9dVW7poR9h7HvC6F3uQ133ENPv75SIThvn02dRnfM+K8y8x
         Q8NeVqVmi/JGjB+Zu4+nTj4Z5c0vHM9hP0yR65PpHrz7d/4/XD13UoOxNmmzvrwfmaTO
         Q4k05noJ5Cgjx8Y8c19s//sOY2W0c6WedxjQDT2oWNiwiQS13wOvDQaluQhmTQU+sOoe
         5B3Q==
X-Gm-Message-State: ABy/qLbaAEBHPYbYhGa4XAfQM/qGLUCKyOjsa8Vjd6+Lq0MyfPoQ/YIQ
        AAdVQUH5Rg51iYx56QxWZW3l15WrWR7cfh8JVOo8vgEI9HKoe7oANTg=
X-Google-Smtp-Source: APBJJlG2PB2BAfr3M6geuBK8xXTGts8Ybwpe5accke8vRMt2XdyjsumKhw0BHM58Mw1yeP9s30wXJa84TA80uJ22jPc=
X-Received: by 2002:a5d:490b:0:b0:314:4db:e0b2 with SMTP id
 x11-20020a5d490b000000b0031404dbe0b2mr14911973wrq.15.1689074995947; Tue, 11
 Jul 2023 04:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <20230426141520.0caf4386@meshulam.tesarici.cz> <2023042617-wobble-enlighten-9361@gregkh>
 <20230426144439.5674f8bc@meshulam.tesarici.cz> <20230509091635.27450bd9@meshulam.tesarici.cz>
 <2023050949-grueling-verify-a43b@gregkh> <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
 <20230711110325.2521472c@meshulam.tesarici.cz>
In-Reply-To: <20230711110325.2521472c@meshulam.tesarici.cz>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 11 Jul 2023 12:29:44 +0100
Message-ID: <CAHbf0-FjiOAMHjh-7D_6gvS+oHr2tGKJArnYu=0AKYHbD8Ntrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 at 10:03, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wro=
te:
>
> On Mon, 10 Jul 2023 23:23:45 +0100
> Mike Lothian <mike@fireburn.co.uk> wrote:
>
> > Hi
> >
> > I was hoping this might land for 6.5-rc1, is there a new version that
> > might apply against 6.5?
>
> Yes, there is a v3, which is a complete rewrite based on feedback from
> various people on this mailing list:
>
> https://lore.kernel.org/linux-iommu/cover.1687859323.git.petr.tesarik.ext=
@huawei.com/T/
>
> Petr T
>


Patch 2 doesn't apply cleanly for me on 6.5-rc1
