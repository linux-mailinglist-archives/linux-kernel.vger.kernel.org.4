Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6071FA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjFBHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjFBHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:00:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44365E40;
        Fri,  2 Jun 2023 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685689248; x=1717225248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4JG/BkDFywtb3I5VV9TtSjO2u/0Kdo7FRtTZx9miGQ=;
  b=kpiWySxAYeKmqYLt8k6k7LKL8EkWVczWMAiiFf9BpYbE+7YxWTxbGzWt
   qcYi8d+rw7OZtdY1Dw4Qldmz2xudQgKNAgec0Iylu8RGBIOA3d1rGLeVX
   mTlxdSjjEwqnhAsCKouNl8pnzydnS1gbL5Drm2LJOpZXFrDy2xPZxj+sn
   EL7AC4vM3zRoh584AjApObj6ygIpBKrdQiM8jVr2CDAgM1w6uGDiIYaee
   49HLFqw25f4uEeO6uvjsVQ5Tn07CyksyYQU8SisoxONFwHTgLn9IurpqG
   DsJHyqdFeew1IccYKuYrGSGpfp7MwUSm64yWAPEt177RbwGrMd+Oxut7c
   g==;
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="asc'?scan'208";a="218514510"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2023 00:00:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 2 Jun 2023 00:00:46 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 2 Jun 2023 00:00:44 -0700
Date:   Fri, 2 Jun 2023 08:00:20 +0100
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
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
Message-ID: <20230602-unweave-entire-fc3f63a18162@wendy>
References: <20230601143327.479886832@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nWrFjptjSZE3Ob8K"
Content-Disposition: inline
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nWrFjptjSZE3Ob8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 01, 2023 at 03:35:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--nWrFjptjSZE3Ob8K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHmTgQAKCRB4tDGHoIJi
0tgLAQCKu1JzuYbRLUmLKfB/0HiulyP6YLm+03/RAEhoeCt1EAD9GbMVAFp9KQoJ
40lt9L+TbD13NE+cK4I44jwxnbSCeAk=
=o8d/
-----END PGP SIGNATURE-----

--nWrFjptjSZE3Ob8K--
