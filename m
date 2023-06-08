Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28E727BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjFHJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjFHJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:44:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930732720;
        Thu,  8 Jun 2023 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686217479; x=1717753479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8BM0i5rppABoxdZHrQfySlcFcT+hRHiqGkgHCysC3w=;
  b=yJtETtgTUK8XKpDatjdyWKaXZpW99/OOhy65lpZVdW8eeQaQ61DRM/zz
   8boAVoqyqtypC3GYcdgt0An1E/Z0fk3BOKBZ4BqC0jWq6o2eSy92Fq+dd
   n23AJstN+anuHqe6yW8k7plXCbedTLHGrr5PtsTYq48ZORWMficOtn2LQ
   hbmjxdGuTXg4Wvci+8SiQrJRytAe8/v77TUrl601evlwZu+eFUTtBV9XJ
   4SGY7Jg2M/8mx1HvFuXUJmLVqWMkpcSwGbpC5S/tEbqAK2YfXt01BOaJo
   5aLy0nj4t3TfcqP2QafOEvkmUPQu+pKYwDy1xEFeEuPplub1vL/FBkHQX
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="asc'?scan'208";a="219398130"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2023 02:44:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 8 Jun 2023 02:44:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 8 Jun 2023 02:43:57 -0700
Date:   Thu, 8 Jun 2023 10:43:33 +0100
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
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
Message-ID: <20230608-boss-municipal-75220d1158f9@wendy>
References: <20230607200913.334991024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZEKmY72Ta3DxAanB"
Content-Disposition: inline
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ZEKmY72Ta3DxAanB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2023 at 10:13:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

LGTM chief,
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ZEKmY72Ta3DxAanB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIGixQAKCRB4tDGHoIJi
0g4OAP0admz+rz+U1D9Q80IclWoci4XliKC4AEdi2qw1ND5MJgD9FdaHOjJIjp8a
bFi+2tRcU1mZvtECVwFIXKMrkwMRGwM=
=OqD+
-----END PGP SIGNATURE-----

--ZEKmY72Ta3DxAanB--
