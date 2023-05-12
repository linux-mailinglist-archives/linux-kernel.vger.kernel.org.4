Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F92700EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjELSYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbjELSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:24:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94CD2D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:23:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4h4I027772;
        Fri, 12 May 2023 18:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fsyQwfTeDy5ayKJkXFXTOFKtamH8A+PUI8fo/saIhX4=;
 b=drhECTdyOlQSrOYPNtSa5Luy3B8rjVG2Dfx0LHr50+Ztm4FcuOqIJ37EXWH2IwJfw6GU
 DZE2kDCyHqrE7dVACS851TCRNcCrTMIdtdsHRq9YARs245tB8JJsprP87oTT2Jlmfcy6
 hnimraL0TjKOCP/mmq5AroqlgWW2WhGz1ES6Wdc2XV54AZjcf9uL5icrzFhflmLwpeld
 eh9uyt07o8rsF9y+cA2SbLZvMhB9qLFVo8LwUEBJhm0vOrp2be4j6ZO3PAUY3wr/Xttl
 y0+m8IodP/RnpLDpMG140mv5Dk59tyVN9re3UQLk8DL8uYd5rqrYTSWXop6UoOv9VYWz Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77cbpxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGbZDm011613;
        Fri, 12 May 2023 18:22:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81570de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrtTuIru4xhxYSrhW9dN4oORgZIxbacnJpqasAj52fMTuFUaETghlU5BmEstyx5TmfYWaSZpq6VyGPh6tMRhHXqiZ8/4BXH7c2tnhTvt15pK/n4IuGT5ZrTjqM8X8DE7GoYythItUn+Ny3ffyLRb5Sw2g04SFMU+kF0j4Wb6dWjHXLPvk+bhpmcED0bDgx6nibp2HyDpa+zmZ+Fq2MibIInnLbHHq7jG8RiVAU1+WEmVGW+GeJiYHKtKvJuSlbtTssCNIz3LesvQQc2RJAQ4B4cpnpdQaWkXYNAZtQmSa8VidOd5028kzcgpcKZQiY+ITTAyyJ4Tx8uKuW39B73ScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsyQwfTeDy5ayKJkXFXTOFKtamH8A+PUI8fo/saIhX4=;
 b=B8sxJh7mU2hMlFlaRQSjIUz82Y/uTrF3BfT64Y0XqQx+nx9kKZCqI4kR5Sn7hiJvETjinZ3CGBjvkgx/cL1jpRRY90aK4uWd1xVhZO7CAL/9hma08Q7310MfB8T4OWZlJt2WRa8y/UoqHhvDyBTZd8+zjlW6nHHNdDLfqP7rrIjox98eX4SIhoAs0TlzRhosgI6YVe53Q4RsAbil6KElnGTMTrM2GF4o30sw6p38VHILLVff1jcd+FknjjGyCgFUPh5nmxNIWgFQuR/g1uHmbeAaaMHSrqfAXhGI21+IVMkJ3GMaiG7w0k6gGuxuwjibgsmmJgcBBKaleXQ6tQaufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsyQwfTeDy5ayKJkXFXTOFKtamH8A+PUI8fo/saIhX4=;
 b=FdgvtUKf6Bym2z0tlRwpW1ibEkyx61wJ+fFRQfeIjwA+GYGmleQK4xYsvek1Fvc46t1fQHmiack+ltTri00bZsWDJEmJ4LCV55NRIW+0+QcBWldzR6Xf4F6Hm2uzRo2i9UlRWFc6mO0WRZt/ZmVPF0/dPcRFtaWmSCCsEz91EdM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:09 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v3 31/35] maple_tree: Add mas_prev_range() and mas_find_range_rev interface
