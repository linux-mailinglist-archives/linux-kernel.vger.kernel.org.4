Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDAE6E1EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDNJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:04:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3B4EF2;
        Fri, 14 Apr 2023 02:04:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y6so16655774plp.2;
        Fri, 14 Apr 2023 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681463095; x=1684055095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXmHkC1a048CwiQG8SZ7PoO3Ikz1HsLxMGbsHdgDqWk=;
        b=gL7zqSMoji7E25lrTbA+NFwfZFoNEYCO3zElJ4oZwNWgUkl6SI01khkvKSUhLKiB9z
         JXmBMaw5Pi50VXy58HT64n61hVbzFrjXBTZOC+wLq1ayDPbY1ycSdSPtjd6DYZ0Xdruv
         XJUVaMSO53/NxvUR2UBSumqvXbD1CnllgAPFBV3jIT0PkwMmpguY5MGFYK9l9qh3GnTH
         ckuCX7ckZvnbFp3ZozvbNeM98vV+xDw5DidolfQlBpAEBZl+abuxXxdnkb2M3hIqbeXf
         fxQVg6eFTc1sFJOtmOJKWObx6zQ2t85KxyItoZUSYMj6tKW5+t5CcDLLdkY77i83Y4gR
         lGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681463095; x=1684055095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXmHkC1a048CwiQG8SZ7PoO3Ikz1HsLxMGbsHdgDqWk=;
        b=bw0aVaPrUQaa4/VQjIslExOi0Uwg8mJz5llA6Jpa9bKCalFlFAwuhI+BDD/IMLL49Z
         IKi9w2pbfJcEz9xSb7ZPnLiBra1pdpUNYkfZTfLet/d1dv6TVuvyMPNbzeyXHfIPptOs
         Me1PABZclre9fUZR1Cgd9SovpWqOvUAncjRMnjxb76l80//j3QKUni3ob1nXSy+Cr38M
         4rzkHsIRtTU8CCilNrt49TpYknDV4EMNZ/ijpggy9ba6Zl2TcXXEQeaFS7HGum6zlCDV
         MH/DngKYwIRBJY7k/mJSsHc44uohLi2Fm8nTyUj+S7bI1apbUjgqfxXCssgV9OCsziIy
         g1Qw==
X-Gm-Message-State: AAQBX9fkTo3EGHgiM5pMPlWQAWwYNbmuKyBbX1IpOz9TqCmyFmMzEr8b
        IfEoh8lriQ7WBAccMr69qMo=
X-Google-Smtp-Source: AKy350YivyfWQMADG9PcbVLMIrbWErTwYNxSC9hCuLgFDtEkOvvbmCap6Cd7PVP8BXxl5AsCsGM4IA==
X-Received: by 2002:a17:902:c601:b0:1a6:87ae:542d with SMTP id r1-20020a170902c60100b001a687ae542dmr1808247plr.48.1681463095070;
        Fri, 14 Apr 2023 02:04:55 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170903054a00b001a190baea88sm2681102plb.97.2023.04.14.02.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 02:04:54 -0700 (PDT)
Message-ID: <1bca6745-23df-5898-7675-c914531fa40b@gmail.com>
Date:   Fri, 14 Apr 2023 17:04:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 12/12] MAINTAINERS: Add entry for NUVOTON MA35
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-13-ychuang570808@gmail.com>
 <241f6cb1-193f-d372-0eda-157946b15780@linaro.org>
 <91861072-dc2d-46d3-dc0d-26d17a3693c7@gmail.com>
 <4b9a0f13-d03a-8496-a400-8621b8d7c98a@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <4b9a0f13-d03a-8496-a400-8621b8d7c98a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/14 下午 03:46, Krzysztof Kozlowski wrote:
> On 14/04/2023 03:22, Jacky Huang wrote:
>> Dear Krzysztof,
>>
>>
>> On 2023/4/14 上午 01:01, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 07:38, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add entry for Nuvoton ma35d1 maintainer and files.
>>>> In addition, update board binding paths of NUVOTON NPCM.
>>>>    ARM/NUVOTON NPCM ARCHITECTURE
>>>>    M:	Avi Fishman <avifishman70@gmail.com>
>>>>    M:	Tomer Maimon <tmaimon77@gmail.com>
>>>> @@ -2512,7 +2522,8 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>>>>    S:	Supported
>>>>    F:	Documentation/devicetree/bindings/*/*/*npcm*
>>>>    F:	Documentation/devicetree/bindings/*/*npcm*
>>>> -F:	Documentation/devicetree/bindings/arm/npcm/*
>>> It is not a bisectable change.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> F:    Documentation/devicetree/bindings/*/*/*npcm*
>> F:    Documentation/devicetree/bindings/*/*npcm*
>> F:    Documentation/devicetree/bindings/arm/nuvoton/*npcm*    <-- remove
>> this
>> F:    Documentation/devicetree/bindings/soc/nuvoton/*npcm* <-- remove this
>>
>> Yes, the two statements at the bottom seem redundant. I will remove them.
> I did not comment about "redundant". I used the word "bisectable". git
> help bisect.
>
> Best regards,
> Krzysztof
>
Dear Krzysztof,

I do a test on it, but cannot find issues.
Could you please advise on how to duplicate the issue? Thank you.

I do the following 'git bisect' test.

$ git log --oneline
5e186f4f1f94 (HEAD, master) MAINTAINERS: Add entry for NUVOTON MA35
. . .
1a8a804a4f5d Merge tag 'trace-v6.3-rc5-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace


$ git bisect start 5e186f4f1f94 1a8a804a4f5d
  HEAD is now at 5e186f4f1f94 MAINTAINERS: Add entry for NUVOTON MA35
  Bisecting: 68 revisions left to test after this (roughly 6 steps)


Best regards,
Jacky Huang


