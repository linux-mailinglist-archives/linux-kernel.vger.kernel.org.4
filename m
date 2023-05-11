Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2D6FF01B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbjEKKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjEKKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:48:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E534230
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:48:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062db220a3so5502862f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683802092; x=1686394092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JADIWBUmOCU2mF7tw9c2hF0lxUUJ8uvybFtNfl4/Wg=;
        b=lNzPM1R+cRkJltiSWXf5AKeqHJ3arnTbuez6xeRf9mGoCm3QmVLbkuLXG3lAlMGoaU
         4UEWJh0zNnpOPBVgyc8QnDkc8pspCPRVe/uidq8EOzkNY9aLiUP5RQC5d2/QnIAUFMFK
         cseqfGp2ccftld32jGfBoZILRpCGq1+hgqiOChCm26NRvR5g93E1tLTukMaOv/toAIIl
         TZrDi0xsywaLpuxLhqyPKmFoBosXJdz3Zvg0847rBjPx23+QcRgrAoB2xWPc0KQaAUdU
         YhcrqHKUGTq7sJ9ylO2qve5qjJDkEREcn1K1e3aYJKTIwVzr68IIjb19zaLDnXysryM+
         ud2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802092; x=1686394092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JADIWBUmOCU2mF7tw9c2hF0lxUUJ8uvybFtNfl4/Wg=;
        b=DMxE2YLjk+HmmnWrCejnUQV/OB6hNNIMbrHoyVmA99x4Nw7MNtrqPeaf1LAhycIkBM
         L2LEIEXYX6oxzqf1M7cIxdXPcY88LfUjSBH3LMf5D1c8FTuRDbcspqP6ruUlc1I67MJz
         +sn3pBAuAt/caEPNPgFoUvVixAxCLxFHKOO9b+EX8KRUfPafy+JnbY2E2E07+Nqkpnhk
         Lee7KEZ4/2FAXOYRcssfFQ8W986HqDpLeY78TtUAxLHOVjzngyj/Dg1p3P2Rm0yqpir4
         r3CR1U0bHTN17YQRAy+o1814lXE5iNk7FMC7z3znYy643EJ7sptXCrbtLbhCMPZnCDhW
         lqTg==
X-Gm-Message-State: AC+VfDwP0abPxhh9vNH0oBHlQIuj8tvyae/18UoC/bJGGY+CQy7NN4u3
        ClwIvQt50Ou7uydNGUQmMulYAQ==
X-Google-Smtp-Source: ACHHUZ7Va8iFg38r9ewoleVUC9xSujzB06Xl3uWpcybKri8RNGNNtHBcP2WyQKx3+cSC2BTzIsl/Bg==
X-Received: by 2002:a5d:6990:0:b0:306:2d15:fc35 with SMTP id g16-20020a5d6990000000b003062d15fc35mr14039198wru.37.1683802092418;
        Thu, 11 May 2023 03:48:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b003f4dde07956sm3641919wma.42.2023.05.11.03.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:48:10 -0700 (PDT)
Date:   Thu, 11 May 2023 13:48:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/iio/accel/kionix-kx022a.c:1053 kx022a_probe_internal() warn:
 passing zero to 'dev_err_probe'
Message-ID: <46296e39-dbc1-4f27-b89c-af6f08d9f318@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad2fd53a7870a395b8564697bef6c329d017c6c9
commit: 7c1d1677b3227c6b18ac999f2b84778baa280b8f iio: accel: Support Kionix/ROHM KX022A accelerometer
config: openrisc-randconfig-m041-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110245.MFxC9bUj-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305110245.MFxC9bUj-lkp@intel.com/

smatch warnings:
drivers/iio/accel/kionix-kx022a.c:1053 kx022a_probe_internal() warn: passing zero to 'dev_err_probe'

vim +/dev_err_probe +1053 drivers/iio/accel/kionix-kx022a.c

