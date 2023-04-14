Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6356E1E41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDNI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDNI1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:27:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE265BA;
        Fri, 14 Apr 2023 01:27:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so389614a91.0;
        Fri, 14 Apr 2023 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681460838; x=1684052838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzKR2LyQ2p4nmkCMjGPaXnh+dnHbOHXDFbLSWiv9aKI=;
        b=pM63Dvia+E1GA/XPoR8yqc3McXi+HI6vownSSu1Fi6nTFmNoACVjzvBTn9oCiSrMUV
         hb2DVaTgQA/i7bGsF9dq8MVSYOoATnHkoIkzB1aJE6WxuVAiVpdecoftLep5KtY+ekzn
         eFPyeQlxM2pzEe05qrBWCDhy0eFjlskEgA4Zl+cSJIiGAFyfy2tOens5i6mL3vu3DXCs
         ZZh2uAuH9p2T7bv2IW0X1Yh9jeNlW/bfFSBnoqblxRwg/Ait2pkzw+hjyg2zQTuRsaH6
         D/JebzTPtPTERsPhssTCBbDhOXhdzXqRmc2aG9y2S/TnTuV1907FQdJcLTr73xSNO6R1
         KgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460838; x=1684052838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzKR2LyQ2p4nmkCMjGPaXnh+dnHbOHXDFbLSWiv9aKI=;
        b=d3sjl2p18rNbTQNsRe5JhiRqR8Km8b8NFZArcMLImrSf8db6BcpjVKdSAuepJCF3Id
         4vKU1zwc8Ce64qjfUqiDvRggykAMVtVEJfy3S9BHiStCkfZ12v9HLAyKnIsDRd1qoRmd
         EmnDB3WmU7/GNR0TdTOzaIuUHTdxoG7AwqLlOzn/JGEPhv7Lz4Q/PkH37ClIQuuhEt4b
         od1U+91Y22NBWugWI0ZtoZv7yVCrzvQWtSV+7qN/ZFKsawNe3ztiJKt1sd8ro1378MZf
         grmbTp7OiqzcTEnbDmHJFAsrcrFDeCkWA8NMwkoB+inygDV4Z2bj4hIAkezC01fi2VXK
         RdZw==
X-Gm-Message-State: AAQBX9e8LXVGIQD1b7CeMEVi9J4KX08QkxH2WJUJXvttVwR5Fu4ZKeyE
        HpsPGGHew7Raug3+ts47mQE=
X-Google-Smtp-Source: AKy350YkpGycY5TWD4lm+/xAK9z9lP/zyakLMPoDbXGP17+eOwwTeByNHA52Oc58U1QToDT7OJpGjg==
X-Received: by 2002:a05:6a00:1744:b0:63a:d2e4:cc35 with SMTP id j4-20020a056a00174400b0063ad2e4cc35mr8012882pfc.31.1681460838532;
        Fri, 14 Apr 2023 01:27:18 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79257000000b0062df30c7e7esm2537400pfp.136.2023.04.14.01.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:27:18 -0700 (PDT)
Message-ID: <7396daa9-e697-5fd6-2e7d-0164302070dc@gmail.com>
Date:   Fri, 14 Apr 2023 16:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1
 reset control
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-5-ychuang570808@gmail.com>
 <874a1e5c-f82e-68d7-3617-042deb928071@linaro.org>
 <41807e8d-b081-6c91-3fc8-f273770ea493@gmail.com>
 <5a59485e-5421-0cd9-ce51-79cf0fd6da79@linaro.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <5a59485e-5421-0cd9-ce51-79cf0fd6da79@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/14 下午 03:46, Krzysztof Kozlowski wrote:
> On 14/04/2023 02:55, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> On 2023/4/14 上午 12:58, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 07:38, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>>>> between the reset controller and reset references in the dts.
>>>> Add documentation to describe nuvoton ma35d1 reset driver.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>>
>>> This is an automated instruction, just in case, because many review tags
>>> are being ignored. If you do not know the process, here is a short
>>> explanation:
>>>
>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>> versions, under or above your Signed-off-by tag. Tools like b4 can help
>>> here. However, there's no need to repost patches *only* to add the tags.
>>> The upstream maintainer will do that for acks received on the version
>>> they apply.
>>>
>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Thank you for your explanation. I was not aware of the rules for adding
>> tags, and it was my mistake.
>> I thought that it was necessary for the reviewer to proactively add the
>> "reviewed-by" tag to the patch
> I proactively added the tag last time. You expect me to review it every
> time and every time add my tag? You know, we all have better things to do...
>
> Best regards,
> Krzysztof
>

Dear Krzysztof,


Got it, I will make sure to add review tags for this patch in all 
subsequent versions.
Of course, other patches that have received review tags should also be 
included.


Best regards,
Jacky Huang


