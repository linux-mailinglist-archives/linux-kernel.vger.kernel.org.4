Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5EC6684F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjALVDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbjALVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576F4828D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJkHMd020386;
        Thu, 12 Jan 2023 20:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=b/N92ggOTVESy4PAPzARUeux3nxn5O9kMIfCDwqMIIU=;
 b=ljq+3vLRXrDEojJzJyeBmYnf1zumD+7fVERIaOzLmbndUeF9raCY2ZpJO7C2YaqBBcIH
 s1FSMOdQLe3PIInOePtWebSGRPfaRmoVN2GbAfFrbcRlMXqarvkzzzBm0eZyqvk19yJc
 daia6/T34w+1nx5fJx+x5xMRH+X4qmnmrz10el/GG4hRFyVSrxn0r8N6HAGiU93oVDe5
 B6wesc93b5C1A69y3h4XvZsWyumLjgBFK8v4j0tYs3pCscnzqjhRJ88B2ma3iRpN9WnL
 T1hk94hAbLNrvf20/+qmOXgq+4yiIQHIkv+TiE/WE9zklFWe/jg90Tc7ly3uOc6sj0Zd +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nkhc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CK1TT4034162;
        Thu, 12 Jan 2023 20:46:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4h0whb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk5/IN5KXqQmP9di7gZOLoEUtCtPCFgaiac4R9I5dkoEvcPwdGqmIX72W08oS+HEkSGu+YOvY+wJqEXvQGfR5t3iNyMy+so516t4uvFGVOV/wn9BFUkbmcM58yNMtJgXSuKCRa1O/c+svZadOjzRg3njs5olMVkYUos1vEm11KB+zZRZ2cKcAqmyWUuuvzlYaSAcoea/xloH1NbJ60fJe+Sm5ykDjxCofMoBQz29mQvQtCxY1uCA+plYNcA0Q5AiOXtH4Fq+uN0S4uu1QzYMViWltUrDqqLjoR2iwWpPx3crVR2uU35UwGJbBgLQZSOgnMnr/XIDB6DJC+xxBy2jUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/N92ggOTVESy4PAPzARUeux3nxn5O9kMIfCDwqMIIU=;
 b=lI8pPhXCLUyQbJ6C96MDvbPTk2Uo/sP8uPkBciY3ZxqNMgbdTHj84aalYCkvIa4hfjpyvIyL/pVRIuxp5V7Ocu8wHvgfYxqV/4ZlbccPfz2BW2xLvY6qmEKhTyfIe61Mq+GAO0E++JYPjYAmJKXIFQ8tS0YsY59Nfl/7pXzx8eM/68JEaF8bOV++qTxiHPiqIGI9mLPugZYjF8PsbF9LPoncJ5aOSGzBKxlAZBkR0u6UO7Wbbn6B0iwY+D2jq5AblqRAenA6+dqNDFr0F+MsRVS5uz7LMejVrwA5mRqgbFVgLRahkZaEaQUDTrrZcBcmGZs76I3tpf2HwamXU8OGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/N92ggOTVESy4PAPzARUeux3nxn5O9kMIfCDwqMIIU=;
 b=YtXTDONkDgcqyOjGSYZHvisAwWCEOjXLC9x56CjBAkrA7J4bfA3VHftfS0FP97ycpsej12b42Aew6DWdY9uoGjr0bwjmENT6cjNJNAeh4k7qWAy6sQWjD62L8mqNqYV7HAxwrig7S5LmqHmeHFDxFVORve4ZVhP7v3Li5r74DU8=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:26 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:26 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 4/8] mm/memory-failure: convert free_raw_hwp_pages() to folios
