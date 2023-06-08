Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA2727EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjFHLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjFHLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:36:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1A1FF5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:36:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9788554a8c9so95010166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686224216; x=1688816216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQWWI054RvloK7dl2oxvJAk/+Nn8DzlFxz+iqkh3yR8=;
        b=A7bQLvR+IH8m04PQqGNvmbATQJagZzGJQWyyTxFvmE2dpYiuLLXa5jIMPSwChKNVKl
         J7yMWr1JCMCEOegoTZux5FzmL37PgR+d2ILEAkyBU+bXVjQFNtTWojv+0pMEQNc0c8r4
         V7EZHtf33JLyD0psYknTGlvz4hTH2F8k94mvHSoZiMix4E/rDb7/uJE9UT3RH8ojQwz5
         Nqz8xHZ7moDQtbDkonv89wcLll3WeWBuQzuqQb7PR69TAym7cnzsTUyskSSj+H71x/Hv
         R0PyYHcu/o1kJlycpLW92iL65Py2czUz2AKLLdBMbYF4V/V+WfknJT5AtbsfPcXDKWeB
         bqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224216; x=1688816216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQWWI054RvloK7dl2oxvJAk/+Nn8DzlFxz+iqkh3yR8=;
        b=lzv8es6Frp2vRDCVnpA/+wf0ECon19+cemtA0bZKI+XKovcPw4A9/TR8bOg+0G/6th
         b5SZP0B6l6hjMfNoBmycq+8CQ1thGrfaeNo5shTpMj0bihEhHp1GYsP0hm7nR7hZytml
         Hk3l43AzMVgf3Gx4jMQ1IgEZAFrVe6Yxdg8ex3EDCDQOy7DSmPNBYZGQ2R1+Umv8A0sN
         qR2qasuuis63AG0Ip6emOxyfxBLiY5iRmC8/YJFmeTrC5E7PZ8wW7HmyhXK3wgQ7hGBU
         f+rdJoDIR/TrdN68Msc26sAeo+oSlhDW6JrHli1m0V4BAs515RS6t6nuDwHfcejtUJ3R
         WLDA==
X-Gm-Message-State: AC+VfDxPSBApNy+LME9/+lmPS7aWRObDsJmsTIWUbvUs6lTbPP7D4uNp
        r9/DFaaOWAwl8usVIL2zW1CEQg==
X-Google-Smtp-Source: ACHHUZ4elyWGDezUPyDiJiGdSkDoQCsi5pS/58U7qjcTQ7drFCO3RsLFxtDosFEJP4SuTQnzLoHfJw==
X-Received: by 2002:a17:907:60c9:b0:977:e87c:e633 with SMTP id hv9-20020a17090760c900b00977e87ce633mr11547349ejc.23.1686224216035;
        Thu, 08 Jun 2023 04:36:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gf1-20020a170906e20100b00965b2d3968csm585161ejb.84.2023.06.08.04.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 04:36:55 -0700 (PDT)
Message-ID: <077e08c8-f2f7-2fef-9e2c-bc865bc611a6@linaro.org>
Date:   Thu, 8 Jun 2023 13:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v1 2/2] misc: fastrpc: detect privileged processes
 based on group ID
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-3-git-send-email-quic_ekangupt@quicinc.com>
 <bdf49a17-bb4c-a00d-0239-ed5d0eef470d@linaro.org>
 <4c27849d-cd34-77ed-7d45-6f366f9fa86a@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4c27849d-cd34-77ed-7d45-6f366f9fa86a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 12:44, Ekansh Gupta wrote:
> 
> 
> On 6/8/2023 12:17 AM, Krzysztof Kozlowski wrote:
>> On 07/06/2023 18:30, Ekansh Gupta wrote:
>>> Get the information on privileged group IDs during rpmsg probing based
>>> on DT property. Check if the process requesting an offload to remote
>>> subsystem is privileged by comparing it's group ID with privileged
>>> group ID. Initialization process attributes are updated for a
>>> privileged process which is sent to remote process for resource
>>> management.
>>>
>>
>>
>>
>>> +
>>>   static const struct file_operations fastrpc_fops = {
>>>   	.open = fastrpc_device_open,
>>>   	.release = fastrpc_device_release,
>>> @@ -2277,6 +2396,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>>   	if (!data)
>>>   		return -ENOMEM;
>>>   
>>> +	err = fastrpc_init_privileged_gids(rdev, "qcom,fastrpc-gids", &data->gidlist);
>>> +	if (err)
>>> +		dev_err(rdev, "Privileged gids init failed.\n");
>>> +
>>
>> What about error paths? No need for cleanup?
>>
> All the necessary clean-up is added as part of 
> fastrpc_init_privileged_gids error path. There is no requirement to have 

Where? How that code is called after fastrpc_device_register() failure?
Or after of_platform_populate() failure?

Please show me the code flow.

> any additional handling in error path other that error log. Also there 
> is no intention to fail the probe in case gid information is not 
> properly read.

This is not related. I don't talk about fastrpc_init_privileged_gids()
failures. Look where did I leave my comment.

Review comments are placed in proper places, not in unrelated parts of
code. The placement of review comment is important as this is the
context of bug in your patch.

Best regards,
Krzysztof

