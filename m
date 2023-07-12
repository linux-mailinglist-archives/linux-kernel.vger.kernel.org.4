Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF94750870
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjGLMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGLMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:35:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368B810FC;
        Wed, 12 Jul 2023 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689165337; x=1720701337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XAbpANE/Fng5ECm20P1cz/dS/we/2gWEgl+TdS/1S6M=;
  b=fVQv6PIbWnX9T9WpHW1d3e0CGWeF+b01Ol+GPCLmskMWXRygvN+ZeNZF
   hjsxqMGeeKqkZ8DZtneUujBdzvTje0vsbP7JkkrHA0oUDLZ8JCGEaJxes
   BPWnJeHTIgcN4WfCugdz5jul+e9hE9rpvkqywyFF6hyDtiE0YMmEnxwRr
   6iSmJXInkPk4gIfxnghbCSImXITb/OKLEN1DRIlE7xd1EwBLSQZT7na+h
   vgO2sxyD9+GTMtmaAp1IBQHksHe11cvkMmBaBf3XO1YpPtEVsqf8rF+F+
   SqkMvs+U+NuiTOHu4FpJPFSBOAW2PfPtYxERnlRJ9L1fbzlTsYgAnfgzu
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="asc'?scan'208";a="220004003"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 05:35:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 05:35:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 05:35:34 -0700
Date:   Wed, 12 Jul 2023 13:34:57 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/process: maintainer-soc: document
 dtbs_check requirement for Samsung
Message-ID: <20230712-unfasten-trespass-d57b3ff1f134@wendy>
References: <20230712084131.127982-1-krzysztof.kozlowski@linaro.org>
 <20230712-skier-ribcage-0d82be7e16fd@wendy>
 <da79ac87-f112-be43-52b2-2293e1a99d9b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oZupxwsk8vse9QyQ"
Content-Disposition: inline
In-Reply-To: <da79ac87-f112-be43-52b2-2293e1a99d9b@linaro.org>
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

--oZupxwsk8vse9QyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 01:46:20PM +0200, Krzysztof Kozlowski wrote:
> On 12/07/2023 11:48, Conor Dooley wrote:
> > On Wed, Jul 12, 2023 at 10:41:31AM +0200, Krzysztof Kozlowski wrote:
> >> Samsung ARM/ARM64 SoCs (except legacy S5PV210) are also expected not to
> >> bring any new dtbs_check warnings.  In fact this have been already
> >> enforced and tested since few release.
> >>
> >> Cc: Conor Dooley <conor.dooley@microchip.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >=20
> >> Not sure where to document this. Creating new maintainer profile for
> >> Samsung SoC would be an overkill. OTOH, more SoCs might want to grow
> >> this list, so this also scales poor.
> >=20
> > To me, this portion of the document was "information to the
> > submaintainer", which would be you, not information to the contributors
> > to the platform. Adding the comment about Samsung SoC seems aimed at
> > contributors?
>=20
> Yes, I want to document it for contributors, so they won't be surprised.
> Any hints where to store it? I could put it in the "About" tab of my
> kernel.org repo, but no one checks this for contribution guidelines.

I've not got a better suggestion for where to put this, but under
something labelled as "Information for (new) Submaintainers" isn't
where I would be looking as a contributor.
Is adding to the generic DT documentation that dtbs_check should not add
any new warnings at W=3D1 too extreme?
writing-schema.rst has the instructions about how to run dtbs_check while
writing dt-binding patches, but we don't seem to have any docs about
running dtbs_check for dts/dtsi changes.

--oZupxwsk8vse9QyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK6d8QAKCRB4tDGHoIJi
0lwSAQDBl5SejPpAFmt5bv2VhK+0qeUjxPKk2oF8smIN4o1SmAEA0svDs8omMe+R
WsZHkfgbSn5tEDE4rofWHvQ8e/QKrgM=
=b8RU
-----END PGP SIGNATURE-----

--oZupxwsk8vse9QyQ--
