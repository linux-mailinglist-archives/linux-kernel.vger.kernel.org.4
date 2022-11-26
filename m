Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43FE6392A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiKZAUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiKZAUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:20:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468885289E;
        Fri, 25 Nov 2022 16:20:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ0EFcJ021360;
        Sat, 26 Nov 2022 00:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TeldgEcYyZDBA1wEHlWdYytosJpp1+Fg6G51JQB0pXU=;
 b=AirVqcjJtX81ukcKEyZmh/V1aNqYZVoFB8SshX/J/IFgDfX28a6m0NO1+2eAkqEDnPKt
 0qJK6GqQLp7baJfa/bCY/JXbcV6oPO+L+5GJPvbAaCW8QpsLvCMEvvImX/+fNqCaoACW
 MReiCoWfyWIK6SkC0FbltlVAkdr2rjB+m+t0jnAEKCdr8dW+StrCTKFiaIz8jPJRCyxy
 gxJIDriGpZE66MLFCnQWhkKyK6/BwxGUq6tslYI46xmvlfq9wB/zis26Kt7oVVvsuWU6
 3Hr7iQV7R6ILieXWpXYEZ29BOXahpzogxxpkrcx3IpUwUvb+xzHHtIkGf5S9RtKU+G6i +g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m2jqm23fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:20:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APKhDqP008615;
        Sat, 26 Nov 2022 00:20:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkgdg8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:20:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNwdEXRLNggljHpL9r3kHustVlxgxaalh9VVBFy4ShYCJv113rP3n327mFZLhnTV8JMKPGITZI91OUtFfygEkSdaTiqerNYAYdb2lJzt/LjnQqQALcF+7JIgCr+h4YHB9LdoA/kebatGfd6X8ESYMcoWbz5vopCYrLdxLJCNS8nyZr9hRWg9EkesCqxZgH/irSGLrspYlOh0QvDIYjtmyxEIsiz2HRq7Q9dtGs/hrrp7KglU6wSAT3KFXRIlVv45NgQNkLZTp929o5YCCIfw6DG6AB6hUR3/leXdtTf5CCnMMu/+SI6otFEMWyQxNja1Xq+K20Qqg/Ovf0zDu4Ps7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeldgEcYyZDBA1wEHlWdYytosJpp1+Fg6G51JQB0pXU=;
 b=CmZJ+El3MjTeSHIM/b8rAD8vO67mvfZWelKJ0buvDFiEAXlE9gEa8uv7y2JvkCewxzGSwUjCwJMCEu+6GlkuqFMti/9yHsHakPtLte0YmFQwbQO69xhPiDHfLw6V8Q2GzGIAFbM2hmxHYlUFPJA2eB49iIxwKFLizVHDtLV+mUfWaBsUJ0XqI93dJa+Mx3cKfig6T1hJbYYdeHJ6pfZxWuWc48KGyWPRiX7Tej7Vo2caqUsQwdBEGtm6otP/n09liflUY4o2U7Z/H+DPxcCWSY23/yOEqQGcE0gIbIm2n0WyI4KHzt5ba72UAu/hvOF30yVlgGZTVbSF6sxVSxrIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeldgEcYyZDBA1wEHlWdYytosJpp1+Fg6G51JQB0pXU=;
 b=FwbDQNmaaDLZeXOMkOh/k5yoyQlFCv/oyZpN0vMrFpRhnjiji9GaW1OCfQ/HAS+nr1eHDN2xfE9gV0bfBghRBPc55/7d02iPZxaExaUOL5ucHR842cuAesY9yd0jTKnevkrZCpn3jXxWBg01t2OuHlKt6dauTTTyvqx6A7J6364=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 00:20:10 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:20:10 +0000
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dgilbert@interlog.com, error27@gmail.com,
        harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_report_zones()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edtqr2h9.fsf@ca-mkp.ca.oracle.com>
