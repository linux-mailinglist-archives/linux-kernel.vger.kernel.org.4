Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993126EE3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjDYOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjDYOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3310EB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi1SH008675;
        Tue, 25 Apr 2023 14:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=qz+ACXLhzPbOkMtTfxRbmIf0lnxNTD4ojNPfBIcfcZI=;
 b=X8DU/B8PpqamizkZUoZIk/mU6m0w6WIoj/dCQlVu4KWOyy1bAfmEyfqIh6e/pFHnXOpk
 565ih7a+esweeU6mywF87lM9qzUTQ6m4bqTQCjmpe8XSyGMV47ICCMz+4rGaH4R5k1f4
 sJMfSLG+RvN7LcI8y7YiBWejjbNjHaNLbaj0wL3lI2Cz9DMVjTdjHB5hNfYovTGjfotV
 1iJmYbwAXB/qtTbODQ9e6gTYQnoDT+6L8rWDfkqmI2JxnFWbON/SKHUu2WgslQfEV3/S
 PIhfYemj2G00tRvyrciXuiY7ZyXoQ53BBN4UEBFyQp8rE4AeixYaeGRvhRfN50p+/dio vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5e33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PE47Lf013267;
        Tue, 25 Apr 2023 14:10:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q46168crj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPossiL5qEbq/wF0lxZ5BFfQFTdM1/R02UWcxnGEsjgqvgul/TKZz4HPfHFKEelWV9W+kbH73UguwoDbFZufc9O9j6dHY5mh31Sx1PS/PNFjIncv8ChRNXHtbLo1Mw/CVVhczx3ilEleGVtanOA9wPWkx3zrczBi1+x1gpkMujxqN2VwaWVvMyggJfRpAqSzdeH9yJcz/r8ook4weEGKU8erZcov7+JJLESkZr9BpE7lH8+SOcXfyfMyXvuBi386ndQe3AM03a3AyRZJ9erlwsowxNajkAXYzqxXLvpRrZolGZJ0bNpwXTqgnfD7alMXw16f3eJTYhxAcfhtazyprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz+ACXLhzPbOkMtTfxRbmIf0lnxNTD4ojNPfBIcfcZI=;
 b=S1qsEW9dCpe9pxtHjGnCfJcmYOM8hHGtnWrLlU6aNhYCbcW4RFFHE2/vcBe+nqvTrdfWc4+MBGgAgOVG5H4INdUhNUVBB8vNmlilE4pjQwh801u8CRnxKsa/O3XIj/OTEgt9uNaTYIg8QIBoiETQftebaINva/ovk/LI18y42Ikfdq1TDy6MR9I8qNryaxx2ZY6iqIaZfrHSX5odJRtbBh1SqUQtx4CtXxbh7lalWs/Gc/bfKXqVZ+gqYU4I/KmiT2wLl9SV1d81CBEv2MEglE/tSe2SFRVPnXuVZhChYO/rwytd6j4KYtaneQgseUDnen4AcZtdxgLb3/O/tsl0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz+ACXLhzPbOkMtTfxRbmIf0lnxNTD4ojNPfBIcfcZI=;
 b=do9V4toTUvZxi8E86xctCYBOhvvGnxJp8+6ThJ/MLgnCzgSNR0HDZzZSr6uQBE3d2NP4g+134jZgCPNviC2ataNmBJ6om+LS2AgiJU6HbRfJ0teg2tz6poUXJfXHcyBEFxg0s89hpf7bX1uxk2e/p/0jJiZnvmRuPYI4DDUeJek=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:19 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 00/34] Maple tree mas_{next,prev}_range() and cleanup
