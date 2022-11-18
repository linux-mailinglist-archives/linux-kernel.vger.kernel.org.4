Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49062EC90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiKRD4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbiKRD4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:56:16 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4AF769DF;
        Thu, 17 Nov 2022 19:56:15 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so614219ooi.5;
        Thu, 17 Nov 2022 19:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tfxi4m72wJDyyyRk1r1gIS4usq7HPix4iuACaDy6u/8=;
        b=DenoY+XB54pUL5koOEVGOCWkcSZY/POLPhYm6ChexKeEMNZjmWsAYnR9ronZwffuL+
         40GkaAi6KKxURO8n7TtqEu1Pbl9cSRBePc03ctq7XACsKcX6o4DXQLdPh0EX8ODc1Evn
         YdaNaAryzo5gv48cwjSHcO9zwH9Pz3QGf1M7MQn5MFlz4V4c/qVzNPoU9Ii4FUldM2an
         XFD1vxvmi2KgnEuWkhfDk1IBq17/dIcFZWC+YFFV8ym0+lrT9e59iTZWKj2UdsWNAzOJ
         qMjL4budHrnOdNB9hWrMMvFFCqaHQ4Ydge/IMXrLO3bAaYSTJrk5Elr87dVG/Jg2UPCs
         B7Lg==
X-Gm-Message-State: ANoB5plB1IZ0oazyIZEahT7vzKeokD0t54OWlfjhkIDxVQ952t+Zke0w
        ty5BwmNN0ZYFVTdGrTWu4Q==
X-Google-Smtp-Source: AA0mqf7N7myWgaJT6ZUUlriqZmuzPomf0ckaoERhMXeGZBOJTOq3ZutJEDELIXaz1RGOFiNZqsXuxA==
X-Received: by 2002:a4a:aece:0:b0:48b:f37a:c28f with SMTP id v14-20020a4aaece000000b0048bf37ac28fmr2735429oon.36.1668743775080;
        Thu, 17 Nov 2022 19:56:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g38-20020a9d2da9000000b0066cc0525476sm1090311otb.75.2022.11.17.19.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:56:14 -0800 (PST)
Received: (nullmailer pid 397831 invoked by uid 1000);
        Fri, 18 Nov 2022 03:56:14 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20221118011108.70715-3-hal.feng@starfivetech.com>
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-3-hal.feng@starfivetech.com>
Message-Id: <166874355750.392596.1548443526558920682.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl
Date:   Thu, 17 Nov 2022 21:56:14 -0600
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


On Fri, 18 Nov 2022 09:11:05 +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC sys pinctrl controller.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-sys-pinctrl.yaml  | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.example.dts:21:18: fatal error: dt-bindings/clock/starfive-jh7110.h: No such file or directory
   21 |         #include <dt-bindings/clock/starfive-jh7110.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221118011108.70715-3-hal.feng@starfivetech.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

