Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACEE6F87E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjEERpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjEERpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:45:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62A1A4BD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Hh6Bb027906;
        Fri, 5 May 2023 17:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fS3QzFuLOtxJjXjPIV+nCtOmoBdMiTTxr1dJoGyuKyc=;
 b=JHS7b5VTcmxg3kI8kEVsQAC4Ti1h5KVNcZHnG4g9x6Jtoz21LZ22SdikdlT2Ec0svw8m
 YyCCMT1gBmtk7WMbK0hp9AUYTWds89ihmx1jlyRTA98y/931icU42GOtH8sdVNAaRyvD
 JmDDatY5lx3lO2eHIU66Duy83u3vNu4zUOWV1DCbn3ZAm2IZoO6dwRR0c/7O1qP2d8Cu
 cK7Hr3vYATv0qKG4VOF/4kAZ9lAGnP6OLPWiwVAWMacYxllKp9qtq4zBVRT8elGWFNip
 eW5zFlssBhsxHIrrRNhEvNP3o8BaYTPilxnQXdS7iO0xuGRnInjuwTvfSCukaXpAAtqh Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fwf3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GHB5t020761;
        Fri, 5 May 2023 17:44:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5fbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcKTlijIpSfzxtY4xlFYqqfczGnV3EEHI3a0kKjjGGIbo5goYdQEwJHo4/ahyJh8wK670VRrDypHnkQWNfedukwWnO+QCu/5/D14BvRnRn8Rp4eCtvZtgMVfIqvVmvM6Q3zhl5XxZ79wIfOhQ4MtkbHs7J+RTTEnAkYtVxMmmwiaq6dD2d1nDv7Mb/CaNmswGPnOnRZwo5hRWI+7W6T/YMxgtIIkWAS+jxSbi9NO9ocrIfGiaWh6xmZDPig7PimNF4uQihCl8BnobK8dNvIzoHb/BSq7KAf5EaFvMySiZq6+g+ibNSLVJn7kpCUouw6fByyKm4TLZLx6qcOctWm5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS3QzFuLOtxJjXjPIV+nCtOmoBdMiTTxr1dJoGyuKyc=;
 b=BL53pTWtZ2TQjrSyUHMvwBFsRu4YpMqdFEB7HZcbTheeY9rpa8VQ0JAoOz+JvE+XWciSw9uvkeKl6DJizb1ssI/vVUsdhzQmPZ76DuEf8fh4gslSflanHp5Er+mi4JhkMPxYnClkctNztNVKFs6AT9/GCVrL6JUrSwvO9TBhcUUYZs5TdIE2ISWzJRaPRYb8Z4mt86xOSCPyWdih9S3mFX6gLK4b8FODUGCxLuEhZ3CLV/L3kAM+e04kp7sqXK2uCztVoH0MW6ATIf3tjhA7KAj7LceICjS3Uw6R81oVWXt6BeDVUURL2wSqq0pU6Sh4niNuWS8a/ERvdnh/u0zyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS3QzFuLOtxJjXjPIV+nCtOmoBdMiTTxr1dJoGyuKyc=;
 b=oDzev12CfoX9CrqodZqUfUZR+pAHGavHs4HtihNQoeQ0t9LlAbY6taRoflS/2eqn1WBRtdR5ZpgwZBwxddiAEOrs9oKEgQZ8Tn+tBYmbhtgp7cxfr09ZFkWU9sBDUWDVMYiOFGSP4KurDGdOFK0E4NbAHiZ5Cny1NR4KX8TumtM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:13 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 13/36] maple_tree: Use MAS_WR_BUG_ON() in mas_store_prealloc()
