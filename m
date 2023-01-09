Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1966228E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjAIKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjAIKIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:22 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529E13F6A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso6654056wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z/+RvE1zUSvzhkjun8dKEVXgkB19UZ8DjPmUEsU3dsg=;
        b=yecaOk6zXoJw/jb5YS9smcV2qzy3f/ol5OghdAeZIx0LZI3BMFInA5U4I7ICB9hQ3X
         7vBTGVKSgthM2nIAdWXWaZi8/IwerZXSdkVLfaVjrYFH/kw7Vvn5ksuZE5XmNp/vSJGd
         0SiSRNdhctOdLuCqswNIxgnUq6FErw4qj/bkb6zsWAPpiiiAA5wiw7tzPSkDZAUfiT+o
         LkTEqifzy+TaZyHe2k4mQFaHxL5jdNg99VD4KxcH99sSBlkqmWkdGb7tN/i1TodvKxHk
         0349xtvtPwZlMyHJ9/Cot4Iwe6bOK+vdai06PUQhACbMG+65WuRNP6ziEJcH3EgF3+Pv
         PIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/+RvE1zUSvzhkjun8dKEVXgkB19UZ8DjPmUEsU3dsg=;
        b=V9VeU6NgQ19kFmboYoUy+VDjqjlOi/NU1/tljVN89hI7iTzBH3UivDV3secerxomgn
         Lyaqnd7TEGRplWk4hobW0k2pHNts0VYJ4odWqZiEHlICKPx/WNMqNAClA4TVUjegCH9l
         FL3hJElDqGMB6nTr8vN4JIboQAqXvP3cxxxI2AG8I5LmicxTW5BwMl6CWv/CdWCdVQAJ
         WkIR26UGM7zubkKXFWRFJ+2zgtwua/QFeZyeZkrX2eNkZbiNQdwcy+6kIPqGUCYaOqPG
         8iuE7TtVGZJVxhzp5V6D9p+uDByiSIkS+lbsCB6GYZOR6yEWTgjf52a1OOYMl8DIlIbY
         oEhw==
X-Gm-Message-State: AFqh2kp2gTsjA6CZYL2FYx+4+kpqgyMhACcsEeJ+EnrCQfJFEL6sDsd+
        Nu356PVsrBM4z/bplq3gaQzOjw==
X-Google-Smtp-Source: AMrXdXsjwUvFqv7FUVFCq6eCQgr+Bke/YuyPH4PMJ7hVGkEi04Ga33xLbp4qHyhwsfRsqvvw8kHNTw==
X-Received: by 2002:a05:600c:b99:b0:3d9:edd9:20ea with SMTP id fl25-20020a05600c0b9900b003d9edd920eamr2879640wmb.38.1673258899507;
        Mon, 09 Jan 2023 02:08:19 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003c6bbe910fdsm18183901wmq.9.2023.01.09.02.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:08:19 -0800 (PST)
Message-ID: <bdc6ba2f-7683-c7fe-f51a-1fc41bc805ce@linaro.org>
Date:   Mon, 9 Jan 2023 11:08:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/5] remoteproc: qcom_q6v5_pas: add support for SM8550
 adsp, cdsp & mpss
Content-Language: en-US
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 20:23, Neil Armstrong wrote:
> This patchsets adds support for the aDSP, cDSP and MPSS found in the
> SM8550 SoC.
> 
> The aDSP, cDSP and MPSS boot process on SM8550 now requires a secondary
> "Devicetree" firmware to be passed along the main Firmware, and the cDSP
> a new power domain named "NSP".
> 
> In order to satisfy the load & authentication order required by the SM8550
> SoC, the following is implemented:
> - "Devicetree" firmware request & load in dedicated memory
> - Q6V5 prepare
> - Power Domain & Clocks enable
> - "Devicetree" firmware authentication
> - Main firmware load in dedicated memory
> - Main firmware authentication
> - Q6V5 startup
> - "Devicetree" firmware metadata release
> - Main metadata release
> 
> When booting older platforms, the "Devicetree" steps would be
> bypassed and the load & authentication order would still be valid.
> 
> Bindings changes depends on:
> - https://lore.kernel.org/all/20221124184333.133911-1-krzysztof.kozlowski@linaro.org/
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@somainline.org>
> To: Mathieu Poirier <mathieu.poirier@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> To: Amol Maheshwari <amahesh@qti.qualcomm.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> Changes in v3:
> - fix mpss matching in bindings, tested against DT
> - Link to v2: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org
> 
> Changes in v2:
> - Moved the SM8550 pas bindings on top of "split and reorganize PAS/PIL" v3 patchset
> - Incorporated DSM memory support into pas bindings & driver
> - Moved second DTB firmware into second entry of firmware-name
> - Dropped applied "qcom,fastrpc: increase allowed iommus entries" patch
> - Link to v1: https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org
> 
> ---
> Neil Armstrong (5):
>        dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common
>        dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible
>        remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
>        remoteproc: qcom_q6v5_pas: add support for assigning memory to firmware
>        remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data
> 
>   .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   4 +
>   .../bindings/remoteproc/qcom,pas-common.yaml       |   8 -
>   .../bindings/remoteproc/qcom,qcs404-pas.yaml       |   8 +
>   .../bindings/remoteproc/qcom,sc7180-pas.yaml       |   8 +
>   .../bindings/remoteproc/qcom,sc8180x-pas.yaml      |   8 +
>   .../bindings/remoteproc/qcom,sc8280xp-pas.yaml     |   8 +
>   .../bindings/remoteproc/qcom,sdx55-pas.yaml        |   8 +
>   .../bindings/remoteproc/qcom,sm6350-pas.yaml       |   8 +
>   .../bindings/remoteproc/qcom,sm8150-pas.yaml       |   8 +
>   .../bindings/remoteproc/qcom,sm8350-pas.yaml       |   8 +
>   .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 178 ++++++++++++++
>   drivers/remoteproc/qcom_q6v5_pas.c                 | 271 ++++++++++++++++++++-
>   12 files changed, 504 insertions(+), 21 deletions(-)
> ---
> base-commit: 268975e1af25cd83994d24c46ad0d95753291f64
> change-id: 20221114-narmstrong-sm8550-upstream-remoteproc-804f3fbb34bf
> 
> Best regards,

Gentle ping,

Thanks,
Neil
