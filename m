Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686D69135B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBIW2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBIW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:28:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78FBB85;
        Thu,  9 Feb 2023 14:28:43 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id l6so2001447qvl.13;
        Thu, 09 Feb 2023 14:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0U+tDjz/45+yjQJbRf3k6cwcTvgN3CgcBpue1rhH4k=;
        b=d+BJwS+qdmFmVh7KDrHpyO9oYDnuo8v+McE+iNWgi+rCEoQehnc2P6q5AuvPY1bUPL
         Jn7cG3NRmkSAWltuvD9pIBckYSaJW8hw9yPQcPQ3jrFflwHnvSvRhjhFFXYgP+JJYDb9
         eZwr34K3Yzk+xXLkN4lP3vJ+Zf1bFNgL8dyEGAITCKlNXyFfmzcaFXc2jFFv5M6zOaUo
         2PNny/A5BGkrHwtPHVCq5svLiguqbma2Obij/zqSXyJdDHMJN7xCjfbt5jid/gUEWEIY
         D5gMaTHgJE/a23UJ7zDqK6Jtj8MfZ10UWu920qia9yEgIAc38oLhfsopslJnsx+afFYi
         8JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0U+tDjz/45+yjQJbRf3k6cwcTvgN3CgcBpue1rhH4k=;
        b=3UajMwcTPzqz7SHMzO9R4VehDE2tfcs9fFCiKb6CWxHmczwYnXtRo1XVqFvlNORLQE
         rq30lWxjelNw4wqTFjHTmcKTW6D5jubXEJdZgNeXMPyohjsuTJksAcKOdiw1MdKLYkKw
         v/N7RRzX4mUX1l6EMF8gLIzkOjuCuivno0bSlPFOytA0WG21C8n8OjhFX+IGBEK1/v4l
         jLUSHiPaedLqsGEpVqUwUSJ+k65kJjhfudX8A+c3Mmv/S02CxffGRGUToziabXqnN/tD
         t7e+LSbg+YafNF6uAZXhwkYgReFeDOlRroINQuw6K6ZirOoXDaLNgoeWM9sO0nGpDb4F
         aaGQ==
X-Gm-Message-State: AO0yUKU0VkycDrXRMp2MVnCKFgOUXG+VWO/MDZX2WctQhbxfHZBIqkSE
        /OdyKvyJEXTypD5SleLWSz0SS4LM6js6w9ghnZM=
X-Google-Smtp-Source: AK7set/+FY0eJyS98gw8/TSz+DdxCHUKMRf7NLCbPC6x5B3S4+cmY31fzCpWIL4RRRiKVkYLBtj3V0akIVWcwL6a8ZE=
X-Received: by 2002:a0c:a88a:0:b0:56b:f460:af52 with SMTP id
 x10-20020a0ca88a000000b0056bf460af52mr1160717qva.81.1675981722622; Thu, 09
 Feb 2023 14:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20230208185714.27313-1-asmaa@nvidia.com>
In-Reply-To: <20230208185714.27313-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Feb 2023 00:28:06 +0200
Message-ID: <CAHp75Vf7FcAvSwLPWj4OfnJ61iXy7TAFFzTAq_8b9VXeyCfBFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-acpi@vger.kernel.org
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

On Wed, Feb 8, 2023 at 8:57 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> This series of patches creates a pin controller driver and GPIO
> driver for NVIDIA BlueField-3 SoC.
> The first patch creates a GPIO driver for handling interrupts and
> allowing the change of direction and value of a GPIO if needed.
> The second patch creates a pin controller driver for allowing a
> select number of GPIO pins to be manipulated from userspace or
> the kernel.

Please, make sure your patches are available on lore.kernel.org. I
can't find this at all.

>  drivers/gpio/gpio-mlxbf3.c      | 312 ++++++++++++++++++++++++++++

I'm wondering if you have anything in common  with gpio-mlxbf and/or
gpio-mlxbf2 drivers. If so, can you split a common library code?

-- 
With Best Regards,
Andy Shevchenko
