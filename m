Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19996F6D8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjEDOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjEDOPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:15:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004EF83FC;
        Thu,  4 May 2023 07:15:00 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A01CC66056DB;
        Thu,  4 May 2023 15:14:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683209699;
        bh=y4FvvvnzdeNkci3XHhof6BvR49moH0azvrIsG0BQSCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LHsGk9z+LHxHKeZg/XLV6IG62c1f808AthAGn5ZNZ31bhRXcptxe4ZmfIddqtDNNE
         756X+D82mKbzroAoAnLKrHHBrI3S3mLXxauBpp3DATIRccxFXjgiIakEBegFrjcfM+
         tu+yO1/YZD6MqNKjkCCUSdu+6JBijBv9ZsYxtZcEchQCkuGYTGK3CBMtz1/1eZG4Lh
         b1wHI1DhUy+I1tVhQD3Jjryo8BYwWCuHh0/bofmwc0nDaWpw1SKIH7q1foSmR5U6z5
         UKc2SPP/jyUlFyWa6U6yhQ4pHq0TdV/GwtNMYtEh8+FSP7vNIx37Iw9wuGKw4Ccupr
         Zg209zS/q2RHQ==
Message-ID: <a5d4a5be-b658-d9fe-59b8-69199329446d@collabora.com>
Date:   Thu, 4 May 2023 17:14:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: rockchip-otp: Add compatible for
 RK3588
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
 <0678c24c-33ae-7e99-7bb6-d15dc5a7ed76@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <0678c24c-33ae-7e99-7bb6-d15dc5a7ed76@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 09:28, Krzysztof Kozlowski wrote:
> On 01/05/2023 10:43, Cristian Ciocaltea wrote:
>> Document the OTP memory found on Rockchip RK3588 SoC.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../bindings/nvmem/rockchip-otp.yaml          | 71 ++++++++++++++++---
>>  1 file changed, 60 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
>> index 658ceed14ee2..84a11382c6e7 100644
>> --- a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
>> @@ -9,34 +9,31 @@ title: Rockchip internal OTP (One Time Programmable) memory
>>  maintainers:
>>    - Heiko Stuebner <heiko@sntech.de>
>>  
>> -allOf:
>> -  - $ref: nvmem.yaml#
>> -
>>  properties:
>>    compatible:
>>      enum:
>>        - rockchip,px30-otp
>>        - rockchip,rk3308-otp
>> +      - rockchip,rk3588-otp
>>  
>>    reg:
>>      maxItems: 1
>>  
>>    clocks:
>>      minItems: 3
>> -    maxItems: 3
>> +    maxItems: 4
>>  
>>    clock-names:
>> -    items:
>> -      - const: otp
>> -      - const: apb_pclk
>> -      - const: phy
>> +    minItems: 3
>> +    maxItems: 4
>>  
>>    resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>  
>>    reset-names:
>> -    items:
>> -      - const: phy
>> +    minItems: 1
>> +    maxItems: 3
>>  
>>  required:
>>    - compatible
>> @@ -46,6 +43,58 @@ required:
>>    - resets
>>    - reset-names
>>  
>> +allOf:
>> +  - $ref: nvmem.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - rockchip,px30-otp
>> +              - rockchip,rk3308-otp
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
>> +          maxItems: 3
>> +        clock-names:
>> +          items:
>> +            - const: otp
>> +            - const: apb_pclk
>> +            - const: phy
>> +        resets:
>> +          maxItems: 1
>> +        reset-names:
>> +          items:
>> +            - const: phy
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - rockchip,rk3588-otp
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 4
>> +          maxItems: 4
>> +        clock-names:
>> +          items:
>> +            - const: otpc
>> +            - const: apb
>> +            - const: arb
>> +            - const: phy
> 
> Keep the same order of clocks as in older variants, so you can keep the
> list in top-level place and here only minItems: 4.
> 
>> +        resets:
>> +          minItems: 1
>> +          maxItems: 3
>> +        reset-names:
>> +          items:
>> +            - const: otpc
> 
> Shouldn't this be phy?

It seems there is no reset for PHY, or at least I couldn't find any
reference in the RK3588 TRM, nor in the downstream driver implementation.

Thanks for reviewing! I will prepare v2 with all the requested changes.

Kind regards,
Cristian
