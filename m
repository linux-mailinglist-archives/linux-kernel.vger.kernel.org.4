Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7308E6C1276
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCTM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjCTM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:57:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7DF14E8D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:57:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p34so2403657wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679317031;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvL+slkyTsieeGJof5szMQgGH5S7JIZZEhTxRggeytU=;
        b=b/Sj5ljK6PeZaqOEElQ967UiYgmJ2F8dRTNzsgaFau/bb4dJLCWd4N2pqlyHmOHyaw
         9YwWksQXtuE3LlemF7rOPPkXwJsePmE0kGv6OyOirVM9tRQ2S4yzBc5ZBNnqAulScmf4
         tBV46Ds0D0UfVkfmfzeS1QtwW8yOS9sUW7//w7jOAtLo7skkE5Of6vGjcI01vIxZXPuX
         Y5RXtH9ubPHjIF4gzuXb66y+UBe5lo3YAc+tf7atqpig8KTU52/+UI2RIuP12ZOH0wlx
         wDD8X02BXWPfGuDW9OUHMCqBieJ1gDgdefjNfijgqhPnblQUEkZ9BJyWc9AdwbxyV1i9
         EnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317031;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvL+slkyTsieeGJof5szMQgGH5S7JIZZEhTxRggeytU=;
        b=nCp+8hC3iaijqj+HV+88M+m6vESKRMFwOVYlg/aIdvQLDmBOn/X9wWo/5whgES8tuu
         OyPaZq0FcMwQo4vxR1O88JIZIwgLe/9lTtuoIFXoygG7CDTY+iRlLJu/wbSyhy0T5S/v
         FcW5AdIUewf5zhVDGcRbEwjmBo56atUMTP4dWihg7YtYAxSVLql34d+c9jIQT0mgO0cu
         BmMs73mep5LmzaQL/CXcBvTW2DrQRDuWAyOukpzwobQ2L+AJV8a/zvpMSXQONsmXXBQ6
         LRGhG0DNgPCKe3ORAb+YEh+8x81ZFyDv5DUvyx7rYThheHLMBJ4uMJUmcLiWJUyjXoV1
         nuvA==
X-Gm-Message-State: AO0yUKUVY9M3EptPi82MO72WLeSMYcHFY+Uuo/E6sF9qQFRceglxKIrS
        K44JsuXuh3S0EzoxFkrKdaQ=
X-Google-Smtp-Source: AK7set8KpoqgiJp9ENsmyYOoWci7QkyWDOKsRPDdrTJJK/aIAJnQ05T2f2QvRg8e+aD6u/mjk9C9Vw==
X-Received: by 2002:a05:600c:474c:b0:3ed:355c:4610 with SMTP id w12-20020a05600c474c00b003ed355c4610mr16014104wmo.35.1679317030794;
        Mon, 20 Mar 2023 05:57:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b003e1202744f2sm16773764wmo.31.2023.03.20.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:57:10 -0700 (PDT)
Date:   Mon, 20 Mar 2023 15:57:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_transport.c:1449 mpi3mr_expander_add()
 warn: returning -1 instead of -ENOMEM is sloppy
