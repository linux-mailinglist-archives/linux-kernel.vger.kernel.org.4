Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822E762073F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiKHDGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiKHDGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:06:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F2317F1;
        Mon,  7 Nov 2022 19:05:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80NnFu021202;
        Tue, 8 Nov 2022 03:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=KnkXTulLPRyvoL7jmuv5BcX7qc7x3d78ORrbtUTaSzE=;
 b=ImXzYkVi5KOYMTdCbGwJGtPAEoYXzT/XJ7ojXJ6DN7uxvhb4zdHzWvJjvfl/KzAMfe7A
 GO0jK1jKrlUpa0SGJwztAk/bXlyLN97R6R0GjXZOUO+ikit0qjV2/yqcm9eiX/5eUPVp
 b6nycNOJ+OJpbCe+pdvR/GxmI97MkGVLw60gSQj21QA55D8grAAj+HvBN6ahm/Eu6B/A
 Iup9rcgPRR100VNEVo3NrSV3tozRqhisn3iAXXXmF+33fpscueTGxRihMuJ2xdOMCCZE
 HUZbWXA30xz0qyM04ONA2XR8GOBeK96OqWpS4r3WVTipHZpJo/nZoDGnIhbovmYMDzCq qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngnuwya1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:05:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A82CI46003423;
        Tue, 8 Nov 2022 03:05:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctbpdh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKJ1iXiNWzy5vXS1LDPIpNpa4L7F4c/NT1HyMHLgqKvRPrXSM2v6yadgBEyyHQvAmDmH5OdTIHe6ML/VHijFEUB0v+U3SBGFw6bOOfN+aTogJYXRJNcGydJKILWDTRrqPi/b9vdAf/5FQOVPIkUVeSwE6hfp0m5eyDGZsUr17UPHiz9JHf0UHr8DBy3ff6I7aL+yB0Y6hzQwAxDv6kvDUJ7558HUxTXu6r6lBgGlxUEQq59akM1Wq9f/LLecgufSUELfUiWSBbICiE6QHvMui+48ZiEJno/IrT9mUJajAl2vQNhlGoP0Wn6HZxqYDUxpXcY1Q3StBku2mPZcvorO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnkXTulLPRyvoL7jmuv5BcX7qc7x3d78ORrbtUTaSzE=;
 b=JNfi8zBK+JPsQnJootTqb8JZc461HjK0SAP0JRgNKjxs/H/U60R2H1uuEKLDtCADlXeN/KCWdMIODP81t4FHFnD9PyxVl8YVviiaxtcr70nPN2N/f5ZenCHGITGGvFmLeZEEW/2rTlev8hx+ANdpnJd/enhknaPYwU67TUn2GvPFax458e1aK0MegM/BIOtsgTH5ZkN1kNDI6Kf0+/lplBa3u9g8Ai0BPrwOJ//8Iiz//CAZ4QOZQgR4JFaphmyPlbIePw4nq1JHdYGI6SpQbrGm8Z8p654WMwfPFO6B4I52oduz3Inna2B2yl8RTY9+I9HxPm3BPbzOS4zwAWLfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnkXTulLPRyvoL7jmuv5BcX7qc7x3d78ORrbtUTaSzE=;
 b=Weyd87WdEXzEnItzBkAQYJLzbBy7ueVMiMBdvFCN0fwPI6aozNp+AcPMS3h8ZNpGzy/8jt9zrXuWn0T3ZN4raYtE11y2NpWq4ivWZDrByDEHHm3hxl7rKdSIwgEMzNEjkcuYJNXKaRZnftQDGKNatbbqnDnaRDBNAhJA8Ofev2E=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 03:05:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:05:39 +0000
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] scsi: elx: libefc: Fix second parameter type in state
 callbacks
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0yejgcv.fsf@ca-mkp.ca.oracle.com>
References: <20221102161906.2781508-1-nathan@kernel.org>
Date:   Mon, 07 Nov 2022 22:05:36 -0500
In-Reply-To: <20221102161906.2781508-1-nathan@kernel.org> (Nathan Chancellor's
        message of "Wed, 2 Nov 2022 09:19:06 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ff9a8d-ecac-4c67-4290-08dac1361d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NL+1wgpib3XzfxaiwggyGo4+0SGfMgLQCxmQqOnjIlPtB+d4I+g/kHXaUC+CwhOWwxVQEhRgt+Y+qisNjomDHqEM+N3GpeosR2JWvr2N6ttoyOoF2+YQkBpcN/Qg/qTmy6EM97LS0rqGN7B2k0DPlBLDPAjrp6Cwjed4goMVM4G0nTywoUcF9LMeZ9YR3kM5ImGUgms5X/Fpl9AWGv2qSGdqasFi1qoRW7iygNAE+bCmRVuyCkelUN5VGSjlQUbtwyKM/9YvlXz+Vk9D/2m7inZzskZLOdo5CAqSmtEottMQzZZadcB9zWaFu7LQ5HRv3s1IoSNNlnUhTMWarP/h89nBHP7gfq22oy3xTAc9WFCf6+t/AYAifdmeiSC61dk7j2oZUeWiGcmQjpb7jbeIMp1/ktSUXw4Lpct3I8BYe37pdCR1EWqIjIOuw2939m9mslFgHusacDx99Y6AEWP36jFwHJ2WWbODcEMwvbkWV+bTYb0QBAD/ItprvUxM63JiJDevcl9wPHgPkB73hNyrkm3mAIlhhUMzD8dlQO9riMr5QgWp32Q4gOg6QOTySyn4EixlMwNIrsdWj4/RnodQN7tHWLOZgSd1KKXF413u0nNrOdqcQPosJjwM7uEcIhbZIzt9y0cen+PnvJPhKcykcyFIhjS+XrbvtRmDNdxNo9KrFVXe4q+nKDKVNUybg/6cYnRiAmMzzRgTHqKcrvmMzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(26005)(186003)(6666004)(6506007)(36916002)(6512007)(83380400001)(2906002)(4744005)(54906003)(7416002)(6916009)(478600001)(6486002)(41300700001)(5660300002)(8936002)(4326008)(316002)(38100700002)(66556008)(66946007)(66476007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KnIdRYWlxZQl9t+Q3HcfptU08N7Zrr2myf5/j4qNk2uqOVY0I4AvR5Ye964c?=
 =?us-ascii?Q?RhSuUpXa44B+zX94N5Q/QOXE/h3Gxh/32NDqTW2UHaeWmGjZTjZcnH9RWR/Q?=
 =?us-ascii?Q?kSUamy7wXMmYa+yvk3Zr7imfptvfZ6KectZ+0Zz8dAMfbU1bH2tD8H98fvNb?=
 =?us-ascii?Q?In/cAwG0RUCROi7tH/+bX4mIjCwGylz20idcXDUoZLLipXUKWzumCQIp/Qm5?=
 =?us-ascii?Q?4X3xZ3WVyYjcN+/lZlxyB3gZSkSPLDZS/yOd9FLcGh5nVs4Vg/N2W8z0LE5U?=
 =?us-ascii?Q?gn7jO7svm2nv/cy0vJFQaiMDytdl2CeABjOfNi9JdligKLt254MhOZ99SxGZ?=
 =?us-ascii?Q?ZnC1hnp+FCoiTcotLuq2Lhd3s3mDdlZIxc/4zLjNXXt2HsuLyjE3cXa34doi?=
 =?us-ascii?Q?EZwwhWk/TJSjAt7RiMhtY3WdiSNdO0oFcLackMLv8VnCfAXJoRJcAjdebWFw?=
 =?us-ascii?Q?zMTbam+FbY7XUeRnd6W2y6Ut+dSDj+Nx+LFSBMFMeemkfFHsv5YXTRfm7mx+?=
 =?us-ascii?Q?zQjaTjYAe0RNklB/f4tfU2lcC2VSdZvILafvji3kO79cHcuGp5aPrkKy0tUm?=
 =?us-ascii?Q?mUA1f/JeiLNJ6LYYIPtJ7oySInZ7JuCL3LODo5j4/hy4Cx1ZvL0eRHaljx3O?=
 =?us-ascii?Q?nG1siy5jRJjBD5gX2gTtkOPqsMTUVCLYxYKX896Iz8QNYzHuOPXALnZrFoOS?=
 =?us-ascii?Q?73AHtxOtgKJyOTon/aK25KdVOvxYWrhBGegJA24FoJx63xLBLqJPtFSSx8vH?=
 =?us-ascii?Q?a/cW+O+ztNo/I6QC6UAO3QtSJizGg55pRTpxBgXTbMN0ftgv5HTAP7NHxmKZ?=
 =?us-ascii?Q?NScLGH7S8MheLDYJYKyCN3GZV3ZESzhakuTeTglJLWaf+ijdbDRWgpTF4RIA?=
 =?us-ascii?Q?LOZr38tUfhwUwgEv5jVwmQ6QK0LPD6/L0Ak1m08bpXp2nWz7WoWx3SNnx+ma?=
 =?us-ascii?Q?A7tQe9gkqmHhKSdV4rDHUJX3jOxwqIB0rF9K+ig9gQ9PW/jdkVSKADaqAjHN?=
 =?us-ascii?Q?54r6571po2KO54uWv6TaE3ZCUc/o6N2CyDmKo1Aec1vrzTNy7hepihKuC8hF?=
 =?us-ascii?Q?4oSYVVA/rQTRbPp3mpUr8HMKFVIYtdNkPdrPZbtYsg2PKZMKhgY0R3lpjd6U?=
 =?us-ascii?Q?k2448Ry1POFLC/eGUKkEkNb1H2Njx9oVL8Qs426cNZAqJItqVfF90MTFgIO6?=
 =?us-ascii?Q?Ylrvm6gAIj63mfi5cLsuxPPl8A+qXYQiSrSnfxDrPnGNTybouSbQ/Wo2EqDR?=
 =?us-ascii?Q?genLkbelv10N5QhXZ7HSV2i+LooZV9mphyW9/R9N65AFQjxhr8ELD5Ws/Hwk?=
 =?us-ascii?Q?Scu5vwiL15VQOSwYZBJkHJ0LqnUjSiE3MlztvC276/ZSzI14ZUTVB+nGWawP?=
 =?us-ascii?Q?RgLw3dqn9+LpF0ei60ZTxRXYPvud7/n8ok8kpLZiPjcOrz1moJ7mzRUawpV4?=
 =?us-ascii?Q?IObrfFrEHEv+KGM523GSZLB78Q8P0XvTssWh7CvETtG2XN5FgBzaER+0V1Rr?=
 =?us-ascii?Q?GByLH4WwqFD/fBm2CdKM4Ec0API0ovYXwaeCw4FR8RURXFZemhHMwanGcqRB?=
 =?us-ascii?Q?Juo4JabdiwSUIdnz1iiGimTV7dTnj3E5t5aHHoMGLsrp4Z4YWcIOtGPrHaxj?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff9a8d-ecac-4c67-4290-08dac1361d5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:05:39.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jY5ws2tH6a81GqFUevKsbDE1vmZ4hE3N/kIh6nM5kBWKGeS0JMcRpZ5jxvZipBTQh2G/zblybV2J9q7DWTGPGltls9G1T7UkcuKGtZqhYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080014
X-Proofpoint-GUID: JOrFgzFlA4NqNcBRKmlYT1jX9th2M3Qi
X-Proofpoint-ORIG-GUID: JOrFgzFlA4NqNcBRKmlYT1jX9th2M3Qi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help
> mitigate ROP attacks. If they are not identical, there is a failure at
> run time, which manifests as either a kernel panic or thread getting
> killed. A proposed warning in clang aims to catch these at compile
> time, which reveals:

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
