Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7532B67C873
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjAZKWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjAZKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:22:22 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B034006
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:22:12 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5063029246dso16906427b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVZBb1oyzkUI7/NM6RSubt7U6Ftymmupkl59Y2rmdIo=;
        b=pmSzzUkPr3OhkA6m+Oj/XroMvwnITLmQmvnJmZL+J4aWY9xVfgowvAlmoNt0bVQpiC
         73qaFBmoi1tWpZcuo8icy42ngWtYOL9B/rGi6exZ8bNp3Fg9/ISGqOXShYgCuoll4R9M
         h72uc75qeFhAql1x//HEB4YlB+rySdjgalgUK948KlWPIwT8MDNIwcb3nyXYjpu6gx0T
         UcBW6sxsrrbXo/y9zqpduWWeqADvYzJgc0qDekqd9nziULSRA2ztRZTJLfFEimLZ3/XU
         HK/LkuRZijLyfMgx5ZBDAC/A3g4++UpJocL6HC1m6FLFPXdv7dSA+uh+boTDSH4P89Qw
         7zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVZBb1oyzkUI7/NM6RSubt7U6Ftymmupkl59Y2rmdIo=;
        b=gfnuIuqQhwUpSYmGvc5u9YSUFVKfsLhC9/lWTdVeuhHWyrB5Iv/nWH8+X6OGPuwRY1
         uA3Y89dLGHfsW7HH7FY9FWG9dF4PT0kxSp+PH0+oidF9w9O7ZW0f+jT3wyrSI88XlkHg
         4wrvAkv2IGehTbDj7Vksq5dPmpnpnbm2BxGzQ7b5yImIBSD2nTd37WKeVMuBtyNpPZqb
         7iAbuAfFhbwU5mE864/cEc6Vgop/iJLKCZjubI4OIdB6LBHXXOdGrOMmI/1ebYa68Hj3
         TeVH4mfqAG/iWF06jaVtuI8gAD79ioQHmSlD9clVGADb2J1mm9z5wFnUAmKS+3I6kfVO
         ZdrA==
X-Gm-Message-State: AFqh2kqIX4K9xk8bwn7/SMyLHSrjB+FoQcjTLaOtftZ3fzH2/R0TNNZ9
        dTsoHNibJL4vKIjjanq0bxTtPjt/L/8eMtGKNbQBwQ==
X-Google-Smtp-Source: AMrXdXsdGXBXTF5Ce79X2APQS9aUEQSJbDTKGn74bzz5zuuuKty6yfdkkxjubqH+p3Y2Iq6WnyUlc7GBT7JJupRIfbs=
X-Received: by 2002:a81:1a0a:0:b0:4dc:818f:f9f2 with SMTP id
 a10-20020a811a0a000000b004dc818ff9f2mr3561295ywa.469.1674728532116; Thu, 26
 Jan 2023 02:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com> <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 11:22:00 +0100
Message-ID: <CACRpkdZ1g9BEb28-YzAU8V5geiYzT9drjT3EMxok70ex3fOCKA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] gpio: Clean up headers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is a few things done:
> - include only the headers we are direct user of
> - when pointer is in use, provide a forward declaration
> - add missing headers
> - group generic headers and subsystem headers
> - sort each group alphabetically
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Just to add to the confusion I was also pursuing a series of cleanups directed
at just removing <linux/gpio/driver.h> from <linux/gpio.h>:
https://lore.kernel.org/linux-gpio/CACRpkdb6yMqTkrJOg+K46RZ1478-gbxh6=tw4bzWmd--5nj_Bw@mail.gmail.com/

Right now I don't know what to do :D

Linus
