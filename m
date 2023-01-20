Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C046675DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjATTHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjATTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:07:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A7715CBA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:07:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGE8gK024797;
        Fri, 20 Jan 2023 16:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EDNWgaPr84wzI5zY4rRj3tBHM0uwh4gNSNGy1GLqfSI=;
 b=uZv2dLGTTJLhicPDZEaiGBuowL89Ose4KMV1xUkKmgt1gJE7DXW26jZwjlbp4+8YiD7F
 6XiuQzCMUYsNHF2bcwcFNE5D3Vl6CkBUU9T75TILQYDAi2ZEckaJdUxy+/1CORh+rSvA
 dbAEx0nnOMKCeUwM8D0+sKeCWJTMpTibSfamfc5L7n6V/PaTdhqILX0D55ObnXe1gNXO
 I9HGdDxuOpq+pB7svNQEAtRbaE8nk6l0ilM73oUU146HmkMR0kbwubwfEatFnG1WfI/B
 uVMo/JZCW1HlsGm6NmB5WuMGP6PN+tS5C5qx42lmBMEjFs3g/1sI1JPQReqV9xse9tA0 hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k0154b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KG4G4Z027874;
        Fri, 20 Jan 2023 16:27:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud9185-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkeZBP4uTuIlcUjsansuw7l5zpcNDIbdA7Z272gKSHV0WEe8UkDkCCZfn+NtjGdxqSkfl6Vl0vYXjXcjDObauGmQjz0HYggGBpZw/Tk6Lpu9oL9BOQLGmGHTG+Wxldhk8uk7myTs8B13sGYGj7RksMTMRlsHRBCHuYTGuHjefgffG6uja0+UzxnX+G0bn13GprVZL6a8m0xTpWK6DhPUmL3AGyU8dvPuxrVwZND8nvELvow/uzLEz+PLhSeoQ0MQ7+Ok9x4qRYbCaSO55zlBWhtY1ZUDg88BaqvUQS9r4xoieEX10KWNSRWLbv57oTGeoi8omp0sgTPCj1nrUbdqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDNWgaPr84wzI5zY4rRj3tBHM0uwh4gNSNGy1GLqfSI=;
 b=H+8gU6KC3QhtRQCPOC0qQnvpZ+zeZGfchZCIMuHaNuI4ldWUFKYSUF061dC8lkqf+Dmo1rU5ND+A75K6vU1n1wWGE/8PcvbdmsKa46VIXI3sWfsCl4rjz+hWd/AWjcKF7laN8yFibTSa4UEjlQsQveVXwsD78MNm+cLzhHuIxoxYDYlydtLoDtofqBqAenSB5r9wZKkV3WYlGf+jTItVgf/O0Wkcqyz+RDQUORQ87PTfX2JLD909PK9RdMdywKwPOqPSb9CaUzihvWa8r0z5InQcLORm+NF2XrBMuLR6GllyQSSMBEpIhDrZnmc/7NK4+ivhRAmRQuTVej5bKwE76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDNWgaPr84wzI5zY4rRj3tBHM0uwh4gNSNGy1GLqfSI=;
 b=mopStUYfML9NlbDeC8WpmLsDjTvwVnxwoHuODglEPj70n8kA8H8BFQIV0HPxREhR82rKmZt1tT0IZWk2qDHe1lkMjtVCyiOgoQlRnlEqIN+GoJYkoICSllV8KYVwJBTaGGYqlGktlr5GMZFZUwSgCG+gjVuN3sZxfBxt/If/9fA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 15/49] ipc/shm: Use the vma iterator for munmap calls
