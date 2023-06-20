Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C172736AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFTLYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjFTLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:24:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6410F8;
        Tue, 20 Jun 2023 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687260237; x=1718796237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObSwR3z5gLc7CWALv2Ch7IeWIRyke2xnjULZNZqbszg=;
  b=Ul4KqJJQntcBCwGTrprVM26zTf7coH+I+dT6SAmTmFBf+9HYy05cvt4v
   Oz6g/NvFysA0k9Yx4gaBOlhIu68wQ0wZ82yLkxVvkeDob6g/t77AKqsc/
   e3Rr3VD/wZnx1h2//lpnWwHm+XCqzePQUvxRlhJUw2ubxsEuRwTKYcnSy
   f4f2D0vWNslagoQduucUf5Dpif9NAhRDt1K+DCV4PQIX40xeOnG9NzdsK
   1ICj3Ib9Y0eK6y0GXp8xmQXD/dFMlAX9cXMkneNpMkfGRuWZe0sEWAItS
   BEXUxuycVQkgVjA2BaL9YTTBwxleiuh6Pyk20ORCXrldpsmudlIzBdC0a
   A==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="asc'?scan'208";a="231095395"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2023 04:23:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 20 Jun 2023 04:23:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 20 Jun 2023 04:23:53 -0700
Date:   Tue, 20 Jun 2023 12:23:27 +0100
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
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
Message-ID: <20230620-mandate-capsize-e8dfcce96656@wendy>
References: <20230619102154.568541872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X5M9avvAq7l2RkVl"
Content-Disposition: inline
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X5M9avvAq7l2RkVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2023 at 12:27:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--X5M9avvAq7l2RkVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJGMLgAKCRB4tDGHoIJi
0njvAP0XYkx/pajmHmA2RE+wIYvGrRd0VoRhKQJyWeZ8viOryQD/SxOX2X5bd0qu
huJFxG1Xv4VngDi7MgDUWqTh5JSFvQQ=
=9L50
-----END PGP SIGNATURE-----

--X5M9avvAq7l2RkVl--
