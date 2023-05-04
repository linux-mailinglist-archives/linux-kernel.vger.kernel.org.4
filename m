Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD96F6527
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEDGif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDGid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:38:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13E2122
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:38:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so467865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 23:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683182310; x=1685774310;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0j4be7d2rG+22TYev8I5mh2jy5bdlXqGPQcv/ReyqdQ=;
        b=tw6Qh5w7opRCW4Q+ayJWgUlmG18Ys0UByGAJ+5n2YniM0PUWxitzIRUlXQwPt9EKa8
         NWoSfoieLWgQgVtUWeCJPW14Sb6ANdwBvJug7kzSlxco76xHzRuDBEAlU9wX800ZcVV7
         vrUeX+ISVuoRNMwCuKJ6E/+VFlKYVet33wH9V9N86MCOJsTLfbjmnV1XTXSmB2c9dl+Y
         8qUUS+LbcJH4V5nOPzJcNsWD2eZbAUn/rTgONZoaZobe9uxR501evVCtP9r+IyqcFfOz
         hy7OxzdgCO00XmZaasmrQraKq0lhS8FpiTq+IwTIViSvGJTGf4bf+M2ucJkQsxRC+IMU
         hVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683182310; x=1685774310;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0j4be7d2rG+22TYev8I5mh2jy5bdlXqGPQcv/ReyqdQ=;
        b=a5YBijv56Pe4dgy5nD4zOVbip19eouw15c2TMoVJaIxZH0cSlMnfmvfELs8E01Eafw
         517SXy9sjrVwv8hM39hGRsYTd3UDVJlk2YddtDgZMrPwn9ugcHhBg1za2Kv46dLLlLl0
         9GhClZZayqCbx0lsJVkBf+OrfUMhBdW6LuI5t5T59X33iT/ZlIcl6jd6ogD0dtw+y92D
         srVaHWRZonm06lORikGqlBctT1eto49qA3qD7rppqQVQU3Fjm++s6o8KfXH4+EhcC72k
         YoF9+XtxnJZGFhCPF7mjVRfZxKPFsYgjaGkqrJQLCKm8RmP81X3Y6gqxTS61MTUMDfUe
         hdRg==
X-Gm-Message-State: AC+VfDxXC6i1eUaF9a8pi21bofWY5O8wZWtFDzYzFSUq3iVYgoIKqldR
        xNWqZTl0a6Nb4hhSId3EFiEDiw==
X-Google-Smtp-Source: ACHHUZ6YSFXuWIzgIAn2WEOQ2PDaxiYOet8Q+iWJXYQ4KFH0vwIkq2ihD5MIXOFv//R9vz5DMg9RjQ==
X-Received: by 2002:a7b:cb93:0:b0:3f1:6eaf:daa7 with SMTP id m19-20020a7bcb93000000b003f16eafdaa7mr16219917wmi.10.1683182310180;
        Wed, 03 May 2023 23:38:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003f339b2d06fsm3823493wmc.4.2023.05.03.23.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 23:38:28 -0700 (PDT)
Date:   Thu, 4 May 2023 09:38:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/scsi/mpi3mr/mpi3mr_fw.c:1413 mpi3mr_issue_reset() error:
 uninitialized symbol 'host_diagnostic'.
