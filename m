Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330B6017F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJQTpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJQTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:45:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133C719B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:45:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJi40D025291;
        Mon, 17 Oct 2022 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=nYBnln3qvMlYaKkUsMs1rDnaohZQO4eL5A8SBO5Hec0=;
 b=QBVe2JX/AiGhMdKzSRcDx5VXA6gZTmp0uWm9ichFvTYuJU5779RusPfZq2k8YsWjVv2K
 +bp7LkDi1EACpFEyeIEYE1u0TKJD9zCOR4D6H0W2v+jB/g+n0rNsgAoi4i9lFsDOHM1+
 xqjiTHZmWdSi/dvqQFUGoomPcVB7cz5WMcjVQNG2W6fVg4HDJYB5KpeuCBq3WZ+BIOyl
 g+Z73DKE0WeOEcAXJ5M+/o9ao/7hIkUjV3Hr6THdpqf13dBAkT2QoJL00xx7rtZbP6g9
 yLk/TXXzAviBurjj7V+9/ldkbeKXQ98P2nrpYBtwVx7OSdrAcB9wQMbf7iEA7sNpuM+a Ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww0fqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 19:45:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HIVeh0019193;
        Mon, 17 Oct 2022 19:45:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0pm558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 19:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l67gC2TUH0p7r56KxWo/YB9z3g7yirPIIEtrCIRKMPTD07+0HMHiEf1j0G8s+OrughZ2epGvJQnPoJEXDI2FCRlHPWT11pr0wGtLjJjb0kGkSekxgMyN3ZthLoLfzkwSZsvLlTf3d48A8DDrJm9+Na1Rq7XwsMz39w/PBn6GVB/4sLtoKEiI4XTMnZLPaCcI90SUO+pzPLAM8/AHlJx/BKdcEl3ZNPQjYrney5Oumipmyyzqc9aSIk8XM8dILCgko085EkmHGeentKY4Rpi1IXYmq2o2WDEBJIyZqt1kcHGqocd4LdlmaovSQ2Ca2KzBbDyRw9cfRY29JDv+wpFyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYBnln3qvMlYaKkUsMs1rDnaohZQO4eL5A8SBO5Hec0=;
 b=CRNjn+f0Ek4PTk61RRzq8+Jzk+XYn5iZgwDGzPt2tsOBgrUlSXBRt4MPwIg8qtjvDuxBhPzBDJQ6I+TAh8z8DgCUMHZY3uxVyOI5tLHPUegNnWN3PYLwNiqut685IRB9KWh6PvGAozX2a6tizF0vb6dt6HH6o0Weyc/24LLf7OQREbfTu/pg7qgKfvTze379aNx6ZgmroBnTljX3SftdEyHq/hBK7Fi7ZejxNW4SrMWWqR1dS9800HxoTEzeNFHA6raZhd8ZGUdpFOpkzUmupF9upj14+uNRRGnDtBCJCUlReoC/5/He3EWCtLbqcmk/CTYefQaTFnzQxIeDvdDxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYBnln3qvMlYaKkUsMs1rDnaohZQO4eL5A8SBO5Hec0=;
 b=vNaMr5WmS23QckuQXgMfnmwsSO6w3ZrNVmOBpIf3yxgGiqUe7LnjJqQk1PeWnxtjH+5HaX3UmaM203lruwNUUyL6+kY9T2izuTfM+y0XV5g9YnJRh7Ao6ukIpb76pN23+N/YtYEPztsY0l1XrubyqOISVnorEh8p8TRUa/ohKOY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 19:44:59 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:44:59 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Cc:     jane.chu@oracle.com
