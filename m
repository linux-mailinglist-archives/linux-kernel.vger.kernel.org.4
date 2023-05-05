Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF196F831D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjEEMjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjEEMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:38:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA81CFF2;
        Fri,  5 May 2023 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683290338; x=1714826338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8xaX52aaPvTWMjYeqa0TqYNGO9iqMeWfTGMQ8/3Jsag=;
  b=YzRd0Kb6GY9xNP/hRdU9DU6kfOfEMmTWZs+5OmCGG7t/qI1rc2SJDoPt
   iMGq+yYiMV4sUN1vooydLwjGd/4NN/JojdhZgtkN40D7YysPmOx+o7bCg
   AylHbVw1tlqZ0E78XQ6S1pdjWuTgchDE/R7c/D2qVx4i/mpPcG5mXLRcy
   nPRY3HISuVLEb9vmkjGHPmuHjmE/hk4Q61gAAx52bmXcffIfv6ds8Xt27
   t+dqcpDh2CMfhuPt+6DgGRcbliAVoJOyDh+aAUafivBNjZwlplTlJNuTt
   /Dci2+pGaQAlU+GqFgjZxzTsmjiwmr8K6BDXcsFUnZUQaWrYrHp2qJRhY
   A==;
X-IronPort-AV: E=Sophos;i="5.99,252,1677567600"; 
   d="asc'?scan'208";a="223989201"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 05:38:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 05:38:57 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 05:38:55 -0700
Date:   Fri, 5 May 2023 13:38:36 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <vkoul@kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230505-magician-poet-724c96020c2f@wendy>
References: <3ed72340-accc-4ad1-098f-4a2eb6448828@linaro.org>
 <482e812a-05dd-105c-189c-e926b4be9d28@starfivetech.com>
 <089e24d1-588a-4a56-f00b-0b35d1d99295@linaro.org>
 <ea5b5534-8fc2-7c84-a011-c1b42c6ed7a0@starfivetech.com>
 <1ac26c1a-1726-515d-6598-849a07ed0b86@linaro.org>
 <5adda0ad-965c-fbf0-878c-9d41d28b5c39@starfivetech.com>
 <86693969-59bf-5bcc-42a3-b6e94a0d6f3e@linaro.org>
 <fcfc8ba4-40a7-da43-3375-712bd7e7f4d5@starfivetech.com>
 <20230504-worshiper-ongoing-5581e1f2c2c4@wendy>
 <2f473307-2219-61a4-fa66-5848fe566cf0@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="joHxcNEPtN2DDJ9p"
Content-Disposition: inline
In-Reply-To: <2f473307-2219-61a4-fa66-5848fe566cf0@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--joHxcNEPtN2DDJ9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 05, 2023 at 09:29:15AM +0800, Changhuang Liang wrote:

> But if keep this "starfive,jh7110-aon-syscon" compatible. Which .yaml match to
> it? Use this series dt-bindings or syscon series dt-bindings.

There is no syscon series anymore, it's part of the PLL series now:
https://lore.kernel.org/linux-clk/20230414024157.53203-1-xingyu.wu@starfivetech.com/

I don't really care what you, Walker & Xingyu decide to do, but add the
binding in one series in a complete form. It's far less confusing to
have only have one version of the binding on the go at once.

Thanks,
Conor.


--joHxcNEPtN2DDJ9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFT4zAAKCRB4tDGHoIJi
0j7sAQC3yBu80qw2HVfxwCss7YeMwglVk3XoMJwU5Edb0+UMYwD/TodA8cpmhYbt
lWKK0yqBI6MEjCP3wB/OBKkdc3DOeQI=
=SIb4
-----END PGP SIGNATURE-----

--joHxcNEPtN2DDJ9p--