7c1d1677b3227c Matti Vaittinen 2022-10-24  1000  int kx022a_probe_internal(struct device *dev)
7c1d1677b3227c Matti Vaittinen 2022-10-24  1001  {
7c1d1677b3227c Matti Vaittinen 2022-10-24  1002  	static const char * const regulator_names[] = {"io-vdd", "vdd"};
7c1d1677b3227c Matti Vaittinen 2022-10-24  1003  	struct iio_trigger *indio_trig;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1004  	struct fwnode_handle *fwnode;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1005  	struct kx022a_data *data;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1006  	struct regmap *regmap;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1007  	unsigned int chip_id;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1008  	struct iio_dev *idev;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1009  	int ret, irq;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1010  	char *name;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1011  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1012  	regmap = dev_get_regmap(dev, NULL);
7c1d1677b3227c Matti Vaittinen 2022-10-24  1013  	if (!regmap) {
7c1d1677b3227c Matti Vaittinen 2022-10-24  1014  		dev_err(dev, "no regmap\n");
7c1d1677b3227c Matti Vaittinen 2022-10-24  1015  		return -EINVAL;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1016  	}
7c1d1677b3227c Matti Vaittinen 2022-10-24  1017  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1018  	fwnode = dev_fwnode(dev);
7c1d1677b3227c Matti Vaittinen 2022-10-24  1019  	if (!fwnode)
7c1d1677b3227c Matti Vaittinen 2022-10-24  1020  		return -ENODEV;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1021  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1022  	idev = devm_iio_device_alloc(dev, sizeof(*data));
7c1d1677b3227c Matti Vaittinen 2022-10-24  1023  	if (!idev)
7c1d1677b3227c Matti Vaittinen 2022-10-24  1024  		return -ENOMEM;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1025  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1026  	data = iio_priv(idev);
7c1d1677b3227c Matti Vaittinen 2022-10-24  1027  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1028  	/*
7c1d1677b3227c Matti Vaittinen 2022-10-24  1029  	 * VDD is the analog and digital domain voltage supply and
7c1d1677b3227c Matti Vaittinen 2022-10-24  1030  	 * IO_VDD is the digital I/O voltage supply.
7c1d1677b3227c Matti Vaittinen 2022-10-24  1031  	 */
7c1d1677b3227c Matti Vaittinen 2022-10-24  1032  	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
7c1d1677b3227c Matti Vaittinen 2022-10-24  1033  					     regulator_names);
7c1d1677b3227c Matti Vaittinen 2022-10-24  1034  	if (ret && ret != -ENODEV)
7c1d1677b3227c Matti Vaittinen 2022-10-24  1035  		return dev_err_probe(dev, ret, "failed to enable regulator\n");
7c1d1677b3227c Matti Vaittinen 2022-10-24  1036  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1037  	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
7c1d1677b3227c Matti Vaittinen 2022-10-24  1038  	if (ret)
7c1d1677b3227c Matti Vaittinen 2022-10-24  1039  		return dev_err_probe(dev, ret, "Failed to access sensor\n");
7c1d1677b3227c Matti Vaittinen 2022-10-24  1040  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1041  	if (chip_id != KX022A_ID) {
7c1d1677b3227c Matti Vaittinen 2022-10-24  1042  		dev_err(dev, "unsupported device 0x%x\n", chip_id);
7c1d1677b3227c Matti Vaittinen 2022-10-24  1043  		return -EINVAL;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1044  	}
7c1d1677b3227c Matti Vaittinen 2022-10-24  1045  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1046  	irq = fwnode_irq_get_byname(fwnode, "INT1");
7c1d1677b3227c Matti Vaittinen 2022-10-24  1047  	if (irq > 0) {
7c1d1677b3227c Matti Vaittinen 2022-10-24  1048  		data->inc_reg = KX022A_REG_INC1;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1049  		data->ien_reg = KX022A_REG_INC4;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1050  	} else {
7c1d1677b3227c Matti Vaittinen 2022-10-24  1051  		irq = fwnode_irq_get_byname(fwnode, "INT2");
7c1d1677b3227c Matti Vaittinen 2022-10-24  1052  		if (irq <= 0)
                                                                    ^^^^^^^^
This code assumes fwnode_irq_get_byname() can return zero.

7c1d1677b3227c Matti Vaittinen 2022-10-24 @1053  			return dev_err_probe(dev, irq, "No suitable IRQ\n");

But fortunately, it can't otherwise this would return success.

7c1d1677b3227c Matti Vaittinen 2022-10-24  1054  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1055  		data->inc_reg = KX022A_REG_INC5;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1056  		data->ien_reg = KX022A_REG_INC6;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1057  	}
7c1d1677b3227c Matti Vaittinen 2022-10-24  1058  
7c1d1677b3227c Matti Vaittinen 2022-10-24  1059  	data->regmap = regmap;
7c1d1677b3227c Matti Vaittinen 2022-10-24  1060  	data->dev = dev;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

