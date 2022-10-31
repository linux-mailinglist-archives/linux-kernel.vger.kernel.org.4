Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA2613DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJaSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJaSvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:51:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63B13E3F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:51:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u11so17836346ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIHD/TalnTPrkfQ6wCKe1+99U479JroLHsIatpvVNE8=;
        b=fjqZEw3Oi/NfL5I7at77owN0GtEsWMX0r1fEzL5LPGqVfZC43cZIuBkVJ+Fs016DA0
         K2ArqvY7Rsqnw++C3rz8YWhAkTEWebJwTeoZAMgcShX0JjVwsifpNdUzSM5jOV5q+GV1
         Q7VE9xOWS6SutF9so2EQrzuM/aonKiLC9hFcyEUYzG1+8S6RHzEG87E6cuYOHbq0aMOW
         ocp0AjUJ7TqQS48AlnOZXZfBe3ckgBN3F4Kpk1oC3FUzsOdRyh9IiMqf/0ACqP2rmNb0
         gcromFjVbxC7HNjGvPYl1a+p8UanfmCZQ9/fUsH3yicpLzV0bsau1hAprx7ihRQkF7N/
         NRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIHD/TalnTPrkfQ6wCKe1+99U479JroLHsIatpvVNE8=;
        b=vsNJIx9y4kIWU2/CbmEBAVAsV/EOwBxtfL8v1ZqVRtmd/C3AfzDZTYKbW+KtEBEO2+
         8Xmiye4vIScUdPXF82cSP8+sOv6NBgI0bo0Qx7CpzyJGqMzLVzkuG+nJJiuqEI1VMevU
         CdHCQZkxrixmo03JhutTYMzw8PoZSPFncq6Impva6kbzg6zZLUef6rrxyshBOwYrXs51
         c6esG69JAk9haCQzopWOAJNQnhbNBy1HQDWT1dGFByJPNGARZezD/ByYZFcDY0G3KKS3
         1pJX9MwnEtkmjeUtgIbmLI5a64tDrh9nlXA/7/RBtNEeRACKmhNjKiohaqySXckFitT7
         d/xA==
X-Gm-Message-State: ACrzQf34sjA+TGekNB2OJw3a57EpB7FkZkMpVsEluvx8kmwaLSluyxdH
        5lpMrRvrOsrLnDQ0OVIHksIaHA==
X-Google-Smtp-Source: AMsMyM5frARTC2Hh094Sg/I/oEzIe5ybtNqpiEGAbGIThR+S76Cn+lsGnfo2EEZ/3m+PZ7dEDfJXnw==
X-Received: by 2002:a2e:a810:0:b0:26f:c2a8:c48 with SMTP id l16-20020a2ea810000000b0026fc2a80c48mr5987398ljq.6.1667242260639;
        Mon, 31 Oct 2022 11:51:00 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h14-20020a056512054e00b0049480c8e7bcsm1378240lfl.176.2022.10.31.11.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:51:00 -0700 (PDT)
Message-ID: <748f41e1-cafc-e7eb-43ac-b8daacf88da4@linaro.org>
Date:   Mon, 31 Oct 2022 21:50:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 01/15] phy: qcom-qmp-ufs: Move register settings to
 qmp_phy_cfg_tables struct
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-2-manivannan.sadhasivam@linaro.org>
 <14844656-0d93-eac0-1877-f3e967691f5a@linaro.org>
 <20221031154607.GB12738@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221031154607.GB12738@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 18:46, Manivannan Sadhasivam wrote:
