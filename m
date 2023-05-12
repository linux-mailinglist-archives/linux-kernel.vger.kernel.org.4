Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49953700EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjELSXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjELSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:23:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B7D106F9
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:22:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4aDl021732;
        Fri, 12 May 2023 18:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7MLcv1G8LkaXK+scWyvzIEbLLyWLzRFzfze5eok9DRY=;
 b=1THEmRfM7CBUTlInFna2M+mcQY3YW+rIwS0iMwQ0FEAM9SE8oYd1qixzTrOCWjI5iUet
 ot1EJKgvvQVYY0idq/mgyTHAHtsCRS1BuaRdYL/M3NvZPgJS4yYfY62W6xX93jZrHfeq
 andIucI6YYYYQnlSQMU+aw8Q5RqR2ZiFmhpMVOEMCfHzu94OLB4Rl/ioUvSYnxJgLuZ5
 WLRrN6DB6/99kbVvJfPI+TPvx7y1SefdCbl89nJdywLSxvg+i/PeZpplm7ImEyt84CCF
 DwL9ox/3JVhboaeapQNk33tW7sa+v2+MXfvt1c7X60FSYTVNRf9ZVB8nBqcFyaH6BRSl Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7793h35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGoFFF024387;
        Fri, 12 May 2023 18:21:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y8gtqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdIS/0Hg6oQNMlW1ZVOrgjAcitDQXoHDX0v3i7wzEPrBC+dmVdQbrdBO6SLBW2Am2OoFVixke/DpnGfGLQ2/+mlyAtJjUPSsMGCgOxe+u8LydGihxLLZYM/1iFUci1ChlCMhCVs38owCCI3lTJX+c/mYG23pJtYSwu8LT2HKAu88mDZOtwoBADmNGB6a59sZp/ln+TkJND+knWqHrpudU1xuykBjU5O8cAfW6gjP70sLMPOVkUhjRJywJvRISVYz/gPBQN7mBU+xOdYT2MbhV4xYo77lUwPLAMhD3lXR6DSgzVX3K8HKocSzNBCxMVBomZx0gl8d7CgrfiQCh+H+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MLcv1G8LkaXK+scWyvzIEbLLyWLzRFzfze5eok9DRY=;
 b=NkvoZ6uWOj0LjfaN9V1lI3UTvBgKuaSMSF9dpvBiW3joCTZya+fT6x6mLk7aalYP/bPHPf6ZPJyGsaAJs8fx57oJyqwtLjnfEH087a4XWTeWsxHS/CVVSXl+vVacOtdEvVmvRzP+/U7TgdXtgM/pFClxlIYW6hwHNX+8KKAEYFwZpZrBneqwobgvG8VwG+KdNf4txQ/rzD8evE+3PXhO6mtbVHmexb9r0MiK8LR0IWIdzh5XxdzOdGHTJxr5nw5pOp9QPBw3s2Ju0qV1v9WoYW3oyFS98mR7mzj+ZyKbX5aVW4vT9IP1nKaZdqbdzL+QT7OxfYtNmzhT8UmjRBqWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MLcv1G8LkaXK+scWyvzIEbLLyWLzRFzfze5eok9DRY=;
 b=syraMOC8SBqWtewJx2C5QHqdQebPUxEjXKv9EyVCdLkO7GcGBmabAP885o8mwahsKKOgYjFiirkKZ1f4ICf/9y7/+F4T36idjTYFYsXoNWFy8SEDlW3hMJwLYRa4uxIOiF626Su8UMFMJihYoun7/22++tTqs8Tk8H/KDjwN6FE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:35 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 17/35] mm: Update validate_mm() to use vma iterator
