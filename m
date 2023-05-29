Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD91714905
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjE2MES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2MEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:04:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DDA3;
        Mon, 29 May 2023 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685361855; x=1716897855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9agoXGkI07FIZqJcQYRolaaB4bHKP1ZD9xZJo5c9UGU=;
  b=dfwdmy0B3qmuNNiEDOBLRTTIsWM3xsnjKJvkLAiw6DWv9XlU3RJbfRmr
   gmnSxJPbyL4DrBV9/DMmCgCSmTGdyZ2pX7MlTluON9Zup/d2OtRiEzwej
   4YGflwo/iLiIy5wxAKdgi9mzcK6JQizAXmAbFdhBhOS5RbeDC4SJSMwc7
   sxsjNa/BvDuuRrrXF8IsboOrscvv96qRpsmG4gd8V+H0dF78hdaGbzUgL
   dwTbWNkb79a0038TcCX5ta7j8mfBMBPMUDp/+UssyYcEvriIoQ9+OQF7O
   wdyTnW42Vl8cZzc9uypg86ZzycdvImJZkQGAt9lXen88h9twcL6LquEa8
   w==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="154422043"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 05:04:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 05:04:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 05:04:05 -0700
Date:   Mon, 29 May 2023 13:03:43 +0100
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
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
Message-ID: <20230529-subpar-overlabor-c42e619055a8@wendy>
References: <20230528190835.386670951@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5WMTKpVQWMZZehZ4"
Content-Disposition: inline
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5WMTKpVQWMZZehZ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 28, 2023 at 08:10:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor

--5WMTKpVQWMZZehZ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSUnwAKCRB4tDGHoIJi
0iOCAQCQU1uvXkh5DbnfamFmbN4PIyuSRHvreZU77DkUJVGrEgEA4ReFSKhQ9sRq
STUQ/8sLoUIlwUFY6gfddnKv5XH5BQU=
=D1lu
-----END PGP SIGNATURE-----

--5WMTKpVQWMZZehZ4--
