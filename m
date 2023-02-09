Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1466690222
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBII1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBII1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:27:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191753FF1E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:27:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ba1so952434wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DMSjPOiPerJSq8T/YtMIAgTUoaGtgoLM9j3d2rTLbWk=;
        b=yUlt6Qh9ILGQGhNd3pjJztI6cUdSoWgqJoUTtNGkI+96Gy4ZayQju+Xlzc9C3BmtA6
         ijL1XWbUI89Gn8S6fD6ok442NrqDfy85/cdMaxW3EtVQVwDUtf/ogABLsQYk/k9tIiXs
         eoIKa/Xu8tS6p8wAwANEuZHfBL9SaTSChPGe08LWpv/i1vge4QyyZq4e9Gj7iFZJv5ee
         dIpVb5UPJsqiuwiRc9jui3mYBpDyXtqQEGF0OKIYdigtORTegzWgigNLjumNS71HGFq4
         IEz0CpAzkV2i/ABiTVsLbF5NNqGhLuxprKfuiQQ7WlirPwdO36cuGYy0GS/9x6OxzAKF
         +ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMSjPOiPerJSq8T/YtMIAgTUoaGtgoLM9j3d2rTLbWk=;
        b=R+5Bd2tyUPI5Tqr72ntgXucaz7g473t4jHQ3h9abrPtX+qwKo9VAXl0dFAxZLGzxMg
         ww1k8rS+r8NzJbpp+rlrMydmM3mPL1XvB2V31ozYCgqcoRkkhiJg78FN9jTlpXk+sR8N
         Eg1S5z5vjYh5t/qpjEynBskCgDaXeKW1N/SxaeSSNIORuDWSGNLckM7N2qxmNCL8vHUa
         8CktKRw5xpWMvxFwX30VgD4GM1a3Zy0Zp3m6jLKoht24Nh9wgZrMVGsrO7M8YIXnsivd
         I5AMql7yWSCV3gquj1a6Da8KDkjZM5zQHzcyKy3AaUUNJ8WaVB58KbJkblu3+uGiaG2B
         OC1A==
X-Gm-Message-State: AO0yUKU4qxk8q7mkHqKmrAxszHI8InprliYLazYswCNceBer5m00msnW
        x/dZf1v39RGZo8Q+YPqOfK4cyg==
X-Google-Smtp-Source: AK7set9ItuomxBH8KrAbd3rm7yTuNjdmsHJ33bxgWjaUhBAqeprTJ95lkWwZouzRvd2rSZbfWbYmpg==
X-Received: by 2002:adf:fb82:0:b0:2bf:dab7:8f9f with SMTP id a2-20020adffb82000000b002bfdab78f9fmr8295211wrr.65.1675931241616;
        Thu, 09 Feb 2023 00:27:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5431:990b:7117:b75e? ([2a01:e0a:982:cbb0:5431:990b:7117:b75e])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b002c3ec35f360sm625255wrr.56.2023.02.09.00.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:27:21 -0800 (PST)
Message-ID: <0fc54210-8e94-5901-f02f-7a2b110e32ec@linaro.org>
Date:   Thu, 9 Feb 2023 09:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: dma: qcom,bam-dma: add optional memory
 interconnect properties
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org>
 <a188a52e-6327-f0ea-a54e-a23b88bca82f@linaro.org>
 <a8112f61-f8d3-c1e0-9549-a9036a7e7894@linaro.org>
 <88c31e71-55b6-a20d-1fcf-07804eace54b@linaro.org>
 <eda179e1-4cd1-0d1b-4e27-2fe92e959cf2@linaro.org>
 <0f16d63f-3bb0-54aa-bcb4-4c666d4b2846@linaro.org>
 <32153a4b-9974-a42a-ef30-c0bd8cbc732b@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <32153a4b-9974-a42a-ef30-c0bd8cbc732b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 09:25, Bhupesh Sharma wrote:
> On 2/8/23 2:38 PM, neil.armstrong@linaro.org wrote:
>> On 08/02/2023 10:03, Krzysztof Kozlowski wrote:
>>> On 07/02/2023 16:27, Dmitry Baryshkov wrote:
>>>> On 07/02/2023 15:35, Neil Armstrong wrote:
>>>>> On 07/02/2023 11:32, Dmitry Baryshkov wrote:
>>>>>> On 07/02/2023 12:03, Neil Armstrong wrote:
>>>>>>> Recents SoCs like the SM8450 or SM8550 requires memory interconnect
>>>>>>> in order to have functional DMA.
>>>>>>>
>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>> ---
>>>>>>>    Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 6 ++++++
>>>>>>>    1 file changed, 6 insertions(+)
>>>>>>
>>>>>> I suspect this will not work without a change for a driver.
>>>>>>
>>>>>
>>>>> I had the impression single interconnect entries would be taken in account
>>>>> by the platform core, but it doesn't seem to be the case, anyway I can;t
>>>>> find
>>>>> any code doing that.
>>>>
>>>> Probably you mixed interconnects and power-domains here.
>>>>
>>>
>>> The driver change was submitted some time ago:
>>> https://lore.kernel.org/all/20210505213731.538612-10-bhupesh.sharma@linaro.org/
>>>
>>> There is already DTS user of it and we expect driver to be resubmitted
>>> at some point.
>>>
>>> What I don't really get is that crypto driver sets bandwidth for
>>> interconnects, not the BAM. Why BAM needs interconnect? Usually you do
>>> not need to initialize some middle paths. Getting the final interconnect
>>> path (e.g. crypto-memory) is enough, because it includes everything in
>>> between.
>>
>> Indeed the interconnect on BAM may be redundant since QCE sets the BW,
>> I'll investigate to understand if it's also necessary on BAM.
> 
> Since we are already doing this via QCE driver (since crypto block on qcom SoCs employs BAM DMA services) via [1], this change is not needed for sm8150, sm8250, sm8350 and subsequent qcom SoCs (available presently), so this patch can be dropped.

Ack, I'll push a patch to remove the interconnect properties from the BAM node in sm8550.

Neil

> 
> [1]. https://www.spinics.net/lists/linux-arm-msm/msg142957.html
> 
> Thanks,
> Bhupesh

