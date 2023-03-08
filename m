Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1806B06BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCHMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCHMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:17:06 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2279BAD0A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=wZJRM2rHzGf84CtmVYJT/6El2+DB
        2f0LTb8sWk3XR8g=; b=T9d7vaeMwyVgnnf4joeAwYgPH+ENqHsI634ZxeS59u5+
        UGlk1uSRipbxytFq4slwXYcrMFPdWVIdvscYcQ8BSKdc4tBYOx7PrnwEjG/VJpD3
        McBG2Qj0RyqAiBhf4GXISjgzzs1qryBv/Rf3HijxqfAz9Ty9UmTJtADvjih5XZM=
Received: (qmail 1073161 invoked from network); 8 Mar 2023 13:16:52 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Mar 2023 13:16:52 +0100
X-UD-Smtp-Session: l3s3148p1@s4zQgGL2GLcgAQnoAFr3AO/pv39cimVn
Date:   Wed, 8 Mar 2023 13:16:51 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] soc: renesas: remove r8a77950 arch
Message-ID: <ZAh8s38kTHLr1Xpf@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
 <20230307105645.5285-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdXr=WGTEOnAhckPW4B1WUoRZUokkRjEZXjsU+Qr-y60iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AsjcfHyIniRZmAli"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXr=WGTEOnAhckPW4B1WUoRZUokkRjEZXjsU+Qr-y60iQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AsjcfHyIniRZmAli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> ... while queuing in renesas-devel for v6.4.

Thank you for the fixups!

Happy hacking,

   Wolfram


--AsjcfHyIniRZmAli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmQIfLMACgkQFA3kzBSg
KbZUjg/+MXkBkOBrzFfErKnn/1+QJ0oDMSPiuZf8owAma7Qbn0b/IA2OzggUd1jB
ScpiSugHkfNu75GpRke4W2IA+xtIuQCGTx8F2BcPK/sSNOQP15PiwNu+2di0zaPW
21ZKpX0rG3KOgAJ9t1GV4UwmeWSdFuEQu40HWrSbCf9B6NywDyTxtSDYH0CvxlIa
Z4LCvGcofisQlGtJFHfgjdzLH1AMXKnJYhF8zA30q/kzZArCvpXQeXJYeb6nF4V6
wPLbgtAiX2xfMOEE7+tFyZmcF4RkiNOo+gc/qvAyP+Z4hrWmK3vYOjt06L0hG0SJ
qgzRFSmNGokSVakDZX0wm/6LK5ORWzfNCFpgoitvRo7AzGqWq9VDmBvCuVTEPH7z
cd5bQIFvs/L1ViCId/JX5dAotbY/aZfaIXc6ePVYlLdlh41VrrDMvtAThXKpV16m
3ngXvzcGhNmKPtXCseX+qNa5WRX008LOMJozd/zQGZCQQHt/faxA+eZ49SkjZgNW
xrpWEM/Lh5BlVxTVOmzP6mV2s3jZBG0o1GvpHg5a+2TZbKcvMGLjqTBftADm5cwR
Uxoi5p0JE0uLklh0EbZCY4hsDoOCRgrt1xBx5NmjVLMpbZKOV6wtT0+CzXX6aHR4
C0D4Qlp+p0/fT5a3HN/2KKfTPetygHsZEkYmLf/nkeaQiuVX/xs=
=XeZo
-----END PGP SIGNATURE-----

--AsjcfHyIniRZmAli--
