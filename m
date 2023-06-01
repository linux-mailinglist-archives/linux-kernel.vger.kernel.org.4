Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A329719074
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjFACRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjFACRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437111B0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKIEje032508;
        Thu, 1 Jun 2023 02:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=R0qsDcG9O4MhzZqrq1oD6FDIspNJvYaqrNhWXitLwfg=;
 b=PtnGSGLadaxpFYBfSJvFXng6oWFL07b6iI8i5p54eCcNuPE2uoPQehQBAE7pb7Ev0VLn
 z8pToT/iCUYlkoXhhVeoTFhsHGA95PhNA4yWaLxdKPiYJm7e4chjQQvDyTvWuEMmtRn7
 NT3EM2qW5/BBrrTNoX786DLmjcWklEHYdGLrI+8r906i/m9vUbiUTyFLBco29ckiQ3/E
 gV3RYZ/Aa7pdEPHt0g1HE4z6TG0/y4W573RdZpVitOzaeTPZYagY/uJhuCSKl56nLP+x
 ra6oKtU6dZooiQEBSzaB94F2vpXDvn7SDnSfEoz9v4oCdE+bZOUS8rTL/GSqtdEY9FH7 eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97hvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3511YC8d014618;
        Thu, 1 Jun 2023 02:16:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6grag-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR1mxZ86x3+fIhLgQWSXcwcQyL9Lxj5Vi3xMkcb29dh+XCN7OJl7zrh+l7fw6tqx0qtk6Z8vm+k/01CBoWbEtRAniPEmOn7oGZcigKX0T2oX0GyNldnIwa24Syt4nS39Xn5vDAffLL3ZUSqbppTvyovIItbrWAB4u8xD/VkE/o/0wVqwJbmriwj/bXxKQdQNr3EmEH/d2TsogPIrwFZfZGDnTv1UoAcNaLHU7u94wJyBaUmxqkgaP4SvsNz9CAyofZ6z5tOmmZ+6HPV0EysxNY5uY+hmZWsLm/TJ8EWAQlcCGwZ0Nvd84WZXr725OLYon5f1MrhApGQxmH7kJS+uBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0qsDcG9O4MhzZqrq1oD6FDIspNJvYaqrNhWXitLwfg=;
 b=KQ6o8SvETHAfgm4guphXzHWBzeD2lH82xrKP7zV8Q8XtcwaTBZw05WR+aFKWli+z2Hu/yAFHQueP6/qqa8+vBJDCVg0JA0o6Yw9N+XFf0Z11gusheqgx17STnTQ0KNIkMz3PSVGhUPjQS3BVYCdY9eY0PKMhUR44GVlN+KnFusjEE8B4pLTRNRchDDlAJzRMyYLLkKLgqv18HTne+FKGqq24/TmI6yyljarv3f3ZA6/RhLJtl0a7uv6zTOAvy2SQ0x/AXA1XkbCSL4dy4kccimd/staETs2la+WWZ6R67ROMKvfjCKw74FpzPiAdn3nEHk2N+YFYzgTjHlw43R8PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0qsDcG9O4MhzZqrq1oD6FDIspNJvYaqrNhWXitLwfg=;
 b=j8pAexRwxJZY8hsZ3dlCUzdR3YwM8BQd/4gW5kGOODCXkce/+41utsWGi4Zpyu2lFstTOk6pb+uzDkgw9XNc64+Dx2uWAb9NO8e1a5mPNNaTlI5f9heO+fjX8RNQflaEzPFiR3AakFZ18w4hnQZNVYqleCYjyWt9oQerLivhAaQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 10/14] mm: Set up vma iterator for vma_iter_prealloc() calls
