Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841474B777
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGGTtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGGTtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:49:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B186199F;
        Fri,  7 Jul 2023 12:49:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367I4E8w006111;
        Fri, 7 Jul 2023 19:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=oweUE7MLGJ/zQUrjQE8QHdytzxsqi69jr97xd5UWxMg=;
 b=VwDmgXExlpWEJWG5kIpjoK4By/y0z3ckBihiwn8UQ2kPX6uDQ2jmjJ5ozhFsE9PEduO7
 syDIqF62wGqi5GRYnScmKQb8Ntfw4WXjbMY96BSrMITTP8KMAvPLYenj9wdWpQpKvjWd
 Eeq26KuZNkWe/uVr8nkr88g0BHhWlEQt97LZqqQ+FP1Kx08cP1UaLjydTHf+E5mpIfco
 ARlIQGFMfvRnReAGYWzMa8j9XLVkrLCimUzJDk9nexWcwItbQyB8TkW2+SfXMY4qu3TD
 gy6CLjIOs0BFVFnQD1IKsy6b9qnmiTc9AOuWpHIXommvQPoA7y+dMC9yiUcQx/J+Lf0/ dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xhp4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 19:48:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367JVDDt013524;
        Fri, 7 Jul 2023 19:48:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8vdrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 19:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdzHIm4Wx/Qg7en84r4+4WRMzaNuEJeYXgF6Dd8Hm/uQNH55lEfybj9U+QYNP9ZiSIGujYQWAGr8j26Pdf7AFrn4FerZwqpqe3BPjf640jDt17E+TZBrhSKTP6s/QAQB9cFXmSiViigZ0jMDoADkIloXZ6Af+IXNK4lhsqdrWbGI8iUZohLkY2r3kbP6ikSh2XtAI2HLlNBSXhRL760Y0kw4V8DiAKYpBAM+uK1dC80t5Hn3rwx3DR3AnvRidDSNQnVjTR+s/Lgk+iSikrGdcdmS+xxs2aNJ3F/SxgGUK5T4u1W9zaxJOxcDifcE3CoKG15y1djF/nioJXou7XGxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oweUE7MLGJ/zQUrjQE8QHdytzxsqi69jr97xd5UWxMg=;
 b=afBjRG5hRHJx6OpLUn03gZLd2GBtDBPHY4+7DYetYG4qSsZOwdUqq96RhCX5DY/JiOHr5gMfAo2SfHc3COQJLiArh8FXsZZtiUN8I9y1qr5r3D2eH2f0oNZwr0lzsra9G2RItFXCs16+1+35EQ8pIoB2BGCHedaL/NIOtlYGgbzTVtAfhUg2UVqZklTNXFqVMvrn8K1YSvkYEqv49TtP4coq/dHhgaznnk7jyoO+Cy3PQyYG3CMFL1T+eLHNauhvvGJ0q8U9/KAXb9RX1vQNx7Xlc+RJ5UZ91aBP66YRHSaoc4alxW4D5qusNHxGeFsUZ8MT05w2JePw5etcD9FWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oweUE7MLGJ/zQUrjQE8QHdytzxsqi69jr97xd5UWxMg=;
 b=JxvqFRP2TRtDGmkaS4qlS9Aosjqg0tpBwMQXM/+y3g2/L2wHUIx1cpr8eBGOsasIN4INFQSc9CqfB4zvg2dMMC6PxkAMYRDhiHiKd8Iyw5vUmLd7RRfrfZ/y2BH4d/LIePDUXCbwGripO3R1E4YnyvmS9YEYEb7njaST6GgpL+8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4648.namprd10.prod.outlook.com (2603:10b6:510:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:48:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 19:48:34 +0000
Date:   Fri, 7 Jul 2023 15:48:29 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/2] mm: lock newly mapped VMA which can be modified
 after it becomes visible
Message-ID: <20230707194829.u3p5zfjckmh6lktx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        vbabka@suse.cz, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, hannes@cmpxchg.org, dave@stgolabs.net,
        ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com
