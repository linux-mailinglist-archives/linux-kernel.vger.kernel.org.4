Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE57664E00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAJV3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:29:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B2C5C907
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:29:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL3dA5011348;
        Tue, 10 Jan 2023 21:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NFMJF7cUMJP9lifP0TQBljBMoJD1rIbmPNCDBxv9nAU=;
 b=2ydqloHx1XjkhKY998CED9Qs12dqCCdFl4yEwis26UANneUsGGrWWd8KxdygNsAnuDql
 x/0teMbmGjdr9RycPOysNmlafuV26W0GoENcyFZ7QdwXDrwcS5tehCuDB0DD++PHasxy
 XFPhwZRYO4A8Q9Tm2aLpl8IjwY/Nmp2XaxnPHjRLRc1Dg7QtsVN7MW5FVRYItFJ/nThk
 /kv4NSzPW7azzOcJXj5Zt4NP2+gWN/xS9NtPsg7pKauiTTVkAg+hb/tcorD/5IsUdUNy
 j5QWJUL70yqPgX8yNma44wRMRC8x+UHXaE+gFrJRFXaji6tPt9lYI1M2JGeOInBTGaAh DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1fe58303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AL8a34013050;
        Tue, 10 Jan 2023 21:28:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1fp4gn28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 21:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KljZCFg4VIE/L1uidnGE1+vSi6fNvSqbZxxUUH30nGZQsG9neARDKSSIr9sxCtzcLosdkVJ7gsVnZxMbFgClDpY4AjIn6iHK80HnThP7zXqijnzEdKI6dmugIsAxja9xN8xXR6p8t6h97lAr2bFLzjm9ygE0mfZKN1iCh43+lpaYhLDdDHt6zzShbIg4Xz1rsmk3az6Sk7My0o4Jx88Rs5CZVSyDgY3ZTIM/qhSp6ogRjH3IMCtuM5UcvCWk70TsuT3y+62NDrg6MqyP2Ikie5AkW3/HdsPLtTf0Kt3tv+HvLmk6TG9NQSc5mWXikxCcnOzqvfr8gdJZ3U+VMt6qEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFMJF7cUMJP9lifP0TQBljBMoJD1rIbmPNCDBxv9nAU=;
 b=MoaBk1QRoYKDYKQ+nemXP6i0zfazDL4HtGKz9dX8F8t7Nsv2RbPNRSEZkYSw2nkgyXxauqPu/aC9hrsZ8go/hnPUtMu1JtyCUPwUaK7mV5N49m992TFB8RVBMro+EE8ahblcXp6zzinKVtRx5lxO/f9K/eBC+TIN4H0ocJssYjhVRKWHWlkTc0n8Xa0w2Q+cKIxESjR17PPVyN7xjpWuRzOrhdM61w2LS2RVOJcxD7MPXIIHi1KkPyXT1PwV/Tm6BghMxfxllbIg6z9IfzB8dKigoFO263oEgCi/0P5Ruk3zIUmD4zuhRGPHv3eLqe9vG69gdhTGQwWQqc0u2muPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFMJF7cUMJP9lifP0TQBljBMoJD1rIbmPNCDBxv9nAU=;
 b=tUdjGJTOd/3IpBy2PfZOSmPqxpNlVfDlNScGPANkgyuBAryytZygjToo3gMMT+ZLlIIBHvmm0+TF5t7ze2lpwoYiSW8z1BmCD8eil1RundrHf51dzzT5fbX8yImXbQ92kLZh29ee6IBeZGZF15SHUKjDCHSKDKxps47H3essSvU=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB7153.namprd10.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 21:28:29 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 21:28:29 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 0/8] continue hugetlb folio conversion