Date:   Wed, 31 May 2023 22:16:01 -0400
Message-Id: <20230601021605.2823123-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b391d5f-d585-4d38-dfc5-08db62463d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2qW/AjIZi4Swm1ZMUfcEC5/rhpFh7jUwlR5fk9PBbocj52wAdtf6LFCkouQ87VwyxID/cz0S4F1GVXPado+zysYfcpcTMfriPgnz5O0eB60kvgnDQ/+wXTtsrJm+x7oNWLJnk9Zt2VxF7NReeb/OY751/LNrQL2SO0o6CjlTevXjRKnI9UBRl1ObnY/YE8NFnnjmSTjHeA9NlYM4I8sRy41lKlrP6m856aGmcr3T80VF97DE7/tTQSm2OuNDz0xORSvCHt17wrd6r7DHvPHxB9DCkRFgTwwlXiRT/yc1io8YZhskUpimFYwzaueJuiPlQtlkQArj9AqBMcaIToUveGZiT+ECI6L4qvoTBp/2iV6Xnu1dQ9tBGp4nmo3O1IN5pi+oBEa1l4xa8vSQR9JVj8+jWb+AyhxWHxwRBiS/PxK+hEf7tK+IhLyjiL9TLUxjdY2Zwmb5brztqQoVOrVZaE5luuMMVMCQ04Ic82+CYCRCuzy4eTiBxmvfI1oOSMKMRr6wNRM4ELppiGGgrrKiSdXEyn/P82oC5OLUQGuDaBoP6CZtafjcNqqU+K3LzLD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(30864003)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5H6st9oIpAFFF6S62qufXyJKIuqX8QstCl7tDYpxoHR5p2Br0yvP7mWKTLlE?=
 =?us-ascii?Q?d8VJcu1wipyaRIxK/uiRhIQG6/nKaz4Wsq6peZf5mEcW+L/GsnX3M1JzMcWm?=
 =?us-ascii?Q?KgtWXrz6u1jsOcOuIO/0RGjuY6kjiE3bXQgMZrFcsAh+nOFWAKNQB9PxY57T?=
 =?us-ascii?Q?ZnAdScPg+nYtiS0XItTBPQd8UqtJ+dVNd0xYgSZdtHQDsrq86nQPOC80spwT?=
 =?us-ascii?Q?TZ+Kmrpi7AgATeiWDBuHltxh+4JYgON0klwvQKSBfBzshXTR6suENEjh+So/?=
 =?us-ascii?Q?gmvtitWN+ifc/TXzRkuOw844TmZ/+gvrt4YrfZv9cjX+XKP6COzWJpTz0KrX?=
 =?us-ascii?Q?b6/DOLg/VJuaTKLdMInJM1lwCZ48TjxRSOk7Boj3I3LHL9hE7d6IF2vy3EgX?=
 =?us-ascii?Q?4In4Cne5/eZ+u084U3wiE7FKXgUSbg7NCieZiBcColpaUnBMoG6vjZiniCaS?=
 =?us-ascii?Q?AZSaxwk9qFAULwsRZQf+CGse7eKnjGe2l3bWGwwr+AhMeHUR6E921pWB/GRv?=
 =?us-ascii?Q?ye1SaQK/ALiV8C/9ADynP4TZlYK+gwmnbyXzlqn35bTiSk1VhpHB/87ivYSU?=
 =?us-ascii?Q?EJbATTfGOeFkMdqripb6xKW26D8MlZb3PKezsh7QuHjEVeuJl/OT0vAXgYXv?=
 =?us-ascii?Q?yqS3LsM7LJQ11xmEyhoXET4eMkJzlPEX/PjnvHHU/oDYdoOtO+btjD+OTKwH?=
 =?us-ascii?Q?K40wKZJfbkVS9CqZyYnYDku3OHf9yTg0tbcmDMGYRWXmfDvcLhaMMy/ArDWI?=
 =?us-ascii?Q?5PiULzRi+KBbo3qX9n5UUeDNPtrPh4Lnd4YaWEIGfIO0NN9ozcoXNefX2o/1?=
 =?us-ascii?Q?kbbzdvcfBP5vqnbz9fgmcJ8mydtNIGsE6+4FZtqOj3Uqe7ycEU7Ykmf6PA8F?=
 =?us-ascii?Q?Hm8dUXEavWnSwKHCInWZOCybK4XoGjw0A49DILN0HYGBd+J8fEMz0KVyNHjs?=
 =?us-ascii?Q?0CddrsychKodY0aSxOGmc14MlSMRD9B6VswW86uv3Fh0tvWhTck/1Lro0N2y?=
 =?us-ascii?Q?9aV/gSAltBP23V92Bq0tjXoASuQ/z349jHxeH91xdrIt/rNDaQARZYqMe9Om?=
 =?us-ascii?Q?4KJB4y/AnvT+hZiSrkWZ8kXbQXsZJY78fqikd6xO/ByGfipTjYZgpdR3WYIw?=
 =?us-ascii?Q?bzzyEXUXd8ntVDdQwoIhSOtfS9wrHitSpsqN/iH/sL3kfh8WM1h0+RhjTcy6?=
 =?us-ascii?Q?RjD32qUxU1T6uRzA0SVxo2zP/5h90RzAf/aaWEEWK3hf/t62xVV31Dc7QkVc?=
 =?us-ascii?Q?T+UwOLhNQUp0IkW9gTY1hSSF4ph4u6L6+qX3fgxBraHWg/3X08LJLB9AN53H?=
 =?us-ascii?Q?DQmPl4JMMwUbNore5gst+oj1/0x+jeYBypCksgkxrN7F8KpdjrKdXcQSZKBK?=
 =?us-ascii?Q?gexgZAeFCPmXvZZTHwrgbJgFvCnsXFQgd/uidDnQmNRORVh5gP3PTCNjZm/Q?=
 =?us-ascii?Q?8c7aAy562/5GLLzwcwIpsDRKajQ9QM0HwajoXobKwMPY3koaeXALCLT07GuY?=
 =?us-ascii?Q?Etpau6UeHpKlA7tpxPTYxIYZg/Y4epLWMzPuowVDeC84YxS4IfwV1gvsOAh7?=
 =?us-ascii?Q?UNi8GssojIlggmTTZvzSXRlCLP1aSsfKeQgb4rOqH+UBzJ3Ym/hkfU6BlbAr?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VaIXhJFo0X8cYw/ar/GjujxvX38RwHji4bTOhmhK6DZ6fuwas0rZsLWTH00KuVbWQ/ueU3J8ZHoRXFPJHwyx2IFDkFijHEf5DexRvyNMvPd2vptobTYiM46SvKWpCAJKO5weM8v+NY2grs7A98o+2j8/E1dHo5AA8L8fzZnLIRGAgX4UeNtBTge8zl9r9YeAkDSS+JC+XAR7qItcQqV2sZf1glNBFa6YnXmmc2Ym0wH9iwKqtAaeaQl65IpNu0DPha/1do6lY9rgzYNpzDL3ZTw59AeP5eh8ufcflyTYY3nYsexUSreX8ZTCo7kWUDJE8d0WJhFM/6Dj6tyRQkVnxXUnbglWGjP73cTdu3Uh28cjpvgl+JDKx07u0oBqPVgXrE8hvo10+dAkgmcSMfVT0HQ21hsB4FlR6VNWSAqe7BXbmOjMxt5fQN/AJdSeM532uQbRTivWszfFhudxpcIxP1kTy58HSHdN8mzF+zUzcEUQ1qiHbErhyzLLmXICIVXPbbOEHcooYWlZt2vy5OaPIQeD9P+Cr39YMP2y200nrJ6o4bWKKG8uNSX5YyfGDnvlXBM2+7pVTRNAd8GrcbERh1AAQhlXgfryWzNSUHi12XWeyAm6N0H0FZ6qPGjO+m2fwdrWnT3JExf36U4rAQqhtjLwx01qIvjp/tAiJk7ThblFUadeSQi4KPYCnFMkIjIBUOerEmxMULKPmrRr811dsDw9tgLW9kcqVcOi0i2mm7Hz+VoL/SRFpt+IkoMMBwSLKiZqApkRsRTvY2lUownxLL8HS6WBi9+SDRkoLXa8anT+xn0Nbw5xAEcHfpTpTqTH8via+8YIOCrZtWcmpuT7emk4mJ/M/woWRAGyInIdDIlHkOcW+xKP0OBQebcoNpFJfZjcecoD/gAflC4pjckt6Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b391d5f-d585-4d38-dfc5-08db62463d42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:41.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4WquQDN+UXc4LV/IKdkmdhy7sSj6odFGO5WYq3JrS0ezLmae5wmK8UxlkPotQGPo5wObCtpPntoQ6hjJhdxPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: -bPzwyrCvF6Vdk0woBIxe-AxPlxS8OzE
