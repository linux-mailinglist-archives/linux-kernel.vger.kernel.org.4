Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD406F5679
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjECKpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjECKpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:45:13 -0400
X-Greylist: delayed 615 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 03:45:09 PDT
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B649DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:45:09 -0700 (PDT)
Date:   Wed, 03 May 2023 10:45:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1683110708; x=1683369908;
        bh=SJENI6Xn7thgyOwQEG5tYhCtG+qo2jUnMSGkLldh2PU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=OSdko56aHCHeMD/cu7G6Z6q+PGNmNm3IEp5v54rcYBL+2WXSzYLluEkhtWVezjrVo
         tBKmYOZw2GVZCf/+xXNmaJA+sQbvL9M+E7lCd1zBGWC8qbgrXZt/Us7lUSUwZxu+hH
         by3Z9TUgmGS7DT1RrcANiDXxOP40mJe67u5k5a7PlSDNXbxVGeoIMRCDiN7T5935GO
         9puy2NEejbCxlkbVlgPE6dW9Azi4ZqFL/TqkRfzwjc9ben0a4OJ2JzfJeria7RjUup
         uRcxEvsLYnuOAMjAMVYe8U8NPVglMeeI4TfG6tfi8+BuwCzW/BL9fDJtV1sLEFssmU
         d0ScU0FDE2/Ww==
To:     materoy@proton.me
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: bindings: fix sorting of rust/bindings/bindings_helper.h's #includes
Message-ID: <dIXozfBEyCqYQ9-l0IgxfaoL6paYc_6NjXMxHp3qUqAxQdF-c5qRoULMp4K_Lv4bCOPRez2c_4v4PuFKMysFxhNkK2r1t0grU89YosKzTbE=@proton.me>
In-Reply-To: <20230426224748.34056-1-materoy@proton.me>
References: <20230426224748.34056-1-materoy@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.23 00:57, materoy@proton.me wrote:
> From: Roy Matero <materoy@proton.me>
>=20
> Fix sorting of rust/bindings/binding_helper.h's includes,
> to maintain consistency and rust idoms
>=20
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1002
>=20
> Signed-off-by: Roy Matero <materoy@proton.me>

A couple of nits for the commit message (these can be
applied by Miguel when picking the patch, if he agrees):
- capitalize 'Rust',
- add a `.` at the end,
- remove the newline between the tags.

I am not sure if the tags at the end should be sorted in any
way.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/bindings/bindings_helper.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 50e7a76d5455..dc8d97272e71 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,10 +6,10 @@
>    * Sorted alphabetically.
>    */
>=20
> -#include <linux/slab.h>
>   #include <linux/refcount.h>
> -#include <linux/wait.h>
>   #include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
>=20
>   /* `bindgen` gets confused at certain things. */
>   const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
> --
> 2.40.1
>=20

--=20
Cheers,
Benno
