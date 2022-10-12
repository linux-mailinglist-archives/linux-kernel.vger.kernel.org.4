Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB59E5FC3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJLKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJLKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:19:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39A12760
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:19:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f11so25560474wrm.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FNH5XGwulbmy7DN88MzDK1w46G3Joqy50v9SsajFjg=;
        b=KQhcKkZ7B1AVROrjaEN4Bgeir4PYDD3k6K0Fw3hcWFG4Rjadfgcok5jHmecsIP9IfI
         iv7RZhlz2NCkVBaeApx1jxmIE6xiEE9iS3Q6tv82zfw6Sib9OEB/B4kW9OQYPw7muHxR
         L7PEmfN7Mp/1MEVYajBEHVpu3D8nxA3bQrsuFC36Zq6TaW8HYzgfJpn278bjZDOmL2ho
         j9phH5HEqCBhEW3R5GJWKtYLX5dksNPFNTqf5mHPyVTH23meVo/NZRXViycBOLKatcmG
         K7V5ZSeOrbaDd46GizWNP1ERqlt3h8Ggjtlo+h4TShvIsWJX82XTHYfYGKdxQWWi88Vy
         WEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FNH5XGwulbmy7DN88MzDK1w46G3Joqy50v9SsajFjg=;
        b=eCn/EkC3h+54I3SosBjmepskMN3aMTwxHn920VjUs/ICIDb4JKH9867+4woH6A2Fzk
         zT3JMdtSqhV5D05uFr7X3O8tgscDqWQVurLFNLN7rHe/5PN8B3/r2hGbHlq4fxudOQL8
         5dxnbfzPYJyOBmFNgvPg48R14bcezCaMi+TC9hPWqsaFM5vohxvHCbicrL2SogOrSs2v
         9f3Xw6iC4nozHTVw61/XYYE/A/uGzNXJC5g2xvIgOeV9o5T3oULyX2+YaYFf3kHHmwJK
         Zr2vXyO1wTjnp583EY/pcINpawWuwCm55siQqUNyfKksy10vQuIvFEVpA8zLYvQvfm93
         NY6A==
X-Gm-Message-State: ACrzQf2P2cfK9zBQiB4x7UbQkJOK4CD0zjUT+cq9SD0LWkajFIzWixHv
        +ZaD5iltNCKY8oJuAYIhgBqPjg==
X-Google-Smtp-Source: AMsMyM6ucvyrxvhZbOWUJypJtM0d7s+0JtdRw4rT9jvREGBJ4kDLqezLV/AX97hNX2wfLvndoAt8sg==
X-Received: by 2002:a5d:6d02:0:b0:232:4070:6026 with SMTP id e2-20020a5d6d02000000b0023240706026mr739456wrq.33.1665569990813;
        Wed, 12 Oct 2022 03:19:50 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b0022cd27bc8c1sm17016048wru.9.2022.10.12.03.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:19:50 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:19:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/7] gpiolib: of: add quirk for locating reset lines with
 legacy bindings
Message-ID: <Y0aUxD/te6RAy1nk@maple.lan>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-3-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v1-3-e01d9d3e7b29@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:19:31PM -0700, Dmitry Torokhov wrote:
> Some legacy mappings used "gpio[s]-reset" instead of "reset-gpios",
> add a quirk so that gpiod API will still work on unmodified DTSes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
