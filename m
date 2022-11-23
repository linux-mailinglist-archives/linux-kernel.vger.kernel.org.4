Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721D635FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiKWNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiKWNbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:31:03 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D192C10FC0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:12:41 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z4so4423171ljq.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/IVWWdjp8tAx1I6PTuaSz9fGetOroGNtnDHskb25ww=;
        b=baOyM71qkJYZUfmBbkdR2CsrfUbsjU4y13yize9SsqNZBJzcjC2HlZKq/8tEx6QBg1
         2LekXSAPbNjO+tW9q0atX0ELsU137PD7NM8Yqm+J2BxzSViycFJO52Md2zcQYopH56kz
         xLf7QAXBSvdlIXctpK7HCZJqqklT6dVmTSNGOsPZj9qk3Ct0tHjS8VZK0IhwJkJU6Otc
         SD1yd2zV7+G8Ty+jcsXSuE6a3wOBPxFtjENrZe0XjTrRPLurhMPKsHAALxTLMC1lrRA+
         ZR0BYHMGhT/WuY8CCOP2n0PMfs1cvbeObHztC05O1b/XgL+AcK2Ysbb2g9X55w2qeRYS
         qmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/IVWWdjp8tAx1I6PTuaSz9fGetOroGNtnDHskb25ww=;
        b=mvWuTgHik0JwyOC4g21Z+ZXP/Wf3aeTB1rwS/bu04yTDuo7o8V3selmfk5775Qrz1J
         M+o9loWcBkLQY5WPx9KsIUYz+vHfh6iz+I5t6we3jMKlZk4j2arSvJPd9iZdrkp22HTP
         Q0kB6k6dD/wrHzLuPFwyDebrs+tIj14Cjbh0jFMRUU5YbgVxBGQRTi1OwkZpIyO2kA85
         A/uHunCwVCMn+Qh88gHrwqH6IP6pixigpW1NqAqMaFOdQ6E2PlYvJlOeDHThyKq2qEyK
         2NVI7+01jxVx+XfzskLHofb8VqjZ8mVr636t1RHrOUODIp0NTXGlWT2BWxN5WzpPR4dn
         AJDw==
X-Gm-Message-State: ANoB5plEsg97SGpnPjaWd3hzDfMYfg2wSYhF2S8OkEyTtXElZ+o99HYC
        tmo81/MMRa1gD/m7D36CyQCGLg==
X-Google-Smtp-Source: AA0mqf72r3r2CdweEKQPRpoICFb4EKclboZYMlY4ArKN+ddS2Sk6L1oDCwr0Ujc+mePWkYAv2UpgMA==
X-Received: by 2002:a2e:a543:0:b0:277:8f64:f9fa with SMTP id e3-20020a2ea543000000b002778f64f9famr4684566ljn.282.1669209160213;
        Wed, 23 Nov 2022 05:12:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o15-20020a05651205cf00b0049ad2619becsm2898897lfo.131.2022.11.23.05.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:12:39 -0800 (PST)
Message-ID: <03a26971-e54b-a8e7-c02f-ae5a8feba71a@linaro.org>
Date:   Wed, 23 Nov 2022 14:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
 <CGME20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f@epcas5p4.samsung.com>
 <20221121091118.48628-3-sriranjani.p@samsung.com>
 <a98ac5d7-0c0e-110e-5405-83a09c77ceac@linaro.org>
 <000001d8ff32$c8b78e30$5a26aa90$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000001d8ff32$c8b78e30$5a26aa90$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 12:57, Sriranjani P wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 21 November 2022 17:58
>> To: Sriranjani P <sriranjani.p@samsung.com>; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; lee@kernel.org;
>> devicetree@vger.kernel.org; alim.akhtar@samsung.com;
>> pankaj.dubey@samsung.com; ravi.patel@samsung.com
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
>>
>> On 21/11/2022 10:11, Sriranjani P wrote:
>>> Add SYSREG controller device node, which is available in PERIC, FSYS0
>>> and
>>> FSYS1 block of FSD SoC.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
>>> ---
>>>  arch/arm64/boot/dts/tesla/fsd.dtsi | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> index f35bc5a288c2..db78816ba0bf 100644
>>> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>>> @@ -518,6 +518,21 @@
>>>  				"dout_cmu_fsys1_shared0div4";
>>>  		};
>>>
>>> +		sysreg_peric: syscon@14030000 {
>>
>> Node name system-controller
> [Sriranjani P] Will fix it in the next version. We added “syscon” since I referred other dtsi files in mainline for example exynosautov9.dtsi used syscon as node name. If this is the name we should add then I’ll post few more patches fixing this node name in other Exynos dtsi files.

Use proper wrapping for mailing lists. It's difficult to read your emails.

>> and either put it next to existing one or next to functional block (peric
>> clocks?) ordered by unit address.
> [Sriranjani P] We thought of it but as I saw current fsd.dtsi file and other exynos file like exynosautov9.dtsi, in that nodes are not properly arranged as per unit address.

I know, that's why I proposed to order by unit address within other
syscons or other functional blocks (e.g. peric-related).

> 
> So I can think of following two approaches: 
> 1: For the time being I will put this sysreg node in between clock_peric node and clock_fysys0 node and clock_fsys1 node as per increasing unit address. I will clean up other exynos and FSD DTSI files and post a new patch 

Not sure what cleaning you have in mind.

> 2: First I will clean up exynos and FSD DTSI files and then post this sysreg patch keeping it at appropriate place. 

What cleaning?

Best regards,
Krzysztof

