Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94F74FCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGLBX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLBX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:23:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F032695
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:23:24 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDCHO020037;
        Wed, 12 Jul 2023 01:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kRbCGzZx8r8pOYM46D6GsNFGKL26YXUDBywo0QE/niM=;
 b=zMLbEqmmD5jvczscmMNcivDX1InpFY95WdyUxU5SsiaVgCG/ZGWagLUAylPh0eWWUDkd
 BthRTmRh6RwQsBeICPb8EV25tfjjLwdpSgVzhYqCaxi31lLQ3aj6RzaRnYvlMWJy2ei2
 ffnnhpSTqwfKJJtVDL1bl6A9J4YIeFudXphghahZpTF9NRYaNopQot05TAp02XKN7FZg
 P4kWXsceWYcMe8nzsPQ1c171fNkQ+NRQrAn6261mL1UQIsY/2mUJu9XbXvtN2TtLQJOK
 oW0guwBcidZQjhKBlZ0kpesFD0uCF9drAxXi+ep9XXFM1Cqavy792cjgBJF9sfcHI1My JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrgn7v0kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:22:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C08TP1004531;
        Wed, 12 Jul 2023 01:22:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8c1qsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 01:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYIaCxirIfp9LilZFqVmpnyHfeVE0vBl1EquEuH3oUd8Fb4CYRJESmMgjNSKHS0OY5X6lbsqMMZZgLAPMpE2cTore2uv1cOi4KTmN68u55xgLBuLyFUW/pRCdPY29LOcfKkmwHERV+zTDgmPXmvSxpEi6q/NcdMgmK0VFAdgoShuKgwX/k9wq0rKgkXMtWddaMr7KkUvvKB84i58oHPFqKYuCdXztu9/6tErRgdGWJsmiNHAU1zBUgi1NKakLj3CshNsxoBQKIHqKsP959C7C/dILJDO+QF4rk7Qud1dCBoBqIV1ysA93NdhgqD2BUHioFKp/hYsnVaTHiq3ORyb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRbCGzZx8r8pOYM46D6GsNFGKL26YXUDBywo0QE/niM=;
 b=UIjZCYFX22nkw5MOTcIKITnYf/ta2rxPI/mdg+YQvCIdWkWkLFt04+iU/wdz9itaMnMV/wUHw5xbgBIVjwvpPL2cSun9Xw8pHWpVao3clpvoYmc98XHH045nf6c5MakYTrY8p2vQXHDczU74Vv9hIsSdn9Jhacy8gs872Q7pEw94dXQgq9jYh5cVr9O5J4Aqs9tP20X9BJgQHFD5ow8JEOLAoBhpfmX1SLhi26wGHc6LlJiHdiomxNQVBe3334Gp31PjbdIdIWfdUTvnl6031fXDfAUii1/K2b0d5j7gyxHuICd+9QcZJIRM6ogPVqu1Ma6kW4fiMGuyw5k35crb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRbCGzZx8r8pOYM46D6GsNFGKL26YXUDBywo0QE/niM=;
 b=Zroqx2ziIUnVIbdvbPCtJbzgPmQsimrZFF+JfMqGvNbZqiNpK62V/Qj5+yFOjc86zjTM6r3RV+KpOx4AzEPL9a/2mJ7Gk5s8aG9kGAuCKjTHYXui8OblFl9drKUZc/IbLJOV4pY/GyiCBspR65NtFU4Yx1Sf1EGUCEt89nWT1xk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7158.namprd10.prod.outlook.com (2603:10b6:208:403::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 01:22:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 01:22:46 +0000
Date:   Tue, 11 Jul 2023 21:22:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 6/8] maple_tree: update mt_validate()
Message-ID: <20230712012244.5o2cxqowoe5dmw7k@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
 <20230711035444.526-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711035444.526-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0033.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb7ea9a-b716-4627-2101-08db82767fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUKTkI0/EGJmGU2z4mzwRxUPtXkkwuhTbe54PUMCQAopkBjNxosRSMDOToXdgkodb3aodIM84XjZ+MrYggtdQ3q6EnyQd/dFS9RsI9xLO+QNSuQKfNwIQo0QM+Y46LNNxUHoJmvrkfAOs2C6G1127k2BUNt+Gl7xd7Uo5zUJnAzREUdeHg9APxa3BJIeRQa0ITLYsifOHRXK6E5jJx8PfFhY88bSP6Umy0c9UGM4erBMZKiqY+3lrEcMQNwxcWikao6PVq8ooPSlSB/cC+q+As0Usyv/o8ZbKY5/VF15iCIJmhaTzpMTR5hRb9L6mFQqDjwkCPz6PurRhJcucHakFPCbKzxuRVQBGWaSvcoCvysZczvuKdjGcRaR16qB+BrJAsoVi0GO3QioQ/smeV18C4VB3FXMkKYxvL2MIjIo3f4Du1PgSLGlewHpcdRyLvEupQ5qXFMqJsYSgwB/pJgdxET/YcwxBUQCSAAOPp78R+JTWhvnWIvLIQnqV5jyhcSVNWcJV4K6X1r/5j2e95AiEhnPBc+RL9w/1H8UK/XhA+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(86362001)(186003)(83380400001)(33716001)(2906002)(15650500001)(5660300002)(8676002)(8936002)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001)(41300700001)(316002)(6486002)(6512007)(1076003)(26005)(9686003)(6506007)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRbSfjNCaTqWnOj10dy7CZFIvWflmpXvIDNwriGaN7R1cxBoJ4yAZuZ9T8b4?=
 =?us-ascii?Q?fAVkHsvSQrXql51gLhZVhe7L9vMmVTI4s5+o5CG9GcADCjYzzNMeavH9FAXZ?=
 =?us-ascii?Q?akh+49ojBtLupouwIES+Gbp39uKvxPN5hV8sHcjh3wHQH+eEkodekwGZs25w?=
 =?us-ascii?Q?kGqQZMpya+InpxHkEHyGqZ1yB9WK1uxp8z2rvLJ0DXPvJWrUFuFqR3XaeVei?=
 =?us-ascii?Q?WuUIJN+CcSK+hxfiMmp6q13n58nF0qW7Zs20ITKRvPuWfPICpQAlAOWeMZId?=
 =?us-ascii?Q?mTmbSKc4M9nFPDPYUPqdJOZBQE88W2m5XUFWnMuF+CQbO/hKR/BPM2Iy/E1W?=
 =?us-ascii?Q?4ZYO9B2vPB6WA5OZMLk5DIyHBXOls+UA+L1rQjujC6VpoTmkKQF2Jd17WSLp?=
 =?us-ascii?Q?sAki8iT2QhyW8Bz5wm1Z3xdpckWn5xyV9GNmp1rHdSMH9wx6hQxz5tf1vCbN?=
 =?us-ascii?Q?2GPF2PLKmteAUHGCNvmqdfFR8SrLQHtghLIF6Eh+yZcPF7QbDgOOu4L83PiJ?=
 =?us-ascii?Q?ei0w6T4PZnUafT/0ibtNSnSnNkgAudscS8FrXLZVP+nNjRt27etieUE7HESX?=
 =?us-ascii?Q?UhBw1k1CEC17fm1NyHB9LoBYIOY0KolIINzNzfDPn+HHzWaNoMo5J2BpeE+5?=
 =?us-ascii?Q?X9OtEL83gxFeLlYXDMR6ucf8bsHFyY+1pVKGjQplSoAM2EoQMMLVORtmor1j?=
 =?us-ascii?Q?linSsCgC76Q2MVunacOugERJoRk4iNRk3f7+a6s6NNGqsmk7UGhJ3e3oTutI?=
 =?us-ascii?Q?muzGgtomimxQgX15YV/k0+htU3La/2DhPo6c7knAyjuDl4wdoeQ1l4mwnNUY?=
 =?us-ascii?Q?qExSZbho3nw/unuGEvFxrb+aOBAxEJTGYg4hsjJ5JRBYqOT46vl6p2xOzAWY?=
 =?us-ascii?Q?QNtFgQ4n0FwNhgbnjToAQ9WEEYDmMbYOBaf7OXM+o0aqeSSRc/AITwQVeu+t?=
 =?us-ascii?Q?5GXzn8ut+luo4sX0aqMsh4q+vw47K2mG74ofwzCCL0KAYBWkvpUrnN49+Wp6?=
 =?us-ascii?Q?sYrAEYcChUK18GtB/h9w3eF3oHeylPw//sf1SSKD85r5UMGf5sThB0oxLRiP?=
 =?us-ascii?Q?cJeIQgkN5HKziEIbgTlVEy2/lejGpQ2lc+9w3qCei9sCwr9gmdXeyhyHNSa0?=
 =?us-ascii?Q?EAwxpXVVuExXTkcCCjyD+0h4inAoLzLIcodq61hpO670vrskDjY79zcMCJoo?=
 =?us-ascii?Q?73fL6zaiOlKeNtKgJ2d/0vNAUxSA8bRVuSI6fcPP3L/2cghQ6Wubz+gmN0lw?=
 =?us-ascii?Q?dRaWTuAS8UGO1oMScXzT9UC4ZHePitCjryLv7xnu/GRKVyg5nIq7gouIHVGb?=
 =?us-ascii?Q?qdpn6fTiG4PjfamlrYLNVYHWrDLU29qNwKhFg/b3pNuTNKT47VGytkMBGM6p?=
 =?us-ascii?Q?8ZiQ05L5RYprkJ8HDSATwi8HYCm4hXgFcT/LX+LctCgS/7kzb9ROiPMW0OPS?=
 =?us-ascii?Q?/0kGApYQUUybPWEQ8pZSRRHkbujP99GCcgoFhEH288rQQTqTuwKRDMiK9JiJ?=
 =?us-ascii?Q?CZ3FVbn8ZAnAg5GMwSzxTwgSSgG87roeq6I3i13Kpc0y2yTIstCdx6PkbXoT?=
 =?us-ascii?Q?My6o+nUTTbpGKNOeWnJHCfjD5Pyh7oe+L+52vcaK/ISWq5xY5KEDWInUDQoO?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fYqCPGFcoE9jyE4myR6LT90LxscvQ5BAONhSShM5/ZL7pFEbXjnZ6JkCGe76?=
 =?us-ascii?Q?wAynU3BVDGU/EgulqTf+y7knjUAUlGwrDuzKKopGmjnLY9fB6u55xVGdnG1w?=
 =?us-ascii?Q?6UjpJxzvQ9kP6hI6/Qn7UP96wCu2uaQZw6C6dJNfKwfbZMdQ/PoLfkteVDCG?=
 =?us-ascii?Q?M50Ay/6IiZJUb/0B7F3KtQXjw6v9eZWzDYU09ZQt44d7TloLwtwUC+ZMic2p?=
 =?us-ascii?Q?aCccziJZp5PDh0uy3pKPAdDV/mF9Du3A2CeX9GImBfKkULtEnYYaeeneb2xg?=
 =?us-ascii?Q?ilLq+p6Nr1pQKc91iMufXDecXXB9pjVt+uT91QoNMlo9e2Hrphp0SwDrOs7c?=
 =?us-ascii?Q?TMTSs31O3RdbWL/Umg+guZhvLY+0a1AKxvgEKdZx/Z8arK8cjBRZKfSHxaby?=
 =?us-ascii?Q?PIBb6OwloJ+0RfA/8Qb0CfW5CVVdXaeckVDz4+SpIgv5G51r7gZ5VGmWjP/9?=
 =?us-ascii?Q?XuAMYKP72ut4qmTwaCleBXwIfJDXzMcTwOPAXDyyj9uh/SbYqk/Z6194zoju?=
 =?us-ascii?Q?r2d0dspnkV6ocMxobnKpu7NaC5iIDlcdmAlqJ5Ago6ODHiSG+qjQ+70zumMx?=
 =?us-ascii?Q?AtaMru/oeXJhqKAIoccf4VC98J8S9dwadfBUuHxMjC/MDtv8B7pWyScFcxEr?=
 =?us-ascii?Q?lRJ0U1XlTKHDbK3T6NUc+NhqETUFDkRW0rpz+kK2hK+g6rLSar0tvTGLf6KE?=
 =?us-ascii?Q?2gdKslgUblnqx545/fafdlHUOn/cliQQprEdZrl09hsYiNQS83y5hpCLZg6y?=
 =?us-ascii?Q?154AYfY1bsnj30NQ3Dg2d5mpkKv9CakESTTrhX32O+f53IqVTGdTARHu0Fc2?=
 =?us-ascii?Q?tcKqfKb0Y4XD3yxLBCGF5BcV6EQC60z//UAgeQhbdndApHahuUmDXXMMY3Nc?=
 =?us-ascii?Q?eF3lKRtWFYIibKIxe5VfrbemSDTyMqq4sP8czsexUwtRKa180dRDQWLSpfn3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb7ea9a-b716-4627-2101-08db82767fe5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:22:46.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N82eGiFEhrMIHgowfpAJlJydP/KV3aNASyhdkltDXL6xvFxtbinpPCWYge/o09TsUi6x3hhDuuV57t88LKTV/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_14,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120008
