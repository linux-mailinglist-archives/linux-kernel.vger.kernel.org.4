Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1383C70C18C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjEVO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEVO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:56:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A201C2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:56:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so9552365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684767383; x=1687359383;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b140pn1gYOSlEH47A+p/JRdrM+QQ5uQ8BF1K767advA=;
        b=wl7yy7GK28mNGMeYrqFILf3sUKRAll13thAdDxiufy2lMIDkkCzsSh70zlLkqJ46+S
         eyxDxFfiEakte1nxe5BBrTL4JHATMxL228DqZEmB5BdX/Y1n3HTze08SVOr22g5mj86B
         POKWXvyUaFfmJiKrj8QFC1gQRBCwqLnqsHdrjWDkNTuXN8XeM2oNpr89/6ROT56sm2Al
         K0KBhTTxIZhqmME0nU4zQADIaYHv1DJxDIYHc/F4HNel5dIWSw4UV+gOGFDkjwcEkx91
         33aRK7xe9CBpkLsRPsm3ipFdfw69juo1J18okQ4vEcLjaBUgoQ8oMIyqYPZ6xSdjfVlp
         lVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684767383; x=1687359383;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b140pn1gYOSlEH47A+p/JRdrM+QQ5uQ8BF1K767advA=;
        b=ZiTLAd72E+o07ysJOiMDim1b3Vo4m1fHK0JItyNsJucZduPXikbEvcnt8l75QJ/BJz
         ZFPQaWz7kb9wFiYMN1vCr6FQ7LcYPcNKDb+vQfF85tVNOK/n+E+kQTOi+8DH5Y7Fzk9B
         Ynpv8z6XmGAeJ8F8jzZvkrq86QjZ7mXIYbU5ug1w3wmZfBdL7FsJheaC0CTSVa4LUL7T
         ahtYfu4Q6FTHeEh1NuLc0/tcxX2kL13jx5Ib5iKM8tVnIa/T/JZKVv5lLnHdKxKopogy
         U0kJyx0C4fZer5j5VnOpi1hqwNl3kXdelxDLVdHqad+UR0YA1We7uianUupkWArQhRmO
         3Ppw==
X-Gm-Message-State: AC+VfDxPclWwnlCgj41j8sHUJo73o2j5QfaBmkEl2mEBIIzA9vsgGaMt
        TPnXwT70cRo+6siJG9K7i6PtoA==
X-Google-Smtp-Source: ACHHUZ7RkOFwOC0AH5m7aYqiTD9Ph9ztRElXr/0GgrOqduYpZ7KTX4ONCTOACx0yGX5pkiokSu9udA==
X-Received: by 2002:a05:600c:294c:b0:3f5:fa8e:aaa3 with SMTP id n12-20020a05600c294c00b003f5fa8eaaa3mr5338726wmd.28.1684767382846;
        Mon, 22 May 2023 07:56:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c378500b003f42314832fsm8561082wmr.18.2023.05.22.07.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 07:56:21 -0700 (PDT)
Date:   Mon, 22 May 2023 17:56:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Subject: drivers/phy/renesas/phy-rcar-gen3-usb2.c:747
 rcar_gen3_phy_usb2_probe() warn: missing error code 'ret'
Message-ID: <47e1e12a-f1a8-48a9-a37a-d60501f2ec50@kili.mountain>
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

