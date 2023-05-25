Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D9710E00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbjEYOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbjEYOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:06:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E7E4B;
        Thu, 25 May 2023 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685023603; x=1716559603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=upPO4QUm0taAdlDSGlmbwceJ4JBD1WN4nd0/HmurPiU=;
  b=UN71+bSlBvm5eO/lGHyIRB87X5WOqMWBzpFzqCA4wpeGg7Njx9QxMFFD
   QUssdn7pMl+7+R4K5fAbibz8gCaKuIIGfQPewfwFJnoqFfvfcKS1k47Dv
   1TbiJpBI05HMsSyKSOwtbJevuNFU2Eho1K+G6joDLHmBBRnUUKXRj0ksB
   FJgCv7WsVb+ZOD5KWD9x4qX/aHD4Iq00Qz52C9O3lWE9TY/PFYXs+v0MF
   UqqvDkW0/4xs8WMd2bfUsWyA2MXwu+wd5EDutFbN4THjBYgaek6wuW5xq
   L+sZ9s9Qj+IN2PcqJsDx2od5T3SjNOUQ7xeqt7dQ3NCf3/IX7hYrXWQbe
   w==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="226989442"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 07:06:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 07:06:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 07:06:37 -0700
Date:   Thu, 25 May 2023 15:06:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor@kernel.org>, <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v16 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
Message-ID: <20230525-ranging-plow-e3f4427f44b3@wendy>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
 <20230523135351.19133-6-ddrokosov@sberdevices.ru>
 <20230525093736.naztwqlhvskujsoa@CAB-WSD-L081021>
 <20230525-connected-skipper-442c6d0b52c1@wendy>
 <20230525140100.mdzuhyfhxxkf4mx7@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98dEgcHdS9y24H6f"
Content-Disposition: inline
In-Reply-To: <20230525140100.mdzuhyfhxxkf4mx7@CAB-WSD-L081021>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--98dEgcHdS9y24H6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 05:01:00PM +0300, Dmitry Rokosov wrote:

> I was unaware of the official policy regarding the removal of RvB during
> renaming changes. I took a cautious approach to the situation :)

Better safe than sorry!


--98dEgcHdS9y24H6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9rVwAKCRB4tDGHoIJi
0qfyAQCEDt2Wmdd7sQ0AFn0qT0m1S6WB+FG53v9IrhD+R5MRiQEAlgl5pqnYxIZ5
1D4vdPj2SIBYSAryBd9N2bDPGtAFTQ0=
=cV7U
-----END PGP SIGNATURE-----

--98dEgcHdS9y24H6f--
