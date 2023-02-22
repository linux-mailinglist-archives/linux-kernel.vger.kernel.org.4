Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84D69F727
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjBVOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjBVOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:53:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6552693
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:53:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f18so10365658lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtiAUhBRnV1kzRpqeljMlrgfEP8oapNbELdUiPr+q0Q=;
        b=yIaGRZdfGhPRxB1k8ow9epTiEE1W20A8grO7TCejcTJ9sWi1bZHAds5FbSz221ZTgc
         XY+qfPUtt4sp+Rr8533QuRnBFRfyC9e5t70/Z86qx+VK2ILclkW2XWvn9kZ/+UyFKuoa
         X28QYxXXtkuaave1dYN9Fiuv/jZYY4Lom0dKo3852iGBIY8af9JqyXVGLJVvSd41ym6O
         Wy/obk73XRE8S4v5Qlf3i3KQ02UEZhazuGUXtNSrUU+P6P05EbCPh8aIG+hwdMCc5Qx7
         0pXwcTR1KpkXeIg/BgUex7/RhJZJwkDYuOas/jUlZqbPv7dWUyC5ZHgBt6zYJ9V/kAMd
         EVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtiAUhBRnV1kzRpqeljMlrgfEP8oapNbELdUiPr+q0Q=;
        b=uOmcTh9tAIKVkLf++UoS1OckyLhCBUffzPAQ4T9fhffMV1b+JsTwUg1ddbm1mezEpP
         z832N0vNn5ucIwNj3Bh9q8G+TXKmUdi0NIufLN2bdmjx4iiQoXqEtT5BQ7qRPzeq6dOf
         UWjFCz8iRjbiQRiS12/UiK9DCjmiI6m4XBt1zxdYnqFlESTvvLNaOFuisOwnh17TCJqO
         g+RQkvKDQoybLGEzGMKcGjYXfrgD1VGRWlaMO7CmyNlEsTHur5CObaDuK6ivnoV9Qz2J
         ftNnsg0H6eXDHK32pED7MQjTQii03VmqCU9CnqahjCqR3TcjI9EnxG+SBQRRQtFGIe2U
         VwMQ==
X-Gm-Message-State: AO0yUKVVDx90ZxNy4ScBtD6tEanOzwfAhdIyS0ZPVvgiy/JYuBnFl4If
        nZEb7SoshMAvLqHenqjcjn2HZg==
X-Google-Smtp-Source: AK7set8GZAysuh1vxytnbgEUxlKPIUmiScd1FKQtLfvEvrgSqsAGqT845Dtx9NeLeTWFSw7AwRcICQ==
X-Received: by 2002:ac2:5282:0:b0:4d5:a689:7580 with SMTP id q2-20020ac25282000000b004d5a6897580mr2678118lfm.47.1677077611335;
        Wed, 22 Feb 2023 06:53:31 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id w26-20020a05651204da00b004d39af98af6sm646836lfq.81.2023.02.22.06.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:53:31 -0800 (PST)
Message-ID: <64c80ca9-2317-8225-2345-146e41f3c251@linaro.org>
Date:   Wed, 22 Feb 2023 15:53:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soundwire: qcom: gracefully handle too many ports in
 DT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
 <20230222144412.237832-2-krzysztof.kozlowski@linaro.org>
 <dc544641-b9f1-96b4-95a1-30fafc0712e5@linaro.org>
 <80339c7f-1cea-3c97-7dc4-5efb4597cb69@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <80339c7f-1cea-3c97-7dc4-5efb4597cb69@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 15:50, Krzysztof Kozlowski wrote:
> On 22/02/2023 15:47, Konrad Dybcio wrote:
>>
>>
>> On 22.02.2023 15:44, Krzysztof Kozlowski wrote:
>>> There are two issues related to the number of ports coming from
>>> Devicetree when exceeding in total QCOM_SDW_MAX_PORTS.  Both lead to
>>> incorrect memory accesses:
>>> 1. With DTS having too big value of input or output ports, the driver,
>>>    when copying port parameters from local/stack arrays into 'pconfig'
>>>    array in 'struct qcom_swrm_ctrl', will iterate over their sizes.
>>>
>>> 2. If DTS also has too many parameters for these ports (e.g.
>>>    qcom,ports-sinterval-low), the driver will overflow buffers on the
>>>    stack when reading these properties from DTS.
>>>
>>> Add a sanity check so incorrect DTS will not cause kernel memory
>>> corruption.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> Fixes: 02efb49aa805 ("soundwire: qcom: add support for SoundWire controller")
> 
> Can be... but is it really a bug of the kernel? Issue is visible with
> incorrect DTS and it's not the kernel's job to fix it. If DTS has
> incorrect values (e.g. IO addresses) system won't work anyway and that's
> the same type of bug.
I'm not sure to what extent the kernel should be responsible for
checking DT sanity, but in case of a buffer overflow, I really
think it definitely deserves a fixes tag.

Konrad

> 
> Best regards,
> Krzysztof
> 
