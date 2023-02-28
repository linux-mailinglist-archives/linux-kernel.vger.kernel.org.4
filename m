Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4C6A59BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjB1NDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjB1NDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:03:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0736E9C;
        Tue, 28 Feb 2023 05:02:55 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6P2ii018687;
        Tue, 28 Feb 2023 13:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9HercEzMIm8FoOqFRLPzepdxtCz7dyCg49LqSqCSdxk=;
 b=tDvIrTpGTXFpWBF0Zt+HWt5/WEhKv9J4BWhJVGIujTd3H8AhZT7oDY0B4DsTBu9BISnA
 Ek95iMGUFXDMi0eWgXOVSJ8Nv3XOwdWpXGC+IMNz7N34HMct7vZnte+EXjprLp1JUh1A
 +Hz8fUoTvBC/EMGh+9YSNKP1e3ULbNa2t8i45pT3d2XS/CPlSV8cNB+cMmv2pa2tCYCk
 HJObcaVdLQUEqJfWMzXiouetisH46NYSF10ma1zrJH9yS/nphEN+61dHYX7p1tj3MpNq
 gaULc0LIksZz8pbQjq1KrxupXZKLsYoTfccj4eht7vbYMfQ++tROAlGLeqVogU1jwGZd 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7e1qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SAo7cE013160;
        Tue, 28 Feb 2023 13:02:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6r8gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtBZ1ZhGSPKdEVZQCX0g6DWpUbGGL5ZK8rBJQ0yHV00G17VDIDV1kKq7/FGjnVeDVIGpXe2kiCzWxTjfnu+GMyi7rZoeyj7AZPs7d3JjW0kf417hydu/EGCnJk2y+XW9H105g75/hvJCOuyycsvRe0cQGZABNYw9IXM4vi4fiSDcmYXPSe1VATR6aV20Omz01TuuwoOz1lt3iAHDN5lB5EmLSayHzo+RPOvaLvAbiCmoZpyyMaeaCuCZSy4nOJj6c4BMv/qnhuMafjvr3z593NpJLhl/5toilHjLj6iQyGs6GhVlTUj2N99dK1SyJsG8SMRr29spaA4rmf2g2kGF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HercEzMIm8FoOqFRLPzepdxtCz7dyCg49LqSqCSdxk=;
 b=i+2Z+Top2hvWZZWT2GdABUV4xSTmVb5MnVW4EJVXr1XvCcYW9w9MwIC5FrG57T1ZrSEtnoJDjCdnvZj2xHXQe7uqebTKZ2IX/7FZQ7s9abMfr1SYbnq8NcO9506Gq78Yk/YktfhZr9qw2dfCveceJga5Ev9t+/G0pW08Z5azgeANi1EaQza/kN9ieN07+WdXa0a8HVDMR6UFyUtzEyVkHQNRyZJqiL0lfey8LjXssBpNzI7zWq2KntIvMJ4bF4YEvJ1GPKhJEAgrzIQ6aE0CX00H3OKemxvIs8kNuX0J+4GhwRzs+qcmU4rp9NG66D7MiHTB8fuQUwVQ2NEzlNEVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HercEzMIm8FoOqFRLPzepdxtCz7dyCg49LqSqCSdxk=;
 b=NhEVZXnm9RBtysq5wHaB7AC74WJ4Ro7OMIjdZbGBuEuyVlJgbAiH926QZLRcO+tQNRuUObqumf4SBnZe4oLH3hCCp6x3ns5eemQ2YAhZqgyYnYZzB81hXIQsUvkGSN6Tltw+wxNjoBo91SQtxsO3vgft1KyJzvpkIM7Gqy4I7/k=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:02:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 04/20] pinctrl: renesas: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:01:59 +0000
