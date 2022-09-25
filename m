Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1545E9484
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiIYQ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiIYQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:57:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6120B2B277;
        Sun, 25 Sep 2022 09:57:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9A3q7032194;
        Sun, 25 Sep 2022 16:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=7WBREF244abCgL93q/zOvOr2X9+IL5wnfMd/gyGGIpI=;
 b=ZWWgrP4Gq3yPJMZ/aV3JM6fFVRveFJu93K2ClYhcxTpIaTRB0XAF6mGm8dIGs/63ZU6s
 Bx+DnnD/BakNTFJycDr4e0hyTQvIoPtsn9n/fK2XI02pxP7YzH/kGrWJEYKa+WVLCOUr
 VatbprICf99/82qd7vZYIziYZ+3XlmhSfqrtox66MfinwCXDIizp48Xdf1VGriH3tExP
 e7HNcu0vkiqIY+RtiulBeTiLgEaZqjPGxt3D+BrFJ7ESVbktF52t1/G6i7+Fd2khuOon
 I1odQ2fxLmkEOl8TmdDATFr0tBywW6PHtx5G3llfSc08uwmxlZKtus06QRJHh+Jgmyk8 uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jstesswv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:56:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCIuwL019882;
        Sun, 25 Sep 2022 16:56:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvck7s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 16:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCAElmW47nOAjdvt8llTL+fgWlU7MhJwB29HeZYxAHA1UR1GntVftB9pDifxAagFFfp9hpYlNHkI2VbDeYeBK+LZpFcXXEc8ceUcMK1kxKk6e4X7KgmOF68qw294wAVZ3WHc/P8+X+YB0eT6bS1kczxH4VvMq5vFdGrGE93pzq3sNXVD7ArvyWOYZyNLSBUmq68cbpT6mW4I3hc0I+1EM89VdjghwahtRWRR6rWpKEUEaDET0Vk/zPpoPpaM8+r3GsKxlU/hdFz4BMoOIA44ZOS+HizoC5vyiC+lyVK970g57+4VPi5Oy25+Fxr9zXHotcAD5zLcdwEFYNaaE8yA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WBREF244abCgL93q/zOvOr2X9+IL5wnfMd/gyGGIpI=;
 b=RjQaluG2MK26tKgLb2K+aGICWA61gy6lcSpFNrGS8G1/qe6pkOGNPV64oOog5BngDc61aAfkysfOCh75Mx4mU7jGkr6vh9CP+AYMOHltO48irDGGsWT/s7OzhXGJVq/HGVRBEMGiRpwKqF/Wiu9V8E0MAzwMZo37+DrmjkRklhqOkCBQrjOzByjO39+JmeTaJ/qW6DyrgSjfu5AjlHxe2XwCjENPRdzZobW4Lh8MJGyH0mwVDb5ql5ez5Ecevt/uNrXAyU640L9Q1PRgbH5gk4CY08/t0mVOAJ3+PtVEmH9qHfIxmzg4aVnV6Z89OH9zlf/ULBZZ4L5qofjhdk/0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WBREF244abCgL93q/zOvOr2X9+IL5wnfMd/gyGGIpI=;
 b=esjisDzlIVf7IoXsLwStUZFvOjE78UqaGqxy9WeybaaRfq5GgPjHMBru0Gczb9SUeMUNzZohVweGehFPts6x1ksqsobVfRrr2G4EP0FWgSOJbpnRWrWTyphytEfjyXG7aPxITt9W6PVstgMCi4hGMDasYOB1LpbnQ34ISnRI1nM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 16:56:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 16:56:47 +0000
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, kuba@kernel.org,
        john.garry@huawei.com, gregkh@linuxfoundation.org,
        davem@davemloft.net
