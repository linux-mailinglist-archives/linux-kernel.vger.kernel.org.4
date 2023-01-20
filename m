Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF50F6759F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjATQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjATQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A926843
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGEBVv006200;
        Fri, 20 Jan 2023 16:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/9kACN/AP4IQaoyUNzsvycQcefPQy+ywc1CEO7zJRpA=;
 b=H3yLSvJ/O7KALsbr0P5B3kroZCe4UG37VVxEOqnmxXO8ND5Ixsi3r6HsMaS1raZd174o
 j6ESsjAI2UA0lW5NHOirkSNVbFs87hTf3Zzi4dfaVqe0PhzETJFbBR+0MagVaNEHe7bB
 OiLL/hJqa6rqwriHmKbpz+ZsMWDbH6cXCblaRNJNTRI5vYE3EwpadLwflA8fw277Qu8G
 oZApi7qtuGPK3isilTXmfkc6pEb4G8v0DVtq/K3NT0rOabFHUWkTn3q6uCrBuSr+h7ki
 jhL/gO8aaMBc0ezsRz0Wyk8KUpOnKSBWUmS4i8rtSTH0gYJqyqS21nb6oZV6bb4sxdQm 2A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdmfwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFOoWE000777;
        Fri, 20 Jan 2023 16:28:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2svyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDHFQjqETnLVnROjoJ4i4pW0ml+94vNFtuR+kA/Rw4mSS6nTbMXeqh8trWHB/KUUU+3pgUvh4HjEHbXqF2XVJEAi97X2mHG5/WYZXPf/2OhmD5n1netV0/z+2n8oNL36VkwEp3OHy14f7FZQxO0tl0NPzSaL8hbZcggC8Y/5Hn2A5CDBYaGulvXzVp5LWDMa0wenQqxd3L1ZzG07ik+/gKj3FU/0FfmBlYXoRolIb+kTvcawP+aXS/B4fbZZ7/w3f87nzwhh/w/m3kObAmx++LWbHPcTBH/OB0k3fENlGFelm9QUPpghXw1XWky21XU8XjE5Vqa5hKF6dMRGNqiKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9kACN/AP4IQaoyUNzsvycQcefPQy+ywc1CEO7zJRpA=;
 b=T4MUHU/uESqTHvQVTSzG4UvWLAJ7ONqFbDpBH9XghCgkqurikVagiqOO3/TXRNMOaLihwUZexSYscI8xfHg6PQLR6LGfB2e/q3TyT+66qESAfE9F6Y6QQ3UoKw+/2hU1l8d6Xf2TDONcM5htCTIWUgKWTRjob48/tV5/9zuPDZDdgouadxdPT3YJdd+X6EmILvZADBrXSRme283grff94K10znM0mGtjBbB6h/G68M7/nJiiCz7CwQaNdDIdxlDKfYxFlZKxwdh7kFcgsuLKiXAZ9CmuWGOdaE1O7OUleH4mI+yR4K+gj0SFRIuiANCRNDVhhEzmFgop/3bQTTbI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9kACN/AP4IQaoyUNzsvycQcefPQy+ywc1CEO7zJRpA=;
 b=z8C/+fTZMWeq/6kW67CttkFtoUOiVld3up0T4iC8VYK5Y04u8DOoYtoYxlAzECVwlKPpRUA5jZHP0BqkKsGGrZdUR/kyn5g3xVpA49n593jiayRWc6sy4SRSt7ZPpzKuIkKhH/NepsTJMvRiuyWLxdE+wJaPCzlpIln4BGWSTnA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:18 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 26/49] mm/mremap: Use vmi version of vma_merge()
