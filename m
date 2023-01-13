Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80666A62C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjAMWqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjAMWqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:46:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64A7D9C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:46:50 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DK47gf017334;
        Fri, 13 Jan 2023 22:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8LXZYJ3IF5YwIJs7/2QVzJbgQ0tay2z86vhYBUXlFls=;
 b=cymAnCJ0l5okh3YPHT1RkPIRHOwWDAIU8AjWERzlrPJSsu3HjQ3CthmR0hF1mQiKpTJo
 ztP1wxs+iB8u2/S5RvchhWC43tbW0gBzuxnyh+3MhnzjMWlqIeuBcV/tdOwNJvHM11mN
 ER7lkIvfQR+AGUJgi7ys/pa6DtHFHM02oUc4Y9JMeYJGA+tLGsag4ZvNiWPxzNYpOj/4
 TXYR9IMPW2pQaLafS67S/dsLjwSgF+FDbqik6uHSWtAjgpJYR0LP3pDmi5zOj0UHhgKz
 Eg3pcmXrIvkiMqNgE3AhmsO8CENs+OQ9AvxGp2wIANNT+rZ3x7YYGVKxH6CkNMFz01L0 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3dxhrakw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:46:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DLRUnj004403;
        Fri, 13 Jan 2023 22:31:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3f7usqt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3uCTLA4abyH2sk9K35xHo9IIcjUCK9YRr7TzgpZMGnoiATaZ/+FNVJlASE4rssoojkR0ut+fBlkLEatY4+ihehwnLkKow4xfidbR7hZhWnwUQ584Zz9AvXxKbACJpicrNRampd9viQ6Pwxx41ETzpRXjP+pStyS8oe+lB4Ow9hxElksXI5XYJBxVMfhQO+LeG0mb2wGkz5hzhZS5yvr2v0NAvJXP3npzfJ671+ZNrt/0lU1KRNUzRhvXJefPSwNApARdvtgKlxgLWw8pH5trnDomS9rZPRPySdzjzghNIFjVe3XrLSc9gRLZFPs5R9zBXT26+4D21xcYVi1j9gMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LXZYJ3IF5YwIJs7/2QVzJbgQ0tay2z86vhYBUXlFls=;
 b=OC8mLe8og8X7fRU9TQYzwyTOMW3oosey0g9PL/2LXeUaHODsM9h4oZcBkBKBgM0/btxiSZ77uAPLGgdP02QZsWEEJp/cMCcGxpySLLYn7j9ouEsBcCOWkIBqPitvJ1G/gFqaLj7/BdOaSDr6AO9Tq+CQjmMrrjOaOotVgdqJNEFlUcY28kebUttxV9cJ4mpMH8Yza67aPPGIY2IUaTZIJ/p/DqmgkCclBkIFDciYwibogkQvtr1/D5StZlGzTgYKLNgQzh25yzQWLtgb/B1txJb5uZAzXgF8zXiliOi1xmJgknRO2nqb+A1EziQs75SCZPaQTSAblg2mmQrF1Gyimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LXZYJ3IF5YwIJs7/2QVzJbgQ0tay2z86vhYBUXlFls=;
 b=uqKY72DzuOKJ1JkbcI+Z2oowO4Qbj1kY18tGHmJaMWdXJnFHYBkYf8etKoJtVFz1NTr+J55b2z9/39kvZxEHJ8zsw+IcC4ML6iFLbJYIad6FcqJ2VjL9URxGEnRj7r1TR38Fgh8aXIYukTWe2f9oOc4zeAChK8k0v8SbZFgIfgo=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:09 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:09 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 4/8] mm/hugetlb: convert alloc_surplus_huge_page() to folios