Date:   Fri, 12 May 2023 14:20:32 -0400
Message-Id: <20230512182036.359030-32-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c38b07-bba9-4376-e8b1-08db5315cc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqGMdrtbSBJ3HQrNsDxTUm5/wJSzX5Cw/SyBk0obokkLnzquvyzJ6sfmXJXWVm67980xis7hU37YN09xL1CnxFT/Ww1OmVoN0XQ0bRGB8cWDyO4o8uEHdQ3MtRQT9yr/DuPsZiPenqBBlc5kF2hz6zOktGnPP9FRViBFEZY4SHVRIX+fA4itkaq726grKna2YM2CHWjkSGM4QrqGxRGKcvoZuS/U0jJ9ohhRzvEXwNvwzyGug5qWT6dJl+XW68gSiOVi2k+fqx+e8QJ3PtLKybwN5IFBZT825mZQk63erRAcJmrwFH7KkUgKPq1ZJG5UHi64fFvBN419RCzpwj5MOih1w2Yw5M52LgYV5gU9qpCslAD9/2KsTYl8l0FGkS6purEGYFZNQ0HFjIvhF1pnQs05Nbj5tWFJrJo6Tv3U4rK7unnf/L3tix+aDNmOOz6K9vZN9ocI5zxLIwi999QBUJ53SyKJ8u195yXRPUlBoSRl/hLkCBk1rg9f7+pDaA6TS4SrAf2PdijMNloEXAfuCeJppmJGovIWaymQzJDOdLHjk8pE+I9DbMx1pwCp6/Gj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(54906003)(83380400001)(5660300002)(6486002)(316002)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oIpa4+C6m1WFdbJRp43wJ45rKc7F4ma3Vb/VlkAYf0ypRZ+JZkYUNzM8Cu0D?=
 =?us-ascii?Q?VDOFMV18IaWGaDf2FcOwQYj9u/ZCk9RziZ47JXJ8+0NtiPdK7JE9zi8jHp4p?=
 =?us-ascii?Q?3wZ8b/1rVsq+QsZUAjq9TctabxdCXFycqKN3Cz9XlAROQIlCUp4WJkht8fmm?=
 =?us-ascii?Q?MraSTkcg9DLPKMHCTZPhlS3j3NUmwIend+grKHUQb3/sWoNTvY+XAR2jZD10?=
 =?us-ascii?Q?D7rnPwcnVYoLkDml2P7ds8zTTf1SUoG+uB9ppqs+jf5FFZd1SzelMtOD+KOH?=
 =?us-ascii?Q?23ffR2jHV8p/0mbXfa7E7ooGb/UPJJ17CfTrQyOVT3cC8jLAd05Vt3hdpxsj?=
 =?us-ascii?Q?UHfEXeMn8ZrA5F6HAqIpap0239/zlDm4sOvrDng7aFE3RrfVCIoxhMWnmlkn?=
 =?us-ascii?Q?308Gfy9/18Jdd5XD+zoF0f5of6tMe32nmZuZFvEhGXQt5F8gU5Ou9RDaBweN?=
 =?us-ascii?Q?sdyl83IUVXRp+SR2VdBMc96Gg3KQyVJbuBTcSKWPxeha8QJtxB+RO9pTy6QV?=
 =?us-ascii?Q?9Hh/ISFnjbg38WptM+NFbEIg36gv4EudmkiUw/lJ3xu2oavX+oFaoNejrMif?=
 =?us-ascii?Q?xCDrvLR4vlbo59q1bClSYbqaqjOznLrR+Efl9tz62EzB/yqK1pixAtUwJbOp?=
 =?us-ascii?Q?XQeT8i7tcXKjlBDrrcEDDamn8kzz/Ub9FIdCTSL387LrGWNZgQjRhlIGox0v?=
 =?us-ascii?Q?sTlwPlCy0zgJl6sE93KnumIg0N0AD+kOWEbRWlsi334B7UNv2PKlW7024f0C?=
 =?us-ascii?Q?zom0uoa21c77RirVUz1Pruz2ZuWKbHWRBjBQGJFs6RewDwzh01lgg5nN6F6C?=
 =?us-ascii?Q?4f7zopBPxrZT5YPEBU3xJiEXheRVzDXky1wxoN8+i66wxKSaoyHU+Z1Zr1ni?=
 =?us-ascii?Q?KP+uBdXVkh0h5BoQlJUtJN19E4p1kzqXsHuKeMm5+ZEK/8J1Q7LeJl6WDwwN?=
 =?us-ascii?Q?rJcRdgSfU5FLA8/BRzH5JKFdX3z0po8DYkpkoO7jvStK7fJ9VyFxHVARTHmE?=
 =?us-ascii?Q?fnnzyfhd9o/ZJF1SnxQVrQ9fXIVQ1VjnMuOHdVC2BWc6dvsEkbVU5s61wwge?=
 =?us-ascii?Q?AycvFxbwGCx3sZs17WY5ED5Hjb/LEKTtTw4jCFZDjmbc90eqa8e5mQZDztKx?=
 =?us-ascii?Q?1l0LjluYWYvli9p2hR9xMcFH4Bm7aAw8SXmi7f6AysDdmF01Ek53hrT4YMSW?=
 =?us-ascii?Q?II607B/yijmZX0B6Z8wIv+OIkzTIRiJAn/UfEJQFlcLt65DxdoZffIO5geeh?=
 =?us-ascii?Q?VPAKW/FxKRU83J38ODycN9MroPOjzHuLnKSShVLcZ3xUgHQIuiOa/VZC03Gv?=
 =?us-ascii?Q?1niuuyQ0Ddju17rz/CiCinNz+enxWJU4twB9LmpJhcs98vOIsGOpZ795Dbur?=
 =?us-ascii?Q?fGBRoviZdc8JDltXZw+bPz5Nt2tQPXhtfjwGii7ZtgwnzXM3yVR/s7kLZDyY?=
 =?us-ascii?Q?3SrUaKRq1cf09jC43+4vWK4GOwmcAVt+deks+DysZOvJgEm6fhsEr8KtsEf/?=
 =?us-ascii?Q?sz05fUBRZmk0i+jkH/Cz//YW287WbhBCvRhT6b2k7213wBDDsEmJkKusyoZV?=
 =?us-ascii?Q?LFcJabapnGwpbekaa7fQm23FKNDpSr0rIwq+Efi5+t5KSzV9xoCAtsp1vwMZ?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IK++kfRjaHZtIr+lgNp3AAzhEoRmNKUa6cvjUsp6TU0eOnwEJ97Q9Loq82yaY7J7E8AT2oQPLm82iGCuS9naGHJ89/BbXuhdMPR3up5FDev6aJs+fy7ForAspeWULHwYqkCdlFzUscl3FK4kMvW1i8XfE+OYhbwlSDYltbUIEmgRz8vCw41SuQUrwCaWPAslkuFU6rryGQFdaD/TIM6qQVmlOOrnhNtRaLwc9IjkEgjRmBBGsrrMuzh+voj3/x4bEnnHPMeFkT+Luoe2WCia/shq/BjHHefExJUNG01AhYNYhswmJ1fLj6DS+2nigiRoo0irbWlOncr7gLHJmHmGPLeNFsXdZjRNbXQ7diUmcN02LLnKXa37lcw+eKAXwkmbwCCM6tZi/WL/EdRFtV8j9CLIXLF+oz60RnI+iWeHOcQU9ZuKzJnu8yJdgmGeEbikPi0CsdiF7MKK6n0202fzsZAyV7gmXsEN14Ih/D3O/9/ddoikeK04M5cBrejxeqtqhodBOrOQsJ600pEictPRSaN09+kd4hm5QfTTSanaXMnVRSbvH+NvF37HgEYKHuJ/xF8MKqtohzQbrcU+RJ7Gyrqc1y6apzvM3EQAhCN9zKh6fPCymNOOrUNvUYmfF83Oz+Me/iXM/q3Wa11OWBvLu3vRNQAklR3Zsnj4KosSpKUvgVDybOyirFoRtY8M3hQUwrpx0M7xjWw19PCckCn1/S85KmrmZXz8OjDn16FuBsX1RvV8gZiB4e67vTnxEPYdX6VsL06bRku9rWmbJerpo3WhVbjWCMXqx0LgFxn68DfxyEOz4H+qvxD5ZzOENp+X8vVfvoesU6oTINoeFVMxIcb30Z+PjwTqjPA2NzFN2B9eVFNppMwME9Rb5g1Mw2f/KIEuAIJKbHXMoUr6wym3qfiI/cc/UJWS4i5Th98zLNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c38b07-bba9-4376-e8b1-08db5315cc99
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:09.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ky3eZwJ8zRM2zejQPcQr/BXAp0e+XeXdve12VlkAQcWYYjs0ia4U7/BxFJofg98VJndSsiSzf/K5xwlTxNvUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: BH5HRtyGJHJSKTh_ErAHXRcob9nmF5it
X-Proofpoint-ORIG-GUID: BH5HRtyGJHJSKTh_ErAHXRcob9nmF5it
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the previous range
regardless of the value stored there.  Add this interface as well as the
'find' variant to support walking to the first value, then iterating
over the previous ranges.

