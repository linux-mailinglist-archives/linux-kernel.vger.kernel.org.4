Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EDA6E3125
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDOLhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 07:37:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A9469E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:37:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c9so13202950ejz.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681558668; x=1684150668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gGVDnQxXRcNBB+gIcNBM42K2M5PMWJ09VpXJBsTwcI=;
        b=gha1QMoUmDF6WDoTY0G7NEzu7WdheZvXRT+g956hiOcIV+qJpMdUoPhtz2od7CKPpK
         llXwAccMshWROOkI0yVsi+uqpdtKXwpBKOJQVz0TGNDPvZxMJGbAS1GSpbngUtbNd06x
         Rt5LBvgQVttZaog9RqsKcXUx84cI0T5ZXxh4fhS6O8/5XSHo8GnP5INA57ZIBDlqJZ2y
         fRr777T2JTY7FN+ftSlsA5ufOSoI8K0q0rpnqOJHrWTwc/OEA809xhTYA6GmMk5HSRQu
         H4lCM1j1xmvEWuCiXA4twTLS36vw2bDLe6MMB2yDF0HO7LTNcnL0w6cuQ8y6VWt18jJo
         PiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681558668; x=1684150668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gGVDnQxXRcNBB+gIcNBM42K2M5PMWJ09VpXJBsTwcI=;
        b=D0fI3i5lEz1eYo2jYJGaPSZxfvjMb6Cexpj0e4DMwBmWldvw4dNhefz0YB5Ag5ETxK
         Q5PlKH/R60xklwzA9KV9rtTkhq5AFPgkB7UANO9oxqzjOOfAF/NHjfLLhkqISlnky1jV
         9dtLv1fde5K1nhUQbcfOt64o7XOVycli4/8DG3oMz7MMJzb5MX+yhWVjeIiD6JjSwNz/
         EHyWwnoK0MtnFY1rqBmOclbuAcUglmVtH8DQgG0hvdE8lTnG6bi/Cc4bTWLEVY6rKwl1
         qbJoLsZTJnnQa/o3dvqtJ3ScFs4fWxr49N67SVjBq2J48v2O8tx6otsHleBW/HY+Uwi6
         DJAw==
X-Gm-Message-State: AAQBX9fg7Ht4qPOe/8HaHRiTqDbTEWwyVFtZUGCfS3562Df+5yxmqrND
        reyItH80y9+/EUmmvJ3iNCnv0u8nkLc=
X-Google-Smtp-Source: AKy350bsAWqhR1gZ3XJlBAT2ROvJsdzGaBHGX+jdvZ8Sb0wK5EVIhDUMDasH7H6buMeD/8QNBqlBNA==
X-Received: by 2002:a17:906:5e1a:b0:926:fce:c080 with SMTP id n26-20020a1709065e1a00b009260fcec080mr1616983eju.17.1681558667569;
        Sat, 15 Apr 2023 04:37:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id gv35-20020a1709072be300b0094f07545d43sm1162521ejc.188.2023.04.15.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 04:37:46 -0700 (PDT)
Date:   Sat, 15 Apr 2023 14:37:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: drivers/net/wireless/ath/ath11k/core.c:1309
 ath11k_core_qmi_firmware_ready() warn: missing unwind goto?
