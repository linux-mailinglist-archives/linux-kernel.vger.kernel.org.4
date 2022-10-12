Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931B5FC92E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJLQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJLQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:25:24 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234925FAD2;
        Wed, 12 Oct 2022 09:25:21 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so12481359ooi.5;
        Wed, 12 Oct 2022 09:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbGkRBfc7blEHX2oiLr1yUH1nf0Co3xQFCa79h+BBRk=;
        b=o3Bk6hLFr1DNT8JRxe5OAUis+w4HBwv2oe5DErzvQPVxWeou0OgYqvQVz3LWRN+/Oe
         jno6N1B2q/kIQsp0VFQLbU0vP9c/5bIqF4LlAIDX6eUY4zrRT/nykH99211JDwyQs59Y
         0bdT1hwmBPxfYxBY13Qo1sqZ1N2S+XKyu0Fc9ESOinJOXyV7VF5kPR5njtqYE7m3Nm2w
         XAButS+a3iY6H2fiEkKtNGM/hiDpOhC8/941KUnvzJ8LVAdwOSIZdZih3tv1hEDfa2ye
         UCGtRSkQoY/sgGc46zMnEeziW6sL2XI5j0aYsNNtf16ZKa/n3/QSWmsYVzFyjdtyknTQ
         RmeQ==
X-Gm-Message-State: ACrzQf1njzWTtR0Hm/QUjQdBNV3pPvOS99i6lrk5QTmg71kljY6I7WGv
        xMRMVZ0wTX9pcAie9muA4Q==
X-Google-Smtp-Source: AMsMyM5WZKYN3WOatUVAQahyGG5zpQ2QpJ9rGf1419QBSTH+VPlsKqDKNZYOHp9EcGV1Saa4zwhNsA==
X-Received: by 2002:a05:6830:34a5:b0:661:a0a5:b0f with SMTP id c37-20020a05683034a500b00661a0a50b0fmr6481648otu.165.1665591920378;
        Wed, 12 Oct 2022 09:25:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b6-20020a9d4786000000b00661b019accbsm1876633otf.3.2022.10.12.09.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:25:19 -0700 (PDT)
Received: (nullmailer pid 2286501 invoked by uid 1000);
        Wed, 12 Oct 2022 16:25:21 -0000
Date:   Wed, 12 Oct 2022 11:25:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 2/8] dt-bindings: iio: adc: stm32-adc: add stm32mp13
 compatibles
Message-ID: <166559192047.2286466.15301667518001122082.robh@kernel.org>
References: <20221012142205.13041-1-olivier.moysan@foss.st.com>
 <20221012142205.13041-3-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012142205.13041-3-olivier.moysan@foss.st.com>
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

On Wed, 12 Oct 2022 16:21:59 +0200, Olivier Moysan wrote:
> Add st,stm32mp13-adc-core and st,stm32mp13-adc compatibles
> to support STM32MPU13 SoC.
> 
> On STM32MP13x, each ADC peripheral has a single ADC block.
> These ADC peripherals, ADC1 and ADC2, are fully independent.
> 
> Main characteristics of STM32MP13x ADC:
> - One interrupt line per ADC
> - 6 to 12 bits resolution
> - 19 channels
> 
> ADC2 instance supports two extra internal channels VDDCPU and VDDQ_DDR.
> Add "vddcpu" and "vddq_ddr" internal channels names to the reserved
> labels list.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 68 ++++++++++++++++++-
>  1 file changed, 65 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
