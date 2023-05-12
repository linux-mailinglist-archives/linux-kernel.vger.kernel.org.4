Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83663701223
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjELWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELWVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:21:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49D198B
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:21:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4AGh017810;
        Fri, 12 May 2023 18:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cdJ8lm1z/mPh75QcXCutPwSFiLdHje5rsIQEGiQdfdU=;
 b=zaBG6lF0dycp05vQaHl5BahZH6WjCklWDMOTgjJcHdAxfiewOxsRfyXrGx7vUas26MmX
 /6l/a4eFdisbyPSupGSdpjKndXuFFSB1ZEVBKrQhLtDLdnvQCq1SXO5fHi4WvQ7uTmPl
 IUAPb9tKEYnUlkeMBD9CJTA/F0AkpBBYclfe3+KoPob2wuOxQg5GWM+k3GMivNJ91GLm
 e9ekaqYLGELbrqyK7Uf73gCobvWS9ZqBf2/68Q2SsacV9CfwspUKCjJvcg+Ih3dusYfm
 2IRGRzMHGhHc1GzmH+CrkLdeo16sKmEajgQfrnmkgTZtJpayEI65wjNEkPZ4GItvGvzt KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qhje7j3m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGqBGf018389;
        Fri, 12 May 2023 18:21:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjm4k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7HicVJF2EdplLxN6JanTWKy8ubJb6DOARK/S9F8rQhq+0pA7N24YLHIRprCoCdxVpzSSIPE1sZ3f9tLRTNdW+392k8oaVCa0G5QrD6PFxvi0yA2fuFRCBAyMOSHWUC2LHhEnISY4kJ+Ppt5WvVd6Qwn7i22gzgknEfLwHcJbw0AWLmywN2DntnwDBPUIbru+C8VCklyrNi2FMempHRysd87wN7VOq4mxhTQTCd/J7c51fgaNN8ib/JANRKEQQKVtpZhJVnuYwsPQn+5QoRsZF1EO1eMBw9SBcYXY597S4om4b0xfC7fyg5zk47fK86z3HOlSEL8kYYs8xuSbXpKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdJ8lm1z/mPh75QcXCutPwSFiLdHje5rsIQEGiQdfdU=;
 b=B1BpcAUa7eVSMX/yXKp1QwLdpnH/g3RM975S+XZNPrqfNh76eV4uXtHHrCq6fhStxt7QRE3foCD3fVahGulXVbBBtYMemI/EnsKaPtM91hE1E363xj6xiyI1NsFy2x9bxbDrM6cjVf/4h5+tRjwiziE5EKG2a1RlW7CE2US4bY6+YYLPu6R/FF+JzNJbuxQtgRyKt/HYg+55JF6JnKCOarl4DbxnYwx3ivSqmIfX55RqY5jkLzFJG194JACkJPEU5LGmXtMr1UILeSqFGrDg5vt8cV501uLTYI3z2TrrmQyJxVeDppm/5UlNbdEpbCM+ikg9pEFP0OxG7w58dj/mvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdJ8lm1z/mPh75QcXCutPwSFiLdHje5rsIQEGiQdfdU=;
 b=aGQlkPxuFFwMXn7eHrwC1JhLq77XwforE6y0rUKMnf8ieIcDDKknXi1FUZf0tNnSfc1y6Z3YMD+Gm1IWcEvxH/5D66aKrJs5n1D9bDa19Zj7FFG1yVJ65WH8/S1/XBQzOkfSHrfzG36CKo8K2pJAhGK7Jx4RnTjDNwQO+qdyaGA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:54 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 25/35] maple_tree: Revise limit checks in mas_empty_area{_rev}()
