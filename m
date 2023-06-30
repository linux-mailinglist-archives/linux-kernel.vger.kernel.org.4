Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277E574415C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF3Rf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjF3RfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:35:01 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10E4680;
        Fri, 30 Jun 2023 10:34:39 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso8967775ab.2;
        Fri, 30 Jun 2023 10:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146471; x=1690738471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ94kfdEfq9RrPFyhfJUVdunZkyBAVzDUoOb8tFiC9I=;
        b=DJc9gkx2Qj6nob9kqtEG+l+YwkxBFXyM8CaOh8ba4p4FroqnWH4MLV9xI3ZsjAbiMD
         koSz7EW5nCy4Rijk07WqybpKcPOEYLXPzehOYJ4bi6c7BwHEFZ3aYvAgsO7ywXjE4f29
         QMi11B8XmiBmQ39nN2LvSQ6NhgempeoNWS0kyiS5dH1RekkBHqvl+p5Yd0K2IOMu5UEn
         N5K15JyUyhvE31i9cdFVVILterRo8vr00DDmxqL8ae9K/e/gTN8ZK7dAEj3ZsOi8PzVP
         xzzqZKkzXa6pNGVnG3oeEQxJKo2c0c1m0WW8xs29+Q9ZnkmMuvrWjbdXewIrIH3MQbIf
         J2wg==
X-Gm-Message-State: AC+VfDysE37+dnvW0RJV16jsw1N5xoU4k0x3NKkITmQWpGlkHk9KEEj/
        1D5bYXOSZ0nm3CWRMn1FcnVTTIB5sA==
X-Google-Smtp-Source: ACHHUZ4EbUs4PS9q79isRP9O3xuyN3VlPHEnyRoBjVZ32PU31b0maNUtRwGNVSbiOr7AKyybiYfTVQ==
X-Received: by 2002:a6b:a16:0:b0:783:694f:e791 with SMTP id z22-20020a6b0a16000000b00783694fe791mr3651652ioi.12.1688146471480;
        Fri, 30 Jun 2023 10:34:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i17-20020a02ca51000000b0042af069eeefsm1830983jal.50.2023.06.30.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:34:30 -0700 (PDT)
Received: (nullmailer pid 2074728 invoked by uid 1000);
        Fri, 30 Jun 2023 17:34:28 -0000
Date:   Fri, 30 Jun 2023 11:34:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-phy@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        timestamp@lists.linux.dev, Vinod Koul <vkoul@kernel.org>,
        alsa-devel@alsa-project.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Dipen Patel <dipenp@nvidia.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: timestamp: restrict node name suffixes
Message-ID: <168814645706.2074491.15762386958786625732.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 May 2023 16:48:50 +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to -N suffixes to decimal
> numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

