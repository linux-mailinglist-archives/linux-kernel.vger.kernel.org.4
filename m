Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38F74ECFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGKLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGKLjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:39:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFE112F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689075549; x=1720611549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVVsS6wun/m2iHEQBE7o95Tjhy9U3B1DpVXbtTxW4os=;
  b=hXO25d0N4X4LKMKOKA4gxFgYG9NugRV7XZoNN+4udUTaIWvuGi5wxzgD
   FwEMiDIPTeHF29GB6WkBePlYn4Ynp+sFh3n69O+46TlKGFLUtSVUXiWiP
   uQhNUB6JAWPOcK96uOcxYscPj7vM3wwUkgtqZRsAmYDTMwYWPz5cOTwKA
   BbTg+3a5gQ4rYpPIze/en16Jz5+WhPZ19SXs3Bd9q1jxvQwvUJsZyLBx1
   CtvQ7UnaOAn8/LaUemXDCJ89aXRd7jrAgZ32NwIfpBENfUShHbVpkpv4M
   Kkn0NtuuRWsKx7KDIL8D8MPHX46PeUcvurQDE7YhYpUVE/mMjAoiJR5Gg
   g==;
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="asc'?scan'208";a="234816665"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2023 04:39:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Jul 2023 04:39:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Jul 2023 04:39:06 -0700
Date:   Tue, 11 Jul 2023 12:38:34 +0100
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
Message-ID: <20230711-dab-imaging-2124096a7b3b@wendy>
References: <20230710131902.1459180-1-apatel@ventanamicro.com>
 <20230711-remission-from-581829b1ff05@wendy>
 <CAK9=C2XG9fsvUxnL98gKstxdpdOOAV3UZ3DAV66=S4DJcutzKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="th+QX7GWLadOiiRn"
Content-Disposition: inline
In-Reply-To: <CAK9=C2XG9fsvUxnL98gKstxdpdOOAV3UZ3DAV66=S4DJcutzKQ@mail.gmail.com>
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

--th+QX7GWLadOiiRn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:07:11PM +0530, Anup Patel wrote:
> On Tue, Jul 11, 2023 at 4:51=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:

> > Other than wondering why you opted for 450 (curiosity really), this
> > stuff looks fine to me.
>=20
> It is the same as the rating for clock_event_device used by ARM arch time=
r.

That's what I figured, thanks!

--th+QX7GWLadOiiRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK0/OgAKCRB4tDGHoIJi
0sryAQDPy8c7d4yVTO4UXMI9onT2ENWGMKOpCA0/OBGnIgyYugEAuOIkqZ7wTz/b
IsE+VFynbx5ptjZaWV6ND4UaTlJn3go=
=ByLl
-----END PGP SIGNATURE-----

--th+QX7GWLadOiiRn--
