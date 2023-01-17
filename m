Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F366DE69
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbjAQNMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjAQNMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:12:40 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F974360AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:12:33 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4d0f843c417so307505037b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=20fmAC0ZlUwS0WGm8jsJpzevdaSRxhLT1q2VH+pp97w=;
        b=vuPcK3dDABh+jUyxpP8ZlvvlP2TjJ3GvFZOZg+UojhzUCSbeu0sbINK1uq6WfKOmab
         ctgkWUnt7Xswkq/nBZnUQ6FkDG9sAdM6b6XgtCw4BBLz8WBX33aizIGEbLeTdSl4/Wcl
         d/mqmnoc7tP6F4rWsSbtUqut82HAWhr7lHyNeKRIR0du0zp33VBJzrEnfWUPrCLbF2xf
         hC0iirnkXp8uCO0Ms5+TjSqD2kheRw9w3ywLzlWcX/NGfPX9ipj/pFYstvmlhBbWmisr
         gSPoyuEahDLFz4w3XDyChAvhFC3b5v7DdJb09lZjs+YtaaXZM9kVkwS0K/KuvDt3sH7w
         op+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20fmAC0ZlUwS0WGm8jsJpzevdaSRxhLT1q2VH+pp97w=;
        b=XE3Fs9lpsfEiW2JsCBzwhjd+k5AfLojeRwNu0gSdsJJO1mnKU29Rxu+ng9S6Wz428z
         TIhcw3QXm/f9xRf21LArvRVKr4BYc3cdapu3xldzpWjMF6s+DgaKfFtAfuZU80UNQ4/0
         tBzl5AwTADves5BiWGCUY4mZrvM/y6r7tO8g+LS2ePF1ytOYnofTpD/uEUm6Qgs38J6V
         iq2EKdj5kRheEXU+SZjjuMSULGvSwAUMIBB6S3BNpzBvwB5p4KpjVawtdqvRde2QyBzz
         D3pDrsWzmS8E11Su5OsRP9jpAfgzsx7y5TkGE9qaIpWpnmfwxIFjNTsRSTBx0AUaiyc5
         toXw==
X-Gm-Message-State: AFqh2kokExETdA5Hqi9U0KYU347O91Ykhlo/NXQaaTSCGBUKNwBq1i8l
        +HYAFkIrbAWb8O3yi9xRYqSmsES/I2hzvDgXYlIDrg==
X-Google-Smtp-Source: AMrXdXuq8BnfQd8hwGrg05kolOybbliFbKMUakN4KXCF8wWUn7vN9ft3/xF5J5YD8FcWWHD6jNnfeb6hb+9Jaea4LFk=
X-Received: by 2002:a81:6dc1:0:b0:36a:de9d:825e with SMTP id
 i184-20020a816dc1000000b0036ade9d825emr365156ywc.477.1673961152876; Tue, 17
 Jan 2023 05:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com> <20230116124704.30470-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230116124704.30470-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Jan 2023 14:12:21 +0100
Message-ID: <CACRpkdbQ4S9Dp0_CEmWH8jbjOPedBo4-FP3YH2h6R-HRNn-A_g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: pcf857x: Drop unneeded explicit casting
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
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

On Mon, Jan 16, 2023 at 1:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The s32 is compatible with int, no need to cast.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
