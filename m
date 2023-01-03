Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C165BBA8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjACIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjACIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:13:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A5DEED;
        Tue,  3 Jan 2023 00:13:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so19990302wmb.2;
        Tue, 03 Jan 2023 00:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9x7x+PDQyoC//YE5z76DODqegmiMuec0Apjfukh6vU=;
        b=BCWZFslWen88M91vk6UysisKNCyPjoRrGSdBkAQqSWWvUDO7KrSspFNT3yNU1P8M5p
         e07V3gJbMpycNavWA3hhy8x1SkZ96ytpQ0AQ6P/Z/YUyDTPPD8zdq5okJ/p1TAnUoTu+
         KWpM0hJtn+k+YgNT3ySY4BO0ENaD8mcOPYvZMPtcrex6LwKlKiO1k4VBf+VhETSyYVbD
         eiOK4hjuQOehZ4ed8Li2JNL5KBkQu1tjK1Q6WbF/4mVESSvstP1GG4P3cfCzFcc41mL0
         SQMDkZ0jQ/YwWdbyeVmcuQwBh1wJPvhKyoF/XRXE2a/moBuBJGF3ww4NHJm9mqQxmgOq
         K1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9x7x+PDQyoC//YE5z76DODqegmiMuec0Apjfukh6vU=;
        b=vWo74zawv1oF5ayZNa2ui/G2u35hKch99MQvMFGdNLGlCs4v9mZEaRjoOrgx2wafon
         zq/xLCqLAi9dgxlRIUFer+pFPrbssEvdeI+xaTytjPOeQu3RnkVJ3x9MJUaxdro8h7lp
         YlvlN8Bhz7YzThuqQb81Mh4NlxMmFsz5Btzz5INoGu9gudIZx3CN5OUegJPnVVEKHTps
         VIWbQVvuenSGQ+87MmrNfYhEkZfjXsOljGCQf1IBt+PaJi9EB5o8znETO0mllZq5r10l
         5qQ2TXBO67hUzhQkE3dDSWBCda2Vpy9QJmUbMC3iYTb3SuE66oUmFL70oaCYrD+ZYKVz
         3GAQ==
X-Gm-Message-State: AFqh2kqXW6cnC8MHh917ZhKPApn2sLOn1v95dV2TNbL1WEuSPGT1wT4d
        qcP/qDZFOauW3p+vn4GWrwyDc/HlpJPoRA==
X-Google-Smtp-Source: AMrXdXuzbXcTKhCq2LwZEFGE45IPcvl6hZKjXK/ye2w6WH8dpxIxiYDCILXC4dPXS5uOVRz1ybliAg==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr30909493wmj.30.1672733603645;
        Tue, 03 Jan 2023 00:13:23 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k6-20020adff5c6000000b002a01e64f7a1sm659283wrp.88.2023.01.03.00.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:13:23 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:13:18 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Xavier Roumegue <xavier.roumegue@oss.nxp.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/nxp/dw100/dw100.c:1574 dw100_probe() warn:
 missing unwind goto?
Message-ID: <202301031138.wkCMwZin-lkp@intel.com>
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
commit: cb6d000fcaa6e2ee0e01937364c686690329bf5e media: dw100: Add i.MX8MP dw100 dewarper driver
config: ia64-randconfig-m041-20230101
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/platform/nxp/dw100/dw100.c:1574 dw100_probe() warn: missing unwind goto?

vim +1574 drivers/media/platform/nxp/dw100/dw100.c

cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1531  static int dw100_probe(struct platform_device *pdev)
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1532  {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1533  	struct dw100_device *dw_dev;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1534  	struct video_device *vfd;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1535  	struct resource *res;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1536  	int ret, irq;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1537  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1538  	dw_dev = devm_kzalloc(&pdev->dev, sizeof(*dw_dev), GFP_KERNEL);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1539  	if (!dw_dev)
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1540  		return -ENOMEM;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1541  	dw_dev->pdev = pdev;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1542  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1543  	ret = devm_clk_bulk_get_all(&pdev->dev, &dw_dev->clks);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1544  	if (ret < 0) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1545  		dev_err(&pdev->dev, "Unable to get clocks: %d\n", ret);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1546  		return ret;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1547  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1548  	dw_dev->num_clks = ret;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1549  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1550  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1551  	dw_dev->mmio = devm_ioremap_resource(&pdev->dev, res);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1552  	if (IS_ERR(dw_dev->mmio))
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1553  		return PTR_ERR(dw_dev->mmio);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1554  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1555  	irq = platform_get_irq(pdev, 0);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1556  	if (irq < 0)
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1557  		return irq;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1558  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1559  	platform_set_drvdata(pdev, dw_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1560  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1561  	pm_runtime_enable(&pdev->dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1562  	ret = pm_runtime_resume_and_get(&pdev->dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1563  	if (ret < 0) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1564  		dev_err(&pdev->dev, "Unable to resume the device: %d\n", ret);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1565  		goto err_pm;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1566  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1567  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1568  	pm_runtime_put_sync(&pdev->dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1569  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1570  	ret = devm_request_irq(&pdev->dev, irq, dw100_irq_handler, IRQF_ONESHOT,
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1571  			       dev_name(&pdev->dev), dw_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1572  	if (ret < 0) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1573  		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30 @1574  		return ret;

goto err_pm;

cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1575  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1576  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1577  	ret = v4l2_device_register(&pdev->dev, &dw_dev->v4l2_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1578  	if (ret)
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1579  		goto err_pm;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1580  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1581  	vfd = dw100_init_video_device(dw_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1582  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1583  	dw_dev->m2m_dev = v4l2_m2m_init(&dw100_m2m_ops);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1584  	if (IS_ERR(dw_dev->m2m_dev)) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1585  		dev_err(&pdev->dev, "Failed to init mem2mem device\n");
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1586  		ret = PTR_ERR(dw_dev->m2m_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1587  		goto err_v4l2;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1588  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1589  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1590  	dw_dev->mdev.dev = &pdev->dev;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1591  	strscpy(dw_dev->mdev.model, "dw100", sizeof(dw_dev->mdev.model));
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1592  	media_device_init(&dw_dev->mdev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1593  	dw_dev->v4l2_dev.mdev = &dw_dev->mdev;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1594  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1595  	ret = video_register_device(vfd, VFL_TYPE_VIDEO, -1);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1596  	if (ret) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1597  		dev_err(&pdev->dev, "Failed to register video device\n");
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1598  		goto err_m2m;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1599  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1600  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1601  	ret = v4l2_m2m_register_media_controller(dw_dev->m2m_dev, vfd,
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1602  						 MEDIA_ENT_F_PROC_VIDEO_SCALER);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1603  	if (ret) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1604  		dev_err(&pdev->dev, "Failed to init mem2mem media controller\n");
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1605  		goto error_v4l2;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1606  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1607  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1608  	ret = media_device_register(&dw_dev->mdev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1609  	if (ret) {
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1610  		dev_err(&pdev->dev, "Failed to register mem2mem media device\n");
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1611  		goto error_m2m_mc;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1612  	}
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1613  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1614  	dw100_debugfs_init(dw_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1615  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1616  	dev_info(&pdev->dev,
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1617  		 "dw100 v4l2 m2m registered as /dev/video%u\n", vfd->num);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1618  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1619  	return 0;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1620  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1621  error_m2m_mc:
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1622  	v4l2_m2m_unregister_media_controller(dw_dev->m2m_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1623  error_v4l2:
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1624  	video_unregister_device(vfd);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1625  err_m2m:
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1626  	v4l2_m2m_release(dw_dev->m2m_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1627  err_v4l2:
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1628  	v4l2_device_unregister(&dw_dev->v4l2_dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1629  err_pm:
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1630  	pm_runtime_disable(&pdev->dev);
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1631  
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1632  	return ret;
cb6d000fcaa6e2 Xavier Roumegue 2022-07-30  1633  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

