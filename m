Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA766C264
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjAPOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjAPOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:40:01 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97F65D13E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:17:57 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4b6255ce5baso381626017b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMWPYbjQSmRVDpKeSGqsCVfuSkZPvGKrSB2oUbUO47s=;
        b=SYFK53kycJxgo7F4nx8t+Uq1rDJ1llc++BuMPl8M5ZJX2xFkRpK8p5whug2ez8db+A
         KIPMoV484I7tP9WiCqbxFjGfOd6nez5/aptbCRUbR8qIxZ6txax865rbxwZL6SYCc7Ke
         RUib9ZIwffT/BYLQey+u5bZmZDr9ohQ3xlBmp0xuWgMMaebTCOU3NB4e/fIZ8RsF3HI7
         1dmvlBuN8v8tuoQPmaSMsb1vRnWEl+qLXvyJM3t1erv6w8kBP/k9JasPdAPgurI0RfPw
         XWsgS6ncV+ctoIcTMo0TImuXXSYEym7BQsIGVffj6IWXo1qrVtYaR0iNwrs/FiIEAo29
         MVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMWPYbjQSmRVDpKeSGqsCVfuSkZPvGKrSB2oUbUO47s=;
        b=13Wsc+DRDiaPC94Ptc8HsmvRA8XdOY9dim40FzAYYo2o1VQjfedSIK8LDHJhCi3mNm
         z5jx7PsYjE5NN30bw+1DTdsl2aJ3LCcExwpvTXX4nwId5BBtPfH/z6vCSQReCvaCCqqY
         PExL9N9Q8Y48TpzXOLqfPOiakrQ4Hm08/aW7yl4/tlmNfgjz3775yvsdjEHa17B0IH7W
         lmheNY0aQPpWtr4ikh2uLynJoGWp1AbG97a48jgp45o9bd7vXZ6SEZvxFaooxlewdP61
         XKTZpjSjWMwnwCVMtUvMmx51ElAWHmdedlDKx6b0sx/InVjT6ieNaHLuHkzE/r6uaCI2
         BVdA==
X-Gm-Message-State: AFqh2krcnUCRdZef4uKCj2lyiedfnFuRyuR+tYN8WDCnf+4Cazk2Aj+c
        4bvRH+/1gqQ3qIobzM9jQrEXIv/h9HRfg7vt+mhBnjiI3c/mFg==
X-Google-Smtp-Source: AMrXdXtAh/ZzXCPDoVr/80rB6yvhSPUFDFti/ZSylP6eMttiHYWNAgRlJEvBO/7JBrCK/xVWI3UCXqewXP0ad6lW/PQ=
X-Received: by 2002:a81:a084:0:b0:4dd:ff06:1358 with SMTP id
 x126-20020a81a084000000b004ddff061358mr1666940ywg.488.1673878660244; Mon, 16
 Jan 2023 06:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 15:17:29 +0100
Message-ID: <CACRpkdYD-MfgCBUdTdNU0+kx+Z6parEmWwQC_3smDYxG73=XGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove unused of_mm_gpiochip_add()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
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

On Thu, Jan 12, 2023 at 4:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> of_mm_gpiochip_add() is unused API, remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A bit late to the party but THANKS for doing this Andy, it's been
a pain for years to have this cruft around.

We even have some traction toward eventual <linux/gpio.h> removal
now thanks to Dmitry's efforts, this is great.

Yours,
Linus Walleij
