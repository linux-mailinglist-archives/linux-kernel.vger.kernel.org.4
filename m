Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39A060172E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJQTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:16:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1027645F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:16:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HITdQk024075;
        Mon, 17 Oct 2022 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=s6WxsB4P4/NnMWPkhiW++UDBO33GhhI2iU+dl7SeAgQ=;
 b=2DByNDsR5CzLJG8PdFRWp7agK++tgjg8wALbwGFvUllayt4k0zICY9rtQtRVTI0V7wKS
 XaOQskMH4ughGh5++0goxg2mWCeFD+U5Z7/Ar2zSqOvUyrH1PLWRhOKI6SZXi6G6tIM/
 4cn031PQfEmQ7CdqOawIB1srDUHFel4BB+lon6Q+tAOTfHjWgpxaD98UcrcMIcOFXALI
 Zqz5EpYzExDJ/BwZuOhlnskQQLMYzGHS5++72nZDGjio2G0WoADabr34BoEWh0UMoeEN
 HBib9cMiDa1EoyzboIANooiU567Q1zK23kFmvcpCi9ZzbGK6q5ZhEc0K3ZHwlLIq3zHG lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtcxrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 19:16:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HITwqd019156;
        Mon, 17 Oct 2022 19:16:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0pjxut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 19:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clVcvumHLX8RRNZNZFMwwmUOT/XTPGxiOu8Blfy/hQVd+3N9fqhe/pZfZPevIgSpks3lHLekZWOnKTSImK8vHVb9mi9kfrqGPo+1iCRWLE4gRfSM7dpWBJjeHibII3uZh1aIv338ZqHako7jahCREyRP8oq/jnvOCI9nNtTHile5GraKU/ihRPSga9YCQuwZBEJbDUwrIXDO/yJ6P0/bQyynGZpNZCL53ZMVvDEwZJkRJBpdgeIMy4pAkSMkYiCrfSUr/xKF3vS4Zj1rLlKjYMJ1lNt6oHjH6t3bPS5R6iYgGw1WuEiKq5inb6hQIpPMt7leeyrpdWuY8KRTS9tYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6WxsB4P4/NnMWPkhiW++UDBO33GhhI2iU+dl7SeAgQ=;
 b=CyJ3wmzhIK0OslpsCf8Ryy0y4lwsR3q889HIES2pWcfr2D/tneKByAYIasKKq69DxaGyRQSYXiK50ok79ZIs9Z4bxTRqrWaPeWnDsIRG1bRTZp6JYVNhNQfzdgO0m1zh3AvpYEHlZeH3yY9DePDL/zfNZhWbO0W/kqgNdIu9rY1bt9PAX+M9ySQ+I+lFxWQC+F+6WUXVsqlPkAcrAUzar8m0pK/6AmBfmlcDzD4Eq6ahmPShfEqtj8deKF/v9Nr3NNRoyOzTxEWw9VnOymUXgxS2xbv32MhJgjhZzY2pFm8th4D9mL0ft1hntx+lWZcZg3K16ZmKw2h/XjwyDXqoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6WxsB4P4/NnMWPkhiW++UDBO33GhhI2iU+dl7SeAgQ=;
 b=Rbn8SQOHmPAWNlurtDHbpC0z4ymrlTpqrzozCUepPTuP7f5FwmL8bYUANmjO1kEiGpIdVigrRatA15STZ3JPkr0I57fvnQBsVMuYh4HUQwUxaVL1EM2DBLx4zsozWTfKmqNoi6vQMHQFh5hagX65yJD/FttlRK/T3SCiTZlskkY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 19:16:38 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:16:38 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Cc:     jane.chu@oracle.com