Date:   Tue, 10 Jan 2023 15:28:13 -0600
Message-Id: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:806:20::35) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: af22c69a-5205-4048-0d3b-08daf3519dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8g1J/cSbxquhDIvUwzlfId6NRV3JD0wGtYB9k++qS2fQNASG7e2Eamt5mpYJP++S2SDIv7KidC9AlEIpOSIUxh8ORoIw+iAhZL9HmcY+uUPp2gKXwbcx6A5e1XBpudKI9DbhZE7qNJVueKvFDz4Jsz8PvISUtt0TBU+hN1SynkcomuuNsQp7yCHZNGoSfCEfn2fvg0V9AtV4Skf14hFwzX5S4uj63MUp9hwCIlnJUL1HTTFh/h2lmNX+sydzrAnIfQg/ma4bJrIb6SW1uYLCy1DId5rUEDIOOnQI35/5Jhy7t3xZ/Kcf64u4dv24Q/USkhNLU6EanWxj/lIoJeX5wK6ghCZMw0dAhncnvkk/7O+oUUShiyDfyIRlcIUKkkCKn679l7sY75ZZHyNPHLabELYSbCG+UETVoCxkskXQrjpcFBlsly+T0lhQtgFsgXT0KkPinvx8IpdrcnNDlXNGsDqtAetVV0NLX8Bj14Tq2IaiX5gxbjQfh1hR9dxthQb6VvGhVvh/iKIepVmT8COZWXv5nBpti+Tis5OOdU0jrdLuJOaE8ZLLig81CO+r/qOPnyMwMWPDSdCcmd5QgAMgFn60kiwm+tePmhgOMc15QnBTfvrvgNhGetaB35skk4me6ZXWPyqWiWj4B/vBYWB5pJ74ouBdTBQN9RbpPMZ/g9E2PbvK2utNwKUFwl0+3EsO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(2906002)(5660300002)(8936002)(44832011)(86362001)(36756003)(4326008)(41300700001)(8676002)(66946007)(66476007)(66556008)(38100700002)(316002)(6486002)(83380400001)(6506007)(2616005)(6512007)(6666004)(478600001)(107886003)(186003)(1076003)(266184004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EdXEgZpEcSB0kM2sPJRujoEHXvkIiusMkRfOSH90L9EPcYMyDeiaI0IWukoY?=
 =?us-ascii?Q?2rJL+bTZ5Y19mIVhmb+l/6UX9M/h8WW7f4xnlSjv2DXooZawR/HNJ+BFYKZx?=
 =?us-ascii?Q?yMttD3k5LuVtK9pPq2fj3BOI4tNi7hR7gMDq3tOW4v7HulYqV0CJeUTip08p?=
 =?us-ascii?Q?WHlynEat9nTrFEgGVCCQkLg4dd29d2b1XA+ciXFv3FFUXLDFLIR4HXtJE2AB?=
 =?us-ascii?Q?a+fGPPQefPP0Ld1tazvJvYiq/SZFZgsz8WCUwtdKFMkDRCKDAfLQpBxhoyPk?=
 =?us-ascii?Q?9CU6CMV8vTMbwLtOxjNyQqIxBTSUzGwxmzz2IJ+6FAf/7forKkGhRKvypXMF?=
 =?us-ascii?Q?sVQjuzVZJyp+IAfFrJXvVdZjJpnizMqaddDCVQR/m9Ze84yn4rfX9WIKItLQ?=
 =?us-ascii?Q?Ck2E4Jjfb9e2gwTcNk80lZzplJbtQ3wOCreMPogOsLfWcF6LNJJiUm+O5rwq?=
 =?us-ascii?Q?w0BdxMFQWJxBaGdiUHXwOIQnmHOq5lXtybdBp386Foy36p4o21PWstdeOiUl?=
 =?us-ascii?Q?uiX9Ftg2trdWUIM0mrUGEKSR+FvyJKwsoLBliOh9fk4cAcFS1OMiWErBLp3P?=
 =?us-ascii?Q?tNqjnXrXRmvFwgA6vkdhhuxET8Kcc40nCHh1aeSlRBhXv1Lg45FM8TpEcEWk?=
 =?us-ascii?Q?RsLCcHaPT80uU3TZIP5ZGFdlRL9KNjlz7tYf8zpOgJWnD1+nJ9+WtHDJ7TP4?=
 =?us-ascii?Q?rk5dbCDb0IlBkByuzSUKrLKPsgmmX7d0x6NGpiksLH77DlbNQnN0BlJxvk8q?=
 =?us-ascii?Q?ATQTQK3YuqGuUvt2qd124HrGDRnu3iKFpl2IOjtQ9NWcKorhnqWNcamcPPkg?=
 =?us-ascii?Q?a5aloHNzotwUktK4F4RDXFiLvMcnx8hmZhwXfmYfLtB57Xf43NRrPTPYZOer?=
 =?us-ascii?Q?Yhum6FuDlr/5JvMhrZVseBwjpbCyKfpCbPa7lSk7YkpYt+bACvZ5cJZ42pL9?=
 =?us-ascii?Q?6B6bdKB/Mv7Hp+8mUscU09KWoxNZNNr9fpCXnUMN+TSZyqysNNBf8BKhZGnl?=
 =?us-ascii?Q?anPsIZDoOHIp+SwyhGcb9GCOM8I5XOsELCOkBkXI7mOSGFsewDn+JSwkIXZw?=
 =?us-ascii?Q?LiUIwAxIDl5puImGPVn6LCaHCJ/9Cwc3zzBc2PGfbIQIGcyIMu6U3fI8CV23?=
 =?us-ascii?Q?7+4ghE7lz2fyeFOMI5ZonmRRlK/XcGm9RzuwMWyc3D1Jwec6B9CR9SHvWjJZ?=
 =?us-ascii?Q?ms540YFyYB0ZSkApJXI6ZXCpKoHQ02gj9W8ZJy7QeXaz4WEbQHYDnH08dC0W?=
 =?us-ascii?Q?X269vwVjP5PjkwmDo+Z88H+NTfj2eXVPBqurfSZnuUnrbF16HcRWxnroOKWP?=
 =?us-ascii?Q?F2klX2Wlptx+t9JTHWtRChSiUpjymJLKSH9HxpIwhWTVIYIHA9Roi3p4+PAH?=
 =?us-ascii?Q?dqPKutSg2XlEUZke+pdrZb8xfH0dDE0FHmpFoh9QJ7EQ72q7L8cszHU9r7e2?=
 =?us-ascii?Q?I5wDg33Q4ZHj9h/ddMyp87fZNcLRGb25rbyt42XkZNALWclODeDYMr+4qbCL?=
 =?us-ascii?Q?IEy7amzFdfDkvNNfO+n++8b9X+2ZGqSsT5goKyzeKvUgCuSq7reMT/MwjYx6?=
 =?us-ascii?Q?bwLkAFTnmgh36Otv90gay8Sb64Arao/coeZ6zBeumzmTgTME700odKCUJmEe?=
 =?us-ascii?Q?u6LaE2cvrU5bUMd84T306Jg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9SHaFA1OqzN2NG6eu3k0Lr3dIbyxwLq0Pp09E43fNh0yf/9tEQdBkRf+qMJ3?=
 =?us-ascii?Q?ndQ8FAn6IP4lCJ8s92h3KKe5oLetAoKfyUytZb9mMqeb9rHrIibrQddPHIxh?=
 =?us-ascii?Q?uEiqyYpJp1aLhm80PthL58UqLSsHJO5dHH5YMFCHgjfMUHixRWEPlYX7DVQ3?=
 =?us-ascii?Q?NPpoZBFhrz3MB7qV21H5Fz8tNXEiBi2RGfhwrr3LBWn8ePuHH1CEVnWrwiKH?=
 =?us-ascii?Q?S/vmVjqdUQtEUl6dcWJzYG+fcNxMzIRJzRIDN7r/0/FBBgjGsQG6G60Im6A7?=
 =?us-ascii?Q?JAdhlL0+1hfmBdZDCCUtf4ssWqLMrK76wnTgrIJPIaL8RTyM5RrZekaznpwz?=
 =?us-ascii?Q?IYBhruuNQC1cnOi9YKRRTrOoMyg+PoQCRNyZt+ycDTe4lcQrITcHbnqW9AAj?=
 =?us-ascii?Q?dKFip/sPMtTkHWckZyxX+43VpGGxbHzP/AsxDMUS7krY4AruvN1eYkENpQx5?=
 =?us-ascii?Q?ujbpyhu9/NQ0rs052hFce6XLVC6qgqltPFcyK6BjnLS2RnblOh56G1/m4vHZ?=
 =?us-ascii?Q?72/FCbRUvEN4x64KI8J3gEMFg/4R+a+p9mEL4stcRZs5YEdajwVMo83V6w0y?=
 =?us-ascii?Q?Ck5s/aR5Gx/7+lntDMat5iMoTcm0UXjEPwuA0GLr01Fd6eQfodfm7vZcuxbK?=
 =?us-ascii?Q?tz1+PZ1QGw8jfzbrX03gpvTzI61K8OH4MPCSXOepfMhPnW3A6kaJVMRiNDzC?=
 =?us-ascii?Q?cEQ8uf7fkLlsG2l2Nr88UxOwNVD8VxyChTUCF8nYhZkLdw9HySNRkNVuVY3G?=
 =?us-ascii?Q?f1bXnWqPc1AXnN2yhjJ/hiv17iXtRy7Kge3wvk1u0ZQGSieCTYK/3OZwOWln?=
 =?us-ascii?Q?xd6RVeudH7vwZaFfPk0Q5yrH69thuLElEy4Bfj7PAMPpBRyTb/VH4jnH6/e5?=
 =?us-ascii?Q?CEivwzEBUa5CT88qX180RMFlSPxjMfPd07so7k9+4k0SYpyTlUTKpJmJrc01?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af22c69a-5205-4048-0d3b-08daf3519dcd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 21:28:29.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccyhhU5JEdVRQPpMxjEI1tvMqB81o/wlu02W211bBRxRIjoCb6y2A11Av9ljVHtakyVbXKDNka+c1+yndZ/QfuyMDAT+SzDzhVRMQU24KfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=553 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100142
X-Proofpoint-GUID: 58USJFIwX4gBfdcwjAcGpNpGX_HUGS56
X-Proofpoint-ORIG-GUID: 58USJFIwX4gBfdcwjAcGpNpGX_HUGS56
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
This series continues the conversion of core hugetlb functions to use
folios. This series converts many helper funtions in the hugetlb fault
path. This is in preperation for another series to convert the hugetlb
fault code paths to operate on folios.

============== TESTING ===========================
LTP:
	Ran 10 back to back rounds of the LTP hugetlb test suite.

Gigantic Huge Pages:
	Test allocation and freeing via hugeadm commands:
		hugeadm --pool-pages-min 1GB:10
		hugeadm --pool-pages-min 1GB:0

Demote:
	Demote 1 1GB hugepages to 512 2MB hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
		cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
			# 512
		cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
			# 0

Rebased on 1/3/2023 mm-unstable

v1 -> v2:
- remove reduntant get_folio_unless_zero() and use existing
  folio_try_get() in patch 1 per Matthew
- grap folio directly from hugepage_freelists in patch 3 per
  Matthew
- add r-b to patches 1-2, 4-7
- change variabale 'subfolio' to inner_folio in patch 8 per
  John Hubbard

Sidhartha Kumar (8):
  mm/hugetlb: convert isolate_hugetlb to folios
  mm/hugetlb: convert __update_and_free_page() to folios
  mm/hugetlb: convert dequeue_hugetlb_page functions to folios
  mm/hugetlb: convert alloc_surplus_huge_page() to folios
  mm/hugetlb: increase use of folios in alloc_huge_page()
  mm/hugetlb: convert alloc_migrate_huge_page to folios
  mm/hugetlb: convert restore_reserve_on_error() to folios
  mm/hugetlb: convert demote_free_huge_page to folios

 include/linux/hugetlb.h        |  10 +-
 include/linux/hugetlb_cgroup.h |   8 +-
 mm/gup.c                       |   2 +-
 mm/hugetlb.c                   | 214 +++++++++++++++++----------------
 mm/hugetlb_cgroup.c            |   8 +-
 mm/memory-failure.c            |   2 +-
 mm/memory_hotplug.c            |   2 +-
 mm/mempolicy.c                 |   2 +-
 mm/migrate.c                   |   7 +-
 9 files changed, 130 insertions(+), 125 deletions(-)

-- 
2.39.0

