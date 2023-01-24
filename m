Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3A679D56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjAXPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjAXPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:23:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AD7DAF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:23:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEnPG6012233;
        Tue, 24 Jan 2023 15:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hy6jCI7pFfU3MAsFB7t1PplYcEQPLc/a/45P3Pywvg8=;
 b=oM34hkwtCH9AzZP4Uv9sENB4Bj6DcTz3LN2P1HrNJlZGm8i58KHLGfSds7tmkzS8AlVJ
 +809vgnbadaN2VzVIJ6bljAxAiDEQThid4BFpGmsnAXsnArQT4cEHeRtUjM+8VmAHa08
 WNJyvrD2+A5WLDHVxuEI0hkMhWp3SEJgHztSHMlHukH9li3mXr0a6z8J0zgpFWWeFYci
 c97SI0cSBySs6X64kNg4HMyXiOg32gt48fUywEqve+c1v+gmPgDi1zh87mBnysn3kO6H
 cJa7CtFJ+nyjkzuWjabVh9AAs7biJRgU71xdbazo2YAPXXUkbiDrR5Mm9Z7lzBzag274 bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktwf8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:23:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OE7I1P005971;
        Tue, 24 Jan 2023 15:23:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g51va2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk0AnhB28ZwBvjN6OwLBoLdWmL87gbr9s2bQ3h6I0hDjPNL8AAyo3wqb8ny61nX2QTFwYWvTksD6uyead2uEDTBbfmxvsU2DVTTwSnK6JJwie/THxua0ydN+M62XyrcJ3lasdTu5ihAMu+Gw0xCDHcaFf65cgJmlGvSY4N4BMuPm/vURekqovzL2CFzSF/dFfbOh/8qVwobE98MgWLDqmR6/iHljIlmlB26jl8ZMPV5kE/z8DcQziufJ7ffDskEIubEANsl+ugxzepOHOpMtn23luGHLTmGKNNMWx3w3T88t5a1RImx2jMfihVdKzRHtpHEttgXsQT0o6+8fqQ9wQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy6jCI7pFfU3MAsFB7t1PplYcEQPLc/a/45P3Pywvg8=;
 b=Tak9TkLdIYA8GfuXv5rz5CyRKMbjViN1WfBMMocLAHvcopyjmtKmm1H0XSU3E+xFhW8QwgpRiih4V6aRDl0KFvgz6f9jSII7y4e7me3Z1k2EWrTGhZPjnQPucDcCuGi/xZfxHzenaA1P532dUv0ocs66EU7ZZrxVOOnqcxepSjYtt1pTWOxJV4JpkvlyXYzipAS/YJHjd/44TjwiScUoUsCBvD2RmScP+VWeK+dKv7wvJr3oWJNqtCn+bJrrtjXehDMVjkvSFJhWgHfKxnxw9gIX4ppUm42pUi1rLh4fILOfom0tRjZZv5idZBACyYzKmar5OQ4/YmLh5kWpUqMoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy6jCI7pFfU3MAsFB7t1PplYcEQPLc/a/45P3Pywvg8=;
 b=Oqrpo+akbw0ZqeNWOwn4pHosHveJFsUUZvJ702GXBXWnmouR2XYXoM2LAzYwYci3Rs/5F3IXA99ggLVPlAOgPJA29EMrHP0T6V0g8uojNSlIMl8WPPl6E2yEEhjtbf/3uX0DdIFzpMTjU68ZKuHXWPnDpAXyB4rbMzdcow6KRlU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 15:23:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Tue, 24 Jan 2023
 15:23:09 +0000
