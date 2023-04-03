Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CE6D4B23
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjDCOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjDCOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:54:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F82C16C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:54:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so118514677edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680533666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MYkMU1LTnOHVMP6HjNeFG2DRZjRa3eGm53fnJdgbc8=;
        b=aHG4EQpPrwwrZ0xsU+6h+jgYLslKOOi5f0J6zlC90kyvgE9UTdn4Q0F7pOHcdeXnW7
         ugGgxYwmhjEZKPhmZd/z6Og12wPvcP59GUXr9yluSvir/y4ynYPSdxiTWLo9lAIn8wIO
         FHOuwq4hdWcrWbLElbUspEy5TTrdRXtL9PLOEnLnHnIFHowf3o9aOP531Cf4r+3JLIh1
         3PkHDWQ+5nfm9SFo6Tm/sArpNSaVlKYiClE6W1G06KPvrhigzsAi3xwCat18zMHB3zIH
         w3TYqVRGHPAx2r0pok5PyZYjGyCotgek0g/FAtKB8rdPuQIGJJsYmsEKuistr/NT/475
         8gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MYkMU1LTnOHVMP6HjNeFG2DRZjRa3eGm53fnJdgbc8=;
        b=g1B8KmIo4DsC6ZqL/XjTGeXSQpGTq9OkblY3J5luhToyfiU34NYN7s697Xj1a+/ASk
         fwEtTKpoGIcpSXH/5hUfm8ptyoBzKpqo/z9Rsuo06Dq/9euP+XgS/CcyEiX4zpFnxjVJ
         2vfayZChN3kAtApOJdvl7yaBi2kGiOxWL0zIqo/3a0odOQaBKnT2pmSGS2h+xPvN6PH8
         Sk9VL6guE3eW6C6DVihq8RtyjlC0eAURUOpGw8URaGj16aY3pIFxRMVmQ3CviDD/cLxn
         xii4YENFfgpPXzb0fV2Rw1P4b0G0vIoNtfzJ/WbXrcig8F4gKgKqSEENUNxklvCygPbn
         kuwQ==
X-Gm-Message-State: AAQBX9e1DHqajlDlm3gVVQCDZ8MpYGwQxpvgq44eOQV4gkmtTSk2JoPb
        rODQAqHYR8zMGaMJrRADv0o3hg==
X-Google-Smtp-Source: AKy350bzC7zhyZol87P/h8Ao3cd9jxB9eNaY5b8cDld4A3nvsptLofinA2tasgAr9kVP46T3v1lsvQ==
X-Received: by 2002:a17:906:b303:b0:933:48ce:73a5 with SMTP id n3-20020a170906b30300b0093348ce73a5mr33462885ejz.56.1680533665843;
        Mon, 03 Apr 2023 07:54:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id q20-20020a50cc94000000b004bd6e3ed196sm4736781edi.86.2023.04.03.07.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:54:25 -0700 (PDT)
Message-ID: <6cd130bc-955a-9537-6a1a-301a38aac53f@linaro.org>
Date:   Mon, 3 Apr 2023 16:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: add mtk-mipi-csi driver
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230403071929.360911-1-jstephan@baylibre.com>
 <20230403071929.360911-2-jstephan@baylibre.com>
 <4837c3e0-60ed-601b-8512-30fda2176619@linaro.org>
 <CAEHHSvYJrCZop8OvTjsLJjr5HHSrG8dsSQ+K_W2cjdKJ4xfodA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEHHSvYJrCZop8OvTjsLJjr5HHSrG8dsSQ+K_W2cjdKJ4xfodA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 16:40, Julien Stephan wrote:
> Hi Krzysztof,
> 
> Le lun. 3 avr. 2023 à 11:49, Krzysztof Kozlowski <
> krzysztof.kozlowski@linaro.org> a écrit :
> 
>> On 03/04/2023 09:19, Julien Stephan wrote:
>>> From: Florian Sylvestre <fsylvestre@baylibre.com>
>>>
>>
>> There is no commit msg.
>>
>>> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
>>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>>> ---
>>>  .../bindings/phy/mediatek,csi-phy.yaml        | 41 +++++++++++++++++++
>>>  MAINTAINERS                                   |  6 +++
>>>  2 files changed, 47 insertions(+)
>>>  create mode 100644
>> Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
>> b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
>>> new file mode 100644
>>> index 000000000000..c026e43f35fd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
>>
>> Filename like compatible.
>>
> Should I rename the binding  file
> Documentation/devicetree/bindings/phy/mediatek,mt8365-mipi-csi.yaml or

This.

> should I rename the compatible string mediatek,csi-phy?
> The csi PHY module is a module of the mt8365 soc and can possibly be used
> on other mediatek soc.  I think this binding is generic enough to have a
> generic name, what do you think?

You did not allow adding new variants, as you made it const, not enum.
If there are other devices with this phy, they could be even added now.
Bindings should be rather complete.


Best regards,
Krzysztof

