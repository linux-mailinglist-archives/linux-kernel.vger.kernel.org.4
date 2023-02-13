Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3181695348
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBMVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBMVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:41:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F39027
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:41:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id dz21so2796388edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXb2wBOT0LurWdGsoyTt17ekBKNUZrsqRtveFQNt4nQ=;
        b=z1v7IJ/L49vgAuqUVJCPTCh16RYIOgtH3JfOPSjlP7iw0RmPuutgOY/F6FqTkuEEG5
         Q9z0i7bJk3fbSz/QN+5noH1x8n9yQyRip8muvcDr810PHPV7+4+KjBinZZ38nD6piQ9K
         1utxwIiBdPSJrS7wFbD+h/+N3QvZbjP62ixkdYcFKEOnyEGMl95tpBUa3RKRa7KIpKB7
         12Dg4jEBDJLHvX8aIqFO5n4VQDZzuTbbxCXUIhX91hrm0LBRUMM7kQ06ddjkwKwJXhry
         sH9s68W1MKnA/6bIeBJ8U/Hne71xCtKVrvVvFszbeNXWG70UGgYznCOA2mNyWNu9ja4R
         nDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXb2wBOT0LurWdGsoyTt17ekBKNUZrsqRtveFQNt4nQ=;
        b=jtb8Wpb2dYfysJiPnNAILFuJjZ0IfMm9qgt/pGwIBA3lB77lCjhv8QqVX2r5w8MVcF
         rsK5WRYMlF2Q6OyHH/fXvaZSlvkMDYwE2n8eGWz20jW+FW1xk61oC7vhEt+O9dZU9uDs
         067XLJ4mTtdxXhpu3rC+XK+lU2P+Iwh7nqDD83qT48Qs5+l2UdnSDPkA0MVkdXTpDMdS
         t902HzAfYkSfdCdCythC2deF0RDRZCpuAVzZNze4/1Wa3JFxrUvC/eGKkaxFz7FuRNmf
         M4eyJg6qxEKDScqyaNM9noAIfOzV3OGjVrbngVM3CmWGF0m+Z9Ov/H3FtkXzna7T17P+
         Bjpg==
X-Gm-Message-State: AO0yUKXTKvVLhHBgW7rz9IIvUdfoCa47o4nG2NcIjJPsLIw+eX4p0oVZ
        +YpilyoVYBliAKP+VfKCzpDJsg==
X-Google-Smtp-Source: AK7set9aQzXbOVQSMzQenYRV6W4FxrtJ/vxZGkwXVcVSbKAUnD68l0E6Z8ccUd7qwBPKUVhGbIhExg==
X-Received: by 2002:a50:d617:0:b0:4ac:c29d:5c4a with SMTP id x23-20020a50d617000000b004acc29d5c4amr137942edi.29.1676324472163;
        Mon, 13 Feb 2023 13:41:12 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b004aad8d2158dsm7157131eda.66.2023.02.13.13.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 13:41:11 -0800 (PST)
Message-ID: <83637cc7-21ae-7778-37b3-4522cc0a06c9@linaro.org>
Date:   Mon, 13 Feb 2023 22:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: pm8941-coincell: Don't
 require charging properties
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
 <20230213204950.2100538-2-konrad.dybcio@linaro.org>
 <20230213212733.rhvuzrshfrvzgo4a@mercury.elektranox.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230213212733.rhvuzrshfrvzgo4a@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.02.2023 22:27, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Feb 13, 2023 at 09:49:49PM +0100, Konrad Dybcio wrote:
>> It's fine for these properties to be absent, as the driver doesn't fail
>> without them and functions with settings inherited from the reset/previous
>> stage bootloader state.
>>
>> Fixes: 6c463222a21d ("dt-bindings: power: supply: pm8941-coincell: Convert to DT schema format")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
> Please update the description of these properties to describe the
> default behaviour.
Not sure if there's any default behavior other than "go with
whatever was there previously, no matter how it got there".

Is it okay if I just add:

"If unspecified, inherit the bootloader configuration"

?

Konrad
> 
> -- Sebastian
> 
>>  .../devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml  | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
>> index b7b58aed3f3c..d62e3af55560 100644
>> --- a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
>> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
>> @@ -43,8 +43,6 @@ properties:
>>  required:
>>    - compatible
>>    - reg
>> -  - qcom,rset-ohms
>> -  - qcom,vset-millivolts
>>  
>>  additionalProperties: false
>>  
>> -- 
>> 2.39.1
>>
