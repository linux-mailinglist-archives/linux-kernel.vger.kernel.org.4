Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D77300E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbjFNN5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbjFNN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:57:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2BE19A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:57:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30aebe2602fso4785146f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686751057; x=1689343057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPa97b/m8awB1y6CgRTH/CJ/m5ee591UF9NZ2XQQOsc=;
        b=WNNEeJBD1vcyieVRQ0Ke6ZId0JOE110j8GC1VVCVaI+CWwOji2qbhG+5mp0Hemsrhz
         62kTGusy22dWVYrjBsEoVVpM9plEBeEbi0oUh7GaVrZA9/m4xF/knZH5+uhkgs41S7vf
         1XCXYrfQ5kSEjqCQkiB8iKwqfLpwrFgPAtMda9oQmijJdP+FNYksMkZ3YJhhBhnVFemc
         N0bmzIU4BrMMqVTvs0K2yo5531OqfFuIOyISfNacAzOW7IE7/EDYYxlxAkdP9EvrGizw
         10Yolw+AQeW6Hl5nq/G3bpGna09lvWSBf3jBbp50pabpXMFeAIU8h5uzpcyxiKfU/suN
         I8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751057; x=1689343057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPa97b/m8awB1y6CgRTH/CJ/m5ee591UF9NZ2XQQOsc=;
        b=Sg2GYuYx/wN2zgVs9zYGyMmugBtU0mr5SgtH7Zhn2w7cZYkrH8mUUF8VVZix9uwykt
         JztVxSUUN6iV6Pr7tnBKETJfQSSJlaQDPo+sExR31Wh8OSj8vHWWr2RZQXC/0+0/8XfE
         wnSgzM1TSWsw/emX36niRnhdGVChYZuFbxhxCRrAuL3UaIKNqUjmuJjPt0Ox2yBEClwb
         ffmo6208jp2fKKeG9MKcJ71G6pJe18rmDftcaGD7wxOWlMzWxBrtxyRFgPzAJNxyTyXZ
         wRVDUp0hXeaaGewoKJmoqXmzv6a0SmbtMBDBiaYiEaFTDKK/xT+X0dFWwrAcp1Fsi4NF
         fTdw==
X-Gm-Message-State: AC+VfDz/Uef5rhnQ778tP6UjII87ohuOOaXyQdlppntDRyKe9hrCeW8u
        BYfi2J1kjSoZ8l8NokT/y4J5pw==
X-Google-Smtp-Source: ACHHUZ5q0xfEjsdETTqI7KGtJmGo/tlRbRPlZ+7Xc2ZNFm3qHNRVGXDwHOHEn/T7mDKELNIARHkbQA==
X-Received: by 2002:a5d:6890:0:b0:30f:c7e4:d207 with SMTP id h16-20020a5d6890000000b0030fc7e4d207mr4562659wru.61.1686751057390;
        Wed, 14 Jun 2023 06:57:37 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i1-20020a5d4381000000b0030c4d8930b1sm18237278wrq.91.2023.06.14.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:56:06 -0700 (PDT)
Message-ID: <0411f4ec-79a4-520b-e246-f20ffb0f1e8e@linaro.org>
Date:   Wed, 14 Jun 2023 14:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC] media: camss: Intepret OF graph connections more
 sensibly
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614-topic-camss_grpah-v1-1-5f4b516310fa@linaro.org>
 <8f53da6d-76ec-a7e1-8308-b676930d224c@linaro.org>
 <efe0b912-24d8-9617-ce6a-aca5dfba6910@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <efe0b912-24d8-9617-ce6a-aca5dfba6910@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 14:50, Konrad Dybcio wrote:
> On 14.06.2023 15:48, Bryan O'Donoghue wrote:
>> On 14/06/2023 14:22, Konrad Dybcio wrote:
>>> Not all endpoints of camss have to be populated. In fact, most of the
>>> time they shouldn't be as n-th auxilliary cameras are usually ewaste.
>>>
>>> Don't fail probing the entire camss even even one endpoint is not
>>> linked and throw an error when none is found.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/media/platform/qcom/camss/camss.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
>>> index 1ef26aea3eae..3aa03fbc94e2 100644
>>> --- a/drivers/media/platform/qcom/camss/camss.c
>>> +++ b/drivers/media/platform/qcom/camss/camss.c
>>> @@ -1084,9 +1084,8 @@ static int camss_of_parse_ports(struct camss *camss)
>>>              remote = of_graph_get_remote_port_parent(node);
>>>            if (!remote) {
>>> -            dev_err(dev, "Cannot get remote parent\n");
>>> -            ret = -EINVAL;
>>> -            goto err_cleanup;
>>> +            of_node_put(node);
>>> +            continue;
>>>            }
>>>              csd = v4l2_async_nf_add_fwnode(&camss->notifier,
>>> @@ -1105,7 +1104,7 @@ static int camss_of_parse_ports(struct camss *camss)
>>>            num_subdevs++;
>>>        }
>>>    -    return num_subdevs;
>>> +    return num_subdevs ? num_subdevs : -EINVAL;

Can you if/else this instead of the ?

Then add my Acked-by:

---
bod
