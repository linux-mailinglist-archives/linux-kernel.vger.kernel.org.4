Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC672D0D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjFLUlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjFLUk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55631984
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOW3c004153;
        Mon, 12 Jun 2023 20:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=R0qsDcG9O4MhzZqrq1oD6FDIspNJvYaqrNhWXitLwfg=;
 b=Y3b+g8r3438KMZoG9jk/PrPBc1kQC6lwmgrMntLEla145gmNoVf288KgfIox/enLPgIC
 HC/lykFg9Fu1krocF+AAVOfSmz4DhimQLFIst+gWNTHztGq6+cM7jyih+iyrU0RU/XrI
 /Cf6agLAHvVKFINXOXSZe2NjVNoNplsT9Ogwq/dAc19RRz5gK+tLlF4RjY5kIiTvwV6Y
 VnDkHydtkwhTYy2hkTKW2ygXlj39wCxEgPDR2S5FqPZp4v8n+V1hYpoJMa0xZnk3OkuA
 VVdr4jW1vFhFhmuqHxXd43BfOOF76bsveJ+3R2Gp1AlGKxLBOYNYxcUQaOx3o4mTOZ1a RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1uxan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKTaW1021673;
        Mon, 12 Jun 2023 20:40:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm39bw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxz0N6LVqdEFFJiaRp9WAFKOx1xBLjerCHfJ49qA68Fmj6Y61fShuTBSb3/7/aa19Iw3mNV2lxR/pi3xkaYL8icR6gyC47Xd6wF6g6ukVBOqmZTge8EPLcHj+atIi+P1LnTf2HUS4brtnaDfCHapXQ/F0ECHreCEJBYbP9S0zMlJ6GKQ0TiUYghL3AptG19bFGL7uDOTCiw4IFDqX5RauiWxeM4KlWfhkAeFodP3QYgsk0SPIga5IwOJ3bNiql5GzuloBdqYDx9A3aFoxk7+WpX1wspkPPu3UKeQ375YYrqlD/Up1dxl17tp2wXUIU8eJhLfYyRWZm2G9mXzmb4+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0qsDcG9O4MhzZqrq1oD6FDIspNJvYaqrNhWXitLwfg=;
 b=DAGmSOoMM+Rtk5QVkHbLl5DowlG8igiXQ79g93ILJGZqAcfWdLNKCIxrMz1BoXmoaE9jDIduYCv11mA4gIih4mvbQF3blAZIcrv16bApWEcIC5V9JFYX3MfCnj7l6KfHrCqxZoqJXZ7C1bSc8NDkyzeMlacjpCLOuPdjiv0wfHkhiWymWjwi/4HYvH8YGiHBaWWHy4Bhvy6UEZKaVZ53Bqer6yQHVIJ45o4fsUmsT8dKmjVbuXbq9jrxjoWN8cRYkU3gT3Edt6tFff2Hg6U7/OdcHRIyhP3fZYgFnkqN2bXGMKy3QO9o4tNtDMdwTVL2Z0+8wnblX6ScKaRmndS6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0qsDcG9O4MhzZqrq1oD6FDIspNJvYaqrNhWXitLwfg=;
 b=CzpAq6EYG94Td/g4JsxG6pzseIWOu6Rt0z0vvyCbhigNsIDKyFZaGtwiIjK/dLvchoGhstL/wCYXpUhoGpqg67Cgabt7TShJrEZN0qGe0v+tUtf9OnrSx9ENv/3JHujy3JfpCycbi+O5A357V4/P4cY/P+MFfSotuCzUwzjYi04=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:28 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 11/16] mm: Set up vma iterator for vma_iter_prealloc() calls
