Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4474D991
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjGJPIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGJPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:08:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6293D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:08:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AChZsg016621;
        Mon, 10 Jul 2023 15:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mfyYjv116VAzZo339cVcCRzcWsGdvneef8/MsSoYZXw=;
 b=A/6fhspK0ymAhhl3clMrLKoA9t8K4pacdcJF5y+AaC/mMyNrq9uRGKSW9pJIOjHkry+i
 GZPWiXKtNfR1yoDM+k1TxoxduQxJ+NWPa8jQP0iFW3U9CoJmQ014TZneOV6b/zau4pLL
 sjsHyxoGS3l6kwhvaeiAOX1/t7PrkWzWyzGYEAfqeyBfUun3E1wXajEIVXL15aJuCu/U
 IvU3QxOtqqBPuLOuVIyiDABbLHbkATpakHjfOA08YcMKOjyuGsFPVD/SSp2UlnmnGs8A
 3BGfxG+cFULgoB/E3wvLqI8FOs+ObAYAHLxKfuKhisJFFKAz2exnEdJYoqGyvlP//rcU PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydttpj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:07:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AEYm3a015855;
        Mon, 10 Jul 2023 15:07:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx83ksr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 15:07:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nqr3IHeelom9cEQUZpsuNUDRZhwDHC3pst5zU75rFYJvcZJWNqUqKuTh+pU43al5pS06NbJ2+0uHECwRWHSwFor5ni5/E4i3HnynnetrJ9sRj9XR+4BLUS6J3ucV2n8W+P9t5/fwT3D9jzsUrl7hXWNKDKf0wc0uQ5GeRhHagar+ZQU/wKk+/5ATiSXbEV1dRXFO99a037D8CbV7fGrf8/xBgcCcwkibpqISOdC229TKptngxP7wWoLkK3XqywWFV1duOZm0fAzZ7YOHLQm94uOl+3oRuMARH+s2mGH4ca0skxPMgSIxb0/bI6Hr1PtXu1Tb9l2tmm2v7n98VdSEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfyYjv116VAzZo339cVcCRzcWsGdvneef8/MsSoYZXw=;
 b=mIcCt7pWm5A9qwrVqfSRPWuSFHt9rTLuVntb+IqGddwPS2LOUPKnxGOkl+khLcT4reHZNuPfDJtcENX7FCIR+KssIBqlWMW4+edK+KiFSR0HzisRu4HgYMdYzVyr8/sGwNaYq83uMflDjNGqy/6L+cgKzza0GhHrSYosHdgPqQesAYaln/74TDPYl/3/kb5xFuuA1pPg+MKh/qrHM4EvUhxMo3gLKYM6dEV6i5FjvtW8l/xtBuMXY6QXk6Wq1t5o1jqP8PtnBIhTXJLZjlJ5xluysbC2PEdudCECREOtuvRWqrxsJReaFh5ug0SYtMHe6MOWETUDu8KgoJoKpUayRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfyYjv116VAzZo339cVcCRzcWsGdvneef8/MsSoYZXw=;
 b=FnzkMUizsDWgaqKpUsH8TYJjKY3QnZ0GcTra3w02W5DRyM6ZskgWVXN70/Ba4K4W+EeI9VhB03Jw/slcxW68RC/uH5nSq2nGv+nuthcCn+Wzs98Zv1qsdgr6XnfKAVZb24PgAZvMOtI+JdP1cNlZlyT4u4yUi1qXXaLF4ZtDEy8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 15:07:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 15:07:29 +0000
Date:   Mon, 10 Jul 2023 11:07:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH 1/8] maple_tree: set the node limit when creating
 a new root node
