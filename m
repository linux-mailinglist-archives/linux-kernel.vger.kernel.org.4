Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6680169675D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjBNOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjBNOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:52:01 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B7C2B2B2;
        Tue, 14 Feb 2023 06:52:00 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id dz21so5720335edb.13;
        Tue, 14 Feb 2023 06:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRuG/W8XFFocL2OnJrbaTWAiF5++M94qwm+FKUahD+s=;
        b=ugo4WguEwCQD9aEVhr4zBOnUdbt/i6dZ4lksq2/AE4NSpTs+XwBVvt5f4eSMfFN5Vz
         9n9pFooUt09zEc8OJgIObX/bEPJWteWoy8pOVtAKDUNRpO6IqZXurqttC/4lX6VvPebM
         u1LpDp/Apcxx+fIqj4wDTOhKScnp3NIyblaznZUKEPGstfJQ0EMUwFik6Fubg1E4KeCz
         Fmbdvw8RR3IJz8zfkDehCHBK3nw2Odh/DZfj2aFkvalWLL8qwK3U9vVeLPBHlAScH3YE
         Iw+4bY8eb1X9ZFRi1JUavp55vfJUPUYS9FPY3/6cmYMXQ5rbyV3sHSv5Up9yjByeTXpu
         r/Qg==
X-Gm-Message-State: AO0yUKXK3+1EigGVulG/K3z4JVNLP/p+EtAAow4Szu3IhrzJpGSXzX8o
        SlrU7bS1W22lZEHpYzIYoHH4l32JHUxGVlJYo7g=
X-Google-Smtp-Source: AK7set/WkTy4l+i7Q7geKHty3TCpys2JnFbR5olx6Gb393rDwTz9QEYN640TIaaUqdiD2Pr4Q25llcbgrxmrS16JmlA=
X-Received: by 2002:a50:c01c:0:b0:4ac:c160:3010 with SMTP id
 r28-20020a50c01c000000b004acc1603010mr1337008edb.3.1676386318689; Tue, 14 Feb
 2023 06:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20230213204005.55483-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213204005.55483-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:51:47 +0100
Message-ID: <CAJZ5v0gTy2UVcoByRdk9LOxyYhAHncHxbeiwHnxGJTLE1Hh=OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: firmware-guide: gpio-properties:
 Clarify Explicit and Implicit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Mon, Feb 13, 2023 at 9:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Clarify the Explicit and Implicit meanings in the table of Pull Bias.
>
> While at it, distinguish pull bias keywords used in ACPI by using bold
> font in the table of the respective terms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed formatting issues
>  .../firmware-guide/acpi/gpio-properties.rst   | 35 +++++++++++++------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index eaec732cc77c..db0c0b1f3700 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -67,17 +67,30 @@ state of the output pin which driver should use during its initialization.
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
> ++-------------+-------------+-----------------------------------------------+
> +| Pull Bias   | Polarity    | Requested...                                  |
> ++=============+=============+===============================================+
> +| Implicit                                                                  |
> ++-------------+-------------+-----------------------------------------------+
> +| **Default** | x           | AS IS (assumed firmware configured it for us) |
> ++-------------+-------------+-----------------------------------------------+
> +| Explicit                                                                  |
> ++-------------+-------------+-----------------------------------------------+
> +| **None**    | x           | AS IS (assumed firmware configured it for us) |
> +|             |             | with no Pull Bias                             |
> ++-------------+-------------+-----------------------------------------------+
> +| **Up**      | x (no _DSD) |                                               |
> +|             +-------------+ as high, assuming non-active                  |
> +|             | Low         |                                               |
> +|             +-------------+-----------------------------------------------+
> +|             | High        | as high, assuming active                      |
> ++-------------+-------------+-----------------------------------------------+
> +| **Down**    | x (no _DSD) |                                               |
> +|             +-------------+ as low, assuming non-active                   |
> +|             | High        |                                               |
> +|             +-------------+-----------------------------------------------+
> +|             | Low         | as low, assuming active                       |
> ++-------------+-------------+-----------------------------------------------+
>
>  That said, for our above example the both GPIOs, since the bias setting
>  is explicit and _DSD is present, will be treated as active with a high
> --

Applied as 6.3 material, thanks!