Message-ID: <90ba7164-a232-4561-9d59-78c0669e2851@kili.mountain>
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

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fa31fc82fb775445c176e576304c4098222f47f2
commit: 3753af778dd9d0d5199d6a7d01b0ead33135d095 kbuild: fix single directory build
config: arm64-randconfig-m041-20230428 (https://download.01.org/0day-ci/archive/20230504/202305040735.8kNJSKlE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305040735.8kNJSKlE-lkp@intel.com/

New smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_fw.c:1413 mpi3mr_issue_reset() error: uninitialized symbol 'host_diagnostic'.
drivers/scsi/mpi3mr/mpi3mr_fw.c:1919 mpi3mr_create_op_reply_q() error: we previously assumed 'op_reply_q->q_segments' could be null (see line 1872)
drivers/scsi/mpi3mr/mpi3mr_fw.c:2027 mpi3mr_create_op_req_q() error: we previously assumed 'op_req_q->q_segments' could be null (see line 2000)
drivers/scsi/mpi3mr/mpi3mr_app.c:1337 mpi3mr_bsg_process_mpt_cmds() warn: potentially one past the end of array 'drv_bufs[mpirep_offset]'
drivers/scsi/mpi3mr/mpi3mr_app.c:1337 mpi3mr_bsg_process_mpt_cmds() warn: potentially one past the end of array 'drv_bufs[mpirep_offset]'
drivers/scsi/mpi3mr/mpi3mr_app.c:1367 mpi3mr_bsg_process_mpt_cmds() warn: potentially one past the end of array 'drv_bufs[erb_offset]'
drivers/scsi/mpi3mr/mpi3mr_transport.c:2063 mpi3mr_expander_add() warn: returning -1 instead of -ENOMEM is sloppy

Old smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_app.c:1338 mpi3mr_bsg_process_mpt_cmds() warn: potentially one past the end of array 'drv_bufs[mpirep_offset]'

vim +/host_diagnostic +1413 drivers/scsi/mpi3mr/mpi3mr_fw.c

824a156633dfdb Kashyap Desai   2021-05-20  1371  
824a156633dfdb Kashyap Desai   2021-05-20  1372  /**
824a156633dfdb Kashyap Desai   2021-05-20  1373   * mpi3mr_issue_reset - Issue reset to the controller
824a156633dfdb Kashyap Desai   2021-05-20  1374   * @mrioc: Adapter reference
824a156633dfdb Kashyap Desai   2021-05-20  1375   * @reset_type: Reset type
824a156633dfdb Kashyap Desai   2021-05-20  1376   * @reset_reason: Reset reason code
824a156633dfdb Kashyap Desai   2021-05-20  1377   *
f061178e076210 Kashyap Desai   2021-05-20  1378   * Unlock the host diagnostic registers and write the specific
f061178e076210 Kashyap Desai   2021-05-20  1379   * reset type to that, wait for reset acknowledgment from the
f061178e076210 Kashyap Desai   2021-05-20  1380   * controller, if the reset is not successful retry for the
f061178e076210 Kashyap Desai   2021-05-20  1381   * predefined number of times.
824a156633dfdb Kashyap Desai   2021-05-20  1382   *
824a156633dfdb Kashyap Desai   2021-05-20  1383   * Return: 0 on success, non-zero on failure.
824a156633dfdb Kashyap Desai   2021-05-20  1384   */
824a156633dfdb Kashyap Desai   2021-05-20  1385  static int mpi3mr_issue_reset(struct mpi3mr_ioc *mrioc, u16 reset_type,
824a156633dfdb Kashyap Desai   2021-05-20  1386  	u32 reset_reason)
824a156633dfdb Kashyap Desai   2021-05-20  1387  {
f061178e076210 Kashyap Desai   2021-05-20  1388  	int retval = -1;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1389  	u8 unlock_retry_count = 0;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1390  	u32 host_diagnostic, ioc_status, ioc_config;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1391  	u32 timeout = MPI3MR_RESET_ACK_TIMEOUT * 10;
f061178e076210 Kashyap Desai   2021-05-20  1392  
f061178e076210 Kashyap Desai   2021-05-20  1393  	if ((reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET) &&
f061178e076210 Kashyap Desai   2021-05-20  1394  	    (reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT))
b64845a7d4039a Sreekanth Reddy 2021-12-20  1395  		return retval;
f061178e076210 Kashyap Desai   2021-05-20  1396  	if (mrioc->unrecoverable)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1397  		return retval;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1398  	if (reset_reason == MPI3MR_RESET_FROM_FIRMWARE) {
b64845a7d4039a Sreekanth Reddy 2021-12-20  1399  		retval = 0;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1400  		return retval;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1401  	}
b64845a7d4039a Sreekanth Reddy 2021-12-20  1402  
b64845a7d4039a Sreekanth Reddy 2021-12-20  1403  	ioc_info(mrioc, "%s reset due to %s(0x%x)\n",
b64845a7d4039a Sreekanth Reddy 2021-12-20  1404  	    mpi3mr_reset_type_name(reset_type),
b64845a7d4039a Sreekanth Reddy 2021-12-20  1405  	    mpi3mr_reset_rc_name(reset_reason), reset_reason);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1406  
f061178e076210 Kashyap Desai   2021-05-20  1407  	mpi3mr_clear_reset_history(mrioc);
f061178e076210 Kashyap Desai   2021-05-20  1408  	do {
f061178e076210 Kashyap Desai   2021-05-20  1409  		ioc_info(mrioc,
f061178e076210 Kashyap Desai   2021-05-20  1410  		    "Write magic sequence to unlock host diag register (retry=%d)\n",
f061178e076210 Kashyap Desai   2021-05-20  1411  		    ++unlock_retry_count);
f061178e076210 Kashyap Desai   2021-05-20  1412  		if (unlock_retry_count >= MPI3MR_HOSTDIAG_UNLOCK_RETRY_COUNT) {
b64845a7d4039a Sreekanth Reddy 2021-12-20 @1413  			ioc_err(mrioc,
b64845a7d4039a Sreekanth Reddy 2021-12-20  1414  			    "%s reset failed due to unlock failure, host_diagnostic(0x%08x)\n",
b64845a7d4039a Sreekanth Reddy 2021-12-20  1415  			    mpi3mr_reset_type_name(reset_type),
b64845a7d4039a Sreekanth Reddy 2021-12-20  1416  			    host_diagnostic);
                                                                            ^^^^^^^^^^^^^^^^
Uninitialized.

f061178e076210 Kashyap Desai   2021-05-20  1417  			mrioc->unrecoverable = 1;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1418  			return retval;
f061178e076210 Kashyap Desai   2021-05-20  1419  		}
f061178e076210 Kashyap Desai   2021-05-20  1420  
f061178e076210 Kashyap Desai   2021-05-20  1421  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_FLUSH,
f061178e076210 Kashyap Desai   2021-05-20  1422  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1423  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_1ST,
f061178e076210 Kashyap Desai   2021-05-20  1424  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1425  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
f061178e076210 Kashyap Desai   2021-05-20  1426  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1427  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_3RD,
f061178e076210 Kashyap Desai   2021-05-20  1428  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1429  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_4TH,
f061178e076210 Kashyap Desai   2021-05-20  1430  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1431  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_5TH,
f061178e076210 Kashyap Desai   2021-05-20  1432  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1433  		writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_6TH,
f061178e076210 Kashyap Desai   2021-05-20  1434  		    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1435  		usleep_range(1000, 1100);
f061178e076210 Kashyap Desai   2021-05-20  1436  		host_diagnostic = readl(&mrioc->sysif_regs->host_diagnostic);
f061178e076210 Kashyap Desai   2021-05-20  1437  		ioc_info(mrioc,
f061178e076210 Kashyap Desai   2021-05-20  1438  		    "wrote magic sequence: retry_count(%d), host_diagnostic(0x%08x)\n",
f061178e076210 Kashyap Desai   2021-05-20  1439  		    unlock_retry_count, host_diagnostic);
f061178e076210 Kashyap Desai   2021-05-20  1440  	} while (!(host_diagnostic & MPI3_SYSIF_HOST_DIAG_DIAG_WRITE_ENABLE));
f061178e076210 Kashyap Desai   2021-05-20  1441  
f061178e076210 Kashyap Desai   2021-05-20  1442  	writel(reset_reason, &mrioc->sysif_regs->scratchpad[0]);
f061178e076210 Kashyap Desai   2021-05-20  1443  	writel(host_diagnostic | reset_type,
f061178e076210 Kashyap Desai   2021-05-20  1444  	    &mrioc->sysif_regs->host_diagnostic);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1445  	switch (reset_type) {
b64845a7d4039a Sreekanth Reddy 2021-12-20  1446  	case MPI3_SYSIF_HOST_DIAG_RESET_ACTION_SOFT_RESET:
f061178e076210 Kashyap Desai   2021-05-20  1447  		do {
f061178e076210 Kashyap Desai   2021-05-20  1448  			ioc_status = readl(&mrioc->sysif_regs->ioc_status);
f061178e076210 Kashyap Desai   2021-05-20  1449  			ioc_config =
f061178e076210 Kashyap Desai   2021-05-20  1450  			    readl(&mrioc->sysif_regs->ioc_configuration);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1451  			if ((ioc_status & MPI3_SYSIF_IOC_STATUS_RESET_HISTORY)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1452  			    && mpi3mr_soft_reset_success(ioc_status, ioc_config)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1453  			    ) {
b64845a7d4039a Sreekanth Reddy 2021-12-20  1454  				mpi3mr_clear_reset_history(mrioc);
f061178e076210 Kashyap Desai   2021-05-20  1455  				retval = 0;
f061178e076210 Kashyap Desai   2021-05-20  1456  				break;
f061178e076210 Kashyap Desai   2021-05-20  1457  			}
f061178e076210 Kashyap Desai   2021-05-20  1458  			msleep(100);
f061178e076210 Kashyap Desai   2021-05-20  1459  		} while (--timeout);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1460  		mpi3mr_print_fault_info(mrioc);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1461  		break;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1462  	case MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT:
f061178e076210 Kashyap Desai   2021-05-20  1463  		do {
f061178e076210 Kashyap Desai   2021-05-20  1464  			ioc_status = readl(&mrioc->sysif_regs->ioc_status);
f061178e076210 Kashyap Desai   2021-05-20  1465  			if (mpi3mr_diagfault_success(mrioc, ioc_status)) {
f061178e076210 Kashyap Desai   2021-05-20  1466  				retval = 0;
f061178e076210 Kashyap Desai   2021-05-20  1467  				break;
f061178e076210 Kashyap Desai   2021-05-20  1468  			}
f061178e076210 Kashyap Desai   2021-05-20  1469  			msleep(100);
f061178e076210 Kashyap Desai   2021-05-20  1470  		} while (--timeout);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1471  		break;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1472  	default:
b64845a7d4039a Sreekanth Reddy 2021-12-20  1473  		break;
b64845a7d4039a Sreekanth Reddy 2021-12-20  1474  	}
b64845a7d4039a Sreekanth Reddy 2021-12-20  1475  
f061178e076210 Kashyap Desai   2021-05-20  1476  	writel(MPI3_SYSIF_WRITE_SEQUENCE_KEY_VALUE_2ND,
f061178e076210 Kashyap Desai   2021-05-20  1477  	    &mrioc->sysif_regs->write_sequence);
f061178e076210 Kashyap Desai   2021-05-20  1478  
f061178e076210 Kashyap Desai   2021-05-20  1479  	ioc_config = readl(&mrioc->sysif_regs->ioc_configuration);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1480  	ioc_status = readl(&mrioc->sysif_regs->ioc_status);
f061178e076210 Kashyap Desai   2021-05-20  1481  	ioc_info(mrioc,
b64845a7d4039a Sreekanth Reddy 2021-12-20  1482  	    "ioc_status/ioc_onfig after %s reset is (0x%x)/(0x%x)\n",
f061178e076210 Kashyap Desai   2021-05-20  1483  	    (!retval)?"successful":"failed", ioc_status,
f061178e076210 Kashyap Desai   2021-05-20  1484  	    ioc_config);
b64845a7d4039a Sreekanth Reddy 2021-12-20  1485  	if (retval)
b64845a7d4039a Sreekanth Reddy 2021-12-20  1486  		mrioc->unrecoverable = 1;
f061178e076210 Kashyap Desai   2021-05-20  1487  	return retval;
824a156633dfdb Kashyap Desai   2021-05-20  1488  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

