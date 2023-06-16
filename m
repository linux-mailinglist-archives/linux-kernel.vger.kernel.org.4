Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F637330BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbjFPMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbjFPMF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:05:56 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A212D69;
        Fri, 16 Jun 2023 05:05:55 -0700 (PDT)
X-GND-Sasl: gregory.clement@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686917154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCjRRq5jWpMtrjACm4L6UNEQn8FssryrXj0q7mB1XHI=;
        b=m8Q28aJqjRaLSo6u11SgoYEwu5ED4c9MCYZx9CHPNfVG1aIsNB99F+BBVfJI9YyHPrxgMe
        ooUbWLXLMBHg+ECHSAPkkipZFNlmMKdmw37vTWL1Is9oapxjEFBunMJYPa2+TI1jY6ynI0
        GYCaQg7HFSz/dy3lZ4BITLgGxzcUOg1t2NrzudDdvp/DtJsxVt/frlKBBI96Zj0DaPr4sI
        XDNGugZL1izeQ5LgIJ7HkjyxtBtsUNw9+3NMQZ59x7kR9KmBfFbXxqvNtHdDpNUwtusOwM
        rmy15kIVPOiGLpnG3wMPW18UodKe7IpgzQADBraP9NKOs7/0dQXp9p6d1orW3w==
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 757E660002;
        Fri, 16 Jun 2023 12:05:53 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ben Schneider <bschnei@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ben Schneider <ben@bens.haus>
Subject: Re: [PATCH] arm64: dts: marvell: Fix espressobin-ultra boot failure
 and wifi
In-Reply-To: <20230603052356.3530-1-ben@bens.haus>
References: <87o7lys5x7.fsf@BL-laptop> <20230603052356.3530-1-ben@bens.haus>
Date:   Fri, 16 Jun 2023 14:05:53 +0200
Message-ID: <87cz1vhase.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Schneider <bschnei@gmail.com> writes:

> Boot hangs on EspressoBIN Ultra (Armada 3720) after a message that device
> vcc_sd1 had been disabled. The device manufacturer patched this issue in
> their kernel fork noting that vcc_sd1 is used by the EspressoBIN model
> but not the EspressoBIN Ultra. Removing the device from the tree fixes
> the boot hang and wifi.
>
> Signed-off-by: Ben Schneider <ben@bens.haus>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index d29d2da95..f9abef8dc 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -24,6 +24,8 @@
>  		ethernet5 = &switch0port4;
>  	};
>  
> +	/delete-node/ regulator;
> +
>  	reg_usb3_vbus: usb3-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "usb3-vbus";
> @@ -66,6 +68,7 @@
>  };
>  
>  &sdhci1 {
> +	/delete-property/ vqmmc-supply;
>  	status = "disabled";
>  };
>  
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