Date:   Fri, 13 Jan 2023 16:30:53 -0600
Message-Id: <20230113223057.173292-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:610:58::18) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: e58823e5-24f7-4fce-f206-08daf5b5de11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTvO80LArocnoz29rMdmL3a/tMD4DPxDHUI1vZkk+vJNVTARnnjHBoLVNtqatFjL8FanrL7niPfdgeSQjr33asiGecWfNmmrRsp8ZozmoEa5LKEoUcfVwKnIh8izeLLNH81NzXXSyJ3Kg0hUk8PWw7hrUtMsdINoRyTo2U/C+vwOHEUsRikW9rjCxmwUD3dgdcN77lBmflu75N4O9EFpGeJZTCnPIbSPwvVSteb1gpXzitBC5iIV4eJ2Y5VviuqyUV0WThgeK5+SGZ70KZ2UPOPmJsMkohI/lj/YFX75rSlb/n8HpJzGMqiJXn6CMEvMMah52adtF0PgVKACaFbbZ6vFKSk0Fz8jP/NmXm8ZcbLi9sSnYJXHAxydnpiWizzul8jgre5DSSNvrR5ov8YGyozhEflpYfO9Hhav948I/o+3otH5/QXgRw2Jsdp8FKx3aSr7+cwZoIgmXmriJF6zM/g3CZ/k4gjNMpcCsdl0Qq+el4eiTF+I+RSiaVxxuWrriuS3kRMYcSwbRKR+9Hf7Knl4Ftvk/HnZdNAdDcgcfK+P0Uzxo84RiEelUwh0ii5YvnBtMtMETMd3ufFvVX/dSiLmsSQS5VGkyAQ7HMqrY8sjRl6AuxQTYG3HjjM3igK3UfxuhBzkq4can/bqziGr+1mQqNdlBUlL3Ue0KCP0FWP0APR/4AKskiOtwLxAtPff
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cg6t8hDArrPyPIYL1FbJc0yc8hMbE8cTOxJQRVjPDQdMBo8COQKP6WXH+vn2?=
 =?us-ascii?Q?FZwN2BkQXdxLQ9oHhbov/eU50uGkpkVTLakZ1mhyEdEqA7rF6EgW22VvXmoy?=
 =?us-ascii?Q?hErsQVMPMh2UM/lUJNWsDQObSpsVF4l2C1qJf7x1fesVLn3RXFt1omfMcX/b?=
 =?us-ascii?Q?nLDLfp7zAisCJFRTx5hTW3U9CLb92NVsrOa7lqx1q6mUAloQvOXtV+nyuwR/?=
 =?us-ascii?Q?Y7BRjrDSPNb6abQe5HuL7Y1Iz6qqcd4DIGxB4PsQXd1cBLBCxv0RZJZWDX31?=
 =?us-ascii?Q?oiNMgQKOCqGgVzFTaYLHyajahKRbHY+VBtWAp7KASPSCOl4GwEgCGSbIS/Pj?=
 =?us-ascii?Q?MaklQvM9LVK9QEg7/qIiKup5aQTwIl01TJ7cAInoacCvRCzL8aJXtP+VJ/xe?=
 =?us-ascii?Q?drTODqY0zLCdYZLXFv/ot9kVv7CSzm+g5m7hxXUiyD9S00LmIOmnz070zrYW?=
 =?us-ascii?Q?9qECObHysNWA9ovbKR6Nuy3sShxdraopAInI74/HXnCpk+v63r7IKx3RUD/3?=
 =?us-ascii?Q?D9pYDuhE+1rovlqqep7x6eHWPOXT7PztOrsOpmqbV1CF9XQIDQLcv7LKExmb?=
 =?us-ascii?Q?opgooiaoyAaOM5sdExOH8MxQ2+xbUdSWP4HKjIXutyOWDoQuYR+OQM0kINRq?=
 =?us-ascii?Q?cgwI1TiT6nuT8BQWMLMEcuFOc2BPgFMflkMg/h8BRI1G0dbsmXhBPHRVPkgk?=
 =?us-ascii?Q?vZqlm52yAyc4CNgYjMfHPJgLkeeobqd42pzVDBCU06T2DeEOl68QSjkTZaiX?=
 =?us-ascii?Q?V5Qrd74tuXDJ3qjHoI5WiZq80+MlXHQQzh7gKBQnuFpBFI5eJMWrO2Y4lQf3?=
 =?us-ascii?Q?SBTNQ8QuW2TvPgjV3z2u2FUS+N3uioueLTHuaF26waHp/7DY/kP/flRMc4jg?=
 =?us-ascii?Q?8uGmDYGwxTIi5ZlCwNFHobijz96NKEySzhKp6u199OfbkKhNrarxhTUBuwP2?=
 =?us-ascii?Q?VE2xkpqF8TpJJJApEDDLVPLiq6J1Yafwbx5ciNxBk/mOVVkBoT/Gt4fnnrgU?=
 =?us-ascii?Q?CfjEY6mcbb3RJU2/DndCEKqRq63tEQNIOpLB2eamUEY8sfgL+mQk44s+H1zt?=
 =?us-ascii?Q?hvvMmS5Ss4CxE42D+BrbnzReI4sFmj4p0DaEprW1Rshe0TTCAbuyYD3z2ron?=
 =?us-ascii?Q?kHUyww59tABDpI4sQvXvtAvZNo/fb/D5nCmlKdu42jQ37EZ47ut+uIG1RAk2?=
 =?us-ascii?Q?zsJG2pu4ayhzHaM2Lpcn64A2AAlGjxYZJ5O3HgOel9+MMXR9xA+8MWeKPIB3?=
 =?us-ascii?Q?CdPfZ0bBhwwpDx7hHfBYgZXNfw2ACV1cUNZcpPWOJFRl3gQlNoL56rY67Q4i?=
 =?us-ascii?Q?YPbkcHdzoXO8LvAO0yYap3JMR5pVxfhNKTwfzOjfFw/yda3pj1lkR7was7EQ?=
 =?us-ascii?Q?Y3sag52Lo5du5quhw9yTZhPToZOuexv7oLh+V8qvnRZO59pplKoh07q/01K2?=
 =?us-ascii?Q?x1RlSnaFVj/R2p/e3P//dKz6SHZuDJPjNgbBgqT35qqvezrbjcQ+Zbz8hePi?=
 =?us-ascii?Q?zwoBYzxL6eplr04lw6gDPLgo9Us9s73Rtn2wXrnE+dLaYMBgl0EEwMej4KxO?=
 =?us-ascii?Q?OXoYKTHcY+zzbYoQdzc1I5jw7/0vxUXr/gWSIm+XPMuWO2oxYYT0iB8XTX1m?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9q8AaoO3UZzcM5wqdUiGkOtIlI3JG43R0IDtHrBRr79xF3757Fegjl7L1ky6?=
 =?us-ascii?Q?6bnCwgLV+rr0rGfB2u/ymTr61Ekz5IVaFpW3RcoCqutApXcuNMOVoul4ttKA?=
 =?us-ascii?Q?QXZfwTBfz2Mq6acxsH6Yy4icK2yx8u80CF2wwU+2FXTAiILH/3NjbjHMTaJ8?=
 =?us-ascii?Q?vT/6HEVBzloH5YrNUFdb7UMVWB1HRzkJ8mKnDmhzl1l71A3wVRvF/G12qQMX?=
 =?us-ascii?Q?sCzWBoZgkwWnKWZNDZXm5pRuymCXJoYB+VSgA80M8eyqbaXrDqdSFZUMpKgE?=
 =?us-ascii?Q?sDP3aceO/Lb0fHmfoKFzD75Ic1+vt9QkOL8VVuUZ5w41xy5MalC0EhCD/n7p?=
 =?us-ascii?Q?Z19IsOHBNtUriL5hf3M1YZ97B2wGc2ElBBxtFWaivs4Z2140jaorh2ruoJGm?=
 =?us-ascii?Q?Ioc7+ajRWawuCeQyKE8ZrN7vOeMVpA/lv8Li0Euh4BBa2pWcYJ+Fm1ewtRXa?=
 =?us-ascii?Q?Kpm3qYlcFt+uukdLhtQOzmMRtGZrVF6L8cwIT2VpgmbPsX3qf4i3pjRhzjzL?=
 =?us-ascii?Q?/qXAD7Y6UTK876t7jrOtVegFnPPUlTmfLr351Z2R0iBn6MDRbKg1EJJp99De?=
 =?us-ascii?Q?kKLPvpLf/qNVQTeM8Yga69CUjvWmOsRsme6B3qUY1K1MaxZeQivFFb0uALqn?=
 =?us-ascii?Q?imQMa0pTgzpQ2AxAIYaN8G6CgyrBXC+ZyI4674Wg6xepx5C1MjbEWdPQm03C?=
 =?us-ascii?Q?NTdsk1YgYph0WtQFneBT8JmaLjniiN65nZ5yFu3dWfL2MSL4Sp6pDfisFN3s?=
 =?us-ascii?Q?xrsOeEJdYKZ0F/HXRkEznw3Qq7zH1bQhFZtacQkV6OnbcjSyiMK7ogsIvtPc?=
 =?us-ascii?Q?o77ULQOwSIYO57dtF4d1P1Qq4TunzNk4O8I0ibgsoN6K98Qt7si9qlBVJrp+?=
 =?us-ascii?Q?KHigc11HghvWTaOdOAnuZURJsPF7iKCHT9BEtfVTkrAIkP8fMeI8OHGEv3UO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58823e5-24f7-4fce-f206-08daf5b5de11
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:09.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBOg0Ugfg73IHrAXgbeVylyIuV9UJFDx6J+LHP4FJ8XKqFqk9GTj2A4lzLzsCsI+OOvLxaXwXXw1E2/kr5lKvqdoHErElBAno63Rm9Cl/aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-GUID: NdggC7Npj6So1PRF5CqSQuW-W_2iMWe7
X-Proofpoint-ORIG-GUID: NdggC7Npj6So1PRF5CqSQuW-W_2iMWe7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_surplus_huge_page() to alloc_surplus_hugetlb_folio() and
update its callers.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c206a8c1ddb6..62552172683a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2234,8 +2234,8 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * Allocates a fresh surplus page from the page allocator.
  */