> On Sun, Oct 30, 2022 at 12:50:50AM +0300, Dmitry Baryshkov wrote:
>> On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
>>> As done for Qcom PCIe PHY driver, let's move the register settings to the
>>> common qmp_phy_cfg_tables struct. This helps in adding any additional PHY
>>> settings needed for functionalities like HS-G4 in the future by adding one
>>> more instance of the qmp_phy_cfg_tables.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 223 +++++++++++++-----------
>>>    1 file changed, 126 insertions(+), 97 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> index c08d34ad1313..cdfda4e6d575 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> @@ -107,7 +107,7 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>>    	[QPHY_SW_RESET]			= QPHY_V4_PCS_UFS_SW_RESET,
>>>    };
>>> -static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
>>> +static const struct qmp_phy_init_tbl msm8996_ufs_serdes[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
>>> @@ -156,12 +156,12 @@ static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
>>>    };
>>> -static const struct qmp_phy_init_tbl msm8996_ufs_tx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl msm8996_ufs_tx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
>>>    	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x02),
>>>    };
>>> -static const struct qmp_phy_init_tbl msm8996_ufs_rx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl msm8996_ufs_rx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x02),
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x00),
>>> @@ -175,7 +175,7 @@ static const struct qmp_phy_init_tbl msm8996_ufs_rx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0E),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
>>> @@ -231,12 +231,12 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_serdes_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x44),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm6115_ufsphy_tx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm6115_ufsphy_tx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
>>>    	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm6115_ufsphy_rx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm6115_ufsphy_rx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x0F),
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x40),
>>> @@ -254,7 +254,7 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_rx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5B),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_PWM_GEAR_BAND, 0x15),
>>>    	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_SIGDET_CTRL2, 0x6d),
>>>    	QMP_PHY_INIT_CFG(QPHY_V2_PCS_TX_LARGE_AMP_DRV_LVL, 0x0f),
>>> @@ -266,7 +266,7 @@ static const struct qmp_phy_init_tbl sm6115_ufsphy_pcs_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V2_PCS_RX_MIN_HIBERN8_TIME, 0x9a), /* 8 us */
>>>    };
>>> -static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
>>> @@ -308,13 +308,13 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
>>>    };
>>> -static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_tx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
>>>    };
>>> -static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_rx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
>>> @@ -333,7 +333,7 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
>>>    };
>>> -static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6e),
>>>    	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
>>>    	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
>>> @@ -344,7 +344,7 @@ static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
>>> @@ -374,7 +374,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x06),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8150_ufsphy_tx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
>>> @@ -383,7 +383,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8150_ufsphy_rx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
>>> @@ -421,7 +421,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
>>>    	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
>>>    	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
>>> @@ -431,7 +431,7 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
>>> @@ -461,7 +461,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x06),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8350_ufsphy_tx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8350_ufsphy_tx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
>>> @@ -473,7 +473,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_tx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_TX_TRAN_DRVR_EMP_EN, 0x0c),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8350_ufsphy_rx_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8350_ufsphy_rx[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_LVL, 0x24),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x0f),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
>>> @@ -513,7 +513,7 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_rx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DCC_CTRL1, 0x0c),
>>>    };
>>> -static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
>>> +static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
>>> @@ -531,19 +531,24 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>>>    };
>>> +struct qmp_phy_cfg_tables {
>>> +	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>>> +	const struct qmp_phy_init_tbl *serdes;
>>> +	int serdes_num;
>>> +	const struct qmp_phy_init_tbl *tx;
>>> +	int tx_num;
>>> +	const struct qmp_phy_init_tbl *rx;
>>> +	int rx_num;
>>> +	const struct qmp_phy_init_tbl *pcs;
>>> +	int pcs_num;
>>> +};
>>> +
>>>    /* struct qmp_phy_cfg - per-PHY initialization config */
>>>    struct qmp_phy_cfg {
>>>    	int lanes;
>>> -	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>>> -	const struct qmp_phy_init_tbl *serdes_tbl;
>>> -	int serdes_tbl_num;
>>> -	const struct qmp_phy_init_tbl *tx_tbl;
>>> -	int tx_tbl_num;
>>> -	const struct qmp_phy_init_tbl *rx_tbl;
>>> -	int rx_tbl_num;
>>> -	const struct qmp_phy_init_tbl *pcs_tbl;
>>> -	int pcs_tbl_num;
>>> +	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>>> +	const struct qmp_phy_cfg_tables tables;
>>>    	/* clock ids to be requested */
>>>    	const char * const *clk_list;
>>> @@ -660,12 +665,14 @@ static const char * const qmp_phy_vreg_l[] = {
>>>    static const struct qmp_phy_cfg msm8996_ufs_cfg = {
>>>    	.lanes			= 1,
>>> -	.serdes_tbl		= msm8996_ufs_serdes_tbl,
>>> -	.serdes_tbl_num		= ARRAY_SIZE(msm8996_ufs_serdes_tbl),
>>> -	.tx_tbl			= msm8996_ufs_tx_tbl,
>>> -	.tx_tbl_num		= ARRAY_SIZE(msm8996_ufs_tx_tbl),
>>> -	.rx_tbl			= msm8996_ufs_rx_tbl,
>>> -	.rx_tbl_num		= ARRAY_SIZE(msm8996_ufs_rx_tbl),
>>> +	.tables = {
>>> +		.serdes		= msm8996_ufs_serdes,
>>> +		.serdes_num	= ARRAY_SIZE(msm8996_ufs_serdes),
>>> +		.tx		= msm8996_ufs_tx,
>>> +		.tx_num		= ARRAY_SIZE(msm8996_ufs_tx),
>>> +		.rx		= msm8996_ufs_rx,
>>> +		.rx_num		= ARRAY_SIZE(msm8996_ufs_rx),
>>> +	},
>>>    	.clk_list		= msm8996_ufs_phy_clk_l,
>>>    	.num_clks		= ARRAY_SIZE(msm8996_ufs_phy_clk_l),
>>> @@ -685,14 +692,16 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
>>>    static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>>>    	.lanes			= 2,
>>> -	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
>>> -	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
>>> -	.tx_tbl			= sdm845_ufsphy_tx_tbl,
>>> -	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx_tbl),
>>> -	.rx_tbl			= sdm845_ufsphy_rx_tbl,
>>> -	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx_tbl),
>>> -	.pcs_tbl		= sdm845_ufsphy_pcs_tbl,
>>> -	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs_tbl),
>>> +	.tables = {
>>> +		.serdes		= sdm845_ufsphy_serdes,
>>> +		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
>>> +		.tx		= sdm845_ufsphy_tx,
>>> +		.tx_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
>>> +		.rx		= sdm845_ufsphy_rx,
>>> +		.rx_num		= ARRAY_SIZE(sdm845_ufsphy_rx),
>>> +		.pcs		= sdm845_ufsphy_pcs,
>>> +		.pcs_num	= ARRAY_SIZE(sdm845_ufsphy_pcs),
>>> +	},
>>>    	.clk_list		= sdm845_ufs_phy_clk_l,
>>>    	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>>>    	.vreg_list		= qmp_phy_vreg_l,
>>> @@ -709,14 +718,16 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>>>    static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>>>    	.lanes			= 1,
>>> -	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
>>> -	.serdes_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
>>> -	.tx_tbl			= sm6115_ufsphy_tx_tbl,
>>> -	.tx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_tx_tbl),
>>> -	.rx_tbl			= sm6115_ufsphy_rx_tbl,
>>> -	.rx_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_rx_tbl),
>>> -	.pcs_tbl		= sm6115_ufsphy_pcs_tbl,
>>> -	.pcs_tbl_num		= ARRAY_SIZE(sm6115_ufsphy_pcs_tbl),
>>> +	.tables = {
>>> +		.serdes		= sm6115_ufsphy_serdes,
>>> +		.serdes_num	= ARRAY_SIZE(sm6115_ufsphy_serdes),
>>> +		.tx		= sm6115_ufsphy_tx,
>>> +		.tx_num		= ARRAY_SIZE(sm6115_ufsphy_tx),
>>> +		.rx		= sm6115_ufsphy_rx,
>>> +		.rx_num		= ARRAY_SIZE(sm6115_ufsphy_rx),
>>> +		.pcs		= sm6115_ufsphy_pcs,
>>> +		.pcs_num	= ARRAY_SIZE(sm6115_ufsphy_pcs),
>>> +	},
>>>    	.clk_list		= sdm845_ufs_phy_clk_l,
>>>    	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>>>    	.vreg_list		= qmp_phy_vreg_l,
>>> @@ -732,14 +743,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>>>    static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>>>    	.lanes			= 2,
>>> -	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
>>> -	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes_tbl),
>>> -	.tx_tbl			= sm8150_ufsphy_tx_tbl,
>>> -	.tx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_tx_tbl),
>>> -	.rx_tbl			= sm8150_ufsphy_rx_tbl,
>>> -	.rx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_rx_tbl),
>>> -	.pcs_tbl		= sm8150_ufsphy_pcs_tbl,
>>> -	.pcs_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_pcs_tbl),
>>> +	.tables = {
>>> +		.serdes		= sm8150_ufsphy_serdes,
>>> +		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
>>> +		.tx		= sm8150_ufsphy_tx,
>>> +		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
>>> +		.rx		= sm8150_ufsphy_rx,
>>> +		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
>>> +		.pcs		= sm8150_ufsphy_pcs,
>>> +		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
>>> +	},
>>>    	.clk_list		= sdm845_ufs_phy_clk_l,
>>>    	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>>>    	.vreg_list		= qmp_phy_vreg_l,
>>> @@ -754,14 +767,16 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>>>    static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>>>    	.lanes			= 2,
>>> -	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
>>> -	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
>>> -	.tx_tbl			= sm8350_ufsphy_tx_tbl,
>>> -	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
>>> -	.rx_tbl			= sm8350_ufsphy_rx_tbl,
>>> -	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
>>> -	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
>>> -	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
>>> +	.tables = {
>>> +		.serdes		= sm8350_ufsphy_serdes,
>>> +		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
>>> +		.tx		= sm8350_ufsphy_tx,
>>> +		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
>>> +		.rx		= sm8350_ufsphy_rx,
>>> +		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
>>> +		.pcs		= sm8350_ufsphy_pcs,
>>> +		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
>>> +	},
>>>    	.clk_list		= sdm845_ufs_phy_clk_l,
>>>    	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>>>    	.vreg_list		= qmp_phy_vreg_l,
>>> @@ -776,14 +791,16 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>>>    static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
>>>    	.lanes			= 2,
>>> -	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
>>> -	.serdes_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_serdes_tbl),
>>> -	.tx_tbl			= sm8350_ufsphy_tx_tbl,
>>> -	.tx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_tx_tbl),
>>> -	.rx_tbl			= sm8350_ufsphy_rx_tbl,
>>> -	.rx_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_rx_tbl),
>>> -	.pcs_tbl		= sm8350_ufsphy_pcs_tbl,
>>> -	.pcs_tbl_num		= ARRAY_SIZE(sm8350_ufsphy_pcs_tbl),
>>> +	.tables = {
>>> +		.serdes		= sm8350_ufsphy_serdes,
>>> +		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
>>> +		.tx		= sm8350_ufsphy_tx,
>>> +		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
>>> +		.rx		= sm8350_ufsphy_rx,
>>> +		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
>>> +		.pcs		= sm8350_ufsphy_pcs,
>>> +		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
>>> +	},
>>>    	.clk_list		= sm8450_ufs_phy_clk_l,
>>>    	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
>>>    	.vreg_list		= qmp_phy_vreg_l,
>>> @@ -826,16 +843,43 @@ static void qmp_ufs_configure(void __iomem *base,
>>>    	qmp_ufs_configure_lane(base, regs, tbl, num, 0xff);
>>>    }
>>> -static int qmp_ufs_serdes_init(struct qmp_phy *qphy)
>>> +static void qmp_ufs_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
>>>    {
>>>    	const struct qmp_phy_cfg *cfg = qphy->cfg;
>>>    	void __iomem *serdes = qphy->serdes;
>>> -	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
>>> -	int serdes_tbl_num = cfg->serdes_tbl_num;
>>> -	qmp_ufs_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
>>> +	if (!tables)
>>> +		return;
>>> -	return 0;
>>> +	qmp_ufs_configure(serdes, cfg->regs, tables->serdes, tables->serdes_num);
>>> +}
>>> +
>>> +static void qmp_ufs_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
>>> +{
>>> +	const struct qmp_phy_cfg *cfg = qphy->cfg;
>>> +	void __iomem *tx = qphy->tx;
>>> +	void __iomem *rx = qphy->rx;
>>> +
>>> +	qmp_ufs_configure_lane(tx, cfg->regs, tables->tx, tables->tx_num, 1);
>>> +
>>> +	if (cfg->lanes >= 2)
>>> +		qmp_ufs_configure_lane(qphy->tx2, cfg->regs, tables->tx, tables->tx_num, 2);
>>> +
>>> +	qmp_ufs_configure_lane(rx, cfg->regs, tables->rx, tables->rx_num, 1);
>>> +
>>> +	if (cfg->lanes >= 2)
>>> +		qmp_ufs_configure_lane(qphy->rx2, cfg->regs, tables->rx, tables->rx_num, 2);
>>> +}
>>> +
>>> +static void qmp_ufs_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
>>> +{
>>> +	const struct qmp_phy_cfg *cfg = qphy->cfg;
>>> +	void __iomem *pcs = qphy->pcs;
>>> +
>>> +	if (!tables)
>>> +		return;
>>> +
>>> +	qmp_ufs_configure(pcs, cfg->regs, tables->pcs, tables->pcs_num);
>>>    }
>>>    static int qmp_ufs_com_init(struct qmp_phy *qphy)
>>> @@ -933,31 +977,16 @@ static int qmp_ufs_power_on(struct phy *phy)
>>>    	struct qmp_phy *qphy = phy_get_drvdata(phy);
>>>    	struct qcom_qmp *qmp = qphy->qmp;
>>>    	const struct qmp_phy_cfg *cfg = qphy->cfg;
>>> -	void __iomem *tx = qphy->tx;
>>> -	void __iomem *rx = qphy->rx;
>>>    	void __iomem *pcs = qphy->pcs;
>>>    	void __iomem *status;
>>>    	unsigned int mask, val, ready;
>>>    	int ret;
>>> -	qmp_ufs_serdes_init(qphy);
>>> -
>>> -	/* Tx, Rx, and PCS configurations */
>>> -	qmp_ufs_configure_lane(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num, 1);
>>> +	qmp_ufs_serdes_init(qphy, &cfg->tables);
>>> -	if (cfg->lanes >= 2) {
>>> -		qmp_ufs_configure_lane(qphy->tx2, cfg->regs,
>>> -					cfg->tx_tbl, cfg->tx_tbl_num, 2);
>>> -	}
>>> -
>>> -	qmp_ufs_configure_lane(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num, 1);
>>> -
>>> -	if (cfg->lanes >= 2) {
>>> -		qmp_ufs_configure_lane(qphy->rx2, cfg->regs,
>>> -					cfg->rx_tbl, cfg->rx_tbl_num, 2);
>>> -	}
>>> +	qmp_ufs_lanes_init(qphy, &cfg->tables);
>>> -	qmp_ufs_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>>> +	qmp_ufs_pcs_init(qphy, &cfg->tables);
>>
>> I'd suggest going straight to qmp_ufs_init_registers, which would contain
>> both serdes, lanes and pcs inits.
>>
> 
> That adds one more level of indirection which may not be needed here. Moreover,
> I'm trying to be in sync with other qmp drivers, specifically the pcie one.
> This helps in working with these drivers.

Yes, I understand. However I hope that the respective patchset 
(including [1]) will be merged soon. Thus I suggest skipping the step 
and using the same function already.

[1] 
https://lore.kernel.org/linux-phy/20221028133603.18470-10-johan+linaro@kernel.org/

> 
> Thanks,
> Mani
> 
>>>    	ret = reset_control_deassert(qmp->ufs_reset);
>>>    	if (ret)
>>
>> -- 
>> With best wishes
>> Dmitry
>>
> 

-- 
With best wishes
Dmitry

