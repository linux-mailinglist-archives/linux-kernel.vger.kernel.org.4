Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C56EE3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjDYOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjDYOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F1146E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDiZav006059;
        Tue, 25 Apr 2023 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=iD0HsogRo+KasGO0aQ8MARS1o2FIoUvczcMPAOl56mM=;
 b=hiFJ2wYC+ZXqm0dwEd+7PtN6HOWAgq6RVPycl7IZuN6Ach2M7WfVZkJ9NWezRXj4+Uo8
 UkX+smTHU7nvvc+kfJqfA7w3Y9PyzPMmbijIyg2etBkDYibmfbSUV89dlFfxDlma/Zwz
 SxlAFR9O1xliiDRuOi3QLwPgoFRtrHc3ztuMxes+Xit7gRopEVKIHH88lPzQjPIlFMlI
 If/SvW5aeV+P4/Vz2pBp19oO99zmEwuTnm6Ll4taKsi15P4qSgDWKmQM2xlZfyn5E3ga
 g8FGnbDaL3eEjzC8Ghh6CxWgbo9iYR5T3msFxcu8SNs+a510V8aOGDapyPWoDbfrzah8 sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q4661wgmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDVpp8032767;
        Tue, 25 Apr 2023 14:10:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qsfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4QfDqlQkGjNJGs9rz82EMjgTlKeHuggT4/lHlZqFgDO8VYtN+b3dM52Tkf6Dkubms1HhAitdP6gJ+wJYik40h+vFdg4s11l4xDcgcstfMwVBRopoFp5vnw+Cw029cp8sitQMdYmwCKw2i1lXU2R2ZyJQvWKyC70uKYu2Hw7SxW4XgiuYk4vx9+cMF+u93I4ALkna5whARq5C3GCAExeqYHLCPEn+ocodZAgUiey8WKBlaFF40rSSrKBUpLKiwKw9BOtEi5xp+aaIzJw+3hwniU3huMdz2NtmQXoBDjpqINFatY5KNJYKvgCC0C0rTLLT185YY5yil24LuI4XIlB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD0HsogRo+KasGO0aQ8MARS1o2FIoUvczcMPAOl56mM=;
 b=A4KPQr8MylyTQlDkbSr7XTghgPbDeD/wi4DYeDI2gmu4MPhPc0KwG8kBoYZadPuW5qCvH2cdYdLMRu6mKbupvwQ+IKfbtG1iLGkDsFt5HQAVk/i+h8bGNnrD9HF+9847SqqwXgkigG3uj0bxKDbl5+h03QGxsfh0VFBcZ29vHuy7EZAUmITmrHPV2l4CBvjT61ovUN5YAbKlKXv0abHNWOGjcF9u/tLAz+onSno1fHWPQfLgCB69qraeaWBE9uzSqgN0XmczEU5qZB94AMDNvshVsrZ79q/ypoc93U0ZUQ8SSGx/X+KxG4Ix+xJeyjYP+25tgnRMriGBC2ZIL5Ui9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD0HsogRo+KasGO0aQ8MARS1o2FIoUvczcMPAOl56mM=;
 b=gHSXvMTkozXEeBaK7Da5ellbUf4g1nTL0UQRqAk+M+sqz8plTRB7LJZ2SJuaQVfKA48d54ECURpwBrJaecXM8/pWg2+sdb2hdtifaDBbXh/0QicgXm3wb6NGRQjaTsU9ra09kyOA9nIXiBYK2YPaim4XjnOwArhK3vL3YxjTMvQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:36 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 07/34] maple_tree: Convert BUG_ON() to MT_BUG_ON()
