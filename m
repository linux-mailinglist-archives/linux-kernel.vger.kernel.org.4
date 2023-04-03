Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0F6D3B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDCBtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDCBts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:49:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C56E86;
        Sun,  2 Apr 2023 18:49:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332LpKsl010601;
        Mon, 3 Apr 2023 01:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=AWuB6an8jk6aQjsr6Fxt3z7i3McpThFDjEjBlrzWOnU=;
 b=PYbV+FyH4tF93Fq9MEfegAPs0UvdzQQwvu06sUO2jD/Or3Ur+b+7SCpIn5RGn/MtsgtY
 WbnhC4z0o9lw1QJHzewkcx0DB3tZ6Zgt6Y0HaaNKf/coOy7KeNOfrS7t5l7PPtzws5Zy
 OH7wrOTqFLeLf2vO5q2LDsofKjMyYMQyvqyIfsMQPzC2cfWP0WjKYyFisO3gxXy3z7mi
 V1otgsQFr3xS+zA55s7oVv0DSY5LHt5N0X/FWWxMb/g/5HkEM1OG1GnKWQlZzacuayTE
 lCWJtTH2zarpE/d05+84Ch33VrNTG0REdtJFco8z+eqdgnFuamlrUtWuQoS4ELkwk4GH cQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7tsx3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:49:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 332LbVNW028569;
        Mon, 3 Apr 2023 01:49:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptumbw90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8NtAfHsUEhbZ5SjlJZPlnn98/IfgxvNUYnkaIssy+X2CPPo86Es2tGIyeF1dLbWx/veyZ3/GWe9HbqAkAD5vXNaDw9Hr4NANh5Y3F57KqlcW1VIpj6Nr2PrDvEIYOEpFhwx+QYp22IkBjzEJZZJo0nAfl3sLijIHvcXVeh56VNI6KjP2yiqklqKwK/6F8xf8bknOJj77gbUSomDYwrhY1tOWmkpvkOGWB3ap0yxKr+hCVInkItxGxxyTuOp7i1Pv7S0y+zpDbSchAOPQ8tLD2YwItSe27mUCagCghKlZ/wFkmfPAMyew+eUn9vxZpK0ofj9JrgJqVx4kZkiotUCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWuB6an8jk6aQjsr6Fxt3z7i3McpThFDjEjBlrzWOnU=;
 b=Ex5H8JptJEUWXB0HAe9J8igescoza9mJh7Xyud9CyToajXIeM15kLWar4PTVT/NXhc9z+4J/+TAffWMOLRo+zSCRfNRLFDQq2bj9K/wF16zQ39AotBZ2zIZXBxr7nRzLZXfDGBY/kHV8LMRBEc1ewKJzxIXN/zI1cqGUzToUgX9QrOTF9IoxgHBeVCA96a1MpvQC6K97I05UMWmTX6esoF9TvAb11GZMOnNLXLVLsmtKhT+v7O7WyoIKD/omv672EKrdChekpHFep8lBqyUteXBduj8cz/1zq0hHImugtXq9sv/040JsJDcvenGySbnelt6Uqxzp0IqkRQUSVv3RHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWuB6an8jk6aQjsr6Fxt3z7i3McpThFDjEjBlrzWOnU=;
 b=lBRPRWJjsHAdo8rRZuXTZYwbLVouTSWn9LnHTx2QpZgTXddHJr1nrd74G6RMUH61iN3caRU94zlxxyvvrOoEBJ9+xaHFzzWoJ1uIR3WA7ChiLEQ1tx138SNEQXl2d+YUMIwXCxeWhE36gid/zG0wCbitAv+xewRQtJmpKd9QYvc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 01:49:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 01:49:34 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     njavali@marvell.com, mrangankar@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] [SCSI] qla4xxx: remove unused count variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkk5wx9w.fsf@ca-mkp.ca.oracle.com>
