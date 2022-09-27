Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21DA5EC509
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiI0Ny4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiI0Nyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:54:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C541D20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:54:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a2so15819495lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y7eWZ9SMX+EFPIirIXesPJAAeZkrfswB+4GkN1RJhPk=;
        b=n6tWZz5VI7Pp2Uu/mWB6mY2Hmq9R+OEFGzYZLL8g6VRzhMi8Si/lddGc6qn5PfUFC8
         LcXriFA52bMkEZla1z2A4T+Z8GmSJqavnjlxQOIZqBjKe5mYDKJPx6VsaU0Bm2IVCabi
         j1BahHdJB68ZQCzXRy9r9cPEk352miCC8Qg9az8OYjfLgOLxUKBb2KO0+sdeUO/0brrz
         yhc/O1ojI/Z47Ty8C1v64n94RfrufbpdLXn0HlLO17pWxewUnD+XUMLqvj0l9aeTZpXM
         HD62Qs3ggexgJ07C7fSZmgZWsENC1i+zmJUvtQd4xlyiAagpYhcT77yEutAYlSj98CNL
         ULjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y7eWZ9SMX+EFPIirIXesPJAAeZkrfswB+4GkN1RJhPk=;
        b=ABP1l8ET+CCUdYxK6moozOaJUNRPEiK/OZf2GVSDFic2FNp1LJ2VaWXe4deHL3A3rX
         XNJvbi2oohbIpBB3J7DDNjz+SfSeG9zaieIrvmgMmNo+Hw5G2/2Ziya8ceexGw2aDSB4
         tMxqE2C8ztH761MDmUrOpYJk4pmPuIzCRzFOb+p0Ss/wQg7O4XLnqQBibvVOEFkgHIiT
         58BfkM8E2Whzh4rfPCDKPeAPddnrAbV0IQy3MDClOMMljlJuQ9crMLICFZCWeGPHtxGO
         z9qjb4+6zI1m0pBY+E29wNiw3NCW71wnIGapwstjUR3YkCtR8rQO5G6MNBb/IzbEfDzJ
         M9RQ==
X-Gm-Message-State: ACrzQf05dQQjchunGFVBd0C4qTZrPCTWdnUfWQHl98s8Kxs+chtwgMEI
        FnUZRLPIwS+kSmGcr/ExytIntg==
X-Google-Smtp-Source: AMsMyM7RVdxF0oAtsZ2jK1fXCW+7kyhsovqXnP8hVaTceEAnHfBBNXoO/Z6cZWpWPH5Ndc4q5eb3kQ==
X-Received: by 2002:ac2:5dd0:0:b0:49f:bbc5:a77a with SMTP id x16-20020ac25dd0000000b0049fbbc5a77amr10661528lfq.179.1664286888990;
        Tue, 27 Sep 2022 06:54:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512348900b0049465afdd38sm171569lfr.108.2022.09.27.06.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:54:48 -0700 (PDT)
Message-ID: <4d2c1aa9-dfc4-dc5f-cb13-50ed940939fa@linaro.org>
Date:   Tue, 27 Sep 2022 15:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 11/15] dt-bindings: pinctrl: qcom,sm8250: add
 gpio-reserved-ranges and gpio-line-names
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-12-krzysztof.kozlowski@linaro.org>
 <149af8eb-cfa9-c2f1-1aa6-6057df3aa03d@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <149af8eb-cfa9-c2f1-1aa6-6057df3aa03d@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 14:41, Konrad Dybcio wrote:
> 
> 
> On 25.09.2022 13:06, Krzysztof Kozlowski wrote:
>> Document common GPIO properties (gpio-reserved-ranges and
>> gpio-line-names), already used on qrb5165-rb5 board.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml   | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
>> index c44d02d28bc9..d7d8e5d3b659 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
>> @@ -49,6 +49,13 @@ properties:
>>    gpio-ranges:
>>      maxItems: 1
>>  
>> +  gpio-reserved-ranges:
>> +    minItems: 1
> Not sure about this.. However, this will apply to 99.9% of boards, so:

We need some minimum number.

Best regards,
Krzysztof

