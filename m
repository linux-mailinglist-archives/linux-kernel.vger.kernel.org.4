Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFCF605B42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJTJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiJTJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:32:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D615B101
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:32:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a29so32593440lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vbo5+yxCw1Loi5uLkMP1tDK1U+EA1+GCOOOHXa4CGGI=;
        b=O6mDEx4dRLj/vAVzy2Aph7R6Z73vdf+VuLUUt1K+G+pPDM84CT5WF5NOwWOFOO+Gi6
         wTE108TymB66vlnG4km+fef77IPNX6HUCwaLqrQuBHteIiV8koVOEjSxIaUaPbtJ5qY8
         ahZCE1NLcVcgEi7IvRxFEGg6vv4VIxN8uSWLnQF5GkLmW1BRhkjEbeC3W76TUfDOcdVb
         PfTBXDkz0YprUQdhngVHRU8DP7CCbuGntY3HaeiwgZg0j/Fg2dJSUenit49QbMMHttdd
         mTzzxcmjdoeoNrto77RJHat+RBEFkI+z3K8V8aIAKyYOlXpQUSr1cJ804zY7c6IkVNX8
         NtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbo5+yxCw1Loi5uLkMP1tDK1U+EA1+GCOOOHXa4CGGI=;
        b=1yd/JHZjse1uwMeGZYzJ8SI7bgcQoYNFL71d6I0Wkr6noFEaJ04a58MLBQTsT9J5eH
         g8eAMK8W0li4wJxgzyFFLgOdz3HcbZkqDHJfmKXHGpOEBoIgeD+adZ55BSUGIVbz2S6h
         lPIF9bSykttGx6wUJQHzmPdoT++Dm6Zsgs4Cf5Pntd1Ni2vzmoh3nrGvKkpr4Q+0FoGh
         2tUqYylvIdklg96MjWNh6oI9aOlw0w1cee3QPV81sVs3ZJDeDgI9W8eEjRdUITXhaDtQ
         TGAf+GlmybYpSnEUQelxaUOUoV8ri8rg32wp1Xjj5l7GABnn0D6o/NdsHaPKJ4uEz+/C
         WsEg==
X-Gm-Message-State: ACrzQf3D3R3ER1n/3wJfzQLcO21BAW3ESrVsvywfOKN+nJXn4eBuEt/w
        xfcp00uNFYUJ3nYUBQXQX7frxA==
X-Google-Smtp-Source: AMsMyM4ZRdhINz5QnYRn8AeaGxUG4k9Nojc8u1utaKccujFaIuR4oyR3qkdibyWqq9n8hAsHW19m+A==
X-Received: by 2002:a05:6512:12c8:b0:4a2:cc28:cab8 with SMTP id p8-20020a05651212c800b004a2cc28cab8mr4123960lfg.205.1666258334516;
        Thu, 20 Oct 2022 02:32:14 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k12-20020ac257cc000000b00494a1b242dasm2665017lfo.14.2022.10.20.02.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 02:32:14 -0700 (PDT)
Message-ID: <004a6ab9-690b-db13-08a9-c42d09368814@linaro.org>
Date:   Thu, 20 Oct 2022 12:32:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 15/15] phy: qcom-qmp-pcie: add support for sc8280xp
 4-lane PHYs
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221019113552.22353-1-johan+linaro@kernel.org>
 <20221019113552.22353-16-johan+linaro@kernel.org>
 <2902e7e8-eddf-149c-06fd-86b85d8af326@linaro.org>
 <Y1DuB6hzb3V5Lqdy@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y1DuB6hzb3V5Lqdy@hovoldconsulting.com>
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

