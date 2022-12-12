Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5148164A8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiLLUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:48:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24951057A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:48:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwni6029926;
        Mon, 12 Dec 2022 20:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : subject : from : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=Gv4QiRRYfHYNhxrPix30E7LyXaIUvh/NpBgKyRQqAFo=;
 b=fFFhSl8gg8/GHwMBUfwe8a20P2rWDNLkUbW1UhlLdlf2BjyCZmiWPiWUpS/3Pwvl9MgI
 Qc9wSv9OK3rN+8zWi4fQYr+e6yUep9wLLOCww+kPV8bGc/xIWGCmKU+k2Ip+1rPvo8EX
 4bPggRdct8FzUgHH8BZ0+mSnjyd1P22GVZyYqMM3kNmU+cE+O0s9bR08OG/XB8x9e40x
 IISfFMq1M0gN3gunbh1vDv31SMdqEPMKNffA1sshNIC6pCOLRGgsDaRuFwRwdu579tmL
 smiDE0qVe4ygUZQyl51xktdRM9vr2FtHsEzbRid9ScH1yCs8W6tZMb5vF8777C6J0OJ3 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj093u41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 20:48:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCKX4YO032958;
        Mon, 12 Dec 2022 20:48:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb4waj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 20:48:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmIKQdHGoa30O9zagpZpFSAkPk8Y9qTuKl5jf2weLw1gVi5I52x6m/SCvsZuSUZip8lV4orvlpkkBfeHIKR1ZZ41ab57BoTjdjFdxavLRlYyQAShNgmB7Fz9GURa03Ubi0Pdz65M1agdc2coYSa9qoUkoGDdfkEz0s3V6l/ye8c6qppy6ntCgoFIQoNFml3xHYxAh2L5KuzZlCF1tbDStUitS+6uvXlnBI35e8VeO6wyinijnyf4jWVqGX33GxNEGJm7luZhl39H4HNuXbsfXPMEwZby/xJvJ46qpt6YKW6G402IV2wNtNUuDF4oOTyUQ04UZdgi+cGi7g+pLkjUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv4QiRRYfHYNhxrPix30E7LyXaIUvh/NpBgKyRQqAFo=;
 b=g+DKFPZiBw7bllstxzy/f3wKkd4vj8S1eP4Pj9PSLLM5EdFPEMK3ClFN6jQFZ3SiOnEwwjwqIhOPiwI5S4CGS748ceAlnA7yTumW95CSqPd8hH5J12hvFht1nd71SP8esINiUCKg7WzGvZzGqbOLvb6K8zKOv6UTxNilXXu/qGizJzXRxi3DFnzjpl4frqiW0K3auvcwJltoxfTn8EmFG6d/rk69xTThyCaXMqCu3Cz0a6Sq1bjo8XbmALwS6zFr1BOTvLgCNxL6z/d6RcLkRQ5IT89U3CTcfDxy/YvIJXy6e+qga1qaXNbNuNd47eGA4kJcxWUX425uLC6xq7FOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv4QiRRYfHYNhxrPix30E7LyXaIUvh/NpBgKyRQqAFo=;
 b=KH4SqXg2I4+1tjaEKDA2shTlxfWC2p5Aa86rKktd9uA3YI6IkTJGPO1Mf53FRnxULIK/s2eQNxu1NoJh4S5tXX+EJyk3XDpW0H30uJevXJcHrXybkTW9XKGhyKaYt1zrvlmEeZZbt2cSAElV0CY2FvdMgtNxYicMS1bwNFbTbvk=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH3PR10MB6786.namprd10.prod.outlook.com (2603:10b6:610:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:48:37 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cdac:526e:e65:cfd8%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 20:48:37 +0000
Message-ID: <ed5a5cd9-21f9-18b5-cbfa-2af70bffa483@oracle.com>
Date:   Mon, 12 Dec 2022 14:48:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] jfs updates for 6.2
Content-Language: en-US
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::12) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH3PR10MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b19c0e0-3703-4762-9cda-08dadc823df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiWO+VyoHSNg3UxWF89hdOzFWmmgyMf3PGJIM2i4UD5bsSeqhdYgW8eEv4ODJ8cqGUsxBfiKzWc5t/xDsnRob/yWs8lM14q8b5rfYy8O04H0GDL7H9IAd/B+UZJ1S3EV3YsdWNMKz1Ptvc93HEm8Vc7tNdVdbXa3xD9jXRNvLfsAhETOd3q9dfbI19pByARScVR6R1kR6sS1wotRJ/AyVRzamg626uc6nrt0x3ceEMDKRvsPPrsfbtMKC1vIylQ/g4C+yT2yyZX/r+IKdxTLBYHeaookQuO48QSByiPPdJkEjAOB42oIjjQCciDc/Pi5i1oD1mqfoUGVD+/2+G8XvIYKaRVH4QfuStGNR+w3salkV2YQBDkr91Ge3W4OOCX9cCOGqZ0xtP1aKdYzbiE6eHaM3plWIcJVDTHLZjfhw5Vp55C8hgp3b3SyraTDzSt4/uK4rfKsczAlvwp6+giEJpgBX0nTt4cvuPkaSFkXpCDS/PynsulVmFMHzgHdMLgsxE+CEXcH3enlS4zftD4wEGNK3dmfcI2/tS12SWXZq0C5urhtI/0VKuTbaGT95GCLPVO0rqCnyMKU1Wjh7cBwqNGC4Q/fzEWwkxghN3UmE0xms4jotu92x5x00Fg5fMahH4+ypwlhyf5qBmFsZHhKFzNMI1CL9d6ovG6luceglTKXjN7slVwOc+RPscsgvOPlPoWs/YWUA47EAWJUoSeQe+Py3qW2sRjDE/XfpuEWbzZu0vTjh5O3c/SvQIm0MfWO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(31686004)(36756003)(31696002)(86362001)(83380400001)(38100700002)(478600001)(2616005)(6666004)(966005)(186003)(6512007)(6486002)(26005)(6506007)(41300700001)(5660300002)(8676002)(66556008)(8936002)(4001150100001)(66946007)(44832011)(66476007)(4326008)(2906002)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGl1M1BEZHVGdCsxVGozSEszV1ZiSzQ1S3N6bVBHRDJBNGJJUXNKYUdOTVV1?=
 =?utf-8?B?Uy9US0M5MHBabjEzMExjcmczS21rN2dUcmQzdHVpRng4dFNPRWhCN2VWL2o2?=
 =?utf-8?B?L2VYMDk1LzBFTW9BQUoyYlhqdnpqdGhaWWUxUWZva0xEeW1LN0pzcENncGdU?=
 =?utf-8?B?UU1CZ2NTRnV4Y0d0ckZEbkNrb2lFOEhyNkhhcWNnR21hdHV2bTJWcUxUZmJj?=
 =?utf-8?B?YjNpZFVPS1lXNEllR3ZneEFRcmFaV2FWeDJqUENmWmtCK21QeVJnMHhqS1Ax?=
 =?utf-8?B?b0tZamN0cWVJeUtaU2VlSDFRMnBEczdIbHlWRnJ3a3JrbHZsUGFmS1hOUm4x?=
 =?utf-8?B?S2dzaVlTdVdIV2F5V0l4WVlTMVBwQkNjK011U0hrWmQ4RWhCUkFVUGl1QXFl?=
 =?utf-8?B?RVIvOHpwYkpvWStwNEh6M1lrSTA2TnZjSWhOV2pOejIrOStldHhzVldTd3lY?=
 =?utf-8?B?bFBvOE4zb1RJSnlkV01YVzluaFpiZzJuVkhoNENCcEZ5UjkzZzZmU3FUNlN3?=
 =?utf-8?B?VTBtYTd0TW9IWmhmV0lWREt0N1JVa0RoYURSQkptbW9vOHZjcCtWUmtUUFVt?=
 =?utf-8?B?aURvK0tKVzJHT1hMRzRLVnZ0VCs3ZGp6bFlUQlMxb3ZvTUJNYmFkT0lkbWI5?=
 =?utf-8?B?NFE3QXFiNWluSWpFbkNXc3VJT0JHOWdFZUxPeXFnR2dZeFpkekVodVhHM3U1?=
 =?utf-8?B?U0Z1M1lYUWhiUWxid0dsTVFVQTg1VlIzd3U2M2pHcUhLMXBmYWg2TlpKYXVM?=
 =?utf-8?B?a0NzWFZyR1ZnWjRrV2xTVHFIVXlOUERMK3RicDNCVno5TFFNSWJ0RldqWXZo?=
 =?utf-8?B?Q3Nnb3BwcU9PTHJYOGtJNUtOQTN2SDFyMlJNc0FMR0tmVmFJTXd1QUozcmpK?=
 =?utf-8?B?MWlLbHFkSVNuc2VhWmVLVzY4KzZUbEhoRHg0NGJmLy8xdG8xRnRQMkpLaFI2?=
 =?utf-8?B?alQwWmNmUm43cE1uZUZIMEJUU3gwWm1GdlhycmdFTW1uYU00Tjc1Tjc1RXRS?=
 =?utf-8?B?MEw0L1ZZeUkxTEo1V01lRUhJaXpsajZLOXd4Z2wvUzQrdzdNaGo1engrbkVT?=
 =?utf-8?B?S1FhN3VPcGNUN2pNWHhzeldCdXBqRTFBc0FsRDNtZHA1Wkl6Y29QSmszckVi?=
 =?utf-8?B?MzE0eTZIODgvdWRpRGlnRE9uSjRQamh6SFdvNlZQaldDTjZBVUltRXZlTVha?=
 =?utf-8?B?RU9IOHNJcjVQL0lsWlRwSG4vcTFScE12OHV0NFVsajB2cjNENGMrSXJBWHBj?=
 =?utf-8?B?bWhIa1FWbGxkZ2hmcHMxNXlIYnRCM0Z6a1o2bHRLYmhpeTZFVEY5bjJJRXJV?=
 =?utf-8?B?UUxlRmViTFdTZk91dS9UNWY4NVJ5MzhIbDFWV3dTdWw5M2c5RWxoaEsxY1NX?=
 =?utf-8?B?eGlXdEN0ekdUV205dUFDQlFXOFQxL2tYVWs3Z3dheE8wT04rSkVBR0xXSCsz?=
 =?utf-8?B?dGZQak5mSVNvci9PREZqNmgxNmJ4RE9TQjdJcitNbjk2aC9XQWorVWQxNlVs?=
 =?utf-8?B?SnIyQVZ1bnJIZHZkbldHUXEzcHp3OXphTFB0YnZ3aE96dW93RCthYk96Zi9R?=
 =?utf-8?B?WFFITzZBRnZoTWxhTHQ4RkxTTDF2Q1VqNVV6THY4QlJYMDY2MXkrd2xUMXFW?=
 =?utf-8?B?N21EWGh2M0trc1lyTnlLbXJhMTV5MC83TTFTbGpoT1hCNnVjQUNqU1BJQ05k?=
 =?utf-8?B?ZmlrZGhHL3Y0bjlmeWFBV0lKVmVzTW04SHZ4TW9Rc1I3N3RNSVkvOEtkMHFY?=
 =?utf-8?B?UnpVTjJQN3FITGpNUFRieVRyNDkyUWFyZk9jcURvaForZzMxWk80UDR6Y1pO?=
 =?utf-8?B?NXVNZnAzWXh5eXllakFZdncyN2xsYk5hS09aMDUzZ3lkYWltdU1aYW81OG5l?=
 =?utf-8?B?QmhWTVFLZStkWDJnSHJWaStYQzBlTVFMbU9jc2MvajJUNXMvUjJVYUVmZmxk?=
 =?utf-8?B?ZWF2bXNWTENwemd1cUdyL1VuTm1xcWpTRUlkODR3dTNZcGdXYzV3YWJCSUpL?=
 =?utf-8?B?T1htNEM2dUFUOUh5QnhqV0tBRlFvMmRaMVJxMnl2NkI3NkRnenZscHFGTDNh?=
 =?utf-8?B?R2xVSFJVdzFzbkxwRFN6QXltT2NNQkNtc0dOcHhxZURBeTlkbVA4MXdVdU1r?=
 =?utf-8?B?YVAvaTlHc1ZpREhCUTV5KzR2MFI0ZDY2amNjZmpaQ2E5WCt6Y1Y4cjM1ZnlH?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b19c0e0-3703-4762-9cda-08dadc823df2
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:48:37.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bF/a0rl95S1NtaGTCDAyN6/S3/PtPq6zdv6QiW2fY1GykJr+Hm5rjAxQAjpQUmZSal2UjRQ4bLc3Yv9Ar62RBRi6JhvZE37+6cz+WJ1y2U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120182
X-Proofpoint-ORIG-GUID: uJVnfsHin89ZyoxiuPz_tQAmiRJfIASW
X-Proofpoint-GUID: uJVnfsHin89ZyoxiuPz_tQAmiRJfIASW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bbb8ceb5e2421184db9560e9d2cfaf858e1db616:

   Merge tag 'v6.1-p2' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2022-10-17 10:20:04 -0700)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.2

