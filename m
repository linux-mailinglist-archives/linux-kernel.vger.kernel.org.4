Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC26B7703
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCML57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCML5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:57:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E6211EF;
        Mon, 13 Mar 2023 04:57:35 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMpq11016396;
        Mon, 13 Mar 2023 11:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=g0Rzw+eRZpRhuJgCsIWnnQHJOZib2dCc0mMTz27LTUQ=;
 b=iQJN0CelMhu0PiK0GN5fM2dz0/F1++Fjq1nIy3bcAkaej/H98k/KekMz0VntSgBQSivo
 +D1uXh4uWNYIsFA8OKgtwZ3bkP98DOQbSqDkhb+3D6rLQ0V5cLsYrksJqPSMXCEUVtw3
 7uH2oBVLzOzRXRxPN0Kj/nq6Og/eSeIkejQ127TaUrPeAos8MCIq63q1qrmbEmhwahGH
 gE9fyZhJ19YyL9RKRi73mC0EdlLmtNE2gqw/16ioJP0lgiufujoqo07IKdIZmrfnKKoe
 mdp+YtwdFqGMU3yiP9J/eNY5OeiAng8qiPPAIqmJEnBvHo+ugWZgwXKLPWdVC8ApQyNJ Rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8gjbbkgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D9Ppck002459;
        Mon, 13 Mar 2023 11:10:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0kf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4wX0Z0vcP2rsg5E6M8DyM9qgIjLaiVDvOV8nwnI6v2bgjER2zZdg+HnakP+2ERCFl/yCj5YFmJPJ1GPgtnzcF+0MYCJAlphgquQlnNJjb2+SlZB94PHlQ7IHT4VbkEtohpqErtnrJib70ypNaJeBnMxabBGVlJ+PE8F2awFJ1VPjo/vWu4Od705KxzBh/+KAdPB//lRzTYXH2DOI6L1hMnnF1ev01stnpTSRqdrGhpMiSjTpIL5Yas+z4K+Iay9H85SAtuh8pLyGLH+iQTSF+VXmzc/MjEoP/4VWVYWJT4DODu9Y0g2Q9sZiwIjb9SjsgEYeXye6kMwO4N7vODErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Rzw+eRZpRhuJgCsIWnnQHJOZib2dCc0mMTz27LTUQ=;
 b=IlNPDrarbx1wzerMb8VroSri+RnykcgElDsZcJu1pTN2QoqKd8WfqAZKJumEcDmB4iAptvRDiI9UV72vv4WAUYbtIPvV6NoKZdWLYu/q8ZpYpnBWKEDtOFKGP0CJafjhL/Y+IBn0PI1H5maKzxbwVSwxGlSTsfayeWSnblLk8hODsJMYtAarB4O7o+1tkicupXk9Hh+DZwLid9ctiC71ucsoK1m+aT66KPzTmy93rv8Uvhw69G/dPu+NhFCCxQ6oA53bbTlsuYbc4GeBtdH4gRUktLhKLlg+ikzm2qQEXok8AY3Y21SC2iIkVb1vQZPt8HmGJCOJpvt96UU8rpcw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Rzw+eRZpRhuJgCsIWnnQHJOZib2dCc0mMTz27LTUQ=;
 b=sCMW+jrR1LcX/cjVFcYj11Wg4dDu1+6kk1A3kkLmQzFAHFWyGyG+p40z5THmzNQpwdpfgeTi5T3K4H5AIgUOK7GMvyAn8+IH7Ms6JKODXDXDjMOo6CEK7ATkBR5Z5bC735qGpRnoOD1L7EpqSrSGkSJwt8M+b1XqEpVIT+Lr4WU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:54 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 8/9] scsi: scsi_debug: Use scsi_host_busy() in delay_store() and ndelay_store()
