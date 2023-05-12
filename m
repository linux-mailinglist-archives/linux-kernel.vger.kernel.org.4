Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2A700EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbjELSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbjELSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:24:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797AAE702
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:23:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4BOM002662;
        Fri, 12 May 2023 18:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hgPz8T1WANsIM3jiTasywPGcohQqXRj1T+Dc+8WldZ0=;
 b=eE9768IkQLA67MoY+zYeuuj81UEV/AwHn9G2vfQpeQCPQPx03D8hzDQ7V1mZaZKfOst3
 UCc/GZqUCRq2OlE+Gedcto9sIgwu8/2tO2nuvgrJnv9fSy89WOMTSNWHaaFaolS0HZYP
 vZ1up8jZ3/4CTo4G/MhrWe+U7gzEG0aHAx3ehA8y1zuf6Tl/JoquAO+PT3wMcV5UJi7d
 +5Wz40QNYPiz3oV6KZqTSBVyl3gMo+D3gthHUEt/B0c0F+6KkE9HfxXS9BO5sJbcT/4C
 FRaXyw+LvW50tCCQ0Dc/bXF+zHMB7etGurZoGtUiTVvB/33AgtYaiRmA9nN0IC8/q+VC SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CIBqZg018147;
        Fri, 12 May 2023 18:22:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77mjmca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhgfXATd3qU1Vm/p26haEATcJmRdqnKgoIn/AZ+QrsjMbIZXOP6h5V7Gm5lNwnpLx9Dr/6e9jOqfUB6nq9HoqLkxY8bRziZzT005NzJi5p7dZdiCSTTfwh8bAnMF3gAc23SgeWg+n0wy3AOD5o7vQPGXzGSXLAYPzzL0KlGNX8fl2Acse77N98o+hmzA2ViUt3hZ8JNjwhoVsr1u///cB6qQckr3Ij/UrP1YoYiT3KQ45fEaTlI1Oy1Y/ZmSZFkHOrP9XyAsNVloaX2+P3t8mknfxtgmLg4RNz0UKlk22rwc966hjmhZ4UMQ45eF23fN+DPMVIQDhkqpupf/6AqcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgPz8T1WANsIM3jiTasywPGcohQqXRj1T+Dc+8WldZ0=;
 b=hgNjg7T7wuDGP6/CkAxlm+TLRk2fMqSkqht5gyKXaZZZZmX/ExzwcD2zAuNrJx85CSQw3sgtuocewXMG2poL+Fx9hlmidFa66pt2IgJg7T2Xui5xePx3D241bhEHI1ZzZoH4olbcfuRueXksL+uIVDCxPyP+0KA43xebZA8fQxkBBNuL/9V99j6BJ4u/fy0glrRbv03wAnPw8Wd08Boi3yQ9FGjVxA68f1t0XOqXe+eF916p3WisuVtt/Fx0St5Ijm2d1zGZyhsGn6yxOG2Lq3X9PHKMH/yxCG/IdIMc4Le+r7eysEe/pzkucVFg7nLeapjHBu9tw5F0l4+77Uh1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgPz8T1WANsIM3jiTasywPGcohQqXRj1T+Dc+8WldZ0=;
 b=ujMYm2TW9pk/rA4l9kTprU36KPEEJu91PNPeMDc95iUh+BE5tN20ZLEIHp9AP4qMiLKfEtimbJFzqx5ataEURY+b1afe48w1R5CqpFvRpJ46rZ8hbKxchL8u3gknJ4OT4H7lSdtAZmh1mmdW3P+vNZqy3hQIMleeFoetESX8f4o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:04 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 29/35] maple_tree: Relocate mas_rewalk() and mas_rewalk_if_dead()
