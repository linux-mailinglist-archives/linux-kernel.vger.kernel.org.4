Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10556EE4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjDYP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjDYP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:28:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1718D312
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:27:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDiT6A022532;
        Tue, 25 Apr 2023 14:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7WvxfxD+srrNnZyxfWsPROhv0EgqoD/8Wp1bZvKRdD4=;
 b=l+rxpYL7HMLuyr0Hvt6LeDsIk8lbvqMFReGtog22sUbrOHiHoZgAJXScT/N2zIg2lg6t
 I/XuI0rQIetuFwUz42dPgG/BqAr0t/tdOj2GArNdyEWJAIKp96ZcPFXXfNJrtsZbF8SE
 ggeMu9H5OS6346MFyssfdPRQyYh+OYJxNAbPbtIhYiF85Jqk5wDtmdHvbodrjbLKNZPw
 HdOYKtR2JyWpWHJRh7fMIs5VucEiI/fYsqzjBM0rnBeaFp2g0pLK9S/EkgsSVBlEBC9x
 lsvoymoEq9esUdFyv6VYd6be7cA0wNOiWReKuuFGmcpl7KBYORv67erVyrqo8RH50CZ6 DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484undsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDZh63008655;
        Tue, 25 Apr 2023 14:11:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616qpax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2NvE8t2CCjaACt4VSE6n9YAReX+NJHNO7b5yw3yaiBfILy5M4Ccosw6d2eKNz0pxSv9feFDHHkKiq6VEY4RTWqHfcBNmakgyUNKJDx1A7EsVMRQ3cfdSD9jd3sfObi7Z7O1T4dkeTTPX8WMUTL8MJipmCV7D7cqYXvmxCIr9kLHlrf/hg9hhIyQOW+WD+9rCgHSX+WNK4A40LZoTkAFKno96Fvy/SW9lsKPF8pCJR2DdXTWIzmoYSMkq/3HHvlwgXLjxK/Lz7RnDGdY59hLwvd43J89jPgUyS4ZXU4Xovvi5t/1WdixkH2poBf9bEqRm1EihlN6S6OhXW6NMdlq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WvxfxD+srrNnZyxfWsPROhv0EgqoD/8Wp1bZvKRdD4=;
 b=HseEM0TcQ51mAuB3VNMQN/54jACEUrd2fBeZbOMK6XfferC7O4a9eCgbzGJyGPv6YeH2i9hdfHcAy2kt8xsHkZigGgJe9kYdy/jJkmUxovV6q5KrWsTMponIvdkifhOLq0RYN8ZZ4v1EwABwFX01XkTF8h89Iyqbjjb104yUP976OnArcrlXPwWDHD3TvgIhykfXPxjTqLmJ7chd0NZuGLBVHW94H1cJblpcEaMhcfi0Sql0If2Sj8VfHtx5eWAj+nXNla9gvzLqYKLAkWBJJjo2aRA5dRP/Zq+cjtUclOZ7Qj0YH0c9fu8VjxtavlcGMw//RTwcM+3YPH7R6MT+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WvxfxD+srrNnZyxfWsPROhv0EgqoD/8Wp1bZvKRdD4=;
 b=DgBdnZPTwL8MRIZD4EEErmFBfVebQhKbj8zYAKJGxXDgOpqlyh6B7xO13QUpkC90n1Hr4d7R0GkBaO5DYOOk+xUaKuz0L06b+r5US5DgwFeTPcYv48VVxBj9IYMkWAIltAfIhpZTViPUG1MUhPCsWdjibuUqnJSxfQrRuTrsVN8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:15 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 23/34] maple_tree: Try harder to keep active node after mas_next()
