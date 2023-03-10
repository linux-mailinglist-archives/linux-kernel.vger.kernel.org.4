Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2846B4FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjCJR4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjCJRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:55:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFED1314F0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:55:22 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF44qf017864;
        Fri, 10 Mar 2023 17:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=V1xbyQGJ4bZYqGXPT3MVt/uryP1v9DElf6oelbSVnzM=;
 b=U87s0ghmpa0UGJoufmroN4mu6k0QZ3pzhoSTynakpY0uyutA0l77y8ywD9NX/aCfUx+c
 pQ8KUk2g/zMG0X8tBDF0cPhTqTgPsRvwtLQn0RVM4yxrE0zQ0XNbAuRPs/90Z8mP3jdP
 eq8hwbvo42uB5vQnuVsYkS77IykvlAsyJ2GZ6S03x1+yyQItasIA3X+Yc75fX9AbvtBT
 tKoNMJExroiGgyHJodQtY475hJ/GkzQb4Hqb+opVtxzb3rABlFV5fM6LBzTLZi5YQncX
 00J0HlLIDtYgBGxhAXNIo4/EViWpbBoebbldvh8wy9cSLevHUm9Q5ZbV235FqZAaFojS +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j5xnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 17:54:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AHVejK025020;
        Fri, 10 Mar 2023 17:54:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6frc1wcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 17:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfSfpmu82PxaUGPszlS2r3zbgazNxSmmChqrQzIxB5NNuoeJgGUNXqQpM6nr5afzb3/L1JQk6EpUJIsYbWzTg3HrpoBStpz4I0C0zcvcMl7SsksteW/nyoD9V70knOjy0ADkBGuYFx/yeyQr0wOX1+wq1w10hGtf0e/oP2fd1RlA+vDRrm57TRZQe8MhmRYw1fZhZ1oE9fZQIaikIZZ1TKEENF6b+KC7Iaq/Q2pX2UQ3op71etsOk/6z9Zugwg+0ATRp5j75FHe6EQnY00umEdKfCkJNO6VQlbDuTZYdrh9flpL5REY6BAZdPsGqMJqiaaiEwYQh/7jsn3vu3pGOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1xbyQGJ4bZYqGXPT3MVt/uryP1v9DElf6oelbSVnzM=;
 b=E9vhYmZjjs044YLf6rs0cfwLx5PbF8FORIrtW/TorP5cFGwxh2yjwOaHJQqXqT3wauOaqIFlV4wUTH4QMFCKbWJwqyT1VdyFeT8zmBLKxobS/sbNe/U2Juxa9MWs/0RpSfKWaoH+IaYY/4J0qC5gmof6oFYiPcO4wUazmeD4+NjUGqLKTU9Pt7dViSmn9i0ZyEARAvN8038VQTQow1AbZiiN94nA/7SNOtFucXdhw2rHNcsXD9uzIkWvVLdfeniNHsQcjtbErG2Tk8iSywABI33+S5ibCjfgGtoTsnKvcQKyPRCyRxgiZ5yQi+WVs5wUAJbZ0dF01yn52WX8JfiNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1xbyQGJ4bZYqGXPT3MVt/uryP1v9DElf6oelbSVnzM=;
 b=VzuRpamS9vzjuEtIrEOgcDZDiF1ljfLKCJxQKntr8Ki0kzfJhPCYAL+JVfOc7bm47h/AZFoGQ+AXoihv7lPxsLDxNWZHEp/6I8HiQs8wpoa0sDKSLbJs4HBwDU3GP6Y9mEbK37TR+Ou8Eb1KC3c0R5seBca4370I6vydko28oLY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5199.namprd10.prod.outlook.com (2603:10b6:5:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 17:54:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:54:49 +0000
Date:   Fri, 10 Mar 2023 12:54:46 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 0/4] Some fixes and cleanup for maple tree.
Message-ID: <20230310175446.k536ck5rqwxtso62@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: f02b65fa-6a3d-4945-a379-08db21908b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFcHXclqkxRexJSWHsPjtVm0yoOcDd7e2fqGyh1jyq99OF7FNxxm/kt5R39Xk4MPzv9nZiSh9o088YqYUPEDPcWVgcO3wzX+eqFfSiP7ogt9MbSGMuWlPu4bz9fDbobwvBo3iGWJBJ8sfeDR1r9mxXd7j7/KvP8OGpqgMckVHbnr9tEuHjttlzhBseCP4BzXAk+ueZdOzHitXDB1T2zIcMD0WGT9sA0FiHwaYbZ/jeOkMjKvhg1gGIdjNbcSxqtD1d0NCYb1Ehdby/wUTKBTmhUQiX1TdfthaaeJ37d/cDzXMHrHmdgr/HCSdL3wvxGbng5lTBDIsfDQloHj19gQ0/AXRd0cyk3u/pHs5QHB/j4o3sA/TziOOSSx6T6aIX2FFF/a5eqrr7wUKqVlyRHmb8oBkabdwhJyj68dZ4dC9YCqEtXsB6u1TpTBBDD/6YqFWir57g7BDowOBbD1Zk2/Em1/iqatC66KKLMU5vVqUwkutRKUPq2lMD1Q9FiSKoJrZlyXDDPz4+cPZcqWKX1ANx6GshzhVDnf3HZmB6jYA2QIeEc2Ua7pFhO0tTmPHg2DfZGj/9s9oaSKlU7AwQtpaG8dNZgarB6aF6dP85rJZ7aAS67CDd6H5Bp9N9EKFO/pZqJf4OZxEv3FUmbe8j5Bsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199018)(33716001)(6666004)(83380400001)(478600001)(316002)(38100700002)(6486002)(6506007)(9686003)(6512007)(186003)(26005)(1076003)(5660300002)(2906002)(66946007)(66476007)(8936002)(8676002)(41300700001)(66556008)(4326008)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKYNzZEXoSh9Dhm71A6Rm6UOHx2gWRgdWMe3OkRhtllIOPg0XavnMCTR9C3n?=
 =?us-ascii?Q?mc+PoLFCil34gKmrRXJZ8w3SSM83z2mUwPpKxipZHmf66owZpJN025xaN84G?=
 =?us-ascii?Q?kUVQEXfHoeUsLGrvEehOu676PXKMYvJxYRjd0iZnApc1/UyXiua6MtVcTYCj?=
 =?us-ascii?Q?IJ1whl4gY/saT9BD5F6iLjcUOpheavL/W9As0tFxB6g8fLwPVgP7wwRObJT2?=
 =?us-ascii?Q?GKGXVn6TBizvps98QczpBO2Ugaalf/mLC6zLjf+nZj0YdSy12ZFIwC8jXHz9?=
 =?us-ascii?Q?xXh3A+SR7FGPAW2V1wsXVSvBCMouw1/uhrD7w3/tZATGkirC5OhWkJ+n1pmh?=
 =?us-ascii?Q?r2sJt+jBs068JaMAJ+eyiHnehH2SHtSfOEpSLJvXh3O+AreJOrfjw6k+4UVb?=
 =?us-ascii?Q?Bi9wH0Yhgiqhae96BBm1P6FBDeNu9FP0xZTMXYm6he4UWIzmb/KqnWgmGt/c?=
 =?us-ascii?Q?iPtADUqK6xo35370smuquq96TGFc6nQ2JsVnEXci+0Tc3ELyVJDX4vpHLHZo?=
 =?us-ascii?Q?RUeuDZresV4SOikCnTrFc9gabfDM2eYjjltkxL0mopvQkwNtnSugyM4iFUUh?=
 =?us-ascii?Q?mJ+k/SOkiRRiXbqFwOr3Dw+vYI9DASkGCSwEEnCLEO8sdAxVZkgE/NNiHECx?=
 =?us-ascii?Q?41P/jSXeMeDQo+ribx/hWHhnKBR1OwGZT6HZg0yzIo+yph84LHrO7riaxs7Q?=
 =?us-ascii?Q?4l8lrkFDpZiXsD1blE5k19HtKcL95J7LgQ0NvpWwYb+VZFuYwV5aT8XhDC0f?=
 =?us-ascii?Q?ueTgnn3pu15cCFD2zv6K5q2fAzQ6zlkZ3TbaLlxdYuGoJCpU0LdmrZnh3FOX?=
 =?us-ascii?Q?nOVBkxLdq8i3ve3KCghGcB3b8am+nP/rqgL2Yo4cvS494PzCTq3M0cLleUp4?=
 =?us-ascii?Q?OgYAvxTLe8xKCiQN9z3oGbTB5+5J2dhysaI25cH8PI0yjZOnXJVKdv9wINBe?=
 =?us-ascii?Q?w4KhlojWi42byUR0HpSlopVVOm7+tv8CzmUJd8alMA8AiyjtbjiTkPZZEBsL?=
 =?us-ascii?Q?NuwUCPUwGVTDG0KitlREfRnO3kVIVyD4VdM3j3U4chJOEfbebdLI7V0XAa5X?=
 =?us-ascii?Q?d77XB6VKTuKN7DGduB2YnG66htuZ9GJ3cc65pxlCiho6BTtm84l97pwPDy4w?=
 =?us-ascii?Q?QS7yv6w7PLBbuwon+P2DUa7WFPEZlwBsBQ+cL5FMCwPiVr34Am7FEUvUEziG?=
 =?us-ascii?Q?4z5vAuSfG8mfMOvxOQiwQP4yzr2COupuIburfAU/nMn69jiaU+wPVN/NtuoP?=
 =?us-ascii?Q?1mSERTnE/ytWtzCH8Agz94A3Sd9HWmMHlA8BabdZE/QKIl5/XC3mQLYDKSUt?=
 =?us-ascii?Q?4V+dqYDQcy7oEs8JudHD5EF+9syfs9RKWIXmFasQRYI2BOEY+5mZUG6SO+h8?=
 =?us-ascii?Q?iqMpxYNnNqkU2piGmdo+FGXQXljlv9RjCFo8WELggAruLjqrcG9bphNHGW79?=
 =?us-ascii?Q?tQM/S/PwLn/SObeTYFQsGnT/uc1zwVrduGr+hsOk0p6FzaqbgYj29PIAyrIf?=
 =?us-ascii?Q?rkZKbRAhbh+yvhPBn2WnRK/T8MJP9t7aUcgnZv+K2gFNqjKnfY9L9RUYxiMJ?=
 =?us-ascii?Q?upzTLpu4E5u0djzl43usKboloxQJB/baXXuiEQlOFyVs2x5ERMAkQXTmFinK?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xLRqHYip0uwahSwXfR6+ZFDvKtQVyQrB9iqHDz/Dmr9g3jpTL1zYyf1VyzT2CQCTNxQnqj5Um8hD2wzz4gDD+f+9pU1vw9GoNfHqSPOfw2INfaqw5DxIyyQroABUmi/irk4uQIPFmV+J8uvnMBn9ZEkp12R4ALeAAOQd6WrEFYtyjz6Xknv63Kca3ielZcANBPmJKUD1XVpdq4nJLY63g4v+OLK5XEVUolcGLhAbOqOyQbc4oG4b2/jy+rUuNw4a5bx8PqUZbz1MsTFXzlQah+Ik+9ZN/OSayZm1HzhK0sXUCZZCAeWS+KFDLCwy3jgW5D1HgHe3AW0bx2Gxht6Dg3koHEEizn8/uhpfvq/0PMlThgLnmERvMypI0QB6bCo3UO9daxZli1BzbuQYqX+XcN6PhITpmYPerLHY4zA2x5CjSeMmCBjaGYhGTe1EAYs/U0MKMgD+7T/RP11BoM7p4FLEACKsvM/KBR+1S8Gz1ql6DMginAcsTTd8PEx2yaTCe00ttrVxzgZ3BW9OaWejxhX+qDE6aAlYpemtSpOzwNRgRQDXoTtu87N+68OfEfYMJ7wVJlwXpckCsVIA6vCIBe0i7+rDiHRRloZeWjJmGDg/Ry5fNvWrI8Vh58wl9cFzunJzSNLvXqLiDY5lYtOWX3SiDXfQsL/pO9M62BzdEv4Moa36JAcHeGIwW8T2uglWTCoN8W+CkYwrZQvjLci8ycVkNktkXHE7FKbTJgj6+4hKh7FvGpxSfqgD79wOo80bH99aOBtZHVQsSjYGSltrjCeUlMbcHr42szPkeR+IlKpEQpdRZd6t0udBDgxpgtjQ9NkivtWJtke3c/A3dazpmLBaj9/DDAZzcWTYuQFhFrV51sUrOH1jb3fwmWJJrTeW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02b65fa-6a3d-4945-a379-08db21908b13
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:54:49.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF4K9EQTa9M+WvoYb2Mjj5Q/ecJC0rE4L7ayS7XAETVsLQpQmW5C61Lwo/VXQMU7owa9Ec7owELAfkONy98zhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_08,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=762 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100143
X-Proofpoint-GUID: 80d4cIHXdagWP7tY8dkw4CqBJPRbP6W1
X-Proofpoint-ORIG-GUID: 80d4cIHXdagWP7tY8dkw4CqBJPRbP6W1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
> Hi,
> There are some fixes for maple tree that may be needed.
> When reviewing the maple tree I thought some code was verbose so I did some
> cleanup and I double checked the boundaries so there should be no errors. Less
> code is easier to maintain, and you can ignore it if you don't like it.
> All patches passed the maple tree test program.

If you have a bug, please add a test case to the module if it is easy to
do so, otherwise please add a test case to the userspace portion (ie:
things that need rcu or threading, which is more difficult in the
kernel).

> 
> Thanks,
> Peng.
> 
> Peng Zhang (4):
>   maple_tree: Fix get wrong data_end in mtree_lookup_walk()
>   maple_tree: Simplify mas_wr_node_walk()
>   maple_tree: Fix a potential concurrency bug in RCU mode
>   maple_tree: Simplify the code of mas_mab_cp()
> 
>  lib/maple_tree.c | 76 ++++++++++--------------------------------------
>  1 file changed, 16 insertions(+), 60 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
