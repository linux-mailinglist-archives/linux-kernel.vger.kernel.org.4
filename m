Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0324A648982
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLIUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLIUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:22:42 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982EDF30
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 12:22:41 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i25so467272ila.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 12:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VCJPVUZ229VvXZG5wipT/tFOqRMGUxG79Y/d7XX9HM=;
        b=Pfmwrwpae+fZaGlILeNFUaIoYSBOcivcDsDgcWEr2kPvYQwhfuFCFOPQHkF1i57cuy
         ma6SHSiLL5TW//coHBlwCKRfOkI991QkAkeoCPcBgf2ylZZqjv9c13DbIpa80vrm1atb
         Tq+IoF4nJpJG1ruBIE/4orsDLaYGqpqraP2wWSPSZz+XUpS5eVKaNPj/0Y7IZp6/RAID
         shwZ9nP8Syw9N90PnyvLq12sYchx635S7YXS/omNUYqYSljx2ItSnNCRObTuEMO/B8xw
         bhQ4tIIIdM3LWw7Zcodgv8mRr1BZXEt5YD3iDdozoaAjE8lvzL9eJRUcxW361tF/H/lX
         H11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VCJPVUZ229VvXZG5wipT/tFOqRMGUxG79Y/d7XX9HM=;
        b=DNDzA8Mbl6WYRyaoBqS9T8HITd9ixHCbVqJ5BGQ7b+35PRUKR25YIZS+OBDnUh0rOS
         TRGttv826yYWVdHoYJ7Oxf/R+sq+gPw7YoOqIo8MG8FmsCL102SyC5Un8Wz2PK79NnR2
         8xj61bvqBG6amcmAOWyathwsITHtCyiBBuKYk7f7s6wxjvkukgF3sFWvQkhMpyOnvY7n
         urZeB+R83qOE/rJWiVYpHyz5J+9mm82EJiGRRNkKbFbrEXraslHnfucjgku69aUt0Tev
         qzMvhz6sWwskMn+L1ovKLRVl59nnMGAk/K+/SoFUoYTmHreW+rFfizCcWVmOsalKwBXm
         AEQw==
X-Gm-Message-State: ANoB5pm8ScG99o97LtGdfp8Gyk0+emCeeM9WqHjnMS2zKZSDfSyq0N5e
        LsH+sBA8dTPgWLcMxAStnEPe6A==
X-Google-Smtp-Source: AA0mqf4YQB2PfPKgPfJ4UqAF0ol8toR/N7+zMhZkZRuFqZ1iKgHMCBx0XJMb7Nfd8oEJ1vhEM2p2Lg==
X-Received: by 2002:a05:6e02:78e:b0:303:52d5:fefe with SMTP id q14-20020a056e02078e00b0030352d5fefemr4012562ils.31.1670617360670;
        Fri, 09 Dec 2022 12:22:40 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id x16-20020a0566380cb000b00389e1142967sm753934jad.57.2022.12.09.12.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 12:22:40 -0800 (PST)
Message-ID: <fa6d342e-0cfe-b870-b044-b0af476e3905@linaro.org>
Date:   Fri, 9 Dec 2022 14:22:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH net-next 2/2] net: ipa: add IPA v4.7 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alex Elder <elder@linaro.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     andersson@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20221208211529.757669-1-elder@linaro.org>
 <20221208211529.757669-3-elder@linaro.org>
 <47b2fb29-1c2e-db6e-b14f-6dfe90341825@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <47b2fb29-1c2e-db6e-b14f-6dfe90341825@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 3:22 PM, Konrad Dybcio wrote:
> 
> 
> On 8.12.2022 22:15, Alex Elder wrote:
>> Add the necessary register and data definitions needed for IPA v4.7,
>> which is found on the SM6350 SoC.
>>
>> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
> [...]
>> +
>> +/* Memory configuration data for an SoC having IPA v4.7 */
>> +static const struct ipa_mem_data ipa_mem_data = {
>> +	.local_count	= ARRAY_SIZE(ipa_mem_local_data),
>> +	.local		= ipa_mem_local_data,
>> +	.imem_addr	= 0x146a9000,
>> +	.imem_size	= 0x00002000,
> Should probably be
> 
> 0x146a8000
> 0x00003000
> 
> with an appropriate change in dt to reserve that region.
> 
> Qualcomm does:
> ipa@... { qcom,additional-mapping = <0x146a8000 0x146a8000 0x2000>; };
> 
> which covers 0x146a8000-0x146a9fff
> 
> plus
> 
> imem@.. { reg = <0x146aa000 0x1000>; };
> 
> which in total gives us 0x146a8000-0x146aafff

Can you tell me where you found this information?

> That would also mean all of your writes are kind of skewed, unless
> you already applied some offsets to them.

This region is used by the modem, but must be set up
by the AP.

> (IMEM on 6350 starts at 0x14680000 and is 0x2e000 long, as per
> the bootloader memory map)

On SM7250 (sorry, I don't know about 7225, or 6350 for that matter),
the IMEM starts at 0x14680000 and has length 0x2c000.  However that
memory is used by multiple entities.  The portion set aside for IPA
starts at 0x146a9000 and has size 0x2000.

					-Alex

> Konrad

