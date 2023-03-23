Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DA6C6404
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCWJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCWJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:48:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFC26C0E;
        Thu, 23 Mar 2023 02:47:05 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5hncE019250;
        Thu, 23 Mar 2023 09:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=89hlhwavpoRCxdyyerkjcxBDKORDxXA2jkte/ztT5V4=;
 b=S0dmYK+z8t79pcc/1k8Jqe6csJuqScTUkKvFLeb3wbS7nZFQwujNmGjIEC77mA4LmdTW
 GY8F9s55t+ZnSWY0FqAaxmX3Qncjpadr66Zd0ec9ipeTawSxbp27zxFuEwz6bodyiJ/o
 o4TAok8h6slnG3ljNfW/VpaMBcfTsUD7WX9IXf1jInoJmFiva1PUorLlWFqP0o+8ZVcn
 BxXZ4+BpXFQ41hPWCO0jpakO7bEmVmndZANddun3yiSXcGZtf4fVMskvqhyc2xsV7Ols
 +SnWTgHboORzqJvDCsjlGNr84JLtYp3TAGe0ztb7S7Ae5vM7JU1oKSPAok67u7ErNdKB tA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bckbpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N9cdi8006987;
        Thu, 23 Mar 2023 09:46:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgmamg7ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 09:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9S3XvMiHnIvcK8HB2SaqkM04PywFHAIy8Zmojf0y7m/gYq4ks0BDPIWmW4pKDAxcUQ5HTk3ZWXsp5OZV3XtuQjzaLIukdxdSfxOE72bjtBNyHGLyGtV7sB8fLmVwlpYZfRFPrrAjL+IM7jM12zBNt93HbVyxSJrJf960dpB/yCdVqrhZu7SOpBBlbD5J104/A8spojhhCFDaMVZm2uGluNIZkz6KhZ5rBKgrjL6E/gL7xozxrt/cYSCXmwbRG6QzLLQkIdEVGnj9Mc5ACVMjPbYbbjipUmqp/dkvlPs1CGnWymVM/3MXEmbh59WZ67KW1ZT1sNNXXawyTw9+O6WIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89hlhwavpoRCxdyyerkjcxBDKORDxXA2jkte/ztT5V4=;
 b=PPgPSCc4bFVtdoiHmUrWzmBdXa5k4CoFNP3mL3MlvnBKtkbg8BQCFYOBcY/2fApu1ig8w3SKcpAJo2sLRArcgnb/7Q/36kETsWN4aNbqe9V7B+8Z9r764o/6adB83XHIr/NjcU9YKhjQ47d8neDF6B45vbb1LenI4vw9zzeQ/M502X+ENPPqQR0Vl5fGqKP93hH2nmtFXF8g7Ijx04MRVexgIBPbCg/oBI5+orNWet9/Dpj6vggiWOv64qQAyUEDSz0SR38QMNmdni7NMkyntfjZiGRSj/reN2ZK/SLXsiAuUQEsI/9F6F5UNS744MAjuBrK9fpv1ZgW/U8O7YHATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89hlhwavpoRCxdyyerkjcxBDKORDxXA2jkte/ztT5V4=;
 b=FFq6XxNQh5DD5G88JcPsS0pd0cV6ICpDIA7jwCEOZBQEwvjlS8edAalTLBEAd8eOv2UH5CdNL/ffUseJTYz1HfF4eBZVQ7WD0bjOIuhZfumh4vrgMHyDFzJED4pTg2rDbKoF6rZYm+8en+0T+lQ1O3wE+axHLq12E5wehSsB6eI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 09:46:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 09:46:14 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 01/11] scsi: scsi_debug: Fix check for sdev queue full
