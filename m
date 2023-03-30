Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B96CFE30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjC3IYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjC3IYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:24:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90440EB;
        Thu, 30 Mar 2023 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680164643; x=1711700643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SBoEmEO7Dj8b7NzG7TSXvuV5ruIHbv+zWUEtKVANFTE=;
  b=SFRBen89IOz4UM2WOTouzvEBLOT3JzGCc95ze561lmGjwRXCZmk08xGF
   Ia+hhOi8j0XAzQQkJXEp6hjigNhHdX++oaU80FbQwKdHct1CGhoI6cNp7
   xRfcjQRP+ojvf7hMFL0HPQS3Dc4g87yrF6xi64VhdkBvnsujfeXOdbGJE
   sml3OpPaROb99qZ0i1i66ooYRJ9yIcxIovNB31RaOPLaNYIQ45WJ3kt2k
   cBXvo+4F5hQxnBs7lUXzrYaIMfdTG4g5zqcGfRJRXf1RAJ3W2XToL3fCQ
   ykpG1EintgJKaNH6PujsiTK5ek5tsFk0n/bur0laexSXgZOuw79nfu3iU
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="asc'?scan'208";a="204161151"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 01:24:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 01:24:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 01:23:58 -0700
Date:   Thu, 30 Mar 2023 09:23:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <conor@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <rust-for-linux@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <a6220e52-9934-422b-9b05-95705b8fd684@spud>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YyN1dM7SJNHGwojV"
Content-Disposition: inline
In-Reply-To: <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--YyN1dM7SJNHGwojV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 12:07:29PM +0100, Miguel Ojeda wrote:
> On Tue, Mar 7, 2023 at 11:25=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > I have added SoB's too, but if that is not okay Gary, then please scream
> > loudly.
>=20
> Note that `Co-developed-by`s always go with a `Signed-off-by`s, i.e.
> it is not possible to add just a `Co-developed-by`.

Aye, but that does not mean that I am entitled to add someone else's!

> By the way, like for the Arm patch set, if you end up doing a v2,
> could you please add the `BINDGEN_TARGET_*` in `rust/Makefile` (GCC
> builds are really experimental, but since they are there anyway, it is
> best to be consistent and add it).

Sure.

--YyN1dM7SJNHGwojV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCVHEQAKCRB4tDGHoIJi
0sZQAQCUXauXvBSo3TQBU7zir2CymSgO+QWCV5+jRW9nEMhawAD/bfruWxpKJBpY
m9CRaroRiPS0CZfC4rp/1I2j2aRuSQg=
=eDKb
-----END PGP SIGNATURE-----

--YyN1dM7SJNHGwojV--
