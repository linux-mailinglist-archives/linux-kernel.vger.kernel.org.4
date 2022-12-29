Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0C865932D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiL2Xbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiL2Xbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:31:46 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E8915F00
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:31:42 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 192so22064424ybt.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NwlNvW8os5X59hb+wdm0uo0iYsXBEq+kQRMcnpWHiE=;
        b=0j4VQxs4nuQQ9EjiJwPgd/BWlKvqX8/RfMJ7cBnb1Q3LJKUSLHooHGvRB1cIOnqkig
         S/QQa1CbQ3LapqEQO1J/jAZP/XsLf9vqw4NPLPE8I2TCyGTqGxB520sGCoVYHzU3dxoY
         WBcxDegm3jeJk0yZSOB0l7j6PNzK0EX+ixnj5P3hO+URsg6FtBSz3aHITR/rFKENIey3
         WixOaNwb8qBnA1/w+gFXyIToQsyoyLQgtIDOommrlxN6s+tZp86wgfrwg0gYxkXP3CcG
         vBgM9+4LTtlz6v6qJNAARMWk3nyorQA5/6Z0xTOvLml2VbFMxrG/luCVxMC3GUA6Tau4
         m6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NwlNvW8os5X59hb+wdm0uo0iYsXBEq+kQRMcnpWHiE=;
        b=8CnLMpWQ8Prczrayr13MIjt8MTY/nJr04GEA48E0NZ5oYcA8DKDSDGZElxsx7C2N20
         POWOzkIEcyHXgUE7j7TmmE3cGkafKMf+liS3fG7AWi1vNcZAqjPcZpRRdYYbZuJ7GOOD
         GkYT1XmPhT7sbxZcKlxUlbVlfWSq13INqmut0iex7wxxYknyzsMe7VJBll4W9PLdXk3r
         Khtupk45JMBJjTMwWPpzzQUittlWQJLpykYN9mxzktcD6LYyMBKM+/S60lHyof65WRxX
         jITbC6EfYdvdeXHpbDam3KOsP428I36mWk8i1Km4umdyQSw2gkvpjcT/DtY7h5S4xT3a
         g5Qw==
X-Gm-Message-State: AFqh2krAHtW1NvuhHmFzUNdMkw975ybzeMSEXua++tYIPturO9MVRIum
        CK2kY6zlCUuVYy0baJ/ck/mccEY51aE2v3MqPY1gEr7eUIC6zoqx
X-Google-Smtp-Source: AMrXdXvFwo//4ugbN3LtFvW0Sxm9BywwvyVJV+up6QWzpw24GP8LTdM0mEKDLcMwEI3XthBq05XMVSeokYNuCVarIoE=
X-Received: by 2002:a25:6fd5:0:b0:6f6:648:510b with SMTP id
 k204-20020a256fd5000000b006f60648510bmr3476079ybc.637.1672356702151; Thu, 29
 Dec 2022 15:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20221117184406.292416-1-nfrayer@baylibre.com> <Y6wlhfdDdm+XAsuH@matsya>
 <52a11d11-20a0-bf08-ce64-401b5d0ad133@gmail.com>
In-Reply-To: <52a11d11-20a0-bf08-ce64-401b5d0ad133@gmail.com>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Fri, 30 Dec 2022 00:31:31 +0100
Message-ID: <CANyCTtTwAoT9O=8kUeJvsX=+KvCANHdtku8T=Brnmpy3AKysLQ@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: ti: k3-udma: Deferring probe when
 soc_device_match() returns NULL
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        glaroque@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 29 d=C3=A9c. 2022 =C3=A0 17:27, P=C3=A9ter Ujfalusi
<peter.ujfalusi@gmail.com> a =C3=A9crit :
>
>
>
> On 28/12/2022 13:16, Vinod Koul wrote:
> > On 17-11-22, 19:44, Nicolas Frayer wrote:
> >> When the k3 socinfo driver is built as a module, there is a possibilit=
y
> >> that it will probe after the k3 udma driver and the later returns -ENO=
DEV.
> >> By deferring the k3 udma probe we allow the k3 socinfo to probe and
> >> register the soc_device_attribute structure needed by the k3 udma driv=
er.
> >> Removed the dev_err() message as well as it's deferring and not failin=
g.
> >
> > lgtm, but need rebase as I already picked commit 3f58e10615f3 dmaengine=
: ti:
> > k3-udma: Add support for BCDMA CSI RX
>
> Is this path needed at all? afaik the k3 socinfo is not going to be
> module built.
>
> >
> >>
> >> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> >> ---
> >> v1->v2:
> >> Extracted this patch from the following series:
> >> https://lore.kernel.org/all/20221108181144.433087-1-nfrayer@baylibre.c=
om/
> >>
> >> v2->v3:
> >> Removed the dev_err() message
> >>
> >>   drivers/dma/ti/k3-udma.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> >> index ce8b80bb34d7..ca1512eb9910 100644
> >> --- a/drivers/dma/ti/k3-udma.c
> >> +++ b/drivers/dma/ti/k3-udma.c
> >> @@ -5271,10 +5271,10 @@ static int udma_probe(struct platform_device *=
pdev)
> >>      ud->match_data =3D match->data;
> >>
> >>      soc =3D soc_device_match(k3_soc_devices);
> >> -    if (!soc) {
> >> -            dev_err(dev, "No compatible SoC found\n");
> >> -            return -ENODEV;
> >> -    }
> >> +
> >> +    if (!soc)
> >> +            return -EPROBE_DEFER;
> >> +
> >>      ud->soc_data =3D soc->data;
> >>
> >>      ret =3D udma_get_mmrs(pdev, ud);
> >> --
> >> 2.25.1
> >
>
> --
> P=C3=A9ter
Hi Vinod, P=C3=A9ter,

This patch needs to be dropped as the k3 socinfo patch has been dropped.

Thanks,
Nicolas
