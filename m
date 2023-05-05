Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996AC6F87E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjEERrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjEERrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:47:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D01D96C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhMLV014811;
        Fri, 5 May 2023 17:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CA7TjhYz/vx59Q/uHiOAJePZOs9K1Q07auxG39Vh9+I=;
 b=QMLIVu7S015P2YmiLXMZYSvyTMbWFvh6TOFhVhDo/Bi63VABFde+C21m2RqmUhysajgn
 TdhbveLz/i9+S10VEWv1sNdRnVXBectqasX1QPkseja1wqxD8WqnBGjZ6rkR3pHYKMH2
 Vrsfr5OZE3t26ykRQLl7RCmTIiw9guorzlYYp96dDlG/Sx6ZzfuiUT1ojsMclK0uVNfB
 bIhkQdiAp21wjBDW8YpLyB5JhFujJZe2n03yRuF/2RuCabgOVKd+S5dne2zGC6IBOkdY
 2t9uzY7i9wzxKJH7i0wTx+eEVpXU15SLbgF6R2P4lEFT7jqekCu0OUfJHBlNeJwbb5eU aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snede0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345HJ4n4040541;
        Fri, 5 May 2023 17:44:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa74pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGonLsfDzPaPppP9YU8ESmClONIw1qpSVIFxo33Y7jsrpxJD3DoExAomVcc4kpIBhA2VBUHD/eczn3YbmYeM8sguib3zU4lzJo38m9nACSuKv8HY6UYBnzLym+RnGqH5dI1YTEN+7ShAEtxmCp5gObMRPcxR97FGavNZDdacK0hESTVTTsgjELXVZTvPtIIWWS/REJu98JbOV2c479VfEpT/HzT6JyBhWIp6/Pks+IVv7/NHrD4Sy8DGmpHYL41Z9zG8nMshy3RvNpkIIHX1SK3RE0sGsGXWImxyURyOykAy8St8JlfKzB+wkx/GHCFkuFvbvlNiBBhnbmXFwwA2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA7TjhYz/vx59Q/uHiOAJePZOs9K1Q07auxG39Vh9+I=;
 b=HI7bFEy4tQ7NLiWH/6xLsk4VZTLInF9OKkemQvNwJHldtunWaaWIIDtg/J6ecuqimOBaO9x2fkwd7/qmZ2Lx8Mu98gkfHRdV3tbp5igtKskAw+KOwfEZa/Z75b9SnDvKavXzh0bg216L7XZf/K4nWBEKX6y7ezRBuOMKB8ocL8m3yaZGeW8QMCabBJW9XLNN+jAB434W6RZCxa7cpzfHDExuloCn8bmk6p7fmKuAJ7+Um/2lRhgYLtHysRKmbOw8Q8KJJXKK4xeoG5RVCezcN1N9jd3QRemTxyFQ4nQCTPJoCoiMdfNeV0PXJnqj+lhgJPaVy1EaKIaJRGUVzPzi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA7TjhYz/vx59Q/uHiOAJePZOs9K1Q07auxG39Vh9+I=;
 b=PUA79E2pLy+w14SDM7hdXefovq74KBt80nGWz7eegRN7LMo+fFuNPxwPSUUyXppgxWDUxljWGtv3p3novyG8M8Pk7Sg5VHG9ZcrwsM6hjbTbFzHhWDMK6nyXNjHf140cLzITOydjAQBbs62fMp4Bd5tyd8aqBJMHwXkJBHD14FU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 30/36] maple_tree: Introduce mas_prev_slot() interface
