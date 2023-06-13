Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5872DCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbjFMIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjFMIsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:48:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5B5C0;
        Tue, 13 Jun 2023 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686646084; x=1718182084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gK0JGjscBxeV5JXTkYgz7hz0xvUOrqtLXHuF/C7Qnxc=;
  b=eVdmVzUeSrkr8VvVo5/X3/862qdi5jvkfcQ0XHeVkXDNBFQCJiIx/XA2
   qqwF+stddN1aqtGXBmQ8UK0nwy611hD8aAN4SIQAJVBQKBrc2uX5Mk/04
   kK9uYN+QP2Te8tNOHHM0QXt7+jzkljzBJrumKDiFtPZeHd4YMTP4NvdAB
   +bAvap2fSOuzEG3gtpj+GwuZ8PyZlsEF1vY2PRzf5JQ8oKa8QguOPpmnj
   B90UUYSoKLltzaGGgbM9FRUGkH28e6eTTsoZSHvoWwPK1xLCGFkZNV+Ub
   qHLSwaPSrvBJ+ZVLRLzFxpa5W/MLLt0rnMne5QT6vtzMMVDhKXj/NzL+8
   g==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="asc'?scan'208";a="217571430"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 01:48:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 01:48:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 13 Jun 2023 01:48:01 -0700
Date:   Tue, 13 Jun 2023 09:47:35 +0100
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
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
Message-ID: <20230613-curdle-varied-0e920e75d1d9@wendy>
References: <20230612101710.279705932@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uz0ntHTHOCy6+mM2"
Content-Disposition: inline
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--uz0ntHTHOCy6+mM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 12:25:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--uz0ntHTHOCy6+mM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIgtAgAKCRB4tDGHoIJi
0gzVAP9qrENM500fT8wOMA4aixSCKLr30EfO5nxMoELVF/AOKAEAnKX+vti7R3Gd
W2XNtHU+pFhDzBtnoAWB8l9rrQDrCwA=
=vvDo
-----END PGP SIGNATURE-----

--uz0ntHTHOCy6+mM2--
