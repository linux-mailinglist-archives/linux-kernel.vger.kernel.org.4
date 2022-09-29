Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271E5EEFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiI2H4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiI2H4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:56:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985312E43F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:56:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z4so1059082lft.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5I0KFer6CMq9bS+qb57rtF7Jxe3pkwXN2psBdqfUQXI=;
        b=Ck6MPZt5fmCodIEyDLh6E41lYpwwhdGCmZyvW+lbk2zOEhdtQQncjNQxhIZmAQ0qjG
         TeUEaPob21B1EMB28Uh742fObyVjUHI7G8/goo6JIe6jQFrLj493AJTbV6r8KQfjRpbw
         q4/SpWuUHNMw/PNhjUIORx+/r1CG2oxz3d43fivIIhQLoEYwPpy3hOZTXvvhM2ebtG8P
         j+GAvQBoQwLYtff6fXJdKrlX2JBFTOJ+CIugNaUl9z7KdAlX6gDFDgrZPWZmcSZJfTrq
         N4LP+qotWxPz4A5iZeVZ0WrP7jo1nSQ9Fmh4/ATIzgnuixkHnRMeZ126/dDY/HBhfffQ
         qG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5I0KFer6CMq9bS+qb57rtF7Jxe3pkwXN2psBdqfUQXI=;
        b=YR7OcooqCtB22EuC4HNSy+E3ClqRjH/0SroDhwy5m4I8mU6nF8mgY9TvGO9c4GhYvr
         Akqf+/QS/x4050l8tun9a9e0h/LaKszh+6VdkvN2Xdip6WizS7PdGX+iGHWTi2TNhKFr
         t8K50W6oMAYGCZU0thOAkLQf2Q61vtSSLmhzTbJTL4BFO/c95GGpJrKvZTIABdFYmHq2
         gyECDy/CDEie8i+x11YntHmZHf96MSzg7qDXFJvMT7ijLzWoge1Ie+6UgqtqZ5lpqAVt
         Jm8OZ9ReW8U1zbJHZnoXVg3CNJn6bFMusIFFeS3txYqe3OMi/GarMBvZjBr1+ti4lC1M
         9mag==
X-Gm-Message-State: ACrzQf1skCdOVCaqgg36ry2FDJXQQL9TDg+xwBN2CaiGkK9j/Zq7ZE56
        X40LuJdLkYpVjZqgzf+Q07edY21p3oLtwQ==
X-Google-Smtp-Source: AMsMyM4ESrsuCcFeLMKwFM4lzuOI4iKNeMYoJjszgvxbAOlpQrqJOj4oMRQ2+lGzJESEEKyHlT8fJQ==
X-Received: by 2002:a05:6512:31cb:b0:49f:c2dc:9986 with SMTP id j11-20020a05651231cb00b0049fc2dc9986mr812354lfe.549.1664438172091;
        Thu, 29 Sep 2022 00:56:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id cf33-20020a056512282100b00498fbec3f8asm707549lfb.129.2022.09.29.00.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:56:11 -0700 (PDT)
Message-ID: <e516bd2e-baf8-7ecd-cc59-9e7c2af64918@linaro.org>
Date:   Thu, 29 Sep 2022 10:56:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-7-johan+linaro@kernel.org>
 <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
 <f9d0fb60-3e62-8f55-015e-88ca2e209323@linaro.org>
 <YzVFQikkJmTDlg4U@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YzVFQikkJmTDlg4U@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 10:12, Johan Hovold wrote:
> On Wed, Sep 28, 2022 at 10:48:40PM +0300, Dmitry Baryshkov wrote:
>> On 28/09/2022 22:10, Dmitry Baryshkov wrote:
>>> On 28/09/2022 18:28, Johan Hovold wrote:
>>>> Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
>>>> PHY is powered on before configuring the registers and only the MSM8996
>>>> PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
>>>> initialisation table, may possibly require a second update afterwards.
>>>>
>>>> To make things worse, the POWER_DOWN_CONTROL register lies at a
>>>> different offset on more recent SoCs so that the second update, which
>>>> still used a hard-coded offset, would write to an unrelated register
>>>> (e.g. a revision-id register on SC8280XP).
>>>>
>>>> As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
>>>> the bogus register update.
>>>>
>>>> Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for
>>>> sm8150 USB") added support
>>>
>>> I'm not sure about the particular fixes tag. Backporting from the split
>>> driver into old qmp driver would be a complete pain.
>>>
>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> After digging some more, I stumbled upon the commit 0d58280cf1e6 ("phy:
>> Update PHY power control sequence"), which puts explicit register write
>> here, telling that 'PCIe PHYs need an extra power control before
>> deasserts reset state'.
> 
> That's the commit I'm referring to above.
> 
>> I can confirm this with the register tables from downstream dtsi. E.g.
>> consider sdm845-pcie.dts, pcie0 table. The PCS_POWER_DOWN_CONTROL is the
>> register 0x804.
>>
>> The programmings starts with <0x804 0x1 0x0>, writing 1 to
>> PCS_POWER_DOWN_CONTROL (which if I'm not mistaken we do not do at this
>> moment). Then after writing all the serdes/tx/rx/pcs/pcs_misc tables
>> comes the write <0x804 0x3 0x0> (which you are trying to remove here).
> 
> The PHY would already have been powered on with the mainline driver, that
> write has already happened.
> 
> Whether or not PCIe support for SDM845 has been broken since it was
> first mainlined almost three years ago is a separate issue. I assume
> Bjorn tested it before sending it upstream.
> 
> 	421c9a0e9731 ("phy: qcom: qmp: Add SDM845 PCIe QMP PHY support")

On SDM845 PCIe0 is used for the WiFi, e.g. on the RB3 (dragonboard845) 
device. The PHY definitely works with the upstream kernels.

> 
>> Same sequence applies to the PCIe PHY on msm8998.
>>
>> Most newer PHYs have the expected sequence (of writing 0x3 to
>> PCS_POWER_DOWN_CONTROL) before writing all registers.
>>
>> As a short summary: unless we get any additional information that 8998
>> and sdm845 tables are incorrect, I'd suggest adding a conditional here
>> (ugh) and using it here and in qmp_pcie_init() call.
> 
> I see little point in doing that unless you dig out an SDM845, confirm
> that it has never worked with upstream, and update the init sequence
> first.

Digging out an sdm845 is not a problem per se. It works, but it also has 
an additional regwrite that this patch tries to remove. I will try 
checking whether it works with this register write being removed or not.

> 
>> Vinod, Bjorn, do you have any additional info?
> 
> An explanation of the split POWER_DOWN_CONTROL updates on MSM8996 would
> be good to have either way

-- 
With best wishes
Dmitry

