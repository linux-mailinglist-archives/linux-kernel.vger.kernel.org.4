Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254274F560
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjGKQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjGKQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:32:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C631722;
        Tue, 11 Jul 2023 09:32:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9NiAK005730;
        Tue, 11 Jul 2023 16:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=8UkPXgHJnYkQCXxZa4zvinXjy2g3MTsYet7dBuKMxCM=;
 b=0sOX2Zpu3dalQ+9m5wGeFLRVDHfoU6d0Eo8zDaoo5qjGANSikkmTvEj2vxo6ZgOTNsFW
 rEqdmyq+FFVZDuOZCPRPVNBfDJ/+PL1biZ/hfvkv+mCQbYSe/5eXfBZy64olnhNlyrPV
 Y/g1H2SV7YLZ3OaVHlKIY9kWskOwzAEPbVYhd3AFQE32vPqWfvKFWSYEz5/8DqgfgSHI
 Ix4SwgiPA0gqP7MC2P2qBExcgu3OeNOeYvKy7ZrtOvsjQ17T34cGlQBmCBW2K1kD85hX
 a9rm9qwdeOwu4Ak3HAkCjH/JZZCg9MgTxKdUMOBbGYTsuF1RseAj3f2dQ3OA0GVZybKX LQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmhau5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:32:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BF5B14007175;
        Tue, 11 Jul 2023 16:32:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx854cgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:32:07 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BGQBXV019529;
        Tue, 11 Jul 2023 16:32:07 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rpx854c4h-7;
        Tue, 11 Jul 2023 16:32:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH RESEND] scsi: ufs-mediatek: add dependency for RESET_CONTROLLER
Date:   Tue, 11 Jul 2023 12:31:48 -0400
Message-Id: <168909306215.1197987.11044186916008223699.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230701052348.28046-1-rdunlap@infradead.org>
References: <20230701052348.28046-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=788
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Proofpoint-ORIG-GUID: xVg8CnqmzB0D8QwPe2cW16ZMpPjtyouI
X-Proofpoint-GUID: xVg8CnqmzB0D8QwPe2cW16ZMpPjtyouI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 22:23:48 -0700, Randy Dunlap wrote:

> When RESET_CONTROLLER is not set, kconfig complains about missing
> dependencies for RESET_TI_SYSCON, so add the missing dependency
> just as is done above for SCSI_UFS_QCOM.
> 
> Silences this kconfig warning:
> 
> WARNING: unmet direct dependencies detected for RESET_TI_SYSCON
>   Depends on [n]: RESET_CONTROLLER [=n] && HAS_IOMEM [=y]
>   Selected by [m]:
>   - SCSI_UFS_MEDIATEK [=m] && SCSI_UFSHCD [=y] && SCSI_UFSHCD_PLATFORM [=y] && ARCH_MEDIATEK [=y]
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: ufs-mediatek: add dependency for RESET_CONTROLLER
      https://git.kernel.org/mkp/scsi/c/89f7ef7f2b23

-- 
Martin K. Petersen	Oracle Linux Engineering
