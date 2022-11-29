Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4863C11A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiK2Nc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiK2Ncv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:32:51 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588BB1FCC0;
        Tue, 29 Nov 2022 05:32:46 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142faa7a207so16937473fac.13;
        Tue, 29 Nov 2022 05:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4iiVFWfKqe3AZg8KwhTodtf8S1J/1Ncv2ons44PHnNo=;
        b=T72LQcqRcOiKw+owxb+yWTHM74ZLOZE+4UUJZTEyiN00vVER224XehClpg2/rA8yac
         LuCIKWAU/DK5cwzQxBgaNXj2mLiHfPyf/eqvfQCM+5Tsv9aGC8128LSNhQack/jCiIGh
         k/PY+elBh653ASzxkc372VQhRyX3GJQkMJYR+V8ubqdG6rsd+KKJB2LQICMtseYd5bRk
         ypaYiqC05iJNOu9BD+ci8B3RdNOGVYGLHyzrakOFZ23txcaePbj3j3of3Lj0X1Wigpz8
         Y+QdZ5wodPc+GLD4D25/bgljw2xS3+V5kNYzMLalgJJ35hRvU+Whm+u9HDRE7yDNq/C1
         HaCA==
X-Gm-Message-State: ANoB5plLmK+oCZmgYD7l3MWyU4QEbGEx9ARXHxoiZAjJ/0LDwqgx8y9i
        ZneuL9N9bW537zYOOv5cLA==
X-Google-Smtp-Source: AA0mqf5u4uZTI4F9Mbhj1HJmrc/ab9YlLeuoGYl3W18uowVQkPxjcL9LrXROGjAylWDDlvR3naQvWA==
X-Received: by 2002:a05:6870:1715:b0:143:d85f:987e with SMTP id h21-20020a056870171500b00143d85f987emr3035354oae.253.1669728765470;
        Tue, 29 Nov 2022 05:32:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05687088a300b0013cd709659dsm7379107oam.52.2022.11.29.05.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:32:45 -0800 (PST)
Received: (nullmailer pid 3502174 invoked by uid 1000);
        Tue, 29 Nov 2022 13:32:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221129103509.9958-5-hayashi.kunihiko@socionext.com>
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-5-hayashi.kunihiko@socionext.com>
Message-Id: <166972831755.3491712.465402006721841028.robh@kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: soc: socionext: Add UniPhier media I/O block
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


On Tue, 29 Nov 2022 19:35:05 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the media I/O block implemented on
> Socionext Uniphier SoCs. This block is implemented on LD4, sLD8, Pro4,
> and LD11 SoCs.
> 
> Media I/O block implemented on Socionext UniPhier SoCs is an integrated
> component of the stream type peripherals including SD, USB2.0, eMMC,
> and MIO-DMAC.
> 
> Media I/O block has a common logic to control the component.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../socionext/socionext,uniphier-mioctrl.yaml | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.example.dtb: mioctrl@59810000: 'reset' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.example.dtb: mioctrl@59810000: 'clock' does not match any of the regexes: '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221129103509.9958-5-hayashi.kunihiko@socionext.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

