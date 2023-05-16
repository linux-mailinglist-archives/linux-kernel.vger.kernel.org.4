Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E869F70429B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbjEPBIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbjEPBID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:08:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7846C59CB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:08:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so133539761fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684199280; x=1686791280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DMAxQdxkLEKTX9BIr/eW4cFEEBekMsteNz0Kbsvrqc=;
        b=T+c1yY4q992sUnckUr3fqNgC5GXrZ80f29rEPsibowWS5WZI+ILS8pYwQXrpGOBNfR
         9szjgtwnOiZkMn/0zfD3h25fXdutgDEC+fN/9qNU3bqKALPoC1lRqLF+IlSuSJX+FCLJ
         etSOI0v4Gy+x6ftKPfSLPBD7+ru+6umRbRVwL4sychhPkALU/Zf+JkvwF/YU/zB4701+
         lqfJgQ/M9hHR65cp2nbckxaZzzdh7XlfYaleu8zMpl/jW8vYWeWz3LJQ9AD79ZobmToz
         GEnAaYHTI/ne/rk7r5PXWemf5SwctO1JwmlBUMOtnpHNE6SloixkaZz4Jc8QrtdRAopC
         oKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199280; x=1686791280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DMAxQdxkLEKTX9BIr/eW4cFEEBekMsteNz0Kbsvrqc=;
        b=IBUbrMZlcLYObbfOCFE5lxcuFWwY7g6lhI5p9C5BGpMqnrYBaygHAEK5cOF2vyi5nD
         K67AyTlnFa/I6H4z31JrRRgXpGT2yUv9M4uI6EVSssioAO1IdJMwL3w1vpqysYWXMZ1L
         qqdOKPx505KeAu/Mas/kKzjrZn+ik+mDY2pmCUV3Xn1NDNBkJTb3f8N/Kufx59XT9zj5
         tUGBnyV6yMk28AR2ip1l4ktfrFSw5ugthGM+gdjiuS98ci196PvEjHbaZO4IUSuVKBe0
         vcgDg56RP0OW33ZKLwjVHr44g61zTuz3N5gA1URDUXd6ooeuSenOWTXvKF61BXvCips0
         yi+A==
X-Gm-Message-State: AC+VfDygzH7zHE9QWgKjA+Wuu8JBDHS8nAJhRr06dj2AB4F66dYNDIiM
        keo0qYxNpCEmfObV9NbpBeD/dQ==
X-Google-Smtp-Source: ACHHUZ73giUuePscrw2MnvH/2uxL/Bf8qcLcrF/OdAvENc9JgDkwq6Y2Fi1mdZ2XzM8RIgbJcPbBWg==
X-Received: by 2002:a2e:93d5:0:b0:2ae:d757:4c41 with SMTP id p21-20020a2e93d5000000b002aed7574c41mr2147748ljh.23.1684199279748;
        Mon, 15 May 2023 18:07:59 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002ac7a715585sm3958594ljg.30.2023.05.15.18.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:07:59 -0700 (PDT)
Message-ID: <f7f38099-f183-d7b6-f542-1bdac6652a77@linaro.org>
Date:   Tue, 16 May 2023 03:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/14] dt-bindings: thermal: qcom-tsens: Add compatible
 for SM6375
Content-Language: en-US
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
 <20230303-topic-sm6375_features0_dts-v2-1-708b8191f7eb@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-1-708b8191f7eb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.03.2023 15:12, Konrad Dybcio wrote:
> The Qualcomm SM6375 platform has two instances of the tsens v2.8.0 block,
> add a compatible for these instances.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
<bump>
This one got lost!

Konrad
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 926e9c51c93c..d73b72dafcbc 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -56,6 +56,7 @@ properties:
>                - qcom,sdm845-tsens
>                - qcom,sm6115-tsens
>                - qcom,sm6350-tsens
> +              - qcom,sm6375-tsens
>                - qcom,sm8150-tsens
>                - qcom,sm8250-tsens
>                - qcom,sm8350-tsens
> 