Date:   Fri,  5 May 2023 13:41:58 -0400
Message-Id: <20230505174204.2665599-31-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: ade42863-8341-42fe-68e8-08db4d906e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVAqzFOS50BD0j6sifO54mDOVa+Y0xP4yxIS6jtH+SZ1hY42OCp8Z8BtOBd2RqlowJ2kQ8+YoMRehm3zRZB8C8tJ8zg8RA+jhgtiZXBACEUHOwdVbBg9AbWXv4OtxPcgV+9UCxVZAK4dKj+p5kDMjs6tL9VEhtU8DM55KGgs+XYnhFvIvFUHJlyAwaTGa7ptJNK80lCizVcoD6CDVOjtTUq66T5V06YxQTFzmBDKqnFiLaH5cm+mGWXiFV9MmH8t8vJwY8WGONgPesza0wHZJUxHVzfUadtDUzbPyMIL/gFjaD8BvSOjduE/hCSR8mNlWkQGUZ2SlQTmIXQk/Hwz47tXp3utSKVpGGlVO9+pfdRyCvOyQUtqN/VkglW/3nzkZgCNGgZ0h+NT5ifBDNcD8WYjI/thADZJ5QgT3rwNa/IFvegvtgEQsE0nQgWg708uX/FjLebP/H1NbW2lVjONdExeJfFyQ4f71mr+HowGJxCpeRsnZTH5SY4cLEK5GnNoQyvgywd2NU0fx/fyqcAAhMXotbySZiroI9cjQAXNI2FoJNjSUQyt51if/mgSYJEe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2JdCCRyFEuE39RCezX04HYkKltHrZ0x4Oboo6i7pE678fIulTNOrSMYQGcG?=
 =?us-ascii?Q?y9F+BFCkPVIUWuQCnVeoH6VCU+BUPZZ4yGCu1ECaIopRs/qOh52uC1+A55iz?=
 =?us-ascii?Q?1FLqccWu/gFYr92UILYigtNMTAa4yWzKduqp5G8seIEZ1dX2ARk4gSx3grPA?=
 =?us-ascii?Q?jxUrNlpaPL3gU2j6cLvZ/y7cAqvipsYZddZ9qg5cxP2oDVcXeJ3jjgpcQ8g8?=
 =?us-ascii?Q?X0BhHn6eSn+5bXqgsdJ9qvT3A240SEYdlQjYm8hGgnfatR7NB5LhC0p6nul3?=
 =?us-ascii?Q?j6vICzP6oGkWBw2Lv9ZO3qXd7xI0kL3hXnSXscWaoXAMHibK7I0xYKl7Enbb?=
 =?us-ascii?Q?aMAs5Qjs7sj+StHjRnDoXfW0Yfzozq2uVGi3clpNeuqtA+JUbUNDqsjVWtqG?=
 =?us-ascii?Q?EnkJXi92GvcPsTQqDceDziciTKqsENEdCB/2l1ylVp9VdVnsjrKG/bCndxOP?=
 =?us-ascii?Q?DKaFvLybNtRyxceaytAT2remv3uHUtXBpHE8qoD268aCfNGsXnE3bXWULetQ?=
 =?us-ascii?Q?BbNzhCd9RcqWHaosRydKEaN6suOywFhu8epr4rckIQ8AeP7jBbsP6pustfu7?=
 =?us-ascii?Q?xdF0V+3z4sMerQDBSz1fYwBuwDMJnkR8lDODqWIvz21ksn/cJ46UhPpJuv25?=
 =?us-ascii?Q?sFxey7d3KrNm8zL4ZcfBghqDplc6vMAMtOL4yEwSVTyL9Wc6t0Yp/uGrzbOI?=
 =?us-ascii?Q?+OdhLEAzwrXg7VuCsI9Uk4xRCkJ5DhxXaUu14fa05emsjNUjjmRJxqJEpNGb?=
 =?us-ascii?Q?7z094HcE80JtPe4/A1B1G5YfrzJddKeqoWPR3tuEi73UL+6LJWqIhLX5DR5O?=
 =?us-ascii?Q?bvAt6hULxLEckw1ydewunxD2luzXec+BPRuAcRfWGdoc5OEnUfHGOLjKYquK?=
 =?us-ascii?Q?UeZGgP1BO037dCs2egE0VVF7bUWCvqlitxA1SaO7WrtC3x8XgBzQzMOK1MUu?=
 =?us-ascii?Q?dP5lMve28qh+j3cpbFWCeGMrqABGE2beD0S4nRZpXVrE1KCO0DvJlH8cm+ts?=
 =?us-ascii?Q?zgOevJNWB669ErEA8q7ez9UmGC8flXgNNjrTcXzY6ANM6o3Mkuw9eE2VXhE+?=
 =?us-ascii?Q?wakI1f0xhAfuAAf7miv3W7scixizbA1WeM0FpnJWeqLD1XV4P9poqxGo+nJz?=
 =?us-ascii?Q?ouAVinAJjmR5ELmj8y/KOt+zaO7cKuZYej2NU6HUNezTIw+pVoVS7m/LkAOz?=
 =?us-ascii?Q?of8+EyVniy6ysUr8eqQl2j3+lpt5iwWV6FwvrhoWDA04D8v4XVDCT2muxoM+?=
 =?us-ascii?Q?VGPxLiJPODsTm/OyjUoOdp5jElIAp60sJChAgV/abjWFEX9qmYiArFAkgmtN?=
 =?us-ascii?Q?rMVohEuUalAYgszoozrcVCgC+E/s5PdWRecbaEv9f4tvLil0in1jEpStfD+B?=
 =?us-ascii?Q?fbbG8h8oaAEdEaUda1zyRN2pU4L/EmpKpFwVD46xhAALtM2NjzXtApzrolwu?=
 =?us-ascii?Q?m1SpqMFPAohiXO5wWAFPIrO8sT3PvjoUS0df8iRU4BiuEV1NzYlSnHSrDq9G?=
 =?us-ascii?Q?e0sa0Fn2mov8S8jqBFrz/+/imamdtFytXK/QVgNUEw8SW2rNDWcyH/F6/aUE?=
 =?us-ascii?Q?ZC/fUzcrGC9sYqG1aVSoKQtQekVlSOvVNV0IM0XDjRH4qzkB+zBnlNPVSdPs?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8eW3+kgvy95HdpjqmCWK/I2aH0g4ACQ0z8NFYKsTdihXT0/yCz2ydfS6yGL6Mujkok0YjmnEgeoaVMAkcXHR+9vfU7Sd/fyug+FP0ZgfwvRAESsa7T5KvHQt5szpeh1TQfwFi4wH7d9X5UQm4j37cA8WEHP6SeTGqIDSsnPmnLR8rnJtaoRffj9Bni8MeiIxzFTbP2ZH34NIzyYbhFusLJCOYfDPj8UEAiH4+RTso+QcCUhD4wjRJZsQ625j9YxUa+XCSHo4kki9PcBWwSyFct30LQ8EjA2IM4BYQFOmEby/GAN7Twoq5uLMcYX94U4910CNq5M9g0HKZUiNYSuvRTroPG1FQ/wp0YHGjAHhfB6jb/78ny7vSvhZ+j9Eo2gBLPGRSWfAltzOZ01KFXOsQW5XQwJuqNRZfwXm+X8UoQeUmH/VPiIgKoB3UOSnPvl8OBtK0vHUSgAB8d+3k8pb9dlk3uHgBb9Vq/ifDgyGctmcIJuCm4A5RXO2S4oOQgUmSDMQem2JNQIcSWr/jg8hJOba2tosbZ9TcTRvNq6KycfbrL0Ya2I3EG4Kz6zZ5quyUycfGrcPkV/DoEaYiVOTKmkuQLpnwPGEfqNAhBrCTdUSa9Ey5g+cZXPvNfBmFeOPfOyj3StIuJzHOm0mxv+RSbAMLIPb2LA8ZhBm/60Fq289Q4SLpbzHzowtRPku/dNYUHPRypY4uo9ZGoHxpys/VcLG9oi5/bF6xgm09Z2FGs5xHV6bVm5v0rkEQAosjz9pjrw/r6q3Ja/NHb620rVybFetrw3KJqWcohFHZUDGNyH30AY7p9PlDzml18gyU+/myza57Aqt+h+74AsZ+i7aR0j0K6m9D4Wc5xxAocuu05fTD1Cbj3e0r+M5awBWl5zwy0jWbkt7z/iAhtmnk77ZSg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade42863-8341-42fe-68e8-08db4d906e7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:52.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucTWXRalRWLhz3gKCXAoBw56D4iMTnd7X9mk2NsWnlLFM8eqrP8dgjuvM22zcXzK6KRH6BQrPkKGs9xWHQB1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: c9cf0CTyHw6iQVJsRmQKihWYchOaB9LM
