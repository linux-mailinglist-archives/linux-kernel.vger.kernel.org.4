Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5E733FBF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjFQIsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjFQIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:48:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3D1FE2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:48:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-987341238aeso101575266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686991725; x=1689583725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9v9IMhMYANhGUwezLEP1LlL4XT7NdaZ2AILcbGscvfs=;
        b=f7b42c9PMsOBSkpJ9BbkAwiJsfDUkyVlZ+S2LGTmtnk6tvWWjubyHvGU8ecZu3PFT1
         ApXo/v+Fl6S3V+ooOvBsn256Cv49dnEKkb072m4AuIavr8BWkheII2u6lx0s3ccSFAma
         zM5k3myH9oM9k2luWy//WuZQZZ+ai5bpgGC6GYyVwqIXPX8Ypsz6WkCufOVTeFtbq3UI
         HHLwW8EAk7R/hkqnNgtXIz+vLMqVyTVy9KfjexhVtTG5bDAwh5D1be3NqMRRfFS6JMgJ
         Ffx5Hyb6uVS4Mzojv2NrMbt83IzXNmdbgXErrtsI7Gd2E3cmaux63uScJlPRY0tLcYVj
         jUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686991725; x=1689583725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v9IMhMYANhGUwezLEP1LlL4XT7NdaZ2AILcbGscvfs=;
        b=AdNNZCuCyRiBqOf7uw6YQXquW6DZf6VTASnTS4o7JI9jCMyBiP09pskAikCNF66j59
         2uzpuEpst4arueDWcpT57s0uXQXOTNIjSrTDL4DOmrcyOCb1hJOBlWoMBPMHOpgKD3om
         XhdFSuAs7OUuDVvujYOSVZCnTXPLf5xgTEfSd5anyE7KNRik5YoBUpnAdbW6mXJXn4C2
         H8QHEtg3VikgA5NEKpuAQYvyiItcFRhNxfeAngiot5SOBlOUjnXXwnKI4c0BWkNuqiS1
         G6Iw98nPvEhvh8RzFkUTJFw9i3kdvUkiNoZkz/8XUBuHfQCELMc01R0hKHirCwFm9V/H
         lQxw==
X-Gm-Message-State: AC+VfDy6QBhdqgdk9Tz9xTQkKxxcH8LDfMv1xszBaWb3LzsdZlmK+L1d
        SgaEJXvyhV+5iMu53hIxR7vJ2A==
X-Google-Smtp-Source: ACHHUZ7Kpo4IrOBQWBZ6pUx87P+qfVIKZIR9we2zLQmk/Rued5SQQmn3eIdab16cMTZ1bsaToXLkLw==
X-Received: by 2002:a17:906:da87:b0:982:870f:9e8f with SMTP id xh7-20020a170906da8700b00982870f9e8fmr3843576ejb.62.1686991725276;
        Sat, 17 Jun 2023 01:48:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906341500b00985bdb7dd5fsm1965918ejb.201.2023.06.17.01.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:48:44 -0700 (PDT)
Message-ID: <aca54f67-cc09-ff4f-93ca-6973d153db2c@linaro.org>
Date:   Sat, 17 Jun 2023 10:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com>
 <98960024-7dbc-91a3-75de-90b529637916@linaro.org>
 <20230615052746.GB22186@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615052746.GB22186@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 07:27, Varadarajan Narayanan wrote:
>>> +          - enum:
>>> +              - qcom,m31-usb-hsphy
>>
>> I am confused what's this. If m31 is coming from some IP block provider,
>> then you are using wrong vendor prefix.
>> https://www.m31tech.com/download_file/M31_USB.pdf
>>
>>
>>> +              - qcom,ipq5332-m31-usb-hsphy
>>
>> This confuses me even more. IPQ m31?
> 
> Will change this to m31,usb-hsphy and m31,ipq5332-usb-hsphy respectively.
> Will that be acceptable?

m31,ipq5332 seems wrong, as m31 did not create ipq5332. Does the m31
device have some name/version/model? If it is not really known, then I
would just propose to go with qcom,ipq5332-usb-hsphy.

Skip generic compatible ("usb-hsphy") entirely.

And then we have... existing bindings qcom,usb-hs-phy.yaml. Don't create
something similar with difference in the hyphen. Just use device
specific compatible thus device specific filename.

> 
>>> +
>>> +  reg:
>>> +    description:
>>> +      Offset and length of the M31 PHY register set
>>
>> Drop description, obvious.
> 
> Ok.
> 
>>> +    maxItems: 2
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: m31usb_phy_base
>>> +      - const: qscratch_base
>>
>> Drop "_base" from both.
> 
> Ok. Will drop qscratch_base. This is in the controller space.
> Should not come here.

Then drop reg-names entirely.

> 
>>> +
>>> +  phy_type:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - utmi
>>> +              - ulpi
>>
>> This does not belong to phy, but to USB node.
> 
> This is used by the driver to set a bit during phy init. Hence
> have it as a replication of the USB node's entry. If this is not
> permissible, is there some way to get this from the USB node,
> or any other alternative mechanism?

Shouldn't USB controller choose what type of PHY type it wants?

> 
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
>>> +    hs_m31phy_0: hs_m31phy@5b00 {
>>
>> Node names should be generic. See also explanation and list of examples
>> in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> Also, no underscores in node names.
> 
> Will change this as usbphy0:hs_m31phy@7b000

This does not solve my comments. I did not write "label" but "node name".

Best regards,
Krzysztof

