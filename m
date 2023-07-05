Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0477B747DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGEHKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjGEHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:10:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1604197;
        Wed,  5 Jul 2023 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688541010; x=1720077010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ConKYiJXIY8Jw4Sc7qTfwuyKjyDkGUkguUDNtmuu4Zk=;
  b=N9QxTD0855nGKBaqoA/NItrwF6P8L5ZxFIzvjzRlBVGtb2CTeU8dHPhI
   DCribEZTrnVh6P37BBX8VW9UynPJFEChp7xrZVJh7Iit5tZUBqr+qwo4o
   yckVK8RU5cBnEhvhRirWVjcIenWrkbSsaeNstA0063BktKv9/Wo/YjfQ1
   1DZXfs60Rgs8/xedf3pJSGH73EA8j/YES0mUmiFsI86Og1InX1pTzMBQJ
   FzhqUP3rZavXHAtDKmqwAg9GypuZwGI254fbiQ6BdS47FWwQISVszWo6Y
   V1PXpzVW/Vx0IUDTuIsdFvx/Y8o4P7l+mUsK+7YPNGqUezUrLu7ot/l08
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="asc'?scan'208";a="218951171"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2023 00:10:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Jul 2023 00:09:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 5 Jul 2023 00:09:50 -0700
Date:   Wed, 5 Jul 2023 08:09:21 +0100
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
Subject: Re: [PATCH 6.3 00/13] 6.3.12-rc1 review
Message-ID: <20230705-anyplace-clutter-42bd80a39c68@wendy>
References: <20230703184519.206275653@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dN8mUbTyqj3Pmp0M"
Content-Disposition: inline
In-Reply-To: <20230703184519.206275653@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dN8mUbTyqj3Pmp0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 03, 2023 at 08:54:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.12 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--dN8mUbTyqj3Pmp0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKUXIAAKCRB4tDGHoIJi
0vFOAP9Bfnks3OPNhwIpLnAo0xr09+RySOHcNuQb0Z3PEXElDgEAiHO+IooplcDK
yNbdHmsxbhmaGZ59pWiMsXCMz0zCGwY=
=rNmL
-----END PGP SIGNATURE-----

--dN8mUbTyqj3Pmp0M--
