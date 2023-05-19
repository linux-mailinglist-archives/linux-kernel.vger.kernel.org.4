Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71121709FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjESTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjESTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:06:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF5BE46
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:06:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f24d8440c9so1499798e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684523204; x=1687115204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rui+ZWUFjt86muw9r1inOKrWuQmQAvAfmjQmisslnGc=;
        b=rXItGa2oK4EId+ypJUigwh2I4n2aUm3LD0VPGd7JlVZCaPN/L88EcMPOP4jWOnPsQZ
         CMm4ajybmaym87ABRc8V6w1o4kohcT+W1ohUypA9+EDCj73+q5y0nvyWbhDHobWdb6Wu
         sIyjjd8bJ8+fnLS+pt1HFKqrBe9SO5gkmQyicwHfhc6LPGdryrcV1gAFOFPuRy+/V/vf
         CEB4XZ2V6Bv9bm8AjqnJWsxwAw2BnFMIUlmk2zv186UF9J2mfuO7wgqfYg5tVieB6J6P
         kLogJIvzdk6ert42EdAka5D9GXdWfHp+tod5qHax9lYYW06PeODCbhHf8lYLWQS8Oqlk
         9n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523204; x=1687115204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rui+ZWUFjt86muw9r1inOKrWuQmQAvAfmjQmisslnGc=;
        b=dh98MFkLL70d4Ytl8lPsk7yotz7bp42EjnSvhGvbbDkIf9MIXkuXqhenvdAFc5/eQA
         pliIFMqZPb3Fbh9lfSqxTkQeSiU40b4Jp4geu322c0bwGmvpg0nTIwSjFca8XwBC0ZGB
         hRKKSJYM8Nmkrwnt9NP5nPEiSDk1AZDD+raUB/cNArHSkayXBzQo7/C3jjFADwG8zMbs
         1gxNvMWhEH5+LhCbdvIBGqJThzEj2VLmx3EIGl2NpGeBTrhKHvYYXZk80I+NkXHl1v3w
         JwEGTuGUUrZBtma1P7PxLBv5Rph/S1lQ5xkCJrRXn+gxjcGM1TWrlweT8BjoGB34UP5i
         a+5Q==
X-Gm-Message-State: AC+VfDxisXVRyvacfLaRWOQjDfXmgUA1XXr+vwmeIQzporRRrJn4qSZd
        v5DDdg8ycwBHXbjAzyU+xEqB1A==
X-Google-Smtp-Source: ACHHUZ67Ce2tA0cEGprwriJupZEEkiXqed5dpC+i0UuXp7d1PPnEunZUR84ZOoZKnBiZEonZaVqBdg==
X-Received: by 2002:a05:6512:3d22:b0:4f3:aa26:1890 with SMTP id d34-20020a0565123d2200b004f3aa261890mr1294165lfv.22.1684523204153;
        Fri, 19 May 2023 12:06:44 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id d30-20020ac25ede000000b004f019d3eab4sm2904lfq.23.2023.05.19.12.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:06:43 -0700 (PDT)
Message-ID: <0ccf9fdf-5604-d65d-6c7f-02c96f706a09@linaro.org>
Date:   Fri, 19 May 2023 21:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org>
 <168452313011.3852116.2187810600963716663.robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <168452313011.3852116.2187810600963716663.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 21:05, Rob Herring wrote:
> 
> On Fri, 19 May 2023 19:04:26 +0200, Konrad Dybcio wrote:
>> Document the SM6375 MDSS.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>>  1 file changed, 216 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:0: 'bus' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:1: 'iface' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:2: 'rot' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:4: 'core' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> 
Whoops, forgot to fix the bindings.. there was going to be a v5 anyway.

Konrad
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
