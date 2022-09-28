Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF495EDCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiI1Miy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiI1Mip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:38:45 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC5265B;
        Wed, 28 Sep 2022 05:38:44 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1280590722dso17093321fac.1;
        Wed, 28 Sep 2022 05:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=izGymghuYlLW90ZqTUFVA6hxBsKrpDP7tl21fb5fyRU=;
        b=WYStW8AlNj+qfl4X7l8NHjbai0KGgiVTbN2/8sFl4khNxNaUK5GuZfa45zgWwmyg08
         TPKBeqKdh56xUmPps/xnM5qhijWwExTYcLAEmS1v2yyAissvoHOU61wCsVn9JzN1h8eo
         bApwrFxXdb1AqFNvOkEULX6iUgw0wh5Cb12lcVXZGQdqPnLScpJcQbYg6w7hf0DJqmFk
         FOs/cS+zF+7maBl/CVnSi0dH7d5Ldta6+k70fw7YcfLWbVBVCJMh24y3lggUT/fYUMiS
         JL/vu/FlXr4qvLv8qlgqQ2D3dWxwjdV1Iiw99SWtWc3KXJSlRAryZiwm4e9+ymAb2E3w
         DEKg==
X-Gm-Message-State: ACrzQf3vo+S7T4C6nXwZCHbuy5WmV3XMQHJ+ZrmhyYDRMJTFlssu6arL
        XxFLnFYsalI2swpgGvwB1A==
X-Google-Smtp-Source: AMsMyM7qqzHW98WUHbsO2svepBG1a/Wd3CJ2lhpiV2OIPCcqaXGou3x3POtLT84CMLdn84MUJOdD2Q==
X-Received: by 2002:a05:6870:ea84:b0:10d:fabe:9202 with SMTP id s4-20020a056870ea8400b0010dfabe9202mr5132680oap.294.1664368723383;
        Wed, 28 Sep 2022 05:38:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z89-20020a9d24e2000000b00636eeba9209sm2007154ota.52.2022.09.28.05.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:38:42 -0700 (PDT)
Received: (nullmailer pid 4136677 invoked by uid 1000);
        Wed, 28 Sep 2022 12:38:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220928083702.17309-2-zhuyinbo@loongson.cn>
References: <20220928083702.17309-1-zhuyinbo@loongson.cn> <20220928083702.17309-2-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal binding
Date:   Wed, 28 Sep 2022 07:38:41 -0500
Message-Id: <1664368721.036656.4136676.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 16:37:01 +0800, Yinbo Zhu wrote:
> Add the loongson2k thermal binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v5:
> 		1. Keep use same quotes "'" in all places.
> 
>  .../thermal/loongson,ls2k-thermal.yaml        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.example.dtb: thermal-sensor@1fe01500: reg: [[0, 534779136], [0, 48]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

