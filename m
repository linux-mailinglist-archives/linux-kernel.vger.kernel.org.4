Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B55F5550
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJEN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJEN0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:26:14 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A946870;
        Wed,  5 Oct 2022 06:26:14 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1324e7a1284so11189015fac.10;
        Wed, 05 Oct 2022 06:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeNXkgtQ2ohhQxqKygG14h08DMWrPMWmhK225hzpvUg=;
        b=aSmxpGVxzudWghH3aFd6R/qEhZtQZ9tB/Mn+J3XbXQkEHFt5h75X7PhnCtsvELDzc7
         K7by4BfSSO/0KsiqN0pktO+wr329eBBUPW3cb9RQeH05XEy+J0mR8Zd05cmAy6UgJTtr
         Ysr3adiVvzOGIHtDc7g9xDdzQASOLrGPzzCCnU5Q070RGmDMdA20BLirX6a0jWurneEb
         yniWPcjdWmPCgju78knJ1tFVNIEGRDMeHFvwptky1mQcNgqKYVZL8W1qF4kQ5IwN+yxE
         Xp8EN0rv2wmfjUYiY/RvPIgMFUdwIzeoYj9/c5f2h5QIjMEBrjwDVUKua5HU61XiAYsF
         6BmA==
X-Gm-Message-State: ACrzQf0NC1er1+FpUSL8vEfa31HwVc1WQY4h8X6ad6bOlsKwySahwJ/g
        iylZAbtY11ahcwwYcLh4BA==
X-Google-Smtp-Source: AMsMyM4Puo5r4+b3yYmrfhVd1FVZDYP+hQr34AxmMvxWgoeBed7W3OtdrKFhIy3w/jFjYq2Be/3QHg==
X-Received: by 2002:a05:6871:b28:b0:132:a186:f3ff with SMTP id fq40-20020a0568710b2800b00132a186f3ffmr2475603oab.240.1664976373490;
        Wed, 05 Oct 2022 06:26:13 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a860a000000b00472874bc2ffsm3423312ooh.28.2022.10.05.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:26:13 -0700 (PDT)
Received: (nullmailer pid 3269768 invoked by uid 1000);
        Wed, 05 Oct 2022 13:26:11 -0000
Date:   Wed, 5 Oct 2022 08:26:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa <nuno.sa@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/8] dt-bindings: iio: frequency: use
 spi-peripheral-props.yaml
Message-ID: <166497637100.3269712.6231096328116701814.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 13:56:37 +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/frequency/adi,adf4350.yaml     | 7 +++++--
>  .../devicetree/bindings/iio/frequency/adi,admv1013.yaml    | 5 ++++-
>  .../devicetree/bindings/iio/frequency/adi,admv1014.yaml    | 5 ++++-
>  .../devicetree/bindings/iio/frequency/adi,admv4420.yaml    | 6 +++++-
>  .../devicetree/bindings/iio/frequency/adi,adrf6780.yaml    | 5 ++++-
>  5 files changed, 22 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