X-Proofpoint-ORIG-GUID: c9cf0CTyHw6iQVJsRmQKihWYchOaB9LM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the user needs to revert to the previous slot, regardless of
if it is empty or not.  Add an interface to go to the previous slot.

Since there can't be two consecutive NULLs in the tree, the mas_prev()
function can be implemented by calling mas_prev_slot() a maximum of 2
times.  Change the underlying interface to use mas_prev_slot() to align
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 232 ++++++++++++++++++-----------------------------
 1 file changed, 90 insertions(+), 142 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b0f185a8154b4..e050fd1f7cce8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4531,15 +4531,19 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	int offset, level;
 	void __rcu **slots;
 	struct maple_node *node;
-	struct maple_enode *enode;
 	unsigned long *pivots;
+	unsigned long max;
 
-	if (mas_is_none(mas))
-		return 0;
+	node = mas_mn(mas);
+	if (!mas->min)
+		goto no_entry;
+
+	max = mas->min - 1;
+	if (max < min)
+		goto no_entry;
 
 	level = 0;
 	do {
-		node = mas_mn(mas);
 		if (ma_is_root(node))
 			goto no_entry;
 
@@ -4548,64 +4552,41 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 			return 1;
 		offset = mas->offset;
 		level++;
+		node = mas_mn(mas);
 	} while (!offset);
 
 	offset--;
 	mt = mte_node_type(mas->node);
