Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18356C63FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCWJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCWJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:46:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582224730;
        Thu, 23 Mar 2023 02:46:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5i64A005171;
        Thu, 23 Mar 2023 09:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CTPolVlOjH3rGDI7HOnmsS+cX2W5umFbzmjcwbFzghM=;
 b=sYcu5l6yZ8dgQMPToVMkgGAaFCQSnAomwKKQQizahGOwkSfN9UXsChKHBPerwN6pmIxc
 xzp9kzXW02eSn1SslB4cpuyRS6qbi6T1K3+4SbEVIJKjTZavuZOl1v0rqgE7QbNskkOS
 XFz3HNueGJ91eGuJ+K+ArzRvSacqY38KHXKSRsPq40UZt64dOwPCMkEAk+cf8XV5sl9U
 599a+Yo4/neI2kh9jduXNMTMGR0qWlkUGzVudxFXtfnS80du+Wc9PeGdRzyK7fED5+9Q
 wGQx08lzfz/OEMDzf1wVQKrtpSt6aHGX/bqm0FyYi0u/YM/pGU5T6ghESkYhUlQt0lUV 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdu3y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdi9006987;
        Thu, 23 Mar 2023 09:46:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpRBVKa30QZvMdgTPU1rGq0Pey07xHKGHNfjVomXbqr4tXNoBj09L8Tdi3V8kT3PzgYk3y9ScbdPuEap1HvzJVzbOGGKpvOxHnKULeZHn9biIrMGspTN6bK2OD//Vm7RnJP76LjJcWXJHnQ+JFiRJp8w9wCbPTVkGXDxTjEu7fWhOwLXX4T5uOFLh0aYUzR3kdRwuvjC/JImNaZdT6VH3BK7Z70cvas4jyUU/CiJBjnIDrhb+jpb7aiQfcKAPv5WH+mgXlBtBfIb+QL07vL33B1q+vjiTmwQHjq4OAB9K7n3z25RFUwApZ0XtbSI4c0F4TU7U9pPznj8WQbeAH/uSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTPolVlOjH3rGDI7HOnmsS+cX2W5umFbzmjcwbFzghM=;
 b=Rhz8JUyRENJgNsKb4iUL1n5p0fKbtLPSFKln/mJwRHD5reVXbzL259UooARRma58x2H+Xww5T9so3F9eNwcglNnFhzsTPhyE+mQSNwny2Kfv44OOLymjPM5ujIYRB08dZqS5ARyERQx4R7RuvW0d3h4t3cADGtKPg3otFv/1QTQbxdYSa0DiY6Rmfk0lDGVW+8t7d/SVlRZ5URCPKFtYgkTvG/uODwK3MTHwjFrtrTE1uZi/+KESxmnG4RVYZ5Yi6ls7blGMx9kyYMjxFYTEaLBNONZttos3vrCiYN4bVTw0N2L/T1Zb5YoW0poiT9/PlUmjlKXad3GRjIWDYhk2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTPolVlOjH3rGDI7HOnmsS+cX2W5umFbzmjcwbFzghM=;
 b=pCWvgerg5gklrgm9hm+c2dJSSuuIB/qhCzuGw0vyY/QKv+bLLNw4AhywjoTB+hCpAoXbr/vIbaYgHV8Dz8ZB/uQQ/ZfUi86F/6qSEbWT8kJ+WYLzA9qlNc22W1Uq9SV49aT0gJwdPliRyp3CXA9XTsUC8WlIIOKFW4pLGOiAQX0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:16 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/11] scsi: scsi_debug: Don't iter all shosts in clear_luns_changed_on_target()
