Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C0727FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjFHM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFHM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:28:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2F26B0;
        Thu,  8 Jun 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686227322; x=1717763322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D3eGuNa1+BoSZIrVhFPmuw0PAOKIN8uK8gmRTqHfLG4=;
  b=esVpqYHHgx5kpOfYhZ9Mf2DbbVPU0TwLUQaqB68pCrEYa5aj9NJUppYj
   SoR4pMDc989qcqcbvuJu20j+1kLMIVdOw867bP8VIIbMJpTuT3icTOf3w
   Xk6kJdL9M19yZKrcEX7NwAZtECza5asr1sRg015OKO7YtGioZS4niq4jV
   q1SZFOgu6MQPuO0hBvO24/2OqhOoqhH93ZqHg2a/ZWYP+EQeLA1ztZeAi
   9hkByaA/KTt4sKrRyhe+91c4+D1kvo2usJCU9CXoPJWKazFenisEbmY1/
   2OxWpn9hpdEUc7dnFUGqTXNuAXZYmN3GK4JivOEgeHYroA3qQocyxwZ3f
   A==;
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="asc'?scan'208";a="219411820"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2023 05:28:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 8 Jun 2023 05:28:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 8 Jun 2023 05:28:30 -0700
Date:   Thu, 8 Jun 2023 13:28:06 +0100
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
Message-ID: <20230608-spiritism-gonad-5f5aff4c3a24@wendy>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
 <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HEkduUF7a/Zaoz5V"
Content-Disposition: inline
In-Reply-To: <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HEkduUF7a/Zaoz5V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 01:52:47PM +0200, Miguel Ojeda wrote:
> On Thu, Jun 8, 2023 at 9:01=E2=80=AFAM Conor Dooley <conor.dooley@microch=
ip.com> wrote:
> >
> > I do intend revisting this, probably after the min. version for rust
> > gets bumped, I've just been really busy with other work the last weeks.
>=20
> Thanks Conor! That would be great. We are increasing the minimum
> version after the merge window to Rust 1.70.0 (assuming no unexpected
> issues).

Right, so probably I won't resubmit anything until after v6.6 then,
as it won't be in the RISC-V tree until then, by the sounds of your
timeline.
Gives me plenty of time to try and unravel the mess of libclang versions
and what extensions are supported by each tool. Not like I am devoid of
other things that need to be done!


--HEkduUF7a/Zaoz5V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIHJVgAKCRB4tDGHoIJi
0ikSAP9vwx3IhwT2YQBx4VTPuAhBIV9NLradoYYCFXuEPhuj0QD/TlPI2RbulZ9K
uWEHPxTMU46fCeYmbOUy5I7dtUUEwgg=
=ram8
-----END PGP SIGNATURE-----

--HEkduUF7a/Zaoz5V--
