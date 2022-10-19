Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762726048AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiJSOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiJSOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:04:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B04143A51
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:45:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so28180269lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9WfAq9GlhRokXPelqeWHthsmCpycJCohpwOtcymBXs=;
        b=pj/UffD41G8Iag/bxmsJ7mApxGuCCO4sUpnc87OpLKIYy6sgo/WL3srjmgGC7rWdyG
         qg6U+PYe5I5uvsWHe0IkyropCNcU+DQM8+xZLhOZqN1sUvA1S8bwF3ZX2/K7P/bdin2E
         WSpeDtyJmLFSVE/JKVOKGtkkes9Y2C8XzeBOpGN3zn1paIj9b8uWH4FTj3NhDVcr6Nml
         +Jp5J6KYzqIuuY27Hw/9m7L6yNuXH+UCtQDjaig5wzr/QvBqlHwEmjNTW2YdeF0Dqki4
         AJFg8EeWW831/VgwDIWPAgyvvRkMHiZFlgaePg1pl5LnwXcUYBtXbGKt0rFyyNTjbnEo
         ayVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9WfAq9GlhRokXPelqeWHthsmCpycJCohpwOtcymBXs=;
        b=KfE2xrrb4mWRg25iWxqUG3TE7vs72MI+a0rXhFb8NoWo7cdDgYsUSO/yofMnbiFcCT
         gd55RKRPsEY17eRHrVwdU2Welgz9GSS5+IeDus27wjHYUZA1lqnsfeKV0UxyL2JH04AK
         mdoiwO/8UlaBpKn1JH162cYtHlxqJ82ggoRnSZ83jQBQx+W3gq99UCYANQFF9SyiO0mo
         jtydlGjFpwBPX3f08IUURxL9Wlzf4q3HGK/ICVKXIHEkTbtbI6lirJVPivltQtRS1Q9i
         EXDtBHSzaq4vTbhu+VUt2/wg7NrjYoJQVytZKF+jrUzfQvK8nU6y8yRbNKUq5A40sgGC
         +GQw==
X-Gm-Message-State: ACrzQf37QKC0tWlyDhaX9DmdzVNERCvKHqs0IHQNlqFiNHNHsYyjG9vZ
        yMWmQADd+pjaqnriK7+nsQ0NAg==
X-Google-Smtp-Source: AMsMyM5b2vyYPLDgUf0s1Uyw3+sPCvqEqEGYyKzYINQDUoDWiJvmGUVKOD0SEyhCvSuLsjUYLXbifA==
X-Received: by 2002:a05:6512:110c:b0:4a2:4119:f5c4 with SMTP id l12-20020a056512110c00b004a24119f5c4mr2784433lfg.606.1666187074664;
        Wed, 19 Oct 2022 06:44:34 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s28-20020a2eb63c000000b0026dcf238c50sm2450177ljn.127.2022.10.19.06.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:44:34 -0700 (PDT)
Message-ID: <0b0c752c-1f3d-bf5a-ade7-e2f8acac92a4@linaro.org>
Date:   Wed, 19 Oct 2022 16:44:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 08/15] phy: qcom-qmp-pcie: add register init helper
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
 <20221019113552.22353-9-johan+linaro@kernel.org>
 <0f1fff20-772f-c4d1-f803-f1824ef23780@linaro.org>
 <Y0/63eH82t2zXFi5@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y0/63eH82t2zXFi5@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 16:25, Johan Hovold wrote:
> On Wed, Oct 19, 2022 at 04:12:02PM +0300, Dmitry Baryshkov wrote:
>> On 19/10/2022 14:35, Johan Hovold wrote:
>>> Generalise the serdes initialisation helper so that it can be used to
>>> initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
>>>
>>> Note that this defers the ungating of the PIPE clock somewhat, which is
>>> fine as it isn't needed until starting the PHY.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 51 +++++++-----------------
>>>    1 file changed, 15 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> index dd7e72424fc0..f57d10f20277 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> @@ -1820,46 +1820,32 @@ static void qmp_pcie_configure(void __iomem *base,
>>>    	qmp_pcie_configure_lane(base, tbl, num, 0xff);
>>>    }
>>>    
>>> -static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
>>> -{
>>> -	void __iomem *serdes = qmp->serdes;
>>> -
>>> -	if (!tables)
>>> -		return;
>>> -
>>> -	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
>>> -}
>>> -
>>> -static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
>>> +static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tbls)
>>>    {
>>>    	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>> +	void __iomem *serdes = qmp->serdes;
>>>    	void __iomem *tx = qmp->tx;
>>>    	void __iomem *rx = qmp->rx;
>>>    	void __iomem *tx2 = qmp->tx2;
>>>    	void __iomem *rx2 = qmp->rx2;
>>> +	void __iomem *pcs = qmp->pcs;
>>> +	void __iomem *pcs_misc = qmp->pcs_misc;
>>>    
>>> -	if (!tables)
>>> +	if (!tbls)
>>>    		return;
>>>    
>>> -	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
>>> -	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
>>> +	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
>>> +
>>> +	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
>>> +	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
>>>    
>>>    	if (cfg->lanes >= 2) {
>>> -		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
>>> -		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
>>> +		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
>>> +		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
>>>    	}
>>> -}
>>> -
>>> -static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
>>> -{
>>> -	void __iomem *pcs = qmp->pcs;
>>> -	void __iomem *pcs_misc = qmp->pcs_misc;
>>> -
>>> -	if (!tables)
>>> -		return;
>>>    
>>> -	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
>>> -	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
>>> +	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
>>> +	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
>>
>> Nit: could we please keep it as `tables'?
> 
> I considered that but found that the longer identifier hurt
> readability so I prefer to use "tbls" here.
> 
> Compare
> 
> 	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
> 
> 	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
> 	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
> 
> 	if (cfg->lanes >= 2) {
> 		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
> 		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
> 	}
> 
> 	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
> 	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
> 
> with
> 
> 	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
> 
> 	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
> 	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
> 
> 	if (cfg->lanes >= 2) {
> 		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
> 		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
> 	}
> 
> 	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
> 	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);

I'd say, it's up to Vinod. I'd prefer the second version.


-- 
With best wishes
Dmitry