Date:   Fri, 12 May 2023 14:20:26 -0400
Message-Id: <20230512182036.359030-26-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd4b1cf-1d0d-474f-649a-08db5315c3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9S+sR4ngD4nQbHxf7+xcHpk5a9gBQUpTbjI0Kkt8K/he08zGTiWlQy19BYi3TUrt1yM+qX/8cP5Y7Zq7f0HVukcHQgm+qlJwGKjnUHPgo7eY2m0rViFr66lPE2tYcqkHnmQOIl5WPraAjp2tVEg4LEosoBE4GKaqYisqu1o4CVQwVE9v9otYjBhWl0WqnA7h/WSD6GxEYu6fUtbIqRoRDH19xLBs2Y2X6cILrboA06D4aKqWVmnoJ82FaKvGnrLOgje4l2txBSxOmd2eLcRPC/fGfPKYQnwDSQPvrmh91beFgdG6JFcK0DVaHAQxctgs+bJ0bqyIRm1WAPnK1Pe9VFaCM9plHSINYOFDU8i3ACU4GXNvW88o9FRTNinEGiPGtSaLGUyN9rmjB9i116h3f4cBKdwX3MTmWYWFzyIlpGW7vHfeWgk6a2A65ur9LHtIjRgb2I54CaPabMoJldxmiHiOL4+Q1RAHtwk1I8s16MVU4gm1dDixsQ0gJY7HKMqIGJno5EIW66DnE/XIDcUMydasqMmyTgh+V+rA2u/I77NVkHvVnEWTQGyINhB9WVtC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(54906003)(83380400001)(5660300002)(6486002)(316002)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYtuC88m0Ty4TD6mxKWVd03AVUogQ5AuzodbZ/myXhsyCUFdqZBodHMDRUBa?=
 =?us-ascii?Q?Cwc4LWicbG6/8ZCd3LV9V++/Be+ld/82lbz6tvXG/YswwyL//yBlMe78PpeZ?=
 =?us-ascii?Q?Emj1GT4qeMMhclTUOmnq+zp1ekbrt/i5vw9U35g0vrs0ooeoVEwEdHPYlLdr?=
 =?us-ascii?Q?kKVNqGj+L+QNVixnLHbK4wFV4WavVCfGS5/VCnhvxaw5/rvMd8mtwc60qHxI?=
 =?us-ascii?Q?iIkFik0BMkVUL2zVTmbfscM7HtvS0ZYUEQmQ0TjCjpcpSw7Z9PiTpKwQDODh?=
 =?us-ascii?Q?uBiyyPxgvsaiIoPckgyr6JALhEUCkZdfzA/N4TYowZviTrT6jA9ZDopYKgoc?=
 =?us-ascii?Q?lk5dbL6qFkzktAPoUNkZcPKCMGcby/q8LwYHXEchISIjihLXfC+MiBsiapGk?=
 =?us-ascii?Q?qjZf5pVdDg7HUz4TgvykAxb7BKdXxt6fZNni4EZ6ETmlNFO02PjU2NZxRqUH?=
 =?us-ascii?Q?2O17nx12NIL/F75I0/s2Gh3Ac4TQFY+X7UP5Ot1WuzqxvNHaecWgAngSkZoQ?=
 =?us-ascii?Q?lqJsFys2WRCtWd0CZm1eqRQ3nC/tNTd+5/0mAj6KTaMsOctcAGIQ/ArRN+QX?=
 =?us-ascii?Q?Sc3MvZ2Yid+QRQNyyrhUYeFEsCtr1CBzkq0mLtmbscPJM0//75K8Zm/ZRxaK?=
 =?us-ascii?Q?bd2/GbgWMQwhyYDbE3MWS+mwJWewucwXUS0D0FT3iHmv7gnDXJEgshg1sta6?=
 =?us-ascii?Q?NSoAFHWNaUEAIz4Cbe8h66AV3wdZxtUn6eGNycED7o1snJTH18/RjbJb7Bg2?=
 =?us-ascii?Q?c6dhrG363FaqcRMmDPJBVEoPRRnVQWBKw8WQtn/79rBjNa/L/RvaXQACxrC1?=
 =?us-ascii?Q?jlxMP5tlhB521QwpzCWNlw9h+8XlnpZWaAyXu9wFOCXoPJXs88hjHT3l/luj?=
 =?us-ascii?Q?dAAw7x5dPAuKTW0DS+960VZP24zfKZoGKWCqNfNkNjEADd0ymfg/Zcnjri85?=
 =?us-ascii?Q?TV8Sz7ybZRxOb6aZp7bfXzKC7xDlWQqYkRdcDzboeA3InoQ+U413ZA4Le1og?=
 =?us-ascii?Q?sUY8FufU7fxPP5xwiP3LEOfsC52rK7lL5g6SFG+H/GWbom1aJK5rulrLmeim?=
 =?us-ascii?Q?Mrq9zHbbl5/Mgp0LB5RqoUVB90Qldn1ples3zFtex1xOAkTzN/Shv65KrSwW?=
 =?us-ascii?Q?GWiFuMIdsLfSO0MCTgyH8jUH0oQFoYtlvxkEzRRXlHY7J5u4D+O96UfzPYM3?=
 =?us-ascii?Q?Bx7EMCpMgmVl6gcpi4/09F6BYV+36yC71zyL44BmKIAAusT1/oOqW82XyA+O?=
 =?us-ascii?Q?sGYjrrqX0pktbKUQAvDCebNSaIOKQlORxhzBIDnm+TOQM/YYpdCLRzrjYC9d?=
 =?us-ascii?Q?0sv8YgfER5XrijZemHyu4uILui1eS/Npd3Koxa5sS2uP+UwoW4VneeHp5YAC?=
 =?us-ascii?Q?rnLoKCp5p63fAVZLJEoJ6qX8ixRWyhWuMC7zA5oiSlgT0lfjiKjgYzioT9mT?=
 =?us-ascii?Q?Z0n3G1JeiDOVBjngQTKhC8yTNYyYkmWe3tEX9pyZtBSk0IS6ILnvkSIFdOqS?=
 =?us-ascii?Q?WpaflpdHIzspx0PqPuyM9G5CHp3OfZFORfWfllQEhEukSPQXSR+xRF/EPoOM?=
 =?us-ascii?Q?utLzbuZrRd40t8TArKuFfLbMRKRcZoAilK2mHb2LRVCogxBn+pP0Bo21WmfK?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lsLkyzQqGQmtUeXLmjO68IJyOVz1++mgo8dkw5rkjGCs2IO0WDmNJKEI80RA?=
 =?us-ascii?Q?RIuSsFVFFsCF4R0vZTfCmgHFYlr5zPPGo7HnERN5uEboKdMU+iLJMjy1iJIK?=
 =?us-ascii?Q?fJQuVtuoFm5RSlcMrp4f1xJ9PvxFDC+pSP+freQSe+HfWmOClNy0wW8YMAxP?=
 =?us-ascii?Q?HNjKaDCmRp6d9v4/XH4PUFG4NmvrhIEo2rrCUc0kfIvPn7bJ3U+FyXFV9Qu/?=
 =?us-ascii?Q?JEU1veI+OE21Nnwkxb02djOzHZ5+BkkfThUk1i19WW3t5h3fLG7ML6LDqtzk?=
 =?us-ascii?Q?0AGPDGARH2svLQ4/9ctWIWKsiZJ4ihgwklTzn94995FTz9AYDi9yGRdQh4z0?=
 =?us-ascii?Q?J3021i+XtzC5bR69szarsYwKjJStPSc7tS0ijEcSE/An4eMsWBvUrNxeSLvJ?=
 =?us-ascii?Q?JKOkgA/6glaX3vzKwyFF88MvKN/omOi/zKzDzf45msoDNXNtG+2niabmnGCk?=
 =?us-ascii?Q?HcUDXRSK0wqxsJZYgf/0GVAVu4USDYtR8e3Zgb/weB45qCxAsQ0x5wXOuMO7?=
 =?us-ascii?Q?kvF/5Ode57CCVeFI9n2G81roY7zynS/9JXeJXLkkC9cUDCSUlgFfPyE9V/ZS?=
 =?us-ascii?Q?vXgx0PvGuNaF1OfvGzSy11DfSH4WdnbrVjg48qLOCO22uHDyG1HbWYZZoOz9?=
 =?us-ascii?Q?8Pi12TyAIYvqJ3JRn4nlxNC/LaC3TRksoy6iUbJZuescyANO1l4bTBCkifNT?=
 =?us-ascii?Q?GrTdFb94+4zJ6iWv407jkwYdVq8dmtIf1EA1+8YL+v96Jpu3BhPpgkhwRpPG?=
 =?us-ascii?Q?rDLJMXZuOeTtxNo1WhMy7Rqd9Xt+5kPsQrnQViGJAFDvmrdogNTzgWpzugCp?=
 =?us-ascii?Q?qw+r+tjNAfuT8LAyOQn8dvjn+5qZNw6sP8Guky4vmVSb8MOeWle42zqIcsf9?=
 =?us-ascii?Q?qhzIMe6tARMosHuUtZ/ercNfjTobLQ/mJ0mml6856wHQLX1Kli3yjXuBajdk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd4b1cf-1d0d-474f-649a-08db5315c3b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:54.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05DwoFBIrORTpFRcoJa3QxAjWeVs0K18dXMJaNRYwFprQnWVJ+C4euRaZN1dgUrfRDbqhOaakoMGNAdr0F2vWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: 0jWGXU2_C1MqmE9UyNMYpqFc_iGqKhby