for you to fetch changes up to a60dca73a1a8079d867b2c2e9549440346c1ba83:

   jfs: makes diUnmount/diMount in jfs_mount_rw atomic (2022-11-10 15:22:23 -0600)

----------------------------------------------------------------
Assorted JFS fixes for 6.2

----------------------------------------------------------------
Colin Ian King (1):
       jfs: remove redundant assignments to ipaimap and ipaimap2

Dongliang Mu (1):
       fs: jfs: fix shift-out-of-bounds in dbAllocAG

Dr. David Alan Gilbert (1):
       jfs: Fix fortify moan in symlink

Gaosheng Cui (1):
       jfs: remove unused declarations for jfs

Hoi Pok Wu (1):
       fs: jfs: fix shift-out-of-bounds in dbDiscardAG

Jiangshan Yi (2):
       fs/jfs: replace ternary operator with min_t()
       fs/jfs/jfs_xattr.h: Fix spelling typo in comment

Oleg Kanatov (2):
       jfs: Fix a typo in function jfs_umount
       jfs: makes diUnmount/diMount in jfs_mount_rw atomic

Palmer Dabbelt (1):
       MAINTAINERS: git://github -> https://github.com for kleikamp

  MAINTAINERS         |  4 ++--
  fs/jfs/jfs_dmap.c   | 27 +++++++++++++++++++++------
  fs/jfs/jfs_extent.h |  2 --
  fs/jfs/jfs_imap.c   |  2 +-
  fs/jfs/jfs_mount.c  |  4 ++++
  fs/jfs/jfs_umount.c |  4 +---
  fs/jfs/jfs_xattr.h  |  2 +-
  fs/jfs/jfs_xtree.h  |  4 ----
  fs/jfs/namei.c      |  2 +-
  fs/jfs/super.c      |  6 ++----
  10 files changed, 33 insertions(+), 24 deletions(-)
