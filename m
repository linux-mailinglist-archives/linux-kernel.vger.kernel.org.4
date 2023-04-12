Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51736DF84E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDLOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDLOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:22:35 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9F5BB0;
        Wed, 12 Apr 2023 07:22:33 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1842f69fe1fso13819117fac.11;
        Wed, 12 Apr 2023 07:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309353; x=1683901353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPvHP5zKEhV3wpPCaaJd0A6PHj3TqrNkW4J6dKPRAfw=;
        b=5lQq/Nejs25Vk0ZcsNlVd/GDTYBvHlzp0fhJkmhrIwKRhF0PQXQnyz5iC5gdAqHO07
         9V13/a+1FOIJ0Okav0LPeTBoAWPLJxsP0H3aYgYTaPmQjQ+sZHP+PpUz3Z4XH5/uvxM6
         Yb/zeu+uDxZc1B080IMzGqUDgkTOM1lWEszuyDK1uKMEoZgoebFznNBIdlFkUzCDnMWh
         Xf92p7MEYfJMqhrbeyb8pFUzSgTnHUzYJi29fSR/KASueuu4C1Fawsw5xV0mtXyvtu7c
         IH7ZmGgJ5CNUCndtspQkG0sr7/O24w9MlbphBREZ7KypUuuydow7A9rXgEzunJBNuNPo
         aasw==
X-Gm-Message-State: AAQBX9dw53FkZiBCCsR8E1Eej7J59cvOHZ1a/hcQzAbsmlVuj4Gwvi/n
        rxqV5ltY4aZh9ZXIxnew0j6+9pr2Ww==
X-Google-Smtp-Source: AKy350ZCtkbbDRKlzPF0Ss6Eh8n2Yi3YFFtYIpvQFEmGPtALYaJH/WAqtHFfG07hJhh36HiOUhzpAQ==
X-Received: by 2002:a05:6870:a713:b0:17a:b026:dacc with SMTP id g19-20020a056870a71300b0017ab026daccmr9345535oam.52.1681309353118;
        Wed, 12 Apr 2023 07:22:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020a056870e14700b001842bb0a01csm172819oaa.27.2023.04.12.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:22:32 -0700 (PDT)
Received: (nullmailer pid 2309359 invoked by uid 1000);
        Wed, 12 Apr 2023 14:22:32 -0000
Date:   Wed, 12 Apr 2023 09:22:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: Add RPM Master stats
Message-ID: <20230412142232.GA2305202-robh@kernel.org>
References: <20230405-topic-master_stats-v2-0-51c304ecb610@linaro.org>
 <20230405-topic-master_stats-v2-1-51c304ecb610@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-topic-master_stats-v2-1-51c304ecb610@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 04:49:17PM +0200, Konrad Dybcio wrote:
> The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
> statistics. They let one assess which core is actively preventing the
> system from entering a true low-power mode.

Just curious, is that a debug thing or something the OS uses?

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/soc/qcom/rpm-master-stats.yaml        | 53 ++++++++++++++++++++++

qcom,rpm-master-stats.yaml

>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml
> new file mode 100644
> index 000000000000..d2d6a2a39fef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/rpm-master-stats.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) RPM Master Stats
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description:
> +  Per-RPM-Master (e.g. APSS, ADSP, etc.) sleep statistics.
> +
> +properties:
> +  compatible:
> +    const: qcom,rpm-master-stats
> +
> +  qcom,rpm-msg-ram:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Phandle to an RPM MSG RAM slice containing the master stats
> +    minItems: 1
> +    maxItems: 5
> +
> +  qcom,master-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: RPM Master name
> +    minItems: 1
> +    maxItems: 5
> +
> +required:
> +  - compatible
> +  - qcom,rpm-msg-ram
> +  - qcom,master-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    stats {
> +      compatible = "qcom,rpm-master-stats";
> +      qcom,rpm-msg-ram = <&apss_master_stats>,
> +                         <&mpss_master_stats>,
> +                         <&adsp_master_stats>,
> +                         <&cdsp_master_stats>,
> +                         <&tz_master_stats>;
> +      qcom,master-names = "APSS",
> +                          "MPSS",
> +                          "ADSP",
> +                          "CDSP",
> +                          "TZ";
> +    };
> +...
> 
> -- 
> 2.40.0
> 
