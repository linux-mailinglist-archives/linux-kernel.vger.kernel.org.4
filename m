Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBDB6F88C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjEESmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjEESmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:42:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2017EF9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:42:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhKn3002999;
        Fri, 5 May 2023 17:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3J4pneHi36iA5e8D1W6Sbr1hFtHWPs0j8jYZRtGOe7s=;
 b=UlTnh84uRBjQOVFW3mKagKHbizZx00GFxhBHt+l2z1t240jj4Utl2i9PJqA11eIbujNO
 JHSvT7WoNhBHiTMq+daqPxxYs3oYhQptdExaaFKXCupgZAngfpQMrU7xgZqSid5mU8xn
 OP9t0fSDsiI5KNGPORdAKsw55yKTARaDsXGJ80H10YH1x12nch5WNED1PoZIPTgs/2kS
 1SfARZyLedwMHh2mWkKzRsGsFLCtgwW0kqkgbs8rWzxMOgneEd86cTNmhf/O/ANToJJY
 ruzX1jJGRRedVn/1UCIPE6glswoj6cC7zJDqZ6f5uYOxRotk28wK+sBo81w+iI3KG5dg Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgdkde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345H0e5C027533;
        Fri, 5 May 2023 17:44:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgetkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBV83DcrWD8RIwXJbAUMpCdnv/qGABm/4+xYkyveCm6oFe5wkfoR4ExCAF8UN60gpyEw+0UmSIhyPX468tV3jrJTmEIZ7ZD3xqQPxO5sPUdXIS3o6SLGZMBJf6Y1/DwyBYv3qytdMDLFl7+KiUplWZPx6ZGUaUfuZ5Kly4SqRgRCmjAkifx4ptfHWdJLXzFatYLDvr3j1zh9X/1RZIe7JtwIyeebTLJo+eAjRvFFLQzeYv12MkIOWpLBU5/VKa5PmP1gGyIIOhNZhR9Xzau4MgLE12IvMX8jjmCATVhWIdZ+HnsUeC1Ymi8QT13IIpFi0NBo2u9D3Efb9F4rfAv7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J4pneHi36iA5e8D1W6Sbr1hFtHWPs0j8jYZRtGOe7s=;
 b=ZCsCPmlx7ZLSX+m4a1TRPTnukcJZis/68qRtsPx/r46ldRe7g2iMRZOYBDZoA0h+OkGE7z2JHtWc5w6LJKC8bwPsB9VdogAEercgKe4XAkFgwndudb+6gHS4fYquxWEsbVWZwJFzdo9AC677RG/Dii9Mx2g55dOtSLz+0p/sbINOISRu2pjAXn2BpWQWuZu5zpwLdAknCjEwW/rK9xOXtaXzvxJsBX6061WIURYuMNI0hqZmW9UD0lXoQiQdQLdmnfObQlYemZLgz0/0qMWylXBsbi+mKUe0sd7OqUrJki89ZkS9TMyDganjRuuWLk+b01g9yYmPPQ3Vnhejyy25qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J4pneHi36iA5e8D1W6Sbr1hFtHWPs0j8jYZRtGOe7s=;
 b=KOQgVsqE2mtu9kjc9Yzv5sMupawSOSOv30FDGcX/oMtXRttwenkNcAk0O4KRsEOzXlSNCkRoNR/P+zsijuzf3rA21a6fB7ECQeLqIytsw4Zz2CRxbJGgXXWPTT7UpyOx3lpxEKXw7mA1ugsbBc0a88yPG5AOuUjv7MWec7fPLDE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:32 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 21/36] maple_tree: mas_start() reset depth on dead node
