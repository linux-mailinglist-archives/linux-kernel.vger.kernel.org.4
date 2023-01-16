Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E166BA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjAPJdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjAPJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:33:15 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA17A89
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:33:14 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v127so24059742vsb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=URkHLwx/bN1JCfcGvgrmnXaeAySCWtdX4HCUZd2JU/k=;
        b=VWq8qyZNimN3Yfem28J7S7yGjKE7DQXKdfBACz68oxyagAvzcR8WuSfM3wnILJXNO1
         JTRLwb9JPqOxHfhF4CWGdf5F/Ia8Ant9wBZrEKB79Ra2rHgo2NBgCX2oMVTgrSC2hqad
         ouGen9PyJQyh/7Wx3ejE42eXrOwDkdurkmNIUUh43OwRgqO/KS0DsutVRmG1OMG6jf3F
         2dAxLkqiml+0coGtBVNCiWPRJsws7UouBeqQ75imKDVTTPuT1uXytJJvlh/BgAV2j8pr
         YcGu04GrjZ5W4se6L3gPx+XydNATr9RqXRJSMIYy4+YFGef3PVSRqrVJeL7JDjqXb6+0
         9k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URkHLwx/bN1JCfcGvgrmnXaeAySCWtdX4HCUZd2JU/k=;
        b=uc9UVnfpI+CVrqC7RoZG5dYaAa06hVzAnJfm57nH1TH0+auQ3yRlNRAsgmaBqSi0xq
         EVk719Cd7/8DXZuSQRHAcaBSzMW6fqzjHSlLQONWjjmW/+Zj2wEdfUSA2kjnVkSOrBCe
         DHo+84JEZ2eBwuK9q6OVQfmTJPjsO1govDkjQJoc2fGHZjr9AcEvWTNQu4xjMnA1NWQr
         pw6FDQiWG0tc65vNvJIdk83pf+zx+bWFe33vSW5WpzMjEvXv3XeKumjKk2AZIq4wv88n
         JbnlW5/1GbQAlOVyCp2rryqKsLQhjoeUYrhm3wb349g8k4gQ5pTUdnYb9CrA/dqS+oxi
         DYVg==
X-Gm-Message-State: AFqh2kpDbH4/HDjqY6sCr4s/JpMJeifrBPBU5NyeM4lKvW457I8J2jib
        aBGSlrp0bmZSMjUt8NeFaPJVmpV+buYG2+kP8+hd/A==
X-Google-Smtp-Source: AMrXdXtCswJVEULIT6svjZGgY72uO0FfucJ6kd9XEOxYEUb0IJMmb9o0kyiH3ZLYGxrxgIW2hts0ijsYrp63IQxql54=
X-Received: by 2002:a05:6102:1141:b0:3d2:3577:2d05 with SMTP id
 j1-20020a056102114100b003d235772d05mr829615vsg.9.1673861593487; Mon, 16 Jan
 2023 01:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20230112163825.72983-1-andriy.shevchenko@linux.intel.com> <20230112163825.72983-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112163825.72983-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 10:33:02 +0100
Message-ID: <CAMRc=MeoFwtvu9W8y7ZVoudYt4ufg_vOkdVd9Q=7zPEn-e4teQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Remove no more used ->of_gpio_ranges_fallback()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 5:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since the only one and last user of the ->of_gpio_ranges_fallback()
> gone, remove the callback completely. New platforms must use the
> gpio-ranges property.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
