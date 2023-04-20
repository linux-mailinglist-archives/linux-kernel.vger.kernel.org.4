Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739606E93FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjDTMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjDTMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:14:28 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEB55B4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:14:17 -0700 (PDT)
Date:   Thu, 20 Apr 2023 12:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1681992852; x=1682252052;
        bh=6HI9Qpf9JvUgsdsugSwS3c85xCsDCf6u50n2x19sraE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kCAIXBwKkjOHkHJlq7Tr9HMaNEzDeFiigD8664y/+xYRIJL52h7bL8zrU0A4ZvPAs
         sJPH7eq5XV/sXC6l7ZhlCUeJfCg/f3UNV0XIKrHVYZpAo6AdmoMIG/d6zIqeMaGtAh
         pT8AJ9NezEutaeKe/BOUsgZbdP3bF9E0HtNUwRVPLfhL9zHjmDKp0FroiwVWK8kKm4
         9zc3i8Vj7rs6vS7kxqI3P2XuavW88od4alo7wfEHto8o5mXhTFezvffC07DPo+GMn+
         i1i82YZqNTOo67Bz3E4mYVZkDw8pP/h33/sjSPw11ibv+dWoAbEX9WaN3YyHCB8WW9
         bw8FV4nq01Qlw==
To:     Miguel Ojeda <ojeda@kernel.org>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: alloc: clarify what is the upstream version
Message-ID: <xpeiYudZe3PTRA9hBOt1xOt0lnD4q-fRlnSG1swbdtX23aZ2aFZNNrPlGNSJfWFbKv0soUz1m6rDJMj2vXWnJbu_oox_hwLOhbWEAsDldUs=@protonmail.com>
In-Reply-To: <20230418214347.324156-2-ojeda@kernel.org>
References: <20230418214347.324156-1-ojeda@kernel.org> <20230418214347.324156-2-ojeda@kernel.org>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 18th, 2023 at 23:43, Miguel Ojeda <ojeda@kernel.org> wrot=
e:

> It may be unclear for readers which upstream Rust version these files
> are based on. They may be unaware that they are intended to match the
> minimum (and only, so far) supported version of Rust in the kernel.
>=20
> Thus clarify it.
>=20
> Signed-off-by: Miguel Ojeda ojeda@kernel.org

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

>=20
> ---
>  rust/alloc/README.md | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/rust/alloc/README.md b/rust/alloc/README.md
> index c89c753720b5..eb6f22e94ebf 100644
> --- a/rust/alloc/README.md
> +++ b/rust/alloc/README.md
> @@ -10,6 +10,9 @@ upstream. In general, only additions should be performe=
d (e.g. new
>  methods). Eventually, changes should make it into upstream so that,
>  at some point, this fork can be dropped from the kernel tree.
>=20
> +The Rust upstream version on top of which these files are based matches
> +the output of `scripts/min-tool-version.sh rustc`.
> +
>=20
>  ## Rationale
>=20
> --
> 2.40.0
