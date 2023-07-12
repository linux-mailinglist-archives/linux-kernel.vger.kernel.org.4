Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016E775018A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjGLIbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGLIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:30:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB111BD7;
        Wed, 12 Jul 2023 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689150333; x=1720686333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyIWm5FV5uRNjw92jUC5ce28JX8oOFOKKacHgKLY0MY=;
  b=FJ9aXpMwT3ABNuc0mJW/EczqfXXPb48BPeyTCixHGA3K44z8ZeEDlCQ0
   P7SRsXDkhKiKi/TDI6whq1NxowTUWubgSNziSEMf7xf0tkXZiz5dVaHM3
   wWviVM4Hoz4jh5TP6OZrL/U7pATnirQKAkipUuQBQUFQQhbBU7JRs8blZ
   bvWUNK2D46Q1241eCuihcui3T7+u/wseVH0nZDXgbqw/MQwImkiUfUk6J
   UxH9DMY6g4f9noJARyD5EoG233INY2LVSrtPkf1MzeGdTPAD2WIeJw5D4
   3I63JrNQpFnh5D2V6gXDx5QcrcBauxRzlwDKPMGYdMGZMVVHBGct/wgAm
   g==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="219973705"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 01:25:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 01:25:32 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 01:25:30 -0700
Date:   Wed, 12 Jul 2023 09:24:58 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ad74115: remove ref from -nanoamp
Message-ID: <20230712-pound-frail-572a5362ba41@wendy>
References: <20230712080512.94964-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7VYnBipMzYAZfg7z"
Content-Disposition: inline
In-Reply-To: <20230712080512.94964-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7VYnBipMzYAZfg7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 10:05:12AM +0200, Krzysztof Kozlowski wrote:
> dtschema v2023.06 comes with support for properties with -nanoamp
> suffix, thus bindings should not have a ref for it:
>=20
>   adi,ad74115.yaml: properties:adi,ext1-burnout-current-nanoamp: '$ref' s=
hould not be valid under {'const': '$ref'}
>=20
> Cc: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Heh, was just about to go and do this myself - good thing I checked first.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--7VYnBipMzYAZfg7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK5jWgAKCRB4tDGHoIJi
0mXcAPsHTRpr3H6jsOo7jbTH9rgP3UZCpEo9wClxybWVe5ZmCwEAvhX4m5CFF5da
kFeiG4mEv3v+Kq7ERy6tNWbJGLrWXgI=
=XyXI
-----END PGP SIGNATURE-----

--7VYnBipMzYAZfg7z--