Subject: [PATCH v2] vsprintf: protect kernel from panic due to non-canonical pointer dereference
Date:   Mon, 17 Oct 2022 13:44:47 -0600
Message-Id: <20221017194447.2579441-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:806:20::33) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH2PR10MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: cb64f30e-14de-408b-53b7-08dab078133c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SFvkzBrx05K5gBQy+oWMRr62HfycZT/poHAbOfG6ucygf4gnIGcXFj2ld8ElpPXjkG1yQDe3BOEhphS9blrkxI3vud0TY4pC8Qj71Y2h9HnjGVYv9zWttUzqx9HAUI0+fT7G4VCoymPCzGPp/AzZEG1Qx8NvKWZBprfVXkZqlws3wn9GFjdgzGJyzzC5VcKYwsTd/vE62VtcWeNEOwGUegP+DipGKN9d+11b8NpaAYec65mVO8wa//BOwd7VHRkQ+tTb8lc4lYtjrzMelIEIGcyMZD8Ij/kdQslFYLjuYFbQ/l9yJsxnomcvEbrx1vleI6ce7QnT91es0kYmmUhi9+qg/rrn3j9ESC+XznTXbZfV7ThBe7Quuqa5NSZ1Wg/Yc8z0oucda6fcLISbEKnyM8Mjt3laIsGNiOti4nATkf4XSrPFwd8tywj+q1PuJIeAdJUsUDVaYwgv7Ojkc/fRjznsTuRDP/l+GtncfhW6P8sWOhlvO7KOEogDhLJ0b4YPh/DQUd+iFXLw+QgyH+zq5ppiEOMplzjlKF2tO1Tw3beG6quOeKqaNmZ41peMXA2rj7IjzzlMFF4xce11dzmzmQV4FfWqJs77mWbwFcf6NsltGJBybV9S6/RPm+hBE6tfkjfm40/ZDW5eTh+qRWWPF/yDqLwSQ/M03L+yB0MVPs94IvxQSCLm8xhIvvYZuSDu0u8h1900D/Kf2oTwPTp+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(38100700002)(86362001)(6666004)(107886003)(41300700001)(6506007)(52116002)(316002)(6512007)(5660300002)(8936002)(4326008)(6486002)(478600001)(44832011)(36756003)(66476007)(8676002)(4744005)(66946007)(66556008)(186003)(1076003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBELa0ei9x3pF3Z3K6F5/0kzzB+3GTp2U0TduH8J+2cl82pY/LzSxE9djvg7?=
 =?us-ascii?Q?gUo0+TuJqNb9Rqigtq1MVtCiC9P8UnWNk1jneY8u2ttudK2CnMk0132vjfOH?=
 =?us-ascii?Q?mTl6mJYnIGXIGurAJ6gsqItzzDc/9Vxlj9DdOUQttUvVaC8gs6wNqIglmBwI?=
 =?us-ascii?Q?FJqXxC1UxPBWjAIK6dvCQUyPBpozq7LCBu51WadZmJEe7ZLm4FWnPf5o5+No?=
 =?us-ascii?Q?LpZl/psJ3D0FVZy7A1DSNwJSQ2gsAY0p+g66AfP5pfYTc8EvWQIJN5pFbQh/?=
 =?us-ascii?Q?3/yva8tFNCqGe4mpgsFtvpirQ50+lXUjd+qjCajLzfaQ2JL6yMNUATHUcFof?=
 =?us-ascii?Q?d3xUj8Rfz0MkLJlZoMjI8wQ8SQtTbn8LbF/dM93qTvUiPgny1Dr+HY0jzd0Z?=
 =?us-ascii?Q?VuTtcpugjxW0AgEHpRbiq3l6R43Jdd74M5mfy9nHLA3EyPRVGEYYLhQR1KOc?=
 =?us-ascii?Q?Y+39sMocIhTj1S1CvaZOJCaQSCTmmUIE4r0WuJM23SbMAAAZi7KTSJWO2x+t?=
 =?us-ascii?Q?fuF1GvXDSXfyB49y88f815SO+nBhDkMFZSB6hKbXHQ7mvkGe5+1vS3oDzzs6?=
 =?us-ascii?Q?2MuiycfE2FgciB7/nU1duq2PZob9fXgP+J+vKSbexpXb4LjUcYKOg0zfrnrV?=
 =?us-ascii?Q?BtVhjgKhf0KY25FaG/PLhNNDBKf9WyrjfW5YltlkDrf5Go0vIBQJmtqbwE81?=
 =?us-ascii?Q?4Kfv7pIX1Sx2HGlxtuVU9E+MFTticQ9P305tBAXewpflZrAWrdndrIBmG4mI?=
 =?us-ascii?Q?psDIG7Am9UlladWO1M3KBZtwTA6Gt9UqHTK40S38yuN74xHkQ1OQB223JsAz?=
 =?us-ascii?Q?GavNbmErO8aGi9DJrYAzh1jBjHFuJdpHABBYEQpPaas7PbpUDun3sO/3ny4j?=
 =?us-ascii?Q?/k9hj5zZvD+DszKmGBWxUnb0Pdf/VnUvPozTAoKcIKWYTWnWXAjPtgsUAD7l?=
 =?us-ascii?Q?kq5aFiv4JubFqVNxHDvc1id9zDfwtX0oeZ7l+n7WcjqIFWHYzKyTCm8TzTxg?=
 =?us-ascii?Q?oLlQce3Gepaa7vkezqFto0PYOvP4QSGqkMp+E4VoyQ8mABJTV6340Ne+VxQQ?=
 =?us-ascii?Q?liVP1KJ1/QVWDEK2rmmv+vKGM2sjE1voVtG+YENCA6qRiAnq1224Gzu5atRM?=
 =?us-ascii?Q?L45fspC7QZLtzPzZ6kq+sRS2RHCWTzJZGKS8RuQvlNq+Tm0TMhGMcrq3Brts?=
 =?us-ascii?Q?TsMr7vmYVWoxTD4QbLqterb8mYrsZvxcUmh52gk2j0dlKt6C62vHmoEeBB+Y?=
 =?us-ascii?Q?+Derj0RmPmUduVD5OXM9hqCYh2u8nb+YXwQ34Tb7XpAH5UWGCv6NEk0ZDoZY?=
 =?us-ascii?Q?UwAsLW9qtuLnCuLASoBY63QuaIC/c+xkMMkmeIoRAb6BUb8Q2v92+psbuFUL?=
 =?us-ascii?Q?1E1iqQrxGWCD6mjUWgRA5OnXlcAdadaX4dLfYJc545xnDhRNHGoU2JykxfRR?=
 =?us-ascii?Q?l3tnCePNf49qB6fSDQOr7jS17XihImEl0gmD4a3t3pH1DNpjeiE5aBqjeuFg?=
 =?us-ascii?Q?pqFe9A5cyu6a926je1mHq8YGEBe4YTXz/5ZeTzzebnrsvEVmGyOuk1EjEwis?=
 =?us-ascii?Q?vV90WukSECf6yl8FIFa3D6G0yx2349X1LsXj3QBHNQwr/cupJjo7vbAYBZIs?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb64f30e-14de-408b-53b7-08dab078133c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:44:59.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyWJBuniu+GNrCK27SlpJe+UjHoPA9PIVj2xUZF1zxhqhqV+chyOLiexpYODtONFkoWJ2E1fhYECvgV9iMNKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170113
X-Proofpoint-GUID: D6Hl7ionjuajXnW6wsRnf-pXPwmZ2LXk
X-Proofpoint-ORIG-GUID: D6Hl7ionjuajXnW6wsRnf-pXPwmZ2LXk
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

So run one more round of check via kern_addr_valid(). On architectures
that provide meaningful implementation, this line of check effectively
catches non-canonical pointers, etc.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c414a8d9f1ea..b38c12ef1e45 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -698,6 +698,9 @@ static const char *check_pointer_msg(const void *ptr)
 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
 		return "(efault)";
 
+	if (!kern_addr_valid((unsigned long)ptr))
+		return "(efault)";
+
 	return NULL;
 }
 
-- 
2.18.4

