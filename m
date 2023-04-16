Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A06E364B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDPIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:52:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19E106
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:52:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q23so47077478ejz.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635120; x=1684227120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz32sDKpQee3zlr0zbbcU6t7W7vxz6tKNYrQgxPMKhM=;
        b=iByFr0zHFbbmpDcuRT4PT75udL0WsPCSqRaVHq4COTZiUZWBbd9DS6L1BeEDu7TGMe
         numPO2jCgvITYIRIp0T7U4cz68Rlqwtprp8LZM3g+gg44ye6QTAx44AZox8WMTcXzQTl
         /T7Wpk3Zi5IM1HGA+j9pfe8I4Vf7CzOMtkHc+cFltux3qesSZuIHafGZbTX8WwoQ81RT
         hBJweTn+UqJShEsFPq2m/7GPDF5KW9E336x20WdGrRqG7vty5yem+Ykg5J8X9argTnhI
         WXHdUoPI8HTmFLdKISV6h4fwk6WUAGpioWMImU1hrMZ5BhkC3FnuLZLZxK4VWbpgf6h4
         SdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635120; x=1684227120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz32sDKpQee3zlr0zbbcU6t7W7vxz6tKNYrQgxPMKhM=;
        b=QvMBC4fLJqCU9xQGn43dfpnRbhRoU4iFxawbTBFf6NZtNgwY91ST0tb4bkG7Nv1Nwm
         66JBfmimnM4tl1av8TCVdDS8aJQfYUUERnofFOwiOGPxLn/kpDpoq7AvWgDWkVVFLNqw
         UdMhY+HQqxhJVioaTD2kd4hReP5VrYi+X3+BS2exmmdCAjA+qSC65fpMY5DuGLHe527u
         KxN8u4Lc4q6qIOqjWBcL/CM6XlPT4ODLhB543C9zLxAvG7vlS5TWHKg6tiDigBmHCifZ
         D5RDc1Jid2PrOcsLZR82V3wvHanIrbokF+f3bV+EuUcePTrMNakT0Ku0aUtyEjV/q9H3
         kZJQ==
X-Gm-Message-State: AAQBX9dTgYnV6lF7GHi5XfsxG/CnniHBHkBMxMPrh5Gu5Hq5ZLDayYj/
        A0iBAoE3s+ivE7XgsqvSZ6vFPw==
X-Google-Smtp-Source: AKy350ZgAT7FtBUWuvq/C/6PhXhW6abzvf7raeIGB2P72QHa4KKmckqO/uvo4v2wOGWhDawntqppKQ==
X-Received: by 2002:a17:907:954f:b0:94e:11ce:4fcc with SMTP id ex15-20020a170907954f00b0094e11ce4fccmr3232718ejc.37.1681635120160;
        Sun, 16 Apr 2023 01:52:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id m24-20020a1709060d9800b0094eeab34ad5sm3038472eji.124.2023.04.16.01.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 01:51:59 -0700 (PDT)
Message-ID: <d175db74-6208-02e5-6427-52377e33fa9e@linaro.org>
Date:   Sun, 16 Apr 2023 10:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: qcom: Add RPM Master stats
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
 <20230405-topic-master_stats-v3-1-2cb2ba4f2092@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v3-1-2cb2ba4f2092@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 13:37, Konrad Dybcio wrote:
> The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
> statistics. They let one assess which core is actively preventing the
> system from entering a true low-power mode.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
> new file mode 100644
> index 000000000000..d7e58cbd3344
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) RPM Master Stats
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description:
> +  Per-RPM-Master (e.g. APSS, ADSP, etc.) sleep statistics.

Explain what is RPM-Master and what do you mean by "sleep".

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

There is a relation between this and qcom,rpm-msg-ram which you do not
describe. It's not just RPM master name...

Best regards,
Krzysztof