X-Proofpoint-ORIG-GUID: -bPzwyrCvF6Vdk0woBIxe-AxPlxS8OzE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the correct limits for vma_iter_prealloc() calls so that the maple
tree can be smarter about how many nodes are needed.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c     |  1 +
 mm/internal.h | 18 +++++-------
 mm/mmap.c     | 81 +++++++++++++++++++++++++++++++--------------------
 mm/nommu.c    | 33 +++++++++------------
 4 files changed, 72 insertions(+), 61 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 25c65b64544b..dc0ba74ebb74 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -697,6 +697,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	if (vma != vma_next(&vmi))
 		return -EFAULT;
 
+	vma_iter_prev_range(&vmi);
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
diff --git a/mm/internal.h b/mm/internal.h
index d78fd0fafa3b..531b2e95146c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1045,23 +1045,21 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
-static inline int vma_iter_prealloc(struct vma_iterator *vmi)
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+		struct vm_area_struct *vma)
 {
-	return mas_preallocate(&vmi->mas, NULL, GFP_KERNEL);
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
 }
 
-static inline void vma_iter_clear(struct vma_iterator *vmi,
-				  unsigned long start, unsigned long end)
+static inline void vma_iter_clear(struct vma_iterator *vmi)
 {
-	mas_set_range(&vmi->mas, start, end - 1);
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
 static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
 			unsigned long start, unsigned long end, gfp_t gfp)
 {
-	vmi->mas.index = start;
-	vmi->mas.last = end - 1;
+	__mas_set_range(&vmi->mas, start, end - 1);
 	mas_store_gfp(&vmi->mas, NULL, gfp);
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
@@ -1098,8 +1096,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
-	vmi->mas.index = vma->vm_start;
-	vmi->mas.last = vma->vm_end - 1;
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_prealloc(&vmi->mas, vma);
 }
 