Date:   Tue, 25 Apr 2023 10:09:44 -0400
Message-Id: <20230425140955.3834476-24-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a882c61-b27e-4436-b284-08db4596eea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xF8Z9iy02Vl9yNJa6yOlquWLM4U/5xW2dCoYXKSYUx5Z3nEJoGZRz6NyqxxoPMYO3kzKMF66iMetewRzQmvCVCiaTP4xzXglKlOnBDPmSTcJCngdcF4rbpXKr+8UDJxmIXl5lW7bNBUshhhB/2Lfcmnl8gNiRhhdP6VAsXwh2yA3/AqD7AjOo0+nkANPdIrIeG1cBeaMTmzDLE7y30kDVaOyaz5mLOY9o2c85LvEPbcAsLrRml6ABTjqMPG7GWdL0JoOH5kL+AryWSZrAHy0mY3ecw3KIozjPGq0sYCNEO9m1j7MVWoBwionmsWMXX9fKBwGGty3AeG2pJXWTrlYek1IHeRD9dGyZWGlpqxKu9EFgv29qlBO/iWuWWa3GcBZr9LiNGucb8u+dJyxdik+2wHWg4BHm36AWXDMnpKkeDuReKeETY35sNAU2bzcyBAdkgJBg/9zO2I2KTtBcOpKIT9Vt2i8Kfc/tcfrmN/HzJZeW0BtVr3wMx4n3Xnw+n0CPEc+vSjXEciZII7g39She1/FwNpxcgdUpxDZc8f3l+Pw/qoJ5YUohBOiwJEIpjXFToYKE8ZHZ8aNlI2j5S1rzAP4sZxemzo9HF5x8nAK+I/TVcU0xgdAQ5y9Eb13/LfGgXaqNSJ6eVzW1rJY8WMCJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uol0bo3KdgfB81IXg4cQZVhRzdgiD5MYRh9mEC2f8/6DqlAhMDj8iqujxSc?=
 =?us-ascii?Q?Rn2aEdABt2r+G3Df6WupObVo/cz0TdCRYNb4h1y9q/Dmhgq/g62dBdmes931?=
 =?us-ascii?Q?OZgkoUDHjg5tP8zNcmbAnXJTv5d/CFfA++yh0TBMy48dkmBZfrvA1GyCgRj7?=
 =?us-ascii?Q?NM7hT2DPl2akgE63FpiSon8YoUA+sZ0JtCUQln0QnYkp5WDuhiUgaPb/CCyS?=
 =?us-ascii?Q?VDoNsYmNROGtVQ9vo+8gkVefNKfJzLXWOa7oPM0XbOfo06rVrPlGNQ4TjPbh?=
 =?us-ascii?Q?x9M7wit+WCkaL123bCrMVezkxxRPAGy/pXV6vQwUXsvptKRSyh8ahSvUESul?=
 =?us-ascii?Q?+wj0rEdGJSesodCh4F7NUsddu2ySepQueS1l3xNIF6FOEQE/3Zvbt0U4Neda?=
 =?us-ascii?Q?/dOoXRV5mRbV+jCDp521H74g7eLf51IAOdqqjTcBWDMA2jXVXOweI34mimtw?=
 =?us-ascii?Q?cOL6ymLs2v6YysWkEvEVZkudOcuH6GemFiuIVvPD4A5Xxw1OkNwZyZFDWh71?=
 =?us-ascii?Q?DuZtvqId2TRzRaVcko1CD6XBcxnIpClfpVcZzTd8WRNz/1J9Hf9E737layQ5?=
 =?us-ascii?Q?5K0xSgPnuCvwSmja62D5+Orax7DIftzN1bpzzX4xHC8TkrHCBQN1GggNyhyh?=
 =?us-ascii?Q?uIzCEig0gMlshbiN59cyhdXd55ApCmElf6xptVQbRkgUFBuKB2AqkNGHRw23?=
 =?us-ascii?Q?BjwJU26WT/d+wWnC/+whhKKO9p3axda6GvmLzxRNduG4LOc/SQ1M9hNunv3d?=
 =?us-ascii?Q?0TtRxRP51bZqQYyIEa47+H/j7mgrvElVYdKLnbubKljJzssUmI5qs6439ZJW?=
 =?us-ascii?Q?BF2tbWbrGTeUnZfDzmxk+zl5XTTlyzmyOpT9DG0gfqAkEhBavf7HMuNg9qxt?=
 =?us-ascii?Q?eqpRx1Oc39xgidfCCZ9d6tW2uLYPKRVhId6pAzSDZUMEnAufbm1N/X98+oZn?=
 =?us-ascii?Q?s5XvL6a7AHm2XsDJQIOKKHQhf8sZn6IntdIwFoZNygoz8b7ujLnPD3uhhHJ9?=
 =?us-ascii?Q?MnPe/5TnzhsjZQgaYjMTnLowTU/0ctlrMbVxJTPp3jyjiJmtGa/nkBXJwlgo?=
 =?us-ascii?Q?VuQEIu16uaf2gAd23lznLM4cWS2S6gpr8qaEfOekeYqd+2wpoj2wFwMIO1aj?=
 =?us-ascii?Q?gxvrK91gri9gdNsdpKdWnwqD2FBnZIdDxpxj3UKf1NOV1jPwCF4HW7bBlkNb?=
 =?us-ascii?Q?n9h8rsb8rFk9da7knOzTGYTCLeBnyfFMM5RiDn9J0W7lKxKJtr0j1xGBz5jD?=
 =?us-ascii?Q?GfOhWameMphvZ3bpM9j7m8Yhb40ckx3EIGXVRlvZPGM1c/6tYd67pOhEZ7Bv?=
 =?us-ascii?Q?L3cDvGhDzJY7rVdAQzIr5oUXECvIMCF4Rb2BElK7Jj192EqupESMVTpyYgwm?=
 =?us-ascii?Q?1JWQX+AzTdnTHLopCyZUAB2obfyuxaU63hpuLK2MKT6UDMQzj/NUicFAKeVq?=
 =?us-ascii?Q?8qBu3HJalZEsCIFOv7tJ8Y1F4nRetL/yxzQvDriMoLYoJt8Rxve4Zru3l7tI?=
 =?us-ascii?Q?i9DCckll8pIu9zdfhQS36ttAhtHbsNYE8Mv+RgUYE3W48imRtrCA702CT5YY?=
 =?us-ascii?Q?gxUXbr4IdmW8DjBZju3sPzOZVPXnCPhEHtBdxlTv9XGnlbICHiJQv9njJ/dT?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5sxA7SnaFF32wa3SNfcKuB8ByOlk26QlO0MfOUViqy/cs1g4wQh2F5TeUUUPRBpTUGSk7MyMmEaVloO28AcscPEdP2HLF/06LZtMkz7QYo37jNH1Rz60l1xrKukEGZjSrutT+k5uQg7Utb+pPEuMOSIF6dKI83pCKf7prQfzYpwMdlsRcWjsghUim6+yj8KOW8yipNJ9HtLWg2Z9xOtCTb4Mb9+XIprqkureWs69/rgyKVzpT8jxxIoqoE2f7C4xnpkGPphq5cR76AwCFGZ9yACXP/S0VBoP5WIPZAoxVYeaqrF0HCEzUUiysfdh64iz99BSwkimgQ5ch6eACP6inNmx35CYnIT5O5/jJAn8WwcBXITxGv34r8sAy5RlDmOkpbhrtAU+NEB8IvMLN+V+dDiMntOD+AMmZrv85RJqdPZ0SJm8TIHb/ds42AnQXjzelaIgmIGlw7hwnz/wClj1O2zzHQi0zE7Al8UKUOB6GagfsjZW54+b7viq0E8ISbVvDznUsWkFQRQhCLUEPwYzTlz0sdZXAmIyiXmqentbjLEvTRBM3YT5Y4HrrtwEzkIongh3CTAGytesd1cE0Qsgcs91yDiDQRO1vbrnlLlT3wfFXiULcqpCoTE+JTOpljCgfH8LuSmUKjGP1gXeSraqsCQM9OQVx0pxG5dxx8nV9zZRXxPpDLsI5ErbclRuNwMeReobeplkv8x1seNFnV1vJ5jNWwahltgJ0Dv3UK/4t+pwiN3+YvYw971dG9wPFWveZVHfGvPv4QEgd1RGkd1mApVQ1t1PgavdpEVlDS70gBW5AwgMOoIAjCC2cMCgjkhKN5s45ABZMiJ6rG56G7QXL3b4yIAblwqnl5QBtYiNCSak5u/btNlgavlU8UY++a+0XixqVSe5H5Dtmm8uBybo6A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a882c61-b27e-4436-b284-08db4596eea0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:15.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqzbQnfANxGGj1kQjhxrZXk6utvhMKvMQ0SvQVC5iJbboT3Ju3Od8IXgSIdWlYo5kGzkOjqgefRU/h2WKbP5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: bynY_zJYe4DUneV7ZV7-6mUfRe_XRueG
