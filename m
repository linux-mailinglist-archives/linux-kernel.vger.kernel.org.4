Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587C688E01
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBCDcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjBCDcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:32:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB03210B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:31:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw12so11937956ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 19:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3U+VBc+U8900xd5EAE+/o092MReN2kqBrk9eevhvIKU=;
        b=low5lDLusr3RQ+ufb4mgQmtlD+OkztWKTyxvaV0jR+lH2ApeK7vCMb7vBNCX0Yw5eN
         BKQk+annfE09U8uu/fpXWvPvK2CcpXPQyX3b0v1Cde5GmA+g+QWYbOfrl4B15c/2nqB8
         j3/IZBcn2TRyDfcnuYjVKcJRl6rvRrpG2YJPNZKFIO3a1eqWRcrEFsFUw8NqnLeFtXQq
         YDVpuuAuz9dIQB2GqtoS84ysImXccRKWgGauXdk5mZgeky48OzvhvQAkY350XMApp61D
         ny7+B19aAmc8fDm5pRBcDgFUO/ynEIf2xu2NlUUJDfyWr9aSxLuJyLn2058MSC8Is7Zd
         tXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3U+VBc+U8900xd5EAE+/o092MReN2kqBrk9eevhvIKU=;
        b=G+aFc8kJgH4GDgxrvy5uEWJyZP2ZUX66gExKBq9kOCLKOnNhpPgqYvo2zhV0iVk8NA
         qZeLSI4EB/Ebry1EnYe2KbjtGMEd7dcDQYJYeY/A6pLTHqsLaKDtKfce5YfhTB58UnZo
         usjVMd906qGjHvZaYV1H1IgoJfv2gnBleQeZuo2JGc6JDE2SnabCe8cu3JZPAkNM0T3+
         ZJOADbB1PNkZh5g6hI4J33XkyeBtB35ZjeBoAM1hvVvfzKwsnzKlttXS3TGtAeY9rfds
         e3ynH0QqE0DrTAM9HYD2l+PEvPEex/DMRHFj6xHylKXZInKOiQqb8nBDyZBP6ycXxdwx
         L1zg==
X-Gm-Message-State: AO0yUKU9Q3fnRHV94hdNFXIOT8qRepAMbdxSTwLzCtdP0AaFxsCFWqJi
        eDg1JD4T5nAo36IbHYDQ6gnLbQ==
X-Google-Smtp-Source: AK7set+a2b1QYPixHmpV/BoB+ddXv4X+iXvFucmfpHR9OC/m2Llgni6j4LO+C7y0u6t3cxpX5CJ/yQ==
X-Received: by 2002:a17:907:2c49:b0:887:2248:efd5 with SMTP id hf9-20020a1709072c4900b008872248efd5mr9230647ejc.77.1675395116303;
        Thu, 02 Feb 2023 19:31:56 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906318c00b0088b93bfa765sm698374ejy.138.2023.02.02.19.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 19:31:56 -0800 (PST)
Message-ID: <8a3eb2d3-5cdf-8bdb-63f5-ab89798d38e6@linaro.org>
Date:   Fri, 3 Feb 2023 04:31:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 17/22] rtc: pm8xxx: add support for nvmem offset
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-18-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230202155448.6715-18-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 16:54, Johan Hovold wrote:
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset
> needs be stored in some machine-specific non-volatile memory, which the
> driver can take into account.
> 
> Add support for storing a 32-bit offset from the Epoch in an nvmem cell
> so that the RTC time can be set on such platforms.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
That's gonna be a stupid question, but just to make sure..

SDAM is rewritable, right? So that when somebody sets the time to
year 2077 by mistake, they won't have to put up with it for the next
50 years? :D