References: <20221112070612.2121535-1-harshit.m.mogalapalli@oracle.com>
Date:   Fri, 25 Nov 2022 19:20:07 -0500
In-Reply-To: <20221112070612.2121535-1-harshit.m.mogalapalli@oracle.com>
        (Harshit Mogalapalli's message of "Fri, 11 Nov 2022 23:06:12 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:8:2f::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9d7396-2bd9-4d05-18c5-08dacf43fadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCW/q+0+8nTQzewTZIRTNf3rpBv3GX2QwfBsTbHHO5E8OKjRGhQbCNmOpeFG5gYAAJ79qIxDVBuyN9Hsf7FWqAHA1fuXoXcWbefrE/XQkU5t2exgHfW1iPFLZo7PaAhfWYF0mLQAjblPgekehZ9KuWDfFYJr5ZN4nQI7wXHPbsENEu8Sp+3UY4XCf6Yizt7jwLMxy2gWMK8QBM8yq1xpxkcqKvYjg7Q9jJHpUe5evbNQIgvxyVmdxH3rR4u982McLH8/Fukgphby9QtnZ0Wwl0mRQlzJWW3V1g16ig1bpgBEXpmW6OhD7Tg2NqBtGWkoOAxhdzbAB/wJLY0B58egWAurZ1b46Ouvxe2uEEgwCtOJBTvqnmjVeHkOrBmjqgKXOvrd+Prh6MwxzNgZpdq2rYW0UbeQwSLssfC+/3MtKobvNmROL4mpoUBL0+zpF2utmEG4GSoqEXtlTz2AkAsZguMLWbgteXuGaTpmwQimXhIGnL/V4FuR0E+z1ITGyeElrmPnLGGj82y+aurWtuYNCzQ0HrOnalpA3TTlfmDAxL052G2q/3ammlsKmaMowLFVKy9DAPVjiw7raamw/n/nmpmkuT0O8QsR1M61csIm+C+Qdulyms5rflIPTn6/q49BksWip8F7yrsAMkS+XUddgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(8676002)(4326008)(66476007)(66946007)(66556008)(36916002)(38100700002)(41300700001)(6486002)(86362001)(558084003)(6506007)(316002)(6636002)(26005)(54906003)(6512007)(6666004)(83380400001)(2906002)(186003)(5660300002)(6862004)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4HPdiGfMZwgW72iVDZGMaxkKLAtzqxmTzw+l0vSlCtEk5jvWvcFh4sB5Ult?=
 =?us-ascii?Q?ME5YhOkJd/kOcA+m+fyGBIunadii7c41PO7FFnW57KH/yAneRXcNZdIFbVNK?=
 =?us-ascii?Q?7Ub0afga5WIKVIzyAdDLCklWLiWMvtvTHR3+wOrlH+g3dnfpJ8pSB98YhzeK?=
 =?us-ascii?Q?7yH/RBJllMuKb2Kn8hWdTx7QnedoILCxynpr/+3tQGC+OE3cGb/bzedbvVDD?=
 =?us-ascii?Q?YlRC2/XHS9Vzviqa/4ZE5AJ++I5HJRW2BA16zboTB3qhyD+dzYUO7D6SUYkA?=
 =?us-ascii?Q?FZjBL+lXREgL0y0t6AlLyZ6nZewgsfgTnPVUzloZLgwqg2TBXqz591xsL5df?=
 =?us-ascii?Q?LX05LRMaNBc10iM9Ni60D+M6WGMEGA7160Iwrbal2csdooyeKihIPOHUvzR4?=
 =?us-ascii?Q?f43LE8PTEk9VJzEobXr/kPCLXnjGRrW/WlGmExu9AKQbBCZWzcoTp6uP46LL?=
 =?us-ascii?Q?dVsNInxNHDPbzW3NNkooWMEve0jVQ4tT+rnFLgdlZTyE5RG5Up1UH+k/l3Bw?=
 =?us-ascii?Q?+s6TA6qXocnPc4sMsQBLYSVwvrRkaNMCrLHGlTh22krrC5vwmLJMTXuICB0a?=
 =?us-ascii?Q?CfZMlqmMh3IfnPyHrLqeRN4+w6/JDQcj7Qs6xHlE8vbwxl808xWwpxb6gc07?=
 =?us-ascii?Q?J5eNirixmTHJ3voojkUyqQ7KVM5Qv1BThjPyIJuj5c9tP5iLQObIEQQLP5sY?=
 =?us-ascii?Q?ocY+tLP4Xj0wWFulEU3l8behik5kIRDE7p1iyymSt6NzbwJd7Jx+lzpoH1Kw?=
 =?us-ascii?Q?Z/pTh/GvzuCYy/SzUnOYLD8Izq25K1A6n1MLVj81iztpiSF2SeDtq0DDaTaC?=
 =?us-ascii?Q?UulaF3BYQ4XRc6OoWyk1VboMCqHH3FZHyzd/yib3xeSbvNw0HLnE6h79QDzi?=
 =?us-ascii?Q?NXaUzDaDPyCUHIKFs1GmRdnipFlYUJesi67pAVMWKRpSqFpo3TapLMaKBQ/Q?=
 =?us-ascii?Q?0ylLL8e3R3eLozOanL/NtnrNWzB1JHrfOR8SySotzRdQ1bCv9yfgm6mswa4l?=
 =?us-ascii?Q?mnkMCHpsrgB2tgLCpXIn9HhizvK8c0BZwXKeGUCbvMd5/3mpkiqy4J3exqAP?=
 =?us-ascii?Q?CHtGx10ySa5VcRRjaSVc8dAivheMkMg/r6BiEaGgSIq1rJrtfBUEoumwjdeC?=
 =?us-ascii?Q?osihl+YilH3aPSxVXpsF+TgL6xXZfRmHhqu7hjnIfjRfz/I1ZQVyOI62OSbz?=
 =?us-ascii?Q?ndls92d7/tc5ukq1JwHjX0YUe0YJVVoGaDwEoh2jyVfFopKGlzq/8nll4Wxn?=
 =?us-ascii?Q?mlxhVxopB8XGhiCdg0dyd+McstNIf6tYHlWlek3iYOXI/KlhZy5Hj1wE552f?=
 =?us-ascii?Q?VLVV22VglEja5EL/ZK8qeVDitcGVlVaTVrVOfCZRfwF9sAnTua3IcC+QCZpd?=
 =?us-ascii?Q?synioaeoA6kV1bxd5Y/dhisAsrqkKOBZl1iCAmq/j4fBbdcoWTozCLYyz6Ra?=
 =?us-ascii?Q?9/SeMZIuPdi8OAv2UonY7q9FP+W3hM8vQFvPPkq89ColQ7cKT7hJwU3tEYVY?=
 =?us-ascii?Q?ANJ6LCzmrEaqwzAQLH6fNCDQOJkjNXW04wZ83a3+yInyMBBVRw1fsfFQpvI7?=
 =?us-ascii?Q?v1rdAYrlYDKPW6L8rLm2uMlRgVUzP14GwcWkwZhgbD5VP1aZUrUACHYJIZWp?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UHsb5YXVySfP0vbhidzsm49apucPrCvS38amfr+UB24bPiGh8ulbfyYAV1r/?=
 =?us-ascii?Q?O4lHc9MZrtn9OY/IezLwgKKjUhcyOTIOQGC2U08RLRCLP50i+x8NMYve9oVJ?=
 =?us-ascii?Q?2ejWRH93xf0I5xFEYlWNPzSgTFrzPqjwuVj1HAOosaN+p6xc20EbuKEXDf75?=
 =?us-ascii?Q?DQMAfODWH+5ZhgqeK9xH/03ZAR2vSeispnfMO1HFiqAYHo7eJtMIQNfOi4rJ?=
 =?us-ascii?Q?KX5XdCm3D6cXnexLYq0bgYFHGrEgtbAWAkuDc9M5UNyd7d7ueN3I8TksO6Sy?=
 =?us-ascii?Q?ex4riDOUsbKyfUlM22wPrVFpVnrnRuK2ZF869YzoojsgKs38ozf0nCCBrmEk?=
 =?us-ascii?Q?kiYwV79eJJRTZMMWGKV2u4Rgkgta2uNLH4Xw+uPIip2zTAPV/Zo3jEAieTFF?=
 =?us-ascii?Q?F3BNVHLlEMRz+eTIRgAIyDHin3NNhvRLRwOWpN2Q7KCq0qZLQzGe7fwGLGvB?=
 =?us-ascii?Q?pffphHZqgPFkkpsPkeaXSagqKgnXX0y+dBbYEwC8TkhQsEtnPoFhG5B1DmmW?=
 =?us-ascii?Q?kNtv3Vz9eTfmqkAiq+u+Q6bJN8LKWR8ZYMQB2raOcUThrYW+i5rS4gabfH4i?=
 =?us-ascii?Q?TbN3jqvORoATirk051/du2+ArXX7GI2cHERzpvbuEsNI/34g5LmynWhyxDz+?=
 =?us-ascii?Q?0OyrLVcyfrLqYlAdfWQ2OTpWexzq5Mc03pm01+XpiLyyV+jCF97OHVZDCm7N?=
 =?us-ascii?Q?1ua5Lx9vwYZHGQ6+KTTOi8Hp0yuHS1cv27MNphsv36N3EvgRFX7v9IQG+8WL?=
 =?us-ascii?Q?PypCZMWlgnRwCDxXYsPigjxhGsae4faYzNbgF7CQw2rBkMHRFfm/qi9L+HjR?=
 =?us-ascii?Q?aH3TW91WWPKNGg1jhCF29B9iF4nPi9ouQYQidnFj2ngWno8wXPeI1Q8c8uEN?=
 =?us-ascii?Q?4QnRGtas2MHwG7HtbGrvP5yrFjxcXdQcyLvSUSYyAeUZ9RIyywe/GxY5xUrp?=
 =?us-ascii?Q?oCzr0IzyKgxo11pZg16Int7XcuMG3Cb1R7aai7HTE3ueECHnT2/xxyFdfnxM?=
 =?us-ascii?Q?rVeq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d7396-2bd9-4d05-18c5-08dacf43fadf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:20:10.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkPWnIN6lNpDFRm9vjYY/tMjxbRp2V8XIcJpjVu6ciUUzqF/AAH+LKvguXuKT7GsArhnCFVbNdegvdolXeYwxj15C2i7NWA02Mv1QCs728I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=826 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260000
X-Proofpoint-GUID: flTEeAwtUyNnVYqMNigD1dR8-YWA4ELo
X-Proofpoint-ORIG-GUID: flTEeAwtUyNnVYqMNigD1dR8-YWA4ELo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Harshit,

> As 'alloc_len' is user controlled data, if user tries to allocate memory
> larger than(>=) MAX_ORDER, then kcalloc() will fail, it creates a stack
> trace and messes up dmesg with a warning.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
