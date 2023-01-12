Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E746684ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjALVDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjALVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6A245654
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJXrdB031605;
        Thu, 12 Jan 2023 20:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5ZhXU0K0obhHWYBra0myTmvhNZYLEHNRBdlUL+JmMXM=;
 b=i6I00Ckq8ZfzjacFEutouPA/2JpJJhMqzZgmaCLWi8oqyH2Y2qlWQ+PWIOR9RV8Pgfi/
 ++b7G/7kd3bZ9AcGRlaW+9lPmjNpLBa72/W4VOwaMH45wVJCbLsz5z8uilPJma946n/g
 AUbZDQCzS6iycUNINtq25ZrNh8mEIWuvvQ1msSMY/10LTDfkGYr/3SnPr2vOmsSvsmYl
 47s9HWaxsKGN7bA2rtcGQsn761FoQmmSiHX955UgnzctPkWQd0wynhMxnBDNo87p7XXN
 pdwcr8exSizMOAhlU35n3iae2le/gvQf0JUGoqCoWULcQLPhzmgeuuzZBtEL+BOE6/Dp Jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0sckagc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CJPD3j016114;
        Thu, 12 Jan 2023 20:46:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4ra2u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl+C0nC1xy9RiPk9zX+8eYuF2Yh3zZ1/AbPWPIIwmdWtmXsHi3FGv8HhU0ms5bf/8uEs/vtxM7n+6SEQXZ+vEVLXPTYlxNnUiuE1E0LlGIvo8IcaM9qxtdD5S+zIqpQjTEZWJ/WhIXf09outscZauj2iHLsdIxFlbOnEYOpt+oZc5djJ1YeAAaR0hSL+eKVy3ZvmYDMqikEVv/7fbl0biQW/Uha7npnzg+A8kOXzuSGZ8E17TsjdowZXS37LN2PbV7LOumEdxeXlYTC5s+A+mSn9Xtrt8nsAtkR5/V71d8JWLkWgQ4uJMqRs2/9bIxBEVr4ACqZrvvkFVWnqL6aQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZhXU0K0obhHWYBra0myTmvhNZYLEHNRBdlUL+JmMXM=;
 b=bSPgkKJxX5liciQCVs3xvSCJmMgV1A7v9VRuY6Tv9y2bQSGjQ0mRv8qmRkn6Pie50urkALZAEfcXzeiegkg0YqEz11RAb2gEJ0Vr/8ZDPAGteC3leRw28G3sAd581+zO+V8C66gAIZzVyxK9hmv0THm7RPDWVDIqvq55hpbpTMKnb2Cafz7jv0NvPJQSxDJZE3nyRmEqXc3yUFI8hl3Z1VV3OLq9vNPlXTtKbyqRxJCUc5oEFD8uriylz5ecnScGExxR0H4gylf1HLmwAamgj7w50rN1/2+MH4OYr+Ra+/WzPSy/KLWAbOP2eosBAgqEvYBufqgLhk9pf97F6TFSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZhXU0K0obhHWYBra0myTmvhNZYLEHNRBdlUL+JmMXM=;
 b=HDVzf3WNCheg83ULGX8x9+2g1twIw4c8/VzORFhQyV9f2zxVSo0W1yBI+YhLlwxKxYaK3/SsSjv97U/l5hIi4xFymMG9c4zZ194XwvZLJ8TIRRKW05jUyFdRSbuG8dn6CORNPhup/8nUKJj5+KAwBOJR+StzUomcdEMaU4Oprv4=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:16 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:16 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 1/8] mm/memory-failure: convert __get_huge_page_for_hwpoison() to folios