Konrad
>  drivers/rtc/rtc-pm8xxx.c | 141 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 129 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index eff2782beeed..372494e82f40 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -1,8 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> +/*
> + * pm8xxx RTC driver
> + *
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
>   */
>  #include <linux/of.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/init.h>
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
> @@ -49,6 +54,8 @@ struct pm8xxx_rtc_regs {
>   * @alarm_irq:		alarm irq number
>   * @regs:		register description
>   * @dev:		device structure
> + * @nvmem_cell:		nvmem cell for offset
> + * @offset:		offset from epoch in seconds
>   */
>  struct pm8xxx_rtc {
>  	struct rtc_device *rtc;
> @@ -57,8 +64,60 @@ struct pm8xxx_rtc {
>  	int alarm_irq;
>  	const struct pm8xxx_rtc_regs *regs;
>  	struct device *dev;
> +	struct nvmem_cell *nvmem_cell;
> +	u32 offset;
>  };
>  
> +static int pm8xxx_rtc_read_nvmem_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	size_t len;
> +	void *buf;
> +	int rc;
> +
> +	buf = nvmem_cell_read(rtc_dd->nvmem_cell, &len);
> +	if (IS_ERR(buf)) {
> +		rc = PTR_ERR(buf);
> +		dev_dbg(rtc_dd->dev, "failed to read nvmem offset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (len != sizeof(u32)) {
> +		dev_dbg(rtc_dd->dev, "unexpected nvmem cell size %zu\n", len);
> +		kfree(buf);
> +		return -EINVAL;
> +	}
> +
> +	rtc_dd->offset = get_unaligned_le32(buf);
> +
> +	kfree(buf);
> +
> +	return 0;
> +}
> +
> +static int pm8xxx_rtc_write_nvmem_offset(struct pm8xxx_rtc *rtc_dd, u32 offset)
> +{
> +	u8 buf[sizeof(u32)];
> +	int rc;
> +
> +	put_unaligned_le32(offset, buf);
> +
> +	rc = nvmem_cell_write(rtc_dd->nvmem_cell, buf, sizeof(buf));
> +	if (rc < 0) {
> +		dev_dbg(rtc_dd->dev, "failed to write nvmem offset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pm8xxx_rtc_read_offset(struct pm8xxx_rtc *rtc_dd)
> +{
> +	if (!rtc_dd->nvmem_cell)
> +		return 0;
> +
> +	return pm8xxx_rtc_read_nvmem_offset(rtc_dd);
> +}
> +
>  static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
>  {
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
> @@ -90,6 +149,33 @@ static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
>  	return 0;
>  }
>  
> +static int pm8xxx_rtc_update_offset(struct pm8xxx_rtc *rtc_dd, u32 secs)
> +{
> +	u32 raw_secs;
> +	u32 offset;
> +	int rc;
> +
> +	if (!rtc_dd->nvmem_cell)
> +		return -ENODEV;
> +
> +	rc = pm8xxx_rtc_read_raw(rtc_dd, &raw_secs);
> +	if (rc)
> +		return rc;
> +
> +	offset = secs - raw_secs;
> +
> +	if (offset == rtc_dd->offset)
> +		return 0;
> +
> +	rc = pm8xxx_rtc_write_nvmem_offset(rtc_dd, offset);
> +	if (rc)
> +		return rc;
> +
> +	rtc_dd->offset = offset;
> +
> +	return 0;
> +}
> +
>  /*
>   * Steps to write the RTC registers.
>   * 1. Disable alarm if enabled.
> @@ -99,23 +185,15 @@ static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
>   * 5. Enable rtc if disabled in step 2.
>   * 6. Enable alarm if disabled in step 1.
>   */
> -static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +static int __pm8xxx_rtc_set_time(struct pm8xxx_rtc *rtc_dd, u32 secs)
>  {
> -	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
>  	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
>  	u8 value[NUM_8_BIT_RTC_REGS];
>  	bool alarm_enabled;
> -	u32 secs;
>  	int rc;
>  
> -	if (!rtc_dd->allow_set_time)
> -		return -ENODEV;
> -
> -	secs = rtc_tm_to_time64(tm);
>  	put_unaligned_le32(secs, value);
>  
> -	dev_dbg(dev, "set time: %ptRd %ptRt (%u)\n", tm, tm, secs);
> -
>  	rc = regmap_update_bits_check(rtc_dd->regmap, regs->alarm_ctrl,
>  				      regs->alarm_en, 0, &alarm_enabled);
>  	if (rc)
> @@ -158,6 +236,27 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return 0;
>  }
>  
> +static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
> +	u32 secs;
> +	int rc;
> +
> +	secs = rtc_tm_to_time64(tm);
> +
> +	if (rtc_dd->allow_set_time)
> +		rc = __pm8xxx_rtc_set_time(rtc_dd, secs);
> +	else
> +		rc = pm8xxx_rtc_update_offset(rtc_dd, secs);
> +
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(dev, "set time: %ptRd %ptRt (%u + %u)\n", tm, tm,
> +			secs - rtc_dd->offset, rtc_dd->offset);
> +	return 0;
> +}
> +
>  static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
> @@ -168,10 +267,11 @@ static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	if (rc)
>  		return rc;
>  
> +	secs += rtc_dd->offset;
>  	rtc_time64_to_tm(secs, tm);
>  
> -	dev_dbg(dev, "read time: %ptRd %ptRt (%u)\n", tm, tm, secs);
> -
> +	dev_dbg(dev, "read time: %ptRd %ptRt (%u + %u)\n", tm, tm,
> +			secs - rtc_dd->offset, rtc_dd->offset);
>  	return 0;
>  }
>  
> @@ -184,6 +284,7 @@ static int pm8xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  	int rc;
>  
>  	secs = rtc_tm_to_time64(&alarm->time);
> +	secs -= rtc_dd->offset;
>  	put_unaligned_le32(secs, value);
>  
>  	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl,
> @@ -223,6 +324,7 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
>  		return rc;
>  
>  	secs = get_unaligned_le32(value);
> +	secs += rtc_dd->offset;
>  	rtc_time64_to_tm(secs, &alarm->time);
>  
>  	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
> @@ -378,9 +480,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
>  						      "allow-set-time");
>  
> +	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");
> +	if (IS_ERR(rtc_dd->nvmem_cell)) {
> +		rc = PTR_ERR(rtc_dd->nvmem_cell);
> +		if (rc != -ENOENT)
> +			return rc;
> +		rtc_dd->nvmem_cell = NULL;
> +	}
> +
>  	rtc_dd->regs = match->data;
>  	rtc_dd->dev = &pdev->dev;
>  
> +	if (!rtc_dd->allow_set_time) {
> +		rc = pm8xxx_rtc_read_offset(rtc_dd);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = pm8xxx_rtc_enable(rtc_dd);
>  	if (rc)
>  		return rc;
> @@ -435,3 +551,4 @@ MODULE_ALIAS("platform:rtc-pm8xxx");
>  MODULE_DESCRIPTION("PMIC8xxx RTC driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Anirudh Ghayal <aghayal@codeaurora.org>");
> +MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
