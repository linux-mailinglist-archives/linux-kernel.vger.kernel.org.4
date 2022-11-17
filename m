Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2589462E406
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiKQSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiKQSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:23:19 -0500
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CA7FF2F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:23:17 -0800 (PST)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHn5iT027081;
        Thu, 17 Nov 2022 10:23:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=4ZPvwgnnjtZDDCVOpA449PvCyUyhPb7SwW0t+FMWDRQ=;
 b=tudP6RVGm6ac5AzqpfLXEKGXJPPZu1poPYEPmPhdQ7JQyKv59qBhwSNpy28A6wEBnp7o
 Ks8C+lVlLIz05NBpZGa25T0z/KAO2pEiqXmi5zm1xY0qkj0bkr+wY9XSQ7+KvtIsWi3G
 2aTxB9IYk/NMrp7yAiO8Azn2yP/W7chAL2Gp2GSoI/TR4vA3IJSMc7lUypNYoxJCfTrV
 4ENIQtXt9mD/AvGpwMnnKbPWyYkxNgoSzCJOCRhBpEKjkX3tWOUhgwc4NvGX4RyBV1kE
 p1bXtqEDFGr8FEiT46eGhVOcc3T/+QPSP7kF+1m+hTax9lbkAEffNfdiJUJGtNmncGmI wg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3kwbtjsryv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 10:23:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp/4AGgec0kh+jgOp8gc9Ssc3+VRnWOYflIWtXRXqjd1TqNC8Poend/0XgViCoi1TXEWcHH4/mV0HZxN0cWtG27isPSMERnRXbKxhTrBCfUYfzc1mgWz1aTYWs8Qswn9NC7rpc8RsP3Wc+PMUw/Fp5Qpn9Lui/rcvh4msohNhg4kj+xGg3YKA6HFk1hyKJX063EKGcg/3X4uTYs+ksFd4+cnQtVLnLvbnp+CBjbg0DsVfPxgFPG1LvmM7F2sbpDSG0aNhZi/2Hzai07/4EtwMHpSizbjJjcRSI3CpV5715WxTSpTvxFEtofZ6UvS2u/ZrZeY8D4gYit+uFKerqp1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZPvwgnnjtZDDCVOpA449PvCyUyhPb7SwW0t+FMWDRQ=;
 b=ltI3gAtV5qkjQcowDe7mHmTouo2wgun5zQmIya00qO5xPPTyBQjU7jkcXZAQQd9g7qRKwA3UvkWEaUM3r+SYx4s9MN0wN30fsAhAjscjmLsfM/QtBcX9hskXI3Ds0wjTQZrnabK/0IpFt3J2x0UVdc60d+rx6C+G7JBGLNjpbc65bEzXXh0MzeLuEltGGERWrU9S1RrKsALHCqqHdq4pnOU3BjaVQCfyl5xUxuJN493JSJuG5MUQMbCvY3xuKhg1WG99MbxRG8Md/Noa1711NXaL66NjmpzQ+au5CKwhqFWN0c8HyD6E2MfXNloU1TKrzvBKVHUe+pE+3kKNuOGtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZPvwgnnjtZDDCVOpA449PvCyUyhPb7SwW0t+FMWDRQ=;
 b=sdVwfMISaZkeBDblbmz9MHd2G2Rht2g3SHSVVCaX6obdNhC/xhDnvZC5c8QABsRsxtkSLRNCPIDbTNrWe4ILl8n/GXvRh5w1k+7IgOqffAR+tJfZJfZxDCqNgeIqEXMdOTAc9FYqFzpSiLpHWKf/RB/52m7Ec9smXWVbKNwT0ezh70mo1bUBS2y3U1ysKWccR6X8KqUAoIGosPJd1wSp6me5ip34r47Zp10mnwBcYHgKz1Z7f2S98NIHFHvNwNhGukrLOFtloj2+3SlQ/DcVq7Ko7oKlrD7Cpy1MH0kprpR7vmlnpsWCfm5GpdTY7qwus6GzEGPWPg6wx6miPybRQQ==
Received: from CH0PR02MB7964.namprd02.prod.outlook.com (2603:10b6:610:105::16)
 by SJ0PR02MB8676.namprd02.prod.outlook.com (2603:10b6:a03:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 18:23:04 +0000
Received: from CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::7bb8:3ebf:497c:17f]) by CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::7bb8:3ebf:497c:17f%7]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:23:04 +0000
From:   Jonathan Davies <jonathan.davies@nutanix.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mike Pagano <mpagano@gentoo.org>, Michal Marek <mmarek@suse.cz>,
        Jonathan Davies <jonathan.davies@nutanix.com>
