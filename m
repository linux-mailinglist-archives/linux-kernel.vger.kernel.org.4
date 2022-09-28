Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27F5EE4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiI1TPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiI1TPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:15:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E1CDCC9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:15:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k10so21825867lfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v9AUnRjO2I6miLavN2yEnEf1RGDOOvreZhD6/ZtXL0c=;
        b=O5XQ8YaQgffej3awuvAT1+h+SmTlKX2PrkfOu3buOEqj9nkkAG496M4zpid4tF5yDu
         g6vNQcL4RTvGoJKuvVnYBZhult/bGdv5lQG8/9vg5vJp/yiuMM0b0zhSZAbnR8oEpBLG
         7mSLdkM2w9P1Ep1kVJDyLLM7gvDHyofBYnPvcWzXT0Gq2kx18IKcWmic8S4lioH/a6b3
         VNvF0WPZPS7dARP+owjdaiRcfg3PnrV7bGpaidDR1agFqvaeTscCAGurM3CL4pxc3Zof
         sBgd1Dbn9n1Sy97CU6hAB3PVZ5tyM9vK7xbPeY7i6wYL8ZMXTzKhijdO0IiTc1BfwyCV
         H3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v9AUnRjO2I6miLavN2yEnEf1RGDOOvreZhD6/ZtXL0c=;
        b=vHTAyKspIG3Ifh6UChdZBa3S8C3IE1jIxw3N72lQvKWlsq6EBuKRp+NZmGNsEZ3Y/b
         0L4Q4L14oebUnWQTrVNYxzP2UxEBapgWNqRkPVQnJz4bA7s0FSC+34tqio0eDIchjcLD
         FxMbKFeROf3BC0ugn17k6FrgqVr5LrttAeSrOQ5ikgwKi3+sbt4ZCwPG9ZcgPHApxrE8
         o2B9JYopUMxd5kHcGnlhq9Dzf00p1KjDtuUgPS51MP+ajF1kigHhwOCq0ue+7NPdLlGK
         FrxD3mcOeA3pKXyoK/J0gDjJobbWM4tVBvgoC8pSTltruGEYfCdiRIC5AvkunRtF1wm6
         0c7w==
X-Gm-Message-State: ACrzQf3EVGp5zE+HBvVMdKC4zAz2BbHmVnd1btcooB2wlXfo0UrMBzqr
        UnQSdWCQ/kwKWKLKT3bY2Ac2qQ==
X-Google-Smtp-Source: AMsMyM7uFp6b3scZvJgm5d/f0hHy6uDvB0ECqwfcwJQtQ5AKsRY1t945LjU8a/xIXxais1OIskGI7g==
X-Received: by 2002:a05:6512:1151:b0:4a0:50f2:9509 with SMTP id m17-20020a056512115100b004a050f29509mr13049964lfg.297.1664392547558;
        Wed, 28 Sep 2022 12:15:47 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r11-20020a056512102b00b0049d0a98f73csm548977lfr.154.2022.09.28.12.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:15:47 -0700 (PDT)
Message-ID: <c3d39c4e-2099-b09a-8486-8abae7336611@linaro.org>
Date:   Wed, 28 Sep 2022 22:15:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/13] phy: qcom-qmp-pcie: clean up power-down handling
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-8-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220928152822.30687-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:28, Johan Hovold wrote:
> Always define the POWER_DOWN_CONTROL register instead of falling back to
> the v2 offset during power on and power off.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index eea66c24cf7e..47cdb9ed80cd 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -90,12 +90,14 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_SW_RESET]			= 0x00,
>   	[QPHY_START_CTRL]		= 0x08,
>   	[QPHY_PCS_STATUS]		= 0x174,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
>   };

Without symbolic names it's not obvious that 0x04 (and thus this 
regs_layout) can be used for v2 and v3, but not for v4.

>   
>   static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_SW_RESET]			= 0x00,
>   	[QPHY_START_CTRL]		= 0x08,
>   	[QPHY_PCS_STATUS]		= 0x2ac,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
>   };
>   
>   static const unsigned int sm8250_pcie_regs_layout[QPHY_LAYOUT_SIZE] = {
> @@ -1872,13 +1874,8 @@ static int qmp_pcie_init(struct phy *phy)
>   	if (ret)
>   		goto err_assert_reset;
>   
> -	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
> -		qphy_setbits(pcs,
> -				cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> -				cfg->pwrdn_ctrl);
> -	else
> -		qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
> -				cfg->pwrdn_ctrl);
> +	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +			cfg->pwrdn_ctrl);
>   
>   	return 0;
>   
> @@ -1995,13 +1992,8 @@ static int qmp_pcie_power_off(struct phy *phy)
>   	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
>   
>   	/* Put PHY into POWER DOWN state: active low */
> -	if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) {
> -		qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> -			     cfg->pwrdn_ctrl);
> -	} else {
> -		qphy_clrbits(qphy->pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
> -				cfg->pwrdn_ctrl);
> -	}
> +	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +			cfg->pwrdn_ctrl);
>   
>   	return 0;
>   }

-- 
With best wishes
Dmitry

