Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F894629AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKONim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKONik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:38:40 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2E11445;
        Tue, 15 Nov 2022 05:38:39 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id m204so14855641oib.6;
        Tue, 15 Nov 2022 05:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+fDz1MeXrHCSzrnjCBgED+fbLhxB4Hb//quFwOW43s=;
        b=61hgC9/Ln+S9bfCtSZTrDyKLxpqT44/OtqnwKeExscBSjMAAqiK3fTHq0GI2XRLjI4
         mYq1bAFaRc8L9jbXwBh+DpBkvitpnUMfouoeW+9BDZ1GSGzkqHOCMKW7rUfaDWndiJ8c
         V6SF+R2SVEgclsTHTCZ3RF7bfTlRjFkKC9AAFZvdELQZvbgCqlw4uWunMeh+8ox+p25U
         BxKvzXld1wPaG0PHm4vX/jc6UwmM66MCrOzGjHVQadWTzsOBfWYo8W2L17YF9tQKtMXv
         4MJzxZgk2chC04k20+uA8UzwMpjab/sPdk9WcmOyZZiyijc8GJi0bUzULfVPM5iL14vp
         HYWQ==
X-Gm-Message-State: ANoB5pkTiepp+JchO3ECVAQ71h83SEOPFs50qWilKMgdX7HW1W+RxMQP
        fUILMwYQV6O0eMfGfVb6pg==
X-Google-Smtp-Source: AA0mqf4DqB+WPG/dOrOPgThB+8W8RhMkPaOgNske3u2tmtgD9UpaU6R0SMSg4otTyqeCTim6ddZ6dg==
X-Received: by 2002:aca:1b18:0:b0:350:d543:7554 with SMTP id b24-20020aca1b18000000b00350d5437554mr272866oib.251.1668519518573;
        Tue, 15 Nov 2022 05:38:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n204-20020aca40d5000000b0035a0c543ad6sm4938359oia.21.2022.11.15.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:38:38 -0800 (PST)
Received: (nullmailer pid 865048 invoked by uid 1000);
        Tue, 15 Nov 2022 13:38:40 -0000
Date:   Tue, 15 Nov 2022 07:38:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: [PATCH v10 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver
 support
Message-ID: <20221115133840.GA861387-robh@kernel.org>
References: <20221114024942.8111-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114024942.8111-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:49:41AM +0800, Yinbo Zhu wrote:
> From: zhanghongchen <zhanghongchen@loongson.cn>
> 
> The Loongson-2 SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing.
> 
> There is currently no support for GPIO pin pull-up and pull-down.
> 
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Co-developed-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v10:
> 		1. Remove lio/uart2/uart1/carmera/dvo1/dvo0 pins resue configuration.
> 		2. Remove the castings about readl/writel/definition addr.
> Change in v9:
> 		1. Add zhanghongchen as patch author and add Co-developed-by tag
> 		   for myself.
> 		2. Keep entry in order in Kconfig and Makefile.
> 		3. Keep it as a separate group after generic linux/* ones.
> 		4. Use linux/io.h replace asm-generic/io.h.
> 		5. Use PINCTRL_PINGROUP() and associated data structure.
> 		6. Remove Redundant blank line after loongson2_pmx_groups.
> 		7. Adjust gpio_groups.
> 		8. Remove message printk after devm_platform_ioremap_resource.
> 		9. Remove comma for the terminator line.
> 		10. Add MODULE_LICENSE("GPL") in driver ending.
> Change in v8:
> 		1. Add #include <linux/pinctrl/pinctrl.h>.
> 		2. Add #include <linux/seq_file.h>. 
> Change in v7:
> 		1. Add all history change log information.

Linus applied v7 already. Additional changes need to be incremental 
patches on top of it.

Rob
