Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E682E676830
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAUS73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAUS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:59:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125F23C4C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:59:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so5872800wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+8AIcmyNh7anmgy6us1S2qZEpfi8cOsNKu1F+SDuic=;
        b=DSNmytpeph3gW86uTDWNK4tSD4wjbNZ+cDtqBYO3TGJYyGKeyNEnyDHpdL6NbHsnsR
         H1HZAwuXKokfN8LsS1QrJEyAeY7EIOdPKb8qeSzkOktbrnPpL84L2xaMDr+0F7xXZ3HP
         5S4Q3pnfupRaVcL3f8GPGj2rc3jlDXy5D+vFJdCsgI6+Ntr7Pp1uQ4A5TgxZMj9fYqZf
         zXsTyha3a2JkjiMkL3x711hQtBd+fuhd9iZtgPTCo4Ow3XIhSI0bGl5NGf8QzLUz0wfA
         UwXvNPRSl2+7FhnwqvCm6ZPJaHNQjALqXvNoOxOpD3cch02DvgwxSnlmxIBX2RIhkkDS
         BAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+8AIcmyNh7anmgy6us1S2qZEpfi8cOsNKu1F+SDuic=;
        b=0XSFgZ7BCtA1frSHqYnmo1Ubw/25I779xXE3feJ2WaVp4//snEcBxna7zOy6vJ0zvn
         sUnF4U4ly6hn9CeJawU7MSz9bpEkyyznVR6ZdrQW+EeVBQmyc6c0BjJUF3EzLGDUWlj0
         xLyMo1WEfoinE172p7Jd9gn5JquXT7zSeNOtQS/3UWnHTPES/BPxRvZDLqJP91VPhRFX
         vCpJyD6XWMAsPk8dndiwysamrDhFRmoemFDSFVSCnMlFGILEFr0sT35qkwBYivrY6y+7
         1/B3sfPzdcXSECmrZJfomg9FaeFN5ftofL9TAYU/ZenlpxnFVzi1JoX4NQ0oLHI0SwUB
         73Og==
X-Gm-Message-State: AFqh2kpNo8pvTlnLgYLUpvsA3pOQV/Xb7hk6wJ1EIP1qAw4BDBw9iwAi
        YXWstM6Ic3zcrWMoyRYmEpX3sg==
X-Google-Smtp-Source: AMrXdXuEm576fBINS2Nr1ehlHPHAUS08eLwq4m7iyjQxHe/PDV7pRwzAmtYjpecqMbhz1ClAl+8oUQ==
X-Received: by 2002:a05:600c:4d91:b0:3da:fb96:53d with SMTP id v17-20020a05600c4d9100b003dafb96053dmr17702315wmp.4.1674327564340;
        Sat, 21 Jan 2023 10:59:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003db01178b62sm6848719wmp.40.2023.01.21.10.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 10:59:23 -0800 (PST)
Message-ID: <277a46d9-587f-324b-10cf-064302bdd2c5@linaro.org>
Date:   Sat, 21 Jan 2023 19:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom,sm8450-camcc: constrain
 required-opps
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
 <b676c36565da1b73c53ced6218ef6de1.sboyd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b676c36565da1b73c53ced6218ef6de1.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 23:15, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2023-01-19 05:00:27)
>> Be specific how many required-opps are allowed.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> This change is independent, although logically is connected with my
>> dtschema pull:
>> https://github.com/devicetree-org/dt-schema/pull/95
> 
> Do you want to take it through dt tree?

I think it would be better if you take it.

Best regards,
Krzysztof

