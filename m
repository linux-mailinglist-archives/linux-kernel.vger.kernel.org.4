Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1789663929A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKZATc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKZATa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:19:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2535217A;
        Fri, 25 Nov 2022 16:19:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APNlRos023488;
        Sat, 26 Nov 2022 00:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hllBczcpQ+46gwR9J636bGpLjGx6p3rcki1/kwHzraQ=;
 b=CeQUHa0TZ6zNYv+wNlvLc/CWMa5F8L2GLq4yjJeEFAXcQVhygh+laAy8RMcepdT6P3YY
 jqdoCAH+8Pq2ShIcecKLAKz9dTHz2aqq/gAfXBi43TquA1hmYNWABkRJxp1zl7S1UAnj
 AirreiyPaUem/ZF/duTiTJ/dm1cTV3BI+YX71AfDLQvkeuWxtjy3UUtyAIT4p+gUyMNy
 w7PfEXdrR16w0r42l47ANxbniOgTv2JV+qmpyLR5FYaCN8YqFad1Lc1isRGsZWTNYRnJ
 YoTpU/3AGSaTTJSDV05AhVuRfD3RdPgY4HniQVpFX14F7qUmCK1VSCB82w2DzVMJrN+u bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m35d8g4hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APLWCEG027693;
        Sat, 26 Nov 2022 00:19:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m233yhbge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR1MXJ3RKtMusxGdKcW9oTLqeTGhLFchqRYZm2hM1t3hSoNhqhMdNkORlK99eIysjPTz35Ty5dGV4+DhhHkq23P9JACIoqe2zj5IL3mc4YU59DO5d+d9NwCJH7E/r1ozOQHOTNBeV/G7E/m9BbBQmMRM9CNtVMyk4YoiOfRQjtSxPsEFb6Q69fF13o2UUGyvzTXbmxz71KGiBi8u7ewj1ml7TMi61j/DFEEOX7mOXCGXy9MdGFE2MnTeUBNn04kcFRd8Pb3H5pqYllz0e5v2tJ0cfvRzxQdayQcDKhJiXFz1r6WaW1KYfpOrGvNPadtgppwpWpuiV8LxImyEXHKVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hllBczcpQ+46gwR9J636bGpLjGx6p3rcki1/kwHzraQ=;
 b=bOQGA+9LbvAIyOhQIKBAk67zICqEpBe4BeEAsCX1fPuRN7GbG7lZ4mLpw2Q2TU3VN6+NbXjhKG6lb2t9BJ6CoaI9MklroZrErrHHMd9ibMp1B/53fugdO/avpoOVMkY3vGfol/fXf7OIgyw4tcRaJHwsnUYwedIX1i/Vo6OzIYz4j5JQPjnQF6pdU12/i0tumobCZYDBW1d12qmlTAyNiy9CTmta7QHG/4HPj9lJHc6GlsmCTFohOwlRtssueqvl3i5UCKSA7gSajPx7za1yzwxZ1UOUiWHRQQFBojeU9TjbJgNalrRuqKWAkEnpC9sDbqotFYw7W1Sp64UgkiYfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hllBczcpQ+46gwR9J636bGpLjGx6p3rcki1/kwHzraQ=;
 b=XFdTMYwh+Qgjv7cklxo+mBHby5roavQaBefOxRJVWiv+n1G4FNfpXw84wLJPTLpBvx2e9WcsBIh+aFS7cnQlO1vOG0+DirHfBYfK61l3K2y6aJlFbrMhMgqk7mSmSq16llC51jfx2k8yu7ZC2bmbn4ErB40D7MloUq8uxM2BQ0s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 00:19:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:19:19 +0000
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Change the variable's(check_for_bkops)
 type
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qpqsh36.fsf@ca-mkp.ca.oracle.com>
References: <CGME20221111062238epcas1p3418881a8f028e97afbb498645704c9c5@epcas1p3.samsung.com>
        <20221111062209.7365-1-cw9316.lee@samsung.com>
