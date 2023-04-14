Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF86E2650
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDNO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDNO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:58:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF0977C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:58:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EEnVUf008597;
        Fri, 14 Apr 2023 14:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vP+4LFQVuudNT+vgk5ViGBRjw7ZjUDxkA+sBSq1fDDU=;
 b=xQK7iKkbnXZBzchfsmfGb6VAj1XPCNbUbV0NGGq3ZjbFtPuBmg+46/bm21rI0DgqL7T8
 Ri6UWS2MqHHvr1eU1fDEFBS6EdMTpX1TFTQcfVT6mEkyfGG7w4YUh9Dl6+HJwznkk6zf
 ry+GTHvNRSz33+TOkv0PgM/UHaoHoiyENYd0hNjYQTLmsKSVnjwTbp5yAZBw09M0TkdT
 8So2mzVHX4x3AAZfSHwuRNrtAcofSXM7qGARBfgaEmIqCrB4WK3gGgiBRlmt1mC2OObe
 hq4udxo+OYwWU+jzJwUuvBEMTEjf4682XramADbRZdlou/zaid1HB+nN17MuDnNnkWyt Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0etx11x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 14:57:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EER87T037843;
        Fri, 14 Apr 2023 14:57:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdu1pup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 14:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9h/KFHGjUpNUzNCiEkjhbJ2WuN384rqV9jWRpaKX7qAUDQhggKdx4P461j2PaOl/kC4fTi/73sIiIC2pqbYuKHm4uewInAtyBRdd5j9F8FeQr7GwSmG2WiqdStdcUMh4KdHN8JnW85Y6ldUEsSZa8qat+v7a8rJmRh/CAX9uC18J8EYHrx3PEgnlEwlPFb4EDkauHhIMgWauMsSARgEgkYO9JQYvie4PTCW4FqN9axqiG67A+GqhmMHFEDDo4lp6E6/BZg1Jan2HQB0Ek4z/yLB09wNEpB3jB9im3e58PooIpilzuOekiUX3gzecwkgy5OA8w4TpRmveAv1tejwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP+4LFQVuudNT+vgk5ViGBRjw7ZjUDxkA+sBSq1fDDU=;
 b=I0zSe1unkFhSj2poj8vmFYwntxpIcP/rRl3KsjMg7KXoBo37Kzc05Sj01z+Kvbn7MToTkYXlNUy31PkPr1B5JXCXyJfKeFJf8u5H+q2Eal4Wr8xhqDjvRanKTals+5F2IJ5fxd0oYAueRrwPpsfB4WfdnbQpEtpPN6j08aVtUCM1wiqJuFz7MosFxprETCbd2EUGerNPFQiF8cBBr2ia4CLlkpaH6CljBIGIFq/gNTgfzd8YJdLdrYnCrggJdijPZkBP+oFGnF+Ro6eM2wYD2q+3fLBZ49m8MjcXz20oDoeVYDF4HkNIB7U10z0tAhdrlW8e0gx2UmW1sehpqspSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP+4LFQVuudNT+vgk5ViGBRjw7ZjUDxkA+sBSq1fDDU=;
 b=rnprVvxeXChbeFEsQwGt1l/lGqeGl+BKg13lrA3weLEroRnTP1Ds0oD6JRSmmxjT9VWeFvgQ3yYaeUzo0V+FeGCSuuRIcnT31tHpSCDiDwy2rY6uZa1p8UkPhiom6yhFXSdMdn9F9jBGkxyaLpfNSGX+YulqUfDgwuitT8Fai3M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 14:57:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 14:57:53 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/3] maple_tree: Fix mas_empty_area() search
