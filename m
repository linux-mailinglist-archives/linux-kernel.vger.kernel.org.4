Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C387C6E74A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjDSIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjDSIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:07:03 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47186A5C7;
        Wed, 19 Apr 2023 01:06:55 -0700 (PDT)
Date:   Wed, 19 Apr 2023 08:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681891613; x=1682150813;
        bh=yDcINe1SSrAuEgU0eu40vrPrEWNwzjnrBuhCZcpXXBs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BhU/Z8WyZmwQMdSHDFz2vgO3Qz7wqusgLY+W616pPHAqVLEgPWdvoryP/1glt08BF
         zGBocVP2O77p7OAc4F0U9m5qSFqj6vnRONGTCu1DnlwRIHgw4auiLAKvxuqBXdzr1h
         pyjH5MJjzNplMpQnmGZd5J9kNZqR2qY3tUMTggzLWbQ6+btgJBKfW067K4sWMqkeV3
         FBPzfrq+/e6swskgoBd0HWYstakK+lQ2UB36nRg0X4eVlyxh5vTKOwdqKR/kBuMVu8
         5vqP425LM6IC4LzZzBJmALn1N40yRUR0NzvhIbw7hQjm7itslZt3dSBGXjYMJvZo7d
         MzMnuwgjMQj4Q==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: alloc: clarify what is the upstream version
Message-ID: <kjzSDs4jT8f4VbiRFjQmaecqRpvv06jDQ3EGFsy0OmT3eNmicJJEqzRp6BZR9YNCu5k3E4ArIzgLOxkR3eYuv-iuuCMwGs4rHJJBg8Y2vR0=@proton.me>
In-Reply-To: <20230418214347.324156-2-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org> <20230418214347.324156-2-ojeda@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.23 23:43, Miguel Ojeda wrote:
> It may be unclear for readers which upstream Rust version these files
> are based on. They may be unaware that they are intended to match the
> minimum (and only, so far) supported version of Rust in the kernel.
>=20
> Thus clarify it.
>=20
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/alloc/README.md | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/rust/alloc/README.md b/rust/alloc/README.md
> index c89c753720b5..eb6f22e94ebf 100644
> --- a/rust/alloc/README.md
> +++ b/rust/alloc/README.md
> @@ -10,6 +10,9 @@ upstream. In general, only additions should be performe=
d (e.g. new
>   methods). Eventually, changes should make it into upstream so that,
>   at some point, this fork can be dropped from the kernel tree.
>=20
> +The Rust upstream version on top of which these files are based matches
> +the output of `scripts/min-tool-version.sh rustc`.
> +
>=20
>   ## Rationale
>=20
> --
> 2.40.0
> 
