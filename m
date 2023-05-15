Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBCE702A04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbjEOKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbjEOKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:05:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88B2130
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:04:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so19224892a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684145084; x=1686737084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyEboodinoETFVIKDJ6MaTczEBVanL7D2yaqefiBb6w=;
        b=agNiLDnOYfkL2mCqKdqZSIiw70w52wrUzYgCUEB9n9qAUNdE3IdkTCGecuhuqmqtw8
         VbBnHMCmBZqIlWOujTG6Va8H4lYgd6yZCw8Hpsh1WMRMi6sWR9CV5Zz+PI9y7w66//fg
         arIWFcrfvMNI6tXxJfu9CJuqzfVPCCJXSFfujf2SlRVkcOVZzEbpj9uL91ebQdwYdGGG
         CbwgZp8Xda1ViZ6vvEebMUxYDF/F4JOxw/58B/jGCB4h0Cjhl291HV4z/BwINGd3eH5u
         3xWWfX6QvTTqZC9ircJRO5wuJMvJNb1rKfZ4JR+EFQndEWL5x+zFeDnzajqWMyvorZ5x
         c4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684145084; x=1686737084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyEboodinoETFVIKDJ6MaTczEBVanL7D2yaqefiBb6w=;
        b=Iw7TIBhPzPyTBBTBEmrtN00lwvrqgmBt+qleIqYWtNdtfOFRLQS0ufKtPKlYbx0fiT
         8TtAB4c7CL0gx/dGxFn2DwXvqnkNsmiI6pvpTZ8EEnpmozaLduSNFa1eZiDBhrDJU9yL
         XOpFjCRo0lqp/eRVvwGrQrJJFrv3V7iLm89MDpLcWTAfpwk4VUj4f9qvVpPHehaPd2Vv
         kgq7jZZ3VHM+kZieCnxp8WFxhX6RisKl+jOZxXiEKPGTlog5PcfKsMX73Ik648kNujno
         Qota3XdJmwQd/5ANxG1lKSSzP1+JQbkABbi6AnKjH24B3oCILZjndhum89zfaZi9NjpA
         B8GQ==
X-Gm-Message-State: AC+VfDw7VF/IMusSC5fLJMnK+i0ajBqKWSL72ouoX9OGm65tsWkAxghq
        3z7rvU5d8eCVi//+Ot7KMZbCPQ==
X-Google-Smtp-Source: ACHHUZ5HNnM1GF9ntlgBSWxnLUIuD7ee0ze5RiVw+zE9WMPn5mg3W9l+AOnJxUyQYhNRbGifB0Mx6Q==
X-Received: by 2002:a50:ec8a:0:b0:50b:c275:6c56 with SMTP id e10-20020a50ec8a000000b0050bc2756c56mr26793165edr.16.1684145084277;
        Mon, 15 May 2023 03:04:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402164f00b0050d56dffc93sm7229454edx.12.2023.05.15.03.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 03:04:43 -0700 (PDT)
Message-ID: <0b0c8f9f-bbb0-16e9-1556-eb2ac8cf1981@linaro.org>
Date:   Mon, 15 May 2023 12:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230515031557.31143-1-yu.tu@amlogic.com>
 <20230515031557.31143-2-yu.tu@amlogic.com>
 <590560c9-4da6-bbd4-6aac-de57ab5403ba@linaro.org>
 <8c6ad0a9-7820-c7a2-bd3b-1eee87d96728@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8c6ad0a9-7820-c7a2-bd3b-1eee87d96728@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 09:35, Yu Tu wrote:
> Hi Krzysztof,
> 	Thank you for your prompt reply.
> 
> On 2023/5/15 14:32, Krzysztof Kozlowski wrote:
>> On 15/05/2023 05:15, Yu Tu wrote:
>>> Add the S4 PLL clock controller dt-bindings in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions. However, there's no need to repost patches *only* to add the
>> tags. The upstream maintainer will do that for acks received on the
>> version they apply.
>>
>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>
>> If a tag was not added on purpose, please state why and what changed.
> 
> Yes. I don't know the process. So I need to add Reviewed-by: Rob Herring 
> <robh@kernel.org>. And resend V8?

Yes. I cannot add it top your emails.

Best regards,
Krzysztof

