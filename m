Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860F6887F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjBBUAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjBBUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:00:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF9D8003C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:00:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id be12so3207709edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NoqwPWGdPAAWq3tFe6UZV9Xjkz8TFbiEHT4UnURl68=;
        b=Tn28cTUSKVUffrD7pCt/S1MhVB2RkrGSUwZX/JySWEYfCCwjY0OGIbyUa/ZCwJFffY
         apfQkcw3TMBqChoq4X37lw40vtgOLTx0jwMxK7xd21TYs7M7uNtqkxqK6tJTIA4jbk3F
         lr0s8xjSde00oNu5sxyac8YAn4DJakT1oN6Njx39tGn6hpYtheIen5hx2aqhR6Q6XWgZ
         JJBKXwZVfTZd4jDAnnZFQ26FFZJYJz5Xq7PSi5/c9He0Q22yjnj0KWOcTs5yvPthItKq
         kNmTSaCq/aB65gkTgiS8uHjYmW/GwH25E6jurgCa8WKKM7cVdmra1RyC1mbhWMD2PaVB
         mOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NoqwPWGdPAAWq3tFe6UZV9Xjkz8TFbiEHT4UnURl68=;
        b=cPcRyRq8e8p7mqQ71fEjkxKXuIps8MxDWC63nk0NM97d6SoWazQ1YXynNy4DWMzriE
         XgLuLpvp/Aotuuf8LNvRpBEU8ma7gC0PfkWl1+kwSmTon/nLW9Rv4uMZ+3UveXRFsdyn
         aVwAkIzYsVe+3GwS3dzZyZN4EHOzOg3l8Z/7sAzpS9CZKF6T6hzKqPtlSehRJahirDaj
         E+pLn9uKQsefKAd+tofL9AuxrrTKGHCsK3Drv3epxTP8UUNHqRMk8UVxah6lf7NqEzI3
         jDrcETJMHsbmbbrwke8QwgeYDs8F2Re/2Sfw2zPqiJS3StNUWe7hhQd7Y5Od3v5CXgsN
         sqjQ==
X-Gm-Message-State: AO0yUKXC274iYQSXl0Tw4z+auXrgiEXV854N7QB4SjbY0PclXkfSTpfc
        QsQ+ZKUIRtEJ9D5XTBQ+AKJUIg==
X-Google-Smtp-Source: AK7set+rkkWRJNhGP6gyYP8lfc64qT2+M4TGBD1kvog85pXPp56JMHboaZCnQxFv3pufpNjZiZNnxQ==
X-Received: by 2002:a05:6402:5288:b0:49d:a87f:ba7b with SMTP id en8-20020a056402528800b0049da87fba7bmr7635461edb.39.1675368024344;
        Thu, 02 Feb 2023 12:00:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id el8-20020a056402360800b004a2470f920esm160692edb.25.2023.02.02.12.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:00:23 -0800 (PST)
Message-ID: <8766f07e-a5d2-b59c-d130-f8cc2da64556@linaro.org>
Date:   Thu, 2 Feb 2023 22:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] dt-bindings: mailbox: qcom: add compatible for the
 IPQ5332 SoC
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-5-quic_kathirav@quicinc.com>
 <3a346606-576b-ab89-78f5-5bbaca729090@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <3a346606-576b-ab89-78f5-5bbaca729090@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 17:35, Krzysztof Kozlowski wrote:
> On 02/02/2023 15:52, Kathiravan T wrote:
>> Add the mailbox compatible for the IPQ5332 SoC.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> index 943f9472ae10..8d8cd1bbe67e 100644
>> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>> @@ -18,6 +18,7 @@ properties:
>>       oneOf:
> 
> - items:
>      - enum:
>          - qcom,ipq5332-apcs-apps-global
>      - const: qcom,ipq6018-apcs-apps-global
> 
> and drop the next patch

Is it still ok even if the two devices are not fully compatible (iow, 
using different PLL types)?

-- 
With best wishes
Dmitry

