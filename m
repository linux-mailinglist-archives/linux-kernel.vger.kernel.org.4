Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D95F4A89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJDU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:57:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC632B267;
        Tue,  4 Oct 2022 13:57:49 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A791A6602293;
        Tue,  4 Oct 2022 21:57:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664917067;
        bh=rOIF7LaAC+WUVJaWsdB3dj8dPLLF/TT6iHAASQJV/bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyD0WRDRXBhLgr1sTa2WExTxq0q+VMMHRlGKhs96nczEb0fEuSC+ICo11R4PYpvSU
         nlf4ITYzDetrChG53AipERX73WynNauggGFWlIyVZw7VEORqZSchn6q2vw2S7qYV9I
         d95KgrlPRESBHfgg0EKEHMHAwuqj65bYmrtHAV/78ETAjIISLObB3opn01Y/IdyXh+
         CeNc/OmUyc74UbxCMepkIuUR4FkoLFfbK2K6wY5ikd/lAJAI0YpDRj5lZIWo7rXfQP
         9Kg9uQtoosj7YD7UE9TB2fFPJylUhWkVWq8Aqc2l1ESI33RhBCBFCwjBflYaXADWI8
         cXLEvjEednbbg==
Received: by mercury (Postfix, from userid 1000)
        id B95411063330; Tue,  4 Oct 2022 22:57:44 +0200 (CEST)
Date:   Tue, 4 Oct 2022 22:57:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Message-ID: <20221004205744.q5eybgbx6syszsqq@mercury.elektranox.org>
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-2-linux@fw-web.de>
 <20221004150929.GA1506199-robh@kernel.org>
 <EC42D2C8-ACA5-4B6A-BC95-534CBDFC36C8@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="esf23iwxvt2hw4gh"
Content-Disposition: inline
In-Reply-To: <EC42D2C8-ACA5-4B6A-BC95-534CBDFC36C8@fw-web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esf23iwxvt2hw4gh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 04, 2022 at 05:19:11PM +0200, Frank Wunderlich wrote:
> Am 4. Oktober 2022 17:09:29 MESZ schrieb Rob Herring <robh@kernel.org>:
> >On Thu, Aug 25, 2022 at 09:38:32PM +0200, Frank Wunderlich wrote:
> >> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - rockchip,rk3568-pcie3-phy
> >
> >The driver also has 'rockchip,rk3588-pcie3-phy'. Please send a fix=20
> >adding it here or removing from the driver. Are they not compatible with=
=20
> >each other?
>=20
> Right, original driver has rk3588 support,but we can't test it.
> Initialization and lane-mapping (bifurcation) was bit different.
> So we wanted to upstream rk3568 first (but have not removed this
> part from driver).
>=20
> I see that someone added rk3588 basic support and if he can test
> rk3588 i can send compatible for it.

Basic rk3588 support is still WIP. At the moment patches for the CRU
are still pending as well as base DT. I hope to land them for v6.2
(so next merge window). At the same time I don't think PCIe support
is realistic before v6.3.

-- Sebastian

--esf23iwxvt2hw4gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM8nkEACgkQ2O7X88g7
+ppF5A//aMVPpjLHGUEf9ZvplEMOuOtVijERKVd+RRgN0E+HWDjY9kTSdKo0zfcU
G3FTTyYJhZXSjZ6wAluSupAr2dnO8Ob8EnXdSUZtTKPrAZs6QkZETJpLkD25nf8i
vOzeJcNy+8SvpO6WGhF4alc3E+T/lqVH19Cft9ZWCQM6cWy66IKpUdaWirPRmcIR
qz8WQBUjtZ6z66itUppsc5ysDVRz0YXtNTekcfUHF3qxW4AVq07RdNCzOdPOv0Rh
mXAMpCzm2MCAmYl3+WvtxIfHbS97ksKZ+M54UmlS+nAoaNJ/lM3FyjaYs9he8ApT
JjDnyY2SbGhAiBXJ3WN0Ry/gxoEhm2Wjj30llsUE7ncc7UV0ADAB7zx3++V4ekLq
MD21LyMoLY1G5mROtW8KN3SOAUrlD5f6/uWu/JbUOEXiMuJ5rgeVlwpcuqeRcLYc
ZdTuJB/mijzlEAVr2p79gvNTrbStb6OU3o1YBJXi1lUlRk4eIgxL2ZgU/zaB2zmR
5UVY0eNam56p2+8Y5NRsMTy2LXDWJLnagSoPuz25O0x8I4Kb0+pQ861Md6rNrj4C
Gx4uieKw+KOnlZ8tdJ8mPflqVn7yvnT2WWhhCBi37idzZbm0CFPTKGZLCsjJPA++
mSg0DQJtYs8tjIS3bTkNg1h0OMO4XIvfygU7pp5SsBb5hxehagA=
=+xoE
-----END PGP SIGNATURE-----

--esf23iwxvt2hw4gh--
