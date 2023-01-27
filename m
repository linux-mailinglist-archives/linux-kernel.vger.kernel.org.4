Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9367DCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjA0DXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjA0DX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:23:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2675728C3;
        Thu, 26 Jan 2023 19:23:21 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0O4B3019439;
        Fri, 27 Jan 2023 03:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=APQiqFhcmLn0pA4kVPJyftYdBrW0Ss0XbZAnK3xmEIU=;
 b=ytZ258WvrIJ6CqRt/zmNgiwW6Si5uXaQEMysOG6ZLHFHVJTiTyompdiKrEVtMEX3lAZf
 m9F6b3drFYFZyyVVCbzJRXMnppLjCA8f7QsHbqmYewuBP1LFFnvK3+kcBhx6R7ZesMFW
 G9WZwqht8hgkrODbSvVyLbsOG0hoaPZ21NZc5HLpUaPd3PJfDxt9AIpY0/7MIUl8+sJV
 RVi45FEQgE6bDOZ4bLyrv5rLjss6b9b+EO+UOmFQ6L1L25FespGQ8qjfgJb7UR/Ex58z
 g+W8ILHQrJmp1BcBeUhZMT59uGgI4H86vsWiSajwWu3S6gwjO/xniDbxW4mQAl3jR5Nz NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku3sy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QNlVcv007006;
        Fri, 27 Jan 2023 03:23:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8nxsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30R3N7es036358;
        Fri, 27 Jan 2023 03:23:15 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g8nxpp-8;
        Fri, 27 Jan 2023 03:23:15 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, jejb@linux.ibm.com, qutran@marvell.com,
        Tom Rix <trix@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Change qla_trim_buf,__qla_adjust_buf functions to static
Date:   Thu, 26 Jan 2023 22:23:01 -0500
Message-Id: <167478863297.3972592.6357225235775673779.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230114013724.3943580-1-trix@redhat.com>
References: <20230114013724.3943580-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=931 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270029
X-Proofpoint-GUID: GMC2wvpdUZj6FH-csm-4OaUmSaw6JGYn
X-Proofpoint-ORIG-GUID: GMC2wvpdUZj6FH-csm-4OaUmSaw6JGYn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 20:37:24 -0500, Tom Rix wrote:

> Smatch reports
> drivers/scsi/qla2xxx/qla_mid.c:1189:6: warning: symbol 'qla_trim_buf' was not declared. Should it be static?
> drivers/scsi/qla2xxx/qla_mid.c:1221:6: warning: symbol '__qla_adjust_buf' was not declared. Should it be static?
> 
> These functions are only used in qla_mid.c, so they should be static.
> 
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: qla2xxx: Change qla_trim_buf,__qla_adjust_buf functions to static
      https://git.kernel.org/mkp/scsi/c/54c51253b3d5

-- 
Martin K. Petersen	Oracle Linux Engineering
