Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4470E457
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjEWRyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbjEWRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:54:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387E5186
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:54:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHovUI019773;
        Tue, 23 May 2023 17:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=6JVUPO5l21KMMmjTpRo153uzpWrX8v2dG7oFsIAaYeQ=;
 b=n06UB66aEpb2j9HWbFudq2ufqahNWicfLUJcLi3hPkUoqGFQ/fAiCC2OgQpPpnlFY/rX
 LO61ZZOvckJpAzuhgpXuBY0JWS9l8IwDKP+GbURwxFcN6vVCj2R2guh//8rFdk4UR7NC
 SFhqSkPm0vE1/kkX7TpywB67N+yQ0Uu/bgugkD7z1k+pVXsppc+abV4u0dpKDXYO+iIX
 0EbZzD5qDs/HRGVxnFpZ4kIRdWAkLFlDgJ1K6pS7TJx/cDmSAZ9UB1pxpBWQGh/vzetx
 sf0eu59OZxnQtcQgUo/jYmdHhEz7KpdtDsdg4pniG2hWM1c6BphxtUcOBfrPWNvU58Tz WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mnufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:54:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHb6w9016030;
        Tue, 23 May 2023 17:54:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6jpc31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ9Z0n1AU40GCJnAczS0QCIQMgMWTt63hnjBGJ8t5Z8LfrdDw9QMdrnbRcY6cJkJi0yVh2GsuSnUjVFVMX/1RErOqwR1F3q2hhDlC/xgQlpS9EXYXeUfJ/2vd9pQEL3JZVGkNbY+tqOTZN1lFU6hYgP5B6Rde2ZK4VjARds+SunxNFIxN3ABhlUF8sDYEK3Ss89aIBq7CEtKow4iqbNuZV7WHDZzkSkvNjI2TlCVT6TC62hmJYhMBXnT8UWkTSEI6pb2ooZ6D280kxe59WraFxPmfktZMxXWd7RT3AFsVEFX7OZ3i6LGNGjlCxhXnVFRZKMaTP73JDy8/jC3S7o57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JVUPO5l21KMMmjTpRo153uzpWrX8v2dG7oFsIAaYeQ=;
 b=O4PwHp0MCZ7NIghUYx4P6d/cWKVHvtidvXd9hWpT443b6xjUAtVKbaioo6ed2beV7EENAxTYFSiEWnLcWLDRpXS9iDpB8UHLXYH82iv3Yb/zVA0i9tl2T7d1SknSyDY7XpvQ4qj1cu2jFu2e1gYwK8qBCUeWqyoSp+Npbe4WTVvxjMT2E/T6CJToadELJEdVlFY/FJurAI8FRykaqB6VAP+X+k6B7Rfjoq30r4RJKw8tQGua75QKt+MDASzUWLWN7Cgy/OxdgTjhXiXY8xugW2eEjORF4f7dcMu7l+aVgpTVA0u/PkUeNnJmRald5nPFstOw+hRzF+aGFWng+ZXstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JVUPO5l21KMMmjTpRo153uzpWrX8v2dG7oFsIAaYeQ=;
 b=nQaHwflbnVWoxn9/TNRRJvcLrqtHkE/e/C6siR1lNZxc09cCQzE5pCMPmd/UdCkSxj3SzZwWftmh1cETAXKexqnQjGkV6SLCSOxr/HwfN799/L6uEEBXTlQ2uTlIB41pCzvJVoQxZg2IpB7qJ9mz1s611I3i1QvJ7vbmbZLVB+0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Tue, 23 May
 2023 17:54:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 17:54:18 +0000
