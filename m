Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AF739474
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFVB0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjFVB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:26:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34581BDF;
        Wed, 21 Jun 2023 18:26:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LLcM6u014079;
        Thu, 22 Jun 2023 01:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=cSSXJvzwbsP7uvbiIhgg/wXMRZzlf7HkionQCzwDMMc=;
 b=VXI9CBi/3GMTuGF15duSZRXzzV5TeZDsfFCCUguhyiJuX2XYFLYk3+0Jey7LbG2D0GxW
 HACKhwQFR1GjOek+jQSQRkZIa6sv2o4td6tv8x/GfZ60RacGLhSDSsHsHPvpnxkrF8CU
 etZ6UfzB6T46iB+UhBorltf3ZxGNNtQGwTqb23PdxNPXXy5eyHM4zGHNDCyv//IwB9a3
 55X4pk02IgNy2C3ky84bkq+mgEIIdibhYOrIhLDKQhysjH3i/6MLZkFAfwof1cf9LLy9
 u/b3DOWpkyzq2tQ25c7DwTmkt7KWenhA2L8XBUll2vlRAvQdiLrrMlLfjsyVDxxkc01K Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1gs4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:26:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M0pi6g038617;
        Thu, 22 Jun 2023 01:26:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396tj09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:26:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35M1QXb7038374;
        Thu, 22 Jun 2023 01:26:36 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r9396thxp-9;
        Thu, 22 Jun 2023 01:26:36 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Po-Wen Kao <powen.kao@mediatek.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
Subject: Re: [PATCH v1 0/4] ufs: Introduce MCQ Quirks for MediaTek host
Date:   Wed, 21 Jun 2023 21:26:27 -0400
Message-Id: <168739587248.247655.6838498435493216526.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612085817.12275-1-powen.kao@mediatek.com>
References: <20230612085817.12275-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=828 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220009
X-Proofpoint-GUID: JDCv5bixHWDoYLjfTImxiueTaAZT7aUr
X-Proofpoint-ORIG-GUID: JDCv5bixHWDoYLjfTImxiueTaAZT7aUr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 16:58:08 +0800, Po-Wen Kao wrote:

> v1
> Introduce quirks for non-standard part of UFSHCI and address Bart's comment
> from last patch
> https://lore.kernel.org/all/20230328103801.11198-1-powen.kao@mediatek.com/
> 
> 
> Po-Wen Kao (4):
>   scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
>   scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_RTC
>   scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_INTR quirk
>   scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_RTC quirk
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/4] scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
      https://git.kernel.org/mkp/scsi/c/c4ad4f2e6646
[2/4] scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_RTC
      https://git.kernel.org/mkp/scsi/c/aa9d5d0015a8
[3/4] scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_INTR quirk
      https://git.kernel.org/mkp/scsi/c/95cd364ccc97
[4/4] scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_RTC quirk
      https://git.kernel.org/mkp/scsi/c/3c9b49be6666

-- 
Martin K. Petersen	Oracle Linux Engineering
