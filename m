Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F9A63157C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 18:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKTR1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKTR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 12:27:23 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7629C23BC0;
        Sun, 20 Nov 2022 09:27:22 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-141ca09c2fbso11396201fac.6;
        Sun, 20 Nov 2022 09:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psr43w/KwYpCS09PSnvsr6T/BOSKuDQbf/f9YtbaYyM=;
        b=kv2L+VxCTb8uRw2Bms2auLFSqWKY/KkyL3UIyZNXYgRAXW/DeiijEilWF7gB1HqxSE
         poh6oCo7Fk+ptzjxf/9BQ7XMezttTBM/nV7XoopSKyDtknzynbu8/a9QQvRcI6NLYM4k
         BzvlfoWoCifFz5rRSK3QQlgcl5Ih80QtpmBgvQAzK5JOjwQviP/AHrhj3Jf2rvA2YKYk
         GPTDtHPiNTU3I+pTBxhl90CGQzk+KN8NrxBN6YAUwNzCB+HT4n5kSD5unS++eQN40ROQ
         4oRnQV4UuaFLY+CeVEzX6CMZNX5/mhH3tilyqYnjNX3e8F93Vhj/MqDKbE3ZBhnWtQo6
         mEfw==
X-Gm-Message-State: ANoB5pl+N2jfghR12IDMY3m4xiap0DuPEQR0G0xsduNYIhGTc934mr5/
        15n0dT6HzVs8psopXUEwiQ==
X-Google-Smtp-Source: AA0mqf64hyvtqeROaDRbdlYaX4sITQ6nML+AL8AWNYiaz+na1pOcPZOwYnk8alXGVc31DPju9buvKg==
X-Received: by 2002:a05:6870:3843:b0:131:db21:c62a with SMTP id z3-20020a056870384300b00131db21c62amr1251138oal.214.1668965241710;
        Sun, 20 Nov 2022 09:27:21 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:5cb3:df5a:23c3:86fb:15a6])
        by smtp.gmail.com with ESMTPSA id t21-20020a056870f21500b0010d7242b623sm4907785oao.21.2022.11.20.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 09:27:21 -0800 (PST)
Received: (nullmailer pid 3227469 invoked by uid 1000);
        Sun, 20 Nov 2022 17:27:22 -0000
Date:   Sun, 20 Nov 2022 11:27:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: addac: add AD74115
Message-ID: <166896524133.3227417.14306497239130014722.robh@kernel.org>
References: <20221117080916.411766-1-cosmin.tanislav@analog.com>
 <20221117080916.411766-2-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117080916.411766-2-cosmin.tanislav@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Nov 2022 10:09:15 +0200, Cosmin Tanislav wrote:
> The AD74115H is a single-channel, software-configurable, input and
> output device for industrial control applications. The AD74115H
> provides a wide range of use cases, integrated on a single chip.
> 
> These use cases include analog output, analog input, digital output,
> digital input, resistance temperature detector (RTD), and thermocouple
> measurement capability. The AD74115H also has an integrated HART modem.
> 
> A serial peripheral interface (SPI) is used to handle all communications
> to the device, including communications with the HART modem. The digital
> input and digital outputs can be accessed via the SPI or the
> general-purpose input and output (GPIO) pins to support higher
> speed data rates.
> 
> The device features a 16-bit, sigma-delta analog-to-digital converter
> (ADC) and a 14-bit digital-to-analog converter (DAC).
> The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> be used as the DAC and ADC reference.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/addac/adi,ad74115.yaml       | 373 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 380 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