Date:   Mon, 12 Jun 2023 16:39:48 -0400
Message-Id: <20230612203953.2093911-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: e55d9ba3-17aa-4460-d8a2-08db6b8541da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baiAlL7d72i00B1ajKVYNocWxGFowIdsB/lK7kgGCoBgQ8wNX3xAXDGzwaAZo1tmfKaQ2eu4U/UTGpp00zxHTs2qknGFRss423KPY4V8ZdYcIOdsga4J+HjRfFV5BLu4v4j0Q1rLySK3XSSPUNWZY/mj3O2fckbTUUFMCIRQRboAW0IFWXBpnPylCRU6oH0TCtbRFVVTkx4PJpsVgpRF3g5SEdk9pKiUuMqYoqc9nNuCDKYxiTc2q0XD7sHnSRw1uGh2b034G8/+ZDnC41N1BZSL+iMEKqlBIIIDNG1g/1zeflRiDGbeBlJTMYNi7Sbqj7KSRHIwMwNXQSE1DwothH3SnbUXRm1Lf0slyvWXEqFaRq10+6x4QXX5RAxaWDXEQ761i0sI5ZkVV0+1F+lOfpfkJesfzKL/NH3t+Sj/vyQ8HE7Su3WB0rDXjaEkX4rI2y4BukN3jBqJE3JAhiW/QAz+i6iezacCCAs5y4WG657PfF7KVzwxxbBZCN4biKg5RD0hA7viaQVb0Zebnz9kSKpKWqDtzLwx6nRFu3Tp8dc2li99s63sWnW0ies0B7Ag
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(30864003)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JLWDf2Z159QOImfXtQ89HkOyaYpafdVRF2E5ZLCnHerdojwzlc4laSINEXOv?=
 =?us-ascii?Q?q/Xkhz+b/0FxZOjYiSNTik09ZQ6CDZHIxN3olFU1YUZSs3xoKP+JBiRYiXA4?=
 =?us-ascii?Q?yiBJgk+Z9YQdF3/23YAaNw2ixBz2QPXEy2y4mTB5PQtMYGyCb71KyJwEJOrE?=
 =?us-ascii?Q?891yWwe4G0EE2c+AktTR50L6PNuqMDHIKze98UjJxreRxGxVR7LK+1zYCv/c?=
 =?us-ascii?Q?5NSWMJeg9eTbYj8nsmweEKXNDnXitee3lyL9m759HIrm9qj7OvuX/84O//50?=
 =?us-ascii?Q?YD0GTjd2Cu886tKnwV4IuM/DnBJ/SwwQdLfeMijM4s+alBQ1Qs0KVohzKq/S?=
 =?us-ascii?Q?LpyXKPGGOm84DZ98tb1jYWYBBfVvCURS35uav7xNmQO6KL+zwci+UnNKa7JR?=
 =?us-ascii?Q?2ZFBmDX84k7rhZGeG9m6YSFa7xESuch4IRHGecLoGjPsxKShpK07YF1JBYYS?=
 =?us-ascii?Q?51OCu0KURqS/iup4WbHCrdLkOqyWE2PbxWobbgfvopAEX6Gc0QOMELYe0Cia?=
 =?us-ascii?Q?hlL6wYVtb7QnGzawH/Py9RgtGPtvyu8MkyXnFKQ6qj/bNxgkgu9sNzbzIpwe?=
 =?us-ascii?Q?sGrFK+jMKSZ6GOuXaeTMx0LoFq6OwiuwhKeW7koThzumcTMiFltoNcWRrF5a?=
 =?us-ascii?Q?2tm15CA73tmzWi97cvEWcdB9JmxHQKjQhy1CniHdOnsWhB+dE7W7W5RVKBqb?=
 =?us-ascii?Q?E+BFYtP/uaqEZbAs+5jvkaD3eKyfa3LO/t7rMttQAxPfgsIUUOfI0RpDpOwH?=
 =?us-ascii?Q?ZpMzR1B/CzC9hv04a+vGudp6JlGO65U0Z7J+PcgFkp/PNiyO3i6NbwuOK9NQ?=
 =?us-ascii?Q?/Hugf3H/LrPZHWxLaPtxFwpMc3qy2uicNCoh+bltZ7zA21zj9VIqgpNTkt8p?=
 =?us-ascii?Q?dKoLdZjLHz96PUot32Y+y2l6eM6kxXJK80xr81hzVbtdM8eb6DunUqZAANbA?=
 =?us-ascii?Q?mIZIsgN4f2OLTFcYzuVZ7AFe9eFyNjQks72tz0fbPWOMqW1yNL0Q3YvAq5hw?=
 =?us-ascii?Q?o9GweVVaaPjAXmU/JlHCDi43iV+M5jiXaO9v4VSuWZNEUQdixvckcaW3XCid?=
 =?us-ascii?Q?thzXj9iC+0R8TyT6QTGLielXJAijSGm07RbVmZR4yhlFdnTmtUYASNHyHp4E?=
 =?us-ascii?Q?SWi5+G6SkIEutaAd5jKQga/dQB286F/C9N/QuyNm9uEKE6kU0Gpiq4yzCrhT?=
 =?us-ascii?Q?sfCzWFpc1wiRmhNPiYFGTgWQ5KLst9bCEJEAfj51ZxoU8QrbubSSgmf6qGyV?=
 =?us-ascii?Q?ZeWgAdce+RlTbSvzDTbjBGHlbGEGdNfd5dwN1/iCaUTSjholSRuezoHT5gxV?=
 =?us-ascii?Q?tg2fUX/SBm+MkWw+1jbGEI9ZbiQIS31YABe8pvNrNPTqPp2j/gwyLznHzdG5?=
 =?us-ascii?Q?ULJKo+q4BFuddB/9pVlIBqnHlcrd7bIHfbaoF+1YIHyeaXBmuUvvnO8Hrm3t?=
 =?us-ascii?Q?h4RYJdBXlv5n+Gyr9FWWHMwE/pw3XhzgxHkUnx8qmvzl31W0PzApBMOsnwgc?=
 =?us-ascii?Q?6QamJYgcjHCjNMzktVveEg9P/LFBuGy4/q6hU+H1ctbluQdTK0gSYcd5k3D9?=
 =?us-ascii?Q?qcPsq3D3CACKxQUAzDdIWpsA9dF8HdqusN+MjszrPbaw1ZiK/acjUhFsZsET?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?z9DM7iNkrT/OLzyoklmwwE52k/J2QjoViwMGBkMgxM/s6HKaQYEv/hrFm0yr?=
 =?us-ascii?Q?qGdseZbHbdHBWZEml4a01bR3YZ0dduqnFhX0g/HLPSJuGMYmX3mfZ+bAunuR?=
 =?us-ascii?Q?ty7J/RsgwWP/8zJ+xOxuEt368fRf1KD6ND23Caupdm7c7w++PQcikzStRU9J?=
 =?us-ascii?Q?/iji/0Hvkk+zlblBnwcy5OdnhS2hi8gXPyqTcbS57hAwcdczMcskYKoZ6voH?=
 =?us-ascii?Q?2XTjxwESM8BhabOrrowVGq0gecbFnnxYCYkMLfRgZkNR3uLExMRxnXDjftBQ?=
 =?us-ascii?Q?N5d3Z3jg4ZHHXg7fqQa+ml74Nk+tIcXi2wsCrsl/xFf494XEUZxkWlA+NMOV?=
 =?us-ascii?Q?ZHRxt7Beh9zQZZqTEdn0A3yFrjZppSM1yCuez2kOPxsNZxKuw4p2VFZUtrmW?=
 =?us-ascii?Q?4la02QrsqNTPahwbLNDGdx07dNLJhAXOycMQqjZixNoC2Gd4TEMafHzhadiV?=
 =?us-ascii?Q?K867fm/is3D2nmFp3U0zSqsNKm9WlRaLIZ8OEtIEL6mGNufPWDV3tZya5e6D?=
 =?us-ascii?Q?Lw2xjjUrS2B2IZrGZlnAI0lFryf92w6WGAU248TDNwQ+nzOYLAkDb+25nTdV?=
 =?us-ascii?Q?UCecdpNw0T9lTmrLi/aI6fdampOUS8BRBhioc2Bfslxb7ZlZ2lO5SgF8y1HA?=
 =?us-ascii?Q?82+frPdIVCJhgZbWMluYsw4rH9ZQ3OJLnmcLIJvRpWhxuS/Do7NEgDPSwStQ?=
 =?us-ascii?Q?6gQxeSNNVEWuh+nSymdjsMKuFnT04L5rLm2gflY9ETsTqz07VhfF0ObO6HzY?=
 =?us-ascii?Q?386svlFXx9NdXf+SR6VM7gMpsC6Bn/6byMLPP+KZ8FRIVvZKeFoGK11lOH7K?=
 =?us-ascii?Q?8Dh1AmmlvibHtvpBypi7UeRlGre6yXkHK8/Hc/P1x/R9uUFHxBY7jM+pr8GC?=
 =?us-ascii?Q?TnkXsrAa5u/8a5TL/VA1MGCR1tOKunPAz1IpXhX8R7KuH/AwWVwOpFQ11ArI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d9ba3-17aa-4460-d8a2-08db6b8541da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:28.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seXZaU6wB3eyC6jRbU7BjSTF7MTpTrC4rty6Ou6dFd6CB5k1xVgjQop7oSOZP8u8YiDqwrpOOlw3CPC47z+m0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120176
