Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87D711CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbjEZBnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjEZBnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:43:51 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060B8189;
        Thu, 25 May 2023 18:43:50 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-332cc0efe88so2157245ab.0;
        Thu, 25 May 2023 18:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685065429; x=1687657429;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jTbmei8zqNqJ6frj0t/x/Tx2m7WrK7chTEbcHeVjzc=;
        b=TgUxA1aooqJTU1EfOZAVmujBbAE28R5RO/8Gb0DJ3zjbzS5e2Fe/+F1iXbCGqZ/W6E
         knsQD0CcX3daecXSo+woAcEeVfbERidthGn8UdvRUolMTruFAgUyDIeoU6Q68Kkm06Se
         YmL4iYW0oGHTaCfWGb/sEzUf53hpG6DEt1730m/yc+8AML99uh3C+hSuC4KC5NGvgFYt
         xT5gWTYptGsUuJm8qTh5KMK6imNzQUMO7wiDMcgQdT6TNKjjDz4j+4TnrX7+JqCUl+FC
         yUPzNsVyun0xtMYAl3AC9PRYb0Emku643eLBMhFDrlf19iCyWCnxA/riCwNVN2kHFKrY
         5FCg==
X-Gm-Message-State: AC+VfDzZ5w+SPi+i4cFveE+sCmaj7nbk/T9/K1F0i43Xy698Dv5a+Rqa
        HYioxZrM1FcgYq8JBI53QEqy/sKlxg==
X-Google-Smtp-Source: ACHHUZ4mS4hoJfgLvJTFnnbs2sA7i4TntiUO4ePPO2oes6Cyc2vmxW7GJV8Ieo/h2mexGehk3bggwQ==
X-Received: by 2002:a92:c088:0:b0:331:55d1:92e with SMTP id h8-20020a92c088000000b0033155d1092emr263928ile.17.1685065429134;
        Thu, 25 May 2023 18:43:49 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p9-20020a056e0206c900b0033a4f125238sm670551ils.41.2023.05.25.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:43:48 -0700 (PDT)
Received: (nullmailer pid 3169 invoked by uid 1000);
        Fri, 26 May 2023 01:43:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     conor+dt@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        wim@linux-watchdog.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        daniel.lezcano@linaro.org, linux@roeck-us.net, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, sebastian.reichel@collabora.com,
        alexandre.belloni@bootlin.com
In-Reply-To: <20230525125602.640855-2-claudiu.beznea@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-2-claudiu.beznea@microchip.com>
Message-Id: <168506542288.3082.3027996857307148198.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Date:   Thu, 25 May 2023 20:43:44 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 May 2023 15:55:58 +0300, Claudiu Beznea wrote:
> Convert Atmel PIT to YAML. Along with it clock binding has been added as
> the driver enables it to ensure proper hardware functionality.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt |  6 ---
>  .../bindings/timer/atmel,at91sam9260-pit.yaml | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.example.dts:29.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230525125602.640855-2-claudiu.beznea@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

