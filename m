Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78855700E99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjELSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjELSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4DAEB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:00 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4RcO028673;
        Fri, 12 May 2023 18:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TIup8gWjKo1+vsYDiyfSVfHSc1F0eKn/r9YDDUonoiA=;
 b=qFNgT4O/i/K2K7vIxX/1hQIdWXfTIo9XjKE/tzFjSgkE7LuzgxoX6fzfHdXNW4FhbDVp
 j067wCasFrfA+aA5numSuNvbqMmgtlYc0AA3OC9L7lmgzWUgHmRH7b85VCssPWwe1lHF
 2rlq4OZWBBqFJjbjvl6ezvBygjOGDcZBu9Ayrd8ieXudm8rMI/NmHIl3+nUVEkRSsRYR
 0H6AL98JauuuxY2TrKFiBTuBXT7v6BYv+xuo+2w0XjIgnW8G9v4YASmbSoqqPtUN9eH4
 g3QlPRdBM42WGOkgr4KQxIktppFVkHrqviSXdNt82CRhqYH91387692E7Z9gCxLUzOsx SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dkndx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHnCYM011668;
        Fri, 12 May 2023 18:20:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8156y0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkqPi/WmcqRAc2/z+EoCD2A18iVfhaFkAMhDFcjSX1RzRYaTSxfNwQHfIjq88hYhYf9FKMx8/9ShnYfqgGOE83OQWEqVQpdRsyFK34VjHlQcpXBV36yxIIHRCHShc8AE8hfpmIqbx18T5plOIzNUc/hQveWOEeCiJzE8hT4PVhFlvq/p6swmZAyw9HitcTF3lztxQq2Z+qjTo24PWTBhy3vG6zIx1My5KUh5QkTPIQuSV8PioYSvT+N7gaxKpfJTpPXE4hfB3917dMwjaumy2vrQVbOqKZ+2RPKec94U9V0Jh0qPlyb3rW87cuqiQYrSC5+AskxPepV+4ziMyDjJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIup8gWjKo1+vsYDiyfSVfHSc1F0eKn/r9YDDUonoiA=;
 b=esyjWgrgIHW3nd/2VGzr2VYdErreM8zpM8Vkc6sf078bZ70zpWt2PXBkRG7YO8vsH+ohFCURynHLzThQ118xZ3E0VSAac3hVdhasbURmBt88AI5U3faAM3DTe/ER/FMo5Dh/jAjaoixHfJKnwf2u0dPIIVBYxsyqDD9ERIB2ywIwb5IHYRRtlEMCBlrGaPfp/xZoGFgmpSql0ApWubDJRoDMdMJlgFcxmOLMQvAt6Z/vgSNL8j0QJZNZG9g5VAjYtx8XXKkuNjzmbJa/oufhdZ70bKGxSqRMICyPlWrpu/htPTbAY4AGbiCSOUpx3nBiLhayMVZgGmbqkPUVyhwtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIup8gWjKo1+vsYDiyfSVfHSc1F0eKn/r9YDDUonoiA=;
 b=sq6EQ50ppQ/Qnm48oVHMcxH+yN/+3qLRoAuSxqoiVnKHgFTdWJpwLdeb2O9/4v5S0nPO2Bxxy/7E2s7gXqOr8n1bDScHlFjUfRTsXP29SZm5uNkbPFhuGIm8nZrASYWaIXYgQx2hPa4lFfR38uVvuljgUjW28QkIYnrH+wBBTQk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5941.namprd10.prod.outlook.com (2603:10b6:8:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 18:20:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:20:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 00/35] Maple tree mas_{next,prev}_range() and cleanup
