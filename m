Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B986F87D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjEERn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjEERny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:43:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB6A1891F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:43:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhK1h014772;
        Fri, 5 May 2023 17:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=S58ESfS5JJYWB2ZAlQ3vKg+/QpLNdflt2UxDlEU9y5Y=;
 b=QFNRDu+OHAY3gy7ncgUmKhRMYbfW5Ln4e7TC0gwm+kI/uxv6PEBKdbrhU4Wo+Y1rYjSI
 mIVKebbYSs3gRJjyAybOUhFrKImu2b3bXYKYzmKRXujJGXoUkFA3VG+v+ikgEupEnOtT
 yPzE6KkmmzQYBFaU1UJ05OZ/KXLmd4IxXd5B2Cxvog2YVwI8AYRJ5ohEtlzoQ8FL+dX7
 VQEbJmzpMJFE7D/+6YjuNoSOWdVdjX3J5AQ15RtsmQNBk3AfGiIRV+Lekl/RM4f06D8W
 ID68J24K9XeU/GQ5kT/ArxGofxeic+4mEjcUS8iOp1fuKU/Pa/SS6Obs9AoxFZA8I3Fo gA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GuBT8020742;
        Fri, 5 May 2023 17:43:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5ewa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWqo98ioCWkhe93YGjOvdaI9ZN96XqZ29VD3OSRVGCBgqgBxCjKnymQavNhfiLhaSnjVip+UbNt64lbxvhNVMlUxFcW7soFAnM+s1hP6nfRec9nug6l+yajBmjN23zRmxKVKvmLHSzgpBrCygE6IN5QZjGEstHcCIQkLTrxI9f7/6OzCed151xT5SnYdJq37fgTnBD1diZeb71jyHNfclx6KWExwy7OB/5q6IuVjOc1Zg0WWKdiTK2m4Td+zYplERQINIlOCa5gSk/K/5wq1aa7WhIClTGOFxYa/HEDh7ChpsQZZjqYLoLFOrP+9I3H3yT6Ae/C0xq5P18tCQVZnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S58ESfS5JJYWB2ZAlQ3vKg+/QpLNdflt2UxDlEU9y5Y=;
 b=mCP8RDJCNgJin1suoI5wxeHKAwmfyjyYeS9Kl6vnQAl/VPCJI5pwtXC5ldl+vZmjiJio8KSBfOsVg9MZw2mMjmdUP4qyhFJagNYZX8zImBAg52Ypve4jJQYCoe3sCI8VTTFYlqtmEBJnIkmY1IDXuZ5+PEPJS9c+BYvdpp5kb2gM3+EKiBMotsp/TwtkOSsdJiLS+ZUNDjlXyEjFR5eFQkavFrlmjjl7gu8nRvPlFeC40HjUYYDgYyXSEj/M7Z/Cv6F5P6xYOJIWzJn4KNJ5MFyO4UMI7paE34DcDIpNox6AQ2OQGmkHQUnfDIWMoaMAA7QkWvTiFNalzZfzRssapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S58ESfS5JJYWB2ZAlQ3vKg+/QpLNdflt2UxDlEU9y5Y=;
 b=zxs94ji61fv8j9wbDXOAh2dLx429/Cn/hI5AiMXkS+0dPA0FusQtckmYuiZUS+tgekc6yxA7l4CMjt8Crzrj9aQZmq7na9SVpW+Gwg3yejYKL3cxaJ81FzJoT4pXqe+oKHUTXNSkwUIfBU+NDrK4Hkzs9oEB6x+Wow849Vu/l4o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:45 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 02/36] maple_tree: Clean up mas_parent_enum() and rename to mas_parent_type()
