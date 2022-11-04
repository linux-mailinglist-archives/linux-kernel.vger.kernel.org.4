Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41961953D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKDLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiKDLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:15:07 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F67F70
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=kb2kbisxuNx/5Qhb1xm5Fa2x3BDC
        yhrGdVOj3vwkUcU=; b=hXE3+bIScF4Srsx9K/QrAktRMC5u1zRkQ1l3I5o/jWME
        wva+U2DK9p7ZesbZjp5tTEA7GrmUI9+D8xxMVUpl6zOb4mZLm0cK7r5iwvBn64eE
        64C/jKqA2OLjL4/aZFQGhg0007f4IpI6DWArrVFlJ+lTF4MMFPGqXroSXA0mhWQ=
Received: (qmail 3058062 invoked from network); 4 Nov 2022 12:15:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2022 12:15:01 +0100
X-UD-Smtp-Session: l3s3148p1@NQ4WL6PsPZUucrX5
Date:   Fri, 4 Nov 2022 12:14:57 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: renesas: white-hawk-cpu: sort RWDT entry
 correctly
Message-ID: <Y2T0MT2mZ5kghUQ1@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
 <20221103205546.24836-4-wsa+renesas@sang-engineering.com>
 <7cfe285d-eb82-1840-0149-b5b77f2beaae@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WmaBimbi6vKaUGvX"
Content-Disposition: inline
In-Reply-To: <7cfe285d-eb82-1840-0149-b5b77f2beaae@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WmaBimbi6vKaUGvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But I doubt that there is a bug here. Style (like order of things) is
> not a bug.

Okay, I'll be more strict next time. Geert, could you kindly drop the
Fixes tag or shall I resend?


--WmaBimbi6vKaUGvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNk9C0ACgkQFA3kzBSg
KbaXpA//aKHJpB+WdjFMjJSHKTjyd54QODpeCDNiUiKAf7AqUDfijp/Mbn/CfakX
IsDn0iKCFjtBOFKuIxA57jqPMnEPWvl3Xwm4Lz5aYWACc1L0tDl3u2Ws2KyF7FL2
ED+vUqdMGmjLgzzd89Y0C48xe6BWqmNrqqMKFWfh8bXpTA6rcZ3p+1ngHRNO6auf
hWZG5t8vK0oluvURfv8G4M98SFi6CLkEk7CA+NlZVdzWOfrQWW88yR228DmFFVhx
mSfCgsvqsChq2gcCBxvCTnPF2/g84rs7BimFQFK7SjLnLjckmLTrPHdWRAVhvQbm
eCy+b4p++OYENJ+aUwAdZZup3HsJlp8nkzxEuSIyMIptLlOS7XJ/l3eO7fDarhLO
gO/sr3joDMTHwaap4xc+Qg5t3SCdkiVSZGPSURHbE/bELoDcoWvrGv6Vlx4bGKsV
gOzbAFUnmhFSXF8CFDE4wYeJovStXURLhdvmh8I5pDhdwYC1eJ8HrJPl+efB/g+Y
/dQ7GUON4GZ2nfl6rcgANftIBd6eQBkfE46GMCR7qwEb3QDEXegRUdhfVMrvb9hY
Ngpgc8QfM54BuMDRsV4SLfixl04REUvnI5BGUWPwl7DpLSwvL67K7NjFcNVR7COm
oF19eNBhlsP3XE/Lq0+pTfPeubudh5ZM1T3uvOJ4d8/mbkxh4gU=
=VghL
-----END PGP SIGNATURE-----

--WmaBimbi6vKaUGvX--
