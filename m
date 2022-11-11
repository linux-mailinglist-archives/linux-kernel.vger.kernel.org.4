Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87962556C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiKKIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:35:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2436964A3C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:35:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so7349459lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twgHmIPH9il7il5wbqgTra+YIwMN83kWBZp7hPMXf2w=;
        b=FVxWsRl4Kvf+vS3Y4w9Gu1eXDiw5q5d6pHyvGRxI+mXJBSW2j/Ll7z5OoouutImAlK
         d2lfqSM/radzGvAlV1o2SK6EkOfFU+dTG6rFVAKF2JJGqA+JYSrd45J8vcig0bgWrNep
         rEKQlIZEJ7K7W8B++EIpU73XtR269vhTE31kIn9+r3C+5B8EHFatUrguyEKSmFspgexj
         b7pV2wTwImPQRvTLac9p2ywf0D6OSkcutPC60xYkEuW9+N0RdVYQGVupgQqmQlhL7XjV
         nAHIfV9IiAHn3W5mcA5/UJK4TB97y8+a+0i+YPNXlQ9bOkQ52vw4DVw112AGhXAKWrnd
         b9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twgHmIPH9il7il5wbqgTra+YIwMN83kWBZp7hPMXf2w=;
        b=cpQ5dgbPl1zfy0hE++vLB5iCjwcpVl5LYmoh/o/TWEUslcq/QmDlL4WUAvM3bVJ7MQ
         fMk7YN5aYC+/GYOshbNNWJUF25warjdahprLKdR5RklyA8XzrOsocGaBh1P2N0fmNkGG
         08LBT4BIW7QQi3lrP+4M1+9zAWmzrCRBjPRLAt+qW0AFNgzQTFxKczHoclr3CjsP/RNS
         g4mABVh3wo1LlunYpD7eU6BKzj3I8/3/XBeNe4h1AeC9QT7S0c0LMF5eWorzb7fSmNuV
         p0nd4s2WhR2pHadAk/KvfULWqQKwawn+ZqhxckeQBicItSnBOn1HFsGHCgVZrjys+7bs
         8i/A==
X-Gm-Message-State: ANoB5pk6auccHM7Uj/rUQrL6tmZVVtWhasmKM5MvDIuEaU2NphAQmSRS
        gXr+vWhQi8Ob9fhOAJ6h5eX4CA==
X-Google-Smtp-Source: AA0mqf60iJpcrCMeahPcVkfeMPwgzC+qBrMypg018HfvSO7QD+mOoz8pMAfYCPhQ0s2W7nN55HmYlA==
X-Received: by 2002:a05:6512:252c:b0:4aa:bad8:9b5d with SMTP id be44-20020a056512252c00b004aabad89b5dmr387326lfb.540.1668155756533;
        Fri, 11 Nov 2022 00:35:56 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id h28-20020a2eb0fc000000b0027741daec09sm269129ljl.107.2022.11.11.00.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:35:55 -0800 (PST)
Message-ID: <9918fb9d-b5d8-1521-8f16-bcc7362d2138@linaro.org>
Date:   Fri, 11 Nov 2022 09:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 09/10] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Add sc8280xp bwmon instances
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-10-quic_bjorande@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111032515.3460-10-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/11/2022 04:25, Bjorn Andersson wrote:
> The sc8280xp platform has two BWMON instances, one v4 and one v5. Extend
> the existing qcom,msm8998-bwmon and qcom,sc7280-llcc-bwmon to describe
> these.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Steev Klimaszewski <steev@kali.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