Date:   Fri, 12 May 2023 14:20:18 -0400
Message-Id: <20230512182036.359030-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: c192b094-e227-474f-22bb-08db5315b7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU/azvj2KXt72Bl1TAWYcV0VDl/KSLeKDGy9+xannr2ckydWqbUhx2cegTlDd4kmyTU7UwqmJR6mgdSIjCv8Do9UMfcx6kAGr7LjiOCGN1itxexZhNq/+QZ8XFPTyBm+K2nZDfO+mvnfGA/FhQYuJN2kD9PstJy82eraIwhYxbkyUAsFoYDEL+4PNSzAo7zGGj7HYMe7juK7kPoAW2m9Jr3BwlDXRillIGuvCW677JQ6FsOtc2HyTCSIglhovWW+Zhj22U2YVJ3za4GOd5rHangiso4h5ZYrQ1FQ0GojG1B29AZw4Xvk/lVA3JwTsYKGKis1ky7+TO7ba/iuFTKb4z1OnxMab+FjNQlN5s6eKptyN/Lrh0A+maCJs/FC9+Mvj61NV6Qc+shh4zq+oV1TnSUeHlHUVINkw3BTM62zL4mSiBpOinS8HLJtQZrism46J493nhi3NXpivUCnrCTApMIfQrOKT1Ba9CScVenBsSElpbVcQ3sLph1BPrJVTr7HK+TtNTxYcnckLtCNAUYEHw8f1QD1K6hpzK8e6k/abSLyj1spnaHfSZSLQw9EuaRm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(2906002)(15650500001)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1anzwDG4d6Hba2ECpgag0LTinKuCVJtwDCsHqlS9WI1lEY4JJb3J/IE1KIdd?=
 =?us-ascii?Q?r+IsptJZidEuUGeIYpdJNUoNkeEslXSynlkr1EiU5I0b6YlKQw1RjegXoSNI?=
 =?us-ascii?Q?tuio41iZarVDgR+SJEhfE1E4dWQHzuOVSKRwOuiVk9xTr1fHaiP+jgokBkXi?=
 =?us-ascii?Q?BVtkDrC3cOuhoeOzmYrCoDQ30jO4hEusc/EEi8B4mkanttUlJjB+iS9wU/U1?=
 =?us-ascii?Q?2qy7D/fy4fVylIbopGdQ3MFbnvw2n3XVkJneuT7QQuKTrLSYyg3++rDFe3vP?=
 =?us-ascii?Q?p6ddkqHwUAUh7o8YSGncd1O96KNdupEXHuyV6KDc/uchbM0NQmb4A9hMjBB3?=
 =?us-ascii?Q?Zce6jlP1G9+drAcWcFD7vigWo/mEHwBlhq9yH66xTjhbqrurNK2OOfcY9zQZ?=
 =?us-ascii?Q?e5d5h1WI91w+L6T3twZugwkBjyVDGHkl2nX9TCpz3qmxhVeFh8lLvglMFAUy?=
 =?us-ascii?Q?GRCEwLGpkGTZLChgMnIlzRKyIsJNsZUxlE4Wo4PzYFaXyX8oklz3p7y0ZMAA?=
 =?us-ascii?Q?7URyjyjlwwz8QQ7t5XfowZoWci90cdPRqrcFo4TInzZmhH565c/eGWtZ1gwR?=
 =?us-ascii?Q?k3mt7Lwnwjdgge2aYDfxqMmtEW4vq0FzKLiOWLbZZgvLVJg6x3n+KzZW798T?=
 =?us-ascii?Q?6p1oN8aK5auxMW5FsxpICziRNPgjSy9O+6VQKO+tFcketABOJJB/E33g3Nnh?=
 =?us-ascii?Q?8xxjN+Jt7mG5jOaNvRJVJzsrWHfIcZtEo7fcLlC5C5Anr9kd48wI6IkY+bgZ?=
 =?us-ascii?Q?ukae9RklUnHXknC9wbBJ+zSNa52Rc5kp8VeMEsCumgMQPaONEdcYechYU4fD?=
 =?us-ascii?Q?VdQLNhI0H5Adv/zHX5uligIKvN+7XvOgzRy3Up/eIyddbbhd7dLCjjQ7ZiJU?=
 =?us-ascii?Q?d/b4VL/FwDDUrF8u26FCRLmE+yuiXHTCRJGdb9lYS/Cs9YbZ9DsJb8lDsceL?=
 =?us-ascii?Q?8EiyHD8QywdtiKo/Sqxc3AbK4exzeccKmkPsdqckedlymMe1CH5eFEqesuG9?=
 =?us-ascii?Q?/sAs3St8ae/73dToJrJaFXdqROv7uteHcCKbUUSMXfdvOLtpk2stHzIxZKzT?=
 =?us-ascii?Q?oKvQDpzEy7d4Prl0Qt9mraXiOh6BZiC0riVe7qbRQImL69nfR+7J8NMFztgP?=
 =?us-ascii?Q?0OuipC//dad5dC6ke8GnrpUf84tiduKlyOMNxTjQADe/6lCKRm1eFJ8bJMUE?=
 =?us-ascii?Q?2FA9laG/XoxufOs4cP6Hq9wrqHSX1R9eyfYe5P+KG/vjpOO3yexY+TKvEl9D?=
 =?us-ascii?Q?K4GySoDd6qUhpxHYvikKoGB9kl8VY5BisjDHF5BA1MEEwCu2kH/azGheF+aN?=
 =?us-ascii?Q?Q5/rJRzEt2Mgyfa3MWe5MWqF0+8Ki46lRshtJozXnG9wY0cRWkBL1Z4pNUtJ?=
 =?us-ascii?Q?bH28uL8gcNDqnArer4TMBOErN5qgaR2ssDndftuIp6xfRf+Koh3575jxmvZx?=
 =?us-ascii?Q?VAQJSykHYjQflG0Udfc6271g6NxyzYyE3hRCJyRNwaWiFMJgAm3CYjm0sI70?=
 =?us-ascii?Q?RzVz3VLkU6kO7FZTQERmtT4HvrdZ2GmA3IoQxy9GVfWdNgj1/B17abbCWTje?=
 =?us-ascii?Q?D6oFO8nNttdvtIUVh+JHEYN1NLPXt+xa1BxPOAyclgWUZ+L6xqMIU1ONStDT?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TVip/8nMJIQHuH6WbSbZOIJipwGB9ScNMm4ye3t6n/d2DK1gGNBL1Trs49E3/pUSVq3/VwxkCqlVALgTKs0CqFDwuS36XLL9b8GLjPT7m9Y8koJILvSC4QWLsg5UUyEPI8mvPbsIDR5WD28c+JgoeIkOsrCVY4CCBcn3NOrXAYhsKV7KOaIlFFend8sbyr0YNAz/uSLA567yjVCzQPko5vh6svbMUIqBlyoVhyI7m31WY3j80JAcsFdNPjsyYhq9NHe7vnKUNHBjar7HBXDwuC9sbvcqeivvLQyqdg3QqFwbpvUSZ0kdvtJdu+Ecz1dVy4uIaTc3Z3oN775Qbdj1TfR4gSkpCq6FhgobWu4tpU9+zmAvFUTWdiBuuqoQLrDVWQhP7a2NsMdoL+BRVv6QT/GjMtXaGbnXNfHRD9ybpde9GvxUA06g7atYouJcyf483JXN7low7/UQbmW6RzkR4pdgN4m76Ff37DabCRQYsO7SuiW+e7mEPQjz/DEKc7cC5WpE7D+on2kGIOewEs8CJzUqtZCnI6azf4z8yxjNcG+gACbiBP8/ryZwXa4dB8y0h6jN6MXig7YpblWJh108SrIBixyPKIVAj7ykSjVIkorggCFl3fZjrvJYsHTj32Y7g1SttjrDn3jxKJw2pe841fDYFLfOKmyOW7vWgMaCC0HyRt86OQwc3DsTA5TvIFlmgk16S93xNDkIRl0vjav2K+/ZIIET3gNlFqfIMjprGhBtB5QYtyZZAm6P50HTHZBckr+mCNWORlRON385Qo/AgV/3rJfB4v8W5xSLhMg5KpjpiF3vur1j0xeWMYz5706wrAlRjFUXmMLxYHvX3Z6TmBzuHQVH0F79Zgw82n9vocYaebqc79G9wuYEMRsfTX4keQXFOVqW208OZT/BhHn+KA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c192b094-e227-474f-22bb-08db5315b7f2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:35.0028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEOqID7zyKoqQPwqRS/tlgv1POy0ZEJNHpqODxwUOC+DYHBMClZimVAuGTnHCIwJ6S844qmFYe/uGQHLn/6MRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: THtmXAa2XHHW88ypvVy__sB0Xa0xRRxc