@@ -1110,8 +1107,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
 		vma_iter_invalidate(vmi);
 
-	vmi->mas.index = vma->vm_start;
-	vmi->mas.last = vma->vm_end - 1;
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_gfp(&vmi->mas, vma, gfp);
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
diff --git a/mm/mmap.c b/mm/mmap.c
index 22c71dff762b..eaebcc8f60d2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -411,7 +411,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping = NULL;
 
-	if (vma_iter_prealloc(&vmi))
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
 	if (vma->vm_file) {
@@ -664,19 +665,16 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
 
-	if (vma_iter_prealloc(vmi))
+	/* Note: vma iterator must be pointing to 'start' */
+	vma_iter_config(vmi, start, end);
+	if (vma_iter_prealloc(vmi, vma))
 		goto nomem;
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
-	/* VMA iterator points to previous, so set to start if necessary */
-	if (vma_iter_addr(vmi) != start)
-		vma_iter_set(vmi, start);
-
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
@@ -703,19 +701,19 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
 
-	if (vma_iter_prealloc(vmi))
+	if (vma->vm_start < start)
+		vma_iter_config(vmi, vma->vm_start, start);
+	else
+		vma_iter_config(vmi, end, vma->vm_end);
+
+	if (vma_iter_prealloc(vmi, NULL))
 		return -ENOMEM;
 
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
 
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-
+	vma_iter_clear(vmi);
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
@@ -991,7 +989,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (err)
 		return NULL;
 
-	if (vma_iter_prealloc(vmi))
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded = true;
+
+	if (vma_expanded) {
+		vma_iter_config(vmi, vma_start, vma_end);
+	} else {
+		vma_iter_config(vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
+
+	if (vma_iter_prealloc(vmi, vma))
 		return NULL;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
@@ -1000,8 +1008,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
 
 	vma->vm_start = vma_start;
 	vma->vm_end = vma_end;
@@ -1945,7 +1951,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error = 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
 
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
@@ -1970,6 +1976,10 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
+	if (next)
+		mas_prev_range(&mas, address);
+
+	__mas_set_range(&mas, vma->vm_start, address - 1);
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2013,7 +2023,6 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				/* Overwrite old entry in mtree. */
-				mas_set_range(&mas, vma->vm_start, address - 1);
 				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2052,6 +2061,10 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
+	if (prev)
+		mas_next_range(&mas, vma->vm_start);
+
+	__mas_set_range(&mas, address, vma->vm_end - 1);
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2096,7 +2109,6 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				/* Overwrite old entry in mtree. */
-				mas_set_range(&mas, address, vma->vm_end - 1);
 				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2255,10 +2267,6 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		return -ENOMEM;
 
-	err = -ENOMEM;
-	if (vma_iter_prealloc(vmi))
-		goto out_free_vma;
-
 	if (new_below) {
 		new->vm_end = addr;
 	} else {
@@ -2266,6 +2274,11 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
+	err = -ENOMEM;
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, new))
+		goto out_free_vma;
+
 	err = vma_dup_policy(vma, new);
 	if (err)
 		goto out_free_vmi;
@@ -2600,8 +2613,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	next = vma_next(&vmi);
 	prev = vma_prev(&vmi);
-	if (vm_flags & VM_SPECIAL)
+	if (vm_flags & VM_SPECIAL) {
+		if (prev)
+			vma_iter_next_range(&vmi);
+
 		goto cannot_expand;
+	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -2611,6 +2628,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_end = next->vm_end;
 		vma = next;
 		vm_pgoff = next->vm_pgoff - pglen;
+
 	}
 
 	/* Check prev */
@@ -2622,9 +2640,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
+	} else if (prev) {
+		vma_iter_next_range(&vmi);
 	}
 
-
 	/* Actually expand, if possible */
 	if (vma &&
 	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
@@ -2633,9 +2652,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 cannot_expand:
-	if (prev)
-		vma_iter_next_range(&vmi);
-
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -2721,7 +2737,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto close_and_free_vma;
 
 	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi))
