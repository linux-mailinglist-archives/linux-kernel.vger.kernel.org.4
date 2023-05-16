Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C776B704DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjEPM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:27:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8694696;
        Tue, 16 May 2023 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684240038; x=1715776038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWOCg4krQF0iPAAoKCL329e4qIBpOQAo3CjUNd8Xx/0=;
  b=VSUmdzcRpVKNT51YZEFvpiqXkBlJyJ/kJhz3mc5EUudBhlBArrvkEthv
   qrW88uKXZSeByClSkORhcNyBYrDb15bJXkoYi0+XVkKvoz1FKQuMVobtE
   SffmKVsLgH7g6wdQkyE49fOk3/CCeBUcp8WfZOwT0pH+Dc4yuBxKQqLPK
   itgQwyjLgM/v7SNWctCDi3YK0yhox7UcsuFT+JARknsRCFDd3lhns5+D2
   SKMa1k60p9Cu6vVohc4/z/H8ylB7UGwwH2uuxPW9IXNWkiQzDH3Di5+gM
   E/2ldNk2iLeVm4tAm2xoeA4LT72h9QXRZzG/CSKmuI1k1OtoTDr+s0JgP
   g==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="214078784"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 05:27:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 05:27:15 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 05:27:12 -0700
Date:   Tue, 16 May 2023 13:26:51 +0100
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
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Message-ID: <20230516-upstage-churn-cd7d524d8d51@wendy>
References: <20230515161722.610123835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WnZSukDCj38U/cgu"
Content-Disposition: inline
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--WnZSukDCj38U/cgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 06:23:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Ditto here, nothing looks out of place.
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--WnZSukDCj38U/cgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGN2iwAKCRB4tDGHoIJi
0u6bAQDOIEwyks1kiuprnXGIel3Hl0BNpNMJlhW+DBdUmgNXGQEA2ZGmcf5Xyk8D
BnxrM+d2X4dKMpwJg/Z8jUGcGa2klAA=
=ajXQ
-----END PGP SIGNATURE-----

--WnZSukDCj38U/cgu--
