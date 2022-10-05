Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989DB5F5559
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJEN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJEN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:26:56 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770379A5C;
        Wed,  5 Oct 2022 06:26:55 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so92461ooi.5;
        Wed, 05 Oct 2022 06:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO2SqYLoFOsz7+IR3mhu/AFuRbAvzvmqVoHscVGVkcs=;
        b=bKEQ/FQsHxva8M3HHFQo6LSQexmku4Rq72M4LAM8z7eETXFAuLg/E55hI94U0bkjaj
         EoTlv0cuUbSS0Vdgon3nPssGOZVf/ng4KcxEf5YenluRt7i2l4odekHCk0AN9C6KQYGQ
         NAsjlH7lBD7rMr97qs/tZ2ZxoWpu5i8bZtyda8vtCoWJCbre7DiyoTUocbKIsBpZHbR4
         MVC+XHXkEPAtck0oPoYUvuRo7c7XFDYKt0J7jZWeptHSifujuwDp5JlmTVlFiWhSApyv
         kbIXaxe9Uq/pjxT+OBakHtC6JaHzw4K/67BVS23RK/gULzwLd/e/C4OzI8Mm82J7UAnD
         C7fg==
X-Gm-Message-State: ACrzQf1SByXnSiO38fGeoCh1A1lmhg6b20iM6HefCIe9eKxHTikiphDd
        ZJXFCLbN83qmdJQUckbAMg==
X-Google-Smtp-Source: AMsMyM6ahyrEuYKX3XiGPAQZBsG8bS0lyhi2X48CPKWdpgTa+BZR7wyYfax8ziTZDUbcBJxAfVyZ3g==
X-Received: by 2002:a4a:9b0e:0:b0:478:1e84:a130 with SMTP id a14-20020a4a9b0e000000b004781e84a130mr8612929ook.23.1664976414580;
        Wed, 05 Oct 2022 06:26:54 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id 38-20020a9d0ba9000000b00636e9a0cce5sm4095491oth.60.2022.10.05.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:26:54 -0700 (PDT)
Received: (nullmailer pid 3270842 invoked by uid 1000);
        Wed, 05 Oct 2022 13:26:52 -0000
Date:   Wed, 5 Oct 2022 08:26:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cristian Pop <cristian.pop@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        linux-iio@vger.kernel.org,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH 6/8] dt-bindings: iio: pressure: use
 spi-peripheral-props.yaml
Message-ID: <166497641181.3270793.14862629415813275623.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-6-krzysztof.kozlowski@linaro.org>
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

On Tue, 04 Oct 2022 13:56:40 +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/pressure/meas,ms5611.yaml        | 5 ++++-
>  .../devicetree/bindings/iio/pressure/murata,zpa2326.yaml     | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
