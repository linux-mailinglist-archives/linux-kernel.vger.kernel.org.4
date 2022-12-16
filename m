Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADE964F145
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 19:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiLPSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 13:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLPSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:53:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F029C18378
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:53:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGGhk8R012485;
        Fri, 16 Dec 2022 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=jpFkq0FfekSAcg0g37LbW4e0z91e2ZjG9MaZvLqMgHY=;
 b=rZFPXGtZ0xHBLo6mQrvpvwAZ4BupLAGgVYpjLNm79BmYpkU7l0EstZ3UWfs0uK7OvGid
 oxUfsO9sC6VL37grI7x3AnpyIuL6a4uAn2m6rqFGD7zeN09ZGn4eS77X7KfiHROB1G+p
 dG2sTA3g8Djm4ouAnsjfcrFBENmogKSmWciiw3QSmJc2/D/F6M8oitzA1a+W6VOdGI8B
 fDvfGuoxTDUJlzlLAOQXbqB0UYv2o95Tvn2Ujt80Oy66EOBiiAGNQpTrNP1mIWAmTWvT
 TfWT0vF0TQsmRb0pGd96j38Hps4j4YErJXvvjalyhaMMI+yINWz8lkoYecbikta2zJUd IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex887v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 18:53:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGHEonn027797;
        Fri, 16 Dec 2022 18:53:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyf0r2j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 18:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elD/oSnuzZFRr5/y5sPs+a9JcCcgGcduPSowACZ9Y/2jwpO76Wamt28UMwNi6aQmyZs6PC+d/wyQjfi6pB4uQmvgFQ7HrzUMXIRT0ts2GbJgpnLn84SgfTtrYT+G3Ts/lbolCuAyAYx88EZSkVcN8+F+5hmflXtaTOMDDmPKV0NBpydVnS1IcZ+R/umswxxQglL2V/BxNUHA4hE5OxRojrPEXq9RLQeRHghGpGq3fxheWs6B8crKMQ1MAdLlJpq8Gg+Qbbgxc+HirWoMuJqj4d7DesKh9Ey1ZLPtxrC+MgmiGl6v+hInY61yjiVwLLqRB6K8ZoOO4I+LN70MTcZEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpFkq0FfekSAcg0g37LbW4e0z91e2ZjG9MaZvLqMgHY=;
 b=Pt7llj288HzxQXLVesDJfi96MISTRsy212dqNXkjw5HUhfVP+KBAurtebMx1b8z39L/YRzW9fR1Fwlm6QAv8k6X65UzYtFHQ0WXJq21yd49Z/qqfZVIvrog1Aa3mspwMgBPBm03E7OqjXOC9QsE32WPhMUQWuUJFdBDz6SWZqlc9FaE9FKsgxIGdn0LpT0njuno0XSjfMdtuufQbB0zs2jBv4dbDHXjdrdN45icLBYrfcAeYPZxixSTAWk/hvUJLq9WF4tdp75wmnDsvXH6pj4ohmOeIfzTkPkYK8AA/rTTUvmnXMYpzmwofF9XYBUdMnv6BvptOiUus3Fpo5qhGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpFkq0FfekSAcg0g37LbW4e0z91e2ZjG9MaZvLqMgHY=;
 b=QaxTXz0rx4EI58GGPWxmfvgEKnAnKsFVqLY1HTJuTi2wo1LIxfFdLdHjjaS6q8iHFssnooPOdO6G4WfxmcaZAqabvFWXYyt4Ho4ilJMROpYkOeMx+28be/R1lqfGe0CSk+7pU3uvBdHO/ajRg6GyRKb/6jxnAT3V5OgzJqGeTLs=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN0PR10MB5959.namprd10.prod.outlook.com (2603:10b6:208:3cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 18:53:15 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::4747:eca9:4a3d:a1e5]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::4747:eca9:4a3d:a1e5%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 18:53:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Andrei Vagin <avagin@gmail.com>,
        "usama.anjum@collabora.com" <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] maple_tree: Fix mas_spanning_rebalance() on insufficient data
Thread-Topic: [PATCH] maple_tree: Fix mas_spanning_rebalance() on insufficient
 data
