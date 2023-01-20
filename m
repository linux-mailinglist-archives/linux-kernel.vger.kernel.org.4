Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F796759DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjATQ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjATQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD247CCF6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEBFJ006188;
        Fri, 20 Jan 2023 16:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=MIwysW3cgYBCZl0uIFOInaixLCkr+JfsDdv5IZ6BRyc=;
 b=HH/QY4tJkFldz8VkI1WB3z3NYpFl/GcvjxpR8z1H1PBVAFJorteITKzHPcu+73prea1w
 5xajBlDmx1h8Vh6noBtfbr+XMm52k6yB0mNlZR4dohAUknSMCWkFW2SqJi/REnRYpDVg
 wVKNPiF47GXso7WLVzaTznJHbRRimxQLyVTZJtQP/9sE+A8ulaYxiCrEfPcOKPRaiP5p
 MrKdYorytPE16G0okXRf7PL9uOm9EBaps1oTXsRGXgcRAN6KxXECyOK1Fz9jqDuVI5YQ
 CVxxrVthy+1+p5pbUqQXtXQwhq6EoAR4z1bl67dg7heM3YM3E7kiFO8JWFzOTYgkLopV hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmftt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KGLsL8018855;
        Fri, 20 Jan 2023 16:27:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quj9xhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfJAc5kXqLRPtRlkzfRRpAOSkWuVuFzBLYxQPWuCiFtkyVei9WTTcGZOHUXICPOdQ7MthU7SmI+wwg/hWdLTtN4inqGorQHKRebxQiFNmSuJ1edO2P07iRiIUlImfUTOkpid93jhPpvAAAHya+WIsJKu8JuY7UsYvNeH2tJKxiQd0uNAaZb7cYRBet8GJeqpF53pPBSJb7H5Hvliis+1PsR0bVham44wQ3pvpwyvbZxZacndPIcIr/SjIMT3iHdqpzmPXKzrUnlgtN3/+lHEETg/eOL2SRf4awUTbyreub8bMZaFAjmimmZO6vWhrza/Lz96fge3BZZQmvdve7bmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIwysW3cgYBCZl0uIFOInaixLCkr+JfsDdv5IZ6BRyc=;
 b=XoPyc7BE3+yHBlQl7PD3yLo0nlT0nnnLv8M+yZurvoU9x/pNTQ/4h3rdnIyEkoxVPuNlwamQ6PtXL5mn6pg50ptbB93B0BTZ9QCSn0Es2ciLiVNMnY+Gw2V6WCcuVdZAHKp5t6b/V+OJAAR/rssg4ShtwfAyzu4W+qxi2HDUWf/36U4U4xNTCI/SF644OB+xmPh7Erc/1tuU8PTg/yJjuKmcdT7LXyM9uJ/wDI8NAFrPuqafjrVnM6l0/KKT7xs5vYx3Jga0sm6wClk3My/1Gyii64DWviPoRD300M8bZ21fAJiLpb52DannY68V/g9IzJe+ihLI5k/1hSOMmsNGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIwysW3cgYBCZl0uIFOInaixLCkr+JfsDdv5IZ6BRyc=;
 b=Jhz2hBHQGiRpZWNoMIMFarfftmuLc/f2S+xNOjoucm5oJzmDsq4LdjsL6v9zZ+kqzxreWG0bWa8ULm9ncNt81Cbyt3Xu0poeuoL7Ekgj/6z7fvT+V6ruFrOZJkahU1aHqdOakV1dVWwi8HeoKghDNM5weQ2g2NWaeLheJ9ktTK0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 00/49] VMA tree type safety and remove __vma_adjust()
