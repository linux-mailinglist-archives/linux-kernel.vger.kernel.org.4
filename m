Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B46E17F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDMXPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjDMXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:15:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F2E7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:15:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DLf2w6006517;
        Thu, 13 Apr 2023 23:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=i6Rxw7iIk0J/BNeOkIYTtnUfRW44qfOmHGQyWjvMfk4=;
 b=aLwSS6dEKw7VsVMpI1gDHveksUFC98FH27M2+BYm/eX/KtP+3uTUpsjoHNxbtPyKk1GR
 xtFHNnAZt2lHtisuV+txiRPMGu+XoIROUS9txCWx3YXrCm3wznF4CBQBpFs0y9eqG0f3
 aLSaCItlXWbhYqSADLrPZf4VT9IPePLGv9daBMCrWooZhMZ0pQg58XisfZYkwTLu6u3W
 BuxPJGxZ4PlEadoLP91wzyAz5a0c+PIryiY+OWIkCSxEQCNw/wt+DbMYFbC9J0yv8Ng/
 5d3WWTuPCNFgaPVkCHZD8GasbCFd4xMJsBzseHnMZCnwuHSL6CrE3mXrB9AnEgyynOEp eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hcct74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:14:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DL4bgN013123;
        Thu, 13 Apr 2023 23:14:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw95ffh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hbv51cRzgxmRktH2vz9Bo9fJy8kGWycJBBCs9SEoTa4Mst6okMB4lFzQuVIaIVq6T2UpMjlGZWG57a/KzoX3mSZQcCHlQ3y+ZJOIFkmI8/pLiwIRq4Lnz3mVbGWbqU7RMGDV34vxV4y2b2WAPcpzKLy0M+6chpvQ1UyQO0k1OeUZmpjTvXeGNfompCLnkVl5Gb0dsb5SXi6V0akzCEnJnCUQ+ZwHa1+G0g39bzamu/XjzU3pRFQLDt/cGEx68UVttWJQ98c6QUc9bpOcridZVQ4W+fJ9EvSbiEyFudLTWF1WHwIzgawE89rKa4Sa6fv29gwBJPnMw8Wzng+mF/Da2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6Rxw7iIk0J/BNeOkIYTtnUfRW44qfOmHGQyWjvMfk4=;
 b=kE+mggcVrjv31D4XphigbTTb0PNJlSEyf7tFvCC0zxv652QfjAY8S+hcAkUhzjPVUgGE0uDSlyXvMdrhzsry24zo133wAjJ9BtFWJF2Avqq9HfScpDvkR99gjQGyrOsLowy4tVSP/dtjAABQ04Oy3urhyDa2J0d/oRvHVZhcxoJpnodszKQG2pldvYL/Ts9qn/MBhhzTs2mKvLgyXsryIF18HeuQN34jwYit8m8TBSa8ABxUG5qVzkN9T12XCp1KGK+scglpHdmCRLYvE54JhB4jcx+C70Dn9s5TwgRwWrHOHpKUuXShgWKSrubK6CBK4XjSSXvMZhp4WFIfiO6ywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6Rxw7iIk0J/BNeOkIYTtnUfRW44qfOmHGQyWjvMfk4=;
 b=f3CObmAKqtx9D7pO/CvOJCpxwRj+uTrLbew2pa9vQxyWLwakLytJTXWsbL3nZzylcWSzzXUAW9PM7HT4JfMWcwMsothlGagUtzKEpu77fKVzXW9zFVvNNVUvPeG/z29Qj4Aq5ADC4i5mg4YdpqDdPGy70BNSqKVGshBTwAxyeVA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ2PR10MB7058.namprd10.prod.outlook.com (2603:10b6:a03:4c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Thu, 13 Apr
 2023 23:14:57 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 23:14:57 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 0/4] change ->index to PAGE_SIZE for hugetlb pages
