Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56994704DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjEPM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEPM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:26:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5749F5;
        Tue, 16 May 2023 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684239985; x=1715775985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aAB1RI+PrfBWa9+/JpT0dOlyMXsCOTEgzEIRHIH/VVQ=;
  b=A6cbXNzOYIETCKPE6bt30G/bMT8nt/pAk2b/BF5oGSIomRrU3WTc+ZDk
   uAVkiF+PYMQW+RHDzMpdz8janjz8O/r2+PHm+Lfbl6iQFbw5tUgZJMTUZ
   koL10UfTskillthnJanYpOiWlxY4Lc4UyLH7eLmMsqO3IeURhkG++STiI
   2+vge0WhOfEyMO1tCvhIv7LhMMjT6xjcBlbVDoaAE7Y87FuZkP9cowNyx
   G48yJLGCT5q4b6YMNAkQSXgFnwF2lWDOSGLd3OUy6DGVvsSTPRDfmcqF1
   TPsxHOrJEn37+kRWYmbNTBo3vZa+uDcz8jOL0R1BnNA/RXDKTpx8cQ8KW
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="225535650"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 05:26:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 05:26:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 05:26:22 -0700
Date:   Tue, 16 May 2023 13:26:01 +0100
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
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
Message-ID: <20230516-semester-edgy-b26933f6a150@wendy>
References: <20230515161721.802179972@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qBMShf/1ne2wUJK"
Content-Disposition: inline
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2qBMShf/1ne2wUJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 06:25:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Nothing untoward here.
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor

--2qBMShf/1ne2wUJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGN2WQAKCRB4tDGHoIJi
0ub5AP9Jo/r1xko5aR7TyQIpHj0BfhnxhiduNu6Md2mZxFj0SgD+Pg4ZTbNficLR
3VkfPdsE0z30ETmw2hg2SJm+6cUUVgY=
=LJb/
-----END PGP SIGNATURE-----

--2qBMShf/1ne2wUJK--
