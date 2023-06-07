Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78CA7254C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjFGGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbjFGGvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:51:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F21730;
        Tue,  6 Jun 2023 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686120704; x=1717656704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DhWndPpddaoxUPxyEmfRWSwqvWtGZRWshWcQJxBubLM=;
  b=j7QdwPT0HFYLz2X4G6haAJBuKvrQJyzmdzWH/J+f6PBu/peCbkwN+ni3
   XwAhJGLaUslWqNPzfP4bt4DbOMoF1DxnGlvoplyrMRzFfSh3c/6nWlGS7
   98pvE3PU41eQGGuqwYtn5KhZcLu98i7pn9Pupg2cguzr7jbcAyP6uWtCk
   kpdaxtvk+7hugVIoXgz3HT94F4q/jZIcFhOH7ueVOBIuO4xaLv8hnk5hA
   gT35iZcK62sJSTAf/8JPTlW19rssv5TEeTKwYKfHv3Et3poWyckVa0+QE
   bu2VfUnp2UI0CIzNuqWRRIBuq3r7Jt0S/wswEaSiRXGkyj7FUJb5/hheZ
   w==;
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="asc'?scan'208";a="217189778"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2023 23:51:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 6 Jun 2023 23:51:43 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 6 Jun 2023 23:51:40 -0700
Date:   Wed, 7 Jun 2023 07:51:16 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mason Huo <mason.huo@starfivetech.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Message-ID: <20230607-process-spinal-321ccf04d7e6@wendy>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
 <20230606105656.124355-3-mason.huo@starfivetech.com>
 <20230606110804.qns4rolrrj2gku6w@vireshk-i7>
 <20230606-unsmooth-slip-c80fab59c9b4@wendy>
 <f29a14dad3d744bba54e561a050bdfaa@EXMBX067.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PguniYfT8h3J0i0C"
Content-Disposition: inline
In-Reply-To: <f29a14dad3d744bba54e561a050bdfaa@EXMBX067.cuchost.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PguniYfT8h3J0i0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 02:04:37AM +0000, Mason Huo wrote:
> Hi Viresh & Conor,
>=20
> Sorry for the confusion.=20
> Should I re-send the patch series and remove this patch?
> Or you can just ignore it?

I applied the two dts patches yesterday, you shouldn't need to do
anything.

--PguniYfT8h3J0i0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIAo5AAKCRB4tDGHoIJi
0pBVAP4k0GCPxUv/B+QjWRQshcDqTHSTrBRdE0zfT3GoMOfxDwD7B9gQAFoFQrw3
IP3CJDRJ4Wg/8jlq6a5qKq/d/BjOmQs=
=3vSO
-----END PGP SIGNATURE-----

--PguniYfT8h3J0i0C--