Date:   Tue, 25 Apr 2023 10:09:21 -0400
Message-Id: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::15) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 6914f1fa-3f01-4e0f-43f4-08db4596cd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8t2HNM+PW14eW9qISPhK1VV1hokgOdQm+nYU5Uru0782RJuUuf3L0ztF7KkNhd3NYYfS3ohZKGRJ1+kq0oG37O7kxNqFBx+veQJOa4U6o/nojTs9dsV70P84z3/ilrpH5TJPOxZOpUtYbAp5pODg6LZM97fXX4JhoNE7QjVETBniyzKvCYtay2uz3s+Nwpt+NkNOTQfXfJYWtjhMmH180B1GItauQJpSgqRtWVJdYyIkm4Hw8v5qTc/D9maQR2rPYCJpT9Txeo2BbDNybu/E2B7qcI9uV7erlzXoo8L+Jprcg2Jqm3FRo91/6FJRhR3SSUbcLezhwHBuyLgfJr0LXSBS6NzCPOR0LGd8PloPDluE5Pvj4L8Ed0s0Af32tsNpzqig4aJHgEtlp8PcO+xY6dZtSAspUtYkfqATnFEhom47DNHFMsJUBEk/4EXuwsSBRJSHrzt0hcL196V4GCjR2Hr5Q9UXIGkNtCCZnGPAmpU7ek9LR/3/rBICfPNwHdhq8f0uti1np1UYpAABaeLPSLDeRaFDki/P15eR23ESrFTkAEFAAkYaARfiw94VDdY/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6666004)(6486002)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbMqklbpmFOdPcV/D9gPRp3ulF0bwWxOuAx44ofVg3Ki5q4RE4YAE4mPjJHG?=
 =?us-ascii?Q?UmTO5D1+46K9kwMX63EQ0Hs4LGRQGH34J04RgwUBupaLt/TCQEwWkkBTkzlE?=
 =?us-ascii?Q?vMJ4vTC9FG4+a1SIWLXgFOOx/eGnlbH59blBSq7dvuyRIHBeIRkSbCdy0MgL?=
 =?us-ascii?Q?VdDHo7JbZJJUB86qBU//wvjX4wTvWhg7tPrftXIWJ4mNVepbLeDzcYMK9OvS?=
 =?us-ascii?Q?zMUhpMBFI8h9+YWCK5iju5ZW//4kJLNNlE4jZWnKLV1RjMTc4aeFMhAzvZGV?=
 =?us-ascii?Q?5YKF20YQtckaqcfIfggqPjXzdEYAvEB7hk6EcHpJAbkNtcwBZYPWzf268899?=
 =?us-ascii?Q?VssgZ3PmJ1tmnPsI4dU5FIU+Dab/h29gwy9Y/qr7Md2jP+rheELyXCEdF9vK?=
 =?us-ascii?Q?LsqPzhEqXhRlg+gMP1HOZOyDlZY9vfv8Ebm3E5SJciXMPeemVE3UAhdwbkCh?=
 =?us-ascii?Q?/hfEeCEr3bowPiq/njuJJl7YqjvRPZ8j9qvl6ALMXy0prBN77590pnIy1s9G?=
 =?us-ascii?Q?PebbwTLlm/+gWLVk9EmzsLK2cV/wFU/G/AjICw/Zo0aTtZkk8bGv5y4y1A+Y?=
 =?us-ascii?Q?lrcmnrfKAhlAVbRzgCRKOiGyY4abhQrES7u0zkvvYf7YEcgoqRv6FSxiG0KI?=
 =?us-ascii?Q?SxgF05DnCfuBcaFkyr7vfOc8tXsw5bxa8x4qZjJE04uHR5L0gfNUINIhJPiE?=
 =?us-ascii?Q?Jd7JpRT/E/j9Dy5gK39jvVrOit1yG6UhIXBxCbepNv2rZHuvZRrDMCy0sayz?=
 =?us-ascii?Q?u+INU+fumawly50ZgYYn0Vh2kx9LTv9ymDMSSiynEEareohEFFn3cXe6upaj?=
 =?us-ascii?Q?vFnl+5HIRK6wvl71we4ktMtu08ieze/pO7pnu/np3UvIGnNuD+KWNLyOymoq?=
 =?us-ascii?Q?OmZ6xJ0CJPg3bJmiKiuieeaHmo4ouSzQfcjW/HDoEtIfKcGYZDffx946Ql/T?=
 =?us-ascii?Q?SNWRNkB3ClgJHL/Y+lsHmb/2VptnnN7kp+3iL5kaEgvrxh+b44/LwpALdkD4?=
 =?us-ascii?Q?jpVQczv5AuN1HE3KPCWzqU4FTx6JBDCN2gaGayC3KAnxcXFIXlECTkMd/76f?=
 =?us-ascii?Q?EW615FHhsmvdjDu9/m+RfaWqhc0rxNjLgJ30tPYKNKx5mzob9XvlFunCmIpH?=
 =?us-ascii?Q?yW8yYBFBWcfCBJgdPAioBxY2lHZidoEfkGe+BahrnLiOoGSqIxj7rsoeiMr+?=
 =?us-ascii?Q?Zzrpk1hff8DB65Wn9dh1d9ORIETUHXUfitPCMnrobVqj3rrLj6XKKmeAa8mM?=
 =?us-ascii?Q?4dsa/U5vTiP+lymJ5dgOQWnfAXujY6rOaxA/BXoSAhvTQMHz/7FYiXDjVJvV?=
 =?us-ascii?Q?ylNVjNkNSq+AjwoamP3BfJ0CnyijAihwG4SwVBa2NDn4uO2JI+zTGalbZzcG?=
 =?us-ascii?Q?zluKxbpW8EXeu0jkQ2yeVKNyWin999FxwbFlCsrkMh84I0sPfdu2/lejRKvM?=
 =?us-ascii?Q?bmunPsQLKrDQgWlx9n0jtSxL03AU1oAfAUZTU6BFGq2/vU2RK5d7KNLCyjYq?=
 =?us-ascii?Q?xMlx04CEPv6HaIidNIlRUAGb8wbq8BpCDxiebvbqxZC7u52+ZM24kyKTaMR7?=
 =?us-ascii?Q?rKMSX/Rmqs+Q8NjVrjzvYpfznpQw+2pgSNQ7mGvXT+CYJl8ATduuB/U4+C4K?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2vDF33pv/UQlkFqaazy/5J8V1uYMoJdnMHZura/ABxKfcjqVdGupu3TF4dTFrFtD2sq0rdyvF1wGUOTK5zA8MkBc6jqFFrqcv9DQBIzfMbm05sC01kZL40pSMcBIyh0tKaSFj7q8DWQkJszl44/Fd+WiLGJXUI1VNqZ2ZfmT8qWdAKFnuV35tL2blZY+aX7Le9KemqDA+G7pDdz5lSwmrULmCBZ2BPl763jRQ0+cUEPufSKI83Mv5mUPkIX6dbcCn6REvWFdYqXcIlf/UNEMi/v0WGycGD5BWqfWv4m+Elaa7roHXmk3kRz85jc6rFl0wVYvn0FqMi6BO2FJdYoNoGCj9SssnRTR5SC8bPpU3Xho7ORxDHCU6s4SA5GoumbMpfGxUQYJPAi/jD1jPHTBvUn7XHuekWkGs49iTvQmJhKkJ/m2OakuPouF7nRWQdJcliSmuj5QeB9eaC5PYVfgTBS6uBzwCDsaRpdbs+HJDVJHPpJlNC3bET8/RmVH1881JIX6kVMY5oGTOjW3JVJsyCU5TjbOj7Hl9MK0lYw2wi3UWXJbBzUNKU1FvqZLC39iczsJSgn7wgLWt6ln5yxDXu3LJLSzbe+SlSMnxbKshegyjueqYQOjC95yuSgPL+Z8s5Cdia3G/wwuOJ0MOFnAl5EiBUPKuo8xlN3yPG0WBWtlhfI+QDJVwuy8ce2HgbCTGcYdyyWywn8I21tP/df8uk47u73w2/cW2PxtS+bwMu1Dtj2G7fiTcfOTns7Fu5ewjvIgpuzyrdCh/8qyLlhoTCdoUME4usJAEnmxUZ8xS373AG7ZbjRDpy3EgYa3LsdCQRSy9bdSVQXSHzojPg5X+d8keqM9Lfj31nnuFhp/q9fFNCdStpQk+cIAMhuoEz9PwX6oH4yk8P57uiwAj65N/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6914f1fa-3f01-4e0f-43f4-08db4596cd6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:19.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm/BymYwBKhewP5bjmNbXBkbMBa3YzlSvBc+CaAkltwxjPhjifIh9auLF83Hk5f1XyV5agqsP6ZM7TmE/NJvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: 1HS0nuFO89QypAZDQe_SY_i5tzslVqwV
