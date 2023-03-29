Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA46CF577
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjC2Vkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC2Vkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:40:33 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F543C3B;
        Wed, 29 Mar 2023 14:40:32 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id r14so7062917oiw.12;
        Wed, 29 Mar 2023 14:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126032;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/qJzs/hW1pmjhUHORKknf7d39R3TDMqbem1vTF6rpE=;
        b=upXT3YGycA3MdO2RxV8X0Saw4DfWqH0es4Fa1QRAhlQ10iru6SSaRkdeTGLMKdJJdy
         Jct5VxIr87A0zwuoQtex6n3XgL+Z8m5plWgVBF6+xEyX7OlMdr43ljCiFUwYqIOdvJO1
         vkCZ+lvLpzvEWs9U+Mlu2CB19s8sCEEVUzRS91CGiW6BgYXTdB18sTCgbhUTUFN11k7M
         HMXlkNV9+DT5tczjGPi1S4OQR0gY/f0+g8ext7dERO99kI5E1pKHeEuG9mJQYshoi4Bp
         MlCHh6GJe3ZdrfhWTyTX+I3kFtBzPIj2U7pg1DRvsWlzMjOWfW199T0/vwUiTCFd+KQl
         gmEA==
X-Gm-Message-State: AO0yUKWqlXGiKMaf74jPtZvsL65Beaygk6eMEPxUKyCEaUKDpBZAeNLA
        ag2FXpzVgNjfsIb+7jo7Gw==
X-Google-Smtp-Source: AK7set8HqExr54n7KB+fv5GbG1F5mEostBq+sitshFffuWryo7IxT/gigISCoOi3ymblpK2cBSZfTg==
X-Received: by 2002:a05:6808:984:b0:387:7b92:8b97 with SMTP id a4-20020a056808098400b003877b928b97mr8519158oic.43.1680126031713;
        Wed, 29 Mar 2023 14:40:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n67-20020acabd46000000b0038919e6eb5esm4278794oif.3.2023.03.29.14.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:40:31 -0700 (PDT)
Received: (nullmailer pid 112250 invoked by uid 1000);
        Wed, 29 Mar 2023 21:40:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Jason Smith <jason.smith@ni.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20230329154235.615349-2-brenda.streiff@ni.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-2-brenda.streiff@ni.com>
Message-Id: <168012595979.110912.13924121978276239170.robh@kernel.org>
Subject: Re: [PATCH tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Date:   Wed, 29 Mar 2023 16:40:30 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Mar 2023 10:42:34 -0500, Brenda Streiff wrote:
> Add bindings for the NI 16550 UART.
> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>
> ---
>  .../bindings/serial/ni,ni16550.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/ni,ni16550.example.dtb: serial@80000000: compatible: ['ni,ni16550', 'ns16550a'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/ni,ni16550.example.dtb: serial@80000000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/ni,ni16550.example.dtb: serial@80000000: compatible: 'oneOf' conditional failed, one must be fixed:
	['ni,ni16550', 'ns16550a'] is too long
	['ni,ni16550', 'ns16550a'] is too short
	'ns8250' was expected
	'ns16450' was expected
	'ns16550' was expected
	'ns16550a' was expected
	'ns16850' was expected
	'aspeed,ast2400-vuart' was expected
	'aspeed,ast2500-vuart' was expected
	'intel,xscale-uart' was expected
	'mrvl,pxa-uart' was expected
	'nuvoton,wpcm450-uart' was expected
	'nuvoton,npcm750-uart' was expected
	'nvidia,tegra20-uart' was expected
	'nxp,lpc3220-uart' was expected
	'ni,ni16550' is not one of ['exar,xr16l2552', 'exar,xr16l2551', 'exar,xr16l2550']
	'ni,ni16550' is not one of ['altr,16550-FIFO32', 'altr,16550-FIFO64', 'altr,16550-FIFO128', 'fsl,16550-FIFO64', 'fsl,ns16550', 'andestech,uart16550', 'nxp,lpc1850-uart', 'opencores,uart16550-rtlsvn105', 'ti,da830-uart']
	'ni,ni16550' is not one of ['ns16750', 'cavium,octeon-3860-uart', 'xlnx,xps-uart16550-2.00.b', 'ralink,rt2880-uart']
	'ni,ni16550' is not one of ['nuvoton,npcm845-uart']
	'ni,ni16550' is not one of ['ralink,mt7620a-uart', 'ralink,rt3052-uart', 'ralink,rt3883-uart']
	'ni,ni16550' is not one of ['mediatek,mt7622-btif', 'mediatek,mt7623-btif']
	'mrvl,mmp-uart' was expected
	'ni,ni16550' is not one of ['nvidia,tegra30-uart', 'nvidia,tegra114-uart', 'nvidia,tegra124-uart', 'nvidia,tegra210-uart', 'nvidia,tegra186-uart', 'nvidia,tegra194-uart', 'nvidia,tegra234-uart']
	'ralink,rt2880-uart' was expected
	'mediatek,mtk-btif' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/ni,ni16550.example.dtb: serial@80000000: Unevaluated properties are not allowed ('compatible', 'transceiver' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/8250.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230329154235.615349-2-brenda.streiff@ni.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