Thread-Index: AQHZEX+nAbpIKZyMBUWjTfJJigFqHw==
Date:   Fri, 16 Dec 2022 18:53:15 +0000
Message-ID: <20221216185233.2036415-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB3011:EE_|MN0PR10MB5959:EE_
x-ms-office365-filtering-correlation-id: 10704a02-7378-44d5-0d4d-08dadf96ca34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOqBPz/GLl/ZzSQXlrcJ+5XjoU7+XkPGxya49Xke2/xr989u9qZ7dyOdmxEEBvmKuwPllMasujQ6eCP/0GF8Jhb9MtiU2ca7cjJkInqGekKTzHiYD4680m/hvfs1RAqNyevSDqqg5mhG7t+as0D6EcYH24mlZ953CT9Ly8bPQO0W1BrzjMGRz4CoOnmmaP54pBsCD28lE6wGtyhyc5qNRKT7jXV78YJ+74NOgUjwTdo8PjblBCzoxEkTjKiK41LwIIAEBEa8FUWp9JekpzgpeJCLN7l3r+cB83UaUBQ9/zU5/LvGjNX/3T8AcB54HnK9a/ph6XkWEeyoeWMBt5fclCaOpoEXDduouGQNu59x6/9ZIXrb4K9vgwIyFIJLasjf/j4SZPA8ZIg0NTofmiJp6YbbIYDgsZ3YEk4QjmA+UV84VlPwbwb0LL+HTj1xuNxwyZqGQwDLdQYAxAtRlCzam4FSdD8SnH5je2CA75ClNAwUoYph28yDyF8R+vN/AJIqZxr03nxtEcmJ5SXnEaZygQT9sLs7BGoJBa2p3WQ1jZGqmnltxsDWKnZyc3D70GlezKVNTojjQwEYxPC/LVrtb2SVPu7wa48SnTEamTPCpRnzYiCxA91W09iRnGQa+mAWGAwhM2KKnkOpAdOjcmS7Kwxg7mKBYWYNeEB96zKiHOu3/Lc4RCbjItkMFx6LUQpy/mukKtoL1TwaO6Hvp1UVTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(71200400001)(66446008)(86362001)(6512007)(41300700001)(76116006)(66476007)(26005)(64756008)(91956017)(186003)(8676002)(2616005)(1076003)(4326008)(6486002)(478600001)(66556008)(110136005)(44832011)(6506007)(54906003)(38070700005)(122000001)(38100700002)(8936002)(83380400001)(5660300002)(2906002)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nQL1zJFaMnXG8NnBg2rQcHopfGHRBTXymwdrNPCj6aNzz/YMOjKxwi/7DY?=
 =?iso-8859-1?Q?wmFWuksXYuxpPvoH9OJC4RWQMiYyTIgq2JRpDLG23uQrAkRvK+1rgbCxqr?=
 =?iso-8859-1?Q?tDfd0JAQ2YlbMgDZgYrOUkVp4IKeJjgNq+Q6ucFkH3yAVLF4CGjZ93QOuT?=
 =?iso-8859-1?Q?cZ2B2XenSoNNHuyWIAT9hT+V3zN7k6f7uYtQzlgqH/WQGrM0/ydxlQxQU0?=
 =?iso-8859-1?Q?1mjjin/wrqOI1i8csosz8ZN5+jurNIcrvOaHMJ1r1FT4zRbT8RWja6i8Sw?=
 =?iso-8859-1?Q?QME1SXFFAQDg6xW9XhDPnGowEFUkGqbMhcEjKc/5okvjiEjFrJCh8F+wc6?=
 =?iso-8859-1?Q?ekaCHTwd64KiR9guPErHxGQqfxHoTb72sHDCanjv20c/euaCRJMIQ7Vrti?=
 =?iso-8859-1?Q?/P69272lU5twjke60bbapf8XaiiYEv4lV970x8HAFunQOP2ATPXsafyT4d?=
 =?iso-8859-1?Q?eAC4uTcFNi/XJSjywXH/GIdCXy8aV48Jdm0ak/qjOpTVpU+ZxH+v5yleGt?=
 =?iso-8859-1?Q?VD+Pq5iw2zuPa2TNZaoaIECLG8HkjS9kZBBcp0cN4E6KhtQ7MlfoxeWtIP?=
 =?iso-8859-1?Q?demFcihqgBcWYxzwK8wIcBOgiOWkrB2BlG7rxc3w59CC4CvrWdsKus4zYg?=
 =?iso-8859-1?Q?A6VnebSVzYElJ7jYGDhn8axN4ESrvNUDflU1cI64NXbhNG21dN8weE76b9?=
 =?iso-8859-1?Q?03xh782BbqQ454+EtZgLqv2xsggv4L17tvVz1r0Iz980ObTwlsO6XAugQt?=
 =?iso-8859-1?Q?PHzLwZS5VV/L/8sid51++770jLUyys740f5ETg/7OxXQtNtqCCaxdMb6ix?=
 =?iso-8859-1?Q?X8tntFFvh9hRKQCjN2ifUOhvR5BKy5QK0iCUxA8VO9jfoEvdWgiS1aZS9b?=
 =?iso-8859-1?Q?wa+pjL3edU5HJxaXLU8ynF/k9nGbW0/BZbSf/PDbERYn6qJcP8erIeYcOu?=
 =?iso-8859-1?Q?iufJ71SOaDs2Xy9XwnqBH0GJeInB4/OQyENK3UYSMJbYBecLRLZzkSLW6I?=
 =?iso-8859-1?Q?EfGq840xFant9Bxqj/3DgUWvOUnfgY3uw6CF95RAupsYkp3W4NfoHo7y5W?=
 =?iso-8859-1?Q?GVw9NN0d5MqdcPxtG09shLSo0SUaVZuO38nqFwA/zqZgtL4yT5CtvfOlce?=
 =?iso-8859-1?Q?nhaYONAtZRymAepV3/I2K2vx1F+uvGCvAnnliVBIJ7YSJRqXRhfTOPoO88?=
 =?iso-8859-1?Q?uwN+AKBK82dzhtmN1D/m9NYXes6ewAlCSH3B69nAClJ/rhL3wjXTm7qu7v?=
 =?iso-8859-1?Q?XcPySmWehxL3R19I7IDIMq8Eq5RgingrqewhAhaosdXMnOVQihwYN4eSh3?=
 =?iso-8859-1?Q?/PY9muojpGv5pTVOtTmW7oSrGVZJR/Nv90yl+eOM36uUqlgiH841AAqUwR?=
 =?iso-8859-1?Q?UO9HTVOphn6W96f2yKUkSoJp7HHrd7tKzmurtlmJVgopo0FGiu/tKuX9L1?=
 =?iso-8859-1?Q?CvP6heg/AbTxMarjxn4L0crsbsacxZFPurrlhgRvWw8GkCtDPQHufep3Uu?=
 =?iso-8859-1?Q?pnqHnVylmJ1PqAuyDGkodtAtjyYwTQxr33NlKIJPam2y8TGo5WtEhVEj7v?=
 =?iso-8859-1?Q?XPQH2omtHdlmuhuxe4+tOs9w7IDcfIKoREswVSd0Th4Cuos31I5P0RgWhd?=
 =?iso-8859-1?Q?SaZetJWnGOd1Kiv2PlObeKcqIeWRLxNdyyesrGkuIA0cOliCL/0eNedQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10704a02-7378-44d5-0d4d-08dadf96ca34
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 18:53:15.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oocB3FSkq2dwdDljudnn/b43PE5qP6GPCVuMoYrrKjbQUeJaESgH2ubT/m31hp6EvtFO23DTSciSSAeMNGgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160165
X-Proofpoint-GUID: CouvS3i_rwQ-t3pY0NYDeZ5XVeelIDpa
X-Proofpoint-ORIG-GUID: CouvS3i_rwQ-t3pY0NYDeZ5XVeelIDpa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport contacted me off-list with a regression in running criu.
Periodic tests fail with an RCU stall during execution.  Although rare,
it is possible to hit this with other uses so this patch should be
backported to fix the regression.

