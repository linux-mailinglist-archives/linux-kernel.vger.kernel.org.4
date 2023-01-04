Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEC65CE75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjADIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjADIjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:39:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E265D1A391
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:39:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o15so25012478wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8M4iGpO9e7b2cQQvu3ijDQSMC1UJ28r1PJjopN7UEUQ=;
        b=Zq/1/TKDbuZmK4ywvygwb9EcdYZHPGyoydny94EyBFfGfQJ5xeDEWsCQM4qES7w2XJ
         jS49PfaZHIL4eqa39bTkr999TTKKqG6NAxQtm1//JjsvzIx+KFuk4rVaB81p2EU29G6E
         CQimUftb7pxH0iblcjB71pVrXfjTj91ZNwCPvbf65NARF3a/lIjTMMq6aP3cuY2RQ+l6
         l+zSELmyXh/DSN2oZBrZqtq4Irhc2A98iWd8Zqghm09mBpkKHEXJER0mlA4QdiwtXrrZ
         WJmBCpXrzFBx9zvvGN1C9ss3bq2Z2LFF+Ywbl7S6ajs698vXMzZ0p54SJEGboypbvYH9
         eiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8M4iGpO9e7b2cQQvu3ijDQSMC1UJ28r1PJjopN7UEUQ=;
        b=xcMy0Nys/VbpxjzQ6WWX+ZYCp0qz1+8ROnrhTXBNdR5yTavK6kJbhBsjH/5luG7bQf
         8d3Z5HC0zS7zsclaSgemC4yD4dU4AZP+33ayuzY0UpAMlVjYg/1akGZMiSeOBT3EJpxz
         bXh+mwvrcBW0t1x1mEgbnp7UtulgkSaLB9rosTIBO5EcL+PrtLxBwkAPqP9CY/r4PeA9
         //iTi4vlP/qUdRBRYNFf/KKbRGStoEkdx2P8qV6CbjKQAheXuq76UXoCIE514zHc8n1b
         JGeHkag5hdUSPqbz0zR9TXLDN6ERTaiOEOE0UZRj24D1ZEE9/4TxdlV4SZhIqu0eEwBR
         Pngw==
X-Gm-Message-State: AFqh2krYglqTFq/g2ni37peMyrBTwLBbr3Ue+jRxbHTrTUgs5oH5+Q/E
        mod1ZRTVTeCdf6+nELMB/xc=
X-Google-Smtp-Source: AMrXdXt1aJKSMCXpyvqCpHFt5HESprrAjO//Xl5shjkWBe6PXBfaj3rY8aN3L5tzS3q5FEqPGs0mfg==
X-Received: by 2002:a05:600c:4255:b0:3d3:3d34:5d63 with SMTP id r21-20020a05600c425500b003d33d345d63mr34789309wmm.8.1672821580251;
        Wed, 04 Jan 2023 00:39:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05600c1e2700b003cfa80443a0sm44791827wmb.35.2023.01.04.00.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:39:39 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:39:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/i2c/busses/i2c-qcom-geni.c:937 geni_i2c_probe() warn:
 'gi2c->core_clk' from clk_prepare_enable() not released on lines: 896.
Message-ID: <202301032054.FPhnSn5K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69b41ac87e4a664de78a395ff97166f0b2943210
commit: 14d02fbadb5dc1cdf66078ef8430dd1cd22bfd53 i2c: qcom-geni: add desc struct to prepare support for I2C Master Hub variant
compiler: csky-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/i2c/busses/i2c-qcom-geni.c:937 geni_i2c_probe() warn: 'gi2c->core_clk' from clk_prepare_enable() not released on lines: 896.

vim +937 drivers/i2c/busses/i2c-qcom-geni.c

