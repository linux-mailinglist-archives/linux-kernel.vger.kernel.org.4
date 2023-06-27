Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D5740086
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjF0QMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjF0QM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:12:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11872D6D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:12:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RD6HB5008139;
        Tue, 27 Jun 2023 16:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=jmX7AG/NR+WuVKCNX4D53EuUAf4wVDiw3d/Uo0Nd8mQ=;
 b=lldI4aWktuQxEx6nI0AbyQfEgsA0OwCQOxHcupoCakYJO7cb96D110O1QLdLI0fHD2Tk
 d9vIAvkRxlRbwmhzUUfT9xjeBldAdyCrfD78gMWysGPj8JAtpa+FF7cMlRX5UPFaINGC
 9oyW5KWu/U7eQZr437d5z3YvWWVB/fRRjqfdi+IaZi1m3rLJXV73BsAJfdXT9LZWQ0QT
 nNXdC96FaPveKSjA+mdgcimLyHaOzvkCWpWUWzx9HKy2MLRQE5Y1ldGd3HAu27DLWExD
 Ul7JWaaQlHcOXSqbkVU9JAX9/dK1HCIPRmdpUtLTBobPlj361sXZ/cJZYXFKQZaDf1Rr kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30wgcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 16:11:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RF3YTe029638;
        Tue, 27 Jun 2023 16:11:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx4qqj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 16:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR4QrrLDskZ75WhzNL3uz2WjLDmG5RPmQj9lFxUHUIJdGcezeFJ79PHFKN5byUhMuqonYanzNf1Wtwi6LbE2drBl+i2+wRL5yCCFwgSmsooG+nsfdjejYutFIhX9I8sM6FUOocx7YQ48vBGe2tpqNce8JnbuQkNosZGXnCacNZSTSKIJ2OsjtyZD2pIpQt/0dsbJ0CBLMZJdJPes6WdZ7sLz/VPwzMF9xOToPzGNXLIYw1MmOhRagkTsHWy53pfTGB5veg169RQmaFPtZzLEZ3LYMZqKCEfBa7C0EzuP6bfW1Y/nWyPll2ZOVJxsor02S5lzoYbri17cg41o1b1vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmX7AG/NR+WuVKCNX4D53EuUAf4wVDiw3d/Uo0Nd8mQ=;
 b=jqMVxAwbmphgO//IMDL2Oz3lZcg8mbVfwfQScagkAD68CsWIKsOMNzW4KMYIQoByDWPZGfcGvNy7+Bnf+h9Mx4Rc1cfF2SzTkzH4A3J42Vt6QgQBIgIO79ZlIBVWvptMNLqsHz3XNZsfQZ6UPxjNeojxQZQvXAvYbbG3F6vuFkRuZk3TMpSFxRwEp60bDJ6kz8GvV3IsWf4XFcUwZAoTwHKzjkhKqZ3Fq4uMUR3K1QwIACCt/68MzM8T8I+VsuQoObuecGpQhNPv2fLNUzXfmAiNgvJry6nzxMG4si8CfDn5DC5/qN78w4dIkFWFHMPzSo3LiB7i1Cho5qwN6S2cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmX7AG/NR+WuVKCNX4D53EuUAf4wVDiw3d/Uo0Nd8mQ=;
 b=uDOMVokp5Nt938SB6iyQQJcK3cyQXxljaOHf/raMu8iseW5Q3nAtz1V6XXUc7q6No4D5ZNvcobV+7GFKrwOoMimt5IkVYKpAQOFbDuYgfRZvaKWZs2vXZC6up4i5PX2NrI2iD5jAYch9s1hms91mbK1nczGGtxXRCIgMC/2vsO8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:11:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 16:11:39 +0000
