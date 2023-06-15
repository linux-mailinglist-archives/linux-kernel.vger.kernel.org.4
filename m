Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA13730F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbjFOGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOGgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:36:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E02954
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:35:34 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bc4651e3838so1395650276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686810933; x=1689402933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLa/CgfA5d+DY9dHcSH8mgD5fq7VSZe7M+p4b8NWBtk=;
        b=mOO3PT1WrOIELxCfG0i/4igVe8lGlVmiONDFNGZJww1D7bBlzYSX8f+qCa/pywNzfi
         M9e/CsmBwE8P4k5DRomSLFLQe6BVS1mNS2cfoO0qRDcjOHKiQXqe73ct7Bh1Y0eCW+XW
         W/d37IG3hZW9RHimYdL3QLyDWl19jt6mlZasQBHk8lDdf2YrorHexqvwLDh4B9hUhlMy
         FJ47MJu08OVdGBXdPnQ7YJKdzQ2ab6tKrq5/wO1Q8vHXASp+dPnPpMSOgqcMUgidMoo6
         IJXDsTSMz5ENji7oitLqwpI5+NxsGSqlv1aF6ZmyljRpGJMK4WvQmOdLw5VkhpAr84Xf
         2eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686810933; x=1689402933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLa/CgfA5d+DY9dHcSH8mgD5fq7VSZe7M+p4b8NWBtk=;
        b=OdZWHqBRhO1/iz0L8gHpJ6SghOFM7aGDA9fCJOdlfau6xv6boj8ur7hI3JyUyD7KFd
         5nZ+dv+AlQgFxkvmdR1OKQi+gcdHPrp6yv7L+ECePaUvNCFxIlvk2T1AOheFKw6GbNRl
         61V3LhCxtHEqYeJzYshgXkO1h2S9MziEf+moWufaSjYGLnSzpUCEZ9cQ/V6SHPT04mUd
         ozuT12tShIl1BR2sxnF9O9Zag2gAQZgU8x++WDBIEV8LBQmKM++4vm1/4VLUlN+6xKKp
         FIyzoHddzNK1LPlBi2dqRjpl868WeEZra9R9s7mbJEDCMNkbM5/u6DCg8SSFExe9/O87
         zeow==
X-Gm-Message-State: AC+VfDxFtY4kGWV87MsT5EoIvC+HZcTBataKgcRPUfqM2LL8BOUaLaFc
        nS0QVdeNJHFtWsrJqMRTOTJQLTFj3azWL5y1Jnj9oA==
X-Google-Smtp-Source: ACHHUZ6KaRkbHGBeRCY14mwoBp7/8GV+7bITlsqgluLuuuSPsdu6e9DJ8B0bf2xG0Q3aw+6W8iifIr7KRw7CeavtV+w=
X-Received: by 2002:a25:dad4:0:b0:bab:b84b:e500 with SMTP id
 n203-20020a25dad4000000b00babb84be500mr3985971ybf.33.1686810933468; Wed, 14
 Jun 2023 23:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com> <20230614231446.3687-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Jun 2023 08:35:22 +0200
Message-ID: <CACRpkday2jkyuZXWW_TNqWLZzsVJJ2dLUg=L1AJ8aMr0wta0DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: aggregator: Support delay for setting up
 individual GPIOs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 1:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In some cases the GPIO may require an additional delay after setting
> its value. Add support for that into the GPIO forwarder code.
>
> This will be fully enabled for use in the following changes.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