-	node = mas_mn(mas);
-	slots = ma_slots(node, mt);
-	pivots = ma_pivots(node, mt);
-	if (unlikely(ma_dead_node(node)))
-		return 1;
-
-	mas->max = pivots[offset];
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-	if (unlikely(ma_dead_node(node)))
-		return 1;
-
-	if (mas->max < min)
-		goto no_entry_min;
-
 	while (level > 1) {
 		level--;
-		enode = mas_slot(mas, slots, offset);
+		slots = ma_slots(node, mt);
+		mas->node = mas_slot(mas, slots, offset);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
-		mas->node = enode;
 		mt = mte_node_type(mas->node);
 		node = mas_mn(mas);
-		slots = ma_slots(node, mt);
 		pivots = ma_pivots(node, mt);
-		offset = ma_data_end(node, mt, pivots, mas->max);
+		offset = ma_data_end(node, mt, pivots, max);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
-
-		if (offset)
-			mas->min = pivots[offset - 1] + 1;
-
-		if (offset < mt_pivots[mt])
-			mas->max = pivots[offset];
-
-		if (mas->max < min)
-			goto no_entry;
 	}
 
+	slots = ma_slots(node, mt);
 	mas->node = mas_slot(mas, slots, offset);
+	pivots = ma_pivots(node, mt);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
+	if (likely(offset))
+		mas->min = pivots[offset - 1] + 1;
+	mas->max = max;
 	mas->offset = mas_data_end(mas);
 	if (unlikely(mte_dead_node(mas->node)))
 		return 1;
 
 	return 0;
 
-no_entry_min:
-	mas->offset = offset;
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
 no_entry:
 	if (unlikely(ma_dead_node(node)))
 		return 1;
@@ -4614,6 +4595,76 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	return 0;
 }
 