X-Proofpoint-ORIG-GUID: oPWjTIlcSOfWFaZijm69_G4kjkpszFKp
X-Proofpoint-GUID: oPWjTIlcSOfWFaZijm69_G4kjkpszFKp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230710 23:55]:
> Instead of using mas_first_entry() to find the leftmost leaf, use a
> simple loop instead. Remove an unneeded check for root node. To make
> the error message more accurate, check pivots first and then slots,
> because checking slots depend on the node limit pivot to break the loop.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 072532fa18ee..1ad11799e197 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7270,21 +7270,20 @@ void mt_validate(struct maple_tree *mt)
>  	if (!mas_searchable(&mas))
>  		goto done;
>  
> -	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
> +	while (!mte_is_leaf(mas.node))
> +		mas_descend(&mas);
> +
>  	while (!mas_is_none(&mas)) {
>  		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
> -		if (!mte_is_root(mas.node)) {
> -			end = mas_data_end(&mas);
> -			if (MAS_WARN_ON(&mas,
> -					(end < mt_min_slot_count(mas.node)) &&
> -					(mas.max != ULONG_MAX))) {
> -				pr_err("Invalid size %u of %p\n", end,
> -				       mas_mn(&mas));
> -			}
> +		end = mas_data_end(&mas);
> +		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
> +				(mas.max != ULONG_MAX))) {
> +			pr_err("Invalid size %u of %p\n", end, mas_mn(&mas));
>  		}
> +
>  		mas_validate_parent_slot(&mas);
> -		mas_validate_child_slot(&mas);
>  		mas_validate_limits(&mas);
> +		mas_validate_child_slot(&mas);
>  		if (mt_is_alloc(mt))
>  			mas_validate_gaps(&mas);
>  		mas_dfs_postorder(&mas, ULONG_MAX);
> -- 
> 2.20.1
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