Date:   Fri,  5 May 2023 13:41:30 -0400
Message-Id: <20230505174204.2665599-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 86eb6d51-477b-42ba-a081-08db4d904678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KY/DIrH1NDoZFyXEf7FUyHkksvShYO8YuB+ybsz+kkMEqjuPVr+Y68dXoKsBmPwXBmL+xUP9tvomS8zmF/hcDdUwnau+Zn6gr4IC8MuF/XImSN4QU//Ss4csrr/lKY5DME6+u35OkKgqJciTXRSL+D/iaj0vzArCstAg1RypCdZkViebcMTh1qmc23OWXRJJppASNg7WdJFuSGa+fhKuvS4AIBYVmUFfU5bX+yvhB29o1xL+xU3Ja8YWJfQzDl0eO5ndR39qj5oHcmO1VmimUwR115e4Kn9LXEOYUHR6o1MgJ5MF6LeU/vBQfso024f94+nD1p93jDjKGKFShnFDC7XBqJnaDzD2GEvVUiTjMl73FmTeTJ+yxxYR/R0NuOcCsCqP6/r8zz6HR3fWSim2LEIsZdK9E91G0c+vaR6IorJrz44nqot054EVNO+bE5KJbPhvBFLeSeYgo0Rlv532DS1mOfDLsBFLK+VebzQOdOVThuAxgVGkmevYrBgyycrX6xzNs+auYQB6QYwpSV9orW+Tsp1CFf/gbW9CE25OaT2poddsA2qs245LSLglfMv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hMB07DAKl+LFD7DXRb/7o0zoxXbTpJ9rzytyRs0o80X1BABG9Kq09hJUC0c?=
 =?us-ascii?Q?eqLQcmXcy2tdiYzReppMYIc48ECpJqqmRUoJuxvnjk4LI7F+5g/QaohR0z5P?=
 =?us-ascii?Q?EqJ5+rX+GhTsCId7xKorB4wihOzOxTWm4LJ/xCPu8imR1quOehdT8FwoNH1K?=
 =?us-ascii?Q?qGc6TeHfr+9DgujkKNm5p6MJryjKDtohgt/PfBHNN85OLYqAsHNulGlE/WqT?=
 =?us-ascii?Q?yjy0dPGRhXbMgCFYGlHL9crA7vuMuh9y7poqbiwcVw8i9C+77frZNDQP5ou8?=
 =?us-ascii?Q?XLKN9cwD0QjamGbuITCo/wRv4KjcUO4xyfJdA9QBZmyM3zJS14vi73J33PFv?=
 =?us-ascii?Q?Gh+pwA8Hc6Q4UOzFQaQmm6G8T8vCoTsw9eQHFJFMhE+fa9EiVVdOxDLZnpQR?=
 =?us-ascii?Q?1m4GPfuIg9+uwSuMLqcIARW9CqyUozeV+dcgy4ybz6BOVsvgAee+tjjZr2ku?=
 =?us-ascii?Q?SvzCxH9sJhpvtOAi5bShDh82tx/ESOmgTi/1UjVQQgM6cJNyNP9qTFEj3z7p?=
 =?us-ascii?Q?D+SxkSrN9rxpK95EykR4CdhhBkCnmmyjBdqOlEbs3WEtQ4zfOMZKL+3vJ+rh?=
 =?us-ascii?Q?und9Wv1LtwiOHR07acjPZeoP3fBFiRVpdz56Yr+PfMYyc9UjlnXC8iQo5BUP?=
 =?us-ascii?Q?YarhYgsNQS3Xn+c/osjthf8c2CQq4DjmG071zCxBNBwT4SLTPcXv5mCXV9Zl?=
 =?us-ascii?Q?Y+B8mCjJ12Fz1O/cZIJKG8xnQ2o/QGChT7jw/9LPiGRiD/RttG7yzEAg8Cm7?=
 =?us-ascii?Q?vNSLyjA5WNCy7jtjKI3f9yUtML5eIKQfMs+HDS6ICEhMMfBmbr/7nI+pb+4b?=
 =?us-ascii?Q?mk1IdpiC5GpMnRuoaqODt7zePYUD5zL+5UDsRsBeJtxsKr7v8ZIPjg7M9oQI?=
 =?us-ascii?Q?B7COwJygBhn3uGjMWnkRtWhDGIjVtt13FdQTsDOXwoHLcgLljWtxKoX6HhM2?=
 =?us-ascii?Q?50tqlhS3Ua3dnD3q4In8xWAS0VCo8MdVg36W5brxLQB6fKksBo7rZ83az66K?=
 =?us-ascii?Q?YBdKfv/bLOE5OI5kEeT8OHRVMXSfIdQabGE+UYyFW2JFOvLpfUMafqYexNt+?=
 =?us-ascii?Q?2j4EDt736Ycml3DPJmVwUqVkm6tKvy1xothVwuy5xTgMxIu5dEqQBAlwRcF7?=
 =?us-ascii?Q?4s6Re+BRTmNKJsQbpWNlojnqVLSLxXmqo4YYfgRR82SY3PbkNZJjZKRNa7Sm?=
 =?us-ascii?Q?stLVgkQVTsSmr+x4LI+x+/IS8CYUvTG0xxliXCTCEWQsbTzW90cbj9IdqfLU?=
 =?us-ascii?Q?UPXdmHy50+Yvizc1g7XHX5FIQVWjLGpo99SVO47Hf5zN74IHcKBMrUR8kiv3?=
 =?us-ascii?Q?Zq6LxmXQM+OfIfHGWHbUNibRaqR3hI0LzyMC1KauCdJB1K3PY1JeKKnhvlur?=
 =?us-ascii?Q?oNGhMfX19ZJimxlJPcU8IF6UFh1GDbS0qPyC/8WmdeDdgJYfr0WS5oQ2gyyJ?=
 =?us-ascii?Q?X1MtM4LhBvVRUPxw4AQT3VGDqgb+fbOwb5nsD+DRAgiKFsplIxqF5Ecv1u05?=
 =?us-ascii?Q?fx7s49HGWfBS7CPjK8uIX/JsJrHTuv0GlLPV46u7q8Im1DudvyvtC7YpLFHg?=
 =?us-ascii?Q?/ACHli9wmlXL0Zpt5J+J8Wq/rB/+JozNL+oP9qW3qXWIGCxv+KVEdYiOsO8E?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: woSQDffY2Ke+LuD5eYWHBXWaRJUJ2oiyQUh3gDEh0IGi/0J+d+nA2LN+YBgECPhMG+n1hGNLdTu4Uiso51ItTVUnRepvEYuI+gG4Bnm6w0WkP4cZzywshMgSSZXudSMiMKc5mNgFlC6RV5CYfJrORKgjaEhQ5Uuy+fjONxQGSaXThu4EPVcH5dLDdeF3MRPHqyIOKB+jzQdQrrPOabT2AwYSMykhJjLetLGRe9iNmBaDA51beJrkfIb4SQKkrOnRCksDiZgRctcbkr9X7cSGrMHJzckuBSxKqX64fyioAV134nNAzrgqp5Pal9otjcjIE7u3pn5u4+lutJ8tdVqB+F8Cd0hsoJjg+LAPDN97LOVfxjatbT6RSDd+r43ulxR0gQANiSyRpEUIas1zfhmnxW6zKgf5h+umTvnBfZYWGN/jO+P+3nTqH0STflMk09KQKghGHBvvTAHlb2cnrTYHshLJ/niVVJrSEg0/m+Rd7ytnuTmYyLi7r/dcpFlUDk9CLiIlQ2rI4lolME7HgdFYGKREJHP+52F3qinePZoI/dCQgIzg9KPsRUg+dX7bjK2chQhGjGkIULv0F8rEiMXwIPF4C05LkL+DiMfayn3rzxC17t2/H+8LaiDDwcuOQiLri+ZKmS8t+QMspSD0B8I7HRlgE5Og/XLU5MIuUBofbYYsN93o7CmQ4MJtKL6jR1v0pRt5cbCxQiY/zeTo/6RTPPuiv2Vg2yRBSZgDUN+cQfXahdmRo5ilRrXNF/An5lyLhKzHoHh9ByIF7pc3BCuhgqTDfNx8SpOmUS96Tb5/LLmq6Ld3J2Eif6sxhDjLs+WqDBo+GeQY7N9pjmTX1OWIEa1x9fX+7K6+saP9k4Eoi0fqk0TDkL6el45iQohEp+1vqg1CS6iMiB2OaElgzxITYdd8n/xe56R/4pyeqRrZ5cM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86eb6d51-477b-42ba-a081-08db4d904678
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:45.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzDwOtF1qJOgUP2ODVuQ2+r5388z/wIBGFpuVSodpN2Mkcbrq3fyK6XScIDC0cmXfn+0bl1rVlYr4PRV2IKVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: ygWba-i0sCKZQreKgD0Yg0IPrstlhNCF
X-Proofpoint-ORIG-GUID: ygWba-i0sCKZQreKgD0Yg0IPrstlhNCF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
only called from that wrapper.  Remove the wrapper and inline
mte_parent_enum() into mas_parent_enum().