X-Proofpoint-ORIG-GUID: bynY_zJYe4DUneV7ZV7-6mUfRe_XRueG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the mas_next() call to try and keep a node reference when
possible.  This will avoid re-walking the tree in most cases.

Also clean up the single entry tree handling to ensure index/last are
consistent with what one would expect. (returning NULL with limit of
1-oo).

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 89 +++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1542274dc2b7f..ef7a6ceca864c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4727,33 +4727,25 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 		if (ma_dead_node(node))
 			return NULL;
 
+		mas->last = pivot;
 		if (entry)
-			goto found;
+			return entry;
 
 		if (pivot >= max)
 			return NULL;
 
+		if (pivot >= mas->max)
+			return NULL;
+
 		mas->index = pivot + 1;
 		mas->offset++;
 	}
 
-	if (mas->index > mas->max) {
-		mas->index = mas->last;
-		return NULL;
-	}
-
-	pivot = mas_safe_pivot(mas, pivots, mas->offset, type);
+	pivot = mas_logical_pivot(mas, pivots, mas->offset, type);
 	entry = mas_slot(mas, slots, mas->offset);
 	if (ma_dead_node(node))
 		return NULL;
 
-	if (!pivot)
-		return NULL;
-
-	if (!entry)
-		return NULL;
-
-found:
 	mas->last = pivot;
 	return entry;
 }