Date:   Fri, 20 Jan 2023 11:26:27 -0500
Message-Id: <20230120162650.984577-27-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c679f7-1c31-40b9-c116-08dafb0355e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71qp98AKk5xBLo+cVjUhSGgDJYZDlZxczlfKieYLL6Rk1cSdsSXhHgisV/LJObnZeA075RoIPa63H9cOx+N6xDYcyMLyoq2oL2SXmzwt0hC40NfX9H9r91po9snRC6Z7rdhoCRuje1BrAYxdgexBSYvmLTto960r/iIfBzgCKGsj9gS4h8Ix8yCoTzw22GXVa41ye5lQSfhG0M52Ar///eR6g2hzkK4iuAJbeukWte2ZtL51Ku2AC2fqooqpgZIdi3pyqhBEWLv3axO2mOAKC9gxNrTKvA4k8XvXElxbauP6hrTN3zpZKjGyS/LsezsZPBLXnCFhqFh+OO9/5cdxoPq+ywrK8hQEWtps5OMjc89MjMQUfnaKiW30tBj8O3Wlm2JQrodE2N1m/vwIsP8yZHzbtlgSRwu929DNavi/WCe0rOogY08CVdbgOwkhsbWa+eE1Vl5K+6Cw5qMun87goHdV4zEQGrsAq7Elwg90M2Nrj9DW1shj10c/0ZHa5Y2PTk5cpDMoN1lkcF89oHXr9fwOUETa3AtOmGy9kKe9sE7xZoS5ByIqgZw2ifSUI/V0QDUOkbc5j1xGMq+NSx8dnqej48KKRTryjxQh7eoI5y2BZaFSgLzunX9mmkfeSppr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(316002)(26005)(54906003)(41300700001)(2616005)(4326008)(66946007)(66476007)(66556008)(36756003)(83380400001)(86362001)(8676002)(38100700002)(6486002)(6666004)(107886003)(478600001)(6512007)(6506007)(1076003)(186003)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uxep9WGjZduhse7C+CrY/mUeMFV2dEdPw3ffygY8SyMcws05HJMH1oVZCp9Z?=
 =?us-ascii?Q?mR1DAsRd31Oj45yEvyyGwZrBq7eqWsv77ixo/s/mSozNtWtwQSm6HTfPTTLH?=
 =?us-ascii?Q?BLVZzbeTWq4EscvvOb/zATIE7Ammprqp4v2/Ov7qYE3eMmO2Mr5SnzUf5RW8?=
 =?us-ascii?Q?WHJYBzseMDpfoY3QPVPGfxsNHJ+9MJgSu3cS1I2v/d5E4cZPawHqZcoX9hZa?=
 =?us-ascii?Q?34x6sY4Ww2Rf0wlX/QiF8Ou5ShoRrJZPo5eSwqjIZ2BQX7DiffX9kUsHs7Er?=
 =?us-ascii?Q?xOtknmqG7fC5cfff52/ZLDIzAiY6VM/d26CjLsGenihiSUETXyxk6jf042pM?=
 =?us-ascii?Q?+xOvIfGi6E/Ol4cgNhgyHL7lNnPk38iEEDsc5Rj4lkiKcy1EHJ928BJos1QL?=
 =?us-ascii?Q?gZw49hNIDnqKjbHcn6z8vQmFCFbrjVBNf6hELlgq0WkRsOJ0g/1F6F+8iyeK?=
 =?us-ascii?Q?A1D+1o5OJtKCKtCWN1F6l9gxUhwz7yDiL6sKratnyvZJvgWvcTFEBcfFrwRK?=
 =?us-ascii?Q?mTcaFWVGdiLu+cseUFLEM0CxVcxYQ3rj6ONrBxYUpQAFd/3a4VKyHCaKpLKC?=
 =?us-ascii?Q?cHDNCbnJYqAW40R++35GaS+FfDGd01PCeOI0B+knWAQjIpfolaZlZcAFrU5t?=
 =?us-ascii?Q?RI/5D8tUlCq04o4JFAR2FWRibSAwEEcjV3ovg1ijTYKmnYwSan03S/HWXhYD?=
 =?us-ascii?Q?gZXubPuQJXRSST1L/LAjZVL3Z9T3hK62L3iGvoCGN1xLho5VNSJSr7j+9ChM?=
 =?us-ascii?Q?29zW7qe9veqW1EabMFR4PVeRykUTeB6/b/Chks3StzcFgGJed/jKBEjQ2Z1A?=
 =?us-ascii?Q?JzMvfi0a+6oZeA7KSBPaYp1UiUZzXtZXQu8CgqY1V5FXHeTIQCRM5Kh+A6xO?=
 =?us-ascii?Q?zZiLoCsPvGOrn1zbeC82dGVVFGYURL07F63uGufFuzq1gwHOzRgYaL9DbfBO?=
 =?us-ascii?Q?m+4yRy7b63AMjBJT3WASYBk9ShuDF2ZuM9vpd0VNT6lrWHip4v+MnBMwtWpL?=
 =?us-ascii?Q?GVpD26mXGBdKMK+ERrmVI/M0jNqmexXuynd8seAUUqJs15fzAt637pYl4L8H?=
 =?us-ascii?Q?BO2Cmbuwe/6Vnv5xcZM344owB8w/eOMAWolHs38rVXpr8vJWSW8wZwShxNlm?=
 =?us-ascii?Q?pCFBX+OMega1ELNJjSyI0Pb6LoWFJl5ndJWmh6OUCouIBy+SzvxKVxICrBJK?=
 =?us-ascii?Q?8kMRQN0Q+NthmYC7tnqRo4xTupRiVQIEWFwPynxUiTXUlBwk5LK+sKSJSkPF?=
 =?us-ascii?Q?/FOeT9LPBr5YSyNxNSX3ygFytoF5TFjRvxUVX/KGujwxEqpF1A55sDorcDEI?=
 =?us-ascii?Q?Zy6lKjDqAeCpDaars84eCKwH0Ccn5ER4W6yCjt4+7MB913YRuokml7ByoT6B?=
 =?us-ascii?Q?4qro9P7Y7aMthizZNLFoRPmIUQBCW28+TnICRgBVgZR3hZGTSw/CY64x1xSX?=
 =?us-ascii?Q?5GeFRQmWx5d32Len1Y8v5a6ztS48YVNBH6iR0FjQJ3peuQsDOlXzO4c7d/41?=
 =?us-ascii?Q?ggqHmY4spPIKxhfCPV2TU6ERJek/JIXMfRLiEcI+6ZDLc/iE+N1n+LTjuxzC?=
 =?us-ascii?Q?67X2gLTKIhXZ3d/myMtPPpQZAM9F+RM1fupBtYeSra7rm6NBN2BUWIgDGhPG?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f00bskaVOwowAMmBYoD/YZ080t3W4/jIeTrLVHu+THIRZcvwdRDpo1tOYepWZHR8Qf7ko4hK0IwlRI0iDuTvwZj85dJBBu8ZydhuMlsvv/9LiRA6rhQB81sjbju6+TMBWv4ExI1wy0VMRFQI9MeSZybWcLg4Jgg7SzVe3d6jTO9zNceOdUQcqZO+SK64F1OSH99vR7Mq0a/SxugtrS92eVjSVMk8Z19+3V3apL+ulMqdphogl0iVBF19HLKjdwuPGAAsXXPGVQJydvVcJSOfO3VV9s9X9ltNslJz0hPI04q6OMrXETqJbSIMPk0a8EjwhxkV1kB7KaBLrFQr7eBQI2KheBkCOb+4xy7+X4XZPaYSec4W9shBFrStpmrcHBqz4nqpM/kp60qTqSS6lt6E07V8QoBbCZ5aVD9yauw/9KC80eTQTm3u63YwlnzrxRabavykAeVIwvNwcXOmgd2a91feOmGMSHdhfA/+EBoxCCCono8RYO4VbL8LZtDKu8EgNNuYm+6D2DAPTQBNEv7v9p5kykYGB8InhNfRLpah/QZbKAEiRNFhuzd830uZcM+9yt/4y328RrlJFfspe8CgENsnrx4VT/qfULDTsQYqUB3pYosrzFP8kOdWfmiO1LLW/qneTGLy+LmraGQk2f5OCY1wdAVaELaoXxdvH3lMtTLt/nW1a85ivDwTX/B2c0JX18pgW+FB3NbORrj1SGRKOldVqQDphSA3eydPtDgTaNLGUzWHj9RrEhCeKyOqWRT6Z4I/oHhWwgGTQG9B+8Ucr6NoymaCRJVnrS+Gdx6KnhtknITcHN3mPHvH6s1ygggAgwhUSr7DQIC1U1yWT3ABcwt2gzLwKuhODj9bvXn96PpgDzFD/foQEy5CrAcqLuHMYnJ88O1FzwV3TiGKA72WOA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c679f7-1c31-40b9-c116-08dafb0355e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:17.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEVazrXeAT8JrGbkf0npYGGMOKlb/XW+S5OjZJ3zlN7BhEhWx+J613euClZI6nn/o4tldjEtnwJ/2uBa7bvB+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=832 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 1E97svEgIO2Mi4onTfqViEyhGWP_TSir