37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  768  static int geni_i2c_probe(struct platform_device *pdev)
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  769  {
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  770  	struct geni_i2c_dev *gi2c;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  771  	struct resource *res;
d8703554f4dea9 Vinod Koul                  2022-02-21  772  	u32 proto, tx_depth, fifo_disable;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  773  	int ret;
3b7d81f08a6a2b Stephen Boyd                2020-03-10  774  	struct device *dev = &pdev->dev;
14d02fbadb5dc1 Neil Armstrong              2022-11-29  775  	const struct geni_i2c_desc *desc = NULL;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  776  
3b7d81f08a6a2b Stephen Boyd                2020-03-10  777  	gi2c = devm_kzalloc(dev, sizeof(*gi2c), GFP_KERNEL);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  778  	if (!gi2c)
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  779  		return -ENOMEM;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  780  
3b7d81f08a6a2b Stephen Boyd                2020-03-10  781  	gi2c->se.dev = dev;
3b7d81f08a6a2b Stephen Boyd                2020-03-10  782  	gi2c->se.wrapper = dev_get_drvdata(dev->parent);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  783  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
3b7d81f08a6a2b Stephen Boyd                2020-03-10  784  	gi2c->se.base = devm_ioremap_resource(dev, res);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  785  	if (IS_ERR(gi2c->se.base))
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  786  		return PTR_ERR(gi2c->se.base);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  787  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  788  	desc = device_get_match_data(&pdev->dev);
14d02fbadb5dc1 Neil Armstrong              2022-11-29  789  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  790  	if (desc && desc->has_core_clk) {
14d02fbadb5dc1 Neil Armstrong              2022-11-29  791  		gi2c->core_clk = devm_clk_get(dev, "core");
14d02fbadb5dc1 Neil Armstrong              2022-11-29  792  		if (IS_ERR(gi2c->core_clk))
14d02fbadb5dc1 Neil Armstrong              2022-11-29  793  			return PTR_ERR(gi2c->core_clk);
14d02fbadb5dc1 Neil Armstrong              2022-11-29  794  	}
14d02fbadb5dc1 Neil Armstrong              2022-11-29  795  
3b7d81f08a6a2b Stephen Boyd                2020-03-10  796  	gi2c->se.clk = devm_clk_get(dev, "se");
3b7d81f08a6a2b Stephen Boyd                2020-03-10  797  	if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(dev))
3b7d81f08a6a2b Stephen Boyd                2020-03-10  798  		return PTR_ERR(gi2c->se.clk);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  799  
3b7d81f08a6a2b Stephen Boyd                2020-03-10  800  	ret = device_property_read_u32(dev, "clock-frequency",
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  801  				       &gi2c->clk_freq_out);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  802  	if (ret) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  803  		dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  804  		gi2c->clk_freq_out = KHZ(100);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  805  	}
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  806  
3b7d81f08a6a2b Stephen Boyd                2020-03-10  807  	if (has_acpi_companion(dev))
3b7d81f08a6a2b Stephen Boyd                2020-03-10  808  		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
c9913ac42135cf Lee Jones                   2019-06-12  809  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  810  	gi2c->irq = platform_get_irq(pdev, 0);
3b7d81f08a6a2b Stephen Boyd                2020-03-10  811  	if (gi2c->irq < 0)
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  812  		return gi2c->irq;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  813  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  814  	ret = geni_i2c_clk_map_idx(gi2c);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  815  	if (ret) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  816  		dev_err(dev, "Invalid clk frequency %d Hz: %d\n",
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  817  			gi2c->clk_freq_out, ret);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  818  		return ret;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  819  	}
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  820  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  821  	gi2c->adap.algo = &geni_i2c_algo;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  822  	init_completion(&gi2c->done);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  823  	spin_lock_init(&gi2c->lock);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  824  	platform_set_drvdata(pdev, gi2c);
3b7d81f08a6a2b Stephen Boyd                2020-03-10  825  	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, 0,
3b7d81f08a6a2b Stephen Boyd                2020-03-10  826  			       dev_name(dev), gi2c);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  827  	if (ret) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  828  		dev_err(dev, "Request_irq failed:%d: err:%d\n",
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  829  			gi2c->irq, ret);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  830  		return ret;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  831  	}
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  832  	/* Disable the interrupt so that the system can enter low-power mode */
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  833  	disable_irq(gi2c->irq);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  834  	i2c_set_adapdata(&gi2c->adap, gi2c);
3b7d81f08a6a2b Stephen Boyd                2020-03-10  835  	gi2c->adap.dev.parent = dev;
3b7d81f08a6a2b Stephen Boyd                2020-03-10  836  	gi2c->adap.dev.of_node = dev->of_node;
ea1558ce149d28 Wolfram Sang                2022-08-11  837  	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  838  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  839  	ret = geni_icc_get(&gi2c->se, desc ? desc->icc_ddr : "qup-memory");
bf225ed357c65e Akash Asthana               2020-06-23  840  	if (ret)
bf225ed357c65e Akash Asthana               2020-06-23  841  		return ret;
bf225ed357c65e Akash Asthana               2020-06-23  842  	/*
bf225ed357c65e Akash Asthana               2020-06-23  843  	 * Set the bus quota for core and cpu to a reasonable value for
bf225ed357c65e Akash Asthana               2020-06-23  844  	 * register access.
bf225ed357c65e Akash Asthana               2020-06-23  845  	 * Set quota for DDR based on bus speed.
bf225ed357c65e Akash Asthana               2020-06-23  846  	 */
bf225ed357c65e Akash Asthana               2020-06-23  847  	gi2c->se.icc_paths[GENI_TO_CORE].avg_bw = GENI_DEFAULT_BW;
bf225ed357c65e Akash Asthana               2020-06-23  848  	gi2c->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
14d02fbadb5dc1 Neil Armstrong              2022-11-29  849  	if (!desc || desc->icc_ddr)
bf225ed357c65e Akash Asthana               2020-06-23  850  		gi2c->se.icc_paths[GENI_TO_DDR].avg_bw = Bps_to_icc(gi2c->clk_freq_out);
bf225ed357c65e Akash Asthana               2020-06-23  851  
bf225ed357c65e Akash Asthana               2020-06-23  852  	ret = geni_icc_set_bw(&gi2c->se);
bf225ed357c65e Akash Asthana               2020-06-23  853  	if (ret)
bf225ed357c65e Akash Asthana               2020-06-23  854  		return ret;
bf225ed357c65e Akash Asthana               2020-06-23  855  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  856  	ret = clk_prepare_enable(gi2c->core_clk);
14d02fbadb5dc1 Neil Armstrong              2022-11-29  857  	if (ret)
14d02fbadb5dc1 Neil Armstrong              2022-11-29  858  		return ret;
14d02fbadb5dc1 Neil Armstrong              2022-11-29  859  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  860  	ret = geni_se_resources_on(&gi2c->se);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  861  	if (ret) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  862  		dev_err(dev, "Error turning on resources %d\n", ret);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  863  		return ret;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  864  	}
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  865  	proto = geni_se_read_proto(&gi2c->se);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  866  	if (proto != GENI_SE_I2C) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  867  		dev_err(dev, "Invalid proto %d\n", proto);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  868  		geni_se_resources_off(&gi2c->se);
14d02fbadb5dc1 Neil Armstrong              2022-11-29  869  		clk_disable_unprepare(gi2c->core_clk);

