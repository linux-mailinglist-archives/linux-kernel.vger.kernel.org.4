Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A3652450
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiLTQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiLTQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:08:36 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5F1C939
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:07:15 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f16so12829904ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+rhK4g1t43gT5jBljw41PW9sxBKydEd9ihbLejf+Bg=;
        b=DfXoxiov3B7rpJToNAnhfQPdqVq1elFGK3XOHmYon2/YVkJG6JvYKeFWJ6QkfuOa/n
         JCizQaH1o64mybxlfRBsfEg4hNomLEA/b9egI9cs3zUmfSmO8dI8gLiSU1oM9E74RYbT
         D8JByaiR+EaYJ4YdtgEhh8yCHD6QyUKywTL0VIinwfWpLuPeWIIOursy+93K9UCmiSWl
         zaD0TYFWfoVUABTtFOmWaGnhWir+x7lfDyEWq8f38lMcFTDcBp1qkxnf90hUQ+1Snfwl
         rj1y7jjItvdIEGpF00XFjzlqJkSjJ2a+tWGoNWpdYC4+19yj6NPC8VfLTfEQy5o4O9hd
         wAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+rhK4g1t43gT5jBljw41PW9sxBKydEd9ihbLejf+Bg=;
        b=NQK+eQhIC7KdaMSQriwon3UuS4kWAcaop20VOjpJK5IQA55ZWhCBKJieKyNQQPmM5Z
         R3g9rZ7NxpzPER/1JLE9Q0b8NPGUBy1ATuqOWwKPMrdvxEMPEc8vmnF+Fwt83R94ccF1
         CRDa+lIdNVLLn96MX4dKGNoZX1/dbN2cmJaxv5LIDyF9bxDchX2XuICJuKV5NlW4Te/6
         U3a+p3RJtBv/QsHu82PvFK6sLk0BvSgRJDvAhQQ0CokDr4gixPy1tGN6QsM3qwEw7Scj
         0rcJTyYmUuGUCBmJCw9lsHdIejhzMqNk5Px4Yz6YOD/ow1Rwwn0NUWL4K/qv7irYPtev
         d8cA==
X-Gm-Message-State: AFqh2kroQf/4Qjch2Ya6WJ0eHS3I/aFCo/0Zkfz5i8DONJj7F3mRuRGC
        KPwYB0zjoYd5rtg+yCntPm6ElQ==
X-Google-Smtp-Source: AMrXdXug0b5wvqiwZQ+iTqRB2hD0FkG1sZFyvISQW9KdZ6u/Fptxwn7zdjfRsYursvGZXLMV+tmRAw==
X-Received: by 2002:a2e:834b:0:b0:279:c1f7:1bfd with SMTP id l11-20020a2e834b000000b00279c1f71bfdmr792357ljh.30.1671552430117;
        Tue, 20 Dec 2022 08:07:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q14-20020a2eb4ae000000b002790fbb5f89sm1057925ljm.44.2022.12.20.08.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 08:07:09 -0800 (PST)
Message-ID: <bf84b93c-0b24-99f6-9c70-2f4c677cff18@linaro.org>
Date:   Tue, 20 Dec 2022 17:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ALSA SoC: Texas Instruments TAS2781 Audio Smart Amp
Content-Language: en-US
To:     Kevin Lu <luminlong@139.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, navada@ti.com, peeyush@ti.com
References: <20221220144203.2194-1-luminlong@139.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220144203.2194-1-luminlong@139.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 15:42, Kevin Lu wrote:
> The TAS2781 driver implements a flexible and configurable register setting
> for one, two, even multiple TAS2781 chips. All the register setting are in
> a bin file. Almost no specific register setting can be found in the code.
> 
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  sound/soc/codecs/Kconfig       |   13 +
>  sound/soc/codecs/Makefile      |    2 +
>  sound/soc/codecs/tas2781-dsp.c | 2483 ++++++++++++++++++++++++++++++++
>  sound/soc/codecs/tas2781-dsp.h |  213 +++
>  sound/soc/codecs/tas2781-i2c.c | 2143 +++++++++++++++++++++++++++
>  sound/soc/codecs/tas2781.h     |  208 +++
>  6 files changed, 5062 insertions(+)
>  create mode 100644 sound/soc/codecs/tas2781-dsp.c
>  create mode 100644 sound/soc/codecs/tas2781-dsp.h
>  create mode 100644 sound/soc/codecs/tas2781-i2c.c
>  create mode 100644 sound/soc/codecs/tas2781.h

Your threading and patch formatting is broken. Read before sending patches:
https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst

> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 7022e6286..31d2d9594 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -222,6 +222,7 @@ config SND_SOC_ALL_CODECS
>  	imply SND_SOC_TAS2764
>  	imply SND_SOC_TAS2770
>  	imply SND_SOC_TAS2780
> +	imply SND_SOC_TAS2781
>  	imply SND_SOC_TAS5086
>  	imply SND_SOC_TAS571X
>  	imply SND_SOC_TAS5720
> @@ -1573,6 +1574,18 @@ config SND_SOC_TAS2780
>  	  Enable support for Texas Instruments TAS2780 high-efficiency
>  	  digital input mono Class-D audio power amplifiers.
>  

