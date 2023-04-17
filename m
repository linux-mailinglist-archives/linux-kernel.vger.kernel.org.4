Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685886E4BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDQOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDQOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:41:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2CDAF14
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:40:59 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HBTAAW025150;
        Mon, 17 Apr 2023 14:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=qcppdkim1;
 bh=b1lGdYC6uUdXFinAGG6xvhPiid8KqvqvXLdg6rBqGzM=;
 b=J2+vy0CyZA+2plhmuP1wrn/uQ0jHPd6x2UWoaTop7suBdSjrdiDorSYGQBiXhHKo+WOk
 gdSLsFgYx5Ctrt8Ke9cFQxZgtIpq86tvcqfBrlreUREHPn2h5QycoDQvTq2Qs+SMgtcM
 qS3hw9tRim729yHAb3iSXFoYeBiC8t6du09mSIxTeeqE8cLsLDvaWbyqjVf0yVxrbQD+
 nhLEV2zJBUq5SYzyjpDgvTQnMzVW/rXgncWE79hx2v/q/RoeecljmiIVO+b3JRw96z7v
 3q7Z/qmyv7h2faJnc77wF9TEzCSk2heVrvhfe/zB/LqInpGQyZrcllAoWNKCUUbyYzC0 6w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12strt8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:40:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HEeexu007537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 14:40:40 GMT
