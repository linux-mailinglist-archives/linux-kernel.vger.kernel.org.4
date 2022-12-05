Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DE6437E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiLEWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiLEWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:19:03 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481BEB7F2;
        Mon,  5 Dec 2022 14:19:03 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-14449b7814bso10238482fac.3;
        Mon, 05 Dec 2022 14:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ySpEzI3LQzyKP5SFmjnIEUidYwUn3LaQsLW2wzOlic=;
        b=NqECeUA8q9TyEhR6pehURSTFax1kqJrSdLUplhahw+Mrw+7aBC44NsmUNBcYYOXacQ
         an+5tfZqoiVHNQ7rHnqDhMkvR3bgwFXsS5NXnXjm4kvM2fiaBXIui44bNvGVyWiWCZsU
         xegNBI8iHaJjvDJlwLFbQYfxIF9UJ52gcUlneZpCUQC5mJ5kOLKBLUxCYMvKqp7ZLM4h
         /v7dKE6iwRXMbXEGkRtKuXngjSlivuAQgqrjs7svRNp4l/VsnAZWsWtyjGRT0YyaIQlO
         +m72E1k1wvc07nMHJyHLFm1iYzvuXAb7/YY1HmJipGW8ZSENgww0Hy20289KW9I6NUXR
         RVIA==
X-Gm-Message-State: ANoB5pmGp9O3Dy5ebtc7lPvpHU87fWRwvl5oLTNKpzXFJ4EPQKULM4XN
        kmOWyRloLT1rjzqT3j+hqTpoaJTfAA==
X-Google-Smtp-Source: AA0mqf5sKlDmqbc1Mk2eCLtA3OYLAM0/rM2OarTpliWs7h96bLKVsUX+Q6u4yogHFODJsSRgGzlrDw==
X-Received: by 2002:a05:6870:be9b:b0:144:a46f:e355 with SMTP id nx27-20020a056870be9b00b00144a46fe355mr3029486oab.95.1670278742535;
        Mon, 05 Dec 2022 14:19:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o25-20020a4ad159000000b0049f8801ed22sm7108506oor.30.2022.12.05.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:19:02 -0800 (PST)
Received: (nullmailer pid 2789606 invoked by uid 1000);
        Mon, 05 Dec 2022 22:19:01 -0000
Date:   Mon, 5 Dec 2022 16:19:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Sean Young <sean@mess.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: leds: irled: ir-spi-led: convert to DT
 schema
Message-ID: <167027872947.2789286.10887556404939879459.robh@kernel.org>
References: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
 <20221204104323.117974-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204104323.117974-3-krzysztof.kozlowski@linaro.org>
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


On Sun, 04 Dec 2022 11:43:23 +0100, Krzysztof Kozlowski wrote:
> Convert the SPI IR LED bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/irled/ir-spi-led.yaml       | 61 +++++++++++++++++++
>  .../bindings/leds/irled/spi-ir-led.txt        | 29 ---------
>  2 files changed, 61 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt
> 

Applied, thanks!