(...)

> +static struct i2c_driver tasdevice_i2c_driver = {
> +	.driver = {
> +		.name = "tas2781-codec",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(tasdevice_of_match),
> +		.pm = &tasdevice_pm_ops,
> +	},
> +	.probe	= tasdevice_i2c_probe,
> +	.remove = tasdevice_i2c_remove,
> +	.id_table = tasdevice_id,
> +};
> +
> +module_i2c_driver(tasdevice_i2c_driver);
> +
> +MODULE_AUTHOR("Shenghao Ding <shenghao-ding@ti.com>");
> +MODULE_AUTHOR("Kevin Lu <kevin-lu@ti.com>");
> +MODULE_DESCRIPTION("ASoC TAS2781 Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/tas2781.h b/sound/soc/codecs/tas2781.h
> new file mode 100644
> index 000000000..db4ec752b
> --- /dev/null
> +++ b/sound/soc/codecs/tas2781.h
> @@ -0,0 +1,208 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
> + *
> + * Copyright (C) 2022 - 2023 Texas Instruments Incorporated
> + * https://www.ti.com
> + *
> + * The TAS2781 driver implements a flexible and configurable register setting
> + * for one, two, even multiple TAS2781 chips. All the register setting are in
> + * a bin file. Almost no specific register setting can be found in the code.
> + *
> + * Author: Shenghao Ding <shenghao-ding@ti.com>
> + *         Kevin Lu <kevin-lu@ti.com>
> + */
> +
> +#ifndef __TAS2781_H__
> +#define __TAS2781_H__
> +
> +#include "tas2781-dsp.h"
> +
> +#define SMARTAMP_MODULE_NAME	("tas2781")

This does not belong to headers.

> +#define MAX_LENGTH				(128)

Why () ?

> +
> +#define TASDEVICE_RETRY_COUNT	(3)
> +#define TASDEVICE_ERROR_FAILED	(-2)
> +
> +#define TASDEVICE_RATES	(SNDRV_PCM_RATE_44100 |\
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |\
> +	SNDRV_PCM_RATE_88200)
> +#define TASDEVICE_MAX_CHANNELS (8)
> +
> +#define TASDEVICE_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
> +	SNDRV_PCM_FMTBIT_S24_LE | \
> +	SNDRV_PCM_FMTBIT_S32_LE)
> +
> +/*PAGE Control Register (available in page0 of each book) */

Missing space

> +#define TASDEVICE_PAGE_SELECT	(0x00)
> +#define TASDEVICE_BOOKCTL_PAGE	(0x00)
> +#define TASDEVICE_BOOKCTL_REG	(127)
> +#define TASDEVICE_BOOK_ID(reg)		(reg / (256 * 128))
> +#define TASDEVICE_PAGE_ID(reg)		((reg % (256 * 128)) / 128)
> +#define TASDEVICE_PAGE_REG(reg)		((reg % (256 * 128)) % 128)
> +#define TASDEVICE_REG(book, page, reg)	(((book * 256 * 128) + \
> +					(page * 128)) + reg)
> +
> +	/*Software Reset */

Wrong coding style.

> +#define TAS2871_REG_SWRESET  TASDEVICE_REG(0x0, 0X0, 0x02)
> +#define TAS2871_REG_SWRESET_RESET  (0x1 << 0)
> +
> +	/* Enable Global addresses */

Wrong coding style.