At the same time, clean up the bit masking of the root pointer since it
cannot be set by the time the bit masking occurs.  Change the check on
the root bit to a WARN_ON(), and fix the verification code to not
trigger the WARN_ON() before checking if the node is root.

Align the name to mas_parent_type() since mas_node_type() exists
already.

Reported-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 50 +++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9cf4fca42310c..555de3a8343e1 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -425,28 +425,26 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
 }
 
 /*
- * mas_parent_enum() - Return the maple_type of the parent from the stored
+ * mas_parent_type() - Return the maple_type of the parent from the stored
  * parent type.
  * @mas: The maple state
- * @node: The maple_enode to extract the parent's enum
+ * @enode: The maple_enode to extract the parent's enum
  * Return: The node->parent maple_type
  */
 static inline
-enum maple_type mte_parent_enum(struct maple_enode *p_enode,
-				struct maple_tree *mt)
+enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 {
 	unsigned long p_type;
 
-	p_type = (unsigned long)p_enode;
-	if (p_type & MAPLE_PARENT_ROOT)
-		return 0; /* Validated in the caller. */
+	p_type = (unsigned long)mte_to_node(enode)->parent;
+	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
+		return 0;
 
 	p_type &= MAPLE_NODE_MASK;
-	p_type = p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type));
-
+	p_type &= ~mte_parent_slot_mask(p_type);
 	switch (p_type) {
 	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
-		if (mt_is_alloc(mt))
+		if (mt_is_alloc(mas->tree))
 			return maple_arange_64;
 		return maple_range_64;
 	}
