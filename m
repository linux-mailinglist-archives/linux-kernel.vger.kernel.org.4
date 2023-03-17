Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8826BDFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCQEFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCQEFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:05:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5C65441;
        Thu, 16 Mar 2023 21:05:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GKnTYj015118;
        Fri, 17 Mar 2023 04:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=S1DYi0fXg9cauOh2B8nkoXvAvQb0BOn7AOmWiiGl0hc=;
 b=Z6bxcFM0gs2Qs5Er5MVBiNj6RWpwjtaL9bG3Yweek+6rEkawc710h/hvV26YhA9HWggS
 fLmRStDXz85ckez5mz5bSOPeprGy3kL8p4W6lGoTkKVzbBsOO/tS66aNYMKUoNDyY7I+
 GJO/2AXzNUcZbCJud3GYHif0z+7QPKWyg7ka4+bTZnEtOMFy5SHMOfBvnPPT6np5wBmN
 Xh7MjLVk5HRqCNTouZkTx30od2RFTgFI/SRJwY82DoyJTA1lqhvCllns9im0Uj/A40aG
 bhKJSjvYVIUKMS/0w2CY4diVRKBUoI18M8dRCfmU8olGgkHfnsFq0/r2QZjCjp5d/3gI pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29aywa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:05:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H2hwWU036776;
        Fri, 17 Mar 2023 04:05:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9jfkp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 04:05:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H454xr027487;
        Fri, 17 Mar 2023 04:05:04 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pbq9jfkkv-1;
        Fri, 17 Mar 2023 04:05:04 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Add BLIST_SKIP_VPD_PAGES for SKhynix H28U74301AMR
Date:   Fri, 17 Mar 2023 00:04:52 -0400
Message-Id: <167902587498.2716429.6166299583657702408.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313041402.39330-1-joelselvaraj.oss@gmail.com>
References: <20230313041402.39330-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_01,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170023
X-Proofpoint-GUID: Dy0WCO5TNiDY3Zv_XkiLC1WKVaf6oMaS
X-Proofpoint-ORIG-GUID: Dy0WCO5TNiDY3Zv_XkiLC1WKVaf6oMaS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 23:14:02 -0500, Joel Selvaraj wrote:

> Xiaomi Poco F1(qcom/sdm845-xiaomi-beryllium*.dts) comes with a SKhynix
> H28U74301AMR UFS. The sd_read_cpr operation leads to a 120 seconds timeout
> making the device bootup very slow. Like the following:
> 
> [  121.457736] sd 0:0:0:1: [sdb] tag#23 timing out command, waited 120s
> 
> Setting the BLIST_SKIP_VPD_PAGES allows the device to skip the failing
> sd_read_cpr operation and boot normally.
> 
> [...]

Applied to 6.3/scsi-fixes, thanks!

[1/1] scsi: core: Add BLIST_SKIP_VPD_PAGES for SKhynix H28U74301AMR
      https://git.kernel.org/mkp/scsi/c/a204b490595d

-- 
Martin K. Petersen	Oracle Linux Engineering
