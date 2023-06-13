Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5872DCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbjFMIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbjFMItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:49:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DCC9;
        Tue, 13 Jun 2023 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686646161; x=1718182161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+c48awLSI/0CX9e9GAjVHuwkZ1cRmuijLM7ZZzCtiA=;
  b=tjt8p1VwHATIBSrBND5pMlokUEQgrA4QygsEf4AMRblU3/c319M9kgeY
   PcvMRQQh57xWoWWtx6wtknoPlefNhFL0l931klafnZ+oYM204NAiudSjl
   h/oRbA4QwJvmQRvn7G2B7pIA2Ga2Ei1HCBYD+2Xc4cAV7ozxRg9GG9a4Z
   zDOnG3kxn1PxGRzzqBAtb9oKb/UZ641VZuzvDR8mhBD48rKTMgw/RSak7
   qFk7/eKJdO/xKUUIEiHrIvuAFSyS06M0FKFwC4yE4f8L7hjB3BC3EehhP
   cE8RoSVqVfjGToziDOTpLz54C1Jyz9Z6mAGHx1HEgFCTjzn/BR/KToN1s
   g==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="asc'?scan'208";a="217571653"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 01:49:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 01:49:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 01:49:18 -0700
Date:   Tue, 13 Jun 2023 09:48:53 +0100
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
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Message-ID: <20230613-guidance-coveted-a8e584cbe2b2@wendy>
References: <20230612101715.129581706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDJ5gyBZh1IgAYsH"
Content-Disposition: inline
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dDJ5gyBZh1IgAYsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--dDJ5gyBZh1IgAYsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIgtdQAKCRB4tDGHoIJi
0ksMAP9tuDiBuXFuFp/74o3e8ST6oIaVrodvmXc3Xs8Z2b9SMwEA/aYNJ0bFUqKq
Fk8AkuVKLgekY33M7RvgHJfLeP4E+ws=
=qZZq
-----END PGP SIGNATURE-----

--dDJ5gyBZh1IgAYsH--
