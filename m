Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48C67E6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjA0Nep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjA0Nen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:34:43 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAE837542
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:34:42 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4b718cab0e4so66769987b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7esqlfGYWzJ6Y0OJydSA+tLwFcU/wE5gsqCLySvP+FI=;
        b=i57taSKI0KV9DD633Xsgalq3yZIYCbjUnOEqRNTxRaG3ZkW3eAINc+I03tOTV6BQ2Y
         FHs2eZEaC2sTf87rY8ZVFOzNa+taUhkzWD7aWEgCrwK3sLRoJc0Cw5ErliVLqZwBatn7
         tP1rVVq6OgfCIwzk4sVt3rt5j3bhd41nDzzl2G+LIll+x8miozQFAqxy09mA0h0MLvqV
         PqJcH2tHWwaPEgKjMXiles+k3XwjBCIGg+WBVuTzmm+k3O3jhdrl1gXab70Y2V1dQY+Y
         iNMBGZBLVRmcDH1pW2a9YppIkGrPkaCnrDDOTVO9WdpjTdbiijCzj67RtLs0SewmVeZk
         gD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7esqlfGYWzJ6Y0OJydSA+tLwFcU/wE5gsqCLySvP+FI=;
        b=cq+eq1egDw2onPvn/+nq1Becb1V5dRJVRKxbtHnKoK/NpSopeDknrEDAco/oFIydMh
         3UjFJzOiSTk2pJfqRv4sm4Ur90Xs+a+TvUk4XXoDEkFDTdvgYXd+vfhvSZ4wq/eBOsgd
         kE/v3jvAL/9KvcXOx3l+k6BLgqCZ5fogWAv0DaN5ecipTSRzrSAkGKjEd0zhAEk6OMMz
         FWqhBZ6HIUXJMRvnKSMlFMu/rYAvyCG6poLCwbk6NbT0l+pwGZnU8nL+vbYvB2e5Y5wT
         LOhM1z20HHFFggqufpGdlZgMQorFXczlJLl2QeeHqPGhueyBSFUmlOna/4M2qJDZJubr
         2BuA==
X-Gm-Message-State: AO0yUKXTHB28F3wde1I3cRwVhMBPIQpZVV8hanrrliLq2kFA48rbhDS4
        OLSfZds732FqKdb6LfN/9/bE8Bi3bNnH1+5qsLMcr3tT1ogVKg==
X-Google-Smtp-Source: AK7set88vSes/BG5lngJVrxXzpSoY8t2RDVO5Y7hI0bNYjMxtiyjEXQTq9fC8laZszhIwxmHVbHyO3JrYsWeQrYHj7w=
X-Received: by 2002:a81:1944:0:b0:50b:429e:a9ef with SMTP id
 65-20020a811944000000b0050b429ea9efmr232496ywz.434.1674826481893; Fri, 27 Jan
 2023 05:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20230127101149.3475929-1-arnd@kernel.org> <20230127101149.3475929-2-arnd@kernel.org>
In-Reply-To: <20230127101149.3475929-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:34:30 +0100
Message-ID: <CACRpkdYPoTVtT5snJz3wYFBggYA0+wdSXxHRKoJ3TkH6jeXqaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] gpiolib: remove empty asm/gpio.h files
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:12 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm and sh versions of this file are identical to the generic
> versions and can just be removed.
>
> The drivers that actually use the sh3 specific version also include
> cpu/gpio.h directly, with the exception of magicpanelr2, which is
> easily fixed. This leaves coldfire as the only gpio driver
> that needs something custom for gpiolib.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I see I was reviewing as the new patch series was going out, such is life
as an asynchronism! ;D
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
