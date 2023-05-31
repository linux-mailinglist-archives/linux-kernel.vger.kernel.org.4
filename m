Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7CE71785C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjEaHfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjEaHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:35:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669BFC0;
        Wed, 31 May 2023 00:35:16 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685518515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUnorI/qOvsXjlT7WXm+LLn3umXwCSS1TTFJLqxcPFg=;
        b=X9/l352R3GaXjSe+wkke6JFZycBsByaaGdfLySy2l/cF/hTtqqOdyjunOS3rAeeP+Ht4ab
        ASY0JZOBwVglAh3yjyDLS/ls7ZhKsNoBTl2t6e7gTqk0hfZyJHtj2gt45J6kM4U/T3xwpd
        P6aWeeSUpQj1/ricomG21DcNbZyLM7CYx/WYRSwBlqddyQz7bU30a8BJcPbBKTX5oQCZ66
        NwWWZLC/3pziD9agG6MLQbpLs4bcg8RjopjMdac3dDZVku8ympDUBZE9gJEHyLltpg0/5G
        wlbNU3jZpHz/JvRHc0IPNeinbEsGHyXg45sbCLCIfhqL8snRpD62dp23axMQ0w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AE65FF80C;
        Wed, 31 May 2023 07:35:12 +0000 (UTC)
Date:   Wed, 31 May 2023 09:35:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, enachman@marvell.com,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v7 1/4] arm64: dts: marvell: cp11x: Fix nand_controller
 node name according to YAML
Message-ID: <20230531093512.0f7e12e4@xps-13>
In-Reply-To: <20230530235456.1009082-2-chris.packham@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
        <20230530235456.1009082-2-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

chris.packham@alliedtelesis.co.nz wrote on Wed, 31 May 2023 11:54:53
+1200:

> From: Vadym Kochan <vadym.kochan@plvision.eu>
>=20
> Marvell NAND controller has now YAML to validate it's DT bindings, so
> change the node name of cp11x DTSI as it is required by nand-controller.y=
aml
>=20
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-cp11x.dtsi
> index 0cc9ee9871e7..4ec1aae0a3a9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -468,7 +468,7 @@ CP11X_LABEL(uart3): serial@702300 {
>  			status =3D "disabled";
>  		};
> =20
> -		CP11X_LABEL(nand_controller): nand@720000 {
> +		CP11X_LABEL(nand_controller): nand-controller@720000 {
>  			/*
>  			 * Due to the limitation of the pins available
>  			 * this controller is only usable on the CPM


Thanks,
Miqu=C3=A8l
