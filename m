Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8660216F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJRCu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJRCuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:50:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B1491F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:50:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYIOZ029589;
        Tue, 18 Oct 2022 02:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hRR+n3Xxk3o0TGS8WrhQWj7qXSfSxNi2jZA2579B/Qs=;
 b=pcaGjr+zKSGpumGwHYNlIR6pm556ibrZ13iY1Qd7ReHPbDnnns604Ygf/QTn6KjxAyEC
 jktT/UMoj6e54vWm2mNKTkdUnimTDv+pSt/iNVnqoSr53vfTJ3lVT/8xp3tmhG181lRl
 LG4ZExYU8oTLUYVftquZiO41RI7P9sVc7GHIFQm8hf89sW2t/xoNxK47UuuJeTfU3zJt
 FbMMINInJgl/OfxvLyKDzUxAjCLjhKTDxSpMw3rexjjbJ6sGrHLlDaIPzwmgXvSNO9aJ
 TV1BJpyevIcpXkmY5O7CNtJCpDOMGmx7QVwAxvDdSSsPAPQJYEPvWcXbThv7Vd/eQ3i2 EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mtyweyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:49:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HMSvbV019165;
        Tue, 18 Oct 2022 02:49:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0pvqbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYZPiEfRMnbUS1GWggaHDXXYV28MD61/VrhatYKF7rd96jEbFyUi3RVOBudj89ds97LhW2ai2z+X3Qn0THh1nkWV2GAByVsja+x7VaCEa2Md0QHHZYMUVcJ98Mttx/a5vMxrYn7UvqRSO96IkhpZ1IbHZTRJ2RU96rgjGpKkCcI3tboXsI8XgOQ0c9T9P1T6oPGnnKnFrXu73+Pu6+uucz6jUE6gJXxOMCLUIKWjqP50OjvpyQGvzqOhP0TrXUumrMd2zxktyupe8Obec+jhU3Gfq4j1FNeH496THNxmKjJPQxiLF6YNIUM10D03ibMKW7Xar8YSLnYQXsN7mvNnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRR+n3Xxk3o0TGS8WrhQWj7qXSfSxNi2jZA2579B/Qs=;
 b=jbm+DGdMUomPoZx70azV6BOGsUMr/C8lKHoDCJOAoRtScqb7wUnsWOwaEdw68+9G4qPyHDQIIzG27J81S3Dj/rg57lB2h8aZ0P4fDrtwKIU8hB6LMJjk7beZqcTrPDlaLyE58EgM3FwLSP2depGYcEnUokdkEeDCcS+X97ozoreIEuFxesSvATSesryQOCDUodiS02o1tETiCf4rgsj/L4n616UWg9cB4xOdH/1CFXUrL1lsaiIAHZHIw/1rGE9amBcVddtBPwEa6GZyUoL6a1tkleLEw82+ETTqyV254uf4FdU1hnH7Uw+dWrcIxprmZEoZkC/2YWUwXTCAvg9kVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRR+n3Xxk3o0TGS8WrhQWj7qXSfSxNi2jZA2579B/Qs=;
 b=Kp6ln17KAr99y5yXrJQgXbD3GDCibGF6xjcfkd5Suxb4JTZrIH+7XeAv6UEt+D8MkAnT/Xoje/DPIdY5WcO60O+7EQJu5cBpnTBUPZeNwnTKMb3G7rA6eIB8U/+CcU9+u9a3PVlcxdK/VvtxRAkPmC/afY8e8MWKxDdUSKOkIYs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5220.namprd10.prod.outlook.com (2603:10b6:208:324::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 02:49:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:49:53 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Carlos Llamas <cmllamas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/mmap: undo ->mmap() when mas_preallocate() fails
Date:   Mon, 17 Oct 2022 19:49:45 -0700
Message-Id: <20221018024945.415036-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: d316a836-b8fe-452a-b067-08dab0b36e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9Nyv3SMw/c2j5MyE/ZN3Z3hK/mgbn1STOp7vUaYVLiMOqIYRXzPxZWl2aPer0SztYQ9JCRsjWpm0GwzjX7cPJ4MkqqR61McDUlmIfqV0nJRwEbRGs278RllIRy7e0lSz8J6wUmiOMJ9Ey3bkZaLz0B3HWvSQNRJfIXzNWxSItZAOjoO+Ka+8fSZctuZY1TeDhSyDy5ixz44HaIAqeGQAIanK7lrswORLO2tAJhicorXhliAHYq5skIlhMATSvnONKKRdgT6L1ZVitxZCbMeF9lsjYZRMqvV1JQfMZcmWpm9YqNMHIDaBcieuHBBOk/r/ymONR/HuR/yGXjtOaY/utexVjDcRCnyAdtn1aVkuBZUrvLnb36qo18nmMx6v/OT0cu1gd6OgXWliFWdoJbcEF824ykhSdt8ADYN0pB+CfA+w6DDVOY7Fxqyz6NLjChgHD6XdRNqLSU2Tw2YsQgrO7KO/tdF1Yl6KPxgV6vglGGwubzpui1Qkyn/8sq2pjuXtfZKC8lxxN0rTi8fh9eoGerOgrgP/aFEBGw9CI4lwlpsjfiwRytS/coy+2EZwjOsbTFucUtiFl4Pic1C21zg6P0UYVuyZ1mmxidhESmFCT7nfDQeJbW4kgQdFYmcL9r6gfuvyopvon4dhevTHYfsnyhN1053SKWRbrgJx5GwjKA6rioLjzKC4YevZLg84wKtk4aM58TbmlDe6Ter9KPy1QmeS2Ix550TICvbrhGNG3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(5660300002)(83380400001)(36756003)(44832011)(966005)(6486002)(6506007)(66946007)(66556008)(66476007)(8676002)(4326008)(6666004)(107886003)(8936002)(41300700001)(86362001)(478600001)(6512007)(26005)(54906003)(2616005)(38100700002)(1076003)(316002)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRjIsfO7YpPmeO3ineMTWukAnI08AOfDYD6p3VB5AEjO2IOaAFH090Z8Xlbj?=
 =?us-ascii?Q?Onh87AmpIsJlnzWp+xiw5EPISlcOp97pWL3bl3wTszSsZnc01Q/cdg4EAUAf?=
 =?us-ascii?Q?PaD24yvvcToz+XWqcolSNmMuUNVnObveGuxAz0RkZHBMTwlCH2MHBF1kqguE?=
 =?us-ascii?Q?njwFABJYRhqInKJGwGp6rR75meHgWMpgMdbJue+o6uL9cawZUGYEfBvkzgMM?=
 =?us-ascii?Q?NI/ubq5Qpr16iz8t5f6Dn1V+aFRyxqPbetDyRSzHmDIfC0NTE5Z6peNmZTdc?=
 =?us-ascii?Q?OVjs53S3tnsBolQrfIwXGu6Qfrn3OMc3rqAmg+G9Uxd1Y849jyfyuHP4Bqvy?=
 =?us-ascii?Q?H1FYjJHlyGyiCQtaAxfEbFF9ds2FOoVJ08BYsmeqRapdj28qvBiuQ+M9BSKL?=
 =?us-ascii?Q?1kQf36XI8WsgiVhIrem3kphYJ721WuZGuy8gauikFDHcpDlHKW2B9DYBTp0b?=
 =?us-ascii?Q?A3oKzHN1T2CpntVnV3AeNM16P+X8yuK/5uqOCymv54HSvKD5BFfQ44xBUJr2?=
 =?us-ascii?Q?ymy55si28L9zr08QcuuZ4hE8caGW05VdYWIOuOY7FSzTTeBKOea8uz66SSmz?=
 =?us-ascii?Q?CRppLQnJMq8PX5qsj5DtFblbnp08aYXQuUJGDbAD8Vg1jknVqaRJVKbf6l1k?=
 =?us-ascii?Q?gMgOd9Ri8XQa28oxRQ7xiHLzET6A/bMxgWoEW7BvR0ijDwZiUvQZoEzyfx5R?=
 =?us-ascii?Q?ggFo/c6ZLwnRWeveE+cD6X6bsjZAMKpgCETsCEm0FAI1kbF3oYef6IjUTlB/?=
 =?us-ascii?Q?B+JHjEjUQor5UIZez2r3rw2jJ3z1SV/ajFpBsc8g8m09QpZQR9m7trotZtHu?=
 =?us-ascii?Q?HhkS+2tU61iWfJVZvfsuuNeDaVkeMl4OQwnVRqh7GdgZpvb4/KOdYtiRUKKo?=
 =?us-ascii?Q?X1cND4vkaFzVZhO5XxyQkLsf/SClGVoNMJYpbWIKrjA6LFei7hrodhhbwwfK?=
 =?us-ascii?Q?IHFyZl71pw0LSaCW6UiTahFwkIsAzoeEWGCG8CC6BQQlmY9wU78le1qmD0e8?=
 =?us-ascii?Q?+LjLopBfycbeG26fwSHbWyD2ew/rlJ9GxJp9in24LnJ9u5vuiTQvwU3oqGgC?=
 =?us-ascii?Q?+1Z2WNyL6ZzbUcGypIan+Vphvtm5UEmcSeUoAgFeOc6NfSbb4PWjo+3OieHt?=
 =?us-ascii?Q?hw8Rr/m0YVEWtJwq5GFth4Ob7+14X5uS+WBOI5ypJsKlNfx/YoMBn6dLQ5+1?=
 =?us-ascii?Q?ywwoi90At2GHQDwXgbwKn+Fyqz/lSgiMnqepUe4+Kra5ttpR9u9xIEjCPtxm?=
 =?us-ascii?Q?Z6E2NCnCcrUHij2r5YkKn119jlM6Wfkwa/jnU87DhvQtvoXXJ2sLH2FlAVRo?=
 =?us-ascii?Q?x0/5PagaYg5Di8OK8J7OiwrdPsqhBBPEp5jB54k6kSIVP0xkkgwIopWNmAY3?=
 =?us-ascii?Q?5h/2ZHPo9jHER4CICGWdidhuVWLt+ZQDI/VNy6jbzLjOJa7dT13J8EPdKbap?=
 =?us-ascii?Q?xwbhQdHIL18lWf64e7v7gsNfOHuyUc9JfrV9IQJFMpWupHFnFVeYOZsO5XZa?=
 =?us-ascii?Q?yvRXYrLpucRixsNG0IXWiOMZ+7NdJQUCOkF5aT9S5Nj4o27kVmxmtIceQhiY?=
 =?us-ascii?Q?eI7AFWOpp5buVRaEkJZXBf2QXmZ+uAs8/YVJsDHzy0/s829VzAj4UtcDnB/n?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d316a836-b8fe-452a-b067-08dab0b36e98
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:49:52.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U41ccYeOv4tqWrWa1iFNZT+HkMQlSvDtveaWTUtH/RD40QehwVTFigBMXFaJDVxIwg2t5CozDLQIxv+Kyotspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180014
X-Proofpoint-ORIG-GUID: Sroy2ReNUAohFBiOabRXCBCKPw_O_te8
X-Proofpoint-GUID: Sroy2ReNUAohFBiOabRXCBCKPw_O_te8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory leak in hugetlb_reserve_pages was reported in [1].  The root
cause was traced to an error path in mmap_region when mas_preallocate()
fails.  In this case, the vma is freed after a successful call to
filesystem specific mmap.  The hugetlbfs mmap routine may allocate data
structures pointed to by m_private_data.  These need to be cleaned up
by the hugetlb vm_ops->close() routine.

The same issue was addressed by commit deb0f6562884 ("mm/mmap: undo
->mmap() when arch_validate_flags() fails") for the arch_validate_flags()
test.  Go to the same close_and_free_vma label if mas_preallocate() fails.

[1] https://lore.kernel.org/linux-mm/CAKXUXMxf7OiCwbxib7MwfR4M1b5+b3cNTU7n5NV9Zm4967=FPQ@mail.gmail.com/

Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bf2122af94e7..3c9890e443a3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2681,7 +2681,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error = -ENOMEM;
 		if (file)
-			goto unmap_and_free_vma;
+			goto close_and_free_vma;
 		else
 			goto free_vma;
 	}
-- 
2.37.3

