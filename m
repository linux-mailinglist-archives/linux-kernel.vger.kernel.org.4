Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855D05B9D94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIOOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIOOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:42:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60BABC5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:42:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so30663442lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WzKY19WlATzPVfjWML638L0xpeL6UYwE1yJ45I/Qe4c=;
        b=mkjXKq0L1gE6sUmU7qAI+Vol+B0XZR0g0yca2k+PFxKonmhAB+tCnq6kRTf6Q+Kfkh
         ksoCBORIf83GVqgYfnFgq1MLkIvDJOCpr/yQWXXDZOzomEsd8A5yMieujbGCTnDcg4V5
         w6kFycoisvMLh+DDuXs2j+klxB4uTEWIFyHDkFeYCb6oJ1OUS///z1EoCfLwU+xYwpdE
         woJZAi0HPvwwUwcXhybl0avMbAIPuP/K0jkZ12tnVc9rJxf4l6NozEehUlWwSSgTCQoE
         Y8JJW4YeaztMDNIplC2WS5nOQbsXV0iLUI5IQYJUwnqYhAzEzh2Mb1oNEw0F3SZPKZm7
         zyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WzKY19WlATzPVfjWML638L0xpeL6UYwE1yJ45I/Qe4c=;
        b=cr7Z7M3nAMZS77E8VKoaukcjDqeNNm0uNrWQWSX9xuSmFZT48KTnP//XJISZPp4+a5
         cFZmAl8YXzgm/X26yavOGNzv0WdaQA+lwlZlyuHiuOWfUFz0kIcRFIfQiMRyLagLJZnS
         M4Q7Qc2F9cQz/SP0tSuZSSdu2/cOin9b6ZriNOEcwqDlIAjFdcfJs5oY1fSuykUH8Itb
         nSEf16eW9V64RSlxVXLuyN51piwXpvkXOcHLJhdqJZwc792G+CG3r/kNG4qrLWcx6KA8
         M3eIKlXlyLmVFdZgIf7sdJDPlYeGb04yO4H+FrliFR9he4EOArGtBbviLmmcYmAKyRpO
         8qOg==
X-Gm-Message-State: ACrzQf0M2f36zQ6cI8bs26guJzkVc5b6Mqy64XhhCQyrVapaD7a7IkKa
        ujtHx3t/nLu7r2G7fyKQdfvJwA==
X-Google-Smtp-Source: AMsMyM6EuxVDO1/5rG6bQA27Gun6TqVZg0nEb5JNoe9sjRTnCxFH+9HkSPUtPFwrkNcWUmDbI0KX2w==
X-Received: by 2002:ac2:418a:0:b0:48b:aa2:1d9f with SMTP id z10-20020ac2418a000000b0048b0aa21d9fmr86523lfh.195.1663252967602;
        Thu, 15 Sep 2022 07:42:47 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm3173178ljg.76.2022.09.15.07.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 07:42:47 -0700 (PDT)
Message-ID: <806d5fc4-fb37-c60c-a11a-f73e5e21afb2@linaro.org>
Date:   Thu, 15 Sep 2022 17:42:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/2] crypto: intel-fcs: Add crypto service driver for
 Intel SoCFPGA
Content-Language: en-GB
To:     wen.ping.teh@intel.com
Cc:     bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, dinguyen@kernel.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org, will@kernel.org
References: <2d24ed07-5501-5ee9-e2a9-34ef15216e28@linaro.org>
 <20220915135219.670329-1-wen.ping.teh@intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220915135219.670329-1-wen.ping.teh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 16:52, wen.ping.teh@intel.com wrote:
> From: wen.ping.teh@intel.com
> 
>> From: Dmitry Baryshkov @ 2022-09-15 11:46 UTC (permalink / raw)
>>> From: wen.ping.teh@intel.com
>>>
>>>> This patch introduces a crypto service driver for Intel SoCFPGA
>>>> family. The FPGA Crypto Service (FCS) includes a large set of security
>>>> features that are provided by the Secure Device Manager(SDM) in FPGA.
>>>> The driver provide IOCTL interface for user to call the crypto services
>>>> and send them to SDM's mailbox.
>>>>
>>>> Teh Wen Ping (2):
>>>>    crypto: intel-fcs: crypto service driver for Intel SoCFPGA family
>>>>    arm64: defconfig: add CRYPTO_DEV_INTEL_FCS
>>> Hi,
>>>
>>> I just found out that there was a previous attempt to upstream this driver
>>> 2 years ago. It was NACK because it did not implement crypto API. Please
>>> drop this review.
>>> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg44701.html
>>>
>>> I will move this driver to drivers/misc.
>>
>> I think the proper solution would be to implement the existing API first
>> rather than adding a set of custom proprietary IOCTLs that nobody else
>> is going to use.
> 
> Could you explain what are the existing API that you are referring?
> The FCS driver doesn't have API. Instead it uses IOCTLs to interact with user-space application to perform Intel SoCFPGA crypto features.

The FCS driver doesn't. But Linux does.

For the hw random generators we have the struct hwrng/devm_hwrng_register().

For AES, EC, etc. there are corresponding Crypto API. Based on your 
patches I couldn't guess if your hardware is more of a TPM or a generic 
crypto "accelerator". However Linux has support for both kinds of 
hardware. Most likely the right interface is already there (or almost 
there). In 90% of cases 'a custom bunch of IOCTLs' is not a correct one.

-- 
With best wishes
Dmitry

