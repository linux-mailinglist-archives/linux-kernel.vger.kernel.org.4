Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B76748A09
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjGERUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGERUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:20:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393FEAF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:20:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98934f000a5so808537566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688577607; x=1691169607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfEHsbcVLsYY2/6MdyIJQreizHbf5yUJFDf6o8SZPns=;
        b=yUPwuMYoTrAIbvL+x7Qmdp6zHDBqj6BWcwUx5FEQzS5Em4Dk94RrpW1R1DrmbqL1pT
         xSE7wxjloL3ZEtiipOTNGChx/VY8nHNwXyogmiV6ZCTFnHI3F2llT8KDzgrXEYvG6M06
         /MxP7DB0eGdiK3T0prn60kdZ30MwP/id0PtHHGtWKOENJUYdGfiZOt5lIPw/iFsLH1p3
         ysV8bmJIju6UzD71SxEy20wol/P8LIgliKjUlSBEnTno6FpMFZ+/8ienitSI7cJ5qqtJ
         m/D9SlwGs1U6TSFZpUiB6Vp7zHnoZpeN8qRhw4eTu47PiLOxKDqt3gZ9ghkWpIWFJ8Od
         CE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577607; x=1691169607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfEHsbcVLsYY2/6MdyIJQreizHbf5yUJFDf6o8SZPns=;
        b=cHfljBptfbZX1K5FpuE3zyMckSfEDWwJQQW3Ts/uCxI7ypZJ9wjxGEX1/Y/em7K3fa
         thYIIGm9xN2eB71DcBU1kec0+BINhf0keYeIgdqBcgUHQDpAQg+huVnbEi/FxMSMZAS3
         /zuxegLqGYbaaTS267h4tEv5M0tuImM5S6/AYEsKPcTwtu3QRixMsp/+r8gnBpLmE/cE
         GXN3s7H4uvSnc16DR0UlyAv3jcXFlSp/eGrQTzpPMPGFpA33KAKdk7M0LXuDbAi8D4fm
         k3yekgrTCyaB6dA3Rzv09Ma5JCWDrChEHpdCvco/vq5vzsOvyqBVvwSrE8/Ek+t8zylS
         YQqA==
X-Gm-Message-State: AC+VfDw3bmpBQPzQGcTQKnI4ZAV5BKhMnOI2ZpBHy0+HiJEmyMi5vBjh
        UrJbF0v+0B1/sn8pRHqQZWg+PQ==
X-Google-Smtp-Source: APBJJlGYjDazpHom/rxOe0Tt8KgqL1usdNH/RfAzUqq56N/uG0cGBM5j2B7OjBSjkYX0+X2DCREjsw==
X-Received: by 2002:a17:906:b7c8:b0:992:bd2b:d0b8 with SMTP id fy8-20020a170906b7c800b00992bd2bd0b8mr10059261ejb.29.1688577607701;
        Wed, 05 Jul 2023 10:20:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id xa10-20020a170907b9ca00b00977c7566ccbsm14915729ejc.164.2023.07.05.10.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 10:20:07 -0700 (PDT)
Message-ID: <295e4cb9-0fa1-8370-72da-ade8123c90a5@linaro.org>
Date:   Wed, 5 Jul 2023 19:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 1/1] regulator: Add awinic,aw3750x.yaml
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     like@awinic.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, yijiangtao@awinic.com
References: <20230705081942.2608531-1-like@awinic.com>
 <20230705081942.2608531-2-like@awinic.com>
 <2923201f-8bf4-a55d-a033-28ae5e569466@linaro.org>
 <17ad855b-3a3b-4dba-9a64-a1a683b3b905@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <17ad855b-3a3b-4dba-9a64-a1a683b3b905@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 13:52, Mark Brown wrote:
> On Wed, Jul 05, 2023 at 11:20:16AM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2023 10:19, like@awinic.com wrote:
>>> From: Ke Li <like@awinic.com>
> 
>>> +properties:
>>> +  compatible:
>>> +    const: awinic,aw3750x_led
> 
>> I don't understand why there is _led suffix. Isn't this regulator? Can
>> it be anything else?
> 
> Boost regulators are almost always used to drive LEDs for things like
> backlights.

Let me be a bit more precise - if this device can have multiple
functions, then the compatible usually has some suffixes (although no
underscores). If this device has only one feature - regardless whether
for backlight or for anything else - the compatible has only model.

Best regards,
Krzysztof