Date:   Fri, 20 Jan 2023 11:26:16 -0500
Message-Id: <20230120162650.984577-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 06965935-d7a4-463b-7823-08dafb034478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESWQdx05gPHK+7ix/em7+cJCh/owfqthMghRQtfd2HWm7uQIX6FOCZOMT/tb6Zw7QRqgXbJppl6iC5L1f5lsyWC+ec9M3SiSj5EV0FY/fg8cv+cx4GSP7/k7we+ae1dD8xBhcnzCFnLBc8uZTCuFNdwk4o5TclGuvCQBPzd1mp0UCTRyf5mMZxnYP03jtaktE6Fi4UqOQauVMvHXXs7RzvNUd17jwVe+VGH9TSWfJ7H7w/xCTtVWT8NyBNEv4BuunFuFJ+tESdz+OFLehMrg9KLmLY6a7wSDjCYcQRZIJ9enN8AexvoTshzkafDWnikavlJEOxt8SuRPTAt+B9ulcMmSGu1KtY8jP5S9Go9bmuevMv+668QP5RAQ64G8vZP4s1bca8MHoyuaADxavxfuGwiw8Fh7ni6c17t0z+QsG6cqWC/euA24cbIJn+eGeczvolZCWZCVMa+GeoVaWHztaHCBsrxc9aDUNt9X3wO0vIBJB5jFp24xYlIJZPjpZHkBYbfTQQyT7RE4W1h570zwSBp0W5skFDtdW4LrPE1WZx2alpJGpDr36G4wvNCHSRfHnT5Q2WOFPE85CCiaBVJWH6irFYhiI7i/UR/O4+bb+IRd5sH5kWI+LMb3lPW+PAB50chyWI4Wbks5ZupRqKQhYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CayPXG1M9muknjvu0eCOWmvM8sHetjp19jBWhYYg67ES1f8HkbPQxbktvoa?=
 =?us-ascii?Q?i1S+Q+yPdfYgqVbuq0jn0f37DAhf9tWcbKRujRJ2KHFzDzxXZz3laAXSuheI?=
 =?us-ascii?Q?k+ZehaPLO8t5pA2tU9vbDLBiKhlw67Msn2SYYsoMXekfpfN4vLWraLGNt2la?=
 =?us-ascii?Q?tvWrWMSkzvKJZChZjukGWLHSDzECGhcEUzKEXUqLFhHTo/VG+3oWGZfPm43z?=
 =?us-ascii?Q?aPjUUn6wFVMNBKRcQ+H3CNVFIeemEzaspNrzG1WI9vMtpDPy23A5FO0tgDNi?=
 =?us-ascii?Q?En+pzqirW2wivJU2FKJKzeatOjl2Ryd2Y8OweX8CxIlkH+0ohxFOO9hH8w4z?=
 =?us-ascii?Q?FSR9OGZ5wc4btSBDjduTxcQ79Nofj3ZNGjPaa1m92psucY7AbLFIIGhBbN/F?=
 =?us-ascii?Q?Pd2PJcpFTRTbo1EPH1w4GVYiDxQdp2jnQDEZoSNkrdp63xaUo/BPfQ3HSitU?=
 =?us-ascii?Q?PJD+Jk+krUgZVNjC7GYe5qS7/k7YmWqmuPfqk9Qu5w5/1+n5IXKNkTEWWKcD?=
 =?us-ascii?Q?zsANb56ix5T0N342qD3qkUl3BflpUa+8w2Kka4gqsRgADw3pduZCA+o/U50k?=
 =?us-ascii?Q?hJR6ZfvcTyy6Y+eWvYesLuLTyU5gZfcE69cihw8piNUggzJDXAZ+7bfGuCGQ?=
 =?us-ascii?Q?g/BZHd2KctAnOLR24dtGtpSCDWLcQautj7StaNvywVIms+p5L+qGJGC+UMFv?=
 =?us-ascii?Q?MK/cz7vxxMmCQljdV3dxbfRJRx7HcEvJHWduPGWDzyb2bnwV247vnkghRX/X?=
 =?us-ascii?Q?zPSWJqxBjM9mrZbulDaidfydFHfLwilFNlQZVuwpO8SLLxbU55/zHYSzSWMz?=
 =?us-ascii?Q?iGb/fr7y7wsfxnj8cHkFCYz4CXXp/8HK+Ywe8qNgDCyLprYNYJZMXuVq2MJo?=
 =?us-ascii?Q?5BBPn84j0wGF/icOCFsSEPOgDCjKG1l5wCZUx68gYrhIl0QyBOFJXUn2DSYN?=
 =?us-ascii?Q?TPj6C1UyPtiDEHBbeeCu8sJF+TV5257u5bqBiHThBy29/iHZCZWZTcV2Wu9f?=
 =?us-ascii?Q?RE8kECAo2fikAoN3t8B0eBFgNEt4nmah74oXOJzxEzO6ERsDdpMMMLtiB05W?=
 =?us-ascii?Q?KfgdKhHLmIcVwoXm22y//+j4XitafUdCP97woKixsrdopk7sD5D8lTG4WeZP?=
 =?us-ascii?Q?q8kGYpUBo48UcEP3cQxwHmCEc5MUT/rjzc/UGsBg5QREFOTYsspC0PPo5DtP?=
 =?us-ascii?Q?dEZXOL3CqHSbyI97N37dt66hOmBzy8QIMff9l0L9/eQK2WnO1Ds2HUAoBEgy?=
 =?us-ascii?Q?gg3giXCI+dPuBHGqz62M7vJxQT8rmz3SQubhAIU+MDw7020wytvUNhWqPaut?=
 =?us-ascii?Q?PsxkhzHJXyvIciuaeg5rZd22JkLt9mSEL/EKIYbb++nO/+nFLQtzZLJ28hM/?=
 =?us-ascii?Q?3i0P28tepr3iFagiJrTinzDKEla7Sj9MoRz4+9WXgIqWyDCqomCnrGaVSJqz?=
 =?us-ascii?Q?2t6czGIqimtlnuPZWmfCLU/Y+vP/zo1LOoMDscCDr4Q3fEsNOCMkeuK84fyO?=
 =?us-ascii?Q?edwlSL2V9kS45Wg1R6K+3PCTZgnNEOnE49YGwiexdENcv60HVEi4IeM+tYn4?=
 =?us-ascii?Q?IM4b76KcHA9/Ko5xGXJfX9DVdfB4L6HZ2TqK0/ST9iytVEc6RdHTta5Zk4Ar?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0tDw2qGWkA1ZQhzoQ0eJiCGqUopI8sALZu5VfBvzWEXgDaaOuncFYH1/wwaiAV2D4N7QDCeiP6srbpdBo8AscJbzr1D6Om5JDb7F9cwm+bhDCicoNfvJsU7XEtqE4nAOqdl9OCUG4MM7Vteh6TPe91lUPtbZyie+v0e1W0tjzrA/Wg+80UDlY7YoVTz8ZA3g8G8qS1RFXc4QfV5jSdWfRTKH8XBoUtaAuVmnpVQaJhrwpcuQymrofkLJrbxy+NifQfsVNWk3tviynBgmQyHpeFJzrtMpZJwPXQDYFnLwlDsJWtj4M7KdDEjuaHX3q1Gw3o2ZCcPdj8+EUax9CbuSgWXUF7Kag9K4aa4mEms1tdryMB1K+eEj5MaoeLQhYvBj2L1hb4aYy/zJA5DZDPetEUbVrDwQnmHv4ed1iJTjk9g5QHW6xBF8xwt/QK0c365cABhd9u5MSYoZ8hgtkQRv4IsNVEnBOk60jl1yJ/UL/oaFxm3skOrPcLBu9J03Xi9A67FBfDF9+P/SEHAwjzIO+8+EkLcU2eZ4ljzbpBbme4WbPqsFZF2REOg5MiA6s4ZhCiTtF1RskVqgQ/pFz1o+2V6I8Y4hCBXOC02AZEb/W4k+2frYZTckBkSsUyiMcrq9vkBzrVQfZfGQdNGP+Jwc62gmw2Mu6F7in/Ib0NEIiK4qxX+hO2OavJPdu2aqK09VyCoQQG+74JrfTOdlyyXMMgXRmBT7gqNOQ6ulDCN6WBbfamxRPMqIzpBaA6POjDRTKA6WryZWvMl7csylXjjVA9BlhmQnOYga+rU3s4/Xpq8Duz/7hnKMpNapVefX+s517IgEoKzQ/RsqHJXL3xt0UVjcrSZKWvza2nsHKoO0QXASdnfT4qcos59KYLpX+GsQrZhhBcfN9nB6nh+KDD71TA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06965935-d7a4-463b-7823-08dafb034478
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:47.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaStrcyrsHFDbGQS+grzDqcuE4jewBiplDYUmWe0YE/CI9DzzxfBjHx7xhR/KxDlDQumDYwsP9M1Ogq9LCaXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: rWkD6Vi3PtbenwvBD1LrZMOrBVT807GL
X-Proofpoint-ORIG-GUID: rWkD6Vi3PtbenwvBD1LrZMOrBVT807GL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass through the vma iterator to do_vmi_munmap() to handle the iterator
state internally

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 ipc/shm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index bd2fcc4d454e..1c6a6b319a49 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1786,8 +1786,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file = vma->vm_file;
 			size = i_size_read(file_inode(vma->vm_file));
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-			mas_pause(&vmi.mas);
+			do_vmi_munmap(&vmi, mm, vma->vm_start,
+			      vma->vm_end - vma->vm_start, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1810,10 +1810,9 @@ long ksys_shmdt(char __user *shmaddr)
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops == &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
-		    (vma->vm_file == file)) {
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-			mas_pause(&vmi.mas);
-		}
+		    (vma->vm_file == file))
+			do_vmi_munmap(&vmi, mm, vma->vm_start,
+			      vma->vm_end - vma->vm_start, NULL, false);
 
 		vma = vma_next(&vmi);
 	}
-- 
2.35.1

