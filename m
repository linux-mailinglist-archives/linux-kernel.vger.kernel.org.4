Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E526F366E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEAS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjEAS66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:58:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF142D60
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:58:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341HNxPX014506;
        Mon, 1 May 2023 18:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-03-30;
 bh=xeHBM5iVtie+PGiRNpDWOwmCQRq7kQZO4WL8stJeZ+o=;
 b=ZyUA2F+iX3dylZGR3dirEZGIHgtfx8TM9+OaEAXR+o6d1tIABIhGkJ1JY45DTLRyPOrq
 TsiF1L58eeQ/fPzb4JU6GdYzWHId9/R1F6jcxk4sOfSfhBVbgKmcBV1RMMrNli0Pa2jF
 XsDOvUwp3PAoZ5Ov0+zPjm8KFMpS9Cf8ND19XGTllKlJJ7bBaLjCdNYAn09QuAGC1LfW
 WSjiocUxG63QFFrutcm1tQD+xXHKbw1NtLrYU6A6Vv1l+33DmdwQoJIG2zzcQbBYk91V
 BHSUZi+vQJ6+vyx0DUoWSgSUCA8PU+dOsamqhp+tzU8oP4kvnqlvZbDYsOmSsVENCHq9 Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9cu15t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 18:58:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341IlntL013647;
        Mon, 1 May 2023 18:58:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp59cvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 18:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAeM4IdH8wjxBNYEF3QB515BV2pjsPYWhXtbTovZHN8xUE+ZAsMHO7NglOBqfFqijE4ZbzPQXt6SesesRCq1r/No6oTOitLUNTx1NhOz0RgdmNyNBXfBsNIAcPLBX+tnIfYQ0gypf2k0vPisYpra/PFMO68gSk8fqUnwAj5eUsAyeXGFnnj9KU0GjgUGTXxfxu4j1mu7XZRdD/rbDg0P2hKRMdF4Y221MjSf6qpAClJsuPV4fET2+978ojSzbKWQIL8sxaXTR6x0Ar+VDcP5JUqabELM1cBLKJF9WpTKEfn0GbPUEnq/Q1m3k2KE6/AS87Zc3yB+myIsY/6noc/55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeHBM5iVtie+PGiRNpDWOwmCQRq7kQZO4WL8stJeZ+o=;
 b=G8US20w//fl/pcw6wJqa5XNh0px1f9JZQ5aG9+bM3WDc0WPT2FCl7RLDzvnxWCbufxaTlfJ2CZo4x5geLMf5aNtFSx5z/2GKXIBZbVJLIZD97Uvbuun7JrGJ3ZLkzLyvVbpTpQTwX4cUaGOF6PEa9HQf6UFRspukkiRUKKws6huYkzqZFV9ZduyVviJ/ElkQ7rVdkowAhPQi0lY42VpqabN81ab0+IwH50mwntZ09C/gjYJdWa7UEwBSxjSNwsad2lqInJRTr8wra+rFc2Rzrq8Z3mZ0o+LTSxKzh1NVcftsRxenyweGCwQch6dkqyhhG5oJDLGSPcRMjyvJrGlIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeHBM5iVtie+PGiRNpDWOwmCQRq7kQZO4WL8stJeZ+o=;
 b=l7+KiZzQNMbYjtMub/LcWOlRk1pNctoJJXiKrvWklhG2f+kmWpqMs5JCoM45wjuP5kiJ/M+sqRl0iNbceCdCvKECWveDAvcc65P40UJY4Hh2zGS9Z9wX96D/dlOWr+O1+qMmHFbiYAjdCr7EiG+VrL/E6DWpZSggyv4sA/eouys=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:58:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:58:39 +0000