Subject: [PATCH] scripts/show_delta: port to python3
Date:   Thu, 17 Nov 2022 18:22:40 +0000
Message-Id: <20221117182240.39104-1-jonathan.davies@nutanix.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::15) To CH0PR02MB7964.namprd02.prod.outlook.com
 (2603:10b6:610:105::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB7964:EE_|SJ0PR02MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ddcacc-8d45-4649-bf28-08dac8c8c461
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p5E4JmhJiz53U4yTAv8OlZj8Ifb78+8XNwvnw0a0lgl0R7FEN8ARBZaEW69oBnzm+3WIi/TX0w8QiHRHJQstQ9k1CHDq4MlPi3i7yUxL4wyWAE50JMUbuIrlWGTm/4vDLc5AAwnnlvJjrpQb6qJFQMn+NmZLmM2gVkFvGSiFedO1SNRMQ0dzkza9oa6eEJdx2Eh89YWFPTaYIYCZi/wm2MB8MB7JIHuqUXdxNWJS+AAhk+gKw2KFn1bYdXbp8rqiwP0qXi86/vhdtflYWgw/nHfGzH1CVSeigtJKJxIkCnlffTX/LmWNHH9lfNqf9HDRLa/dhgJjk3OwxVe2aCfxr2tDrKgYkheK55HutFBCpLd+1h80VJGnvAqmIONl9vUvK84RvwrzrV8KBVxxI16HOGMqAZNbO2MA8xLRqInCg/woBrCqEmgc49ilDvpujNCyMaDIOK2YTBFrx7WdQqp3EpzQE/5YAJGeQoRcTe4+RmfXNbl+l6VZIHhhuUfjwC6m5lreP+qTht05QuaUnzHr/LCCfXM9JX9r6SYa9IvcucxNGHQYZbp1dXEj7mLDoT/2mST5Atg39IYac8FLz8s8veTX4BkEF2uPpCZpP3RzSjuCcKiQd5kcAloLQ3A9fAtij7WBJ6iQxc/beaRZdumkKycgAQvhlZ5/0fm+lKbefiFp8uGkEDK/BWddWL2ORfhPNZ45xRr0I+C/RimW1ksXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7964.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(316002)(8676002)(66476007)(66556008)(26005)(4326008)(6512007)(41300700001)(52116002)(66946007)(2906002)(83380400001)(1076003)(5660300002)(2616005)(186003)(36756003)(44832011)(8936002)(38350700002)(38100700002)(478600001)(6506007)(107886003)(6916009)(6666004)(6486002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RrmiZPp8l565GjM5GIxKIi0i7ONNQS8iVuLKqxrubH0SjCLLpvqpO0zvxiD?=
 =?us-ascii?Q?v1pfe9GG2+4W/m/iXPhGVYp6lv3QQoXREMsSFMTfKx5bzfukzTS3l2pg6CEV?=
 =?us-ascii?Q?wl9+VbRcr5XHaUnid62Q88RqWuEsx/ppcX+l26EXmH42RahdtEJF9e9ooZ6M?=
 =?us-ascii?Q?OEppWiuZg6IdnRd1QKfXKhAVb/EzidFHbu8I4BYVnA6QH/8alTsUT7NFaxEO?=
 =?us-ascii?Q?mvS68cBiiFk1Wxujqfrm182IwOXQUNvOjbq1VVtdZL9nv8GyYIhlu8q82ZZ7?=
 =?us-ascii?Q?W+vKi0op4wCwxeIC7m/eYGm92ih7cqT2QzohuF1zRJ+c49C3sQK4Vpk72b9G?=
 =?us-ascii?Q?0Y2uorpbIFpezY3qU4NHcJC6H1dTnJ1/+KEwSbOtheyukzmPTw1GT+TQeIZr?=
 =?us-ascii?Q?AqQDqi5YAD5NAm2w8SQXp9zy6vlICAxY62JoHKUiWHseZrHzslFdug72b8CG?=
 =?us-ascii?Q?yQ9yyFxmFY4sE0ihhZ6Zj+5fv9Qm80z0tw2iUfl/oMN9D+4zXI5zK+Ly6Tor?=
 =?us-ascii?Q?C0I5xtlIGBy1moVHQI3x4fV/+Lo8G2Y+9fuAzIXdaCuX23Ucl6OPhlswKGeL?=
 =?us-ascii?Q?biyeAeaUwU0IX10TOBvfvp73s8a91h8/HSyR49h/Jbvbt+JQx0tffDfaPdFm?=
 =?us-ascii?Q?V8GW/xNtNS8Eps/CutvnHP1bDYhE5QS7Vp89q4I8zvJLYIWU5aJeHc6KKQON?=
 =?us-ascii?Q?eWyGV1Z8WqnV6BtwATC8qrzfMu2GXyKjxqilyf1PwUHCcsqiNjVTYZ6iYult?=
 =?us-ascii?Q?RuP1tI5c7dDDSL5GlikTtgt7TmWErgnglkvM1cJSumyBh/2zS07KKtQDDtIy?=
 =?us-ascii?Q?hTpUcd/iIUw+Z7XFEM1Uo/1ZLg9LN8qzLEls22QVfLvA8DRR61OxXCrk35Lr?=
 =?us-ascii?Q?4rxHICNdXi4sOnvGWAS/pXdAFGrAqrM+HFBT2LibOoqv6XhLJgqcyOAmeXXi?=
 =?us-ascii?Q?hx0vPj9AZkn7BZKS8CFngR+BfRojnU13tx7KXGcKrqIbqSym2IrIT6AhZdet?=
 =?us-ascii?Q?CP42IwIdQjlHlXTzqm72ofKk7qhSuFgOdxE2OR8VDWVPCqouojx/zIz5znq5?=
 =?us-ascii?Q?F2OXU3GiwTvH3lmj4bneKVMgZUOtsiGecMXf5+0wa25/ytQwwcBl9Y+gjq8d?=
 =?us-ascii?Q?sCYUHhePxzAK5Erwymz3tkNyDkP2TvoKowtmhTSu8DCrld8sCL6M5zLWF04U?=
 =?us-ascii?Q?dU//8xRJECY7h3rfBy146jA5NIBaop9Z+yCphZ91UF2FRbrsYq5Z9Edvn8ix?=
 =?us-ascii?Q?Lf89xhrTS4o+nLEgLrNfeITWqWkQcoii71aibR2aZ2DcgDfGSqJYGezIy5+1?=
 =?us-ascii?Q?8O39ijlCoGNR7V+6dSd+B47gNPvtDrivbt7Xu9vfpaOkbv9Mf7H6yX7HcZRI?=
 =?us-ascii?Q?qBmNg1oSkwVznGYHIgzJzWE1f1RwyUpb/CnnFkYbIpFlgxzHmpTMAlHOEwFS?=
 =?us-ascii?Q?Y6i4g3XB0esQvNGwrPKNdEbkTpAqw6YqDzOKDAO+W8dliIPbcMnjd10fbtLH?=
 =?us-ascii?Q?Dgr0mfdlWFgPs3xpSYnDjvRNxNGFpSkanCJVzA9xtGCAVOwFSMGXzMPjJrRk?=
 =?us-ascii?Q?HMoAqswerP8mQvTT0BoQ8XGBvV7CcIO9OlsTNnMjXwiz0uEgv4CCO1FTECq7?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ddcacc-8d45-4649-bf28-08dac8c8c461
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7964.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:23:04.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HjF2fmjMSpxyH4Gte+TxsOwi8eV3/LWSRlfQpmeI8eagPi2Lgf3xe6dT2lTIuSQhrMYGJkVr/nN1CwuptwiQJg0B/frZwKAoHkTtTUBFWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8676
X-Proofpoint-GUID: PbhMvOU3Cskf6vParM6xm9rVWAVGUJCR
X-Proofpoint-ORIG-GUID: PbhMvOU3Cskf6vParM6xm9rVWAVGUJCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although commit f29b5f3e6fc0 ("show_delta: Update script to support python
versions 2.5 through 3.3") claims that show_delta is python3-compatible, it
uses some functions that were removed in python3: string.split, string.atof
and string.find. Replace these with modern equivalents.

Also, to suppress newlines from print(), the 'end' parameter is now required.

With these changes, the script can be used under python3, so update the
shebang line to reflect this.

Signed-off-by: Jonathan Davies <jonathan.davies@nutanix.com>
---
 scripts/show_delta | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/show_delta b/scripts/show_delta
index 28e67e178194..10f0c9089611 100755
--- a/scripts/show_delta
+++ b/scripts/show_delta
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # show_deltas: Read list of printk messages instrumented with
@@ -46,8 +46,8 @@ def get_time(line):
 		raise ValueError
 
 	# split on closing bracket
-	(time_str, rest) = string.split(line[1:],']',1)
-	time = string.atof(time_str)
+	(time_str, rest) = line[1:].split(']', 1)
+	time = float(time_str)
 
 	#print "time=", time
 	return (time, rest)
@@ -111,7 +111,7 @@ def main():
 					(time, rest) = get_time(line)
 				except:
 					continue
-				if string.find(rest, base_str)==1:
+				if rest.find(base_str)==1:
 					base_time = time
 					found = 1
 					# stop at first match
@@ -123,6 +123,6 @@ def main():
 		base_time = 0.0
 
 	for line in lines:
-		print (convert_line(line, base_time),)
+		print (convert_line(line, base_time), end='')
 
 main()
-- 
2.34.1

