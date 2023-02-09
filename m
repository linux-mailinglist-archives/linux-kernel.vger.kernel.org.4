Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B510C6908EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIMc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBIMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9303C27
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:32:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gr7so5879302ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mI4A2A/YRcpk0KsG7+KaCv38yTM/sk8ZRuS5AtlWkYQ=;
        b=uEXiZv8uI0iDjLIXc1PYXiwS+u0Nq9dfXCD6Kn9rWyF6pARLTEka8Na+KXb6kyU/wH
         loK4kq5BGZ7L5nIzKb1x2/BuIm+O1WkvAo3MFaOS3oEguw7Dv2/rrSiNszsCgQ9gCmkk
         0qDdt6jwfXk01cQLM/1V3PC+lVRtmV2LxcthQlya0+mYJl4oI5ywb8ZywhM9bxnkaH0T
         9H6SdIp/b48DaKWM5uP3SWo8OfXbowTo5jyrWOuClwLu7xtHYKfcC28lP1Z5HsCrjCjx
         SwQXvkAS0Cmg+5bBOPivh8bW+2Nhb24MgqDj8dmlMkYOwMi3kagpd5ZMpBKgD8yX3lwc
         qs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI4A2A/YRcpk0KsG7+KaCv38yTM/sk8ZRuS5AtlWkYQ=;
        b=ROmuI52PnP6n3QMHmmV9SKwNb/91gml9yblid5zHXW4u7u7A+KPgXS7YKlHb4kysyv
         zQMkRjvjJ65+LdRCX3zMR4JyrgLl7t3QMRBlTk5ydk0ZDX4zYJSYl7k74uZdppQsnqDe
         n1bntg1d9rsYq2GBi5ZD5zc0qJcVzkUGbTvX51eQa+BJnuHQUj628wDI2Gizp7jlEU9l
         30XEl/LqQRQfb1OfTLlmR7G7Js2cqHaWmSgCZU9EA8ZJcjdyBjfuFc8S6kKhioq3xcVd
         kNkGqsynQMD3A8u9Bo7opeAjLK6xzhfTLhE3mxT7X3zhWov8a3Gpngwf1de9WOh2CSP0
         FvwQ==
X-Gm-Message-State: AO0yUKUkpq5f0zyx1oJFtcEjfA5hOj0Rq4Iadw90iz5alX3ogTXHC/DT
        jHzMKmMdhxR37FMUPjL2KF82nA==
X-Google-Smtp-Source: AK7set8nWM/OSDeX2zOKTTybXG+LAP0FSQqgfmkdWfTQ2Cc0RIYIPycfvojWDhMZq00YKJq9jdxrRQ==
X-Received: by 2002:a17:907:20ac:b0:7c9:6e0e:1427 with SMTP id pw12-20020a17090720ac00b007c96e0e1427mr11740156ejb.6.1675945952630;
        Thu, 09 Feb 2023 04:32:32 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090640cc00b008a47ee398a9sm819738ejk.47.2023.02.09.04.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 04:32:32 -0800 (PST)
Message-ID: <76311e72-0e18-d6b7-6dfc-a312e930e095@linaro.org>
Date:   Thu, 9 Feb 2023 13:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
 <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
 <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
 <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
 <ed737e67-eabc-6f29-b734-f4698767ca8e@linaro.org>
 <fa2e0db7-5b27-5a41-920b-b786dc4e521c@linaro.org>
 <027268b7-4b04-f52e-06a8-9d924dc6efe4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <027268b7-4b04-f52e-06a8-9d924dc6efe4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.02.2023 13:22, Bryan O'Donoghue wrote:
> On 09/02/2023 12:11, Bryan O'Donoghue wrote:
>>> If the bootloader splash is enabled then this memory is used until the
>>> DPU driver instructs MDP5 pipes to suck data from a newly assigned address,
>>> so there's a short window where it is.
>>
>> It seems a shame to reserve 30 something megabytes of memory for continuous splash unless we are actually using it is my point.
>>
>> If I'm running headless its just wasted memory.
> 
> Couldn't we
> 
> 1. Find reserved continuous splash memory
> 2. Fee it in the MDP when we make the transition
> 
> It must be possible
I suppose we could mark it as shared-dma-pool, pass it to
MDSS, reserve it from there (by occupying the whole thing)
and either use it or free it before jumping to the newly
allocated region.

The MDSS driver can already accept it through memory-region = <>
IIRC, but *nobody* uses that, so I'm not sure it even still works..

Konrad
> 
> ---
> bod