X-Proofpoint-GUID: D5IC79pNnINVD8vvbzvUb9loOXEQAmE3
X-Proofpoint-ORIG-GUID: D5IC79pNnINVD8vvbzvUb9loOXEQAmE3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the correct limits for vma_iter_prealloc() calls so that the maple
tree can be smarter about how many nodes are needed.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c     |  1 +
 mm/internal.h | 18 +++++-------
 mm/mmap.c     | 81 +++++++++++++++++++++++++++++++--------------------
 mm/nommu.c    | 33 +++++++++------------
 4 files changed, 72 insertions(+), 61 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 25c65b64544b..dc0ba74ebb74 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -697,6 +697,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	if (vma != vma_next(&vmi))
 		return -EFAULT;
 
+	vma_iter_prev_range(&vmi);
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
diff --git a/mm/internal.h b/mm/internal.h
index d78fd0fafa3b..531b2e95146c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1045,23 +1045,21 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
-static inline int vma_iter_prealloc(struct vma_iterator *vmi)
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+		struct vm_area_struct *vma)
 {
-	return mas_preallocate(&vmi->mas, NULL, GFP_KERNEL);
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
 }
 
-static inline void vma_iter_clear(struct vma_iterator *vmi,
-				  unsigned long start, unsigned long end)
+static inline void vma_iter_clear(struct vma_iterator *vmi)
 {
-	mas_set_range(&vmi->mas, start, end - 1);
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
 static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
 			unsigned long start, unsigned long end, gfp_t gfp)
 {
-	vmi->mas.index = start;
-	vmi->mas.last = end - 1;
+	__mas_set_range(&vmi->mas, start, end - 1);
 	mas_store_gfp(&vmi->mas, NULL, gfp);
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
@@ -1098,8 +1096,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
-	vmi->mas.index = vma->vm_start;
-	vmi->mas.last = vma->vm_end - 1;
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_prealloc(&vmi->mas, vma);
 }
 