Date:   Thu, 12 Jan 2023 14:46:04 -0600
Message-Id: <20230112204608.80136-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f732dba-eca3-46ae-27e1-08daf4de1246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qK3wrl6vTo4mDujOGLwyNRxaQRMuA7JFtcMccYrBYCyTY2TFB+hXrf+eNiDZ2DMk4MbnpV2+aMnoSgElLw3geEjojkysXeagiygkmI8/il6ptdGca01r/Pb/VopzKTa8B3drPYOAd+ANw6bXZhdoGn2FSYWHE+dCQW7bKDL4bucCSrt39hY8uh00tgaAvQMeTeFkC6Zq06FdgmTMVl9gZBKmrX+bpql7VkvaCX+Q+mdaOqfIfNXY0FQMYir90IGb3SQtp80CBxIwKrl/nCBeIU6b28+D1U/Vj/YfItRhrKEebYj/+/2fTv8qddTU5ivD52NthoFi/fQTuI5aDFIc5a1+/qyYncXwv4GsNmHdbNGO6ryoAWmBVfvlhTIBcsVlu+FCO0n4mnCzqBVkHeQJWJUgm7w1320Z7/l40eePCtQfnz3jxJHtsa1845kkpzZ1vOaXU1ERK7NJSbGgSB+JKS+4ikGVCqaXFo0743/66rVRvOVgLVXnlYrF0+trQb5oqJOa8WX4JOOVImbZilJRW5I9kCv5FFqkMrnT1ufHazDbUkVRrD7vEhrppwFzpRSpYewGjczqZgRbbAVQDmpJe9ZmITdzQB4ZsYTdC75Aa78eeQCU3a9KJddS+PJbF19NwoaeKJYxASzuM4v3LQ7qoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9DKwdJ4XvFCc9ZfwwddG/ZJ077A3nrGL+lpnb5xHXE2dkeUBN7rwjYTaiitt?=
 =?us-ascii?Q?IsOwV2RFchPELPESiGsAYGyAi21ffjcNww7M0LzmV07UAIPPHlQUhYBydsWa?=
 =?us-ascii?Q?Amb6klBII17qfenM4v0oxU+9uAH9mwryrxQyisCLpOJcHH4MoIdAmeBhLeFV?=
 =?us-ascii?Q?CcfxIFFoTJWvPJPnw6tufqXxKFdEpLhUz8b+7Dfn9lpWEkT89zqtVwqLH27i?=
 =?us-ascii?Q?2LEtgF1JqXtq3lBvvD0nO0rn7u2hBsZ7SAy0Wk/tEGR0Oeri9TR9gw/Vyc9J?=
 =?us-ascii?Q?1WcRJfGErwqBrLoENkQTskX20Fpz+y4iWQKSn9kGLjKKqXzFUn3ZZsoiGh2b?=
 =?us-ascii?Q?JeSjn7RJ/rX5nWz0ONb8zlHazRwQgBL1Z156JJ4ltVNTSd2XgU4q7yNw/dYg?=
 =?us-ascii?Q?RUlQhXYXkATvQrC2H+Vc5oRLv9thYO1dbO7Rxvc7KaiyCfD7/70vIHa7vQcn?=
 =?us-ascii?Q?GvKhf5zjUNS92estOoiZC+EPkQ+E14acjYJ8JhZIEvbs/SUFOcyR4YIgXcM9?=
 =?us-ascii?Q?jhw/5kttuwXrv6Fm2r67s1MzLaxc1jDAMw4jwUxUjzPDCGU2J+Q3F1UGLcXg?=
 =?us-ascii?Q?wdCqOtzpmp1U2fcRbjvVlg4m62JQvA8MZ2wgerduJPHD1hfu6IRXB7MB/Z6w?=
 =?us-ascii?Q?oU0B5PO2euzbLwoIa+W3F/1VnnXebO5wIa9oxICICf0rrbzjNwCsTlTvjy0i?=
 =?us-ascii?Q?uoCNYezbcDrTR2A+cJ2qFlSw/Vw3tlYWMOcKWoNpnwqgFYQla+ozzXArbbkt?=
 =?us-ascii?Q?TDFDCo8+5aMqGVjltWDoIUVE75Xy0mMV5GDZfzc8y2gdzm4+qtAAywOxQNJT?=
 =?us-ascii?Q?AHkSnoURnA5C5nmuDXbXjGuCLE7vusBkeAhpJRb9CsDo2jl+FYrp2CaXsQvl?=
 =?us-ascii?Q?rPShfnNLSjwqHDAhUw/N4fK6AI2zl6djXMSJP7AnI2uouPTTvFnmm+zHZcJv?=
 =?us-ascii?Q?zse4k0uYVpKl/eA+4FYVyafsRO0s2YloPiQz4wtaRDkQ8qPtQzghrgiedd/5?=
 =?us-ascii?Q?krn/biqfeX/k/uRjoyKARmsfSlgPSegWhbKn26R60SOkngaAV/rHqaH5cU3y?=
 =?us-ascii?Q?d9iGdWpzIeT0AXyRnvsBM4DpVAh4qL0JoQ57hXh7CT3JYKuR1d0lA22tj/To?=
 =?us-ascii?Q?K4PsyHEMWXu7k/O+oxAB1GwdWIcVEuPCRd1PLctGiEkKaQcazsvxdnGI0IfB?=
 =?us-ascii?Q?iNB2Od7fwkt5b+Ex2QduiAET/Wx1V8Y0iStzuiz34/2l3vrEXhdY2vTiQZ3s?=
 =?us-ascii?Q?ucTTvBfXi/j0drVnyewDxN8GPUesW9+DBpLhn1hUQQXEGDu+rRPqNflNuWVW?=
 =?us-ascii?Q?2nYd4IUmiduZoQd/hWoGYMk2mBWTOKc4H26s/Hcqfw5bsulaIxKEDOqbc6Dh?=
 =?us-ascii?Q?eUY20ddsdx66YXPulYfJrHjg/Ypm2xECN9WaSbgoaXpDYjnOU23vwJgcJtLa?=
 =?us-ascii?Q?ypuYdcT6gk2/D3IYsU1JQmESxK1XK0arMuZ5tuNxtm4H+KxYg/Nfy51sAbn1?=
 =?us-ascii?Q?VjTn4k7MOcG80S3fdHOc+GiwJyNierQ5T3MPoJD6avMLJouukzn9uHxCo2ND?=
 =?us-ascii?Q?m7PX3fVriBu+/Q6eMo7rGGGA+Vf/LMXQ/qrwXO9ysUHyqE9ip7qMHxywDdtp?=
 =?us-ascii?Q?Gj8UzsLmORj9FFVUodKY1Bg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HZku0l0JRcKKuqTEpkOMguqs8pt1zrJUumElap0G7tYXJTnM5W5cUgvLLJyr?=
 =?us-ascii?Q?YhoVmNWj017mUfFQufPXEGNtNYPiazsU8KgEcmHajQOMY7hjB6ST6SR/8zSb?=
 =?us-ascii?Q?DYuivxeKcJeu6hwFTIavg3M8+SiHqp9LRbOSed6bBJgPPjq86n4Bsh9QGq08?=
 =?us-ascii?Q?uoPZc/Pq6kyZ4xcGIeGY0AKleQaB5RaEyjp0rThlJx/dCx9YG8JA4TvJG0mQ?=
 =?us-ascii?Q?0kS+v8nVMWkiFGxgnfcCDwhVwqsiCpYu1l4V6DDPR2MPRL0SJ66dU8A/vAL9?=
 =?us-ascii?Q?YzaRtfaCv47eyfnjwYk3lI4WGPU+k++TMShwg9OE+9XRPHS2jHUV8kaMyPtz?=
 =?us-ascii?Q?jo7f8WmihyfmYyYeSq8bG0nWHUQm5+q6KFZ/gYw2Th+VoSdaSnAmtdt+aEyX?=
 =?us-ascii?Q?8q23wMx0kNB5fZdxszEiSv76nxWVtcP+gdGUQH2hMnuExjwIXaKSPi6f+FXh?=
 =?us-ascii?Q?hf56kIFT9AAptcg37tek/76fu9AjEX/hUwfRii6YZ4xwWU8skfqyR+j1XX4t?=
 =?us-ascii?Q?SJFVHRgWP1jwkoQerNm57SLQJPeNnu6cQLSb/Q78FYatqtAlEw22D9OLyWee?=
 =?us-ascii?Q?MTVqJuTNMYkgq504IQohYTBu8xKY6fF7HfngbQ4MSPAlXdHyAcOQ9DcTCB5S?=
 =?us-ascii?Q?ZppHjou6ejsPeyk1Du6i7FoU7zCbcwJyLU6dI4/+Cb5z3TCSvCCdtGYUfQMC?=
 =?us-ascii?Q?5b6yl07nXMO0uf6LZe/cRus9SDK6ntwngVApZb6mn7FjWOywNp2JsbLHfMM+?=
 =?us-ascii?Q?w8dRjzzlqQgx0JSym/rq/rCiMCjBK980wYLrrSG92tKT1/1lMXkcoZtFa712?=
 =?us-ascii?Q?JecLBBuY1YpV1VJhGNhZItzWPErOj9gJcUFlYUj3vNxEerPTw6g5uIR+8Rp0?=
 =?us-ascii?Q?Qneop+7ME0yy4IDWVhCgddK4qDvgLLEJ0IXfq2Xr++qXvkI8b/VHypbWGe3H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f732dba-eca3-46ae-27e1-08daf4de1246
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:25.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUF7txgrpUeYBdpNrQWBzrnp2h3BnL4tKwT1P/fxnIdDyFjz2EYAerLso+VmXG2aH5P95DLndyLloSKcxYAs1tMgeWkZ49CX2dOwkE/zogs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: Sarck6fyytDvRWeuTYgSH43y6OwR2b8e
X-Proofpoint-ORIG-GUID: Sarck6fyytDvRWeuTYgSH43y6OwR2b8e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change free_raw_hwp_pages() to folio_free_raw_hwp(), converts two users
of hugetlb specific page macro users to their folio equivalents.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 205272c64f37..d5c828328e32 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1766,23 +1766,23 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
 	return ret;
 }
 