Date:   Mon, 13 Mar 2023 11:10:18 +0000
Message-Id: <20230313111019.1521680-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313111019.1521680-1-john.g.garry@oracle.com>
References: <20230313111019.1521680-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0126624c-171e-4797-0e1c-08db23b39d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ddb1KhGR8SjBsmuIta5MRZx+tol+ySNx5Fr8y+lLP/Onz7w2DNJiwml4XBkdQzLQkIpDmScIrBd3GLh5stDwKT/9+GNeS0OIeh6uopmt5GUAVnmn+OlB5kMbFr40kIVVCy2bJ2arXaY6sD5rUH5cBFFIbVmsEfxn1OI/DgoKnedv1eF++lg0gkrQLsmn0o5l4G0T8pa0MxL58WyE47zc6+FBEPHaMDevusXmfDB3QKr+3Rp2X54w5hQ5GxZ2yMf/bbRnYtpprwilQ+hOb7OAhfUP23vKT/c6bmc5x39dJpCnHgU6gpFn6+6maAxdysRaNTTUssLbHSTW2eEGqDsJeZv5VZxreRVejD2YYLvgrTR/jIVpIqiBsyMn7rrSKHmJHYBQcbxrv2N1Uf9MjQwIiHKS/qU9on33pUr+gTG0JF9U/B9FtPWvhGF/jcvUo7QJ1pnly0H2PCX01odMVjjX3eiWwh30zfCnQB8MvszP8xKMzeppOOtM0xeCxaPOo0zcT+9QyxA2mAjj2S0AWRQthAl5yOdNm6hA6VWZRRnEU7E7lHZB2lxSGsL3DkVcfRa/ei4xcujgKY5AMCIbdmD/J+6T8YbIAw+RfKS6pHK0XJ44AyWQWkuuheZM8o7X0QwbVKfEUdJelkLyi1/a9muYNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7D5RLzCvCCUNhWLLSk4ijFySZfz2CCHyM7vQ03GN7rYapcuj1Eaa64ac9sof?=
 =?us-ascii?Q?qvyEy/hwMubuv/WUlEMm9MC6QU34xW/q+42iIDtVKAxLARx8FKDTKFTV+1VH?=
 =?us-ascii?Q?z0wqaXvOupaJb80JUwF7q1dQWOV/lTYWasq57tYko3TCrwv+z25/mzV/I6as?=
 =?us-ascii?Q?Ljnpl/GzQaPs0wTlMmrbWksHRX5R+2AauQiSGBXv7pptoHiq1380BoOHxwX1?=
 =?us-ascii?Q?6kJlEPSo2Cxr9rMrjmOgfxiQUlQvgRL8fWMO8gjqWN8dxWwaZenZFRpvz0l3?=
 =?us-ascii?Q?ozz8u1T+XGAoGq+0K8EK+aE56BZ9w+PF+zeU3M/0c/Dq34a4O6t6DwiSGWL9?=
 =?us-ascii?Q?CvWRGdmU7+RM83GqRO0MVlcY5EJPnM5K9Syfegwn4oolZA9kvkvC4G2MV5JA?=
 =?us-ascii?Q?ij/YUlLeZQykoSv0DU4PBGZyy2AysynkRK21YYrhjy83rFNUo3lJJTumyvPe?=
 =?us-ascii?Q?lfXmAyuWy2bFTZYCKFV8BqscmHL1dvxbXPYzPfOYu+ZLgnR7kCXTOtgLqort?=
 =?us-ascii?Q?fCJWnUDjoAW9leoTgd5VNHEYs/NCmh6owdtuGyGseo9ma56kQk1uNFXtri7t?=
 =?us-ascii?Q?HkSpxgbooBoPyEOdU+nGryny9ZBo3MdB/h23H3XPs+3OGBrAlOMDx2IlnsWL?=
 =?us-ascii?Q?Bj5lT/K7zXKxhf6R8/RkOfJkaX4Z53AJVbnIoRQF8B2tYI47UH0mjfAzxj12?=
 =?us-ascii?Q?kkbo3Fr1UNNi2ijf6g2r9ncH3XwcH4li2mVtkQB9mOCRBoRCBiQrhAy1XshK?=
 =?us-ascii?Q?DhdX4MTA2fREiuzD5yPTHiELZQkQCFUs3tIprpdgUoKLW7IPhqvOYC/Rpn2f?=
 =?us-ascii?Q?/8+dJLauHuLIgQnUCw1KUudzvVXxgcJHa7Lva93vb5LIJYgNy5EZg8tiVoAV?=
 =?us-ascii?Q?vwzlPKCdqm/kPeODchn5GM/N0cMe1fn3ELjrUuC9OhrByqfgf+xVZTUcXiqB?=
 =?us-ascii?Q?QJhb0kneE0V41zTjJbrLj/waIc5Wk+i29OXOUX31axwALBWM/6C38qNi1lt5?=
 =?us-ascii?Q?FqflXLcu8Tlbzqiu0Db9WEUcfjMEEwlH4hfwYEecp+RvmErUGtEw3gALJNJf?=
 =?us-ascii?Q?v9KecErLLceGjDYcJRV7JaOvPiOwMJ8KgkyqKuRnnFaRFUzsleYQMudsQ0fz?=
 =?us-ascii?Q?EZto10Wr4WVlEpc/7kdbPtYi2CtHr/0VkHA6WSYtSEWPbzG6IE8Ju3pa/ZuK?=
 =?us-ascii?Q?hzVSbfxrkVsyelkZnDieFWht0PDLcS828DhJqH+QOOS8jRl/w+j/Oq4pwCC7?=
 =?us-ascii?Q?2Bbj/nRgWB366+LGs7+fZpDIGqRwnzrB1kiSpc9U9EkMUCS/szaYtH+uNrJ+?=
 =?us-ascii?Q?I2w0zvGx0CUqt1akMYHAA39pVUwMe34IX5npt5SQEj7thT+rSBtHgMiGF5Gk?=
 =?us-ascii?Q?OuMe4cnvT8e1cqJi/1fQa86NnYpoSNORadh/likgKVTq0lbEHs+TIUptwoK0?=
 =?us-ascii?Q?h2KOUSKv7P7SuWKN3v7ZMA2B7FoLs3Y9/Lq463XVpX0/osJsHRfB28IYK5ow?=
 =?us-ascii?Q?cnp41xisTiVBR6Y0DwNJqXZcThpAvM5YzeeHnPS2itEoPxsW5jWmN5d+ZoNH?=
 =?us-ascii?Q?WLZ3XGP8Z519iJwn2PYJA+0zayXYTKo7mGtyfuTspqFIFff63hjAzMGuSWO0?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cmMY9xUBfHr6ikyLrkVvECrNy1Vxc2qU+w8qYfNy0NVfS8V6X+SmC4ZYu7GU05TSLeEwz2VHBhkWyEyfTVbaQ+GV/exdnxCNQIzSKazTsjWM+qleZI+PTNMGJF7WOSwYBB0T5b3rjCg9JK2Qvg65fTylgh6O57vqAgGplGtPZRQnvzQWhTd+qoil+2ujdORz4UyWWxp1dsSdoonOV5KW5vdV4E7TvHfdowduBeAYEBSxZFmx/L643r4I11iyJjTIt7JvfuwYQM7WSa6LkOXHceZAP3k6DMAqYkJPyoNGOo31lik+lwoyLa07LmWNMFhPdPm0coq0JlOlw0DhcSl5AKL97I63cOi4fAEH8vsHGo5w+Nv+qUZ7JawJbvovEHhHOs07Kd7R8dV0qehe6rsDlLbPVFyhYWoErl+Mbau1PSYbkbyAW8niiArCh5xIFCu79ZgWntZ81nI89u2UMgNSdUddOcub419wV4MFGR+JdC/wa/UyFd4D8iRtNTB/t38ZdEqfCzlU3gJeHKGGDuN39lsQICjXA5vlyFysqgtJFBHgjOirPyG62mME9X9mo+22BoySGZYoNYPOxjCmCII1izQy3/eN5rBoh09yArxwhY+c50k/EGKz3/JYVQ9fzPm7BEu0NcmtwG6aAd3d5tYLY4wdFrmF8oJGJKV4mYFLN2AOQAO8R7bqGb08Iq8Bdb+JOVzPYGLGJuRx8lxwREsDyAMcgG0vhTdKvtSvI+NPhGJr0F6J/HaUGWgTZU4IagYdLO/h56Auo0ciSEJycu1mle07XcKUqf2ZD2t+HxdR2a31D1sIoJllGLrhXcoPkrZT9i0/RqlVQigf7EaGHXfzlIPX3xMVGqNrNzwPoOKAZnKrvTOZPnze6FK9QL6nenM7DoiEj+8JGBuT7yGCRWPtXNzB/3loENpzGd45jse9uiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0126624c-171e-4797-0e1c-08db23b39d08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:54.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35wrOQbASI6CdLYWcOn+rFKr9fr82dMsb+s+S1OiPEDh1DGTIZm3/rrv7W2R9tJk20negpVRcWqqdAUHiMfTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-ORIG-GUID: HzIi2gXS7Pb7fhmvDXLLLZAuOmeJsq2A