Date:   Fri, 12 May 2023 14:20:01 -0400
Message-Id: <20230512182036.359030-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: f7aa72a7-600c-444a-fdff-08db53159d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59a5Gmtx6/Nxt+zNYxnjQm/EbUn9T2Z4104EeaFMJ9bllM0Y2b5Cqp/oX8Eyt41EVHY1/+TGbZhGYrdn1QL9UOjF7HxcHAWv2Af4m++RlcoT60CIwKHoCu9L567vGrZK0obnT2TG6u1fQZAuKPxuVAh/6R5uZ1HpmY+gTMbqtKx+Xto66hCk7eDH5/Yt0wM0p8PbGrAil1EnGCYcCcs685uHS8mHdYEts2gqF4JOrtNRzbqpBqKgM+MNXUn4ebfOrg6bV05v1g6TfxeRNk0HC5HY+kFqErBSb3J9axM+c87QJKnI6gvU/X+CW03vvTfRxu3XsBz6bSMBdZXuUbirUdSkafmzl/7ygYEEOPJfp23eOCiQSh1LYeiq8ngutrooyF6DCJ+nP2ihZQhC95NyIe4SWBMZTzNGTbbfazSQ6POQXDn68PjEpLzNntmhUrg6l8kA7FMAVVlPoh7LcyQJm2ROV1jIu/XWkagQ+KcA+6zv1XjF64Q1lfgojWZpiUMSMSd5dcine8dEN1QoD1VxP0jo8fU5hchGqTtXJOAxokNHA2/gaIqVNDD48pxB9LqTTMKuBw4hh8xGrT7lQS276A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(6916009)(6666004)(5660300002)(316002)(6506007)(1076003)(38100700002)(41300700001)(107886003)(4326008)(66476007)(86362001)(26005)(66946007)(66556008)(6512007)(2906002)(8676002)(8936002)(186003)(966005)(6486002)(36756003)(478600001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uux1+Il/5/a8QNwPZRd6V0kS5Zq/xXKC1VuZruX0QdwuNyMegg0hfC4ZakLR?=
 =?us-ascii?Q?0lrLek1Q+D1GOFIQReVz37MxnFadjL1zLYvx/txWaHZKu+zRQ+SbaFIDSRlV?=
 =?us-ascii?Q?PUwEwmU1dvutLBBOGAkEJWOxZT0LgHyKIYyjf8OLNBCvc01QJh76UT80Lo/F?=
 =?us-ascii?Q?2dhaDv3gqc44fzGPhUCadj0piN5tmbXqzV2xb4c+SEZSbCcrc4Lo4/FloFoc?=
 =?us-ascii?Q?RIBf0vt7nDH/xS57sBGOXDmKa+5QtyGJ7rd5JTa4veZbwpSQeLeXPzxep6wz?=
 =?us-ascii?Q?WmZSOyB2f1/QXn0UjKs3fZK7EOfIuvrpKaU7MngYbMUb9WQyg7xqhAdRJHwz?=
 =?us-ascii?Q?PltOPpIYEzwB3cXgxpLSqET/zKAmRM5TxakVODWkc5uszDAcRiKrKdZm5o5W?=
 =?us-ascii?Q?jnseYtQ864ucDjcOwzrEUwUV+DIb6JCX4eo7IazrqKdyFQZ5hJFWz9mUDcpJ?=
 =?us-ascii?Q?V+6JtgkLecg4f3jkx5sLZJbVlbE5lmdFRfJIswzlrJFOpDnSdrtk4om5uHYA?=
 =?us-ascii?Q?tc8LIngHkjN5ksQOvxXCI2v40WslPzmO1X5c7LFZ5M4s+iSGUMRpBhrpqzEC?=
 =?us-ascii?Q?8ypTfYzChtLqtl/uY8Wlk2+CR6tguyRqWG0dQO7TwWz/ZVzXQcCIta/jb9G0?=
 =?us-ascii?Q?DSd9NHFO/oUWd0v7VAnjzsdiz5QgJwMtFRQow/EQ6biUaph+YAUeQXv5A6nJ?=
 =?us-ascii?Q?rBn/QayJNiqYYEqmn2KrxuWwIRyj4eKKX5Ngvf+LgzE7q2HYYSPhpSza/1fc?=
 =?us-ascii?Q?jfEK3lQAS2vRqXjS/nM7t9qHbhF/He7zb4FQ4uZ8wAzAjXBhsPNX3TQmjUSd?=
 =?us-ascii?Q?rOazVnMbmrayXF3VtteobkNjybRHH0vp3TJ5u2q2+N2/Nrxtx2MNQGF0yVzv?=
 =?us-ascii?Q?SEPFj6Lz2DfRTx028LIl4B9L/jmTxw/jtPohEACKsxRyzQDyMlvoLUwpheSS?=
 =?us-ascii?Q?eCOtBjQE1QSBL3yGlNl163BWsgaalc7u0IUJS4xANaHlwzBAFOoOBkC2UjE6?=
 =?us-ascii?Q?Cmw98pF33llSQjWGBoc540Xc66j2CmviIerrZnR7ubJdgE5q3Ws6bsTB2+zY?=
 =?us-ascii?Q?CnX0RYcqP82mtxRlW8wrfaWm6O3hG+9KXGSTPWx22vY8j9/GG9nlmjLc5uYY?=
 =?us-ascii?Q?9+0zAACoSrs7xCPIcx3KHXgUuCf88EygdE3EejjqczdxvTvl0YQ1lM5BORv9?=
 =?us-ascii?Q?vcL9tqBun30gqEws3IKHPSQQ0mFqP7/u82Ev7Cds2aHb2Rzg+Njaj7A6Tln2?=
 =?us-ascii?Q?teAuVeY0b9D463saNH7/CpNtGS9HCsZOSq93TaVonQGGhfR5LUCYie+5Bll3?=
 =?us-ascii?Q?HRT4rhx58Kb1l45CdAkrLZuVl5Nt7K3mfYs4MqNEz7l432Jh2oyPIyBMJQ9w?=
 =?us-ascii?Q?r8Q2PdlqjiGrgLD/4Xyu5N3t90qPAQEwYC5qrRUNC+q/ACC0NoUkW/FSuah/?=
 =?us-ascii?Q?4A8kBFLgvbdOyfU759n2ZCnIUF3tDmAlanJNMi5/i3JoO8rNGTEcd6SLlnwM?=
 =?us-ascii?Q?BfqARLdKd3umH5aXYXrZSRd2g5G9haz8BvLe907IKz7PtY0Fcqfc6fvJAE+x?=
 =?us-ascii?Q?0Gg5L/l9GhYKPwjsfCX9qU5F4vhikNgG69ZyNiKPoZXsIPBx1WbL7U3tlANM?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0mg/hZ6bB+88vfRZjs+Z8TdSrlhnUn05KEA6W8wzajfvLaymdYjR9ciBmyRBkND54CCeabIV7bt+Z4P7bOZ8huXeKUAWE1zNQvTmezTs7xyGEElbsvpa5RpIhFHso6OFznFmNs8CBmMqDMnUsbQcHhlFBh20RpBnF0FAIFRxxY7WIJvNtC0fLsiOKnLjeE01X31SGvceWl9W0rs9RqPKjwk/jGSbD5VYxkSzR4jOqcRCp1YL7dawZO/z07rQRiGXDoM9q9PkfKZr0EExKvFpiDXmnJaZxdZDoqe1AJMYAD1Qp8aLyR/9R5XjhokH37jCmH1t31tdpA4qhnpBMJhq5z9aGLJfdYda7F/AXjNEiONaM25f0GeOUtQ60RbbixX06gMEuHkQ2I6NdpU6xblR2EERE32CsGTdYhDUus8uNJmK1X6Q4/c1T8afBGjwgmmdVWzXLuj0h/4UQGNBQUctBtOowqJzpgozn/07Sp5viJrA4GYsx/iuEwXqvkHRc+UXH2HoE0eHllOi76+wyPwbbBvgshQxBkjlnladtizPLxxHgK3S9YPkGNAru1l1eqGJAKg8XV5oniXzRo4V/R39AksnJwweK4FBg5KTQL7WXIMef50oVf466hmk4e3XL8FxbL74H7SIRrilANOxmJ207Qfuj2nk6g4qxJtzMIwivHOpOj4pihcB2LU8/9ADoEploZ0oL9WCojw/ufJiuWI2IY7rCmbdB0bh6Zvoa9ij+tx06A0hx0vzqEkmQtQUQFvUVLy0j0pGDV//NpqzGs1VoJqbIaQyn2EQ7FoRueVxSjoQrPMtAKsECMr25AKzH+6nQ9A1o3N9ilVnXhcoLGOGWjwNvguSEvPjP/U5KTlzpZM/dfMcJoIHGBW7FX0LQBX677nJTIWgIy8cny94TxfnxA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aa72a7-600c-444a-fdff-08db53159d18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:20:49.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoOH5fPHZ5WaKpY1Ve+wTZdq/odOMmPOnOmeHx35QzLGN2jTjQgdM4s8ZrbbDc/wMXulQNcUZVP1Fi/STDdWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: zckAPQKl0h-lS0gAsyhzvHkIGtpoFNbJ
X-Proofpoint-GUID: zckAPQKl0h-lS0gAsyhzvHkIGtpoFNbJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains a number of clean ups to the code to make it
more usable (next/prev range), the addition of debug output formatting,
the addition of printing the maple state information in the
WARN_ON/BUG_ON code.

There is also work done here to keep nodes active during iterations to
reduce the necessity of re-walking the tree.

Finally, there is a new interface added to move to the next or previous
range in the tree, even if it is empty.

The organisation of the patches is as follows:

0001-0004 - Small clean ups
0005-0018 - Additional debug options and WARN_ON/BUG_ON changes
0019      - Test module __init and __exit addition
0020-0021 - More functional clean ups
0022-0026 - Changes to keep nodes active
0027-0034 - Add new mas_{prev,next}_range()
0035      - Use new mas_{prev,next}_range() in mmap_region()

Changes since v2:
 - Squashed patch to fix test code into 0025
 - Put all pr_warn() on a single line - Thanks Sergey Senozhatsky
 - Fixed export of mas_prev_range() - Thanks Vernon Yang
 - Added arguments to function comments - Thanks test robot <lkp@intel.com>
 - Set mas_next_slot/mas_prev_slot static - Thanks test robot <lkp@intel.com>
 - Added mas_find_range_rev() definition - Thanks test robot <lkp@intel.com>
 - Fixed mas_is_ptr() issue in mas_walk() - Thanks Peng Zhang
 - Fixed comments for mas_find_rev_setup()

v1: https://lore.kernel.org/linux-mm/20230425140955.3834476-1-Liam.Howlett@oracle.com/ 
v2: https://lore.kernel.org/linux-mm/20230505174204.2665599-1-Liam.Howlett@oracle.com/

Liam R. Howlett (35):
  maple_tree: Fix static analyser cppcheck issue
  maple_tree: Clean up mas_parent_enum() and rename to mas_parent_type()
  maple_tree: Avoid unnecessary ascending
  maple_tree: Clean up mas_dfs_postorder()
  maple_tree: Add format option to mt_dump()
  maple_tree: Add debug BUG_ON and WARN_ON variants
  maple_tree: Convert BUG_ON() to MT_BUG_ON()
  maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
  maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
  maple_tree: Use MAS_BUG_ON() when setting a leaf node as a parent
  maple_tree: Use MAS_BUG_ON() in mas_set_height()
  maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
  maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
  maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
  maple_tree: Return error on mte_pivots() out of range
  maple_tree: Make test code work without debug enabled
  mm: Update validate_mm() to use vma iterator
  mm: Update vma_iter_store() to use MAS_WARN_ON()
  maple_tree: Add __init and __exit to test module
  maple_tree: Remove unnecessary check from mas_destroy()
  maple_tree: mas_start() reset depth on dead node
  mm/mmap: Change do_vmi_align_munmap() for maple tree iterator changes
  maple_tree: Try harder to keep active node after mas_next()
  maple_tree: Try harder to keep active node with mas_prev()
  maple_tree: Revise limit checks in mas_empty_area{_rev}()
  maple_tree: Fix testing mas_empty_area()
  maple_tree: Introduce mas_next_slot() interface
  maple_tree: Add mas_next_range() and mas_find_range() interfaces
  maple_tree: Relocate mas_rewalk() and mas_rewalk_if_dead()
  maple_tree: Introduce mas_prev_slot() interface
  maple_tree: Add mas_prev_range() and mas_find_range_rev interface
  maple_tree: Clear up index and last setting in single entry tree
  maple_tree: Update testing code for mas_{next,prev,walk}
  mm: Add vma_iter_{next,prev}_range() to vma iterator
  mm: Avoid rewalk in mmap_region

 include/linux/maple_tree.h            |  130 ++-
 include/linux/mm.h                    |   13 +
 include/linux/mmdebug.h               |   14 +
 lib/Kconfig.debug                     |   10 +-
 lib/maple_tree.c                      | 1181 ++++++++++++++-----------
 lib/test_maple_tree.c                 |  863 +++++++++++++++---
 mm/debug.c                            |    9 +
 mm/internal.h                         |   20 +-
 mm/mmap.c                             |  111 ++-
 tools/testing/radix-tree/linux/init.h |    1 +
 tools/testing/radix-tree/maple.c      |  164 ++--
 11 files changed, 1761 insertions(+), 755 deletions(-)

-- 
2.39.2

