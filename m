Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B146A91D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCCHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCHmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:42:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E653289
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:42:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a25so7073929edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677829361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NaYC7Z7KE3/xDS+ojWZnShCIrXPLH1EZcxegpj4uXo=;
        b=vRw8wJ2r4i7Z3/3FQ0GALVawwqYtGc5IZ3nkCeTKZwVvCJ93pC8TOrhqdS/aiSDqGa
         MDEEySc4FT8jD+H4FeVR1ZU1fmdhh5Ezx6susvVz5f0LEC9MWQSNzts23IizlW6LDRDk
         uAibihwPv3kGtZbFMyuYBpmULGzMsY5BNim0FTLQkSJY0q7VQ8TYL76kG7xy5r5U0C9+
         3JK+o8axtWR8oFBgB9y3Mu0LKtrfZjbPM1DSawcJMj8LZEqZ6LGoxS8FzGwfxM8RHpHE
         ijWPbrA27y6Mu4FFYtk8aztOvKlBsUYe6emc2JHIkURRoLWOZiyVIDTd2J+O5AazW4jh
         iA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NaYC7Z7KE3/xDS+ojWZnShCIrXPLH1EZcxegpj4uXo=;
        b=nhbItY7I/5R3uBRxXmN2sq4UUKmLK7/a4xsv/30f/gxsv25UZFPYN8ghQqaG26kCFr
         TorqYRXD8Z4ZLE/rXZX2a7AqS/TcmIf2nIShMaqLGSgRDXKXPeIU/vh4b889M9OjfWle
         mc9l2Fwed+bwwzZOS++qT7X8MPzku7MWNk2Sa7Yq7tS0DDoNhv+6FxsgURwXCx6r6fQo
         4NBhHF+40shHNLlWlAFAhDNGirAV4DYbmIyxCdt7Ne7ijvy1jIIL58Ta6f50HhHckwOi
         EnHV8q1iuN3e0/NpeUwGZWM/TTixnpHe3EmTwdYVzraQGIh36KgMP7AnmBXRt6U6OYIm
         dR5g==
X-Gm-Message-State: AO0yUKUnNoT59/6oVJVk+04dgbjs/LxbBiwuHds5P04+D0zO+oemNwFA
        /r26gOpGeR/o/5dFVdevQ7/C2g==
X-Google-Smtp-Source: AK7set9XQN5XXL8B1oRWyaxYB8OqaN+rULhPoZWgFzO6jicJxzYWXiJ+BxcApbrfFSwmxpwqMut0ow==
X-Received: by 2002:aa7:c153:0:b0:4ac:b614:dcfc with SMTP id r19-20020aa7c153000000b004acb614dcfcmr1347767edp.9.1677829361326;
        Thu, 02 Mar 2023 23:42:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id rk9-20020a170907214900b008d2d2d617ccsm676760ejb.17.2023.03.02.23.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:42:40 -0800 (PST)
Message-ID: <54ee2141-f00a-3193-0821-2faaff826254@linaro.org>
Date:   Fri, 3 Mar 2023 08:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] dt-bindings: display: mediatek: Compatible list
 cleanup
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230302141234.169985-1-y.oudjana@protonmail.com>
 <0969ff46-3fba-f679-7943-52da7528185a@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0969ff46-3fba-f679-7943-52da7528185a@collabora.com>
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

On 02/03/2023 17:08, AngeloGioacchino Del Regno wrote:
> Il 02/03/23 15:12, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
>> Several DT bindings of MediaTek display blocks make unnecessary use of
>> "oneOf" and "items". Remove them and replace them with enums where
>> necessary.


>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>> index 7d7cc1ab526b..52f233fe1c0f 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>> @@ -20,9 +20,7 @@ description: |
>>   
>>   properties:
>>     compatible:
>> -    oneOf:
>> -      - items:
>> -          - const: mediatek,mt8173-disp-wdma
>> +    const: mediatek,mt8173-disp-wdma
>>   
> 
> This is present on all MediaTek SoCs - literally. The issue is that the driver
> currently does not support command mode panels for real, so this binding is...
> ...well, somehow in forgotten-land...
> 
> I would hope that command mode panels get implemented soon(er-than-later), but
> I'll leave the choice to you and Krzysztof - I'm only providing the information
> here. :-)

Yep, if you predict now that oneOf sooner or later will come back to
these, just keep it. Does not hurt much and later re-introducing it
makes patch much more difficult to read. Therefore I prefer to have
unused oneOf than later a patch which introduces new compatible and
re-indents old one (so unneeded diff changes).


Best regards,
Krzysztof

