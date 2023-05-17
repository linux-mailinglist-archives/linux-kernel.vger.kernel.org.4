Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C1706DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEQQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F77133
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:17:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4DtC032144;
        Wed, 17 May 2023 16:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=gLFYdWov4P9Tmx/yE5Yd5P2g0kOW3P+UFXo1n95NLLE=;
 b=mOLywOmTyy/CRwtcR3vHRJ6eVPFgpcTkxQRZG45GB2LBlO3+Xl1jRIRyidXVv8mL24gP
 bHoYYfcoNRMlhVU35eCacwxIv0SPxq+ARBOWma0l9lNn6nTIwJJUCOy0WvJwCNfIb7yd
 +kqg0FPyOcrC/QWsaVK3ihkCqdtchUQWYl2ynY1RbkKcN/YFE3mgd7luNTPa0UrcCfxm
 HH004iumUd/9mi4T3yDqCCsbqtX5f8YD1FDfMYG3u6cQGhFcgJf3ZzvjDHNIVOzMMO29
 8WzU5bzG90RpKo4BDDvFm8K5zt1t13dY/H+pOysJ7gBLHqiz2NXz2nUbEEK96t9oFAAV mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdpb7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 16:16:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFuB25036269;
        Wed, 17 May 2023 16:16:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm02mvs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 16:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeaZFj5GGPqjbKxqfJ2dkhxPXNTF+XjIQ6Zbdm1SxSdsigxNKIVAsn6h7oT6VaCfOK8QPlTRJHEIRTHWv/Du6Xnbj9wg46UAXIzQ6R5i+pXCyW+6vhaaS7loIyzZ4kbcHZAwfGMF+zOYdBpujvVl7t8BxjtIiiKJiHrqmP4rjRXYcwvnY/D/wrUS6wxBP1VCx+E3++7cix33XqiS74QJLEIwIkiW/BVDJdsOUsN/a/xqEjr78P+5nPI0v37QIHyLDNVtIwU0sXMMjJ6XGkB3yd3/yWb5fFNUQgAD60AKy0+EN3iTlJ8KOGtOLHL8hzo7AZH58TP++DPh7Uu2s5+O7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLFYdWov4P9Tmx/yE5Yd5P2g0kOW3P+UFXo1n95NLLE=;
 b=koc64ffzwNX5xQrO5HyHWf940ARs3m1G8UNY922WsB3IJ6u8t3deT5vPDLLkfAfq0jAPpQig4+8zvF96JDuuQhM0M3HGiXurToZdqN2EIKR+gD/An3W2sqTciaHpxdLRFgGzM7kCOrgiiO28rIiFgoBFZhDEoLgDkRn2xikIm3bGF0aoCf9Kfa2guPsubvtiEvn0+ZFeAJzX/Dfs9/Vv6Chu4jshl9pwRJkGMpIQE91JosXNtxK6UzvRs86IurCYqeDl7xEDrIKRXJzT6wJGRDWSXuJIdvHqyiHqj8yKTMIDA2Q9jG61wtJ7ukmaJL/tzqpzI01c71OsAxDJISQhPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLFYdWov4P9Tmx/yE5Yd5P2g0kOW3P+UFXo1n95NLLE=;
 b=sO/Rh1wptsV6K7HOuYQK8Iuhr/2d4xBIbVEKbYv1YNqwys7XsDsbINL1t3GR1qC38/rF92O8SKOn1FFAn8G22AwuJ2U+fWofCFEryEMe1xLM50rbtp8XjMLNf0tfqdDnt5fkXuBaqoEEvBm4ItUPXaDiAGFCLSqn8JsLeSwMQJE=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Wed, 17 May 2023 16:16:43 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:16:43 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, willy@infradead.org,
        steven.sistare@oracle.com, ying.huang@intel.com,
        mgorman@techsingularity.net, khalid@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm, compaction: Skip all non-migratable pages during scan
