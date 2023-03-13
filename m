Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B56B729D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCMJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCMJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:31:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032E1EFEC;
        Mon, 13 Mar 2023 02:31:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D105p7014367;
        Mon, 13 Mar 2023 09:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ls6Eo1X9j6h+D+hYtYNKhPBOnQyjqpjONeX+CFfSem4=;
 b=XrzkAfQMJltlga3tgWE+C9rnP4E5VHrSdOR01P1BxB8S0tkhmHFQup4UC8VaAe4O2juU
 5Jdmonxj7LohozBKiwvyZPBp0fay7ZMBF5+YH2W4mVxusPSsayh/m/nJsfNEUTIBIfJ4
 3h2ZDTJWFNcg9/kZ1cX2RvLqAbS639c5twUrev5Th7Nwvzkr+58ITQxeY+eTVMQP+kNs
 rwj0WZlPIvfVP6SCgAuJskI6fgb/4V0JTEQQ7EjfsjI0dA3eJQ1e3hpx0lwvNDBqD+gu
 t2dW1oTzAMSn94uUt5ZAX6DotQK8IUow5s8YAhlr+1ii33h0aO6TcSPfOIy5UOL2ENFQ 6w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g2dkc9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D9TO78025159;
        Mon, 13 Mar 2023 09:31:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34d2e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO5buSSP8fmR429oSb2GSW2Uf6OgQ8JQ1Q7hxUEFJSIFnTDlNOYjggObblLPT7EfUoixcYzTBRAkuPpInsqLK88A53oFgHMVYpo5WLV/EQNfngsGo4E7yohqFN+cX/uLHQZilfRzY3hAe3Woyc+0X2WZ+9TkHNgaaDOi1S+bdqZfJGFRg+d6VxjMdEH6dPnIbDhEP4meXV+ylTBaRATrcrWqWS+jxWXnVJh6kZjmAzEALnDMcU6wcwNzh1xJ5D6sS9jjhOounRSfBmP0NZuixjsNvR8kHGNHU+0Qojhlopno2EN0NaFruAA0lNg0LT7Iiagfueic24AdQyzX4v2/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls6Eo1X9j6h+D+hYtYNKhPBOnQyjqpjONeX+CFfSem4=;
 b=ZACXNghWlsWvEAzGNQIsopN7O2RlWry++hk3KrF2KYzoJDtykI7bDA59K96AB5Uk75VctXB5K+zehOJa2rQHtj+sOfZsAqPlnGFFrQhVoTXrWkpXn/PGigf1AfH69+M+3zHTQMtOxli7XMqwI6KybrvXjQoTDUBoBinfl2yf4GDqWpCEEU6bOJAxrdsIgmB0IukV0400IQuqlkWpxuBN4Wd3c7aZyXbWNB6ahojsHKwAHrP3Nn7sk9Temly4zjd/xdOUkzQUdsSSQ++BhIrl/9HH3qJXA5L7INM94upH/nGjgCUbvcX8S58Ul3VBta3bDNPx1funffUkdPWOOULZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls6Eo1X9j6h+D+hYtYNKhPBOnQyjqpjONeX+CFfSem4=;
 b=NjU2RclpRY9ZicHj0ZYxBUDSfCHqTRg5yGxe8kbVMk78AYGJ8uuaJZW4bRpttcYUEq6Z664flhmJ4FL936Fhm5xF5FXdvB2l5TNls/1GM2vyB99iLbsH7ueslox0tKEjDmBXNP9pfhXNYDJI7GunDBqZDJghfEzw7YoQj/H7ELk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:31 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 03/11] scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
