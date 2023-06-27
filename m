Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD80273FCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjF0NjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0NjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:39:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE52D7B;
        Tue, 27 Jun 2023 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687873152; x=1719409152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LbkL7tXxwlJdWU6yvK9qq0d59PKW1IuqSiGV1lLmpm0=;
  b=ndQ/vj8ylgz9jEFgs+e/Xn4dXl3AVllj9jwCdIGIGNqvmGqB5hmG5Yiq
   IZEyEzvJtQzEn6AZXYTDEcE7UwqqLGz8ulhT8QaNDEA2xD60ffPQgvdI1
   zOiZ3u5/75y07Oedl2Zts/j2WaIeMnmlS2nvdJi41aAfFRT7ElqzVf4Ff
   RYihkDqdfKEwBF8H5oUx1/4jjFBuSeJr+UhhyztNZkr/aIejGuotjHxtI
   B8ucJV0/SXwIu7RJGXVk/0RwRI35jCO2UCn3Ioy4Cf88REB+Z3J8fKq98
   oVsI9oxI3e5WO0CrjlWt8yi26Gwehc8DwxqukRkw1c8MdRY49KnubOnMM
   g==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="asc'?scan'208";a="222147104"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2023 06:39:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 27 Jun 2023 06:38:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 27 Jun 2023 06:38:45 -0700
Date:   Tue, 27 Jun 2023 14:38:17 +0100
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
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
Message-ID: <20230627-paying-untangled-02a11b535346@wendy>
References: <20230626180800.476539630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c+jIQADTZPCON90F"
Content-Disposition: inline
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c+jIQADTZPCON90F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2023 at 08:09:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--c+jIQADTZPCON90F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJrmSAAKCRB4tDGHoIJi
0m/kAQCZItFJPvjCZjQq6mgT6kT1CMX+57+otcs5NeszzWM10gD/e9c5NGstRzP9
FGV0I520y2b/1Y6fKCso6XXNSgY7gww=
=Q0Sj
-----END PGP SIGNATURE-----

--c+jIQADTZPCON90F--
