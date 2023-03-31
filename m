Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543FC6D27CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjCaS2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCaS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:28:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E320DB5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:28:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VHNscj016715;
        Fri, 31 Mar 2023 18:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=MRi4DfW2GRFVrbuvxyEoVrSSrSijr2TCCiq9lkrEWVs=;
 b=q25hBnTmMIoLihbdw7xoWaYcGB3L8i2PpxvBpiz4NEMTOXu2giPYM2WcAswPBMKQb3Mj
 o+8j7yIzc7WKyYGMe52mw5YCCxebf6V37NrJxICzZmFOCSjCNLdf8ISi+nJFnTbMib1k
 kC6G7qo0Tan4ejqGnhMVwPmlYKq7X2f/LAAXyT/mbXWvv0cCvSZtD2n4l8QRF00uZE8B
 +UlwxX612ZZLzC4H8/kU2/4GxVVJhKAOW9gHyaBJitwHnfyNCd5gw/eDB6f17XeO5Naz
 JS0eR2y13Z8Pdgt7VhcutNezNCUc64gm2gOZqpG9WcjyG9RX8HDJYdipj5g1MSMdPchh IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyxrnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:28:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VHkdUk018603;
        Fri, 31 Mar 2023 18:28:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdj1qer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 18:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjClWVK+L6lGaMM5d303b1DAX5akrjsbGtORyhjRHgjmqG20itYMQdt9LjWNv0BDM56FMiAlXHZl9+ujj5q8Wz9FPgpvEZQEo3+dzpKdhA7IXVwYqnuNf9wuRifdXG6ak7cZZzpGOV0BNVxpCU8EsPGixBj9O5c6cOcmT+1iGdjQo273FfbvXnW/4kF78UROFdHJ+256OuNpu2pCyv+0p0vSfNORIJPIf98NvLS+B4na+kANg20mdWJvBhJdYq+KVtK6YdQgwZXuL4NcFx32VeS099hgUSgJFzp8U52BJOW+CnJzogRPT41oBqSLnoW3TSdPoNzsWnYKvtzyoOmPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRi4DfW2GRFVrbuvxyEoVrSSrSijr2TCCiq9lkrEWVs=;
 b=XVxc2rNkWPTCTiaWB7mh9mWZW8PlA+4Yi5GHPucLTAaLp9+Qrao6fWBjdxTq//lxywWa1cElizK25PUMwNjP8KZ0jhQQIAEP7EH5sufF+TFaKrYr5EDVjG3xldcNF3OEr7twXkVoE6nE68vthCKihlLMbSuSNYHl/17nxXHegFTs9Im2jhQ0VEb+jyV249Cx84G1qbOq2C+x+n1dWqLmbBMcT5EAtECdUVcAIDSaAMUQsf+L+KJtN1YOzM2pCEj+xjGgg2T/O6n6gsvfWHRhkkqdVJ+E45b37a1TYDxsCLTTAPw6NvLZEV3ibnxLimm9TVgmTRZU802Snt/PQWS4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRi4DfW2GRFVrbuvxyEoVrSSrSijr2TCCiq9lkrEWVs=;
 b=sFHTSCwAU0ZWaBQwIX5se0N8lwupAx02q2GLc7KZ9Mlsz9NbCVsh1K0xAW1+f79zH8yZkrGtAx9RBFs8AAYO22DzaOlPeXIJy5NmjdEIdhJAwwToe1rCOyiQWokFB2LduSzL9gvp4bWysQIqac6M87fkIwOw0M5roBcg1K/fhjk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 18:27:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%9]) with mapi id 15.20.6254.023; Fri, 31 Mar 2023
 18:27:43 +0000
Date:   Fri, 31 Mar 2023 11:27:40 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 09/29] selftests/mm: Reuse pagemap_get_entry() in
 vm_util.h