Cc: Vernon Yang <vernon2gm@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |   2 +
 lib/maple_tree.c           | 163 ++++++++++++++++++++++++++++---------
 2 files changed, 125 insertions(+), 40 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a4cd8f891a090..85559a34a0987 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -457,6 +457,7 @@ void mas_store_prealloc(struct ma_state *mas, void *entry);
 void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
+void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
 int mas_preallocate(struct ma_state *mas, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
@@ -467,6 +468,7 @@ void mas_destroy(struct ma_state *mas);
 int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
+void *mas_prev_range(struct ma_state *mas, unsigned long max);
 void *mas_next(struct ma_state *mas, unsigned long max);
 void *mas_next_range(struct ma_state *mas, unsigned long max);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f88c60f43afc8..fd4f9f766cf23 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4603,7 +4603,7 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 {
 	void *entry;
 	void __rcu **slots;
@@ -5924,18 +5924,8 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mt_next);
 
-/**
- * mas_prev() - Get the previous entry
- * @mas: The maple state
- * @min: The minimum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
- * searchable nodes.
- *
- * Return: the previous value or %NULL.
- */
-void *mas_prev(struct ma_state *mas, unsigned long min)
+static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
 	if (mas->index <= min)
 		goto none;
@@ -5953,7 +5943,8 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		if (!mas->index)
 			goto none;
 		mas->index = mas->last = 0;
-		return mas_root(mas);
+		*entry = mas_root(mas);
+		return true;
 	}
 
 	if (mas_is_none(mas)) {
@@ -5961,18 +5952,64 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 			/* Walked to out-of-range pointer? */
 			mas->index = mas->last = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
-		return NULL;
+		return true;
 	}