Date:   Wed, 17 May 2023 10:15:54 -0600
Message-Id: <20230517161555.84776-1-khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::29) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DS0PR10MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c525c8-dc09-414b-02d8-08db56f21a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09gs4wGan2yfGD6r6hfjNS9Aau9RmN6gszZSLAERVeO1u0wcdAEX286Oxg55bCYG++gCjyC7tPUMuBNHEkqfymFRDs/A95d9/dm2zXzwbRE9luZdO06xoam04iQITO58FSOn2OH+q7vcpJfXrBYjGJWqupAg6SIruxi2Qbw8kJzSwmNOXSbq1jm+W91R20bvr5V8U5dG79QEV81wcPCQX6VoH/agTl+qJAZKWYOi9IKnkLLApm8oj8IZw+sj3Pmfd6WFg4z5yNrU1cmPhphcPShxGFtm+yi8tMSmaFQ2/0apDYZi0tM5GTQgQH0gOqh8pzvjGbOZn7fDer/kQ8BX25QCtohI8QfCoFrvymdZSQ1BPaeXhBQjHROeiv1VsqG7+nzjSTnabwC/kz5pR/rdXBcVc+CdGCCBf+J9++TPqEZMqcyFroj0qLVmTP+/xVOJWIV6C7gU/sCSSvRIdtg/zzghbLCJEciSirMEClMuvMMvAKJxEQfDAFTn7rukBjQgu/6Ji1XcY6fbl9O7Jza/lyvP5XgmxkiJzHnPpgkVwG4V2lu/qYY5IUmff81d36vZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(5660300002)(8936002)(44832011)(83380400001)(26005)(6512007)(1076003)(6506007)(2616005)(38100700002)(186003)(8676002)(6666004)(41300700001)(6486002)(478600001)(86362001)(66476007)(316002)(66556008)(66946007)(36756003)(4326008)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2HZEtPhD1q16nKxjbNxCopL/LGdP6oIRlFs5INkAU0/Mq5HISWmyEFJQ8VZ?=
 =?us-ascii?Q?bCTl8KmhhhehThYWyogfKyXMAppHEEoepJIDVscvauWgNruUmydqVH0TBWWp?=
 =?us-ascii?Q?hStBVe74UU/OjIHSiArhQE+lDqfuRlEm1mA1bqXZMQiVqCS4pPumolK4qDfx?=
 =?us-ascii?Q?GYZyHBj73nOoat9n6Szh3Mgx4J4ibOOVmahwPriRRxwWNYW3g9r/mr8k4/lz?=
 =?us-ascii?Q?edoKR8nhgUf0x6zxiByLmZzWtXiIhuiS2fwP4VnkgR/OkKGvZI3WVw82KP7V?=
 =?us-ascii?Q?nV9zpvIsoOkKYiaDtHx6/dZyTFov8YTwk23nuxoBtE9G/txCY4MkhmLpPeeA?=
 =?us-ascii?Q?fT2+AgAWI2kZgWF8dQ6+kH+d5NMm0ANGVi2+wkGdduAu3I+csi9i8krfJJ0c?=
 =?us-ascii?Q?nfiNEUtfFAhrf/+WqIlpKf5eTuRKm71vtNnEaz3d1Hp1kQQ25KA+q8BpWlRW?=
 =?us-ascii?Q?EBgAcMGWm9LPZNek7895tBkzqCP/qDODVKx2TTem89hNBgCfEEopsnOutmSv?=
 =?us-ascii?Q?yPsO+iyptAY1rI2ybb7impHVShrGOpmccKxndXPQnCJpkZFCV78Jp5dzkxSB?=
 =?us-ascii?Q?wolrLhjzcObskD3AWhTT75tpTkeaPWPSlxnzhSFckE5mpdb9HrYLM4Xuwm11?=
 =?us-ascii?Q?sGmz4MR3xtPHlCZuGp3Wy8s5+7O0Lk8f0hhaUiT5gqlvp6I+7TbC3H1m7/yz?=
 =?us-ascii?Q?jwCMjb9fBcc+tJpOCvlinx8I27wPd/BBexRzLUo2ETX1dXTWrBmNk0jGBVps?=
 =?us-ascii?Q?VGlNnhglvpu8m+n8OUW9lBfh3I020HmfxPZ4nrUcJaz5HrFR+sUDac94BdEf?=
 =?us-ascii?Q?1jfVb9aHKHeQapz/z5VF0xnI8gqDGTuREJLb7+1h+3fJXo4XCxAcBmj9rwEY?=
 =?us-ascii?Q?U6i5gPhPFYIM6x+j6VKV+mI3d5HN2XlXd2+yP9YAwHH4p5lblkcKJmSnXKYe?=
 =?us-ascii?Q?/3qsAIvDO0bPCj3SzZ5quhxAtGzMFl/Vvp47cBTXbY0i5QORJfCAxg+lIsfP?=
 =?us-ascii?Q?ETxdP47yXS8e/Evnwrxa88RfxOavIP7SlmI43y4qhoWtm7G32IFD0Xj9nieV?=
 =?us-ascii?Q?aEc+8Vn782+dBFj4R12/GWZmXN89f1RdtED4nD2kFQUAS4bCw5NK2q+WVowC?=
 =?us-ascii?Q?2YBl67TeDrJXPJvmmzd8cvmhuRyUmnLMNShCKx2ni0J5j9s8y5z/af6Kt79Q?=
 =?us-ascii?Q?PUWiy2CZKHfTOX2MEk6AJdyot/87LJaqp5DNQLyK+j2YImYC8mFwCN3hk3nf?=
 =?us-ascii?Q?Klh+26/0dA8oDvwKD6ynlhNG2vbwnibJY2UIy9dt6mY1tPbLxcr0eJpla9Ai?=
 =?us-ascii?Q?Xh0ZuHWf/yFT/veUg2ahPsUDMsrDu/l7kdXcb0FuRh9sPu6acZTuHA/d6iMb?=
 =?us-ascii?Q?sHWf+CRGXtORqCAYBlULxDvY/1/CYyATc1CWqW9DIZ+tAhmYGb+dkjUkN+cq?=
 =?us-ascii?Q?kJ7rCUooC1FJD61PWU9cLg2PfgeDhrwEXQhCMsZFnzPFSHuN+vwGveA8cRXd?=
 =?us-ascii?Q?l0/fWaRkVeszSNRZ7jdWKbcdmTJvNetWpDa4dJ9FiEyHXG948IVBlVbe/PD1?=
 =?us-ascii?Q?dI9EH0gg04SQazuK46c8Fc1QCObNjUusOZ68dzJu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?e/vzlw4b5x9pi2xqPEJWZ/tNFdSAKDnPnakS44nLR3YvaJPoBDPSi1SydX++?=
 =?us-ascii?Q?g1YNtqq2vQD6kOO9KGMQKIoTqng+3RuJXbi6+aeRZJrEXY0TKUrbo729dDT/?=
 =?us-ascii?Q?c1SRWOTxAyaLZBdXXGnNWrCrtCOEZr8j4XC9mSsMxm8IBkBTvHnYu1Vf8lCE?=
 =?us-ascii?Q?mDGwhjf6uj6JG8SOFljijePqXl62OOpdJTuaOM8CGowtUcqPVVOzo/H+BeMd?=
 =?us-ascii?Q?9kMLiGlTevaAobLa2E/p3uCmCBib6K6uAj2Vb5un+2yZlBw2wbC3M7deCtiK?=
 =?us-ascii?Q?zktRCv9xoh2JPR9LlhQ7pcTmaslpOJvkAnZnTaksrkroy64z2xEanwHvP0ym?=
 =?us-ascii?Q?UCMvD/Y2D5Z0GgItJpfJqymKyzlxwfFCYhfypqU2r2c0wqD8w35x333pYp3x?=
 =?us-ascii?Q?SNEURdazOykwbowm59sCE1AuC+MceXdyG48KmvFhnkjkr2Q218y4vOFJ9diR?=
 =?us-ascii?Q?VqFWpCOCziOiNxKxoVKaOx8XAqM6iFAHSB8kRA+4mOUhxHI9je0JYbp+HK/d?=
 =?us-ascii?Q?NCHa6JwVvfsPsctdMsoOMaec5vUEfpFkPS3YXfTU2YiRFKkqwQTaZCO15JOO?=
 =?us-ascii?Q?xKMk48Pvr1AtBShT6SkDyFT/zDJvnIozXnGkXDvX914POqpP9TSq6TUF+8JV?=
 =?us-ascii?Q?fsiR8tmdiYOwabNDz8i+9ujX2GXV1hOvkOLWxltedhMCXIJzGr9810P96bTL?=
 =?us-ascii?Q?YQZV4LiGlxnnJ39klQqPTfl2ZcYIXlLSi71ACHzQZ5gs3AyOjNuZFQ1qNZrP?=
 =?us-ascii?Q?sEjhunZvcUaDYbBmdQz8+IWRUnKTu0GyzRtCCzhrSyhsTI0uWNDyYXhlqbNq?=
 =?us-ascii?Q?MeWDz4GtkAUQsMhIPz1q2dt/4h99vpTUcONnS+TYb5ySqSM3ZrKEfpKUl1Vs?=
 =?us-ascii?Q?oRpMfnlSRuM+FSy9oJ5QcwqLTnLNvF/bPgUv72ilDDDviwGSFmoOA+nxK8Zh?=
 =?us-ascii?Q?W44zh94H9isJXlo8R05Saxx+ElgKcctRq/JW3/pB5rk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c525c8-dc09-414b-02d8-08db56f21a4a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:16:42.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39PGTT8pTsZUhs2u0A53voVf9hipnrnRTqL0UNPgP8laoRrCLO4hFkhRDvbvyNAJZ+kq1GjsK51UK85hs2bmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=957
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170132
X-Proofpoint-GUID: sVVNSOqX_q6gjOUHavRZBMEX0Zu8JHVA
X-Proofpoint-ORIG-GUID: sVVNSOqX_q6gjOUHavRZBMEX0Zu8JHVA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages pinned in memory through extra refcounts can not be migrated.
Currently as isolate_migratepages_block() scans pages for
compaction, it skips any pinned anonymous pages. All non-migratable
pages should be skipped and not just the anonymous pinned pages.
This patch adds a check for extra refcounts on a page to determine
if the page can be migrated.  This was seen as a real issue on a
customer workload where a large number of pages were pinned by vfio
on the host and any attempts to allocate hugepages resulted in
significant amount of cpu time spent in either direct compaction or
in kcompactd scanning vfio pinned pages over and over again that can
not be migrated. 

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Suggested-by: Steve Sistare <steven.sistare@oracle.com>
---
v3:
	- Account for extra ref added by get_page_unless_zero() earlier
	  in isolate_migratepages_block() (Suggested by Huang, Ying)
	- Clean up computation of extra refs to be consistent 
	  (Suggested by Huang, Ying)

