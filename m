Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468D6BE5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCQJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:38:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B0170F;
        Fri, 17 Mar 2023 02:38:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA6F3660309E;
        Fri, 17 Mar 2023 09:38:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679045881;
        bh=rmmWudAsSvMomWU/4fDVcXJ8Rtt1hVjirKy1iG0ELDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aBnKahfJNgs/WHPGR5Z2WVQlkVBpkAadZjyTZUgUEZ7nZDC3i5EGLvepHobwTWD4D
         7vc9MJxqJk6pXw3GuXacqWZCXQmuh4te0jaQ7SUBdz5Kr0E94PFH+S40qtVlqZ3Y3x
         4rYQTCMbfHKf462ylqImBcZTQQnypHMvt8RoueLMyjyukz/HjOHI0r+vbFvQ+Buurk
         WZQdnuhpNmvPbSY2HKe4LJtO0I+1ySONKuAA8FluTO2fRg0Ag7XYdk6c5AsgkGu8bZ
         Cd24vQ4qRawksvtR02G+AVvYBdzWwzwCmu0EDGB0YL4qO7VGAKyerLfkU4AHZttOqQ
         cqnUwyX3YSyPw==
Message-ID: <fdd0a157-eedb-bf21-c632-79b02a4cd6b0@collabora.com>
Date:   Fri, 17 Mar 2023 10:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
References: <20221227081011.6426-1-nancy.lin@mediatek.com>
 <20221227081011.6426-2-nancy.lin@mediatek.com>
 <4aff6a7a3b606f26ec793192d9c75774276935e0.camel@mediatek.com>
 <2700bd6c-f00d-fa99-b730-2fcdf89089fa@linaro.org>
 <1d65e8b2de708db18b5f7a0faaa53834e1002d9f.camel@mediatek.com>
 <b04eb48e-c9aa-0404-33ec-bef623b8282f@linaro.org>
 <e5ceec9e-d51b-2aeb-1db7-b79b151bd44c@collabora.com>
 <0ebf187d-972e-4228-d8a0-8c0ce02f642d@linaro.org>
 <72cf6344a1c5942bff0872d05dce82b787b49b76.camel@mediatek.com>
 <4027714e-b4e8-953b-68e2-f74f7a7f0e8e@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4027714e-b4e8-953b-68e2-f74f7a7f0e8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/23 10:03, Krzysztof Kozlowski ha scritto:
> On 17/03/2023 08:55, Nancy Lin (林欣螢) wrote:
>> On Thu, 2023-03-16 at 12:36 +0100, Krzysztof Kozlowski wrote:
>>> On 16/03/2023 10:53, AngeloGioacchino Del Regno wrote:
>>>
>>>> Hello Krzysztof, Nancy,
>>>>
>>>> Since this series has reached v29, can we please reach an agreement
>>>> on the bindings
>>>> to use here, so that we can get this finally upstreamed?
>>>>
>>>> I will put some examples to try to get this issue resolved.
>>>>
>>>> ### Example 1: Constrain the number of GCE entries to *seven* array
>>>> elements (7x4!)
>>>>
>>>>     mediatek,gce-client-reg:
>>>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>       maxItems: 1
>>>>       description: The register of display function block to be set
>>>> by gce.
>>>>         There are 4 arguments in this property, gce node, subsys id,
>>>> offset and
>>>>         register size. The subsys id is defined in the gce header of
>>>> each chips
>>>>         include/dt-bindings/gce/<chip>-gce.h, mapping to the
>>>> register of display
>>>>         function block.
>>>>       items:
>>>>         minItems: 28
>>>>         maxItems: 28
>>>>         items:                     <----- this block doesn't seem to
>>>> get checked :\
>>>>           - description: phandle of GCE
>>>>           - description: GCE subsys id
>>>>           - description: register offset
>>>>           - description: register size
>>>
>>> This is what we would like to have but it requires exception in
>>> dtschema. Thus:
>>>
>>>>
>>>>
>>>> ### Example 2: Don't care about constraining the number of
>>>> arguments
>>>>
>>>>     mediatek,gce-client-reg:
>>>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>       maxItems: 1
>>>>       description: The register of display function block to be set
>>>> by gce.
>>>>         There are 4 arguments in this property, gce node, subsys id,
>>>> offset and
>>>>         register size. The subsys id is defined in the gce header of
>>>> each chips
>>>>         include/dt-bindings/gce/<chip>-gce.h, mapping to the
>>>> register of display
>>>>         function block.
>>>
>>> use this.
>>>
>>> Best regards,
>>> Krzysztof
>>
>>
>> Hi Krzysztof, Angelo,
>>
>> Thanks for the comment.
>> The Example 2 can pass dt_binding_check.
>>
>> But the example in the binding has 7 items [1] and dts [2]. Does the
>> "maxItems: 1" affect any other schema or dts check?
> 
> Ah, then it should be maxItems: 7, not 1.
> 

Keep in mind for your v30:

maxItems: 7 will pass - but only if minItems is *not* 7 :-)

-> (so, do not declare minItems, as default is 1) <-

Regards,
Angelo

> Best regards,
> Krzysztof
> 
