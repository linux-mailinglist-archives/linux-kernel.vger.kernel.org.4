Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF7705457
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjEPQtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjEPQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:49:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067CC55AF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:49:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GG4dpJ013785;
        Tue, 16 May 2023 16:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=PIGAirBLaLnos2v5Zqo7bQ/AfRAdOgo1OSH44H57uqY=;
 b=xf4ccKlqU+BqS6RBEUg1ZXqGXzSkw1S3IoTMLPGtNHKBX9DvcP25Z9mtql0RsC5SeAzM
 l91RXXvsIulRMxcpYZQSbFGt1P+va0FWfemq6GEfWTKJfeQnGB9JfDLCMB39Ym9R2IGq
 C/XtNFMjciZhCrZqrMfZwDslMAtJbUphlosif0x5tnS8CVhk7Aq9bTZ8iTmzHX2t9WY3
 D1t2c/YOm7+9nLquX7Z9d45u3gW4BlBM7w5+rVlZ8sKykp7ZzXuG9Ge1UsuNiDsxgj4R
 6c5j3oGxzdEx+85+1VyjyHb6k4+vwQbQ+GzcE8SX8I5XSQEILfxq2Eb9azvuUJO2DeuN vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb36x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:49:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GGn8u1033898;
        Tue, 16 May 2023 16:49:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104tkfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 16:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfqBUjWwt8TwPVG8TXEpNbx92YkoTuFeYTGGPuhSImdF9lejoyYsZBJiLTn7EX+/4ikrOY+OU1lfjn76Aq91TqKF+odsfrOURppwX0c3ZVMbpmPH7Ly7ys6IqioE+ruxXz1c5FNKaVCyezzl2aeNE5Yl+5aSDpbuhy1MTFAgCWKkdXnPb6cZQJoAoP8pK9GVyXvh+nk/KELVyEbOEIHrZdM9XvzB3bw/1UkpKd1QWg5W5dEsUFlkRZzVH86bysebf4imDvUjoDrghLpfuHR9nQZTxyh2PSYRAH0NQWCtAqbwPi0lfhSO07ka9rvl9kMw/OG0gGN45hGMqEqXOUJTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIGAirBLaLnos2v5Zqo7bQ/AfRAdOgo1OSH44H57uqY=;
 b=XThRN8k2u/xLVIbtUt1bjHf9FpdtV4IF2Eqk1dIr4y2pZH73us65+TaDNmmux9hJye8LYaqkNJNlS87sYUyuLSmcqYt+hyO4fcKW3JQWiFszTAp1ifSi+tUrHM2RKoQvwtEsRQh3vOwbJozXz4Zl2Hzk8YhaaGM32hO0Y9EFce4EQ4rtsM3qAw64/fvTz2a607c7xDkl4SSIvE+iVloqTL5au2LlN2lYqUMbZptd//uqZNMEl3c7lhIeXc744msqb9pqdFrEBvTOUxDbPHeQkI5PvcIy5CPq+naud7cPqeJ3cKegFzs69fSivXrEWq6xaOYpaDaTYum9Pc+1w6ROBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIGAirBLaLnos2v5Zqo7bQ/AfRAdOgo1OSH44H57uqY=;
 b=EfttIE4sgLXdpPuOjBorHwVEtnoeppGidLr0HTNLVplra2p14VqNhjyTodL8vwUXGKjH8/LEhLihVJlq9r5bDRexHSnwBBl4aZlLIklWonp+Tg7j1dqBuUURkXJeM78FQDylMMuKGwSFnT/Zl12LogvdlnsA4zBk6rLezu20+YY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 16:49:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 16:49:10 +0000
