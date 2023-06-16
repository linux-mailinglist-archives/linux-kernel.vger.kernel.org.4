Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8D733085
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344936AbjFPL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344943AbjFPL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:56:11 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000E2D67;
        Fri, 16 Jun 2023 04:56:10 -0700 (PDT)
X-GND-Sasl: gregory.clement@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686916568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QaZnoro0oU0BUT67Qd+xO/fbwDMI8KTckqLRYFBC1A=;
        b=F4yISwuao80Yq+BfiQHCmYOpMnGAeJxFSVfrWuqpY/P6HLjFFCoFhz0lo96y1NyGig0eWj
        sDErek1g/skSmiysKMh7RQDKWRKllmMsl0byx0C4xXIa1v5Tby/m81i9EzeHKKo1KAI2Xh
        jZ5tKuFuRxaWWQG453O6K/oKdgppll19PVojTDpxeFWSMErJZtnmraOglde5qpBlcMGWft
        DNlCpRYwy6ADtML0ewRZrsx0fbSSdbXFbmPowV63AFelyzYBmgbci1OvpG92FVKlrxx6pC
        6nEgNgBeuOGKW4E/ssMzNDlRlcW2bccMh4vCSvY54g+o1EJV9RgOFnY59bE7Ow==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 398F92000C;
        Fri, 16 Jun 2023 11:56:08 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v9 2/3] ARM: dts: mvebu: align MTD partition nodes to
 dtschema
In-Reply-To: <20230615040447.3484564-3-chris.packham@alliedtelesis.co.nz>
References: <20230615040447.3484564-1-chris.packham@alliedtelesis.co.nz>
 <20230615040447.3484564-3-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 16 Jun 2023 13:56:07 +0200
Message-ID: <87legjhb8o.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> Update the node names for the SPI NOR and NAND partitions to conform to
> the partition properties in the relevant dtschema.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on mvebu/dt

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
>  arch/arm/boot/dts/armada-385-atl-x530.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dts/armada-385-atl-x530.dts
> index 241f5d7c80e9..5a9ab8410b7b 100644
> --- a/arch/arm/boot/dts/armada-385-atl-x530.dts
> +++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
> @@ -179,19 +179,19 @@ partitions {
>  			compatible = "fixed-partitions";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			partition@u-boot {
> +			partition@0 {
>  				reg = <0x00000000 0x00100000>;
>  				label = "u-boot";
>  			};
> -			partition@u-boot-env {
> +			partition@100000 {
>  				reg = <0x00100000 0x00040000>;
>  				label = "u-boot-env";
>  			};
> -			partition@unused {
> +			partition@140000 {
>  				reg = <0x00140000 0x00e80000>;
>  				label = "unused";
>  			};
> -			partition@idprom {
> +			partition@fc0000 {
>  				reg = <0x00fc0000 0x00040000>;
>  				label = "idprom";
>  			};
> @@ -216,16 +216,16 @@ partitions {
>  			compatible = "fixed-partitions";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			partition@user {
> +			partition@0 {
>  				reg = <0x00000000 0x0f000000>;
>  				label = "user";
>  			};
> -			partition@errlog {
> +			partition@f000000 {
>  				/* Maximum mtdoops size is 8MB, so set to that. */
>  				reg = <0x0f000000 0x00800000>;
>  				label = "errlog";
>  			};
> -			partition@nand-bbt {
> +			partition@f800000 {
>  				reg = <0x0f800000 0x00800000>;
>  				label = "nand-bbt";
>  			};
> -- 
> 2.40.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