Date:   Fri, 12 May 2023 14:20:30 -0400
Message-Id: <20230512182036.359030-30-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: baab5718-671b-4955-1788-08db5315c9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBrDQZVjwlvdp6GDcwXVKhBhzlVyu8/3/tD0An6IjMGl0bsGGQ/JY4y+RTN8kMnI0TjzFHr40DEEM1ltxQinCbkTU/mM8rbQqpHCdQ2mNxP2wWiPseM6Af/jJNt1eHBt3kRnfPwfxTgoildEr42V2aOK78pZv45c6GA8XUGnFPHxZJ8SbVSfJbRZIKtFclkKoN550GAvll69K7pW0/9WTW2hn6lUeRFpbE9OtizESWWR62c7dL+q7juuH6LBHf/OocLiTH2lyrgS7s7XquZoosODUPJAhKpHp0HgsP2yk2/d2vmcwPHFBZpkTHNsKgvn84CaCpnXk4sWOJdMXc7BHlHfhWqRxa3QLNT5frWsVFyO0qnscYTEdZmNxpz5s9ZV6KAXlL/KFVU0/eIIEL6qaCtyFtv0S10OcIGa/+BvRGuj2JQ+kb9eTWjAYl1O4/cyXtFBRSSDuUBozEOWXBwmsZ4bJJAFLqJtChexynN7UFWdWSSAYWVZB5BXsqMsKYtZP99cabLHVjHtAWFDfYEtui9cpZgM/9F6hnzfAEl5nwUxkiJQ4eGSxLUZiwn1KEWd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJJO1CfHOir5z6LqIB00TrJQ29ljAMoNFPyCnotCshPLPvwycjGxhBWRi2wr?=
 =?us-ascii?Q?uQGMQw+Aq05rSXkv69F3Yp0/cQb9jJJwDQsOfbtS+kqtwpAklATV/bK+XbDu?=
 =?us-ascii?Q?Srn3COk0PUc84PPOyK9KT4UiFXjEv5vxo/yUFKKmmKgLgg6+bhRE1RFDHISr?=
 =?us-ascii?Q?FnqUy+697Moei7sZU18vgLHpTcswYOjdtgIqYN8CjwSDkhtWoe7HEv7QoWAr?=
 =?us-ascii?Q?NCIrP+jl5pjSg78+sPzF0VUA1OVtVD2qIZIPcRq6ILEfymMoKazeZY14lm+p?=
 =?us-ascii?Q?8hr7oPpxFy7uQzAWWCT4cas/PhB7cu1GuJhDx77EVGdM73/K6uZV7MNTvQXP?=
 =?us-ascii?Q?8JXD36Ds0cW6MQ2dJLHwLyGukU1S8+dDgSXxNeLkgniLfBdySRGie/+Xi+zt?=
 =?us-ascii?Q?fC5Xm8AlI4ZV5tAfKhrFs6m9PdNfdAKlK00ev6voXHuqG+01NXNfkQhv7oPp?=
 =?us-ascii?Q?9amdEPhH1c0pyxpZxswA45Ca4JXqyXzFL+OOYRfsqB/E8lfBVU220yqT/Evy?=
 =?us-ascii?Q?tzEx++NDrLlGvwGNvB+IXzMWpKrXoRukQYrM59XXIC/iDEw3SZIWhOa0SJ9I?=
 =?us-ascii?Q?kzlxG50I4Pi0qLxfrqg/1QHvVCSLf4SVKaEVC3ZUEPVna+t38yNE5lAFoX7u?=
 =?us-ascii?Q?GDex+BnTM/57hTitffZyP3EvFgO/aiokSF8AubPoyc4PLtsUMeM0M8wBeANA?=
 =?us-ascii?Q?wWSdgPQpKi7w3hawXLXaUsnhH+omFbiinLW5I3WoyXz39Vjo+hE392jZVQuK?=
 =?us-ascii?Q?6PyMGarrvGniNxa0ZvUpU6zX9hjDW7InS5FopEOHhW6L6oWn9F0WhTi2MCtm?=
 =?us-ascii?Q?Y2Pt4heCgL9HbdyK2Sc7SJzBg2yvCWvB9fFPQw4lMZY2kSFHVEGzcSvxzt1P?=
 =?us-ascii?Q?aNYpzva9b5War6w2+u+bEKMTCq5OCjH5nO+A3zG4Gaudf0XoVKRHgI6GC1U4?=
 =?us-ascii?Q?VdSrtGkzUmY8xA55uQLsFKZfvclkl9HrZeQBA7vXF32INLRu5Q+KYRg2HYur?=
 =?us-ascii?Q?JAYyXqXA9GD8ScD+9z6vENXXsUfgx8KlNTz7cb4ITJE+J4YxzP4X0V2URt3K?=
 =?us-ascii?Q?jxQ3VU7X7eEn2pg6zKems3MFNs6D0pW3wrdMIPEY5dEdIIFG/wCwBUyUiNUe?=
 =?us-ascii?Q?FuGAAoYvoyk3JkPrAeN+DFL6ZZv1iIFUaHswjJ55Npi8xsI5SX2cCyH7sxKE?=
 =?us-ascii?Q?fGvYGPDCSi8MJ4PABY7f3fWOIkEwYy2Gsr6hOWtmp0h6/N3Gj24XljYJcmRJ?=
 =?us-ascii?Q?hySMG7WQ/6NROuMKkc3vvriXQOsjNnGbA+EPzLadqaR5t5bfbd+rgJSc0ZBX?=
 =?us-ascii?Q?eiKiQsOS54J7dpq7fom0xPdWFfpnH1c1QC1nFZG36jF8k5FEdDebsnHbJrue?=
 =?us-ascii?Q?pdCilOBh0Eu+6ZiRRWpn5QN61HGcvJ471qjH53BcWKLGWZJjjSn0TFXdU6wq?=
 =?us-ascii?Q?g4YhCVM9F1+shqPw2InmNAeVPc4Pra87monUgKirLMmfOH72+HmuQitPFmnF?=
 =?us-ascii?Q?Yk1to+eapRVTkbagftabm7rOiRNoOLeOqP2LTQhNr6toH0aD5iASzK/7k2Bc?=
 =?us-ascii?Q?cL+zlIeqvOa7u2UmE4+Uc4gLwaI23UuXpj70Hu6bLJFroC3yZDxMRsNI882C?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HjLvLo2iwLM8dhOBk5jB6IFnzvIWFN0K/TMXMcJEJz/CkDMKIfZH+WEOQZ3uHRfkJ5Z2VK4i8xb4JoamMgEzNbbssJci28WtDE6Yutyo0XgZ0EQs66rQGrhGr+KKkuIonOW6WeP6HEUoNgGqE/o1O2G8UclvaRyJuL5NUjQV1InANstT/ud0pWulH9wmE2KwZybtiql6iKgK0U35xWff4vfR07nE8zyjqkRDkrgCVF33sjgJqO11PXYIn70ZRKYAZYpsiJFyVvvsaoIqIpaIvzOJk/f519vXZjFqc5a2CnWfV1Ca0GKUdpR12J7ZGtdujusRo2+u1lzHCkIcKYWgZP4vt09cIex+wwtjbvBLrMQL7jZsARzFMvqgveCfGj4FgW97n86pBFRZm7TUMBgIVc87s+AeUemlHxET3awWlSazxFP/S149g0D+dz+8QQughZGmjwkDCuL6+Qfrrt0dKH+R9rLUGFObcMCWlJp494DBJpbKlEamuXkkrKM+p42jiuVEPNe/8TA/y+0U16hY2HtNZBROaWk4ZUIcKmGlLYS3/yl+izqBkj2YkWjvz8z7STwEgKNtd/P7SJnMiwwChjDZBguUP6H311+1+pjPK+mHzdsfxvkW/v76lF869zCf9KCO/jgsuZyQB2LCEIFFSbW/lXJAre1Y/mzvom1GRit0Pmd661SY57C5NK1dSvvzftVt6fpodbGU3Oj5+o3BuKxT23vi2KvKDZGBzdLtJnQP0xi1LoOCnabWBW2Q8Tepp54ZYKUgpzhGc0NWlrXd1Q00lTUdXZeZYIDLs+BdbMK5+z/1X7CUAEtkzon7nfayTKhWa8K9RcaybK77GwaHXknl8wnNzOgd4jcJLWLdn8qQi5uUr688+PwvcULacxJs0DP2qO0BIyQ4yy6bHQtuJw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baab5718-671b-4955-1788-08db5315c9b2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:04.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZwji4qVgGazXVT++eVgpfvcxmKgNushUMGV8UHe1ilbqykXq3lB3heqPTdap0sUN0fTGkygi41ieCs8cQatWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: qP5PD0-t1bzF0cOQdCVGGfgbTd2gFRFa
