Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA176BE4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCQJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCQJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:07:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C0166D0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:07:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so2822982wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044021;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FkEW8ZYuZi33cVLz405PPEYTVS02b7guai4VJnc/u0s=;
        b=Q6GGawkHUaBC3zY4KVyRU2zkTV8I/A3fQwxW7vTpJrTozVht9LImkNfbBCRCosXa0m
         pd7TBNyANDkYveJ2bhPyAp4KF6gKFGL5nSe71B61hyNABpnJuYVwciehnVTke16XsHkt
         FsBJJhM40ydNvoYFsecqfm0EzfkcQunE5FgD8M6ukgPmOfmmmPgu/4NlxdQjJpj+hPYJ
         axfR6dGJrSVb3HtEHlPHaxD2AyWfNzbMa4+JeWw0nvc6HsJ085fcxmt3vgf5tLRbSyby
         YeUW4PmcBtee2DYPwXFAwToI8SgWqv+LAG8OKBai099FX6K2zS8T9UqV+0L1tZUy9wWV
         d3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044021;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkEW8ZYuZi33cVLz405PPEYTVS02b7guai4VJnc/u0s=;
        b=AeE1uFCvz7bKaSPnfkzjw1riKbeKKxzSznVM7CcZ/rYMJjq8/6o8wyzsHmhT9Un69N
         vV/Ziinx92e+QYaw4VO3WqsvoU17j8JJZgUtRsV1IZC4KuAli3Uz0fJMfytPkyGMy9Dk
         3t5Lp9grqZNTGmm7UHRfy4e3u6pq+neoAIAaZ3Vytj9WNkLDXmvPv1UqSZOYeAINvAWF
         oLB9ckp0iHsHNqjtjm1bk3Q1gy1iwE/h2Bp6ZohRAbQ8Rp36a74ZFeap+nZwFCorBMVU
         13nnq/2Mtp+oqJenIVPFrFu20J/yx5jv4Mryq0L9RDrjq1M5yWMpJi1LPAaCAmOI5Jr9
         vTeA==
X-Gm-Message-State: AO0yUKVivHSSNolioJpZ1BeZL3wED1bjEyAf0E30Djue5Bsjj35GXKdo
        kIbLBbwIclgNl+IQdnKj4kRSkA==
X-Google-Smtp-Source: AK7set+A4ni6dKWDcGtNRjRWaK1QKtVa/vvIX67r+ZAtb/CzWUnqPiOUWmFYG5d7yJ93VdhYmJaZlw==
X-Received: by 2002:a05:600c:450c:b0:3ea:e7e7:95d9 with SMTP id t12-20020a05600c450c00b003eae7e795d9mr25428831wmo.32.1679044021068;
        Fri, 17 Mar 2023 02:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:9ed5:bad0:e925:7938? ([2a01:e0a:982:cbb0:9ed5:bad0:e925:7938])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003df7b40f99fsm7331479wmb.11.2023.03.17.02.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:07:00 -0700 (PDT)
Message-ID: <8a6ecd92-ff4f-e72f-457e-4061546dc46f@linaro.org>
Date:   Fri, 17 Mar 2023 10:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 5/5] arm64: dts: qcom: sm8450: add dp controller
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v4-0-dca33f531e0d@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v4-5-dca33f531e0d@linaro.org>
 <c63ecdc2-11e0-79d2-8647-284913f0c0da@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <c63ecdc2-11e0-79d2-8647-284913f0c0da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 14/03/2023 23:12, Konrad Dybcio wrote:
> 
> 
> On 9.03.2023 10:19, Neil Armstrong wrote:
>> Add the Display Port controller subnode to the MDSS node.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> [...]
>> +
>> +				dp_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-160000000 {
>> +						opp-hz = /bits/ 64 <160000000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
> Downstream seems to use 19200000 here

Ack, will update.

Thx,
Neil

> 
> Otherwise,
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
> 
>> +
>> +					opp-270000000 {
>> +						opp-hz = /bits/ 64 <270000000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
>> +					};
>> +
>> +					opp-540000000 {
>> +						opp-hz = /bits/ 64 <540000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +
>> +					opp-810000000 {
>> +						opp-hz = /bits/ 64 <810000000>;
>> +						required-opps = <&rpmhpd_opp_nom>;
>> +					};
>> +				};
>> +			};
>> +
>>   			mdss_dsi0: dsi@ae94000 {
>>   				compatible = "qcom,sm8450-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>>   				reg = <0 0x0ae94000 0 0x400>;
>>