Message-Id: <20230228130215.289081-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4f3b43-dbd6-4bdd-1d91-08db198c1476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lvi0CBcZ6rjGy9wF8vBtDMrTrV/NiL9xtGzEwIjUJKBv8pJt+vsqfphHvIE1yF6fyX7SnPyzr5vEiibEfffSdUvE72VdYDqHPXLpNNaCdpbyBcVj7UTBXAIj5QPQwXadb5iKudRT0bjbTaDDaSI+oNLZA9aHLh2DdsqYeTt1RxIciGQbVwazWCmlPhzGcLsAXQtQ1j8jQn4ISjdBOoRAQvat75DG/8pg3vnR5Trv2I6ucKQYSBUPAj9opzKaZKeqSD4JgiqpnDBsYsKb5QwrMwPsNGaOM0f+s1rJiLbVwcsA1BQMMCQ5ClWHgRfFPbIFACV4Rlp9LbhTAHJNOwLqkQ6S6hRnzNMNS0e3CoJ5xoWtrHSrPcSAQRQrsKXYTFVIHIrIj7L4getOIRiSsPTIPInxmUZU+PI412o5Ytj6na2ctAebNUGLzDJlPQWqrgkwIQcpsjPB673vy5lOuZ9jNt9jmJEz+/FGmSR4xYj61QlYmOEDHdAOxbQj1J4QxKrVCalTvpJz8fHRRlPL9eUnC8pwmpm08CIa2+6jUIci0KGmYw9AFI8YWoi8aJD5yycD2AX/0yYSt/QcOg+Geu5fsOnf4vyhCDCQ5FsYsV5C5zsTifusMXWAc7PPF9lbAqeeNTBQoJyRk/O35MJDJdjHGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6666004)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D6dpFePdHb9Rt4XF433YS0YkJiLeRhBas6XuiatJ4zypF/xx1medS81yrzJw?=
 =?us-ascii?Q?Gre6FQVRF5cuU4mRRH/KGeQF/9pHPyoYQFtDC11wHtziBYJTB81rBPYNTexa?=
 =?us-ascii?Q?UdJQQihotipycbE44mkU883aYZJ1kV1sLRK2SNsXVKr3SrbicuG4hm/9vT3u?=
 =?us-ascii?Q?Fg00Ks3TSx7Rsq7kcfT1U8BKGdN1W4ZoQOLssU69dnUCmjuqO4njIFdjJvXq?=
 =?us-ascii?Q?hIaRM1g89in2nai76qPeuPkayQ1OOj3VT1vNlMDdbHq0dM8Aqlxj+EGf6vef?=
 =?us-ascii?Q?Bc0DVjS5l746WIoUjIJdW3jGdysoWwDbB0+6bf4OKdDjU6ezFC93cT0L1Tt9?=
 =?us-ascii?Q?H0AEtjGPAWXXMM9f/aCPbQWRTVGmTedUrZK5N61Ay5BEwN6RE4FkDjRnLwK6?=
 =?us-ascii?Q?KO6EBFGWgGFI8XVY6ixWJbNwF8vUTPrTkstEpu3Ug9Jz8VQlj7MENPK4+wA2?=
 =?us-ascii?Q?kNwbXlGehft8AR71zh/1AITA5k1LEdafygo/V1/nHDVPtEuCq/T9yM24e6r0?=
 =?us-ascii?Q?4RooUrUZ0YebCNrTY2NnWdnJHXlRNp//vN2OM5vvU4UCzUq03bd8SHWaqmrk?=
 =?us-ascii?Q?e3EOYj/rz5UP5A6fR4DZyhu24vb8sJL3nwtmVwyntxXOQs/b/w92SxFh1aIE?=
 =?us-ascii?Q?BeXvTKWe8jHx27fxaTEAHfJdeyl9VzJlh7PllEAAbwoj1cCf8JqhhJwHyb0B?=
 =?us-ascii?Q?NLnhUS9smiS5gue6VkJkCHQV+iX4VotsaIjv05WzPAExg3pChokFcyOEvNYe?=
 =?us-ascii?Q?iF19GU13WHqp2HD5S8RCifcaIyx/y7FzQIDgr/ALHq95pxlMwqTWFvZG2x5F?=
 =?us-ascii?Q?Cy3gJJ5miVG4o8wDdHyLOMZWe9NOKW2ea3s1ookSMLFx0hxdCwh3Uv0IJUi3?=
 =?us-ascii?Q?KvwrCfFk4MuK+Xkpm5E8Vf+zDAherMTl02CqLmtabzayZwx6/L4LJlByKvzy?=
 =?us-ascii?Q?v+4N1StZLoJoN9n/WqHOSvKR6PPRGbIlD/0IO5v8GR8/v6XsffHWwJyq4beR?=
 =?us-ascii?Q?elSop6++mtP2oWJqWtr07v+qDwVGOI/l8ZONvhyfcEN2w3rC5Vh8SIXoRf76?=
 =?us-ascii?Q?U7DDELic7d8JygzDEIRFb6b1/mEyBrfxQse2in3mcxlgXc+TPnze0cTdg9oB?=
 =?us-ascii?Q?njraX1jZxRjSMYS2OwWwTVmmpa8pCA98sbtVJ1PC7PKF1oDqq9k4OSuJWv3S?=
 =?us-ascii?Q?OkEHLvO1/Dm7LMO6Rh4H7fo6pSNxYLQ0676gUK4nY0I1yQ/b9Wgoa3cCFD2l?=
 =?us-ascii?Q?rW2Me4zh/+Fw6mMxLeNw0oXZu+OkH0zsqLlu/pl8mJY1T5uqd28QOMJMb2k4?=
 =?us-ascii?Q?TUfrC+DRECgKrdPkn0B7BtvFlBVSZlnI62AbC53gO+oZHU1mPuMYeG5U462A?=
 =?us-ascii?Q?xkBpREY+w8QF/9XappVaZJSmtlFkw06NXfxiui8T4XHjdG8DtmqbZ9l8hxdO?=
 =?us-ascii?Q?AGin2rKH5seb/8fRqgFBHzNuCDHvBgbC6kH9GkCfCnwHrv7BNAFghiW0YwLY?=
 =?us-ascii?Q?K7ECon9uAj03nZqzCT1KwxG57Np2PXb25nf6Qv/p9bG4h2KqKkKaS9FcHLc4?=
 =?us-ascii?Q?RQgWuA50aC6d2aBdDgxUx9LMM1CYJ6P/0ZKzNCAW7j9erfcgLS1GhDnP+r13?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c36DawhEzyh68iC8S46gGX4x7wZyvqpnXY4LZoHkXR0PaJ2vlO+sumoedVlHZWAt9X61ScwcFu2frJW7OhFyFurtxAX5aSqynst4RmzZtdPd6txeDqyUl/FZY4YVLnXappWq89VJGQOKUVXw5C3Y0EkBRzKEcs3VPI3Flug8HWUlnXGeK2MQBIuEikLqQ9FD5eSmU/ntmfvSJRjqKS13ZU8AFKrULR2PmzXVosT1nJq9yg98c+n+vJwE1aWiyU56IZPceOAsuxpYcSahplns46KBsk2lrMDZWqalteK/arI1Zr5i5t/JFY1q1vTjf9qJSSSZcO+IGtYTXNWfvaJ3yPBFhH+Hw86kEocBmw6z+raG+3IRUie79FgZd57aY39a7TVBSU+UVBeYU8UVG5Am+f2EiCkwogs93nDKGmyXtSr95w9w801MCZU6dIj6oomBmuo3a96qwqu7sbHKPn2oa5mKHJn92jhJ1vS8Kf49p4g516MimNvhznrh+Cgk+tYpCPYqnsyuEWpH3USF6gPqTVgH5bDKrs2pRFEAf9RVWqpXi4lADIfZcZj1ZqCc+ExI5UUa3z6QkKqv2VpdNGgAaJL7HmpM/LsRjOfDgPl3hx3+LBxlzm7ADaRsmbuhC3FPbyf6xPKCTb8SQrtxGTqhq+5zddQMZr9rb1GmLH+nJdppycMEwOzrSdAv+TZugoUwwl6+X5Ba/mX6uygPpKyYZf8w7qZEQW0gvaGzd27lhWFIh1p0f4M9kzqT0c7mDiuvats77fwgp4UwjUg3o88aSkaeAo136SwBIEejRoYVVV7QdS3qk6aGHuJ8HC18DhCedSkmZVnB0+mtpJPFoySCMSHG/hIB596dJvzwuONyFVvnIWQgjFOYhOHdav8T2dtT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4f3b43-dbd6-4bdd-1d91-08db198c1476
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:43.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oX/4gEhFa1kpSjbsgSFPuZDHQPuBp3TP91LnuJgqcC6EuuSAR8KdrXLshvtpJC+E0zd1pwGXvMn4WcclhAYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-ORIG-GUID: d75hrOkTXy7GXlt7x8T_Xpra8XjANqY5
X-Proofpoint-GUID: d75hrOkTXy7GXlt7x8T_Xpra8XjANqY5
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
---
 drivers/pinctrl/renesas/pinctrl-rza1.c  | 1 -
 drivers/pinctrl/renesas/pinctrl-rza2.c  | 1 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 -
 drivers/pinctrl/renesas/pinctrl-rzn1.c  | 1 -
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index 529c0fc4ec063..48173355a040a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -1407,4 +1407,3 @@ core_initcall(rza1_pinctrl_init);
 
 MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org");
 MODULE_DESCRIPTION("Pin and gpio controller driver for Reneas RZ/A1 SoC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index c0a04f1ee994e..40b1326a10776 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -514,4 +514,3 @@ core_initcall(rza2_pinctrl_init);
 
 MODULE_AUTHOR("Chris Brandt <chris.brandt@renesas.com>");
 MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/A2 SoC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 5aa3836dbc226..362c3a0baf1df 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1561,4 +1561,3 @@ core_initcall(rzg2l_pinctrl_init);
 
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/G2L family");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index 9158c17574923..d73741651419f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -952,4 +952,3 @@ subsys_initcall(_pinctrl_drv_register);
 
 MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/N1 pinctrl driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 3b65a71abd9ac..e5472293bc7fb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -1117,4 +1117,3 @@ core_initcall(rzv2m_pinctrl_init);
 
 MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
 MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/V2M");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