Date:   Tue, 27 Jun 2023 12:11:36 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <perlyzhang@gmail.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Message-ID: <20230627161136.7hmr3st4xtsh44y4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <perlyzhang@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
 <ZJmQVeiLtkFAGfW0@casper.infradead.org>
 <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
 <ZJmmFF1Hz5ajRhy3@casper.infradead.org>
 <8cc06224-8243-e08e-d0ea-4db71ddc7745@redhat.com>
 <20230627015832.a4rojonhlykemose@revolver>
 <08d4385b-15f6-f0e4-bc5d-528f6a8af3f3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d4385b-15f6-f0e4-bc5d-528f6a8af3f3@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee6a1f2-e252-4b44-c37d-08db772930a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anfZcpaBAK/voXOLErdG/sy/JU2/KQHDuW64tffjRo8bAzeX5VtyvdI0z63pBtc8FAxhu3YE4sRPlzq2i7DbJfpkp7wrjOhas12kgwfFtUm/VYAw4rbdILREt89BnF0ZNVG0THlACvPZVxssxt6JUUdjC7oIbP+7YzcytSUY3l24AldfKAPZGo64jceHNu2PdWtclkJuXvb747ULusXUEO5oKFG/Z/F5sSo8pVY4hgDl2ky7fbehavbiIETL+AhGhGBPy4QodNic37iM8W7XmYb3aRoITICJj9TY0KePZabRuib2kQwMHCFPxgygbzbm2cf6Zy1AWLU2Voub2Z1mwsqjt6LdCOBjVeYRKK9MFYi1/bfE/YbQhCqybggILVp6DPERSJa/r0h5z4lfh+Q8HBFGxNFCjidt+VTj6irsiZ4FB2XI43Kh/Jk/LaO3NX58miArW3v/h/lwwXAqW5XGUqCla+2XEpZNqnKdeFo1ByZy5FB0esGIaHEs8AW4miHIgCJsTboXPMrRpOcbR/FvXSzaotibPslaXoqUxPq/T18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(26005)(7416002)(5660300002)(66556008)(66946007)(316002)(66476007)(6916009)(478600001)(4326008)(8676002)(8936002)(2906002)(6512007)(966005)(86362001)(186003)(54906003)(41300700001)(9686003)(6486002)(33716001)(53546011)(6506007)(1076003)(30864003)(6666004)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZOq9TH8MZn7vpGeqg+iH/dLiiKL2YeTYNm9ciaGivNtE/GYecXlkDSWRMOl?=
 =?us-ascii?Q?JsCNJtVsOqIr4dMYoHpGvNadyFyulcIkKtc/aas6hYUmL7q5inIbDPLbTzib?=
 =?us-ascii?Q?mabmDxJv7y2a5vpR7jS1A78YmWN6rqX7QQs9jOhFD0ioDuhh/T3wvFLBog98?=
 =?us-ascii?Q?BxE7ZB4n2oxNQmtOzLMnhCcRAnybwjQjiUNoJCwsi/S/F7pGzYN6/WfUDXXn?=
 =?us-ascii?Q?poinooc+QwS/p2q6HNmEI8a6N4ouH+yPYAnB6OTyvcLy4qnpLr9FTfQLTEs0?=
 =?us-ascii?Q?LMesYU/wIiOBtMBURlqBiwrxghmsQBeNq9pSHqKOaH+oo9zoem4AFDtdORHE?=
 =?us-ascii?Q?8c6BFilSfsCuHnA9uFoQShjdLqnUI/ASs4LrtjWfVbY2j7pivx0hsGm4hrWY?=
 =?us-ascii?Q?vssc5qN+QVHMDhtAc6uL9E7c+m0nqZPphwwvf+zBENxQCftitnjcEoLq578I?=
 =?us-ascii?Q?w+fdyRf3Z18uuWJldihtnKXc3ikPwMXJ01wPQvPoqqbs8PWXr+HV9ZIKoBKI?=
 =?us-ascii?Q?eiqfZtThud7OW3u4MiB4JLXONyXST1EFWKXZtEAY9RlbiPiFSgwSnH1BHfEi?=
 =?us-ascii?Q?FF1Rjz5jKqIcMDf4FHXxSa5MWic/1YrK9Oq47mQWDccWQbNsi6yMRYT2svaW?=
 =?us-ascii?Q?3oZoPIpP6OJ8bLPisTk98BzOBvX5vJsbehZAMAFnDMVYpLiH8VLBnFn4x/sE?=
 =?us-ascii?Q?cZk2Sye5NA+/edbxeN9yxKUjrCvqUnTretaVqm1YtQ2hmSSmD0o37/8ENuJt?=
 =?us-ascii?Q?bvCjawjGFQCs7QUQoLeKG80/iMC6r8tUcexwpjUjWq9tShDyldJ+AoEtWubl?=
 =?us-ascii?Q?JOBKW5zWtDuv1Kpnp7ISnnlnCt6EUY06cMTTxaAvr+b5Ja9oyOkqw6OxTnYW?=
 =?us-ascii?Q?Vb1+9ADQhLpKiGcZWbPqxiQK2RE6tHNwm4XvrDn/z52EZUBkNG2Cdf84igrI?=
 =?us-ascii?Q?aJgHwG1dwim9St8zeLjM/kpw4uQ3bb8STPpXsZNeTHo3e8Ho8P55U9TNOHZZ?=
 =?us-ascii?Q?N7Q1dScggHQYwZ1TE5pHlm97qlU5rfbJrAhMWeXAuGIpsWs6xwasVSvmx5lE?=
 =?us-ascii?Q?Z7J3uEYFOd0nbdB4qzuwRCkmbXkY/xWlLJj0Mcb7bnlN9MzbEOa67bkWQa/G?=
 =?us-ascii?Q?FO3IXnksISVd5xMh8w4b6Iu75qReIOOgO6ZUYodQ0F5SMlBdYhs5Du5rHzSv?=
 =?us-ascii?Q?WEDNVBEFJv+LEiXJS1dHFFVa8vCVHvro0wHY59lLoJP1PdP18d6JED/pJNT4?=
 =?us-ascii?Q?2d0PounDO2lLV9Q40jiPToga9Dy3EiRLATQ3wQNvRbblMHgshF2bGttWtcZY?=
 =?us-ascii?Q?Ts8tSQnNvytUWUtS/uR/E4F1AYfVDBEAu/DjDl/wn0DwhpWhtdYQuGl9P+WT?=
 =?us-ascii?Q?Xis4LzOv0pldhS6DBawJ1dIRdvJq9AXh4mwrPqlPenF/GUg6jHh1XhLN9It2?=
 =?us-ascii?Q?RwmDg9MP7jspesBLLsalEbvr7iutxm1bdoo2uVnVKsEfWYGTvU945xUdOoBH?=
 =?us-ascii?Q?4/Cy2hbz4OeMWavnZDi91t9tcphR01lp1BXsQ/TzHB1LlRfx3vGCxQ/o+Rkl?=
 =?us-ascii?Q?Jpijb3ufy0GbQse3NjTHpVOuxds2jZU4aV8rMMHFIl0+V71p90/YmwKDwuFu?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s4aE+L7S8bgpuKgHPq/YhZqmQawfTVPidDvsG0+XE+AHpbKu5YznB4c51pLP?=
 =?us-ascii?Q?6cp694l8wtzSmdsJTXwvaaRmNGV7gZdQFSKyDtBwWNCHUCDt7TH0TokiV6px?=
 =?us-ascii?Q?JB5Ab4CE2prJaMsFKsjHDZ5eIWc5fGKe3fVfyv5UTRsbbb8aB39urZaQaJmM?=
 =?us-ascii?Q?kn4KEU5+j/9HsvFw8ylzHxsx54m8z30eNJS9x4XN66oncn4I6xolKDt+T92A?=
 =?us-ascii?Q?8d4+ZBxLM/t3sbhuO/ubr4lt2995WKLo25AhOF3aWIDuNi8AbXCLB6GdjeNA?=
 =?us-ascii?Q?8eVeOkkbucw7uExSU7k1lUHw2xEoFTSqyOUAOh65qMF6Ny1qUFg9NKLRrnH8?=
 =?us-ascii?Q?IqmBEgXgKOWMLYoJ8W5fSO8Y2ZwdyELTWwIlS9GEqUpkV67tzvVCiZZfbV0b?=
 =?us-ascii?Q?L0yVE4+AdNu3zaqd0MkQbrypW++FSbhVkLr4Jk/m0nV6U/jwtL9r5TVTkkDX?=
 =?us-ascii?Q?Da5bSqPm/p0/IwvHwyM4Cs+Hfkuz0hi268V/D/Jr7LFGfiOF8qHsqUad5B1f?=
 =?us-ascii?Q?ppvNOBWfJaEJbDw4aQwH5RhFyQ/dPlJpEp6bmEM1Q+7eohX9cndlkvrI5ACK?=
 =?us-ascii?Q?tSoQEWQe5kpGeL+vF7t3Be6npcen6oZZY0Fh4pxtLapDgPymDNx7CmDfnyrd?=
 =?us-ascii?Q?SKT4Jk6l+pz8wOgfGEJMZz8V/f10R4KbTRxrDI8Dmah7j+vbfJAkzK2vnQEV?=
 =?us-ascii?Q?u3wGXMkWN6pBTvwvFrCVDBlLi3Gksv6YLZtuy0bG+99x7Ptg4rj3fo4NupM1?=
 =?us-ascii?Q?l468aUEq3XAhZuhR/Hgu0Urq41C9oAhckEgXvPAn4AfDlpljtdu6iC25ioG3?=
 =?us-ascii?Q?RhncOTYZD78aAIDHJl4oynO7zjQ8k+kbnTc+mIvMfcxVXYoDG/t1U4ArCd45?=
 =?us-ascii?Q?NCzrNFbxBP75uf6iKlYRmvj5dfan8/hYa0qMB2+ar+OPBkJvFzUJuf53EIeq?=
 =?us-ascii?Q?/CL5lJZFnWo0nPT8uRdzMrQC/xSmImXoAq77CILWFzq/zyMiwIZcbSll3nTQ?=
 =?us-ascii?Q?pPs7LTcSxTFfl2NkiabDeB2R2DWbD0ktkq41Ericy3zs2ilNJCdieDExpJLk?=
 =?us-ascii?Q?MQkTYDZl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee6a1f2-e252-4b44-c37d-08db772930a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:11:39.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n128RyUZrZIvBcswDTzAxnTt6H/rjL+BjUz/ioX5A6dWXCAkovSwyfmywR20wgO4bdYebPeGmg18n9hC+RPgRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270147
