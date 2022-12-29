Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0337865883E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiL2BHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiL2BHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:07:18 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1953E13DFA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:07:18 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id k7-20020a056830168700b0067832816190so10766491otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GstWgD6pi9exQ0bv5bGn3BCV+taiIfBYlUvekjsyeZY=;
        b=K2Iip4YfjTPzPv5Slmn56NAQiSADHK2Ch5wPeGXTuK38j7VbcAcuTcsIEAe3zRdNVt
         hBom8WFoogY4Wy7Y1zEmuLe3e4XERVlKRAc70q6ZYznLlkuSM2nvJqgahtuAS1hdBSCk
         DS53GKvdfdT/eYcbN4EMYXZwn3geq/TltULwpH86vE5+GESw9NUitWMsjrkJ1PFAgn7l
         JRze5JuFdPrrzW/t1XQLQ1Pa1Ex6nRL46sXg9Uy+O6MIEN+tsXPKmSe/lEgPS9TG8lE8
         x/HEXwHfWE3wk/cSv2iT1toK/BEZwmRCDGSor6khDQObfJwrTglk3SMWzZq9/MVA/113
         2jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GstWgD6pi9exQ0bv5bGn3BCV+taiIfBYlUvekjsyeZY=;
        b=cQ1Tm+R85jFAoJsZFI/J5YDd+1bqHWbv1yzErJZ679pWwNBBL0yoqg9L+jFbC55C6k
         ay+52cJCNlLiEWCdeZc99squDvMZ2iOSBkP994jYLes/hTQZ/Nipp9Q1ajW4UQ6iGBRQ
         EHOG844TdlwZCKj/xgB4K9ymjU4j0ClF6D9AYFaR/NylnhbQ1gC7AAatrYZf5S8SVFaI
         t94Zip5RmvAollGTWJCNkw7p/34d9VyvmrRK1Ela75nIih+ko6o0YA9kBLeovk8SHIbl
         l9aGOXEMua/I8KEApQ8c3EQPVPJEooiWpJWiPRyAQHabuxtbrIlzsrWs1odJMtbafa2W
         pq6w==
X-Gm-Message-State: AFqh2kqJOCdfcxKEepl0L3CJf34wesk+StnE7A4GHq3lAKr9jz4kHO9T
        6vtmK8tK5H1DehBRicwT4jbA5E+8QMTjxcjLEMfXtQ==
X-Google-Smtp-Source: AMrXdXtTDVlw3GDkypP2l5QtbfdX9kedLos3gb565LD+nG8UaM7MjCjcFv8UR57dDARgapurQ6K5Hp6pgbNA/srFoU8=
X-Received: by 2002:a9d:750d:0:b0:66e:abbc:cfe4 with SMTP id
 r13-20020a9d750d000000b0066eabbccfe4mr1774657otk.102.1672276037445; Wed, 28
 Dec 2022 17:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20221215163822.542622-1-arnd@kernel.org>
In-Reply-To: <20221215163822.542622-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 02:09:11 +0100
Message-ID: <CACRpkdaUXkUCcP9oWq-Esp0A2ay=QoUuSfgUMYvKbjDehW_UsQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sp7021: fix unused function warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        William Dean <williamsukatube@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Dec 15, 2022 at 5:38 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> sppctl_gpio_inv_get is only used from the debugfs code inside
> of an #ifdef, so we get a warning without that:
>
> drivers/pinctrl/sunplus/sppctl.c:393:12: error: 'sppctl_gpio_inv_get' defined but not used [-Werror=unused-function]
>   393 | static int sppctl_gpio_inv_get(struct gpio_chip *chip, unsigned int offset)
>       |            ^~~~~~~~~~~~~~~~~~~
>
> Replace the #ifdef with an IS_ENABLED() check that avoids the warning.
>
> Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied!

Yours,
Linus Walleij