On 20/10/2022 09:43, Johan Hovold wrote:
> On Thu, Oct 20, 2022 at 06:43:47AM +0300, Dmitry Baryshkov wrote:
>> On 19/10/2022 14:35, Johan Hovold wrote:
>>> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
>>> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
>>> PCIe2A and PCIe2B).
>>>
>>> Add support for fetching the 4-lane configuration from the TCSR and
>>> programming the lane registers of the second port when in 4-lane mode.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/Kconfig             |   1 +
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 118 +++++++++++++++++++++++
>>>    2 files changed, 119 insertions(+)
>>>
>>> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
>>> index 5c98850f5a36..eb9ddc685b38 100644
>>> --- a/drivers/phy/qualcomm/Kconfig
>>> +++ b/drivers/phy/qualcomm/Kconfig
>>> @@ -54,6 +54,7 @@ config PHY_QCOM_QMP
>>>    	tristate "Qualcomm QMP PHY Driver"
>>>    	depends on OF && COMMON_CLK && (ARCH_QCOM || COMPILE_TEST)
>>>    	select GENERIC_PHY
>>> +	select MFD_SYSCON
>>>    	help
>>>    	  Enable this to support the QMP PHY transceiver that is used
>>>    	  with controllers such as PCIe, UFS, and USB on Qualcomm chips.
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> index ea5228bd9ecc..e5bce4810bb5 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> @@ -10,6 +10,7 @@
>>>    #include <linux/io.h>
>>>    #include <linux/iopoll.h>
>>>    #include <linux/kernel.h>
>>> +#include <linux/mfd/syscon.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of.h>
>>>    #include <linux/of_device.h>
>>> @@ -17,6 +18,7 @@
>>>    #include <linux/phy/pcie.h>
>>>    #include <linux/phy/phy.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>>    #include <linux/regulator/consumer.h>
>>>    #include <linux/reset.h>
>>>    #include <linux/slab.h>
>>> @@ -886,6 +888,10 @@ static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x2_pcie_rc_serdes_tbl[] =
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>>>    };
>>>    
>>> +static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x4_pcie_serdes_4ln_tbl[] = {
>>> +	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
>>> +};
>>> +
>>>    static const struct qmp_phy_init_tbl sc8280xp_qmp_gen3x1_pcie_tx_tbl[] = {
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x20),
>>>    	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0x75),
>>> @@ -1491,6 +1497,9 @@ struct qmp_phy_cfg {
>>>    	const struct qmp_phy_cfg_tables *tables_rc;
>>>    	const struct qmp_phy_cfg_tables *tables_ep;
>>>    
>>> +	const struct qmp_phy_init_tbl *serdes_4ln_tbl;
>>> +	int serdes_4ln_num;
>>
>> Would it make more sense to change this into the proper
>> qmp_phy_cfg_tables entry and then use the existing API for programming
>> the table?
> 
> No, there is just one serdes register update needed when in 4-lane mode,
> besides programming tx/rx for the second port. Adding a third struct
> qmp_phy_cfg_tables for this seems like overkill and would lead to a more
> convoluted implementation of the programming sequence.

Ack. Let's have it this way and change it later if the need arises.

> 
> And you can't add it two one of the existing ones, as your comment seems
> to suggest.

Please excuse me if I didn't write it clear enough. I suggested adding 
another cfg_tables, as you correctly commented above.

> 
> The gen3x4 PHYs can be in either 4-lane or 2-lane mode depending on the
> TCSR configuration. Port A is programmed identically in both cases
> except for this serdes register, and in 4-lane mode tx/rx also needs
> to be programmed for port B.
>   
>>> +
>>>    	/* clock ids to be requested */
>>>    	const char * const *clk_list;
>>>    	int num_clks;
>>> @@ -1518,6 +1527,7 @@ struct qmp_pcie {
>>>    	struct device *dev;
>>>    
>>>    	const struct qmp_phy_cfg *cfg;
>>> +	bool tcsr_4ln_config;
>>
>> As a matter of preference, this seems too specific. I'd rename it to
>> split_config or split_4ln_config.
> 
> I'm afraid those names do not make much sense. This TCSR register
> controls whether the PHY is in 4-lane mode (instead of 2-lane mode).

Well, we just need the info that it's 4-lane. It doesn't really matter 
if this information comes from TCSR, DT or e.g. fuses. I'd say that TCSR 
is a platform detail. Thus I'm suggesting a more generic name.

> 
>>>    
>>>    	void __iomem *serdes;
>>>    	void __iomem *pcs;
>>> @@ -1527,6 +1537,8 @@ struct qmp_pcie {
>>>    	void __iomem *tx2;
>>>    	void __iomem *rx2;
>>>    
>>> +	void __iomem *port_b;
>>> +
>>>    	struct clk *pipe_clk;
>>>    	struct clk *pipediv2_clk;
>>>    	struct clk_bulk_data *clks;
>>> @@ -1932,6 +1944,44 @@ static const struct qmp_phy_cfg sc8280xp_qmp_gen3x2_pciephy_cfg = {
>>>    	.phy_status		= PHYSTATUS,
>>>    };
>    
>>> +static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>>> +{
>>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
>>> +	void __iomem *tx3, *rx3, *tx4, *rx4;
>>> +
>>> +	tx3 = qmp->port_b + offs->tx;
>>> +	rx3 = qmp->port_b + offs->rx;
>>> +	tx4 = qmp->port_b + offs->tx2;
>>> +	rx4 = qmp->port_b + offs->rx2;
>>> +
>>> +	qmp_pcie_configure_lane(tx3, tbls->tx, tbls->tx_num, 1);
>>> +	qmp_pcie_configure_lane(rx3, tbls->rx, tbls->rx_num, 1);
>>> +
>>> +	qmp_pcie_configure_lane(tx4, tbls->tx, tbls->tx_num, 2);
>>> +	qmp_pcie_configure_lane(rx4, tbls->rx, tbls->rx_num, 2);
>>
>> I'd use BIT(2) and BIT(3) here. This would allow one to make a
>> difference between programming first pair of lanes and second pair of
>> lanes if necessary.
> 
> No, the tx and tx registers of the second port should be programmed
> identically to that of the first port.

As you would prefer. As a matter of fact, we do not have CFG_LANES in 
the PCIe PHY. Thus I'm surprised that you didn't drop this. I think 
CFG_LANES usage is limited to sm8250 USB and combo PHY configurations.

> 
>>> +}
>>> +
>>>    static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>>>    {
>>>    	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>> @@ -2080,6 +2148,11 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>>>    
>>>    	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
>>>    	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
>>> +
>>> +	if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
>>> +		qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
>>> +		qmp_pcie_init_port_b(qmp, tbls);
>>> +	}
>>
>> As you have been refactoring this piece of code, maybe it would make
>> more sense to change qmp->tx/tx2 into an array of two elements? Then we
>> can extend it to 4 in this patch, and just always write the whole array
>> in a loop?
> 
> No, I don't think that would be an improvement and would obscure the
> fact that we're programming two otherwise identical ports (e.g. tx1 and
> tx2 of port B is used for the third and fourth lanes).
> 
> Note that the above conditional encodes the difference in programming
> sequence between 4-lane and 2-lane mode I described above (one serdes
> register difference + tx/rx of port b).

Either way looks fine to me. So, let's leave this in a way you've 
implemented it.

-- 
With best wishes
Dmitry