References: <20230331175757.1860780-1-trix@redhat.com>
Date:   Sun, 02 Apr 2023 21:49:24 -0400
In-Reply-To: <20230331175757.1860780-1-trix@redhat.com> (Tom Rix's message of
        "Fri, 31 Mar 2023 13:57:57 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f9272c-b754-41b3-4959-08db33e5ac91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuKd6iuuAfSyov9yd2o1YNmiaR5nquBW7zD8w5glrJDAY9oT6hNufIcyhvRxJ98apMHD+xgkCYjaiEHM8LFyekgpdwn6KOsRXUrV8eHvJ0yyhjCVDF0Eyzp8kws2AQziZClRr0l+LI0tMXTiBZByAYOZ9N40FpQTOGJCTey98psjDcCpoJQA2uy2jHa4LajaRx7gUKnkbfMMvUB6yaSYedgOW4J9OxptacaZyYAFUbv4yO+CaTC2Q+Mqy7QqJiWqC1qq4VlsJzPdV64pmI5faaaNeRvr1EK4L8p6cZIx9PK5lLna0oRqzpRGtukqIjAXEjO9KVF0ShZdG2rNbdBtxqewX+2PbQzmQ8ae4qejAwKRgRXjHK8qxQ7cSe0Y5CI35J+7wqJhX2cRO51mqeigIexnEwPTOuQN8QMgGDrQGDiXvLp4Hh1zm1LJiitasSQCmo1IJ76of71KQmlNQ1j+47BA4voysuO6ywlbLt+m3o20mVJU+85IQ8w6q9Q2Jo5uRw0RmodMXEr168K+MlQGVUsH/dDNPV53bYTP9VsUycu3kLIyNa+wJhWQPYgoMqpogYFHhuLcHsQKo3stYmBm48xItfYX+WHyACLbXhvYfZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(86362001)(558084003)(2906002)(36916002)(186003)(6512007)(6506007)(26005)(6486002)(6666004)(4326008)(8676002)(6916009)(478600001)(66556008)(66476007)(66946007)(41300700001)(5660300002)(7416002)(38100700002)(316002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MPQmPT6jnXfAFM3W9X4ayK65vRnaGlj+kwF/3EY+Yfju8hb+UzKFR/HRE9R0?=
 =?us-ascii?Q?P/d1a0gurFZvIW7W3mhed5KGKYIU1tY79AUWg/0TzGuwkyQdjDFL7U8fezKt?=
 =?us-ascii?Q?Iusg9Z4an3U7qD651NNdc4Ahdiow6JQBxUElClIgvRmjaZH3Pjl/6ZthzpGS?=
 =?us-ascii?Q?GZ5PBoGmmImaWPwcatlWlagGwAyGOD34WAqd3+aX0LgD7rJVvIH882MQM8GC?=
 =?us-ascii?Q?mR25bbMKIZIhNIlSI2Ngi4lcV8cc2u1PeHB5yvcUqjqaoDh2cJA2ACvEFuwq?=
 =?us-ascii?Q?+4O+WFy31vAt56zWV8GfzkXJMrtxGpmjfnOIs6YU3EnNq/yQxWKBRIl5A1j9?=
 =?us-ascii?Q?k09EGznuVcM/pTSsdN4hGemilexzfedWHOheS8H3hEDMUzfSgudTOu4CaRWT?=
 =?us-ascii?Q?s1kKQoe2Q2ilQz1m9HEPwq+WT1Sqh5Kib7rwXAGdvU5Vn9x5O4sBDBqYWBlF?=
 =?us-ascii?Q?LkRzIey5Pm1Nm9tyi9h26PlNclNldq7ThvSKnia7L3rVWzMOFLocl4n4ubyj?=
 =?us-ascii?Q?+23aPvHU2FowfU56GLIuCkwQWsvrwOQe0OOa9HovAmS6RqE7hU1cn4xqg2DW?=
 =?us-ascii?Q?SVl0SFStIZTKVkxPzV4bmiiyHT+GQCb2FPqvr9Rb0GqjX7mO8GJfDPBeIf6/?=
 =?us-ascii?Q?2GOnlYvihMsU/VC0r3Wt61yuHtkBeJ0iMFjdtVo/GPe2zWvoT1ES88/hzgwt?=
 =?us-ascii?Q?YllB/GotfIcLbtRd9ubW0oEuZjKaZ/zfwK8UK3p89CDvpGXYABoEyXWlSAT9?=
 =?us-ascii?Q?G11paIyWCk8VUZIbfp5gsp3HH/N1O51PpKXiPfggIa4Ar8G+ZJZVybqr555w?=
 =?us-ascii?Q?T33BMNxQtDV/3gkVuZustu3r51vcLVRomlXF2Mc9TT1FDvxRrZoXm0W2z8wI?=
 =?us-ascii?Q?5cWwCvf/24f7WmhJbG0dCECXr1WMNVtA8FNSubzQ1Cz1GLIvaJWduLnzILKI?=
 =?us-ascii?Q?N1+mc4ZKjseM05J7YD8wLCWbNsXOKiYRszPAvKoFctWp8+KmJWDRySbrZ671?=
 =?us-ascii?Q?WeFn8RUlH2kJGuHv8KjWjbY3KIPd0beIzm3FxupGaf4CD5crCEboecnXR847?=
 =?us-ascii?Q?bHYUUR3i3HStVqdeHfO7eCfegvyVvEQH4mrz9iy4G/2XKSfJN50W+g/cziVQ?=
 =?us-ascii?Q?10nqtSxPtsdBfYElR1zr4m5LNdcpihcXR541WVBHOd1E2GmXxd3eWpbWm49g?=
 =?us-ascii?Q?rWQJ8xOB/dFZMWcHcKkJSGU2ioSnL2T5MZv68R80sjAyEKvmrgj954EW9pyP?=
 =?us-ascii?Q?vTE1C8SB4Ksa7YWoFSGIQFP15VPgJ08oljXrJeN4WC8gYRhU00nIwjISo/N9?=
 =?us-ascii?Q?tRZR35BOo+5P4+G2K5W52tGsG2DlLuU3sv0t0DpzKjqJ7+zMdkBTpuN4bGoR?=
 =?us-ascii?Q?GfPKhoRBgKcvaQsmEVPj7qH5awgH3cfYeEIt/qqmqve0Xumopx83WF3IXGSz?=
 =?us-ascii?Q?XhL3+gtqDKAYO1kx3FzNAQk+rhnhHGwAnAbh8So7Xbl/rphgO0HOloN11F/w?=
 =?us-ascii?Q?aKmV6Swed7wKqaqToSNdlBBdCcuXs1pmEWlHHUoEIBu7gpTxjaa3kZLrAkYM?=
 =?us-ascii?Q?PVkeJC2keto9jJXuKe/xrDT094KL9zgLtmuiSSj68/e/RlW/00TqY788bwJf?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uFifCih7yw6oI5bYT6FEuyRyG4ZTBs99zdkTI8lcJJZlS8vzmHvmbsx872JU?=
 =?us-ascii?Q?oH4pOrlF7xGMJL/d5nARiqysj9WAH6U+x5hB68KomRDcZRbZaE+EGPifi7iQ?=
 =?us-ascii?Q?IVOZGTTVQQFRX6jnyPLu89wnUC7LGI8Mfo3dugb2aiYq/WjKcoXYhmOPpeuT?=
 =?us-ascii?Q?RnkMLK1wq3/GCLXJayrVPFHvtSRauMj7MJU3+QnGDvXR3c1srXqIV3rF3PTA?=
 =?us-ascii?Q?NhHpL03N4ShuSDMJj/SQXtzpAVTTgg8xEjeFY1Cy0+OR/YmAAbGn3zBv+p5G?=
 =?us-ascii?Q?0dEXRknb7SSSSRrJM8My5eTrwKE95oC7SMcjgXYjq0kXw/pVuvtEuV4Wo+kH?=
 =?us-ascii?Q?SqEJvi0taGXR4ZpekSwkCP/qXyKRoo+BCq+sjsu/G5AEmFVsDM6bEIiSuqvb?=
 =?us-ascii?Q?g2xkNUu/lcgaQQ1J1r4OwCNm2Focl+LVF79bCweI1tThL/MmxuVPLiowZoww?=
 =?us-ascii?Q?Me8AcI881S2vOD6sNA6Bt1wJA+HPJFW+hW9GPtB+zFWDIMxIt5o/E4T3zx5z?=
 =?us-ascii?Q?ixJ5NS8BcN6nEqtSP+eh/8Pkg6sptLcvuHWmCwRjO6a8/bxpNmwe8Lexfl4s?=
 =?us-ascii?Q?3qBpvcyPZr0p2HcwJdZbhG9HlMWBiJgBjeyQHgY5wuG9Z5xTkvCIusV0ulHG?=
 =?us-ascii?Q?ACbwWYUgc8Ai7shgNYOWRslv+23q2DPy6kgB2DqAtypg8p13hDPdhzUAogV/?=
 =?us-ascii?Q?kpTPTlPL6vhpWpBYkBKy16FxmL3tHk3mfOZxPDM9XzHDKUWmZQQDMdC0eWNm?=
 =?us-ascii?Q?UHgIDUB304N7E7iVIHJyaE0OHM2WDa/xmKNeS4ZOx93m1tizlpqZ0pP+PKlP?=
 =?us-ascii?Q?KFFZmHnCwvoz2ES9xfM5Vl2ZY29G5+23va6jgH7PbrcDB/ZvUMLfNXQZMlTZ?=
 =?us-ascii?Q?avhnKeVOPItepTnsJ0V1gM5uR8+krB9OcQNaqn2ck6CC3DcYLzXZIohrtVJc?=
 =?us-ascii?Q?iRSL08JTqW5NtVjIBYgK/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f9272c-b754-41b3-4959-08db33e5ac91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 01:49:34.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ6ZxYx28GfcVcGPIm3ZRXoI2KIBKlqfY12NHNMSi1+SfxCmPUiOpRr78FWR/umnd4pboUcvs9RbWGWRrcQKCHaqbh4gKnuKNcntuV/KdE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=825 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030011
X-Proofpoint-ORIG-GUID: aEivWm-oFjgCOMolCywO6gT4UIG9NfZS
X-Proofpoint-GUID: aEivWm-oFjgCOMolCywO6gT4UIG9NfZS
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> clang with W=1 reports
> drivers/scsi/qla4xxx/ql4_isr.c:475:11: error: variable
>   'count' set but not used [-Werror,-Wunused-but-set-variable]
>         uint32_t count = 0;
>                  ^
> This variable is not used so remove it.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
