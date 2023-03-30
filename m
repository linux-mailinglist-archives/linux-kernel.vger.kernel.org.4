Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BFB6CFF80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC3JMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC3JMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:12:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE67AAB;
        Thu, 30 Mar 2023 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680167531; x=1711703531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ro+17oDK7rnlBrMsXFzotd23YydUQ9691qY+Ptq0G7I=;
  b=tVyVk0/LVO0WPg+UwKLeKbN1fDkacYdBN5JyjboazW3UTiUs5i7/+LDn
   eAl2qdeKqrpNpAn6dAviszNpc+ZWWsG+dh0yYFiggnb535NyhTIRntZ3B
   5wgtihHx2ZpluAMTqzk1+vGrw4iS8FBopA/CSj0VY5e43lyoX3z5BD80s
   CK4ZtsJ3/fFvq6su9xfh5KQIIsn1J0xnjgDcYvm0N+Yvx1sxFQo6uza4D
   ZaRdHPcUAiYw767tG9YFxUuqu7VK1NXEjHWLSdL6eAbxIHOX/QYt9BE2g
   lV0+8wN+XwPjZsM2AV6R4KvzAd9Zi1ILL7xZslXCKOenCmTKpC2DroZpY
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="asc'?scan'208";a="218661930"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 02:12:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 02:12:10 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 02:12:07 -0700
Date:   Thu, 30 Mar 2023 10:11:53 +0100
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
Message-ID: <b5fba6b3-177c-4325-905a-8f9f633a592a@spud>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com>
 <a6220e52-9934-422b-9b05-95705b8fd684@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3sMGWrE3WbodPTsC"
Content-Disposition: inline
In-Reply-To: <a6220e52-9934-422b-9b05-95705b8fd684@spud>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3sMGWrE3WbodPTsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 09:23:45AM +0100, Conor Dooley wrote:
> On Tue, Mar 07, 2023 at 12:07:29PM +0100, Miguel Ojeda wrote:

> > By the way, like for the Arm patch set, if you end up doing a v2,
> > could you please add the `BINDGEN_TARGET_*` in `rust/Makefile` (GCC
> > builds are really experimental, but since they are there anyway, it is
> > best to be consistent and add it).

Hmm, so I came across this commit while looking at that:
https://github.com/Rust-for-Linux/linux/commit/cfc17fed52b9585e2f19e2381bfb7094561b8027a
(rust: bindgen: ignore RISC-V extensions for GCC builds)

I don't want to add even more workarounds for this sort of thing,
especially as in this case it is outside of arch/riscv.
The extension stuff when mixing compilers is such a massive pain & given
this one requires Rust it's even less likely to be tested when someone
comes along and adds some additional extension support that appears in
-march :(

I'd rather do this in the RISC-V Makefile so that it does not get
forgotten.

If my understanding of bindgen is correct, we don't actually need to be
honest to it about what extensions the rest of the kernel is compiled
with, only make sure that it is not called with arguments it does not
understand?

| bindgen_c_flags_patsubst1 = $(patsubst -march=rv%_zicbom,-march=rv%,$(bindgen_c_flags_patsubst2))

This one is no longer needed as of 9a5c09dd9701 ("Merge patch series
"Remove toolchain dependencies for Zicbom"").

| bindgen_c_flags_patsubst  = $(patsubst -march=rv%_zicsr_zifencei,-march=rv%,$(bindgen_c_flags_patsubst1))

Oh and clang-17 is going to support both of these, and Nathan and I
already spent a bunch of time fixing the fallout from that!
It still functions correctly without having them passed, but I have
heard requiring these may become the default at some point too.
What's done here may end up needing to be dynamic, but that bridge can be
crossed if/when we come to it.

What version of GCC do I need to replicate this? I can build tip-of-tree
gcc if needs be.

Cheers,
Conor.

--3sMGWrE3WbodPTsC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCVSWQAKCRB4tDGHoIJi
0qpsAQD93N6ZELaSuCLnFRRrVX6KqM1buvhJrxpnIPixxEBkYgEAtdX2bVK2gcK0
Nb8PM/km+TWTR+ljihbHfIH7vEsl0AE=
=NGwF
-----END PGP SIGNATURE-----

--3sMGWrE3WbodPTsC--