Message-ID: <20230331182740.GC12460@monkey>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160711.3106988-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160711.3106988-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ccb35-88e5-42f2-1738-08db32159e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5grRwSq1Cgkf3dZSr31fnMzqUjO6TPTsKx07MiPtHwNUzrOOVW6D8bTGNtxjsnd6lzfFURrSpOQUPote5dtJ39BT1u1tEUerFDczTpbi1idWIOo5rrDVE+kDssb7V9eNBHT8he5hFDrGTs3oqTYz98TipElSdVtR1SgmiC2/akdLBYI8G3aA1qumS7PpT2eUz1fQCGXLmFqi4d1wXexNT88w9mZuaT4+RYGge76rUP7ZY7ZlmQZzQACoiuOzH0evVO3m0Cs+O7DqOrSoFJ5mb9GudTraHjF5BrKtpH9rL1NqR/NWoFO/KxAxEGNWIxNQ9ntKfHUdKnckr01JsQCASr/If+5am1fnBF7tU5sXfgLvwTbr+wCDFz/Jml3feW6MPJK4I3zFueM3Ktt0+lXvw1yC1F5xDBpwd/Cws/z43ZKEy68Z3uE+AaH8GszNgFMsJkmD0OimYpVXWRi8MgMpScJboZ0kGDEY0YHL9mKUU5dN7CF7YICps33Wrj64ArPbZjQPif4KW0dwiOsd2TBm0KDd6jqk+gJMikFb8T0RLycuVaRHuOZ7U5Z1tKf5GbKo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(54906003)(316002)(478600001)(7416002)(5660300002)(38100700002)(2906002)(66946007)(8936002)(41300700001)(83380400001)(44832011)(6916009)(8676002)(66476007)(66556008)(4744005)(33656002)(9686003)(6506007)(26005)(53546011)(4326008)(186003)(86362001)(6512007)(1076003)(33716001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbAiop4sfmJ5g1pauL4tfPwkNkmfD6sETWLSfWkUgAlT1r2boYKx2Bjenxfu?=
 =?us-ascii?Q?d3WJpoRFhPyuLnkjclk/++ibDOl9x536lDvdFvnKc37aFOJoLxq0WieE0CjF?=
 =?us-ascii?Q?rXbhc03fIn+9EilK/Iu7KXr7idRoSn8WSROrTa5dgPMlA8EBjll9i+MbP8a+?=
 =?us-ascii?Q?QlhSuxatZheLUaI1VIeq1fMBH8hW6N0DCEU4zc/MQkSo4ub1aMqkHtci3pWF?=
 =?us-ascii?Q?zRLOAjbEdV275nEDePaeBpTxeMwV7MpsfeJByu93eC3GHhb/jgJFetg6UWYf?=
 =?us-ascii?Q?HK1YjyT15XhomoOKZC3GgIvpdtWTEPsiK0MMrZ6RWtDdorlO0S1NmjEavZPL?=
 =?us-ascii?Q?AxA+Q1bnbPFtzLqFoGKOhbdzjYyXx5GVPRlnQ2Bl331U6lR9dzKMtivSNSFG?=
 =?us-ascii?Q?GrQQOT1gCZ6/GBEOEskScjPM6ubAOBmWFWTg46voziw9rgqRghOZIuiIKhTT?=
 =?us-ascii?Q?VwERpILrNuA84y1+ovT66Sl1NdO4HtBDL5wr7hWI5QFGD2x3wrio3HhizGfg?=
 =?us-ascii?Q?qqfYTaK4OOAWpzIngtM9NaE20t6cgVqh+9y1hnIBGQzkR34NKaL0U3yFuw6H?=
 =?us-ascii?Q?HJLrKBVpzX0WksoZdwYo9qkeipOvvkS73Q9DMAPwFUYnodlF1C5pAgdqm25u?=
 =?us-ascii?Q?rbQJuRUt3jy4fQTSbBUR4d0NJu/q93RLscatuWdyLJnAYJtLiuc0vzwOr9Np?=
 =?us-ascii?Q?3dTedZgJ2z3Cw+JoCOEAbY1E/9w1Uw+30ghmp01Y8wYGAx/fzLlMdWQhA8ug?=
 =?us-ascii?Q?A+VmxWG6iHVALrCJc1YJEK3AIe2GAJuCPs+QTJC5MFxx5Zyto7s8knRToOwJ?=
 =?us-ascii?Q?w2gNNRv2wZKz97rSNT0f3MnpSa93WQ5mY2I8Zme0Zrm3+IJH6jr2ngx6XBlT?=
 =?us-ascii?Q?G4jlQC8Elj4Qd1MeNL1McHrhGVjv9/TizsAb5/gZ2vX2np0Br+OEAdPHMvJE?=
 =?us-ascii?Q?5WtYN88gaqRHi7xPRx+FHIjFrxWkYYFp/pTQitJlP8WyZT76fmXNAV3zPS6m?=
 =?us-ascii?Q?1CN5QM+v7pA1ZSg7V+9n+GYucH2to088zYvXfDSrEFQFpJKFOMSeD+/xHOrU?=
 =?us-ascii?Q?ofiWXwCUI7yz0JcSJji8cdg5eBmHcQZJFy0jrzYaa1v/zV1yWKRCWFb0X6iH?=
 =?us-ascii?Q?Nolhlq5gVoJFb8UojDLLoOSmMvsBgYWxomX+9Ry+Ke8zjvg1QA71ucV/u0BF?=
 =?us-ascii?Q?Zd3vrVzBrZaT///utigX29/Dw+h9k4EpYdV9pRkyjwV0IF/tklUTKV/zQTew?=
 =?us-ascii?Q?jx7nRygUGAKuVMAXAmeCnDwmg4udi+YEdmWYmJQ+ugItdBfQi2SaIeWIeJJ8?=
 =?us-ascii?Q?Aub+2n4NvFNCw3crFxetlBkb8YOxIfmPNDAXNsNjZisAzSIRPHvvQwhZ9fSQ?=
 =?us-ascii?Q?gKrYHyPJuHpWYc7vYY36xPtVVgJpA51H1igYLXU7uo8141GCkUsxlbfBc/Uq?=
 =?us-ascii?Q?QLqAvKZaqyJwwT3mBXFNgqXZ95aM4Rt4GsOio/QkHIuEg8eB0axAX+vAk3mU?=
 =?us-ascii?Q?i6Q1DjJwwZboezMlah5OUwdLewYlRTq0QJRQkzklSN9mQvlVOyTEAgXhSKkA?=
 =?us-ascii?Q?VZhyxvsUvYHECnNaj5w6iz31HaQRKQhoXuFob4LaCADEEFiVVc0xMKwpS7Lt?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OWJBN62cLTToDwYFOv5hCTMMKy8GNdIqwritdOIZrtwwfxihtHj7npkMaUrQ?=
 =?us-ascii?Q?4Rr3t1bbT/GyPrcdtc1qpL6FsrPBoISLMd70FDQVxtfXs1AMv4EJBvw6KniQ?=
 =?us-ascii?Q?eJszrfkgswT44X3dLsVbAY0+eQdmAsgZGa0WqbWEF+SX5TJrMw74X8m9jPwy?=
 =?us-ascii?Q?PS0hRGzHV805/WXtrp2nJOS3rTJMBBpLRwP8LRUTfetpfedEK3MvuR+VW9oZ?=
 =?us-ascii?Q?yEQUI7Z7vDobAj1mjDJgG4roiTHdr1NYmHpaaFsS19MpyVER2CQkM5N2LdYl?=
 =?us-ascii?Q?kTV39Yl7Ff5LGAZ7X9VCEA4z2AIaNXMsRNbnAX+gklTaI76DnacE172mtxhG?=
 =?us-ascii?Q?uDjlSMewPy+FR1NWEb4xrvAVNiJ7tbnkKjcXsOVud6fzFV0NPhWurPxdzTlM?=
 =?us-ascii?Q?BT5Mxd7ATeHDX3hMaOBlQ93d8roVbSZdCOLagiEpj2NH2k88MnA5qeNqeJT+?=
 =?us-ascii?Q?blcZ9zEh0VukPtEBPr1JcXvrB0w6NKKmE61PIxysOrw0NIqJ4vRKYRdOytlt?=
 =?us-ascii?Q?o0q8odqgffippbT8Cn7GHzuzcdz3GsoOUGWsI5yIgWVmpZ7rdJE76MAJXjUL?=
 =?us-ascii?Q?SqzKNhok//qiYEkr3yN8iKdLEK04g5H3aljG+bZ1L1Pyo4Sh1PN0gG9+/vM0?=
 =?us-ascii?Q?8G651b8nVLvxHSXuapMenv5lGTR3ClFyTjhBhVrpG54Qa0r9fWPqCaiYNGPI?=
 =?us-ascii?Q?16LjHmEt+me3Ke7u4lxMG1qQ6itbq554Vo7i2J3PQfSxS8Y0OA0mGrihcwgQ?=
 =?us-ascii?Q?EDZorTQ0A8oog5+f2TMgdJjMQpPzmjiIBfs21twMAhLtk3dftKtQgyjfDne0?=
 =?us-ascii?Q?Hqrl+ubi5b0y9JptKpukbIgf0AyB2mPBKp1VtEgH14H5wJAeQPuC7f2YDeET?=
 =?us-ascii?Q?OutKn/Jsj/Q6Xd1L3Op+QfCEvG4ghIUR05NcJgkc9tE5uFYwv9Djif2pxtz4?=
 =?us-ascii?Q?wE231X/UDEn1AYu9IGFIoEdMvvWb0pnJzU5zkI9VSWE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ccb35-88e5-42f2-1738-08db32159e47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 18:27:43.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6avuaMQRvYq6KqRPKtagQ9KGjduX2FCCD7IcxdoHnJhIhQZNTplbGuyRWj+qqml63OxwwwwyWedZKx47UHJK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310149
X-Proofpoint-GUID: mM06ZE4smteXtE3t36W_JYofAEDWqMrb
X-Proofpoint-ORIG-GUID: mM06ZE4smteXtE3t36W_JYofAEDWqMrb
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/23 12:07, Peter Xu wrote:
> Meanwhile drop pagemap_read_vaddr().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/userfaultfd.c | 31 +++++++-----------------
>  1 file changed, 9 insertions(+), 22 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
