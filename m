Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991B562E3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiKQSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbiKQSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:15:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8982200;
        Thu, 17 Nov 2022 10:14:57 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHG9aL0014158;
        Thu, 17 Nov 2022 18:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=N/79CVvV9uVQRmO5Mh+DqZ38EAFwR/xxaVwvcWhjG3w=;
 b=0/BklrV/K5AYlMJXUViM7xavzLhiYhwwo5WOpyLOUFGJjd6IftrKpI0jiiZ62jgff3b9
 RcFCJPdc/q86xvuWtQmp9KMFxqn1KO53Y2waKGA+9qdHbv5d+ME/nhVpLlWUF3eTBrA9
 W2tBHAyCr350+ASAHXn61Vi/Zw1A1SkEr4DPoWWIHINVKimSX584agHitNNbrWuQhjRS
 1dEZvND6fNJzvuDaEBv5eXMh6KbpBMATBf8Q1jdYxr1Zw66azyZ76PF7SsaC+pwYizV+
 sxcIaW8LST0Q7xioJ9tmA2WCeRhv+uZCT66Xo4cDI1Fa8rofXGFMjsy9n+3rk0zpHLeG pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jssybb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:14:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHICa5028822;
        Thu, 17 Nov 2022 18:14:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk209va5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffsIH96BvtQ3WrCKPuti8oYJlFQpIrh5APFT0VLHPTbY2PUqabpXOIflwLRVVTOzH0OQnBZoBu346SHJnXpB3iakykFC6sttVM1akuum5kpiesiPoVCG6hVS+7rtd1twbCTjEKWx899gcV7Dz4dxw6wrx5alwLBOswW+Dp45OeR/TWQHlEPd4AZ2BNxe4wtDIRqA+YAk7nz/PchSWTfTgTbSx4HpC+nh/qW1gf2DQbxbD2ltBYk2+DTVU9tzKPV4RxcmNhgnNEE7ooV66f1Wmb/0q5oKI8KGQwsKhNYo2p2AjKEynEOzzuXK4w6P66OC6TawH5BQIA33yoRsUVUnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/79CVvV9uVQRmO5Mh+DqZ38EAFwR/xxaVwvcWhjG3w=;
 b=m5xBbtRX/pAd4TdVglh9W67OkSoQ8yGGno6GUVNK7WZfwAQz14ejCOZrlkUNBV3+/dvJZBHdE7XM4LzF6CGA4TXedze87usxD9weSvDsRKcrXwzO9fAMim3KqmfX/cESjOlm1JRTzYEASxZ/+Ll1bloB6fMT5HYM9/znXQ2SK3e8i7qTlPwqwm8w+iZ/h0yTY3ThBC+LUBdvr4U2GrrEYj0TfzzcfcLvRsgQCL1VXUiBpdUAUbZ6EZ0A6mptzpc6xoqfedPwJsIEgcq4rHxwCtU3qTVmaSpQJ9y5UWJ/v1iIMXtDPTr/GuFVBNVZhi7HYu0JCk1VZF6EGx5H0/YjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/79CVvV9uVQRmO5Mh+DqZ38EAFwR/xxaVwvcWhjG3w=;
 b=NrnClHkHkqCfM+u6bUxmImVMoyxRaKLuIwzovShYh0I/xdFPvUUWdim+HIjgocCtwhqmWHMOs4s+kTOdRaCnYHJIOgk0XYWrTAytgNITZsZR8PNq3PMXEvgFoG+ZNe2q1IXp37wbrACb6WWRUlOROAe+g3j+bOsx28k9MdFLDV0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 18:14:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:14:50 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: remove redundant variable ev_qual
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfihwirb.fsf@ca-mkp.ca.oracle.com>
References: <20221111170824.558250-1-colin.i.king@gmail.com>
Date:   Thu, 17 Nov 2022 13:14:48 -0500
In-Reply-To: <20221111170824.558250-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 11 Nov 2022 17:08:24 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 45da23a6-fc5f-4f11-8d72-08dac8c79e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjPCBCQ4U2xI9Eb/Nn9kO5dbkyeRg+ar3a4DaeTNR5I6mfeNhWM/mgywWi1CXxx5e74RWXhzDZ/Hmb1sqvLGljFIa5QdgKpFAmwG9vXRi554dyW9j4q3WOZykJ5dl/3+J2Z3k1RD9GABc6v7N8vItBKWYceLiWw6vCu3Sx2vZTyzyTrY81D+1kMjH5FSJa8mZg4QodpQt6Seff3c4SEidD9vgTsO1oaNebTf7WHcZsXmxpsQlzcGx4BcRq0fnqjx+Ti9qgO6vVHRaqbqPIgu1/8evJTndeCN3ZpqgRIjnZl9Q6X3CAMEcHJGqteh2XTE9Swog4kmjhLi2ajgr+mZdg+eSRugWit7oqwPhbhu2GmsjpWK0Hebsm1Zi5e2M9ws7v37wIfl6/kbwUXZ5kjlZw2YUtIwbnicMJxhxbgnAS7W+SYATJHNLjwwrJGWiBXkSLMDNPBO7Iqv1frkUbz6+Fj8rjjcCfncY+00LOWx+pSgo46QYq5CAe/f8Qa4k3hUScNwtH0RKYhNBaPJP5ph4p8IJZ6LReycLyHRxdIC0+ok85rsZraKHUFlyApgXYAxvfa8BTInPvzod7g80F4dXl+mtAlsRjP7+N9UEv4acWCOH818lAHW4UU/2RiSbTSlrVM/23i7YCV7GsJYHUuojA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(5660300002)(41300700001)(558084003)(66476007)(4326008)(8676002)(66946007)(6506007)(66556008)(26005)(6512007)(186003)(38100700002)(86362001)(6916009)(316002)(54906003)(36916002)(6486002)(478600001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIVCWveafCpmQKiH8tE1+mCZL0Pch2UcePyD7QmFuBLlaCGK1mGCU1+PCYyV?=
 =?us-ascii?Q?v1VX7KOBLPxGUOLB1ruBNQM4uIRbA6tOFy1cW0F5TXtOdNjlDiQEO7VYntlq?=
 =?us-ascii?Q?I6GjKyfjZgkbnYqOmFPYo/rCXnObt8dX4JqU4I5B37xrhTHZB9hlF878acOx?=
 =?us-ascii?Q?hfxsse5u53d8McWJpj0pNqWNU1os85lKdy35qlYU8oqfbq+t/TSlQlHrjE3m?=
 =?us-ascii?Q?vuXa81wGiuUtbZ2RGOrGvBy5okiFrzwSxcX3AE1+N+Q/VBeHv27AJMi4YToF?=
 =?us-ascii?Q?uGjGxc7oA7e+Ix78ZHmCJRD84D6C97Vv3CuIMz+n6qh8mmVrCU3hRYEdGrsN?=
 =?us-ascii?Q?hlIm/2bD/+r+HB3a6SiWZGCdwNfzEep6QmEcCJxyES1g1AXaAldlnqtYy5KO?=
 =?us-ascii?Q?tHNm3WLAoHVLnVtNJisBsRXGYnkfzKQstgRd58Qt1KFx8RsfFAiQKDAPP+fR?=
 =?us-ascii?Q?FLgYpkuQeC2t2fn9woxfwdaTg/dpEgEqJYRq/Xw/5qikeNGNFgMpBRodk3i6?=
 =?us-ascii?Q?rO/wIEz/r43PinTHzJxLCL6UQEpgI4oOXUJTv1iDQ5GIJxdjYS0xZ/47P9fy?=
 =?us-ascii?Q?Ey+FcX9Ad/B9GKcr0g3Ec9zaFURVYG7M+dzbF08YG8OX+1RHHwE5Uh+BfPQs?=
 =?us-ascii?Q?yiVFWCS10WWhImLtwzVc/aifIAFLL9IW8LIl9oR6jA9Z/hBDk4wVKjBnuzL9?=
 =?us-ascii?Q?PwBf+fJMnFiM6azoV9gK719+j23tzWd/uNb118mItMdtPcd++Ggfr9kH/8UO?=
 =?us-ascii?Q?fc/x1y4WD53+CG8bc6OF44rT8FYUgrlUofmN8idD8lnwnXjTKcjGoVgm9FHj?=
 =?us-ascii?Q?YionT+eFP57vlCPLdioqufEQf6afluxaQhRUYEnRrJt7HyLG0sHQC6g7G8ry?=
 =?us-ascii?Q?9uBMxRePvvlFpB04M8hROzf3U4tQ5M6HSffBSkTSSnV6y2RZBv+eGLdD7ZIP?=
 =?us-ascii?Q?16zdzTj2MTDgvOfQLbSFLqOyekWq5g6CIKYBkRyIcWbXwNVm8SJNG25Ix0Hk?=
 =?us-ascii?Q?tAMjgApsVhnOWhBV5uODhrlrO+dI+8VQAum/+vObQ8R6l0TxO5PSS5XFNL2c?=
 =?us-ascii?Q?daBemQIm5xogEWxUSPIxBlvRrnqQ243zqnJaWeouDmM2hLSK+fwTGCIT4S3H?=
 =?us-ascii?Q?pUkGeiHniE/DgSEJ0zOX+BXBxYPGSBzG6IfftTPtzJ2AoME/gBD8FFkiC2qO?=
 =?us-ascii?Q?CSf2LZ28Fe8TFfMszZJAYAiaUbFkoKegordpkE/1/yPvuoj0M/bfKXvrzgRE?=
 =?us-ascii?Q?Rb6eIsCXaLQMeSDhPVkuPxQXE5KgEzyKMHQ7zHGljwDZhWD3aoxVHL3yBMOx?=
 =?us-ascii?Q?zmxfkEd1X3rZQiC9ekOZD5rlyZ/6GEFmWh+0A2zf7R10/KsA+uWG5HlzQZas?=
 =?us-ascii?Q?dBILdHugD6H/qhi8xUIyUmH3EmuxSH3r1f4ktuSb3/615Rame1/kXUpvv+p+?=
 =?us-ascii?Q?tT0DSCvWQosVW7CtDa6bLn+2zhX+1Zka0I0Ga07piheh8CF0Y1qaVcbzRsU8?=
 =?us-ascii?Q?Cjop0vJMgxvobZ87hS/PNySTrPnKO2jCfr372OYfy8Ijw7RgnT+F7DOC1/us?=
 =?us-ascii?Q?sj/sfCwH7Xj9cLJJcoO1uHVJdsDlkDyhcMXE76XodDPZ6t3In/C5o1tYOlTl?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?j229OfDr2OwQ4+VZIsYjPBB+CFmCrQYEhcq7b/s/c2sagMYrfy1xqDMIctcY?=
 =?us-ascii?Q?nYyITBUSG7ng46fCvcHqv3BGPIurlIKWeZJxhC6KgkkBKQUK5YrwEPUEzjci?=
 =?us-ascii?Q?QfvgVbrAt49OOMvC+6nXD0Hd1gU//Rn7Icr7zmv97FR6yslFQGgJq1k5bNDB?=
 =?us-ascii?Q?1kDvpyO6tPPfQV7JvTgv5NJdALDVmKG5ZnMwDMTOyxOG6+qIDCrSQdOm2k0o?=
 =?us-ascii?Q?De5sc0LCxcksGbURAFJlvM8jPrFodwaoS9/O1JPJrno3E6DgsM+8ne7zRxlg?=
 =?us-ascii?Q?RmGZpXJONmIKujlJ+PuTLxMJrOg8Z1wRsvqETQMLzkSgG0EQCKYkm1EZGG8t?=
 =?us-ascii?Q?1hXn++jbtzJ263Xk+m0wQXzen0fMw8WjudiHH3OjDM/M0wRNlAE5kaMRFQ0K?=
 =?us-ascii?Q?r1GNnRjCMKSwz1VEZq+1FnnuXPRbJIgQrDTScdvC50G57gj1+aZXKT6NaQzL?=
 =?us-ascii?Q?He6tAZ6FWYLDzEV0dmktCXEHVHjkr7cRSylnmwFUbXi0gSu4+F3egmtf4rfl?=
 =?us-ascii?Q?Or6NzzVmNjCpTbkMqIiEAYGBTEBtaBFguezVo0f8WCU1gRVGkb1fFY9j4g5v?=
 =?us-ascii?Q?+PM4l/2gDjleCXAAy4HorecYhdr149M5ohoz1fRSYsAJAtBRPDsKLOQsJjby?=
 =?us-ascii?Q?mlXnzFc206OSxzV5ZERG4Xy9Kyjng5HhiS/yO8uGovUl8oLGSNTDhAj+nOrr?=
 =?us-ascii?Q?5TV8v1fzpUZJJdoL/4ip8fywqc27BIwMUhYOYze986I8zgmIyY5rQYXi2Qsl?=
 =?us-ascii?Q?7zvPwG8oCqqloaBgV9uFo8yPhSn4AvXy3R5dTKpJUIuDfL6ennVWJwsoZp27?=
 =?us-ascii?Q?y+8GpXMuhquEbi+vXFDymbO2wffnYLaOOXNO4L84RUtf94LykjQFQnwSP1L3?=
 =?us-ascii?Q?tMZ5xNPZpiK24KNhZqX7Jfi6PBv0O4GFZDxo39j4RThOy9g7q0aWxioBcGsg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45da23a6-fc5f-4f11-8d72-08dac8c79e0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:14:50.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esxJ65+fEzdbROhqHuR16va09tnzbRqp2J/GsrwpPQQUu4zeUbQ1mfXHvNmq87Ebk/DNJv0BJ1EgAC+l8Y+3o7pvaJuD+tInDXDlSlMSfqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=886 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170132
X-Proofpoint-ORIG-GUID: I7OtdDNYZDhZ9MWYXSSGt7bqepl-b7kI
X-Proofpoint-GUID: I7OtdDNYZDhZ9MWYXSSGt7bqepl-b7kI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Variable ev_qual is being assigned and modified but the end result is
> never used. The variable is redundant and can be removed.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
