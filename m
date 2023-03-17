Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F776BE3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjCQIgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCQIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:36:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539C69077
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:35:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so17261209edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679042091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIfNmjlP/emZ8VU0HYeaktKYqZYSqV2w6X7O7md3pTs=;
        b=wRZi0OVE5sRJZF8H5ne08hNllrwQSaDe7kgGBEhqxrCYqeQtS1DYfaDBWAGYGhRX1g
         9eEESgI7jotBiXvy9PDWwIfXCEKC8O+x7dZ/YPmU1MCK1MCJIMOR9TkKDyWw/ceoJbsi
         CLFpbkrE7zninvqToDa+UVdyqbScL/is+LHeiOC3sosKRFDnOvAmka/sy408NQYE3tWs
         MkLZgpqpYvAJk2+H4jiP/ACpWPtEVBdncsHNeZW1wMSZZ1HVQehNcQdVe5MP0iZl2PT7
         4ObHyUQsq6E+ghbdkrTFTOnkEqP6x7JrTtCt8Ai9gLXefM1p8G3Z+rWtt2v+8H17cf70
         +W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679042091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIfNmjlP/emZ8VU0HYeaktKYqZYSqV2w6X7O7md3pTs=;
        b=012lnyv8GKImTTSHUIjuSroYWKmfspLOBLPw8aSTmkfkiAWIJdBi+ynMHZHuwUjbhG
         ABc5LDUpRMIZBELAu5K6fkV1fennMVMNQToxBP/dgVXk/u4tZHVa30uXHof+azbyWpIY
         Vm60OiY3nB5BSe9tai4i76V6bfqBxE7rnh5T0bPUOBO3EAQLCarqwPP8NHJ4zw/BWg0u
         28a5MiulguYmWyGNpzQDFlrAK5FCHU3EG6Po56ozThnNxmrsLXbg+oa7YUE2wEvcajme
         X5v42OMqrZpcO67gT9LuqGYX4t53F32XW2zjrlupkhhgw+RISsh+Epg+BR5OWFVWAkPv
         g8Kw==
X-Gm-Message-State: AO0yUKUNfNS3gSkoHY5vgjnLaR0h/tBp2+zs6tCmwnL8Toii+l0ZIfqE
        9yMJTQtGGot79IiZzxdCzJcSBw==
X-Google-Smtp-Source: AK7set9oeh/k8QPKvi6CFkwTq2accUoCK8wDEQMIU95iWYbYqUoF32/8ClKQOzwcdKOzOdUC1XZG8w==
X-Received: by 2002:a17:906:568a:b0:931:d8db:8a2f with SMTP id am10-20020a170906568a00b00931d8db8a2fmr1352054ejc.58.1679042091136;
        Fri, 17 Mar 2023 01:34:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm727970edb.52.2023.03.17.01.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:34:50 -0700 (PDT)
Message-ID: <423d0cd0-ba3c-d163-6005-592a9d594bf3@linaro.org>
Date:   Fri, 17 Mar 2023 09:34:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 08/10] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org>
 <20230307-topic-dsi_qcm-v5-8-9d4235b77f4f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v5-8-9d4235b77f4f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 09:51, Konrad Dybcio wrote:
> The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
> alone. This however didn't quite work out and the property became
> undocumented instead of deprecated. Fix that.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

You have warnings caused by your previous patch and since you fix the
same commit, this should be rather squashed with #1.

Best regards,
Krzysztof

