Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372436C11F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjCTMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCTMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:34:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A7D19F38
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679315658; x=1710851658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcnN2qGl2Pur4dc2QuLgMq8NqxxsuBO2ZuAmWpHomJ0=;
  b=Xrx/63RsAGjEQTzndBwrzRAFZqOTbOwwvpjBiBmG2Qku/fp63cm92kX6
   Ig6AihtLQYcNOwCqLu6wahrUhz/IvN8OXtPQUK/BPUVfC1DZFXGyMnz9x
   FPsXtOaJa03SYVO3fecvYzBFgS/+VuWEYNB1hPm8Jl8r0O48WBcvE9uyA
   QS09DxxrQMl35NisbYARjrGK6QqoDrPLJQvsML4KqGz7GDKvXBbAt9v/n
   M13E7nfPyN9/ASx5ByhhBrtZ2wIF2k0yrcmG3k8nROPRCTuhWWgPOWQB4
   hLi1yXzxCKnG+sD9kHlpDDAd2omKlC7fBWBqw3Nj9Wl6BRGxJUjwK2dZZ
   w==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673938800"; 
   d="asc'?scan'208";a="205505745"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Mar 2023 05:34:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 05:34:18 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 20 Mar 2023 05:34:16 -0700
Date:   Mon, 20 Mar 2023 12:33:46 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 0/4] RISC-V Hibernation Support
Message-ID: <d7588d2b-882c-4d9c-b2c8-228db57f56cc@spud>
References: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
 <1a2b03d49ce1440b9e50ca8a13320782@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HaYFqWzWKiEzet2y"
Content-Disposition: inline
In-Reply-To: <1a2b03d49ce1440b9e50ca8a13320782@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HaYFqWzWKiEzet2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 07:20:58AM +0000, JeeHeng Sia wrote:
> Hi,
>=20
> I understand that you must be extremely busy, but I was wondering if
> there are any comments for the below v6 patch series?

> > -----Original Message-----
> > Sent: Tuesday, March 14, 2023 1:03 PM

It's not even been a week chief, relax :)


--HaYFqWzWKiEzet2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBhSqgAKCRB4tDGHoIJi
0isRAQC8xqECPojT7k8KLP/g0gxIKh0GbuzK/rus2SdRX/7gxAEA4fdVWWR7jRBN
8UJBhDFoCHdK5+6jjdAwESpbv+bUzwI=
=4n11
-----END PGP SIGNATURE-----

--HaYFqWzWKiEzet2y--
