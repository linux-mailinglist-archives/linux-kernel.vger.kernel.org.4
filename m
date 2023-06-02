Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEA71FA88
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjFBHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjFBHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:01:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2210EA;
        Fri,  2 Jun 2023 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685689297; x=1717225297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HsIDP2Lxt6nJZdUdVu7PR+wHkA56EitEmtH8CnaLUc=;
  b=P71jD0bfV8HOzF+tIvRrLEpp0VEejQpdf/BfWVE9sQPGqKZ3EFrbG7EN
   3cPNhtzzctNaWfu9Z0HVfVZnWyKjCyEhZdaVJLrTTy0io53PQPAoEPn65
   98v//ckL8A8becBxeUrwL4iFIdFLF0N8Pu8PgliYlTmnDjIKcty8LTerG
   toXOjqNBKZDPlB/A8+h5EJ9G5bzaIuxpp6y9nCOW1CSB/ADFaP/+IQDz7
   LsyULSAgh7qwkFi55Q6YARBkC4ueu9fJKFJmqKJTWEX7WmCSk42Uj+rvL
   aa4CGizGU6I3k/3gnePWITabydccygqaJaupEUXj5AZDbu5Cf+IpSD38+
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="asc'?scan'208";a="214293338"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2023 00:01:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 2 Jun 2023 00:01:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 2 Jun 2023 00:01:33 -0700
Date:   Fri, 2 Jun 2023 08:01:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
Message-ID: <20230602-annotate-gestation-0e7846af0042@wendy>
References: <20230601131938.702671708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d13Qmp8CTGImzea1"
Content-Disposition: inline
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--d13Qmp8CTGImzea1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 01, 2023 at 02:20:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--d13Qmp8CTGImzea1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHmTtQAKCRB4tDGHoIJi
0jAtAQDj+LXwNx9ZseC9NwOZKJojiLWJN+DqPO7ASS+cAvaLSAD/ZMfyKDp79OxA
3yjHT03r4GZCJinf5bmTkY4FZzB+Kw0=
=N8OR
-----END PGP SIGNATURE-----

--d13Qmp8CTGImzea1--
