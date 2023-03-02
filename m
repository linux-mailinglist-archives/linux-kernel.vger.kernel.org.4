Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D682B6A8B61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCBWBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCBWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:01:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F85551E;
        Thu,  2 Mar 2023 14:01:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K4KCX010969;
        Thu, 2 Mar 2023 21:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1RghJjNDIyeWZ0W+4sfwbo3AqMVqMFqnbYD7CPbfAZ8=;
 b=BLtgdAT+8NzR5CYLPeRyk/iJD2PFPnBsP8rLPVxdvx+Um27U+zEKRsCIvjaFgIuoq4Fq
 vGlZUQ/ST8406jpcOdzcAGUydjIqwEJgdQvPCATDVWd8R+5F/1yY4iESq5x0LW04etWI
 Qe/6ae2P24dPTSNpnw/uhtXmqm23DakfrnS+EV5z/1qAPz/hxorgpwbrETkstwQUPLKI
 ojH2H9SnTkhspi4hQITaxmP2cPXL4vfgIysEyaUZ0F1IRxU+FAChZNnVgRW14e3G4Ae2
 eMwgyzlMFsgEJ7eJao6JqVwUC6lv8Mj9b+YUCgnD1OXjnoeATz33RU7J9Fj5P8dY7WKe zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakw0e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KcTvf031258;
        Thu, 2 Mar 2023 21:18:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8shf3p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXFFWG+O15+d5giu3/A/s6S6AOjLQCDIFZY6C9jPzWs08Up675HSP/SCkxsPCag59JTgVEcURFqRR5Nmtdjy9HzVF3XcBOm6oMM6xrf8R30GYSRp8hWriy8SNf8ql+m1+I65stYgqSvRwzv0MDrQvxNaXhIPs726TOTRmKRGUmFmzs5HHbb7/UHeGKaPkSpDXgOb8PlsKs4O7+d2/gtnJvvTwA7nytKWoKZeLbFM2nVh0R8p4A5V9OD4jsleUCMHCnOqpkiubs0l4GSsp8tUDDndBuPloiGD7TU0TEUVR/EjhkneqGrDtHgoOM/TPT0Z2D9s/uOg9gPpvPOSob3dIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RghJjNDIyeWZ0W+4sfwbo3AqMVqMFqnbYD7CPbfAZ8=;
 b=kySwWqxqC06XR7T3D5gidREVwivIe32nIfkCwO07Te8HgGCpctKTeBiyqa/MDoZeIE7Rk6AS7v4O9G8zJL3feWw6uj992/HnTnGnara1ei113d1b0tekL4ygCEfvYXPXTyxskgsYpFYkd13xVsA31wGDYcJfs3H2CcUK8KNIznnISbMG7xFmZ2/XZETj8MjVVDwMMzoOZIGoAbXbYU1u/OCmbfB2kybp2uWH96UYW9/5Ngta0gNva6MZ2P6XZRZEh5rTRebIpbqlRfMBLY/WobaSOAACTwu5Vsbx1Uv2VWI8UnGtPEc5w3dkEi7sgeyr9FhbMv380ZWTAenFKLFhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RghJjNDIyeWZ0W+4sfwbo3AqMVqMFqnbYD7CPbfAZ8=;
 b=iibMsQKwX+5wA5jgNUcGzzNA3tm3qPx3mZNY6vkUNo4fv7zl7yZ0I8Hxky0Q9/57tCQ5HhYIMwe2J009APGERYo221/yjq9wtGN0njiGgOlgOupWQWGBOj0j2Fe3zJsIDZ0PsWPEkEKgbmqBPvt+xAEfq7bjZf6TDx5Ie8JGvHk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:20 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:20 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 02/17] bus: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:44 +0000