An insufficient node was causing an out-of-bounds access on the node in
mas_leaf_max_gap().  The cause was the faulty detection of the new node
being a root node when overwriting many entries at the end of the tree.

Fix the detection of a new root and ensure there is sufficient data
prior to entering the spanning rebalance loop.

Add a testcase to the maple tree test suite for this issue.

Cc: Andrei Vagin <avagin@gmail.com>
Cc: usama.anjum@collabora.com
Reported-by: Mike Rapoport <rppt@kernel.org>
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c      |  4 +++-
 lib/test_maple_tree.c | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe3947b80069..26e2045d3cda 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2994,7 +2994,9 @@ static int mas_spanning_rebalance(struct ma_state *ma=
s,
 	mast->free =3D &free;
 	mast->destroy =3D &destroy;
 	l_mas.node =3D r_mas.node =3D m_mas.node =3D MAS_NONE;
-	if (!(mast->orig_l->min && mast->orig_r->max =3D=3D ULONG_MAX) &&
+
+	/* Check if this is not root and has sufficient data.  */
+	if (((mast->orig_l->min !=3D 0) || (mast->orig_r->max !=3D ULONG_MAX)) &&
 	    unlikely(mast->bn->b_end <=3D mt_min_slots[mast->bn->type]))
 		mast_spanning_rebalance(mast);
=20
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f425f169ef08..497fc93ccf9e 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2498,6 +2498,25 @@ static noinline void check_dup(struct maple_tree *mt=
)
 	}
 }
=20
+static noinline void check_bnode_min_spanning(struct maple_tree *mt)
+{
+	int i =3D 50;
+	MA_STATE(mas, mt, 0, 0);
+
+	mt_set_non_kernel(9999);
+	mas_lock(&mas);
+	do {
+		mas_set_range(&mas, i*10, i*10+9);
+		mas_store(&mas, check_bnode_min_spanning);
+	} while (i--);
+
+	mas_set_range(&mas, 240, 509);
+	mas_store(&mas, NULL);
+	mas_unlock(&mas);
+	mas_destroy(&mas);
+	mt_set_non_kernel(0);
+}
+
 static DEFINE_MTREE(tree);
 static int maple_tree_seed(void)
 {
@@ -2742,6 +2761,10 @@ static int maple_tree_seed(void)
 	check_dup(&tree);
 	mtree_destroy(&tree);
=20
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_bnode_min_spanning(&tree);
+	mtree_destroy(&tree);
+
 #if defined(BENCH)
 skip:
 #endif
--=20
2.35.1
