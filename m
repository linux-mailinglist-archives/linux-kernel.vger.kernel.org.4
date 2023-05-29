Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B998714E48
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjE2Q23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjE2Q21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:28:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E64AB;
        Mon, 29 May 2023 09:28:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so36298435e9.3;
        Mon, 29 May 2023 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685377704; x=1687969704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iKyeVxpYOPIGYe/Lxm4HI6qu/yiKmBXO8zVnrWLpCU=;
        b=EpgmH9C6n5uyhLbAytYKg1lA2SVWmxLhgqXm1xmhHfyRF0cp7zejDIcXKiCOd/EkHc
         lJIpPh7f+lCohgmAvAACNj6NtHaPhXMHKg9a/1/VIYzTiRhn6x2LWHZJi68XifC3mRJI
         M3Z4b4rjMXd+jU9mNWH6+Q9me/xHAkVmLSql84N+hYQDlhrXNMp5t/3z6xDJly6Vv+Xb
         +VVlAxN3nrAj3MkDBuSILGgXIKAVFZ5TnPECDlY3JGBc/ph6RWAStiyGZMvTDLIgVWBO
         nbOejSBvsD/+OMxkRwRl19Bgf7Rsp3Y7zuinC3hX3Q9e+cVV9V0Np7Q/ycx4MsnnzGgA
         +Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685377704; x=1687969704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iKyeVxpYOPIGYe/Lxm4HI6qu/yiKmBXO8zVnrWLpCU=;
        b=XK2DaFOk9/fwmizwmYwJQd/g5MQR2475JRRbAb3ZJSCZqYB2ZcNPVmJ7p6zXWeP99G
         y2eG/4kaq4RFt5eZAV09sQuzT35AievbArTGsOplPPqsqMIwB14pzsvjgaUMZdx9XloG
         5CKNf6qBlie/qWxDZ0RBaZtyBREltsjhLcIxkhksMv5aOimrAzkaQO4gFZAbIlTBWj6o
         h73D4hPSCKQ7sb2rF5oJK3fn5iYVdj9JAa1cKxcvG43R6rpFqKScqDAgop0oIxyODJ6D
         iKR/laGbUrYJLSiV+EHL9RTqzcv79eBJbwJh/ItxPZag25VbiukUcLi/dnXl/uQlMu02
         N/fg==
X-Gm-Message-State: AC+VfDxQXnA4jI+VlIkHZzZiJMwEzKIH0Ef2E0bQhoj84j9auNNMLpHu
        xUXEj3klMwGbVLb15r3Xg3A=
X-Google-Smtp-Source: ACHHUZ4nt4/ZUaLSDt/sbuRs0jUlCrpJSZ4JbtG0UP+yrn/Tqv+Tk0qeFK4rvij2BzsefX+Pdi2pHg==
X-Received: by 2002:a1c:4c04:0:b0:3f6:962d:405c with SMTP id z4-20020a1c4c04000000b003f6962d405cmr8550475wmf.41.1685377703937;
        Mon, 29 May 2023 09:28:23 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k5-20020a7bc405000000b003f31cb7a203sm14715125wmi.14.2023.05.29.09.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:28:22 -0700 (PDT)
Message-ID: <3069dcf7-28e0-e7f6-11d5-9bc286d7d6e3@gmail.com>
Date:   Mon, 29 May 2023 18:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8173-elm: remove panel model
 number in DT
Content-Language: en-US, ca-ES, es-ES
To:     Icenowy Zheng <uwu@icenowy.me>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20230526100801.16310-1-uwu@icenowy.me>
 <CAD=FV=UxrFVZXn+dtgamttTVopWMSVbxYsHCGG_tS+3OTXbHiw@mail.gmail.com>
 <f4a9e090-3712-200e-bd09-70090c9cccbc@collabora.com>
 <6996788b112f4795d2930a6664b3152cd9a380a8.camel@icenowy.me>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <6996788b112f4795d2930a6664b3152cd9a380a8.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2023 10:45, Icenowy Zheng wrote:
> 在 2023-05-29星期一的 10:02 +0200，AngeloGioacchino Del Regno写道：
>> Il 26/05/23 16:24, Doug Anderson ha scritto:
>>> Hi,
>>>
>>> On Fri, May 26, 2023 at 3:09 AM Icenowy Zheng <uwu@icenowy.me>
>>> wrote:
>>>>
>>>> Currently a specific panel number is used in the Elm DTSI, which
>>>> is
>>>> corresponded to a 12" panel. However, according to the official
>>>> Chrome
>>>> OS devices document, Elm refers to Acer Chromebook R13, which, as
>>>> the
>>>> name specifies, uses a 13.3" panel, which comes with EDID
>>>> information.
>>>>
>>>> As the kernel currently prioritizes the hardcoded timing
>>>> parameters
>>>> matched with the panel number compatible, a wrong timing will be
>>>> applied
>>>> to the 13.3" panel on Acer Chromebook R13, which leads to blank
>>>> display.
>>>>
>>>> Because the Elm DTSI is shared with Hana board, and Hana
>>>> corresponds to
>>>> multiple devices from 11" to 14", a certain panel model number
>>>> shouldn't
>>>> be present, and driving the panel according to its EDID
>>>> information is
>>>> necessary.
>>>>
>>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> We went through a bunch of back-and-forth here but in the end in
>>> the
>>> ChromeOS tree we have "edp-panel" as the "compatible" here in the
>>> ChromeOS 5.15 tree and this makes sense.
>>>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>
>>> ...in theory one would wish for a "Fixes" tag, but I think in
>>> previous
>>> discussions it was decided that it was too complicated. Hardcoding
>>> the
>>> other compatible string has always been technically wrong, but I
>>> guess
>>> it worked at some point in time. The more correct way (as you're
>>> doing
>>> here) needs the DP AUX bus support and the generic eDP panels, both
>>> of
>>> which are significantly newer than the elm dts. So I guess leaving
>>> no
>>> "Fixes" tag is OK, or perhaps you could do the somewhat weak:
>>>
>>> Fixes: c2d94f72140a ("arm64: dts: mediatek: mt8173-elm: Move
>>> display
>>> to ps8640 auxiliary bus")
>>
>> I remember I didn't change the compatible to panel-edp because it
>> didn't
>> work at that time, but it does now... I'm not sure what actually
>> fixed that
>> and if the commit(s) was/were backported to that suggested point, so
>> I
>> would leave the Fixes tag out, as that may break older kernel.
> 
> Well at least I developed this patch on v6.3.
> 
> (In fact the same kernel config do not boot to system at all on
> v6.0/v6.1 when I do make olddefconfig then build)
> 

I applied the patch without the fixes tag. Lets stay on the secure side to not 
break older kernels.

Regards,
Matthias

>>
>> Anyway, for this commit:
>>
>> Reviewed-by: AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com>
> 
