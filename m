Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF745648FFB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLJRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 12:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLJRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:16:29 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F81FB;
        Sat, 10 Dec 2022 09:16:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 399DF1C09F6; Sat, 10 Dec 2022 18:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1670692587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdQHQ5s+tXy+ERTEJcEFuFB1iLfks/vH0fSWLk/R1XU=;
        b=dWRl/z/DQFNmcGUBaWofIwuApXxBt7IaiY7S944ChkKAygdKedlqeVYseF8xjEqlWokFQJ
        xGboTiYgmijEegmXoNXTRBOmyxNym2ra2+/eAwFUINi7AvnUqzvsNBEZJSeyi/yvMf/aCN
        aaeiYcOZztfN/YsfKftqmtFX/056z7k=
Date:   Sat, 10 Dec 2022 18:16:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: configure
 flash LED
Message-ID: <Y5S+6j1yJ62RJU/v@duo.ucw.cz>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-3-531521eb2a72@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HG3oTbixxIVumDLy"
Content-Disposition: inline
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-3-531521eb2a72@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HG3oTbixxIVumDLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Configure the pm6150l flash node for the dual flash LEDs found on FP4.

> +&pm6150l_flash {
> +	status =3D "okay";
> +
> +	led-0 {
> +		function =3D LED_FUNCTION_FLASH;
> +		color =3D <LED_COLOR_ID_YELLOW>;
> +		led-sources =3D <1>;
> +		led-max-microamp =3D <180000>;
> +		flash-max-microamp =3D <1000000>;
> +		flash-max-timeout-us =3D <1280000>;
> +	};

I'm pretty sure the flash is not yellow.

Plus, how is the node in /sys/class/leds called? Can you make an entry
in Documentation/leds/well-known-leds.txt and ensure the name stays
consistent across devices?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--HG3oTbixxIVumDLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5S+6gAKCRAw5/Bqldv6
8mv/AJ0bt0t8Kg/jefzjZ1+T0YiFck3AwQCgm0aNvzYQBqjPy6v98GKiO6emCiw=
=zhQd
-----END PGP SIGNATURE-----

--HG3oTbixxIVumDLy--
