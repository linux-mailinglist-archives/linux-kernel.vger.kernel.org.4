Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A544768D07D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBGHXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBGHXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:23:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971DD2ED62
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:23:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g6so4607437wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQitbnxCpMivjKxe2oQOuZ6YvDuYr5hFK9LcyU5cdAA=;
        b=tTuTreXltUzh9WcUcDrT+es8CzEbpLPqYCq9t/Wx8YcJFF3PgxxhTKXLdKjd9+EmiX
         r8nVrdlP7jx8PcRFpfzpAclGjLVuEeQHU2L0poYXHdP4k3Jfx6NcHxZD6cClIqy/s2Yc
         /u57cWIF1Y82B04sXt5rO/YJGGFU305UrvTfhtx2zquf5vTu2tI2T5AUwkrYD10MG65B
         c6Qa+bu9uYq/082q5txu+KJ0hRtrICfHH1T+X0muO8Lhvs7kJ0K2mUAFIYwoyixfsboz
         Czs3uV3D+ZdOG55lwjCGawhQ46uzS3d8zgHmNnC3x5KivOkR9Y0TcjtxQisu1diM35Jv
         iQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQitbnxCpMivjKxe2oQOuZ6YvDuYr5hFK9LcyU5cdAA=;
        b=XqiUXL8uTvnw5rxG/Y0w2E52PZD2lvdKw+ckzLSZ2c3pPlZsvuyt8/MxjbHwHLZ889
         vNvi9heLqlVoq7M8teC/wcMz/Yuv9cy7L5Yx0jc6yZ7Mwf4fHI+dLRf1rTRiPNiOOstG
         BG9CtacX3r73ekQeg9SVtfrHOQp+Lz8bp5gCkAEYKQ5hQOtLYNG6mMqAX17AjMPVzlSJ
         92+h/77vQgfYgsWrGSkwmvN9Y+uGM8qImm/DMZTASYOqYwQoj8BpjxzCLd2T7TQR21qP
         EDdln0TH7T276GT1fNoE0P9TQ20jUgGJK+3u8+/gnA33TONLv7RjFuTPVC0EdgjtNUmA
         6Ltg==
X-Gm-Message-State: AO0yUKVR4lvL/qOXFEz6C5cOlrQ8fYZR5fiwCDfPmC//eogv38H+bekl
        Ob4f5gPQ9pkvN9LdgcP1U53iow==
X-Google-Smtp-Source: AK7set891brjIkXxfIlhrt/+o8ewJiLPWvdwqvX6E/SDlSZsIbChWcYOhYFUx815zAuwNKAgrmIISw==
X-Received: by 2002:adf:f6cb:0:b0:2bf:b77d:c5b9 with SMTP id y11-20020adff6cb000000b002bfb77dc5b9mr1688810wrp.14.1675754599075;
        Mon, 06 Feb 2023 23:23:19 -0800 (PST)
Received: from [192.168.0.104] ([82.77.80.113])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b002c3e9cce04csm4109414wrt.111.2023.02.06.23.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 23:23:18 -0800 (PST)
Message-ID: <ecef06bb-8710-e3b6-5068-68a59b4e4eff@linaro.org>
Date:   Tue, 7 Feb 2023 07:23:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] spi: cadence-quadspi: Add Rx tuning support for
 Xilinx Versal OSPI
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20230207060924.265789-1-sai.krishna.potthuri@amd.com>
 <20230207060924.265789-4-sai.krishna.potthuri@amd.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230207060924.265789-4-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/23 06:09, Sai Krishna Potthuri wrote:
> Add Rx tuning support for Xilinx Versal Octal SPI Controller(OSPI).
> Xilinx Versal Octal SPI controller requires Rx tuning to find out the
> optimal tap value when running at higher clock in DTR protocol. As there

Is the tunning required just for DTR? Is STR spared of the tunning
requirements? Because as of now, we use the maximum supported flash 
speed from the begining and we don't change it.

An option is to start the NOR flash with min(max-flash-freq, 50 MHz), do
the read ID, SFDP read, golden pattern read, increase the freq to the
max-flash-freq, then do the calibration. The golden pattern must not
necessarily be a OTP-like data (ID, SFDP, OTP), we can reserve a portion
of the flash (non - OTP) for the golden pattern, can't we?