Date:   Tue, 23 May 2023 13:54:15 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 03/10] maple_tree: Fix the arguments to __must_hold()
Message-ID: <20230523175415.626iud4x7wpg2cu6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
 <20230522050656.96215-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522050656.96215-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: e6714374-7b7f-4a9c-4c34-08db5bb6ba8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/8JF6UOvBLsOpBtknPHr9CPZox7fDQGDcJfwWlhQeIGov5t8Tygkehy5y3064RRG9jsIImyCaMweH7isPAMdUToV+rjuehD8e/PCk1nyfBlsVdCGHrnyBazA7bke11HuDTfHxeQ5mFDF+0JANoXdsj6pUgDcZPjoLmJWMC4RiB/EMMbLLY4bkaFJ8AAgfMcr5smu20c9/R2GSSCiXz9LhgYTOBx6AOFkV4LGqdYAQ9TAmAKfBGH7vakXzRAqK0ZFC8BZEJV2ABG/G/rag7yQpLXW3GOivzatHIJEg30eO6pJCF9a3Ovkl6t/hIb9P9URX04ryuybHdVsXGygE4iQ+4aR0D3C+Pb4qSYFx3B4XkAu257/f62nUmXdppGx7otbrWDdXbo4QC7dJu13l2ih6u3JYCHYzYzIvyusRoryxDDZN9kk9lvP5HO/5bmynWxqIcaBNfb0Wnm4zE2S7cCD+gU2lJd9frDPnDkm7H9B6UAa7zwYhxf3AMR6AU3dLVm1Gmq2lfMM1LZ1FBbpEjEGPyAFuwDIAXvus6f5wuNG8ueLboKV8U3pwKqu2ESoJmU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(41300700001)(6486002)(478600001)(316002)(66476007)(66556008)(6916009)(4326008)(6666004)(66946007)(5660300002)(33716001)(86362001)(8936002)(8676002)(38100700002)(6512007)(1076003)(6506007)(26005)(9686003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eeId1GX/0lujyQUyDyWBY0Xxmr/X3UVnay45CK3Z3HDHDzkzG0Vdz7XHc40W?=
 =?us-ascii?Q?yzuEu2AKYb5hPxANJ8NGIABV4qgjTTI6+tq6rVFD3Db2x+AQ9qpcBJftSYEx?=
 =?us-ascii?Q?mhT+0o0rwHFrqOva/NirDFID9LwHuSQzvTfigtKfGh47s7KsrJEUYTB50R67?=
 =?us-ascii?Q?LwDp4gCLhlEqbnfnkkpdnlRhfUQDG0ffqDMlBfvc0AIVHe2SztTwD08AeDeG?=
 =?us-ascii?Q?mS9b8l5D6dnkdffXnHRcYA+NsZfItsK83jqnDabp2XZ2jVggHTxiHADrZocI?=
 =?us-ascii?Q?NiEwbkktzD5NcyPu79P3A7kShnS0kgij41WNvDozqEGtS6uxt3XisNjRyvpx?=
 =?us-ascii?Q?UXgu79q0iUchDJJ5vy59FQlCWfLr4QVW9Ebm9lxUnh9NKVqHryOY6HV123+O?=
 =?us-ascii?Q?9gUbf28i7lMN+62UDXm6pU0p1vMzsypK/3o5lU0NZw4B+Ta9RcAocgaNTbYM?=
 =?us-ascii?Q?RnpmgcIm1LT2+An4SLVESpG7TkXB8cjrmAJQg7IREZ2UxjT9fIpZOBa5Cz5y?=
 =?us-ascii?Q?ETaA2OTm8pMYBVpLzqXORTc/KAaPzztGWtTvYmwEwS/yDYlB0RSrjvJCDqIW?=
 =?us-ascii?Q?XR+fNGQPwaY5Bi90c/9hw9xuDFVOv0YLCh4DCGl/QpMXxsXjJ3EsmgWPXCIB?=
 =?us-ascii?Q?7ZvvVZq6a6gYLqeEMZZ8rsYkl8UYoBgAHd2N2J/8VAG625PVnAlt7o+X6O6S?=
 =?us-ascii?Q?ML5hK+okpqG5LsgOhw3c1QdNe1UgMCDz32O5YBUg0mlpvoChJac1ZMBzhoJ6?=
 =?us-ascii?Q?aXXPglZxFTdpI4tjxELJ+KiccXV5jjQDz7mNIcOC/MR8m6P9vuQ+gthvf5m/?=
 =?us-ascii?Q?khd9TJ3jKj+VKaJ037tnq4rO6XyInEN9Fm/3TvEJxlQNYblf4dNIx1UR11r/?=
 =?us-ascii?Q?WTAz5Yy/O4BBSCJEd0XIu6wO+4HtveWSqrBhDlBeCH6HYGvnsRSyBr2di0cf?=
 =?us-ascii?Q?rN8flk5t1/iAhmnZHgNVatXD4+7KP8JReogwN0PAS+z08M8wulTfRqz79kfz?=
 =?us-ascii?Q?J4tjqfiwH8ezn751qb4vFYqwN0BhF/uoJqM4DJABBYEpZ1CIedJCN8ELfQI7?=
 =?us-ascii?Q?n4g0zQMF3/MmFojCSEiaau55nJWDxzYaF11kJm2SUhVaDaNXBXbFQNE0vVGG?=
 =?us-ascii?Q?WhrHi9vdBK2PeqwSptCBA8Ag0zXop1wt5UWF8BoekUkU7Nvzbvb9SMCHTnyY?=
 =?us-ascii?Q?s5HdgScH/DhYBWIbo7OeMycnOZjyj/mv1z4AjlGDPJg67hUlgkaSgtaal/1b?=
 =?us-ascii?Q?YLaLaD4WWaX3uHVcndeVMf6evkIJ4xQh6Iac/71jO4KlAMME2MjEQw+6Rt/t?=
 =?us-ascii?Q?NVC/EJ5mTNahUsjBlRI75DlenieO3OwOARxBJM02r1Mssl3+Dday4d/CWNsD?=
 =?us-ascii?Q?TXBGYHO+rvyDmlae52tz9+kbsmTwBlBWKoT3CCvSQ7glFP/wQF+7YzZ17fPj?=
 =?us-ascii?Q?adofhgdl7Q5zfkSZYshBkQnTbLG7/HHlJlPd7kbIGSWrDRWzUEVUwbqyETHz?=
 =?us-ascii?Q?IEo7UVHXeQCbR0LnL9S6WGuLkssmNb/2OegbhV9+0gA0yeiP1Di/C91NS10U?=
 =?us-ascii?Q?v0DDzX38eu89QGQxUCRyMXe/NPF5XOR0AVnBzFYv3mXnFi9b8PS0LmgGCnrT?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N4lcLmdiKAO5Fhpo2DWgMOi3GjGFtPNVMhMIt2pSGU0Bogq0HcDOay8vhvbS?=
 =?us-ascii?Q?r4bosL/W/KurNbtNUnpuqYAiwBF3FPMjpQiM/Ueb6Q6eRVJt+OjcrOScdnHp?=
 =?us-ascii?Q?1KQNLKh4hLSS5YVlGYOjB9JDxtj/CLR1OYMgw0nU9wViDeH2ERl/dy6/yzEN?=
 =?us-ascii?Q?ljqG+9LDYIHwFT8O17Ic9X9D5hrLOYaN5URtZT6JZiswC/nu9K0ITTviwA5w?=
 =?us-ascii?Q?7sJ6eSOhUBIE5u05XAOcR8L52cunaVhVJZBL1BLS363A4kDu9/UGhXD5hZQb?=
 =?us-ascii?Q?H6mDbXMTCLc9DI997TsQtYEN/TdPfw5FsBi0Oh8DajGPugtw6BXivC7IixA1?=
 =?us-ascii?Q?WeA0NvX4kMLYTyl2VTTMWLqVceHvoUQmqJJt6dddR9ne/fRPTf0JT4tCdYJn?=
 =?us-ascii?Q?H+pJcxK37TvNUZf36fpKLFKQ5u8JHzAww9Z8Icmfeg/wXmaezGy4GBFzJTuJ?=
 =?us-ascii?Q?w6oBuyKAkxZn7fqbEZNpxmE2Zm36obKIUwV3vLqvTWE9mqUTgDQxzJJbHte9?=
 =?us-ascii?Q?Nov35+nqY24QrWb1vamd1GD8WxgQy2FuJLIfRanlmbbb+zZRiKnM5d87c0zc?=
 =?us-ascii?Q?GLPIR+OvrEHLmRdL9Ds8mDLvngXOrwrqUxFCQkOYhzKGsdkYW0OacPKoDkXL?=
 =?us-ascii?Q?Cif8P1fJBvecgn/7G09+SuYy0qzBFhh1AHW+bhe8MUsVfKBhAqOOBIGn8vvb?=
 =?us-ascii?Q?3YyvuXUlxfdgrBRHvOAmTYSQ321tgL3uQO/YTVn4BZRjvKe3cqqPnQNteeha?=
 =?us-ascii?Q?rJVZcQZqw15U99ZpBj8NPCJ7E+ngE23KgoAo4aWGd6JZyPuzwlaZ1KWgaTg+?=
 =?us-ascii?Q?ilp2kxnoKGLbxjFB9rAaEdFsmiIugErVSPmzuaSwjchp58WwOETypkyWuUgg?=
 =?us-ascii?Q?Y9J2LeeYpeizyrnmT/YtDL/hJhtJRfMA6wfktV10+oe5OWPu/ulStyp4yt5M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6714374-7b7f-4a9c-4c34-08db5bb6ba8b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 17:54:17.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +csRmfAssVGII8nfJSchSOWRxx+QI0wO1ohNNhN1yLnUxBVDzRS4J6xoe4wulMRdaIM4Lg4VgWtpCvsQ18s4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_11,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230144
X-Proofpoint-ORIG-GUID: tYJnLUN7Mea0j3j07echmnsbVAGwE-Ne
X-Proofpoint-GUID: tYJnLUN7Mea0j3j07echmnsbVAGwE-Ne
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230522 01:07]:
> Fix the arguments to __must_hold() to make sparse work.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 263bd0ccc31b..3fe6a6685384 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1752,7 +1752,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
>   * leave the node (true) and handle the adoption and free elsewhere.
>   */
>  static inline void mas_replace(struct ma_state *mas, bool advanced)
> -	__must_hold(mas->tree->lock)
> +	__must_hold(mas->tree->ma_lock)
>  {
>  	struct maple_node *mn = mas_mn(mas);
>  	struct maple_enode *old_enode;
> @@ -1792,7 +1792,7 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
>   * @child: the maple state to store the child.
>   */
>  static inline bool mas_new_child(struct ma_state *mas, struct ma_state *child)
> -	__must_hold(mas->tree->lock)
> +	__must_hold(mas->tree->ma_lock)
>  {
>  	enum maple_type mt;
>  	unsigned char offset;
> @@ -6204,7 +6204,7 @@ EXPORT_SYMBOL_GPL(mas_erase);
>   * Return: true on allocation, false otherwise.
>   */
>  bool mas_nomem(struct ma_state *mas, gfp_t gfp)
> -	__must_hold(mas->tree->lock)
> +	__must_hold(mas->tree->ma_lock)
>  {
>  	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
>  		mas_destroy(mas);
> -- 
> 2.20.1
> 
