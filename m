Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E4622621
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKIJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKIJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:02:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E571205C1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:02:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so44802979ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsAe+kA3GdQnBF2aWolv9MYAcxJCda0oHD5FhlDiJLE=;
        b=j9Nc3MpEbBnwzwg5UEaLqwNu1nsGIMUF3a8z9HJDehUlUeryWFOnEFfE3Bbu6Y6l8o
         tDgNmvBYbNahlU2sPytXWqPqjGNyQhrQsT5z84ORPZN896DSxrbH6QCRuAUbuLAMDq26
         qXVH9l70TndqhSFEqFs0l963Ufs1kOcH/eP0rro65enDrRzyp1WDUq6r1uj17Bh0rbkj
         PnUZCTVhCVqs87+NbiQMf/XPqdYnkyljsYv7ArOA9Cgubf7rWluUbu9AnkzrbsaeLRJc
         UWX+Sjlf/pQktjsSSUmW6BWfn8ov6qxzK7D5ZT5YrgHZVAzIRYxpoQD220mJ7opf8L+M
         dIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsAe+kA3GdQnBF2aWolv9MYAcxJCda0oHD5FhlDiJLE=;
        b=nAYE2h7A0yI49TJPDEDtXdiqV+A+5l0YrkT1M0+bZR48ZYVG+A3h4UyNJbZn6nLoaM
         dYz7WCG2LP0CurWO+uZY+yAm3oQzx2DoHPxGsDvYHX/7YrPue6V1Z8JE6LMI9IAsH1di
         mOQsDiHoTPH12QgKtZdsqnTJgquWG/1j7ztCmHZwjAPcVABrmtdUPXLkpSDZ77no58HL
         4G7VdI5iZ++T+kxbo7lxsiTVGh6vaObsn/2qUi/4l/4ERbB2I4BC7vdU4YJs1QPw/QGD
         8D4kFpM9JC1fO93tqH1aSzsWvhpxUvy88rE4+sNCRIV8wunnJIn5DV4CKb8cKKNV82hL
         1dgQ==
X-Gm-Message-State: ACrzQf04BsEF7RX4rwN4rFuV8UGC+xTWDQ/NX+yMpRivtp3i6YLwWy/d
        tMakRgFA2RUYeZYEwPwPg5BhIpq0jRbRZABhUQ1V2Q==
X-Google-Smtp-Source: AMsMyM6ISJx2BFO7Ll0CuuSSmC9yDaAZCLn3kbu6cGtsl2P5ZyLimjSH+pon5taEHzKDD5DmZkLJlkesHDVhMsZW0V8=
X-Received: by 2002:a17:906:95d1:b0:7ad:9891:8756 with SMTP id
 n17-20020a17090695d100b007ad98918756mr1130133ejy.203.1667984527623; Wed, 09
 Nov 2022 01:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 10:01:56 +0100
Message-ID: <CACRpkdbt41kLsU7ds+PmaxSb=WbBrqpSmzvjXH98vXg85Mc3xQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] pinctrl: intel: Enable PWM optional feature
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 3:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> I would like to route this via Intel pin control tree with issuing
> an immutable branch for both PINCTRL and PWM subsystems, but I'm
> open for other suggestions.

I'm fine with this approach if it works for Uwe.

Yours,
Linus Walleij
