Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9E6B5BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCKMg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCKMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:36:23 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE471368A9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:36:20 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y14so8102413ljq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678538179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKq3UOpgcv7dOjJn1dLmGbzJrysgGQToZlLkm4HZwEM=;
        b=qKCvLXh9ll4O56c35waq5CaCZiYyzPaT1tUcmskQ2WY0vgP4hqZShds5KJuyzcqM5R
         ski3PHKV5m0/9L9j+6S/Hpxmv0Q6gC74B3Dlv3/grBvgVYHtUoGrw6u4iO50MFx7vYP+
         xfumzyPb1RAGUY3363xjvwGQl1BelEipSLuz+PyDwQL+rtEoB76IayGSzX73Uy0aJtQe
         sjznDdRGylB5raA/wYwbpxuacLnwVo+o21feJrc2d224SY+s3hCJWFiJJdrCMSfpVA+q
         kP0vMxSBcqH+tG16VEZkffjdesoW+8trwuiF+nMi3kyMspVy8CECbuRhH7JLqXy7UtGz
         fiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKq3UOpgcv7dOjJn1dLmGbzJrysgGQToZlLkm4HZwEM=;
        b=C5wdhNZcz6tdhjftYFYnZX59330yuM5s5dqQItr528AcGNXsPMa0imU6OGKHleDZkk
         4kVtoihYrbugTvsKZGG2HM2XrpDZZ3K27L3X3EfETg+vw5NDP1/XRkftbfETRnQjZZIt
         R3h/QSZJunho/VwWzAF9qESG4edOkx0ChnZIyE3vwKzcl7bd1wvgz5B+ZvD+2TKEd4wf
         nHYe94QEpCgFqnH7R6pXOj/u8NwuiReBt5kdzY6UuX5gjP6ds9nQh/QsZaBQBcNY9HQX
         m5Y2HrQo0CuGAalFr1HMdfL9P2QYHmKEsxhJYVRHupOmFUhqmpSwhzllzQUEVFExw89G
         PZ0g==
X-Gm-Message-State: AO0yUKX2txW7dTlo4vnTOjcgAV3O0ndVH3K8WRargwT5/y0Yktlgre8N
        4plFIMP/hrpwjUNLH+aflnf0/A==
X-Google-Smtp-Source: AK7set/ve/82/jh259j3jFvjcUtoMjtiSUrbwoxhf4whEIOVUxf5kgbZKOVor+py6YR0tXj2rx7FSA==
X-Received: by 2002:a2e:9186:0:b0:295:c386:35f6 with SMTP id f6-20020a2e9186000000b00295c38635f6mr8354782ljg.44.1678538178981;
        Sat, 11 Mar 2023 04:36:18 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id f4-20020a2ea0c4000000b002958bf18efcsm301025ljm.104.2023.03.11.04.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:36:18 -0800 (PST)
Message-ID: <784d08ea-04a3-bbad-66e2-d19d98c0e5d7@linaro.org>
Date:   Sat, 11 Mar 2023 13:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <50f03895-816f-be8d-d956-d237fb13f5a0@linaro.org>
 <6d10906e-08cd-0380-5f5d-3ac0eec60276@linaro.org>
 <67590cd3-5543-59ed-6158-b272103ebd05@linaro.org>
 <858a8925-f11b-652d-3f02-f5ceea7d11fa@linaro.org>
 <74c0c724-b6a9-3755-7f56-9f421cece1a3@linaro.org>
 <500c7924-c43c-4233-1688-f8b6fbbad66f@linaro.org>
 <544e6f22-f2f4-2c7c-1978-a96c9763e2ab@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <544e6f22-f2f4-2c7c-1978-a96c9763e2ab@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.03.2023 13:11, Bryan O'Donoghue wrote:
> On 11/03/2023 00:54, Konrad Dybcio wrote:
>>> - Update the commit log and potentially the structure comments
>> I'm probably just very biased because I authored these commits, but I can't
>> see which part is not clear.. Could I (and this is not passive-aggressive or
>> anything) ask for a pointer there?
>>
> 
> I mean to say "non scaling clocks" isn't an indicator IMO of the fact that these are QoS node specific clocks.
> 
> Right now the interconnect model is predicated on bus and bus_a but, you've found that on some SoCs we have node-specific clocks too.
> 
> :g/non\ scaling/s//non-scaling\ node-specific/g
> 
> would do or "QoS node-specific" the fact the clocks don't scale is incidental the dependency though is that IMO at least these are additional node-specific clocks we need to enable.
Okay that makes sense. Thanks.

Konrad
> 
> ---
> bod
