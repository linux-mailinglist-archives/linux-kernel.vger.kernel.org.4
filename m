Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE96B82DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCMUhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCMUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:37:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87588D87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:37:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso12972705pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678739839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Eym63TM4KgsTNGStmMuI60e+3KvWu4UM9TlUWPbCao=;
        b=QZvHaXSUo12vTSeH7fF926ddWsF5PfwbeseQItsRUBTSaFrWwEgpIRIMM6GOXYXFzt
         4ls1tjt/awzhfxBZDU+bgcG7jlrLIYW/DJs4DL4vZgHXsnujINej8fpkoShEhZJ7K61m
         tt0Qpfmef/MONRhvFUkSOfz+djSt12LTGOlVf3w9WIF6GNvVvj2ed/PIUjHSxhxtZxvW
         0c/7vu4lcuZ1Km2Qx46zfahw1OcBcQtZsvaa4oEiirheUjtr0JA4YN2Pv6CivEG63xEe
         4fx3BUY04YA7AD1uQSki6E10bKM62QqoMwbWoVAvfS3bRYHJd/DuAjikX8jghURcnmhD
         6gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678739839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Eym63TM4KgsTNGStmMuI60e+3KvWu4UM9TlUWPbCao=;
        b=SZvBk6ZVmh0smf/CbIO9DJhsB3Gu0ga7IDTrCuhBpz64+ZE7dG8ASFW8Goa9NIbe04
         z/dHr/Ma4kck7gYs2wCrztrRU+tBfJ7sic4rgdHQPAPRBwbZ6r/LCEhNoIgd2avIJedE
         SGBIVBReEAg+Tyv5mkIMomeJMSrN0uX96mZ8UjTwtjeBDHqppE0uHEIOrw1dE/K/6zsh
         Q8Hkx0CCce2hZYBZmx8DQ+AnXpnVvv3yOQrpv5bZIoppPMPnBdaUcdBqtiYX7hlBPOvx
         Froq9/DVLStRdt1T6KcY6aFlikAc5IUYpTgTqlSi4sp7wCu5/gfzcC5Sdjo7zVw97bc6
         jOYg==
X-Gm-Message-State: AO0yUKVKlifDLIDpg2trIz/qp3Si8EHgqwC5usUAWeIyoL73OJaQ/SnQ
        HMkUdrVNQUgmsJjp4dE4OXO1wg==
X-Google-Smtp-Source: AK7set8fianLoP6cpm7Osru5bWjvxpTuuwNW+QjuIDJqhS4wSr4TVYgQrs4DWnq8TCBKinOc1lbJUA==
X-Received: by 2002:a17:902:f54d:b0:1a0:4fda:54a with SMTP id h13-20020a170902f54d00b001a04fda054amr3816849plf.56.1678739839161;
        Mon, 13 Mar 2023 13:37:19 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e? ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902820900b001a0448731c2sm285150pln.47.2023.03.13.13.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 13:37:18 -0700 (PDT)
Message-ID: <35700295-8f30-08a7-2f83-edd3d92482fd@linaro.org>
Date:   Tue, 14 Mar 2023 02:07:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add CPU idle-states
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230118203428.910992-1-bhupesh.sharma@linaro.org>
 <77fbf01f-58fc-55a2-415b-c39d991e7c96@linaro.org>
 <CAH=2Ntw4hMyV2mqRu1t=WWG24=wKq96PB+eYFtZ4qYQz8dteog@mail.gmail.com>
 <e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 6:33 AM, Konrad Dybcio wrote:
> 
> 
> On 18.01.2023 21:48, Bhupesh Sharma wrote:
>> On Thu, 19 Jan 2023 at 02:10, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>>
>>>
>>> On 18.01.2023 21:34, Bhupesh Sharma wrote:
>>>> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
>>>>
>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>> ---
> [...]
> 
>>>> +
>>>> +             domain-idle-states {
>>>> +                     CLUSTER_SLEEP_0: cluster-sleep-0 {
>>>> +                             compatible = "domain-idle-state";
>>>> +                             idle-state-name = "cluster-power-collapse";
>>>> +                             arm,psci-suspend-param = <0x41000043>;
>>>> +                             entry-latency-us = <800>;
>>>> +                             exit-latency-us = <2118>;
>>>> +                             min-residency-us = <7376>;
>>> These values vary per cluster, see qcom,pm-cluster-level@2 in the
>>> file linked above.. We should either split that, or at least take
>>> max() of each value between the two nodes to make sure the sleep
>>> state is exited properly on both types of cores.
>>
>> Ack to both the above observations. Will send a fixed v2 shortly.
> In doing so, please also add support for D3G cluster sleep states
> as well, it sounds beneficial to have a middleground between a total
> power collapse and a simple wfi.
> 

Right. I am adding D3G in v2.
I will share the same shortly.

Regards,
Bhupesh
