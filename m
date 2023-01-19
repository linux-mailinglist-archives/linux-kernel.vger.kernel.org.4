Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09846732DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjASHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjASHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:45:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D766EC2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:43:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso583521wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0CROLqyxrtD2VIy8QlyK5dNlwxAQqg2okbLFCKA2k0=;
        b=wJX5apVLdkyWFq+iKhD3fOtOOLGX8erlpfKyHbSerA2IfwED9ST6RKS+cxc51TV8mB
         dPH0qZFAIcb9e4pm50th7d+Jx3bfcGWC4Mkc0XBQnIyzTfRh1YFwEfFDvtTnUXyavstF
         sDNYwhxs1Zt898m5/BptimQN21HiKd1dXbUQ51hpZAP0JMwB0ShDuBvIB1TFYgfDyo19
         Nn29S2/zWKQX0gm9vYQieRHlOuLvu20Vocfd58uA6hibgXpC26F0ddIJS5U23Hh5a6ee
         m+STm7kJCC4YinpSkSzalyU9QRDUGni7aTZ7hGpjLeXi0kIsMOfQJVBrwEJpoYAZXRbY
         Gfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0CROLqyxrtD2VIy8QlyK5dNlwxAQqg2okbLFCKA2k0=;
        b=s/N5XApGcf6bxiEQxPmOZ2e4egrPEYJHTSqlz0R9eAhh7uOLAGht2aJR2EvQl2E+8q
         Z6nV/dulc6FpZkioVavb4oWtS/hnFJRAXbxDcsWt0r16mgBHda5Q/UoPgxLW9OcLcE2m
         wrvDKcWar9Pox5D1yMHzWifQN0lko5jj8rQaKokv71H5phGOkGJGl8wHdPHkem1uZ/BT
         gLg0pWDiiLMXL5FcuSo6DjIwK/AAJUWrx1vGmeu3oOZvRDmg0C/JVbdWxLqUNgBdrQwV
         COCbroRY5P6fMdWTv9F8YYVQdkdTllxq5TYORZnyd+GSLmFo2B87KY8AKGwn+e0s2k8v
         ZWVQ==
X-Gm-Message-State: AFqh2kqnoDqZJ+M0fxPRGu86SV0GLdeVtzggzf/Bb+x4kud5As0kQTzZ
        ehTpjsR2OY2/E0SLD3Yv0L3Qyw==
X-Google-Smtp-Source: AMrXdXsf6UgwAMMHYZKd3YnMVuWZ0OmtPNqyKE/YX4WoBTwnAK/rPMX2cWyGCRutQI/6fxngEm6uCw==
X-Received: by 2002:a05:600c:a11:b0:3db:f1f:bc31 with SMTP id z17-20020a05600c0a1100b003db0f1fbc31mr5364883wmp.16.1674114207940;
        Wed, 18 Jan 2023 23:43:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm33264308wrp.55.2023.01.18.23.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:43:27 -0800 (PST)
Message-ID: <04a37865-516c-45a8-8099-7d3a284fdf98@linaro.org>
Date:   Thu, 19 Jan 2023 08:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: ti: Add binding for Siemens IOT2050
 M.2 variant
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
 <3f825ff8853b1ffd8228d3283c7da0483ddf55d5.1674059300.git.jan.kiszka@siemens.com>
 <a219dcf6-412b-a9f8-cf06-1896df0709de@ti.com>
 <dc6fc5be-0b53-00fc-3664-4dfd11b1fea9@siemens.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc6fc5be-0b53-00fc-3664-4dfd11b1fea9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 07:34, Jan Kiszka wrote:
> On 18.01.23 18:43, Raghavendra, Vignesh wrote:
>> Hi Jan,
>>
>> On 1/18/2023 9:58 PM, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This new variant is derived from the Advanced PG2 board, replacing the
>>> MiniPCI slot with B and E-keyed M.2 slots.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> index 203faab80142..7af813202f1f 100644
>>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> @@ -43,6 +43,7 @@ properties:
>>>            - enum:
>>>                - siemens,iot2050-advanced
>>>                - siemens,iot2050-advanced-pg2
>>> +              - siemens,iot2050-advanced-m2
>>
>> Could you re arrange alphabetically?
> 
> Time of release ordering, but I can reorder as well.

The entries look ordered alphabetically, not by time of release. BTW, I
assume time of release != time of adding to Linux, which would be just
dropping stuff to the end...

Best regards,
Krzysztof

