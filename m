Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400706B1E56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCIIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCIIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:37:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F132E0D7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:35:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec29so3879763edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678350931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NyMJX4FZ3z6nATgV0EdUV/35bcDn63ExD7FXocSHwQ=;
        b=beZxlMjCfAyByrqCP1yZUFN3nwrIP2o3p4mKeKmm/2jtSRKfQ7vXwtbBZnUkU0oT1o
         G3kvpfp3/muQrnx8BzSSfSCz/VVIjIPMh/pzZ+UEruH11fmEBtOf/9lkHn3aws0fgjzQ
         NiI9ysN6s+7pSI3mUEpf8v8t44TktAhR5xtgLKqu9a3cbP8gBs8UGdvFbgFf+uQ3rHzI
         LhZRLEgRP2vJZQ0FEm7r4BhFV2frPqljwxZ0ZBVfWNJp10pdvgpqb4ZIGs3btMsNghwJ
         fn+/PaOtfufWVFMVTp974ly8++sI/AaZHKZp6+3gpECRAW1rsWdwmMUypbFLijUAbDwe
         B9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NyMJX4FZ3z6nATgV0EdUV/35bcDn63ExD7FXocSHwQ=;
        b=NpqwfuIri+h0qYi7dro1vrzeme618rWvbDAm3RndCIZXOv4vnQ6Kb7C+TEHyVeMTtg
         Pp+/8xnvyELX1v1rkyMHRkhDBJjiZJpz1PpU19ONvdpJUinmeLNZcud0kyAUjfdD8SMM
         YgSiYUm5Su+r0Jk6esCLVckJKiW/i2xmkXK/x1eaDRmSi6aDeNTs81mBAZhZcBA794wJ
         x3DEsosWq2j7I3amsn3pxhaktwGoIJ7SDIx4NgPRK2mgpnKv/I9Olc+DY9JDUg0DwPJM
         pd4ByWtGb86JuKlEl6QVhy99wsZ3yIinSIUoEQd8Qs/QVG7Zf2l6pD67u8CHnuG13zoi
         D3iA==
X-Gm-Message-State: AO0yUKV6otRZtODZJKo3oyAmjvkFXUiGg3YQa3Dd0wFQElDN/3FFMcjq
        mxe6UEx1wVVpmN6vOo8QvkmmNg==
X-Google-Smtp-Source: AK7set87YYU0STxYSpXAizBhk6fkMFPOfS6B+k0H3u4azZuDE6eaLE5lDdU6zPtcpVzcXX/x3T+URg==
X-Received: by 2002:a17:907:8a06:b0:889:ed81:dff7 with SMTP id sc6-20020a1709078a0600b00889ed81dff7mr26422496ejc.9.1678350930905;
        Thu, 09 Mar 2023 00:35:30 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id d25-20020a1709064c5900b008b17de96f00sm8543850ejw.151.2023.03.09.00.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:35:30 -0800 (PST)
Message-ID: <812bbccf-010f-1138-f104-7db7d47ebc9a@linaro.org>
Date:   Thu, 9 Mar 2023 09:35:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: Add watchdog for StarFive
 JH7100 and JH7110
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-2-xingyu.wu@starfivetech.com>
 <94ba1427-21ea-86ee-d60d-7817f8e673fa@linaro.org>
 <783fe50c-1649-b1c4-06cd-ac81bcad5117@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <783fe50c-1649-b1c4-06cd-ac81bcad5117@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 09:13, Xingyu Wu wrote:
> On 2023/3/9 15:30, Krzysztof Kozlowski wrote:
>> On 08/03/2023 04:40, Xingyu Wu wrote:
>>> Add bindings to describe the watchdog for the StarFive JH7100/JH7110 SoC.
>>> And Use JH7100 as first StarFive SoC with watchdog.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>
>> What happened here? You wrote in changelog "Modified" but what exactly?
>> How am I supposed to find it?
>>
>> Provide detailed description, since you decided to remove my tag.
>> Otherwise, standard response:
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
>>
> 
> I am sorry I did not elaborate it. The dt-bindings was only supported JH7110 watchdog in v3 patchset
> and you had sent Reviewed-by tags. But at the same time tried to add JH7100 watchdog after discussion
> and used JH7100 as the dt-binding's name because JH7100 is the first StarFive SoCs about watchdog.
> The compatible also add 'starfive,jh7100-wdt' in the dt-binding. It is different from the v3 patch and
> I did not add the Reviewed-by tag.

So what is the difference? Filename and new compatible?

Best regards,
Krzysztof