v2:
	- Update comments in the code (Suggested by Andrew)
	- Use PagePrivate() instead of page_has_private() (Suggested
	  by Matthew)
	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
	- Use page_ref_count() (Suggested by Matthew)
	- Rename is_pinned_page() to reflect its function more
	  accurately (Suggested by Matthew)

 mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5a9501e0ae01..f04c00981172 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	return too_many;
 }
 
+/*
+ * Check if this base page should be skipped from isolation because
+ * it has extra refcounts that will prevent it from being migrated.
+ * This function is called for regular pages only, and not
+ * for THP or hugetlbfs pages. This code is inspired by similar code
+ * in migrate_vma_check_page(), can_split_folio() and
+ * folio_migrate_mapping()
+ */
+static inline bool page_has_extra_refs(struct page *page)
+{
+	/* caller holds a ref already from get_page_unless_zero() */
+	unsigned long extra_refs = 1;
+
+	/* anonymous page can have extra ref from swap cache */
+	if (PageAnon(page))
+		extra_refs += PageSwapCache(page) ? 1 : 0;
+	else
+		extra_refs += 1 + PagePrivate(page);
+
+	/*
+	 * This is an admittedly racy check but good enough to determine
+	 * if a page is pinned and can not be migrated
+	 */
+	if ((page_ref_count(page) - extra_refs) > page_mapcount(page))
+		return true;
+	return false;
+}
+
 /**
  * isolate_migratepages_block() - isolate all migrate-able pages within
  *				  a single pageblock
@@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			goto isolate_fail;
 
 		/*
-		 * Migration will fail if an anonymous page is pinned in memory,
-		 * so avoid taking lru_lock and isolating it unnecessarily in an
-		 * admittedly racy check.
+		 * Migration will fail if a page has extra refcounts
+		 * preventing it from migrating, so avoid taking
+		 * lru_lock and isolating it unnecessarily
 		 */
 		mapping = page_mapping(page);
-		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
+		if (page_has_extra_refs(page))
 			goto isolate_fail_put;
 
 		/*
-- 
2.37.2

