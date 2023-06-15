Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3E730CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbjFOBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFOBwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:52:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B4C5;
        Wed, 14 Jun 2023 18:52:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKJjPu018179;
        Thu, 15 Jun 2023 01:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=m31WKPw2obGwAg4HUJLHms84LrozQCsufx6pDKWSSPw=;
 b=CtSvebqhLXVYk6fszM0/mqx8kfqIeXw655vf8kvshrTOhWTFrI3FHmLeGdRHjBnmKvPd
 Xjp33mgVxOMQge6Bo03KL/MbcTF9SvXO4OdBn/rDv9c7usNQwXfoHmRiSDcAsFD2hgFB
 XZy0NqOCkWhxg7Yi5AQvHr8Qi4cYmyGjAAYytexhQA2lVVSd+rNZ+DUDVk8rVjfwyMFR
 GV/qxm3Xf6xg5RcZQ2/AhFPjGoSLvymA2plA9PtsY0HZwqSvtEdDC3RPSNJFkRgoEb6D
 dpEZfuSVRyhYP92QeyXrIvp/g4KF/GrPqQ6qvbXmyw3OJ5ulIAoVPTb7nyNyHJ2uQsYR 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d8w2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:51:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENm4FD017747;
        Thu, 15 Jun 2023 01:51:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm61yjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anp89ytvvOpncF+lJWfGx80d4vUuqjZrtjuukjHk4xD393d4O0J/5pnf3cNkC/bBn6l/U8DsnH8u+pACEtbySDdxgqg7eU06I85+LTYiMqJRXJ/IBrM7pKTx7q8wDoxj5Cm8SYOpoMTQiquYQFBnaw6NLQAzXi2JKYx8ScA1TVLl75m8x8QHdZQq+mjm67oBSH6ZaqjSKFV+it75jin0uwvRVimf5Kv7RHnRYFj9/OzH1DHrZbDImoq2gb9C440YBOZA76RPvCgfo/J4ikVPKTX1nwqKVy4APkvANxdqbxJ1bJfb9wyHDvfv6ew1UuYIiyYtGoE3sq7s3LOdpo+Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m31WKPw2obGwAg4HUJLHms84LrozQCsufx6pDKWSSPw=;
 b=OjRBPUHBF7iGsGkk3wUCcINfSTf87K9rispYiQyPXitdxb8smLU385oA8S3GZGhehwbae2wnTJigY7+nmX0b6iKuM9Q/8TXMOKh2DzPYNU3x9ltY2XgCe2pgZinbXMsh9qiptYQhCHYzPO307K/k4nWqARis0RyoZa7FZHEyFntN+nEm+/zRYZt1Zp8j5o3HAq8XpISTXm0yzmjfISMJyDkMHng3dOS1YEt34PMEhrQYClqKdBiQibgIwpBVt9ln2WLWfIGzfNpBUVeY4/rxqQajUf+iryZ/90MvaSAtDQD8aUlVS6bAb9GhZadD8bWoSjce5vDr0/Q+CzKOE+wKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m31WKPw2obGwAg4HUJLHms84LrozQCsufx6pDKWSSPw=;
 b=ZvrNPuO+eUT7iyGNIQ1QJEWy0h9qVTgWf3AUaIVwO9NNRC3SvMYxzj2a8imIA4+h8oo2xyGfWXBWn7zDsP5K5rjviY14GoyGAat/eoxWSpWlIukRliX9DBOsYLqD+lAxEXCCijmUuGw7qxaPgawnQGX1RT2MwlqWFz+rSD6Md24=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 15 Jun
 2023 01:51:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 01:51:24 +0000
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Peter Wang <peter.wang@mediatek.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER), opensource.kernel@vivo.com
Subject: Re: [PATCH v5] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jn9wl0t.fsf@ca-mkp.ca.oracle.com>
References: <20230613022240.16595-1-luhongfei@vivo.com>
Date:   Wed, 14 Jun 2023 21:51:21 -0400
In-Reply-To: <20230613022240.16595-1-luhongfei@vivo.com> (Lu Hongfei's message
        of "Tue, 13 Jun 2023 10:22:34 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:805:de::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d44878-2bd6-437e-12ec-08db6d430669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LD+SIsZ5yXoYib1EPOYQJTU6OimX0OcV8vU3sx395FPVTR413MlAWgwCMjORUSjwesOsK50mYnBmaDDnvlHeohy7ZsEciNfC8BGY3SkNxSkbeyw9mHV/kZpyIu0FSL+IBGS9Bmc+fF0TNd5wOTAu6cCsVsh2cjJhe9SVH6Vrhqyf5Yx/LVlClCgrrl+TZumt9I5CkmOWNTzSRiNMJwOyZexnKksnik1VNviAqnIiyyDjhZsmqF33ylO2TPRCInJTeB3pJzH9W3huSX3tUIhEn3C1tik/TtkxddgHDOmGhmx6UYuOjCMVTjtROyfm9QO8NgiLsCgzNkYLWZWThoWKbU6GYam1ggVdO0opJhKRrbDs2XBOCvXl6IAl0tQJb3DvmBHeFuEF+bIvOC1x1fNZ20lhnzrRCP3PvDanZQ/+jUbuR25FJJUGoz032+p9z/xkDT4LGbeMMppu5BvKHF3OWOUPvgE7S8eEasqDgpBa1YPGNaBR8R5yF8I5/vnBnuuvuTrBDZ1YD8t7VNPOdzmwWoNTAC8mw2c6xcjAx3IdiJcaBTlf3wOcgFDAMxBaKly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(26005)(186003)(6512007)(41300700001)(6506007)(6486002)(558084003)(7416002)(66476007)(6666004)(4326008)(66556008)(66946007)(54906003)(38100700002)(8676002)(8936002)(478600001)(2906002)(6916009)(86362001)(316002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dDxM4KMr7jQyJHkpKhb965vLdWLuwyv1f0pOiPy7nEH+3EWMrKoNu/T1qb30?=
 =?us-ascii?Q?Hy6xLeb/APAWxdPZrCNAwsImgmnUGOd/mV61hKgJcqNc4hfgu9TiHifTuc04?=
 =?us-ascii?Q?NBYP82fP6qUBmK8CSgUKFaLf7Oj9AqfjxJi9xvtv/iAavr8V7tWXo2TQZczt?=
 =?us-ascii?Q?ERyvru2JTmSifi3WIJaVpQMs49ZsEbRjkRqW1dYDZHuDw/gs4PPHfPo1AVft?=
 =?us-ascii?Q?DHviEfEfOCyC8UW+OrfGf28KX5LNsYpeFVHpaa+Xym3pjzIfY4PltgkYvHd6?=
 =?us-ascii?Q?pOV2+FeFS6qaiBp/f8RW6MXAtDC85lwJYiI5x+DPvL2GnPzh4tRKnDy2nYA5?=
 =?us-ascii?Q?jjK4wWY9o/jS9Yqe2WcBwj0X5wjPsQhjozuvOucnzk6ZBRSftwRHGBLADQMf?=
 =?us-ascii?Q?469gD9sUNlPUNcg2Ec60bpZUJzMc6KzJFcSGxdmCIg0yOOhl7uc+4S7h+dw5?=
 =?us-ascii?Q?/gXBc4iZDFS2+LkG7A4irsatPw6ICKCnrUGPQEJWKlGeKLN1aCW4vai3BsDA?=
 =?us-ascii?Q?UOzOPbqEXvK75L4+j3nFu56NwMogaVA9tZtTGU+EsROk3svyWdMRaI82GYqi?=
 =?us-ascii?Q?F04kfh6EiUCTcrhB1QDuQyOMTv0hHHnYJmNovPYWZyehsVYT62GFhq/8xQnU?=
 =?us-ascii?Q?P33xvD1htZIwze+lQz1oeLxujM6VgqY8WVHxhx80Bw9TR1R2SwYlqdIELbSt?=
 =?us-ascii?Q?xKw9ydbTmTBL/GTqr8eRNYuqbJfTBYKrul64lqAqb2MN2d2rv6vn+zW+Y0vA?=
 =?us-ascii?Q?Mm7h29Nm/0X6uePdJ5zZWYrt6vN2F+2ekFsi4ya/q3MMKba/dsH4ZXJt+Sp6?=
 =?us-ascii?Q?izbm3YjGxxozKQ2Y5v1LHKRD8w2JGrZbWMW+fMcrF8KldwDjBfr/PAn6DjDm?=
 =?us-ascii?Q?P2BF0RgcS+q8eKzKAlMxT/cxGBnYnVqjfWiiJsSiUkUSCeuM6gczfbVCD+gI?=
 =?us-ascii?Q?guLc9aQcANuFB3ni0KGL/G59v6Bzce/kpUiWjYLJGBGOSNYFq68ucGOvwL4c?=
 =?us-ascii?Q?awLhRZYPqCp5BBx6jdW5KlRCxgKRaNrbl+CiTdIWiY9O08aurMde8nq7hQdP?=
 =?us-ascii?Q?z2ABlqotUa6+k/KhEVHl8CCIj22gbKxmLZIOtFc0SL4fi3wWrZohP6ZUifVi?=
 =?us-ascii?Q?jHdn0+sMrVgSW3i13qtoytNSQ6bDQ+KNfXEg8xARq17WQkUmoB268ISr8tWq?=
 =?us-ascii?Q?R0Zbi9TE77z3UYlpgDV4NXSeSIKzEp7pu5bpA1wkYrqL5IQJF8J+6rtLNDwR?=
 =?us-ascii?Q?1d6oTKBUZ76n1oL+/GZ6tFlcHkt76egw7GOi9t2oiIXcV+PBQJJlyYe0BXEv?=
 =?us-ascii?Q?zRnuvOhV/MdmC0Gk3VDORfqjvqK93m6haOhO8W6+itm7x7zCaiEWcjM0yKWH?=
 =?us-ascii?Q?dqN94VxVl+hjOVfRL+oM1pdRydc5NLp3Y+Zxb6ScgpSgWGkndrCUiQ8JFjcs?=
 =?us-ascii?Q?R5nF7fob+wXjAMbkDicxJHWQWaHza8dcl9Mf4MrgaPhiqytoITjDrxhsvYd5?=
 =?us-ascii?Q?jA1FKecQqWHhDTRP37foxjS2c37phIJr42aC+9IkiIlebjXkynC/Q9lRBE88?=
 =?us-ascii?Q?mtzg4qbhdAIMdvZ+xKDLisKDUoPvnLXIw2hRqLRaYD8C4G21XZtQoojjmwgQ?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iziRp+ryDG+gCOHZWEV0b1fm8h4SM0fzLxD0PuquEU4WrxHiiOkWSoYFeP7K?=
 =?us-ascii?Q?ojJwYTNe9S9khFLkWE7e7yA2yjIU8uDfuHL/BQR9dXRh/6NvfVpjvZ069h/6?=
 =?us-ascii?Q?MgiqKcKHbVZGSmk+NkZEwnt0Y/dMn/8Had9KkEVhmoO4EV5kiczbjNxlNRX8?=
 =?us-ascii?Q?lWkv9mSXffCACDXvNqXpNVVxFx8fsMgclB7kCG9lUzx4gg7EJhyyJGAV2j6D?=
 =?us-ascii?Q?tpbyiviB2GHjcTzwApzTsKIQxqWgVGdFyWAOd5wLkblwveqOPYoWoTrCBlNP?=
 =?us-ascii?Q?BYptdgS/XzjkEaNTYGDO52hIsa87HvuL/dbt7TpVBgwAmWgiqzxGFNb9dwU6?=
 =?us-ascii?Q?UstpSt59pdYXCT1PugGzzuO5YaQ/QhJwgq3LSxWA1vG//kEOt+YIK1lzar47?=
 =?us-ascii?Q?nkWT5Q/6Ueef54zD5qUzoofGAnGSlGmK7mNyu32t4aGGsmroIK23h/REql/+?=
 =?us-ascii?Q?24q08DOlDRghJhrQBVotK2Bk/slFQNRuavfe817xUDu7rc4+09DQjTv1lfSF?=
 =?us-ascii?Q?yU2fJ8jxNkhqxqBB/dTo6Irx0nJEzJXmNPgN006y6WOQjpx3Dq0WaAslSJyC?=
 =?us-ascii?Q?4vAUITAsYkRSCAu1zWUSuEvW3Cj+qWQIEw/wLu+VEso+Qyiisj+c7ugJ6Nw0?=
 =?us-ascii?Q?y46B4wdafQGXtzNvKY8VUoPhBKnbonPvAwnb7IWI25QPmDgtlCS+70R4/SWs?=
 =?us-ascii?Q?yumBtUSIFCamIhtNi6Zjm4mA6IptEcIwMGuKQ09BcVNsxFdsuW4qyPmmbokS?=
 =?us-ascii?Q?6AHaMvQtt6tRLR0ETXAjfpgBS8VFqHTxY+/TVd7Rni5oTzZh42uqQBXrIZOw?=
 =?us-ascii?Q?vFUhomoYftwwaW4uwcoVn0LTEwb7bCIfcbvVm8xfZ4QN1kIRtzD6QSr2jGuf?=
 =?us-ascii?Q?lvn96FWE+Fur6rfUnkn4jblAYEOIwcM5dZ5TNTxTcWY3SVK+AjIBTFW8ZwZe?=
 =?us-ascii?Q?uSF6DvhNLQGOffukQPy0q8ac4eJr/Lsm+l7wv4NT7RjXF82crj2vdmgji86Y?=
 =?us-ascii?Q?Lys+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d44878-2bd6-437e-12ec-08db6d430669
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 01:51:24.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBj+fOoM+x5HjE+5W5D5caiajvYpRVqQipGmIyycwZmWznWP0p4JHgfr0ErIosvosyQ+iqisRVlyl9hds+YwVfVtJeac6WzAW9dPuM7WZ44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=594 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150014
X-Proofpoint-ORIG-GUID: inD-rXYJRRsLbGRW6QH_gxvhvpamsIVm
X-Proofpoint-GUID: inD-rXYJRRsLbGRW6QH_gxvhvpamsIVm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lu,

> There are three flags that control Write Booster Feature:

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
