Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B96A0B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjBWNyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjBWNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:54:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D06222E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:54:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h9so10784865ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYFX5pmaSVzGWi42xVOCfGboWlcT7LiUwwnbJTILE1A=;
        b=nO8vClqZf3GWYNGDQRXrVe5XH4b4AUQTVSoPx4e6OhvKM/t6moUrffd2aXGjK9hDIH
         lqqm5RUbr7YaI0/s8MMIl9Z89OGPm3iMRgnMjKaPyedLEarIjVS9vebhYPvU6BOjbahx
         Zpuo6NG4GWkwaiJy/RRjcsoDb83oHsnwQnGk3K9K7YM6jbbSa1eOennFtGFInN9qYEtU
         H/3oFyR0tdkT8s0B057loJ+Ouk8Zw+nmlGpXkxSlTkDC9YmQS9drfvsEmtlZBpk3ArTv
         Zc7pb0bBhFwpCbFMcqBIMpeXawKwo96WpgPCahU27IN/6ie9X0esQr3lVBGo0PNNGpqY
         s97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYFX5pmaSVzGWi42xVOCfGboWlcT7LiUwwnbJTILE1A=;
        b=G3RbPHlT7dWlF4oVZ8pvBJdWMLkD47Beuol5L0XXYcsnPSCszPMYSikUA1wE9ZFZkV
         U/BHD+29jb8Pg11k0slnDMkyMd+epOyrt9UqPIWLX0g+X5zxH4FSYdDK8J2N7m1f5q8z
         za2fNcHPumg75tgMB2St3+33Fze6if+X7lD8EadAYu2MlYN+bw2ht54OU1Uz0ALaFukb
         xJg7JQqBJwFMHXN4YCVMp4JM3MRseRWXp3G6n1EHDJbKgYZAfzUhaSkE/NaGBXhmEbbV
         cnzyaTiyIKixCYJs4S1qIVbEuzeo6+olc8KM7ovYeSrucpGv7WPGr0mIhKhaNVcC5BFG
         UMIg==
X-Gm-Message-State: AO0yUKV3Zw1sH+jCfZqXIiX9wxUmAA6VPYZlh11+EliuBN6+SxKQB6su
        HFCw+Zum92xNuN6VpZqSrAaTEA==
X-Google-Smtp-Source: AK7set+jSSf60lhvfadRI+N7+BvjSGVGxxbhW7pvTkm9ucF3nEsyiBqltMBSG24sQdrXsPbcTwZyNw==
X-Received: by 2002:a2e:95d4:0:b0:295:a2cf:b1ca with SMTP id y20-20020a2e95d4000000b00295a2cfb1camr172181ljh.14.1677160440153;
        Thu, 23 Feb 2023 05:54:00 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id w13-20020a056512098d00b004db26660d86sm1001759lft.95.2023.02.23.05.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:53:59 -0800 (PST)
Message-ID: <4e1164cf-2317-776f-54cc-322b277fd4b7@linaro.org>
Date:   Thu, 23 Feb 2023 14:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-3-bryan.odonoghue@linaro.org>
 <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
 <f852bf35-6f29-a91a-00ab-9f7b2d709328@linaro.org>
 <78f9f327-283d-c7f9-b54b-a54efd1d264b@linaro.org>
 <a662b604-0bef-6ee4-43d5-0480171539c3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a662b604-0bef-6ee4-43d5-0480171539c3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2023 14:02, Bryan O'Donoghue wrote:
> On 23/02/2023 12:53, Konrad Dybcio wrote:
>>
>>
>> On 23.02.2023 13:51, Bryan O'Donoghue wrote:
>>> On 22/02/2023 17:08, Konrad Dybcio wrote:
>>>>> +            interrupt-names = "wdog", "fatal", "ready",
>>>>> +                      "handover", "stop-ack";
>>>> This should be a vertical list
>>>>
>>>>> +
>>>>> +            clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>>>>> +                 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>>>>> +                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
>>>>> +                 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>>> +            clock-names = "iface", "bus", "mem", "xo";
>>>> This could also be one
>>>>
>>>
>>> Sorry what are you asking for here Konrad
>>>
>>> clock-names = "iface",
>>>                "bus",
>>>
>>> if so, why ?
>> Yep!
>>
>> It's just easier to read.. you don't have to count the
>> nth entry in a single line. Maybe this specific example
>> is still easy for the human brain to quickly cross-reference,
>> longer lists or lists with longer entries than 3 or so are
>> confusing..
>>
>> Konrad
> 
> I'm not necessarily opposed to that, I just don't see much precedent for it.
> 
> But... fine.
Well yeah.. our dt style is still evolving, but this thing is
certainly useful, I've started asking people to do it in the
past month or so, as we've been doing that in some places already
and it seems to be beneficial to coherency and readability..

Konrad
> 
> ---
> bod
