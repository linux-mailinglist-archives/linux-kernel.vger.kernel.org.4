Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA75B5FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiILSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiILSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:02:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFE3F32C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:02:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso6400728otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hpQfyYER++ZVoMkHEu62P5d1pUi0Jd4MiUp5JntBpPo=;
        b=FBvxz68IdprF+9yu1u8Hw1qSsZbO5EhTFUkmQPAjFvMhZ7mNqDlqFGYGOYfychHet/
         dQsK2GKe0Z6Nm7iFtuh17C9Z3/H9yMevRwrU7DZncyv8wdf7zLa5I+tFHJZ/jqn3d3O/
         utwgIXleCjJrbV70Bw/CUQs2Tcv/TqUULvsUyv3O7Rb36zZyyxKyFU0MmilBKxdy8xEy
         MiF2qKoFsH8y2z7aOEktLcC95dslnWv0GVTHe7xI3GJFcGanvzEtj3sZzAeZMFVGe6a6
         qEoBuky2YuczOCZ06XdzDXpneJGW9TKQSBy3uJwynWq551tDehG000gKgy1v0zrGZFUF
         v2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hpQfyYER++ZVoMkHEu62P5d1pUi0Jd4MiUp5JntBpPo=;
        b=xzc+iiOEkzP1cXRuL9H4zH73Fa3Gy9aSre3reL159ihHSd+6J+cqag7Q7TVuiR7WSD
         wAVcRFnL7RJ19wrTBTHy++MhqVxoEbBzMncCoXe63ff6gXy5eIh1/NtY9yoCOikEKLMe
         AB2BWt8MMZFMEYCWbd1c2tFTIKAi+sBg6zM6YBPmd+S1B8yMnHr758PLC3KFlOt1kak8
         gK0Yjiy6ksr7EA5FUYXjG2WI7hx1atxCC0r4O5QEft852wOcAJeoYjTY/RENrdFV+RBq
         xCbOR/40kF8PLcCokw/nWrUcvzkbC54cC3czmkQFKhmAqCGpZ6C9YArFlt30QGHgCERL
         4TOQ==
X-Gm-Message-State: ACgBeo0aBWq/+soZ0s1qK3sjgFFu9qjGkpCW2lxMAc9x3di9T+52U70j
        miCpQNVjRTx3JiE3Tlb1Y0dDCJsf0+wmnDA4u4Htvw==
X-Google-Smtp-Source: AA6agR5jybZkvIEfZh4kpH/SL2IoZaspZpJ/N6zTxdgEH7ed8Z5noEEWSQuFrlyD+UPvS5eeyKXR/QWsbQgR74bHfE4=
X-Received: by 2002:a9d:bc2:0:b0:654:c63:5b23 with SMTP id 60-20020a9d0bc2000000b006540c635b23mr8526142oth.48.1663005719384;
 Mon, 12 Sep 2022 11:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220812173526.15537-1-tharvey@gateworks.com> <20220812173526.15537-2-tharvey@gateworks.com>
 <CAJ+vNU3QWWza-Q956GSLVvYJHC9owApyQD8Y1WNVDs0=qqz8-A@mail.gmail.com>
 <CAJ+vNU3qv6yi48W6jX3-x-MiAFTU3AtbqsM-V8Dw29ZJFDrdKQ@mail.gmail.com> <20220912080449.GQ1728671@dragon>
In-Reply-To: <20220912080449.GQ1728671@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 12 Sep 2022 11:01:47 -0700
Message-ID: <CAJ+vNU0n7kghjD7D1JDJYr5LtrLmd0QMrdxL0x9n3QCg=eF9mg@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: imx8mp-venice-gw74xx: remove invalid and
 unused pinctrl_sai2
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 1:04 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Sep 08, 2022 at 08:45:24AM -0700, Tim Harvey wrote:
> > On Mon, Aug 22, 2022 at 10:03 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Fri, Aug 12, 2022 at 10:35 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > > >
> > > > pinctrl_sai2 is not yet used and not properly defined - remove it to
> > > > avoid:
> > > > imx8mp-pinctrl 30330000.pinctrl: Invalid fsl,pins or pins propert
> > > > y in node /soc@0/bus@30000000/pinctrl@30330000/sai2grp
> > > >
> > > > Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts
> > > > support")
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 9 ---------
> > > >  1 file changed, 9 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > > index de17021df53f..80f0f1aafdbf 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > > @@ -768,15 +768,6 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09       0x110
> > > >                 >;
> > > >         };
> > > >
> > > > -       pinctrl_sai2: sai2grp {
> > > > -               fsl,pins = <
> > > > -                       MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
> > > > -                       MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
> > > > -                       MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
> > > > -                       MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
> > > > -               >;
> > > > -       };
> > > > -
> > > >         pinctrl_spi2: spi2grp {
> > > >                 fsl,pins = <
> > > >                         MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK   0x82
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Shawn,
> > >
> > > You can drop this. I didn't see Peng's patch commit 706dd9d30d3b
> > > ("arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings") which
> > > takes care of this.
> > >
> > > Best Regards,
> > >
> > > Tim
> >
> > Shawn,
> >
> > Did you need me to re-submit the series this patch was in without it?
> > I haven't seen any responses to the rest of the patches in this
> > series.
>
> You said you will send a new version in responding to Fabio's comment on
> patch 1/6 [1], right?
>
> Shawn
>
> [1] https://lore.kernel.org/linux-arm-kernel/CAJ+vNU3E+5DWR5tQyUurLzGkinjX2fidbVNZ4T70CNmhM6eNTw@mail.gmail.com/

Shawn,

Yes, I will re-submit that series.

Thanks,

Tim
