Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0C639E53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiK0X7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiK0X7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:59:20 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0D6DE98;
        Sun, 27 Nov 2022 15:59:17 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A47041C0004;
        Sun, 27 Nov 2022 23:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669593555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1XVyxBYbqQW9yuwEahExkzgapSoIv+77SK/yCgu5k0=;
        b=d1EMpPaYZK7JkHPzNe8eKLmFQvlMJmCBT1X08y9k++46TmErLAfUSQjA9Qp1AMUYZhwEwU
        x0u1mNXRM6fLTC5l5tnNYyAhsfsdqBhjNGTK+OeLxAAdxccGyicDP+0naAWuLBNbB0WiNZ
        nhVdVfRV9JbYUNpy5e1+k8Bw2Gy0t3M68GCYmrRZajQBLBciZ25xUmOfUKQacVjzwWryCl
        CZLnrJj8FvEHxodnHRBFU4VtfWKiyR95LDMe5X9gtWjWeJ8heHrI6XV2aQ5gjlasN+8ZXi
        WGJ1nXKSsrScxMu4SWsizVjamiNSWeFcHhRy/Hc0OJLUKa+nUP/F/9jORCnMmA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-turris-mox: Add missing
 interrupt for RTC
In-Reply-To: <20220924115826.7891-1-pali@kernel.org>
References: <20220924115826.7891-1-pali@kernel.org>
Date:   Mon, 28 Nov 2022 00:59:14 +0100
Message-ID: <8735a49cfh.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> MCP7940MT-I/MNY RTC has connected interrupt line to GPIO2_5.
>
> Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 5840ed129309..802862fe2060 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -125,9 +125,12 @@
>  	/delete-property/ mrvl,i2c-fast-mode;
>  	status =3D "okay";
>=20=20
> +	/* MCP7940MT-I/MNY RTC */
>  	rtc@6f {
>  		compatible =3D "microchip,mcp7940x";
>  		reg =3D <0x6f>;
> +		interrupt-parent =3D <&gpiosb>;
> +		interrupts =3D <5 0>; /* GPIO2_5 */
>  	};
>  };
>=20=20
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
