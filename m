Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1C67CE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjAZOcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAZOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:32:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830E3C2D;
        Thu, 26 Jan 2023 06:32:46 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id me3so5516246ejb.7;
        Thu, 26 Jan 2023 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2O8IXbwntgqpzPKwbw1Aev8+c15Xxh/E8XGeMKjxfY=;
        b=UoxSsfQ+4YXUyobuuxig3tHEsdLwYpWmEB8Na6HmP/suhG/NdYOfQA3lPi1jcVDGw+
         8B5UPANUwhsgob+lC5b5tqYaI3XZcNIaS4GntFHiJcLNpNf07U0wDKBtAoeOtAl7G0qr
         nEhtMO4rmFrW524FR5F1jB2tEYN2fGHrZ6am+pJjcm+fWYqT1oUDoNgnooLnU2Xt/H8L
         pvG9JexWtfstPuordvp/Ii1x74L4b37K87LWBi34KbGWJC4cuy85DK9fH6j7bz6BszBX
         xXUDN13U4sObAoR21RwB7+34Sm8HNjO7EZqzlVKTr74Uj61ZwEwaY8PV8+aH7/r4T9rf
         sbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2O8IXbwntgqpzPKwbw1Aev8+c15Xxh/E8XGeMKjxfY=;
        b=DbrlzEtVvIqytNUxq2sh9ZkJWkiKvBHkjCd4W7151geav7dCtafyr4vQGH9tQVb80y
         KdSZ57iXemaKq6JNS8/I8eRa4TabqnzdUtOpZyzROnSdR6QSXeX4Um9mGwcLByWAw/uL
         +LcrLaLjcDAzLmefkFxxIg68I3m6j1pB7A2IMS17a7Nq4W+LHxBuPa3KXAkDpgtzTzil
         kbIX+wmnEjoC3yOlLkZ0BhIRqWVN2BkU9l6CQVq35g1ZoCKfRum1fHcJGgpoxOY1lF5g
         tSXUxt1bcdS0fKQeirl4M7VSMfqLd5IkcdiPUlsRf4bk793y+V5Ypk+MgubznB1VnNE1
         8H2w==
X-Gm-Message-State: AFqh2koupkCZdGLo5YsXzOIw7G2neB8gmL/zUyqyGhQzEQH+zMY1Fb07
        zBGib7KtlfLmUkN18C7Jnds=
X-Google-Smtp-Source: AMrXdXs8jVxgA1YdKfSSwjoisrGGqkjV4MBjiUaAA+cRf3N0uInFrzD0m5uzElZJ6Ja1lQxBDEDKqw==
X-Received: by 2002:a17:907:7da0:b0:86d:67b0:6292 with SMTP id oz32-20020a1709077da000b0086d67b06292mr53631924ejc.73.1674743564695;
        Thu, 26 Jan 2023 06:32:44 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o25-20020a170906861900b008675df83251sm670962ejx.34.2023.01.26.06.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 06:32:43 -0800 (PST)
Message-ID: <c4633d6a-9aa5-5c43-bfcb-611cd96e1c5b@gmail.com>
Date:   Thu, 26 Jan 2023 15:32:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-2-moudy.ho@mediatek.com>
 <8ae4469e-ed2c-5019-605b-013a49af77ea@gmail.com>
 <124f081819a80482b3bffd8e12d747fc.sboyd@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <124f081819a80482b3bffd8e12d747fc.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2023 03:05, Stephen Boyd wrote:
> Quoting Matthias Brugger (2023-01-19 08:08:48)
>>
>>
>> On 18/01/2023 04:15, Moudy Ho wrote:
>>> MT8195 VPPSYS 0/1 should be probed from mtk-mmsys driver to
>>> populate device by platform_device_register_data then start
>>> its own clock driver.
>>>
>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Stephen, if you want I can take 1/4 and 3/4 through my tree. 3/4 shouldn't be a
>> problem, not sure about this patch. In any case if you want me to do so, I'd
>> need a Acked-by from you.
> 
> Do you need to take them? I'm picking up mediatek patches currently so I
> can probably just take 1 and 3 if there isn't any build dependency.

No I don't need to, no build depencies. Ok, I'll take 1 and 3 then.
