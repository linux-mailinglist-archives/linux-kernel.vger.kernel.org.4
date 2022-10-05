Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C75F554B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJEN0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJENZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:25:58 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4079A54;
        Wed,  5 Oct 2022 06:25:55 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id k10-20020a4ad10a000000b004756ab911f8so10794921oor.2;
        Wed, 05 Oct 2022 06:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWhd70Afc7tVDYBjFfepu2mFaL/68srb2eh+QDcysFs=;
        b=F7fZR7sQovX5pUpe079pTEZzrk1JhOYtRaXR9HaxBUW0E3+fCneUHVrRgrmux5w+OP
         je0t3Qx2GpC7kie8PHDeFVZ9pJWwPDn7Y7hf+kb81KCN0+3BvZSw/bI0j0Y+SyYsddD4
         bK+910J82YIX/hCwnAdQe1nPApPoIcuTdyVJnG4sz8CCwQUpdrkEkrRTzCElKjUJSe/f
         dOcad8os1qCIGX9hfieIOErMq4vIQPSb72V9QNGFv3L5zrKCZRIJhdOFu8jrZU5itugY
         4dVb0CVzl/rq/CyOHSoNF58vMCHrOJxPs7AokB59gWiflUVEeVJfcY/9kZzjkbHL08bu
         YF8Q==
X-Gm-Message-State: ACrzQf0CFcZoNC9tKxAt6jm88YALpsb+KVbuSVeXy1oW4hjdCWDkN4vC
        i9U5rJoKKXEReCfu1Qc5Vw==
X-Google-Smtp-Source: AMsMyM7IKRwPFl+GPm7zHSQDesAg/+Ligdrzpn63p7q7WIOuUCgcWKm/5h01yvyIwh2VSxvU6zr8Lw==
X-Received: by 2002:a05:6830:13d0:b0:655:cad8:e57 with SMTP id e16-20020a05683013d000b00655cad80e57mr11964202otq.156.1664976354874;
        Wed, 05 Oct 2022 06:25:54 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id p13-20020a0568708a0d00b001326b043f37sm3067514oaq.36.2022.10.05.06.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:25:54 -0700 (PDT)
Received: (nullmailer pid 3269294 invoked by uid 1000);
        Wed, 05 Oct 2022 13:25:53 -0000
Date:   Wed, 5 Oct 2022 08:25:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cristian Pop <cristian.pop@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: iio: addac: adi,ad74413r: improve
 example
Message-ID: <166497635241.3269243.6429715925575343020.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-2-krzysztof.kozlowski@linaro.org>
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

On Tue, 04 Oct 2022 13:56:36 +0200, Krzysztof Kozlowski wrote:
> Improve example by: dropping unrelated properties (status and cs-gpios)
> and using generic node name.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml          | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