Date:   Thu, 13 Apr 2023 16:14:48 -0700
Message-Id: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ2PR10MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fd6791-fa4b-4e99-2ca6-08db3c74e590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItVQXUua0hz3zeemh2vA6KmxvA7DIE1fQkjj1yphI1H7SwgZGSAl1gzpiUp/siCvEPbmn3HaG0Hl6s3wL+L1Q5rHDpGtwEPdhbgFeoXyd3BG2emsyPDdfN9iAqudidpND3rzV5ShpMRSI7R3CP1EBSf+64EB0yJFZMYHTh+ubTzW20ysM/Dk6moFVq8IaAyS+11/eN/x2AEl4VKDY3mH1n/7HI10mxvDRMpGFRhacgAvW82e6yZOYbb1hD3BKTQrWvCCtpjQ9qoBLBfWrFJ6drm4HyPkzRHb8xTBgerfQ06jI6HpiM1eYZ4qbiNxVPLcohfvWl6C61y5bqR1w2Qu1Ff1sqldP6maVGxC40lcVBqFkOqueDx0DudTsxKeZn7MiBsUCA65wcJeLD3CQ+Ej2UuH1hhTHZ/l3UlQOmeYp0A7mXXHoWn1lRKR2AUNbU6VqxKSYprANgreVx6MScxJqB5Hj6RAuRYAZNluzIM95wAxZeGze8BjozAYqeO+ZQPlIcmh7X1hbnnAV4Aki17zkoD70wDFKkA9xjj84c9XHzknc98EwNUoGe7ygrFyj+Dq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(83380400001)(2616005)(6512007)(6666004)(1076003)(478600001)(6506007)(107886003)(6486002)(186003)(44832011)(36756003)(38100700002)(5660300002)(4326008)(66556008)(66946007)(66476007)(8676002)(316002)(86362001)(41300700001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TdgrKNTrpnVbKV4E6IASNF4HqfbeMNagk6O27oeFNS9YoUgJlz3APQDX2t0B?=
 =?us-ascii?Q?4D2vTJym+uMBUTRJIRCX3ArgMKjxUgDfDznfqOHSCtC8H0qdWE5QduTSL1nM?=
 =?us-ascii?Q?AMToa1EVJCWZm94J05Z97NXc9K327dpW+b8NPALIZxqL2Fqn5qkCLZ0SXJLV?=
 =?us-ascii?Q?T04duI4qH6ajTPJ2OTtr4Is51VjbRcOUER8/MaypC1x0wKAdHiBzSl4kGO3E?=
 =?us-ascii?Q?jWiryIFeNYYo9fFCe2bJjUiuTqXaM0ObFyWnLn/rCxLwoRwzKV6g4pbF5INB?=
 =?us-ascii?Q?otNVJ/BPBRymkXD5H0oXAF4wyrWdDm/Rdq96QdZVpCZ0bX78tCNruivaCqYG?=
 =?us-ascii?Q?UfhJi4ytMauOCd4wdJ+uxl/Iv/w+MOrwALpthj0puAHeZ/yZdjcfrCuZVyRU?=
 =?us-ascii?Q?eD9YvNkLRFua1EiwS0+JQZ+t91JUJ3bm3CDhkgEPntyr0gg9VQ/lEEdqsLf1?=
 =?us-ascii?Q?//Ehx2US/iBnav5u0xqQjLoFZI+KZhohTwMQxQu0QyMt8yjWmT+NiQmenkTM?=
 =?us-ascii?Q?O82dCX8C1MBEd3sJAy4Xp3xqo1dbNIuzZZDcKhEJfLbXuD2G21Wa0AC61yDX?=
 =?us-ascii?Q?aCxHxCUTPyha9PrmZmPK982pzhXDM+GR8jvYfJq02TX0R8JpGwx778zcYcYV?=
 =?us-ascii?Q?bBqJ9qWz9CyaZpnkw/Ikk9D/j1XifN5GoNyJbfMhth0lmDrNOQO+lG5GtP80?=
 =?us-ascii?Q?X0l9hpn40Bmna+chDWs8a8yjR3YxBDVXC2hxTLB7hS++MAMKHFvOWlOowrww?=
 =?us-ascii?Q?lM8KW3BcWW2KHQ4PqqpGi9ZYPdcipPP+FzmhgOYFLvduvsaL6sX/C0hzvP/S?=
 =?us-ascii?Q?dNT1qkjQR2kG/Wl83mGZhl0IuISCRV9rh3pGDrXlR8VgUj0ad5G3I5RYC4hz?=
 =?us-ascii?Q?GoODphYPsz2I3fgKDoXqNpBgEu1tRHBTEG530vSX8BbLoEVJxsVodUGBhoS0?=
 =?us-ascii?Q?8jVErmfa2YPyd8xZhevrcY6ql0WVVIaQFGWXWkieX+7cAE1naY3lExDSGjuh?=
 =?us-ascii?Q?KSeHbTl4Igl8KUXYdiULYlAmhlI6jrkvjybnchXraBo0M53GKwjJzeU/49KE?=
 =?us-ascii?Q?l0dfSqiXcmvfW/T9+afIHdTd4yt6V0qnjTXBmFkiBk/+/SO+eNi0Jbgo7u8E?=
 =?us-ascii?Q?ddCQ9sky3SKQpftaDbfttp9/5b8lQb6v9QSe7D/tdRn2/WeYlq914DUrL7Ei?=
 =?us-ascii?Q?QE7zGYk4kVluZ3UK1mEnSaqYBgPqwLc59Gt2dNb7HJwlS6Mbi172WeruNQ4E?=
 =?us-ascii?Q?GKq1nO+Sz9uBb8mHvX3zCCK9ee/T78OarMp/W2S1ii7ONiiUg7u9WjL1Pvlg?=
 =?us-ascii?Q?A+8N6W1jaEd5SVECjhidptCJt52f7TIiNdF4ZpLzzh5NSeFvdeFvsxujlrSa?=
 =?us-ascii?Q?9ZWDMrA/vEEa9dHKsWWy8/ejgy5//7GKlZSL+y4Z1ky/VNCPQBV4DHhthmDz?=
 =?us-ascii?Q?kOPSnTQG1yqYE+fFshyrr+nDsweSMzcUxccFfmVOsXjig64k+h3MeQ5pzsY4?=
 =?us-ascii?Q?t6k6HlXn+pTJrbawRI5/eZoeb227IVK/gjyAY8r8oY8XWlOf3eoH3sE4S1f+?=
 =?us-ascii?Q?XWdx/PZDH1f+KnP/2PUwiyFmTHptORvM3dLJkBm5IPPIE5si5icdQIpNZqIY?=
 =?us-ascii?Q?IM1kc3iZjCN0hlg4b29uAZg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lccaK+n21MTLCeRCGN/CA9TaxuNaO2H8S8mouqTjD/65KhiGmreAfY1oxnSuH2FnSNEyTKVGo1BppsOTHT5JFfvQ1aWxU+Vqs9YvpQgP2zrx0N3aZoHap779AIhngu2JLNU8Eod5mZHg69WhmQRfkCD9dGPDGn6ErgKJ3n5plEyvKejtbCruW8C6E+40t0JuyPBVhCal4fzAvrFa0oWl06+EqAzZD8zN1bh3llgO8JC9vXLgyoLpoA0hrACy5vwr5JOsO8OQ1gZuyZx1Fze7VT6qHVhWxNrw9iTslUW/p9Qlvx2EhdeXaQAI5fjLBqQDMobU+rdsfKnXyHKsgy/+7naW3hRbfYNBtP+g7OGQilnAQ0+ABHdqE4dK1FOaJOFRZksWSsThkA2TgevoZpZ0ziaJnQxROwhivyjdTdQMWMe8nF0uE71PC6C8JQ+jGbocaGIa2ylucoSGhXmJN1ExPkWo+/IrnXQUP5kswxil8N3Ii7akRRxINdd70kI8uiyBNsO1bn6nuqiirlS2Ly/BlknHu5UTQqgRetV5G+Wi/WSldgeN6ThpVdlY6ADt4nO0qgVZTl5SBtxlGWdJ1NEPlapeVc4zfZtc99cQhi5g3HWkx98bofjQd1eNHSTQYxsgvZfWMrZoGerrSmLEiRq5uiRgQevCMqjpyaBzkx7gihCIhWzK+y8wUFwb/l6pIS7pr1UufJF4rYCf816iXtdm3UJVgfjLPEN0ky0vR/rKDeAFk9S8tlXebr/cvX7J9uPjsWr5YuL0jp2JnI7+ICwoNaK7MWZTa8wv5r/hgfUG/ySCDwN8NZeWgtMoG52kY2zffGgYD9h3VvxUFL/OYWOJ5qY+pi6DpPAbOBYSqSeKxFQeDZAdwuxJs4FIn43F6o70NMT6MUEO5em7pYAisIDhpyEhL6NBYAzfTHmprddwYCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fd6791-fa4b-4e99-2ca6-08db3c74e590
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 23:14:57.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XLzHZVC0iEHweYE47XqljKqZqTqAEkaVOj4/QA/LcXrieTlmtgyA5sjqTkLzVDGgt/6TBSLNoAWHzMfkl7TxZUO+9LVkqB+6UI5MqZQpBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130207
X-Proofpoint-GUID: oHCLgvQLJ1N5evcdA-f8YuZd_dBNqYni
X-Proofpoint-ORIG-GUID: oHCLgvQLJ1N5evcdA-f8YuZd_dBNqYni
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch series attempts to simplify the page cache code by removing
special casing code for hugetlb pages. Normal pages in the page cache are
indexed by PAGE_SIZE while hugetlb pages are indexed by their huge page
size. This was previously tried but the xarray was not performant enough
for the changes.

This series fails many of the hugetlb LTP test cases due to bugs in
accounting and I was hoping to get help/suggestions about why the page
accounting breaks from my changes. The basic mmap tests pass but the
advanced ones which involve overcommiting pages fail.

rebased on mm-unstable 4/13/2023

Sidhartha Kumar (4):
  mm/filemap: remove hugetlb special casing in filemap.c
  mm/hugetlb: remove hugetlb_basepage_index()
  mm/hugetlbfs: remove huge_page_shift in hugetlbfs_file_mmap
  mm/hugetlb: add hpage_shift to alloc_hugetlb_folio

 fs/hugetlbfs/inode.c    |  4 +--
 include/linux/pagemap.h | 13 --------
 mm/filemap.c            | 36 +++++++---------------
 mm/hugetlb.c            | 68 ++++++++++++-----------------------------
 4 files changed, 33 insertions(+), 88 deletions(-)

-- 
2.39.2

