Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1504264154D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiLCJeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLCJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:34:04 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F745A6ED
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:34:02 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3c090251d59so71657127b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 01:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkGQMlu6wKeISp0zA+NNxO3uj0UvahfyytXWgxy5oAU=;
        b=arD8BDwE7ELF18ggu6/9RjwoeoBeB7H0+DwUtSejo+QUHEQbiDhl5V0CuZ0vTGpe6p
         hviivVCkjZoYd3PiKOH/6ZWghRadFalG22ZeSIyVKijrgJxiqaGrN05NEYSUvql2pOl0
         7yJk+iIsmF5I8snfE7ZDtQLoM66T+V9rLh4cBo4Vf2vy4oe0KhJxNVTiQirmga+YYWcd
         l64TvE0bmLdeg8gW04V8XaSzDtQBPmfj8MOuaV9XfDJLH4uykJI/wSQeThYIGP+dyk8a
         WGYau/0LOh43OvwlcTY38Jv4f0H72w4JzqpWEG5PUkxI8YTmF/rAxnMxkxJKf6PY1n5Z
         yjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkGQMlu6wKeISp0zA+NNxO3uj0UvahfyytXWgxy5oAU=;
        b=LS7XRnHpwxsZw1i3OohsJuKHYfcRJymWf5qfUV4yyzbn6c6EU1rUVwT14/cqJ4I5nO
         V10R/bQOXu+kEm2kkcvmn/7IZkcEkcwv86qrSEGkCdTBQhWIAEEOUHcOZLaeHQB9RYdU
         BpKwqx8uOhoWoHtg4l4uQHr8pWWttpyvyOJ9G9a+LU+i/RUrU4Wqw5r1ZNraQyL0uXYW
         TpDHwW30CG/K+eVO5irxPzLGj6berX/eSV5vsKw8wwPO7iIEB9xJNatO5MlEg+XGqQEL
         cEb1KHvtI7Y04ZyzyO58lOSOYARg/nbiDAPKzZnp3nAymAMB7ZABIj5jCUHY61zNjNCx
         k6oQ==
X-Gm-Message-State: ANoB5pmTqhhKSdj6suARNV1KJ/n+TKcAu01NpaG9TZCKzkCMs2x0rtgA
        TqmcNE1p9i8NQciYKy+Z7XErgYArBJ6g8o3sERT0Qg==
X-Google-Smtp-Source: AA0mqf5rx5euZ8EgLbXLgUOq9u5gJklMo7bbGhLHT4FySZEtgNpgveMbe3VSrDmx8xMO3lU2qWmHQ5iT6VRng/f7FGc=
X-Received: by 2002:a81:5748:0:b0:3b1:eee3:32a with SMTP id
 l69-20020a815748000000b003b1eee3032amr43455788ywb.325.1670060041225; Sat, 03
 Dec 2022 01:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Dec 2022 10:33:50 +0100
Message-ID: <CACRpkdYVU2KJMw=FRxCLXbpWY+42RGheHvnqzg2bo2=JjTRCOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] Documentation: gpio: Input mode is not true Hi-Z
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
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

On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The true Hi-Z (a.k.a. high impedance) mode is when pin is completely
> disconnected from the chip. This includes input buffer as well.
> Nevertheless, some hardware may not support that mode and they are
> considering input only as Hi-Z, but more precisely it is an equivalent
> to that, in electronics it's basically "an antenna mode".
>
> Sligthly correct documentation to take the above into consideration.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
