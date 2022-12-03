Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E670641557
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLCJjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:39:00 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7E5A6ED
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:38:57 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3c21d6e2f3aso71478267b3.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 01:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1oGywp14JWZ15FPL7OnZRGPM4ko/b7n8s59nLxtj8U=;
        b=s9QB5ECunL2ghBjfUzx+lJx+SxjrYch/xmnA+GUEUXdT8mq8nvvxfX3V1ncfLSXyHe
         EQOqbDQ88d8lyvV1TSdn7VjZkbgpDWeN9lOYQjn19674NnrhsA9QU1m9+6hWIHpNqIjs
         /qSJL5/81qi9XrhCqCFN7kc7oNTk+G/hxvRyKrjnr3XN7MslAb42mzzDBMWkYrAeu4ZE
         4MqoxvWsuWKzhMqfsOmyEzzEvGYzVR9Tq6HuAtgOtYOg0wI8AKtPJTSmhLvlSRiJE+CB
         p0kIIf8tMgwDo8sdm0KWuiz/RB3GEkpWpnz1jFYWbMsfMToAY0S7h/PD1aRE5ZxfhEdq
         6CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1oGywp14JWZ15FPL7OnZRGPM4ko/b7n8s59nLxtj8U=;
        b=ADPdgU7MP8Pv8vWg26aX+yEeOY4SgF+IgNagb26lMKN61VR1nDi4eHmD5vmmo62xot
         LBkAcWbw34Ci/Z8R6XZ3F8xWs3FVE47DpoHGBtJN7nyiqn/yyc8mcCzLzc+tJ0ld4CNw
         PrxkMWNJn77nXHkasnEh91po0lOxTksdihvVRu5H+jpVMZ5khkZc5mNj6JZYcuA7TPBs
         nL3yYUoWuKiHewxWxGf97xj+exdw9NAO0HUf4Nw78xxHqX4CSzwLUJBNeHkJ9Y08RDtN
         SuY3DzwsrtyNhgtH3HtOUVt0+jyYI9ELECng0pmMzgohBR2g9GsKCY0pJiOfV2deqV64
         0gYw==
X-Gm-Message-State: ANoB5plduhbVWG7q4MXoqHsIhVJZlWE00hUORQh0fHi05JifUKHpuiSC
        rQ+ccg+0leh/CpgAqMssjm+I6wBKT9kIzBuxtWJ9PA==
X-Google-Smtp-Source: AA0mqf6rtGoiX62tAlxDjk/WCyDBCu/w/wp+MD9OtLZHeHdONq/EZ7raekDVvTX5ZPXLENYFYKZblujPRMvOkyzLEmk=
X-Received: by 2002:a81:7909:0:b0:36f:d2d9:cdc4 with SMTP id
 u9-20020a817909000000b0036fd2d9cdc4mr54837574ywc.380.1670060336538; Sat, 03
 Dec 2022 01:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com> <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Dec 2022 10:38:45 +0100
Message-ID: <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> +The below table gathered the most used cases.
> +
> +==========  ==========  ===============  =======================
> +  Input       Output         State        What value to return?
> +==========  ==========  ===============  =======================
> + Disabled    Disabled    Hi-Z             input buffer
> + Disabled    OS/OD/etc   Single ended     [cached] output buffer
> +    x        Push-Pull   Out              [cached] output buffer
> + Enabled     Disabled    In               input buffer
> + Enabled     OS/OD/etc   Bidirectional    input buffer
> +==========  ==========  ===============  =======================

This looks about right to me, but we need more input, Kent?

Yours,
Linus Walleij
