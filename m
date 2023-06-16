Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FA733082
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjFPL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbjFPLz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:55:56 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FC2944;
        Fri, 16 Jun 2023 04:55:55 -0700 (PDT)
X-GND-Sasl: gregory.clement@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686916554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3VbCZZPj2MH0B0+AxaXEpesaRl2NPyrEf1VpNxwlIQ=;
        b=j6qpC/T8VW1/ouaPpAkjq2VsAZfIQtkXFSdnWjuzAQS4RsC4Kw+gi590pUuYPb976fLsH1
        3Q/+4HPwTOEjzQ1LXKm1DUDzc1JX6zs19JNVW1zg8wkXQZ1BTszQVJseVTdDvqQWuSKY+w
        g7nO7Uw6b0YUF03aP6e3xYlUkkI46SZ52VVrfxDpqe27j7EPmfbJV6nS70ch8WCp5OOrwr
        vg8dv3qpXhaakMbyfLaCvIdVfd5kapMes7HV7Ne3xneNVBXa8ie/FHATVuFKglJ6ZScQS0
        /RqCVTJWZmi0U4x2FmA3w0E0YSqkIVqk5Rv6YvMkhfIN8xrhPf2rVGiLmy28cg==
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
X-GND-Sasl: gregory.clement@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BFC12000B;
        Fri, 16 Jun 2023 11:55:52 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v9 1/3] arm64: dts: marvell: cp11x: Fix nand_controller
 node name according to YAML
In-Reply-To: <20230615040447.3484564-2-chris.packham@alliedtelesis.co.nz>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
 <20230615040447.3484564-2-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 16 Jun 2023 13:55:52 +0200
Message-ID: <87o7lfhb93.fsf@BL-laptop>
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

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> From: Vadym Kochan <vadym.kochan@plvision.eu>
>
> Marvell NAND controller has now YAML to validate it's DT bindings, so
> change the node name of cp11x DTSI as it is required by nand-controller.yaml
>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory


> ---
>
> Notes:
>     Changes in v9:
>     - None
>     Changes in v8:
>     - Add r-by from Miquel
>
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 7d0043824f2a..982b180b33e6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -468,7 +468,7 @@ CP11X_LABEL(uart3): serial@702300 {
>  			status = "disabled";
>  		};
>  
> -		CP11X_LABEL(nand_controller): nand@720000 {
> +		CP11X_LABEL(nand_controller): nand-controller@720000 {
>  			/*
>  			 * Due to the limitation of the pins available
>  			 * this controller is only usable on the CPM
> -- 
> 2.40.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
