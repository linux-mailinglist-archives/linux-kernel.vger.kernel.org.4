Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3F6DA0DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbjDFTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbjDFTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:17:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF592C1;
        Thu,  6 Apr 2023 12:17:06 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 91B6266030CC;
        Thu,  6 Apr 2023 20:17:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680808625;
        bh=gouod4mYM1AnwWvdTpbJkhJVWs1tDukhi1Xia9f76Pk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VwPMw+qwKDOGEsjf/PsyDnKzHAzygoGRbOB7WByKxmQoMoxZVpE/WG6hjay4AI3zH
         2JIGs9tKVpAZgcuCHHlBb/2j9xtROdi4nD5lBjUibjxvqdUyaJiOKinpOIt4YnxWPG
         Ljhc+sKh4RMLiTsEaA84pp+2AFkvlvEtYDE0vtgujwOrwxEhbh7OgaWfkcBx4iGhm7
         h9ZRkvaT16m13xw0y27klspkjnJpd+vP70OyDKNe1AJyQDT/hbW3Tt8Z1XyV/HAvu/
         /7P7NCkNzRUvvleYKhwpuonJBQ3D3yJbPRQqu2485rUY4BreILhPamPxOq/lAecSjo
         Ym1RGSxSEt9uQ==
Message-ID: <0f64c6b9-3289-a911-5c30-ea0ab0505eab@collabora.com>
Date:   Thu, 6 Apr 2023 22:17:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/8] regulator: dt-bindings: fcs,fan53555: Add support
 for RK860X
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
 <20230406171806.948290-2-cristian.ciocaltea@collabora.com>
 <04d7dd35-6648-7ebb-4674-54c132294628@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <04d7dd35-6648-7ebb-4674-54c132294628@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 21:14, Krzysztof Kozlowski wrote:
> On 06/04/2023 19:17, Cristian Ciocaltea wrote:
>> Add compatibles to support Rockchip RK860X regulators.
>>
>> RK8600/RK8601 are pretty similar to the FAN53555 regulators, while
>> RK8602/RK8603 are a bit different, having a wider voltage selection
>> range.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../bindings/regulator/fcs,fan53555.yaml      | 22 ++++++++++++++-----
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
>> index c0dbba843f70..7547c130ff7d 100644
>> --- a/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
>> @@ -14,12 +14,22 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - fcs,fan53555
>> -      - fcs,fan53526
>> -      - silergy,syr827
>> -      - silergy,syr828
>> -      - tcs,tcs4525
>> +    oneOf:
>> +      - items:
> 
> Drop items here. It's just an enum.

Indeed, sorry, will prepare v3.

Thanks for reviewing,
Cristian
