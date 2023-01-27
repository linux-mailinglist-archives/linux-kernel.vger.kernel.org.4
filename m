Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553167E2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjA0LNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjA0LNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:13:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94E13514;
        Fri, 27 Jan 2023 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674818032; x=1706354032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=no1En9x29CtZ9fZVT34CIJmSYilJ9YDPJ3JKw7YN+O4=;
  b=nGNoX0K2s0d8yuFkfiucsWdFXSzp/uyHSp2kK2x/x6OH4BpTLUAvKcfr
   C/dSZ+m78b9+FSOd1/NHfiVyIgK6Ag42PUEcrKKR39RruyA60/E0KaGPe
   Sk2DIXd6y4k6tbM3f0ka9eaoHzY8bzgXHIJxuSQAEpYbGcf9PU3vGSBFo
   NFzMWpBL951RzSDw4e8qbmtwt82aAoBRPW9sUAo79W4lz//FfKwuEmO9w
   B98RzG7wwN4Ti4o2QRheEmIew4D6pXBRufzfl3eRuNEOd7f1vE5ydWSpC
   sE96nwKbjz2ZXbKN0pf/g7uyqm8AMkxYamoB6KgMy8Tz0dTWiVdm9nZLK
   A==;
X-IronPort-AV: E=Sophos;i="5.97,250,1669100400"; 
   d="asc'?scan'208";a="194133952"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2023 04:13:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 04:13:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 27 Jan 2023 04:13:44 -0700
Date:   Fri, 27 Jan 2023 11:13:20 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Olivia Mackall <olivia@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] hwrng: starfive - Enable compile testing
Message-ID: <Y9Ox0M3fW7Lqr2P6@wendy>
References: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
 <20230117015445.32500-3-jiajie.ho@starfivetech.com>
 <Y9OveVKTkX8cRhyP@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EPnwagEDOKKyRmai"
Content-Disposition: inline
In-Reply-To: <Y9OveVKTkX8cRhyP@gondor.apana.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EPnwagEDOKKyRmai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2023 at 07:03:21PM +0800, Herbert Xu wrote:
> Enable compile testing for jh7110.  Also remove the dependency on
> HW_RANDOM.

Checked, the latter is because the whole menu is wrapped in a if
HW_RANDOM, so seems fair to me!
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--EPnwagEDOKKyRmai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9OxwgAKCRB4tDGHoIJi
0rz1APsH+L8iRJIRtnC9eGhBl+yL7xG/S/IqVBLiqtq+xLZvEQEA+dihIHwbCj/K
rFMXj7DUd8lIg/MTF7MeyTkdQzvT2QM=
=83bB
-----END PGP SIGNATURE-----

--EPnwagEDOKKyRmai--
