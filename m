Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8AA6C3FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCVBnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCVBnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:43:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90561C5BA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:43:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M0wuEF003806;
        Wed, 22 Mar 2023 01:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vMmWwZCyBw+RuowfLdy8HnCksye8u9VTsE9a/18CsGk=;
 b=1H2vMwjrt1GMSZv5nIj6RbjpeQWvgqQgI9ATBBu7Ssxby3C/Zjo0kLvWKaXZQMW8M7tV
 hewXwWe5rjkkt5esXtLS/PfsfC+U7fm7sFxM0boPbIavW6R2VmwPft+Pz4KnXIzMRnXd
 BI5EzE7gwShXWgkr2/lsvcyAyS69MFzGGCuGLeAiSdLLtWJAviXHWGLN+r1wrA95xJKi
 aubJyTVa9y7QAMkXJ+ETJTZ798g+5yXc637Qdox2lViJwjkXajaeZbm/k/3b39RCWiVj
 aXrwWw4PKWdAy3USzcfhqposJ2MQXGiAoy7SGi948i8jhRlF7NsiQxiVjMUjxSDuisIY hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56aypes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 01:42:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32M1ISEw029739;
        Wed, 22 Mar 2023 01:42:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pfm138ejv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 01:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9gdm+W1qOGMie5ej0Js3U1BVLNT9yHWAnoGaNAV2xSYuhgfvS5D81DU0BbVZYeGcTAzRWwrO5+A7HkKCRRFCDDSo9mYoJ7/E2qe7gHZDP2QnOpYANc8b6EQYrBkufGCYoh/5J5x7tKFem0XiFVOj56n/if1q0nLHXUK7lBuJiW5MmnzGGc1cQWOL9FbYbDFAq5q4mNeN4BaZ2pejGJl6Ln4G+l4EaieJvsqSbhCtguhmjMqdiNRzrSFGWojDI30Gp3oVTeWHgCU5p6AQu6w8/NST6qe/7RWE8kunjNAEjzjSuCN0Sk9RreOMLui3sTv3tSnpCozgmVQkRWZe7RHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMmWwZCyBw+RuowfLdy8HnCksye8u9VTsE9a/18CsGk=;
 b=h3VcNJrxqr3wRz1kvP+HPxG+z3nKZbPuaHXm5iP7F9D87RwnbI6yEgRn9ycgW5nc3iB+N3z7LXKJuYqJP8FMr7AYnM+it49rprqR37F5fDCVa5r5uqnUMGzKK4H8YfkZcxTsCZpoiCMGdXoGJbcQ5kI6IwAZMA6gGDWHoZAHpb2JHZbANaiSFFJtB8HDmi+/4mXWb5ixfO3K9ZNQ7CLiJl/rwvlnU2g8KAZHp3UqfAbaibCjC0tfkFicEplpi5WLJRav96KA/eSz5UNAan76n0/wU5buqbw2+cqTRdPgpPdguPlcSrSc5xA9+YIkK8yfXWUZqHg53wVAKkiv37sa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMmWwZCyBw+RuowfLdy8HnCksye8u9VTsE9a/18CsGk=;
 b=KXT4Ss0Ag/aZaaBPa7iaiUCXFlbf0T2lePZiJ+ze0WAH+qAyXXr8ObyyTStdugrdEukzXLrp0l4sOaJq79dFbS5ooRIt8MbTpAghK1BetQWodfL6+q893+rOnss+DIUgUDGipR7RJyA96W679v1PDeaDniPBS0+h84/kZ6poAwo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:42:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:42:35 +0000
Date:   Tue, 21 Mar 2023 21:42:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH v2 2/4] mm/mmap/vma_merge: set next to NULL if not
 applicable
