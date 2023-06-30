Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AFE743E89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjF3PTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjF3PSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:18:51 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF92707
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:18:37 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56352146799so1303640eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688138317; x=1690730317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfOVdHgYJ1E6F9PfNyEObZ4qWmQU8ebGaDanILDhjPU=;
        b=P0IuK3hQpNVumn4PqzXdGpFy72R5KBK62N0w2JbvXroB3MbE0Nu4r8yGEAQ/aSLaMu
         pNDgbb5pHwQ/uaoc1NYgK1x5YcpGYhCS2eiZiIW3bCZkIfcrnEmpfzx7PNF9EShG9mgW
         VnRPqUPqOInB1e4tzK2Vrd6IpZuUqw0Z3v8zRPX+nrI4YsinvYMXsKgoDrrJYXnCOhep
         4ts6QRpsifcAmr4U1YJI5g9D4bCEDLasIpZ/iAjT6r5ilMmFglUOeax0iiv1o+oG2+BJ
         LWgK2KwS/bNBGXBLvfOJK1/tzPqDLAT5D7/aZG23DR9GyCh58jaUMlXukVer960D9zUB
         3/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138317; x=1690730317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfOVdHgYJ1E6F9PfNyEObZ4qWmQU8ebGaDanILDhjPU=;
        b=cawniZ/LVks5zFGn1fRJSNaSNUb7iI+KVZjzm0+Qn/wAuA6anctCmRcdIbYW1BLK2G
         tRcSzVQ6ZhSkCrQGirVOej/7+EmxgrQAqjM2E0ehC7jG1mLVGus9A0fQFy8DkY+BRE7a
         B1DISQ4/dEiXhORhf20aA66k1V6fHJPsz4a+iGMK0mafpfEz3Ry03SXUWeJvJnkYu2US
         GN02LznWZZLUpmADZFfB2ihbziDu47RKG+G9udb9n5HP3d1S8Am6Hd3SXW3RahuTwuyp
         NfxNwUmR5O22BrR88PCwF1GAR2FXpftWw/14cyZXjPZiWGMsAmfw+wFtJ79o2fGOkUBS
         1ubQ==
X-Gm-Message-State: AC+VfDwkgUFCn6REEISugzNltRhreyjY9c7RnDWRmqxA8ooKiSVpNjlg
        O4B+ynM8xaf55KYan+VF8GenUVbigUC+b/AQVu8=
X-Google-Smtp-Source: ACHHUZ6cTe4piYpQSfx2HLnXKCP0BNrb+SjDlKLlHFK7a95mz2TGtuUpknPXkTj31zKplY+magfaLhJ7/hJB+0waUi4=
X-Received: by 2002:a4a:97ab:0:b0:563:5069:2323 with SMTP id
 w40-20020a4a97ab000000b0056350692323mr2345485ooi.5.1688138316821; Fri, 30 Jun
 2023 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <CGME20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5@eucas1p1.samsung.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
In-Reply-To: <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
From:   Clemens Springsguth <cspringsguth@gmail.com>
Date:   Fri, 30 Jun 2023 17:18:00 +0200
Message-ID: <CABfnBFoZ=gh2rkY_oYWzjkGcu8HPQ2FqnrnushH0DZFSi8cwOg@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Jinhwan Park <jh.i.park@samsung.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj,

i would be very very grateful if you would create and submit the quirk
as a proper patch.

kind regards
Clemens


On Fri, Jun 30, 2023 at 10:40=E2=80=AFAM Pankaj Raghav <p.raghav@samsung.co=
m> wrote:
>
> On 2023-06-27 18:10, Keith Busch wrote:
> > On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
> >> See Bugzilla for the full thread.
> >>
> >> The reporter had a quirk (see above) that fixed this regression,
> >> nevertheless I'm adding it to regzbot to make sure it doesn't fall
> >> through cracks unnoticed:
> >>
> >> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_=
bug.cgi?id=3D217593
> >> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCG=
L-000MV
> >
> > These bug reports really should go to the vendors that created the
> > broken device with non-unique "unique" fields. It's easy enough for me
> > to write the quirk patch, but it's not the ideal solution and may harm
> > devices/firmwares with the same VID:DID that don't have this problem.
> > Not being the vendor, I'm not in a postition to know that, so CC'ing
> > some Samsung folks.
>
> I got a reply from our team internally. There is no plan on releasing
> a new firmware for this model and the related models with the same VID:DI=
D
> pair. We can add a quirk.
>
> @Clemens: Let me know if you want me to send the quirk as a proper patch.
