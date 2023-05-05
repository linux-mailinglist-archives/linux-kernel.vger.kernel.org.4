Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC186F7CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjEEGaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjEEGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:30:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFACA156AC;
        Thu,  4 May 2023 23:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683268201; x=1714804201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qc7fG6VouXbKbHHlRomViVIdE9mWho9KSNjrEuBZBgs=;
  b=yIUPXA9zJvXm5RxPirwA9tYAvqyb9dVoCXO9XxT+j0k7rupUCRxx3pUd
   HZ+3z0RuGGW4GbsI7OEy5xxrMZOfpcpfsylB5hEtgkw/m/BSf5WHjAjI+
   xLBzQHWMMvSmbegQHqAOrOwW0lIrEdE8N20PZtllaZYUzkGIk4Qs7N4+s
   Ykb6jwF7vMes7AImZzuK4k++WHCVILy/vymWOxgKCgiGEgQrSuc6xsXTe
   chcCIiY2FpZ91HFqupf4WoDNmG+hn1a4SOkBYCIg2pqI2QlCiI/TGZkEa
   6Ai1LIaexPKhcDI8agHh5frlIkM6mKUFMqDhScxUqLB6eP8pYe/c6OnXm
   A==;
X-IronPort-AV: E=Sophos;i="5.99,251,1677567600"; 
   d="asc'?scan'208";a="223952954"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2023 23:30:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 4 May 2023 23:30:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 4 May 2023 23:29:57 -0700
Date:   Fri, 5 May 2023 07:29:38 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mason Huo <mason.huo@starfivetech.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/3] Add JH7110 cpufreq support
Message-ID: <20230505-gusty-corset-e451d947c10d@wendy>
References: <20230421031431.23010-1-mason.huo@starfivetech.com>
 <457c35b5-aec4-1147-673f-947052b5f944@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PSNHXBMMJYphhDWy"
Content-Disposition: inline
In-Reply-To: <457c35b5-aec4-1147-673f-947052b5f944@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PSNHXBMMJYphhDWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 09:38:38AM +0800, Mason Huo wrote:
> Hi Conor & Shengyu,
>=20
> Thanks for your review, and is there any comments about these v3 patches?

Firstly there appears to have been some mess-up with the driver/bindings
for 1/3, so I am waiting to see if the binding gets reverted before
doing anything and secondly it's the merge window so I can't do anything
about 3/3 until next week.

Cheers,
Conor.

--PSNHXBMMJYphhDWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFSiRgAKCRB4tDGHoIJi
0r5hAP0YWltPpwr1izMQlhksHrJ1Nsu+nh7ZltEKQl+EUT7mZwD+Nja7QwXhJfN8
PS+uHl3ESNKd2rWmiwAV2HVtGWwC7gw=
=N0Ys
-----END PGP SIGNATURE-----

--PSNHXBMMJYphhDWy--