Date:   Fri, 14 Apr 2023 10:57:27 -0400
Message-Id: <20230414145728.4067069-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0407.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 798cacde-e3cc-41ca-eb9e-08db3cf89fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcNPEAtvmlInYIj1qEyCF5g8h4Twm8sXiiuZEYnLggpkv2LuG826RWI0mt6KPA4Vg50VeRn0/RbtsdweW5sRXxG/ChD9xbxAJfoGpeDcUVDKX2rpIjg2eduIgymwB3D1OMwkRVqS9kfIFsSzr05lPPyyYFe/OP3gTTgjBuCja52tUywvQ++AZVhhRr7pUAn68o4TwWSpPBdXUwAa28RRcZcv14m0kaTYXPPIdVrhvQNy2ovS2WPbkXXvkQV0B1TXLNw6okzIz3EYMxQpK3waDgXUiXdkNP23ozg+IzSVPCGYVtbafd5NqCjNhQgljotvQe8LXvAN9tHhMAHnaSL5Ui7QRMuCcoVvAANafcXEO/6Hx9bkRBQVPqkdOVD4Ub035uYPmTiMhqithuuqiV3C2h3NPjMGVdpPZpUOYo23X9mtUWxiyM5Q3y6pNlGHt1qzgeH9XkNBZkSmpMw9Be+gmq4cYYtZthkN2e4Pm9U801W6f9awQB1pif8gVknirPNKuirniJ34RgyZsBZMetidu0yGfTRncL69dJQoscb1LNly/Db0qCWwHenObSt310um
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(1076003)(6512007)(6506007)(6916009)(86362001)(4326008)(5660300002)(6666004)(8676002)(6486002)(36756003)(316002)(8936002)(41300700001)(54906003)(478600001)(66476007)(66556008)(66946007)(2906002)(83380400001)(38100700002)(26005)(107886003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtU1qLgMPPILyTCKMSoD+0/SP8Q/JeuvYcIsfuBJttlLIOsmLyRgd6R+0R9A?=
 =?us-ascii?Q?UZU2eWUsLmUOMn9kA5dd582q6XprEv/3ZWPuIS+NoWAm2y81b+yCTVtcONQF?=
 =?us-ascii?Q?k23oz3HpdPmpt+XIBO3KK/frqk1aef0hfEczG9rtx+F7QGfiplXDNlwt7vdB?=
 =?us-ascii?Q?4vxj1Du8jRQ4SExvA2Feq+ndTPScw5cO4WBeYJkac5jSrHBkLkfZmfN2tyhT?=
 =?us-ascii?Q?Xl9EGrz2BTHvZLVSgsLj/pA16HXKgodN34DSctsTBoAqjwaEh/yBWIYFRuUb?=
 =?us-ascii?Q?+q8z+nvcwnFVX4qBmDUNLYLdCl4/7OT0HRNDBFduYBTPzqYFHenPsFShvMR3?=
 =?us-ascii?Q?6IWMCf1rzjIzGVnFVLarUDYSUGRA9IAkzrI4aSi+uBbMr4GfCLbNPw6hj7qd?=
 =?us-ascii?Q?xHC/4PXMiq+By7pb9Guh2faHfiAL83uT/3YIv7er2OtuAGmMxsgEACfuWBHn?=
 =?us-ascii?Q?+pmMbo0/ImKJKQkjalY9JZUu/APy4QFCdGPTU+2JFlZj+RsChIyJygHaZzye?=
 =?us-ascii?Q?ViqfGaudnZhrVT7w/Z+gb6wHhHYqftd0Ws4WdJxlP3biA2kql5AlBNze0mv5?=
 =?us-ascii?Q?49o7nUL0a9jd8+C+/cKrdRHkfqDq4ANFYdvjGOynjaBcxjUO+uq7WUZrnNpI?=
 =?us-ascii?Q?ebMEbpmQYPiUvb/hV2IgLirlBusd7MsxOKl0I26NNbFGpVvJJ/eWhgFMlXw8?=
 =?us-ascii?Q?qwNyDxlZOFKEDPNEnrjQfcthNXO8cNQkrsyHQxaxPl272uwKtyrWrKjFEz8F?=
 =?us-ascii?Q?1kZu6oTH/CzW1mUIUfFOEHzcH7heIROq3DrzN5qKarNxYh1Z1V8SvQhUVkGL?=
 =?us-ascii?Q?3DR2xg34oUdSh9rwRXyiU6TuZHUSGJnJS+mbWl32YAMfdmpJ9uTqllgJstNB?=
 =?us-ascii?Q?lgcOwNu3MM3Fnl+mGCu7nHRLtmVaU3PmZFLXgIiQqk1U1Oj0Vx0EJT08kXbE?=
 =?us-ascii?Q?XaM0yUqUMjVb8/3yW0bJVJ8VmDB5WgvJftotfUebMmusWUaXk057IsMbuk5O?=
 =?us-ascii?Q?lcgWUf0LU7N7Js34/H6nNhUaq6U8K24pVglg1+YR9TUoG6rSMkp4/OxsA1/5?=
 =?us-ascii?Q?ca7bB+r95LbJCE8Xs1X+FWBqCjPdUYS0S1KQfxVgjiU8UPttQe3PRTHn1okU?=
 =?us-ascii?Q?SkC911FZZ1Dv8WMElj7QTfEge+eYVroiRjTNs0SGy3rHJtEju2tIAjeeUqms?=
 =?us-ascii?Q?zjIyNajNh3VXJQdEjT92B+viZrcn65ekhX88dXrNyuXrw+WaP/5bobPK3u8+?=
 =?us-ascii?Q?DY/+m00MTdF6tpS68s9fOUchcYwIWvklQjUzD+TyoI3pyPLE89HcQIfQW7HM?=
 =?us-ascii?Q?oSj9pksQYMIdy9Wuf41pgPuatMr5d+v56SwjfEl8Jvs6GL+xj7QkNrVZuP8y?=
 =?us-ascii?Q?pWym8PBChVQ0ykmL8GkeYDabPfoY8JXTQGfW1Cj+OWz3mh8M9AhKMSbhYWzR?=
 =?us-ascii?Q?JxKWWFaDHTXM6dAC5wgdEVmkXW8IknGcPYd5sFMa/jjQSG4Vm0qU7pz5xxf9?=
 =?us-ascii?Q?6pIYIsGmocGeE67P1OdDZsWyEI07UhiRvjiQmeItxRBcHDhyP7YpROG4Iiuf?=
 =?us-ascii?Q?QC0xejVH3sXu+4at/f18/AUc5/q5E/kgxglUWy5B3nE34aYlc/IO222Mhvtj?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oDLZsGuDBSfaCliE9NHsFCq5825rhtNTNJZbJMR1j6cYccIh1an/ZUN7cs+izNAXpUJbRgtb0u4hNLA9oq3vWzkmIkvLZEy98U9ticNMU5LCL241bbenGSiUGl0kxsalGXZKWyQ6O+VAPz3jN8wTwUgntSrrKNLthorLkWs0ghzA/R1WeDniY6eVh6rg4JtTIYcQVkEsC2P+mTqB71emzkeWU2Ns+KcXGzCBaTfQ+WD22fnFQ202KnqXTDm6MlzjeRCDsfsydV4qLyg3I1xdcrdT3T9NizmsqVW1O5lElpnqcKKMDAYaa4UHgVGdnSml4uXRl4qyfMuENAMwFNl8OD1bFxwsmrXPaAInUgE/QrTfkrlB/fYaHspsHdk5+6hbzrOLxWDi5NmoVBi2N4VuJlr7jxtB6wY8ltemOmeFNzdMuk1lEQfrnyDrvw2oRGrArZV2fsILL3mG+K5DbjeIhr9E5DHWUFB4zwIgNsc0mVyodggxpWzUf3E5Ou4qkzm6rB9PWMs4NzRi6BKivvVgXmwG0iAYo7rAHxZgA3BUN1EMLGiA7HrQJTZ3zlAhNxmM6swmiMIxb8gdc/RbkQUPNa6S0gpxogakRgy109eJe9UM7tPdp2TdKe/CTF8Mtb/AWisGkUwkoog94yz1nGjtOifREBw3Qpd7quduqc4WS4SMmJt1hnrBaqTmmFOWQ2ibVWiiQgogGuM74XFodDzTm7YihFoRtex7uoWRkvcID8xBnqYVhBkIbyINZ91Y+F2lzo2bqi/36Uo2rObuzEGRuIaULIGEo6WPybIVBHdJ6j5JGqqhrDIEVc+mfLkcvGSBxjYDUN7MKD5FwJyzYPmbLzIiBmvP+A2bMkjF8anL+LjmgjjhWCKAisbzorFeNfdB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798cacde-e3cc-41ca-eb9e-08db3cf89fb2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 14:57:53.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaIwNG2h8aJ+REKtG8+d7DGaRc2xM9NcF4ijHZ0o8nbOcWaY/+FXIKF3LVf06Zpz/L6LuN6BxEfsEZ0m1wcG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_08,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140131
X-Proofpoint-GUID: SRj6rkdUkzuQ3ygcyh1RihbkVsu3M47D
X-Proofpoint-ORIG-GUID: SRj6rkdUkzuQ3ygcyh1RihbkVsu3M47D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal function of mas_awalk() was incorrectly skipping the last
entry in a node, which could potentially be NULL.  This is only a
problem for the left-most node in the tree - otherwise that NULL would
not exist.

Fix mas_awalk() by using the metadata to obtain the end of the node for
the loop and the logical pivot as apposed to the raw pivot value.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ed350aa293b2..ecf4c1c0f4b3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5029,10 +5029,10 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 {
 	enum maple_type type = mte_node_type(mas->node);
 	unsigned long pivot, min, gap = 0;
-	unsigned char offset;
-	unsigned long *gaps;
-	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
-	void __rcu **slots = ma_slots(mas_mn(mas), type);
+	unsigned char offset, data_end;
+	unsigned long *gaps, *pivots;
+	void __rcu **slots;
+	struct maple_node *node;
 	bool found = false;
 
 	if (ma_is_dense(type)) {
@@ -5040,13 +5040,15 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 		return true;
 	}
 
-	gaps = ma_gaps(mte_to_node(mas->node), type);
+	node = mas_mn(mas);
+	pivots = ma_pivots(node, type);
+	slots = ma_slots(node, type);
+	gaps = ma_gaps(node, type);
 	offset = mas->offset;
 	min = mas_safe_min(mas, pivots, offset);
-	for (; offset < mt_slots[type]; offset++) {
-		pivot = mas_safe_pivot(mas, pivots, offset, type);
-		if (offset && !pivot)
-			break;
+	data_end = ma_data_end(node, type, pivots, mas->max);
+	for (; offset <= data_end; offset++) {
+		pivot = mas_logical_pivot(mas, pivots, offset, type);
 
 		/* Not within lower bounds */
 		if (mas->index > pivot)
-- 
2.39.2

