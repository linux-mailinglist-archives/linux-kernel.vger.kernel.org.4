Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1825B55AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiILIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiILIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:05:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96724E03F;
        Mon, 12 Sep 2022 01:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58429B80B9F;
        Mon, 12 Sep 2022 08:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059F5C433C1;
        Mon, 12 Sep 2022 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662969896;
        bh=m2DzyTHCqjvMi1agOjv9SowMwvteEJjnRMhOv1dZGGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyNoyMQEBQpEvH2jI9GNhoaZUXWt12M+fa5yqw7cfD4zmBrbbJL2QEgvU9iNWtSKI
         mSdkkyqm0EcYQqmrtAjfi0wSY/BuyW3bGjnCOGn2BUUjpvWzeClaDHW481g58PyXop
         Vn3rInLhDK4kwxs4o1Iy6eGYTQ7RinHre5xsJdY7zPnmtenV62vuoZegWJhe4iYH0h
         mV8G/0AqDQJFPBREYJzKpUhoLLb8tgh6cmE9/QbacuBAyAMOZaelry588nt+lKY1sf
         /mHUWamRXEMrktnyOARVgjUVtVP+TZpNxqb3wNNu3eNy1Eh7/JMr5/HHhpH4Ewvdxy
         Ht2+N0GBrE6iA==
Date:   Mon, 12 Sep 2022 16:04:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH 2/6] arm64: dts: imx8mp-venice-gw74xx: remove invalid and
 unused pinctrl_sai2
Message-ID: <20220912080449.GQ1728671@dragon>
References: <20220812173526.15537-1-tharvey@gateworks.com>
 <20220812173526.15537-2-tharvey@gateworks.com>
 <CAJ+vNU3QWWza-Q956GSLVvYJHC9owApyQD8Y1WNVDs0=qqz8-A@mail.gmail.com>
 <CAJ+vNU3qv6yi48W6jX3-x-MiAFTU3AtbqsM-V8Dw29ZJFDrdKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3qv6yi48W6jX3-x-MiAFTU3AtbqsM-V8Dw29ZJFDrdKQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:45:24AM -0700, Tim Harvey wrote:
> On Mon, Aug 22, 2022 at 10:03 AM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Fri, Aug 12, 2022 at 10:35 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > pinctrl_sai2 is not yet used and not properly defined - remove it to
> > > avoid:
> > > imx8mp-pinctrl 30330000.pinctrl: Invalid fsl,pins or pins propert
> > > y in node /soc@0/bus@30000000/pinctrl@30330000/sai2grp
> > >
> > > Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts
> > > support")
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 9 ---------
> > >  1 file changed, 9 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > index de17021df53f..80f0f1aafdbf 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > @@ -768,15 +768,6 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09       0x110
> > >                 >;
> > >         };
> > >
> > > -       pinctrl_sai2: sai2grp {
> > > -               fsl,pins = <
> > > -                       MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
> > > -                       MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
> > > -                       MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
> > > -                       MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
> > > -               >;
> > > -       };
> > > -
> > >         pinctrl_spi2: spi2grp {
> > >                 fsl,pins = <
> > >                         MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK   0x82
> > > --
> > > 2.25.1
> > >
> >
> > Shawn,
> >
> > You can drop this. I didn't see Peng's patch commit 706dd9d30d3b
> > ("arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings") which
> > takes care of this.
> >
> > Best Regards,
> >
> > Tim
> 
> Shawn,
> 
> Did you need me to re-submit the series this patch was in without it?
> I haven't seen any responses to the rest of the patches in this
> series.

You said you will send a new version in responding to Fabio's comment on
patch 1/6 [1], right?

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/CAJ+vNU3E+5DWR5tQyUurLzGkinjX2fidbVNZ4T70CNmhM6eNTw@mail.gmail.com/