+/*
+ * mas_prev_slot() - Get the entry in the previous slot
+ *
+ * @mas: The maple state
+ * @max: The minimum starting range
+ *
+ * Return: The entry in the previous slot which is possibly NULL
+ */
+void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+{
+	void *entry;
+	void __rcu **slots;
+	unsigned long pivot;
+	enum maple_type type;
+	unsigned long *pivots;
+	struct maple_node *node;
+	unsigned long save_point = mas->index;
+
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
+	pivots = ma_pivots(node, type);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+again:
+	if (mas->min <= min) {
+		pivot = mas_safe_min(mas, pivots, mas->offset);
+
+		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+			goto retry;
+
+		if (pivot <= min)
+			return NULL;
+	}
+
+	if (likely(mas->offset)) {
+		mas->offset--;
+		mas->last = mas->index - 1;
+		mas->index = mas_safe_min(mas, pivots, mas->offset);
+	} else  {
+		if (mas_prev_node(mas, min)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
+			return NULL;
+
+		mas->last = mas->max;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+		mas->index = pivots[mas->offset - 1] + 1;
+	}
+
+	slots = ma_slots(node, type);
+	entry = mas_slot(mas, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+	if (likely(entry))
+		return entry;
+
+	if (!empty)
+		goto again;
+
+	return entry;
+}
+
 /*
  * mas_next_node() - Get the next node at the same level in the tree.
  * @mas: The maple state
@@ -4798,109 +4849,6 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	return mas_next_slot(mas, limit, false);
 }
 
-/*
- * mas_prev_nentry() - Get the previous node entry.
- * @mas: The maple state.
- * @limit: The lower limit to check for a value.
- *
- * Return: the entry, %NULL otherwise.
- */
-static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
-				    unsigned long index)
-{
-	unsigned long pivot, min;
-	unsigned char offset, count;
-	struct maple_node *mn;
-	enum maple_type mt;
-	unsigned long *pivots;
-	void __rcu **slots;
-	void *entry;
-
-retry:
-	if (!mas->offset)
-		return NULL;
-
-	mn = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	offset = mas->offset - 1;
-	slots = ma_slots(mn, mt);
-	pivots = ma_pivots(mn, mt);
-	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
-	if (offset >= count) {
-		pivot = mas->max;
-		offset = count;
-	} else {
-		pivot = pivots[offset];
-	}
-
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	while (offset && !mas_slot(mas, slots, offset)) {
-		pivot = pivots[--offset];
-		if (pivot >= limit)
-			break;
-	}
-
-	/*
-	 * If the slot was null but we've shifted outside the limits, then set
-	 * the range to the last NULL.
-	 */
-	if (unlikely((pivot < limit) && (offset < mas->offset)))
-		pivot = pivots[++offset];
-
-	min = mas_safe_min(mas, pivots, offset);
-	entry = mas_slot(mas, slots, offset);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	mas->offset = offset;
-	mas->last = pivot;
-	mas->index = min;
-	return entry;
-}
-
-static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
-{
-	void *entry;
-	struct maple_enode *prev_enode;
-	unsigned char prev_offset;
-
-	if (mas->index < min)
-		return NULL;
-
-retry:
-	prev_enode = mas->node;
-	prev_offset = mas->offset;
-	while (likely(!mas_is_none(mas))) {
-		entry = mas_prev_nentry(mas, min, mas->index);
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely(mas->index <= min))
-			return NULL;
-
-		if (unlikely(mas_prev_node(mas, min))) {
-			mas_rewalk(mas, mas->index);
-			goto retry;
-		}
-
-		mas->offset++;
-	}
-
-	mas->node = prev_enode;
-	mas->offset = prev_offset;
-	return NULL;
-}
-
 /*
  * mas_rev_awalk() - Internal function.  Reverse allocation walk.  Find the
  * highest gap address of a given size in a given node and descend.
@@ -6017,7 +5965,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		}
 		return NULL;
 	}
-	return mas_prev_entry(mas, min);
+	return mas_prev_slot(mas, min, false);
 
 none:
 	mas->node = MAS_NONE;
@@ -6229,8 +6177,8 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (mas->index < min)
 		return NULL;
 
-	/* Retries on dead nodes handled by mas_prev_entry */
-	return mas_prev_entry(mas, min);
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, false);
 
 none:
 	mas->node = MAS_NONE;
-- 
2.39.2