@@ -1110,8 +1107,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
-	vmi->mas.index = vma->vm_start;
-	vmi->mas.last = vma->vm_end - 1;
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_gfp(&vmi->mas, vma, gfp);
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
diff --git a/mm/mmap.c b/mm/mmap.c
index 22c71dff762b..eaebcc8f60d2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -411,7 +411,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping = NULL;
 
-	if (vma_iter_prealloc(&vmi))
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
 	if (vma->vm_file) {
@@ -664,19 +665,16 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
 
-	if (vma_iter_prealloc(vmi))
+	/* Note: vma iterator must be pointing to 'start' */
+	vma_iter_config(vmi, start, end);
+	if (vma_iter_prealloc(vmi, vma))
 		goto nomem;
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
-	/* VMA iterator points to previous, so set to start if necessary */
-	if (vma_iter_addr(vmi) != start)
-		vma_iter_set(vmi, start);
-
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
@@ -703,19 +701,19 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
 
-	if (vma_iter_prealloc(vmi))
+	if (vma->vm_start < start)
+		vma_iter_config(vmi, vma->vm_start, start);
+	else
+		vma_iter_config(vmi, end, vma->vm_end);
+
+	if (vma_iter_prealloc(vmi, NULL))
 		return -ENOMEM;
 
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
 
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-
+	vma_iter_clear(vmi);
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
@@ -991,7 +989,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (err)
 		return NULL;
 
-	if (vma_iter_prealloc(vmi))
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded = true;
+
+	if (vma_expanded) {
+		vma_iter_config(vmi, vma_start, vma_end);
+	} else {
+		vma_iter_config(vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
+
+	if (vma_iter_prealloc(vmi, vma))
 		return NULL;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
@@ -1000,8 +1008,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
 
 	vma->vm_start = vma_start;
 	vma->vm_end = vma_end;
@@ -1945,7 +1951,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error = 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
 
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
@@ -1970,6 +1976,10 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
+	if (next)
+		mas_prev_range(&mas, address);
+
+	__mas_set_range(&mas, vma->vm_start, address - 1);
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2013,7 +2023,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				/* Overwrite old entry in mtree. */
-				mas_set_range(&mas, vma->vm_start, address - 1);
 				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2052,6 +2061,10 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
+	if (prev)
+		mas_next_range(&mas, vma->vm_start);
+
+	__mas_set_range(&mas, address, vma->vm_end - 1);
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2096,7 +2109,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				/* Overwrite old entry in mtree. */
-				mas_set_range(&mas, address, vma->vm_end - 1);
 				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2255,10 +2267,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		return -ENOMEM;
 
-	err = -ENOMEM;
-	if (vma_iter_prealloc(vmi))
-		goto out_free_vma;
-
 	if (new_below) {
 		new->vm_end = addr;
 	} else {
@@ -2266,6 +2274,11 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
+	err = -ENOMEM;
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, new))
+		goto out_free_vma;
+
 	err = vma_dup_policy(vma, new);
 	if (err)
 		goto out_free_vmi;
@@ -2600,8 +2613,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	next = vma_next(&vmi);
 	prev = vma_prev(&vmi);
-	if (vm_flags & VM_SPECIAL)
+	if (vm_flags & VM_SPECIAL) {
+		if (prev)
+			vma_iter_next_range(&vmi);
+
 		goto cannot_expand;
+	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -2611,6 +2628,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_end = next->vm_end;
 		vma = next;
 		vm_pgoff = next->vm_pgoff - pglen;
+
 	}
 
 	/* Check prev */
@@ -2622,9 +2640,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
+	} else if (prev) {
+		vma_iter_next_range(&vmi);
 	}
 
-
 	/* Actually expand, if possible */
 	if (vma &&
 	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
@@ -2633,9 +2652,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 cannot_expand:
-	if (prev)
-		vma_iter_next_range(&vmi);
-
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -2721,7 +2737,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto close_and_free_vma;
 
 	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi))
