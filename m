Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BD659C63
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiL3VNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:12:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B01C40D;
        Fri, 30 Dec 2022 13:12:55 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUFxOVe029168;
        Fri, 30 Dec 2022 21:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=aLOApnpY1LIMDeP7ncRXBV94VDCsl+7J8V9+eZTTX3M=;
 b=tNuaLTExblGF137kjMOOhyF6weYOi8idF5Hx+Hv6lnL+HK/1aV28bJDgQsIzPYcY+wuo
 fW0KbAulqXrthwX+tCWcxgw1UQ0o7+KaW4E+2Udd3W/XwPBVH40VKY3VEDjoQkZYcWww
 YlNVcbx65yIBCalMg8+MUy6YTbr2+ZYca7dXAdHY0pZpB3AnuCGm32GRzS/R6tifItoJ
 dHUzWeEGspGFGKnnfGa24a3/85WtaWsG00oF3qpyko7BwNLNNGrXfLHeoAfxfmBKN6OS
 UT1ioeHB8JmkbLdvVA2OTok07hB+Tv5s7Qw+fCuKbIXZM4EAImY7yZaVdIv2DLia91Zi zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mnqudgjxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 21:12:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BUI272W023958;
        Fri, 30 Dec 2022 21:12:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mnqve1jc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 21:12:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhQfvpJaf7FYd5F/qjTURDd7jEewJfz28+OOdGF/EYuWvJ26O6N2OtK+aNt8j/emo/cihRlig3FwqEERqSxv/xh8MKwQpC7rbnD26NHn3D5bqfCZxig2WYUF5CB3V3ChZz5kiqNrJz55GUTzeqAf9W5tFueMLVy41n9Zl26HdLqM3cEbQr0aTaocaMNDHIMfhxBxE1nkiBCGxyqsWEydhG1fVGTUROyj4d9WmihWEBi9UDAHa5BH+euF9R9JJWLNwmUeAXfCTRvdVlt4QHLu0797OPn2dV3/pUo+I07/QP3t7KiEH6494lkTdcIh3TXxMxWmDuyiB6qddz5JXC6YFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLOApnpY1LIMDeP7ncRXBV94VDCsl+7J8V9+eZTTX3M=;
 b=LfQnl1lUbwqUPryDTFnlmYp0WoEBpJhZOb37ME3E9XLDTD6qYm2+FiN9d2JOruFFcu1/wxjd0AEeWqTOXiWfV/vs5TvcFr5RHbTdFXFP8+MFXg7sy5qx/rcEMtycFpXYtmyx6GASaMG82RRZM9x9YNjGNPQ6kKzoTYldx3jDmPCJc10Usgbmgbu60zqD/ezEAb5E4sc9zCgQz3zcY2zHTs/HoxaApYerSEDd1P1gDIBqEmGWTKf7d2DRM0xgQUpRa2rCnWRGb3D5UZ3NRzUo3zJGDhFzz9HT6kSefAvb24KJRHgH+8IWpb0q08YJrGONo7mt/HRKuQ9xDmhnJk5cFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLOApnpY1LIMDeP7ncRXBV94VDCsl+7J8V9+eZTTX3M=;
 b=EoB5wKipjBZK2XFtDcyPzU0GP4oyxl9GNNTjBC7FssX+aWtHDzAhV3PpYY8HkdALp42EmTghI1mZvwxZTz8tqVxzlJqjES2NgJRStZpmOpTA9AV2MxIDsSGlSObdHYHH1wrdlFp8olJr321ID7NcnD/Pu+yTUR5bTFh2UGAixd0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Fri, 30 Dec
 2022 21:12:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 21:12:34 +0000
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH 0/4] scsi: ufs: ufs-qcom: Debug clean ups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jtc61fs.fsf@ca-mkp.ca.oracle.com>
References: <20221201230810.1019834-1-ahalaney@redhat.com>
Date:   Fri, 30 Dec 2022 16:12:32 -0500
In-Reply-To: <20221201230810.1019834-1-ahalaney@redhat.com> (Andrew Halaney's
        message of "Thu, 1 Dec 2022 17:08:06 -0600")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:36e::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bb270d-8cdc-4e76-bb73-08daeaaa9248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXI0aStdJ1/I9oGMPAUk56/gWVQX40QEliprZovhpEV+oTwrF1/QRBIoqArnucvDjU0VA3AcJn6jp/0XV4RpAHVDvNi4AfY9P8DKziW0ng+VjV7+rMY8XN/+lRuDd5OCfjigfJygtTppmprxO9hGf3pEKngOTIJUBtA2CUJuysmduzVIhmOTInfD1mqYzvltxFFrV0YL4Vp+DMwTlNjBHoxtOjo5vT5cLfMXb719lsDtoNbcfVADZsbFifiDSMnZ4SmmSTB5pyOk2ZDk7r1yiPolUMtsMRUXteNFs+rxf/A19eLYNX28Eo9SDblQNzz+TDuyKuE615Gv6IHkOQO3v4BwKQ3G6IuUz1RXg3JDBzcbT7xpiLwt5aDNezwISg844OjON0oi4mwXcpaIfqh2Jh491qrr5XsgAIZ/tSjBxaxJoQ6H4/xXIV7uF+f++qFKKxPKnULTiI4HAgyNNim9ueGJdTuN7GK9LJWsJjBklfPQdRJBCYt4xOHFVuwJZij/sr/mW5GOUg2y+tzP5NrpbPqU5WpxiE34QZ9D/F2vSBuUhXrp/35O7M2TbVZbCjOwKl641c1ENmfNjpp+3Fv5MtQ6BQx/nHMxxRJxpmsARBy1XlcSsWTv8qsbEGKZA5KiUET6Zrhv3y5TI8u2cxYCAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(38100700002)(86362001)(558084003)(7416002)(5660300002)(66476007)(4326008)(66556008)(8676002)(2906002)(66946007)(8936002)(41300700001)(26005)(186003)(6512007)(6506007)(6916009)(316002)(478600001)(36916002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdF5OPMXzVlWQnS9erA/JaLsUsQBj/+XsbfEqjzjYPfyPB+DbJNP6H7Mk0df?=
 =?us-ascii?Q?/iU/7iJNs6u5e74k3crd7aHzX8cWEqEI5VTxxZFLW+DhacPBbrZFA+PGHB7I?=
 =?us-ascii?Q?jfpyFbYNbolsxbMuFkRrEfSP8EJwk4+eXpF8S72gCQ1E3kL5+qrFz6HjjJBb?=
 =?us-ascii?Q?JxM1xW2EPIIvt4OJCzTXBv1JbcE5Q00dUeZ3tU6kNvXamopDzJOiHVMkkPzA?=
 =?us-ascii?Q?SlfVUjULumPERxR65FJEeZ2vENHjHmPzETmCrgSvAkj1FnmtFlPKorQdaNfd?=
 =?us-ascii?Q?Z2nW3EXRSHO9QQmzShKfrdMX86VU3QPGYseW8RJq8d5ELx6sRLJnT7lQCyHH?=
 =?us-ascii?Q?hqFSWMPQRuxT3Sf6CRKu0A9MXReFtJLlz1XKK/+NCiPt6BCoa5taiaMXNjdx?=
 =?us-ascii?Q?ORfaAzFIwA4yemJvD5ukj+xUqMKwGD4Bn5d3BtxXdYcqBz13d3cHEl/N5oQd?=
 =?us-ascii?Q?W+jAUo8TXJlTBdeAwmrpqtW5i/DSfbxQW9g7k1MeHDRNY5W57ZSUcCotQ5P6?=
 =?us-ascii?Q?YGLDan3X9YkepFQ6CGRTT6fl/ljnEX+EDbr1XVQIDjdC1flL3bx+TEgwsKbt?=
 =?us-ascii?Q?wjQf8lt3jEY2QMEYt26R4I0pR9wuDOLabBTEwv4APY3WuPhk5l+rCXqjTrtg?=
 =?us-ascii?Q?qWY0HJjmIba2IBEIptgNeGT0JQiapv977zMbQ39sGTsPyGnyFnZzinaF2pgm?=
 =?us-ascii?Q?V949zKe8ZwgkZuruOB+7M+eIES+lWbT9/qCs8HPX4m1+rzIgvkfNcStbVqma?=
 =?us-ascii?Q?/cGsmjCv/GkVOq6VOznPc3/jxwcMthqLDk8IxYncjnWcZtfBeeVuQUuPjjXh?=
 =?us-ascii?Q?JGuQjRRfKUQIY8EN8xNiCwYxxpbyobYXhicSFt01I5rCw5ya101pUPfMY+Hq?=
 =?us-ascii?Q?4diYT/LJ1UbVnlO/XzW0fkqPJM9HsJimCMw9cqeKkcKzinvO4WvsBn29FvTz?=
 =?us-ascii?Q?Ptmn4KlQJe9xgU+ysG/gOKq6miyGNJ9SegCwW2tC247k37s2uxY9+f7RlD2+?=
 =?us-ascii?Q?C3xZDkGhg8YHzvB2l/6DxTDPwRjdM3xtm+3vyKZTZ1CsAEDGR3v2wL7MOdHd?=
 =?us-ascii?Q?5WYSpNZJcYnAdW/lwU4csVnzBmxFG6TM65QLXyk7sSWPk8tnVPXSFWRpuuqz?=
 =?us-ascii?Q?wkuwvP/+m0YuLwoFu6Qn+3mVVrr5/tFA2DkCtVOltIZLyFUHe5eKXI+CtUmf?=
 =?us-ascii?Q?HnTkQBmf3J/riaDPwLj4j0W0jD7CH+2tOFzEI0+DeWVgUcDzpc7qyfCWpuim?=
 =?us-ascii?Q?1Gndo5vp9Sf4OQQmAeRa5ot2HeFRkAN6pwTlq+U71jULKD3gPkCjzSQiBZug?=
 =?us-ascii?Q?X/nQ4y33+l4Iy9qTOEDWw5z0pW693BWU4SOuzC0XuYvn5Bq9fb9+lRBkN5g8?=
 =?us-ascii?Q?Yc08AXkHW3cY0MZjgwWEwfAgnAKNLUPLLhoRGt95+HJBizAV4UULXwjVlCii?=
 =?us-ascii?Q?ZG2t///4tS9ZhC1N3dHPd4gVnhEJCwvMo5/gdfo9fBJtzdaCloPpD+bC3j5x?=
 =?us-ascii?Q?jv/uoki2OIRHJWgO4raWwdzNlFRGIyEoWCr0Im442f6u2kS83NDwRJRQRmIC?=
 =?us-ascii?Q?JfXmx4ClKeUw+jn1u/X1DMD4yxpYPyj5TA6I4+4O7QWKXvqJ6gVQPT4j8HIO?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bb270d-8cdc-4e76-bb73-08daeaaa9248
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 21:12:34.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XNg9PfOOK3V5tPhMFOKrSD/wSEOE84kht7eqEVR9wPUNRou9zRMBBjlpsvkWG8OkDjb59E7KLbAvVNuFR9s3qb0VWGWQbZ0w/9xR7HCt6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_15,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=681 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300188
X-Proofpoint-ORIG-GUID: zjutCRfOj3mbQfNrv_3FOPyxVTUxpqoC
X-Proofpoint-GUID: zjutCRfOj3mbQfNrv_3FOPyxVTUxpqoC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

> This patch series attempts to clean up some debug code paths in the
> ufs-qcom driver.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
