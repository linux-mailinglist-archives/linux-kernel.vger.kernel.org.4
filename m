Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2E63CE66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiK3EkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiK3Ej6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:39:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53D58006
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:39:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMxM9j026252;
        Wed, 30 Nov 2022 04:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XREUWxH0JAsEPzjck9M1U013SK+wEtZcknpJk/L0LzY=;
 b=unIGZrev6ilndK92/YLqt+m8M8PG0Ewv5iKPEErPQGvChbMOL707b0E/fOoFtFviIQsv
 LvqqAhAolX20rw8gUkDP6u8hpscKQo+w3L9vghO+SnIQ4ftiEdQVdOkQaUs/Bfocj/df
 SpDLaF++rlxm1fCDYUhz/QQQ7rPs+B8sNe7o/Hu+1/LkljoOu3q6q7UzBoCzfedQvxGC
 aokbMP/Vy3Ib7A+zDAj5qUyiSlgVe7bToA3BEMjTZDR8HdsjLGCPzdGQrDL4s9aZdMig
 6MubyrRVXxF4z4pbaAnCk6zR5EKfvdB3GftXfyTXOgMT0kbqLmxQJT/Fbuau61maBILt zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3yucc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 04:37:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AU30KhI027955;
        Wed, 30 Nov 2022 04:37:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3988dmjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 04:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXmuYg75Fp6Hd9hOcswuD8tbwhV+kJuUmguweVFdCdOh4s8Aly66UpeuyvqLDcN5TRkVFsSyzCPEvBzzz8p+kOQlbnJFo6CU13nd9iR7ePiR0wZ5dp7ktH5zfKWTl2OF/yuXJ2GNy+mwXD3voZZ8paqhpPWGQUe2BX9tle0jD0udNjRjZT0yWYWOh+mriAqVStDPGFlfo11OQZZM9w/lLzQVHeD9V0lynfAs2BHwcm2tZ8FoZPHmdHTAPQlSc9pv2mYk6hIDcrQH7qNxx8JFzmU6LQYKrLyIAswvMzG+Q76l0YgMCTiYNhqsaLB2JB2XgXjStS2WhbJr37eOYfxUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XREUWxH0JAsEPzjck9M1U013SK+wEtZcknpJk/L0LzY=;
 b=ND46gVTyfC+s+iOq9BqRxE8cFbB4ot8QBap239qHzbhWn6Bv2652SDbEW5Kqg+DslwOMUQTrGPwxjN7Zkp6D7MOEvEttmHDAg5uKosHMV/tND2WZkGiM5zfRgdzd5tW0cvEPVy5MGj66h7eD4hdmbJ37XYBKv24/XR0RYif1UyXbiGfTCbge5VFTvgeGddjWNT37R2GAIX2WIjDzoOFuAhD1dHQ8cgXj1VoNQLAWCZabR4x62YaanDOiqhFli1vGqISDCRsm/6QBqC/T1XFdJMp87sJftTTdE8NxMbTnWExaP6/iiTqSEIn1txfwWEx+jmC/F/twZ6TIhAxqALVx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XREUWxH0JAsEPzjck9M1U013SK+wEtZcknpJk/L0LzY=;
 b=NVqL9OtwB8aZ5tZsBCGJ7zof68XMr8ofJYpTQ/PV++qbhs9r0huLJG58Parc3vSE/m1O0DHViKAzplkalmwyteTFyQkwHixFCpaORfQtdmtKvqTddUHnBJJAbYhktQtPda8FMMZDD6XtKVX27R8Z4TNFHAu+N2a/4J0hMNrwrI4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6979.namprd10.prod.outlook.com (2603:10b6:806:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 04:37:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 04:37:34 +0000
Date:   Tue, 29 Nov 2022 20:37:29 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 02/10] mm/hugetlb: Don't wait for migration entry during
 follow page