X-Proofpoint-GUID: 0jWGXU2_C1MqmE9UyNMYpqFc_iGqKhby
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the maple tree is inclusive in range, ensure that a range of 1
(min = max) works for searching for a gap in either direction, and make
sure the size is at least 1 but not larger than the delta between min
and max.

This commit also updates the testing.  Unfortunately there isn't a way
to safely update the tests and code without a test failure.

Suggested-by: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c      | 20 +++++++++++++-------
 lib/test_maple_tree.c | 28 +++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 425ad922bb2d6..580310741d892 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5282,7 +5282,10 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	unsigned long *pivots;
 	enum maple_type mt;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas))
@@ -5337,7 +5340,10 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 {
 	struct maple_enode *last = mas->node;
 
-	if (min >= max)
+	if (min > max)
+		return -EINVAL;
+
+	if (size == 0 || max - min < size - 1)
 		return -EINVAL;
 
 	if (mas_is_start(mas)) {
@@ -5373,7 +5379,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 		return -EBUSY;
 
 	/* Trim the upper limit to the max. */
-	if (max <= mas->last)
+	if (max < mas->last)
 		mas->last = max;
 
 	mas->index = mas->last - size + 1;
@@ -6409,7 +6415,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, min);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
@@ -6429,7 +6435,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 retry:
 	mas.offset = 0;
 	mas.index = min;
-	mas.last = max - size;
+	mas.last = max - size + 1;
 	ret = mas_alloc(&mas, entry, size, startp);
 	if (mas_nomem(&mas, gfp))
 		goto retry;
@@ -6445,14 +6451,14 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 {
 	int ret = 0;
 
-	MA_STATE(mas, mt, min, max - size);
+	MA_STATE(mas, mt, min, max - size + 1);
 	if (!mt_is_alloc(mt))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mt_is_reserved(entry)))
 		return -EINVAL;
 
