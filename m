Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5B63C11B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiK2NdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiK2Ncv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:32:51 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0C201AC;
        Tue, 29 Nov 2022 05:32:49 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-142306beb9aso16957025fac.11;
        Tue, 29 Nov 2022 05:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=078KT6G+wH0UuuDUi7kcABLb3n5DFpuFtEI+9h83yzI=;
        b=vaqo9kt7E+wkKk3fVQCueoNs+kJsJTCLehurZC2TUJiJTBCuTa0oT6x0rKtYip6Dic
         d+2nKHrWaIVRoeAvngilG7sAVOqa4KsIlhWn8JBJuvnCF+Ovy9Zn9QN0V93y2+ofS/Y9
         oUq2mcGCYgMQauP1eUpcn79FpC+hsHND/GY9j5fBfHbbiEA8pjoJBOmqG5Xs/r6irhIT
         ZXibxMrZ3yEVeXUURu/FyCN4NHtbkzYizm5hphACCMdDI0hq8qoCa+wuMCqtvsuFCcYD
         UU77XjfbuJRE0QLNETuWkLjGG65YEpuEdTTjs6ZsHYsLHaYHLWWe6CuqSD1/M5ktp3oz
         SV5A==
X-Gm-Message-State: ANoB5pnXSKPBUM18RXac6UFNnt1g8u5hzBdiqXFnQ3+GBkKCkMLWfd2G
        VfDuORJaA1fHvVU4XGhZG0BbqQa5cw==
X-Google-Smtp-Source: AA0mqf4CripRYZLxawuRgtTgf4Xl/2U1GqQbbu1qg6cK2ub0mH5Y80wc7c//ISCeeYF5JAb2UC7N/g==
X-Received: by 2002:a05:6870:591:b0:13b:bbbb:1623 with SMTP id m17-20020a056870059100b0013bbbbb1623mr23688432oap.115.1669728768309;
        Tue, 29 Nov 2022 05:32:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h9-20020a4a6b49000000b0049e9a80c690sm5467169oof.1.2022.11.29.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:32:48 -0800 (PST)
Received: (nullmailer pid 3502176 invoked by uid 1000);
        Tue, 29 Nov 2022 13:32:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221129103509.9958-7-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-7-hayashi.kunihiko@socionext.com>
Message-Id: <166972831827.3491751.8381244533390131696.robh@kernel.org>
Subject: Re: [PATCH 6/8] dt-bindings: soc: socionext: Add UniPhier ADAMV block
Date:   Tue, 29 Nov 2022 07:32:43 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2022 19:35:07 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the ADAMV block implemented on Socionext
> Uniphier SoCs.
> 
> The ADAMV block is analog signal amplifier that is a part of the external
> video and audio I/O system. This block is implemented on LD11 and LD20,
> and this is defined for controlling audio I/O reset only.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-adamv.yaml   | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.example.dtb: adamv@57920000: 'reset' does not match any of the regexes: '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129103509.9958-7-hayashi.kunihiko@socionext.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