Received: from kvalo10 (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 07:40:37 -0700
From:   Kalle Valo <quic_kvalo@quicinc.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     <oe-kbuild@lists.linux.dev>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: Re: drivers/net/wireless/ath/ath11k/core.c:1309
 ath11k_core_qmi_firmware_ready() warn: missing unwind goto?
References: <b559bd3c-c7c2-409e-ab36-455236572fe5@kili.mountain>
Date:   Mon, 17 Apr 2023 17:40:35 +0300
In-Reply-To: <b559bd3c-c7c2-409e-ab36-455236572fe5@kili.mountain> (Dan
        Carpenter's message of "Sat, 15 Apr 2023 14:37:42 +0300")
Message-ID: <87sfcy4lng.fsf@kvalo10.eu.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W_8UUP8aHYrY_1l6QBkfy38_89PmIFmj
X-Proofpoint-ORIG-GUID: W_8UUP8aHYrY_1l6QBkfy38_89PmIFmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_09,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=684 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> commit: 33b67a4b4e64275b6f2cbc4318f1596c70659111 ath11k: Update WBM idle ring HP after FW mode on
> config: openrisc-randconfig-m041-20230414
> (https://download.01.org/0day-ci/archive/20230415/202304151955.oqAetVFd-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202304151955.oqAetVFd-lkp@intel.com/
>
> smatch warnings:
> drivers/net/wireless/ath/ath11k/core.c:1309 ath11k_core_qmi_firmware_ready() warn: missing unwind goto?
>
> vim +1309 drivers/net/wireless/ath/ath11k/core.c
>
> d5c65159f28953 Kalle Valo 2019-11-23 1276 int
> ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
> d5c65159f28953 Kalle Valo                2019-11-23  1277  {
> d5c65159f28953 Kalle Valo                2019-11-23  1278  	int ret;
> d5c65159f28953 Kalle Valo                2019-11-23  1279  
> 33b67a4b4e6427 Manikanta Pubbisetty 2022-04-06 1280 ret =
> ath11k_core_start_firmware(ab, ATH11K_FIRMWARE_MODE_NORMAL);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1281  	if (ret) {
> 33b67a4b4e6427 Manikanta Pubbisetty 2022-04-06 1282 ath11k_err(ab,
> "failed to start firmware: %d\n", ret);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1283  		return ret;
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1284  	}
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1285  
> d5c65159f28953 Kalle Valo                2019-11-23  1286  	ret = ath11k_ce_init_pipes(ab);
> d5c65159f28953 Kalle Valo                2019-11-23  1287  	if (ret) {
> d5c65159f28953 Kalle Valo 2019-11-23 1288 ath11k_err(ab, "failed to
> initialize CE: %d\n", ret);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1289  		goto err_firmware_stop;
> d5c65159f28953 Kalle Valo                2019-11-23  1290  	}
> d5c65159f28953 Kalle Valo                2019-11-23  1291  
> d5c65159f28953 Kalle Valo                2019-11-23  1292  	ret = ath11k_dp_alloc(ab);
> d5c65159f28953 Kalle Valo                2019-11-23  1293  	if (ret) {
> d5c65159f28953 Kalle Valo 2019-11-23 1294 ath11k_err(ab, "failed to
> init DP: %d\n", ret);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1295  		goto err_firmware_stop;
> d5c65159f28953 Kalle Valo                2019-11-23  1296  	}
> d5c65159f28953 Kalle Valo                2019-11-23  1297  
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1298  	switch (ath11k_crypto_mode) {
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1299  	case ATH11K_CRYPT_MODE_SW:
> aa2092a9bab3f8 Venkateswara Naralasetty 2020-09-08 1300
> set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
> aa2092a9bab3f8 Venkateswara Naralasetty 2020-09-08 1301
> set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1302  		break;
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1303  	case ATH11K_CRYPT_MODE_HW:
> aa2092a9bab3f8 Venkateswara Naralasetty 2020-09-08 1304
> clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
> aa2092a9bab3f8 Venkateswara Naralasetty 2020-09-08 1305
> clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1306  		break;
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1307  	default:
> aa2092a9bab3f8 Venkateswara Naralasetty 2020-09-08 1308
> ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08 @1309  		return -EINVAL;
>
> 	ret = -EINVAL;
> 	goto err_dp_free;
>
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1310  	}
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1311  
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1312  	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
> aa2092a9bab3f8 Venkateswara Naralasetty 2020-09-08 1313
> set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> aa2092a9bab3f8 Venkateswara Naralasetty  2020-09-08  1314  
> d5c65159f28953 Kalle Valo                2019-11-23  1315  	mutex_lock(&ab->core_lock);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1316  	ret = ath11k_core_start(ab);
> d5c65159f28953 Kalle Valo                2019-11-23  1317  	if (ret) {
> d5c65159f28953 Kalle Valo 2019-11-23 1318 ath11k_err(ab, "failed to
> start core: %d\n", ret);
> d5c65159f28953 Kalle Valo                2019-11-23  1319  		goto err_dp_free;
> d5c65159f28953 Kalle Valo                2019-11-23  1320  	}
> d5c65159f28953 Kalle Valo                2019-11-23  1321  
> d5c65159f28953 Kalle Valo                2019-11-23  1322  	ret = ath11k_core_pdev_create(ab);
> d5c65159f28953 Kalle Valo                2019-11-23  1323  	if (ret) {
> d5c65159f28953 Kalle Valo 2019-11-23 1324 ath11k_err(ab, "failed to
> create pdev core: %d\n", ret);
> d5c65159f28953 Kalle Valo                2019-11-23  1325  		goto err_core_stop;
> d5c65159f28953 Kalle Valo                2019-11-23  1326  	}
> 31858805f91ac7 Govind Singh              2020-05-08  1327  	ath11k_hif_irq_enable(ab);
> ec038c6127fa77 Wen Gong                  2021-12-20  1328  
> ec038c6127fa77 Wen Gong                  2021-12-20  1329  	ret = ath11k_core_rfkill_config(ab);
> ec038c6127fa77 Wen Gong                  2021-12-20  1330  	if (ret && ret != -EOPNOTSUPP) {
> ec038c6127fa77 Wen Gong 2021-12-20 1331 ath11k_err(ab, "failed to
> config rfkill: %d\n", ret);
> ec038c6127fa77 Wen Gong                  2021-12-20  1332  		goto err_core_stop;
> ec038c6127fa77 Wen Gong                  2021-12-20  1333  	}
> ec038c6127fa77 Wen Gong                  2021-12-20  1334  
> d5c65159f28953 Kalle Valo                2019-11-23  1335  	mutex_unlock(&ab->core_lock);
> d5c65159f28953 Kalle Valo                2019-11-23  1336  
> d5c65159f28953 Kalle Valo                2019-11-23  1337  	return 0;
> d5c65159f28953 Kalle Valo                2019-11-23  1338  
> d5c65159f28953 Kalle Valo                2019-11-23  1339  err_core_stop:
> d5c65159f28953 Kalle Valo                2019-11-23  1340  	ath11k_core_stop(ab);
> 0366f42640a410 Vasanthakumar Thiagarajan 2019-11-28  1341  	ath11k_mac_destroy(ab);
> d5c65159f28953 Kalle Valo                2019-11-23  1342  err_dp_free:
> d5c65159f28953 Kalle Valo                2019-11-23  1343  	ath11k_dp_free(ab);
> ba47923974fb67 Govindaraj Saminathan     2019-11-27  1344  	mutex_unlock(&ab->core_lock);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1345  err_firmware_stop:
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1346  	ath11k_qmi_firmware_stop(ab);
> 33b67a4b4e6427 Manikanta Pubbisetty      2022-04-06  1347  
> d5c65159f28953 Kalle Valo                2019-11-23  1348  	return ret;
> d5c65159f28953 Kalle Valo                2019-11-23  1349  }
> d5c65159f28953 Kalle Valo                2019-11-23  1350  