Hi Lad,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44c026a73be8038f03dbdeef028b642880cf1511
commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
config: riscv-randconfig-m031-20230522 (https://download.01.org/0day-ci/archive/20230522/202305222220.VHYVac04-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305222220.VHYVac04-lkp@intel.com/

smatch warnings:
drivers/phy/renesas/phy-rcar-gen3-usb2.c:747 rcar_gen3_phy_usb2_probe() warn: missing error code 'ret'

vim +/ret +747 drivers/phy/renesas/phy-rcar-gen3-usb2.c

f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  652  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  653  {
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  654  	const struct rcar_gen3_phy_drv_data *phy_data;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  655  	struct device *dev = &pdev->dev;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  656  	struct rcar_gen3_chan *channel;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  657  	struct phy_provider *provider;
08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2020-07-17  658  	int ret = 0, i;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  659  
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  660  	if (!dev->of_node) {
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  661  		dev_err(dev, "This driver needs device tree\n");
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  662  		return -EINVAL;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  663  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  664  
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  665  	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  666  	if (!channel)
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  667  		return -ENOMEM;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  668  
0b5604affbec02 drivers/phy/renesas/phy-rcar-gen3-usb2.c Chunfeng Yun      2020-11-06  669  	channel->base = devm_platform_ioremap_resource(pdev, 0);
801a69c787812f drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  670  	if (IS_ERR(channel->base))
801a69c787812f drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  671  		return PTR_ERR(channel->base);
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  672  
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  673  	channel->obint_enable_bits = USB2_OBINT_BITS;
08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2020-07-17  674  	/* get irq number here and request_irq for OTG in phy_init */
08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2020-07-17  675  	channel->irq = platform_get_irq_optional(pdev, 0);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  676  	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
73801b90a38ff1 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  677  	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
7e0540f41332cb drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2017-10-12  678  		int ret;
7e0540f41332cb drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2017-10-12  679  
979b519c7a1bff drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  680  		channel->is_otg_channel = true;
8dde0008ffc9e2 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  681  		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
8dde0008ffc9e2 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  682  							"renesas,no-otg-pins");
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  683  		channel->extcon = devm_extcon_dev_allocate(dev,
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  684  							rcar_gen3_phy_cable);
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  685  		if (IS_ERR(channel->extcon))
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  686  			return PTR_ERR(channel->extcon);
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  687  
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  688  		ret = devm_extcon_dev_register(dev, channel->extcon);
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  689  		if (ret < 0) {
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  690  			dev_err(dev, "Failed to register extcon\n");
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  691  			return ret;
2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-04-29  692  		}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  693  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  694  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  695  	/*
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  696  	 * devm_phy_create() will call pm_runtime_enable(&phy->dev);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  697  	 * And then, phy-core will manage runtime pm for this device.
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  698  	 */
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  699  	pm_runtime_enable(dev);
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  700  
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  701  	phy_data = of_device_get_match_data(dev);
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  702  	if (!phy_data) {
51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li           2020-11-26  703  		ret = -EINVAL;
51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li           2020-11-26  704  		goto error;
51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li           2020-11-26  705  	}
5d8042e95fd471 drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2019-04-10  706  
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  707  	channel->soc_no_adp_ctrl = phy_data->no_adp_ctrl;
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  708  	if (phy_data->no_adp_ctrl)
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  709  		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  710  
5c9dc6379f539c drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-06-10  711  	mutex_init(&channel->lock);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  712  	for (i = 0; i < NUM_OF_PHYS; i++) {
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  713  		channel->rphys[i].phy = devm_phy_create(dev, NULL,
b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das          2021-07-27  714  							phy_data->phy_usb2_ops);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  715  		if (IS_ERR(channel->rphys[i].phy)) {
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  716  			dev_err(dev, "Failed to create USB2 PHY\n");
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  717  			ret = PTR_ERR(channel->rphys[i].phy);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  718  			goto error;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  719  		}
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  720  		channel->rphys[i].ch = channel;
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  721  		channel->rphys[i].int_enable_bits = rcar_gen3_int_enable[i];
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  722  		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  723  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  724  
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  725  	channel->vbus = devm_regulator_get_optional(dev, "vbus");
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  726  	if (IS_ERR(channel->vbus)) {
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  727  		if (PTR_ERR(channel->vbus) == -EPROBE_DEFER) {
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  728  			ret = PTR_ERR(channel->vbus);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  729  			goto error;
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  730  		}
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  731  		channel->vbus = NULL;
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  732  	}
6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-03-03  733  
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  734  	platform_set_drvdata(pdev, channel);
92fec1c27caa7b drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  735  	channel->dev = dev;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  736  
549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2019-04-11  737  	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  738  	if (IS_ERR(provider)) {
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  739  		dev_err(dev, "Failed to register PHY provider\n");
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  740  		ret = PTR_ERR(provider);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  741  		goto error;
979b519c7a1bff drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda 2018-09-21  742  	} else if (channel->is_otg_channel) {
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  743  		int ret;
                                                                                                        ^^^^^^^
This "ret" declaration shadows the earlier ret declaration

9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  744  
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  745  		ret = device_create_file(dev, &dev_attr_role);
9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  746  		if (ret < 0)
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14 @747  			goto error;

So it means we return success on this error path.

9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2016-11-09  748  	}
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  749  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  750  	return 0;
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  751  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  752  error:
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  753  	pm_runtime_disable(dev);
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  754  
441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2017-03-14  755  	return ret;
f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda 2015-11-30  756  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