@@ -454,12 +452,6 @@ enum maple_type mte_parent_enum(struct maple_enode *p_enode,
 	return 0;
 }
 
-static inline
-enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_enode *enode)
-{
-	return mte_parent_enum(ma_enode_ptr(mte_to_node(enode)->parent), mas->tree);
-}
-
 /*
  * mte_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
@@ -1123,7 +1115,7 @@ static int mas_ascend(struct ma_state *mas)
 	p_node = mte_parent(mas->node);
 	if (unlikely(a_node == p_node))
 		return 1;
-	a_type = mas_parent_enum(mas, mas->node);
+	a_type = mas_parent_type(mas, mas->node);
 	offset = mte_parent_slot(mas->node);
 	a_enode = mt_mk_node(p_node, a_type);
 
@@ -1144,7 +1136,7 @@ static int mas_ascend(struct ma_state *mas)
 	max = ULONG_MAX;
 	do {
 		p_enode = a_enode;
-		a_type = mas_parent_enum(mas, p_enode);
+		a_type = mas_parent_type(mas, p_enode);
 		a_node = mte_parent(p_enode);
 		a_slot = mte_parent_slot(p_enode);
 		a_enode = mt_mk_node(a_node, a_type);
@@ -1659,7 +1651,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	enum maple_type pmt;
 
 	pnode = mte_parent(mas->node);
-	pmt = mas_parent_enum(mas, mas->node);
+	pmt = mas_parent_type(mas, mas->node);
 	penode = mt_mk_node(pnode, pmt);
 	pgaps = ma_gaps(pnode, pmt);
 
@@ -1691,7 +1683,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 
 	/* Go to the parent node. */
 	pnode = mte_parent(penode);
-	pmt = mas_parent_enum(mas, penode);
+	pmt = mas_parent_type(mas, penode);
 	pgaps = ma_gaps(pnode, pmt);
 	offset = mte_parent_slot(penode);
 	penode = mt_mk_node(pnode, pmt);
@@ -1718,7 +1710,7 @@ static inline void mas_update_gap(struct ma_state *mas)
 
 	pslot = mte_parent_slot(mas->node);
 	p_gap = ma_gaps(mte_parent(mas->node),
-			mas_parent_enum(mas, mas->node))[pslot];
+			mas_parent_type(mas, mas->node))[pslot];
 
 	if (p_gap != max_gap)
 		mas_parent_gap(mas, pslot, max_gap);
@@ -1767,7 +1759,7 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
 	} else {
 		offset = mte_parent_slot(mas->node);
 		slots = ma_slots(mte_parent(mas->node),
-				 mas_parent_enum(mas, mas->node));
+				 mas_parent_type(mas, mas->node));
 		old_enode = mas_slot_locked(mas, slots, offset);
 	}
 
@@ -3251,7 +3243,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	l_mas.max = l_pivs[split];
 	mas->min = l_mas.max + 1;
 	eparent = mt_mk_node(mte_parent(l_mas.node),
-			     mas_parent_enum(&l_mas, l_mas.node));
+			     mas_parent_type(&l_mas, l_mas.node));
 	tmp += end;
 	if (!in_rcu) {
 		unsigned char max_p = mt_pivots[mt];
@@ -3294,7 +3286,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	/* replace parent. */
 	offset = mte_parent_slot(mas->node);
-	mt = mas_parent_enum(&l_mas, l_mas.node);
+	mt = mas_parent_type(&l_mas, l_mas.node);
 	parent = mas_pop_node(mas);
 	slots = ma_slots(parent, mt);
 	pivs = ma_pivots(parent, mt);
@@ -6995,27 +6987,29 @@ static void mas_validate_gaps(struct ma_state *mas)
 	p_slot = mte_parent_slot(mas->node);
 	p_mn = mte_parent(mte);
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
-	if (ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap) {
+	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
 		mt_dump(mas->tree);
 	}
 
 	MT_BUG_ON(mas->tree,
-		  ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap);
+		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
 }
 
 static void mas_validate_parent_slot(struct ma_state *mas)
 {
 	struct maple_node *parent;
 	struct maple_enode *node;
-	enum maple_type p_type = mas_parent_enum(mas, mas->node);
-	unsigned char p_slot = mte_parent_slot(mas->node);
+	enum maple_type p_type;
+	unsigned char p_slot;
 	void __rcu **slots;
 	int i;
 
 	if (mte_is_root(mas->node))
 		return;
 
+	p_slot = mte_parent_slot(mas->node);
+	p_type = mas_parent_type(mas, mas->node);
 	parent = mte_parent(mas->node);
 	slots = ma_slots(parent, p_type);
 	MT_BUG_ON(mas->tree, mas_mn(mas) == parent);
-- 
2.39.2

