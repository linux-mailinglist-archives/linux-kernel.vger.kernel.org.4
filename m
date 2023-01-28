Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F267F71E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjA1K3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjA1K3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:29:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184138B43;
        Sat, 28 Jan 2023 02:29:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kt14so19841787ejc.3;
        Sat, 28 Jan 2023 02:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68XM5SY6Nwl6N7UzCO83VpbKiluHmqgtg2rk9s+ih1g=;
        b=KRS7AYwNKqscG5OmDKnnwwusx77OIJ8umk6R0C6lgfibo1fGhdgXp9nJMfOJNL7CB2
         Rgk5XIfMWqMGhxj7F0J/uHEPIiXg2qGl3gA9oQ1vEBMc1Fdm/7n2x9yOE4axLAJbmhQu
         u3MiGA4SDpdg0+5i1DGakmv5m+EmxXIniNs007Q9osDaX4yLakBrmqaRHnnXsIg/19Oz
         uBzcFpV82q8DuQyM125iuTlUfLrmHC2tvPhTNxlUHswA/XXC7FOqU7wflzxThlYxGK4D
         FCjXfYIbhLmiuGYo9E3XWxc2MbiGyeal+sMazLSE74yEe38EgvYjhnjU82sVRXsyuS96
         03Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68XM5SY6Nwl6N7UzCO83VpbKiluHmqgtg2rk9s+ih1g=;
        b=Q+Rxdy6jtZVTo3WyXfxmHBt6dnjMRKQ6NoZfvUtdDN7+3CTR5CJ0GsSnzcsl1UG6at
         lxgYsCiJS7M2nzk5kFvsxxWYHHs/b0Q0ln5uIAlDkjanAkq8qCaKQOGtrIn9GhnebLWb
         yA7Xhe7Mh1e9jeImekVCgsuuUGe5EveO3P+2OVan9Ki51U25OdzpbniRxxhRWXlzhdyV
         uf3HfeCEvjg6Caj5pErV94zbdSKhYiH7+h4j0Lyn4dCnZLpfqSXU6LYObsXUhFaOjrD3
         t3JXpBtbo+fY7+nep/+V00QzZvwGMFd1flSGSATQDjYWNDrGLp112hh6FpcvYGD6P1gC
         cFEQ==
X-Gm-Message-State: AFqh2kqlNOHgusSrZ8b2CadRROX1dl0iptC7xdW09VPE9cHgO5INphtL
        Gh3jvVfXvop66bR7r4oepyk=
X-Google-Smtp-Source: AMrXdXvqhBx49ozlQWXTucpdOhfx8lxHknUW2fYC3sPnDAE2usYHRB3hsvL1eJCqReODLm/tt7BJzw==
X-Received: by 2002:a17:907:cb24:b0:872:45d3:dcfa with SMTP id um36-20020a170907cb2400b0087245d3dcfamr41533607ejc.42.1674901747327;
        Sat, 28 Jan 2023 02:29:07 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:645c:8576:916a:8c99])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b004a20fa37286sm1997324edt.85.2023.01.28.02.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:29:06 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 11:29:05 +0100
Message-Id: <CQ3R47Q8UMTZ.2RQFPSEBX7EVI@vincent>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: MAINTAINERS: Add the zulip link
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20230128072258.3384037-1-boqun.feng@gmail.com>
In-Reply-To: <20230128072258.3384037-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

On Sat Jan 28, 2023 at 8:22 AM CET, Boqun Feng wrote:
> Zulip organization "rust-for-linux" has been created since about 2 years
> ago[1], and proven to be a great place for Rust related discussion,
> therefore add the information in MAINTAINERS file so that newcomers have
> more options to find guide and help.
>
> [1]: https://lore.kernel.org/rust-for-linux/CANiq72=3DxVaMQkgCA9rspjV8bhW=
DGqAn4x78B0_4U1WBJYj1PiA@mail.gmail.com/
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> v1 -> v2:
>
> 	* 	As suggested by Greg KH, add commit message.
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42fc47c6edfd..30161207f365 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18219,6 +18219,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Gary Guo <gary@garyguo.net>
>  R:	Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
>  L:	rust-for-linux@vger.kernel.org
> +C:	zulip://rust-for-linux.zulipchat.com
>  S:	Supported
>  W:	https://github.com/Rust-for-Linux/linux
>  B:	https://github.com/Rust-for-Linux/linux/issues
> --=20
> 2.39.1

