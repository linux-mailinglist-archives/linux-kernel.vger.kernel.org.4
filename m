Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0656E75CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjDSI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjDSI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:57:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3582118D6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:56:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ud9so79496849ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681894617; x=1684486617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFuzy4TuvFqYZVB9yIonpVvfyyHxImCxfwDErPMQgRg=;
        b=H/iMr/DovWLHt2YCjeW6aLfRxx2KGDYSy/hsKKdRIiNQKmpU9pgW72ZIATuskwh2gK
         GPWY+4ijiNsyeM+X4Dbf7/YsVp23JLhKLRC6kcInZXIlj+ZHf+E6rLY8R3slKcoER14e
         oolLGqzzPaJX8IkBrpJpwcP7ZQMMnl5zUgQca6wpzbKSkAPDcyqEDwds585KkzrMAQoO
         Dod9TgyryqBl6bb8iOWLH6zWlaYfhOcMN/q5of2nXEtHI1u52DMhLtJA5CSrFGAcLNy1
         A+DJhj/85CcQFOg9iz3jbKKDywW0wP/I3HBB/u9J3zdFiuzvjTcqRuuxIG1RGNMdwrUJ
         SHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894617; x=1684486617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFuzy4TuvFqYZVB9yIonpVvfyyHxImCxfwDErPMQgRg=;
        b=Wr8YbVEyS5cPe5Y/EsY4zjoEexzme8XCxsbcnywsvBXE8IT9UhVpadshH7wMJM8bBT
         BaPcIYyNq0QqO/QL5CDpnmxuS7Dkv6cbXoKS95UKlPHAena2f485bPuDTbCfklyQPsfa
         TsI3f6mkA1N/O59WFTL1osULZuWyanU8dCMk3YRbu2+UZT+uEOwERH2BLZo5yVDorn+Z
         JfhAraqk3e7o2cn35ouu0bOmjRHpa1ZV8utl7frp/38IpoRE/C+sv4ceNBJVh1O9P2hx
         iOQnJoiWkXzsnMpPeBLRdfnwMT9rW64c7rQU9fCfaWKP5g6+CKagCHBbccokDQhsSPpX
         wXNw==
X-Gm-Message-State: AAQBX9f7ZjBqkt6tegVky3TM3WUW4iBP1onZf8hxIw8cJWr0RE7zalPz
        9pDiTxF1A6HRZMG+VWQp4yxakw==
X-Google-Smtp-Source: AKy350ZHhQqP60s84sOXg5hEoFCicZMMdVpYkZ1g5erVI/+cot6zkgX/52ioHeJ+kkdg+Elklcr+nw==
X-Received: by 2002:a17:907:9805:b0:94f:3cf5:6d7f with SMTP id ji5-20020a170907980500b0094f3cf56d7fmr13114320ejc.46.1681894617176;
        Wed, 19 Apr 2023 01:56:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id be5-20020a1709070a4500b0094f282fc29asm5844742ejc.207.2023.04.19.01.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:56:56 -0700 (PDT)
Message-ID: <77d94fe0-75d2-8f64-19c6-fc19438ba71a@linaro.org>
Date:   Wed, 19 Apr 2023 10:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: display: panel: add common definition of
 ports
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230416153929.356330-1-krzysztof.kozlowski@linaro.org>
 <20230418222613.GA2408838-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418222613.GA2408838-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 00:26, Rob Herring wrote:
> On Sun, Apr 16, 2023 at 05:39:29PM +0200, Krzysztof Kozlowski wrote:
>> Few panel bindings for dual-link connections just type "ports: true",
>> which does not enforce any type.  Add common definition of ports, so the
>> type will be fixed.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/panel/panel-common.yaml     | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
>> index 5b38dc89cb21..ad62d34e6fa3 100644
>> --- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
>> @@ -70,6 +70,16 @@ properties:
>>    port:
>>      $ref: /schemas/graph.yaml#/properties/port
>>  
>> +  # For dual-link connections
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    patternProperties:
>> +      "^port@[0-9a-f]+$":
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
> 
> This allows any undocumented property.

Yes, which I hope the device schema (using this panel-common) will
narrow with additionalProperties: false.

I can make it explicit: additionalProperties: true.

Otherwise, how do I allow custom properties like:
Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml

> 
>> +
>> +    required:
>> +      - port@0
>> +
> 
> I don't think this should be added here because users must define what 
> each port is. With it here, we're going to validate the nodes twice as 
> well. Same can be said for 'port' though. It can't be extended though.

So you propose to drop entire "ports" here and expect every panel schema
to define it instead?

Best regards,
Krzysztof