Date:   Tue, 16 May 2023 12:49:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <20230516164907.5bf2qe7nn5bo7iaa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGOcAOFOjx3XPGqO@x1n>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: a018215b-9121-44f6-afa4-08db562d788d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRcVulgTebU+0bfWLmlbtOi+Ut6ehE409reS4aj896wYJfeR77+LrK6z23QJ9hhZaJPJQcKhYF3YijUEIwZAQlooC8l1CKzCQ9kaBBfEhGoyWmAYwplsioAgQwKDrKy3kq09yQYLsZDVmtQOm+2vQ7NU+mv1zBdBxaClz+KuMAJDdVODiGiBd26Hgw376ecOnA75MscB1aKQaEMF9wSCj9tdQwUdSwacdjV3454b7SRP0Sg/FweIa+LvrKRDurnamaGX2v3+xM0z9FxG8t8hkvIZB4b+ReE+q5DWvoce8qYwFP5rdPHB4Rc9unJU7zLPEWj/LiK2vdBntx4AVumTHPqSD6aIlz9yOqFKYKSozsFvzDGNvyhkIMIjzMyli2faQWFzQId/T8NeXTT15CMnLhAcJH2r4EWkcrMm9GX9c1CWFu8GSusW8rFzgUb+TrQqGCTsLGtBXpSnEQxie+skZO2fbya4X6coXyidm7POi0Feelvb0+W2cGAUX9c6yZFHmG7YeHmN+tZRs+EsSDzC67aiDbm1VsjTXCeQxPwSvIe3Ypc/CGudvdZNOZ3MRRbYfFoB9OA+mh1dZXBkyTw1RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(66899021)(966005)(66476007)(66946007)(66556008)(4326008)(6916009)(478600001)(316002)(54906003)(86362001)(6486002)(26005)(83380400001)(6512007)(6506007)(9686003)(1076003)(53546011)(186003)(8676002)(41300700001)(2906002)(8936002)(30864003)(5660300002)(6666004)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/RjkbKcpvq6eVxmis95vfB9BefaoDHuZE7Ufjcm4M4tQKm1toNscde004GA0?=
 =?us-ascii?Q?mxl/VxxaM8R2hIi/hIKkwoEu3qE/3zwYm1BygPHb1G6rXFhQr6zkXlst+Mwj?=
 =?us-ascii?Q?gNqxnj/uJ43Ufqx2Twzia1W/xmnRB9xs9cGeQwdjrQtpPK2R6dpqcDRDxfWt?=
 =?us-ascii?Q?H+/i/QjBMPo1ipFKkdS3GmfHtVl6+h6uoJGslc2OJuohIYS27PjDRspwKRt3?=
 =?us-ascii?Q?oN4aG3FjhHtzIZTgQGyvH47CBg857xLXV42AV6RDgXfIwUL0a/KORmGQQJIe?=
 =?us-ascii?Q?ExjyJN8158zsxrXfAaC6ejdxP78h6jEGskaucBhBkUfO5zEBBWPwdfHRo3nO?=
 =?us-ascii?Q?2DrybbcYj7SUEFiHVvAcGL72DSMqXsJeAXRmqIiHlk8qcCYQ10RLHEwWdmhj?=
 =?us-ascii?Q?xy+mzwv7Pp0GbauR/t8G97EFCmNvDVIFDV7LtgEXvLnIGC3WjLVrTSdmg1Q0?=
 =?us-ascii?Q?deTrCVL/UoiyQKihrAYbHI4QIGooU/G8wQXSqDu5nculXG4xGy52x7/v+RC9?=
 =?us-ascii?Q?CHFKRtC+A5LlewQgdj+l9f819JsDMvMBgu1Tjh7t8WUCNyQ4NW5dNM7QJaF+?=
 =?us-ascii?Q?kZSHGw83iGMktxrG4pC6iKCzod9LsOcP6jEQwbU2dEVqMVrlLNmjkln/2y7R?=
 =?us-ascii?Q?YXJFDH0+C828uhdS7VuIJ5rlZX+MVi07VADEI/Ud3EhkWPMbtXGWLi3Bxzqt?=
 =?us-ascii?Q?45y5WIXlDG1wqIsGxvvLi+D+Zr/G8O00tpEz21/0fEQlKAXw20yblORBnTTd?=
 =?us-ascii?Q?DKjK4K29IHRImL08Zw3xdAmFBnKLHPI2wNZtGzgL6nCF1NentSa/194i6SjE?=
 =?us-ascii?Q?fuU1X0xFrXEEeGxilEV7FRUG7nJBBzcrO2FiD2LOFKRuLP5t/FuZ/jb5RKGW?=
 =?us-ascii?Q?CFdOfEBMPgiabmw/cF5FiQwMVvoThQquYzKRNW49370hTg4Cb9XF7wkrYZJh?=
 =?us-ascii?Q?WtZwETinXCxi3cbpKkgXs9ax3ni9y4FJJBvz18UzLTdqvPvTIo5HYb9L09JO?=
 =?us-ascii?Q?8L1ItrWct1tbT3DvPeTYD0RC6jVmDN1t5wgsh502m/YZx7FsId9DiQWWNEqM?=
 =?us-ascii?Q?emEqilz6fv+DEDfuc8LSaR91a9QHDUhXEbk7fwxT09whi8sGhCLYepXwWOF8?=
 =?us-ascii?Q?jKg1RJyH0j0wDjEDWK4RpuJrV9SiI1s41RLnaZgLIaznAxhXAZ8ryDV50ZxV?=
 =?us-ascii?Q?ojlUvZzE+1bZHvdC7xRKe3Qjs6aD3PGK+YvwsnzJKVDc0oBEezMv5i77UVSV?=
 =?us-ascii?Q?8QXoGmUUcA6ZXflznV/t118C38F8zJCHj/5qSgwka/pbd47NtdMJzGHX3y21?=
 =?us-ascii?Q?N61pqIBPQKb0dNh/iQ8/xiMlIjWzSn+omnsszETEoRmXlK6N5SMV0+8rGtuJ?=
 =?us-ascii?Q?0k+R87UB+vFFhaMGgbhOrECGm+/FQ0SC+ewFghbOBnVBo9wZjRLoflUHXhK+?=
 =?us-ascii?Q?+ZpNSegGfXM9JpJRAnIucByPLoL6Fp2LvUs45+1lzrlyHKJva2g9zsey+2cx?=
 =?us-ascii?Q?PfoVSJOXlslWCMXjVMXyVeLWpW+T0k0y5j8bkewS4YG28J00MA3u1wki/Lzt?=
 =?us-ascii?Q?JA2SO+mIogHLAFdZP4Gp2C+5beBt3s3ZbKtm4C0k/MK+cs2eX2QUkvoPuwmA?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Sbc3MANgs5GBm7FxseNqWyDrktlgY/lz42EokWLtTLfzg6kFHdByDqAR9Gyy?=
 =?us-ascii?Q?FUOU2PCZ20tvcsy5JqnNo7It8ltTRStJ0HbkhKMDaDq6IWiVDXvqXprZi93Q?=
 =?us-ascii?Q?7NZmlIe2xqk5fHl9JUa6kNBEYF9l51p14qevKkJHgEUS2KzDtAYK24ec91QC?=
 =?us-ascii?Q?lIKlh6p8L0E+xXgV9QUXgXmE3+z4VFRsmhnBs8logeYkM42Br2bpXkjVS1h/?=
 =?us-ascii?Q?zJN/0TO7qhKYtD0iw/K7kA90cVpWDtBKZQx/xCfkovS50swqokRFJVgYln7o?=
 =?us-ascii?Q?5/lHzU+XwPGcbdKGRqba435VBNttjU5PbKcaLArALKOKWXABlUouYL3dnlw7?=
 =?us-ascii?Q?8czWUfwAKDW2Yb5wl7tu4m7j4hVS+aNoIX5b/20dhxEc5YkLEDHBQovPkhYj?=
 =?us-ascii?Q?FFpdH88FkgblQdLKv5OY+B4HMpFtINroNH4JuFn1F83B5hj4DMcpRp6vtJt1?=
 =?us-ascii?Q?MbII13PiE28aBuRyi7m+dx88K4uuFNLkoAU2D40obmdaxciTl+/duJu3Fibj?=
 =?us-ascii?Q?ddHMFCAK8mNe6FdghIICCLgznTJbVtn37NvkbTAgJpN+0s6YSZbUB5gXOWa9?=
 =?us-ascii?Q?ZQoKhT76OvgiXuv03E+gHKMLWYFk3u44O13Aoeq+Bg1odRiFj/mtdMuabAmW?=
 =?us-ascii?Q?JOaLIV55N9ljkbCw3Vx+Ie8nwiC5geJyj3K0DN3vyBDaFywvekehhkkYnGhZ?=
 =?us-ascii?Q?LtxuPy1n3Clil4OP8Ek09lmQGedumB566TB4NNKacP7ibX3FrgGmIysaFXqg?=
 =?us-ascii?Q?uRKT39he/AMfbC0Id+Smb7++Hn2O+PJqswxjaimA/PRAjTCik5KjFDdxKa1f?=
 =?us-ascii?Q?iyGTyptTolcNx/59WWpMvZJk6IZmFyrnOIzFfdp8teaojT2KwTwJbDnsxndM?=
 =?us-ascii?Q?HSwTAqYxle1yKgpaxIn7STXt+nfoeke0SZv/1zbn+MLxTp89ye6HS7sogrvd?=
 =?us-ascii?Q?pjWudYM3hRvVqaVDrcu0UUKPzixaXgGN84EfJGeXEmCPDUjh6i1ZiaXRluJ7?=
 =?us-ascii?Q?kFSQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a018215b-9121-44f6-afa4-08db562d788d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 16:49:10.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cEof0bXGJJPXcinKhI02kyfARDvLJvaqmgZhGPKKAGZMTK7CHYOU5d/lmM9KEO1o6/w3Y0BD1g17S9SMSBaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_09,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160143
