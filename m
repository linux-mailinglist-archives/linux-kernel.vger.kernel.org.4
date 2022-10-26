Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD70F60E5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiJZQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiJZQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:45:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54362A729
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:45:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b1so29826350lfs.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7iGH0jCRRF8jnKlYa8LooBNl7HXW3ndfP8Ygj8/9LU=;
        b=f8mLasIcQlGNu1JsI61aP8xAvJi/H4LSgM4xG4q7FmrSVnWvTcFJ17XxWsMT2aK7r+
         aFImRGqQi2XxCoB3pDtjZoEDXsSl1DBTTxSDfbzac5gyRQTitDY/2c45efNGdNm39FcH
         fUCDrxn83Xnp2fRjAuw4XDUCscF3tLRxaNjkyXqncjtu/JFirqiFUCspnJgD/yAUHs3p
         jU57MoaocCyU7mgNtwIDfHYkjkngRRs5AQm3aPtKIatiiOqaCJFiCAh7qIsvNIcgwYzh
         OnlK2TXdCeJU+3UiMR6bOX63Hs63z6z5T74Okeh0QJ4EcjiRlSsVk2ctkqsdjOK2YfZw
         Ut/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7iGH0jCRRF8jnKlYa8LooBNl7HXW3ndfP8Ygj8/9LU=;
        b=taRz96ezJUyXbMYn/CiI+esC+8LhtDHCtddFsXlnc8VNk2GpVBpb4WYIWwxLVn+QT5
         JIxwTQR0lnmkcs7UTVTozkFWQH3XIGeTjsUN58hLWQ2r5NHllZU2DdUxyzDIp1/Cf/H2
         q2TWgavJjol59c0VfruhCZqp8N8Vql59SvuLANes3SJK3Nn6hYNQ3h+L3YQRtDpFnV8n
         VHL6uTbHDvvVoF+SK/Y9fCXHlI2Tdk9JPt0tE41nAjQVYcN7cKmXs5n20W1EQtGogWDC
         XN/6pjDaKK3AKwuJ+zbLEEAxGZaeSuoKWDQS+0tKpBOF9hxUkVZ7bX+HQ34MCdeLefEk
         i47w==
X-Gm-Message-State: ACrzQf1WCDjroiEZhGJYXm7QQNvS/dbxXiRkpXHFuZl8Ia9/8yVSVIjf
        dn1SxZDud/R3a/Lce9UMxAoUNQ==
X-Google-Smtp-Source: AMsMyM7c5KMB9Ify6vaDssr65IJB+YQYn2ig8pKKgsff7SJZQMwMnQ5bROeYvaCFOGh8FFeaZW9hGg==
X-Received: by 2002:a05:6512:2282:b0:4a2:7dc5:6630 with SMTP id f2-20020a056512228200b004a27dc56630mr16662394lfu.645.1666802706946;
        Wed, 26 Oct 2022 09:45:06 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p6-20020a05651238c600b0049313f77755sm890178lft.213.2022.10.26.09.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:45:06 -0700 (PDT)
Message-ID: <bdae97d3-d6a2-d508-cd86-5e427d8db00a@linaro.org>
Date:   Wed, 26 Oct 2022 19:45:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] phy: qcom-qmp-pcie: Fix the SM8450 PCS registers
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vkoul@kernel.org, andersson@kernel.org, kishon@ti.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
 <f6ab7125-4f1a-61fc-cfeb-8988921c35b4@linaro.org>
 <20221026143152.GA93939@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221026143152.GA93939@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 17:31, Manivannan Sadhasivam wrote:
> On Wed, Sep 21, 2022 at 04:06:10PM +0300, Dmitry Baryshkov wrote:
>> On 10/09/2022 09:38, Manivannan Sadhasivam wrote:
>>> In the PCS region, registers QPHY_V5_PCS_EQ_CONFIG4 and
>>> QPHY_V5_PCS_EQ_CONFIG5 should be used instead of QPHY_V5_PCS_EQ_CONFIG2
>>> and QPHY_V5_PCS_EQ_CONFIG3.
>>>
>>> This causes high latency when ASPM is enabled, so fix it!
>>
>> I have checked against vendor's tree [1]. The registers in question have
>> offsets 0x01c0f3e0 / 0x01c0f3e4. The sm8450.dtsi uses 0x1c0f200 as the PCS
>> region base for the PCIe PHY1. Thus the correct offsets for the table are
>> 0x1e0/0x1e4.
>>
>> There might be a mistake in the name of the register, but the address
>> corresponds to the address in the vendor's tree.
>>
> 
> Right. Only the register name is wrong and I've got the offset wrong here.
> But the actual latency issue is fixed by clearing the
> QPHY_V4_PCS_PCIE_PRESET_P10_POST register in pcs_misc register space.

Please, don't use v4 register names in v5.2 tables. If the register 
matches, could you please add corresponding define?

> 
> I will check with Qcom on this behaviour and post v2 with register name fix.
> 
> Thanks,
> Mani
> 
>> [1] https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-pcie.dtsi#L520
>>
>>>
>>> Fixes: 2c91bf6bf290 ("phy: qcom-qmp: Add SM8450 PCIe1 PHY support")
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 4 ++--
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h | 4 ++--
>>>    2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> index 4648467d5cac..b508903d77d0 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> @@ -1332,8 +1332,8 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rx_tbl[] = {
>>>    };
>>>    static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
>>> -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x16),
>>> -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x22),
>>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG4, 0x16),
>>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x22),
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_PCS_G3S2_PRE_GAIN, 0x2e),
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x99),
>>>    };
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
>>> index 61a44519f969..cca6455ec98c 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
>>> @@ -11,7 +11,7 @@
>>>    #define QPHY_V5_PCS_G3S2_PRE_GAIN			0x170
>>>    #define QPHY_V5_PCS_RX_SIGDET_LVL			0x188
>>>    #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
>>> -#define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
>>> -#define QPHY_V5_PCS_EQ_CONFIG3				0x1e4
>>> +#define QPHY_V5_PCS_EQ_CONFIG4				0x2e0
>>> +#define QPHY_V5_PCS_EQ_CONFIG5				0x2e4
>>>    #endif
-- 
With best wishes
Dmitry