Date:   Fri, 20 Jan 2023 11:26:01 -0500
Message-Id: <20230120162650.984577-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0182.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c85474d-a6e9-4737-86e7-08dafb032d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTUZWZtSae2p8A/e3FGHK8nnpXwoNHKw7MDygRrB1ihsOLlS0EGqVKn8NHbr/UJ3+4aj7rbZ7c6QEThVQf50j/ujMbbp3lh+0Xa6WUsp9C/VsROx4k0hSk7ietkxCWCgLd1y9JKDsWJqPb8onmzLVGEsPxxg9bWzo802c+VwYB7eTKygR4UtYidIRZ2vJFGjFzlh4Hz0Mj49s+4lgnyJYorD45Fos2IrftqYO0nkgYOIDgyP3PoV17kBnrKyjaWaXp9i3tczphR8+Xi6cxGRHnhfMqc212PmIoGHFMCdwv301okcMh3VSwvAu+AKrydrzkGMBVXI97bTIGqcyvo9dbbyjwvN/2kKvDNzxlyfzUlZ+JgKwSH+bKKdj7+IQvokOWQshwNO/A3jOSWseZVc4F2WZnBboFyiVXkkVEax5Fp98JduCng18saPZ1X6K6mtvYBKNkTEuwcyM1sQk5wpJDyAA3uEDOC4CzYT8hw1rkIOL67/rxAmVe4rXrJ5rW0tYLXxtCV0XOUGnuDSMkg6rh1e5v3oHtisHJFc4GsGwdxpVs7CogYW2lrLr+F1XGjaVLDMHD+vlFu7QJLfsGVqQVHmlN9Q+92rSAzxGiPvWhI8qZXlgU5IJT0w7+/BesMndIdLhfzv7rCuj0IaESDg7OGViLjLP6hxUyTFjdttabvmFtbRtxeERyn2zPQVWHASyzw3WBXqzCBChsW/6ZxndQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(6486002)(966005)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Es7MTA32fls3tJZl4cn33P2oA9QiBOpEvkSoLzH3EW2w/5EffqjOGewnce90?=
 =?us-ascii?Q?GkgCSgYhJRyPdUVYEzeSfkPmNulzlI/aifPOCxQ4C3G4uLcKpVzBpXc2BqVL?=
 =?us-ascii?Q?6hZypBrn+q8luB7EeN7v3qs0KQdlESmKQ/3KBhNWgZwtYRB2VPU64sXtkMP4?=
 =?us-ascii?Q?HcOulKzdsaNU0KW/0pycHkAyp5mNuTYFpu1OKeNBaonGaxMLLos30FsfHW1v?=
 =?us-ascii?Q?A/X994uLWXw1+VUzvEqzrBXdHS3egIVjrl00IN5t30pQyuw2TczPNLIOp1hN?=
 =?us-ascii?Q?4NliuJSRt87QRmXu9g917yn4B1mqY3ymTY/u5FVQ+IwXYorPfXKxc/lRKjQY?=
 =?us-ascii?Q?/jMIzaZtwbt6UoaUbu4BiP4XNmgsjF0ixJjRLeQyVYMWvKICnP530PkBlOSZ?=
 =?us-ascii?Q?LErYjJYR9YZ84ovklqXcOTXhjNZ78agqZmWnM6jPw0I/lxWIDEOjCZ4NYVjH?=
 =?us-ascii?Q?fNZEUE/FfcjL8516K6U7w0Ug9Q+rSgCa12EvQlBGWooigpBrkLYL4dg8ekRl?=
 =?us-ascii?Q?/68O0W/FU1tehqTe9o3Rokhn8yLDInPOYoG0cwMqr4/hwTNRVKd+c1ZWnYHn?=
 =?us-ascii?Q?ouOh8zkkznEN1wnaBlQ+tIXhNhQk0EvvysR8eo58LoAycjUjQvocIS1ZdvZK?=
 =?us-ascii?Q?YUychCsqj2p02x1mIQLYqFvmpU2B57pGl6o7la4dA8+bYKT6TcA3ipeUHDRw?=
 =?us-ascii?Q?SIXtnFrSHoe0dOUTAhDUXmN0DDSF0zq+yxk4x1fLuov19XnnR0nevmfZMmD4?=
 =?us-ascii?Q?ssuKN5uJK1mIAS3L4UWs/a5ECWvZW9cpZ25FglfFaBduzF0EBODwo1u38ZKt?=
 =?us-ascii?Q?eFkDLxqZb4EnZiCH4bCwgXXKA1i5EzRPSM/SXIb358mUQl2W6jRZmyn09fFq?=
 =?us-ascii?Q?gFnah1+DGS1sFKzhN+bCT2QtQuW0OoCRbUdBharzByRtbK0Lih0tM5pAAfRi?=
 =?us-ascii?Q?zAgF8Wjz6dLIg9AYktU7odbaK9rWpoQlnQAAslfU17kWOZR32osxJQYG83a3?=
 =?us-ascii?Q?FrWAY1yqKCLdT2l2Pb8KabfE27UKWf8dnU4KfwYDTg153LCxR8JB2lCHOGnw?=
 =?us-ascii?Q?sgGz9rmwdZEClybfp9Fql8eOwx/hEncVSRY2EpAO0o9ppxBgVhjMPM6SE/Yz?=
 =?us-ascii?Q?JyMXRcyXKs9DlWtXBp72Fas9mCwjNrOt3K77QdykdENFSsDU458IGQ1rDq1R?=
 =?us-ascii?Q?+yyuSCE+JC6ohA8lMpBQqqyozFRxtmI2bza1uAIQsmhyX8DvPgqhdE3sHV0v?=
 =?us-ascii?Q?ctLxmBcqC5+xQ/4JU2jLGsoFkbcjgtFUDOJC8PfJc//tlNnll7nFwysParOR?=
 =?us-ascii?Q?aTfS03cMYhJSbbUaOjHYFT13+0FNyHCM8lDYqYEUFZ77DNh7rkbOuE/3JmBz?=
 =?us-ascii?Q?1u5SwO2LIrkpTQlvL2YhVvhMFqZh0o2Xar7Jt//ycD+gLtHpziJ9L3ZP78gz?=
 =?us-ascii?Q?hyeqZ1aUZpwdUNvyhfFsYZ3myCUneCDIpPRiMEM1bI/vMt+ZeRzSMLPGsf8Q?=
 =?us-ascii?Q?m6IXR4JwjMt4YESmkEygXQ2w4uEDYJRkaSBeC0WzqHCNFo0LFD7hL6Ix2iF7?=
 =?us-ascii?Q?m+9fod/MAv5ktkkx5D6jeTiYlHyPT5rgHRYr6WVj2sAVZNNWvVJ/hbTByJhE?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 85D9ZO4BOjFScD6KcNE6Hb6cRlP3dqHnzTGupit7nz9lGDkBpkBsZ0gTHvzEv7IdH0BcteNyTZ5mbJEiGsaN3fXZUHdi2pvF5eOb1/UZRNgNJHQeMi1uDcM56DDqX/Z2v65JPfJ/cObUKvhqUaWC6Gl3Spsf8I+I7y9RFS5/rdNt2pvOBU3H8fOTSr8GbiQ7h0ASmHeSERdT8lGz+0QiJvMawMc6KTDhV6mCfbagIu0QRRQVEo+zW10rYBMjd4Yj4mxI0YAU66O5DFXzhj8CkXn4K0RvQ063tB9wVwAC+Ygcc4Wi1WAqsaTCmyW1vNeJoslUiDMLgLYTd8T66J5Gbn/e5egxI76ptAFecIi7SRcflNtQPDzSawQOHLrkmH5RosVJnLa3+Nw/L3eSkwYlc+SIPxn3vpUiswnScw/dkil4UZ9mVqs/RP/BuSFfJurcl8LMEOLBRYrp0doEA6hwoUoAhT7FhLpP8B8hY39rT6PHH4TytpDT7z6Rmny22xfln8553e3X2bR4atDOw2UMhELcUZyo+nNIEHwN85W9I1RhP5LNsVOdYN6yXKUVMFAifZsodeosQGdvLDnHqkb9xkKc4bVWeEK2ZGGMr0qCNHCdlxYlCQCh6HesbUpQyxMrrUZCI+1ztedInojlhRlIGOD2R75W2uQ4Ay18zHpnlb6SDA2pnCZ/g8rmPSgSdcNi3VxXclqmzOyXf0A8sW/ZlflA23RG0j4gmVcJ2KLMNnogJQySYJX0bBPGB0PLys/olQ9EoQIrxI6rB9oFP+7A/OXdkKkT8GoC2xgeonfQ7nUxkszTfU3jzv6LhfmSbwulqv0+Ge4LBnHUuKXca7HV9K9dN4TXkjWDAWQWd9y/Cy48DbsYRKImLvsoNSODkEj6q5kkTPox6qIhN9/NlucPCw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85474d-a6e9-4737-86e7-08dafb032d94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:09.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LVCkXEwOHMV0rCGZyN7Fe2Sl2BlKCdoEQy5+UMp8D1TPPU56HdzBACSqn9SfM6TfKKesnjPEDU/mdbzil9Z/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: Fit6vowrtgrcllInD2y5_xqDK_cqb8Hu
