Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8C74EC86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGKLVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGKLVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:21:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AC120
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689074479; x=1720610479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtwdLSiym59o1DrznC492yD2dJ/cAL9RGvqKk4h6Y+A=;
  b=GwuWbc+M+DVuWld8f96tEQ3ILBlyGOZ+0G220wac1sPoxGsOySWMw1Q9
   XuG2WxPPC2jILB0wz3mKB7a84tVr6EuB/DwOW8a634eUjpMaCUT4HKkAR
   fNDmzajmZCrZYvmQ+eQ5hlzNayDciXmp8J77IjcbS5wbJfOmkWl5bcdIH
   A4PPpgGNEnm5Tc6GYUOWQBaO+Wnq6a/cYcWaTzKsq2xkmU9ymwbgkRIFr
   OpPpir4K/akOfDi3oiPckq8fmZC814KqHStvhMKfvxQdeUUgmo4g1UA3U
   CPTH4wZmmi0XeQ7NVBe03mvqBG67st8vIKVD5O98iIPGfpGMmo605S1gh
   g==;
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="asc'?scan'208";a="223099167"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2023 04:21:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Jul 2023 04:21:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Jul 2023 04:21:15 -0700
Date:   Tue, 11 Jul 2023 12:20:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Misc RISC-V timer driver improvements
Message-ID: <20230711-remission-from-581829b1ff05@wendy>
References: <20230710131902.1459180-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pOCE+3HdPQhgGlY6"
Content-Disposition: inline
In-Reply-To: <20230710131902.1459180-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pOCE+3HdPQhgGlY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 06:49:00PM +0530, Anup Patel wrote:
> This series does two improvements to the RISC-V timer driver:
> 1) Keep timer interrupt enable state in-sync with interrupt subsystem
> 2) Increase rating of clock event device when Sstc is available
>=20
> These patches can also be found in the riscv_timer_imp_v1 branch at:
> https://github.com/avpatel/linux.git

Other than wondering why you opted for 450 (curiosity really), this
stuff looks fine to me.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--pOCE+3HdPQhgGlY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK07CwAKCRB4tDGHoIJi
0j7pAQCJ35VuI5FCicsChC20YXbYXFS71ClF3UbO+6hIao19zwEAork915p5cLPc
U/+WO9wBead32JpGTrl+GduNOhTD0wg=
=i+Kq
-----END PGP SIGNATURE-----

--pOCE+3HdPQhgGlY6--
