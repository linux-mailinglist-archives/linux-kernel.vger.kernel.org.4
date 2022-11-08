Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1026207F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiKHEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiKHECS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:02:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23CE12098;
        Mon,  7 Nov 2022 20:02:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OaSe029245;
        Tue, 8 Nov 2022 04:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=hpac+svPeY3KyQ+gp8Yw1XVT8RWqFaCgvJefANWpUEo=;
 b=u5M1Nt/0t1MPuu86Sl6baPM6w8CNGfyoLSIvgs8Tuf3MBJNHAPDKrul/PDh9kTYMrIka
 5LkHFTnpvD84jvfX5F1neSPjVeCFWjwNl/K5NVSswwZfHgtSEU41WT6qxsbA2SymNdau
 2XIed57zyoxkI1zGf4KbRHG1FCL9GCGgF7tivLaI52788G/9tkA6ww7nFeXaD3UIsLH3
 lIEqXlzNNETqun1oRvyxq0htne1AqyW9cCTCD1VnnY213Q3cfjx1eVGBI3DiKpnOsld3
 zSvAtUn2IslI3IksJ4cmU0FcvfA6wwqUt0SNgdAZgehegbNf5pGldi4M3U76Won3QjZ5 Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfx5e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:02:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A83MHV7025650;
        Tue, 8 Nov 2022 04:02:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfh3tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 04:02:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A841vco022774;
        Tue, 8 Nov 2022 04:02:00 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcqfh3s5-6;
        Tue, 08 Nov 2022 04:02:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org, chenxiang66@hisilicon.com
Subject: Re: [PATCH] MAINTAINERS: Make Xiang Chen HiSilicon SAS controller driver maintainer
Date:   Mon,  7 Nov 2022 23:01:53 -0500
Message-Id: <166787988589.644518.5758321410761277323.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1666784008-125519-1-git-send-email-john.garry@huawei.com>
References: <1666784008-125519-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=996 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080020
X-Proofpoint-ORIG-GUID: z7Z5JnoPzha81MSS8zMdWivD3pEwO0Ac
X-Proofpoint-GUID: z7Z5JnoPzha81MSS8zMdWivD3pEwO0Ac
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 19:33:28 +0800, John Garry wrote:

> I am soon leaving Huawei, so will no longer maintain this driver. However
> I will stay active in upstream linux storage domain.
> 
> Xiang Chen has worked on the driver for as long as I have and has good
> knowledge of the driver, so should do a good job.
> 
> 
> [...]

Applied to 6.2/scsi-queue, thanks!

[1/1] MAINTAINERS: Make Xiang Chen HiSilicon SAS controller driver maintainer
      https://git.kernel.org/mkp/scsi/c/e6629dcb00ad

-- 
Martin K. Petersen	Oracle Linux Engineering