X-Proofpoint-GUID: Fit6vowrtgrcllInD2y5_xqDK_cqb8Hu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch set does two things: 1. Clean up, including removal of
__vma_adjust() and 2. Extends the VMA iterator API to provide type
safety to the VMA operations using the maple tree, as requested by Linus
[1].

It also addresses another issue of usability brought up by Linus about
needing to modify the maple state within the loops.  The maple state has
been replaced by the VMA iterator and the iterator is now modified
within the MM code so the caller should not need to worry about doing
the work themselves when tree modifications occur.

This brought up a potential inconsistency of the iterator state and what
the user expects, so the inconsistency is addressed to keep the VMA
iterator safe for use after the looping over a VMA range.  This is
addressed in patch 3 ("maple_tree: Reduce user error potential") and 4
("test_maple_tree: Test modifications while iterating").

While cleaning up the state, the duplicate locking code in mm/mmap.c
introduced by the maple tree has been address by abstracting it to two
functions: vma_prepare() and vma_complete().  These abstractions allowed
for a much simpler __vma_adjust(), which eventually leads to the removal
of the __vma_adjust() function by placing the logic into the vma_merge()
function itself.

1. https://lore.kernel.org/linux-mm/CAHk-=wg9WQXBGkNdKD2bqocnN73rDswuWsavBB7T-tekykEn_A@mail.gmail.com/

