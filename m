Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02437639E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK0X51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0X5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:57:25 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E94BC93
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 15:57:24 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BD916240004;
        Sun, 27 Nov 2022 23:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669593443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l37uiqnZyo16oWSX5uCWvxnVzS1dNzc8ScxGMBi1+/0=;
        b=B3/AbFM16eHclLkaiGbLAh1RP5qx+OOjZa1llo3o+ElviDZJ6mUaUKatJByQR7iGhKZLNq
        KW/fByZUyi0Pq+pKYeRZahKwSUatCbb3V45yQ2pAKXtTlumiau0ypVaj3+4sAypTqr5G1d
        P0UahJn4kNOUWyQ5k6K2eg9+LuNWMZrBrNL8lNc4ZBU8NS9gpShMO2xn8p1Fjn3qRIyaBK
        9AYQrzxqAEfzVhJtNaEeH00vy1rFutZiTI+6P/XHC/FZ0qbuA2ur2kHqsbyt9wI3GUHPDA
        mrQFDUhPs8nt5SRONtT64aWYaX76U2HxXGfAp8HaBKOIE8VttWY0SnSVeYbqOw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add ethernet aliases
In-Reply-To: <20220727130926.1874-1-pali@kernel.org>
References: <20220727130926.1874-1-pali@kernel.org>
Date:   Mon, 28 Nov 2022 00:57:22 +0100
Message-ID: <875yf09cil.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> This allows bootloader to correctly pass MAC addresses used by bootloader
> to individual interfaces into kernel device tree.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boo=
t/dts/armada-385-turris-omnia.dts
> index f4eb6898aa6b..d2afa466e29a 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -23,6 +23,12 @@
>  		stdout-path =3D &uart0;
>  	};
>=20=20
> +	aliases {
> +		ethernet0 =3D &eth0;
> +		ethernet1 =3D &eth1;
> +		ethernet2 =3D &eth2;
> +	};
> +
>  	memory {
>  		device_type =3D "memory";
>  		reg =3D <0x00000000 0x40000000>; /* 1024 MB */
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
