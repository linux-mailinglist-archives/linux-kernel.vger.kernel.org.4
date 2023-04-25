Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2D6EE3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjDYOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjDYOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408FB1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:35 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhpYZ001836;
        Tue, 25 Apr 2023 14:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aIr0SwrMirH0Qok/1cx1PN+5MY4i1PWV/gGH7bHH8uo=;
 b=w6ehkow8R1SR8F+ygXYJZkPySYjYPG+/1afnxxRSX377Tf9PZ8D38iFIP3r17ldQFH9K
 8tFG+BOt+iZw36bUkLG2X2F0MmofyaAkN/ChBxnH7LYpypfLmivVFjcXStaHL3qNrAVE
 xmIOQN5S6HhDjeiTkkuhU96oFdpajl+1moAsP67hQeaRYZgMjgsa5jrPW2rqRcXAQc6F
 MmAJP755Lt+ETDs80F1i0gttB3SiFEfI6W5dV8fjGZV/WJB7zgycEwm3DdPuJ5urUWNC
 JW3jF0y++hplB03W2inIUHVxfbIOPBYtWicY1hDKibb8VknMnmuQrCP2oVh3x74McSlP Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwfb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PCeSeI013280;
        Tue, 25 Apr 2023 14:10:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q46168ct8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3ShGc3rqVcmlKgu+w+idzBzSVJ9B1wCS+0iSuVEXpEzvS1lut+Hay7Fh1GlqjXX/hefMzHLwbblqQxtkggTYIapf8H3HBduc6XLlTe10UI+l0MCQx9pjmdqV2vcJrk5oLNMaagS8wvkfCSlGZNJw/lhfQ2Qcc7Zg2rAnNpt/tNTc/r01uB2kR937BMqayZe11Xmm883Qy62mFBTC8pilC8WTuxaxNHhutQXgV6r7nZgETsX++/eN4o1JGukAtkpieiLRO5HAUidRFCSnkcu6PNyFmjdSqxhWk2Krhlvd4yp9nhIrnJ0nTburntQm+fb6i4x8Zg02UtiRoYk2kHcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIr0SwrMirH0Qok/1cx1PN+5MY4i1PWV/gGH7bHH8uo=;
 b=NcvMssJbbbw+X3nFVtJAhCJtA8pB236wAbhWE/Qf+nmHpR5OsLDkpOkVTVdwrE6xccApLK6NZNFcubn5C7Mszwj8MZcaCCNUfOJMo8VJWQNp43bzRiWELvguRuS1C4v6E5tS4RcKKDe1sWCwppVkIM3VLmf7uaioduz2QAyG7NIh7RwtXG41o2mABfvVZtHZhInqCCKFISBhiKLrn/ki2OerlwHwAW0P8gfg8X3uMp/Lr8zCTI6cesqF13GMheFympSNasTREgU/c5sTOg32YimnLmbwPMD9oUMMhIZg3sfRqzooS5flfoPkmEMpJbFUtdYpzEq1aMKyl4zTmjI0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIr0SwrMirH0Qok/1cx1PN+5MY4i1PWV/gGH7bHH8uo=;
 b=W2AZeCa8JD9sH4oSMSbNLQ5BoeILw80XAeMSwVqry446PWGZ+xxTWWV9kGYaUV+HK9NgzxQJptD1dbw2FDa+HWoO5A0K4tAXQx991usTWBzC/BRPSuyPm697qxNsrxPAxBtcMuAWLdtjNcEtRhvPEG75TCq07RZsUGZH8yProqM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Binderman <dcb314@hotmail.com>
