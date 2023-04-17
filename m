Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32F6E4BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDQOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDQOn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:43:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C551B742
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:43:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HCtV7Z007267;
        Mon, 17 Apr 2023 14:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=qcppdkim1;
 bh=5qzd+c0AETChtvpI0vuLSbl7U7FbPzJnd0FfoOEhIaE=;
 b=d83kJ4LEVgpDwRbJIfScjM0ci2P9l7VFJg8STkWtX1Vk3RhnMg62DLAte+wcJjjZFwSK
 hpSsm6R9SirIQawc0FyNmpR2dqj/AfCB+IlEOlukxyt/pHw5VLULAc3tfvUdChjHlC2c
 ITR9VKacjAJ2zNVsl58jupmLNDC7p45UCZ88Pgr97wkplcGVXEy7dBi30E/iPtowZYUa
 7lg9FVQX+mpQKjsyca6+WYXrWD1K5YUmMd3pYM4wwmLs301Jnbc0yCr8D5BiWxb2icOM
 a50Wbo2dPAZtv0/Zxdy2yUwKnfPQeaZ2POWtcH/iSPuUCwEcKzPnzQwBU45j516VpQsz UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q11er8y0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:42:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HEgnI2002301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:42:50 GMT
Received: from kvalo10 (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 07:42:41 -0700
From:   Kalle Valo <quic_kvalo@quicinc.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     <oe-kbuild@lists.linux.dev>, <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>
Subject: Re: drivers/net/wireless/ath/ath11k/debugfs.c:1009
 ath11k_debugfs_soc_create() warn: passing zero to 'PTR_ERR'
References: <278dae1d-0cc2-4963-b7f0-5d611a5b31a4@kili.mountain>
Date:   Mon, 17 Apr 2023 17:42:38 +0300
In-Reply-To: <278dae1d-0cc2-4963-b7f0-5d611a5b31a4@kili.mountain> (Dan
        Carpenter's message of "Sat, 15 Apr 2023 16:15:07 +0300")
Message-ID: <87o7nm4lk1.fsf@kvalo10.eu.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H9A4xvmLo5N9w1APDOkTIhTehPqH1_oK
X-Proofpoint-ORIG-GUID: H9A4xvmLo5N9w1APDOkTIhTehPqH1_oK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_08,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=429
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k list

Including the full report below.

Kalle

Dan Carpenter <error27@gmail.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
> commit: 323d91d4684d238f6bc3693fed93caf795378fe0 wifi: ath11k: debugfs: fix to work with multiple PCI devices
> config: openrisc-randconfig-m041-20230414
> (https://download.01.org/0day-ci/archive/20230415/202304152142.ssXYxFdQ-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202304152142.ssXYxFdQ-lkp@intel.com/
>
> New smatch warnings:
> drivers/net/wireless/ath/ath11k/debugfs.c:1009 ath11k_debugfs_soc_create() warn: passing zero to 'PTR_ERR'
>
> Old smatch warnings:
> drivers/net/wireless/ath/ath11k/debugfs.c:1022 ath11k_debugfs_soc_create() warn: passing zero to 'PTR_ERR'
>
> vim +/PTR_ERR +1009 drivers/net/wireless/ath/ath11k/debugfs.c
>
> cb4e57db2ff0c8 Kalle Valo 2020-09-16   998  int ath11k_debugfs_soc_create(struct ath11k_base *ab)
> da3a9d3c15769b Kalle Valo 2020-09-16   999  {
> 323d91d4684d23 Kalle Valo 2022-12-22  1000  	struct dentry *root;
> 323d91d4684d23 Kalle Valo 2022-12-22  1001  	bool dput_needed;
> 323d91d4684d23 Kalle Valo 2022-12-22  1002  	char name[64];
> 323d91d4684d23 Kalle Valo 2022-12-22  1003  	int ret;
> 323d91d4684d23 Kalle Valo 2022-12-22  1004  
> 323d91d4684d23 Kalle Valo 2022-12-22  1005  	root = debugfs_lookup("ath11k", NULL);
> 323d91d4684d23 Kalle Valo 2022-12-22  1006  	if (!root) {
> 323d91d4684d23 Kalle Valo 2022-12-22  1007  		root = debugfs_create_dir("ath11k", NULL);
> 323d91d4684d23 Kalle Valo 2022-12-22  1008  		if (IS_ERR_OR_NULL(root))
> 323d91d4684d23 Kalle Valo 2022-12-22 @1009  			return PTR_ERR(root);
>
> Debugfs used to return a mix of error pointers and NULL but we changed
> the NULL return to an error pointer to encourage people to just delete
> all debugfs error handling code.
>
> 323d91d4684d23 Kalle Valo 2022-12-22  1010  
> 323d91d4684d23 Kalle Valo 2022-12-22  1011  		dput_needed = false;
> 323d91d4684d23 Kalle Valo 2022-12-22  1012  	} else {
> 323d91d4684d23 Kalle Valo 2022-12-22 1013 /* a dentry from lookup()
> needs dput() after we don't use it */
> 323d91d4684d23 Kalle Valo 2022-12-22  1014  		dput_needed = true;
> 323d91d4684d23 Kalle Valo 2022-12-22  1015  	}
> 323d91d4684d23 Kalle Valo 2022-12-22  1016  
> 323d91d4684d23 Kalle Valo 2022-12-22  1017  	scnprintf(name, sizeof(name), "%s-%s", ath11k_bus_str(ab->hif.bus),
> 323d91d4684d23 Kalle Valo 2022-12-22  1018  		  dev_name(ab->dev));
> da3a9d3c15769b Kalle Valo 2020-09-16  1019  
> 323d91d4684d23 Kalle Valo 2022-12-22  1020  	ab->debugfs_soc = debugfs_create_dir(name, root);
> 323d91d4684d23 Kalle Valo 2022-12-22  1021  	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
> 323d91d4684d23 Kalle Valo 2022-12-22  1022  		ret = PTR_ERR(ab->debugfs_soc);
> 323d91d4684d23 Kalle Valo 2022-12-22  1023  		goto out;
> 323d91d4684d23 Kalle Valo 2022-12-22  1024  	}
> 323d91d4684d23 Kalle Valo 2022-12-22  1025  
> 323d91d4684d23 Kalle Valo 2022-12-22  1026  	ret = 0;
> 323d91d4684d23 Kalle Valo 2022-12-22  1027  
> 323d91d4684d23 Kalle Valo 2022-12-22  1028  out:
> 323d91d4684d23 Kalle Valo 2022-12-22  1029  	if (dput_needed)
> 323d91d4684d23 Kalle Valo 2022-12-22  1030  		dput(root);
> 323d91d4684d23 Kalle Valo 2022-12-22  1031  
> 323d91d4684d23 Kalle Valo 2022-12-22  1032  	return ret;
> da3a9d3c15769b Kalle Valo 2020-09-16  1033  }