Date:   Tue, 24 Jan 2023 10:23:06 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Message-ID: <20230124152306.wozuqyl7ehl7mzjx@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230105160427.2988454-1-Liam.Howlett@oracle.com>
 <Y7fNo4IElYXCyPmd@kernel.org>
 <20230106183559.mpdywid4szzpghlk@revolver>
 <de1ed6a6-6f74-2664-dad4-3467efd83483@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1ed6a6-6f74-2664-dad4-3467efd83483@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2cb606-ffcf-4e38-3cc4-08dafe1ee675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NupngwFwDJUait4KG9dZeZDdc4PYrusDqrc9GCWDtDppFbM/J5ShijoxnXkvpVpjhD/taz7rZi+AqQ0LaXUEQacg+RuEmBnk/g/550PeTV6/TdL9YL4Oc5aN5rTcmbeGXXgMhJO3IhKy4Ip8fuLqjggVYX2B4E7KcXdDpmGi+XOTwfU1EDYwZStMNCOuFJ32AD6Iuk3ZKEZqg8biL7IaZq131ndHcmQDpkPaZVxWEMa11Up7zMMlYSHUbvUfpCrcckvZ1DDAKq6UaKTbHHCQl6kuV5UjMyUG1JYSzVM9aa3Oyw/gJtV4upuCJpGCqmVtA/G8KHPE6jRHcjXhONa27H/nSBQVp6KbftnNe0FXzhkaE2iLUV5OdyAEl/S0DbbtbpNFbptlKTTqPcvT1rcxamlBmWI0lWQoodDL8kF9rQ3rjy7VVEkSnA8qbFwxJcM3vsfLhNDzK7fDGlkdMJSyHkTMIRBorrzWOCLf1Gb5PoWIckAkDDKtpeKL/DRKaOmWaDYFAw9W2NL51BkVjsQG96/o5KjlYEklLG3ijmW/cbmy0TFyZAVY92AZ8+aogtugsbBIrghKjtYr0idS9v7uKHwQPpGcjA9ETCDt+urSVskKjzM25TK67YYcfj2cSmJN1Vul4zFX6PetZPwcrQrAXgwCNH+mQznhStIafONeUFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(33716001)(478600001)(2906002)(5660300002)(6486002)(6666004)(186003)(966005)(6512007)(9686003)(26005)(8936002)(54906003)(316002)(53546011)(66556008)(66946007)(8676002)(4326008)(6916009)(66476007)(1076003)(6506007)(83380400001)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R73tzXHUwH+ZRUFk1pKTHEJo9nyJvMEMH+XCRYayTlP5T+IaY61Z0QLrMmch?=
 =?us-ascii?Q?LJGlCO32mOp4Ty1d+iOwj6wRLdBuvV5c/QtlGYZCOE63D5N/DXUB25FI3t2V?=
 =?us-ascii?Q?+hI/TCxCoPbD+ozOHk+CyYaRjmynX8vpqwKm2KfQNWYqK2eBd+DTc1ONijXp?=
 =?us-ascii?Q?LxPP1mzWRkdpb0Kzick+H0EusVNMCGq5ickCmQqALurmtFjp6WkEPaHcdJln?=
 =?us-ascii?Q?FCkOnXeNeUOjmHiSZasPQCjzF3AmwoEcfMQIZ5XzU2D4aI66QmUAF55fErr7?=
 =?us-ascii?Q?R2FB43O0XNzNlkaGbHbJW8IhtYBx3lYlMU46U+Pp3MLYWUgycbFTqpfLSj8e?=
 =?us-ascii?Q?GHei/LsyU/NBx5Twxg9TKcSd7io16Ch3w2u98CoIN2HIY1PJwe+heLr/UAWt?=
 =?us-ascii?Q?dqA6Il2UYMwy1SfsIG/1/UM7bS2kS9IuE30yqUIz3rq7sceRau/IHrcwkl96?=
 =?us-ascii?Q?lLhpjII1MI6tVqL0Mi1aVAmgZAwL3aDncyQBpF3o6joi5WfIrEAwky4SJHeq?=
 =?us-ascii?Q?NXBRqD0lMeSPjSfoGRt0O2qTwe9jEMewI8j9JE847LjHi3bhsnTEgIsnBqgg?=
 =?us-ascii?Q?ch+LHvBab3qqvDpmXK2+FN3LlUxKTjB52fPsLZmFjhwFS1ZtlAoQcT4HcxT7?=
 =?us-ascii?Q?4s1s+Ebm8/gkOWC7PDgPn3enouWfe8VuoYfqbwFuON/O7BG7lidUWgruCN7S?=
 =?us-ascii?Q?evjXQyGZ8ax7L0of8uMcXmjm8JCf3EWsKipG+kzcAB+2bzPkBHYXwltMaEH0?=
 =?us-ascii?Q?ObHHILuWpT2VGO8m9n/qCIbcauuTYcBcTQyvroCFi6fDif1DLeyuUagOQVOU?=
 =?us-ascii?Q?Ve+fDjMLYT+scJvVYJMouAlNhESSi2GIaIJ/VwuDvFe+ga3HgEB87nTZCENQ?=
 =?us-ascii?Q?h6wR6ft1pi7wW3+pBICh7FWAqzEr/HFeECsrMQbgzEGgYWZjcspvOlp/43nA?=
 =?us-ascii?Q?JWFXcn1eJA38lmBiIpcz40exsLpe4MMLAEXv4z/ukY9c1SiiKTDLTvb3D6AX?=
 =?us-ascii?Q?BkIDvuYGEdX0K48BDHLbWUErasbSHXhfQLPd2USJwzpbvGWKh335DIGPfBPO?=
 =?us-ascii?Q?+IyGzzFvz3gklnCQ1jXPFuAlT9IgIC3X8nq2pLGkxFZcgjzKnZ4TmIvEDews?=
 =?us-ascii?Q?ASjD97DMMoxushjvKWLinrMdiTwgRxyLHVgUDUBPX/Refgv7y3uNyiCmQu/C?=
 =?us-ascii?Q?hKq2ZSbbM5JaZRk1Za+KTy7B6XpYBK25G8XLsORCVCAfXTeQrhSxNGfDmt/K?=
 =?us-ascii?Q?xzKdj6ciFBqy0xza0QY35E/H2Qr++3XN7SUHRnQ3unPkohgDsivQhWdzr42/?=
 =?us-ascii?Q?ITDsicleoVwODA6H0JmF/Kkyrc0sodyEo8XSc6dhX9qtmOi/te7cSx5M0Ehf?=
 =?us-ascii?Q?4u2PMIm30ouudAxBZEP/u6KMTbCDjUTtO9usvdAqQaAiQvY8rTk7KfLmy6xH?=
 =?us-ascii?Q?KiGw6bdKRg7yHU7Qo6jzrpZ+uGrdpCLNY+vkfZf0jZPo8w1OndtVThdwGNFG?=
 =?us-ascii?Q?DrzvPq6jaHWyc8KpnvcZnKexaHlOQL0AWLBiNyqzFHtaJF0gtuz1Rqwx3MBz?=
 =?us-ascii?Q?dD8eRZ3eWuB92mZZyOMBB0aR83HJ4AQb4NfRqBGojTuF1F4jm6Px3usKNYeG?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PKUMa6LLz8XR6fI4Yz/HgDVYvJYHcLs8oDmqTDB+3dnK+3UiSfCz8w2+kcOT?=
 =?us-ascii?Q?fsFsVUWFbM1LxtPKdzMLCyNRtKXLbG+aVsBbxLYN3jhgidMMicInausifZFv?=
 =?us-ascii?Q?uBxRXFFkx6joTwwkty3RA+uiPeMjAWO0crxqSioaZbB+bpjy9zFJR/XpT6cG?=
 =?us-ascii?Q?NffaPI4dWy+9Ywv8tEerG+aIVhWW7+LJ/ckcZTnqo8UGO1YsUny+bDQcdc2p?=
 =?us-ascii?Q?wB7aREijkeV4r1detluB6Iu6J795N3fNSSIDFc+b1M4H2805UG1iX3Gc2d15?=
 =?us-ascii?Q?NqyXUVGu5+L+NxnI3mVYu6z+BnL2ASqBQCs7EvOKU5D1IkOpAQwPgzSN8GyQ?=
 =?us-ascii?Q?I2jxHk/Yc0CgGXuTK0jzorV9AzAEp6CU3cKdVqu0lo77iy1l6pxbePsAcq+7?=
 =?us-ascii?Q?f+q/D6XpswxdjRjQRaEf8pMqdXhx8mB073A3HVptyEj0kR3pw38gUmFrtaTj?=
 =?us-ascii?Q?uU7Oz0srzOip/5ZdW4iLkPPEaHgVciMGTIARQrQbFwMmIbHcv3HvHPJqf2dh?=
 =?us-ascii?Q?PYgV8Jsx/6bVB7czBZs7svHWU02h4jYO4gKOK2LVQcStitRShWBFqpaCubxm?=
 =?us-ascii?Q?M/bMV4EM8DlpnhUdwiqDKhMl4WDJ4vuvcQerytGCwIKPtW8+DR3bm7NT3Qui?=
 =?us-ascii?Q?s5BchYxFFGAIpCUCDWIDmR/HFzSGhmPXgLvL6riz0wtXFXN/GUjsgBYwV11v?=
 =?us-ascii?Q?cVhFN6ufGbsMR/ZBn117RqDKkGwNoPB326WE+3yEga0SxGGtTKnWXJBe8ZaX?=
 =?us-ascii?Q?veyB9wzIJf5V243Qe3RrMJ+bS1iCUggTDHyeG77jm/+16Xju3aZj8DqOIvl9?=
 =?us-ascii?Q?XJt3iXt5SHCCN3bzxFB22T2o/jaahnDm5VqBzNB3bdAClQMZElDvVsAVeeGo?=
 =?us-ascii?Q?Jm7IQkXF168ET6WSmSk6uvV4TaY92UBYus5bIk8ohtecK5uuJJPRKJ3banFS?=
 =?us-ascii?Q?Ne6HPKPVLAdr4Tqe22W3sfpMUk4O3Z2XPl4zGl0ShQg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2cb606-ffcf-4e38-3cc4-08dafe1ee675
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:23:09.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ1MUsdiddYRrcyaHafJHFJn9MUih3HtwEnNAd0g44zxIeA3mzcAOAwWxQKozUAn/IIdHF3i/GfztmXB08yFMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240140
X-Proofpoint-GUID: ckIdP9M48K3K_rIckpCDVJmCLYu2Sclt
X-Proofpoint-ORIG-GUID: ckIdP9M48K3K_rIckpCDVJmCLYu2Sclt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [230124 08:18]:
> On 06.01.23 19:36, Liam Howlett wrote:
> > * Mike Rapoport <rppt@kernel.org> [230106 02:28]:
> > > On Thu, Jan 05, 2023 at 04:05:34PM +0000, Liam Howlett wrote:
> > > > Preallocations are common in the VMA code to avoid allocating under
> > > > certain locking conditions.  The preallocations must also cover the
> > > > worst-case scenario.  Removing the GFP_ZERO flag from the
> > > > kmem_cache_alloc() (and bulk variant) calls will reduce the amount of
> > > > time spent zeroing memory that may not be used.  Only zero out the
> > > > necessary area to keep track of the allocations in the maple state.
> > > > Zero the entire node prior to using it in the tree.
> > > > 
> > > > This required internal changes to node counting on allocation, so the
> > > > test code is also updated.
> > > > 
> > > > This restores some micro-benchmark performance:
> > > > up to +9% in mmtests mmap1 by my testing
> > > > +10% to +20% in mmap, mmapaddr, mmapmany tests reported by Red Hat
> > > > 
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2149636
> > > > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > > > Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
> > > > ---
> > > >   lib/maple_tree.c                 | 80 +++++++++++++++++---------------
> > > >   tools/testing/radix-tree/maple.c | 18 +++----
> > > >   2 files changed, 52 insertions(+), 46 deletions(-)
> > > > 
> > > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > > index 26e2045d3cda..82a8121fe49b 100644
> > > > --- a/lib/maple_tree.c
> > > > +++ b/lib/maple_tree.c
> > > > @@ -149,13 +149,12 @@ struct maple_subtree_state {
> > > >   /* Functions */
> > > >   static inline struct maple_node *mt_alloc_one(gfp_t gfp)
> > > >   {
> > > > -	return kmem_cache_alloc(maple_node_cache, gfp | __GFP_ZERO);
> > > > +	return kmem_cache_alloc(maple_node_cache, gfp);
> > > >   }
> > > >   static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
> > > >   {
> > > > -	return kmem_cache_alloc_bulk(maple_node_cache, gfp | __GFP_ZERO, size,
> > > > -				     nodes);
> > > > +	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
> > > >   }
> > > >   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
> > > > @@ -1127,9 +1126,10 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
> > > >   {
> > > >   	struct maple_alloc *ret, *node = mas->alloc;
> > > >   	unsigned long total = mas_allocated(mas);
> > > > +	unsigned int req = mas_alloc_req(mas);
> > > >   	/* nothing or a request pending. */
> > > > -	if (unlikely(!total))
> > > > +	if (WARN_ON(!total))
> > > 
> > > Hmm, isn't WARN_ON() here too much?
> > 
> > I don't think so.  If we get to the point of asking for a node while we
> > don't have any to give, then it's too late.  It means we (I) have
> > calculated the necessary nodes incorrectly and we won't have enough
> > memory to fit things into the tree.  It should never happen.
> 
> Either way, the suggestion is to use WARN_ON_ONCE() instead of WARN_ON().
> 
> ... now documented in Documentation/process/coding-style.rst
> 

Thanks, this is good information.  I was actually debating a BUG_ON()
but it has been documented to that WARN_ON() is better, but
WARN_ON_ONCE() is best.

I would like the stack trace for any code path that happens to cause it
even if there was a previous code path that has already triggered the
backtrace.

The memory should have all been obtained or entered a previous error
path so an OOM issue will not cause a cascade of flooding backtraces.

This would also result in a null pointer dereference today, so I think
it's safe to say it's rare.

Thanks,
Liam
