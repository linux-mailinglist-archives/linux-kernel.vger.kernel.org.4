Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865CD71785E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjEaHfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjEaHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:35:34 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783ADC0;
        Wed, 31 May 2023 00:35:32 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685518530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWtlFYzuHfQ3SlMfLkKb18GwFkwsJ5XNHKhR+KU6DsM=;
        b=I7lq4Ksn1hRLvrMAyPj7jTH0rXUWpa2y8sb11pCvfqi3hVSwuYZy8VjaAQKZIs9sF77P+L
        eib0ELs21oehsVa9MWbsXnKFAn82tJcFRc4HQySI1g3tKTJ+EInI0Mka7bHs13JiFEr/+8
        1sV9wggKRt3sbgTKIye5bjqasRH7gVhhMhATppUpfCbCpZXIS7MZgLjfMIDf6ty8ewQly/
        RMoIT877U92v9B9qlPKKkEegNyjYbG2ZMP85fMmeDb9K6XIKcreB2dA+JU9kt0lnjNUUdV
        G6B+RZkEDNxjEwAQ1qNfOPP12mBbkQYgkfCdFoCeTyPMma4hwfDLA3/0X5lsMQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39439E0016;
        Wed, 31 May 2023 07:35:27 +0000 (UTC)
Date:   Wed, 31 May 2023 09:35:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, enachman@marvell.com
Subject: Re: [PATCH v7 2/4] ARM: dts: mvebu: align MTD partition nodes to
 dtschema
Message-ID: <20230531093526.1fe2acb3@xps-13>
In-Reply-To: <20230530235456.1009082-3-chris.packham@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
        <20230530235456.1009082-3-chris.packham@alliedtelesis.co.nz>
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

chris.packham@alliedtelesis.co.nz wrote on Wed, 31 May 2023 11:54:54
+1200:

> Update the node names for the SPI NOR and NAND partitions to conform to
> the partition properties in the relevant dtschema.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  arch/arm/boot/dts/armada-385-atl-x530.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dt=
s/armada-385-atl-x530.dts
> index 241f5d7c80e9..5a9ab8410b7b 100644
> --- a/arch/arm/boot/dts/armada-385-atl-x530.dts
> +++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
> @@ -179,19 +179,19 @@ partitions {
>  			compatible =3D "fixed-partitions";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> -			partition@u-boot {
> +			partition@0 {
>  				reg =3D <0x00000000 0x00100000>;
>  				label =3D "u-boot";
>  			};
> -			partition@u-boot-env {
> +			partition@100000 {
>  				reg =3D <0x00100000 0x00040000>;
>  				label =3D "u-boot-env";
>  			};
> -			partition@unused {
> +			partition@140000 {
>  				reg =3D <0x00140000 0x00e80000>;
>  				label =3D "unused";
>  			};
> -			partition@idprom {
> +			partition@fc0000 {
>  				reg =3D <0x00fc0000 0x00040000>;
>  				label =3D "idprom";
>  			};
> @@ -216,16 +216,16 @@ partitions {
>  			compatible =3D "fixed-partitions";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> -			partition@user {
> +			partition@0 {
>  				reg =3D <0x00000000 0x0f000000>;
>  				label =3D "user";
>  			};
> -			partition@errlog {
> +			partition@f000000 {
>  				/* Maximum mtdoops size is 8MB, so set to that. */
>  				reg =3D <0x0f000000 0x00800000>;
>  				label =3D "errlog";
>  			};
> -			partition@nand-bbt {
> +			partition@f800000 {
>  				reg =3D <0x0f800000 0x00800000>;
>  				label =3D "nand-bbt";
>  			};


Thanks,
Miqu=C3=A8l