Message-ID: <97d00233-15d8-46b6-b9e7-36c3c73b3a0f@kili.mountain>
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
head:   e8d018dd0257f744ca50a729e3d042cf2ec9da65
commit: e22bae30667a7e74ed057e00fb6e8c79e0738de3 scsi: mpi3mr: Add expander devices to STL
config: riscv-randconfig-m031-20230319 (https://download.01.org/0day-ci/archive/20230320/202303202027.ZeDQE5Ug-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303202027.ZeDQE5Ug-lkp@intel.com/

smatch warnings:
drivers/scsi/mpi3mr/mpi3mr_transport.c:1449 mpi3mr_expander_add() warn: returning -1 instead of -ENOMEM is sloppy

vim +1449 drivers/scsi/mpi3mr/mpi3mr_transport.c

e22bae30667a7e Sreekanth Reddy 2022-08-04  1337  int mpi3mr_expander_add(struct mpi3mr_ioc *mrioc, u16 handle)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1338  {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1339  	struct mpi3mr_sas_node *sas_expander;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1340  	struct mpi3mr_enclosure_node *enclosure_dev;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1341  	struct mpi3_sas_expander_page0 expander_pg0;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1342  	struct mpi3_sas_expander_page1 expander_pg1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1343  	u16 ioc_status, parent_handle, temp_handle;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1344  	u64 sas_address, sas_address_parent = 0;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1345  	int i;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1346  	unsigned long flags;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1347  	u8 port_id, link_rate;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1348  	struct mpi3mr_sas_port *mr_sas_port = NULL;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1349  	struct mpi3mr_hba_port *hba_port;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1350  	u32 phynum_handle;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1351  	int rc = 0;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1352  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1353  	if (!handle)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1354  		return -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1355  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1356  	if (mrioc->reset_in_progress)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1357  		return -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1358  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1359  	if ((mpi3mr_cfg_get_sas_exp_pg0(mrioc, &ioc_status, &expander_pg0,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1360  	    sizeof(expander_pg0), MPI3_SAS_EXPAND_PGAD_FORM_HANDLE, handle))) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1361  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1362  		    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1363  		return -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1364  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1365  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1366  	if (ioc_status != MPI3_IOCSTATUS_SUCCESS) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1367  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1368  		    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1369  		return -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1370  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1371  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1372  	parent_handle = le16_to_cpu(expander_pg0.parent_dev_handle);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1373  	if (mpi3mr_get_sas_address(mrioc, parent_handle, &sas_address_parent)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1374  	    != 0) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1375  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1376  		    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1377  		return -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1378  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1379  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1380  	port_id = expander_pg0.io_unit_port;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1381  	hba_port = mpi3mr_get_hba_port_by_id(mrioc, port_id);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1382  	if (!hba_port) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1383  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1384  		    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1385  		return -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1386  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1387  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1388  	if (sas_address_parent != mrioc->sas_hba.sas_address) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1389  		spin_lock_irqsave(&mrioc->sas_node_lock, flags);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1390  		sas_expander =
e22bae30667a7e Sreekanth Reddy 2022-08-04  1391  		   mpi3mr_expander_find_by_sas_address(mrioc,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1392  		    sas_address_parent, hba_port);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1393  		spin_unlock_irqrestore(&mrioc->sas_node_lock, flags);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1394  		if (!sas_expander) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1395  			rc = mpi3mr_expander_add(mrioc, parent_handle);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1396  			if (rc != 0)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1397  				return rc;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1398  		} else {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1399  			/*
e22bae30667a7e Sreekanth Reddy 2022-08-04  1400  			 * When there is a parent expander present, update it's
e22bae30667a7e Sreekanth Reddy 2022-08-04  1401  			 * phys where child expander is connected with the link
e22bae30667a7e Sreekanth Reddy 2022-08-04  1402  			 * speed, attached dev handle and sas address.
e22bae30667a7e Sreekanth Reddy 2022-08-04  1403  			 */
e22bae30667a7e Sreekanth Reddy 2022-08-04  1404  			for (i = 0 ; i < sas_expander->num_phys ; i++) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1405  				phynum_handle =
e22bae30667a7e Sreekanth Reddy 2022-08-04  1406  				    (i << MPI3_SAS_EXPAND_PGAD_PHYNUM_SHIFT) |
e22bae30667a7e Sreekanth Reddy 2022-08-04  1407  				    parent_handle;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1408  				if (mpi3mr_cfg_get_sas_exp_pg1(mrioc,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1409  				    &ioc_status, &expander_pg1,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1410  				    sizeof(expander_pg1),
e22bae30667a7e Sreekanth Reddy 2022-08-04  1411  				    MPI3_SAS_EXPAND_PGAD_FORM_HANDLE_PHY_NUM,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1412  				    phynum_handle)) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1413  					ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1414  					    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1415  					rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1416  					return rc;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1417  				}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1418  				if (ioc_status != MPI3_IOCSTATUS_SUCCESS) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1419  					ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1420  					    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1421  					rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1422  					return rc;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1423  				}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1424  				temp_handle = le16_to_cpu(
e22bae30667a7e Sreekanth Reddy 2022-08-04  1425  				    expander_pg1.attached_dev_handle);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1426  				if (temp_handle != handle)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1427  					continue;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1428  				link_rate = (expander_pg1.negotiated_link_rate &
e22bae30667a7e Sreekanth Reddy 2022-08-04  1429  				    MPI3_SAS_NEG_LINK_RATE_LOGICAL_MASK) >>
e22bae30667a7e Sreekanth Reddy 2022-08-04  1430  				    MPI3_SAS_NEG_LINK_RATE_LOGICAL_SHIFT;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1431  				mpi3mr_update_links(mrioc, sas_address_parent,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1432  				    handle, i, link_rate, hba_port);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1433  			}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1434  		}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1435  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1436  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1437  	spin_lock_irqsave(&mrioc->sas_node_lock, flags);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1438  	sas_address = le64_to_cpu(expander_pg0.sas_address);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1439  	sas_expander = mpi3mr_expander_find_by_sas_address(mrioc,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1440  	    sas_address, hba_port);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1441  	spin_unlock_irqrestore(&mrioc->sas_node_lock, flags);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1442  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1443  	if (sas_expander)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1444  		return 0;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1445  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1446  	sas_expander = kzalloc(sizeof(struct mpi3mr_sas_node),
e22bae30667a7e Sreekanth Reddy 2022-08-04  1447  	    GFP_KERNEL);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1448  	if (!sas_expander)
e22bae30667a7e Sreekanth Reddy 2022-08-04 @1449  		return -1;

return -ENOMEM;

