Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918C562CD67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiKPWKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiKPWKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:10:22 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C776A6B8;
        Wed, 16 Nov 2022 14:10:20 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1322d768ba7so93971fac.5;
        Wed, 16 Nov 2022 14:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEp4qpDc25C4Jhe16ERtOXiKxuguwyQ9WU0yv9/yqug=;
        b=exbfnqt6UDWdCCUD1GWnjkZrltX4ZNJiBsYtAKztyFxHAV8Hv+vqeXPHZtOySUHwpm
         AICP5XN4xfglim/wWP5UYE8hl64Mgbc2raatBCThBOvdg0ouM4HiB1AeU7j6SuiZjhkc
         5kOu4aMjVMCVUZEYR1VY/jMA1/uCWwKttuAxcAJNiAVl8jBLPHMibclKoffubF3/oaOc
         7IsZJs6WZtJWI1mi4Yyu6DLvdgsxdp3uSui/uxfrdiFqIBCGNcjER8jyKXBwaZDg5WfK
         /FHNbuCNqWjzpJ00tcNjSJOn5NGsxvXpFeyVTVSuOzAAXTvqOMN1ieksttliwxX1hY17
         vb7w==
X-Gm-Message-State: ANoB5pmbW91Y79THMTExbXx0rTGbCez+txExmgEw2evHwUcmx92jzFl2
        p2Se/DDarrVRvhwXlYqsOQ==
X-Google-Smtp-Source: AA0mqf6FejGYuLDOQ3k+okboDBW6zKh68C2C4aL76tw/wYr9fhgB88im/yXe8Lf2jOF3kjHoI9Qjkg==
X-Received: by 2002:a05:6870:ea8e:b0:13b:a31f:45fd with SMTP id s14-20020a056870ea8e00b0013ba31f45fdmr2846797oap.194.1668636620141;
        Wed, 16 Nov 2022 14:10:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d5-20020a4aaa85000000b0049faebecee2sm522050oon.35.2022.11.16.14.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:10:19 -0800 (PST)
Received: (nullmailer pid 1116479 invoked by uid 1000);
        Wed, 16 Nov 2022 22:10:21 -0000
Date:   Wed, 16 Nov 2022 16:10:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad4130: use
 spi-peripheral-props.yaml
Message-ID: <166863662057.1116418.9768601754353437839.robh@kernel.org>
References: <20221115151955.394030-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115151955.394030-1-cosmin.tanislav@analog.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 17:19:55 +0200, Cosmin Tanislav wrote:
> Reference the "spi-peripheral-props.yaml" schema to allow using
> all SPI device properties.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
