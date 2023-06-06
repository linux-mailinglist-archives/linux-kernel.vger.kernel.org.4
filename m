Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7D7236DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjFFFfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:35:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5A71B1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:35:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d20548adso4637881f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686029703; x=1688621703;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DItcVaOjrcYkXzsyVkcyTU788kN+vsjja6o/sf/+zE0=;
        b=Bd3KFnsYSunXxKVeeLkLOn74iafJ1rBrfQyLOcvh7D8nQeCutLkreKDI8c+KzJWwUo
         BHyoCulsuwkl9go5L4Dpht5iwNJ5o4lAUxbiA1mFhq+ClSN6DkqtbCgKXDgVmGYz+lxd
         KxNbhy2k4pwqGcNge6pEIdWiTbYLuN2e0AqlPm5AigYZfUU7+1+TB0Nen9D1oaWCXnUe
         djbRc7JsBtulNXeLZNrYfuDV8QG850iOevEGiZSGroy3pWJS0MXrx4zvQF0hYDBdTtTE
         Doysc9Lk34XNLMh0VTV3PcnXJYLgSuUOTMC1k8jgM3Lvp9VF2vRsBu2vPgsCBAOYngHd
         iLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029703; x=1688621703;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DItcVaOjrcYkXzsyVkcyTU788kN+vsjja6o/sf/+zE0=;
        b=QSpr9zrYl4yEAwAShU4XDZx2stZw6e9x8X3qH98q99Xf6EBuIp5CVCfXtwqcIiw9uF
         CCE1iB2nvXUt+xoVa0zjQ8GtjntEVHHezhQT/kKsiAsw+QvVGTY/W5P344jnJ1TJm0ph
         FikqRa6l8mH2AKPF1w7qeCy8hq39mIeS7a2WE76goNIFfAynggeT7Bcu6NZ6vNlrvtZH
         Upej5kU+ayR5MTkjghDdH1+ygznVigCOzJMztnKVeY7O6o7ROqP3ootSCOUlPD/WjXzc
         USai8dVpWYSeGc3Q16BCtQazIBoW9ipoQ/3xvYYPM8RQS/A2OpusHYqbxa1VtDvKnc8Y
         Jcdg==
X-Gm-Message-State: AC+VfDwq8Lb9tN+dblhxxPlqQWATl4sV/7NJ7+QPZUtNwRbqBRWV3vSN
        A7d0bUUbHSuisZhznxO3BfeJsQ==
X-Google-Smtp-Source: ACHHUZ7oqDCpT2xMNRxrZwF+AKsxLbObVg9DSAGvxtEJxdFiLjqjI9nNLfr2AcBlawUXtdnRTlv98g==
X-Received: by 2002:a05:6000:8c:b0:306:2dc3:8b67 with SMTP id m12-20020a056000008c00b003062dc38b67mr641415wrx.53.1686029703014;
        Mon, 05 Jun 2023 22:35:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d5109000000b003063a1cdaf2sm11464068wrt.48.2023.06.05.22.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:35:01 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:34:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/realtek/rtw88/mac.c:748
 __rtw_download_firmware() warn: missing unwind goto?
Message-ID: <291c3208-39c1-4eb5-bbca-b1331c346782@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9561de3a55bed6bdd44a12820ba81ec416e705a7
commit: 45794099f5e1d7abc5eb07e6eec7e1e5c6cb540d wifi: rtw88: Add rtw8822bu chipset support
config: riscv-randconfig-m031-20230605 (https://download.01.org/0day-ci/archive/20230605/202306052310.OVhcUjZ3-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202306052310.OVhcUjZ3-lkp@intel.com/

smatch warnings:
drivers/net/wireless/realtek/rtw88/mac.c:748 __rtw_download_firmware() warn: missing unwind goto?

vim +748 drivers/net/wireless/realtek/rtw88/mac.c

3d8bf50860c7de Yan-Hsuan Chuang 2020-04-24  717  static int __rtw_download_firmware(struct rtw_dev *rtwdev,
3d8bf50860c7de Yan-Hsuan Chuang 2020-04-24  718  				   struct rtw_fw_state *fw)
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  719  {
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  720  	struct rtw_backup_info bckp[DLFW_RESTORE_REG_NUM];
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  721  	const u8 *data = fw->firmware->data;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  722  	u32 size = fw->firmware->size;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  723  	u32 ltecoex_bckp;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  724  	int ret;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  725  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  726  	if (!check_firmware_size(data, size))
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  727  		return -EINVAL;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  728  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  729  	if (!ltecoex_read_reg(rtwdev, 0x38, &ltecoex_bckp))
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  730  		return -EBUSY;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  731  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  732  	wlan_cpu_enable(rtwdev, false);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  733  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  734  	download_firmware_reg_backup(rtwdev, bckp);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  735  	download_firmware_reset_platform(rtwdev);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  736  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  737  	ret = start_download_firmware(rtwdev, data, size);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  738  	if (ret)
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  739  		goto dlfw_fail;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  740  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  741  	download_firmware_reg_restore(rtwdev, bckp, DLFW_RESTORE_REG_NUM);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  742  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  743  	download_firmware_end_flow(rtwdev);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  744  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  745  	wlan_cpu_enable(rtwdev, true);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  746  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  747  	if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp))
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26 @748  		return -EBUSY;

All the other error paths goto dlfw_fail;

e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  749  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  750  	ret = download_firmware_validate(rtwdev);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  751  	if (ret)
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  752  		goto dlfw_fail;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  753  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  754  	/* reset desc and index */
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  755  	rtw_hci_setup(rtwdev);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  756  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  757  	rtwdev->h2c.last_box_num = 0;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  758  	rtwdev->h2c.seq = 0;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  759  
3c519605850890 Yan-Hsuan Chuang 2019-10-02  760  	set_bit(RTW_FLAG_FW_RUNNING, rtwdev->flags);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  761  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  762  	return 0;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  763  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  764  dlfw_fail:
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  765  	/* Disable FWDL_EN */
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  766  	rtw_write8_clr(rtwdev, REG_MCUFW_CTRL, BIT_MCUFWDL_EN);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  767  	rtw_write8_set(rtwdev, REG_SYS_FUNC_EN + 1, BIT_FEN_CPUEN);
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  768  
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  769  	return ret;
e3037485c68ec1 Yan-Hsuan Chuang 2019-04-26  770  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

