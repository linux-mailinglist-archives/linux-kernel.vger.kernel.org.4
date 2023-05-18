Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD4708479
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjERO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjERO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:58:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6031A2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:58:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IoJ5006529;
        Thu, 18 May 2023 14:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W28sfOc1Ebm9G6oXnJIkL5YbIyR2oRp0bN+zyezWu+4=;
 b=3YxNQOMSLm8Fl/AJk96bIxq/5lBKdJqNWDfuyK6x8L18iN6pwv190qLqdoUMgUe32O49
 9zReLs4K153qsTLZi8Z8YlytXC7FaST5ipzLWIyw0Uu3ebf5fkAH5PEX5U0VsrQnRuPn
 2FQLgO9/K20+odHAev/UNv35IbaEWm4QGHc/TMTUeSNLIV+NnM8MEhVlX9pf1evTF3OZ
 iPJkesoVZgx54ttopPMpbnuyBbAt84slHr4WfbCVhyzTK1ESSRkh5PaNq6qQ53V7GXhC
 HalaV6BCJJywhBSK9BvbJdvT4hiolzR2OsLnlFzm3yC+iG1urXI9MXnN8DismS3+lJj+ FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye82r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDdCHd040028;
        Thu, 18 May 2023 14:56:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106mqeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/LMqj4xnMPwm4eoRHHVTcNEraqYZ8eijPxIfo2WJSQiFZcig8lLHK5bfvTeOm92uY73Lf3aB9PD9pvMnLsVJ+yvMwgZcsHNTMRTNVZBlHMO5YpIvdnod1GWy5Ltp1U7lr7STPD9zg/mXwCc22WgWtP7B6ouCyJZd2OsBUk1CZg2IAesi87NagP/HivB37TkI1JBKbpe9QBAOyhJGxiXptdMr0NClEslmwiCs22IsZ2GvsLoM+J+hjHmz/HUDXAFJUYLNFcgluTploj4KpQV6O+RhZyr0vVHQdS6jOPJ68LgFCL0pVzulvitnslQ4R+QVP1f3sAs9UK5SGmRNXnLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W28sfOc1Ebm9G6oXnJIkL5YbIyR2oRp0bN+zyezWu+4=;
 b=BwA7SQm1TlMtoR3ib19r/2ULCra0yguEL9YD3gK1GcCIEQxxtj3VQnL0O37I+xDWM7Q1MBbSAGNFNXMstxMNKqERwrCpZNNyyWn4Gvb/XmstbuzvUK/vS3IlO/yDF1obnqI1EQhr2Yu9FGNr8JjhdxIJzRB5GBxNCsOZZDjyoPr33uGGXswpJfAUHopOLj3lGM0sPK9RuGALOaRaYyv+CXrgK9n9EfSfluUMenyOKgTZx3UeKVJhV3ltEW4DZxWTOM0Fqe+IzO0BuAOtnk6ZzWQUWYDVeSkuvcNHT6m1IxN4aTOXLLpbcvIYP2+LPoOVjVz6LX+AD+6eLVAqGEizvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W28sfOc1Ebm9G6oXnJIkL5YbIyR2oRp0bN+zyezWu+4=;
 b=y12prn5ooAR91eKDzVZ+MSOP0wRklXkwtJ/FlHZ+2hD7+LkrpraeOqu7UIFbHkvpf3ghAVzW+SQVz5ILDHDt4/LO4ywqTkrMLrKDCFoysm1myp95ug5YHAp7V7NtMG2ogH+cFE4S174spe9zRO6Czw0JQAMgFOhTpL2KjWx4I8g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:56:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 24/35] maple_tree: Try harder to keep active node with mas_prev()
