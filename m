Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77261747DED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjGEHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjGEHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:09:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17345E72;
        Wed,  5 Jul 2023 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688540955; x=1720076955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l73p5YJJFfIg5mKM+9EMxeRdo7h+3A+3ITUn2dbN8zk=;
  b=qp8pdQdRKbfj01P5MFpUQ8YAYiyBax+TDqCx9mfE/0xymet+SKGzAu2Y
   WxWOOQ1BKQiZ39B8KduNv0AkWnDwC+AU7wtXU8cIpr8UIVUR2ZznU9VoW
   zNMprLgUxHjvmU/mPpUso2Wpqq1pHqSfrXQ5/xFfH+TAQ/mEBuPjWgVAa
   i/3rJEki70JjOvvc2mbXRenEx/iVjPos/LJ17lAhvGSMXzVjc01TQxL+s
   A2wKschdh2pfG1hmERz2ew5ffLj0eDV6JGmau7tBHsFrLXZt+AAzAZT5/
   TYfWfR1YDdWq/r63WTZlhCeVxIh9QVwUGnkvqY1HtE2b9U6btneWUoEqW
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="asc'?scan'208";a="233760148"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2023 00:09:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Jul 2023 00:09:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 5 Jul 2023 00:09:02 -0700
Date:   Wed, 5 Jul 2023 08:08:32 +0100
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
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
Message-ID: <20230705-gooey-humbly-577dcaf96f15@wendy>
References: <20230704084611.071971014@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8S+27JBDQu4Xdzlx"
Content-Disposition: inline
In-Reply-To: <20230704084611.071971014@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8S+27JBDQu4Xdzlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2023 at 09:48:32AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--8S+27JBDQu4Xdzlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKUW7AAKCRB4tDGHoIJi
0kRsAQDYn61LoLb5rgpRz8Dwk5BMGeutZ/4yn9PalgqRWBtTlQEAzMLHnPhPh9iI
V0RmRcbfLdARjkll6t4SyT7zGCJlDgQ=
=qSlY
-----END PGP SIGNATURE-----

--8S+27JBDQu4Xdzlx--
