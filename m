Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5276F300F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjEAKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjEAKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:05:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB2E48
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:05:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-956ff2399c9so478699266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682935551; x=1685527551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nc4PhAMrOLTlbgqbAftOku7N9NpDflo5yDtm5yYgPu8=;
        b=zD+V+ei/Do9FxEWNmNm7WCDVOl9mdYftzjEpPNd7ek4D4hcaCNzCLetn2p7HrXE+cG
         Ev7r6Rv/6e3TwcnpHueVX9FN7+gv4WnS3HTFJ0QHLliFdsKsksJrPbI5eVrLUr1DMHx5
         AavRbXydzgyW2cfCcMvDYk8Z0sa2wABOz1VFx+BzI2x6uA4e35p2ID0s7b5GAuVg+fjA
         cNeXcNY3memsjLQTM+pKxYkq88UOrqIS3CYqhc/VrSfjSOZ8NHbdOpW5p9IOdsTTw3BW
         DKOVcL9PZ8OarRxIHB1Yx+1hCow5D3E4+wtu6rhMJitwtum5PxZsCGg+UQ3XStKZS26F
         SIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682935551; x=1685527551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc4PhAMrOLTlbgqbAftOku7N9NpDflo5yDtm5yYgPu8=;
        b=jgqZZ15tAnw4OS8cC0WKfBKGRKHu1cpQ0N/QRhlTOT1QZu0ObtZDu++jcAZdifAUll
         pZt54ByhqE+PlJ/kyEl6oAu+VeVrPQ0/6sJcgewItaxoIcg4YBHm+8UMrluDHJqbGRUp
         K+F5tP7bKr2QiWnl1CZfanMp4oeuV11qMt5Gu5Cr8tlaclhi44D7I7bUr6CPSCZA6WRe
         acqHFo/rE90lfZQ2QyrNQNU3pdjdVyv8hnIPtZ8fKUULsOeXj+Athaku+mNBcnN6wbQp
         ALUPuX0IMd598vpER79qUrXAGm5qlZqXvRCldnNbV3iPqHf+WeESJfFRXYwvZe0NqcGH
         NbQw==
X-Gm-Message-State: AC+VfDzmFulclQqYodia5xyjpzXk30zw6bvy3HP8Qe25tZxkx7P2eaPR
        Qi70KqeQHPdGd2tuYzHmY8QFWg==
X-Google-Smtp-Source: ACHHUZ61UINPj5jaB3EFD4qHRZNHQQ8lpUzoHUfZ2aELodqL0E1nMYYOtJqjTPUsWoYWZ4H0JjWb7A==
X-Received: by 2002:a17:907:9285:b0:95e:d74b:d171 with SMTP id bw5-20020a170907928500b0095ed74bd171mr12138929ejc.28.1682935551059;
        Mon, 01 May 2023 03:05:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id b21-20020a05640202d500b005083bc605f9sm12011239edx.72.2023.05.01.03.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 03:05:50 -0700 (PDT)
Message-ID: <1a30fc8b-b57e-de40-d396-892b55649a77@linaro.org>
Date:   Mon, 1 May 2023 12:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RESEND v3 0/3] Add support for ESM
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Neha Malcom Francis <n-francis@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, kristo@kernel.org
References: <20230424105011.70674-1-n-francis@ti.com>
 <aabe7488-29b8-895b-38b8-67e5a7d1dd35@roeck-us.net>
 <705557cd-0a60-3cda-d78b-d78e2faef856@ti.com>
 <a1e940aa-7ede-572a-80ca-d950273e5ba6@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a1e940aa-7ede-572a-80ca-d950273e5ba6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 16:34, Guenter Roeck wrote:
> On 4/25/23 01:49, Neha Malcom Francis wrote:
>> Hi Guenter
>>
>> On 24/04/23 20:27, Guenter Roeck wrote:
>>> On 4/24/23 03:50, Neha Malcom Francis wrote:
>>>> Resending as no major changes, commit subject change only.
>>>>
>>>
>>> Maybe you consider changing the subject of the bindings from "misc"
>>> to "hwmon" as not being a major change, but it made me aware that you
>>> are trying to sneak bindings which in my opinion don't belong there
>>> into the hwmon bindings directory. This is not a hardware monitoring
>>> device, it doesn't have anything to do with hardware monitoring, and the
>>> bindings do not belong into bindings/hwmon/.
>>>
>>
>> I understand, it's a thin line across which I pushed ESM into hwmon; my reasoning was ESM also actively looks for signals that it aggregates, and is overall monitoring the device health. But if there was an option, in order of fitting: fault/ > misc/ > hwmon/
>>
> 
> That is really a stretch. It doesn't monitor anything. It is a signal
> routing mechanism.
> 
> With that logic every transistor would be a hardware monitoring device.

Then let's move it to misc/ as I don't have other ideas for the placement.

Best regards,
Krzysztof