Message-Id: <20230302211759.30135-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0654.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bb5565-260e-44d0-d11f-08db1b63a601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PyRWZ36QV40DzdTpk0BzIU8rqkvtWOREVmxDTW+XYW0dPHp8WjqvrRSkyzkMYyvslSv/hDHhrJNiR3Kk9KlsZfwGBWQXqQ4/eJ7QWQwSVsIg8DvCYIT8S8SAOFIbXrPaTpx6Op6ZTZWYhCexS098mvENKXQ5JT1bo+GgdeJ+qNs0J03SpU/T223YDMcNNonwaZVkfKHXuWakFwbAB/x1qg0uTgppGjur0iE9nJdL6qv6ZpFVrQpHYF5ByeppZ9ydEO+MfVOZMSYRuAVkhjQ0XDfrbz00xeXq9ses5efaUccWSNf/sJ8+M6enykomjBS9IHB1wFsoEVA/E+evL52B3lUXkmnvuk3pD6rgKy6zwLJJHbapRECujyEJ+MeT7Pd+c5E8dQufgrZFdlHbNfwO2Fwfk77mfmQ540vyJXfvc8C9MflxGeAhPP5n2AcXJQtcqyXNs/W73DozM/4UhKD67X8P95GuWxe4yGhiKZJ9jB9mzbYPZLKTtWa+FB1R/GB1gEryLqOWLjMeaJu4NRZFMdZFvC8fXOlh8HrQqMFSTPzwYFmv9JmmxQHBWLK+t5mJ78xTdocDaTnn0oU3TesBLehuyqLXC4AIGbtN7nyBJ92nL55zv6bgwd50/bTRmC2gTdKGWr2GXUzkcBW7m+8KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6XSip/b5QhH5SJ83GHkVsA5GDnPAXRuB4W15WuAWlH4zVyQ95OdRBHZPIFET?=
 =?us-ascii?Q?A/WYxPDekrrut2W7rLd3C9r0Ou+knI/10Qwgku9ExmE2wK4ymZriPbATXIUS?=
 =?us-ascii?Q?fjaYnfQhQhCpoUk0fMvY3J7+XkWI0RoJQym8KoSiSEJ/R3J+4I4IWFY+TdjK?=
 =?us-ascii?Q?sJmw9QewxWk/F53FXkBj0d0Y/SQqcEwk/NjkHNp4pMKnoyW9SVNaVonk/dQZ?=
 =?us-ascii?Q?g07aVGIiqzo3e6xJ5MN4WmvT14LSVn29Dsd3/mtc9EY3baeEc6YFr+kxrjqI?=
 =?us-ascii?Q?C/Ti+CQN3RFLIEv2EldHNWV9bI7nFyiH0drCsd0WuiGb9u17B9GwcznM6nOL?=
 =?us-ascii?Q?ZXTBuHUf0M+tZyb3f4H924xxDbK1VHTPfrDRsOF3hMZ7ZjbkUvgSewAgQhvf?=
 =?us-ascii?Q?fmA2hPscP4gELqZ8tTLKVuE6VYCLaTVqkW1TcjBAgKilSfDNd4YkIZVq337j?=
 =?us-ascii?Q?VlSBljZco4y3iGHmIghjbIvrRQvOE/vkOAdBeWUm2ZNooMlL14fCBo83dQAh?=
 =?us-ascii?Q?PjuAZ5HGDeddLplfmyMSJMtBFYuRVpiITELFrS8hBHEAmRmWXSdd2R6q41Zh?=
 =?us-ascii?Q?dEwLvDFYznBOClv/nOrqAmvvXEyYGx9oyVZYSHjDcoM4Sty5pAkYflzceK21?=
 =?us-ascii?Q?Nsai/X1Scyxyj6FTElYFi9lsaAFYn49bTA8Rapiwv56Cd++S8pj4gtVT9fXc?=
 =?us-ascii?Q?lsUVf6Pt/lKCsRIDl4AWF2huJz1CIWWXDUbHUF5dcfG6fpmGbAlTcPbFu+mp?=
 =?us-ascii?Q?jpRa0rBT713wbABIwZeGQudpcktuUJZis61phgzvWIjBHThGByJyLAEFGPUM?=
 =?us-ascii?Q?W6VzFJ3OvuxYkjdnSd886utrNb3jaZqlVCY9JnhYcBS5gho4UkfQczqAGmk9?=
 =?us-ascii?Q?35wOtmrumBccXBFVWbs+CdIcSssQEN5t1y9XLAYKVEuMPIRJH/dMgl3hc3v/?=
 =?us-ascii?Q?FBNhh3jACrUkDAPna+bLhdQML8GUQ+c09aCYsQBweFHQLz1QRVWpfRt0jdMp?=
 =?us-ascii?Q?sBIvPhcC/8wcAV/DJr6CvCsevr0u7dV19XvY3KFS6aBXF98hazq7TI2Pbbp2?=
 =?us-ascii?Q?FEKgMyRJ63scW09h7DVGFXurAAjypelf6p1m2wmG7uHlQSlSKaeJ76j/CeUC?=
 =?us-ascii?Q?VvHgnyEkDmHevyal0PJ4SyiBken2G94mf8vkaMXdsYRnqAq5st5ksegoBg1+?=
 =?us-ascii?Q?7T8qrmr7BFAVaZ0WIX8Cx7o3BSCzd4woEhJTqHoU5rpimaDjkg+Mnjv0kayu?=
 =?us-ascii?Q?PVS+bv0v8IOta6I3bPvdw8hHfP2keMmJF8CkkRCW11CN3oaJoLv2ETil++YV?=
 =?us-ascii?Q?Eb/a8/AO7PiV1Qsxy5d+CQOjbQC2K41po8jaMQahRaUS4XrkSmwW93Jk7OSG?=
 =?us-ascii?Q?RFtvLSTHCa/TfJdRM7Y4oSMuXRAvgCCFRJdOggf5CXiBnPfJGBBjbEyovFyD?=
 =?us-ascii?Q?fjWUtJCrl4an68ZtvJBA3aTiW30UyDKJDjxRpNKpd+CjEkKx/z8x5+WoZfiK?=
 =?us-ascii?Q?Cg5dH1bilQkvEcpfginnz62NG8B6OmSgegyQ+yeoZBIPxvGJMSS4v4c3+ZVm?=
 =?us-ascii?Q?IRsy9AeFIb3x7XUSR9IJbZcoMvXT5uBnqXN9pU9TmiX6CvHy/LBGbdUmSQv2?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vIMMA6TQm59ZRf92AyF7NEES7KU7Lj/BuJ52iTmgvX1ylMBubjC7JfDjo6AFUIE88dtR9HiCp9sON/OJKSfgf44fPUyz0Kl0ruIRpvH8C/FnKcaR5RzzgWotuNNAIm+J0zxLWYkWK2ybcw53RTEo2v5RtIs2QphwiQiuGFDkSpgks59PsYOx9NICjpk52nIKhPt9kYpoOatt2a4e5EdZc/QPytWFOS/yhU0PIuD0Zcf5BgdFNT0eTM90kk1XPkKg0zxkAwSCTer2dn+xIwujDpkiOygZ2D8/oYftN1uzZ24la2ICCJD9XC30QV4x254y3gVjre9FbMyVhAvoFd9003W8WMuyX1X8DsDzAl9FKeu9qZ9hz2RcSglORiSug56l7Q0rb5xji7dNT+5foASnNjbMDl+qL60J/wUgM2KzVXG54QMVe7Hp3OhVkNZYvF9kve79gg5T2zIcVv6ZTYVfbqwMzRZBGz8iklKKiq5no3c8qKF47eDHb6oSrHSc7S0xcLOheRreIk7obTqeKdO9+fX+MlW+TkKrNf7elQMrlWQCVojN76uAWZj3ca/qZGrGAm5Kl4mwrHVAd+qpqMLg5jOjxkEY3GjmEIEtHMo3hCblybuhhSyhAKR73Jm87eZRMh3c95pFAV4L1E6O9VubweXw4x3D/mt+xPugj2lHiTgCQK1rcnu5VK2CY1u5mbJyNty3ei0Oir6qU3cxhn7ay0FpeaTMyepDUdCNASx5nEon0g4rdovF1uv3sh9AntDJeUNKsjn7f0MYfKhJgQKU3WBsGYBEmbPwMzgH/3y/+QzVibAAbvbaSrVAxKtypDMSd/Ymw9SLNVdfI1y6azvyVqVmCVCzdVAVVzsiKXP/kfY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bb5565-260e-44d0-d11f-08db1b63a601
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:20.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5h3TnPSL1vaNxuVrfMxW7DlDckn3lFSd8GDW2FZN4eRsyBPXX1kwATDNU8eDWOYg+lPj8evUgIn46pTdVEi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: eEiHpchq8E2kAOyg2BzNE6ba_HEZB4NY
X-Proofpoint-ORIG-GUID: eEiHpchq8E2kAOyg2BzNE6ba_HEZB4NY
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/bus/bt1-apb.c | 1 -
 drivers/bus/bt1-axi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 63b1b4a76671d..e97c1d1c7578b 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -416,4 +416,3 @@ module_platform_driver(bt1_apb_driver);
 
 MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
 MODULE_DESCRIPTION("Baikal-T1 APB-bus driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index 70e49a6e53746..4007e7322cf21 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -309,4 +309,3 @@ module_platform_driver(bt1_axi_driver);
 
 MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
 MODULE_DESCRIPTION("Baikal-T1 AXI-bus driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

