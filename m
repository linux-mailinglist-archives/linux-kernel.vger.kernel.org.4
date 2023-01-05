Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115465EFC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjAEPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAEPOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:14:35 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11E50E4F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=tZjV9jpuEK4Y2XqKI/OT0o3B7gcC
        cq0sQKnRF7DSmjw=; b=dS5JSKGc5w2j51S+cCn85pOOS6H5K4+HfhFA+rpX+YLs
        ASmLCWG2lAUoVk/lr4YAW7+7mHm+6klsJvuUSBDXSuStZPer5j49CmcxoMdDqFRE
        K2u9KUTyNoaPsqWHsB0Netoyg64tEKHfVggboQp7Z+tE/tbIMtXZn91JiCO3+yA=
Received: (qmail 1656785 invoked from network); 5 Jan 2023 16:14:29 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Jan 2023 16:14:29 +0100
X-UD-Smtp-Session: l3s3148p1@3djgwYXxHKxehh9g
Date:   Thu, 5 Jan 2023 16:14:28 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 21/27] mmc: remove tmio_mmc driver
Message-ID: <Y7bpVFG41DVU6hXS@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-22-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+plC2ZH96e31NEJu"
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-22-arnd@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+plC2ZH96e31NEJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2023 at 02:46:16PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> With the TMIO MFD support gone, the corresponding MMC host driver can
> be removed as well. The remaining tmio_mmc_core module however is still
> used by both the Renesas and Socionext host drivers.
>=20
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I trust Arnd's research that the driver becomes unused after the PXA
removal. I can add to it that the plain TMIO driver hasn't seen any
functional update in 10 years maybe. Most modifications were tree-wide
cleanups or adjustments because the TMIO core changed. It will be
interesting to see what cleanups can be done once this driver is gone.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>



--+plC2ZH96e31NEJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmO26VQACgkQFA3kzBSg
KbZryRAAsP2ilw61YHDXp7tFw+jW83ObuNAFRybR9fjDVe+mWZSwrtb17iABxFsd
f8eP4ELMzbI8dmX2rZ6kl/5WFRbsJbSOZHaePwk7pNX/nCaQLsaZCsEF3wf76BLY
CQ1znFYgyKGkJg4s/ofW2XqvbegrKkhancbFYXQdh2f1MV/POW0zGSmkC3uWqZSD
fmw8qQIPylrxFwum4PEpxK9L3hh1gwVNh37jTvfviVkFrrDz1Wd+QT9YEIikmAyT
iRmbXbqeOoc+0k6TKQapZSCysgedAamR9ZHG72s6GqrFx1QBRlSnDxySvmMWwkUr
XK4gHeiIs/kLaNFu2bZSeIOhhRk84ykHO2Yhxj3NHRX0BwWrSDCbjcFwFozGMMNW
N91CRN2enh8MneYgcH+WoISB3byrFaxwjvgpH3NjUDWiExyBNSdXrALbc9lHLA4q
5ND+ysxn2KtyOP1l2iFHUY75Oym+pGmG4755QWPLqQHsm1hYHaQN/EnGAh3EyApo
e67TFAwVbQqjdNu0oRBk2BylfNbVrRf/1+c7X9bvGrJFBMhvj9iKPTktE3G5FOvo
YeNo2P9Z9sjuJQBKBKtvhfCUnPscMmcZoJzrUKo8fKhLbsw5qb0NWVoNpc0qZGeL
TGsbyddaUvOagAFLXS+HHsr5iDnc0rE8lgeLB3uq5yvFqzMrjBU=
=IQN3
-----END PGP SIGNATURE-----

--+plC2ZH96e31NEJu--
