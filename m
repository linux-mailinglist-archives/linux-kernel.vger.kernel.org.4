Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B36E098E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjDMJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDMJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:00:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D80A251;
        Thu, 13 Apr 2023 01:59:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e7so3376175wrc.12;
        Thu, 13 Apr 2023 01:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681376340; x=1683968340;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7g5hV3NWDVn1/V7aQRt4oQ8CBf16T6HKdjwb2x5bdk=;
        b=dBQhg5EbOvayR7mx31g2Jml4oYq5/XXxJlntstydhf4l7HpHShRVId/butsUy55+3P
         EsfmjNNOvORzCCy9QrCrhfQ+NTZ2L3YPpyILbRZZh4Z0DC80Bk+ylhxVs+zuIVYeiEk6
         WMSrTGlcRp94aMhIDPa9q1PpS6Fdk/5/eCF820KZyQ0No/UnjIG0HBi/m1RC4M68XKHy
         XeOSWDFKffbUpGzlPRgMTgi2c9AkCSK5nQdePDFLEjMBVDR0WcU73xrKpxaPEEVPltjN
         9zZdFEN8Rws2NkH82yXHFR2q4Udm2qOj4psP4gaDMK4HtgQ1oRZANyNdzRZYpIeGAE18
         vujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376340; x=1683968340;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7g5hV3NWDVn1/V7aQRt4oQ8CBf16T6HKdjwb2x5bdk=;
        b=KwFQ1IOtWAMOCxFBIR9VaXFDGnogu3FUpUCSB+0Yd9WGdu4siT6fD17i0YomGZN9jB
         oDAJlrXF9n8bLO5rgYC8uqahWbSyHaU/cYkHhMHZwRjxAwKuwvAwCcf3wtviusvPNd5G
         H1/7+KbwdhpRfENDP6/UPf4yD8bvIbCpo1UpUCz379tJtOsYH6TQUfEs54FMXtlKUitx
         F9nn1/xhlcGEWHKzbVAchyxVNoU8xqVhUS3vgvCHJcPhBnTzmnhsX/Fk2/AqPJyb5VR2
         87Pv+s9/xsyZP0HwSyu+LUbAm0nhkxSTmD+uPclkb7Opnr2vFDvLyUzTAnNSsWNPfI1F
         AMrQ==
X-Gm-Message-State: AAQBX9fgPf3v9dUtaXqzULszVUo1rSvG5C9r/McY2t/XfA6zU51q0Wms
        iaQ61yNJfljQs88eXaBxGDE=
X-Google-Smtp-Source: AKy350Zxv3Ko4eW0Fum9TmN1yb7aYSGe0D9dQ8XHg0Ai6fR9/Rf1dH0XSwLKNKkfZjY0IWUaTBv/eg==
X-Received: by 2002:adf:ef51:0:b0:2f0:2e3a:cc04 with SMTP id c17-20020adfef51000000b002f02e3acc04mr1138305wrp.8.1681376340325;
        Thu, 13 Apr 2023 01:59:00 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d5644000000b002f02df4c7a3sm819861wrw.30.2023.04.13.01.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 01:58:59 -0700 (PDT)
Message-ID: <4b5a6233-c8f3-4d12-7508-45df8b7548f5@gmail.com>
Date:   Thu, 13 Apr 2023 10:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
 <20684378-cf3e-0299-d390-287b7bafbda5@baylibre.com>
 <eb770f19-ada5-81bb-5ea3-798edabca70f@collabora.com>
 <7e53c0b1-3aed-da08-5c57-800ac2277bc6@baylibre.com>
 <e129b3ff-90b1-3df7-871e-09fba0a960f4@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
In-Reply-To: <e129b3ff-90b1-3df7-871e-09fba0a960f4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 15:17, AngeloGioacchino Del Regno wrote:
> Il 12/04/23 15:12, Alexandre Mergnat ha scritto:
>> On 12/04/2023 15:03, AngeloGioacchino Del Regno wrote:
>>> Il 12/04/23 14:59, Alexandre Mergnat ha scritto:
>>>> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>>>>> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
>>>>> the same DSI PHY as MT8173.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>>> <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>>>>>   1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml 
>>>>> b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>>>> index 26f2b887cfc1..a9f78344efdb 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>>>> @@ -24,6 +24,10 @@ properties:
>>>>>             - enum:
>>>>>                 - mediatek,mt7623-mipi-tx
>>>>>             - const: mediatek,mt2701-mipi-tx
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - mediatek,mt6795-mipi-tx
>>>>> +          - const: mediatek,mt8173-mipi-tx
>>>>
>>>> AFAIK, it should be:
>>>>        - items:
>>>>            - const: mediatek,mt6795-mipi-tx
>>>>            - const: mediatek,mt8173-mipi-tx
>>>>
>>>> Since it isn't respected above for mt7623, it may be tolerated.
>>>> Please, take this comment as a suggestion, isn't a NAK from me.
>>>>
>>>
>>> First of all, Thanks!
>>> I want to explain, though, the reason for that.
>>>
>>> If you check all the commits, on some I did it as you just proposed, while
>>> on some others I did it with an enum before const: that's simply because I
>>> *totally expect* some to grow, while others (const - const) I was either
>>> unsure, or totally *not* expecting them to grow soon!
>>
>>
>> That's what I thought. IMHO, if someone add another compat later, he will be 
>> on charge to change the const by enum front of your "mediatek,mt6795-mipi-tx". 
>> But my opinion is probably not the most popular.
>>
>> I will not make the same feedback for the other patches in this series.
>>
> 
> I honestly don't know what's the most popular opinion about that... but whatever,
> in any case... just want to make sure to communicate that I don't really have
> strong opinions about doing it one way or the other.
> 
> The arguments in favor and against that are probably 1:1... :-D
> 

Then let me throw in another one :)

Take into account that if we expect the compatible to be added somtimes in the 
future (not the near future) this code will lay around for some time. People 
will take this code as an example for new code, then we will need to explain 
it... In that sense it would make more sense to have all made const: const: and 
change this to enum once a new compatible is added to the mix.

Said all this, I leave it to the DT maintainers to decide :D

Regards,
Matthias