Date:   Thu, 18 May 2023 10:55:33 -0400
Message-Id: <20230518145544.1722059-25-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c390d5-990c-4fd4-242b-08db57b01ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxDpKdJaRu88zBjVUO/9+Z1+ZbM/uBLZ/SbYz1SonUn1Y0O4QEcw/AI4j8adcsBZ4FRLatqPvj3EHLte0FVokYxppYe2IMlv/e8wgZKTapXLTVYCKqFMF361xk5HC1oTxtMzlw81qLEwsvXvUs5euXxDc5vJrKfznd8XF+LLTY2LgpzLIdjP5GnleMLMaXJrG2fxndZF/++pI05FjRxPM1LcZwfYNu8WQeC5PicZnx09LBZIwhe/tPxWJQFig5m6Iro/CMQguSFZQ+e4butCV+iBJRv7HTTLdNWEfAPjEmGSEZcSIRoCFAtK+LRqyRYj32gXNGuA0shVovRyWVzHdni6XDjLaaJQhp+3PjeuLFJXNWJeGAPVv7Kh9HyqVLi9TUj2yfKg+s2MQWESYy2Vv9Qa2VTlvCk7EWpdvE8n3XaFEZXQu+O8VdZ2/psSHtK6ahuMtZHAPQo2BwD8m/X+9Mqae94h5/tvF4wTHq8D5YGVv4dgtICz9rt2n3hJVVshpX84Iuq2Dx7BEW0hY9YcnURwHS74VnwQnTztpZs9CurRv88GNvGmL0vBCEmm1Az8YMAKLiRSzphsFXXrzclsLu7SiMsDP99FgfWv9sf4nzLwPNtRcEom/QqPLdAiffRYSphrhvvY/R/A/snQlNVraA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRiV/57gg/QRhfny02ygSTSGSwekIEVJnh0jU4Vvk5vZKbFakZePXWUOmScs?=
 =?us-ascii?Q?N0tKOlwgscwlyPJmq/GM12b7il+w0nkTLJ9BUypjZRziTqGJhCj0lvjtaTkY?=
 =?us-ascii?Q?dS6N+QzB96GrslrojnMwgnxyWxOFo72H72XbuQo5kXWlcX7heMXo4WbG8y7o?=
 =?us-ascii?Q?3tcdFRrPk/7nd/gkeTVyxYJcq1FutvoFKPuC6wb8g+2ShI1Ge6FjcX0B+KXZ?=
 =?us-ascii?Q?6VIkTzKYaK1BuIMelqN/bGbYtXl52M8lc8PAhDPKN6FyQNneAY03qhdtrUFW?=
 =?us-ascii?Q?ZrGtidTL8fmyrlPq4uwC4g4hKmkTUr2Uj2Fqf1h6Bbr0VqYOOlTO6Lk76a83?=
 =?us-ascii?Q?rxVYm/lt02uQEM7c9uq9lJrcnZfNH/UESXX4SKcT54C+df7OnBWKLhC/eAom?=
 =?us-ascii?Q?FIsm/mCe3ELpVmEqs/ya1C6vm/XYIQxjKI+KsPWOdpX4sPRxJ0HGBVlY3IWT?=
 =?us-ascii?Q?7QLCZqpfHv5StTwdoIIIJJstr/83STXr1XhtPOKJ+kiGdrJPRNmWs6f3fSko?=
 =?us-ascii?Q?nyqK+xgFB2sWyanxcBmvHNaqDKYplCNBWxEGoPXrKPaodMbtt29buUZytVPm?=
 =?us-ascii?Q?6QH5XXfxIqEm4kZkBQD8icjx1kJnID6oHdqHFtyFI1lCvYpIz4JpnIBs0qlh?=
 =?us-ascii?Q?MxySPflgAtobnMSKkIsONYqE6i38B7pYXI3kiasD4SS8LyrVhP9VXspbl89u?=
 =?us-ascii?Q?NtdSJJzTXvG0OdNKGN+cH5P7xrTQ1SkXHnjSoKnawv3f75uEa+THGxMlTmBp?=
 =?us-ascii?Q?QZ5V0TfqiWqKQGzRsmkAf6sb4vVJtr9RvI8XtW+0CFZqT3nL1bmYxiu5tzYl?=
 =?us-ascii?Q?9IQTYxlnbsfEzP3vWN+swutcoRUs+larnj7/jh4RAeDw/ft4777oCH36pKHH?=
 =?us-ascii?Q?O6CCay1ooiJhZoLxOnJHXrKLzDlY/EgmrW0JBtaXKEeuQU9gkFarxj+oBSD6?=
 =?us-ascii?Q?ac7nkTzRjMlhVM8vzl+Koed0PI0VKQu9F5v/OPMZ9cFVfxrne+eByYm0+N3D?=
 =?us-ascii?Q?oICNX33z9pEAx0Xhtzwf++5P3M4aQDUg0Z1PMVJwm+6nLqANfIEbeJCfb5GM?=
 =?us-ascii?Q?/9a8QeNaF/ErGr7zcQtgt+kdJM7z9A3rQZD7daD1Yfw3zYAYH1cT+dRysKjI?=
 =?us-ascii?Q?zOD+7Lu00+AEmDelw6qcOazzsGhRPaNELbXbGaYCgIeIGYxlsZlpck8QpibK?=
 =?us-ascii?Q?/H5gDGVLVyRy2kz/W2EHF8m2V3Eua0FJ3D6H94GxWe+2MGzeLjoL7sKWo12J?=
 =?us-ascii?Q?fj8evRRWz8p1ea2UePT2sdp06+2X2GOgqL7PLpPxOqDZDC6ME/VSd0Ac17RD?=
 =?us-ascii?Q?jf7xaXR5gVMhXom7Ev1p0937xKFF0b6qPEXhqier2QmLqvohqSR9pB+A+3Go?=
 =?us-ascii?Q?fTLPX9d+DdUIDgK1Nno5qf8GyQL/rdJouO0m0mEdYc5SNWBys9HrcDKjDCZp?=
 =?us-ascii?Q?HuofZHIYBbUt5kR+0biir2aM3ugwZ0+n/sk0+OrS8vdx7WbMTfM1kOS1YJ1H?=
 =?us-ascii?Q?qM5QORTaoWd6cXIvHKCHaHHNyzjI848UNljFEHb0430a9DYLEG1XuI3pvWwS?=
 =?us-ascii?Q?B3Wrnca1r6AVEfrm5AJVBMF4Ci0FXY52BH7xtgkFarjusjP/lh0X+HCKrgls?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xzf67/Wq3FcXQD4g4FUUTZrZJ0NM2/d7p2W/6RDggl1JSpuZIrm4EL9eMbjhMePJ13oyzcXFIyAq+7v72yPgg0LV4RJRDcVKg1/cpKXYndJNjP1wV74Me028YHVL/tmjk33gwQox1OHzt6J8XQode4BdQOxajrkCWn5seho0cscBsfMhGy3RbOi+uXgMB5uFwSPFIneq65scBZhikq+f2J4EpNtxpfzbjI+OBA2LxknQS3Eugpf0BMfoFtkaNQHonkRmv/RgZ7E6HX//xmVrwDbnr/rS9SQfOpOVsT8lNA2jl8xFrfJIaV0MJVscG8K7l/fKMqEwBBrsMjsu6SGv4DsK6U7iGaqksGkidRiuvZGRM2sry6atv1XctWqgK0lY4gW927yQHVu1S8OuJIn0JyiDH2JmE3qt+qE/FDUxWYpMo10JUdUlCrHXslOVCl2X+TzIE6fxEZikCff3E/TAtcU+QdawqqFcUn1zYKCFKPUJrAIA+FQXupBGb2RhyVN6nxNs2RohdNxB2jDADCjSQQGYxr2GWV74BO4ZUEmTx2SXskcHnKfkjqB66j91vuo+8GDbI66FRqkUfFjoYVHPz2y1bOALCF3cLA/FFBQz56cgbPAo9tIAJ3fMlHdW1UVGCGstNqZKYHunmabjezXij45l8QzR3t+S2b+OiYRZIGS86jcOv/i8ECgVzTOg0KbJxJx3sC12yEgNkq4mCNLMELXFQuRezSB/uMUjWCL5DITM6RYacL6z5Kvy8tIBVYJTnh10nPXJvfzA3arrHFeWDgkXBBf0nGaqA8OaCNT30MxOlRtKpK+Bp/0PeibgMV/teOw6Wtxr9QLANzCz69KZhMlGd+7Tkg3Bcn1xUgN0DuKDdm8ZwRekdVejZ4aF6EjkHm0gyLKFUz/znmB7Y0vrLw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c390d5-990c-4fd4-242b-08db57b01ae6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:48.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUh1pqpfYTUbKGUcZ+a9MtTGErXNPyI7r8B+9I66kFFFgzccF2nggozCFV05YNZEVDgdN5/I28MYKiYOAGM9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: ILsHtbKFAdztoPaxyvw3AyTf6eZPg-jf
