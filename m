Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7E67F25E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjA0Xob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA0Xo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:44:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB2B5A806;
        Fri, 27 Jan 2023 15:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9EF0B82145;
        Fri, 27 Jan 2023 23:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B33C433EF;
        Fri, 27 Jan 2023 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674863065;
        bh=xAjRM3OwrCzPKZqjeYMU/ZIJa1szvJnod3xJDEu9BKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i3ne9xBg3WgMnuRsia/MVaG1UqzDhirZwAl6VgjlsiYZhuEr85T9kf9SEsG3+J4oX
         GrS9tFXI8l+8Y72Vy3YxGM5KxtdJyfZzpD0eyGwA14lZY4MCcZt/w41XTH5A25Xy1q
         y/Je8cArvnNfd7Iwg+qMJp4Q6Km79Et34jr7n9CDL+CXw+YQeZ6tUAb60g99oIk2SA
         kuynngwKGRkb50/OqC3LPtoY+WG0JtAEZfmap1OfTML6QXHv7Rt4VqR7YiAK0nCJO9
         3nlXugIRSVbdd35gDRBCYuCKSiOkuKQuax0d9Q4KTRA9Xi2+pzQu3K5KP0xLIzr5IN
         Jidk3axeE0KwA==
Received: by mail-vs1-f47.google.com with SMTP id h19so5161007vsv.13;
        Fri, 27 Jan 2023 15:44:25 -0800 (PST)
X-Gm-Message-State: AFqh2kqkq47fPwLWa2fZmtY4fjJyq0wlKBhsvNIPNiZJR3yOe4kptHPu
        9zLLBnGDXvdhHRMwAWzOkmwgEofvKVTgyqzb+Q==
X-Google-Smtp-Source: AMrXdXtcnWsJO8ZKRcbJNSWxH+Y77FSptLg7E+6uJVLOHhlTS5zZrrwVhR1vakT89/lO4uK4qWIrKVfUcuxC6ix8PzQ=
X-Received: by 2002:a67:f506:0:b0:3d3:c767:4570 with SMTP id
 u6-20020a67f506000000b003d3c7674570mr6365473vsn.85.1674863064282; Fri, 27 Jan
 2023 15:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20230127224101.never.746-kees@kernel.org>
In-Reply-To: <20230127224101.never.746-kees@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Jan 2023 17:44:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVp57NtR11JV-eXktMU9_dQ+8sF8YSPe7KyazrvJB-eQ@mail.gmail.com>
Message-ID: <CAL_JsqKVp57NtR11JV-eXktMU9_dQ+8sF8YSPe7KyazrvJB-eQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Replace 0-length arrays with flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 4:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> Replace the 0-length array with a C99 flexible array. Seen with GCC 13
> under -fstrict-flex-arrays:
>
> In file included from ../lib/fdt_ro.c:2:
> ../lib/../scripts/dtc/libfdt/fdt_ro.c: In function 'fdt_get_name':
> ../lib/../scripts/dtc/libfdt/fdt_ro.c:319:24: warning: 'strrchr' reading 1 or more bytes from a region of size 0 [-Wstringop-overread]
>   319 |                 leaf = strrchr(nameptr, '/');
>       |                        ^~~~~~~~~~~~~~~~~~~~~
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/dtc/libfdt/fdt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Changes to dtc/libfdt go to upstream dtc first and then we sync them back.

Rob
