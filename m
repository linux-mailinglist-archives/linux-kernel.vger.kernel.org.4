Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB26A23E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBXVkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBXVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:40:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A065C144
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:40:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3107074wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsMUJOfucntI69uWmt/ynOZ6YJQy6cS1tproFnr6S1Y=;
        b=fd6VqkkOmMlYhO9+PLnPa3CiH1DDR2efQfzQWcVpEJ2/RwIEaTzXyfpfmzRhmHWuVr
         e5NbQ8z2jHeBJyZiWPDnDzgG7bDXD873avPJKVvnWC/dSDBoUOs1KgVjfA+SlE6nwXEL
         CiuLKBTWKSTyEf/eI+SQxoQVRsuzPvXZv5aXEyS7/5cMdLlMgLHlYw78aCONJEXz9Cgu
         0hh5QSqLMhyCREqwu5P0ZbcP6g0n9OT8dQCXLoRSmurOD/PRJpUXtJ9SeVEx0NWGio2y
         rk3dYn1bZcd3xDKAvUgzYuLGlqFRR4+75nxlf03HnDJ+uArZequCPBZf78dDLabOl7J0
         4PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsMUJOfucntI69uWmt/ynOZ6YJQy6cS1tproFnr6S1Y=;
        b=q/pSIeSwwnpg3lu8NzFUG0t6fXwrJndGi2cC4qiNtB3V9VTxn2uK2PfsuRaNHMY2YC
         LYMvpCIwl3A7srNIKpIdTVam7tvRruKJd4tcBu8VlaExSsnEtv5Uzc+eTR+YJB/mJSxx
         YOB68Ez1XMqnbJpZf3/PFKZSRHd7fBIlKKI1QizJuKPqGr4gVseJHVVDToVSofv5DcV1
         fe/+UID/INHMA/HZ8uYZT+EAErF1IIZ3wUssleD6e4oJKbBcL9tb3CM2tFJFjq7Fe8ku
         ura3Jc7Z7Hh34vzCqUuB+fV7r+Q/N+52aWZlr9lJgjLMZZNHCSTQVZH2h+0ifaglp5+M
         pQMg==
X-Gm-Message-State: AO0yUKVKheUBWPl+jhnToOd2DdsIC+MxK8Zxn4DOFyJ01e7Q03BH3XBB
        YmEBDK5AHL/WbbCQvgxfT9yzOw==
X-Google-Smtp-Source: AK7set/gZMti4//bQauS+LaOAAx7jpdsQqbc8JJz9RAHbdvzPeTY+j6CI1BSmgL810x11la1Tz6eKw==
X-Received: by 2002:a05:600c:170a:b0:3dc:43a0:83bb with SMTP id c10-20020a05600c170a00b003dc43a083bbmr12398985wmn.3.1677274807871;
        Fri, 24 Feb 2023 13:40:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hn6-20020a05600ca38600b003e21f01c426sm486400wmb.9.2023.02.24.13.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:40:07 -0800 (PST)
Message-ID: <37b157b6-2383-3108-819a-44f59747bd05@linaro.org>
Date:   Fri, 24 Feb 2023 22:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC 1/4] dt-bindings: clock: rename mt7986-clk.h to
 mediatek,mt7986-clk.h
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <cover.1677089171.git.daniel@makrotopia.org>
 <15d718a2d696d29b48668b9ab5531369c537a1e6.1677089171.git.daniel@makrotopia.org>
 <ace28a97-b43e-4b24-52d0-93bc21263aff@linaro.org>
 <Y/kmj36e4jSfLdVN@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y/kmj36e4jSfLdVN@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 22:06, Daniel Golle wrote:
> On Thu, Feb 23, 2023 at 11:18:37AM +0100, Krzysztof Kozlowski wrote:
>> On 22/02/2023 19:09, Daniel Golle wrote:
>>> Rename dt-bindings header file mt7986-clk.h to mediatek,mt7986-clk.h,
>>> propagate this change also to mt7986a.dtsi which is the only user.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt7986a.dtsi                       | 2 +-
>>>  drivers/clk/mediatek/clk-mt7986-infracfg.c                      | 2 +-
>>>  drivers/clk/mediatek/clk-mt7986-topckgen.c                      | 2 +-
>>>  .../dt-bindings/clock/{mt7986-clk.h => mediatek,mt7986-clk.h}   | 0
>>
>> You cannot have bindings and DTS and drivers mixed together. Which
>> points to fact - you cannot make such change... Also your commit msg
>> does not justify "why" you are doing it.
> 
> The reason is simply consistency with most other SoCs.
> 
> So to make such a change possible, I should do it in three steps, right?
> Step 1: dt-bindings: copy mt7986-clk.h to mediatek,mt7986-clk.h
> Step 2: changes in drivers
> Step 3: dt-bindings: remove mt7986-clk.h
> 
> Would this change be acceptable if carried out in 3 commits?

For new code - it would have to be in three commits. For existing code,
how you are going to achieve it with keeping full bisectability?
Remember that each commits goes to different branch and/or tree! It's
probably doable within two Linux releases with some header wrappers...
but is it worth the effort just for "consistency"?

> And using the same strategy also the other changes suggested in the
> series?

All of them have the same bisectability problems...

Best regards,
Krzysztof

