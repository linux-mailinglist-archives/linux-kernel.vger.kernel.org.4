Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937687092F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjESJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjESJY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:24:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DC192;
        Fri, 19 May 2023 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684488296; x=1716024296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=87nQKBC592NwT/Pd0f8zSjxOqvt3PLjwDId4OLffKFI=;
  b=XRPiAjvzIOzxyGjfcTuA2BcxukSdcSCrATlmqMIeFbSRc5idUWxIVwU4
   eU8+HxE6hzdurNrp6PweDpla/Ef/nTAF8a+bWpk3usMq0SvPM/o0sRtNY
   qKuSJQrfvF/eG7CGD+eRd+JMbezMajfU6JFbnaDyXZeqQ8oi195pe0O3X
   okxwMQGImkGl5GxYRMEiF9yTNsdWLJ5PQaD9TlDjL0IUXVcWD4vtIUL3E
   1D05xr8geagRYa9/Y9niMs71eFgua7KZcIbfDHaMVJ/qouxjFTdYUHrob
   C0D8h7sHNWfYmf+cpLnwLhzYuCwy7zrfLJGw9TrnAEIR3mPRIwtKcAlFP
   A==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="216277062"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 02:24:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 02:24:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 02:24:49 -0700
Date:   Fri, 19 May 2023 10:24:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 0/4] crypto: starfive - Add drivers for crypto engine
Message-ID: <20230519-moodiness-backtalk-cc838c53e8b1@wendy>
References: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
 <ZGc4Wv0SU59dyVWV@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RwB4AI2nEmrRJqxz"
Content-Disposition: inline
In-Reply-To: <ZGc4Wv0SU59dyVWV@gondor.apana.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RwB4AI2nEmrRJqxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Herbert,

On Fri, May 19, 2023 at 04:50:34PM +0800, Herbert Xu wrote:
> On Mon, May 15, 2023 at 08:53:51PM +0800, Jia Jie Ho wrote:
> > Jia Jie Ho (4):
> >   dt-bindings: crypto: Add StarFive crypto module
> >   crypto: starfive - Add crypto engine support
> >   riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
> >   crypto: starfive - Add hash and HMAC support

> All applied.  Thanks.

Can you drop the ea1aeba1b2e07b82f9eb7cce5cb169263a77d046 ("riscv: dts:
starfive: Add crypto and DMA node for VisionFive 2") please?
It depends on a clock node that has not been added to the dts yet, and
will break the dtb build:

Error: arch/riscv/boot/dts/starfive/jh7110.dtsi:505.22-23 syntax error
FATAL ERROR: Unable to parse input tree

Thanks,
Conor.

--RwB4AI2nEmrRJqxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGdATAAKCRB4tDGHoIJi
0tV4AP92cgUZfovlR07D11TLWvkZwuwwMjQ9l65227nnLEVvLgD9EmRW1kdZlybf
g9B4AdQr2KFmz9cAGuJErpHMqGrWqAk=
=ex4d
-----END PGP SIGNATURE-----

--RwB4AI2nEmrRJqxz--
