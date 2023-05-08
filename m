Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B853A6FB53E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjEHQhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjEHQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3F6E96;
        Mon,  8 May 2023 09:37:32 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 358016602216;
        Mon,  8 May 2023 17:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563850;
        bh=OVnU4RGXd9knyLIxgJfq9vW/dYCOMkfNwHLTLBsjP4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNj089CzYsmxkxvkweUxqmPLc5zDYy+tdaJPUvGdpUvejup3sWCH/paCb5Eba+Sar
         MgscPPivkUgZDR+CC/HwAMSafY+yZ6cPuqK4ADXwDHU9bvMPD4wUzv/r2anlWOyVg/
         Tf9RFFvbiF05lhz17Q7odoX6wJrMhCNDXvrbF3MvfM8K+wnQZKZ0pjWN6jQtp/i1OZ
         qXvpe3B+oNYne2i15ein1LqS+L5apjjv9fcRRoNqYIh7K+uPuVRSM++pBedpSKOd9z
         sGGccQcZx5s4ml0eKlh0Q3drxFBfWgQ0xwa/4ZSMZj1BECSE2Vs1wKc/ilBw+akt8k
         EZoxD0yMjPQzQ==
Received: by mercury (Postfix, from userid 1000)
        id 08DD61066FB7; Mon,  8 May 2023 14:29:06 +0200 (CEST)
Date:   Mon, 8 May 2023 14:29:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        David Collins <quic_collinsd@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom-pon: Only allow
 reboot-mode pre-pmk8350
Message-ID: <20230508122906.qlb4z46s7ygnaggb@mercury.elektranox.org>
References: <20230419-topic-pmic_pon_bindings-v1-1-ea233dae0117@linaro.org>
 <168210403110.1629611.9828460888076350953.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jdoyh5mkhiee46ot"
Content-Disposition: inline
In-Reply-To: <168210403110.1629611.9828460888076350953.robh@kernel.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jdoyh5mkhiee46ot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 21, 2023 at 02:07:11PM -0500, Rob Herring wrote:
> On Wed, 19 Apr 2023 12:41:06 +0200, Konrad Dybcio wrote:
> > As pointed out by Shazad [1], PMICs using a separate HLOS+PBS scheme
> > (so PMK8350 and newer) are expected to pass reboot mode data through SD=
AM,
> > as the reboot mode registers are absent in the HLOS reg space.
> >=20
> > Limit the reboot-mode.yaml inclusion to PMICs without a separate PBS
> > region.
> >=20
> > [1] https://lore.kernel.org/linux-arm-msm/12f13183-c381-25f7-459e-62e0c=
2b19498@quicinc.com/
> >=20
> > Fixes: 03fccdc76dce ("dt-bindings: power: reset: qcom-pon: Add new comp=
atible "qcom,pmk8350-pon"")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--jdoyh5mkhiee46ot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY6xEACgkQ2O7X88g7
+pqUtA/9G4KFD90qBL3rgN6ZUxtZyVrZTHx2LCk6SFAkQyprCC34z+H1uxcPrRZl
Vg2vOzAgEhy3zgHY+ECwmHBIReeXaNsrbLV79T9vmzs3N2NhFOFfzRKgokg8q4zO
T+1/opSoidLm4q5jDb/569wyhTsCOgZ+ARO1PgaxMxHl3P6R5iNqQvPbB8JsmB+x
5hl70rxFG2Mgi1HFlKI2lgXRkWGLiPZTTl5G1W22ySNE9yftaN7PkAKS2r+e0CTG
e7xDAbILvhZGa0v0iaM3aYr9LWaqf9navf6Fh1BD3IdSDt9NBiy+z7/5yynqT4Uj
mWxlF2Okz5PBd9DrF1NcOfs80w2RxRg83gHeaZP6VT6ooPvJrQj7bbq6G04W+bs/
g4AR8vJItjVnQAHVaXNdoB+8FXRlSug61DKjgZCLm9bGt8MlzbI9mkt+KGIwNf+Y
Rhvw+UIK1xl4cXIeW/cD+tX3UviPoOK3ucc4DMcL17PZ1CKsX34dOSlYzbwEDvO7
TV68ZYo5ZXAuszEefeJ3BwC1bGKju00U/7QVOTqpxvsWPkogFC0i2SKj+NR0j/Cl
JzghP7ApsD9LVcxY1Q8geTx+Jqti8bpHHSeDd9hRauwj3qyZDJYyJH1iyUANrZPO
ZQErG9joCB4xxC/PLYPa7KVJtqCJLV8bgqS9VR+qVVYPfVBp5Ws=
=Mwn+
-----END PGP SIGNATURE-----

--jdoyh5mkhiee46ot--
