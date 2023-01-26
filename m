Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48E67D5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjAZUHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAZUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:07:42 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D573E0A0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:07:40 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id t16so3455449ybk.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLvduNoOt8LztTYVpuNMVnPelMmnqyRxqRLyg6HGxcg=;
        b=H+6SnUs6VnnGPZqMii9E04B2jZbdPO8JEzKwKb/AJ8KxiwwnK2MNII3exjLOSl5gid
         77VoL20WxdjPiAd6mM/Frt++DnvRBGeYkCnMZxJPaMaSvtgB/RUnrDdxLVgKkeveSvqV
         LrzyjFLEy9Ju1waaH1L59m7AUNdOGsFP/ugRIHnpl2AenIYyj6LEgFSvN6LFq6cNKlEq
         E2X18z1uBxOTst1xMvqGuCwKxTd4bVYXZAD93G/mIzNmkdajWluOkGUV1vYYnY3i2Fdw
         fllbaK801dFQ1i7INkpwSx52GZBr7tIxG6tWtQsCZln8/tPnjiETmnRpLougqogGIAL/
         B/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLvduNoOt8LztTYVpuNMVnPelMmnqyRxqRLyg6HGxcg=;
        b=Iuy0+ubhtt8rh4CAjjyZMGhX15V047Gnw1pbf/zMLwPGb/831WBErRduLAJitXvbey
         M1qgE4NJKZYGa87F+5UvMFOrJes6gHyGn3tP+D/Vrq2RVEd4JALp6oO6IvtFIH/VexXe
         jkbb1kbQGW2Zsa3NYyZtvYuolydETtya5e/OZsH2k3//d/ipX2fz1OtyAFchlclIfA7M
         58lIdEhCzBWfY6tUAcwhqFYn8yptg0k9cKL9Gg0bvAQf3TBePpCU31kKAwnR5aiSjSXC
         dKEbLWCTQDMGKCmPiJvftSfB2AW2V2jBPbKTrB6D3gKYMu673/ju/PKZq6qnTouvBOO/
         WgcQ==
X-Gm-Message-State: AO0yUKWYfba+KCC9bNgCgW7kKfHuh6svrvr6rOtDeiztHtTTc/0Hg5GV
        lE5bWP9boAwl+c9Zz/c7ZydEUr7kYD0RJ4A5Fwny6SxQYJltWg==
X-Google-Smtp-Source: AK7set+RXU546bCG2ieA1RNematBemc4AFyAycDDxbMQYNdnjp7iUSmTGAk1mBuk641lDSfvZ/bqCOrkZeydPqsG8fw=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr881734ybd.24.1674763659341; Thu, 26 Jan
 2023 12:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20221226123630.6515-1-pali@kernel.org> <db008af4-2918-4458-aa68-2392674475c8@app.fastmail.com>
 <Y8rMJcX0cqThKj2N@google.com>
In-Reply-To: <Y8rMJcX0cqThKj2N@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 21:07:27 +0100
Message-ID: <CACRpkdZrL3Wpk6_Pka_Ye-9C0Ewx5ULZ8pt396kO-e95kqku_A@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/8] Resend LED patches
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, soc@kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 6:15 PM Lee Jones <lee@kernel.org> wrote:

> If everyone is convinced that applying these drivers is the correct
> thing to do, I'd be happy to (rather) take them via LEDs.

Oh you are co-maintainer of the LED subsystem since a month!

Sadly this series stalled way before that, so that's why we didn't notice.

By all means, pick it up!

Yours,
Linus Walleij
