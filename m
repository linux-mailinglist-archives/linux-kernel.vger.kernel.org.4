Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE673F440
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjF0GKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjF0GJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:09:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161831718
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:09:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so15948975e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687846194; x=1690438194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7EFGbGxcbcRQrdCl8YEQZLIbGz3WyPlJ80GYj0RMRRk=;
        b=IVBmz1n1H90Ne9ExpoJWqX4UnRWGAQN/Ii9CQmrsVbIL2UNjFd/Ksv8D0b2iNvBHfV
         E2is+C1sEzeGQnV4KnTxc5PO3fh3oPdpUsfjAh1KYiG6G/HgXr7d07v6KbVG4uIP6lpz
         ACowe9iGOI0IBw0ZJqiLCJ2YAUpl0Daak/rd2Rt94jBLDefB/qbmyrl7eBnkor6RKt1u
         eylTCdIE/PWUBHrEYY/ctkcG7/+uKJaalh0PEEJ2VNtgIeOXla3MNoxbTZtCbLj07cLQ
         i3/FN5V8v24Q2RNAxuQueZ0lHaGjedR/KLeYcSWQhMxM4vl8ih/mDsNZMjzz8n5HBfRJ
         5tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687846194; x=1690438194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EFGbGxcbcRQrdCl8YEQZLIbGz3WyPlJ80GYj0RMRRk=;
        b=SPMnOdljZ5V7rVn2S3yddvWkI3CNEiHW+dLWS4hBuNlEWVz4YIUWhZ9cC405+e1mo/
         gwgH8plm6m7dUQeSBbe1xcLy+GJcmCbE3wZCI9w1gf3ZCjy1+lYW0qlg3j3hm3F53pd+
         eKQ/yEdIlTK31wljVsUSYK37SAP1JDaq1f0j2CVvFexm0trL5oUbbFbIe6PTgta9l11m
         Mt+4EPesj8idh7SCICjSWiHVunTMs19chi6qjwSnKrhKj7Av679SGasmh0zWpxtP+sv9
         UGpf3fLAlE2o4cfmxoX1hzv01KTTNK/6oAnkNai+EE6OHkrFrbZI5P8mbd+9H1zhfLcm
         okkg==
X-Gm-Message-State: AC+VfDy1YyjwSmskaQD+wcEWHAJrUqiLsOHqjCmg0v3+9/Gi4L/2YAD+
        Pd6iYtDZ0J6XodGtjye6I8+RTQ==
X-Google-Smtp-Source: ACHHUZ6dA4Hj0erbr3brn0zc8qKEJp71t3gpnCs5gtioG8Jwc+sN7pXHdL9xmc+xrWyAcuWkhh2TWA==
X-Received: by 2002:a05:600c:2241:b0:3fb:31b:d516 with SMTP id a1-20020a05600c224100b003fb031bd516mr2389354wmm.29.1687846194453;
        Mon, 26 Jun 2023 23:09:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm268131wmf.17.2023.06.26.23.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 23:09:53 -0700 (PDT)
Message-ID: <f289f008-d1fd-5a78-22eb-d3a21589f20a@linaro.org>
Date:   Tue, 27 Jun 2023 08:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sc8180x: Add missing
 'cache-unified' to L3
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
 <20230626-topic-bindingsfixups-v1-7-254ae8642e69@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626-topic-bindingsfixups-v1-7-254ae8642e69@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 22:00, Konrad Dybcio wrote:
> Add the missing property to fix the dt checker warning:
> 
> qcom/sc8180x-primus.dtb: l3-cache: 'cache-unified' is a required property
> 
> Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

The last one, I hope...

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