Date:   Thu, 23 Mar 2023 09:45:46 +0000
Message-Id: <20230323094555.584624-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cfbf09-7556-4bde-4190-08db2b83722a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3U/BpSpSaYBgCQeRZZA7CR8xZcZSw04lpWZu+hJtrPdz+ThoY59GsDwi11hkX0QJidZ424A+CjD45NRi0kNS1tFOBIW9LrBPBS2Z1wN7yfiNdZEPBgxquZ9B/NtpiDaqb4enclYJRZsKpwsR24DJ/1GeZ/+gKN8eybhoCVvZmHGbj4KY8tjgYntm7Hc0NE3dFSgZkhZwpXjnBUDLahv/y4rtu/RhIpn2Cb9sLZhUpwBRWn5p8m12KuQofB1QUDHUF+yz8oG3KbQo0Lh2QVnRnELQd5zbLo9z73M1LvlhuHbLE34hevQT6hrMR4xTN/8+4YXfZFTqSR+EWaOWTr7X7XJf7Si9Vg/48SbRTUZ1pVjVyFdJRbRBMsvdbMxIY2kvfDToSxOjo8IfTxkZ5kyLPbWhhxuRCpC8bmHk2/ECxzcjJaafIZbimupKBntAkOvejeBq3iG35MvhXHc4/9JLRifHHg7Qylic/PM/9rmtyj5vdRwg93wv3woJfWqyV4d8FcRc8XQbhAZfAY28+PPlwzyFNrma2Qtgv9UAZeknWTDqJPff0NCdFVQdK+D2sWSUECxFRbRa+u3A4zwMrFftygOMWc11HYBauNvyRGz3fe4I12xbjmH+IOewEwJHHqRaoSzFj+Jd/6jI1xmIacCEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(6486002)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(107886003)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z3RB1RSghvF9+4ypGXaRDiBumtmBndHV47o1rH7bGHwCTSkt7r/phR9pK67r?=
 =?us-ascii?Q?MF3E1dmBiiv84/WutRzxOpwYGY0HFtpL4jbjg4iY+KQSdzO2WTJLeToZ/heK?=
 =?us-ascii?Q?xdXEFiZTn9rGgJv0OaTHeCFiBRJqPJh7eFhgkmMSQV819cxoMbrcfZ9cLwfp?=
 =?us-ascii?Q?j7KcM8XwKXyHrHbM5eL41C2ABRg5DVkswQBUp8e/ijuserFb6FaoLvhT4Bag?=
 =?us-ascii?Q?2WP3yHIS10lUEGAOxeemeA8jxxaW6nk9+biHT70QtGmJ4F9zUjpapPdhFRf9?=
 =?us-ascii?Q?Fds1O7kPZWY752CAamdwl0/Qo+jWJoiXFsoZ1nmDC3pMU1KCtZjq8iT2UM8E?=
 =?us-ascii?Q?A3pEJFZiOiExIjZ+rGkbzLWpbkpSvOL9DWvtY2xsDPGS4vQl4K7hsQGEBr8h?=
 =?us-ascii?Q?sFUggnlhb+lSHSVRfXK9/3Oc6A0G6JFfzvAixoINMiDl7HRTmEP2XlLij6Ha?=
 =?us-ascii?Q?JON8Sj1fYpnuHtSvlFK/Fnx6HJXN3tHWB8gYQ4bXKeH4RHz4bS5QGMPK67Ox?=
 =?us-ascii?Q?iuey+DRa3uhyHvp99ZkuiStN2afw0YJYRnq6I5ZS4v5zOK0L3GCMBe/XB+Vs?=
 =?us-ascii?Q?oNt+e2NJ1RX8EqpFndHw4CeoNzr4Wwm+ob3YEOWtYf0GkezZQdJ9riSv750q?=
 =?us-ascii?Q?rLeoIOo5wN1egnGXCXLpZ6GaNPLyNlQBAT78QR75iSdcVxmeWddpoE2cQBE3?=
 =?us-ascii?Q?wc0wc45yOVw/WQbHe6WlIHZXHoWjdNtBKwhXw8fDqQakqwQ1wLMHjC2lkAEc?=
 =?us-ascii?Q?vvzqf6tIdUKUdKLjih2EIP9blPOsW5xq/UbDW3KyKjugGuMRP98ea7f4LegL?=
 =?us-ascii?Q?PVESGQtSE1cn7uFmHVL4Qc8DsYIDys0OozxPl60/ILGgo30Bm7qkv3d6WvAg?=
 =?us-ascii?Q?8lANy5wJi8/wOejXoNLkeYpRfKna9Yep7wHCF91gtwd+bK6l2LrsjpWmR3oO?=
 =?us-ascii?Q?Lnu5j/lg0VCLMzIhdA/sraqiO52Vetq23RhwG3Kq4lqCi9Ux6fJCyZO6Ogr/?=
 =?us-ascii?Q?X6Uirz9AB2oKDp+5TARBB15JUW5FAJuB3WFwSNqWFADtjxyumdGv9dS5v8dU?=
 =?us-ascii?Q?YvSyluE3IeDVQoI9PSPRi8EHTJKkFEGknmfPb9/a48EbRIfYu+EqOgFhFXGY?=
 =?us-ascii?Q?s9GqmnVDZA0uGqxoIUMcw0tctL/3psVFSyV0VT2bB7BxwNIPFWK/5CYBjGxM?=
 =?us-ascii?Q?RuH+fRWjgszVS2plp1cE1YqhsFh46VCmIVvBudqPpRVR/Gfm6uyv4qOHLOwI?=
 =?us-ascii?Q?1ks2TRqXA8/djBoeG6hKbm+OhQjpDZ8LIeV7MIYhaXih7Gy+kymy+ZhDukmr?=
 =?us-ascii?Q?x1+cpfdebhp4c3Hm43qxieja1OBBa2jBC9HVBFr4d7ozue11Ug9eUUgxqOoW?=
 =?us-ascii?Q?nw65Tupf8DttFP04EPVWrbt+BHVzYGN4658vKE89tkL/u/ddxrozZYKNFcZz?=
 =?us-ascii?Q?gCzUIMFkjO86Ww/wT5HUfkDQF4ROTuB1e4hO7ZQUndgEw+gvnEbfmXR5hnfT?=
 =?us-ascii?Q?4CXXEvwPfFbZTr0mEC95UjhkK3BFRFjX252/5cBMM1yRV78tEUo13OSMEh18?=
 =?us-ascii?Q?GObdAs2bddgEj4N+CMVqxzmvFOJ3Lfq92F+T4AsM4usv/SdEr/kdNbGGoDiU?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gMNrDkwPKHGoscTw94npR4KBWc3b6gdCfXQ/S/KxW83geyxDcLjU3rqRn+eUK/4fckxUVf/5iuNMf8U3AwIefymQiJmVUj6HCp2RalEB4nduFE+lAYXuoIerbE8jxALFcZsAaqHSIpAyNq3J78gTNJh7WCZTNSK1wuVGvDVl8MOKyjgC1i4EYkiU/cdbRy9n6eepQh+7p9mQjzxShrfqcugfgvHA4nUBTP/BJhrF7wgmaFjFY9VUyhY1zg6G7yUWfG67UIMvmST95ouEnorfLagqy8lfQ2KuA0aoy7oj30uqqYO2V2hEggR6fmp6As5K6AvCXp7aoFJUX1dNrJTQ0whv1n/URu1uJ8k9XTo2HVDeaJq1EtnMIlM1sxLaa7jT/2zR3el7a68jKW0Yb6QHagNb/tY0ETPw2azdc9QkmzbgSuvZ/RhJgd6zmhheqGCyXEoHhOJcRXJ+f320I78pvG3E4xhVDcOEtUZjk6Mm0tbHN4ejg6soxGzmH+hTzyh5rr8nBNiceWndT8C9UPfnKY5afjytnJPywkP77n0JxxZVbiIRy91+8CJ1+3OpdqFy/QPO+KutXjI7oLpQtnRzxJNcFDg3T0PpUfmsLxtc2okcHtMYUonm51adFHW1SNpIlwsV8cfC2TrHiIycBYDYofIkpBQFNPgcTA0IMU1LmLbfR/vDk1bYkgwG1TMS5Ro2t4r92yA2c+JZiWgt+V1AuDWheoDcJ4CEadx1Yn1GKOhNvUlUb4XBmQSeQNvFDuDi93h+6aIJBSDVn2pLTGigwcbb5U5/NnUBBXzezarJ3xjkfkwi1cAyBXWMtpoHZ63Rf7ZOVdIm/RN3+YGLhUyatbZXMOolUaYYYJCFsGAdVBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cfbf09-7556-4bde-4190-08db2b83722a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:16.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU/hRZ/4WO43bdS27yo9nTlUBAP2pGSrUQ12lUCufG834J5+2H3nDGJP+EY8KM6Vn2mULdPkoJ5JohTHMxE16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-GUID: 5vdny6hxZAV0j8NsWSsZjItaXMAHCKb5