@@ -4782,21 +4774,15 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry = NULL;
-	struct maple_enode *prev_node;
 	struct maple_node *node;
-	unsigned char offset;
 	unsigned long last;
 	enum maple_type mt;
 
-	if (mas->index > limit) {
-		mas->index = mas->last = limit;
-		mas_pause(mas);
+	if (mas->last >= limit)
 		return NULL;
-	}
+
 	last = mas->last;
 retry:
-	offset = mas->offset;
-	prev_node = mas->node;
 	node = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	mas->offset++;
@@ -4815,12 +4801,10 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 		if (likely(entry))
 			return entry;
 
-		if (unlikely((mas->index > limit)))
-			break;
+		if (unlikely((mas->last >= limit)))
+			return NULL;
 
 next_node:
-		prev_node = mas->node;
-		offset = mas->offset;
 		if (unlikely(mas_next_node(mas, node, limit))) {
 			mas_rewalk(mas, last);
 			goto retry;
@@ -4830,9 +4814,6 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 		mt = mte_node_type(mas->node);
 	}
 
-	mas->index = mas->last = limit;
-	mas->offset = offset;
-	mas->node = prev_node;
 	return NULL;
 }
 
@@ -5920,6 +5901,8 @@ EXPORT_SYMBOL_GPL(mas_expected_entries);
  */
 void *mas_next(struct ma_state *mas, unsigned long max)
 {
+	bool was_none = mas_is_none(mas);
+
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
 
@@ -5927,16 +5910,16 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
 
 	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+		if (was_none && mas->index == 0) {
+			mas->index = mas->last = 0;
+			return mas_root(mas);
 		}
+		mas->index = 1;
+		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
 		return NULL;
 	}
 
-	if (mas->last == ULONG_MAX)
-		return NULL;
-
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
 }
@@ -6060,17 +6043,25 @@ EXPORT_SYMBOL_GPL(mas_pause);
  */
 void *mas_find(struct ma_state *mas, unsigned long max)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (unlikely(mas->last >= max))
+			return NULL;
+
+		mas->index = mas->last;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
-			mas->node = MAS_NONE;
+		if (unlikely(mas->last >= max))
 			return NULL;
-		}
+
 		mas->node = MAS_START;
 		mas->index = ++mas->last;
 	}
 
-	if (unlikely(mas_is_none(mas)))
-		mas->node = MAS_START;
+
+	if (unlikely(mas_is_ptr(mas)))
+		goto ptr_out_of_range;
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
@@ -6082,13 +6073,27 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		entry = mas_walk(mas);
 		if (entry)
 			return entry;
+
 	}
 
-	if (unlikely(!mas_searchable(mas)))
+	if (unlikely(!mas_searchable(mas))) {
+		if (unlikely(mas_is_ptr(mas)))
+			goto ptr_out_of_range;
+
+		return NULL;
+	}
+
+	if (mas->index == max)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
+
+ptr_out_of_range:
+	mas->node = MAS_NONE;
+	mas->index = 1;
+	mas->last = ULONG_MAX;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -6519,7 +6524,7 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (entry)
 		goto unlock;
 
-	while (mas_searchable(&mas) && (mas.index < max)) {
+	while (mas_searchable(&mas) && (mas.last < max)) {
 		entry = mas_next_entry(&mas, max);
 		if (likely(entry && !xa_is_zero(entry)))
 			break;
-- 
2.39.2

