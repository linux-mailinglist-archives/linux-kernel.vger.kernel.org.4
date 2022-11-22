Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB64E6335BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKVHPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVHPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:15:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE3A31355
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:15:47 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vv4so24408163ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPBOnq4MV/RdGaWML7PRDRza9Xxp38iF/6zbFkVySgQ=;
        b=XX8ziX+YjfmKOJxT7i71FLz24K+pKc8qQZzFCKWTQ4cyVG1FOzQckq6m9nWgcMo9+b
         v7bxz5/CxkHLNsliL8OCG/hNQWUwNZEq4b8TecZNjFrwC2VqPYNBuOUTff7dkkV3SFDd
         RBsN7GVEnTNLyJlmKgUcpRayxLERqJEcBgi1+e/s8G/uWYuG33ywfZF+d63yigQ3Vmvn
         c2P5ZOIMpb/1W0kteEJ1kWAh0AMOEBhlV72ItmscCpuKEn+Z0R8cRRLpB1gOz2o+Lm6D
         RvzXfQU9b7Yti8mQ/LRmShCZRsv1LS337D30jmCThUUvoVCThen/IFzHrXeKCCAva3d2
         XUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPBOnq4MV/RdGaWML7PRDRza9Xxp38iF/6zbFkVySgQ=;
        b=lBk9N+Ka/TPS7aWBLVawu7OcTPKA0m52bgZCqZXyuX+5v3iPFrjXKxIPQlXj4zlXdZ
         I4jS5MgGqhp7u2NfBhPAGZ4c96K2p7CJ8yOULYIoNJ9yIwZyGiQK2ICP6OPTuceQVlnP
         bnUlz1zbdq2AqZCjBfbqtl8otGHwryQOGDh6uDMGiRl29ZrLHa3DUNz06dT3mtaOjYCT
         kTBxnon3lZZeKBFeRq1KGJ088CdH9KzWKYfyU5gGBzXhHtrEiIYQ5KpOvdGasGUyfMnN
         gmrJrofwrIyosJAQb3msBKepPsyipCLZnmwCi8GFtXMLj53kdE8tfr7CTmqNMopcdlTn
         JIFw==
X-Gm-Message-State: ANoB5pkiF3Tabgdm1wqWHe3IFoeyEf3A3EgOIfwYIg0wYry4Kw3vIIvZ
        25nhMUTGFY69Fnl0rJlJI+M=
X-Google-Smtp-Source: AA0mqf5unCjHuqdcJSjeP1V5neGbUuDTfChH3gpaM4/PwGVXIraGDY+33eTqW3BgS5s+8Hg/UkItmw==
X-Received: by 2002:a17:906:706:b0:7ac:2e16:eb05 with SMTP id y6-20020a170906070600b007ac2e16eb05mr19494203ejb.26.1669101346255;
        Mon, 21 Nov 2022 23:15:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906b08900b007aef930360asm5817871ejy.59.2022.11.21.23.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:15:45 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:15:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Divya Koppera <Divya.Koppera@microchip.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing
 zero to 'PTR_ERR'
Message-ID: <202211220844.eKHGXYnF-lkp@intel.com>
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
head:   eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
commit: ece19502834d84ece2e056db28257ca2aa6e4d48 net: phy: micrel: 1588 support for LAN8814 phy
config: openrisc-randconfig-m041-20221121
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/net/phy/micrel.c:1750 ksz886x_cable_test_get_status() error: uninitialized symbol 'ret'.

vim +/PTR_ERR +2613 drivers/net/phy/micrel.c

