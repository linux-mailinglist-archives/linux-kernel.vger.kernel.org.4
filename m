Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5A70C0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjEVOVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjEVOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:21:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C2A3;
        Mon, 22 May 2023 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684765275; x=1716301275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6B3vXaIvsSyFL8WRgXEifU405baar89aaaU3DZ4ZCOI=;
  b=mGvWkExU3V9X5YXgrwcg55GUliJbIRwAmVPVlPLVEB6wE4CiIFuON4xP
   9ddGNgwu/QIZt5XAlwNSDN+OLFl62wrciMia9Y7VhjhZY6SVFS8MWPwdH
   l31eKr5NB3AVJt5vkCrMDx9ucVHLyDzhh3nIe7PXfHxfFDWx/P7tjJupm
   6lMrrOC8GWnMO4e2/OA0zMPlXR4ncyZQH+/jh0Q69CvKX/ANxne712XpE
   IYbn90Y2ddt00/1fJWMeLQp4yJzPz6QFtBflleWXtD6LMF+mGHVDlg5nY
   HJRVEQ66jphxVA0njyazL+WGOMYtSOr2bZhj1daoWwaUTQXiiNjnsUg8N
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="asc'?scan'208";a="212478960"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 07:21:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 07:21:09 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 07:21:07 -0700
Date:   Mon, 22 May 2023 15:20:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 2/4] crypto: starfive - Add crypto engine support
Message-ID: <20230522-darkish-undaunted-9e184932d93f@wendy>
References: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
 <20230515125355.624250-3-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dVy3OAxHoIQI9VdR"
Content-Disposition: inline
In-Reply-To: <20230515125355.624250-3-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dVy3OAxHoIQI9VdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 08:53:53PM +0800, Jia Jie Ho wrote:
> +config CRYPTO_DEV_JH7110
> +	tristate "StarFive JH7110 cryptographic engine driver"
> +	depends on SOC_STARFIVE || COMPILE_TEST
> +	select CRYPTO_ENGINE
> +	select ARM_AMBA

I have yet to bisect, but I think this has broken the build on RISC-V:
drivers/dma/pl330.c:1053:13: error: redefinition of '_start' as different kind of symbol
static bool _start(struct pl330_thread *thrd)
            ^
arch/riscv/include/asm/sections.h:11:13: note: previous definition is here
extern char _start[];
            ^
drivers/dma/pl330.c:1705:10: error: called object type 'char[]' is not a function or function pointer
                        _start(thrd);
                        ~~~~~~^
drivers/dma/pl330.c:2092:9: error: called object type 'char[]' is not a function or function pointer
                _start(pch->thread);
                ~~~~~~^
drivers/dma/pl330.c:2110:11: error: called object type 'char[]' is not a function or function pointer
                                _start(pch->thread);
                                ~~~~~~^
4 errors generated.

The pl330 dma driver depends on ARM_AMBA.

Cheers,
Conor.


--dVy3OAxHoIQI9VdR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGt6PQAKCRB4tDGHoIJi
0mpoAP9RDzkFAWWLnCRZfm4XNQ+rF1nl5k6lvaz5slDTFQKPAgD9HeBaio8Z6lrR
D2oRKJK24+1MMfPI4S824JdtjnZOIw0=
=Y2QR
-----END PGP SIGNATURE-----

--dVy3OAxHoIQI9VdR--