Date:   Tue, 25 Apr 2023 10:09:28 -0400
Message-Id: <20230425140955.3834476-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 2795938e-4c95-4e43-b927-08db4596d72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Bxwr4oJuEIKFrV0FOOqrkcHTzb+2RfEg//fEQq11ghu/cCk7dn1507AdEdsHXQcnd5MMHfL+F+2HZkogPRPPgwa0bHjoSizE0xpfcIgulqpa1H6BfdHVC7f4P9mdHO0pSLwedIUNXXaDgCTa+LIXO5F+kV6vj1O3vH+YfHAwLW2Oyq5qNrgeRPGzjfwqivKboASJafn8Y21vh2CgJn48TDhEsrjki05ymC+fou5nwvkCvkCeUZgbslDZY64HhAjhrApXU/h+sb89UXTbvMzTdbAUgimKkzlXYMIgn5tl4TA6tCF6SUqJcxd73rN752p45A0BIAVw2pcGXMDrOl4GFz7KTRnB5b5Puolu8yGfB56BH3XdOKWi59SnLL9umGBuKiQ3fKInCaBo9A6j9g+RgKV8sa0HyLnhqvwLMEiajtU7da5FBRgWbBBWhTP3O3iSCzraaJm/udPn4vIxGj7x1TUsXgoxTt9zs1JrFyMMYSTQtNEhQwHMVLDqH+LbPEBjCPdAkNBpHuH/L0pSxjOp9Ks6wxOKUOM5cBHH4CizOmcM5iEs3MBKsB7AapJimWf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6666004)(6486002)(83380400001)(2616005)(6506007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jjAa7HXxMWJakVdfJyVaub+Rkl9hwHnUtiHL0I/UYIYoWXx21a1FA6vLvzpj?=
 =?us-ascii?Q?YVeR4tikYHklJFNYNB71OhXLdi8qDP7RW694+EGGT3h//h6kOWHnAr/wmcuB?=
 =?us-ascii?Q?N8Njnf5G+qyeIUOHVHgfzaY2Y1q021rgsANI7yCIWUWG8S6sLx9b2N2DhBzi?=
 =?us-ascii?Q?rC11Ynzktdf9anL9DBwDziTl1KNc1gdekE2DYdIEp9PcKuReEs2iqhHdg7iP?=
 =?us-ascii?Q?dg/BCzG7CFBtcH+3WCNnJn5URQcOjTrPwkSkKyj0DxRMbV6BKwuD6C5qMFBc?=
 =?us-ascii?Q?YyTu8lkugm7HJ6QNrAE3z0jhVkcRBRkd1QnrFrbRpdQQ0YtW0R5C0/jE+rJt?=
 =?us-ascii?Q?geE6GBjjuF0NloG5uXaUcFtD8qzBRzI+WFsPvkG7Fs86jEE4QNe2DOL7lPBo?=
 =?us-ascii?Q?ny8KDcBLjXgavsOUZCSGlJhYAqsOq0w98f+3BY+DgDbg0I+nldaQ+2gGhHKA?=
 =?us-ascii?Q?XkvfYr4XtC8PqVSJm1AqIKeo0Hh/jop/f7v2kN/3GjFv9Nss8hU+r5JhIkNi?=
 =?us-ascii?Q?7dESyk82NFHC6woR00EN7wZRiM36BGRwb/lWcXzEdFnJrnAfgd1TfvP1Ok/1?=
 =?us-ascii?Q?w4QebyZPk1DPR7F+ZvCnVx3TFFgMqJ8029wtXkPOdD2un07AlzOjX9PpM6h6?=
 =?us-ascii?Q?21KZ+miWJGA9kR/3eTEfI4vs9IbNuPV1wTZGWI5GxKp6VSmcUvM3G7JMGwCK?=
 =?us-ascii?Q?CGmi4ihSSq1YOE4CPS7GPiZPxRH8yPyRcOAiQ6xm6nutnvb4Gvd8dchWwMCJ?=
 =?us-ascii?Q?47ZfpXO9byMf0wv3eGhzfiGqfUuKY63AXGx16xbZGtYbXhnbGpxJu4wkXzNb?=
 =?us-ascii?Q?Jr7ZW8y72tL7ELstDo/qbjv0VfwPATwpmuaCQz7EsePH6ov9Spr1FCCtNfIc?=
 =?us-ascii?Q?D3sxF1y9wFuJlWNfKVPP5nKx7OE8r9uGV38G57TN+YAfwUVJO4qPACT5+6ew?=
 =?us-ascii?Q?MgEpAfxJpWjFwPEs6FPGlm0VnFRkv6ZNpvser9x5MOdai5rKCVvbo5IQaRqh?=
 =?us-ascii?Q?r4w+A3PIesvyn7VL05r1WlgakIysGRv7F45qKdtxqZgKVxj52Rk6EuD3PegU?=
 =?us-ascii?Q?DCxMuvdxKO93yci9x6uygp7BtJcj71kssH7PW2uKY4lhKsug3Nj3xJpscXgt?=
 =?us-ascii?Q?PzvGzd1vz009CfZr7rSuO+TA+rw0kPG3tjAHR5Mz0rahmEdJcohhPgLQC4Iu?=
 =?us-ascii?Q?jUSgaRLRfNf5uf7sP5goUVN4owdjyAIMqgBFSOJZcEW4BXsgXmOPlI0LIs5p?=
 =?us-ascii?Q?3moKFvBXVhiGQ2llI24+o7Iy+n1vf8oLgYQorcFMGZumPUZgTeHh/Syqdm2n?=
 =?us-ascii?Q?Yq/U/oPWxmu92zDfBGMP6B91hqP565FFZfSLZJICPvqymK3jxhivqkZO6eKI?=
 =?us-ascii?Q?XNqgB+af8JK9vn4eYJnmepDpvWBCycryS2lkqjC2IGmZuL+SGWbgxSbijJTH?=
 =?us-ascii?Q?K8gh+26BTjfvRJwKz2y9qrwuZfXDHz9kPZ8FtYtBw4VgfLFtab4gHMsBFwIx?=
 =?us-ascii?Q?/UPqvf7UCo0hHbPLMy+STyLQMakrwsT1gU5ZwTs5tf6e2+x0/H6rcTdXZA7W?=
 =?us-ascii?Q?wLdFGM/VXiHo3WjL+6YSTiKAxSu03BB/+2hKDDNjUPoxaA6gmS6YCcgEj1VY?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KjQPDr8vH8VNk9n36ZFqueqaWIUknRNR81gmeLhGY4SWSIGEteDOImX9Peb+zyd8dP/QrdcbxFwCAl470mj2tfyUfIfT1Xd21CDrKwYd2s4tCvT22dKQyYFP5T+KMnpTIVO6B41KGqqYoTUqszXd8suADctv/RsQd8DPWiJUMiw0Qu2cSqnIfBWDI6A50ERXZsokcjP7mEOXX5ekK9b6bnxlpV7zntqtsr2L1oE08ebDbudh1fWs33Cq05x/Lx/bgIX/nprXeNk3ZMyp1p1CvEd3kBXIIt6EQw8tepYtdWksKyGAHAUJs1t7d57Phx6gf1d4rpTWMymIyjvKD+hJmxS7OZNmJBpFAPB3MJ3Z7qAQhlVMoqwWIrsqi/sXR0QD5TEmjvlh5Q+qzhZrSSYXdSknod3fdaQ5GIFOdsl1zLC8KCAKHmA3k2JU+fjR98v2vlavOfrxwDX2aIzuaWk8NGMRvE7/K7lS6k29ULX1RcciuFJZi38OdSLfrycm2PQpf+naBOam8f8vW1DNL6HjCFSYmFqY+H/JMewW0IPq3rJeZYX5Uv92mkP0XX8ggpFeyF+Ssg8oavRQCsjiAYfsvSTPTpFp0VJ4Lqp7gyEvjxLRpiCWxZlr8o4it7iAa8/VNAksTV1bL9akXlt2vmOOxfEz0KMPoaQB03SETwdIqFK0FoH4DsNZOV2PW89b8zNlIRIYbvua05Ld0mqGZY2qlSRlQ9H4EWhCss4AOrquKwO19RyOpf3yClp7EAsNDZfuIcEhgoJlUohRamp+tL5//2c47XlnQIX4RDbumfLwnW2JO7iS2AKFTwrRcG5KSiZAL1qK1CklLegUkWU55VJwoTcVfkgUtkIeR/MuwdIQ1JzjIiGWMx3cHSoXFTnp4anqkKQwZ02t9w4hIIFluVnkIg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2795938e-4c95-4e43-b927-08db4596d72d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:36.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9z4i23d+Y77iDJyEFJ1EjjypIh91MknPsmgXQuFBK0xQyP+mH2P4u1qfKWeVYw6C3bVIXoF4RU6EAt17CcT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: jEuX_2tBIcqy3DohtjKJ5jLbOoyCeuZN
X-Proofpoint-GUID: jEuX_2tBIcqy3DohtjKJ5jLbOoyCeuZN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use MT_BUG_ON() to get more information when running with
MAPLE_TREE_DEBUG enabled.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a4c880192333e..662a9ecccecbf 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	BUG_ON(mas->depth > MAPLE_HEIGHT_MAX);
+	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

