Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855D74C6CB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGIRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGIRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:41:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52569100
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:41:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso5057427a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688924490; x=1691516490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oeKoSQqGnKyOhvK1kMTJPXEjPeVsm/hf9GdEualz/s=;
        b=vMNlkobbdhJz+MoQIMwxINl916JGFbmOshhhboGc9QS0at7vhlLfF+DcLaLhtjbtEC
         K+LG9umoc4J1NFxFsfZs0ep+c4sdpVURBXS3TVMJRuJbPnn5Gp6yicHFDVdpau0N7DJC
         sLmxR3I/Qqh92wKk4WpNNZRBOiijx1IXCzqaOwZ8d0fGrMz9XntFIYRl5/yIcjUm6Khe
         NdroJi5r7Kz0IiEoh0uNbu5bpLx0szc0plQjYFLF3AT2hBiaC3kmRGrBHnx6AC8gS0FA
         OX2jrrTKou9iskNn7vRpYdO1taGbBZVXRyq7EsU3B/YQQGWEq+/7Joe+6pNzx9L3btDh
         RSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688924490; x=1691516490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oeKoSQqGnKyOhvK1kMTJPXEjPeVsm/hf9GdEualz/s=;
        b=lslK2jjEIsI8SYWYy4/WeB0pvBAbEKDTmtp06CTjKySH0OazDl5Ga6E3rsnUHoWP3h
         Zkmzj0BCa8ZwH90/XLhA++h3WMPW7bW/jj+Sb5L+Bsb4xQ3MoOJKnSiyq1ZWZq5pi12W
         0vSNqGBTM5psHyXHDnNKBm0IEPQTRpA2n53bRPwTr0Vr4IhhTLA9NyBvAumfZL/APaVe
         aCKe6yq68SynQdiJn75BOajn7hu3+3yZXCqjmbYEF6nhcrW1GYXCUQOk7jGFf0ruRezi
         H5fs08Q/0Y3q4QM/oayiTBVE0aB7Quy8ed3IZAAB+wBax551DZVy4Uadoup+R2TzuzyD
         y/IA==
X-Gm-Message-State: ABy/qLZ1VFy3L0b9FhkgBDUsQGtYhHJkWZByClyXPC0yx3xlvwMHFIji
        vHvEeFv1SRgO0yYhzytJjFGsxA==
X-Google-Smtp-Source: APBJJlHvRXJCSdZxiouXi07KpghTnQuXPR5PnU1C68ap3XHWWr3uMG+uW1w42kwNzkNLCiNxe4U2pQ==
X-Received: by 2002:a17:906:5a6e:b0:965:9602:1f07 with SMTP id my46-20020a1709065a6e00b0096596021f07mr10035969ejc.39.1688924489848;
        Sun, 09 Jul 2023 10:41:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090638cb00b00992b510089asm5031895ejd.84.2023.07.09.10.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:41:29 -0700 (PDT)
Message-ID: <0b5771b3-31b1-c17c-2be4-9b71538078bb@linaro.org>
Date:   Sun, 9 Jul 2023 19:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/11] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-8-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-8-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS. One major difference is
> that the register interface used here is that of an SDAM present on

...


> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret, i, irq;
> +	u32 *reg;
> +	char buf[20];
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->regmap = regmap;
> +	adc->dev = dev;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->num_sdams = ret;
> +
> +	reg = devm_kcalloc(dev, adc->num_sdams, sizeof(u32), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
> +	if (ret) {
> +		dev_err(adc->dev, "Failed to read reg property, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	adc->base = devm_kcalloc(adc->dev, adc->num_sdams, sizeof(*adc->base), GFP_KERNEL);
> +	if (!adc->base)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < adc->num_sdams; i++) {
> +		adc->base[i].base_addr = reg[i];
> +
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			dev_err(adc->dev, "Failed to get SDAM%d irq, ret=%d\n", i, irq);
> +			return irq;

return dev_err_probe

> +		}
> +		adc->base[i].irq = irq;
> +
> +		scnprintf(buf, sizeof(buf), "adc-sdam%d", i);
> +		adc->base[i].irq_name = devm_kstrdup(adc->dev, buf, GFP_KERNEL);
> +		if (!adc->base[i].irq_name)
> +			return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, adc);
> +
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);
> +
> +	ret = adc5_get_fw_data(adc);
> +	if (ret < 0) {
> +		dev_err(adc->dev, "adc get dt data failed, ret=%d\n", ret);

return dev_err_probe

> +		return ret;
> +	}
> +
> +	for (i = 0; i < adc->num_sdams; i++) {
> +		ret = devm_request_irq(dev, adc->base[i].irq, adc5_gen3_isr,
> +					0, adc->base[i].irq_name, adc);
> +		if (ret < 0) {
> +			dev_err(adc->dev, "Getting IRQ %d failed, ret=%d\n", adc->base[i].irq, ret);

return dev_err_probe

> +			return ret;
> +		}
> +	}
> +
> +	ret = adc_tm_register_tzd(adc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (adc->n_tm_channels)
> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work);
> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int adc5_gen3_exit(struct platform_device *pdev)
> +{
> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
> +	u8 data = 0;
> +	int i, sdam_index;
> +
> +	mutex_lock(&adc->lock);
> +	/* Disable all available channels */
> +	for (i = 0; i < adc->num_sdams * 8; i++) {
> +		sdam_index = i / 8;
> +		data = MEAS_INT_DISABLE;
> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_TIMER_SEL, &data, 1);
> +
> +		/* To indicate there is an actual conversion request */
> +		data = ADC5_GEN3_CHAN_CONV_REQ | (i - (sdam_index * 8));
> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &data, 1);
> +
> +		data = ADC5_GEN3_CONV_REQ_REQ;
> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &data, 1);
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	if (adc->n_tm_channels)
> +		cancel_work_sync(&adc->tm_handler_work);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver adc5_gen3_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-adc5-gen3",
> +		.of_match_table = adc5_match_table,
> +	},
> +	.probe = adc5_gen3_probe,
> +	.remove = adc5_gen3_exit,
> +};
> +module_platform_driver(adc5_gen3_driver);
> +
> +MODULE_ALIAS("platform:qcom-spmi-adc5-gen3");

Drop alias. If you need it, it means you screwed ID tables or your DTS.


Best regards,
Krzysztof