-static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-						int nid, nodemask_t *nmask)
+static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
 {
 	struct folio *folio = NULL;
 
@@ -2272,7 +2272,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 out_unlock:
 	spin_unlock_irq(&hugetlb_lock);
 
-	return &folio->page;
+	return folio;
 }
 
 static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
@@ -2305,7 +2305,7 @@ static
 struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 	int nid;
@@ -2316,16 +2316,16 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
-	if (!page)
-		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (!folio)
+		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
-	return page;
+	return &folio->page;
 }
 
 /* page migration callback function */
@@ -2374,6 +2374,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	__must_hold(&hugetlb_lock)
 {
 	LIST_HEAD(surplus_list);
+	struct folio *folio;
 	struct page *page, *tmp;
 	int ret;
 	long i;
@@ -2393,13 +2394,13 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 retry:
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
-		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
+		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
 				NUMA_NO_NODE, NULL);
-		if (!page) {
+		if (!folio) {
 			alloc_ok = false;
 			break;
 		}
-		list_add(&page->lru, &surplus_list);
+		list_add(&folio->lru, &surplus_list);
 		cond_resched();
 	}
 	allocated += i;
@@ -3352,7 +3353,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * First take pages out of surplus state.  Then make up the
 	 * remaining difference by allocating fresh huge pages.
 	 *
-	 * We might race with alloc_surplus_huge_page() here and be unable
+	 * We might race with alloc_surplus_hugetlb_folio() here and be unable
 	 * to convert a surplus huge page to a normal huge page. That is
 	 * not critical, though, it just means the overall size of the
 	 * pool might be one hugepage larger than it needs to be, but
@@ -3395,7 +3396,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * By placing pages into the surplus state independent of the
 	 * overcommit value, we are allowing the surplus pool size to
 	 * exceed overcommit. There are few sane options here. Since
-	 * alloc_surplus_huge_page() is checking the global counter,
+	 * alloc_surplus_hugetlb_folio() is checking the global counter,
 	 * though, we'll note that we're not allowed to exceed surplus
 	 * and won't grow the pool anywhere else. Not until one of the
 	 * sysctls are changed, or the surplus pages go out of use.
-- 
2.39.0