Message-ID: <20230322014232.4iixbwn5urfo6t2y@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679431180.git.lstoakes@gmail.com>
 <3506997a8146a287ec13ee7a53cf916707537bf8.1679431180.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3506997a8146a287ec13ee7a53cf916707537bf8.1679431180.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: 72081892-47f9-41cf-21c6-08db2a76b638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PK0HwMzqH43m6tH2cGaTZIOtKvMFxxxOdjU3G562ubCUQKzPZ3a+1XquWGnxhIk3lu1R560GPDEIfcP5fIhZp4/QaCJ5ncQrCsLwG5sQgpWx+3xuXLxlfBd23jzg3t+PgAbx5m85LRBWt+fWwQ6GnznOIYmlfj2GPolOmyk2m4UhgfeawyofG4qxzUW8QhMhKtJGRl7xk8fzJ/tPg/S7YlN2jez8WCaDJTnoxXLSPJvESAg4vFFngRyLkOtX1rMuJ8O3o2Et2M2hn4huMJpkzxrS+frp24x/vyG87eI835Bpe1h9R5GCgGJfMvld+Gu8klvkcatZ2fKXnNXiw2uiWSaKPjCCRGmnVXjFxDaJ2sFKV5AiuawbLxOCpz+cBPoH1Hcl+kqnNKtyuzq/xyURePNitUGa8RUhWhuR/TeJ/pnegId8PbVzqnQ2fZZyo4Zmir0KNBEaVkrPBdWmKu4aVZ8Bk6h5392gpFxcIrKyp3cmxZetoHd3tWwGu+hGHejSv31EQAtZ/006LoPi0YappEmAeQnZoKJoJDGCmdt/+i7AR+unCFT+N1Z/zv88++8lkEoZt+qkX6nlX5P3mREHK3YrWXFJXZ84syQhLWfZWcUoC8V0SkvBkpiYXi17hNHFUqz3qJgWE5YUjn3Der7zMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(8936002)(5660300002)(86362001)(33716001)(38100700002)(2906002)(4326008)(6486002)(83380400001)(478600001)(6666004)(6512007)(41300700001)(186003)(26005)(6506007)(1076003)(9686003)(54906003)(316002)(8676002)(66556008)(66946007)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Idl9j7o08XJ7Q1rhXw4dDfYWQNRGEt9BTpPf/SpP7i5Yp1LDCwAlTKJNTHHJ?=
 =?us-ascii?Q?UagKv/gptgnnQEhU7QzKG4ZWSqwBviGaOPIw0T3IhVa237tLtUT3U+3JfLJC?=
 =?us-ascii?Q?rPrK4vcOu83jf07/67gQB0d03mPADkaNQ9FupvZV+d1OVrhG2bHCw1Wdd8JC?=
 =?us-ascii?Q?5tuGA29FESWzvIhF6SR1+8oO/qKszyDYh2rI4tY2VLvDVw7GCW/KnsPOryvQ?=
 =?us-ascii?Q?uN5P4+qe1Bcp9RwrlSmimDpFG3w/F1mJTjV+BjGYKmNyA6eNCyV8f5gSDtGJ?=
 =?us-ascii?Q?r5xDiKewongg5AmhOOZgaLzSm+Z4JA1XaUX7DiDP29apz4iSctmkPdwnViAN?=
 =?us-ascii?Q?FgYfcxl73cLEmbh7BRSdzPFQXvhdTq1EaXwhwaZjLz2vLeafGtcr7UNj/19a?=
 =?us-ascii?Q?mWpDV50rDJ5ugdLi91jpiLFAk5QIYB5owZiueWYIjmpFqddjzENj/2UpoSpY?=
 =?us-ascii?Q?2cSiJ0l1Xi9VajBFzUwpPN48PFYkCUgr9Js0+/J4Lu48ZoRg9VM93HYwiT8s?=
 =?us-ascii?Q?4P3ygKOTTaTlS5GvW+DhBTSsridpC7j2xvxh0QCRif4IhYLuLvRpGsZST8If?=
 =?us-ascii?Q?bWA+oUPRLbaSKC6t3HXh8HvKSJ8cCmVMFbJNjJ7EDhBbUYm+SkdW6PliLrtg?=
 =?us-ascii?Q?nqv4O2LrvxtV75fo98Rnhc3wqDj+BzCTG3qclE9flcoOnmaLPkbjha6ockRn?=
 =?us-ascii?Q?QCPlN/36fXyIYB0utpJL9yfOtHPy6aet5uzphW8fCNdbjUrYNTAYLsRH3byZ?=
 =?us-ascii?Q?ACBBitxi2ApKdwtwohUQg4/Zg92a+HZp8aMclryTimy+rtSjWx4MF40Q0KaN?=
 =?us-ascii?Q?P1C+ynSGgDqjFDtA8OLn4zHfseyzeLGISve/bKEj2/TNQiDApTImjm2DXouF?=
 =?us-ascii?Q?YOL4D6x7K4um48ssvySv/hcQ3mSTJFZs1gHeG60mNWP+L1Xl/HWFEVUak6X8?=
 =?us-ascii?Q?CFVpQqpaA96nC8fw0o/YRZ5nSTcjix0z0mQpgY+rcjMXUFROhqpq6csb+DkP?=
 =?us-ascii?Q?XqeTo5ZwPsx3rxdJEOu/HOhR7QOikRbIo+o7g7//hPsehH+Efa7ieYUqIzSL?=
 =?us-ascii?Q?t1zxtcGBJqzDqxQ9u5fEsCyMdAHkAB8/NaySs6o4IdkVGmL2A/zLP6aaViua?=
 =?us-ascii?Q?6f8ysOYqxLgZ6MKC6xglli7a4i35wJyjHUmWaETwMC9MupAwDfMMDdHCr+U/?=
 =?us-ascii?Q?neU+W+wVwI+GwWsdCwbYvqYUfVVq4vUxIjYZszeYoZxjEdYhwHXOcw0kVzf8?=
 =?us-ascii?Q?/xB8KAJunxLxQgvCtVD1RiIp3z7H+bRY/6C8WK0WsAdkwNO33v3RhIc3Oc1v?=
 =?us-ascii?Q?9jVVKsVHUGeNDLOOjultM4Xm6e324x3fTTThbRoGllPFfM3O4IXnYQ5kjIqY?=
 =?us-ascii?Q?ql8gIseabNubT6047LtlOT0x5faQnp9JJpbw/wm4ZV5mZk947c8Fqhlo+C6i?=
 =?us-ascii?Q?9us6w95ryV7OFxX4phaA08+YyXa0jxB3hl+B1bRe57P+G+ll9PxpmSmxy7aT?=
 =?us-ascii?Q?6pjOqOIv/pBLMds1Wnj7IG1CcGhOBvQB1QBQp+Chr18hRrQ7EOK/Kx9n9uIz?=
 =?us-ascii?Q?lG89646wHi3Dk682kaYPdIi+j71hTtSvidmxecRG5GykSXDCqmBIuaOUuzRu?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bb5JmW2w2QUVkmc+QrPujKbfa8HTPEoGIL4ch4R3bc9tFa63oS/ry31Un9mM?=
 =?us-ascii?Q?8gK/VyoLudsFNfN88ObH7SE/ONWlQ45yLF1wc0Ry3b8RcA30uSpCGIdXL1PB?=
 =?us-ascii?Q?Phi6QvxQwKCN0zvIVyGlQ+ZKbCaGSNIWPMSApxPnIN8GdV2g3ZeVB/gZA4XP?=
 =?us-ascii?Q?nZ23Mv5cA35SD5Mn6d7yaVZZLYrA+108Vis7liEgG6mTmmQiPsJmNW0KWS4K?=
 =?us-ascii?Q?Fx466NRD1rMd+yh66rxG7XI7nebyWZTkFqSKu2XopSt5EL92gxHK5yZWvm9h?=
 =?us-ascii?Q?cnLd4kMfhPfyUsbZMArs0E27Sl5seGJ/69DSZMBadX+gN7k2wM8R+r7wwyXv?=
 =?us-ascii?Q?tN6e4QGsrv3MA7SBkAg53fZBQXhrNbnExxlWbphz0O2bdD3HzfxtGTU+HFEo?=
 =?us-ascii?Q?6b/2b5EwkBjC/Ztf6tdvZXSTmfOV47MvrKWejMKRAATod2sWLti19H11LMKT?=
 =?us-ascii?Q?fm1VHQ4O4F3er104nvXosNNucVYHsV3dWGYjQMmsIjssDAvpWfd8UuEcNUJ2?=
 =?us-ascii?Q?TZIrzkPRyeFUAEAT4BCZIqP+OZ6FPgmrd4+/WF5H4hpGpUohK0SKtvuAJA1p?=
 =?us-ascii?Q?Hwe8TF4m004c5rIfTa1RVx3vFdvLld1ko8WrH29UjdEqHo6ZXx/4uSXRizMZ?=
 =?us-ascii?Q?bUITQzvbFtREnJyfDUoacGf3zgfVuhQHhlDLEcjgOgTfO3i9zoDMUlpak5TB?=
 =?us-ascii?Q?p+N+fMlxL2KQRiYbhgCA6Iu9sDdjv/xWCsa21b0tRX3W1s1ZksrElbHZOiII?=
 =?us-ascii?Q?Lsy8MpoptqmT+dN+kIWHPjELg64N4EHY+GhhvVvTzdG9zhPYz0no0/jx13tp?=
 =?us-ascii?Q?NSsXZ2Kw5cf7LIKu2cIUVOfVRLpbFbCNpTlovGE5LBlicJKyvw/q/bjzWRtZ?=
 =?us-ascii?Q?32gnma7ecyD7qr+ucp3SUYVzyUGv+30WYMhuPXnl42dl1ctHnN+pEHRPAufI?=
 =?us-ascii?Q?e7VgKaXXSVSr3NBFHxJAZBjpVL5LQm5Hm8CsI71IDh7deAePYPQBQjFUyCry?=
 =?us-ascii?Q?PjHR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72081892-47f9-41cf-21c6-08db2a76b638
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 01:42:35.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orq5xz+DUy3AkmQrJftVvysDZDRFXZyCxtgV72O2y/PVt8W7TV551ZbryPUNg+df3IiI8lih1mqbA+/QWZdyHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=699 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220009
X-Proofpoint-ORIG-GUID: _bnWcMxxHgIa3WOAj7psTpLhj82kJf2m
X-Proofpoint-GUID: _bnWcMxxHgIa3WOAj7psTpLhj82kJf2m
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230321 16:51]:
> We are only interested in next if end == next->vm_start (in which case we
> check to see if we can set merge_next), so perform this check alongside
> checking whether curr should be set.
> 
> This groups all of the simple range checks together and establishes the
> invariant that, if prev, curr or next are non-NULL then their positions are
> as expected.
> 
> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c9834364ac98..6361baf75601 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -930,15 +930,15 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vm_flags & VM_SPECIAL)
>  		return NULL;
>  
> -	curr = find_vma(mm, prev ? prev->vm_end : 0);
> -	if (curr && curr->vm_end == end)		/* cases 6, 7, 8 */
> -		next = find_vma(mm, curr->vm_end);
> -	else
> -		next = curr;
> +	/* Does the input range span an existing VMA? (cases 5 - 8) */
> +	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>  
> -	/* In cases 1 - 4 there's no CCCC vma */
> -	if (curr && end <= curr->vm_start)
> -		curr = NULL;
> +	if (curr && end == curr->vm_end)
> +		/* Is there is a VMA immediately adjacent (cases 6 - 8)? */
> +		next = vma_lookup(mm, curr->vm_end);

Since end == curr->vm_end, this lookup is the same as below so these two
statements can be combined.

I also think you may need to initialize next to null since it may not be
set for the 'cannot merge' case.

Something like:
	if ((!curr) ||		    /* case 1-4 */
	     (end == curr->vm_end)) /* Case 6-8, adjacent vma */
		next = vma_lookup(mm, end);
	else
		next = NULL


> +	else if (!curr)
> +		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
> +		next = vma_lookup(mm, end);

Nit, can we have braces for comments that make the if/else look like
it's unguarded?

>  
>  	/* verify some invariant that must be enforced by the caller */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> @@ -959,11 +959,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		}
>  	}
>  	/* Can we merge the successor? */
> -	if (next && end == next->vm_start &&
> -			mpol_equal(policy, vma_policy(next)) &&
> -			can_vma_merge_before(next, vm_flags,
> -					     anon_vma, file, pgoff+pglen,
> -					     vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(policy, vma_policy(next)) &&
> +	    can_vma_merge_before(next, vm_flags,
> +				 anon_vma, file, pgoff+pglen,
> +				 vm_userfaultfd_ctx, anon_name)) {
>  		merge_next = true;
>  	}
>  
> -- 
> 2.39.2
> 
