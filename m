Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD16AB85A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCFIc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCFIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:32:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7169212AA;
        Mon,  6 Mar 2023 00:31:59 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so35072927eda.7;
        Mon, 06 Mar 2023 00:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678091518;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9LP7bOG1M0J7nDrxY/rPNDyeXRjQxGxyQ2mWu+wlb0=;
        b=R79rh8cvsq/BotA7SR/qy1NbOqU5r5GPQiW9SsnU0rQ2gmdV07G9BqGwwW+lNsFcMS
         5Agkz/rdka2zcFhFAgcOS9zvd3oL6hD621/IWVbha+M+vCVSylYzQXDgg+5uy/uuRcB+
         Gc07ZSXHdIUIYT0Yp9XaYCVb5LpKJsDutCcY0DDl5SOCSsG8VkRpsmkVUdesvHnKoavl
         YNVQcpYREsUPzQIpfFpeMmV4gmVn5blMdzWFHSqxWKEGiRxpjC7luLHPTWJF4AtYrv4a
         ybrcX2AUWPLTueL1pg9e2k7egNucZJj2JDR40vCrCrW67WhBfBU4i85A69FsZv7X/wko
         ldgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091518;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9LP7bOG1M0J7nDrxY/rPNDyeXRjQxGxyQ2mWu+wlb0=;
        b=e+i5+5PVrogiEPggcqiJ5zJkqDib357Jpu0TKwOib9ZeLbZtB502f7Vsa7b6Rpzpm+
         hSQ4T53HsIBSb/eldqVK+9gmG4gcyOvnjD9tydn19zR0Cwvlr3zHBIXxh/TnwIBP4/lp
         9wENGyzjUsRSZqiD+xNiwSBIhXhDIcV1n1r/4IKmsKFIWPZ+aMlMir77lCPd91HPcWUS
         ddnM6C0vfy70Ckwcv9kH4icLIGJc7/d1wuzjHjKpz/OUVhcwaJKesnHAbgrQkvFFMdp/
         KbC8uGjG0hsFDzOLurbzHYU+p2TUL665G4s23xYHz/cxbB66Mexf+GEgiwPWdZArgbtM
         5raQ==
X-Gm-Message-State: AO0yUKVY/qh12yhq+CVhfPy3XKpSP3wePbEGgL+yUJMlHZRpFzjbKTtX
        YfJJhBxOXVEurStt1ZvzhZA=
X-Google-Smtp-Source: AK7set9qotnlsbz5yc0qVnc49U4ouzoOZ0iySrvzB7SZ0KUHh9LNdwGGMFF3oYw8OnyX4EhVRmfwoA==
X-Received: by 2002:a17:907:1c15:b0:8af:2fa1:2226 with SMTP id nc21-20020a1709071c1500b008af2fa12226mr12771669ejc.6.1678091518019;
        Mon, 06 Mar 2023 00:31:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b008b17b123a47sm4205223ejb.208.2023.03.06.00.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:31:57 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:31:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnaud de Turckheim <quarium@gmail.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v3 2/3] gpio: pcie-idio-24: Migrate to the regmap API
Message-ID: <179ed443-a67b-4633-b62c-a4dda0f0f088@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278e328cd1689a4e331e7515050c12c29f2a4785.1678034378.git.william.gray@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