X-Proofpoint-GUID: ILsHtbKFAdztoPaxyvw3AyTf6eZPg-jf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep a reference to the node when possible with mas_prev().  This will
avoid re-walking the tree.  In keeping a reference to the node, keep the
last/index accurate to the range being referenced.  This means the limit
may be within the range, but the range may extend outside of the limit.

Also fix the single entry tree to respect the range (of 0), or set the
node to MAS_NONE in the case of shifting beyond 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 125 +++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 09142af08214..425ad922bb2d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4827,7 +4827,7 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 				    unsigned long index)
 {
 	unsigned long pivot, min;
-	unsigned char offset;
+	unsigned char offset, count;
 	struct maple_node *mn;
 	enum maple_type mt;
 	unsigned long *pivots;
@@ -4841,29 +4841,42 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	mn = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
+	count = ma_data_end(mn, mt, pivots, mas->max);
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	if (offset == mt_pivots[mt])
+	offset = mas->offset - 1;
+	if (offset >= mt_slots[mt])
+		offset = mt_slots[mt] - 1;
+
+	if (offset >= count) {
 		pivot = mas->max;
-	else
+		offset = count;
+	} else {
 		pivot = pivots[offset];
+	}
 
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	while (offset && ((!mas_slot(mas, slots, offset) && pivot >= limit) ||
-	       !pivot))
+	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
+		if (pivot >= limit)
+			break;
+	}
+
+	/*
+	 * If the slot was null but we've shifted outside the limits, then set
+	 * the range to the last NULL.
+	 */
+	if (unlikely((pivot < limit) && (offset < mas->offset)))
+		pivot = pivots[++offset];
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
@@ -4872,32 +4885,33 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		goto retry;
 	}
 
