Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD95EE4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiI1TKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiI1TKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:10:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3564DB02
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:10:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x29so15430693ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cP+0I3mOs2L1eIjpsJ/L9c174FcHhto93z5jVh+tc0g=;
        b=k0KtMBwhj90pHjs/axB9uH2GwSCWiySEVILQVZb+aLITWPo+4e/xOTrnXSeyfXhP8+
         WUJpwSsQOcuDRr6LkhtREjRJmACOcjjQrZlhr4weZBBw98ujBEGcj+lSdo0NMjrMkuxE
         HZ/oqxKHUxTjwxIXDKXmdwrwkFFfHllLa9roMLyXjF4eWU+PQVf0Sk0CyrgHM9J9qx1Q
         nY4kSM8V5dV2LhaFiyvDSsED5X1XKIIip65LFJPfiHWE0QK5OnyIL+7G5NJzI5vzZKHf
         /3Dtn5mAbjPjRGXd99wF3PMoxJO+/EBez63XhUA5eeBWm53U5DDhpmWPmYbYCdxGCgbU
         M/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cP+0I3mOs2L1eIjpsJ/L9c174FcHhto93z5jVh+tc0g=;
        b=Np3mv+VknYG1qWTs118AE8dc0HRi4kvTIh9lGAf9GIqGmJUB2O1TYdGjstHFHmmQkZ
         OVGLzUjB3PdDtuxfZLKcUSisnJlpc9Sb7nOd94TrzYz9OIpT0JnzTozllLrNroo1FvPf
         YySkX2+OYLUzXcZVKD3GzT1ES6m8ZHR+XiiEpyPAGTe9Yi0NG33KFjXMplf6nCD92mDL
         nU9G0oBbazjelZLQroefV2+E4v5lUcKnwutxuimdhd8OWrEx0xpKjLr1wJ5mp6i39sz9
         TAwo4lq+WOQbEydDCQvBtx6zbP/wt0hUolZSPehDRnRer09D3b9IMCXaGaB56MKIvNun
         wlCg==
X-Gm-Message-State: ACrzQf2NERbusCeR9Ab//saBrbOLRDR00YdemMUQ6WN6g7vYTUvV6rPb
        BJSz8ltxRefVsoalmkwH9TaVHA==
X-Google-Smtp-Source: AMsMyM74hGFUFf9B9nArhWD7MayY4zuDeYdL2If2toJlhwy/g3tvy4kLs1xzd1Nf/dJDpKGQGSnxxw==
X-Received: by 2002:a2e:91ca:0:b0:26b:efd1:112c with SMTP id u10-20020a2e91ca000000b0026befd1112cmr11777214ljg.26.1664392203203;
        Wed, 28 Sep 2022 12:10:03 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u11-20020ac243cb000000b00497ad8e6d07sm548957lfl.222.2022.09.28.12.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:10:02 -0700 (PDT)
Message-ID: <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
Date:   Wed, 28 Sep 2022 22:10:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
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
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220928152822.30687-7-johan+linaro@kernel.org>
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
> Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> PHY is powered on before configuring the registers and only the MSM8996
> PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> initialisation table, may possibly require a second update afterwards.
> 
> To make things worse, the POWER_DOWN_CONTROL register lies at a
> different offset on more recent SoCs so that the second update, which
> still used a hard-coded offset, would write to an unrelated register
> (e.g. a revision-id register on SC8280XP).
> 
> As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> the bogus register update.
> 
> Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support

I'm not sure about the particular fixes tag. Backporting from the split 
driver into old qmp driver would be a complete pain.

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 4146545fdf5f..eea66c24cf7e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1953,12 +1953,6 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl, cfg->pcs_misc_tbl_num);
>   	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec, cfg->pcs_misc_tbl_num_sec);
>   
> -	/*
> -	 * Pull out PHY from POWER DOWN state.
> -	 * This is active low enable signal to power-down PHY.
> -	 */
> -	qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> -
>   	if (cfg->has_pwrdn_delay)
>   		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
>   

-- 
With best wishes
Dmitry

