Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D115F3D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJDHo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:44:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1E27B0E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:44:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e18so17679197edj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mCc+ToPojZpBuTYK9yHRLb44Eg2DgQxQi5FkztDsk/k=;
        b=uLmRyAtOLliX1TQaVeqVNYx9CwK7aPDKNxoXYT7ykw77TsVA991IJU8JXPmmqDcm6O
         v8Kk5kQtpUevp2AXM8vjZC6G8X9Uw8n98zhxLtiszbotmzl/04kO0gLQ8/d4bA+tAd23
         NW6Lnc7HYvGKNtga72krC94Ja4HBORTuVu2Oqo4rjkPis7EqVhabqKQgZXCS06H7+UlC
         GYFHRR0a5/5XuP5dgiqiwsWBHBlok1FNNvk/2Lpv+0BUWCAdnBOW5VQH9c3VZEZtf8Pm
         Xr80SOxmECGit2+kgpD4leQXiAiZWkpiajhYIZVUarLwrJ3v/KKI83V1iM8n5iIN+YZV
         3Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mCc+ToPojZpBuTYK9yHRLb44Eg2DgQxQi5FkztDsk/k=;
        b=WRs4nVhXp7nd9eKkPp+WFFWV1G2QwPYVitZHujdACtbjbCgE/N41LXPMNn0naKlPfr
         BdZzIMKKsfjyfACdGaGYX7cnwNlxFMjfnEFTELcNs5rPwn9ivrJ++5x+pvgguLcwXZuh
         ar91bS3v+R1a2OjzYCiE6KFmyKt7zhcVXrxzu5oPi0TETfNGVet7Iq3kjU/d1Z5TmmIJ
         0tgdFB7KooF7QOvFv2FxU51mapbBLQxthXb+K1+yGhlV81ONW3xeQ+Aa7V16ekwJ1xI/
         wZR3j5omKIBlsbvskJEADNbWa1CfAX3mlzf7a+8PmeZzrA+fzRqPWEPJfAotV+sMORMP
         6G3w==
X-Gm-Message-State: ACrzQf14IwH80n3zYdnTb3HblIorbkUXcg7MVZbzCrwa9hjUzHWWrbbA
        fkDBdXUjJfxT4lyN3np94PchqlbFdk6awQASNYXJ1bqNTkU=
X-Google-Smtp-Source: AMsMyM4ZgFT4/azt2wiS/ETsbBEJE4kclO7ulrs3n+x/Ms2QxKptHoIN8mXgj2x7U2hRffdkNNZAtupQvfMY0/19QQQ=
X-Received: by 2002:a05:6402:190f:b0:452:d6ba:a150 with SMTP id
 e15-20020a056402190f00b00452d6baa150mr22090907edz.126.1664869458489; Tue, 04
 Oct 2022 00:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <e8b573d81168c33ed4f3d5e5e2d3b951c323fc23.1664347239.git.geert+renesas@glider.be>
In-Reply-To: <e8b573d81168c33ed4f3d5e5e2d3b951c323fc23.1664347239.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:44:06 +0200
Message-ID: <CACRpkdbLDi9vE-Y14j+Tk7Gm+Tbft+C+R4wtPe-Gr7jLeEe7Og@mail.gmail.com>
Subject: Re: [PATCH] ARM: remove check for CONFIG_DEBUG_LL_SER3
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Paul Bolle <pebolle@tiscali.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:14 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> From: Paul Bolle <pebolle@tiscali.nl>
>
> A check for CONFIG_DEBUG_LL_SER3 was added in v2.5.43. But the related
> symbol DEBUG_LL_SER3 was already removed in v2.5.8. This check has
> always evaluated to false. Remove it.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Still valid after 8 years...
> Link: https://lore.kernel.org/r/1400055127.31197.1.camel@x220

:D

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker.

Yours,
Linus Walleij
