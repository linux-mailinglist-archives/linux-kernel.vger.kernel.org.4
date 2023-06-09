Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240D9729DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbjFIPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjFIPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:13:43 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309531FF3;
        Fri,  9 Jun 2023 08:13:43 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77865f63473so77382239f.3;
        Fri, 09 Jun 2023 08:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323622; x=1688915622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQR5X+cA13kUaYcqbqMobhb9VGgmIkohulmhqJZKYzY=;
        b=VU9yIQG5USUmIih4fni9xtVr5BEqryZ6AllsK5LOO0N7RQRP53z5f9Rz8bGZpGa4sg
         S5ggjSAIiDKE0DU7ZgLB4yJsHcal9Xy7lYbiAI0rA+n2LP2FEd64ywqKGsIzUM7hfKLV
         g7aV8dHoyQcD0e+H86uX1qowKmw1ckmqVJjCajKRPzQU6QpijeF6D7a81STsipVTZrMG
         W5mAS+ouHQ/gA/zJGJvGstgsxW9scVO7XjO6pOk2cY6Tnx324AWxBtGapQyTmS6eb17v
         i4QxxEtNyPjVdCcAtqe5LTHlu6/D6i0YoXEif42T2E13AJ4KjYUy/E3/8362ExfrPp53
         sn7Q==
X-Gm-Message-State: AC+VfDzDDpWaC9OHvPpZe5qCdVrA1xb9PQcplCgapyVK75QkU6fa9c5j
        j318vgGjm//tI2elIDmjXw==
X-Google-Smtp-Source: ACHHUZ7pPsrApmh1g6QnAT5gDqfYy+vIK4VH1grPnXE4XcsiJ/FkZ0gxKjKu7YP4yiXH0oDQiYhlxA==
X-Received: by 2002:a05:6602:1851:b0:774:9af9:f45e with SMTP id d17-20020a056602185100b007749af9f45emr2002777ioi.11.1686323622392;
        Fri, 09 Jun 2023 08:13:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p25-20020a02c819000000b0040fc56ad9fasm1000077jao.9.2023.06.09.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:13:41 -0700 (PDT)
Received: (nullmailer pid 1010803 invoked by uid 1000);
        Fri, 09 Jun 2023 15:13:39 -0000
Date:   Fri, 9 Jun 2023 09:13:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-rtc@vger.kernel.org,
        Dilip Kota <eswara.kota@linux.intel.com>,
        alsa-devel@alsa-project.org, Guenter Roeck <linux@roeck-us.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-spi@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pwm@vger.kernel.org,
        timestamp@lists.linux.dev,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] dt-bindings: slimbus: restrict node name suffixes
Message-ID: <168632361891.1010750.17241199360005605438.robh@kernel.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-5-krzysztof.kozlowski@linaro.org>
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


On Tue, 30 May 2023 16:48:48 +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/slimbus/slimbus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

