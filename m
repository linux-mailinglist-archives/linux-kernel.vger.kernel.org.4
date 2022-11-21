Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC826321BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiKUMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKUMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:18:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7824595A1;
        Mon, 21 Nov 2022 04:18:13 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALBeq0u003036;
        Mon, 21 Nov 2022 12:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NLsv1fHThZWh2EUvAgvHPae1hTx8m5FuqgNioVJKix0=;
 b=OOh9oaM4XC2fJP64jWYQlW2jyjRCUUEh95sNsavNFROqVm6eaCQLAs0MnlaPBL2XI09Y
 n0aEMpxzda/PrITQ2Czs1oNe8P99/mR8M4023xJNTDnJTscN0P1JySKRJPo78sDlmOe9
 bEHZPfpE8jnQQ/Z4GEpmxFF0+m6Uj3lGTr8798xy4t6yHq8+rzRIbS19U8mXSYfj1pKM
 JQqzD13zSfT7fJDW1PNddQK2/mlFV0r1V7mGEYp0WFV4fvMJsceo/eTBkRrONSFarmFZ
 3QtsWTDFSV8lTUSumPoimqpwJAjSnZO3NSgS7SJ64LNzBss8TyIsxeZleHplS/KLdt3Y 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57ma6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 12:18:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALBjMA6039675;
        Mon, 21 Nov 2022 12:18:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9wkrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 12:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAUZHtAUNohaFK7odnTG2lqO3rqNwnUecuvBN/+UZi1OpjVYp7UfD/gfFYpslSWXVROGUtHqjXH1orRQ5lYFWl0QYXLtE32O0+Yd0ZiPp7OE9UV+UIJL7SqeaSKcxEqIiXpFV7eI7+KqVwcEyBZCtx2Ay6oGooqyDs00r1wM9Pv+gYKxCDKNQtWLHWoGywY3PoslwRcFLyg2/IpRmvRlOZBtzElkxy/ymFD4Kfk0L1z46XQoqS+6YaJWfasikE2GiZcRjxweK0lKOG187NUuLFDI3f07dwGcR9UVwAIPOUASRh46UW69/plF6PNy4h4CLT9ft1Uzit5ZzSyNsteOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLsv1fHThZWh2EUvAgvHPae1hTx8m5FuqgNioVJKix0=;
 b=c1CKAIzC3Wgh/yhb2fh1KbQxgnxqxwcyUgiR1htZK0JKGviDf4kZ0vs30rnagFzhIBFbefS9v99Wo6CgER7hFLxRsjwv+8OIV96AQDuJae/KUiq3c9q8uBf0t4L7cN+ByvDZlURzXyEFwtCIZvSrGhpawqy40OzMhVjtJew1hBw0Cn2wE1gmchiGOi7uPsFm8cOOGKULAFDAzwfkZI/gAfagxkGxy+gTsJEwWE/ykZ9y/t3zO9PUmlawkVoDojV2u+uTlI+bMkSqowrgCrk/jPvmtgDJ/CDT0LjnWxEUR8myk2bLcY8RbxD/JPTxEtK1ujy0Z95HK4WSeoZ7U5RiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLsv1fHThZWh2EUvAgvHPae1hTx8m5FuqgNioVJKix0=;
 b=M9w++h85RwKG4kgdU6sLZt5zcpg0s6SbZyTv1OG+NngsSnr5fTIYiCT027NlT+DPiyrkPsyl+FbziTOL/TOc4N3WhuAzS3MsZ3aphXmA4U2ZfNjWzxyXoAmyyUI7dzlAfbHRkClqSVT6xi4nQJbWF5keeOPlzV20RtvJ7RMAof8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 12:18:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 12:18:08 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] scsi: core: Use SCSI_SCAN_RESCAN in  __scsi_add_device()
