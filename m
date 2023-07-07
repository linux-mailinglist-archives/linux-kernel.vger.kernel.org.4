Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ABD74B33E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGGOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:46:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9311FD9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:46:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367EYf98029835;
        Fri, 7 Jul 2023 14:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=x64BrNnx9TSFPYBp8K7mdZuyiNYDVlz2PndfT9CqWD8=;
 b=DLnDBrJCypjZ8/dG3xWKK7NQ9IIr44G4RHy04stbHxDorGxLcc401aO2d9Za2FXpsWGV
 u5q8xEhpBBqql+VEIwAMSGYy40I1j+vA8FRR9i4iWPViZSsE3CH0f8giuMaMHyaNFQv4
 aej+ZYyVm920ErQ9GnqniiejW4inUqseKBxevJ2sMzo6+33aQYVOKfaSVq1m8PcQC2Ud
 zzL8xDGioPWa6W2bIv6VYOlO7MayL3dXVkgjj75ND+sRs0g45lsPp1qxeCHvFyKi/hbT
 kRx+R6qNj3EOWBs9IMGIoqI+5vH0hVpx5PPhFLYfBOm1zt1Qig2seDpxIL+eI9rC6+mR 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpmk500yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:45:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367E2ir7033350;
        Fri, 7 Jul 2023 14:45:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8qee4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZI38YYikTTzS8ovkr52hBAHJnfeyMhMRSVmoCHa5jPmKXimV+c4t3lVge0pEgRT3kBLeyfccFiRqP2kgrEO8aZz+X7eYBl19QmxPhv2hVtgH3ssFpskRlgfiQBpcU93bhDAfGX4RFhHE+Lhz3GaH+L6YvgzgIc3pMRbGH57lmZ9pBVp8n8kTk1oYgoy/a7D+yKL348sm3KUzhHKcWtBwVpp9yyMicRAAlS3skEVolnV4ISG+ok0ZCB/UK3x+3FfpRm+/XTsdW494QNPP98+U6/4xil+f4nrEzIiH12KvyxPbueqTm1nlO6nhxzo8KoylorPblLsQB7fZNAQunGYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x64BrNnx9TSFPYBp8K7mdZuyiNYDVlz2PndfT9CqWD8=;
 b=CZz/3F1pyGP+6lLdMHt0AozuLy+7upeXrwTP7hGbo80RH4oSyAN5jvR1DlINA7QtroSU8eeW/IHMFRVSm7eZ3lM6Ww2iZJBbEccnPhfus2kwwshmVbbDqRZpz4FV1kiWb5Wn+xDBdRaR3abP++7jJ3TPFlpys3nCyklpNZfMRNypAseNcQJmyVPEIy24EGaWiek+wDRXoIsPhLk4yt8lGHOSsLMRnnOO3k5nfqaQmraVykGa/kXPdwgs80Fq7H75QeT7dJ4COhUj0KjYaUc9MtkMq+2/Hci4AdmgRNGD71IEeRG7ZEbxkBX6tHayEBMgESuqbhG8OXctwgy91LM9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x64BrNnx9TSFPYBp8K7mdZuyiNYDVlz2PndfT9CqWD8=;
 b=k/tSD7cPlPkPINza+3s3+HKGCMILmmq3Y9u+dJ8NKkFeqw1DVM+VoSg5FI4T6qpeEBOK/5GM2e9pKZ2WIt1J2uObxKz+KArVJkSZ+q/TXQlQ02Ozy/j4U3YkV7Bdi/I0N7G9Ap1RzT4yFct7WFrcVcrKVCi0vsYxffvV7X/ftyA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4678.namprd10.prod.outlook.com (2603:10b6:510:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:45:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 14:45:52 +0000
Date:   Fri, 7 Jul 2023 10:45:50 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [RESEND PATCH 3/8] maple_tree: make mas_validate_gaps() to check
 metadata
Message-ID: <20230707144550.eavqm7zcr6dofl73@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
 <20230707101057.29326-4-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707101057.29326-4-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0087.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 830c78ba-77ad-4403-f21e-08db7ef8dd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9058zz9w8Ypta6ctqyVUHGcIEm/f0vZFEkvQkEYQgl6L8t0oyaK+AB1squhghvngkXacz157dbF7X29bl1j4BNThtz+ApKCVEdWjtl6xwVsZQq0R7GWNCIRGTVjIOi7MKB7/yZEtOA89+Z4Lg9O3jHENVWwUcwkcfEdCIyz5wvi3RZLZLKyIOLWfsBqSYxMux2CG0olbRC9U1apz2XD4R2kdGXaEjCG3sBh9x3dtkhFZyqf+qCgrKerxem3LrrSi+KowcCfqc/qzAMu/oKwlGjsGNQm5dwORd9WBR2S+n3P4P60seDIaipHMTp7Pi/hRsxRyfjcYxkIjpgHb7qGGn85tn3XzXfecsIQmTHZg2CfzpsUS+hFKc1YGodZNUk0kuEGwpQ1P4lpNk3zkR0H19JRiaiQRNUBuBo3+3Dur4qshEfYkU6RdlyBURCvCiz3odg+h9Cz+pG+9ncXHyJkfUV/fZfSkWTNEIDVuSGau6p/sffR4n2jO08NJP/kfh4R/7uLBIho9TK3ZDiCO/MJ4D3APutNfPBqw93rLPYBknU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(41300700001)(2906002)(5660300002)(8676002)(8936002)(33716001)(86362001)(26005)(478600001)(9686003)(6512007)(186003)(966005)(1076003)(6506007)(66946007)(6916009)(83380400001)(316002)(6486002)(38100700002)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10hIZY0ztTBeVTq8CkQc3d82Hs22SHRXdpqPrj2CvxFaMK7JLNQoP8t+7FNp?=
 =?us-ascii?Q?pyxN+MjpEcgHz9WekmWiG3AspZjTEHmq8m3F5w5G4ajqXozx8sNQQDH98Elr?=
 =?us-ascii?Q?w+204FyzMQpg2pVbGg+d3w4wvP452RvbFY9vUBn8Om9qGgFqH0GIRG/fBX4A?=
 =?us-ascii?Q?ereTBv+LRHL/MHLT9yPF44rbNLdQvkEwuBBmuQ6w9ZJFC9RovvYV/1PEURvC?=
 =?us-ascii?Q?lUFhFEiqgworTK5bajRtOcTYiLcZ0KGmOaYARWyIEKOmfgZX2hH8OsnsV/fg?=
 =?us-ascii?Q?R2JezUBOb3hcUNfhwXUKPhr/bVG9KbpHJznVpmJRQ3STRuc2m2BOcl+kfdWQ?=
 =?us-ascii?Q?uXqDaIB9jw0mv55OuG8BVPA4dXGek2bvYI+rBk0vXXV3RQ7/F7aPRfosiJIO?=
 =?us-ascii?Q?UHYbOK4Vr7pAbtioxRdDn9lpvyhT08Va+dN+Hizw51pmdVXcFOmdNZlz0YvQ?=
 =?us-ascii?Q?3TROApumF4DkU2Ef/j05fWPmq+baK2G108szTw9WBhSBFJLTiiM3aoiVyCHS?=
 =?us-ascii?Q?4gCDdPA9lNvC01kKKmiJa23VNZYeOXxa4FY9teoaRKoFVbFmpqDjUEdsGmn2?=
 =?us-ascii?Q?f7thtalW50rxKytNKZdmj8lAxu2UCJhYeh05Ec3i6xse2FWW6LQeAB+A1qcW?=
 =?us-ascii?Q?oRanaG5Ba8c0ZI4/QckNyxU86ftNSUFDHx9ZpPSH3V+zYqZgHsWe5S8f9+pl?=
 =?us-ascii?Q?4ESSdiZ3rAu86z6lUSvuriM4rFkZTfobjIAsIyoEYADijrZlrD+YzJ5kHY2b?=
 =?us-ascii?Q?ae/IIUCAQwToXRfMCVCW7f2f1VZu60aVyVZSWl5w6kDE2LaHgVeVAHEP5QFJ?=
 =?us-ascii?Q?cXV3vhyLwuwqau15HmI3Hg9qK+DaD/ZLKaiSYC9GcJkBz4ldF/dPjVHM/cgQ?=
 =?us-ascii?Q?XiO7dCyn2vsjBFaP9c8Ga2LjAKOyQiQMgaXcYwCZ9fM5FRNLbMQdNuaxOuOW?=
 =?us-ascii?Q?VCtnvnGqt2pEP4iNpsNC1KFmbe+fHpVydQ1AnI/L5QBCEB3IIFZ/LfmhcTku?=
 =?us-ascii?Q?Dj8HjLxa5p0eTOLV3KsywDR9IGG3b2INUG7hhqVPcNaQVVj5t10qPZ2F7Smd?=
 =?us-ascii?Q?oSEmX3X1Tc/C3J6YJXbhE28YhjCa13lU2PGlXe3RzcSZ5RHVeG8OhSDhxhYX?=
 =?us-ascii?Q?kLhZaqjs8+OIkPK8pRkC8zxLIUdh/wHU3cU5easIsX9wqsXVSfjRcIfWsiYc?=
 =?us-ascii?Q?+2vOEow5kVdhoiysHIx+uaEN45S5mzwBJmmXwHO/ouFqYwX/MpruGcdJvWhM?=
 =?us-ascii?Q?InMJRBuDyl3yPDSyIQDHyto7cMY+IVLnd7Y6hAD7To1GmxdIMuZnrzifl+Y5?=
 =?us-ascii?Q?r3o7v1O/t4GyHmkWSgBw8dk+Kcr+kDRRzz5fcNDT4sOFDZsb0W7gfSvKJtfz?=
 =?us-ascii?Q?KKO3RbCGUXWl4IGsoIOOYM6qtIgxnDGsCfHZwbH+tekBq2+/B3NF6tajXTaX?=
 =?us-ascii?Q?sK8GuvhWtIDbxbVQlRlJY+NMDlTZJ5ZONqwBQkITuErowT2pO7kUUf/VkPUP?=
 =?us-ascii?Q?EKjx4JzAwGr31nSe64QhSank4BdHKN+pJK6Fqk3Z8X52lpLj1babelLA9rdE?=
 =?us-ascii?Q?l4daEzWAWGqjrUNig3xeqsgXXmL7fhyDEjZdFwsrktoUmxI9FZxZXjUe1trE?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HgdToaUg+HytTTF6u1z1D6goWvRD/NoARquJMXzstR+gJITA2z3HAoaCAVHw?=
 =?us-ascii?Q?4EjKnlM8jRimtcG2EMaSlFn3otozADazjFrHr4Cvx6r9O9V+hJmwyO+NdL0n?=
 =?us-ascii?Q?MPz6+LcAmc/d+UpdivcM+h+MY8oA+dG87V+5/rHgjXfQo/JrPvOdSjfxL2zC?=
 =?us-ascii?Q?x5dJ5WP3QnKXj7nsIn3jtSGMIj9GapnE5RPhzHUg+WjbHnwZEZvETz2BGQ3E?=
 =?us-ascii?Q?CkVIezrnZzMyMcIcLJXBHOKs9TI76llkGH4aGZUDRrPCnRlbfj3lg+0OdHmT?=
 =?us-ascii?Q?r2bOpaK/n2Uvlo4TQ8M5Aw2c+FDo3Upb3V8Z1hYjBAUFEMhskZVrrqwTE3E3?=
 =?us-ascii?Q?TyQPMwRmZNHcoJYQhsTXlZcU/zyW0pfcoj1L9cxZLXxwIOCeKnti0/RbgF0Z?=
 =?us-ascii?Q?P7apFYB3d01jK3IO7K4KEmXDf67oDaxsMRqHsfYEsvxsRSQ9JQsPTnwwE1cI?=
 =?us-ascii?Q?EAadqBP+ITyrPPoCJDoKIlzjd9hNhdhumfdvyHAvv3TQLgGbPJ3i9Hu/mU4b?=
 =?us-ascii?Q?2kjGeG+TgyH4lPy5zXpy5Kb3321tDwqS8+nQlEMmYn8oM3IqThzXnciKU8cu?=
 =?us-ascii?Q?B4z1SQUAJCoDMw/tLPkqCJZUSnoirqVRlIsWq3jCX3FddbPCnzk7+06p/Sxt?=
 =?us-ascii?Q?15Gfe9TwB4cI8cQ2PMMU4uQ61+Zb1SHJO5piJwE0X44mqRr2DCzx52gCbIbt?=
 =?us-ascii?Q?kjgc6LiIiDCANNuDBZFCSfHc7Cf9zy5iVvbhl5u9Lz+qwPqYHxgpWpKxdkEP?=
 =?us-ascii?Q?rlgOaSHgsflfWMpB8+qmZpGuONMa15J6FLFs9UbtvXiAUsGR4p8eegyoy7Fa?=
 =?us-ascii?Q?QGBKujMzs0rbwU0SHHHuJslRk5SkLFkbOLFsJxQFnvoNymo9nXh58w2Khysk?=
 =?us-ascii?Q?vDyDzzoCSQJvOMy8wbVs6c7iDqBlYJSnCP0UkmQsIrO2L72WYID2a6W1JPql?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830c78ba-77ad-4403-f21e-08db7ef8dd05
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:45:52.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmyJ4Qa07SvUJPjzSxcM/vdsCG3ZQjH4NRpKn6oUkThyj5fj4IUrvxVOmyqcNiVQNECzm3ezdtRvYZuqjmpBww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070136
X-Proofpoint-ORIG-GUID: XGAq0KAdlvcM6X-WuDg1S5hexek4CclT
X-Proofpoint-GUID: XGAq0KAdlvcM6X-WuDg1S5hexek4CclT
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

* Peng Zhang <zhangpeng.00@bytedance.com> [230707 06:11]:
> Make mas_validate_gaps() check whether the offset in the metadata points
> to the largest gap. By the way, simplify this function.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 68 +++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 6a8982146338..1fe8b6a787dd 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6983,15 +6983,16 @@ EXPORT_SYMBOL_GPL(mt_dump);
>  static void mas_validate_gaps(struct ma_state *mas)
>  {
>  	struct maple_enode *mte = mas->node;
> -	struct maple_node *p_mn;
> +	struct maple_node *p_mn, *node = mte_to_node(mte);
> +	enum maple_type mt = mte_node_type(mas->node);
>  	unsigned long gap = 0, max_gap = 0;
>  	unsigned long p_end, p_start = mas->min;
> -	unsigned char p_slot;
> +	unsigned char p_slot, offset;
>  	unsigned long *gaps = NULL;
> -	unsigned long *pivots = ma_pivots(mte_to_node(mte), mte_node_type(mte));
> +	unsigned long *pivots = ma_pivots(node, mt);
>  	int i;
>  
> -	if (ma_is_dense(mte_node_type(mte))) {
> +	if (ma_is_dense(mt)) {
>  		for (i = 0; i < mt_slot_count(mte); i++) {
>  			if (mas_get_slot(mas, i)) {
>  				if (gap > max_gap)
> @@ -7004,52 +7005,51 @@ static void mas_validate_gaps(struct ma_state *mas)
>  		goto counted;
>  	}
>  
> -	gaps = ma_gaps(mte_to_node(mte), mte_node_type(mte));
> +	gaps = ma_gaps(node, mt);
>  	for (i = 0; i < mt_slot_count(mte); i++) {
> -		p_end = mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
> +		p_end = mas_logical_pivot(mas, pivots, i, mt);
>  
>  		if (!gaps) {
> -			if (mas_get_slot(mas, i)) {
> -				gap = 0;
> -				goto not_empty;
> -			}
> -
> -			gap += p_end - p_start + 1;
> +			if (!mas_get_slot(mas, i))
> +				gap = p_end - p_start + 1;
>  		} else {
>  			void *entry = mas_get_slot(mas, i);
>  
>  			gap = gaps[i];
> -			if (!entry) {
> -				if (gap != p_end - p_start + 1) {
> -					pr_err("%p[%u] -> %p %lu != %lu - %lu + 1\n",
> -						mas_mn(mas), i,
> -						mas_get_slot(mas, i), gap,
> -						p_end, p_start);
> -					mt_dump(mas->tree, mt_dump_hex);
> -
> -					MT_BUG_ON(mas->tree,
> -						gap != p_end - p_start + 1);
> -				}
> -			} else {
> -				if (gap > p_end - p_start + 1) {
> -					pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
> -					mas_mn(mas), i, gap, p_end, p_start,
> -					p_end - p_start + 1);
> -					MT_BUG_ON(mas->tree,
> -						gap > p_end - p_start + 1);
> -				}
> +			MT_BUG_ON(mas->tree, !entry);
> +
> +			if (gap > p_end - p_start + 1) {
> +				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
> +				mas_mn(mas), i, gap, p_end, p_start,
> +				p_end - p_start + 1);
> +				MT_BUG_ON(mas->tree,
> +					gap > p_end - p_start + 1);

Your change above points out that we are not verifying all gaps are zero
in non-leaf nodes after p_end >= mas->max.  If we don't have a 'no gap'
indicator then this may be an issue, or maybe it already is an issue?

>  			}
>  		}
>  
>  		if (gap > max_gap)
>  			max_gap = gap;
> -not_empty:
> +
>  		p_start = p_end + 1;
>  		if (p_end >= mas->max)
>  			break;
>  	}
>  
>  counted:
> +	if (mt == maple_arange_64) {

We could loop through the remainder of the gaps here pretty easily.

> +		offset = ma_meta_gap(node, mt);
> +		if (offset > mt_slots[mt]) {
> +			pr_err("gap offset %p[%u] is invalid\n", node, offset);
> +			MT_BUG_ON(mas->tree, 1);
> +		}
> +
> +		if (gaps[offset] != max_gap) {
> +			pr_err("gap %p[%u] is not the largest gap %lu\n",
> +			       node, offset, max_gap);
> +			MT_BUG_ON(mas->tree, 1);
> +		}
> +	}
> +
>  	if (mte_is_root(mte))
>  		return;
>  
> @@ -7059,10 +7059,8 @@ static void mas_validate_gaps(struct ma_state *mas)
>  	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
>  		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
>  		mt_dump(mas->tree, mt_dump_hex);
> +		MT_BUG_ON(mas->tree, 1);
>  	}
> -
> -	MT_BUG_ON(mas->tree,
> -		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
>  }
>  
>  static void mas_validate_parent_slot(struct ma_state *mas)
> -- 
> 2.20.1
> 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
