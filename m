Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4238729E14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbjFIPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbjFIPOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:14:32 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6030C5;
        Fri,  9 Jun 2023 08:14:25 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-777a4926555so61146239f.0;
        Fri, 09 Jun 2023 08:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323665; x=1688915665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkAejDhVenOljts+lEgATyY0mjLSL4+xG2fSzob05cU=;
        b=bGVGUeWa4Q1D4LKrkcF9ZuGmc3n3tBrlOeJy5gJ1pBxfrGPy6NzlCfJxL1sqMMTauN
         UTHMSCkb20JH2e2WlvXLtwRtH/7LdrCB8VwrKtWCXn2G8nchpv+f9RA4q0BkfNaAaEtk
         xg6/RhxBbH7tO1JRghWIquAwA/v0P/V7hkANfRyL/3fjWETiIwKuGu2lAeIIt/Yyg4Pd
         AewBxbb6mtp+sUuMIvSCu/o+CxgPV671of6C9QL8vuTAU9h46Eg/bIvrJZb10Ubgo+fS
         jB0qRrDyNIg3QWFyG1pFt3aXWyU8BbXApDezMMlhcp8m+lhmdfUDGrvDbJTQIJbQa/ew
         R4SA==
X-Gm-Message-State: AC+VfDyrbruJvav+Z1jrbM1BYAmHxMAeTyVQBFLL8t76TR0ym9VTrb2x
        Iljrvd/L1mUGVaN0ho/azQ==
X-Google-Smtp-Source: ACHHUZ51hC0FqW26G3ZZ/1x1kW04DJ7QhraHlAzn2ctcSO3HfuegS6P1MdA5ofiYZJ2F6gytcZ0bbw==
X-Received: by 2002:a5d:8b5a:0:b0:774:8d6c:9fe7 with SMTP id c26-20020a5d8b5a000000b007748d6c9fe7mr3269252iot.3.1686323664873;
        Fri, 09 Jun 2023 08:14:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eq14-20020a0566384e2e00b0041631393ac9sm1026218jab.18.2023.06.09.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:14:24 -0700 (PDT)
Received: (nullmailer pid 1011643 invoked by uid 1000);
        Fri, 09 Jun 2023 15:14:20 -0000
Date:   Fri, 9 Jun 2023 09:14:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-spi@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        timestamp@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-phy@lists.infradead.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: restrict node name suffixes
Message-ID: <168632366012.1011592.9711699530759737056.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
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


On Tue, 30 May 2023 16:48:51 +0200, Krzysztof Kozlowski wrote:
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
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