Subject: [PATCH] vsprintf: protect kernel from panic due to non-canonical pointer dereference
Date:   Mon, 17 Oct 2022 13:16:11 -0600
Message-Id: <20221017191611.2577466-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: efb280a3-ffc4-46df-1c2e-08dab0741d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emCHekRmf9zSYRHLS9WUVJAgMdEJsmoIre2YhwKHITIBHvnr1jnXqxVYR4QFljfUVzN+FiZqtQoZC4ZgwLY3k8A7xlUc/LM9Vwe491R1p0Fn0nwEAiPYe/RGgDi8C2G/j4/sdrUl/RAbcLjoCdBgNXJ4izmOwdtX+XA6lO4xj+qHOagmZ66YxZVWTI/IzRkqZ5zkSZYrDRpC2UbmNPy4UW7HAm8X7j64J4n9vt6noMPonr5H2bjhew6VKTDLmgUYj/UcfFDmy9Oq7uNqG2ChOEa6v9YMonzez4F04gjqmnv2hluQASKmKqn8WEkOCeZP1L+sSWuZbHtUPBsp5RC6FCznguSIF6ywEHT8VxjWKC7JvOub8WdxIq/xTH8M3n8596LE/QcFS+t2QeEWmyfw7u9qhV8TSc5nIFVWwHMjsje/yqBI//vfPeulxC21m7fY6vmcunYCKWklaaCZx7yQ+LtP4yirSdk41cIIYF7Vilux/HB+xXMk66AwB2Ux8baKcXbv1sPxTASzNuc/imGleaOgXbhpthTfLNxuo6TDQ3q88TvWpjBhxNr2qSvdeiP2RzIFfNM2W5RmgnufwxmMZsyHzAyxjhvzUUZEr7DSA01sOLlgfdxFHpUELuGFa82BHJFc5CSJVRYJ/glTE8rz9Hnggdxgkin1eO8HLuUFOijPhx01QtYHw+o/M540c3PTb6X91uMNxtPpZWJryJX65A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(186003)(316002)(36756003)(2616005)(44832011)(4326008)(6506007)(2906002)(5660300002)(6512007)(86362001)(8936002)(52116002)(83380400001)(41300700001)(66476007)(6666004)(66946007)(107886003)(66556008)(4744005)(8676002)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvaCSVNL+KA6/zzzrU7T04+FLGO0vJPpTgehYJuKnb2tHxxyqUjcr4XShIKw?=
 =?us-ascii?Q?RB/KwjiMG5zy3Vu4qQaWDs0JxYRq6hZxjbYpNwpXan/2TCcAKWSenKvn5t13?=
 =?us-ascii?Q?Aeov8YdJmPGi1dMYjrOCt5JIY/JJ373JNo/PYMH9ca+kfQ5SyEZ9ej/pt0+X?=
 =?us-ascii?Q?h339OqPlJMH3my6XtXxm5wHTjWpdbtJH8LqH+5dytfK/xhkF2GbSp1R+q6C1?=
 =?us-ascii?Q?M3YybfBK5IvEUpjCVQJBJDVMdFrUvHdj+ayMpi6Y3eEsvdilPyxhKNP+25MK?=
 =?us-ascii?Q?Koe210QzL60s6BNjfl87HkK6JmH4MZww4sUNe+Kp+V3KEh4Wp4gLJgtoV6gk?=
 =?us-ascii?Q?UR+Tq0E9r6p8c7WIVsRXQWZzOuVQJLIVxR4mPPIv3W3c3u4oQ6XY/a14zhEv?=
 =?us-ascii?Q?5hl8M3wogA5ihuvYhBviId0deDWnUu4+dHqncXjfa0o2NQeoQtmk7wWv65HO?=
 =?us-ascii?Q?kiIKNfb5UDxQIFvRXwhN+XFYmoxDT3m+59bo5qOFWH2z2LzrrwKhoK8UlKlw?=
 =?us-ascii?Q?TZ5j4OJw+5NjkwmId41EgBDL8F8EqGzvplsZhodT8Y57JHIKIyoMfkjrFcWb?=
 =?us-ascii?Q?JGsHaGC9QgB8VeF5y0a7C/nq5JnuHjf/wXd+y6aT/QYLYPt1kVoGpcziHGbr?=
 =?us-ascii?Q?NpKEEDS/I5Y9nzzA30ggwqb3RYBYlkiRdh1MfPAc5WP4AWyf4YGo+8DHsw0x?=
 =?us-ascii?Q?QHRxdaYIW/vgnsvYeU4gaT7R0z2r9ERvI3QE7dKDSg1//dPz3tZLtxsNJxtX?=
 =?us-ascii?Q?FVLm7prapjsgrx3TKBHdky4nIWloGqx+cujUpalfWks+HhXl6mDBpDy62uaI?=
 =?us-ascii?Q?OHwE6ZfiOXpQC0gumEkjRUWK8YoL/u1C6JQXKECbvN9mtedcaW93yiG8u3Af?=
 =?us-ascii?Q?7dWF1ul0sXge8+kPh/AUv34iNZMyDn9ezTbFOZMLXU9J2U6/G90ntgiRay63?=
 =?us-ascii?Q?hg0cD5FdxuXpjWTqLL15Lt6QMpYCVBnaoJKZzjbHr7K38uh58u1JjxHKwvCf?=
 =?us-ascii?Q?3rX64eyPuJDZhPbPf7Iu2ArAjGzOPF5BjS4ds2jDjEPz8BM3bU3uIaEVpOfY?=
 =?us-ascii?Q?mP0oK9bBZE8//ypFhU6oTeECqsI58Ghzfncu1rI9C7PQEhwcoWqRwwV0u/wE?=
 =?us-ascii?Q?3horGZ9nIl98H1uo+NAxef6yCmTn1u6B3R82T0WpA7WS73/jiSSu6w+/Se9f?=
 =?us-ascii?Q?4f0fCO1YEidjOj9QZDIY0bwAEzVToxVdDdXGtx9zlZ+jCsl0guYjIthJALp8?=
 =?us-ascii?Q?dBSTztx2MaraWHFeIKZiPH8sIFUsPveETjbOkVhl6OtAR3TYuMazy5GTWjQF?=
 =?us-ascii?Q?k4xvBIB6LI0LilOcPhZFXJ4qj6mqePUG4Bsb5ygDF6oKL/fnyCAiGgXAl8Vk?=
 =?us-ascii?Q?9Vx4C6XU3HKQEbInaaLvGtn0HEf4xCji2KZn9CNiEPuWuigaD15/HhVvzqLP?=
 =?us-ascii?Q?EUWGseAgFTmGvFewJ4qRn6aLU7B9D0figGBAFGRFaf7flEt+xmONv5qGonRz?=
 =?us-ascii?Q?tHBnenShv2RiUuAbAfIX+oInDJRNwSLs8EBgutsXHYnLkR7+vzxTfS6LNpmO?=
 =?us-ascii?Q?uNfZbShMVzQDVQYrJgv3UTobePACeEZR7kfxtaNFvOyHQKhGjh+fF2Gr1xyn?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb280a3-ffc4-46df-1c2e-08dab0741d3c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:16:38.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEuI13nD1IibcEA2oVRn8U8mBT2IlaN0qwTsbHbmca7LTJhOOwXLOOwpdrtX2Xq1XVN2ip4Xm/jYM2nIoVhJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170111
X-Proofpoint-ORIG-GUID: gDxEXUwJUlumqUIAzW9-No7ubg4I8x6V
X-Proofpoint-GUID: gDxEXUwJUlumqUIAzW9-No7ubg4I8x6V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging a separate issue, it was found that an invalid string
pointer could very well contain a non-canical address, such as
0x7665645f63616465. In that case, this line of defense isn't enough
to protect the kernel from crashing due to general protection fault

	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
                return "(efault)";

So instead, use kern_addr_valid() to validate the string pointer.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c414a8d9f1ea..2e8a9efc7c12 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -695,7 +695,7 @@ static const char *check_pointer_msg(const void *ptr)
 	if (!ptr)
 		return "(null)";
 
-	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
+	if (!kern_addr_valid((unsigned long)ptr))
 		return "(efault)";
 
 	return NULL;
-- 
2.18.4

