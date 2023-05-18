Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17CA707B18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjERHgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjERHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:36:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8EE53
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:36:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94a342f7c4cso320190466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684395388; x=1686987388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ste+hA3hVZg/wcPWyWKj67qIkpodPoS4fVaLQiPlcds=;
        b=QzEJZhz79HlFdtViq9eqLPahBfKlyYWEPsxmRT26/MAU5o3QQIjH8Rq1P+lhoJtFTo
         K7aGW6ybsrTfEAlzUo7FNjomb8FGMjKQTQIpClTc4kN0zaXiQqqPOCI2trT/LieP5sdm
         mX/nJel5naiIN/6j4qOqyOgxkONRJ1RmkgvxAUIJ8CQBc48TKaxztvuWmoKHDxZ0cGY1
         UB10jhv4eOMwfPdwhfwR+6z6SRyI8qNHBzHQYJUvvlkhkegcjP6rlK2HLglrdc9QEZgr
         h5+66G87iwjuqGnsiH73SRiEFVg6Dtgp2m3+PY4hKiOvWfzdF5Tni6RKCBc2fBYrxeh8
         VGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684395388; x=1686987388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ste+hA3hVZg/wcPWyWKj67qIkpodPoS4fVaLQiPlcds=;
        b=KikDU0X6rhCs+BZ+TCABuZ/8kV8LIdH87QlsCtDpyLSNTwUke+Ornldr9GRsgleibT
         o4Ik3UPi5i4V5Upy6HQwMn2UiqLIkjEoXw9oHMRAAAoezdbJxtW5XxNZ9315xalNMj8g
         yK57fqGC1WRaFhGbizsY3iM1XKdxQcj6OxsFdsiRkqwIqf73zQXfASCmZXNyA+aSyOhf
         l2lxz/RjmWr8ErW87KVDISDQAI5uJaiyx7woLXHQWK7ssg495B/9ZCSXZ1M2rWw9sTVs
         5pADm8W2p/qKDzsSmbKD9Li6EajTguCROjcrO/7RsUCUKgtrgGFamKznwyJqhr8KEkku
         7VaQ==
X-Gm-Message-State: AC+VfDxM5RejOhhXc35lCWnNbVgif0TRlb+uOvjY8JvJEMZ2D/PY0vab
        d97KOLOOxV4c0qbJ5diPKY6pbQ==
X-Google-Smtp-Source: ACHHUZ7Vh4OMaRUBvmALYQnHYbI1fQ7eSxuoQNeQi0X2/Sih20ahC1IIfU/tohj31CS190ZY2Niurg==
X-Received: by 2002:a17:906:ef0d:b0:94e:e9c1:1932 with SMTP id f13-20020a170906ef0d00b0094ee9c11932mr42996168ejs.43.1684395388608;
        Thu, 18 May 2023 00:36:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id l7-20020a170906938700b00947ed087a2csm593598ejx.154.2023.05.18.00.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 00:36:28 -0700 (PDT)
Message-ID: <d1a04735-d80d-d1d8-01fe-d6772d50b43b@linaro.org>
Date:   Thu, 18 May 2023 09:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: update
 properties
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
 <20230517111534.32630-6-trevor.wu@mediatek.com>
 <9359c081-cd36-3e5b-a113-7600b4ba435e@linaro.org>
 <d207670232288181171473d47536173a7aa47c75.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d207670232288181171473d47536173a7aa47c75.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 04:37, Trevor Wu (吳文良) wrote:
> On Wed, 2023-05-17 at 16:43 +0200, Krzysztof Kozlowski wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 17/05/2023 13:15, Trevor Wu wrote:
>>> Add compatible string "mediatek,mt8188-nau8825" to support new
>>> board
>>> with nau8825 codec.
>>
>> Subject: everything can be update of properties. Rephrase to focus on
>> actual change, e.g. on adding NAU8825.
>>
> OK. I will rename the topic in v2.
> 
>>>
>>> ADDA_BE is used to connect to mt6359. For the machine, it must be
>>> fixed to the same codec and configured on the machine driver.
>>> Remove
>>> ADDA_BE from items of link-name.
>>
>> I don't understand the justification for this. If this is not a
>> correct
>> link name for MT6359 setup, then it should be removed in its own
>> patch.
>> If this is removed because of adding NAU8825, then why does it affect
>> MT6359?
>>
> 
> In the patch series, [PATCH 1/5] divides ADDA_BE into UL_SRC_BE and
> DL_SRC_BE. I was going to replace the link name, but I found it
> shouldn't be configured for the machine, because mt6359 is the only
> codec for ADDA_BE and it's hardcoded in the machine driver. As a
> result, I decided to remove it.
> 
> I will separate it from the patch, and put the new patch after [PATCH
> 1/5].

Yes, please.

Best regards,
Krzysztof