Subject: Re: [PATCH] scsi: libsas: fix use-after-free bug in
 smp_execute_task_sg
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yhbs890.fsf@ca-mkp.ca.oracle.com>
References: <20220920144213.10536-1-duoming@zju.edu.cn>
Date:   Sun, 25 Sep 2022 12:56:44 -0400
In-Reply-To: <20220920144213.10536-1-duoming@zju.edu.cn> (Duoming Zhou's
        message of "Tue, 20 Sep 2022 22:42:13 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0064.namprd05.prod.outlook.com
 (2603:10b6:803:41::41) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: e01dbf0d-3f08-4c5c-ffc5-08da9f16eef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtpPnq+nkTrXRh/MqLSBBKrqTWRXT4qiWJs4xQuIQm8roGkMtVt5NgczXSlya2MPhityDViIaWK73mtBWqliZ4KbzcppusW+YSP1s2frZInGAeyNmePEWHR8I2ZPf/mGv9RkAa/H4Vfgw0j7L8brQfb4Mt2tmgHfJVKC4IIX62VkFOixbzEbrdpxxpS+ds7Yy1GMxUGpZqxkAocKqRN9PpbC6bawHEB3eucqm0q2VA/WGGjW89i8DciQNC5lkj3p3Apj0gFqiOru7Etrkb+yMFIEglk84AaEyM8w0vYj7reyQETIp4XEB0QAS+8x8fRt9KzGeuccrvf5WevcLBDs32nZZmdqmUzz28PDnaXwTcuwKbY+dSk0KUOS60X5PYdOeHVCahHjcsCdVPNssvw257rtMlhswjR4eySe6opIERbDLLVVcAE+FN1xa8Q29EkS+NlfhPu16x40GmQGFVIb/1oiMU14lsDHAYK+qQuqVk3DtaoWojVnH4f30AwDL1M0P3az1L4pYBnov8jlX2aUkSNxxc07/sDHaPzJy4qY0dYFuful5qnT6V9g4DMt7AyAltJkYGrMRw4ZezBLymbkTsKZ/l11z9/JlnNL5/8LxmeeVCu81IejIX3AdE35VWB2TQKOcaLlSYSoQcoZ/PmPFC22KCbeyw8p7mhaBadqjzM+QdtsCW7vhIehUzKEAs3sI8GsNI1dWgPcHoXThJqU7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(6916009)(38100700002)(316002)(5660300002)(2906002)(6512007)(8936002)(86362001)(26005)(186003)(4326008)(41300700001)(8676002)(6666004)(66556008)(66946007)(66476007)(4744005)(6506007)(36916002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZeET1CjC7MtYzFUP4CC+Ix7OTP7B4s/OS0QQBap2QTw09bxPL2fg/3+TPQ1?=
 =?us-ascii?Q?j0eHAFjIw8NpbxWXe/f4CqObTSCH0/pXssueFVO5tApgaGR+ymRYc+ZY4l+a?=
 =?us-ascii?Q?mAvRT/kOKF23+jBYceEdIAavNaZpY+8NRtqYb1MuKOLJUXVZ8WCH4KVHWB1z?=
 =?us-ascii?Q?HyZ6a/28P+5unT8Gs/CzUUMbTkTliVD2QtQ2w+11smAeYiMcNTjEDaicx+mj?=
 =?us-ascii?Q?dabOnE1/qpMyF9q0ZlpYjtzN4OBhrnVOKycHQv6ubAIriJVCrpZXn/+uzt7m?=
 =?us-ascii?Q?ajJpHafCn3+FiOwBOoLfH5es4UP0+ZGYRMFgEemzs4fCGUM75sJrh8I6zhxP?=
 =?us-ascii?Q?OYlbzngMYsKEKpYOfDfPpyGJKKS2VP+hnCQ/I9Xo7YF4+7RylfQzPRiAWNAS?=
 =?us-ascii?Q?g70ddovQoK4UAEJiFcRCCWZ23Idg8+uXhA7889RjnX6WGJxp3WILZfrMmLcf?=
 =?us-ascii?Q?Q3oN684Elowax9PxYySNQE+lNhRN8hnvW/QEd9guVO1E8Tdb9A+aVJWjh3Wc?=
 =?us-ascii?Q?Ru23N6KHN++uwh1RChm8iwQ2bJe2vARleQ8woxpqPLcsey3U+4EB9DfhR7cO?=
 =?us-ascii?Q?TVN3JU8jke1rM97+LWMQLl8bbtgYkqUM7Yl+T3+tlp3nIJCouMvUVmJ407ZK?=
 =?us-ascii?Q?IeYxgb9oHHD3udZD9bYBvFTdXWj2ZxelMt3HfSVWhW3WTO0lRktwqIQ+nyay?=
 =?us-ascii?Q?OfbgIb74Pe69HETzgvAq032BoN+MDun9ZiU9ttYgIcutPO6s8Sp5WAtTvsYa?=
 =?us-ascii?Q?mAAWMm2Ar+6NCJMrC6bDIXPzEvig8AOwlNXjhgQgcBQkkyFE1kou8K/s5K9j?=
 =?us-ascii?Q?7hDhUh0OxyeooJgLCNT+wjoSP7HeCdhK8JlR4uIYzV3+2kZeS+EkCmsc2Nsj?=
 =?us-ascii?Q?qEwRvrbgVRenL03Lj5SIBA9OBvBts30kYFdhJ0hcgJ/1WX5g2Kiwr/ZHrDEI?=
 =?us-ascii?Q?zkbSFe56X9gpgzgX2M6RusnFdgu90BJ8XRARvDCABVYFDb+Y2DSIXp9zyFPB?=
 =?us-ascii?Q?U5LQGbI8XA0W9TGcLVw1PwuX5snfbjb4OCr/aHTlDPq9ai93bbaUOaYgo4dw?=
 =?us-ascii?Q?k3Uym7Vzg5J5lFvlm79Llgpz7cuYMlbTo0L8jKLkAd0XC+BfJAxJ06b9SbjD?=
 =?us-ascii?Q?pDF9p1qpfcogNIE7jZuZCiFaw1d/im2ouEQFrbkrzpicElQA3+5G8BmbAW/n?=
 =?us-ascii?Q?jRjC1KTxjrGTuh0P8myQpTJQF3C7bHr8bAsM8M1eXh7xTDYNuI4t6G/c2GZR?=
 =?us-ascii?Q?GRp4oTvB0HgLzpPVdda5ft3k/rAuhvpkeJYPPfav3fl8wnZcQt2STC6KY46m?=
 =?us-ascii?Q?1U4WbaCcyFdr1zqqSI067DPWIm09JYxjDFDvpBAb02n/4FU5ZMvNS9/ySl1c?=
 =?us-ascii?Q?azbT9g2G+cW5u4P4nSOLxT7jabTKB1VZUx2OnzPxPuZ+jE9MRrDno/TAg1BC?=
 =?us-ascii?Q?ILYW2W1lfJj9G1gUB1Juapb7XDkkCn2SA1fFvvYjogoEK2FDRvmYaLvIN13G?=
 =?us-ascii?Q?juMObrjT23Q1wQOPuE69GXTc10xI1+lxqD6R2Hr+wTOWIQD1t6PNt/aX74Xj?=
 =?us-ascii?Q?jVA0i5cIEjDIQpP0DAe9vWokARREls5PQVjj6XQoBtkxR7Bgl7qpYqJVoYQy?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01dbf0d-3f08-4c5c-ffc5-08da9f16eef8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 16:56:47.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ad3YWR2cj22Saw1xBt2M+qV4jsZiAp0DoUa7bwkkwgKFupEfpFkPr81KCTJ/ze36sh4ZKRfGDASDyVD7dBAaUgqpb72lSoh9Y9TBO6Jh1Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=595 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250123
X-Proofpoint-GUID: -X0yrisCXYCoFcjSYk-SnRqjtVpKuxM-
X-Proofpoint-ORIG-GUID: -X0yrisCXYCoFcjSYk-SnRqjtVpKuxM-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Duoming,

> When executing SMP task failed, the smp_execute_task_sg() calls
> del_timer() to delete the "slow_task->timer". However, if the timer
> handler sas_task_internal_timedout() is running, the del_timer() in
> smp_execute_task_sg() will not stop it and the UAF bug will happen.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