Date:   Fri,  5 May 2023 13:41:49 -0400
Message-Id: <20230505174204.2665599-22-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0213.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb1f474-2832-4283-f13e-08db4d906263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxFfq2MxGmQPBTkApwxoF052atfnoYYT+uvrX5ZiXyERd1yBye3z9SXB9ZiIpWdNUGqp/yB0kOlQUgzPxhywUiyEMv9JzRvyqMc5oI0ruC7k/dkN86t14DKR5So8lfPJ1AW7GiZEz5xXjoBdrd97tdz+Kw/c79j0ewdfLsowta59O6fEZRi4QvGZiscXY+5NwxCJ+zz23p/QBay3kvUtweNiq6WHSAqj9550fInuGYZRH2K+bWP3LaIt5BPVTtwK3APHKYN/AMii5iT/1QrBjCv3spI3MNrBSHc81uz9Q7Fjg5Kp94ucWXpShW/hhJdA3ur7O95GofChx3dnuHhI4ZgaK4ZUyV9zhkaht5OF6z8LTTZUnw02MmRnzFX5W/Va8wJ3w54Ovklh12U4wTL9pFjCM/JbuvleYLEzaDYSAo676NNTKM9AnetyeIv/QgMEDo6czAsv5yZuv1bp6KY65vT/eWC0QgeCT80ufH7vlqmOIz96fbUFTsJ0amMaD6jQRNvnvrRMgmfaP3hFYIbR8/HHJamQe/pK3H7yP3ABZh1f9M17yZ+Cdu48jzqZz+sC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(54906003)(316002)(478600001)(6666004)(6486002)(2906002)(4744005)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTaainM5KLzYiNIfrPxhAhCem6Fw/AAgAmwPUezIH0E/4Te8olW0lpOtYQzR?=
 =?us-ascii?Q?xtPO7Cxu/XjsaW6K+6jCzxnoFnxx15rqpUwGZhRJ1CSxoINzLEJaoPUDObqN?=
 =?us-ascii?Q?iTU3JJrMmUccsGyJhi19pPl0a5qnGoVGgEHn81iWB10s3r3kYUL4LTUG2qWd?=
 =?us-ascii?Q?/sI97IsYpsatdl3yrvUd7lWnDznx2RbJlo4jnlqZqagNxltrvWKn3C/MWO8U?=
 =?us-ascii?Q?6wfcPqCY/NxZFBIOpJzuQZblft2WrqBMztodEkWvLh64pFa8loCLdVQGM1Do?=
 =?us-ascii?Q?wAYJ63hkIXScFeeL8WMPZjW/J5zHBH8faLMOcfNaAm3J/9sFf7ANGc47St/m?=
 =?us-ascii?Q?8RtJXwit8Gcd5+Xcwa2v3OLPsFNkOyIpbXCgZbLHQiLvvGghfNKdu1pA6a/p?=
 =?us-ascii?Q?CUkhg3xrL5AbtyDib6m+FzGGAlT1x2H47VDPtKIbFOOK4uI4w8rbDp/wZEM+?=
 =?us-ascii?Q?iIHTMTTUIMTZJkx3RcnCzmIRqoCZVM9HlV0O8Ku0WsUyA2rUkMLS/l20uBKV?=
 =?us-ascii?Q?+BA+k5Eb6jy6OEBToV27O4N5CLC5chbld+asjKHB4mEnbgety4Qll1Z83NLj?=
 =?us-ascii?Q?dROFgXDT/V0PWCvZ9J2OeGG+nFVo2ccQaQvrzUy9mzUCBuEiFpYOB33ugsN5?=
 =?us-ascii?Q?Fl6nnpXTBUcB2RqnbcdHTl61X9fK2TDz5QHjpgqxnVH4C4Vuo3aeTkT93whZ?=
 =?us-ascii?Q?7tG1LjyBkfIRuFZ5Q0Tuc6iArtnun4yfQfzDR44pEvf9cuSFNKNEYdFMbC6i?=
 =?us-ascii?Q?v4/J6o2nhbom5O2JQOem3Own8XCD49e6w/hdoW38n2Haeys9LB/146tFFvNn?=
 =?us-ascii?Q?zxFiFnzpc6Xw0cKVr6tsJCNmRamh0EOEZrtboHqW/FM1DZ5MtzensB//D3AN?=
 =?us-ascii?Q?SkmJ5sLIpjxjrPPDkfXCpw0pQ1BMQxWohnMxuXvWnelZmbCEEHT2zEswRlC5?=
 =?us-ascii?Q?9wxJuG3eU107spzWVorbDMF/qGZRuBUUJTWi/X0hpHXc2/QX07MA5sdsUa4f?=
 =?us-ascii?Q?k6KtpkUGuzsACZt4RYQ2AN2KW4EwcVmgK/K5zQk0pbjUV2RBN14OWgzJDM/X?=
 =?us-ascii?Q?a0lo4YfKvqw6sX70gh4pc/Yyxk093wY5MWf+BezvZqyAK6zueE7xi1M6tcMS?=
 =?us-ascii?Q?96Kd9+kMjwAcgiT4KFcChvdrF1iZ4MkGEySpxws4ncZ3ya37/2LDUUn4TFui?=
 =?us-ascii?Q?DfYREA5vyZzNMdKMv1wQU7BXgGvBgGCG8k5bBlX8L7HhUPzOWAEvWRgbWM8C?=
 =?us-ascii?Q?cjDclyV7J/MXqdlFAAygbRdgRf9NvAYwNMJzsXi79OcaGFO3QZysLIWFlc6o?=
 =?us-ascii?Q?JIPoZOEGzu8/3NhFuqTzD7jVQQqO9/LMtl694O7zI62/eehE9qmEgsLVacnf?=
 =?us-ascii?Q?2dYAcvN/4WxnIeydZcGuAWjIMuFlcb1Ft4V6ZpVWixcgobtGNGav3oFjl5bY?=
 =?us-ascii?Q?5cfkh746NgSBQ0gS1kGn8JeabQBv3ZArUpRl7Zl4KX936axaDuAWsNNY3hLK?=
 =?us-ascii?Q?o46eZMNJaBjOgG4tTFJki+O3Wcd8e+u9q4qI8VnSTrkvSO4OE71N0HHIc7UD?=
 =?us-ascii?Q?dHgYZkjfYloRfwct8RTO/77bF8j7dph/zGISMb9QWKAIXdYydwr3crJGh/Ry?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kZPMehUcCTL+Z8VTbGTalgSjfs3Tn36Q3bKNMAUDWycj6n+osZcB/EYedTCP?=
 =?us-ascii?Q?srz354ZL6xKh5rfJhsXLUkJtC8vKHlRSABEvQs+VJfn4wU1ZoZeQ6bVhWXCs?=
 =?us-ascii?Q?EOgKhHwsve8kdbVuTMEhpRCqLpmzXNdh4/H44v7BPmYtwJcJA2irsyqPuYA/?=
 =?us-ascii?Q?PgEQbM35en+ZVA7p9YwrTQh11tN9W6r8PF97MyYKys+PvqZIZh656md5cfAg?=
 =?us-ascii?Q?SZ/cMHwz6XFuJkoqL1Rj/uiVZjjwKoyPCqXT6ri63bmbGiw4O8+ewTKmwa+S?=
 =?us-ascii?Q?jAD++bJFdiJkTcnSbHLWtKHuPhj2Af33Cz9Ti7w5iXOuZ4H90Bl9fR2E4Pe0?=
 =?us-ascii?Q?es7g7J5jwDD3mAAB/VrauiZvfavIPPJz/tjXV0/d6gLdIad5Q6Pu7hc7nNvT?=
 =?us-ascii?Q?/rIHs43vu+u+jRgMAR/y2eCTeQjPRPpTEgrkHZjVEsl0qzPUq1YKSv/w61y1?=
 =?us-ascii?Q?Fjr4n3dkzkoARVpkyJ8GUWA8BQIysNwSMWaHFI815sllz30uFpLoXgEs3QwN?=
 =?us-ascii?Q?MozfvHyaYFlj9AO1OxAvWImafQG/zMcwoMVvLyusiLaNg+Zz3EMA24szNB4E?=
 =?us-ascii?Q?GMgcoIZcTDSnvxKhGQ5VGNn+luJqTG24y2WM1vIrGoTzXggd+cbllvkJglM6?=
 =?us-ascii?Q?ZSDhrjS7ZZ4ABxf9MpTyHJywZ8Kq/he21zbVN3d18eLnxlNc5GT4Xr7yQ2WE?=
 =?us-ascii?Q?8r6+btxLAOeCt0ZrSIA8d702aeDTu+Tx1Wl5InBycIQUpiFTqZDbZcY0my2o?=
 =?us-ascii?Q?m1Y1co5qvsmm1pBiDvIfZUaUYNjm5hMvBRyWsmdpPXsO5QjxVwUAlWgn4fNI?=
 =?us-ascii?Q?V+aLaScioWCmfRhag3NqJvANiVV5KaimfZuz+Qu5iwQ0P66DRmweXH6qNXL1?=
 =?us-ascii?Q?57O8WErwsb5lXYeWlTSzPHvtLqzzcs8ADTsMDITmNtomjIpl3kY1mMcYt2bC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb1f474-2832-4283-f13e-08db4d906263
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:32.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LLzzCBbtGD8d8LITEh2kOrPBgk2EzhC+Zzpsw5K2yeyXbBMEnhDpDA74Cmoca7nTW3DSb4EO+eFxDB2nI5vPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: EQPxJIyXCQXaDzm9SAh1VwGjPvijKGRV
X-Proofpoint-ORIG-GUID: EQPxJIyXCQXaDzm9SAh1VwGjPvijKGRV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a dead node is detected, the depth has already been set to 1 so
reset it to 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3e5ae43ff8ff..e233f41ed4da2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1396,9 +1396,9 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 
 		mas->min = 0;
 		mas->max = ULONG_MAX;
-		mas->depth = 0;
 
 retry:
+		mas->depth = 0;
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
-- 
2.39.2

