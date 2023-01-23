Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE7678A23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjAWWDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjAWWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:03:06 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA37EF0;
        Mon, 23 Jan 2023 14:03:00 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-15085b8a2f7so15672236fac.2;
        Mon, 23 Jan 2023 14:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5gnKSeHBc10dxfCXcb3Hm2FMFQZs96XVW/q2bcyyPo=;
        b=LAmo9+DdpGbVEeSNDNdaO34e84nSK2oXkcAlNIcMJ+T1dtrUKcqQfUP/LXAuS59CGL
         QVEJyflBz6lbpx4x4wHb/u0FB3hWE/qd2yYt7OuCBgdXNSHe9xn5ZQwS6gqjOixak7N6
         X+BIiB8OdHiz2dxL6EPfvf46UEBkdsUBUW6uJDeRxtJ3r2RVmSLCDGUUYQwkbBDLzhaO
         wg8D4796l0iyXbTWeQvjY3hK0Q55j6KjAN6C6QW1EPaX5Fed1QTME9Z9a3ACnJzLGLsP
         +Q/QzxW+RJCAnqjSRzcftP0c8bwU0Y3jJwVjIsXaqnPujQfFMTg26LoFo3HH0xGRu/4c
         gA5A==
X-Gm-Message-State: AFqh2kply9X1eFv/5Z9g6Jn67AI78cQ9ZBzvwO1X9J5dxARgI4G7xE5W
        ef9LUt0pvldtPWYdFgVQ2DNfzYy6rw==
X-Google-Smtp-Source: AMrXdXvKo1bSqf18ggMU63pL7BT3j3RKr6AF3z3s8c/Dbds/nu571NBWI8Qu+zWG00GQqLvi9tJPPg==
X-Received: by 2002:a05:6870:d628:b0:15f:da23:18a9 with SMTP id a40-20020a056870d62800b0015fda2318a9mr6568923oaq.26.1674511379490;
        Mon, 23 Jan 2023 14:02:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a056871068b00b0014813cc4a51sm15785oao.29.2023.01.23.14.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:02:59 -0800 (PST)
Received: (nullmailer pid 2716964 invoked by uid 1000);
        Mon, 23 Jan 2023 22:02:58 -0000
Date:   Mon, 23 Jan 2023 16:02:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: document SPI dev
 compatibles
Message-ID: <20230123220258.GA2710799-robh@kernel.org>
References: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
 <20230120075618.153664-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120075618.153664-2-krzysztof.kozlowski@linaro.org>
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

On Fri, Jan 20, 2023 at 08:56:18AM +0100, Krzysztof Kozlowski wrote:
> Document existing SPI dev compatibles.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index b13f280f36fa..6d1dc1e2484a 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -65,6 +65,8 @@ properties:
>            - capella,cm3232
>              # CM3323: Ambient Light Sensor
>            - capella,cm3323
> +            # Cisco SPI Petra
> +          - cisco,spi-petra
>              # High-Precision Digital Thermometer
>            - dallas,ds1631
>              # Total-Elapsed-Time Recorder with Alarm
> @@ -169,6 +171,8 @@ properties:
>            - isil,isl29030
>              # Intersil ISL68137 Digital Output Configurable PWM Controller
>            - isil,isl68137
> +            # Linear Technology LTC2488
> +          - lineartechnology,ltc2488
>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
>              # 10 kOhm digital potentiometer with I2C interface
> @@ -227,6 +231,8 @@ properties:
>            - memsic,mxc6655
>              # Menlo on-board CPLD trivial SPI device
>            - menlo,m53cpld
> +            # Micron SPI NOR Authenta
> +          - micron,spi-authenta

Not a simple device and something we don't want to endorse:

https://lore.kernel.org/all/CAL_Jsq+2xGdPnrCnQwf12k37DeZxekS6-wp6qrp3iDa7WLWsCw@mail.gmail.com/

Rob