-	return mas_prev_slot(mas, min, false);
+
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_prev() - Get the previous entry
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min, false);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
+/**
+ * mas_prev_range() - Advance to the previous range
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev_range(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min, true);
+}
+EXPORT_SYMBOL_GPL(mas_prev_range);
+
 /**
  * mt_prev() - get the previous value in the maple tree
  * @mt: The maple tree
@@ -6119,20 +6156,18 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
 EXPORT_SYMBOL_GPL(mas_find_range);
 
 /**
- * mas_find_rev: On the first call, find the first non-null entry at or below
- * mas->index down to %min.  Otherwise find the first non-null entry below
- * mas->index down to %min.
+ * mas_find_rev_setup() - Internal function to set up mas_find_*_rev()
  * @mas: The maple state
- * @min: The minimum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * @min: The minimum index
+ * @entry: Pointer to the entry
  *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find_rev(struct ma_state *mas, unsigned long min)
+static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (mas->index <= min)
 			goto none;
@@ -6144,7 +6179,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
-			return NULL;
+			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
@@ -6152,14 +6187,12 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index < min)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 	}
 
 	if (unlikely(!mas_searchable(mas))) {
@@ -6173,22 +6206,72 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			 */
 			mas->last = mas->index = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
 	}
 
 	if (mas->index < min)
-		return NULL;
+		return true;
 
-	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find_rev: On the first call, find the first non-null entry at or below
+ * mas->index down to %min.  Otherwise find the first non-null entry below
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, false);
+
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
+/**
+ * mas_find_range_rev: On the first call, find the first non-null entry at or
+ * below mas->index down to %min.  Otherwise advance to the previous slot after
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, true);
+}
+EXPORT_SYMBOL_GPL(mas_find_range_rev);
+
 /**
  * mas_erase() - Find the range in which index resides and erase the entire
  * range.
-- 
2.39.2

