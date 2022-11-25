Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D31639012
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKYSvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKYSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:50:59 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDE53EEB;
        Fri, 25 Nov 2022 10:50:59 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k206so4784820ybk.5;
        Fri, 25 Nov 2022 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlXZSq63uGUHYf3xEcy5GQyj8k3wzV3aaEBxQdNWSY4=;
        b=Ru0IfZVgDAD8+P3Vd/Cj6cxPxF1il1m19ndBb00b7fH4eUv5LyC2DmjHZHb/moUV8a
         JsHge43IkuVIWxO44XV59e4g09b+Elr2SLBiQ6IncYJ1qCu198pX6dbQvCzxvfKiNRjG
         vMUVcr5U+8Kk9sD8v59zmjFHrsosxLm+CbmQdD8r3TjVTxKRuPXV81ZDSQBaUNHROONl
         0sJ91C8DtHRaoHSPXNEPRQyHQZe2GD6/JLRFVBnyzzpmWc/pzDOp14qCif7nGdWMzb9m
         nX3jSAQdqVCWAjAgn/5l8aaKymxs3OYuzuTQaUoOYnVYES/FgdTTd19Oy2jA8KVKnQt6
         cR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlXZSq63uGUHYf3xEcy5GQyj8k3wzV3aaEBxQdNWSY4=;
        b=kJjaXTX9hLylnIcHTbZXVSV5Pb8ZjJJ8ga6BybvbLjJmBXdysENQSOuILdlQqZEZmX
         dghx3D7UcsxYH2xyeE8LHlSvAPliTSvtHPnf36b3zWCEDivZTO3NRbj6D+zcwPSaYFT6
         3uXASlfDtiJr62nnYmc1ztG+ysRRfEQ8Clkx4n4R1gxhzTxiwjJdG6Xi4rjDdeCSfbEU
         7r6djOCQ38AdaOSbrY93C95oNsGGe7g1gJ6gSkwIaf1e1EPBdeiGu1ts5rZv1fBqRMlb
         NwqD0OmBT2OOZh67WWogfarOPxW5y/QIkQ8UbB94DMxLLxqNM9U+Pe36WP0JMwX5E9cr
         l8Xg==
X-Gm-Message-State: ANoB5plCg6+NERWoGQT37jiP0faO2TjQD/Ilccaef1jWSANqpA216pRG
        ZWjet59XwkxeJ2smC4e6y62B2ejiLTamHSFjdGY=
X-Google-Smtp-Source: AA0mqf6XrludxqskbuOzV8FiitKfkb9O012hOxOMjMob+MhSVyQo30OjRMO2zb8ZSrAvK81lTzgc9Zh74jFhbyh+76s=
X-Received: by 2002:a25:ca58:0:b0:6f4:3ced:f7f8 with SMTP id
 a85-20020a25ca58000000b006f43cedf7f8mr68149ybg.489.1669402258512; Fri, 25 Nov
 2022 10:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 25 Nov 2022 19:50:47 +0100
Message-ID: <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 4:50 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> Rename the fallthrough attribute to better align with the kernel
> version.  Copy the definition from include/linux/compiler_attributes.h
> including the #else clause.  Adding the #else clause allows the tools
> compiler.h header to drop the check for a definition entirely and keeps
> both definitions together.

Thanks for doing this! Consistency with `tools/` is nice to have indeed.

I see that `compiler-gcc.h` is included for Clang too in `tools/`, so
it looks fine to me:

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

In the future, it could be nice to enable the warning for Clang too,
though I see it requires a few cleanups.

Another idea is to use something similar to `compiler_attributes.h` in
`tools/` (perhaps just copying it and removing what is not needed?).

Cheers,
Miguel