X-Proofpoint-ORIG-GUID: THtmXAa2XHHW88ypvVy__sB0Xa0xRRxc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma iterator in the validation code and combine the code to
check the maple tree into the main validate_mm() function.

Introduce a new function vma_iter_dump_tree() to dump the maple tree in
hex layout.

Replace all calls to validate_mm_mt() with validate_mm().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mmdebug.h |  14 ++++++
 mm/debug.c              |   9 ++++
 mm/internal.h           |   3 +-
 mm/mmap.c               | 101 ++++++++++++++++------------------------
 4 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index b8728d11c9490..7c3e7b0b0e8fd 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -8,10 +8,12 @@
 struct page;
 struct vm_area_struct;
 struct mm_struct;
+struct vma_iterator;
 
 void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
+void vma_iter_dump_tree(const struct vma_iterator *vmi);
 
 #ifdef CONFIG_DEBUG_VM
 #define VM_BUG_ON(cond) BUG_ON(cond)
@@ -74,6 +76,17 @@ void dump_mm(const struct mm_struct *mm);
 	}								\
 	unlikely(__ret_warn_once);					\
 })
+#define VM_WARN_ON_ONCE_MM(cond, mm)		({			\
+	static bool __section(".data.once") __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_once && !__warned)) {			\
+		dump_mm(mm);						\
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
 
 #define VM_WARN_ON(cond) (void)WARN_ON(cond)
 #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
@@ -90,6 +103,7 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_ONCE_MM(cond, mm)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
diff --git a/mm/debug.c b/mm/debug.c
index c7b228097bd98..ee533a5ceb79d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -268,4 +268,13 @@ void page_init_poison(struct page *page, size_t size)
 	if (page_init_poisoning)
 		memset(page, PAGE_POISON_PATTERN, size);
 }