Date:   Fri,  5 May 2023 13:41:41 -0400
Message-Id: <20230505174204.2665599-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cb0878-2d0f-4038-bba4-08db4d905715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: doZ9hF5MoukUp4x0aD7+p7F2zFLmT73DcjH+3apq5YqTyB0TyxC0iNwBsLEhuizFwr4rJ24mfb8FwYhveVOSwZzt6WmbIWMIYYen7sDxkDn+Lrup/V6cK/6/pyT9uB32h5FQgQ4VCv+Nhh1Ytv6DHwcBVTbI7S5358m2+q5uVxeIjuH5hVqnWNK385/6UtLNZ2Ue5mr0koQzBMGJKnubEx2V8Nro2bWjEk3ymTQB98COXRrO/+K1Af9eXgn6RZfMZ1VTzDaKytJpe4s4zdH0bi9IBxDJhoHujrlX7S8wBNIVrBeoxXNeoSRGdEqhioblLy8R1hPzRYfATyptGVEOlULNniiUyi+lJBBuvsiJlp1Ft98C+2LvTTc8qN1pRTMPl0+3tnySOiQ9fmGAYDh0kWBWGKwDoQ8ZPuGQ3AbmCIamAahDKpT462N+yo43gf4pim/XQ6O3AhbWuhUyahxFtKyaI49XPGIrEZBboeDiVaCX2Tr9jPlWTNO2drMIx91pqhyk3ISFL1mKdQlj91/MD35u/Y1nPW2bGKbuVPZPuTUyS8HJ+RfPpDrBkhvBuBKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(4744005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPM1q+8DzgdB1pFNufba6gWqBwrJH4VCI/C9mJNyHghyJPyiwCWy0CHjoKp6?=
 =?us-ascii?Q?a9fpGsc7xQh2c0PZ6P2zIWPM/3Ge2syZKJqSHtqETuDZfh0/F1HOTa1IFDSK?=
 =?us-ascii?Q?yha5QrfcsNdsQH2x26AqZPQ5A7b5JPG2ditI2EGqRZ2JywnQ3uQi53XIef8Q?=
 =?us-ascii?Q?rnah3QzPwIZhenczqpLdFRSlaKeSd4VM8DZRXU2/XiieUm1qhhVk/0fKGq27?=
 =?us-ascii?Q?ST8mMNwpiLOFbFRAqfXPhuNauUdsspQN4xeuXpPrVgJd9F/jRhmsScMssmCO?=
 =?us-ascii?Q?2QsZw2Z1XmOVwHeFHc0XQp0UUkrnnERwORDib0MGAlLTb39hbIOwxX/r3t4x?=
 =?us-ascii?Q?uDi3yIyctMXAF1F5HdET5Z6AfomnHanShBY+o9MZ9CuJLV98AcgR8ccP7thG?=
 =?us-ascii?Q?GGdAet++j+wraP7+M5iFXOeYrp9F3PWE4ZY+zanQ0fJxoeopH30gUH+9j5tp?=
 =?us-ascii?Q?vZkTxl2e1rDqmwqV3Zp20IzFJ2KMHjAC/yscNA64n9W2cC0Tsy3tB0Lz/vq1?=
 =?us-ascii?Q?zCTAvNiFnDgVz9XkHCghgKu6zlupPiSXo478e1Bwmg1bSyfWp3isBQGleTTC?=
 =?us-ascii?Q?+4ymDgNl+m4KP2XZh0z0+ojzdyf7aBiaGPYMq/INdHAGNI7D0Oy+9EAp+eO1?=
 =?us-ascii?Q?FEogMYwS9XaiZxaApVp9TADt+GwpT8qXDoNwDIYr80PMfv4K9fxI8oRjj2rJ?=
 =?us-ascii?Q?/BNQSGViYNrMZ6ocyoX2jaiDIn2RAg+cIUWGAzkxJcVGG/2C62NGH9dg1/3K?=
 =?us-ascii?Q?Zkk8K3/NqXPvopMBrKRK+4s/aMmKnyVhZ77bpMrsVSnzQzX5xhBvLMrMNcXm?=
 =?us-ascii?Q?MnQsF0XiE3xBxvTdM6O7UKfxIYHz8kXucjGTeTJUulvtaWjq9UCusZdHNsSh?=
 =?us-ascii?Q?T/td8kAUrkUr7OPh8wvTUD5IBNkiQS1tt3MHb2RLK+mCQuygptG43Ymf5RNT?=
 =?us-ascii?Q?vLU4TacrywI+8In3GN712CC138LcMfLOHqJpeWJqYBahIf8L97YX/bUC14q7?=
 =?us-ascii?Q?fUs8o9cL7b62CJPsUlq4f8p9IuYdlsgK4mB+QlbzhMfuWUFrdpd3w+fSnXSS?=
 =?us-ascii?Q?aA/srExqQuqjZLriIIJf8Do4VKglE4NSLMvUXFk6EzUqEdVunNHrhhAENZ82?=
 =?us-ascii?Q?v8TmrMZJvrp5k0x6lntpaahihqYCD0/5OB7wOK1qGIozO4xQ9gmg4Ad/XoeL?=
 =?us-ascii?Q?wO630k2lvxh0a8OxsJ3NnwQqbXEinT6xcpgZT+cFszGxRdwECfCzt1nerKP0?=
 =?us-ascii?Q?o5tknowjVwbC1QqoBcoY+vSP09dCtRxeB2p704N/OMopmvukxSnQcMReRhID?=
 =?us-ascii?Q?O8qIXS1BSpQ89jvkYGCKH4Qui35mEgd+ZShguGXBvLUCG5zoleozlqzMOPvv?=
 =?us-ascii?Q?MTtiL7k2AMBmnwTFp8mGtlqTmLn6iTrGYydPpNMZQG71uNUn1zo/7EcCFuu6?=
 =?us-ascii?Q?uL2NeyWvayTvm8h5Xuf/sIjyt2ChkyJglaahOgtRSrosKt/ZzaZE4mw3jEbz?=
 =?us-ascii?Q?+DjVvYH/zcKSm/CVYJyvt6b80qkU5HQ99/hx5oI7jMyTQlos2kjEZ7cH3C3Y?=
 =?us-ascii?Q?XiQcP2UHZK9pSK2n5n3pqjZbu17QvAK/j0DYlldRl2LhK0/HsKle0t+r3Q2h?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8qhdGadaK3J/OFLYH7TOPQhXMxxgvG4B7k5BT1qNRsJSwHcInEbOm3DyY4neD5a1oedOQe+rhBBsBk3VXlFd+0qT2rNUVmcGdQ7zLyROzmHt5iNL6oU+Fpd6Xfm7TdLDgXb/lmBbWumctHS6JtsPAX2mv6i2dd+dDMPo5P2BU18BJAfhuQhljB7NTh9rgzHQXNLD172ZtSzbPFchBxjim6WURb12y0YUSgEdnEf4HRYS4LqfYpHxbQFTwaDE4IPQ6yn8dCRAHvA6DTi/9UuXmrwFQTlLe/dWB2lcBaC7RVKqiOFnDisYPjuA/0B/Q2GKbSDy6Xld80Tp4kRHGhLnlHpBDrOt46uDQtIgumidc3Mh97EkEPtbfeXeuYT6SQb05Tppk1zZJfDqk0R6T+SGHdu9f1ICSW8+5hKcE82484EHmp6em2jDp4GCQ7k+ofLZOzkEASDxZ/gPkWFpj4EYki1EHO0uqtnBsKe9NvZGQi5GN+pFdG/Fz8GiMf4xlTKTRIZV60uReR9eNxam2KEo+YHdWDgnJ26BavYJg6WwcOsvRzs0f2tjGldrJhs67j7iMEAekKe5kdGjyfijRnlzMilH3N9nJZmTcp3BpsO3vWTi0Ogtv5MW7tng4OoegFq9doYwc+RZhRXPV7vKjTW7gr4bZO13m0dKPF7sRt0Qn2bLpd67HnPpgMnMFA8h/AcvS4H3PNk1ECqwPO5suN6VQ1ZVsZ5IGvSyBAf61kj9KkZHw42ncBBPkSBjwc7C+mzah3dy+dxUXnepn8IWimKryVyGTxC19HOWpzoVLOEkqtruAvj28pAgTvsYl//wEBRXfj/CT8nfxN6KjNppaU0RnwjlkP6yBrOEOo+I8Pb+fOUFyss0FJVWqO+w+0IrF1+xpuleZQEjZRUA3FRdukeAvQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cb0878-2d0f-4038-bba4-08db4d905715
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:13.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rorvM8ncg8TIBPwTacTbXFmer6WvQa9lZ+6nzf5pAxflbqGlls/IlXtk9PDQZKRCcTXFk1OHHJ067vwZBYrCoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: hU4HFTngmMBmCtnLrJ29gfnmbBSHgVcL
X-Proofpoint-ORIG-GUID: hU4HFTngmMBmCtnLrJ29gfnmbBSHgVcL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_store_prealloc() should never fail, but if it does due to internal
tree issues then get as much debug information as possible prior to
crashing the kernel.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 824967872d426..d5ccf7bcf3b5d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5761,7 +5761,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 	mas_wr_store_setup(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
-	BUG_ON(mas_is_err(mas));
+	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
 	mas_destroy(mas);
 }
 EXPORT_SYMBOL_GPL(mas_store_prealloc);
-- 
2.39.2