References: <20230707043211.3682710-1-surenb@google.com>
 <20230707043211.3682710-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707043211.3682710-2-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: f110d991-9025-4e79-cc95-08db7f2325ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Zz5DTz5lf7+/zbRAS0c93GJOoi3QWs0lH2QjooC1wSztaNH1TyeW8d4dD5tMasorL53K2uMRERpdmMbZJAcGwQgcEP+DL5BbagfwUGdE8jFqs495v7sQXIpaAPIa3A62XmwVmFR/74G+Cz30x4nRWIachiaKfSBtBFvXC8x9kqHJr55XHkDKhIPUkfQ6I0oBkZxTScCXw/Qezejm+CoGfIk9nopMW91DPh9kTcBv0HKH2yNRQDLZyNFae29Mh1f9i/v/5L4NqE1IWWg8DgTpT1tdp+uEghMvO5YhpIExicG3rrehJugSfa+MgghjD5rpkU2miyaXkuu/PRujKARWzC3oCaqPhXUdBSsr7jeMVt2+e6pe1IhA3xLde+rlF3775mS1Z0xL8rgFf16TnIgvxRRD2I3AqcxNCK5yU874TZvuMq+m+66oDHAoN+7MaCgw/mgpp7C1bIRNYqBfDsEszC0jUB84weg0bO3aZ5k7+UBtexCVp0rq/qzMUY1vidNNMznLt4A18IegwcBmGewweG0tSrocR3So38rBRv7F/g7smXB0ExDbNYaOqSORNfX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(8676002)(8936002)(5660300002)(2906002)(316002)(66556008)(4326008)(6916009)(66476007)(33716001)(66946007)(7416002)(41300700001)(478600001)(38100700002)(83380400001)(86362001)(6486002)(6506007)(186003)(1076003)(9686003)(6512007)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Om2k7l66vyOSwZk7bJ8iLVSlUyLl+7gPAKXPhHtbP2Oo1hHSg0rmLpedtbJT?=
 =?us-ascii?Q?RtNSDqpsRfqAfpO0bd5Y42ybjxixUAjAUgpdzvVbKzLXf3wGShGWnmbkZ6yq?=
 =?us-ascii?Q?LQUW9/lYO0NrZX86MbhcGouJAppwjfJfGmaR4jQfTUjIaJj60rzaUzY1WrTK?=
 =?us-ascii?Q?E/+zWR32xWfKVHZAgX/fXBZnfktT91QwkUe0VuYYZ/KA02zTNABrot8ccrZW?=
 =?us-ascii?Q?jnm0l0r9Mr55E6dy7YDtfLA9s1ZLM82EApzVDCTLJ+rkzd6xRSxbvxoWEnc0?=
 =?us-ascii?Q?O6P8m7rrTHz/OOKWS+LVmSpsaCQtzj2iH6FZeQfuwITaEJad275Q45Hw5/QC?=
 =?us-ascii?Q?tsHhfQSnP3FEMCFGYgJt7g0I1KSSeWD/tG7G9IIK8ZbUiIDRbqYG6WjUFj6i?=
 =?us-ascii?Q?H5Q/3nmIBCEva2q9OywnlZF4hjXfFHTdAnNbnW34RECKq9xIDoyqNRPi5Q+F?=
 =?us-ascii?Q?ZAg3GFf7769KhiDTgwIGMb2AEEciUx8zu6+5uewCJAzk2hx5odpxwL1wvyCI?=
 =?us-ascii?Q?6MOXK2ByXfKCrW8jT037L3jQGFzmqJEVi9go9HxUEEEiTPLidIszowPC2erh?=
 =?us-ascii?Q?lqs/9wl5kpAhCBNuLGwYl2GRc57e53MXOBt22Fx/hC2ycYV7mknivcjpRDQ5?=
 =?us-ascii?Q?rZeMWu2NhCOsxJjsr2o6aCy25dAgly+3mPSqhw8OSHAr2OVSIl7XD2zFlJRT?=
 =?us-ascii?Q?vygY3ZG6uRLIb2jSsN2REtza7oEj38A1xTfEfFDhsqV/SO/iqrjLedds0ITw?=
 =?us-ascii?Q?ZNPR2jUTMoWN3SV/kRpWSiksbbneIeb+kgoFkpiQq5XdLKzBmU0wlZv7CDy7?=
 =?us-ascii?Q?8FBaEgF4vf8elC+Ef542vsy+hsWmsITGA5lDFYr41IebZAT1A0MSf/aWp/+n?=
 =?us-ascii?Q?3mXjXZ1HIr47Je0G58o36X2YcQvbzposFUCQx85q7fKaVUtWEasqPmK7Of1Y?=
 =?us-ascii?Q?RaGUFtid58PjvL3pmuBDQB2Fo5fPtdgTOqsl+NqjJjHeTGhFjDOU1J2ZpmxI?=
 =?us-ascii?Q?T/oEw9vr6BCB7JHw7AxvhdGzLqtrlsqs8RmDtNulP8yVZoOvTORxiBXyRRsG?=
 =?us-ascii?Q?YzfMGYwUf9y5PzwtotstHpj49pu96hnHwc3t7EIWj74BF1ifONS8StO6UjCG?=
 =?us-ascii?Q?Vy6019bqdaIvmNxqQAKgFrtIf6KCN7Umuds7p6FRa6PyvLq2N6ivoGiHnar7?=
 =?us-ascii?Q?ZdiXpH6w9WijWzczcqNavfVA2EguhvIzeq9DOE22FXljylmwCyd3n6wjiiir?=
 =?us-ascii?Q?99MXjStHoerQQ/JwAEGft0vGMh9S4YlUkLyr/TcsuEW/SvQonn3/x6ahqkFC?=
 =?us-ascii?Q?UI07SN+w3rXGOaaTujHhW+gJltGlqQNmzByifHaBrXSUtlSv8xdrChXnuxbg?=
 =?us-ascii?Q?/SXNwTvnne9Ka6N9HCdn6sjELm/scEqZJgbopMEcvAHQZsuWuVF1bp0o0lxE?=
 =?us-ascii?Q?rtux7Aa/bTV6KSDCkq6SpLxrAMEyAFu/roEZu72b8B0Cy34G3oGTzFNEb/G7?=
 =?us-ascii?Q?Joa9HA51CNg2pl76Zc+FCTdigvS1MTH8FxFoBaV5msuSfbzmoFmOqfZGx9+5?=
 =?us-ascii?Q?BVDsR43gu6q3/jgbztpjBDIGIcjJf4afA4itnz6ZNOf+iilksYWJsN3bu247?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N6q7GBJhpG4tohNLCAMSGuq50vrgkjvXTb4Vc4AlnGkVHVZwhAeenpeO/o5c?=
 =?us-ascii?Q?n2+P1jZGZZgik9vLsUFRhBJoqQpWI8Bv9O/wbFz5R80XkwI6oC9NCU2QLhL0?=
 =?us-ascii?Q?CXxHQXx06aLZRgQVIj9e6N15CXfh+9PqYhMf3WQmGwhVxeKvoWXH45Nssolm?=
 =?us-ascii?Q?ckY9HI6CNpkkzX1VfBWw6WSIioA7r/Qrnk/qOUgMgHVpnqt3FC3olpLNnaDG?=
 =?us-ascii?Q?SOuoZeJXNL5loMAHfm/LuklpgSbpScopjPOEgBi2I4WoDPLHmASRSciw8Uqz?=
 =?us-ascii?Q?yPPd+Y1kxv/HkL8CqxH+5psM1C/omhqDkF23G/pkMerHKstZmbG37uJKtUF2?=
 =?us-ascii?Q?4tz23sj+B0J4dbUz8XOAPlieSVldllZ9FpnLPC21kx2yvVBFE5Ut7Va938w7?=
 =?us-ascii?Q?CKByNT9jeMK+C/M7CCXEFdUvy4CX8iZsNCroZ2GGDvedxcR3pjBDt/ZfjZrB?=
 =?us-ascii?Q?otYZw8YwcaWxlh4BSq+xM7Ul40NYpphUZDW89a7t9XPf8aK0/0XfSODebwGL?=
 =?us-ascii?Q?xLhI/af7azyT3dRJIGBEy18yEFS2K01JZW6BHrKC0zQZwk5AS07+GVb8Ymf5?=
 =?us-ascii?Q?PcPmwMFOKwrufIJbpLNr1gbwwjXdquam4qG/Wtvi4Ojv7ITVAqQAYBBgQUKy?=
 =?us-ascii?Q?rb4OtN8QpII++drQs7RY6PEMtMmZKJbF/pWhU6+Sdrt3O7bweEQmlhWamez0?=
 =?us-ascii?Q?Dc1wslkSwDtcwPlKYQgoTSYGRIu0pdwelkD6ItOy/073ZU7dOv8f0h9IX9Wx?=
 =?us-ascii?Q?OX1BEXv03vXgmTIvedNhgRl/rdLIa7NNEPHs4K7jANzqiQ/lj9PErLuRGhzZ?=
 =?us-ascii?Q?TO0hPCmCvipetUyUHl/rbcx5P2pKLijCH57Kkue8UwdTCQaw/WcBkyqiUoZA?=
 =?us-ascii?Q?LMiSxz2ITA+xWuUnaTggvUNCiST+y7Uk5qYtIqWqBSosGMkVpU5bBnEbZfhV?=
 =?us-ascii?Q?7v1+fEgS/LrGpx9WNjOgSXqFsLmm9hRmU6fMk8hBy5Jra3C4z0XZVAS35fiV?=
 =?us-ascii?Q?57R4CqD4XtVaGgOyrQpYJVcJC80P4SvhhI3mAUnze1qXLCMVmok2dNUnVim7?=
 =?us-ascii?Q?hZxR1zs/bBNKWS/pUuugjLjh6UhHb1CDjD4m1jpOAU4GGjhmoAWxl5qIyS7Q?=
 =?us-ascii?Q?k8eHMTGt0JovgRojcVRaADx//OFeh/RZ2q/3hNa21myPvRtC0m7igGbbe201?=
 =?us-ascii?Q?tRtuh2BEvDMoyHBm5lVWMbrD9P6vYrSnnFaGeg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f110d991-9025-4e79-cc95-08db7f2325ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:48:34.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPs0+YGOA2m3KKVeAco1zHB/yze0XV2dYooA6A/RtPXb/vloy/a2os9tzUgn8Wt2jY8Bs9THe9KY4mYU9fu3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=707 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070182
