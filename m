Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0166B18A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjAOOcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjAOOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:31:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF62865A0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:31:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u9so62616930ejo.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ka7RsGQ4vY+og58IhboXaj+SShDOCjiWCr/xxnDLPMk=;
        b=bVppNKG2N5/nBD4Oj/iy4LGZE8V9y9i2K6RWx7k+vphMDkcXflrAeHP6/ig5syiAaw
         PeE1M6XZIfFyulr7NEfQGB5V8p1j2clsUae/m+k2lZ27I/qW8jB04m62MMZu1+fGzs4m
         daoR9ZnEMDSPHzko2DM3VU/VTpQQWjCck90eNclhf86QJjgOgQXkCmTU+GEaoj6KJR0y
         YnCJM/52pGwqCfRZ4ib2b3NQPsA/cjwzG9SCAZDPT4VvqOfICQJKXvDneZscfkzXzVLv
         sjTtrAjxK65mtdcrQuCrzsYgQw/ItBGGulk8En/gb1xex+Xng4kNFXNr7+hbpMb0bcqJ
         WfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka7RsGQ4vY+og58IhboXaj+SShDOCjiWCr/xxnDLPMk=;
        b=pZsrNb4z8egEjGIiH1N8BlyiU2Pmqj+ggafLGAYqZntnddPChhtkl2zmadwafwNPkY
         37WqXFxP0Olav7Dl3fJeS98TWPUPgh2GPIvw8Sj2mSET9lcJ49W0E6vMWiWfPvcSlG9V
         xeHlW3cd7fsjmNH3w8lkfp0XlgisBvdVUDPeJt3UVVuLqQEyI6U10dzsRu1HkMA6SZ0I
         DAUTfei9MAmraP4Uj4HEgVQJZViOrXrPExmz4BTUTkyqCLzEk4mwYy2PpkeaajsRhwT9
         FVaG1C0Vt98Mv4kBiI4Ur5x0hvjtOE5YKHeUIqQZ06QrL25lWMdhwWs2GjPtyeTlxPvu
         5npA==
X-Gm-Message-State: AFqh2kp8ZVvD1/Q6xLsTvJxMCWPnYEt0hLkx/vIC+3LBKUPV2NsLIzc1
        9o6ROPPhJG6wpMFwX3UlSwrk0w==
X-Google-Smtp-Source: AMrXdXtcYn7Ys87GJP7CGaLmrovhaHQrVYKw4ENs4h80qYIv73jg2OMm+fHdPu2HqrC1CdKIEdORSw==
X-Received: by 2002:a17:907:2c61:b0:86e:fccc:bc19 with SMTP id ib1-20020a1709072c6100b0086efcccbc19mr3597731ejc.43.1673793115401;
        Sun, 15 Jan 2023 06:31:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0084c723a626csm10654904ejh.209.2023.01.15.06.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:31:54 -0800 (PST)
Message-ID: <91737ee5-f751-9f5e-34fd-0eeae29d7077@linaro.org>
Date:   Sun, 15 Jan 2023 15:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        jonas.gorski@gmail.com, kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-3-william.zhang@broadcom.com>
 <b529a53b-d00c-063d-a58d-e64b0300605d@linaro.org>
 <5dfac2d7-3b4b-9ded-0dde-26b289c604d0@broadcom.com>
 <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
 <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
 <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
 <32a464f8-6a4b-6777-9775-f17e990e0c6a@gmail.com>
 <71c2e796-f0fb-90cd-4599-13c9718f41d5@linaro.org>
 <31644849-dc69-ddfc-a6b6-6ffd37d64d2b@broadcom.com>
 <f0a50234-bc8c-09c4-e2c1-22cbeaba5c15@linaro.org>
 <e99a71b2-0b05-1a53-1c29-3778b49a3b86@broadcom.com>
 <0cc43891-405e-418f-01ee-845d680b3a24@linaro.org>
 <14a48b44-962e-1839-4fbb-1739ba8dbc35@broadcom.com>
 <f4356898-de35-9728-5395-baecb07c843f@linaro.org>
 <3c3955da-6b9f-c994-e345-03bcffa91473@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3c3955da-6b9f-c994-e345-03bcffa91473@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2023 04:17, William Zhang wrote:
>>> I
>>> know there are usage like that but when we have clear knowledge of the
>>> IP block with rev info, I think it is much better to have a precise SoC
>>
>> No, it's not particularly better and you were questioning it just before...
>>
> Better than using the very old specific chip model number to bind all 
> other new chips while I have a chance to update the doc now. 

It will be used to bind them anyway, it's already an ABI.


> I guess we 
> have to agree to disagree. Enough discussion and I will send out v2 next 
> week.  Thanks for the review.
> 
>>> model number and a general revision info in the compatible. As you know
>>> they are many usage of IP rev info in the compatible too.
>>> brcm,bcm6328-hsspi will stay so it does not break any existing dts
>>> reference to that.
>>
>> Anyway your ship sailed - you already have bindings using SoC  versions...

As I said here...

Best regards,
Krzysztof

