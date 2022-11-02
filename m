Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45716168CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKBQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKBQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:28:47 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A1BC5;
        Wed,  2 Nov 2022 09:24:38 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12c8312131fso20861229fac.4;
        Wed, 02 Nov 2022 09:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TymtfC49QCmqyHl8QfkMefC0X7Dx2Oap8HRgSBbJllo=;
        b=N2FIY1pr8kZ82475fo9dmgGGIa2TJA/MMbB2t/736CTRjAnIYkxB5wJqbzvA+6zYYm
         /J8zrzUveTrh4TRnEm5sgQz3SDzn4dqukXoR10okCf/oMVD7vyFnxjW7ZfTY0dIHRz+p
         MasDFMHLu5nIpA0qf82w4MS2KmWlv6Kj8sLvpCydqL4bVU7atdmkbGn/wKkKw/elyOG1
         2ct/SLjUmgwlhri59mH6tYUAW0UlDwAqTNPRFNo5P3lM4QrCtfP/plWsDaJMZYJqk9EL
         8KWfV70b91AnT2s1r4Ku5/XjMkhwbW50sjzhJiZhxITp0aBHoWnEJxHgWi8k/NXdTIT2
         8DPQ==
X-Gm-Message-State: ACrzQf3pjQvzKxv5vhN/t6DWteftgXmIqQXv2TD+5nwXsSstXSnCwq6N
        KNPAoKKoN3UcpHkk8GUT6A==
X-Google-Smtp-Source: AMsMyM6h/TEdVbnmz3cAGb9ZgLtOAdeHBDX+uj0jE4B4sLIw7YTn9d735BJOdrhMxnqs7TAuN7Ktrw==
X-Received: by 2002:a05:6871:9f:b0:131:52e5:fe7b with SMTP id u31-20020a056871009f00b0013152e5fe7bmr15173055oaa.80.1667406277603;
        Wed, 02 Nov 2022 09:24:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e8-20020a544f08000000b00354b575424csm4682216oiy.29.2022.11.02.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:24:37 -0700 (PDT)
Received: (nullmailer pid 3998144 invoked by uid 1000);
        Wed, 02 Nov 2022 16:24:38 -0000
Date:   Wed, 2 Nov 2022 11:24:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 3/4] dt-bindings: amlogic: document Odroid Go Ultra
 compatible
Message-ID: <166740627837.3998090.4730126926923594945.robh@kernel.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
 <20221031-b4-odroid-go-ultra-initial-v1-3-42e3dbea86d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-3-42e3dbea86d5@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 17:47:27 +0100, Neil Armstrong wrote:
> This documents the Odroid Go Ultra, a portable gaming device,
> with the following characteristics:
> - Amlogic S922X SoC
> - RK817 & RK818 PMICs
> - 2GiB LPDDR4
> - On board 16GiB eMMC
> - Micro SD Card slot
> - 5inch 854×480 MIPI-DSI TFT LCD
> - Earphone stereo jack, 0.5Watt 8Ω Mono speaker
> - Li-Polymer 3.7V/4000mAh Battery
> - USB-A 2.0 Host Connector
> - x16 GPIO Input Buttons
> - 2x ADC Analog Joysticks
> - USB-C Port for USB2 Device and Charging
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
