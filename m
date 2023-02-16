Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354C698916
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:07:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A935247;
        Wed, 15 Feb 2023 16:07:02 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6EE7660206C;
        Thu, 16 Feb 2023 00:07:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676506020;
        bh=zj/VGR6ZN2C2BqNQmI75um4oc0yzLvQN9PNdoVme50M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmMWPQijm9Chur5POuKyLwvgWtFDaIa86Oo2tkPrhdmICLLVS98HgIEn4jkjyUYOX
         6/Qsx9ax9DIs77oj0ELeaHX/T9BGcaXXoxJ3OOhATLFq83/BS7sORH3g3nS+/zi5lG
         Iz2IyD1vJo1bSJvaEjrrBxDux8HUjMnRblE7l1Z/WWhr8ElR5J/A+T/raZzHZV667K
         Cz07SedGXDtOsRqlnqvKGf3EsnVTiz5Ea0nfEjn76IPBQ3DnkVbfDJPiwkopiZ8wdl
         X63CFJSCmqPdgk4W0R1SFWmzZ4spW3x6a2j3bIjonku5wsy3mtZiHA+vxiBmBEkjey
         vojEcMoc+xjKg==
Received: by mercury (Postfix, from userid 1000)
        id 8F1FB10603FE; Thu, 16 Feb 2023 01:06:58 +0100 (CET)
Date:   Thu, 16 Feb 2023 01:06:58 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: power: supply: pm8941-coincell:
 Don't require charging properties
Message-ID: <20230216000658.f5rqso65zocwz2ns@mercury.elektranox.org>
References: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
 <20230214090849.2186370-2-konrad.dybcio@linaro.org>
 <27866ba4-ea82-68b9-fa10-5c7687bcaf17@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q5pkc2stfdd7kbum"
Content-Disposition: inline
In-Reply-To: <27866ba4-ea82-68b9-fa10-5c7687bcaf17@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q5pkc2stfdd7kbum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 15, 2023 at 08:04:00PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2023 10:08, Konrad Dybcio wrote:
> > It's fine for these properties to be absent, as the driver doesn't fail
> > without them and functions with settings inherited from the reset/previ=
ous
> > stage bootloader state.
> >=20
> > Fixes: 6c463222a21d ("dt-bindings: power: supply: pm8941-coincell: Conv=
ert to DT schema format")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>=20
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks, queued.

-- Sebastian

--q5pkc2stfdd7kbum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPtc6IACgkQ2O7X88g7
+poDaQ//Z7PxP8kwr+kgfnl0p7PMiYJPvLy8oRwxDCYGut3RBMnYMk9jXsZErM80
Sh3SYbCbVKqCU5UKkiAze9GV8I7aNcro33yA9EGgQr5bCxWVoWt1ihYjqHS+ZuY2
mQGIhNu7NJA3ADQOmVjFxxOePNZrqz8/5G6MkC5D75IXJ6BOKUuCSUxMNyK0ttHq
Ad0E3cKcq5v270djrzecpI9pY5J1z5ESKkbuCpBZypAF+ANGE02u6NtqNQ1rlySH
IHcSiTFu/HMF29FiOezjBmp4/r6gSEaLIfhoXCcn+WikB/Wc6KWCT+zRIN3HDa/1
VfcDf5l2Bid1FnuDRuGzj9nS338p6sn+mFVHmcR312gLazCvM4n3a1O7Mga7h3iP
gouIznbqJb+/5y6I3KGsgkIwO6ywptIoPoRmsEBKg1PLTNUzViFck6EfoCH+/yEE
GRlGKtvp/DxPaM1oF1yHbWoeeH4WJPZmEBXeMZsu9zIfLlOy/ERDiY/yoTkMhu2W
obuBC3Dmpen0ZEegnWX01a6liPpQw2qXxSsQvdyihff7gsBIZkXKotXK07QLFbbB
8oyFj2CbsABsuh5HtglLdoC6N050NFdQfsJj9896VE3Ejnoufh0gRoHZg/uJzyXg
U6xu7z+gn/ZMmaz0JTpGsizB92O5KFOfVLbPTrgLc/N/ClLXiIM=
=TEzR
-----END PGP SIGNATURE-----

--q5pkc2stfdd7kbum--
