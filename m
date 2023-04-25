Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC686EE3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjDYOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjDYOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C01618A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:11:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi9q2010211;
        Tue, 25 Apr 2023 14:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=d7fYXLb2uNdiDnmhWsfvxET+WevVsv0mGGSF+vPIia4=;
 b=VU3zdn3nVROKRaej4BtAnFkCKEIYAzjXg4Ym7gz2Q/bNpOHysmw9YO1vLKbnJZI43Q3c
 EyZMsLOM07Vv0ooI3jesu7V2TxQZHhspwUcsz3PT35zpzMPlxkiB5fuCJ5HK4gX9XMLe
 7HqdpKWFxmaDRihFXNgGJ+wgYyd7+CcWmR/epPCntmdma6aoFDv0mPb1Xb5Bd9YoCiFI
 SxVlpNbORN1psXjkhXDegRR6X/5pXX4zYweabO1IDXjxaqBA3nw3o+z1fqTm0XgLWebQ
 NPe9nBUrR3u+vqrviuCZkjAbU447XmaNlXtlKtsmmoiMUz3KxIpG6lPOXnb1pa3eQTbv 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476twdfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PCgvXj008521;
        Tue, 25 Apr 2023 14:10:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qngs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFSr54KuY41ickFt3Chu614BWBEgmYmX7ewY9cRLT9VagUwLY179cf2D8huvemh8cLHLQ6BYocf5qcAFT/3DHkIMnzUZe8r3Rn967E1iiMKEfRGJSFbG7x6GAqnhYXPuvHPD7hb07xttO28m7NjxVazVblvC1YwLxUPBu3W0jUMNJjq8c9gzc2BEOo5lTM/PKmERQcIS57bSGQTGaxw8kFAYpv7TjJ/+K0Fk4pU/UmUSWBxy9YG5bJQra7qzYTstowjX3Cq0vHD2fbiJETqtyA7e03T89UAixU+G26W1H94+6oKCeVPRHlpfrQXvvN8HFsZDfL9PZ18RsQmPMWUnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7fYXLb2uNdiDnmhWsfvxET+WevVsv0mGGSF+vPIia4=;
 b=F7j3o6krs5FFITidDDCWz7a75hwhrpUkrFALSsmlQAQL8xy8LUMh2/FO09evFE2OHPWxAZwWgdIaRrjlFemWxAIG8QQuHsbHRZnJSLRvjpdIkGUUkZcGOt38ccs46oM00LXF0raVBNtdn9B5AU2jf0ahf79yOM7ah8KAbnJj6o2ItQaPxiIMxwftq7NBT0km5WDZhcA0LTGSlUtnJqb3ZEAEdOAFF7HEimnlcJhITWW8kSX+qeh9B7un1uv6fbJBEjxZpG17EDvrYgV+9MRullfVbnsYyTHsT/ZxBBjtfyodNM/HrFgy16Fnqhj/OpPgB1pM8r4oiHEezE3zG2ldhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7fYXLb2uNdiDnmhWsfvxET+WevVsv0mGGSF+vPIia4=;
 b=vD8C9MLV2AVffOmr1xnYECAxxLPENHH/09wyhUfge8h5XyVnjeCQ+7qpqzzulhhr2cwfsTwKTF/CLmKpFwC13e19agyN4jnPBFYl9drirewDL4sFlqzTUMXtYIeafdhYWg06sTW9ulMVcfZO414IZyEleMk0mpDLCVNzLVgHp4Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 14/34] maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
