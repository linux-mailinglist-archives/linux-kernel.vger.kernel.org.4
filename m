Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB864B7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiLMOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiLMOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:48:46 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E629FE4;
        Tue, 13 Dec 2022 06:48:39 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id l127so14388667oia.8;
        Tue, 13 Dec 2022 06:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzVIBqgCMRj+d25frQPQuCRYoHnOg+Yv+NlxwZk81AY=;
        b=4KIg5Q7mcbq3JGT0fJW+zO7BcrAtLycrfU6s/A+F8TPr0HI31OSMi7AoOkzVcvKpSz
         3X8ozjq/t6bPpF7PnMU2zgiu/Cj/hCqhxzs1W5zTvb5yVjn3kFQU2GaPcmaVCNBIajJc
         Ac9Vru3F4V1sg7OJLiXYlWklChw8lssKC5qfxgsfWbuRz0r4R4tL9PhlIfu/7RLIFLqy
         bROs3G0As+7p0dAmVIBH0IDMZ5XBUKzY7ALAFP/YUXscV+EwWt7K7P/3SRTgnOqzgiLj
         tpASw9DjaUm05XRgN9RuSt7iIZzFdK0bx1zqxjHrHFlQMatBDCvx+LKNrTkRqcLmnbIU
         judg==
X-Gm-Message-State: ANoB5pm3ixfrfUKCCiZfEk/8ciXvn5Wqrbf7He9vjrY9EEPOqsOQB/GF
        6jfPoD03OG8X/0Nx6FvPEQ==
X-Google-Smtp-Source: AA0mqf5U39GQd+Lq+x42Zx2jUiu3ICKx3nCbHogvtDuqaYRYED6hOHplsR4OXSyz5MzrCOZAtpd+yw==
X-Received: by 2002:a05:6808:286:b0:35c:4d3a:6d00 with SMTP id z6-20020a056808028600b0035c4d3a6d00mr9185787oic.24.1670942918522;
        Tue, 13 Dec 2022 06:48:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n26-20020a9d741a000000b0066e7fb52ca2sm1248803otk.14.2022.12.13.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:48:38 -0800 (PST)
Received: (nullmailer pid 992743 invoked by uid 1000);
        Tue, 13 Dec 2022 14:48:37 -0000
Date:   Tue, 13 Dec 2022 08:48:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        linux-hwmon@vger.kernel.org,
        Eric Tremblay <etremblay@distech-controls.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Kun Yi <kunyi@google.com>, Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Krishna Chatradhi <ch.naveen@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: correct indentation and style in
 examples
Message-ID: <167094291641.992665.14962893906742419729.robh@kernel.org>
References: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 10:26:41 +0100, Krzysztof Kozlowski wrote:
> Fix mixed indentation to 4-spaces, remove unnecessary suffix from
> i2c node name and use lower-case hex.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
>  .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
>  .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
>  .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
>  .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
>  .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
>  .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
>  .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
>  .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
>  .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
>  .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
>  13 files changed, 102 insertions(+), 102 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