Date:   Thu, 23 Mar 2023 09:45:45 +0000
Message-Id: <20230323094555.584624-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323094555.584624-1-john.g.garry@oracle.com>
References: <20230323094555.584624-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:8:2a::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: b70293ec-d926-433d-b941-08db2b837134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pj+qktmDauDKmDGEh8dn5QxbBsuWBqVix0c+0PcJSznVUYFu/Egqmc2fU+jrcyOhqAe1sTh4HPcqpp4rCalHdOYBecWw94rMgRFyfaKg+u4cIeBAiO6tiBDZDnBw1gB6oIK2jpXYBA4RKc0g5LRWWgN5LsYVzNub126UJWHuEepiV0BMqNvoeT3lIUhQpRQiH1rD5bo1kVkvTYOTeRDz3u0/ntzFiU15e4qrwAZLq9FeWLEtowIQMhGO/eBNRrG0wbDBjJCTGGk7j76Kw+rBt1hkJmZc6mAMhCnSc4wz64wqMV/lTh3aA8kO5Vw9hewih/BPq5Ku2Z/nTZLLrB0j3AqAAeLtWC3EoDB/mwVeokOO8Tor2AG10M7QoAzEfXmg5v+fZBoKDZyxCXZgOMLoBAORwuVKUmBagHMsjQpc8cPDdLtNW9RJZsgNjbBEpQHK8X06U8AL5HDIgiRn/3Nj0wHzgQmmkR42IlbKhhTaXVoJa+yqUd0JFM3v6nXGVhKhBwXAixoB8UJsONPQ9V8/7D4PizAx+S3KsxvB2IhRhIG5Xc7KYsOaemPUn9SA9w3T1XBcWD+C4a6xzK52pAeyNuQTbu7IdluTJVNaIzuKtGfyhJ75zsUyO8FMYiMyROSq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(966005)(6486002)(54906003)(316002)(5660300002)(2616005)(8936002)(83380400001)(26005)(103116003)(41300700001)(478600001)(86362001)(38100700002)(2906002)(36756003)(4326008)(6506007)(66476007)(186003)(66556008)(6666004)(66946007)(1076003)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+1ZP/RP9wBYBO0SfaqCMNIq6J6E8uP0Kv+cJV+8+vE0YNcmRE33eVSuBm/DP?=
 =?us-ascii?Q?FJblnsyvO8ELLKZFxm5NXZGJLZ0i6Mjam/AnXqK5FkUsDBRGR8n6ha5V8Gdc?=
 =?us-ascii?Q?IlY431qFRsEseid5be3SJ1VDzOwfVIGYDfF6NZpnlKbdfRuN9j0gaRm+nMZd?=
 =?us-ascii?Q?Ibv4G2muMKqhiqfGVAqD4BRvJha73kg3vpaUpPBgPYwyhD34ruRoO1IpLa9U?=
 =?us-ascii?Q?sTcDlHtL9AOr3jsDxgVnOhKvdnlyKKllY6gD9p+/puy9KSQDWE4ltwCOQAfs?=
 =?us-ascii?Q?ldEIya6g7aqoErtBQiVRJlL22uYpMyD0iUBYF1MtyTPBYv30nPaLL9zenNWa?=
 =?us-ascii?Q?kehJtdPEKo20QQL/rG7uombPA4BHMoOqF8Eh5GUJ+RSS6YRKAZ7JodpkxIG6?=
 =?us-ascii?Q?ubl3cu3+3WaWv8tnj9VLFjZatNiF56BqA2DJsq4WSbAKmwgJvkQ1cKvgiVn7?=
 =?us-ascii?Q?tmCWxEY+FPDrPto60srilc4qzbMbbACHjvOixavSkpkB7TPuib/27YSjD2aJ?=
 =?us-ascii?Q?LrG3Ez+VKHHmxBoUBG/0zP1XhNVQQ8ufdc3JpprcxYtp5L6PGV+1uAbL1cyM?=
 =?us-ascii?Q?r9N2myNGo/0PfK3nZLVzb+QMzVwvg3Du/b2K0CPmJ6znT6w4eukWse1UFV4p?=
 =?us-ascii?Q?tryWvRtGZ+SHKZ3pWMv4/pQQAOj89FVZ7QYRTRvZuhqNtP3jrv9ovUxlLQje?=
 =?us-ascii?Q?alT+YCpRzGq52MAmv8DAQ1rOaxDjt2sP9xs0wQda2Y88D78XBofSvEx4wyOO?=
 =?us-ascii?Q?TUI83JyYoVSoVfXCK6mp4ZvuTZSxFC+GRShBxxroy0VWqZePVaMFqFLvHtqA?=
 =?us-ascii?Q?S0TuiD1mp2XuvWGNo8DmI3JsQOrBy7zs6ZpQ8KqeHTaxh3jFhck/BBfvKj6O?=
 =?us-ascii?Q?kJycJAYtQewMwpRcF72WUADc2ZvG9beA6e9bbDO5vfa3cozz6waDuBkCLtGD?=
 =?us-ascii?Q?xK4GUiNCcHueum8ryRUzztamRmP+/Oc3GMY2c5vptx4PBTzIdic9hBTW3beP?=
 =?us-ascii?Q?w8KJ2mhHbdZP3EpRiVBZIuT+YicupRj20tpEQdMWkLtKnVqQwrirRkRiWqgf?=
 =?us-ascii?Q?/BOApKIcxIA533QX83SdhvEg6mRgnDqvJ0y5DOeG14D3gYcB9QOZ0qd3IoUD?=
 =?us-ascii?Q?6+U3PShp1mAqiRMbcKc4ej+ITkDgw1Plr+/4rKrkSOUf1oUlrkCrs5i8wXPl?=
 =?us-ascii?Q?DpX5J5vyFUz9CeEyDVry/lykpJatKnCdem5ALi1JQzQe+RqgdRHN5zCPRe7D?=
 =?us-ascii?Q?ozU12vgu12NRH/Z2TOIjgbbvh36hAwz/buiZ1pvaOskWB823kMeDyLimp3Dt?=
 =?us-ascii?Q?nRl8gUZcfE2OJlnD/9lGudL3gsdTojSLOPtiOwrY+BeUVOPBiKRnRQk5xCkC?=
 =?us-ascii?Q?YtwAAD7yYVMTeZPT6RNS1vhHYTPY54rcSaPc43U/CfS81dTXxygjG9k3WZec?=
 =?us-ascii?Q?9bXcMOMSDcm2/j1rTqSHN0BJOrf5PBtFKTeeFk8MWXdv7HYZpUGgJQxhnH1G?=
 =?us-ascii?Q?JhK7m5Arx6UagZQ+8+TjXZhuSU8w+a0W9tmCc1U7Be2eyVs7RQIOvMMtirNn?=
 =?us-ascii?Q?K9PnrtzanHwC3f0+U/s79DNwsRfG6UpRSMLgYgC0K3lfzgesAOiU6IsTcaf1?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X933wSTJHCYLM5nvmdB+qCdfiaAf44BMMA0caDF+ZGaUoJpygyiSiF2sv2t0lIRyXVP9LzGg3QNMNT2bz+bq+5JHkHKPQbxMFqiI0/5ohJMTSKwctmEBqN/HdlzFniSDeeFN1u+mCPsQ6yAscg4U6cSHkxNx/atlgdzifWRLM4lbxPczcc5htw3jME9DwQxFQ+mdHFae0Jo+AZpOEaahOgQeCC+ak6ItY/u7GHYv0Vy58XEWh8S0mCc9gpL53CkfwLUwOfKU/w8UWpVGU4uSQmfP0nqmsDwhSUaUbmLfgZgzxYD89qSkmkfG33Zg2F+zTPJM8XknjLSte2CV/fZKbbbu/fap0vRApTzA1aFt1BjYHXHFqcfvh3yB6J+YJkNktguTmFzP5WgCM6YCttz2bknYCLiu5ZjA7QgjWbioku5kXFvKzkVkXFys6mRn7PdXOi2Hpzjfp/mvUnpuZGF24AebaWRbTOKgup3zmmtE91Vs6PwR1kx/17jvPlC6fbVgIX6qtxpg3L4ANTCKV9q7v3bHxcQkdfAhf9SSAmNC9VYF8IebI8Xt7AdbX/mAC4my+XdyqdcaYzjHl2DYT+7YMTr1mQOncyG0iMmmyCYdGQp1wNmqUC6D6ps2x7OueTROQQWtde6DXKU9j3OQAaeCFfS3sXwrQLgAhUeiS5KijMe3epSGBYfa0qhdqRtPtIt4uiCFUscN7rY3olQ9AHgGgeJbK8i8WwUnWG5APPpvR/A0bQRrLQ5TG1UAKq3HaN8lOvYfSV3O5KSE3qhxD7JTF6y+8OUt4TxYdQCTNRQZaTpgjH1j4WEGNefsOwIYwWLfS3MEA1kN2ilktAfrbDJ2sAxJH8ZPy8kx3ifFnAwjgHYw02e7Ua1H9LTeuUwfV0Ti
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70293ec-d926-433d-b941-08db2b837134
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:46:14.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6oJc5gFrSnXtzR+/Zu32t45umzIX1ns1pkTDkJlhRlVTwu6JHah8xtxvMgthSyw5K2uWweQBHnIYQMLn9VZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230073
X-Proofpoint-ORIG-GUID: HBhxybKT5bHM7baVPNQfEbij0WQq5wCj
X-Proofpoint-GUID: HBhxybKT5bHM7baVPNQfEbij0WQq5wCj
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a report that the blktests scsi/004 test for "TASK SET FULL" (TSF)
now fails.

The condition upon we should issue this TSF is when the sdev queue is
full. The check for a full queue has an off-by-1 error. Previously we
would increment the number of requests in the queue after testing if the
queue would be full, i.e. test if one less than full. Since we now use
scsi_device_busy() to count the number of requests in the queue, this
would already account for the current request, so fix the test for queue
full accordingly.

Fixes: 151f0ec9ddb5 ("scsi: scsi_debug: Drop sdebug_dev_info.num_in_q")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303201334.18b30edc-oliver.sang@intel.com
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7ed117e78bd4..782515abca2c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5580,7 +5580,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		int num_in_q = scsi_device_busy(sdp);
 		int qdepth = cmnd->device->queue_depth;
 
-		if ((num_in_q == (qdepth - 1)) &&
+		if ((num_in_q == qdepth) &&
 		    (atomic_inc_return(&sdebug_a_tsf) >=
 		     abs(sdebug_every_nth))) {
 			atomic_set(&sdebug_a_tsf, 0);
-- 
2.35.3