Changes since v3:
 - Rebased patches on mm-unstable
 - Updated damon patches as per SeongJae Park comments
 - Added extra patch to convert the new call of vma_adjust() in mremap()

v3: https://lore.kernel.org/linux-mm/20230117023335.1690727-1-Liam.Howlett@oracle.com/
v2: https://lore.kernel.org/linux-mm/20230105191517.3099082-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20221129164352.3374638-1-Liam.Howlett@oracle.com/

Liam R. Howlett (49):
  maple_tree: Add mas_init() function
  maple_tree: Fix potential rcu issue
  maple_tree: Reduce user error potential
  test_maple_tree: Test modifications while iterating
  maple_tree: Fix handle of invalidated state in mas_wr_store_setup()
  maple_tree: Fix mas_prev() and mas_find() state handling
  mm: Expand vma iterator interface
  mm/mmap: convert brk to use vma iterator
  kernel/fork: Convert forking to using the vmi iterator
  mmap: Convert vma_link() vma iterator
  mm/mmap: Remove preallocation from do_mas_align_munmap()
  mmap: Change do_mas_munmap and do_mas_aligned_munmap() to use vma
    iterator
  mmap: Convert vma_expand() to use vma iterator
  mm: Add temporary vma iterator versions of vma_merge(), split_vma(),
    and __split_vma()
  ipc/shm: Use the vma iterator for munmap calls
  userfaultfd: Use vma iterator
  mm: Change mprotect_fixup to vma iterator
  mlock: Convert mlock to vma iterator
  coredump: Convert to vma iterator
  mempolicy: Convert to vma iterator
  task_mmu: Convert to vma iterator
  sched: Convert to vma iterator
  madvise: Use vmi iterator for __split_vma() and vma_merge()
  mmap: Pass through vmi iterator to __split_vma()
  mmap: Use vmi version of vma_merge()
  mm/mremap: Use vmi version of vma_merge()
  nommu: Convert nommu to using the vma iterator
  nommu: Pass through vma iterator to shrink_vma()
  mm: Switch vma_merge(), split_vma(), and __split_vma to vma iterator
  mm/damon/vaddr-test.h: Stop using vma_mas_store() for maple tree store
  mmap: Convert __vma_adjust() to use vma iterator
  mm: Pass through vma iterator to __vma_adjust()
  madvise: Use split_vma() instead of __split_vma()
  mm: Remove unnecessary write to vma iterator in __vma_adjust()
  mm: Pass vma iterator through to __vma_adjust()
  mm: Add vma iterator to vma_adjust() arguments
  mmap: Clean up mmap_region() unrolling
  mm: Change munmap splitting order and move_vma()
  mm/mmap: move anon_vma setting in __vma_adjust()
  mm/mmap: Refactor locking out of __vma_adjust()
  mm/mmap: Use vma_prepare() and vma_complete() in vma_expand()
  mm/mmap: Introduce init_vma_prep() and init_multi_vma_prep()
  mm: Don't use __vma_adjust() in __split_vma()
  mm/mremap: Convert vma_adjust() to vma_expand()
  mm/mmap: Don't use __vma_adjust() in shift_arg_pages()
  mm/mmap: Introduce dup_vma_anon() helper
  mm/mmap: Convert do_brk_flags() to use vma_prepare() and
    vma_complete()
  mm/mmap: Remove __vma_adjust()
  vma_merge: Set vma iterator to correct position.

 fs/coredump.c              |    8 +-
 fs/exec.c                  |   16 +-
 fs/proc/task_mmu.c         |   27 +-
 fs/userfaultfd.c           |   87 ++-
 include/linux/maple_tree.h |   11 +
 include/linux/mm.h         |   87 ++-
 include/linux/mm_types.h   |    4 +-
 ipc/shm.c                  |   11 +-
 kernel/events/uprobes.c    |    2 +-
 kernel/fork.c              |   19 +-
 kernel/sched/fair.c        |   14 +-
 lib/maple_tree.c           |   19 +-
 lib/test_maple_tree.c      |   72 +++
 mm/damon/vaddr-test.h      |   20 +-
 mm/filemap.c               |    2 +-
 mm/internal.h              |   78 +++
 mm/madvise.c               |   13 +-
 mm/mempolicy.c             |   25 +-
 mm/mlock.c                 |   57 +-
 mm/mmap.c                  | 1022 +++++++++++++++++-------------------
 mm/mprotect.c              |   47 +-
 mm/mremap.c                |   44 +-
 mm/nommu.c                 |  124 ++---
 mm/rmap.c                  |   15 +-
 24 files changed, 949 insertions(+), 875 deletions(-)

-- 
2.35.1