url:    https://github.com/intel-lab-lkp/linux/commits/William-Breathitt-Gray/regmap-Pass-irq_drv_data-as-a-parameter-for-set_type_config/20230306-010313
base:   4827aae061337251bb91801b316157a78b845ec7
patch link:    https://lore.kernel.org/r/278e328cd1689a4e331e7515050c12c29f2a4785.1678034378.git.william.gray%40linaro.org
patch subject: [PATCH v3 2/3] gpio: pcie-idio-24: Migrate to the regmap API
config: loongarch-randconfig-m041-20230305 (https://download.01.org/0day-ci/archive/20230306/202303060606.ooBzB3pr-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303060606.ooBzB3pr-lkp@intel.com/

smatch warnings:
drivers/gpio/gpio-pcie-idio-24.c:365 idio_24_probe() error: potentially dereferencing uninitialized 'idio24gpio'.

vim +/idio24gpio +365 drivers/gpio/gpio-pcie-idio-24.c

58556204662812 William Breathitt Gray 2018-01-09  330  static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
58556204662812 William Breathitt Gray 2018-01-09  331  {
58556204662812 William Breathitt Gray 2018-01-09  332  	struct device *const dev = &pdev->dev;
58556204662812 William Breathitt Gray 2018-01-09  333  	struct idio_24_gpio *idio24gpio;
58556204662812 William Breathitt Gray 2018-01-09  334  	int err;
10a2f11d3c9e48 Arnaud de Turckheim    2020-11-04  335  	const size_t pci_plx_bar_index = 1;
58556204662812 William Breathitt Gray 2018-01-09  336  	const size_t pci_bar_index = 2;
58556204662812 William Breathitt Gray 2018-01-09  337  	const char *const name = pci_name(pdev);
e60d5c32ff098c William Breathitt Gray 2023-03-05  338  	struct gpio_regmap_config gpio_config = {};
e60d5c32ff098c William Breathitt Gray 2023-03-05  339  	void __iomem *pex8311_intcsr;
e60d5c32ff098c William Breathitt Gray 2023-03-05  340  	void __iomem *idio_24_regs;
e60d5c32ff098c William Breathitt Gray 2023-03-05  341  	struct regmap *pex8311_intcsr_map;
e60d5c32ff098c William Breathitt Gray 2023-03-05  342  	struct regmap_irq_chip *chip;
e60d5c32ff098c William Breathitt Gray 2023-03-05  343  	struct regmap_irq_chip_data *chip_data;
58556204662812 William Breathitt Gray 2018-01-09  344  
58556204662812 William Breathitt Gray 2018-01-09  345  	err = pcim_enable_device(pdev);
58556204662812 William Breathitt Gray 2018-01-09  346  	if (err) {
58556204662812 William Breathitt Gray 2018-01-09  347  		dev_err(dev, "Failed to enable PCI device (%d)\n", err);
58556204662812 William Breathitt Gray 2018-01-09  348  		return err;
58556204662812 William Breathitt Gray 2018-01-09  349  	}
58556204662812 William Breathitt Gray 2018-01-09  350  
10a2f11d3c9e48 Arnaud de Turckheim    2020-11-04  351  	err = pcim_iomap_regions(pdev, BIT(pci_plx_bar_index) | BIT(pci_bar_index), name);
58556204662812 William Breathitt Gray 2018-01-09  352  	if (err) {
58556204662812 William Breathitt Gray 2018-01-09  353  		dev_err(dev, "Unable to map PCI I/O addresses (%d)\n", err);
58556204662812 William Breathitt Gray 2018-01-09  354  		return err;
58556204662812 William Breathitt Gray 2018-01-09  355  	}
58556204662812 William Breathitt Gray 2018-01-09  356  
e60d5c32ff098c William Breathitt Gray 2023-03-05  357  	pex8311_intcsr = pcim_iomap_table(pdev)[pci_plx_bar_index] + PLX_PEX8311_PCI_LCS_INTCSR;
e60d5c32ff098c William Breathitt Gray 2023-03-05  358  	idio_24_regs = pcim_iomap_table(pdev)[pci_bar_index];
e60d5c32ff098c William Breathitt Gray 2023-03-05  359  
e60d5c32ff098c William Breathitt Gray 2023-03-05  360  	pex8311_intcsr_map = devm_regmap_init_mmio(dev, pex8311_intcsr,
e60d5c32ff098c William Breathitt Gray 2023-03-05  361  						   &pex8311_intcsr_regmap_config);
e60d5c32ff098c William Breathitt Gray 2023-03-05  362  	if (IS_ERR(pex8311_intcsr_map))
e60d5c32ff098c William Breathitt Gray 2023-03-05  363  		return dev_err_probe(dev, PTR_ERR(pex8311_intcsr_map),
e60d5c32ff098c William Breathitt Gray 2023-03-05  364  				     "Unable to initialize PEX8311 register map\n");
e60d5c32ff098c William Breathitt Gray 2023-03-05 @365  	idio24gpio->map = devm_regmap_init_mmio(dev, idio_24_regs,
e60d5c32ff098c William Breathitt Gray 2023-03-05  366  					    &idio_24_regmap_config);

Heh.  This needs to be after the idio24gpio = devm_kzalloc().

e60d5c32ff098c William Breathitt Gray 2023-03-05  367  	if (IS_ERR(idio24gpio->map))
e60d5c32ff098c William Breathitt Gray 2023-03-05  368  		return dev_err_probe(dev, PTR_ERR(idio24gpio->map),
e60d5c32ff098c William Breathitt Gray 2023-03-05  369  				     "Unable to initialize register map\n");
e60d5c32ff098c William Breathitt Gray 2023-03-05  370  
e60d5c32ff098c William Breathitt Gray 2023-03-05  371  	idio24gpio = devm_kzalloc(dev, sizeof(*idio24gpio), GFP_KERNEL);
e60d5c32ff098c William Breathitt Gray 2023-03-05  372  	if (!idio24gpio)
e60d5c32ff098c William Breathitt Gray 2023-03-05  373  		return -ENOMEM;
e60d5c32ff098c William Breathitt Gray 2023-03-05  374  
e60d5c32ff098c William Breathitt Gray 2023-03-05  375  	mutex_init(&idio24gpio->lock);
e60d5c32ff098c William Breathitt Gray 2023-03-05  376  
e60d5c32ff098c William Breathitt Gray 2023-03-05  377  	/* Initialize all IRQ type configuration to IRQ_TYPE_EDGE_BOTH */
e60d5c32ff098c William Breathitt Gray 2023-03-05  378  	idio24gpio->irq_type = GENMASK(7, 0);
e60d5c32ff098c William Breathitt Gray 2023-03-05  379  
e60d5c32ff098c William Breathitt Gray 2023-03-05  380  	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
e60d5c32ff098c William Breathitt Gray 2023-03-05  381  	if (!chip)
e60d5c32ff098c William Breathitt Gray 2023-03-05  382  		return -ENOMEM;
e60d5c32ff098c William Breathitt Gray 2023-03-05  383  
e60d5c32ff098c William Breathitt Gray 2023-03-05  384  	chip->name = name;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