-	if (min >= max)
+	if (min > max)
 		return -EINVAL;
 
 	if (max < size - 1)
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 19b130c9dddea..f167d6ef81591 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -123,7 +123,7 @@ static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
 	unsigned long result = expected + 1;
 	int ret;
 
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
+	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
 			GFP_KERNEL);
 	MT_BUG_ON(mt, ret != eret);
 	if (ret)
@@ -701,7 +701,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x565234AF1 << 12,    /* Max */
+		0x565234AF0 << 12,    /* Max */
 		0x3000,         /* Size */
 		0x565234AEE << 12,  /* max - 3. */
 		0,              /* Return value success. */
@@ -713,14 +713,14 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x7F36D510A << 12,    /* Max */
+		0x7F36D5109 << 12,    /* Max */
 		0x4000,         /* Size */
 		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
 		0,              /* Return value success. */
 
 		/* Ascend test. */
 		0x0,
-		34148798629 << 12,
+		34148798628 << 12,
 		19 << 12,
 		34148797418 << 12,
 		0x0,
@@ -732,6 +732,12 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 		0x0,
 		-EBUSY,
 
+		/* Single space test. */
+		34148798725 << 12,
+		34148798725 << 12,
+		1 << 12,
+		34148798725 << 12,
+		0,
 	};
 
 	int i, range_count = ARRAY_SIZE(range);
@@ -780,9 +786,9 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 	mas_unlock(&mas);
 	for (i = 0; i < req_range_count; i += 5) {
 #if DEBUG_REV_RANGE
-		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
-				req_range[i] >> 12,
-				(req_range[i + 1] >> 12) - 1,
+		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
+				i, req_range[i] >> 12,
+				(req_range[i + 1] >> 12),
 				req_range[i+2] >> 12,
 				req_range[i+3] >> 12);
 #endif
@@ -798,6 +804,7 @@ static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
 
 	mt_set_non_kernel(1);
 	mtree_erase(mt, 34148798727); /* create a deleted range. */
+	mtree_erase(mt, 34148798725);
 	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
 			34148798725, 0, mt);
 
@@ -901,6 +908,13 @@ static noinline void __init check_alloc_range(struct maple_tree *mt)
 		4503599618982063UL << 12,  /* Size */
 		34359052178 << 12,  /* Expected location */
 		-EBUSY,             /* Return failure. */
+
+		/* Test a single entry */
+		34148798648 << 12,		/* Min */
+		34148798648 << 12,		/* Max */
+		4096,			/* Size of 1 */
+		34148798648 << 12,	/* Location is the same as min/max */
+		0,			/* Success */
 	};
 	int i, range_count = ARRAY_SIZE(range);
 	int req_range_count = ARRAY_SIZE(req_range);
-- 
2.39.2

