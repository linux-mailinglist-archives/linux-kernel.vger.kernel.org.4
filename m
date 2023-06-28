Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D3740C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjF1JBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:01:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:27261 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjF1Ioc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687941872; x=1719477872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=45rv53vDLpmBo+b6q8IZyn51O/jO5mJGy41d2+wno64=;
  b=BTBwypUWtZrjXFIOhWrm+hff56b/e/U99AJ0TZTIMVPaWjClFJGABTsr
   Tt744fze/ShldFzpByLMaxwa/gFSElBUN+3FrK4aMe/86lgc0+p2zoGbr
   qZZcBfNyNA5t/8QJMrYFvh95DVW9B5eE0kC2hs2dFZMupa5dg4oE7SdNv
   XzwNk+qzSupeSRTY96cPGR4/8vtuPIJlggsGClEhSNhY7+S4AE4Jt4fCI
   koI4SZkaR8dsYoSG6ufC2xB/crMPiowyP9yC0lzjBbUgWncsXOigYq2A7
   OYod8h3Ahz070WeFP9SJyolZVwHaXUIRahCZbOOQPOwAqkwOG0gRUrtXk
   w==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="asc'?scan'208";a="232606208"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2023 00:06:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 28 Jun 2023 00:06:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 28 Jun 2023 00:06:27 -0700
Date:   Wed, 28 Jun 2023 08:05:59 +0100
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
Subject: Re: [PATCH 6.3 000/199] 6.3.10-rc1 review
Message-ID: <20230628-frays-parish-7d407edd6225@wendy>
References: <20230626180805.643662628@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u+U0Bb1cftV7h6x0"
Content-Disposition: inline
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--u+U0Bb1cftV7h6x0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2023 at 08:08:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.10 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--u+U0Bb1cftV7h6x0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJvb1wAKCRB4tDGHoIJi
0nDQAQDNSgQkz+OpfbRbVVtB2Cg3CZWIWqMXTeLQLlp8evltHwD+JAFbjSiAX6Bs
Az9y0EiukyHgKim5EgIGIgUAAdJjHQs=
=3Vti
-----END PGP SIGNATURE-----

--u+U0Bb1cftV7h6x0--
