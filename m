Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179E7380EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjFULFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjFULFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6FCE41;
        Wed, 21 Jun 2023 04:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5FF161509;
        Wed, 21 Jun 2023 11:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3185AC433C9;
        Wed, 21 Jun 2023 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345510;
        bh=GHgj/yYOkuJYCVK8z0SzrAG70b1uyM3F4e+xXJRSXEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPn8zfp681El9SKEFfEnYQ0FZtwI8UfabPdCuKI5efvZ9jEMIR1BiZukoqkEHZ0uY
         YOsp3CNwoIRiCKHfaS4m1OADTfqCXLtPhh/b8Bki+qw7HSkAEzxF2zuzLsJB1DoHId
         wq6rvsegVOEJFI9b0mmKQkgK8BGv9mozTOjDe8S8Yfr2mU/dzvcLo2BWkQlQjZVZsM
         b/cYLQHnuWyYadxipwQ/+Xi+fERgSrrVfajam126UVNmC363zCpcCimlTRyfSzT57l
         dj0gallYAIeutWfqKjLoSEj/izyDk55Mgkv7Gka3hv3jMuVjZrKjLbt8gIVv6UxjBf
         zib0PEAweqEYw==
Date:   Wed, 21 Jun 2023 16:35:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/9] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Message-ID: <ZJLZYsla/ylQkVUB@matsya>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <6bb345c6a57ee27516764f36ba7d34fd1a719b87.1686126439.git.quic_varada@quicinc.com>
 <416bef68-6df3-d5c4-2aed-ef1ae7c78d7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416bef68-6df3-d5c4-2aed-ef1ae7c78d7b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-23, 13:54, Konrad Dybcio wrote:
> 
> 
> On 7.06.2023 12:56, Varadarajan Narayanan wrote:
> > Add the M31 USB2 phy driver
> > 
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-m31.c | 360 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 360 insertions(+)
> >  create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> > new file mode 100644
> > index 0000000..d29a91e
> > --- /dev/null
> > +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> > @@ -0,0 +1,360 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/usb/phy.h>
> > +#include <linux/reset.h>
> > +#include <linux/of_device.h>
> Please sort these
> 
> > +
> > +enum clk_reset_action {
> > +	CLK_RESET_DEASSERT	= 0,
> > +	CLK_RESET_ASSERT	= 1
> > +};
> > +
> > +#define USB2PHY_PORT_POWERDOWN		0xA4
> > +#define POWER_UP			BIT(0)
> > +#define POWER_DOWN			0
> > +
> > +#define USB2PHY_PORT_UTMI_CTRL1	0x40
> > +
> > +#define USB2PHY_PORT_UTMI_CTRL2	0x44
> > +#define UTMI_ULPI_SEL			BIT(7)
> > +#define UTMI_TEST_MUX_SEL		BIT(6)
> > +
> > +#define HS_PHY_CTRL_REG			0x10
> > +#define UTMI_OTG_VBUS_VALID             BIT(20)
> > +#define SW_SESSVLD_SEL                  BIT(28)
> > +
> > +#define USB_PHY_CFG0			0x94
> > +#define USB_PHY_UTMI_CTRL5		0x50
> > +#define USB_PHY_FSEL_SEL		0xB8
> > +#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
> > +#define USB_PHY_REFCLK_CTRL		0xA0
> > +#define USB_PHY_HS_PHY_CTRL2		0x64
> > +#define USB_PHY_UTMI_CTRL0		0x3c
> > +#define USB2PHY_USB_PHY_M31_XCFGI_1	0xBC
> > +#define USB2PHY_USB_PHY_M31_XCFGI_4	0xC8
> > +#define USB2PHY_USB_PHY_M31_XCFGI_5	0xCC
> > +#define USB2PHY_USB_PHY_M31_XCFGI_11	0xE4
> Could you sort them address-wise?

and lower case hex values as well please

-- 
~Vinod
