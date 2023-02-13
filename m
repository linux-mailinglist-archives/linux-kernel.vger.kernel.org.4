Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A21694F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBMSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjBMSjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:39:25 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73719F2E;
        Mon, 13 Feb 2023 10:39:23 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id dr8so34094242ejc.12;
        Mon, 13 Feb 2023 10:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7li/ul6pp/uWHNLdUqV/9jTzsiuOuUrKYSojvY49UB8=;
        b=XthNKfg2iXBrAcQh3Mf2m0iMsTdkYZ0NTWxQ52s+MRYxX8nUpUdN+439Rex93io+3u
         zVkc/Q57rwScaAKgyCS85Nl9s2HXuw9XJTBchtvXWHGB9tlo/mDSzRZA05V3pFTYpQCH
         0vseYgdxF8AZ10529mTni9Nd2ZpSRbB2ks/MLdfoeztRPcPioGEy9CmXkB9FxMQgmKZn
         vR58jaACPInf6j4bgCJPVLakKlCQtnEVD5jlBLquYEmNKw1jDARhEJOBNmRzsBpo5OzN
         Q8Ad15dDOTyv2E6e5Qy5hShYMeLciJYhATbfJzFdRNWAxG4v/Mp0rDmglj8Y1aEWufO2
         uwpQ==
X-Gm-Message-State: AO0yUKXNhIzzLC+akKAk2wHvure0WVZQOoJmRsoYelDsPoqoFALy/3oX
        iDucQi9yxJHgrRA4PKBJH/KGYCxKeQC2acdd5Vc=
X-Google-Smtp-Source: AK7set/Bx9GvK5ypcB4OaIXNKHDtwDvKGrleR9Mtkgba/WjL3GlxRH1QJY0JF9smkqhSHPI5ksJeAPBAFpqa0gOo9DA=
X-Received: by 2002:a17:906:8805:b0:878:6169:71a6 with SMTP id
 zh5-20020a170906880500b00878616971a6mr5327073ejb.5.1676313561831; Mon, 13 Feb
 2023 10:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20230213132812.38646-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213132812.38646-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:39:10 +0100
Message-ID: <CAJZ5v0jkMez3_7rRqgyvbB9ik55fRxsU6yoLBZ-gVP7djwntmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties:
 Clarify Explicit and Implicit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 2:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Clarify the Explicit and Implicit meanings in the table of Pull Bias.
>
> While at it, distinguish pull bias keywords used in ACPI by using bold
> font in the table of the respective terms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../firmware-guide/acpi/gpio-properties.rst   | 25 +++++++++++--------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index eaec732cc77c..ae87aa64cb7b 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -67,17 +67,20 @@ state of the output pin which driver should use during its initialization.
>  Linux tries to use common sense here and derives the state from the bias
>  and polarity settings. The table below shows the expectations:
>
> -=========  =============  ==============
> -Pull Bias     Polarity     Requested...
> -=========  =============  ==============
> -Implicit     x            AS IS (assumed firmware configured for us)
> -Explicit     x (no _DSD)  as Pull Bias (Up == High, Down == Low),
> -                          assuming non-active (Polarity = !Pull Bias)
> -Down         Low          as low, assuming active
> -Down         High         as low, assuming non-active
> -Up           Low          as high, assuming non-active
> -Up           High         as high, assuming active
> -=========  =============  ==============
> +=========          =============  ==============
> +Pull Bias             Polarity     Requested...
> +=========          =============  ==============
> +Implicit             x            AS IS (assumed firmware configured it for us)
> +(**Default**)
> +Explicit             x (no _DSD)  as Pull Bias (**Up** == high, **Down** == low),
> +(**Up**, **Down**,                assuming non-active (Polarity = !Pull Bias);
> + **None**)                        or AS IS (assumed firmware configured it for us)
> +                                  with no Pull Bias
> +**Down**             Low          as low, assuming active
> +**Down**             High         as low, assuming non-active
> +**Up**               Low          as high, assuming non-active
> +**Up**               High         as high, assuming active
> +=========          =============  ==============
>
>  That said, for our above example the both GPIOs, since the bias setting
>  is explicit and _DSD is present, will be treated as active with a high
> --

Applied as 6.3 material, thanks!