+	if (vma_iter_prealloc(&vmi, vma))
 		goto close_and_free_vma;
 
 	if (vma->vm_file)
@@ -2994,7 +3010,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		if (vma_iter_prealloc(vmi))
+		vma_iter_config(vmi, vma->vm_start, addr + len);
+		if (vma_iter_prealloc(vmi, vma))
 			goto unacct_fail;
 
 		init_vma_prep(&vp, vma);
@@ -3009,6 +3026,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (vma)
+		vma_iter_next_range(vmi);
 	/* create a vma struct for an anonymous mapping */
 	vma = vm_area_alloc(mm);
 	if (!vma)
diff --git a/mm/nommu.c b/mm/nommu.c
index a764b86b132a..a96b889cc17e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -583,7 +583,8 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
 
-	if (vma_iter_prealloc(&vmi)) {
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -591,7 +592,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
-	vma_iter_clear(&vmi, vma->vm_start, vma->vm_end);
+	vma_iter_clear(&vmi);
 	return 0;
 }
 /*
@@ -1041,9 +1042,6 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
 
-	if (vma_iter_prealloc(&vmi))
-		goto error_vma_iter_prealloc;
-
 	region->vm_usage = 1;
 	region->vm_flags = vm_flags;
 	region->vm_pgoff = pgoff;
@@ -1185,6 +1183,10 @@ unsigned long do_mmap(struct file *file,
 
 share:
 	BUG_ON(!vma->vm_region);
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
+		goto error_just_free;
+
 	setup_vma_to_mm(vma, current->mm);
 	current->mm->map_count++;
 	/* add the VMA to the tree */
@@ -1231,14 +1233,6 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_free_areas(0, NULL);
 	return -ENOMEM;
-
-error_vma_iter_prealloc:
-	kmem_cache_free(vm_region_jar, region);
-	vm_area_free(vma);
-	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
-	show_free_areas(0, NULL);
-	return -ENOMEM;
-
 }
 
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1323,12 +1317,6 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		goto err_vma_dup;
 
-	if (vma_iter_prealloc(vmi)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-			current->pid);
-		goto err_vmi_preallocate;
-	}
-
 	/* most fields are the same, copy all, and then fixup */
 	*region = *vma->vm_region;
 	new->vm_region = region;
@@ -1342,6 +1330,13 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		region->vm_pgoff = new->vm_pgoff += npages;
 	}
 
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, vma)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+			current->pid);
+		goto err_vmi_preallocate;
+	}
+
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-- 
2.39.2