-	if (likely(entry)) {
-		mas->offset = offset;
-		mas->last = pivot;
-		mas->index = min;
-	}
+	mas->offset = offset;
+	mas->last = pivot;
+	mas->index = min;
 	return entry;
 }
 
 static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 {
 	void *entry;
+	struct maple_enode *prev_enode;
+	unsigned char prev_offset;
 
-	if (mas->index < min) {
-		mas->index = mas->last = min;
-		mas->node = MAS_NONE;
+	if (mas->index < min)
 		return NULL;
-	}
+
 retry:
+	prev_enode = mas->node;
+	prev_offset = mas->offset;
 	while (likely(!mas_is_none(mas))) {
 		entry = mas_prev_nentry(mas, min, mas->index);
-		if (unlikely(mas->last < min))
-			goto not_found;
 
 		if (likely(entry))
 			return entry;
 
+		if (unlikely(mas->index <= min))
+			return NULL;
+
 		if (unlikely(mas_prev_node(mas, min))) {
 			mas_rewalk(mas, mas->index);
 			goto retry;
@@ -4906,9 +4920,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 		mas->offset++;
 	}
 
-	mas->offset--;
-not_found:
-	mas->index = mas->last = min;
+	mas->node = prev_enode;
+	mas->offset = prev_offset;
 	return NULL;
 }
 
@@ -5957,15 +5970,8 @@ EXPORT_SYMBOL_GPL(mt_next);
  */
 void *mas_prev(struct ma_state *mas, unsigned long min)
 {
-	if (!mas->index) {
-		/* Nothing comes before 0 */
-		mas->last = 0;
-		mas->node = MAS_NONE;
-		return NULL;
-	}
-
-	if (unlikely(mas_is_ptr(mas)))
-		return NULL;
+	if (mas->index <= min)
+		goto none;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
@@ -5973,19 +5979,30 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_is_start(mas)) {
 		mas_walk(mas);
 		if (!mas->index)
-			return NULL;
+			goto none;
 	}
 
-	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->last = 0;
-			return NULL;
-		}
-
+	if (unlikely(mas_is_ptr(mas))) {
+		if (!mas->index)
+			goto none;
 		mas->index = mas->last = 0;
-		return mas_root_locked(mas);
+		return mas_root(mas);
+	}
+
+	if (mas_is_none(mas)) {
+		if (mas->index) {
+			/* Walked to out-of-range pointer? */
+			mas->index = mas->last = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+		return NULL;
 	}
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -6111,8 +6128,16 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
+		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return NULL;
 		}
@@ -6132,14 +6157,30 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			return entry;
 	}
 
-	if (unlikely(!mas_searchable(mas)))
-		return NULL;
+	if (unlikely(!mas_searchable(mas))) {
+		if (mas_is_ptr(mas))
+			goto none;
+
+		if (mas_is_none(mas)) {
+			/*
+			 * Walked to the location, and there was nothing so the
+			 * previous location is 0.
+			 */
+			mas->last = mas->index = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+	}
 
 	if (mas->index < min)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_prev_entry */
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
-- 
2.39.2

