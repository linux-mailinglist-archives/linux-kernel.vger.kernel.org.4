Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070674D90E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGJObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGJObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:31:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856CF2;
        Mon, 10 Jul 2023 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688999480; x=1720535480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LOdSUAq0OWnykpn7i+mc3p2uFC+TwqqqMHbwvvn1c6Y=;
  b=I5GqNoMgGzPoldBtHdb9vAyZCEd1ywr0Vam5zupaZ4yh/zQgLSBztl2U
   x/tDaX/9BLrkTRZaQN0/MPouRXjT6LPsZ3QFIY6C7JDSZ0+e7xmmRlNCI
   2eyddtCT2zmcKRJIFA6tDv077WtXU0VFcmdzHKmph1t9pgADbpTSN16+o
   kSoDx2LGyZ2e/ip5o0srm8fmM76gqfTb8n3bFFdZ6jDOTO4DFrGA/gol/
   hZhkXVInFUT+0UnI2SB9ACmTwLsiadzFB/yF/B9BczqgI5XwvC4Rnoyd2
   F705Kd6eYqhA7R4Fa/AjsMKiiR6+togQuYcshxxPugY/scKwL5B+4DodL
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="asc'?scan'208";a="223957711"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 07:31:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 07:31:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 07:31:15 -0700
Date:   Mon, 10 Jul 2023 15:30:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
Subject: Re: [PATCH 6.3 000/426] 6.3.13-rc3 review
Message-ID: <20230710-parakeet-conjure-fd252215dc84@wendy>
References: <20230710054619.475084489@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aHlqKoYVsI68erxS"
Content-Disposition: inline
In-Reply-To: <20230710054619.475084489@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--aHlqKoYVsI68erxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 07:47:20AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CI had a wee hiccup & skipped one boot-test, but everything else looked
normal...
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--aHlqKoYVsI68erxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKwWFAAKCRB4tDGHoIJi
0skoAQDE8fqdEO0gxuNGAUHqk2owntemGPzxXEZxXBCYXZTeugD/Quwoj8kDa8Z3
+vnNj5LEO0o5wcqIk4aCGQsqHoH4Kw0=
=JgJc
-----END PGP SIGNATURE-----

--aHlqKoYVsI68erxS--
