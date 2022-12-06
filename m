Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2860643DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiLFH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLFH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:58:44 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4055658D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:58:43 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so18054626lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 23:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuxMKSbqC/Jgu5E4lIjy0a2xiVCLdx5Bzf0OSzdJ9K4=;
        b=gGYhjUU2P1UY3m/14PaCJ9X0vDZV735yOUxXjy6fkwqf0urvMLYvdOZu8W+2LnUpYE
         g9czDvAqWIgftLA+YWCRI7RHT17qnLtPgaZIS2VArFuk23wHsU6wtjN1Ir1UmfDu0NPD
         q2VsHpfsEK4R7Rdect34HbJALcStt2SWbF9s+hE50UBjTJ/F9sSr+Mt6KnBdULGvccsb
         HrByjPeBAUs8HLXuf9RUaNNRu+3na4I/8ezrqiw/J7uy9JFK31/QeDt3ZnWpvQoguTSw
         EmOQPnBu8BkT47yS7tVdEhmDAr11ZapcF+zgPhEWdKTgPIDPDGt3LgHqqOZyWBhfKwis
         qPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuxMKSbqC/Jgu5E4lIjy0a2xiVCLdx5Bzf0OSzdJ9K4=;
        b=xT228ObbtH+pkWK+4hebjBsIv55mond8HRV8T5YFNXn3SsExiGDvMBfUK0m1gvpUgQ
         INzM/+rAjxDtLoOOqdD8usUnZ4Bxm6tZCme3pcOFipUdh5MJztmSHEh2ValO4fz+nGJG
         kZyYDXY9QmyFBk2qczXBi+7xIeo2bsYxRsTiHoFyZmOCkOHdjfQGT8aThk0gBAGw7sfk
         GDuNirjs/iDeC5yIv5Ob3Fnjt6JUSxQIxZNRvzziZc2Maz90aBoSY+PEvbxUlq6J6OYM
         4YFel0vkYJRWYaJ5eXh51naHYu8uotkgH7B0nct1nSK8gnu6rZb6NxKX4TpX34qKkbBy
         sf7w==
X-Gm-Message-State: ANoB5pmvwxQtKFNw508kSrcAP+CxErW3YCV9Y6whM6GUYSXXulEG0NmE
        y3xodQeJuytnU6G0sPXja+xMOg==
X-Google-Smtp-Source: AA0mqf7q59b2daQSmHIbeePPXZzwACGd8uOQbPwr12ZU/qnQ2r8IuZVlVwJQ3jj5MPPt9ZSJVrkAtw==
X-Received: by 2002:a05:6512:1112:b0:4b5:6375:32d9 with SMTP id l18-20020a056512111200b004b5637532d9mr4282236lfg.480.1670313521912;
        Mon, 05 Dec 2022 23:58:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b00499cf3e3edcsm2391600lfc.296.2022.12.05.23.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 23:58:41 -0800 (PST)
Message-ID: <26091130-1572-6a86-8590-7f3ec7654100@linaro.org>
Date:   Tue, 6 Dec 2022 08:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 08/15] dt-bindings: remoteproc: qcom,sm8150-pas: split
 into separate file
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-9-krzysztof.kozlowski@linaro.org>
 <20221205194934.GA2476927-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205194934.GA2476927-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 20:49, Rob Herring wrote:

Hi Rob,

>> +  clocks:
>> +    items:
>> +      - description: XO clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xo
>> +
>> +  qcom,qmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Reference to the AOSS side-channel message RAM.
> 
> Not ideal that we are defining the type here multiple times.


I was thinking to add it to the common file (qcom,pas-common.yaml,
created in patch 6/15) and just disallow it for other variants,
but that does not work that good:

Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml: properties:qcom,qmp: False is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml: properties:qcom,qmp: More than one condition true in oneOf schema:
	{'description': 'Vendor specific properties must have a type and '
	                'description unless they have a defined, common '
	                'suffix.',


qcom,qcs404-pas.yaml has "com,qmp: false" and it references
"qcom,pas-common.yaml" which has the definition of the property.
However it seems it is treated as new bool property.


----------------------------
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
index 007349ef51ed..62126e96d2f5 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
@@ -39,6 +39,7 @@ properties:
 
   power-domains: false
   power-domain-names: false
+  qcom,qmp: false
   smd-edge: false
 
 required:



diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 1d5e01c8d8bc..72cdcc2b157d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -60,6 +60,10 @@ properties:
     maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
 
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: States used by the AP to signal the Hexagon core
----------------------------

Best regards,
Krzysztof