> +#define TAS2871_MISC_CFG2  TASDEVICE_REG(0x0, 0X0, 0x07)
> +#define TAS2871_GLOBAL_MASK (0x1 << 1)
> +
> +#define SMS_HTONS(a, b)  ((((a)&0x00FF)<<8) | \
> +				((b)&0x00FF))
> +#define SMS_HTONL(a, b, c, d) ((((a)&0x000000FF)<<24) |\
> +					(((b)&0x000000FF)<<16) | \
> +					(((c)&0x000000FF)<<8) | \
> +					((d)&0x000000FF))
> +
> +	/*I2C Checksum */
> +#define TASDEVICE_I2CChecksum  TASDEVICE_REG(0x0, 0x0, 0x7E)
> +
> +	/* Volume control */
> +#define TAS2781_DVC_LVL TASDEVICE_REG(0x0, 0x0, 0x1A)
> +#define TAS2781_AMP_LEVEL TASDEVICE_REG(0x0, 0x0, 0x03)
> +#define TAS2781_AMP_LEVEL_MASK GENMASK(5, 1)
> +
> +#define TASDEVICE_CMD_SING_W  (0x1)
> +#define TASDEVICE_CMD_BURST  (0x2)
> +#define TASDEVICE_CMD_DELAY  (0x3)
> +#define TASDEVICE_CMD_FIELD_W  (0x4)
> +
> +enum audio_device {
> +	GENERAL_AUDEV = 0,
> +	TAS2781	  = 1,
> +};
> +
> +struct smartpa_gpio_info {
> +	unsigned char ndev;
> +	int mnResetGpio[MaxChn];
> +};
> +
> +#define SMS_HTONS(a, b)  ((((a)&0x00FF)<<8) | ((b)&0x00FF))
> +#define SMS_HTONL(a, b, c, d) ((((a)&0x000000FF)<<24) | \
> +	(((b)&0x000000FF)<<16) | (((c)&0x000000FF)<<8) | \
> +	((d)&0x000000FF))
> +
> +struct Tbookpage {
> +	unsigned char mnBook;
> +	unsigned char mnPage;
> +};
> +
> +struct Ttasdevice {
> +	unsigned int mnDevAddr;
> +	unsigned int mnErrCode;
> +	short mnCurrentProgram;
> +	short mnCurrentConfiguration;
> +	short mnCurrentRegConf;
> +	int mnIRQGPIO;
> +	int mnResetGpio;
> +	int mn_irq;
> +	int PowerStatus;
> +	bool bDSPBypass;
> +	bool bIrq_enabled;
> +	bool bLoading;
> +	bool bLoaderr;
> +	bool mbCalibrationLoaded;
> +	struct Tbookpage mnBkPg;
> +	struct TFirmware *mpCalFirmware;
> +};
> +
> +struct global_addr {
> +	struct Tbookpage mnBkPg;
> +	unsigned int mnDevAddr;
> +	int ref_cnt;
> +};
> +
> +struct tas_control {
> +	struct snd_kcontrol_new *tasdevice_profile_controls;
> +	int nr_controls;
> +};
> +
> +struct tasdevice_irqinfo {
> +	int mn_irq_gpio;
> +	int mn_irq;
> +	struct delayed_work irq_work;
> +	bool mb_irq_enable;
> +};
> +
> +struct tasdevice_priv {
> +	struct device *dev;
> +	void *client;
> +	struct regmap *regmap;
> +	struct mutex codec_lock;
> +	struct mutex dev_lock;
> +	struct Ttasdevice tasdevice[MaxChn];
> +	struct TFirmware *mpFirmware;
> +	struct tasdevice_regbin mtRegbin;
> +	struct smartpa_gpio_info mtRstGPIOs;
> +	struct tasdevice_irqinfo mIrqInfo;
> +	struct tas_control tas_ctrl;
> +	struct global_addr glb_addr;
> +	int mnCurrentProgram;
> +	int mnCurrentConfiguration;
> +	unsigned int chip_id;
> +	int (*read)(struct tasdevice_priv *tas_dev, enum channel chn,
> +		unsigned int reg, unsigned int *pValue);
> +	int (*write)(struct tasdevice_priv *tas_dev, enum channel chn,
> +		unsigned int reg, unsigned int Value);
> +	int (*bulk_read)(struct tasdevice_priv *tas_dev, enum channel chn,
> +		unsigned int reg, unsigned char *pData, unsigned int len);
> +	int (*bulk_write)(struct tasdevice_priv *tas_dev, enum channel chn,
> +		unsigned int reg, unsigned char *pData, unsigned int len);
> +	int (*set_calibration)(void *tas_dev, enum channel chl,
> +		int calibration);
> +	void (*tas2781_reset)(struct tasdevice_priv *tas_dev);
> +	void (*tas2781_set_global)(struct tasdevice_priv *tas_dev);
> +	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_dev,
> +		const struct firmware *pFW, int offset);
> +	int (*fw_parse_program_data)(struct tasdevice_priv *tas_dev,
> +		struct TFirmware *pFirmware,
> +		const struct firmware *pFW, int offset);
> +	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_dev,
> +		struct TFirmware *pFirmware,
> +		const struct firmware *pFW, int offset);
> +	int (*tasdevice_load_block)(struct tasdevice_priv *tas_dev,
> +		struct TBlock *pBlock);
> +	int (*fw_parse_calibration_data)(struct tasdevice_priv *tas_dev,
> +		struct TFirmware *pFirmware,
> +		const struct firmware *pFW, int offset);
> +	void (*irq_work_func)(struct tasdevice_priv *tas_dev);
> +	int fw_state;
> +	unsigned int magic_num;
> +	unsigned char ndev;
> +	unsigned char dev_name[32];
> +	unsigned char regbin_binaryname[64];
> +	unsigned char dsp_binaryname[64];
> +	unsigned char cal_binaryname[MaxChn][64];
> +	bool mb_runtime_suspend;
> +	struct delayed_work powercontrol_work;
> +	void *codec;
> +	int sysclk;
> +	int pstream;
> +	int cstream;
> +	bool mbCalibrationLoaded;

You need to adjust your coding style to Linux. This is some C++ crap.


Best regards,
Krzysztof

