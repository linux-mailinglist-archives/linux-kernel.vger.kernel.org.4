Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCC6FC63A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjEIMZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjEIMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:25:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126C44AF;
        Tue,  9 May 2023 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683635127; x=1715171127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ijkGrW+2rpFL4Y0gLu0veMBivtrLnsxJY0JGpTtZ9Bk=;
  b=VzdDXSnu7ppy6LMg/3wIq90VQzfw8zFHkoJqkgbVQoiYwpBAtTgb8YSX
   OTJtXp09ZkLv3oKvN6WWDUZuYp1mA7n3CBOf7bRIj0NQ9xXbx5Q1NHJ8e
   icncKEGmkYEq9pB5a87VhLcVLriOVPnJa0QZwTzMLk0MIOhtOEr+QQc5M
   jnCvhBpPtdQBoQzDR0uZnvj1sA4l1eN7cDRNcJBYgUG8GZNT+MZnW+Rj1
   rlGViWXWkWHq4f5AJweDA/DbfpGM1XdknAsWzruRS4/vVwzL/7iNviFsb
   VIE7lhIC3Q3TWE8J8oGk1CnF8FD+D4GM96unL2zFuKbR66Z2Ih6amC6ha
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677567600"; 
   d="asc'?scan'208";a="210342933"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2023 05:25:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 9 May 2023 05:25:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 9 May 2023 05:25:22 -0700
Date:   Tue, 9 May 2023 13:25:03 +0100
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
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <20230509-reheat-enclosure-c0f8fcf7f157@wendy>
References: <20230509030705.399628514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9nh3UvsGBTT76EVo"
Content-Disposition: inline
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9nh3UvsGBTT76EVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--9nh3UvsGBTT76EVo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFo7nwAKCRB4tDGHoIJi
0rXdAQCStlcR0Mkfx/k9Pb/1gFsKOiO1GZCFh66yXngIdynN/QEAyex3G0ZVNS/F
qe2nUILynK5mjBX5La5rIPAZCi7NAQw=
=MJU6
-----END PGP SIGNATURE-----

--9nh3UvsGBTT76EVo--