Date:   Mon, 13 Mar 2023 09:31:06 +0000
Message-Id: <20230313093114.1498305-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0373.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 6435751c-812b-440b-ce19-08db23a5badd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yM+/Tgo5uELOm45O9p0X1YxlxHnUOoNmKdWfY/Mt01K8GiZjZFgG6BxBkWlEKdnXyBkQWSwiPMQT9e7qNFZjzfBvmwPMvbaqReEr4yCWGnrL6e8vZ20OHl9f3DI4TH2/qDfvrhqSXKISPe5NH56MgKq9JDvCgzndUV/zPlJpYKbYnkHMK+fWQolRk6ZzacMN/kEjHui6nkxZzZb8mCZb1HiCbt08edPhnUO/LVpWrU8W14NWRNSkSTP1FUoVO8ADuu/krgmW1G4L4L6i49LzO/Y/ADnYcns0ZC3qbTnChPJPl/72oOqR5AqWUYK6rHv2U8cbaJhGUspa50Wz1K9JJxY1c6eiJijAZR7NUo9EmKHeU+ARzr0fH3E9gOFUXOMMTOtFaGyOHXJXNM3WEUtR7LQOLx8cbwvBnuUYRhoUyeCCXLeVbqYPl+8gSIGJVb5Eza9G8bcy5+ME5gyCK29J+R+WEYJJyqiRzvS4BwE0jV/sfb2vNqKBtwXBi6HKI9r4ZEecN1+xA7QX5Ki1nadH9zep/+iD8iBHh14s/y40L8y3vNsucwH9nnc0O65MDv2pOpGV5ab/VHTGcdi0n64/dSBONsadP91sWhwie18pcRTPKUcER1vZcPBxOYRfHi+9Mvhx3cS9U/qKxDPRIiAA7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGLkFR0EeGTGEmKg1x6eMCZSUh2JiuGWhcf0KUEV2eZ/8svKjaj3NMEuARXA?=
 =?us-ascii?Q?TiaGfMzJrqMsbZ5OdD8JQr9QRdg9l2jAXfph7crgAAf9sskPgZl2SQF8xhHv?=
 =?us-ascii?Q?C4W0JUEL7bbNsZbwhIFXPL9o6gaFX3Zc2MJQ0xZwgFDDcB8HwkAylHEwpb0B?=
 =?us-ascii?Q?aL/Yc3ZYH0vYyxlLGPRefHzl2AqUVeTI+RSIenEHTWeA6lByqNKvulAtg4xs?=
 =?us-ascii?Q?kNWi6B2/GGpZOhdeY0RpyBYzOrbpxhYm8mlRUVzF3GrUZmTaLTAtJl4SJ7cx?=
 =?us-ascii?Q?IF4NH4i8ak4Zj4KezQx198qxTHjMbi4TCffD9z1S6nvi49rJeY395ELHjnUp?=
 =?us-ascii?Q?I+e4pTU5daDYvLGU+VxaCZR5hhG7kcObCPXWHivEyYIVzSQTHlv7RLRqDfVs?=
 =?us-ascii?Q?twuOkohL/cwF2j6cgnPiIjqN3JraD2FZMHvgCvuubqODmFipw4dKTCUKUESJ?=
 =?us-ascii?Q?tkucU+OmNWijlwAmLTw9tioPa/d1n5/890CBclN0cGcpwWPCMZ3jmKpXb5of?=
 =?us-ascii?Q?7fkBybAuHCQe2KZIiFRAKVpAbpo6DhNdrnpwlnIgBlMzvSPKyqk4GkCG8nAY?=
 =?us-ascii?Q?djksRzAgi/SCxG/gvLrCoGwADzRrG6RB71MPp0wyQmHVB7ly8zIsuLHQDz8H?=
 =?us-ascii?Q?l+oPi6dUblG+Vdfg8xdupDD2/CGHOyKxs5E20uYAV5bPbRNLSgEGvzjQhNlE?=
 =?us-ascii?Q?jxqRdm2EEigxuDw8T867yb5gx7aJ5zWINRZgQOXFSGQBc6Dc/IZuQcJj7vEQ?=
 =?us-ascii?Q?FLreVKdLH7LMQwg+HLXOVacozitGl0w1E0YlQ+h2PfB/Q7YfqPfkJHqGfH16?=
 =?us-ascii?Q?bB9qqT0hSah3B5qjOa7VVINo6tPwjugIqdjPLBREE9fvw4o/YFCFOfWWllCw?=
 =?us-ascii?Q?VorOsdzsxqNSM+GmOusLuIkoWbzyGdcv41rJYK7Q2SPTYMoc2fBatpmPe5TW?=
 =?us-ascii?Q?TrDWdtmdnLSOCrcUnGZo7Ylw4J+7YdplH37h7TlEn+EjXWbWhiB/h/34gESa?=
 =?us-ascii?Q?6qg35WKzXqPmUSP7nEoNyKtSeT2itN1FdBJtb0tig3fTQgJu9c/d8RhcW/RC?=
 =?us-ascii?Q?19tzsLE+39ETnMxqsff6m5Mav3RgrerwwVimr58CHPyQl5XPju1z5n9JUCGw?=
 =?us-ascii?Q?W4MDuxJd/5E0hgQKvuieBk1ARgcnTQv0CtN658jDsMtL43C4F6H6n2EOQ/sc?=
 =?us-ascii?Q?Gvtt4s8z0tI3zYs9PhPlgjZRRTAovQKxuJIkyR0rPOY1Yksl+LwlzVkGu4D2?=
 =?us-ascii?Q?NAewtMYTiVcEP4B7/UQx8x7QpPTxMe33PItZ2qwuFowZFx64UZjEiY0kSy6X?=
 =?us-ascii?Q?aj7CbaTxytxNVi/yOzpMTEbh1gv0ksDOenThdt80Vz7SC9HHRMa+uf9AbIUY?=
 =?us-ascii?Q?0sMeh9npTFudvLYUm3QNZX8pthte+b07DXyOhBNQastjvRy8IkN9yTWSQ7Vq?=
 =?us-ascii?Q?JlOT9N7sjRLrGy58QaLCXPLanUjAmJOPDgdNdef70QVdo4VEnaRPUqpvCQw9?=
 =?us-ascii?Q?WkzGp13Nj2NaD6qVbCySVQmvIcPIuUQBe3HqBMzVjnGUmtOLHwi0ig3Fa2R1?=
 =?us-ascii?Q?XTuYiYqOtr+J1/znfVYbI6Vp6GNp3yov5GdoxYa8WuFZDghzR9upL2HCCXAa?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jn8ss1/aC7rAz+DYkJNiHdpCXRiQc1wd/ClxmP2uP/k2sBSmriC7Ce8T2nLaZ1tAX+5nfXTnt70lyo8DVxfI4fGr5D+UADgGN432zNCf/H6vqD6Q1MIag6gtpft4QUVzkx049+iWTbaj36KF+of3elf7174cWljhZT8Jg4IjRTmUCthyn+rFaNgs2oCpzc87TaTNvfiDa9UYicY0IzZNAY4bdsEUFKizxtOPfdZ0PaNBA4r7VGG/BaBggWD7nnGefA/gBHmiOAJGKxYQ1NOvLoHHbosLqHVQHxiJyWSTIv3eMGjebH4+lh6w1pNTiMnLkP7T9joqwrIg8cXSJG2PLh5HysPJatwQmfFDy0VBRl48hbRYDVTUd0+bkAYaHis4ZgzVIoAmLeJ3eZiv+bpYdYBMbI6K47l+sQE/ZWx66INgP50u02pZua8eGt1qTm1UFx78yOjdPOBXfJRQID8DDYLJH9vjwzSuMBqqQU+gDHgDpNHeitF0DmDQPbmNYAzogal+F23b7i/Gds6rfGdYWo6uGr8mZzMIdhgihxlCA/yISvR/r7JfPU84HNY+f7OJ65XG9g2Pz+BBO+ctFMpbFCOFS+nEMUwAQ24zxRV72iE1rrY98tBo1AEXUZd2BemNhBYu0qK6KJ5ckXZnouU4CR+DodFGvJVNw084jbfcf3/rtjGI0jdS7RBmc+vCQzliA44JfXbUvaNPIyfxE416GJXe80vALmWBRtX+CQLb7lSrAn1iyjFspxNw428AVSaqpF/fd4ll81EZRwxDtn8jUg3AvIw/yLXhmGZ5NCveuRwKyaVbVTj2JsdLTkeaKHl4mglPxnrt72gaX10Q4e2A5reSVvahuxNKN7O5TQJrn5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6435751c-812b-440b-ce19-08db23a5badd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:31.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c02aMqbPmCaBdn8bb6zdFs4uBdQfupKaiXWPOxZ0EG0LkcEsmw6H0xFXqWSu5HCiCp7XgpmXbGzD/hSwFOF5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-GUID: zt0XdEMowFbyx7_w2JKmwrin3L_f3gBX
X-Proofpoint-ORIG-GUID: zt0XdEMowFbyx7_w2JKmwrin3L_f3gBX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCSI cmnd pointer arg would never be NULL, so drop the check. In
addition, its SCSI device pointer would never be NULL.

The only caller is scsi_send_eh_cmnd() -> scsi_abort_eh_cmnd() ->
scsi_try_to_abort_cmd() -> scsi_try_to_abort_cmd(), and in the origin of
that chain those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 4c60a055610a..2c2a41b99641 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5360,13 +5360,13 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 	bool ok;
 
 	++num_aborts;
-	if (SCpnt) {
-		ok = stop_queued_cmnd(SCpnt);
-		if (SCpnt->device && (SDEBUG_OPT_ALL_NOISE & sdebug_opts))
-			sdev_printk(KERN_INFO, SCpnt->device,
-				    "%s: command%s found\n", __func__,
-				    ok ? "" : " not");
-	}
+
+	ok = stop_queued_cmnd(SCpnt);
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
+		sdev_printk(KERN_INFO, SCpnt->device,
+			    "%s: command%s found\n", __func__,
+			    ok ? "" : " not");
+
 	return SUCCESS;
 }
 
-- 
2.35.3

