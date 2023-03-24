Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CDC6C7A80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjCXI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjCXI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:56:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902C2798B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:56:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so4901923edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679648177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Um8TbgrwhTbkEwzBW9OgNTPHsSW0JHe7bi80kPf/8AM=;
        b=tv9rIy9Uxu3qQtgXFh+rGg9UcyLX/MSBomBeUuea9AyNItUKVcnbXFLlYIaTPV0LDB
         CQQugLqK7FP4jB7h+4rmxx5LAtCnyIpxToRHnyTKgJOrQW4OUHW9a4q5nQ2JdfnTYBJb
         EsLCIF1w/ZBjnQD3Du69SsSYV2vCMp9LIUEiy2nHce7dBotl/YoYpxCrbQEp7fMwi4mO
         cjS9PD/yx1wDYidaGNYm0jfQHbOQ224kh+Pdm08SgNvQEeXq/yIQndaa9wJ8wvmLshGf
         TSYFnFj5kEUJUR55YMQ84OTOhr5K8XYpjB0mNaoGBOpcdsM/yXBnTxzDlByaF7Ju1pAS
         Oeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679648177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um8TbgrwhTbkEwzBW9OgNTPHsSW0JHe7bi80kPf/8AM=;
        b=cikqIVMS2OxN83dJ5IzxzHwrPedn22HJWDmpx56Wh4SbuspdfdW5HBZ00sEyP/Kegf
         Q0jCV3BmFNFOS3KOYFNB0942Jeh0H6jI9CtvF+ieN0jROaCyyoQ1l4CTCwgBrz0k3vP+
         iquOTAMzZoINX1JW9bQDWlxYpE+hJHvK88LfLKDnhsT28ibydGqciCkhtOxih/7kCewU
         UcaJ4U9y0VLWhuejKhoQSy06zHJCNUyClwh3ALPt/9YDRYpJ995ev9EDYAuNqhrxk/WP
         MSbE/obqJgy3Wb0GdJS0O2ZCOy4eYxenEWfdIE2bSokVyNu0LrNBCVBgP2YMKdnj38zs
         7K3g==
X-Gm-Message-State: AAQBX9fQ0Pord1vfrOEFhfS4vViA9xkbZoaXGVDY9lx7lUXBmKkymSD/
        3AmbrERrVeoRudvVqfA4igqjDw==
X-Google-Smtp-Source: AKy350Z722g5hPv9Mo9UlX7Q2mEg4+ITEw0ynPSM2C2jUm30y/pXKOFomdKzmH7x/14WP6tJRKidxg==
X-Received: by 2002:a17:906:3607:b0:92d:44ca:1137 with SMTP id q7-20020a170906360700b0092d44ca1137mr2162491ejb.43.1679648176715;
        Fri, 24 Mar 2023 01:56:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ce50:243f:54cc:5373? ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id wy8-20020a170906fe0800b0093e261cc8bcsm612167ejb.58.2023.03.24.01.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 01:56:16 -0700 (PDT)
Message-ID: <58316fc3-1ee1-b530-e783-ccd8225e07d6@linaro.org>
Date:   Fri, 24 Mar 2023 09:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V1 3/4] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <3f385562845ae26d519940ca8098fde89282991b.1679403696.git.quic_schowdhu@quicinc.com>
 <611ea918-64a6-f306-b5ec-db55e41abda2@linaro.org>
 <321005fc-1bfd-c04d-b2b5-d85d213ac00a@quicinc.com>
 <7b939818-993a-e849-e7e0-ae9ea74ea52b@linaro.org>
 <5c4df95e-fb44-e873-7ecc-dec381a42aff@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5c4df95e-fb44-e873-7ecc-dec381a42aff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 14:45, Souradeep Chowdhury wrote:
> 
> 
> On 3/22/2023 8:23 PM, Krzysztof Kozlowski wrote:
>> On 22/03/2023 14:54, Souradeep Chowdhury wrote:
>>>
>>>
>>> On 3/21/2023 11:07 PM, Krzysztof Kozlowski wrote:
>>>> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>>>>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>>>>> stats, like the time when the bootloader started execution and at what
>>>>> point the bootloader handed over control to the kernel etc. in the IMEM
>>>>> region. This information is captured in a specific format by this driver
>>>>> by mapping a structure to the IMEM memory region and then accessing the
>>>>> members of the structure to print the information. This information is
>>>>> useful in verifying if the existing boot KPIs have regre
>>>>
>>>>
>>>>> +/**
>>>>> + *  struct boot_stats - timestamp information related to boot stats
>>>>> + *  @bootloader_start:	Time for the starting point of the abl bootloader
>>>>> + *  @bootloader_end:	Time when the kernel starts loading from abl bootloader
>>>>> + */
>>>>> +struct boot_stats {
>>>>> +	u32 bootloader_start;
>>>>> +	u32 bootloader_end;
>>>>> +} __packed;
>>>>> +
>>>>> +static struct boot_stats __iomem *boot_stats;
>>>>> +static void __iomem *mpm_counter_base;
>>>>> +static u32 mpm_counter_freq;
>>>>
>>>> No file-scope variables. Does not scale, not easy for review and
>>>> maintenance. Avoid such code.
>>>
>>> Ack
>>>>
>>>>> +
>>>>> +static int mpm_parse_dt(void)
>>>>> +{
>>>>> +	struct device_node *np_imem, *np_mpm2;
>>>>> +
>>>>> +	np_imem = of_find_compatible_node(NULL, NULL,
>>>>> +					  "qcom,imem-boot_stats");
>>>>> +	if (!np_imem) {
>>>>> +		pr_err("can't find qcom,imem node\n");
>>>>
>>>> So you are printing errors everywhere, on every soc and with compile
>>>> test on every platform there is in the world... sorry, it does not work
>>>> like that.
>>>
>>> Ack
>>>>
>>>>> +		return -ENODEV;
>>>>> +	}
>>>>> +	boot_stats = of_iomap(np_imem, 0);
>>>>> +	if (!boot_stats) {
>>>>> +		pr_err("boot_stats: Can't map imem\n");
>>>>> +		goto err1;
>>>>> +	}
>>>>
>>>>
>>>>> +
>>>>> +static void __exit boot_stats_exit(void)
>>>>> +{
>>>>> +}
>>>>> +module_exit(boot_stats_exit)
>>>>
>>>>
>>>> I don't think this is some special code which deserves init calls. Make
>>>> it module_platform_driver().
>>>
>>> Since this just reads some values from the Imem region and prints it to
>>> the user and doesn't have a specific device associated with it, a
>>
>> Which is not really an argument for such antipattern, but okay...
>>
>>> generic module code is written for it and not a module_platform_driver().
>>
>> ... so how do you handle deferred probe?
> 
> This has no dependency on other resources except that it parses some 
> information from DT nodes, so deferred probe handling is not needed
> in this case.

Yes, I know, but if we would ever add it how this driver can handle it?
This is antipattern.

Best regards,
Krzysztof

