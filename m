Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3C26D3BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDCCPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjDCCPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:15:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1512A275;
        Sun,  2 Apr 2023 19:15:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332Lhd9g027378;
        Mon, 3 Apr 2023 02:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=151XJ1P2l/ci+HKdWElgO1JvnzIj7s0cEdJOXG8dc+8=;
 b=QeDCKYpZVPkXxxLJhpcV/WzZWRVHcBM5SSJHfExBtRkXDTkvI8Uj6eVjI5+nM9NNLyt3
 bTOaxVEpUV8LaJogQtylnEaATEbapIsGBowO8hEDS8NyaViblSVphb2Rn2FUSH7wAUkr
 cuNds2sFda8zGQNb7MZQO7ckspPVUXyO7yJ8sHT0maoWbnNJQg5DGJbwfis05O6EZ2b6
 Dct28wRLl/VTcVtN0g4RVRQtI83XGu9aKiNj9eLzjERuY/cZuDeQ70VN3U5wicUIR5Qz
 JreeewOKBeKs07MYMVJDY84YyVR4KwbHz/WXnLzocGMQv0YP3Oemb31xtPLCjeUZDT51 3A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tsxws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332Lusn8013743;
        Mon, 3 Apr 2023 02:15:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3ddbpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3332FHwl010318;
        Mon, 3 Apr 2023 02:15:20 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ppt3ddbn7-4;
        Mon, 03 Apr 2023 02:15:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     don.brace@microchip.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: hpsa: Remove the unused variable transMethod
Date:   Sun,  2 Apr 2023 22:15:05 -0400
Message-Id: <168031383542.650124.10839329057734214083.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com>
References: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=747 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030015
X-Proofpoint-ORIG-GUID: 8ff-TMZQJi9WDhr89Ts4OIeDfnfP2SXT
X-Proofpoint-GUID: 8ff-TMZQJi9WDhr89Ts4OIeDfnfP2SXT
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 13:49:40 +0800, Jiapeng Chong wrote:

> Variable transMethod is not effectively used, so delete it.
> 
> drivers/scsi/hpsa.c:9478:16: warning: variable 'transMethod' set but not used.
> 
> 

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: hpsa: Remove the unused variable transMethod
      https://git.kernel.org/mkp/scsi/c/d93523877e6f

-- 
Martin K. Petersen	Oracle Linux Engineering
