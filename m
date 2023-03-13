Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D76B72A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCMJdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCMJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:32:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3753D96;
        Mon, 13 Mar 2023 02:31:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMo832004881;
        Mon, 13 Mar 2023 09:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JT0I1lmBwY2/I26xELUpQi/FnxBeftdM885RAyK68YI=;
 b=Zf60wYcVpeba03dA6L0eUIylZSpPuEDoXAA+li9wp76HHmj6SiyD4FxJV7qOnFVZ3rS5
 KJGvEyqLi/BzyZYXnP2mGPULC8i3cpmXG2e0WUjXFbK8vTMGIh4U1v6iGpaam1bwWGjP
 pNI6kiEzgYHQF5CflDERUluT4zjn1NU/oBsS/kFqkrl2SKM+hKxIWBrGh6zXTlzAoIFL
 YPOu9dN/xpOMvcuk0aZslbe8n+i6er9ZxNGoqezSOVJNBk0z4R5Tk83qssfqK9bhJiHS
 Yut88J2QhxttId2SVo0bYrVqIOZDJ8aD+DnV/DfXxVhDXuge9oe61TZMhQjx7GECF5D6 nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u3b6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7v6bO002392;
        Mon, 13 Mar 2023 09:31:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3awer7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+FvIMMBEs2JsS9iCXVLe78lLwEhb2j8rtm3ut7AbxYlJP2wkaKU8XhCUX9DYPbVrXq9ETdxAknbRJ/a6KV/q8KA69joIW1Tk8VgZFPKcwI/in2PXWVMP+pyZ4Bha4lhkrVwa7nwuWaQEg6Ug6FwdWwBtgZcVwtXthZsSeCiYFLkY+Vl+jHnFV2fPjrLg3Eu0wueMkldHdGKR8bmrjWMHnC0MuUw3nKLx9RJ1AKxQdg9QQ2itSkbxzBQWCrIEfiyMo8EbIvAgIauaM5txy1tROHVELwzxrYyK4/EaH+YFcvRwPmbh4ywjPui2y863J9PMlco/a9eJJNDayFoQkQa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT0I1lmBwY2/I26xELUpQi/FnxBeftdM885RAyK68YI=;
 b=mi7b+oRU8A3aEOwoE7pIzNheDitUoBT98ziY+I7rJT42FXLHUXlwL3uqIcrkRZofV6MWNTpVRtvx2QYvOxX6hw32nSXZ5/xdEKn9jwUr3CV0PzCUA4je7E3jG6BK4ipp9ZkdPYv00AiaFDWuRC9X1Xpt0vtvqCqwMKvBR/GOwVssjXH0dsnVnjb0Q/45OtDLgtV+qIfAgzX3pNw6LxyjllSuelsc4Ol619rrn5XF8Qhwckkcolul5Y19aPmi5uuccOUxWC2c64S4hq1eYdh60ow2HHwZh6fUpz5MgOMMa5JtITDEv6bhP0/bvC5JXHQ/lDg9ttyOz2fEyUk+CXcvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT0I1lmBwY2/I26xELUpQi/FnxBeftdM885RAyK68YI=;
 b=wnQhRW9c7Qj3dMtacreo/v9NgVgBQclkgF0Npnc2yOVrY8r9O4ZijireAAUBs9lcHq3N8Hb0HxgooiRcdfjIcNInWUjlrXYEhAQEhZbAiUP49Tzd/mM5Qnh/fug+iX8HksMhrcxDVHr+yD0XwsnoDhpJOT264jFcpWAg682cc9o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:47 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 07/11] scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer check
