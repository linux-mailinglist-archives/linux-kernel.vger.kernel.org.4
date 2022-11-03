Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5F617CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiKCMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiKCMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:35:54 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEC9BF44;
        Thu,  3 Nov 2022 05:35:48 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13b23e29e36so1928774fac.8;
        Thu, 03 Nov 2022 05:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swk/OiKVstVSBR4f7TzyH2j5DF+ZMxXZNAXmMO2doNA=;
        b=fUMVw4qIj3sGC2ASzbHPuM/ccCzMOWxIlkwayQcIJYpJs/YVSNh4ueXOUiGMZ3eEqQ
         Xi0vhAE0EBoTgPv4Vb7G/b0qetbcHEX2G/RbDPPrt5wIbn6cKp34KUI6mjgGkV1TUqsv
         U7Wn2CCzm3HpT/Zx1iUK9FfKg+SafnuWemkBWgByY2eYaWX9WU5taUCtprjYXmOTxaRf
         7QJrd0vmuMEJfvIKZ1avku6hdEvwnvrrUnoHFsQ+vxrcHCSNMaitobBlSE4K2s/X5GnE
         eJX0OnKFspA1ldEpas9YYeLt6jF5TJNddeUpgcBKC+Sk0m2l4zjbG+5kgc//fGaN1Rkb
         FDEA==
X-Gm-Message-State: ACrzQf0s4H6pEtxq1lP3bx5TdwWhh5z5CtAgPg21mb9i+L4GIOZXLhGa
        ijdRc/P56EP96dNaG8gyXA==
X-Google-Smtp-Source: AMsMyM7nAh3H/bFuoxY/59xmkSmzwYtWN6o+qSWjjQyX+E9MsKFooWl0HjQVtzKHj5HYXpng3FnHDA==
X-Received: by 2002:a05:6870:3409:b0:13b:5dee:40d with SMTP id g9-20020a056870340900b0013b5dee040dmr28382119oah.121.1667478947553;
        Thu, 03 Nov 2022 05:35:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a056808056f00b0035956747d07sm338238oig.17.2022.11.03.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:35:47 -0700 (PDT)
Received: (nullmailer pid 2140214 invoked by uid 1000);
        Thu, 03 Nov 2022 12:35:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net, kernel@pengutronix.de,
        Anson.Huang@nxp.com, linux-imx@nxp.com
In-Reply-To: <20221103100358.176099-3-andrej.picej@norik.com>
References: <20221103100358.176099-1-andrej.picej@norik.com>
 <20221103100358.176099-3-andrej.picej@norik.com>
Message-Id: <166747792333.2121983.3197860057328686578.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: watchdog: fsl-imx: document suspend
 in wait mode
Date:   Thu, 03 Nov 2022 07:35:43 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 11:03:57 +0100, Andrej Picej wrote:
> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
> set and the device is put into Suspend-to-Idle mode, the watchdog
> triggers a reset after 128 seconds.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes in v3:
>  - disallow the property for devices which don't support WDW bit
>    functionality with .yaml DTS allOf:if:then scheme.
> 
> Changes in v2:
>  - add a commit message,
>  - add a list of devices which support this functionality
> ---
>  .../bindings/watchdog/fsl-imx-wdt.yaml        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml:71:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.example.dts'
Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml:71:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml:71:1: found duplicate key "allOf" with value "[]" (original value: "[]")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

