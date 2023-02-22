Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4069F44E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjBVMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjBVMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:17:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5FD38B66;
        Wed, 22 Feb 2023 04:16:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x6uM003985;
        Wed, 22 Feb 2023 12:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=x9g4tZ39cl6GFy6mNclSlBENXi13yBQXWOhSA6D10p8=;
 b=qbZ+IIKCzpeAu2w45EOYtN9y556GKyjzOM6Hlk4W2ttseotT3vbVOLLnDXkKlFIB587J
 2DPGz67dXxeaW4ImmKxd2QEVePtIRlGOEeui4pSIZf0RrrhXgo4Fmz3aEZcV94zgpCJM
 eXWBLhElFpc4pgVMjLMV16rRPxadnMzMoVZaMSXIpbB7Cy8cBGygl5bJ9eE04AniyA4/
 v1djSBE6SbAkldd+hX5k4876/dQDZP4SHI1iomZcsbRRVe8LO4cDC9cfZOTC1j3PqZE7
 qZWfZir8O4941JOJ+sa/KoOidLn/mA6wgKIni+AikMt+6hC033+80buUaauLMcvFEzOj Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tqqyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M9rASW040816;
        Wed, 22 Feb 2023 12:15:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fvpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6u9NgeoXsb1HMudILzv6XJNHpxRPVx1QTvbaLZa0wjOoz2+HKacFTEuobZ8MaKgpn2eNUYGl0Tdks8uUZhHi19kbE59VU8IS5iPdBSoB5ju0gilJ0RpXDWKl4qjzBg2dXfbrelBLD0rx0roP/HOjBWd5LTDJHYosPEI/ZvceYXwdtkqy1ZKRdXIAMaiFO0Lrym5vVjQyJPk7quMRlux2ZZOK477S5VNpyHVDEMMgYGKRQ2Lt9vgtZK82w4RWkyNrd2u8mnEHmD6OEq2BiejBwIX+ROBJgbENc+oBgMTXCZxrtTIx4ntrS58ByPvYggUsmzRJT9ZCHdiR6qiBGQM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9g4tZ39cl6GFy6mNclSlBENXi13yBQXWOhSA6D10p8=;
 b=PQ+zyU+zVgBhYt5XLQC7YkuQpyNmhfkCn+lRjVGs2MFO8a75kg5J1kXDqP83Rqde6ZbieimUlgxJZ45sndBDJCo1+GpOcdKbwp0rd7Q1xSkr2qYTtENByoRexpZvlBeCvKEdAn9lVlhZIB7016g+zUrzuyD8K0xzZCh+7SxwZ5SLOEAVoAxjakCwdCQyO2ofQ2tSfFG+wdlVZS4aZXAJiPZAyZXYjZDLIqadTB0hqP1WKwHvYA1+1JKCfPKqbDVB2wGRgPwJMI7r/QbtVNgojhLricRzTYt3qyPVSWXenqH5hxqL3dWRskp28q3LRFwR8RUsaMEWGVPK4EdZxhe0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9g4tZ39cl6GFy6mNclSlBENXi13yBQXWOhSA6D10p8=;
 b=LTIas7mZ9jkT2sEWRySTTXdEZiBU40XmPJS/817XdAAsBWnHVKOqIAVuCwKsdqhl9m4gCoHR0oGOhuyBtg/8848gSQNcbjlVRF56l/x6HMlncDsodhGnGgO5PQpNcjUCBuAILwCkXqEEGnOz9/9k+dLBtF0rVdl1bws0rLh/CHk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:15:51 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:50 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 10/27] kbuild, clocksource: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:36 +0000
