Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97645F5556
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJEN04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJEN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:26:48 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72EC79ED7;
        Wed,  5 Oct 2022 06:26:44 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1322d768ba7so12649274fac.5;
        Wed, 05 Oct 2022 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YGp6JPXS7qBf+KdM9r0or6W+GQPM/sg5dJ9d+tQ1FI=;
        b=laog50CQXzQ6sFj+Ru1RKe9xudyX44k9XwEg9ML5P7GHfrER3q4xIWcTV3tVpBcoi6
         wcrHTGVYjDkEWHVHXfuVKqxdYye6LFtOZFIGDdIRj5PtBcJxaBIhpY16KzLTDSFMz2Ov
         wiFXm1z1KVciRXYlUl+OCQ0WL9AYOTZVw7GuSHLAmtnMYDz7na3iT/+Ra2dtffA84ZYs
         MlDlxmkZIjVZUCcFKnSRUTuZbN59lCxPchusP1wRTzRFm4M8AsUQB7BJeeaGNK8xzerp
         YgyX5Va3a5xHJq7zAQV9MMk9UKf7kjM7J4YeONqTM6GO/xp6A3/vRNShWE49rRT5GoUX
         Vqaw==
X-Gm-Message-State: ACrzQf0wewbwWWRKbNWp88xKjf+nYSC87BcNw9D0jp+1KnQiNggmkIc5
        dHMtu1tuPsjn0kWy+ob9Zw==
X-Google-Smtp-Source: AMsMyM73bt7H9yZQbCpDXNfEUqjfdwhHypRgEdrueMEXUFkibGmSqfIWe15mW6dhhXF4gc+0OIOsLw==
X-Received: by 2002:a05:6870:b69e:b0:132:7a25:b1a2 with SMTP id cy30-20020a056870b69e00b001327a25b1a2mr2559219oab.206.1664976404002;
        Wed, 05 Oct 2022 06:26:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id z11-20020a056830128b00b00639749ef262sm4152958otp.9.2022.10.05.06.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:26:43 -0700 (PDT)
Received: (nullmailer pid 3270531 invoked by uid 1000);
        Wed, 05 Oct 2022 13:26:42 -0000
Date:   Wed, 5 Oct 2022 08:26:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH 5/8] dt-bindings: iio: imu: adi,adis16475: use
 spi-peripheral-props.yaml
Message-ID: <166497640133.3270476.6659048172355431802.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 13:56:39 +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
