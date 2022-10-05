Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4DF5F555F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJEN1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJEN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:27:34 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8753C7A502;
        Wed,  5 Oct 2022 06:27:30 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id r186so1765138oie.4;
        Wed, 05 Oct 2022 06:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E99x76W58jVvi7Q5ED8aBXNSzflWaYxVZJZYp3TwOiE=;
        b=srLRJ3qtfQ+VIvOEPpz75+g47oHwheXQZ9Rl6p9TFzmanlR1xf0i7LRPD8x8GnsmJo
         Zfy9RWyUK74z/+vFgscKkZBOANWYA729qM28O7iMf/ARagx9eQ2iNlAJrZXDjN4XXO6C
         theMJ2UzRU1AcsfHo37vp7O/xfWeDWeUtU9gUyuJb0/eRJIaEwjS88daJ1e7EC1lhCvS
         SPiMRoPiyKdf7sVt3bXptMCrwTRBZC8uWMLI/YxmGpD55x9Mh/SfS0VNTpITdIQcxS4Z
         epwID5eOGWz+r0OU9pm52tJqW2QI3Uhz1ZZ5+2VSGo3S5Qrh/kgKs0xdL/JQHrY9wogc
         39Vw==
X-Gm-Message-State: ACrzQf0jBGg641ePlrcR34A3lp3Tc1I8VVUysMMsz/5l13NMlfsnHDQ7
        cN1KzytA7EWuoWJdwDw5kg==
X-Google-Smtp-Source: AMsMyM7aN/6vhh9HQ0i74lFw4YtPqOrlTGwKmFrvdrePWBEYZXDYdOd+0SZk9y4kWoSyD5OcKKgmsg==
X-Received: by 2002:aca:190e:0:b0:34f:6cfb:b152 with SMTP id l14-20020aca190e000000b0034f6cfbb152mr2218382oii.270.1664976448002;
        Wed, 05 Oct 2022 06:27:28 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id o1-20020a056808124100b00350c5d946casm4268155oiv.4.2022.10.05.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:27:27 -0700 (PDT)
Received: (nullmailer pid 3271664 invoked by uid 1000);
        Wed, 05 Oct 2022 13:27:26 -0000
Date:   Wed, 5 Oct 2022 08:27:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 8/8] dt-bindings: iio: resolver: adi,ad2s90: use
 spi-peripheral-props.yaml
Message-ID: <166497644557.3271594.2439707684962713845.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004115642.63749-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 13:56:42 +0200, Krzysztof Kozlowski wrote:
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
>  .../devicetree/bindings/iio/resolver/adi,ad2s90.yaml       | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