Date:   Fri, 25 Nov 2022 19:19:16 -0500
In-Reply-To: <20221111062209.7365-1-cw9316.lee@samsung.com> (Chanwoo Lee's
        message of "Fri, 11 Nov 2022 15:22:09 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df3f54f-02b2-408a-b29e-08dacf43dc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2VlhYqZ4+U+ChXR2dd6KqsvyF9XZXGeAHV6sH89dTsqJhS0UHHqzgrxzdjak17krh+P+9ZabrqnudNu1vYtOJVzrEbHU+muZso5kNTzfxcD0q2Gz5GbNnkJMFoQCirsJlFUE9BkyC3qlNr23lxo57HMDs+kRGRgGAXFRH/UR/5POZN0MrOwAcp69GshE4cEGUG6YGcP5tk9rP4z0E3liCi5kpql2xBbyCN9kmKhYD5c4rC2l+lx5DZQ56lr3gJU+tF41EuWz9KgiFldgFco1eXlO9csDLc7Q8Wu0pX5bmQDTZF/umdNZ+kMTtLXRSRZwrvhjgKrpYL9oIxxTjCpkWSnrXsZyyXwBhpsaZVet8pVWUrQzOlaJdORi3RbeqJ6n/NI11BS5nC4ysIf1Bd6ZVJ3fmFW/etxl41xOEGAuJoUrYhcFbbn1PcjaVFhc0c6ECyyI/O8pFPKQtL81KLv5vZ1HH6eb8gFrK+0P8L+2rd+1X5tZMHN8ZBBVqBfYsRCBycqe8NWaO1h6fMivhpCvbrPhBFqfOOFF7aw9sqXmv/rGXdINmoJ9fK1DXWm8HeSBj2Jil+Wg7/iGVgI9p2Wyze0qbnuyA22qE2BjbMxmxVy1PPHVWi2czg93hCyVrgnVHJ7A3k4qUPKC2F0lbDhbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(86362001)(6506007)(6916009)(558084003)(6486002)(36916002)(6666004)(6512007)(186003)(5660300002)(26005)(478600001)(66556008)(316002)(2906002)(8676002)(41300700001)(8936002)(66946007)(66476007)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAELp8HO4J/FcHLKLXwOCyThfUViu4POMvzW8r6/QdnF7Va7ciI33EQAWH8h?=
 =?us-ascii?Q?yZIhjkXFGqy7JvcUWKUkV00+km/vrTOx2qi6SYXbrOmeJ052+kngl2hE6qcV?=
 =?us-ascii?Q?gfl/JkTAYtsEY5QQrijfrr5/HCu2EDfR+Cpu7Lfxtd3Kha3E5lbvlRTddR6Y?=
 =?us-ascii?Q?fDVt7OZmUpCb2x3VNRoSFhfghC75K3tCV8P8VMATOEebGQKiZipLdeqs1FOl?=
 =?us-ascii?Q?pg3Ax9K85inYeRNqKmdPIZRbXheuG54Dw2tCZIPPg8HqGb+VKT4FddKROPVC?=
 =?us-ascii?Q?B5ddgJsezqfLQBxmvrAWcj+lLEU6vQy+5hicpEinSa7LS9hCcyt7ed6Sp/5p?=
 =?us-ascii?Q?sIj84w9E9jz+MtNoY3sXHWaTVa2AVrKAVdAiIrNOtN4zB/wZpOYfSFNp2K/4?=
 =?us-ascii?Q?jXGCug/g6cyWdGk0XyLPvU1q8vAwsNHXX81DeHqTIKQSbH3+yDMlHE/vyE0o?=
 =?us-ascii?Q?3CDKFDpmeazi+kAEdiMeV5uKiX+Ht4+JSZEgpBG1bP0SLXn1bchD0jidXPPQ?=
 =?us-ascii?Q?aJWKPKXxf1rNrg796TkeKyfdaTZMw0exw012Nig+ErhbedgOg6S8kLBn/rmU?=
 =?us-ascii?Q?dk9Y+siG4i5UWxAyJOpcz91JZgGqtKtC+OzyrNlH3oShd+DD214xZp8zruaQ?=
 =?us-ascii?Q?3qXHkLIlItqFAAnaI/8qPbP5YwDuEoN8SU131pMbOuMNXXAWSV2dsomefQJn?=
 =?us-ascii?Q?8Nlt4JBZom7D1xinIDgG4WWvmOiTpgqzY+FJ9F2o7sdM0lizdkRRlEBqsm52?=
 =?us-ascii?Q?M2M76Bi75HiZGYg+S/rMUTsiBzb3tLcIcaPZinY1my21HyA0Y/Hrp3V137j0?=
 =?us-ascii?Q?x2wsM5Qf2Kf04/5OwjPMOicN8uXWX4/b7xZaEbTsHkjNHpgyrK2mrSPQUAoE?=
 =?us-ascii?Q?a81+nioIz0JE9OlGG2JxL9Xb9jsW+XAlfdnx0TQYmpzjCTbkW7ZgVyW1Mr3D?=
 =?us-ascii?Q?suGcDaQddzK9g6t1S/xm3hnrfNtGx3hH4v1fHVcEQ+l4OsHHn5yUlwO2MfFG?=
 =?us-ascii?Q?B/uGrql01mM8uMOK5Qvdo0LYhNAxvLy6QWL9lQW/8usj2KhRg/lBQiQCL6GK?=
 =?us-ascii?Q?2bv4MoTQO8cx7ikXMp8bt7k4pyxxoQZGPzP5HzUVUbM0KsCfehIgsziMZGJc?=
 =?us-ascii?Q?ZLvhgENL9fac1EqvCIRboxMZfiICGlYqsrv/yfOc/d65rx2BLbh9AWsdJcy1?=
 =?us-ascii?Q?pTFA5i6PZg0OxAztIJ9h60ZzWb9NOkcsWbVxdIwWiu6ZO6Td6pMHznEfA21K?=
 =?us-ascii?Q?ReZFui0qKpjD7WPVwYxmHc989m5ykf/34Oi0lvRB0IWvItwS1RGRZkXCFrw+?=
 =?us-ascii?Q?bTN1SJrspOvnR7OAYMhAM3DibEzKE/55J9iE4Or9Se6pS4/jgeusN77UiG7B?=
 =?us-ascii?Q?n3UXZ3tKOgJX+rmdPruEIUQpXl02Zag/UaNFyeayUyszrvqPk97Nowea/KJt?=
 =?us-ascii?Q?3iCa2foKXG52i+mdFRiaqUt2IyHcP6YCyFiKCv1u/6UXMckZ0NaSrAoy/XJS?=
 =?us-ascii?Q?mtmypZ4AgqOseTnrSrPTCtzGauThsIKR/CQdrtec3DhLBU9Nx/XYkDQH4BN3?=
 =?us-ascii?Q?+4h6bMwtc8c0rqHbuZrBytHtX0jPL5Z8D2UmUD9YxWzWRD1ZUFASq5cAgeTm?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vXJ0+wm3JMlthXo4Al/Ugz911mwKcSudD4lUcyGfNdC6t1MSRMnyVohEXm//?=
 =?us-ascii?Q?9VbLYoZebL+s447S0vDd9Cjk3OYDQCNZ+wmntz1Sk5F2oaNuUtWZpYah8QNM?=
 =?us-ascii?Q?uS3AsD56FgAAgROgC1yqnDTzvZwxwMXqMSlKfOlLlGJCK3/6t1LPyfbfARuB?=
 =?us-ascii?Q?PVZfA0QdIfMbjR6uLAw7gYk5JOZx384Cpr4z5YBvW8IQV6akaRMi9SxCuBPO?=
 =?us-ascii?Q?xC00mCkhlY/DSs4qiD8FTN3y5rNtUn5gdRP5p3/UfkKr2dq6LC0fnqDu/sSE?=
 =?us-ascii?Q?40/Uz2+ZhL48y1VzccdiaBfXQkWymI4kNRPhAKtOKlIepkhbyH95DZE1ifL0?=
 =?us-ascii?Q?DULZDteQ6GpC3ZFikqoSiR3R+AIXGwXB/C7hgkVGMETNZqopZRTTQxT8Gn8X?=
 =?us-ascii?Q?ZZFDqT5uAG0swtMm8pInLrGDzjZ5Q78n7PxI5lJjbzU/f8W0NOB3KoxFn7VZ?=
 =?us-ascii?Q?IqGD1ey+Mnqvx/fWVk05TIv9e4vvv4HvYhIhZuIr/h+05G9nlQtEG+cbp+8z?=
 =?us-ascii?Q?/sNLGXfyT6Yx1Ol2JkoM5DdZ1R0Q+UON/fivEXFv0zUHNDlf1/bhDVE8HSM0?=
 =?us-ascii?Q?L7SrydplR14yOnO1nS2VDGeTj3QUfha7iJonNWVim4hwhNP6EPDNtSxxGvXC?=
 =?us-ascii?Q?6CVGctwPufetBDGRRu/PWC9dEsgDYurZGfpds6GyFYUeGRJpaPFpv0CDjWBo?=
 =?us-ascii?Q?3J0uGmXZCQf06Y4SiUJfQDZVU4YszWoMF7a/IsrbZlKwivzDRY6B7A2OaYlg?=
 =?us-ascii?Q?euHLD2u5MeutJ4vg/oSCmAE8x3ZXMuu4Izc7gHDRKc7hPtzIdG+h4coAcuap?=
 =?us-ascii?Q?qDQ6wOXRCYxcE5crF9THBhulCiKbcj4N8ZLg+2yxx4+dg4qK8o2N89hHD+15?=
 =?us-ascii?Q?FA0fFUdwUvS+Cza6BS8VuL7SDJ94NiJhXh0Gtoahnbvw4J2YsLNUAaER3T7E?=
 =?us-ascii?Q?70WEFqQO76UDJvG/H1WLMS6Ngqc43tyYv6n7Mb+o1734WejK7FykgxMjxtRu?=
 =?us-ascii?Q?3AHA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df3f54f-02b2-408a-b29e-08dacf43dc42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:19:19.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uErQizFNmBtRNHpLvhSnTdoKMmzk0qpYJIasGDpxmc+/t4SPdICGmQ1ktbZqAw39rWfemzLAsYvufcKORd60JcTNr8dmBnzYntMC9xU7+2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=927 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260000
X-Proofpoint-GUID: bmYW83h_3t7BOWeM77MI7T_YjGhnXC_p
X-Proofpoint-ORIG-GUID: bmYW83h_3t7BOWeM77MI7T_YjGhnXC_p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chanwoo,

> It only checks true and false, so it can be used as a bool type.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
