Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A867F719
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjA1K2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1K2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:28:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B51F4B3;
        Sat, 28 Jan 2023 02:28:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id n6so4162343edo.9;
        Sat, 28 Jan 2023 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icvGNskh7G4bTp76F6U5Z3OfwbzKoqFhH7qyt0kPsG4=;
        b=g1g/jCPRC4hMuA8ogseqLpr0XfJDXnKx5m2sthfLT50RivMcn4/bff+ZMGyGkaPQwK
         jek476LStY+Zzxa1FrrtnrUxgCyDjl7q0JsBWMUR0YgX68jPxPQl9LHtGFHLUB+XjpfD
         e3anV1EHCGJCPeynmXIHSy1yaAitBh3TxqSJ/wvXKCGhvj+VpNporvQy3gZhJUXwfVQt
         URX2WbUN95WXWNkK6gFDxVuXVfgnq/H9/1ht2nTpVRqAQEVkFcM3mkPw6In2fxDMDnEY
         dJk5EqPdS9RZY88tLT7ja8fSyCMQbuBlczLBzEJRON0n7LXBrKLyFVcf+B8XLNSMbGKd
         Nl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=icvGNskh7G4bTp76F6U5Z3OfwbzKoqFhH7qyt0kPsG4=;
        b=oMmyQKX30vYTnyVvvIwtloLJCo6d1cneOKa3wB0RaKUNVRQqrRJtPwuCIyjRThFb0z
         RBec7pHkyLvViiNukDQ++I7Pv5OCqQvxaWoWJpnj/bPN8fFTvQqIAUa0OWUQ62PJ2UqS
         slUEo34Ch6QlCdsrZ+P+AHXhLvwpGpHZj6TP/vfm52bpI7rEhP8o5mocYtdeG8nm8kva
         I95VdMhr0k66taO6ShItOVGJv3TaQorr0zMFz2viesrEINqbMylOXA/+Hzu5ckLI5W3m
         yPnbhy/fjTNpWBYzwWcygdFJd9uAdlzMGcgNBgRWkKvprquGgSqLY3Mk1g8L2OZlX7Fr
         WXmQ==
X-Gm-Message-State: AO0yUKXOQTvR+MkKTtRIF/1+kIjh3BNcXxITTrg2UsIiV3ASN3xOU54Q
        yMyDCOlMJbfY7qPK+BQN8Vg=
X-Google-Smtp-Source: AK7set/JJydZwgB4C3mnsSYcXTUrSMWy/gJAtEPgrZw6MYMAYhcl+Dz558xo1L9VdwjXjHk8N37gMw==
X-Received: by 2002:aa7:c58b:0:b0:4a0:e237:2cef with SMTP id g11-20020aa7c58b000000b004a0e2372cefmr9912273edq.4.1674901695586;
        Sat, 28 Jan 2023 02:28:15 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:645c:8576:916a:8c99])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b004a219af6a94sm1472718edv.47.2023.01.28.02.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:28:14 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 11:28:13 +0100
Message-Id: <CQ3R3JWKP9EU.3MJXX6DG1ODLF@vincent>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: MAINTAINERS: Add the zulip link
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20230127190917.3369037-1-boqun.feng@gmail.com>
In-Reply-To: <20230127190917.3369037-1-boqun.feng@gmail.com>
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

On Fri Jan 27, 2023 at 8:09 PM CET, Boqun Feng wrote:
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
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
> 2.38.1