Date:   Mon, 1 May 2023 11:58:36 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: mbind MPOL_INTERLEAVE existing pages
Message-ID: <20230501185836.GA85110@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb0b7f4-d59d-424a-e43d-08db4a761321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmbXje5dDgzdivIi03sqLsyKDeXc2yXhy61RJedU/NLMsUOtVL267jqWLAOGeeM7qct2xLG2o2nibiUBKW9oEBeJrfsk+hQrzfn09InD6tEv08gnrJjQK7dWDpgXJ99Fw4WrNrbmDE39q2KWbNWutGqvcXnCEpN9scobrAkk9kez8o9uq1XXk2iCvCCnbPX0DxP8KD2rwr4kD2X+13FTduW2zMDIXEwnsOYK7+ZaSg/n+MmOx3UIZ09ckyMiVTlG1aQtL6lqWUCNXF8+/4eEDTVYhcU9gKtEOu9LOz1BZzwmau08bTIRrSslklZlkyq/w9VnUEfrEhElxwMNLvLQwklOAbFq8cJEf2LogN6EVGF1JCri9NKE6k/VUOdb1u+YAB6X2fwnNlTMshl99tLnSHotpsCsqwGN4rMY/X3c4kw0pY//08aMx4ZgExJh+Erhujzu+fK/Vqeabbz6IzhH4Bb+Htur1KcNl7H3FB8gJa+mRw2vuAJmvnj/kpJ4X7a3mTzn/ydIVINZq7c8N+PKj4bcCJ0VAbfDV+eiYjOVgefuyH/WaIGsAWXQ6Jxz/pJq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(5660300002)(44832011)(86362001)(83380400001)(9686003)(33716001)(6506007)(26005)(186003)(1076003)(6512007)(38100700002)(8936002)(8676002)(33656002)(478600001)(54906003)(6486002)(6666004)(316002)(41300700001)(4326008)(66556008)(66476007)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbB3VPmwKgm7ZyZwQJFS22VCG2vT/wbkee+8qTkX8ZaPf5IsB0cvqQaZYmi/?=
 =?us-ascii?Q?vaaNMYTaneAbxr+UKmqkKg7LS23r4IcGIo5F0PNmZy5NS9kQ/Ik9dhWneXSm?=
 =?us-ascii?Q?syn+oEf2f6bTy6iUWbA8JNGtpRBS0ljB92UktqTu1G4JNg5fbD34AN421evi?=
 =?us-ascii?Q?pwcgPt+q7Ib2nXuC2ndy8J/+gPe6oF1Zt6F2ZT9FQGGm5ohjxfahdGOwcS93?=
 =?us-ascii?Q?IdN5bSGd1CuLHNKOuaxf+R66dUX5k+JiXG7FOPXkAkCTFBZk4bFCuS6pkcH2?=
 =?us-ascii?Q?QkAoAn++HzQsd0N45leGCX3q5G4+s2VtqX7b3DH0qaNp3q/ocYzHEl9qSh3q?=
 =?us-ascii?Q?k1TO/sj44E+MeZ4L9Yc9O58y3bg9+gTC8hmn03ny2i/KD3deTJMTFcqvJv4l?=
 =?us-ascii?Q?MB7NJyLOElQp870Q57ICV2nVm8F/4bmENC1qQoMx1ZMtg3SmmPdd53+LYCkN?=
 =?us-ascii?Q?MIZAD800eVj3E2UEWKgMlYNR4lqLJexv5Y0K3YQFzHrRlT0oj3g+T3fThR8v?=
 =?us-ascii?Q?Rrl7lk3P2NtLqEZglgYM6MFcUB4JPhNBGY8wBzWuQdbmneJxYs7s2341/5MM?=
 =?us-ascii?Q?7hWDZnjotzm2LhDhbYfd2tE7TwBjSYJnXoI4HLgsMupJkUqHDUdBeFq9nX4x?=
 =?us-ascii?Q?ks9QnaRjeNb3NDFmDDLunODQjsYM7fs3tQ76HxePzIYgP1X7mYb7lLeth3PO?=
 =?us-ascii?Q?rDyH2uLGrMmio9YQmYAXQupHP9ixnE35iWGMRoR8xZA7dgKtzzy+B6nO+o1z?=
 =?us-ascii?Q?bqn0wly2ynyP268G0hdGaBR1eANJVMm7uPGoiQxAgvrsNx3UXGZlMGGggbMT?=
 =?us-ascii?Q?uKfI40atT3HT9hYt8m7SCvbuVf8cqaw3AhvDG0ofjcBLWnueGskg/zpG6TF3?=
 =?us-ascii?Q?pcaZAMsiGqrphhWOqPxfhPdt6j4fIs+Wd6yIW4Hm+c/TuLM4+VIishnZ/23v?=
 =?us-ascii?Q?HuU4vC6aphykowNQniwvdcdlCgIKSFRqA6GvPFN5tPqaD9ZLZSFrWQD5buOx?=
 =?us-ascii?Q?+5jj3KPv68EAMhkNW6BmTsoHiZgipJwnI47KZ/r8xAIpLIL36oF7flApM1kK?=
 =?us-ascii?Q?r7RdCt6imSoMkL1LSKC6KjXB2YjVzj7cOJyiTMPFwcinQabr5zxui/zHdo/t?=
 =?us-ascii?Q?egO++AI0AEjGFrI5oMNluasuxAcIL92ZWyhk5fi7pcmyFrNxRHu2HfV766Hk?=
 =?us-ascii?Q?BVNroDlb0SAQYyPDNwq2p3zL8Kugfz98lf08FJSzdSvVOmSXPQqTOocgWBDU?=
 =?us-ascii?Q?AeTC1b3OIsYmdjwrQyqYfm28HIpvu/bMetXYIOW8emiJv6mqhVokqoQ6X1rh?=
 =?us-ascii?Q?K65Ru1vFJOf0oEPzHLNvGnPyvUAU29gLP6XqkQ8fh8pa8hukcTizqIR/4YFW?=
 =?us-ascii?Q?mZ0kYwCwNTj4OYCZen53ETW7bqoQNLaBvXRVjgT9fUbmpZnmqD4HtAiti1Au?=
 =?us-ascii?Q?6fDjMNgwtIzPZDumGYt+fedrXXC7tSbb74TEzXaiT6+HlikRHF3cXziDvOYX?=
 =?us-ascii?Q?LGhXbViMoJ+0GNg/JWU1trAgA33euuh/721F398cCyRepqpt5K7XMns1Haei?=
 =?us-ascii?Q?hvZtva7n2XWxkgCNBqnhjT9Hk3uSx820U+AuDr+J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FWNOyn90sXQUzOhvm2PSTZclrGdtsxOtXuadTippL3ETOCPcCeTN3IFcCg+vsv8Q06CnMnJUPNJ2o/WNGUyf6fJhW71kwPkA0naBFV3mie6GPLdaC+tCWbulBS7enjqwXifBV0r6/WmKZkdKeBjQjUoIzBJO3gFrHgd7HdQoMMLVkaF+Vfk6rFXXANmsYWC67ZlUhmoJXiOF648IX//Y5IpqT9GpaQ/hhLoglfOLIY7PlpJYeeGcvA1skZfTtA4Kdy8vQWkl+iJWe9pexQdaV//E/cohBBMfG2tFES0rgUrYEvhvheJ22uyc4/w2nEWFlQX00pjHpfpA5Egc/bCMWKDOsRk6PEZoEAgN/AWeCOvhW/pnM0DYYt4Tn/1L9+RDagZE5O6YeQRzQ0siKht3EIqFeHfiiUD1DqLYQ+ndVGQKjQpe+nfAP6h0zJyIJenZSqvJRr5XPC64kCA01So1vzLdcG39objLc0pkRO3EnaIQVEaUM1X00p/VKLxBPx2cctozXxzCDGTSoYLj3kxKs6gv8Iz6p0dCRnfB0i8hTPfdlBYIFGaBnAm4psP0e7lPrgcAsne+V++RiyqpKf62aNbmGro8snfScUm36PGBhe5/kykwe/Kp+LuuWp3N1wo8Uu9f04xB3TYNQ/U0+dyquCatKSviVsxVvenBrGF2RVHW+7ftx4Hv/vI6KtKVu/nzq2z9HJu7L/JQDGIj0JX+ngNe4HGlQDi0OMwBGzvK5GFLS31x7fmeLvsARNbMpy4IbrSNPBD9j9URfMtd7pEJnsS4yzN5j8G7OKiuCCKxgO6eedgEv/7OZhz9TxUgO6K21jde9prY8zbKZ3XJErwFPGU2ftKrOv/E6d6yYHS6jWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb0b7f4-d59d-424a-e43d-08db4a761321
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:58:39.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLt5vEUZ0h2aCU/MrPcZtMe8DkIXK+aDfVjhFNkRPwOQroy8KKZdPiCZb0J4vUTXVMg/F12YLSb+k+7adtBPCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_11,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=619 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010154
X-Proofpoint-GUID: lPRPTtc7DIuXccSWGKDDtI9oV6CpsO_W
X-Proofpoint-ORIG-GUID: lPRPTtc7DIuXccSWGKDDtI9oV6CpsO_W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I received a question from a customer that was trying to move pages via
the mbind system call.  In this specific case, the system had two nodes
and all pages in the range were already present on node 0.  They then
called mbind with mode MPOL_INTERLEAVE and the MPOL_MF_MOVE_ALL flag.  Their
expectation was that half the pages in the range would be moved to node 1
in an interleaved pattern.

In the above situation, no pages actually get moved.  This is because mbind
creates a list of pages to be moved via:

	ret = queue_pages_range(mm, start, end, nmask,
                          flags | MPOL_MF_INVERT, &pagelist);

No page will be added to the list as queue_folio_required is called for each
page to determine if it resides within the set of nodes.  And, all page are
within the set.

I have reread the mbind man page several times and agree that one might
expect MPOL_INTERLEAVE with MPOL_MF_MOVE_ALL to move pages and create an
interleaved pattern.  My question is should we:
- Change mbind so that pages are moved to an interleaved pattern?
- Update the documentation to be more explicit?

I can do either, but just wanted to get opinions before starting.
-- 
Mike Kravetz
