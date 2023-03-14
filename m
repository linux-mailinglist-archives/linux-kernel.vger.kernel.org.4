Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD586B8F16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCNJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCNJ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:59:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0B2A6C6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:59:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r27so19202261lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678787983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbQPUzNB3ID6pvgwQJH+wME6Ds92/P9woaOtkl2i5u8=;
        b=GqKgGJ20kMDb5o3ZhnHFpC4sl0f61CUq2USW5m3TGTowgmFFbRGSV+Gifp9aBt3nQe
         A490DTAu1kS58JZNJT+zUCcPJCInhpXydDUuim6rOyLmDmt+QgTdtzFTCJpLQCsZ/P9S
         u4JA/MOpMMrJhCbqIypD5LmoJZgnSDXhgXRR5D1m0nLVp4gNHiOoEzzRib9+pdaTmt3p
         piyKQtALFE1HmJbCq1MvvHYXOZbaa+SWjNAonr96szUrHYUcgF2TI6PvbhcRZEvCaFNo
         gb4zE6aGs9Wz/bnE6sg1WuG7FfGcQvdnaIZO27jZ90yf8Tv/EVFXzhR/MfN+8YiGvFx7
         Pn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678787983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbQPUzNB3ID6pvgwQJH+wME6Ds92/P9woaOtkl2i5u8=;
        b=MfObQv6EwAO7DbpwiUqTk8jWMIJIOJ/YWwTkSDony0vH+TvfkS9BECh1qq9cqlpwQj
         tSruM8Z3B0aR4sIy0zB9OrI3Kh6cFkJleEmiWa+5oMGtSCMcErilZvzZYIWIiRRTIN+y
         Fv0mTEnYWscg0ROeM6zlb4k1J5tHsaAczNs2fjflbAf6GvEHtvnfm7piSmTTKhkFaNH7
         Qt/x6M7E3Yrg2ocyg0ZQj9yHhJzBS1MyJpj0koNABt8bNmvnS5RB3KCuLo9vehIRU0XN
         EWvcwN3kBWGrmHz05N10d/qnLa4YK5eO9gE4Graw2TS4U79VwKgar3sPal+KQ6fe3V8C
         Nyuw==
X-Gm-Message-State: AO0yUKWkGzgJbCoyiLeCLy/qy0cGXGibnmw22/x39TOgBHCqvhLU3AKw
        Z1PjtJs/qBYB76JNOSL3wvKgdBeR8GK7Bi+yS5I=
X-Google-Smtp-Source: AK7set9J0jfti/lMPhcprp1dbInMOH8UTlXpjIv9GivdjQJIaKApf44OJfQEjPvxSP5uynMa96SaWQ==
X-Received: by 2002:a19:740a:0:b0:4cb:2aa:9e58 with SMTP id v10-20020a19740a000000b004cb02aa9e58mr569835lfe.13.1678787983651;
        Tue, 14 Mar 2023 02:59:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id l13-20020ac2430d000000b004e83fedf354sm332043lfh.122.2023.03.14.02.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 02:59:43 -0700 (PDT)
Message-ID: <efff0988-869b-7ee8-17ea-4b82f6a5205a@linaro.org>
Date:   Tue, 14 Mar 2023 10:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
To:     Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230309233945.1199358-1-echanude@redhat.com>
 <43c11038-91d5-cbfd-7349-06fcd61a0661@linaro.org>
 <1bd61fa7-cd0e-e198-9cee-7485eacbe685@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1bd61fa7-cd0e-e198-9cee-7485eacbe685@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 05:48, Prasad Sodagudi wrote:
> 
> 
> On 3/9/2023 3:47 PM, Konrad Dybcio wrote:
>>
>>
>> On 10.03.2023 00:39, Eric Chanudet wrote:
>>> ABL uses the __symbols__ section to process the DTB before passing it
>>> forward. Without it, the bootstrap is interrupted.
>>>
>>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>>> ---
>> Fix your ABL.
> Hi Konrad,
> 
> Apps boot-loader need __symbols__ for dynamic overlay operation. Qualcomm firmware passes an overlay file to apps boot-loader to overlay some of the nodes based on firmware configuration. Without __symbols__ apps boot-loader is not able to overlay.
Yes/no. There are a plenty of libfdt functions that let you do that,
especially if you know something about the node.

> 
> Qualcomm hypervisor/gunyah would like to overlay arch timer node with always-on property, So adding __symbols__ helps boot-loader to overlay.
For the arch timer, you can simply iterate over the top-level nodes (or
in the worst case scenario, over all nodes which would not take very
long on cortex-a / cortex-x cores) and look for the specific timer
compatible that has been with us for like 10 years at this point and
use libfdt's fdt_add_property without overlays.

> 
> I think, commit text is misleading here and I will request Eric to fix the commit text.
Sort of, but then the design you explained is very error-prone as it's
dependent on the device tree always satisfying your hypervisor's needs.

Konrad
> 
> -Thanks, Prasad
> 
>>
>> Konrad
>>> Depends on initial sa8775p-ride.dts:
>>> https://lore.kernel.org/all/20230214092713.211054-3-brgl@bgdev.pl/
>>>
>>>   arch/arm64/boot/dts/qcom/Makefile | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index b63cd1861e68..72e85ab31d74 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -1,4 +1,8 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +
>>> +# Enable support for device-tree overlays required on sa8775p-ride.
>>> +DTC_FLAGS_sa8775p-ride := -@
>>> +
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8016-sbc.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8094-sony-xperia-kitakami-karin_windy.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8096-db820c.dtb
>>
>>
