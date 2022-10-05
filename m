Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E5C5F5553
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJEN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJEN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:26:27 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267979A64;
        Wed,  5 Oct 2022 06:26:27 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id d64so17585880oia.9;
        Wed, 05 Oct 2022 06:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VarRHBzsZmqpI3iQzog/d1fiKavi5frmCfjEwKIGaRg=;
        b=LdZGzTe6f3R5pE4NSkBjggl/kY7mv+isxmXgppZtLEiWBbWbFzcfruEEklv/E3q2yR
         267WTrk8osFdhTwmwIUPqhDIpWrvCA9Lze2OG2jFF7XQY1hoM2TkUit+duV8ZFIn9TI5
         DaggYYs7cmZKfoONT/586mG4BK6SkTZQkS2dFg5q1JQZt0FcF8kZu6Q+yQP1Qu5qUG1f
         JZd7HQhepUuI2lk0zEdBCwlftn76XIVqXV2yd9Rk/8i7rRkDL4aUxoSUmeWsOkGM+k/L
         t/ZleH2ZZMYgMqj9B5Y1bLeKTi1b0hwxvWFFt9SrG0oZAvzM6UWrGdhiQ0sG7LMvXs9E
         5HUA==
X-Gm-Message-State: ACrzQf2kBJ8LYqcTyP6jddhGaiyO0h90PB8wXhocrAq05+fmtOrRAExw
        Jo2n0PVJZennzq4gm2tJ/A==
X-Google-Smtp-Source: AMsMyM4pkKToScnDaDGsRSQwEBW/rGxeCtodCeAhbKF8u8fUEZzu1rrLfdbQx6tc9pIAQ1BW2g5Fmw==
X-Received: by 2002:a05:6808:2118:b0:350:3c8e:404d with SMTP id r24-20020a056808211800b003503c8e404dmr2295279oiw.227.1664976386436;
        Wed, 05 Oct 2022 06:26:26 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id q22-20020a9d4b16000000b00660efcb5c0asm172715otf.73.2022.10.05.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:26:26 -0700 (PDT)
Received: (nullmailer pid 3270113 invoked by uid 1000);
        Wed, 05 Oct 2022 13:26:24 -0000
Date:   Wed, 5 Oct 2022 08:26:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nishant Malpani <nish.malpani25@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Cristian Pop <cristian.pop@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/8] dt-bindings: iio: gyroscope: use
 spi-peripheral-props.yaml
Message-ID: <166497638388.3270065.6159101408427868842.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 13:56:38 +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml      | 5 ++++-
>  .../devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml    | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