Date:   Mon, 21 Nov 2022 12:17:24 +0000
Message-Id: <20221121121725.1910795-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221121121725.1910795-1-john.g.garry@oracle.com>
References: <20221121121725.1910795-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: a658f88b-e8c5-453d-b5bd-08dacbba7373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EK9/xpb1OngJmAct5R6txX3QLMGB9rHlj+9CTXvVaPxbhIx1UwPuMXtpwxQXn+l7pc+XcPGpAaGOevsW1C4oGEC7gYrqYa4t4PZqua4R/+M/YMb6z7ltDL+ogZkIbkcAnG0DuHaIxWm82xJgpQOI0skSijwbTU/553JCB3+yFs2bx/h2fhn17fZJ6Rcg1Qlq3HYHBPQJUcYlQCt+miLRqHwjWJZdDn3lN0h65TfKOp77tC+b6qGIL9tIPQQ5lQ3jugWBmuRyuMv2GJfeGuicpdTomTv0ff4fC4jmi61OpI5G3O2I12jJ1OAc6uJOMREwMlP1dNAZ1HOhP7pBIuztnunkhR6DVb4BPNABTn763xyytDyfmiL6Ks6V+Lpi8eUiSWzgQCjwLPCrgc6SQYaVJMU12mQfRf3J85eJ5U5k6i8472DnkxTLzwBesSSviyxm4R3auA+W0N9V8yHMO4cdROMbkFyTQenehEYo0OHRejXZ+EkJ7Ix+OLMqQqBakcIk+EVla97qKBc0Lki+HOxUWbrpYrWUrqf80m/qIeohUxWldiIXkj4Rn0sqHJ3gNZsn4SPxi5wP/HXZIm3Mt7LXiNKtmLKNIcI00V9VJLZsztulzI5/F69ZB4cPcFhVaonEQBGA7UlWSwurqgxyoUppQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(2906002)(66476007)(8936002)(4326008)(103116003)(41300700001)(6512007)(6506007)(26005)(6666004)(8676002)(86362001)(66556008)(66946007)(4744005)(5660300002)(36756003)(316002)(478600001)(38100700002)(6486002)(83380400001)(1076003)(186003)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p4PUuWBNTA44/Eby/QmnemjBzb9O5jtQRW6IB3FfLi5w+0EniQBiH8TH9BTh?=
 =?us-ascii?Q?c/NyqQ5nd1uyHULbMPujbIebKtXbKSQvrXzXjhgSB/5p+OcnLxN2zI7CWg4I?=
 =?us-ascii?Q?BqAuS/F2YZKclAkttWMqwIAXkQIk3bklHkKEvKG1XBOBsAIuj/hDbPVW6O/g?=
 =?us-ascii?Q?CXyaisSp7BaI5IQ2DvaVVkP7KUIAp6PyzIbdBJDsDcgx23NJeAsMbCz3WR5A?=
 =?us-ascii?Q?lgSn/RG8m300mDt5DgQiYoJ2YTNx4EMnq6WYYSJIPQJR+ptb+i0GjAZEOde9?=
 =?us-ascii?Q?lnhWy4mrJsH5dLOlgnRwW2iKtkKmfG8ObCnkcOiMghqu4zRBVr4W469oWSZH?=
 =?us-ascii?Q?DxmVSilXyuvEWbCcmOiul3bN7LE9h7U/Azee1Cy5cWn1OkmXoYbOFpYGmxNS?=
 =?us-ascii?Q?/36T+tEQn1r7iGA8lBj4Ox97r0+1nYLAVSEcABKh3WqcWStfMjDY/fI5fdLI?=
 =?us-ascii?Q?La9VZpGIy/Zl1H/jnhSYXIENTWp/jxXPB3GC5nKYDbb1la18R4OPOdf5fD2v?=
 =?us-ascii?Q?umLnIr+yf6b+c88kOui3l5us2xbkLaBs4X1k9mX47xzbF4+Q9Q4n+d4aKuxw?=
 =?us-ascii?Q?ODOPP69MDaWlukLtGSGnF8u+JKWB+fYfZBHNPw03F2BZo+7y01YX/hmEWYjX?=
 =?us-ascii?Q?jcpnxY5mwHnJgbk9z9FVh/Cf2ziQVXqqzy/TFBxnadGAWZbRP4/JIBzt6gAk?=
 =?us-ascii?Q?G0Nuz/6Ug6Dh157nPuJ0XVUxT65BCPMnpmvhL3vNI89HTW+w/LVbSdOxgN2T?=
 =?us-ascii?Q?bWJCJ9Eo9luhaGC9Jmtag6b9dIALcijIFvtnSEHFvCsLmLNEqRlvKB54JjHp?=
 =?us-ascii?Q?rDp3lMVBWKN/YVv2lQb2twMVJ8oo4UFtV9XfsdLdN6m2zLX6PVWA0t5+tNEt?=
 =?us-ascii?Q?Qr3rGkNSH1GzAXo8NQqLvPk6ZL4HyhjSFxo5tWQ3YUb9U6Do8BZlTrr5hWgh?=
 =?us-ascii?Q?CNxFI9TiLnE2I+CHkuSeZf6StqDA8V6s9YDh/wEM1XhouH21miRcYwKejmXp?=
 =?us-ascii?Q?rHZrMiR3VJ7M+9ZSK98pjy71S33+ROQVeNH8M8V2CsT3vdl2fS7CiTKaDSNe?=
 =?us-ascii?Q?KciTERbIXAkLala4XA81pdQ/+9xgQA+aDKXxVhKLhnGBgD5XLePh6KV/tHKE?=
 =?us-ascii?Q?3NhUOZI+r0GN69t75ja6j/xFhgu6fpiY3eXVCvhu0LwQ6XkGDy5rIGoThp1Y?=
 =?us-ascii?Q?qSWx3gmWfrYXOQjtQoc1EqTNB/PZpmkCTwMmS/FMWZ5X2IlZCUj4qW99B1Go?=
 =?us-ascii?Q?EGdC4mWkrf9b2wGbArL6IRLadGlxFujdxKpTVd+4ARUboMZLokdr1URoik65?=
 =?us-ascii?Q?R3aNlBcKSPQRpwS6IyOn+Ul83G87cxVM5DSypu2e0ZRAHU5nU+Sn5QgBgPWy?=
 =?us-ascii?Q?hfYk18qaZ/EYOaUklgQncU/T7ZFz9plahDItKmFu5MVyewgC+pxMX19pCtKb?=
 =?us-ascii?Q?7xZS7kX7Vb9od7j78uO0x7nnCj3r3IX5JSXx2je7LnYRpem9FKavs9H3tuyv?=
 =?us-ascii?Q?9OHl+/rtc4rdDxKHQFrUpCZNiYzAE1PLx9EErncYwRkWiyqhho43mDhkpms8?=
 =?us-ascii?Q?D2FSim3vmzE7BF1Yvj9YFRWunpRxokMLDRd1id9szF34uosD3XB71kgZtIyH?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9wkPhGa5abw4sjMce+2ub0b8fVLBMe9epcfjcnY/zJatP3v9N1VPj07fAUj8kaYoXtNEg51DpWsJ/MNlJlvxf5UGLaG3GeaF3CKd8mvBXjDyaY4VZ8eSQBT/T9csbRSeGyl3cC07X2VXDvQB/CCwue6Zii968mM1stjyU55u+BkRgfJ8hDIaBiZh7YY4CSkycyzjMRAsRcC8djBUJInC2tkXbEZL32LNcR8fhH7xv2XJ9lheZMyH8mMbZD5XVMeQ07nahDCX3IvfT6wQmKx+6/SSjAZWqlWNV497z85oKy9IAl7zoYE1S3Y3CTifNhTEjSr6VysaazCvO8DbrDZmpmETYsR8HcCN7Rq05CVy3PislNxy8CGpePIaPSLommpigCtPwLjLsFfJ6EfNa0d884lPEaKJa7XmCKVQ/ohSmhbodGegSOcrLcWcX8tas4+8+YM9OULIxs1cteEt0BO9gNlSRbisDdxTtMXgmL3KTXkNfJ9Omjvjpnp+J1biGo6YnTiPev/FT7Wwg3DhleRZOjrNnmiGzd76h1LuF/TxMRbf087yN7zxfrv9WwDfUbpRbyAzqLoHZnQpFlTkOPXPPTrPcyD7Qc9/KKTU9S8K0mhdcNzBSJiIhFr6OG3kYtxNh30vMsCEOMJC9pHQTVbJf4exAf8e8k7gjW3zIZ5B/6zniF3hdjH0UYQQxdIqFHESQyRXXx5l/tXAZ0zNZeEtWQLfiFzdZZox4lpcWWwsSHGyly+lbxxzNBsqAJf11dj5corTTj0EksW5Ripzk8elpsF2qKypu4iosVGF7H9DfaGsB+YkrumI7lVLYj8u0PlFsNZXTLjJUKzPcMK5ftTGzZLXO4PkYLfYz4IKJTjXjhlM3am4YNIdRbx/FG3FW/V3jkZsDael4be0IadtKiNYmw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a658f88b-e8c5-453d-b5bd-08dacbba7373
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 12:18:08.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udiAbAAifQOp3AVsVkHL7VITgLsrkzIJFwUJ91udyK5NVMgFDN6q3tufF6JFxvYsDrg/PdiIM1aQFYVYCkH+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210096
X-Proofpoint-ORIG-GUID: q04crLbWwK2Jm5QrnTSddTIlK98hJmRG
X-Proofpoint-GUID: q04crLbWwK2Jm5QrnTSddTIlK98hJmRG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using hardcoded '1' as the __scsi_add_device() ->
scsi_probe_and_add_lun() rescan arg, use proper macro SCSI_SCAN_RESCAN.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/scsi/scsi_scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 5d27f5196de6..6cc974b382c1 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1580,7 +1580,8 @@ struct scsi_device *__scsi_add_device(struct Scsi_Host *shost, uint channel,
 		scsi_complete_async_scans();
 
 	if (scsi_host_scan_allowed(shost) && scsi_autopm_get_host(shost) == 0) {
-		scsi_probe_and_add_lun(starget, lun, NULL, &sdev, 1, hostdata);
+		scsi_probe_and_add_lun(starget, lun, NULL, &sdev,
+				       SCSI_SCAN_RESCAN, hostdata);
 		scsi_autopm_put_host(shost);
 	}
 	mutex_unlock(&shost->scan_mutex);
-- 
2.35.3