X-Proofpoint-ORIG-GUID: qP5PD0-t1bzF0cOQdCVGGfgbTd2gFRFa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions need to move for future use.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 10b9471a80cdb..c69418b120179 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4497,6 +4497,25 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 
 }
 
+static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
+{
+retry:
+	mas_set(mas, index);
+	mas_state_walk(mas);
+	if (mas_is_start(mas))
+		goto retry;
+}
+
+static inline bool mas_rewalk_if_dead(struct ma_state *mas,
+		struct maple_node *node, const unsigned long index)
+{
+	if (unlikely(ma_dead_node(node))) {
+		mas_rewalk(mas, index);
+		return true;
+	}
+	return false;
+}
+
 /*
  * mas_prev_node() - Find the prev non-null entry at the same level in the
  * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
@@ -4676,25 +4695,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
-static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
-{
-retry:
-	mas_set(mas, index);
-	mas_state_walk(mas);
-	if (mas_is_start(mas))
-		goto retry;
-}
-
-static inline bool mas_rewalk_if_dead(struct ma_state *mas,
-		struct maple_node *node, const unsigned long index)
-{
-	if (unlikely(ma_dead_node(node))) {
-		mas_rewalk(mas, index);
-		return true;
-	}
-	return false;
-}
-
 /*
  * mas_next_slot() - Get the entry in the next slot
  *
-- 
2.39.2