X-Proofpoint-GUID: 8-_NKP4Y3oXQJqp723bmkQZDMm8pKwYe
X-Proofpoint-ORIG-GUID: 8-_NKP4Y3oXQJqp723bmkQZDMm8pKwYe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [230516 11:06]:

...

> > > This seems like you're relying on:-
> > >
> > >   ***
> > > CCCCCNNNNN -> CCNNNNNNNN
> 
> I had a closer look today, I still think this patch is not really the right
> one.  The split/merge order is something we use everywhere and I am not
> convinced it must change as drastic.  At least so far it still seems to me
> if we do with what current patch proposed we can have vma fragmentations.
> 
> I think I see what you meant, but here I think it's a legal case where we
> should have PPPP rather than CCCC (PPPPPNNNN --> PPNNNNNNNN).
> 
> To be explicit, for register I think it _should_ be the case 0 where we
> cannot merge (note: the current code is indeed wrong though, see below):
> 
>    ****
>   PPPPPPNNNNNN
>   cannot merge
> 
> While for the unregister case here it's case 4:
> 
>     ****
>   PPPPPPNNNNNN
>   might become
>   PPNNNNNNNNNN
>   case 4 below
> 
> Here the problem is not that we need to do split then merge (I think it'll
> have the problem of vma defragmentation here), the problem is we simply
> passed in the wrong "prev" vma pointer, IMHO.  I've patches attached
> showing what I meant.
> 
> I checked the original commit from Andrea and I found that it _was_ correct:
> 
> commit 86039bd3b4e6a1129318cbfed4e0a6e001656635
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Sep 4 15:46:31 2015 -0700
> 
>     userfaultfd: add new syscall to provide memory externalization
> 
> I had a feeling that it's broken during the recent rework on vma (or maybe
> even not that close), but I'm not yet sure and need to further check.