Date:   Thu, 12 Jan 2023 14:46:01 -0600
Message-Id: <20230112204608.80136-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa91f0d-7195-46de-53b7-08daf4de0c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bl10q9Kh8LdqVHnL6rBVtH1DLNY+KyEl+GkkkIMWx214WZLKvUIh/HqHTI9nrmBTHpKYH8MAq1eiHyXNS+Kh1UKmGuIRiH/bib/xy+3ko/R7r2v3QPeB2Y85zf9YJ0LlIOz9t2CfG5LW12pbdrAoqsZuJQ8nrsk5rxkFtXlrPdtXAF7XTyjmNJTWX6SLMfy2vluB3i3gbt+c+euC9ogLIIvduFlIQnmz0tbbv7Vo6PwuiLrnfRpNpKojfGWrXH7LBNWhtGm0ViIvizksaAxEeupmds3XeNLthdWjiNjBct/eV6Ukl0okgg6ecbKXQBW8DnP9C8k82m2wpMlJIidQkmTqtI90VW0PtFaCGfYIFOmX+DvBbFKyhqdodEAgpelox1bRbDrNyrPXxoAkKbsDFnklvLZ3HNx0PSGUKrjywL0ZZDGMvMh4kjnKhKd5JQ8UUdeDvFtaX/7Q4WmW3puGsuhYxznuzu7utv9enjKhN6KbG3vOArMnZUzvAsaO5Nd8VFyaxiQIZWlRWwSSvpxkeQx88wzb3eytcjv1y/A8pI19THSigiEG5ihYXu0NPfhGw1G8h/XfbtB+c/ePDJWoKjfelanq4MQ2t+phKBZrYQYCj8CFW1OKKRX2MMGC55Bz65qIvd47urZPPYki0pflk1hLXgQaQk6coLNyOHEz7McwmBGPcJk9GmEnwpiWbzV0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5b50hv3DxMIRBWxPjkS3JvgIpHg5eLjCJRNW2vJLfq6SPJRGnGYj+Mb8MTDu?=
 =?us-ascii?Q?yRiz5UdjIYbn/s0uwMcaIVcQPwKc9xRyA5tfMGakv7MQ2QuoZ2EoWS80G3MB?=
 =?us-ascii?Q?8a2n+QXzmYbVI8wqaAyxxOsnBn7tV95gVwjloc64dHAnaNfCfI4vewv1FYOr?=
 =?us-ascii?Q?ykTa1MJ1ltWdYLFwr1nVTD9uIWezAdYoYy3llZQBIuD0+O5JXTzW7kTYtY7v?=
 =?us-ascii?Q?kkIHR3b9mor6GrwzLmw4OXe0jlEiZkFSQTknI1LU5uYUzF9SrS7X6TXufD2S?=
 =?us-ascii?Q?OPnGYmRyhd+2XjsQmS+hDCLoMPGqqpk46HgTzcfubDKzZJWeoCoCFGPvboXX?=
 =?us-ascii?Q?bQa7Vwz0CNEQekclL3g0A5bfh2aCqLklaQfl1muUG6CL9Dc7I1Kr7geo+qhx?=
 =?us-ascii?Q?dynzlimdpR/mgLuJ3vAPo5uxFeCbXi3wZgEF6IqP85EF9Y+X20okGvD1Fdrf?=
 =?us-ascii?Q?KQph+FWP5Rwn/mXUmZRXlI0lVcb536k9iWmL3YN/vtsrCjAhtEP3/Q0s4YPw?=
 =?us-ascii?Q?aBljogQWzd5hvoNYKsEqpQT7Ev+/3d6HU50uz7ALzVoPQdLVCFdvUpIWvOWm?=
 =?us-ascii?Q?utdKqi+YLwEUO1E6E7xPrnZgdn6LH1qBFVMux8pTpD20SoKr11s9UXgw20nM?=
 =?us-ascii?Q?iQh8Cbsac1IA3bNUdwDPr+V9QxKwLuYxyynqYpvncrFtSxq3xwCXxClvNGQZ?=
 =?us-ascii?Q?A0LpwtpNJ5BG06HD2fHO2YP/3908QR6mLPmq7srEl2hDyrRC6W7c+te5eK/c?=
 =?us-ascii?Q?Q2CgX4T/i2tIudTtWsbT/5Cnzq9CKEEahHRGZZyBQyiILYCV7WND0h+g0Xpj?=
 =?us-ascii?Q?rWe9ioS42KiYpkNtAeQ6Rgvm1GWU9cAKYOLHnVppVSCxg4YIBDmsnCrGgRkf?=
 =?us-ascii?Q?Bow9NjU/CNDn8qMMA6ycWdNzEo64tBVSgFiI9lSDos6t+yqph/mtVVscOmwI?=
 =?us-ascii?Q?U/UynF3/mJADWc5L1WJY+pXeUkb8n8ztieRnOSeBeMIgGu2zxhZFQks7ZrnB?=
 =?us-ascii?Q?SZFC2LgSjJAUlehbpBlLNj2mz91S71H1C0h4aRW4+bnpw77wODjhdNqWKJcy?=
 =?us-ascii?Q?EUUYviCGJ8rcIV+QCx9qRkxSAJt4OdeyXU3AUc7Z4B4V0DVdUaQRwpQA2NBw?=
 =?us-ascii?Q?HpYXgr7OR30QXKOJp5Y2VqqcnYOlsezZGe8TdeMfJmhXUXkdZtN9cfR5dgQG?=
 =?us-ascii?Q?m6vMMUKD6/7/rKltgLVNmmwZJ/IVv9VEyKGYSFCv3JIerRUx9rlh3uCBd1K+?=
 =?us-ascii?Q?OIlS3G/wwhhWTWJE3/A6VvWW0doUfcwOiQoucdTQsRkv0xy7BWJa+VX8ts50?=
 =?us-ascii?Q?yMbQgYV8DY/PIjI8CxfJ4nDHzr3YS2uwnkwgSJQnSDA/4U5UEdXV5ZDlcze3?=
 =?us-ascii?Q?budLlkgAMiScFcdxIiggnDUyIu/2vVzcDjtr3G4mpBVXtkh/DUZ5ptGUmAoa?=
 =?us-ascii?Q?YWTR4QBFK/DLtsUCy4wzcvODi8Lnx50RjxDcGDP2HZfwTHggE1w2p4k+MNLm?=
 =?us-ascii?Q?04MuwWqEmf2bnZEzkmrqrsWIZj/ZgIpIqYHabq3V2Psm2ZdI+oZoFup91Qfj?=
 =?us-ascii?Q?933aW+nVLiY3k+MvLGX46QiCnWxp0KfKFYhMRKzLc3X1wDHNoj9vd3yI/QiB?=
 =?us-ascii?Q?2a0zSI5b5vwR2YrbKbx0Wvg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kdkf3Ld1XNNzIo2UI/Y/tOMGuGrugs7Qs99aBHaXOuO10y7lLNpSk6vOEVuf?=
 =?us-ascii?Q?oc3Uj+CGv7RrpS1n9jOazJdkt6L3wPc5tmi6BvW0LE7BzuvT1YX5aQM9NiID?=
 =?us-ascii?Q?LPnsZOBoxmhW8VyfIh1aZeiGazWfZXazh6XZ93r133S096UZX6NtZQcJr6NL?=
 =?us-ascii?Q?q6l6OqVarZXPv9kXSJxVPRTUFppuPWuMoWDft38KovZOG7k5KXlJ64D3/CXi?=
 =?us-ascii?Q?sefdOMiFY+Q2viTRupCJ+Vwf0tMfvUo+c6M5zu5gynP9qBUolfZcNZHVzYyb?=
 =?us-ascii?Q?HE53qiPo/i9G0z0ajhHVmRouTMeziGTYlPHBAc9fVatqLm+2bBS15hVMMM8N?=
 =?us-ascii?Q?lAQo465+4zijFo/ADzIa+vX6kYHFqvrSMVCYw2E0a1YghheC6+86TYsI7ViA?=
 =?us-ascii?Q?oFJMFZwZOmaX5MGyT8WY5MT8o0R2ymdF5NJXxaRjbvwsPPqq4UaCVoWg4MnJ?=
 =?us-ascii?Q?bh+nj1nDCjvYOrgQscj3ITw87esdUSoOrWJkRKCvxbGXxYA8h86d1kMKGJ/b?=
 =?us-ascii?Q?NTYNRtKSb5S9KFIH8XVuaVouLZOdK7KOWm5H7fKvdePOk5RzGbUPkxyFcI32?=
 =?us-ascii?Q?pDdOe7mEl8ClRtFSR0ooQKLlUHfsc+gHFqnffZJ3yNtpfgHFV68XOnTC2MM/?=
 =?us-ascii?Q?Gsvao6++HJZcxxxa/ByKsG2hfKi4Ji/2RsFT4xsWZWW5zNF/4dEKmJYb7XAu?=
 =?us-ascii?Q?HmCDu97sjjCcQrfISKtkzt+abNmdMPQ5nlzR5b5S9XyF85nrUXvNW/E/8UlA?=
 =?us-ascii?Q?ho2Pi4+3dXGL8yPSA5CnERa15aAwYUCe4rHYsbCvjYYhfzONLqjlOvS0BfuN?=
 =?us-ascii?Q?6eNuYubZa45j4VkWw4j52UinPFx2+twewMnlrHihkuuSy2N8n/0lB4Wv2GCk?=
 =?us-ascii?Q?c/WaHKb5FX8HtqNvjWfQX/DOnmIIOrXMdvoRe5aWtetyBVxqJ7/hBqHb13N+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa91f0d-7195-46de-53b7-08daf4de0c97
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:16.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VIg8pzaEerT2Hp3nZ5zPwGiyFb5zUer03l54ysKg9ZEwcw13/kjHOm4jKFw9PPBayf3i1SjM4EG/AhfC3qe9w+um6dsxsFW7bLv03ySdvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: k5s4JmT990fZcuDW8dfB8ipmGYdokatp
X-Proofpoint-ORIG-GUID: k5s4JmT990fZcuDW8dfB8ipmGYdokatp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio throughout the function rather than using a head page. This
also reduces the users of the page version of hugetlb specific page flags.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9a80d7830b40..ee7e79ec6eaf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1807,20 +1807,20 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				 bool *migratable_cleared)
 {
 	struct page *page = pfn_to_page(pfn);
-	struct page *head = compound_head(page);
+	struct folio *folio = page_folio(page);
 	int ret = 2;	/* fallback to normal page handling */
 	bool count_increased = false;
 
-	if (!PageHeadHuge(head))
+	if (!folio_test_hugetlb(folio))
 		goto out;
 
 	if (flags & MF_COUNT_INCREASED) {
 		ret = 1;
 		count_increased = true;
-	} else if (HPageFreed(head)) {
+	} else if (folio_test_hugetlb_freed(folio)) {
 		ret = 0;
-	} else if (HPageMigratable(head)) {
-		ret = get_page_unless_zero(head);
+	} else if (folio_test_hugetlb_migratable(folio)) {
+		ret = folio_try_get(folio);
 		if (ret)
 			count_increased = true;
 	} else {
@@ -1829,24 +1829,24 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 			goto out;
 	}
 
-	if (hugetlb_set_page_hwpoison(head, page)) {
+	if (hugetlb_set_page_hwpoison(&folio->page, page)) {
 		ret = -EHWPOISON;
 		goto out;
 	}
 
 	/*
-	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
+	 * Clearing hugetlb_migratable for hwpoisoned hugepages to prevent them
 	 * from being migrated by memory hotremove.
 	 */
-	if (count_increased && HPageMigratable(head)) {
-		ClearHPageMigratable(head);
+	if (count_increased && folio_test_hugetlb_migratable(folio)) {
+		folio_clear_hugetlb_migratable(folio);
 		*migratable_cleared = true;
 	}
 
 	return ret;
 out:
 	if (count_increased)
-		put_page(head);
+		folio_put(folio);
 	return ret;
 }
 
-- 
2.39.0

