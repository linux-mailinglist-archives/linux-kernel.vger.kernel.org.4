Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C65E675E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiIVPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIVPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:43:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF7F3134
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:42:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDk22N032064;
        Thu, 22 Sep 2022 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=v+Tc9+1YIxWX9qFepHQAITxeeRxTqqPAYej/GQQcHVQ=;
 b=XGWOJRpIL34IS3eBE9qtHBD6XljV6vr1tKzXsJ/uznVRc7w4ZIfRiQ7V7qqhXMtewtPK
 s8g6JJHlf2uJyFdF23Ij6vjC6KrcgNaA7xzjZ/7JhpHvCL0OCvTq+cclnZWbegtuVSZU
 Ija2ZrUZk3UTjwoXlsAnLzII1fd0oMGGKXzb35wSoxeIDoRgnCUoGDQojmE5Z/sQYyjz
 8XTb/6ppvzmR2zVomci99kXd+9oXcaZMmcgEbQOT/EEV/Jo4NgDPHwH0VgiE9tBvJSAO
 Rn4ua8HPSJpmPYOaVR7jPyeKWTfZlV30p7r6K1j3iFl7sHJ+Bty4BL32d92xCpiDmtCY Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kwxm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDwbA3005638;
        Thu, 22 Sep 2022 15:42:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cqrf4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXKF5LxdJO5K+Ev/BRkiIvdaBv05SS4aP45To2oH0NnNUnME8JPsG11PfpsDAddSmeubConfCn6B4fl7zjKA5CilOJCX7pRwCUfJydppWIwoaodgJ+LAjUbyVgxV72RYMYuzYxqAcfDk49Nr0LbSVa3XFQtEDuklXFMN4eyKc/dfc3BAJ/looDfyrD1Wz3zOT+5MeZ0kKSszP0+dz/ACCUB/k4qiWK7bQW3B28xrpwrlObgJ5SihcuGzxk2RAmb/1WbmiRlTpQxQ+3H6aR4NzajruSdGX98GjX7wNiaG2emLPb1mqUAcJ0l8zbENRgThoy824cL0HPcqIMveL5vLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+Tc9+1YIxWX9qFepHQAITxeeRxTqqPAYej/GQQcHVQ=;
 b=Xw3gXNsDtxehciyEBB9ChUo/+261bjWgsdT9C09ejodzL7mO9kfPWBYznXt1aDqHFV2fcch8ZJ/sTrM5p8ZJ8UlmoTnrDA2Rzx0JDurIv7x+z9FNxEiyS4SblL2pjDfYrw5WSUi7F1/yZ9URn0qjxtgiEwBWdxxhAxcbTKBE1wMdS9S9zp8/t72hRF//ctjQVhUq461D/KSjCW88ivak+M2TB6GtfyI9ZtZN1I8PaFSVm/Z18ybB6cFIg3eVATkYLGZABOMblEh3EwWJFb+nDaFhLUHTdG1/p6IZBH30gbal7O+VTHLf1tvSIlGm50s/BYLqLDgh/8qG+kzexw9/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+Tc9+1YIxWX9qFepHQAITxeeRxTqqPAYej/GQQcHVQ=;
 b=eU/T9wIRpfKoiH8AX1H5mnncnkFqfN5uFtH+PHae4+eo46pgFvlHfgyUsKJKrS4L09ozt9LFoPOSF8KRnsD8pOSjdhTCDD13352v0KA4h1o69pit9St/bxLzhOcmZqVU4yKQmZoe9HpAHrchdhu5TyjXu+wJa95vPtnit3ZJmjs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:42:39 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:42:39 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 2/5] mm: add private field of first tail to struct page and struct folio
