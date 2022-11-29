Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2DC63C116
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiK2Ncy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiK2Ncu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:32:50 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B71B1F6;
        Tue, 29 Nov 2022 05:32:45 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id b126so633530oif.5;
        Tue, 29 Nov 2022 05:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Dqnv8r9E4SOqT5MnYncyhX8Zlx698nGwahfeMi3XgU=;
        b=Q2Ui23xR2bGmDClRkr33t6DAVhaFl5lCV8cDGkY16Wez4c+0PsLsKAELbbY67y/UHK
         0M4xA0cjInWf/9KII+sfLiXQWuqV8Gc3Hk1t4rwyf+pLD828OGwclpjQgF7ZqlpqW9LY
         gokFdfN30puqTxvblGEePJEHvd9QH12yutFHdlgz2OW7V2et/jZlTD6mHF7ygNik8vrV
         JmlwVsfdCDbWSFSnmuLccfwsXoCWl59RMNyhY+SLbxc9YDtuPe7jqHd4VpICsxkOjWiG
         ORX9pw+tCEAmt41r10gY2lRqL8yhKF/u16bPKKN9QNJzrVHSBXbwdsxiWdp66aaMbQM1
         zRGw==
X-Gm-Message-State: ANoB5pnxTowKQKtLFW4afSk6EDqUFZrsPIjIVC/NGrfiNe1+AweSfgAZ
        k/ueXWDRu1j72/YDe4TGiw==
X-Google-Smtp-Source: AA0mqf6OD3N8JIPBwAzKOX2Zj5clO9L8dgv85KoOOetLzymoOgKFQXmWfIHH96Jy9F4ODi1AzJwsLQ==
X-Received: by 2002:a05:6808:178b:b0:35a:10ae:ed71 with SMTP id bg11-20020a056808178b00b0035a10aeed71mr17940916oib.299.1669728764403;
        Tue, 29 Nov 2022 05:32:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a9d4b01000000b0066cc88749f8sm5825915otf.68.2022.11.29.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:32:44 -0800 (PST)
Received: (nullmailer pid 3502169 invoked by uid 1000);
        Tue, 29 Nov 2022 13:32:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
Message-Id: <166972831611.3491633.12623641765426899291.robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: soc: socionext: Add UniPhier system controller
Date:   Tue, 29 Nov 2022 07:32:43 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2022 19:35:02 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the system controller implemented on
> Socionext Uniphier SoCs.
> 
> This system controller has multiple functions such as clock control,
> reset control, internal watchdog timer, thermal management, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-sysctrl.yaml | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.example.dtb: sysctrl@61840000: 'reset' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', '^thermal-sensor(@[0-9a-f]+)?$', '^watchdog(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.example.dtb: sysctrl@61840000: 'thermal' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', '^thermal-sensor(@[0-9a-f]+)?$', '^watchdog(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.example.dtb: sysctrl@61840000: 'clock' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', '^thermal-sensor(@[0-9a-f]+)?$', '^watchdog(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129103509.9958-2-hayashi.kunihiko@socionext.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

