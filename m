Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE4724B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbjFFS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjFFS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:29:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F211720;
        Tue,  6 Jun 2023 11:29:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DEYO6030473;
        Tue, 6 Jun 2023 18:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=gdirt0BYXNkknlaYwMcCds6VZRdgOHOSNcmQdKkHEpE=;
 b=soBn65UHEThqi3xnaBpxwYGbgXe0FnlOH3Oli0coFrMIAFXrro77Ff/ylybDnUdrL6nb
 ZGwMdYggd3OJpey88zrK+aNEg0bzroHVGxjBKd91bZs58/Yedtfw+I/mM1OgyxAn3Hfh
 sYieOWnd4Si+eE/NGeuP+Y204B7DevnxwBE3PcNVuTHbubsP3liP7457r9McpcSbv49H
 fqvxYG9e9D5CkwftcuPFLxhugNAG6ij2opKqPZHBfCKOBlJQ7HqfDuc2ekVnhv9jgNtU
 k0gY0JIt1We0YTGa7TW7uzotu2sHbKevGZT0UB/rXFe2znnSMsROwKIkSOOGp0PS1JU4 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx43wyw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:29:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356HtN7K001871;
        Tue, 6 Jun 2023 18:29:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tr10x4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 18:29:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7oG+BYbwiKSWK5PpAgKS2NoVzKsY6c4+QLgkeL6WEdvyGlvmHUfVtOLRFr7ngkK/cg8ZaHd4Rsd/EQHO4EBSlpbyBUGadBySOEA37/YUo+F9RSVCbPQyVLEqKaLwYicSEAgfXzmuUszWeQ4gjs0yQRi2fMg7Vb41+LaXKFzvrYQBoXejPapJV5NdkeMP94Wo334hw/311D+0DG3nHST5PBJl9SRoac9RliS4SZC6m8kAaYyBEOTLyYrFNUDSG7klxabthPEgBp/n61PPDiABTCZBAe6Hi6WKpb3YIYdmhm33LzB09MArXbR+WdoBogHYKB8yoCiXmzhoObKmzDFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdirt0BYXNkknlaYwMcCds6VZRdgOHOSNcmQdKkHEpE=;
 b=ZTrfyky7DPhmHvdbE2rfXpx+5C1fd3MNJxJRnCluryU4sBbwc9GRo4tGjFEUXvN6q4w2wOT8VtviqX6pCXhLvT5KZazRtTE3pJiyQvoCVHY23QIcpFxyd6nGJDuOzAowg/ErvJ9Z7YEMSHRfVVdo76wEERKjWCkv1zGe7L+HGxMiVfIzSN0MQQAZi0wezYrOSSeqUWom7UISHUwlHD5aBzSWlHktcVdraIVSW7mcMQfj0SaBiU2t+eoxZj+wcZFti66KMLUyZu5lo1rYa/pflYNWiPp3ht1onQFhmqYXfACtr2LLEPfpNg3Vaw+SjAZ+5865dZs4wwijaryMK/o62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdirt0BYXNkknlaYwMcCds6VZRdgOHOSNcmQdKkHEpE=;
 b=awQGkjOlXmOUGeeUks2J4yIGjXZfnKeqJ37Cy/Er1J8SXx2tJvpWJeTL1I0A2T0ieHAclMLILcLOVVvdb8mG5GjfSapSUbKHp93XTQjA2xalQMC5LTGJvWmeMnsZDn2lF7cbc+IFSddrdVt2k2FxqLwTu/GoAYFohvrUTrclR1Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5261.namprd10.prod.outlook.com (2603:10b6:5:3a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 18:29:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 18:29:24 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, stable@vger.kernel.org
Subject: [PATCH] mm/mprotect: Fix do_mprotect_pkey() limit check
Date:   Tue,  6 Jun 2023 14:29:12 -0400
Message-Id: <20230606182912.586576-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: d079db52-d57c-4fe3-c24d-08db66bbf3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pOzPm5JLxSkOkPDJ3ETkMi6utdGI0h/mUEmpYo8mAMgekkHhdH/m/7dcE4zTiFXnXbotbnf6rJ4OQ090HO9+cZOrghfY9Cuqk0HhhGcBe4PZich3IjKKBioHz6YJoAh5tapL+e0lYewIKx0vj7INt+e8viLum6DumX/1khOpfLiqfn2+RmF0cBM+w4MgJFt1pJ7dnbesvVdCqlmEfhevGJb1S6j9bQ4ChgkfiJx2zK+WrXwgrg8FteEgY76f4W+6K5qXGEDVlXYRHBDYUj2iX0tyB1xAvZdEg9/ssS4zdXv1irTMnmsUyGa3/bsLJuyqpbpMAesc2cCEmYZV/W00o5x3xwIkC4Lm+iVsUaWHC9GCWAk1pe8lhov0k0gFezs1gqzjkXi+D+G3Bk6qbMKJwKZlnyA3KGTyNh6fa74Jpq+zzwBzyUHnQlbrvWGgQ8xIjVSrDmzY+qt5y0hI4mbTZIS1tQJmTe+nxXfPvDjckm4lk2jcyS3X8QWpOI+KLJvNC4I+6TlXcE/nOnSTd4K7woP4bK40gNPjYBENvQ80vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(36756003)(86362001)(38100700002)(6666004)(54906003)(966005)(478600001)(4744005)(2906002)(26005)(6486002)(1076003)(6512007)(6506007)(2616005)(186003)(41300700001)(316002)(5660300002)(4326008)(66946007)(66476007)(66556008)(6916009)(83380400001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbhKuLkpHE0wJF43msnIhLKQ6+WvJ0QMbCMPAcP8D0HBg76OMVd4no/e5Mtn?=
 =?us-ascii?Q?/0mVrlED3UjVf0GtPkRhUh+bQWdfT++l6XVwBIORUGZbMI6dz7qr57GhZH/U?=
 =?us-ascii?Q?79mFJtsgWjcb9uh2ncGlPpdXWEYTozJuIF9SagQOMEwhERYEEpEBPknv9FYF?=
 =?us-ascii?Q?Ez9bvK5FTw7khubCtaJ94q9Q/YkJ2rHGeo+hdluHrS6XFGj/UUV1sIpduZGR?=
 =?us-ascii?Q?OK3ilMU8e2cF3O5toUzcQe3xnUNE+WUpXRqCF0c0yzXO7zIsVKA4ELXYL+sx?=
 =?us-ascii?Q?0KMYQ3N1Ze/t2Ys2TgFJ+vd1VJFdab9+ZDdlYfQwrrA5ehkMOsZzzQ6OC8sq?=
 =?us-ascii?Q?YOxUC0myD6uZHdBtX88U6ZrKWwfh0o2twBBd64HgtGXORMMTG1Y2U+LA5i5L?=
 =?us-ascii?Q?j3ldcOab1PTQh2mHWGaTfPcebxc5VAYuUXRC5gsafbk5s5noHfQ6Zky5ruzN?=
 =?us-ascii?Q?LhyfEBCmQKN+nG9/ilOfyswhsEfQehwmUO+yp/ztbBbtylFRTDJLNnXDz5sD?=
 =?us-ascii?Q?3AqAF9w4kpy6UDrfRM1FlbjqS34UFQVgke1oMeiivmcOsPp1gjc+kuGLF1DX?=
 =?us-ascii?Q?RlaLT6NUNt0nHCZz8Oaa9o8IxEldEvdNgx3KUzYORmKb4ehts8NBDNhAOWru?=
 =?us-ascii?Q?0mt1IUvhlSk/wfsSLqmvLdNMK9WZODy0ulSux+LxxxB0jcH7A7zsKCAa7bfs?=
 =?us-ascii?Q?yJ154GLW8uh5OCRfUZjnm2uy1Tn/XL0T8lk5DSgl8CDj99f72P8pKuEwPmtq?=
 =?us-ascii?Q?UXLn5IwLcXnFZXOz7wdMaLOUtrxjJa245STItYEqzyLPKhHB1xw0Bb3KT9r3?=
 =?us-ascii?Q?xJpg/s5YdoZuIf6IqoR37Al0a+m+KNk7h3z8sz6CdQ+VjW1Lh3a84yA5MeOI?=
 =?us-ascii?Q?TR+/V6LqY3A5BDZLLHrG3saRKF5qMQOiZcTtG7s5K+tTlaSBxL/LtFcwJPor?=
 =?us-ascii?Q?p3JLOslXxXLBKF/uZ8flMfujSk5y+dIflmtheOUkTPivP9jEeLlTOo8GSQWz?=
 =?us-ascii?Q?5+WsrR+d6Ho2s7lihANcpZ1nrZ0H+uj51FUHS8e/pz1G17XNk8cKUBB1/XQw?=
 =?us-ascii?Q?nYUdkHqBHmFqx50048sbSozgCILII7CVDEOQkzrb/A7Zqwz++Pho2ONPtOHD?=
 =?us-ascii?Q?TxZUIq58SksOjF+9mF58ra/HLnlaHzl8YRJ5sIy+D+YKGj907FSVNy8VjFUI?=
 =?us-ascii?Q?7lDMXewl0xQq9kB2ySdGtEHm9PS1Opnt+u8ZBOd6TjMZif9nRP3vtxJHTGmm?=
 =?us-ascii?Q?coRYhroaL54DpCOrQBQasxBQIfJAOL+3bCFoj+DH8F4N9ORngjOSWCtaMxt3?=
 =?us-ascii?Q?AMzGS80NMpGziDGknl36eweHiooR/wW88z+khEp72d8TLqGvqi/RgCcJ6+68?=
 =?us-ascii?Q?cU6DLezh+/3SDcVljTyB+/87mJ63/z5TfTw7MS7+v4bK14sJcBIJHUBROsBb?=
 =?us-ascii?Q?NjHKZdW4U9JXN5b47MkfLfxFzeGi6/etZHfTLupsYL6RdEt2FUOtyO6IZO2e?=
 =?us-ascii?Q?4HdOJqULBm7kvAHGO6yOH9FtqJClfFdfEMqK0E5oshRNRUaJp7DD9QgLWdom?=
 =?us-ascii?Q?Zj5dY831T3xMm2OWSpJ/7y6bPCd+FXg1VW3jNrBAQJoc7xrh/h1Wa1dJ9jD+?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fF+0veCj0Npuqucywn2ffD8aecI+JlvE+WV9FsOooyHMXRbiP8dX5R+hl597F4tVsVK0Y9dlGyaE+e4+q51N11vJ33oGgFKvH+MnT5bVIs7CdKd/2BrOJLPHeLR80DBzE0az/9Dy7OfuglUg8QWwp4sStp6+J/kryQKvI+gzq7b18yaLKI2h9Csck0XCcz28zERdLz2wUwKHIZjpJihCNQtKWl+znu7zXEk6neerPK498xzdTbB1IRixnlPmpCnmXSogvdO5Aw9l/Mvyo1r9Ub4uvGeerq733JnEpNsjEBh8BRX68Ock37JSpFEfBDDqU9vLKhgCUf2+Xw5RYVDJ8BGvPNN9VRX1Tune0Q2mDIpwHPCuabUrd9V5g331FA86ASvjv9bbooxXLwlGlKhfb0uKRpCqSnFk0vHs38cjodSD9O01GH8m4TpEhggDyRXKEB0iq+4nZQxbf5aQ9aip00aDJztUm/d1IM6WfCheHhlsRvSoDedGiuva4cKe9yIxA1qyTtKd44KuDuAqrmTRIEEjJWaJBYQ/lbvMOjeuTQVfTU4Gu0meowBRjmyptNZUk70f9xBaiRJHzoCE/AMZKxVsx26rKVz/qjJi8RAGivdpd5iH/OwdeZ4P+7CUffyiRqZc6x5kYDT5uJNbn0C4QjE5cEljZhQJ8Yig+9nzUSndD4X88Yb2ZNSBdQsKa1Wq/od9O5S9uQkKutxqS3K6HfRVkPgmO1liFZKrrB7qm1nllpnz/4rz4hdR8HQn38wcG8jXJTAsch58yW81HUKwm8nb4942nW7FtSkIQGz8idj29AW4bhGR3EJZj0r78XszoR+0gQL1p32pKoRJPDDemppc200D9vkYkaaA5S4eQNyVP8DbZzjzGHDvWZabNrd2NJiTYWpQoxwmGIMgxZ2TAS/FHWvWPtALNQERH+hUIgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d079db52-d57c-4fe3-c24d-08db66bbf3fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 18:29:24.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPazAlpDur/gj6snZMI9kqbNE3Vb+bdyNWHfAz3ZTkdYrh+Yzcuk20fVfL2IdMmaZ9U4e7KxnHPqT/InfdTK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_13,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=917 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060158
X-Proofpoint-ORIG-GUID: 7Bez0iniOprBslv9N_5I3wusSCP2hSEw
X-Proofpoint-GUID: 7Bez0iniOprBslv9N_5I3wusSCP2hSEw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return of do_mprotect_pkey() can still be incorrectly returned as
success if there is a gap that spans to or beyond the end address passed
in.  Update the check to ensure that the end address has indeed been
seen.

Link: https://lore.kernel.org/all/CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com/
Fixes: 82f951340f25 ("mm/mprotect: fix do_mprotect_pkey() return on error")
Reported-by: Jeff Xu <jeffxu@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mprotect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92d3d3ca390a..c59e7561698c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -867,7 +867,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	}
 	tlb_finish_mmu(&tlb);
 
-	if (!error && vma_iter_end(&vmi) < end)
+	if (!error && tmp < end)
 		error = -ENOMEM;
 
 out:
-- 
2.39.2