Message-Id: <20230222121453.91915-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0470.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: eb171a6a-726e-4fdc-292c-08db14ce898c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDrrR3mEm2Rl5vsEM00v6RKZ+VM/q22ON+8bQe/3BfdQxW3npgXe5u7BjqzEo0gvAHVaCQz7QK1g0qh9hDA+o9lIs4MW18t9fP4qGmwP5G9phPrcQ2MToG4kosdJzNqAaEXtjOKr68Z7vV4jJqbU6f3acAkQ08iy+U5zuEtj4eas7lQd/tb6EeWRHBNIZI4Mex5iuYaR0UxZFApOLTyQp76+hnPuaB8PVZy7tQnFDLq4uV9JYzhYoY87gS5zemLFvbsHHLjSk27iPpUB5TVchWwmi6lbo0nzBnLQVuoHz6ChgwsgxKzzkr9cyu+wCE+zfDIlZd2N+jAmeYN9ExKgmHAC1OwbC6tSeHMu3GhrQoc0nJeVKwpABHsWqO0LdTW79QEUZEXS6wzO11k6/nrKZ2QC02AEM/BC84eeeimECjUXEtR5KTHOTttXkvawGjTqGY4kJ/PHUMwVhbCC32iM/Nwt5W9JD11C9OBhLN3AXu2givrNgDX8jof54BmTB/A1xbfxPkpNDl76KxS9ovaedFqrCJPmwP21wis5OGlcjEKXqJ3ck5jj2GAN7c887ivdL3r3kV3X0Fjuy5iZzvbxMS0+FLCgmrkZ9mIs9B0tlSn00zSfqX6FMZXxUF4l6JuiiJx8gbkUDHcg3AmjAqC4bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duqOjtseKcd8m6EtK7ZRKebf3DhG9qEEWMViTnWgKWPfpyFd2dZrX/GfHM+c?=
 =?us-ascii?Q?yiI1ETTgzK+6Tv622efKkry3v9pvwTVZZM/slEvGJhGb28yMK0vMhBfOGbz1?=
 =?us-ascii?Q?67a2odzX6oIc6CEggIXKkQDjnfVULN0BJ4yRxgkMHsYbOu4YLATZIl3n7RQi?=
 =?us-ascii?Q?CHlu940hEfu/Cf7C78YqBlGfs8Xwy0WCvqbWq6/xWonVEpX5l1ru6b3xq+t7?=
 =?us-ascii?Q?On5gYMujZE4Xt3lN2j6480jESnIaNV+Qj1XYRsd9bqAXbfrU5L9XWelc27NY?=
 =?us-ascii?Q?oLd5TaJe/v8gBz5qd+yrTkgGjE2PggsCKP4Jy8tZasnBsyMVoP5ZMjdfC1g8?=
 =?us-ascii?Q?6cKthxsWZlPp4QQaxCrRpgx9ivNhjvKdeViSd55WXnES91ZrReDAZTH60Kml?=
 =?us-ascii?Q?eH3DgvlrvVh+Ph7YW+askVHs4gH4WPfT8IRJ2Cy4EurWvCtiuDbAvAVEDbQo?=
 =?us-ascii?Q?59UHK+vZYTUUB2UjiUkY12rpodYqbgUOZPVzuCTkSlvKTBi+ILj6op2dfc73?=
 =?us-ascii?Q?RK0bB9uC4ZMadz+tgJ+Y0yBqPjSlsEp3LkaKlYt9cUJWRpu1gMRpjjynpz/r?=
 =?us-ascii?Q?QuR7tPTbZyqhAZ8F2s8Fr6h5eLXzEMaNT6Sa1/gKZ5o7bq9mlg4TCHv4xCTd?=
 =?us-ascii?Q?0nHFgSKY+FOw/lw0wVcYa++JrWwYYT9bRWtRetdnf/Do9dxYR14zgdCPcjSX?=
 =?us-ascii?Q?NTwGHAM8qWwiuLPbh6Hk0nRjua5xMu80wci0gJILKah0y8kcdio03Gm2pdg0?=
 =?us-ascii?Q?4/CMzA5XAwXgT8FF0sQrfYWYnTMBPcB54LYh3kCwa15lTzzbLrw3UXH89Z73?=
 =?us-ascii?Q?P9pKHFyZ8CmG7zqo2DlBT4E4wk2gyEYW1f83SqD+y2vGQiZds4dMmnWzI+qR?=
 =?us-ascii?Q?jjgLGKLMlHQ4qxKkV8v04aH0XpyJOIqmGLQ9Su6SUy2wMVGHZV7aV6rfYVLr?=
 =?us-ascii?Q?i8nLBltzUoC501j4m1z7Yi3R8YoxCWH1Ut6sYXLYRtcyBPPrTDyUBYN3HBRQ?=
 =?us-ascii?Q?K2AZHqmicTNRzZVVoQKc8RpR2nV2WK5MBhvCTyaXnFQ+OE6z2NY7OlpiKAvG?=
 =?us-ascii?Q?CgjGiUIiTSsixBm0jhu+JuD6Lrk4hH+Fc8Hsd/CTTszrS/Laf4EqsOq/RPqF?=
 =?us-ascii?Q?0hGvB2NV69TBzf7/FukFOcQJd7FIkp+4YWtR+aQJRFFXJzcS/400wZoorZJC?=
 =?us-ascii?Q?SVo42+Upg4ZmkVYshoiYI396kWXIRef8kA91dOjt2U5aWDfgN8Fvff9M6yW8?=
 =?us-ascii?Q?CR5GXRoSUIBZqCvR2ndJiHagzz1ZKh3X/hmKyKiXJxSki22UfqF0qanFajqj?=
 =?us-ascii?Q?F1HM07CBfI8bQKf+cwPapvIbK3q1/WWUOhYFCp61H6iu/DdXxHK+qwmZrmo/?=
 =?us-ascii?Q?NybTWks9uWQQhBOuYmOSIj5yQCT9NN+Z2J+pr6X5sWivLcbNbg2HirJ/qpSV?=
 =?us-ascii?Q?NURt0UqoBFrfw5HBt0xxQ58nr6WCKr+1DEaV6hA9AtWzLZHSNFl9oyrAOh8v?=
 =?us-ascii?Q?HhFcc6bw9QhzJnIucEYxd++dA7NIFEZiDLOcQItINCmPpGPNxg82lGh2LEYZ?=
 =?us-ascii?Q?lqKa87ymwRIOioTF9gO5AtkBRwQtAwvybuDr04vVXh/Dc/WUwqjVTDjmy4CH?=
 =?us-ascii?Q?njKIjWkmE7sKboCNBoo7l+k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ce6+5uSew4zbGlKEA9EhzF7t7obP42idz8f8NRZuzPiYPZAxUEVugXuO2dtCKeZHBV4RvzLVTNPCQrcTMPHmdzgGhOGTSkqSVtZT5hvJrEmyjfFC1eBr5g1gHjVgrR7+9cKywFiQqD2lGGrzLerZsdvviV30rzdo+X6gF+7cgd59UNixnsjrnVAPy7BGXVdxsezyFMRcJna9O1V1taIq5W+wGsTIE2Akx40XJTzFfpFHuv8WeF3P6C0yCQ+4f6FH4w3vF5pHWhJD/ZTR58JTqRfWnLQ6n8TsharYmS74cVezMG9BjsdhyRwqaczoQpBUS9KvTGAjBfo+fdCJAKyPHvFb7N5DQiKRWQdhXmErxZHtEi/C06+/RnecKNW+FIX0BHQQJQzBbMkhLIZGzo52Mo+bHOhc3qrDPtdRBOz9VgaKVjVudw6T/6JWosxvGTBNfI2Pgb9OYDS5oaYzE7IXTcsfK1zgtMxxaxmvpY9oBYrV7U1p/fk3OIsQ+RV3nIUd/tyLaUr2xRw1FHkTU7D+XZsJKn8L6B/9oAcHrfxoSeuswLhD84DFTiVJHTqaMa3/LkkTnj1T+y0Ow57H2jbqt/H23bVqj2PIhFEV2WqgcSM1u2V9LAypoWk69kt8jnQ7ccJl+3aG8cYxT6SkVn5OO+gy5TGG2vTl2iUGhGcb1aH0ctAXLqINMbufp/AsAfsKVk9cm58W+s/KixU+9bDNPhv9xnP3siNwHtSfPdkvKSuLKqHTw/Jty2mtnpulWxFLe63/n7B4ShMK1VHGyaUhoXVL9R+fq6FD2ue9gcsmpZ5Xe6tnhKIwBToVJrQ6AmL+fli9PcNwUf4Huh7OyYaC6Z+MNRJnt4KXReVRW/Y86vbHbjWuXbz7Vh6OWr2jmPRoDZi3Jp/Zq2j7M/wKS0JMPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb171a6a-726e-4fdc-292c-08db14ce898c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:50.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH02kARxtBm7ldunHrkYaGw6NqIpihwZ1YK/P2AHeWCn9kkcJHPi2SItfyJnk48HAiG3BeC9W+J4cElORlj7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: KF7kFIyct6sBE7x31_736KwnDc0enrze
X-Proofpoint-ORIG-GUID: KF7kFIyct6sBE7x31_736KwnDc0enrze
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/em_sti.c      | 1 -
 drivers/clocksource/sh_cmt.c      | 1 -
 drivers/clocksource/sh_mtu2.c     | 1 -
 drivers/clocksource/sh_tmu.c      | 1 -
 drivers/clocksource/timer-ti-dm.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index ab190dffb1ed..728bfca11d65 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -368,4 +368,3 @@ module_exit(em_sti_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("Renesas Emma Mobile STI Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 7b952aa52c0b..81a9f35d5744 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1179,4 +1179,3 @@ module_exit(sh_cmt_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("SuperH CMT Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 169a1fccc497..dd19553ef0b9 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -530,4 +530,3 @@ module_exit(sh_mtu2_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("SuperH MTU2 Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index b00dec0655cb..0641b5bca75b 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -679,4 +679,3 @@ module_exit(sh_tmu_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("SuperH TMU Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b24b903a8822..1eb39834bad4 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1283,5 +1283,4 @@ static struct platform_driver omap_dm_timer_driver = {
 module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Texas Instruments Inc");
-- 
2.39.1.268.g9de2f9a303

