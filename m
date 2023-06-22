Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA21739420
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFVAv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFVAv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:51:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51342198
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:51:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8775126d3so4629629e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687395112; x=1689987112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpH450RlcCBag58hjq7lxrqN2fInkuZLNQWzOYqCTD4=;
        b=hcMVMZxr3AZmAsjOEMtaDKs1BAyffyed833lUzAWODc+ovtjuJnYZLxkY+42oIEZAk
         g7m5ght45cAE4HpsEarBfPkPQbTJA9Y7bzRNolCz6i7SggEG8MbRygrwARgUjIziYFxN
         BILDyzX2sAoY7G+BYa5TDmWs1iQsT0QXuUWg3lSCkT/2VIDvyX7ONLGCsPyqVA2NuhK4
         QN/mz+GDeeu/aNQyIoyx9VsWTl/RYGVmXQd/5SQaqS3aZ2mmNtEyLsty/VQ63xd5tkrj
         X9o0ixOlKvzjsLJ3XR2lZPoGCJjt4msI6+T82At5mC++svcB7bgLFDrTLKDSufzRizzM
         YuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687395112; x=1689987112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpH450RlcCBag58hjq7lxrqN2fInkuZLNQWzOYqCTD4=;
        b=MdaZdmYMaXlwIp04gCOF7Gv0LKcedpVpiRw/Lz/ywHYwM0kfyHLFxLY0oAFQeEqf5o
         yAUoBC6KTkYEUvKPjwTNejrJ0cdiaS2oZXkRYUNqbgOz8UEKRBfd+smoZSKugmgIWDnS
         GAfYJ7OtnIxbRUxZdQqXeFg+zygIBjQq7bjOYOPn5Cn4tS1eBpG8FwVHA3076pasvQ/v
         lr0NCWFgn8KDDEeaJP8dCbOXfIHyXYOW5XzcmaEG39Ro2aXjy+lVotPZ+vE5f8pLLNGh
         iF2sRH3rnfOXjCvQ6Q/bbbHe3HG7+ORnw9+zmhhd75OIqBJIgK0uKED2JsCKcUbXDwmY
         dmjQ==
X-Gm-Message-State: AC+VfDxc/To09hiXfP1v3bwIM1AkH58kD6BUKzBMhT0Tdm+I7/sVLqiG
        4WSpnvh5tpuxJAKYuqNlzwmgig==
X-Google-Smtp-Source: ACHHUZ65QyPqBn4GlqwjOoSz+PSJNfvplML9UAIrdeTW08mFQ/X0fteOjnBCdjYy51tpPWPIo4EPKQ==
X-Received: by 2002:a05:6512:3f0c:b0:4f9:58ed:7bba with SMTP id y12-20020a0565123f0c00b004f958ed7bbamr2736659lfa.16.1687395112337;
        Wed, 21 Jun 2023 17:51:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id a9-20020a19f809000000b004f3a71a9e72sm928156lff.102.2023.06.21.17.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 17:51:51 -0700 (PDT)
Message-ID: <dc5ffed0-555b-18e5-cf96-d6a4263357af@linaro.org>
Date:   Thu, 22 Jun 2023 02:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
 <20230621-topic-mm8013-v1-2-4407c6260053@linaro.org>
 <da300402-d417-5646-d4c9-7c100c351db1@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: Document Mitsumi MM8013
 fuel gauge
In-Reply-To: <da300402-d417-5646-d4c9-7c100c351db1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2023 18:38, Krzysztof Kozlowski wrote:
> On 21/06/2023 17:39, Konrad Dybcio wrote:
>> The Mitsumie MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
> 
> Mitsumi
> 
>> datasheet is available at [1]. Add bindings for this chip.
>>
>> [1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/power/supply/mitsumi,mm8013.yaml      | 35 ++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
>> new file mode 100644
>> index 000000000000..080fd44083ac
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/mitsumi,mm8013.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mitsumi MM8013 fuel gauge
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konradybcio@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: mitsumi,mm8013
>> +
>> +  reg:
>> +    maxItems: 1
> 
> 
> I think you miss several properties: three power supplies (although not
> all might be needed) and most likely monitored-battery. One regulator
> output and output GPIO probably can be skipped.
Looking at the example circuit, it seems like the chip's power lines are
hardwired to the battery cell.

monitored-battery does not seem useful today, as we don't have any
information about writing values onto the chip :/ And I'm not willing
to experiment with that! :P

Konrad
> 
> Best regards,
> Krzysztof
> 