Message-ID: <b559bd3c-c7c2-409e-ab36-455236572fe5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
commit: 33b67a4b4e64275b6f2cbc4318f1596c70659111 ath11k: Update WBM idle ring HP after FW mode on
config: openrisc-randconfig-m041-20230414 (https://download.01.org/0day-ci/archive/20230415/202304151955.oqAetVFd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304151955.oqAetVFd-lkp@intel.com/

smatch warnings:
drivers/net/wireless/ath/ath11k/core.c:1309 ath11k_core_qmi_firmware_ready() warn: missing unwind goto?

vim +1309 drivers/net/wireless/ath/ath11k/core.c

d5c65159f28953 Kalle Valo                2019-11-23  1276  int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
d5c65159f28953 Kalle Valo                2019-11-23  1277  {
d5c65159f28953 Kalle Valo                2019-11-23  1278  	int ret;
d5c65159f28953 Kalle Valo                2019-11-23  1279  
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1280  	ret = ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1281  	if (ret) {
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1282  		ath11k_err(ab, "failed to start firmware: %d\n", ret);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1283  		return ret;
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1284  	}
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1285  
d5c65159f28953 Kalle Valo                2019-11-23  1286  	ret = ath11k_ce_init_pipes(ab);
d5c65159f28953 Kalle Valo                2019-11-23  1287  	if (ret) {
d5c65159f28953 Kalle Valo                2019-11-23  1288  		ath11k_err(ab, "failed to initialize CE: %d\n", ret);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1289  		goto err_firmware_stop;
d5c65159f28953 Kalle Valo                2019-11-23  1290  	}
d5c65159f28953 Kalle Valo                2019-11-23  1291  
d5c65159f28953 Kalle Valo                2019-11-23  1292  	ret = ath11k_dp_alloc(ab);
d5c65159f28953 Kalle Valo                2019-11-23  1293  	if (ret) {
d5c65159f28953 Kalle Valo                2019-11-23  1294  		ath11k_err(ab, "failed to init DP: %d\n", ret);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1295  		goto err_firmware_stop;
d5c65159f28953 Kalle Valo                2019-11-23  1296  	}
d5c65159f28953 Kalle Valo                2019-11-23  1297  
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1298  	switch (ath11k_crypto_mode) {
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1299  	case ATH11K_CRYPT_MODE_SW:
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1300  		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1301  		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1302  		break;
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1303  	case ATH11K_CRYPT_MODE_HW:
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1304  		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1305  		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1306  		break;
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1307  	default:
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1308  		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08 @1309  		return -EINVAL;

	ret = -EINVAL;
	goto err_dp_free;

aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1310  	}
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1311  
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1312  	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1313  		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1314  
d5c65159f28953 Kalle Valo                2019-11-23  1315  	mutex_lock(&ab->core_lock);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1316  	ret = ath11k_core_start(ab);
d5c65159f28953 Kalle Valo                2019-11-23  1317  	if (ret) {
d5c65159f28953 Kalle Valo                2019-11-23  1318  		ath11k_err(ab, "failed to start core: %d\n", ret);
d5c65159f28953 Kalle Valo                2019-11-23  1319  		goto err_dp_free;
d5c65159f28953 Kalle Valo                2019-11-23  1320  	}
d5c65159f28953 Kalle Valo                2019-11-23  1321  
d5c65159f28953 Kalle Valo                2019-11-23  1322  	ret = ath11k_core_pdev_create(ab);
d5c65159f28953 Kalle Valo                2019-11-23  1323  	if (ret) {
d5c65159f28953 Kalle Valo                2019-11-23  1324  		ath11k_err(ab, "failed to create pdev core: %d\n", ret);
d5c65159f28953 Kalle Valo                2019-11-23  1325  		goto err_core_stop;
d5c65159f28953 Kalle Valo                2019-11-23  1326  	}
31858805f91ac7 Govind Singh              2020-05-08  1327  	ath11k_hif_irq_enable(ab);
ec038c6127fa77 Wen Gong                  2021-12-20  1328  
ec038c6127fa77 Wen Gong                  2021-12-20  1329  	ret = ath11k_core_rfkill_config(ab);
ec038c6127fa77 Wen Gong                  2021-12-20  1330  	if (ret && ret != -EOPNOTSUPP) {
ec038c6127fa77 Wen Gong                  2021-12-20  1331  		ath11k_err(ab, "failed to config rfkill: %d\n", ret);
ec038c6127fa77 Wen Gong                  2021-12-20  1332  		goto err_core_stop;
ec038c6127fa77 Wen Gong                  2021-12-20  1333  	}
ec038c6127fa77 Wen Gong                  2021-12-20  1334  
d5c65159f28953 Kalle Valo                2019-11-23  1335  	mutex_unlock(&ab->core_lock);
d5c65159f28953 Kalle Valo                2019-11-23  1336  
d5c65159f28953 Kalle Valo                2019-11-23  1337  	return 0;
d5c65159f28953 Kalle Valo                2019-11-23  1338  
d5c65159f28953 Kalle Valo                2019-11-23  1339  err_core_stop:
d5c65159f28953 Kalle Valo                2019-11-23  1340  	ath11k_core_stop(ab);
0366f42640a410 Vasanthakumar Thiagarajan 2019-11-28  1341  	ath11k_mac_destroy(ab);
d5c65159f28953 Kalle Valo                2019-11-23  1342  err_dp_free:
d5c65159f28953 Kalle Valo                2019-11-23  1343  	ath11k_dp_free(ab);
ba47923974fb67 Govindaraj Saminathan     2019-11-27  1344  	mutex_unlock(&ab->core_lock);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1345  err_firmware_stop:
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1346  	ath11k_qmi_firmware_stop(ab);
33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1347  
d5c65159f28953 Kalle Valo                2019-11-23  1348  	return ret;
d5c65159f28953 Kalle Valo                2019-11-23  1349  }
d5c65159f28953 Kalle Valo                2019-11-23  1350  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