X-Proofpoint-GUID: 1E97svEgIO2Mi4onTfqViEyhGWP_TSir
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mremap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3cc64c3f8bdb..f161516ab3c1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1018,6 +1018,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			unsigned long extension_end = addr + new_len;
 			pgoff_t extension_pgoff = vma->vm_pgoff +
 				((extension_start - vma->vm_start) >> PAGE_SHIFT);
+			VMA_ITERATOR(vmi, mm, extension_start);
 
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
@@ -1042,10 +1043,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			 * when a vma would be actually removed due to a merge.
 			 */
 			if (!vma->vm_ops || !vma->vm_ops->close) {
-				vma = vma_merge(mm, vma, extension_start, extension_end,
-					vma->vm_flags, vma->anon_vma, vma->vm_file,
-					extension_pgoff, vma_policy(vma),
-					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+				vma = vmi_vma_merge(&vmi, mm, vma,
+				       extension_start, extension_end,
+				       vma->vm_flags, vma->anon_vma,
+				       vma->vm_file, extension_pgoff,
+				       vma_policy(vma), vma->vm_userfaultfd_ctx,
+				       anon_vma_name(vma));
 			} else if (vma_adjust(vma, vma->vm_start, addr + new_len,
 				   vma->vm_pgoff, NULL)) {
 				vma = NULL;
-- 
2.35.1