I believe this was 69dbe6daf1041e32e003f966d71f70f20c63af53, which is my
work on this area.  Any patches will need to be backported to before
the vma iterator for 6.1

I think keeping the asserts and ensuring we are calling vma_merge() with
arguments that make sense is safer.

> 
> > >
> > > By specifying parameters that are compatible with N even though you're only
> > > partially spanning C?
> > >
> > > This is crazy, and isn't how this should be used. vma_merge() is not
> > > supposed to do partial merges. If it works (presumably it does) this is not
> > > by design unless I've lost my mind and I (and others) have somehow not
> > > noticed this??
> > >
> > > I think you're right that now we'll end up with more fragmentation, but
> > > what you're suggesting is not how vma_merge() is supposed to work.
> > >
> > > As I said above, giving vma_merge() invalid parameters is very dangerous as
> > > you could end up merging over empty ranges in theory (and could otherwise
> > > have corruption).
> > >
> > > I guess we should probably be passing 0 to the last parameter in
> > > split_vma() here then to ensure we do a merge pass too. Will experiment
> > > with this.
> > >
> > > I'm confused as to how the remove from case 8 is not proceeding. I'll look
> > > into this some more...
> > >
> > > Happy to be corrected if I'm misconstruing this!
> > >
> > 
> > OK, so I wrote a small program to do perform exactly this case [0] and it seems
> > that the outcome is the same before and after this patch - vma_merge() is
> > clearly rejecting the case 8 merge (phew!) and in both instances you end up with
> > 3 VMAs.
> > 
> > So this patch doesn't change this behaviour and everything is as it was
> > before. Ideally we'd let it go for another pass, so maybe we should change the
> > split to add a new VMA _afterwards_. Will experiment with that, separately.
> > 
> > But looks like the patch is good as it is.
> > 
> > (if you notice something wrong with the repro, etc. do let me know!)
> > 
> > [0]: https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e
> 
> I think your test case is fine, but... no, this is still not expected. The
> vma should just merge.
> 
> So I have another closer look on this specific issue, it seems we have a
> long standing bug on pgoff calculation here when passing that to
> vma_merge().  I've got another patch attached to show what I meant.
> 
> To summarize.. now I've got two patches attached:
> 
> Patch 1 is something I'd like to propose to replace this patch that fixes
> incorrect use of vma_merge() so it should also eliminate the assertion
> being triggered (I still think this is a regression but I need to check
> which I will do later; I'm not super familiar with maple tree work, maybe
> you or Liam can quickly spot).
> 
> Patch 2 fixes the long standing issue of vma not being able to merge in
> above case, and with patch 2 applied it should start merging all right.
> 
> Please have a look, thanks.
> 
> ---8<---
> From 6bc39028bba246394bb0bafdaeaab7b8dfd1694f Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 16 May 2023 09:03:22 -0400
> Subject: [PATCH 1/2] mm/uffd: Fix vma operation where start addr cuts part of
>  vma
> 
> It seems vma merging with uffd paths is broken with either
> register/unregister, where right now we can feed wrong parameters to
> vma_merge() and it's found by recent patch which moved asserts upwards in
> vma_merge():
> 
> https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> 
> The problem is in the current code base we didn't fixup "prev" for the case
> where "start" address can be within the "prev" vma section.  In that case
> we should have "prev" points to the current vma rather than the previous
> one when feeding to vma_merge().
> 
> This will eliminate the report and make sure vma_merge() calls will become
> legal again.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 0fd96d6e39ce..7eb88bc74d00 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1458,10 +1458,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	BUG_ON(!found);
>  
>  	vma_iter_set(&vmi, start);
> -	prev = vma_prev(&vmi);
> +	vma = vma_find(&vmi, end);
> +	if (!vma)
> +		goto out_unlock;
> +
> +	if (vma->vm_start < start)
> +		prev = vma;
> +	else
> +		prev = vma_prev(&vmi);
>  
>  	ret = 0;
> -	for_each_vma_range(vmi, vma, end) {
> +	do {

The iterator may be off by one, depending on if vma_prev() is called or
not.

Perhaps:
	prev = vma_prev(&vmi); /* could be wrong, or null */
	vma = vma_find(&vmi, end);
	if (!vma)
		goto out_unlock;

	if (vma->vm_start < start)
		prev = vma;

now we know we are at vma with the iterator..
	ret = 0
	do{
	...


>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma, vm_flags));
> @@ -1517,7 +1524,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> -	}
> +	} for_each_vma_range(vmi, vma, end);
>  
>  out_unlock:
>  	mmap_write_unlock(mm);
> @@ -1624,9 +1631,17 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	BUG_ON(!found);
>  
>  	vma_iter_set(&vmi, start);
> -	prev = vma_prev(&vmi);
> +	vma = vma_find(&vmi, end);
> +	if (!vma)
> +		goto out_unlock;
> +
> +	if (vma->vm_start < start)
> +		prev = vma;
> +	else
> +		prev = vma_prev(&vmi);
> +
>  	ret = 0;
> -	for_each_vma_range(vmi, vma, end) {
> +	do {
>  		cond_resched();
>  
>  		BUG_ON(!vma_can_userfault(vma, vma->vm_flags));
> @@ -1692,7 +1707,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> -	}
> +	} for_each_vma_range(vmi, vma, end);
>  
>  out_unlock:
>  	mmap_write_unlock(mm);
> -- 
> 2.39.1
> 
> From bf61f3c937e9e2ab96ab2bed0005cb7dc74db231 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Tue, 16 May 2023 09:39:38 -0400
> Subject: [PATCH 2/2] mm/uffd: Allow vma to merge as much as possible
> 
> We used to not pass in the pgoff correctly when register/unregister uffd
> regions, it caused incorrect behavior on vma merging.
> 
> For example, when we have:
> 
>   vma1(range 0-9, with uffd), vma2(range 10-19, no uffd)
> 
> Then someone unregisters uffd on range (5-9), it should become:
> 
>   vma1(range 0-4, with uffd), vma2(range 5-19, no uffd)
> 
> But with current code it's:
> 
>   vma1(range 0-4, with uffd), vma3(range 5-9, no uffd), vma2(range 10-19, no uffd)
> 
> This patch allows such merge to happen correctly.
> 
> This behavior seems to have existed since the 1st day of uffd, keep it just
> as a performance optmization and not copy stable.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 7eb88bc74d00..891048b4799f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1332,6 +1332,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	bool basic_ioctls;
>  	unsigned long start, end, vma_end;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>  
> @@ -1489,8 +1490,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma_end = min(end, vma->vm_end);
>  
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);

I don't think this is safe.  You are telling vma_merge() something that
is not true and will result in can_vma_merge_before() passing.  I mean,
sure it will become true after you split (unless you can't?), but I
don't know if you can just merge a VMA that doesn't pass
can_vma_merge_before(), even for a short period?

>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 ((struct vm_userfaultfd_ctx){ ctx }),
>  				 anon_vma_name(vma));
> @@ -1570,6 +1572,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	unsigned long start, end, vma_end;
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
> +	pgoff_t pgoff;
>  
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> @@ -1677,8 +1680,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> +		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>  		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> +				 vma->anon_vma, vma->vm_file, pgoff,
>  				 vma_policy(vma),
>  				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
>  		if (prev) {
> -- 
> 2.39.1
> ---8<---
> 
> -- 
> Peter Xu
> 