+	if (vma_iter_prealloc(&vmi, vma))
 		goto close_and_free_vma;
 
 	if (vma->vm_file)
@@ -2994,7 +3010,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
 	    can_vma_merge_after(vma, flags, NULL, NULL,
 				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
-		if (vma_iter_prealloc(vmi))
+		vma_iter_config(vmi, vma->vm_start, addr + len);
+		if (vma_iter_prealloc(vmi, vma))
 			goto unacct_fail;
 
 		init_vma_prep(&vp, vma);
@@ -3009,6 +3026,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (vma)
+		vma_iter_next_range(vmi);
 	/* create a vma struct for an anonymous mapping */
 	vma = vm_area_alloc(mm);
 	if (!vma)
diff --git a/mm/nommu.c b/mm/nommu.c
index a764b86b132a..a96b889cc17e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -583,7 +583,8 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
 
-	if (vma_iter_prealloc(&vmi)) {
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma)) {
 		pr_warn("Allocation of vma tree for process %d failed\n",
 		       current->pid);
 		return -ENOMEM;
@@ -591,7 +592,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
 	cleanup_vma_from_mm(vma);
 
 	/* remove from the MM's tree and list */
-	vma_iter_clear(&vmi, vma->vm_start, vma->vm_end);
+	vma_iter_clear(&vmi);
 	return 0;
 }
 /*
@@ -1041,9 +1042,6 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
 
-	if (vma_iter_prealloc(&vmi))
-		goto error_vma_iter_prealloc;
-
 	region->vm_usage = 1;
 	region->vm_flags = vm_flags;
 	region->vm_pgoff = pgoff;
@@ -1185,6 +1183,10 @@ unsigned long do_mmap(struct file *file,
 
 share:
 	BUG_ON(!vma->vm_region);
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
+		goto error_just_free;
+
 	setup_vma_to_mm(vma, current->mm);
 	current->mm->map_count++;
 	/* add the VMA to the tree */
@@ -1231,14 +1233,6 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_free_areas(0, NULL);
 	return -ENOMEM;
-
-error_vma_iter_prealloc:
-	kmem_cache_free(vm_region_jar, region);
-	vm_area_free(vma);
-	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
-	show_free_areas(0, NULL);
-	return -ENOMEM;
-
 }
 
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1323,12 +1317,6 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!new)
 		goto err_vma_dup;
 
-	if (vma_iter_prealloc(vmi)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-			current->pid);
-		goto err_vmi_preallocate;
-	}
-
 	/* most fields are the same, copy all, and then fixup */
 	*region = *vma->vm_region;
 	new->vm_region = region;
@@ -1342,6 +1330,13 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		region->vm_pgoff = new->vm_pgoff += npages;
 	}
 
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, vma)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+			current->pid);
+		goto err_vmi_preallocate;
+	}
+
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-- 
2.39.2