Date:   Mon, 13 Mar 2023 09:31:10 +0000
Message-Id: <20230313093114.1498305-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0682.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: aacc9396-bd30-4d3b-0fc7-08db23a5c46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVJoFjCLM5mB5X+rppvplF3hZpogxm/LyOGoSPNtDYDF4+hVkT6Z1vuIITrG9LOFDwII78jqMprE0Bb7RsSZAiUjLedFUmsHyQuajzogWdZ5NYt8b31oIydljOXZyg/zI3PdaK89NLsZhUbVgALRqzU9wCYH3Eh6zvUBi/HmTV/EDpICPUE2Yq7JKVRKy2PolV8r+E5XVL3F+u7x0fkciBwqr/tXZpp6sC8bXhiup8QlR4PJ0CKdCDKq24KDZ+VZh017kgJttyfrvHn3UbTnQrTRror4F3EL62bxIYnVQJvj/H4rz3APv9pD2l1/ZOV8yD29865e+AgTzni0Wiqf+k6QtpbOSxyBYmI6aIB3u0pO35se2ktuVsQA18I7lx6dCHsK836LjM2wQzPKT5r5174lNKgvwkRIMRMREdyzRxYe6Y7f8XLuiMxikmClrCSjiUtW6E/kkrIwVtwLMtl4q+MMtP540I/Jvad/vS+0Ov6c8oU+goUi6sM8QTFU+XeFS+0Q0clAKCeKd71gYshszm70wDeiQhWY7JWnpYXc6jSetjfU0YPi4OXeLYZH1wsanvPXUosWmnS//4At1SEGrcfDq0Y55Q6VMjPu5r8QteWThe3fSsrlTu1yPL2Df3SSQW+1twurplvc2dDFtQ8LhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHAe0pSjkfL25HxWv5SjmWlElu7nvta/dTiCqUm/xRY5vElGbFR/+DPi3qIh?=
 =?us-ascii?Q?1b5aFiBpmDM6MnptZ4TbACxwliR0rdJmV/OfV9kKjUDzS3BmxOE6EBstbita?=
 =?us-ascii?Q?+1/fKVHBU74mXsfCPYEWGDAyxY6UFoJuseTAlZjpzvVzO4LM0Zctck4KnSVf?=
 =?us-ascii?Q?6TJZGPvBJtD5TzjMV3tIARHcx86WcFNmmd1tV7Y4ht01quGbBtOMsdCXdYd2?=
 =?us-ascii?Q?eNWdDb0vYJnstx4LvTyGsL93u8KFgKAuOGIDyR8cJNovMhHrs8zcdZ25DirW?=
 =?us-ascii?Q?M2zCJbDF9J6z1f/ZETq1nREu9jDXC4d+6jdWkSAyunAOVI1RiR4+uH3jZiN8?=
 =?us-ascii?Q?UWfA9bpFjjmgTlOwVi568hPI2kLPeNo9sAX1BxGXo7SDwehEqF847KwXSeRd?=
 =?us-ascii?Q?UZjxD1JlB2GcwinlgL/PZfpTP7ildGbu3QCd3sjMZVtg2Ba+IUXsjak2ftyj?=
 =?us-ascii?Q?pvWT9fuYTtFDDsDeOJiauHJOz9OzKhNjMhiOIYeLCWqkLljMXHgLMDXrMUCv?=
 =?us-ascii?Q?qF/pad5PIALnuOsE1fxouFNDiWYtw8IEyK6jFNYrOg5eP1dpCWIJ7OxlEbuW?=
 =?us-ascii?Q?dySe2v30cj6fe6qi4sGZKVX8cWbRvJzLrpQ3owcl/eHIiz4uEAjUaEmZJnCc?=
 =?us-ascii?Q?1G5Q03PkaV3AQCV7ZEZY258I16UoD2KIc7xuRtlbbpSWeYTeOpdE47cYGPIs?=
 =?us-ascii?Q?wF9iawG7fI1aRF46LnGlAhsvtLSJ5zJeFWi0MtgSOB5bH75P/twfFTQzpX3E?=
 =?us-ascii?Q?kYEKaNZ5Ef256kYGSkFQ1d5IwPOUd25Gqhbzx6tU2sE4JtVabklhDVNeD4qX?=
 =?us-ascii?Q?W5VBL5EXEhF8XTOrf75LQbQ4G4ELq5MmHIsMUx2QzxNH5YrZWob0Y2FFj4pZ?=
 =?us-ascii?Q?dj4AaJjOykGk7BNlsNGxoUruIrXK5343ozQsH33z4vlm5GA5oz7KLkSy/cUN?=
 =?us-ascii?Q?hOzgoUBJs3l4EZ0nS38aZfO8K9Y+5UM2dErZJJN6hpMQqXcIwVg9lQ6ZkHVB?=
 =?us-ascii?Q?qI1EA6J48apC0SnRyxalOXBw9JZ+4xrtud1cfA6eF8g/05N8ZuwOyscSMBko?=
 =?us-ascii?Q?A6AzHFc22EMiimWGwLEVq1lnKzs06cZMQwAOtoxaAIYgGCvErYr3cvQx+ZlD?=
 =?us-ascii?Q?2KyYGlR09iFso45WN5q5zCXofVDI0rAKu3vv6R0G/rXBc0kPsKaNDds/UTyn?=
 =?us-ascii?Q?G0dQjMYFjrWuaju3ISvR7QtIEfqYDrZQEGj5KIjAm/gMtGfv2SKJ437a0Ivt?=
 =?us-ascii?Q?pk/KCrF/u7ErU4lq6RlQTYq5rvPtqOTazshzzrbxxygyuFXM/rF9pPIjYncm?=
 =?us-ascii?Q?LF3J3+g9KGhQWMTPC6GyqjVd545JthTtITSlXxlb3YODmdy/HpX4o4UIEXxI?=
 =?us-ascii?Q?X/KMfmS545u9Js/T3ueRa5B4qGhW35suSgSrUE05PrWWnBegNOGUxoH8Jqa/?=
 =?us-ascii?Q?mkF3Hg7jjEafwg1+wqz9rZc7j47QLW38mdz/m2/Ju5WZZ27z5dxMqpksIWHG?=
 =?us-ascii?Q?C82bio0nQtnkHdKhucD+1pRqiUbhtHc5gbzEtKb50eOv6Lcb2AgP5H3BFRKi?=
 =?us-ascii?Q?xZmBNUnum2WeK1/0zmEdP61xCNUDeML/hP/IwICPHLjf59x8UFk0QxZGF9O9?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EitnohmxqzyCSGELNlNeM3B0i8/Eo+OZload++aiUfErtEsgI1xPeU1jCr0NV5m6CDba/MOXJD4ILqhGdWIqvXpM8ZguYjIfj5oPO65/abty/MNcaDwTf8ZTyIfEyAjy59xWoWCp5b1iCvEnwG3wOoKTvQplg6N9sulBHKKTF/pMCW8LNBXoPVLfgES1wAVYQ64sMqRoF/aMb/eJeqB6fj6CbKW/mj/EFQPzJ8Vico/lhe4SxLxMlF9ynJ3prOKhz9+H+mmIdrzuM0KisfbyBWLtZLpPs3zazscpR/+aFdYzmEpuWyJu7GYw3xLJ3uNvbAmHDp40gi3ISnZL9NkMY4Tbi+2yYOtsY3B5lev/16gekunh4CRJzT2vg1k8JFeV86Y9W9I6bCI4UVAe+9DOzymN3aZTVUXbVYtbmmNrnyXe5D5She6zKUVFklNZHV1M2BlI39uhXtK+fDeSEKQuEMqMK9Nr85BeUQJQY44HoWWRfbxjkKteS/yUvHCwfbMCQr6yyZ8bgJF58Bq0RfVgCcnOAsVI2sABYgECS4fYTMgyUPGTR53tywpowH5tHQV6R0U6Iwy/0QRdXsUeTMeORIb9ixiEx1tMa92+CPlvCbkjqCHY9WNqeFPUCtH+CgIHaguscPUL9VRjzrcpuaqTaB+Z4XrPQP100fXHxKE54XVHpvxvVyq6v8rqbEdJrLtCM5nV9DPZAer9hQEaAOI8V5sInjfDAwm3GBg/v7a9Yf1P/lRX9+nynix76fWPYkxKLdVJVKgLTnwbyipORBBm9UQSo50sKn1z/SiTp8tA+WnmzED6drsbod9MJIpDOVTyDpkQSYELA3Bk1Rr0PqEgUtCbcg95hPCLh2xAP1D4Abk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc9396-bd30-4d3b-0fc7-08db23a5c46c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:47.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhudysfflbxL1t0htYilXv0zP+JwL2wxmB/flFdMn0iVCC0NaSK9FcRkAsd7sYILgYlEL3lsNfrJ6PeHwkusMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-GUID: OqJSCrVDfQRIQlztVg8oyO1jE88XGOW0
X-Proofpoint-ORIG-GUID: OqJSCrVDfQRIQlztVg8oyO1jE88XGOW0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for device pointer for the SCSI command is unnecessary, so drop
it.

The only caller is scsi_try_host_reset() -> eh_host_reset_handler(),
and there that pointer cannot be NULL.

Indeed, there is already code later in the same function which does not
check the device pointer for the SCSI command.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 749358b48335..47820b9f6326 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5440,7 +5440,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 	int k = 0;
 
 	++num_host_resets;
-	if ((SCpnt->device) && (SDEBUG_OPT_ALL_NOISE & sdebug_opts))
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device, "%s\n", __func__);
 	spin_lock(&sdebug_host_list_lock);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
-- 
2.35.3