> is no common Tuning Data Pattern defined across all vendors, Xilinx Versal
> Octal SPI uses READ_ID based tuning algorithm for which this device_id
> field in spi_mem will be used as a Tuning data pattern.
> After enabling the DTR protocol, spi-nor sends READ ID command to verify
> the DTR protocol switching is successfully done or not. If execute_tuning
> is defined(not NULL) and clk_tuned is not set then Rx tuning algorithm

looks hackish, an explicit call to a phy-calibrate method would be
better IMO.

Cheers,
ta
> will be executed before it actually read the ID in DTR protocol.
> Xilinx Versal tuning algorithm (as suggested by IP design team):
> - Sweep all possible 127 taps to read the flash id for each tap.
> - To consider a particular tap as valid make sure to get the correct id
> for 10 times.
> - Once valid window is found(window size >= 3), stop parsing the
> remaining taps.
> - Perform the above steps with extra dummy clock 1.
> - Identify the maximum window size between extra dummy clock 0 and 1 and
> configure the median of min and max valid tap of the corresponding window.
> - If the maximum window size is with dummy clock 1 then all the subsequent
> read operations should be performed with one extra dummy clock.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>   drivers/spi/spi-cadence-quadspi.c | 201 ++++++++++++++++++++++++++++++
>   1 file changed, 201 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index b55b763003f0..bc4395736def 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -93,6 +93,8 @@ struct cqspi_st {
>   	bool			slow_sram;
>   	bool			use_phy;
>   	bool			use_dqs;
> +	bool			clk_tuned;
> +	u8			extra_dummy_clks;
>   };
>   
>   struct cqspi_driver_platdata {
> @@ -101,6 +103,7 @@ struct cqspi_driver_platdata {
>   	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
>   				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
>   	u32 (*get_dma_status)(struct cqspi_st *cqspi);
> +	int (*execute_tuning)(struct spi_mem *mem, const struct spi_mem_op *op);
>   };
>   
>   /* Operation timeout value */
> @@ -192,6 +195,7 @@ struct cqspi_driver_platdata {
>   
>   #define CQSPI_REG_IRQSTATUS			0x40
>   #define CQSPI_REG_IRQMASK			0x44
> +#define CQSPI_REG_VERSAL_ECO			0x48
>   
>   #define CQSPI_REG_INDIRECTRD			0x60
>   #define CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
> @@ -238,6 +242,19 @@ struct cqspi_driver_platdata {
>   #define CQSPI_REG_POLLING_STATUS		0xB0
>   #define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
>   
> +#define CQSPI_REG_VERSAL_PHY_CONFIG		0xB4
> +#define CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK	BIT(31)
> +#define CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK	BIT(30)
> +#define CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB	16
> +
> +#define CQSPI_REG_VERSAL_PHY_MASTER_CTRL	0xB8
> +#define CQSPI_REG_DLL_LOWER			0xBC
> +#define CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK	BIT(15)
> +#define CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK	BIT(0)
> +
> +#define CQSPI_REG_VERSAL_DLL_OBSVBLE_UPPER	0xC0
> +#define CQSPI_REG_DLL_UPPER_RX_FLD_MASK		0x7F
> +
>   #define CQSPI_REG_OP_EXT_LOWER			0xE0
>   #define CQSPI_REG_OP_EXT_READ_LSB		24
>   #define CQSPI_REG_OP_EXT_WRITE_LSB		16
> @@ -282,6 +299,12 @@ struct cqspi_driver_platdata {
>   #define CQSPI_DMA_UNALIGN		0x3
>   
>   #define CQSPI_REG_VERSAL_DMA_VAL		0x602
> +#define CQSPI_VERSAL_MAX_DLL_TAPS		127
> +#define CQSPI_VERSAL_TX_TAP_MASTER		0x1E
> +#define CQSPI_VERSAL_ECO_MIN_FREQ		120000000
> +#define CQSPI_VERSAL_INIT_DLY			4
> +#define CQSPI_VERSAL_RDID_MAX_CNT		10
> +#define CQSPI_VERSAL_MIN_WINDOW_SZ		3
>   
>   static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
>   {
> @@ -540,6 +563,14 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
>   	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
>   		return -EOPNOTSUPP;
>   
> +	/*
> +	 * Based on the tuning, some controllers requires extra dummy clocks due to additional
> +	 * delays in read path. For such controllers add required extra dummy clocks for all
> +	 * subsequent read operations.
> +	 */
> +	if (cqspi->extra_dummy_clks)
> +		dummy_clk += cqspi->extra_dummy_clks;
> +
>   	if (dummy_clk)
>   		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
>   		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
> @@ -662,6 +693,14 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
>   	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
>   		return -EOPNOTSUPP;
>   
> +	/*
> +	 * Based on the tuning, some controllers requires extra dummy clocks due to additional
> +	 * delays in read path. For such controllers add required extra dummy clocks for all
> +	 * subsequent read operations.
> +	 */
> +	if (cqspi->extra_dummy_clks)
> +		dummy_clk += cqspi->extra_dummy_clks;
> +
>   	if (dummy_clk)
>   		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
>   		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
> @@ -1056,6 +1095,157 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>   	return ret;
>   }
>   
> +static int cqspi_versal_execute_tuning(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
> +	u8 dummy_incr, dummy_flag = 0, count, max_index, min_index;
> +	u8 min_rxtap, max_rxtap, avg_index, max_tap, windowsize;
> +	struct platform_device *pdev = cqspi->pdev;
> +	struct cqspi_flash_pdata *f_pdata;
> +	bool id_matched, rxtapfound;
> +	u32 val, i, reg, txtap = 0;
> +	s8 max_windowsize = -1;
> +	int ret;
> +
> +	f_pdata = &cqspi->f_pdata[mem->spi->chip_select];
> +
> +	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> +	reg &= CQSPI_REG_CONFIG_ENABLE_MASK;
> +	if (!reg)
> +		return 0;
> +
> +	if (cqspi->master_ref_clk_hz >= CQSPI_VERSAL_ECO_MIN_FREQ)
> +		writel(1, cqspi->iobase + CQSPI_REG_VERSAL_ECO);
> +
> +	/* Drive DLL reset bit to low */
> +	writel(0, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +
> +	/* Set initial delay value */
> +	writel(CQSPI_VERSAL_INIT_DLY, cqspi->iobase + CQSPI_REG_VERSAL_PHY_MASTER_CTRL);
> +
> +	/* Set DLL reset bit */
> +	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
> +	       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +
> +	/* Check for loopback lock */
> +	ret = cqspi_wait_for_bit(cqspi->iobase + CQSPI_REG_DLL_LOWER,
> +				 CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK, 0);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Loopback lock bit error (%i)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Re-synchronize slave DLLs */
> +	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK | CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK,
> +	       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +
> +	txtap = CQSPI_VERSAL_TX_TAP_MASTER << CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB;
> +	max_tap = CQSPI_VERSAL_MAX_DLL_TAPS;
> +
> +	for (dummy_incr = 0; dummy_incr <= 1; dummy_incr++) {
> +		/* Update the extra dummy clocks required to read the ID */
> +		cqspi->extra_dummy_clks = dummy_incr;
> +		rxtapfound = false;
> +		min_rxtap = 0;
> +		max_rxtap = 0;
> +		max_index = 0;
> +		min_index = 0;
> +
> +		for (i = 0; i <= max_tap; i++) {
> +			val = txtap | i | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK;
> +			writel(val, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +			writel(val | CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK,
> +			       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +			ret = cqspi_wait_for_bit(cqspi->iobase + CQSPI_REG_DLL_LOWER,
> +						 CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK, 0);
> +			if (ret)
> +				return ret;
> +
> +			/*
> +			 * To consider the tap as valid, make sure to read the Flash ID
> +			 * 10 times(recommended by IP design team). This makes the algorithm more
> +			 * robust and gives more confidence about the valid tap, this will also
> +			 * avoid getting the correct id by a fluke with a particular tap.
> +			 * In any one of the iteration if the Flash ID is not matches with the
> +			 * device_id, then that particular tap should not be considered as valid.
> +			 */
> +			count = 0;
> +			do {
> +				/* Execute the command and wait for the complete */
> +				ret = cqspi_command_read(f_pdata, op);
> +				if (ret < 0) {
> +					dev_err(&pdev->dev,
> +						"error %d reading JEDEC ID\n", ret);
> +					return ret;
> +				}
> +
> +				id_matched = true;
> +				if (memcmp(mem->device_id, op->data.buf.in, op->data.nbytes)) {
> +					id_matched = false;
> +					break;
> +				}
> +			} while (id_matched && (count++ <= CQSPI_VERSAL_RDID_MAX_CNT));
> +
> +			if (id_matched) {
> +				u8 current_rxtap = readl(cqspi->iobase +
> +							 CQSPI_REG_VERSAL_DLL_OBSVBLE_UPPER) &
> +							 CQSPI_REG_DLL_UPPER_RX_FLD_MASK;
> +
> +				if (!rxtapfound) {
> +					min_rxtap = current_rxtap;
> +					min_index = i;
> +					rxtapfound = true;
> +				}
> +
> +				max_rxtap = current_rxtap;
> +				max_index = i;
> +			}
> +
> +			if (!rxtapfound)
> +				continue;
> +
> +			/* If ID doesn't match or reach the max tap, calculate the window size */
> +			if (!id_matched || i == max_tap) {
> +				windowsize = max_rxtap - min_rxtap + 1;
> +				if (windowsize > max_windowsize) {
> +					dummy_flag = dummy_incr;
> +					max_windowsize = windowsize;
> +					avg_index = (max_index + min_index) / 2;
> +				}
> +
> +				rxtapfound = false;
> +				if (windowsize >= CQSPI_VERSAL_MIN_WINDOW_SZ)
> +					break;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * Look for minimum window size to ensure reliable data sampling even during drifts due
> +	 * to PVT, so that a drift either towards left or right can be well addressed.
> +	 */
> +	if (max_windowsize < CQSPI_VERSAL_MIN_WINDOW_SZ)
> +		return -EINVAL;
> +
> +	/* Update the extra dummy clocks based on the maximum window size */
> +	cqspi->extra_dummy_clks = dummy_flag;
> +
> +	val = txtap | avg_index | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK;
> +	writel(val, cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +	writel((CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK | val),
> +	       cqspi->iobase + CQSPI_REG_VERSAL_PHY_CONFIG);
> +
> +	ret = cqspi_wait_for_bit(cqspi->iobase + CQSPI_REG_DLL_LOWER,
> +				 CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	cqspi->clk_tuned = true;
> +
> +	return 0;
> +}
> +
>   static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>   {
>   	struct cqspi_st *cqspi = f_pdata->cqspi;
> @@ -1345,11 +1535,21 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
>   static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
>   {
>   	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
> +	const struct cqspi_driver_platdata *ddata;
> +	struct device *dev = &cqspi->pdev->dev;
>   	struct cqspi_flash_pdata *f_pdata;
>   
> +	ddata = of_device_get_match_data(dev);
>   	f_pdata = &cqspi->f_pdata[mem->spi->chip_select];
>   	cqspi_configure(f_pdata, mem->spi->max_speed_hz);
>   
> +	if (op->cmd.dtr && ddata && ddata->execute_tuning && !cqspi->clk_tuned) {
> +		int ret = ddata->execute_tuning(mem, op);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
>   		if (!op->addr.nbytes)
>   			return cqspi_command_read(f_pdata, op);
> @@ -1846,6 +2046,7 @@ static const struct cqspi_driver_platdata versal_ospi = {
>   			| CQSPI_HAS_PHY | CQSPI_HAS_DQS,
>   	.indirect_read_dma = cqspi_versal_indirect_read_dma,
>   	.get_dma_status = cqspi_get_versal_dma_status,
> +	.execute_tuning = cqspi_versal_execute_tuning,
>   };
>   
>   static const struct of_device_id cqspi_dt_ids[] = {