X-Proofpoint-GUID: HzIi2gXS7Pb7fhmvDXLLLZAuOmeJsq2A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions to update ndelay and delay value first check whether we have
any in-flight IO for any host. It does this by checking if any tag is used
in the global submit queues.

We can achieve the same by setting the host as blocked and then ensuring
that we have no in-flight commands with scsi_host_busy().

Note that scsi_host_busy() checks SCMD_STATE_INFLIGHT flag, which is only
set per command after we ensure that the host is not blocked, i.e. we
will not see more commands active after the check for scsi_host_busy()
returns 0.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index cc2da4cc62b5..7ef195072d97 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6059,16 +6059,15 @@ static ssize_t delay_store(struct device_driver *ddp, const char *buf,
 	if (count > 0 && sscanf(buf, "%d", &jdelay) == 1) {
 		res = count;
 		if (sdebug_jdelay != jdelay) {
-			int j, k;
-			struct sdebug_queue *sqp;
+			struct sdebug_host_info *sdhp;
 
 			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
-			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-			     ++j, ++sqp) {
-				k = find_first_bit(sqp->in_use_bm,
-						   sdebug_max_queue);
-				if (k != sdebug_max_queue) {
+
+			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+				struct Scsi_Host *shost = sdhp->shost;
+
+				if (scsi_host_busy(shost)) {
 					res = -EBUSY;   /* queued commands */
 					break;
 				}
@@ -6101,20 +6100,20 @@ static ssize_t ndelay_store(struct device_driver *ddp, const char *buf,
 	    (ndelay >= 0) && (ndelay < (1000 * 1000 * 1000))) {
 		res = count;
 		if (sdebug_ndelay != ndelay) {
-			int j, k;
-			struct sdebug_queue *sqp;
+			struct sdebug_host_info *sdhp;
 
 			mutex_lock(&sdebug_host_list_mutex);
 			block_unblock_all_queues(true);
-			for (j = 0, sqp = sdebug_q_arr; j < submit_queues;
-			     ++j, ++sqp) {
-				k = find_first_bit(sqp->in_use_bm,
-						   sdebug_max_queue);
-				if (k != sdebug_max_queue) {
+
+			list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
+				struct Scsi_Host *shost = sdhp->shost;
+
+				if (scsi_host_busy(shost)) {
 					res = -EBUSY;   /* queued commands */
 					break;
 				}
 			}
+
 			if (res > 0) {
 				sdebug_ndelay = ndelay;
 				sdebug_jdelay = ndelay  ? JDELAY_OVERRIDDEN
-- 
2.35.3