Subject: [PATCH 01/34] maple_tree: Fix static analyser cppcheck issue
Date:   Tue, 25 Apr 2023 10:09:22 -0400
Message-Id: <20230425140955.3834476-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7fb81c-d2c9-4fe8-cbfe-08db4596cebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9HaFYKdMsxxAXORa4oXLQxpHH36Qid3LWo5sRaEPtKrA8zoT02/XoFrwqdXNsgakHe3uS5NZZ1MieriXYxVXIhoV+cz72oKCrHz3st0jNks71VSrfz8d1SbGZNCFbW2ZqeyiPUruUbWrmxIHjNfT53tXXomHYsTd+4qskKUQ/5jU4NUAtbxwFI7UreWkifwHZie78VQKUhrTDjo5yvviqLcMxk51BJ/BwiXCN9TtokHzVy/1scTp1tHuaLe7ABzLwpaSNqF/ETdvIPiWN3Pl+MjU+UtJdW03aRk+ahPHpJgD+0sRe5579wsjn/ixT4rng5UGcR1oC90dVjCP3zVIp22AHuFRkDLd0AuJ51Qv22qzIpP6A3pwu30TZaEPktD545evMSUr6KjST670C1jJpgBsWIrpd/dsaYXMU0+mMDvCmJF3Nej5D/SjpBrqiWgeODqG9gYHhGNx3So9zwvhJTDkHeW8K+MDva7N3Nydeov3n8TJw3+m2hISlRA80Jbq6mF98+T/yfZoY7RJ4U/MRqgMx3322mV+rJLwgHfm96t8nSpYaToJy8itpO4vFBB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(38100700002)(45080400002)(478600001)(6486002)(83380400001)(2616005)(6506007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEUttXhEAE9/CTXzLck1Hai9ipA6kvtRVRBKqRpZxvA0iQl4jWA1l/m2ctY1?=
 =?us-ascii?Q?krzqBdaojpImpqn++g0XMlWLQ9RWufIFfi7E7zlGJnB1aOkPvZL4yiFdCfU6?=
 =?us-ascii?Q?TNX/cOVxjS5JmkMIgMAmoaUwla8Bkb294VGzv1iKPRqtAov/0cMe2tkWKbc4?=
 =?us-ascii?Q?jrNJuGWOU2lclyuOhs5sOLJJgrt8rUchufDxDvOn3APZKE1f1j7obsTEwmdS?=
 =?us-ascii?Q?C7UvC8JmA7ldfacU4Gdo7P6eIdaEe4hyyUpyf685GUryBuuukvW7EUNEvGfu?=
 =?us-ascii?Q?ZmkxKr/pUWlaAXYN7iCyicQv7EOlgxyMFZzIWYMQe2hYfzTm8Dg4IlVfYtHf?=
 =?us-ascii?Q?fzuUMh8teGiXuZMLriSJeKfX6leQf6vod3mBmAu4/uDMiifyd1T6bWv8Sl3I?=
 =?us-ascii?Q?6y53CMSR7cSEsjMPWv3J/p43CzaeHggUyNcESQpmmAeLmoBdkrqKtJc7AMUA?=
 =?us-ascii?Q?1B0LQlSivLbwpBHu5mqvpLB325FtqqKK6AKwUtHpVnhbV3qlkB/U0HtThJK4?=
 =?us-ascii?Q?aGt72DHqUMlzbAXZwXPd2WcDjBKkFeZyicRJoiK/JtaGErheFvtNteZ6ImUB?=
 =?us-ascii?Q?P4kcnEkRp0oxEPJ+yRX8R+NLnckAEUhroP3op4G8dKfNuGtvKEOsyONwMvrJ?=
 =?us-ascii?Q?iFXnijDAKqk5bjvmC1zz9gS5Yjl4/dgMGy6HgKs3HfhH3TWmegGE2Mao9AmT?=
 =?us-ascii?Q?57ZEfeRAlNwXSB72Mbtite+yKnLlEKLev2wnSfUvlfxURx1bqOdVQdKY7NN1?=
 =?us-ascii?Q?weQN4dFH2l+mBBkn/Jv38GfgS78Jr/EqQk07Uvr63/PKtDUHKCZio21+cX1A?=
 =?us-ascii?Q?b+SrNJK3rnuWQpPlF5i1M9Vsg+ZLM8/vn/ceFpoq5FqSFnVy5SyChHHnN7Oo?=
 =?us-ascii?Q?SShkcjcD/cI6o39OHkqncYcfzIcvqCiozKkQLGaATMorXCMVCPQm6nuI9Wqo?=
 =?us-ascii?Q?tqupg6KU5wGwCCVbIPUOo3ppHtvtjSKpbwdngMjCyFG/q7cQOv+4/yjjx7cj?=
 =?us-ascii?Q?pEKxIA+Ux09s0iO4HGOFRnnnzr1jS3HcFuhlwZy/vAkPy5aa/xY3oB5GAVS1?=
 =?us-ascii?Q?NGwzgOwBpsjYXqYNYRwD4iUa77Wlwzb38MEsyiePBcV1NCfktrDxXgJgMK+p?=
 =?us-ascii?Q?tIhehlE/1Re/ImvR4eeUXg4j423DLO4N7acmsO3hovaa0s8WH70MhUamhXYm?=
 =?us-ascii?Q?7U6x2SwYwHUb9y4to7CCOiAp8X66/nXOepoXxUy1r2ZNmC7onGk3gVYDjp1Y?=
 =?us-ascii?Q?6DBjafLtP7IdqY4P+sgQVx1XskGGd9GvzwBTrPOhvezd3111md707dkMuWsT?=
 =?us-ascii?Q?K2xg/GyuLLbnRaEIcy6PQr6PDWYnKl0uRaCDOxXd0WvW3GU2JlWRzutCs+xi?=
 =?us-ascii?Q?Au4ZIy/e/cSPGTpwXm5q6DAkG2+KT/Ps3FJcJ4yOeGrxlrXFsrHwfrwYlLIR?=
 =?us-ascii?Q?0vAOW6iwlmq1OdRqsvFddYO0W3Bl87dnVQGUVPsM30RI01AWEq7FWevoVML7?=
 =?us-ascii?Q?7gQ7HZoEm6wTwdoYGKdhPMqtUX6YbBMt3dqWyRzGfFaophblplEzc4rbsxXI?=
 =?us-ascii?Q?L6/BgU16tC42tFRehkhbXnAfEGNA+B0oZF5v/dLzZINSbm+DXh8UOT5xWuog?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4JS24oJGBF+Anc4KdmCu8RbDRiRLEXmb5cwH7Ti/SXxwZWglvXK6QowzrLGCKTunqWm/zmHoASkjjZXABa/VlBQfyCnVdauVsAH9EYWXu6hvBbec3iqhbjB7xuDqz655w4mqjW3ZrNRtGb7LvONNiFPNaaB3p8PtpVyAgqu+dktO0PCZ+KrAvZmrXg1TK7PYdL0xZ9mQWrA08to81fPO3sN6GTehS8ShuhnanhdxZ27P9qs8Ki6AuqbXBSJcyH5L0m3Yk/ZU008akQjnTTzXDke2RQZPD5HAzGjiJ51GuU4nKQI1hC4ivZidJs35UBmCPQmE/AljUtB55TkFwh7x8cSKscAzhXH9QbNUK7nR/kxqiwbrzEDXORGrTGU5gjGAT8Y4CiROU8NlIEHplgq06jxo6lWN9Cm1NVwxuJHXFanDJk7Omols2GoTI95zB22jtGkuxDDMke9sFYGkRM1iVD7oZBR/RmCiQzNcj9DE2EcK7ppDc7Fnva27fneg2eB6AfKD+a7rnFyJliBzgP47AJ63qAXKHkWYqFsPRt9q3mncfXaxRsN3F6iYr8NKHgaCkXvVSyedH1ces7xMl7fUC+QLJB3XGgFawmtdbLHi6tu5XS6KGQ/nw6GRZzLpNURhSOycw+9r2s9RS9rbezEGpwsHDK5ZQSKau8kcpQM8w2ShysI6rDZ38L1MqID47Ziglb47mylOwG97KwBtdEVzDyrVMl9ORJFdsvJINSj7ZxDgm0MM8URRQX2i6MKixrWBI0GIAo2wQYc/xxahjwLRVu8BpMxebhcJ51xHKewxFB90eQ8f89kasfDZPa6e3oJGrEuPkeFxFfavD2yQ6xaxPuOXtAYk4le013Hk+fDg9Uu6nK1Xi3izfumuKKFsHQnuwg1yg8WCy+pxaAILNrOOt8kBVhDBN49+EjWotL/J9Dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7fb81c-d2c9-4fe8-cbfe-08db4596cebd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:22.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qfv5BDzKLVYS7/ePBMx1Jb9JRrGHFfqtlH20XDHP8Nxq99PeKmKZvf6JgOqX29SToDmeJ347HaUrcemy5U82Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: VrUNUeLR3wUhKtWgBg6yepI8Dbjke9q8
X-Proofpoint-ORIG-GUID: VrUNUeLR3wUhKtWgBg6yepI8Dbjke9q8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyser of the maple tree code noticed that the split variable
is being used to dereference into an array prior to checking the
variable itself.  Fix this issue by changing the order of the statement
to check the variable first.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..9cf4fca42310c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1943,8 +1943,9 @@ static inline int mab_calc_split(struct ma_state *mas,
 		 * causes one node to be deficient.
 		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
 		 */
-		while (((bn->pivot[split] - min) < slot_count - 1) &&
-		       (split < slot_count - 1) && (b_end - split > slot_min))
+		while ((split < slot_count - 1) &&
+		       ((bn->pivot[split] - min) < slot_count - 1) &&
+		       (b_end - split > slot_min))
 			split++;
 	}
 
-- 
2.39.2