X-Proofpoint-ORIG-GUID: 1HS0nuFO89QypAZDQe_SY_i5tzslVqwV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a number of clean ups to the code to make it more usable, The
addition of debug output formatting, the addition of printing the maple
state information in the WARN_ON/BUG_ON code.

There is also work done here to keep nodes active during iterations to
reduce the necessity of re-walking the tree.

Finally, there is a new interface added to move to the next or previous
range regardless of if there is anything in that range.

The organisation of the patches is as follows:

0001-0004 - Small clean ups
0005-0018 - Additional debug options and WARN_ON/BUG_ON changes
0019      - Test module __init and __exit addition
0020-0021 - More functional clean ups
0022-0026 - Changes to keep nodes active
0027-0034 - Add new mas_{prev,next}_range()

Liam R. Howlett (34):
  maple_tree: Fix static analyser cppcheck issue
  maple_tree: Clean up mas_parent_enum()
  maple_tree: Avoid unnecessary ascending
  maple_tree: Clean up mas_dfs_postorder()
  maple_tree: Add format option to mt_dump()
  maple_tree: Add debug BUG_ON and WARN_ON variants
  maple_tree: Convert BUG_ON() to MT_BUG_ON()
  maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
  maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
  maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
  maple_tree: Use MAS_BUG_ON() in mas_set_height()
  maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
  maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
  maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
  maple_tree: Return error on mte_pivots() out of range
  maple_tree: Make test code work without debug enabled
  mm: Update validate_mm() to use vma iterator
  mm: Update vma_iter_store() to use MAS_WARN_ON()
  maple_tree: Add __init and __exit to test module
  maple_tree: Remove unnecessary check from mas_destroy()
  maple_tree: mas_start() reset depth on dead node
  mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
  maple_tree: Try harder to keep active node after mas_next()
  maple_tree: Try harder to keep active node with mas_prev()
  maple_tree: Clear up index and last setting in single entry tree
  maple_tree:  Update testing code for mas_{next,prev,walk}
  maple_tree: Introduce mas_next_slot() interface
  maple_tree: Revise limit checks in mas_empty_area{_rev}()
  maple_tree: Introduce mas_prev_slot() interface
  maple_tree: Fix comments for mas_next_entry() and mas_prev_entry()
  maple_tree: Add mas_next_range() and mas_find_range() interfaces
  maple_tree: Add mas_prev_range() and mas_find_range_rev interface
  maple_tree: Add testing for mas_{prev,next}_range()
  mm: Add vma_iter_{next,prev}_range() to vma iterator

 include/linux/maple_tree.h            |  128 ++-
 include/linux/mm.h                    |   13 +
 include/linux/mmdebug.h               |   14 +
 lib/Kconfig.debug                     |   10 +-
 lib/maple_tree.c                      | 1042 +++++++++++++++----------
 lib/test_maple_tree.c                 |  993 ++++++++++++++++++++---
 mm/debug.c                            |    9 +
 mm/internal.h                         |   20 +-
 mm/mmap.c                             |  107 ++-
 tools/testing/radix-tree/linux/init.h |    1 +
 tools/testing/radix-tree/maple.c      |  164 ++--
 11 files changed, 1823 insertions(+), 678 deletions(-)

-- 
2.39.2