-static unsigned long free_raw_hwp_pages(struct page *hpage, bool move_flag)
+static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
 	/*
-	 * HPageVmemmapOptimized hugepages can't be freed because struct
+	 * hugetlb_vmemmap_optimized hugepages can't be freed because struct
 	 * pages for tail pages are required but they don't exist.
 	 */
-	if (move_flag && HPageVmemmapOptimized(hpage))
+	if (move_flag && folio_test_hugetlb_vmemmap_optimized(folio))
 		return 0;
 
 	/*
-	 * HPageRawHwpUnreliable hugepages shouldn't be unpoisoned by
+	 * hugetlb_raw_hwp_unreliable hugepages shouldn't be unpoisoned by
 	 * definition.
 	 */
-	if (HPageRawHwpUnreliable(hpage))
+	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return 0;
 
-	return __free_raw_hwp_pages(hpage, move_flag);
+	return __free_raw_hwp_pages(&folio->page, move_flag);
 }
 
 void folio_clear_hugetlb_hwpoison(struct folio *folio)
@@ -1790,7 +1790,7 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return;
 	folio_clear_hwpoison(folio);
-	free_raw_hwp_pages(&folio->page, true);
+	folio_free_raw_hwp(folio, true);
 }
 
 /*
@@ -1929,7 +1929,7 @@ static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *
 	return 0;
 }
 
-static inline unsigned long free_raw_hwp_pages(struct page *hpage, bool flag)
+static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
 {
 	return 0;
 }
@@ -2336,6 +2336,7 @@ core_initcall(memory_failure_init);
 int unpoison_memory(unsigned long pfn)
 {
 	struct page *page;
+	struct folio *folio;
 	struct page *p;
 	int ret = -EBUSY;
 	unsigned long count = 1;
@@ -2348,6 +2349,7 @@ int unpoison_memory(unsigned long pfn)
 
 	p = pfn_to_page(pfn);
 	page = compound_head(p);
+	folio = page_folio(p);
 
 	mutex_lock(&mf_mutex);
 
@@ -2389,7 +2391,7 @@ int unpoison_memory(unsigned long pfn)
 	if (!ret) {
 		if (PageHuge(p)) {
 			huge = true;
-			count = free_raw_hwp_pages(page, false);
+			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
 				ret = -EBUSY;
 				goto unlock_mutex;
@@ -2405,7 +2407,7 @@ int unpoison_memory(unsigned long pfn)
 	} else {
 		if (PageHuge(p)) {
 			huge = true;
-			count = free_raw_hwp_pages(page, false);
+			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
 				ret = -EBUSY;
 				put_page(page);
-- 
2.39.0

