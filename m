Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D101765921E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiL2VSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiL2VSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:18:08 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02AD1740A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:18:06 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1322d768ba7so22944093fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W9yqVYEa9jfT8rZxdmwDJ16lWw8u7Fjyu7VG9cRVsNc=;
        b=RZcGavD4H9jKVLXRLM+Xvq22NMIWxSz4LitutteismHacBOThyHdAW0tPZUFwG821H
         SwewA9bGwujXXzxEVUyYbtR3UkojsEGDCfbILfQz9sp/M8TnYgac8i48VzEyGs4Vrblg
         uCoP2cBj+f5bWE0V91RoQiu8M1qm26w98Nc/nn4nk56E09ZlYnskBwwZaEepOEkEQAQi
         rzHzo6bNZngjGHAomGB620PHxyjIJqYjcHbF1+SwuvArkU5V8B4SeFy3G589IWf15r5F
         jg71XS322LYcFTYrRLKrTtHY6p5l19tAP3+lvyQk9JCkvU3A/Odi8G45O+SsUhm45Yma
         LkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9yqVYEa9jfT8rZxdmwDJ16lWw8u7Fjyu7VG9cRVsNc=;
        b=Zv5W+IISNBWIwqpEFGbr49HZCG9bQY6YkFe6bWMOcxf3tkoKrZVHsnCCaKq/8nxBTb
         12eVcFfjQPG/GBGdopZkKOY5CIfVTyMDrBp9L5s8pSyjWpLpNMJLHc+6WC1WYWDEcCTu
         c0JqKvVv1H3X0z4YQICpViqBI+jBbyUSQavBDQOTddzac7YZZdeFUCclpv6jWNhAVeRd
         duPvLu7PTFeUqC42Khn03cHw/5eiCtEhdh5OK1dhw7ZHKv4oDu46z9jiYph4u1J2jOzH
         E2nHjmW1s+B5ovwjCX0DUUW9VscTqLLbZqPggJO3d1nS7QpdgWLfDwV+3GObDYi9IvCw
         WVxw==
X-Gm-Message-State: AFqh2koCOwhR8h2SyGS1MLAZ83F3V5uwGNSWWLRKgMuiwrOZwxhwXu8M
        Yf+Z489/sIdmL//1VLhJShKZIMMpxnmeyOQibDCfrg==
X-Google-Smtp-Source: AMrXdXs2+KVckCpTFkqtWqvAIbKrP1CjjOsmSSFa1DI/PAC2SI5aHJWnvw/siEpRzJmUysu2avBzlpwp6Kt7A2EFJF8=
X-Received: by 2002:a05:6870:fd89:b0:14f:ede2:db25 with SMTP id
 ma9-20020a056870fd8900b0014fede2db25mr1118761oab.42.1672348686201; Thu, 29
 Dec 2022 13:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 22:20:00 +0100
Message-ID: <CACRpkdZfjn8fu8iToqYut0Czr97Nv4+DMbzZ42rYKQUiRSXReQ@mail.gmail.com>
Subject: Re: [rft, PATCH v4 0/3] gpiolib: eventual of_node retirement
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <treding@nvidia.com>
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

On Wed, Dec 28, 2022 at 10:20 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Now that all GPIO library users are converted to use fwnode,
> Drop redundant field from struct gpio_chip and accompanying
> code.

This is great stuff.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
