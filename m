Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F867DCAB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 04:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjA0DYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 22:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjA0DYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:24:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA19751BC;
        Thu, 26 Jan 2023 19:23:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R0QI1B016371;
        Fri, 27 Jan 2023 03:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=rqkdq0FrvTfBupyXTXXju2DVED87pNKH6/wqePNxuBw=;
 b=wNECLIH3xBkEATUYa4v4OB6hSZkIg2gELTBh7+AsS+XEGGX+HJexD8EQsxmw9IbJIzBM
 0g3ftlTEamw9W013XyZZDi1p+OVjJltDcOus0Hb7BraK+yxIalp/N5ojrdwKK39pXFYC
 bAgFscN81DZ0GPRvsPjAvD06GzU7quD6YBa8DKUHq3aBw7bskXoQIPH3FoYjpGcL2oMU
 uDEBm1GGgjL3YWXWoMxJeucagH5l8kYklMMWoyt5GBvFA8k9XTlyChDwDED40Ha93fMz
 JJS6e/3K/z1DQlT6t9eRA32nZQsNtKiVSREFRSdxpUf1vq9cxxxS/fp+xPKjiKkJ5IGv ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87ntbvmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30R2je8R006635;
        Fri, 27 Jan 2023 03:23:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g8nxsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 03:23:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30R3N7eq036358;
        Fri, 27 Jan 2023 03:23:14 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g8nxpp-7;
        Fri, 27 Jan 2023 03:23:14 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        it+linux-scsi@molgen.mpg.de, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: Demote log level for trace buffer allocation to info
Date:   Thu, 26 Jan 2023 22:23:00 -0500
Message-Id: <167478863293.3972592.1780126487232876209.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230103150438.45922-1-pmenzel@molgen.mpg.de>
References: <20230103150438.45922-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=946 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270029
X-Proofpoint-ORIG-GUID: Hr-un1PNF3TJZHF4tjNYnoL_4fODD7hL
X-Proofpoint-GUID: Hr-un1PNF3TJZHF4tjNYnoL_4fODD7hL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023 16:04:37 +0100, Paul Menzel wrote:

> On a system with the controller below
> 
>     01:00.0 Serial Attached SCSI controller [0107]: Broadcom / LSI Fusion-MPT 12GSAS/PCIe Secure SAS38xx [1000:00e6]
> 
> Linux logs the error below:
> 
>     $ dmesg --level=err | grep mpt
>     [    7.647675] mpt3sas_cm0: Trace buffer memory 2048 KB allocated
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: mpt3sas: Demote log level for trace buffer allocation to info
      https://git.kernel.org/mkp/scsi/c/1eeedfad9a14

-- 
Martin K. Petersen	Oracle Linux Engineering
