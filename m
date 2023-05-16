Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C41A7054F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjEPR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjEPRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:25:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44329EEF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:25:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96adcb66f37so800489566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684257955; x=1686849955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaxHwIc3YTomkyxf5bv7RebD5LndIOVkZkiSgimWPcQ=;
        b=SWrfbgY93o65ciJ/hQhx6fcIKAU1aE41lTMHirqmMKIElBzqohgSGGiDkNEM2+/ecz
         1KsRe2w+BxUYXK5f2P69CQILZGMUhifkVmg/lUOXr/knZ/NUZ3IPk103+g5BJKSxn4pz
         03Isrw/EUpOv60d3KTs0NRTiavnnZ1I4VtfCoCxcyBZQhznZ+wDzD3+QokjZBNMbd4VU
         RTWx/zl12SQBRRmwk0duBJofnr9f/Wc3D0Aq9SJaoYca0Sm3Prmusb5pXtsZyiPziGMQ
         N2mqLQwMvkKnWu1sY3Uh2dQW24GqMlH2mjhXh+4PXAr9tBLhTvqTviIuaUofih8S9umX
         do/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684257955; x=1686849955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaxHwIc3YTomkyxf5bv7RebD5LndIOVkZkiSgimWPcQ=;
        b=kXziN7FMh61ZqhgDR8Ois82FcP3RQOWg22m3BQvuYXzzRwMSwMTsk1YRqwmVCSxSJ1
         AB8Mo5aGWyAhHy5S+dSBxH2YGsAXHJBhdTk0DWah6CopnS26UF9N+/RcGwWNWzkOKsAy
         njjc1+oih9P+3Z28dfEdV4GNaIt/7R7TiAB+0VVe45pTC9L4jwelJw1et1mbkAQjKH35
         mfdohfaRmEdLfLOPV2Hjv8YTNO2w8aMCrV7ax59xQMdTbyvOpEw2bdSpB0q8VAkEBCUK
         plcLMFtkwpZ59/yhcNE6xNTTGhA5/zU6X8OI2u/7Y/vwcg/IX86Jh2ay0hQFqd8srgVj
         bz5g==
X-Gm-Message-State: AC+VfDyxD3tWO/G+ZJAJHrjGQLgdVtjeyKd89tLXaqkRdZqMOEigXFdk
        pDzxek5NxLWs2KGyMRWLR405fQ==
X-Google-Smtp-Source: ACHHUZ4ANbmrMhZNLKIey//CUk5U76aHoVbhuHjT0j3SzTxfHKQkOQs9zz0Q131ZddtwQSy8cdTkwA==
X-Received: by 2002:a17:907:1629:b0:96a:9c6:d752 with SMTP id hb41-20020a170907162900b0096a09c6d752mr27352738ejc.54.1684257955147;
        Tue, 16 May 2023 10:25:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090653cf00b0094ebc041e20sm11023754ejo.46.2023.05.16.10.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 10:25:45 -0700 (PDT)
Message-ID: <451a1f59-2575-10ad-f8f4-eb5f0872f2d0@linaro.org>
Date:   Tue, 16 May 2023 19:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: zynqmp: Switch to amd.com emails
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
 <bbb63fb9-69c3-9c86-c5aa-55b4beac0832@linaro.org>
 <c03d5e9a-7f04-5a26-8e6f-635c526bc859@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c03d5e9a-7f04-5a26-8e6f-635c526bc859@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 19:20, Michal Simek wrote:
> 
> 
> On 5/16/23 18:05, Krzysztof Kozlowski wrote:
>> On 16/05/2023 15:41, Michal Simek wrote:
>>> Update my and DPs email address to match current setup.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 7 ++++---
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 7 ++++---
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 5 +++--
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 7 ++++---
>>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 5 +++--
>>>   24 files changed, 51 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>>> index 88aa06fa78a8..1495272e5668 100644
>>> --- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>>> @@ -2,9 +2,10 @@
>>>   /*
>>>    * dts file for Avnet Ultra96 rev1
>>>    *
>>> - * (C) Copyright 2018, Xilinx, Inc.
>>> + * (C) Copyright 2018 - 2022, Xilinx, Inc.
>>> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>>
>> I think these should be split. Your commit suggests only update to email
>> but you add copyrights. While email change is trivial, 
> 
> ok
> 
>> the copyright
>> change is not (at least not for everyone and for every legal system).
>>
>> What's more, there were no changes to this file after 2018. What
>> copyrighted work did you add in 2019, 2020, 2021, 2022 and 2023? For
>> this file clear: NAK
> 
> All these files are regularly updated in soc vendor tree. I can do stats to 
> double check every file but I am quite sure that every year we did touch these 
> files at least with single line of change (and not just copyright update).

I checked. Copyrights, if you need them, should be added in a meaningful
way, so with copyrightable work. This file has 0.

For other files, if you want to add copyrights for every trivial change,
this will lead to adding other people's copyrights as well...

> It means at least it is not big concern from me that we created file in 2018 and 
> then touch them this year.
> The question is if this is valid argument which could be accepted upstream.
> TBH I don't mind too much because primary reason for this patch was updating my 
> email address.
> 


Best regards,
Krzysztof