+
+void vma_iter_dump_tree(const struct vma_iterator *vmi)
+{
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mas_dump(&vmi->mas);
+	mt_dump(vmi->mas.tree, mt_dump_hex);
+#endif	/* CONFIG_DEBUG_VM_MAPLE_TREE */
+}
+
 #endif		/* CONFIG_DEBUG_VM */
diff --git a/mm/internal.h b/mm/internal.h
index 4c195920f5656..8d1a8bd001247 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,14 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
 		mt_dump(vmi->mas.tree, mt_dump_hex);
+		vma_iter_dump_tree(vmi);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 76eaf12f13903..bcebfd9266324 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -299,62 +299,44 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
-
-/* Validate the maple tree */
-static void validate_mm_mt(struct mm_struct *mm)
-{
-	struct maple_tree *mt = &mm->mm_mt;
-	struct vm_area_struct *vma_mt;
-
-	MA_STATE(mas, mt, 0, 0);
-
-	mt_validate(&mm->mm_mt);
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if ((vma_mt->vm_start != mas.index) ||
-		    (vma_mt->vm_end - 1 != mas.last)) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-			dump_vma(vma_mt);
-			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
-				 mas.index, mas.last);
-			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
-				 vma_mt->vm_start, vma_mt->vm_end);
-
-			mt_dump(mas.tree, mt_dump_hex);
-			if (vma_mt->vm_end != mas.last + 1) {
-				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
-						mm, vma_mt->vm_start, vma_mt->vm_end,
-						mas.index, mas.last);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
-			if (vma_mt->vm_start != mas.index) {
-				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
-						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree, mt_dump_hex);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
-		}
-	}
-}
-
+#if defined(CONFIG_DEBUG_VM)
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 
-	validate_mm_mt(mm);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	mt_validate(&mm->mm_mt);
+#endif
 
-	mas_for_each(&mas, vma, ULONG_MAX) {
+	for_each_vma(vmi, vma) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma = vma->anon_vma;
 		struct anon_vma_chain *avc;
+#endif
+		unsigned long vmi_start, vmi_end;
+		bool warn = 0;
+
+		vmi_start = vma_iter_addr(&vmi);
+		vmi_end = vma_iter_end(&vmi);
+		if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
+			warn = 1;
+
+		if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))
+			warn = 1;
+
+		if (warn) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+			dump_vma(vma);
+			pr_emerg("tree range: %px start %lx end %lx\n", vma,
+				 vmi_start, vmi_end - 1);
+			vma_iter_dump_tree(&vmi);
+		}
 
+#ifdef CONFIG_DEBUG_VM_RB
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
@@ -365,16 +347,15 @@ static void validate_mm(struct mm_struct *mm)
 		i++;
 	}
 	if (i != mm->map_count) {
-		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
+		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
 		bug = 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
 }
 
-#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
-#define validate_mm_mt(root) do { } while (0)
+#else /* !CONFIG_DEBUG_VM */
 #define validate_mm(mm) do { } while (0)
-#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
+#endif /* CONFIG_DEBUG_VM */
 
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -2261,7 +2242,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct vm_area_struct *new;
 	int err;
 
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	WARN_ON(vma->vm_start >= addr);
 	WARN_ON(vma->vm_end <= addr);
@@ -2319,7 +2300,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 out_free_mpol:
@@ -2328,7 +2309,7 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_free(vmi);
 out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return err;
 }
 
@@ -2963,7 +2944,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	arch_unmap(mm, start, end);
 	ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ret;
 }
 
@@ -2985,7 +2966,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct mm_struct *mm = current->mm;
 	struct vma_prepare vp;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3226,7 +3207,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3285,7 +3266,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			goto out_vma_link;
 		*need_rmap_locks = false;
 	}
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return new_vma;
 
 out_vma_link:
@@ -3301,7 +3282,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return NULL;
 }
 
@@ -3438,7 +3419,7 @@ static struct vm_area_struct *__install_special_mapping(
 	int ret;
 	struct vm_area_struct *vma;
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	vma = vm_area_alloc(mm);
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3461,12 +3442,12 @@ static struct vm_area_struct *__install_special_mapping(
 
 	perf_event_mmap(vma);
 
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return vma;
 
 out:
 	vm_area_free(vma);
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ERR_PTR(ret);
 }
 
-- 
2.39.2