X-Proofpoint-ORIG-GUID: 5vdny6hxZAV0j8NsWSsZjItaXMAHCKb5
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clear_luns_changed_on_target(), we iter all devices for all shosts to
conditionally clear the SDEBUG_UA_LUNS_CHANGED flag in the per-device
uas_bm.

One condition to see whether we clear the flag is to test whether the host
for the device under consideration is the same as the matching device's
(devip) host. This check will only ever pass for devices for the same
shost, so only iter the devices for the matching device shost.

We can now drop the spinlock'ing of the sdebug_host_list_lock in the same
function. This will allow us to use a mutex instead of the spinlock for
the global shost lock, as clear_luns_changed_on_target() could be called
in non-blocking context, in scsi_debug_queuecommand() -> make_ua() ->
clear_luns_changed_on_target() (which is why required a spinlock).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 782515abca2c..eba6eca81e84 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1063,18 +1063,15 @@ static void all_config_cdb_len(void)
 
 static void clear_luns_changed_on_target(struct sdebug_dev_info *devip)
 {
-	struct sdebug_host_info *sdhp;
+	struct sdebug_host_info *sdhp = devip->sdbg_host;
 	struct sdebug_dev_info *dp;
 
-	spin_lock(&sdebug_host_list_lock);
-	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
-		list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
-			if ((devip->sdbg_host == dp->sdbg_host) &&
-			    (devip->target == dp->target))
-				clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
+	list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
+		if ((devip->sdbg_host == dp->sdbg_host) &&
+		    (devip->target == dp->target)) {
+			clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
 }
 
 static int make_ua(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
-- 
2.35.3

