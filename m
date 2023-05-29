Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53114714900
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjE2MDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2MDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:03:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446BA3;
        Mon, 29 May 2023 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685361796; x=1716897796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXEjZRVQ8wPrJHIfwMuw1M/dTin+7ZDFe/zF+eNOlmU=;
  b=D9zSOR+FwuKh90SrndeI/qv/xAu8a9yXwunrYk30bDS0VeX6V2LByps4
   9ZDRpLq35CZn1506r+cvvloOlvMIVTvZyZGhvY0NqZAQe8Hlf15e5HzBr
   oN37qWadp75HjdPWXryadmi62fhxHuaIYAHqpIfsheSfCC9iJjuI+k3N1
   rR1Ddu8phe2NwyuovSzEaMDLTPvfYyarpkinfmwkoRTGRmSU8iW4tDqgZ
   P3CrgdyuDBuLE6zqyKL4DPzqd9ugy7pih8PTyBTR/u71V+QGyeDJs3Pgy
   sG34j4uHJUuyWayoxFWFjeLGCRrtoIzsBLbNYRFAJ+8de9s250zJOBUh2
   A==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="217776096"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:03:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:03:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:03:08 -0700
Date:   Mon, 29 May 2023 13:02:45 +0100
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
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
Message-ID: <20230529-grouped-campsite-0640cfccb101@wendy>
References: <20230528190836.161231414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDZyWUJ00k0QZ0Rx"
Content-Disposition: inline
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IDZyWUJ00k0QZ0Rx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 28, 2023 at 08:09:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor

--IDZyWUJ00k0QZ0Rx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSUZQAKCRB4tDGHoIJi
0jmFAQCGZU6EHGCB1w6XAHJ5zvcIvzgVdI3/J6AgdJaX0IJ4LAEAqsT0rD5Rm8tl
Grwwc+BbEhZSCYmb1KIQOW6EZV+ZJAA=
=etCZ
-----END PGP SIGNATURE-----

--IDZyWUJ00k0QZ0Rx--
