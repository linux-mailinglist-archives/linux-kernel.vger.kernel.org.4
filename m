Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FC5EE603
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiI1Tst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiI1Tso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:48:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958077AC38
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:48:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i26so21903884lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XZ2C8PFfFGZso1Vlxd/6CVlqAXMIAAgQjF1Biv8y1Og=;
        b=oCTGbIFkQYEci/Hbrd+xQ2vUzu1JTp4bVF0X114/0S8uFUFyZ3oPjwFO5UCnnYpzCf
         aTd0405dOaHXJb7smPuSto6XHWEHX8gG8L1nIBWyRr5k6bF6IMHHgNsTklxaAHwyBHWf
         v7Ph2+oE1wSbZ9zKE/YGhty3gzsBDLGLsVQFl/ytM3utLvNNseVAPrK2a3qfy7LQdNGy
         wpu7QCR2VSsgMU+FVCOJyoga4qlSyxao/0OQSC6tTszGEZwHTuDDa6uHREbfBxhPRrfP
         sRtMRKTiyv/6rUDU1GYQytaUGQoOV5ypAYLH5kb6H2bnBe2zXGGoTjJ2J3AzWvvyOUiP
         LFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XZ2C8PFfFGZso1Vlxd/6CVlqAXMIAAgQjF1Biv8y1Og=;
        b=d7tazWwBGyXIpTSJK7031G2pH0A8DOK09mjmLX3Ch1kmqTqH2+irAx+YYanMwk8lAO
         e2YfA/Zq3/octx5s68FYXL5aOKGOCMVfQlZ24cdU2ih1HwqcZzL61Z089f7iERbwU+lq
         WMeWofq4YWqgNdIfbIRP9LHzIL8/+88DGFGmV3EXOUJCw1xHrorHaJF6who2JaSDKk43
         /qarQaEXnFtiQxIG2MhOvocX021EnMjSV3Z2dkNN1TPED9Wciu6zWkiAh0/OsoY/7Ddo
         SuVmL6FvhAsMRS7t0ZfAH8ZLpdGiMrgJU+EkNQWvtJsGocsCkTItrZS79qGN59Y83ELj
         ZMpw==
X-Gm-Message-State: ACrzQf27brz/dBAZIY0Qyji0+OOJKvZVTOZQW0IvuGTQ4cpbePkFjQSW
        OeUeX0UEZYDt33tcZGcZSJg4wA==
X-Google-Smtp-Source: AMsMyM5XvHWk0KfJlDfwWXBgryoUNqTHEfxcLsVWW9BozcMHMnmLr5A58Hhz+IkNmELGPVFaP9fDzg==
X-Received: by 2002:a05:6512:3f97:b0:4a1:f6b9:5198 with SMTP id x23-20020a0565123f9700b004a1f6b95198mr2368963lfa.588.1664394521910;
        Wed, 28 Sep 2022 12:48:41 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g19-20020ac25393000000b0049482adb3basm558108lfh.63.2022.09.28.12.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:48:41 -0700 (PDT)
Message-ID: <f9d0fb60-3e62-8f55-015e-88ca2e209323@linaro.org>
Date:   Wed, 28 Sep 2022 22:48:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-7-johan+linaro@kernel.org>
 <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
In-Reply-To: <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 22:10, Dmitry Baryshkov wrote:
> On 28/09/2022 18:28, Johan Hovold wrote:
>> Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
>> PHY is powered on before configuring the registers and only the MSM8996
>> PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
>> initialisation table, may possibly require a second update afterwards.
>>
>> To make things worse, the POWER_DOWN_CONTROL register lies at a
>> different offset on more recent SoCs so that the second update, which
>> still used a hard-coded offset, would write to an unrelated register
>> (e.g. a revision-id register on SC8280XP).
>>
>> As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
>> the bogus register update.
>>
>> Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for 
>> sm8150 USB") added support
> 
> I'm not sure about the particular fixes tag. Backporting from the split 
> driver into old qmp driver would be a complete pain.
> 
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

After digging some more, I stumbled upon the commit 0d58280cf1e6 ("phy: 
Update PHY power control sequence"), which puts explicit register write 
here, telling that 'PCIe PHYs need an extra power control before 
deasserts reset state'.

I can confirm this with the register tables from downstream dtsi. E.g. 
consider sdm845-pcie.dts, pcie0 table. The PCS_POWER_DOWN_CONTROL is the 
register 0x804.

The programmings starts with <0x804 0x1 0x0>, writing 1 to 
PCS_POWER_DOWN_CONTROL (which if I'm not mistaken we do not do at this 
moment). Then after writing all the serdes/tx/rx/pcs/pcs_misc tables 
comes the write <0x804 0x3 0x0> (which you are trying to remove here).

Same sequence applies to the PCIe PHY on msm8998.

Most newer PHYs have the expected sequence (of writing 0x3 to 
PCS_POWER_DOWN_CONTROL) before writing all registers.

As a short summary: unless we get any additional information that 8998 
and sdm845 tables are incorrect, I'd suggest adding a conditional here 
(ugh) and using it here and in qmp_pcie_init() call.

Vinod, Bjorn, do you have any additional info?

> 
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c 
>> b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 4146545fdf5f..eea66c24cf7e 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -1953,12 +1953,6 @@ static int qmp_pcie_power_on(struct phy *phy)
>>       qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl, 
>> cfg->pcs_misc_tbl_num);
>>       qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec, 
>> cfg->pcs_misc_tbl_num_sec);
>> -    /*
>> -     * Pull out PHY from POWER DOWN state.
>> -     * This is active low enable signal to power-down PHY.
>> -     */
>> -    qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>> -
>>       if (cfg->has_pwrdn_delay)
>>           usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
> 

-- 
With best wishes
Dmitry