X-Proofpoint-GUID: lkogRPUUvUrIcwChiqCiU8Ke8gK52WvJ
X-Proofpoint-ORIG-GUID: lkogRPUUvUrIcwChiqCiU8Ke8gK52WvJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230707 00:32]:
> mmap_region adds a newly created VMA into VMA tree and might modify it
> afterwards before dropping the mmap_lock. This poses a problem for page
> faults handled under per-VMA locks because they don't take the mmap_lock
> and can stumble on this VMA while it's still being modified. Currently
> this does not pose a problem since post-addition modifications are done
> only for file-backed VMAs, which are not handled under per-VMA lock.
> However, once support for handling file-backed page faults with per-VMA
> locks is added, this will become a race.
> Fix this by write-locking the VMA before inserting it into the VMA tree.
> Other places where a new VMA is added into VMA tree do not modify it
> after the insertion, so do not need the same locking.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c66e4622a557..84c71431a527 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2812,6 +2812,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	if (vma->vm_file)
>  		i_mmap_lock_write(vma->vm_file->f_mapping);
>  
> +	/* Lock the VMA since it is modified after insertion into VMA tree */

So it is modified, but that i_mmap_lock_write() directly above this
comment is potentially moving below the insert and that is why this lock
is needed.

> +	vma_start_write(vma);
>  	vma_iter_store(&vmi, vma);
>  	mm->map_count++;
>  	if (vma->vm_file) {
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