X-Proofpoint-ORIG-GUID: HH39aa0wm9NUwxgJI_dxOjuYCnMKlUa6
X-Proofpoint-GUID: HH39aa0wm9NUwxgJI_dxOjuYCnMKlUa6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Danilo Krummrich <dakr@redhat.com> [230627 10:58]:
> Hi Liam,
> 
> On 6/27/23 03:58, Liam R. Howlett wrote:
> > * Danilo Krummrich <dakr@redhat.com> [230626 14:37]:
> > > On 6/26/23 16:52, Matthew Wilcox wrote:
> > > > On Mon, Jun 26, 2023 at 04:27:54PM +0200, Danilo Krummrich wrote:
> > > > > On 6/26/23 15:19, Matthew Wilcox wrote:
> > > > > > On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
> > > > > > > On the other hand, unless I miss something (and if so, please let me know),
> > > > > > > something is bogus with the API then.
> > > > > > > 
> > > > > > > While the documentation of the Advanced API of the maple tree explicitly
> > > > > > > claims that the user of the API is responsible for locking, this should be
> > > > > > > limited to the bounds set by the maple tree implementation. Which means, the
> > > > > > > user must decide for either the internal (spin-) lock or an external lock
> > > > > > > (which possibly goes away in the future) and acquire and release it
> > > > > > > according to the rules maple tree enforces through lockdep checks.
> > > > > > > 
> > > > > > > Let's say one picks the internal lock. How is one supposed to ensure the
> > > > > > > tree isn't modified using the internal lock with mas_preallocate()?
> > > > > > > 
> > > > > > > Besides that, I think the documentation should definitely mention this
> > > > > > > limitation and give some guidance for the locking.
> > > > > > > 
> > > > > > > Currently, from an API perspective, I can't see how anyone not familiar with
> > > > > > > the implementation details would be able to recognize this limitation.
> > > > > > > 
> > > > > > > In terms of the GPUVA manager, unfortunately, it seems like I need to drop
> > > > > > > the maple tree and go back to using a rb-tree, since it seems there is no
> > > > > > > sane way doing a worst-case pre-allocation that does not suffer from this
> > > > > > > limitation.
> > > > > > 
> > > > > > I haven't been paying much attention here (too many other things going
> > > > > > on), but something's wrong.
> > > > > > 
> > > > > > First, you shouldn't need to preallocate.  Preallocation is only there
> > > > > 
> > > > > Unfortunately, I think we really have a case where we have to. Typically GPU
> > > > > mappings are created in a dma-fence signalling critical path and that is
> > > > > where such mappings need to be added to the maple tree. Hence, we can't do
> > > > > any sleeping allocations there.
> > > > 
> > > > OK, so there are various ways to hadle this, depending on what's
> > > > appropriate for your case.
> > > > 
> > > > The simplest is to use GFP_ATOMIC.  Essentially, you're saying to the MM
> > > > layer "This is too hard, let me tap into the emergency reserves".  It's
> > > > mildly frowned upon, so let's see if we can do better.
> > > > 
> > > > If you know where the allocation needs to be stored, but want it to act as
> > > > NULL until the time is right, you can store a ZERO entry.  That will read
> > > > as NULL until you store to it.  A pure overwriting store will not cause
> > > > any memory allocation since all the implementation has to do is change
> > > > a pointer.  The XArray wraps this up nicely behind an xa_reserve() API.
> > > > As you're discovering, the Maple Tree API isn't fully baked yet.
> > > > 
> > > 
> > > Unfortunately, GFP_ATOMIC seems the be the only option. I think storing
> > > entries in advance would not work. Typically userspace submits a job to the
> > > kernel issuing one or multiple requests to map and unmap memory in an ioctl.
> > > Such a job is then put into a queue and processed asynchronously in a
> > > dma-fence signalling critical section. Hence, at the we'd store entries in
> > > advance we could have an arbitrary amount of pending jobs potentially still
> > > messing with the same address space region.
> > 
> > What I think you are saying is that you have a number of requests
> > flooding in, which may overwrite the same areas, but are queued up to be
> > written after they are queued.  These operations look to be kept in
> > order according to the code in nouveau_job_submit[1].  Is this correct?
> 
> That's all correct.
> 
> (Although Nouveau isn't a good example in this case. Some aspects of it do
> and some aspects of it do not apply to the problem we're discussing here.)
> 
> > 
> > So then, your issue isn't that you don't know where they will land, but
> > don't know if the area that you reserved is already split into other
> > areas?  For instance, before the range 5-10 is backed by whatever
> > happens in the fence, it may have already become 5-6 & 8-10 by something
> > that came after (from userspace) but hasn't been processed by the
> > kernel that will live at 7?  So you can't write 5-10 right away because
> > you can't be sure 5-10 is going to exist once you reach the kernel fence
> > code that stores the entry?
> > 
> > Is my understanding of your issue correct?
> 
> Yes, it is.
> 
> However, the problem already starts while trying to reserve an area. In
> order to satisfy a user request, such a request is broken down into
> operations such as unmap mappings which are in the way entirely, remap
> mappings which intersect with the requested mapping and finally map the
> requested mapping. The execution of such a sequence must appear atomic and
> hence be locked accordingly. When trying to reserve an area we'd need to
> take that lock. But since this lock would be used in the dma-fence
> signalling critical path as well we'd not be allowed to do sleeping
> allocations while holding this lock.
> 
> Potentially, this could be solved with a retry loop though. Drop the lock
> while allocating, take it again and check whether we still got enough nodes
> allocated. Analogous to what the maple tree does in mas_store_gfp(), I
> guess.
> 
> > 
> > Oh, and I guess the queued requests would have to remain ordered between
> > threads or whatever is on the other side?  I mean, you can't have two
> > threads firing different things into the kernel at the same region
> > because I would think the results would be unpredictable?
> 
> Once a job is queued up in the kernel they remain ordered.
> 
> However, user threads could concurrently push jobs to the kernel altering
> the same region of the address space - it just would not make any sense for
> userspace to do that.
> 
> In general userspace is responsible for the semantics of the address space.
> The kernel basically just takes any (valid) request and make it happen. It
> also assures waiting and signalling of fences which might be bound to
> certain jobs and obviously keeps track of the VA space to be able to clean
> things up once a client disappears.
> 
> > 
> > Can these overlapping entries partially overlap one region and another?
> > That is, can you have three in-flight writes that does something like:
> > store 1-10, store 10-20, store 5-15?
> 
> Absolutely, yes.
> 
> > 
> > How stable of an output is needed?  Does each kernel write need to be
> > 100% correct or is there a point where the userspace updates stop and
> > only then it is needed to be stable?
> 
> It needs to be 100% correct all the time. The reason is that, as mentioned
> above, every job can carry in- and out-fences, such that userspace can order
> these jobs against the execution of shaders.

But each job is split into parts, so the fences surround these groups of
operations?

Since ordering is kept, you must reach a point before entering the
fences which could call the mas_preallocate() to ensure enough nodes
exist to install the new mapping, and then no other operations will be
happening. I guess what you are saying is each fence has more than one
tree operation?

As long as you are not mapping more than a range, then this should be possible
in a single write and thus a single preallocation.  You can do this by
not actually writing unmaps/remaps to the tree within the fence.  Once
the out-fence is reached, then the operation looks atomic.

Reading your patch, it is not clear this is accurate for VM_BIND of
asynchronous syncobjs.  Is the fence spanning multiple syncobjs with
various ranges to map?  Or are these things the split-up tasks of
unmap/remap, etc that will eventually boil down to what appears to be a
single write?

> 
> This is also why there could be jobs queued up, where all of them apply
> changes to the same region within the VA space, since there might be shader
> executions (or just memory copies) ordered right between them.
> 
> - Danilo
> 
> > 
> > > 
> > > So, the only way to go seems to be to use mas_store_gfp() with GFP_ATOMIC
> > > directly in the fence signalling critical path. I guess mas_store_gfp() does
> > > not BUG_ON() if it can't get atomic pages?
> > > 
> > > Also, I just saw that the tree is limited in it's height (MAPLE_HEIGHT_MAX).
> > > Do you think it could be a sane alternative to pre-allocate with
> > > MAPLE_HEIGHT_MAX rather than to rely on atomic pages? Or maybe a compromise
> > > of pre-allocating just a couple of nodes and then rely on atomic pages for
> > > the rest?
> > > 
> > > FYI, we're talking about a magnitude of hundreds of thousands of entries to
> > > be stored in the tree.
> > > 
> > 
> > Since you are not tracking gaps, you will get 16 entries per node.  The
> > maximum height is 31, so that would be 16^31, assuming a gap between
> > each entry (the worst case), you can cut that in 1/2.  To assure you can
> > successfully allocate storage for a new entries, you'd need to allocate
> > 30 * 3 + 1, or 91 nodes, which is 6 pages.  That'll be highly wasteful
> > as almost all of these would be freed, and sometimes all of them.
> > 
> > You estimate less than 1M entries, that would never go over 6 levels (8.3M
> > entries with the worst-case).  5 levels would get you 500K in the worst
> > case, but realistically you'll be in the 5 levels almost always.  So,
> > 5*3+1 = 17 nodes, or 2 pages (1 node over 1 page).. assuming 4k pages.
> > 
> > [1] https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#Z2e.:..:20230620004217.4700-4-dakr::40redhat.com:1drivers:gpu:drm:drm_gem.c
> > 
> 
