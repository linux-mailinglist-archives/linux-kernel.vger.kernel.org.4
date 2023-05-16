Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C5704E13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjEPMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjEPMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:50:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E828A11C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:49:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4ec041fc3so37203905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684241396; x=1686833396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIrib6V4STu6mdlfD65GDnEnwcj31/2sVrUxJzgea2I=;
        b=A5De8E5wWe1LILnOfv1MpSKj9g9vdN4ATjn+1gTJ0X8t+YFnl8RujR3roEaAaPHpd2
         sNLiQKrLoFe4L8wf1egTCWKFj89VGnRWRNYp1EvbGnXFXzxY1fa10MBpkNDmFsC/zuvs
         R0djkXifGiMl//apUYCSaL29QoW1YJLb6hGeIOB8AQRoMjU5DCCGBAxYgY+07D1y94gj
         9hO1EjPg88/WX6TuqZJYdZsUhXixw68ohxOfdnXC5jyIi14D27KOquvr0N1ua1YwpYWB
         4qXHhgtkEWWnwyGlToRIAcJTW5MgV4njbc2joXc8FTZG3oLafJA5ihqS+EnSAsjxifS9
         8iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241396; x=1686833396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIrib6V4STu6mdlfD65GDnEnwcj31/2sVrUxJzgea2I=;
        b=YufPxVnakma+KMMqLFuDJK6FFv2lSq/Q+b8ycE9MtFhUS6WIh+r6kNaDyyGYUVtJla
         1ycCw+yAx6PmpRns08vycpMQnjF/gp6jNFvc0Ss5HkqTsMoeVvctvIRhM67D+qMRKHsb
         4ELMuPnvANsS7fuRnpMWBOvfbgcYDvxPuURHMvyhu9qqVjMsn70CMDf3o2nIiFZ4R6MK
         eBxWaYNDehjFOWkCxBOurAUkwTv6Z6g0b2MUHX/NENw5ZQeFCqv4PwELH8Q4POWMKRKp
         gVAkxzkDbZkzaYZ87nehvoVESdIWjST1CJLFtRajzs8S9XKVVpqKFEn4zNfQdTB4TXUe
         q/fQ==
X-Gm-Message-State: AC+VfDyC5ROlEGNm3wHaCEijjYWRKQVuvfIZU8SMAqVYYMoE87L4Pry3
        rl9yP0k7S1l9dZO6FjF3+PeIyFxS/DhiWTkq7hI=
X-Google-Smtp-Source: ACHHUZ4JAyMv1o9SVQRDgoi4JySBCScBr/Q5APkymzVa0NUpJJAtxMjv3fNWFkbOTqj0hnho2MU7ug==
X-Received: by 2002:a7b:cb8a:0:b0:3f4:2174:b29c with SMTP id m10-20020a7bcb8a000000b003f42174b29cmr22294428wmi.20.1684241396327;
        Tue, 16 May 2023 05:49:56 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u9-20020adfed49000000b0030647449730sm2528218wro.74.2023.05.16.05.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:49:55 -0700 (PDT)
Message-ID: <bd074e2b-9739-a5ba-d076-94a3ac04d9b2@monstr.eu>
Date:   Tue, 16 May 2023 14:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/23] arm64: zynqmp: Add pmu interrupt-affinity
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <4c6674bf7e048e7370248e50ed3d011d604d020e.1683034376.git.michal.simek@amd.com>
 <4e5fc3ff-5b70-20a9-101a-cba9d20fc961@monstr.eu>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <4e5fc3ff-5b70-20a9-101a-cba9d20fc961@monstr.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/23 13:05, Michal Simek wrote:
> 
> 
> On 5/2/23 15:35, Michal Simek wrote:
>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>
>> Explicitly specify interrupt affinity to avoid HW perfevents
>> need to guess. This avoids the following error upon linux boot:
>> armv8-pmu pmu: hw perfevents: no interrupt-affinity property,
>> guessing.
>>
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi 
>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 61c7045eb992..a117294dc890 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -161,6 +161,10 @@ pmu {
>>                    <0 144 4>,
>>                    <0 145 4>,
>>                    <0 146 4>;
>> +        interrupt-affinity = <&cpu0>,
>> +                     <&cpu1>,
>> +                     <&cpu2>,
>> +                     <&cpu3>;
>>       };
>>       psci {
> 
> Applied.
> M

Actually remove this one from my queue because there were comment from Laurent.

M



-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