Date:   Tue, 25 Apr 2023 10:09:35 -0400
Message-Id: <20230425140955.3834476-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 787961ff-3d77-4645-3058-08db4596e0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXNil1XXM7MxmqwOuyGMhiaQSgx2EtBgzXU6YSragX4JGzf5htQKqeO3hCKN/NRZgBKXdTPiOcHkh0uT6eCR8kiyyD2YMyc+2Zz5sMhLf3/LjHwvpcnNt0V4hZIT8qcyGa+b+ICRNu6IXq0GclrUxmozvZ7gR0JnZAQZJUGPpaaUCMnpb9L66SD+2Wpte+y04Se/Y/l0dAuoL57pP+B6MqYFcpRmO4Ccl9JmkyqsoASvpt96UABACGcqe11eFVHNaIHaVs76rTwXsR5ejRvCEDTPTfD9JC+KfOjVLFXJ84wIN31/JVr7vlVrDmPBh977cOwl+/VWpt0NwhkkHai+cN6TGMOAVzR70/k+SimZDMMXyhmNTEikDoMjJ9HxAQsSA1yb/MT5/4sWG2FMW/RQbn+IuBEnZFKZ9Cka8BF0LEZW9mMzpmW8smLDQVjkRY2/MEZGVqLyK4IY4/yqsueae518TdG3h6GP3SZgIPv2MEZa9oK2/+EAuizutT+X6Ze+fekI7WrquomcRr2nXsZOQZXMyQkbdJT6zPUS57zr3JcbP1+ZnghFVPPAwed6sEFS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UmbGOUkjO35asDLl05C5HtoKw5m9gEBQAbf7ePlCVqKjX/bqUde4wysjY1Qi?=
 =?us-ascii?Q?zBksmu60iE0Tbx4law75VJyZPvLT4yORd6CooBjPedqr5+4OKVmEnS+zGngL?=
 =?us-ascii?Q?eWqjYObanA7MqNWbxFN0ULfG6+bKk8dWVwYOHIiwchhBGwcXUPV3TlT/Mk1q?=
 =?us-ascii?Q?PPbtOKT+ycaSOiFfaU8b50bErqiln3Zi4OMjB063LRQ64UbCEwaYlaY5tvIl?=
 =?us-ascii?Q?gWXZV1mB1+eZfUQBbb8Sxh2Sqz4ZNl2INk2PBCeZ141DjFhA3NWyiyJOw9sd?=
 =?us-ascii?Q?Kn4/SQmTEX0j6JYY5Go5FQ2oUA6rLoiGd0iBodiJdndQFIOAeezZ/Hfr+4Yq?=
 =?us-ascii?Q?TrhpUl6oxmLRHfj4RBRhfwuEs4uQhcSxq9gDqzqAgMZZsvR/XPIjC74EeTZq?=
 =?us-ascii?Q?0yuDxhXVEoZbBq7cm+J2GWBQKxzKFDZIJDh3yh4lWowhVNS44B1sGUnmvHjs?=
 =?us-ascii?Q?VyLjyKKjnP78CuwehvW0V38MCp+0S4IMjg90xpWO+nEAeBs5jkQYKeybhQBz?=
 =?us-ascii?Q?3ryBJKb3gFnEybT6KvZmgTP6ZNRaloMaOpPZFQQRsOe9VnivtrvKRNPXUXfm?=
 =?us-ascii?Q?CrhYcALQ/JetGyT8ZAjwffU987xGk/bzrV5bhsk/8UZpHiWjW6kTwk69nWd1?=
 =?us-ascii?Q?+CUWOO5GTOX9PiYpPqne+vnf+RMxS93c1RDy59Ve/qbs1M+/4BljNck2IvQE?=
 =?us-ascii?Q?Rjoc46Vv9KW/ArPSLJCL5Uj6xaYSQmted+p+L9aeMu+WtCRh9/m6rShqtjTS?=
 =?us-ascii?Q?nGiiccv5m1sQYcHLstvbbFPrCVwhcA9ZdIORwle+OuNC+NGssborFyGX89KR?=
 =?us-ascii?Q?Om/h9YXRG+Pl73XnJx77T2PkttFkUmxO7DcqEmW2V8199Wbvj1q8KutewT6B?=
 =?us-ascii?Q?A5fKh+16Zar7sr+swTYgurhhmv+Q+YjzBIOUWpsOQ/YlyeqnSCfIvF29iyaR?=
 =?us-ascii?Q?EuPtJMFLrmSZTMUtKRy220abVTfy7FEsb/ug4OcOo10EllntWtow6TcKdpvJ?=
 =?us-ascii?Q?YpTSOkQ+tKXpL31yfHTyVC8dzs6s952ymg+/AlXa3vzeXb5wETDUW2TXSeJa?=
 =?us-ascii?Q?+CWcej7bDghypyPhusebFWoRd5agUVdzFwU8tJf05F8+KMSmaS/hoymE/m6Y?=
 =?us-ascii?Q?bl0AbqIlETPNPYQ4iKhAQ0ZSfJKMcnwCRWX/0kOVA2W887IjlRZu++/OV/Hi?=
 =?us-ascii?Q?zF8SnMPeJBN0pkpp1q+0/Kg18rIag50WoKQ2IV3Yor6ilP5tfc3pcPCdQubP?=
 =?us-ascii?Q?htGbBYsZwfO+jtc1lL+27yGBSK98tbJ/Oa4iu8/POQaC9wL3Y8E7NRgqDdtr?=
 =?us-ascii?Q?EvTfTs3HsTQoIiD0Eoy+/xB2+iL7QQ4Ty+9fZyIpf9AHBuKunGMTk6IaSZNi?=
 =?us-ascii?Q?sNywBEB0YCXWYohp6B6cmbdSq5hMgOZn66+6I4QOx+3ryKfTQM3f1T9uJCAO?=
 =?us-ascii?Q?9n6Gyk5/ztOq822+pPalYBLCbuSn5dBSA6SAqMeXbr8tmYBcRGIBE0Wfdn65?=
 =?us-ascii?Q?BTiXSLmHF2JYMr/UKNK93M1tKfo416oWTmWP7/Ws0/kEI8NwopU446Nmh+GA?=
 =?us-ascii?Q?5NaQB7mddUezbh82g7JCcPvj62tM18mpRKrUdqp6R5XLoqbiPcd5tPuXWqOK?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zCj+iwc7ibhvAWwaztOpd3eMWLCCuUos8xvDu9cnGbSHoL7j2uP87efCNqbROCJCvUVi+kKaIWOjCzb+/f7HlRKmcLJLbxCwPZyhRREpvk9zFtjuU2iltLiY8u391PEeeaU6wqgP1mrBmG0mKdS5yV/ecYti1yswkuF5Cx1uLXgR64Adttxp2u001A6nRyvvTW//h9v5uyVwI65nGoaN8SJLk/vPewX1Afh95V+/cTw4QfmoeEcu4PX/5CV9sYfQmxINDfpZfYwcVhER/28cpjtCXxeESjiLbc2qcDvYuFQyWzPo3mwZZ2VRB5DWiS61V+ncVObL2h8gcdpqnN1WSMrcBZ+OBjnXKI+gZNmSbt9mx+SADgg6rocPSSmxpoyB55OiESbLy0XaqpPzvdLvIBqFsXplyxTSVv016g1+gHU/JOL1caYvp9enHqaTxdTWS78pgxh3N6F3+WWKkRZnE73KCmrtV2ISFJmbwmI/g8dodXVpOuud0n46vQBW4kdDnOSwJxxg+4r79C1FQhULL/2IyMMjTK+Hz6zsAd9g3iaHGfoVXK7J6yVXbsnrM4ssfs5mkmup4mHmRoiQ7xBa+zKzVQrdWWZSB+kErJy6wGqDNFgCtxve5fPUfSMxe0V7/PoTcO1MP1TOxI+TzWmS11HSMGlxdosDCmykRtSwCjMI+u77pyzjcf2rcFVJan4uFkzDtQm9BmxhD63RmFeDCXa86oeD5AFOfzEgWwS6V5htII5c5dYunirsuKIxAL2AvAJE/s43q7UI564VaFcq9YGRwDAmLRHPKmAT2FaRvurJSQezURe5cSGTLf8+EoHmN7QNmbrNbmndMPoHHhAqK2cqWNg4/HoHTy+tTGL8EYn2UWABiWgBwdSQftw9NFHbENhY/oSTHxTdHrvjfQAVbQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787961ff-3d77-4645-3058-08db4596e0d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:52.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaDuxjkW3De/VsMHPmHzaxfZb9YxyNYSsK/jhDcutjw5IA7caPf0b3/5UxYLAWTAUKM5sVrmQ6Tbjge8FERXOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: 8tW21Y9JmusW-b4L1T7Tem2eKyufveJm
X-Proofpoint-ORIG-GUID: 8tW21Y9JmusW-b4L1T7Tem2eKyufveJm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the call to BUG_ON() in mas_meta_gap() with calls before the
function call MAS_BUG_ON() to get more information on error condition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 28853ed23fe8a..41873d935cfa3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -963,8 +963,6 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 static inline unsigned char ma_meta_gap(struct maple_node *mn,
 					enum maple_type mt)
 {
-	BUG_ON(mt != maple_arange_64);
-
 	return mn->ma64.meta.gap;
 }
 
@@ -1629,6 +1627,7 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 		return mas_leaf_max_gap(mas);
 
 	node = mas_mn(mas);
+	MAS_BUG_ON(mas, mt != maple_arange_64);
 	offset = ma_meta_gap(node, mt);
 	if (offset == MAPLE_ARANGE64_META_MAX)
 		return 0;
@@ -1662,6 +1661,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	pgaps = ma_gaps(pnode, pmt);
 
 ascend:
+	MAS_BUG_ON(mas, pmt != maple_arange_64);
 	meta_offset = ma_meta_gap(pnode, pmt);
 	if (meta_offset == MAPLE_ARANGE64_META_MAX)
 		meta_gap = 0;
-- 
2.39.2

