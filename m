Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE05E7E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiIWPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiIWPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:15:45 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B15282D;
        Fri, 23 Sep 2022 08:15:43 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 85B38100004;
        Fri, 23 Sep 2022 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663946141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1MLy2biFNhN4y1hvJT+YxVTZvdJ5W+EL1YAq5Upuf8=;
        b=PCkWkpfy5DuDQbTHSosAcLn/Kaijc0XM6bknacy7YXCMaAezv2es9CPbc55CP/KrAKbn4N
        2CLl5tgM0bsE52rLwvVXkwym+8PFVKMk7JUYkZkL18CcCP5rOSrAZp3kM8Gs0vP1Y4xJcd
        wVX16yRGeFTiq/qg2CR9VSzaqat4O4OBCHrrnWdr0+xItLAeiXBA4usA/lU66OtXIQRuTR
        7FCQnmf8HMrgyQQmMcp4k1nCxgO0CI+2a+C7XbnN2ZpnbzyhOHtpMba9ciqsUuuMbUX/ap
        o5I2oG6iebkRrlULGrCy+I+fm5bQJgN2WxfgvjMoC2U2qcBCJ6ptN1/mG8zZtA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add label for wan port
In-Reply-To: <20220921115037.30246-1-pali@kernel.org>
References: <20220921115037.30246-1-pali@kernel.org>
Date:   Fri, 23 Sep 2022 16:15:38 +0100
Message-ID: <87k05uxgth.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Device tree label property should contain label from the box/stick.
> Labels for other ports are already specified in DT but wan is missing.
> So add missing label for wan port.
>
> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boo=
t/dts/armada-385-turris-omnia.dts
> index 8215ffb6a795..c4bf3ca0784b 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -166,6 +166,7 @@
>  	buffer-manager =3D <&bm>;
>  	bm,pool-long =3D <2>;
>  	bm,pool-short =3D <3>;
> +	label =3D "wan";
>  };
>=20=20
>  &i2c0 {
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