Date:   Thu, 22 Sep 2022 10:42:04 -0500
Message-Id: <20220922154207.1575343-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:610:b2::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b79e0d5-13b7-48b0-c566-08da9cb11447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4E5Y+WoD4ihQL+pyFDG3mKuTDzW4SZFF+kk3Z28SyaFxkdDEXXm9U8wtK9Hn4k5bAL8j2EOU42jz60dN3drep6AZE7l7BI1ouKEYcIjZedEW/i5OleMrt4PH/vge/ARmT1EVqr+IJNUHMg5Q214KDcaPWBy35rJHGNXdQeQn/R6RH7kkpZeBp0BasVqM8bnO3yuwamq2FQpHxRhjdwb+INKzugWai3P33cZ+XFQMM5w27PZVS5G6SIjhzpSq8R4E0l9OUzNP1iW+uCoQhGZYYpPqbHGHdwUhsVf0wHBC9vvEAtNu+VxJUDm+zTufwMUhbPoWeCAprdDk7D9JU7nMbdyw5tEwPO0IadH1eU0jt2zMGC1x+my87zgfear/UpiXPqnnKAb7llgs+eTe6g3kg3bDIviTczsjoVTFZfb1+2woneDNIxpArOgGSRFzgs5ga5qQ8383nUsIvFEMDWEdZreeGWDi4p+hWz3YMS4L5qxZX5hwL14SuhLhjysHxNRud9IOFcASfDx81TAyc44SaWnDHSp00ysAxZ0tBw/JweJQn422VNOq1g39BeLDs0tEpfA1d26EC1B2cP4v+YZ0DEEe+Vvqbc08PT60khoDl7nJFI9leumz/twH2wRoX1vJdMP+cK3TWXbgvm8QkeScxjyZitCjojwQsju1+rMfHDs4ufBnH1VGK9mUwNKys1EC9QLb0jG/KQtZsc++saZUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(2616005)(1076003)(6486002)(83380400001)(6666004)(44832011)(7416002)(41300700001)(26005)(6512007)(5660300002)(2906002)(107886003)(86362001)(316002)(36756003)(6506007)(4326008)(186003)(478600001)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRa0e6R6FbhmguXiWMPlypS5lNePLpL4KTlbSs5gnpcSz529CSr+3JJbflHn?=
 =?us-ascii?Q?AQ+0VrE6K4LYlHhKNuWfDuMbgNcPVqLmmar+89gvF3a6qrBhaJZt2KAMaRVz?=
 =?us-ascii?Q?MgR9FWkyYeEOAVkl2c4KBWKKadOgE0V+A4cVLadB0FfQ6uN/nAwJWDGD6vET?=
 =?us-ascii?Q?za0jWxZjSu7xL0DWn6v1kt1cstKFYhk8j1OE73SWWlXVvn/uRph4ecnZjk01?=
 =?us-ascii?Q?SkmkCEwdLrI8f+sDLZydCvWE7hThWlsko+rQynxZb3iGU1R5rtZVVGmCOufN?=
 =?us-ascii?Q?C3GlVRwr5z33POPPASVvSMcIKB2r0TGamCXALC9QvT/6O/P9UH5RzGhN/jKi?=
 =?us-ascii?Q?tnv7UwCg0rVtFk7b91soKROchdUwcP+h4f07CzlnMMpEARX72PnVgrCnW9C5?=
 =?us-ascii?Q?iutUzxlWq4lpUG5FrQW6FNmM7wcgj7gmrPTYkZq9TJ/RbW+9LSXVvEKPPEcl?=
 =?us-ascii?Q?NoFIqZNmfAxb6bVCn5MYStrS3YsgrIOyrc0QjvSYwSiOSNEyiw0wXG8Ob3zI?=
 =?us-ascii?Q?1CIinAgrWIX0aLkwHWfaBO8L07BMqi9xaueaRvGuYNBIy9ylyX+i3xxkIeXm?=
 =?us-ascii?Q?tqM2eHiP5LK7Pn6wNuUN5nxAneCKDf+rDr3zKAjCwMtPph6+SeNBh5XvTZDt?=
 =?us-ascii?Q?OX9wn57oowtBoqRcRri5QsLCSSKhhRv6Mj27750yoQR4iwF6xFqIZtMuldMU?=
 =?us-ascii?Q?ZqlSb31Wv5LmBvnzxzmWZ1Xa2TpI89X62gyUsCK7LQYcwfK9mFrWDVq4BwB+?=
 =?us-ascii?Q?WZkBr0efwglRP1xjfIF0sbN/D17UKYvElHW4P3v6z/b/h6/HaqBhDjBNs7j+?=
 =?us-ascii?Q?cfIyJc5w33hZgQ3rUcinQO6Nnr1cCD4ec9pW/TCJrg1s/KiKNmOfDj9ppVHC?=
 =?us-ascii?Q?jquwhVjSxG+uJPcaIxDZ94S8YKtbvdrX4cNglVkVUg2Aiintg22BIVh923C1?=
 =?us-ascii?Q?fRwo8Y1mP6f31NoxEFdjFpS1Y8R6uScqL7nDwtPyaS8jEclkP+9RO4K/JR4l?=
 =?us-ascii?Q?rQ9RQlczNR3W2zV+0EYJMftkmyjQvI+06hblgdEna+BI6dIPVUgUav2wzSFh?=
 =?us-ascii?Q?ArPQmbjr5ExgrMs0R+FiPByNNiYDNLl4DX6tC1oV6jYxvftlzuhcef1hZpPP?=
 =?us-ascii?Q?7h2DTK3WIMmYkTg2RE7hZbSyA70xbzg4U/OBDJB8AeRaOqYO75U1oVJch66N?=
 =?us-ascii?Q?9aKaiDpamaqtVBO7k2T2edMFC3jxCx2KNgge93044Q3WQgR37+r0pZzWasiJ?=
 =?us-ascii?Q?4AK7gbH0W33WnGVo5m07GvyM8T1HXKOuaULBk4D9S9snl/cQsAqJ+6NleN8m?=
 =?us-ascii?Q?0zB7lXtlX6acCYAHdUNuyLMio+hwFkXhHSGJzNa/2/D17BWq91MhJMiau7dp?=
 =?us-ascii?Q?BUG/XXVXhZu78T2WEoWz/0ejIDr0GUuBZsi8xTwxcYbt1Wx+hjctHx0hG9s1?=
 =?us-ascii?Q?ZpDqRwL8/CfznmkecBpx0SK9Y5XIHWMX2uIVSpiOOyeDJqg7crjYW/Q3QSaH?=
 =?us-ascii?Q?9LYRpmjJc7jkdL4x3wy3br2p26on9t98LSzq6awPbl3JhNuZCW8uGHX+HcBN?=
 =?us-ascii?Q?4dQa2ibnqkLYYhYGv783luRDFRXG5bShUbvkVMHeZOOzh00MFKLYLO06Dr8w?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b79e0d5-13b7-48b0-c566-08da9cb11447
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:39.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUz/7peLAALRSOnct9uXPoQK98eInuSOWGFaQ5hJGf6hJ1E1MWUrOSYbWzAQed2Qce1cVoSEypgBdihCTfe/a7AuqBCefw0/2uNIhdA1Ntw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220104
X-Proofpoint-ORIG-GUID: kQQ612thRKfYbH5ZCsrLnULgrApfj9iz
X-Proofpoint-GUID: kQQ612thRKfYbH5ZCsrLnULgrApfj9iz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows struct folio to store hugetlb metadata that is contained in the
private field of the first tail page. On 32-bit, _private_1 aligns with
page[1].private.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/mm_types.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..2d5b1575ffe0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -144,6 +144,7 @@ struct page {
 			atomic_t compound_pincount;
 #ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
+			unsigned long _private_1;
 #endif
 		};
 		struct {	/* Second tail page of compound page */
@@ -264,6 +265,7 @@ struct page {
  * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_private_1: Do not use directly, call folio_get_private_1().
  *
  * A folio is a physically, virtually and logically contiguous set
  * of bytes.  It is a power-of-two in size, and it is aligned to that
@@ -311,6 +313,7 @@ struct folio {
 #ifdef CONFIG_64BIT
 	unsigned int _folio_nr_pages;
 #endif
+	unsigned long _private_1;
 };
 
 #define FOLIO_MATCH(pg, fl)						\
@@ -338,6 +341,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
 FOLIO_MATCH(compound_pincount, _pincount);
 #ifdef CONFIG_64BIT
 FOLIO_MATCH(compound_nr, _folio_nr_pages);
+FOLIO_MATCH(_private_1, _private_1);
 #endif
 #undef FOLIO_MATCH
 
@@ -383,6 +387,16 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
+static inline void folio_set_private_1(struct folio *folio, unsigned long private)
+{
+	folio->_private_1 = private;
+}
+
+static inline unsigned long folio_get_private_1(struct folio *folio)
+{
+	return folio->_private_1;
+}
+
 struct page_frag_cache {
 	void * va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-- 
2.31.1