e22bae30667a7e Sreekanth Reddy 2022-08-04  1450  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1451  	sas_expander->handle = handle;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1452  	sas_expander->num_phys = expander_pg0.num_phys;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1453  	sas_expander->sas_address_parent = sas_address_parent;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1454  	sas_expander->sas_address = sas_address;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1455  	sas_expander->hba_port = hba_port;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1456  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1457  	ioc_info(mrioc,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1458  	    "expander_add: handle(0x%04x), parent(0x%04x), sas_addr(0x%016llx), phys(%d)\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1459  	    handle, parent_handle, (unsigned long long)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1460  	    sas_expander->sas_address, sas_expander->num_phys);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1461  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1462  	if (!sas_expander->num_phys) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1463  		rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1464  		goto out_fail;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1465  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1466  	sas_expander->phy = kcalloc(sas_expander->num_phys,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1467  	    sizeof(struct mpi3mr_sas_phy), GFP_KERNEL);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1468  	if (!sas_expander->phy) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1469  		rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1470  		goto out_fail;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1471  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1472  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1473  	INIT_LIST_HEAD(&sas_expander->sas_port_list);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1474  	mr_sas_port = mpi3mr_sas_port_add(mrioc, handle, sas_address_parent,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1475  	    sas_expander->hba_port);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1476  	if (!mr_sas_port) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1477  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1478  		    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1479  		rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1480  		goto out_fail;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1481  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1482  	sas_expander->parent_dev = &mr_sas_port->rphy->dev;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1483  	sas_expander->rphy = mr_sas_port->rphy;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1484  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1485  	for (i = 0 ; i < sas_expander->num_phys ; i++) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1486  		phynum_handle = (i << MPI3_SAS_EXPAND_PGAD_PHYNUM_SHIFT) |
e22bae30667a7e Sreekanth Reddy 2022-08-04  1487  		    handle;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1488  		if (mpi3mr_cfg_get_sas_exp_pg1(mrioc, &ioc_status,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1489  		    &expander_pg1, sizeof(expander_pg1),
e22bae30667a7e Sreekanth Reddy 2022-08-04  1490  		    MPI3_SAS_EXPAND_PGAD_FORM_HANDLE_PHY_NUM,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1491  		    phynum_handle)) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1492  			ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1493  			    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1494  			rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1495  			goto out_fail;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1496  		}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1497  		if (ioc_status != MPI3_IOCSTATUS_SUCCESS) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1498  			ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1499  			    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1500  			rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1501  			goto out_fail;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1502  		}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1503  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1504  		sas_expander->phy[i].handle = handle;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1505  		sas_expander->phy[i].phy_id = i;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1506  		sas_expander->phy[i].hba_port = hba_port;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1507  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1508  		if ((mpi3mr_add_expander_phy(mrioc, &sas_expander->phy[i],
e22bae30667a7e Sreekanth Reddy 2022-08-04  1509  		    expander_pg1, sas_expander->parent_dev))) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1510  			ioc_err(mrioc, "failure at %s:%d/%s()!\n",
e22bae30667a7e Sreekanth Reddy 2022-08-04  1511  			    __FILE__, __LINE__, __func__);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1512  			rc = -1;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1513  			goto out_fail;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1514  		}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1515  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1516  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1517  	if (sas_expander->enclosure_handle) {
e22bae30667a7e Sreekanth Reddy 2022-08-04  1518  		enclosure_dev =
e22bae30667a7e Sreekanth Reddy 2022-08-04  1519  			mpi3mr_enclosure_find_by_handle(mrioc,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1520  						sas_expander->enclosure_handle);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1521  		if (enclosure_dev)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1522  			sas_expander->enclosure_logical_id = le64_to_cpu(
e22bae30667a7e Sreekanth Reddy 2022-08-04  1523  			    enclosure_dev->pg0.enclosure_logical_id);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1524  	}
e22bae30667a7e Sreekanth Reddy 2022-08-04  1525  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1526  	mpi3mr_expander_node_add(mrioc, sas_expander);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1527  	return 0;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1528  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1529  out_fail:
e22bae30667a7e Sreekanth Reddy 2022-08-04  1530  
e22bae30667a7e Sreekanth Reddy 2022-08-04  1531  	if (mr_sas_port)
e22bae30667a7e Sreekanth Reddy 2022-08-04  1532  		mpi3mr_sas_port_remove(mrioc,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1533  		    sas_expander->sas_address,
e22bae30667a7e Sreekanth Reddy 2022-08-04  1534  		    sas_address_parent, sas_expander->hba_port);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1535  	kfree(sas_expander->phy);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1536  	kfree(sas_expander);
e22bae30667a7e Sreekanth Reddy 2022-08-04  1537  	return rc;
e22bae30667a7e Sreekanth Reddy 2022-08-04  1538  }
e22bae30667a7e Sreekanth Reddy 2022-08-04  1539  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

