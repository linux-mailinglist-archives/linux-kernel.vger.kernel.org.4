Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF860E71F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJZSXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiJZSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:23:16 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2BBD57F9;
        Wed, 26 Oct 2022 11:23:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j6so7824920qvn.12;
        Wed, 26 Oct 2022 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tg+9/4eCkiPnCycaFmooFOheaPBBecDg4xw3IxvGrY8=;
        b=ejQEDS8BuqARAzYv3Xubkx7aSNMxMJg9UyPT9PAn+yrjhbIwJ1iuY6J0xJzdWdqB3r
         rvXDTbSTArKUm7hGivw6XEe8hvjFMYPN9e3ZG/7evEZTaH0BfpBC159AX2XXLBnRwZdi
         HRq420vW/DSc/WCn1CjAunYphWghDdCyj1Fc3FljER37m1HvU5L0A2IBdUFUEuXfEeCx
         anPhOcc//RDoWp+ialFp2lp8h2VBNiNmu+IrTIKkcE6ct/PbqqI9W87+ik0vUC3GZ/Bd
         Z3POlQzZWPV2h0FUqNaxLnE1eE+S6OsvWSQYIAi8TaCqEa7OlJH5/nSfGwyiaujukhZO
         vFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg+9/4eCkiPnCycaFmooFOheaPBBecDg4xw3IxvGrY8=;
        b=MjXPR7SPkptclB96NKBInSItM3afhhotGjHMY7lvjsV4czMQwdHPSaphP+NUYRA1Sx
         sd4lmM6CpN6QrdxiD0UiwXQBQJfro6rFDCnEhQ457u9fQXIhkdtvTImcz+p02w+490i/
         gGZixqcEJMD8P+t5F7ve1i1zKBoXRedSzT3FyY6t/pvQ5Ef8TcfK/1DY+ItMSG1pGRdB
         Bxsweg8aJEUYe1D2tyajIZMANai2KXZRxTz5tKkgnqAWPfJd1vd3D5NfbfxCxZWItMra
         27R3+m7pR0y8ZwZo1TFs+ftlW6x77Wfs1dR3zsYXTjolD6bwlNUTLG2aWXS7AMCkSKqo
         7srw==
X-Gm-Message-State: ACrzQf0LReKlAlEO+X64Pd0VfZWTaqrBicPOeX9WBYn8hcepfFKsv+GA
        Q5yG9eWxELO7JV9CieoEVQ0TwV6bcItCCg==
X-Google-Smtp-Source: AMsMyM5OjuJW0rwmarqJHZHRPNNT4+PhxtKPG3yGVNuHc1WPUKJ9jBmSSNSiXwDtiyZH6i65FQbK4A==
X-Received: by 2002:a05:6214:2306:b0:473:f77a:85a7 with SMTP id gc6-20020a056214230600b00473f77a85a7mr37185205qvb.106.1666808594005;
        Wed, 26 Oct 2022 11:23:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05620a0f0e00b006cfc1d827cbsm4429353qkl.9.2022.10.26.11.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 11:23:13 -0700 (PDT)
Message-ID: <d5a6cd9f-4f1e-5d54-ebd4-e48f73268153@gmail.com>
Date:   Wed, 26 Oct 2022 11:23:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
 <Y1hY57vkkOhybwE1@google.com>
 <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
 <Y1higmSUMLsxvXyq@google.com>
 <7db0a98e-36c8-afee-5b0d-16b836ac8de0@intel.com>
 <Y1l5/U3WnbDIIMOj@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y1l5/U3WnbDIIMOj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 11:18, Brian Norris wrote:
> Hi Adrian,
> 
> On Wed, Oct 26, 2022 at 08:36:48AM +0300, Adrian Hunter wrote:
>> On 26/10/22 01:26, Brian Norris wrote:
>>> On Tue, Oct 25, 2022 at 02:53:46PM -0700, Florian Fainelli wrote:
>>>> On 10/25/22 14:45, Brian Norris wrote:
>>>>> On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
>>>>>> On 24/10/22 20:55, Brian Norris wrote:
>>>>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>>>>> index 8f1023480e12..6a282c7a221e 100644
>>>>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>>>
>>>>>>> @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
>>>>>>>    	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>>>    	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>>>>> -	sdhci_reset(host, mask);
>>>>>>> +	sdhci_and_cqhci_reset(host, mask);
>>>>>>>    	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
>>>>>>>    		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>>>>
>>>>>> What about sdhci_reset in sdhci_am654_ops ?
>>>>>
>>>>> Oops, I think you caught a big fallacy in some of my patches: I assumed
>>>>> there was a single reset() implementation in a given driver (an unwise
>>>>> assumption, I realize). I see at least sdhci-brcmstb.c also has several
>>>>> variant ops that call sdhci_reset(), and I should probably convert them
>>>>> too.
>>
>> I checked and found only sdhci_am654_ops
> 
> And...how about sdhci_j721e_8bit_ops in that same driver?
> 
>>>> You got it right for sdhci-brcmstb.c because "supports-cqe" which gates the
>>>> enabling of CQE can only be found with the "brcm,bcm7216-sdhci" compatible
>>>> which implies using brcmstb_reset().
>>>
>>> I don't see any in-tree device trees for these chips (which is OK), and
>>> that's not what the Documentation/ says, and AFAICT nothing in the
>>> driver is limiting other variants from specifying the "supports-cqe"
>>> flag in their (out-of-tree) device tree. The closest thing I see is that
>>> an *example* in brcm,sdhci-brcmstb.yaml shows "supports-cqe" only on
>>> brcm,bcm7216-sdhci -- but an example is not a binding agreement. Am I
>>> missing something?
>>
>> It was mentioned in the patch from the Fixes tag.
> 
> OK, good note. If I don't patch the other seemingly-unaffected variants
> in brcmstb, I'll at least update the commit message, since the code
> doesn't tell me they're unaffected.

You can mention in the commit message that they are unaffected and quote 
me on that if you feel like this needs to be explicitly said.
-- 
Florian