Message-ID: <20230710150726.orwwolf53i53hlro@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-2-zhangpeng.00@bytedance.com>
 <20230707151819.d5rvxalhewdv62nb@revolver>
 <20230710150532.hvj7jzc5ep73yq4i@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710150532.hvj7jzc5ep73yq4i@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 691c3f39-c9ae-462e-0194-08db81576130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtlHcptL0Z/8zJtUycntz/e3id4yG37P5oP635QERT9GIu0WaIoEO4VWBdMFAS3/YVNCSeSQosBGmnK+AGWVIGLeaEyHyXIRheTSEsivlQqHE2lyNYdHcB6j26QitHwGFfi0UvVExJTr5E9zgJqWYHvdYKfVuAi4GiNDUioMeUUgTzTztiIYurj5AbXTlQB+LaoNpfCd/4MbNgK3HGj4Wrm5ggifd4iAFTw0DWoVHDjcntWnOlDlk/7ak+hgKTm+Qo9e9VKXPUuX0ofQQgz+R5FVdn2LQgKtQkfRuYi+pu/TX5CVeOP/kKWwTwTaWrEwoDIxhcfZrA4gUVtD4O9YYlh0oDn9TR67l+DbK+qI3kEZjrMRde0Rc2lWmHvWpHB95VrZm0EfYUyr1Z4+q8VU6ZgLW/AyEkT3rmCBdBpKHBYDL8SFqMwjnPMWUNirO08k9TWWPzXnhhS/BNUKjVkThfn+9cIg7GaU18tDk+JDELVmdReIGK2K/hKRqMGyNuI7TNmq69ASuvsg479GttI+qABlUZsZfvglffs+oECXAm6otPv4McCDJQAm3cBCT0ptaz+vWynhd7TqMrVjrIhCqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(6666004)(6486002)(478600001)(8676002)(8936002)(5660300002)(2906002)(86362001)(33716001)(4326008)(316002)(66476007)(66556008)(66946007)(38100700002)(41300700001)(26005)(1076003)(6506007)(186003)(83380400001)(9686003)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zTxamHBNkR6z3tMYHdq3U2b5MYfO3OH/FfVX8QukgixkGxbu/yAUnLkOwkf?=
 =?us-ascii?Q?yOBjs+iiXDhNC4/4OeU4eyv6G8zW4edi2fkLHDe6+s+knVJoaj3OT8218iaA?=
 =?us-ascii?Q?WCtG5UyqZi/NxzD3qbBjoLLlrkSWVTAPE9Sh+xwPSy6gmRWJN6Z0sIN5GB3b?=
 =?us-ascii?Q?/YNtpr7KTqqXebEEJnJJpNpb6wFoxVUJlDKPdOZJk1nO8BxcpnygyBYcJ+mj?=
 =?us-ascii?Q?FkIRTEvilks0LFX1ipeJbN6AoR/4k0mJzDoPyqRBG90KnJeF4EghWSj5XeUU?=
 =?us-ascii?Q?Ywougd7DWJ2/kjZOaqFHNPr+LmIPjqHQbHncIifv67U1KxivXQmhFd3Cai0f?=
 =?us-ascii?Q?H7u1bndy8WXJWZiBtDCC4H4rI9529LKTDP/YzFjJ1skBK2Nb6BSWGRBn/Bmg?=
 =?us-ascii?Q?rQ+Vu77kHWKgoEUufDhfB71XwaXOVkHJqpCafAgixBm2lbOxN6G5pvWGlvt7?=
 =?us-ascii?Q?noE34ZnhThYO5PrzSeRT4OuvkXDwOUXkjRssA5N+afnjSCQRMBPfRaPIE4nw?=
 =?us-ascii?Q?PfDA0I5p8A0umhdXxVE1bGi3GJM7naYBv1X9kX1nZvIlOp6uSb9EWz89e3Cy?=
 =?us-ascii?Q?Fz9+x/JdqNeawNbYlU9v/IBl1hLw7qf4fnGnOzqEKMd/u86ZJCOiNjWANIcN?=
 =?us-ascii?Q?FN/qxnoJlAE6KA8FlRE7St8P1Q04zkpwFdiQaQNJl89iOT/HmY/FNUM251uo?=
 =?us-ascii?Q?CzH5ynhlyVIAY8Yk8O8GmKfy6ngQVRDd1p8lTMl+aJrNPKgpD7zCIA/8RI0x?=
 =?us-ascii?Q?2bDfQAeJUNhZUQmEezjXgND2J45lKzc4SLdvXTXDRZEqo7Va5NRwSXwK4fO3?=
 =?us-ascii?Q?WjkPJcecK/93+P4YXyaQPml2rZu6NIkBNY5pv9a1Wx8aXQgIzxc8C84341vN?=
 =?us-ascii?Q?zBuylscXobKSXYz6xOsNiQUpUgGqzDOSROc5bluEab+XrJmugdZbtY/Yk2KK?=
 =?us-ascii?Q?xGC6A6Ua8aRC2iywa2RTi+vlqNZZfcGuZx2guUxXphtaKzmjIMczpaTjVejR?=
 =?us-ascii?Q?hscLq2dCaOh8okaHaXdzWSxNiaytUTiWSXFGOrlMs/XSA3Zb7PVD1XrR5FHB?=
 =?us-ascii?Q?o/xW2FbaiurUqKrCNROk0uGmIxDiLztuhwE1n7cgqCCuY7TknSEO02FhvaJr?=
 =?us-ascii?Q?TNH38blBuSsEcqT0ik1S1k4Fqdpzuz1DIusC0isXGcRrib67VeQRcooZJ9B0?=
 =?us-ascii?Q?3diAFVsqipbhYf1JahfptjKqV7KTa6DrgZTecEC0ctCroVRx/w2vmnCOf9sF?=
 =?us-ascii?Q?JHq8hCYAlv2HvttBgASGAQtGYBtdb5s7RiTShS4GRCBdEyAYYnRfNH9XnkCf?=
 =?us-ascii?Q?EfqHgrcyFVXP9fpx4Sl6Pjdr54bClNiyubR4Nzn7iEXHGfERWoGinIazse1Z?=
 =?us-ascii?Q?0JqG6F1/tb96FN69/RxPIPGThUZUCYyZbAOfs3w8zInZFkbw+9O0J2XSVNcR?=
 =?us-ascii?Q?7wUqyJLy0OLgmtQhL3OxDma9alyb6bBZFVJBeIUOBHw/j9URCbCKocMcKfNY?=
 =?us-ascii?Q?QUm1krtYQWsNydDmO4ByUM3mJU4+SIR/YlHhvkaY1x0GvZdfAPGiK3wlsuwz?=
 =?us-ascii?Q?mKkAjIsoqVXN/kkxnc0ufJaNLNDBCG9hpApjL9Klz1lTk2rZTA5VQBK9NMap?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RaYJ2EWlt1eLYsy4+PQ7C+Pd0KQrrNGWFq+6g9mH+sHGgvPOrr6ZKYEw8aYh?=
 =?us-ascii?Q?P9bvErLO+Af8d6b7g/qfNUToKlahrtGbg3f9ab8Bh4li9IkRjH6ZFUok44N5?=
 =?us-ascii?Q?jzGSt/KzDUlQt69fLbGAwbbskQuiyPiNWugE9qhJdfj/St/nZKS4dYCvaCZR?=
 =?us-ascii?Q?6f7EGYVKed+BJrReURKLd71opq54tNJAFUGUWZfjT6s2zA3+h+zjkqHQQcZ0?=
 =?us-ascii?Q?raT5XhzujGA9dGyBaL0CIWzitHQ2Ztjq8IA+DbOrqkzLyUtK8txR296rTOKe?=
 =?us-ascii?Q?3qOVtgofGmMNIuk6jBRhcX1GcJFf/PGCAalvNmO6KhMdQf6cQIQ3wBAuo8FP?=
 =?us-ascii?Q?rC5507OcAXj2nciEE0+Qd52mtqE494LBsN3fF3MFG7/n5//bx/EuTXEAWiBr?=
 =?us-ascii?Q?CMoFv781G737QeVp0EEyXdAy6JLtYQxHOL5cg8cKeO8z0yRCUDAA+34e2go3?=
 =?us-ascii?Q?VF9f8GHr0/ENbYiDropgzaXIVutNNLwoC2crnam/Dw32/yNEvF8k6wS+u5gc?=
 =?us-ascii?Q?twTLoaOEF5ybQk+8qDtdLLLvXRBY450RIZiWcO10dfbDavs8UgjuAdpwjPw0?=
 =?us-ascii?Q?3ljZhuw2I3L+G90J8XdOYRbrjmada5AvANWf1pvbOwJ51ujU3GZqsYeH/AIc?=
 =?us-ascii?Q?m1D4/kO3CPpR3i+opM6kIbWjd3wlny1vQRXUDJuePbePUzNpWLLyuipT1AlZ?=
 =?us-ascii?Q?STLICtAqbGuTOF+W7ZV9iuDXWzGyxxyFHKsMaf08pxMP6VR6J6CBE5iY9UPd?=
 =?us-ascii?Q?8jyedfBNiua1xhTgRI3jO5uA0yaVk5g31sLTlknLCtTPPe2usYVo7Xs0M0Pv?=
 =?us-ascii?Q?j2LDDj3DIo/9clINRNitlDWRNoUEIrQ8NcTBEDxpOE1xOyBGcST/scuXypG5?=
 =?us-ascii?Q?h6+txHKmqytJTW60dAc+QtuxORzNRN6cmG7W0gAkmTT6qG84cc1RTucrFTNf?=
 =?us-ascii?Q?NHmSZcMiKO9NhR8YPBPebf16HEM7Q5UsPBYiepXqSQw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691c3f39-c9ae-462e-0194-08db81576130
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:07:29.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4zV0K8MxJFietEUMMkhrueP/Uf3DZ2FqaGQyXyySvrk31jB9w2gcF1dcWMgDfNGIL4NTtCMtFO2GcuEYTFc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100136
X-Proofpoint-GUID: Pc9ryvacHV6yxwigctDThFuSZ6UPukrP
X-Proofpoint-ORIG-GUID: Pc9ryvacHV6yxwigctDThFuSZ6UPukrP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... actually add Geert to the cc list.

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230710 11:06]:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [230707 11:18]:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> > > Set the node limit of the root node so that the last pivot of all nodes
> > > is the node limit (if the node is not full).
> 
> This patch also fixes a bug in mas_rev_awalk().  Effectively, always
> setting a maximum makes mas_logical_pivot() behave as mas_safe_pivot().
> Without this fix, it is possible that very small tasks would fail to
> find the correct gap.  Although this has not been observed with real
> tasks, it has been reported to happen in m68k nommu running the maple
> tree tests.
> 
> Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > > 
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > 
> > This has been on my list of things to do for a while, thanks.
> > 
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > 
> > > ---
> > >  lib/maple_tree.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index d3072858c280..f55e59bd9122 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -3692,7 +3692,8 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
> > >  	mas->offset = slot;
> > >  	pivots[slot] = mas->last;
> > >  	if (mas->last != ULONG_MAX)
> > > -		slot++;
> > > +		pivots[++slot] = ULONG_MAX;
> > > +
> > >  	mas->depth = 1;
> > >  	mas_set_height(mas);
> > >  	ma_set_meta(node, maple_leaf_64, 0, slot);
> > > -- 
> > > 2.20.1
> > > 
> > > 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