ece19502834d84e Divya Koppera 2022-03-04  2589  static int lan8814_ptp_probe_once(struct phy_device *phydev)
ece19502834d84e Divya Koppera 2022-03-04  2590  {
ece19502834d84e Divya Koppera 2022-03-04  2591  	struct lan8814_shared_priv *shared = phydev->shared->priv;
ece19502834d84e Divya Koppera 2022-03-04  2592  
ece19502834d84e Divya Koppera 2022-03-04  2593  	/* Initialise shared lock for clock*/
ece19502834d84e Divya Koppera 2022-03-04  2594  	mutex_init(&shared->shared_lock);
ece19502834d84e Divya Koppera 2022-03-04  2595  
ece19502834d84e Divya Koppera 2022-03-04  2596  	shared->ptp_clock_info.owner = THIS_MODULE;
ece19502834d84e Divya Koppera 2022-03-04  2597  	snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
ece19502834d84e Divya Koppera 2022-03-04  2598  	shared->ptp_clock_info.max_adj = 31249999;
ece19502834d84e Divya Koppera 2022-03-04  2599  	shared->ptp_clock_info.n_alarm = 0;
ece19502834d84e Divya Koppera 2022-03-04  2600  	shared->ptp_clock_info.n_ext_ts = 0;
ece19502834d84e Divya Koppera 2022-03-04  2601  	shared->ptp_clock_info.n_pins = 0;
ece19502834d84e Divya Koppera 2022-03-04  2602  	shared->ptp_clock_info.pps = 0;
ece19502834d84e Divya Koppera 2022-03-04  2603  	shared->ptp_clock_info.pin_config = NULL;
ece19502834d84e Divya Koppera 2022-03-04  2604  	shared->ptp_clock_info.adjfine = lan8814_ptpci_adjfine;
ece19502834d84e Divya Koppera 2022-03-04  2605  	shared->ptp_clock_info.adjtime = lan8814_ptpci_adjtime;
ece19502834d84e Divya Koppera 2022-03-04  2606  	shared->ptp_clock_info.gettime64 = lan8814_ptpci_gettime64;
ece19502834d84e Divya Koppera 2022-03-04  2607  	shared->ptp_clock_info.settime64 = lan8814_ptpci_settime64;
ece19502834d84e Divya Koppera 2022-03-04  2608  	shared->ptp_clock_info.getcrosststamp = NULL;
ece19502834d84e Divya Koppera 2022-03-04  2609  
ece19502834d84e Divya Koppera 2022-03-04  2610  	shared->ptp_clock = ptp_clock_register(&shared->ptp_clock_info,
ece19502834d84e Divya Koppera 2022-03-04  2611  					       &phydev->mdio.dev);
ece19502834d84e Divya Koppera 2022-03-04  2612  	if (IS_ERR_OR_NULL(shared->ptp_clock)) {

This should be if (IS_ERR(shared->ptp_clock)) {

The ptp_clock_register() will only return NULL if it has been disabled
in the .config.  Ideally the driver would just add checks for NULL where
necessary and continue without the clock.  But if it's not possible then
the driver should add a depend in the Kconfig.  Otherwise the driver
will be built in a way that it can never be used.

ece19502834d84e Divya Koppera 2022-03-04 @2613  		phydev_err(phydev, "ptp_clock_register failed %lu\n",
ece19502834d84e Divya Koppera 2022-03-04  2614  			   PTR_ERR(shared->ptp_clock));
ece19502834d84e Divya Koppera 2022-03-04  2615  		return -EINVAL;
ece19502834d84e Divya Koppera 2022-03-04  2616  	}
ece19502834d84e Divya Koppera 2022-03-04  2617  
ece19502834d84e Divya Koppera 2022-03-04  2618  	phydev_dbg(phydev, "successfully registered ptp clock\n");
ece19502834d84e Divya Koppera 2022-03-04  2619  
ece19502834d84e Divya Koppera 2022-03-04  2620  	shared->phydev = phydev;
ece19502834d84e Divya Koppera 2022-03-04  2621  
ece19502834d84e Divya Koppera 2022-03-04  2622  	/* The EP.4 is shared between all the PHYs in the package and also it
ece19502834d84e Divya Koppera 2022-03-04  2623  	 * can be accessed by any of the PHYs
ece19502834d84e Divya Koppera 2022-03-04  2624  	 */
ece19502834d84e Divya Koppera 2022-03-04  2625  	lanphy_write_page_reg(phydev, 4, LTC_HARD_RESET, LTC_HARD_RESET_);
ece19502834d84e Divya Koppera 2022-03-04  2626  	lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
ece19502834d84e Divya Koppera 2022-03-04  2627  			      PTP_OPERATING_MODE_STANDALONE_);
ece19502834d84e Divya Koppera 2022-03-04  2628  
ece19502834d84e Divya Koppera 2022-03-04  2629  	return 0;
ece19502834d84e Divya Koppera 2022-03-04  2630  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

