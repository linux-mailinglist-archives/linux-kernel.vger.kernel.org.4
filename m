Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C995B5BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiILOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiILOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:14:42 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E1B86E;
        Mon, 12 Sep 2022 07:14:39 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1278a61bd57so23697169fac.7;
        Mon, 12 Sep 2022 07:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zjUBlDf7L9Ynqi1H6fGKN/mNwcz/H/7eLC0Jbu7Mkrc=;
        b=MVz5fKusp2X9lCGAYMLyHkHb+qCaP3oKXencGmS8tm8E8nK1BrNA5Tnh7osiLZwXdP
         pkCevpaivPAnYYgyLmJa04zYqLRl0zZzBO+TDTh8tcNXRML6KScmtPv7wTPlp1zdBtsW
         qmxBSTl07tl7qTHCKDUdN6X4xkDKz9hvS5mY8cD+BWT/p0kTx2lGFIv88SbJAUFK2ijL
         1U+Hrp+Vv3PqigjDtlPwUgkkqsVagf9QprMqYrVDybB8oIEGArrHZ0KWZzPpk+cnzj2h
         iKPibG0jw6BCLUvdCSm/Gc28f2lSLydq4e2ecHWUSPH5M7hUIHyN7XNrj19XXkY/QnMU
         PyhA==
X-Gm-Message-State: ACgBeo2piCT2rX36S6mrMOpefSFdFhQCEUEjb+DsCmcXa7e1jEa4OKbx
        ihjKsvJEXpzEHkOpK+ga2g==
X-Google-Smtp-Source: AA6agR52VoqB+17Gb0BUpHCSjA4obhxCNA59bFjHr4WfcACjZNkTiq/l3Kzt5b9km8c8ddT0yiL62g==
X-Received: by 2002:a05:6808:1202:b0:345:b62b:3756 with SMTP id a2-20020a056808120200b00345b62b3756mr9487837oil.165.1662992079011;
        Mon, 12 Sep 2022 07:14:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m26-20020a0568301e7a00b006339b36127dsm4654253otr.3.2022.09.12.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:14:38 -0700 (PDT)
Received: (nullmailer pid 1164923 invoked by uid 1000);
        Mon, 12 Sep 2022 14:14:37 -0000
Date:   Mon, 12 Sep 2022 09:14:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 09/14] ASoC: dt-bindings:: qcom,q6asm: convert to
 dtschema
Message-ID: <20220912141437.GA1164860-robh@kernel.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
 <20220908091946.44800-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908091946.44800-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2022 11:19:41 +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm Audio Stream Manager (Q6ASM) bindings to DT schema.
> 
> The original bindings documented:
> 1. APR service node with compatibles: "qcom,q6asm" and
>    "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>",
> 2. actual DAIs child node with compatible "qcom,q6asm-dais".
> 
> The conversion entirely drops (1) because the compatible is already
> documented in bindings/soc/qcom/qcom,apr.yaml.  The
> "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>" on the other hand is not
> used at all - neither in existing DTS, nor in downstream sources - so
> versions seems to be fully auto-detectable.
> 
> Another change done in conversion is adding "iommus" property, which is
> already used in DTS and Linux driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Expected warning because the qcom,apr.yaml is being fixed in next commit:
> 
>   Documentation/devicetree/bindings/sound/qcom,q6asm.example.dtb: apr: service@7: 'dais' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
>     From schema: /home/krzk/dev/linux/linux/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> 
> Changes since v2:
> 1. Rename to qcom,q6asm-dais.yaml (Rob)
> 2. Extend commit msg.
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../bindings/sound/qcom,q6asm-dais.yaml       | 112 ++++++++++++++++++
>  .../devicetree/bindings/sound/qcom,q6asm.txt  |  70 -----------
>  2 files changed, 112 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
