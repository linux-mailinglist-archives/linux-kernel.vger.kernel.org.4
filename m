Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06EF72BA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFLIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjFLIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:20:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB4122
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:20:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d02931d1so594829466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686558045; x=1689150045;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuaFtQBhTySWcwWuBPWolxBfBrmsW/EltaLg5KhduEM=;
        b=prYV4Vfp+twLytv23bFpM/12uJ6o15SuH+KBCBEGZup97xeepSjtAAvrTD944DaozP
         dCjjc9Ujk6QS+CQF86cl3MlHaFd5UN5kuHsSWjm4vXGlHVc98S6yQt5ZO28R8vq4WPys
         ihK3woQF+UTH2aZsmhsFj/2qo41/3UH27bQTAGAcJTy+wCNJh1SNneIfI5ouoCjXxz+p
         59gTP01LhXBhWowWJMccPaFA70F8edGy5v1/j5ztzutzZJh6+SRIOTNumpVbECOYmCeG
         v2oIk9ltHs6P5LtcA5oGycO1Qpc4+Cx2+bPqcDqSQRPvAMRG6wk+98bjnDeq7G4fJjKC
         SWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558045; x=1689150045;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuaFtQBhTySWcwWuBPWolxBfBrmsW/EltaLg5KhduEM=;
        b=PriQuAgZmwKafd0bYfbouqamtuqxdDrdL1sTeKhkGxBqkT2uj9D7qbY8mZbB93BYOR
         8qzvoo3f7amoOTN2Xp+SmiZyUPjDQwhJ9KBFwuU6a3JYcSMtgB4Cnvlmq5U/8E/QLCV1
         IxyCkuPMg67f6ufx9vLGGRrIvMGkGrQdbSbD1hqjkprTwr5BjgODA0aYT/h31PxHOvmf
         jecMRIVSsp8RYcBA5PlSXokRB0d0UOJ+s0blirgBBUf6skbouaBDmTEQii6Zs0MWJunw
         PeL1layc3XjSJCAAAdHqu5W1BR5py/ga4kkfJeHsqCGKF07OwRd2dn+oS2Hhz179qKR1
         NkHA==
X-Gm-Message-State: AC+VfDy7zG+d/glzpkyh/dybkjbKY07FVEhk5fVqpShbA6UQs0gckkXt
        pHRtOowXv9QukR/xgbzaO7MD0A==
X-Google-Smtp-Source: ACHHUZ7CqvoolRP6p9vsNBwdjEzm/1deg6tIoE5CeBdTRO5Vjig2Mx8w6tz8HJgvL11K7BItxZRBYg==
X-Received: by 2002:a17:907:985:b0:94e:e5fe:b54f with SMTP id bf5-20020a170907098500b0094ee5feb54fmr8999595ejc.23.1686558045382;
        Mon, 12 Jun 2023 01:20:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ot25-20020a170906ccd900b00965f5d778e3sm4800684ejb.120.2023.06.12.01.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:20:44 -0700 (PDT)
Message-ID: <b5201498-f61b-c431-536d-6cfdce8c731f@linaro.org>
Date:   Mon, 12 Jun 2023 10:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/5] dt-bindings: ata: dwc-ahci: add PHY clocks
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-2-sebastian.reichel@collabora.com>
 <2e6caba1-3781-156f-4e55-e261f56a10cb@linaro.org>
In-Reply-To: <2e6caba1-3781-156f-4e55-e261f56a10cb@linaro.org>
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

On 12/06/2023 10:18, Krzysztof Kozlowski wrote:
> On 08/06/2023 18:22, Sebastian Reichel wrote:
>> Add PHY transmit and receive clocks as described by the
>> DW SATA AHCI HW manual.
>>
>> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>> index c1457910520b..34c5bf65b02d 100644
>> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
>> @@ -31,11 +31,11 @@ properties:
>>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>>        clock, etc.
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 6
>>  
>>    clock-names:
>>      minItems: 1
>> -    maxItems: 4
>> +    maxItems: 6
>>      items:
>>        oneOf:
>>          - description: Application APB/AHB/AXI BIU clock
>> @@ -48,6 +48,10 @@ properties:
>>            const: pmalive
>>          - description: RxOOB detection clock
>>            const: rxoob
>> +        - description: PHY Transmit Clock
>> +          const: asic
>> +        - description: PHY Receive Clock
>> +          const: rbc
> 
> Conor's comment was not resolved. Adding entries in the middle breaks
> existing users and commit msg does not explain this.

Wait, this is oneOf, not a list. Damn context.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