Message-ID: <Y4beCdGA3bVzgmS/@monkey>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-3-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-3-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: c4eb9337-00a5-4e7e-9cfe-08dad28c987e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmG0Rpyx90bfCryDUHi41SQHz+fVN1XAmyfMZWNhvRxX3y0un8zp7Us7Yh1fmfEdVRCjbZ3D/ChdeJHAAaplLClhVKB+hDSJ0dfxr+ni9neOdbAa4segQyMcPoj7naSXIfwaDNzLB2MhHlhLM3EHmv6P2yApTa/3ixg+/6t7tkyy5OyEf+Dg1QPickmj98i2UJoVss3NXdFh24SuKyXTJENw+rZBMnwsdj5S/h9c4VCGBOfMtIRNoB5A2eHRl5q5/W2neVuO4jkgw1kJMZySi5Utj2Gb/0jctQFS8TmTUPIvot1Bi/NENVqULvVCczpbgnwM1nab7bzuYjewEzOjJ8Ur6fQeBGhYUOPM9a/njsXlpzxYQLmM4wyFu56RsyZBK2hehNY0TNtETLwjOS0yMtD5/0DrZWXjgceuo9TLwNwGhfc6Z7Fy94Or1ylWpDVEogR2XPQKqFLZqKY4DUaic5H6PDmHMkfyB0PMQiHMIe0Kh0aVEpUvAN02IN96LTDRmJ0QwQ5LfvGbzLoiPgQr+tpVKBxlUgBt1Eo44lj/3dObK1GvsYNWn5N5+nMd+Cz7EtokpQOHgt69gxwFjRP31z1vKTGup2PdmC8fBXI51eF2Bw6QOSsW1K2OvFwBpwwD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(6506007)(6512007)(9686003)(38100700002)(4001150100001)(53546011)(26005)(6666004)(7416002)(4744005)(8936002)(2906002)(33716001)(44832011)(41300700001)(86362001)(5660300002)(6916009)(316002)(478600001)(83380400001)(66946007)(66556008)(4326008)(66476007)(6486002)(186003)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBReMCBayiI5GM7X3W8Ydv1YnjiqWhIUJfZyvzKFaBdbknfbpmuzjWq2eyyG?=
 =?us-ascii?Q?cw2AiXexlVswWOVZYn2mPTD7sAXgCxfACffrouY982wA5WVLxQAI4sKzAoZf?=
 =?us-ascii?Q?f9gstMUdmQd2N2zvOMs5NeFUfpWVPE2SXjkGqaaMMC9YJ3YhT7P7EgRKWRu+?=
 =?us-ascii?Q?1UX0dfnJo3KVnkEa+dLiPjwL8n4YHb0atxcObBoXB8xsrfv4pV46U10jjcOF?=
 =?us-ascii?Q?ga6ITEu0i/wH1lePAu7GFAfnyVFjqdi+/gN9PDuZ7EZt74Fus5aeFHX6Paea?=
 =?us-ascii?Q?Dr+1xauSeG9mHWJDspUqQrI8DViswrY861c59V/bm3hEc3IE4YwnYzIhyocv?=
 =?us-ascii?Q?JNtVNo9LDnsFoNjih5pFzWj9cwqzlf2qArcABPjsMCitS0mkTU86wjHl0Vvw?=
 =?us-ascii?Q?7xjcOq/+W3LkLeiXnzuOT3c+rc0mS6gfrbLZl8Sf9YhU/cE5cvaNQREcDRQL?=
 =?us-ascii?Q?fJkWvQfmA58VZ4BX9rszZnwB212Xk7iv1myO1IQacHGuxFEAgLOVaB4nkh6C?=
 =?us-ascii?Q?KesTUGVUXDRiNl17ZX9HM5uN0drawY70QOaLLs1bgU7U/Rir8yPI7agIb25J?=
 =?us-ascii?Q?b2SATdXyWdhx0NbGYIlVoIMPRipxWH8c7shp27t1o0R+kBknDAT9ENnWEJRW?=
 =?us-ascii?Q?8vEgG/B/gGTPPITjonEmGlME4tLAy2Zle6OGFyJn2P1UYakpgG9BPazbYQZR?=
 =?us-ascii?Q?asIY8nA4sY9KJPGSZWVgJnFuUjcjyE40brRhxnZBGkB4b1V315vedOqeCAvh?=
 =?us-ascii?Q?hL+deIKYyyBo/aTFBlL+Xc8b4w9JFKZ3cHOd+7Hqb37DWbUndD6TzFnYlPnb?=
 =?us-ascii?Q?MhCRqjMnQKRKu9ihuQahVjGDw9+wEG1rutq5Cw5nUeONlDVrD8DsWGNZlF6+?=
 =?us-ascii?Q?WYRq0WOT+gc30Iii2FWRoZyWV2usmV9YNQTFgYqti8910hPqX1V1uJ3nRn8O?=
 =?us-ascii?Q?2dFzbE+gTaSUcYp6xeZJs6M6+W3YFkR0NFxlBpXyPHmjfyV6jOkKVNtsg4VQ?=
 =?us-ascii?Q?X228oFjnDmnkG5YYpTVrIXL/Dan7+Kxs54zylIeyTA4b4YWpq3d8rNJg/N6v?=
 =?us-ascii?Q?zo86COSR4rPshyX7+yyPivIpkvpPS0zZ++gw34zYeyvs/yt5Zdc03v4xz2hl?=
 =?us-ascii?Q?PCwVT9iXyHZ3OBHAA35PJwD/YeRmAWxzjZ9VwL2r4nkcL/lO7r9oUskKvjcX?=
 =?us-ascii?Q?9GVA5lWkzFtwPu3AoXQp7cJjhydm6qbQdNfJGQZcxpIctL2Qom2elrZy5bDe?=
 =?us-ascii?Q?Gs/A+ewe5xXEqZTXLYhSv8mA+B7+zH7h+gxm2sl0ziRxant+jSkQFs/wg3J4?=
 =?us-ascii?Q?4UBfc5GDnkCVv7jlnrGGapR54qh80dFCJ6AgycUh2N3aVxgRghrpfwDGaUoT?=
 =?us-ascii?Q?5dN3XiWxZBJhELOLx6bm2z+NjMhYffw99CsnS0MSl8YovZ/3wuh0SaVyEfx4?=
 =?us-ascii?Q?rzNZuuzI+6eg72Q+EwVWPxI+SyxQPaNu1Tbg5u0K4zyYeTQuqJaaH+Ecj31r?=
 =?us-ascii?Q?RG7N9yMg/iFh4JhrmfB1l1SMVlL2oAqlseisBR5APR41J/DeCsAo4x2ScGFE?=
 =?us-ascii?Q?HJQ3fwHxCRNHBGgzsziQms+5sTonboPUvQG6Xsfs0fMxqmbijC+KNYgjGpWO?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WsK+SP9TiFsxIw+mJE86HYhZf3Ng0sXZvljiKWzGJ3aLPYSh0bha5sGhQOMU?=
 =?us-ascii?Q?kg4469leo06kfGW/Rll0pslc89L9KrYxZOi0/DZ26sUsXXpJkJrqIhub78wG?=
 =?us-ascii?Q?W0oNE4d1n8ezMKbIEXIKo0y5wQPldyj7kmCy89Ak9ikMkwblM8FBy2SXpoo0?=
 =?us-ascii?Q?SAt2wrpsLZXttKwwR75DVxEIs0p8v/gM8mBIUXw56R4vM/u2noZ96VUcjEBy?=
 =?us-ascii?Q?opvUW/bTCcoGqbRCcuV2n1dx06xDIVLNF5PKZj+gU2BsCUBsHu1B+ejLDXHc?=
 =?us-ascii?Q?2RlwjDm1RO9ld0ZUt7XDdHkgDxdUbrYCDW/Ri4u4pWCp5vJS3vjuvCril0mL?=
 =?us-ascii?Q?WeWz7NsEgwDoV3NWCR3QC2Jz0GNZPVqiSHoBdwv6AKTMkooUzgCQJH4pW/7L?=
 =?us-ascii?Q?DyLxw47AuZ+ltcrEMUlWl03TzZ4KskQkBr/8iYVTV2roF+DxUpxnbsEIYdYq?=
 =?us-ascii?Q?Fyxk4PRDVbLVD814jbEF2QR0nGCbxtDJpsCBylLh5R0wgiz1s5Zn5u2NC7bQ?=
 =?us-ascii?Q?NAgBN4J11RUO7bAQDYhGiI6luIhXGVBdlFF3pqnUcokB8afHjsQosK/PlzmG?=
 =?us-ascii?Q?ROkrsRWhOVWcU6LGV/EnMgxHuq3cUM60qZH8pS9LC7c0fmgAJdM3uFUf/mqN?=
 =?us-ascii?Q?zkmgHslcaDgVqu/+09hRA7tKdblFfsae/rQ/3wfDe3O694kReRR1Y4AoooRq?=
 =?us-ascii?Q?mhneBjj9urXuuREaXOZ/IWctzMlEWVGUH91eKE6pKMNgW9ae5VpNT+IoWPeX?=
 =?us-ascii?Q?KP9u/y3tOs2RLmmpTki9PlRY9oHikNGOxbbqbRgJIsyfgvxDVYqaxmFdtAxZ?=
 =?us-ascii?Q?4bY3VTZmM3oKpKp+6LhN9Y3Hz457CWIEK3o1yqZyHZXfqnLAgOiX03jL2ec/?=
 =?us-ascii?Q?KsZzu8mvooVSLMWtzS5losI0S/cVkQfN+NyUC4r6AOPhYWK2hsxn8Yr8HN6T?=
 =?us-ascii?Q?t1jtCIaCe2NKpaafpxLcyJXAd28I/YZfOThwWbCg/zJiEd6sJ+RfrnArMdZU?=
 =?us-ascii?Q?extRsM4sx1fm8I6piSs8jvZn1SOyyI+79l9bnqe9TO1+cbH0llo/eUnG8T0l?=
 =?us-ascii?Q?GSPp/pou9UU33ShxwtNRV5iPDb2/WeJUtVev+jy8kuz/XGHY6Lg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eb9337-00a5-4e7e-9cfe-08dad28c987e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 04:37:34.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQstKOfQP6NulGmEQXnoAHiAsyssoq+1TAYnJYzIeyJZSDWKflV7UHo9c8zobxUjXrzj4fh/cfO7P3DuY3zWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211300031
X-Proofpoint-GUID: VXPiBz4mIIUaz9NTFsIt3SdNxHVM_2xq
X-Proofpoint-ORIG-GUID: VXPiBz4mIIUaz9NTFsIt3SdNxHVM_2xq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:35, Peter Xu wrote:
> That's what the code does with !hugetlb pages, so we should logically do
> the same for hugetlb, so migration entry will also be treated as no page.

Makes sense.  I like the consistency.

> This is probably also the last piece in follow_page code that may sleep,
> the last one should be removed in cf994dd8af27 ("mm/gup: remove
> FOLL_MIGRATION", 2022-11-16).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 11 -----------
>  1 file changed, 11 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