Error handling clean up.

37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  870  		return -ENXIO;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  871  	}
d8703554f4dea9 Vinod Koul                  2022-02-21  872  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  873  	if (desc && desc->no_dma_support)
14d02fbadb5dc1 Neil Armstrong              2022-11-29  874  		fifo_disable = false;
14d02fbadb5dc1 Neil Armstrong              2022-11-29  875  	else
d8703554f4dea9 Vinod Koul                  2022-02-21  876  		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
14d02fbadb5dc1 Neil Armstrong              2022-11-29  877  
d8703554f4dea9 Vinod Koul                  2022-02-21  878  	if (fifo_disable) {
d8703554f4dea9 Vinod Koul                  2022-02-21  879  		/* FIFO is disabled, so we can only use GPI DMA */
d8703554f4dea9 Vinod Koul                  2022-02-21  880  		gi2c->gpi_mode = true;
d8703554f4dea9 Vinod Koul                  2022-02-21  881  		ret = setup_gpi_dma(gi2c);
c60bd968c74749 Bjorn Andersson             2022-04-12  882  		if (ret)
c60bd968c74749 Bjorn Andersson             2022-04-12  883  			return dev_err_probe(dev, ret, "Failed to setup GPI DMA mode\n");

No clean up.

d8703554f4dea9 Vinod Koul                  2022-02-21  884  
d8703554f4dea9 Vinod Koul                  2022-02-21  885  		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
d8703554f4dea9 Vinod Koul                  2022-02-21  886  	} else {
d8703554f4dea9 Vinod Koul                  2022-02-21  887  		gi2c->gpi_mode = false;
d8703554f4dea9 Vinod Koul                  2022-02-21  888  		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
14d02fbadb5dc1 Neil Armstrong              2022-11-29  889  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  890  		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
14d02fbadb5dc1 Neil Armstrong              2022-11-29  891  		if (!tx_depth && desc)
14d02fbadb5dc1 Neil Armstrong              2022-11-29  892  			tx_depth = desc->tx_fifo_depth;
14d02fbadb5dc1 Neil Armstrong              2022-11-29  893  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  894  		if (!tx_depth) {
14d02fbadb5dc1 Neil Armstrong              2022-11-29  895  			dev_err(dev, "Invalid TX FIFO depth\n");
14d02fbadb5dc1 Neil Armstrong              2022-11-29  896  			return -EINVAL;

No clean up.

14d02fbadb5dc1 Neil Armstrong              2022-11-29  897  		}
14d02fbadb5dc1 Neil Armstrong              2022-11-29  898  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  899  		gi2c->tx_wm = tx_depth - 1;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  900  		geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
d8703554f4dea9 Vinod Koul                  2022-02-21  901  		geni_se_config_packing(&gi2c->se, BITS_PER_BYTE,
d8703554f4dea9 Vinod Koul                  2022-02-21  902  				       PACKING_BYTES_PW, true, true, true);
d8703554f4dea9 Vinod Koul                  2022-02-21  903  
d8703554f4dea9 Vinod Koul                  2022-02-21  904  		dev_dbg(dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
d8703554f4dea9 Vinod Koul                  2022-02-21  905  	}
d8703554f4dea9 Vinod Koul                  2022-02-21  906  
14d02fbadb5dc1 Neil Armstrong              2022-11-29  907  	clk_disable_unprepare(gi2c->core_clk);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  908  	ret = geni_se_resources_off(&gi2c->se);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  909  	if (ret) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  910  		dev_err(dev, "Error turning off resources %d\n", ret);
d8703554f4dea9 Vinod Koul                  2022-02-21  911  		goto err_dma;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  912  	}
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  913  
bf225ed357c65e Akash Asthana               2020-06-23  914  	ret = geni_icc_disable(&gi2c->se);
bf225ed357c65e Akash Asthana               2020-06-23  915  	if (ret)
d8703554f4dea9 Vinod Koul                  2022-02-21  916  		goto err_dma;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  917  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  918  	gi2c->suspended = 1;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  919  	pm_runtime_set_suspended(gi2c->se.dev);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  920  	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  921  	pm_runtime_use_autosuspend(gi2c->se.dev);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  922  	pm_runtime_enable(gi2c->se.dev);
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  923  
848bd3f3de9d44 Stephen Boyd                2018-11-02  924  	ret = i2c_add_adapter(&gi2c->adap);
848bd3f3de9d44 Stephen Boyd                2018-11-02  925  	if (ret) {
3b7d81f08a6a2b Stephen Boyd                2020-03-10  926  		dev_err(dev, "Error adding i2c adapter %d\n", ret);
848bd3f3de9d44 Stephen Boyd                2018-11-02  927  		pm_runtime_disable(gi2c->se.dev);
d8703554f4dea9 Vinod Koul                  2022-02-21  928  		goto err_dma;
848bd3f3de9d44 Stephen Boyd                2018-11-02  929  	}
848bd3f3de9d44 Stephen Boyd                2018-11-02  930  
3b7d81f08a6a2b Stephen Boyd                2020-03-10  931  	dev_dbg(dev, "Geni-I2C adaptor successfully added\n");
c3c2889b8a2c9d Lee Jones                   2019-06-12  932  
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  933  	return 0;
d8703554f4dea9 Vinod Koul                  2022-02-21  934  
d8703554f4dea9 Vinod Koul                  2022-02-21  935  err_dma:
d8703554f4dea9 Vinod Koul                  2022-02-21  936  	release_gpi_dma(gi2c);
d8703554f4dea9 Vinod Koul                  2022-02-21 @937  	return ret;
37692de5d52353 Karthikeyan Ramasubramanian 2018-07-30  938  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

