Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D126B729B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCMJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCMJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:31:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDBE1EFEC;
        Mon, 13 Mar 2023 02:31:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D01Vc2018846;
        Mon, 13 Mar 2023 09:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=BPrnZslTo9kfHxJ7OT6fURQ/wPLEqWRnM1ifwDhPCKE=;
 b=wvfDbSgjGOghhRD8YFGNiUu9S/ShEj/9LViYDLCXEcl2Q/AmPaBRjD+AzDcXF2l9zVXy
 auDyIHp4pxP08MUz0XpGXKp0g6f6TPQ8iMDIflBJHK1j9NRstEigJEig13Ja88j0M0aH
 kUZn8Hpjtl9liZx7cUqwtwAZNdq3q8ohhcg+CYw+ZVGagFqaSmvqK7+YC1JfSYa+sVK5
 VIjo9w6S9FIbEQcfJnsN/2Lln9rXLeZzgLTGpjrIvv9n7HBszrSNggddPWGLPltkfgZJ
 6AV/L7nny/p0A0cv//GIxOoO/y22TDSmi93Q1+iVrb680QpkNdDcqak0tfiskTJClHwQ 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhabas1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D9BRDj025236;
        Mon, 13 Mar 2023 09:31:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34d2bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvrYK5yeS4t8E2XHMkB7F1MO86F7E+1j3NRYYsjwPmz6bbWku0w99Z1V+wv9/jangA57DJ/8kf0s+NJAS5wulUIUCkpMdUGm1hVFSDbKZbl1tIi4iCteA1xpyH3Tk8x2OxhD4FzrMEg0FpUJ8w/LnUwGkBzcDGeft0JCGIBNgdEjkb7+eEkFaNzBnpWz1/JpdQYRp0X1V5q3XKdqjgF/1IeX4rPzswXNce4I2Qa8p/MwiO2Q3SE4Q/QnRICWXdYzmKendL/t8SLEby0uVd8N8MaSo6G/vQVIfZY+caH9Ma7sKc4Xnq0ApDDIiprUgxJRFxVTdmWB4Tg0YkZi6BHj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPrnZslTo9kfHxJ7OT6fURQ/wPLEqWRnM1ifwDhPCKE=;
 b=PnjPnh9qRt/p/W3dRrktPm7VQOB+U1DM2EM0duG2SKKQIWv1eZYE9b6aNEwdaunkAbiSb+jLlBNt0eF69P8FvhGRY/JKWz5Hz0893L8XHzJcSFcya56I4mBEpFMSvzLjR+cY0IzLpuxQm4OO/jj5EB1wgisUBlDBVzgmpwIJQRevAES2dgBwG8NY2AXPCg2WvvuJn1EcIOVHyQPb+rYo3yI7t6IPM4kBav01DO1yLIyBUTMZ0CVemrIlyeJJowO3Ro5SDrKb4EqitKLqCpQrOXr8qmIn64/rH2aP9zUbuVOVg6y9wpNy4yn7abb7NJ7dS96aIqpVX8rQH3nqGsSY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPrnZslTo9kfHxJ7OT6fURQ/wPLEqWRnM1ifwDhPCKE=;
 b=I6lYMw0NOsFq4pmqpBtIsdP2YhXWmU2UYxW4dX8SZfcjTz0t/JdTnG2h1woCuX3SFTkDrNZ4enS/T5q4sfX35RloK0xBB1eXTzSsQJF/V+dUqw8il+kllVuUed4n3StqIzccFyJusoaw2bLWnHsoe9UPNw9NtNxqYDCOKVGS5ho=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:27 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 00/11] scsi_debug: Some minor improvements
Date:   Mon, 13 Mar 2023 09:31:03 +0000
Message-Id: <20230313093114.1498305-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: aea00997-a6ad-480f-7711-08db23a5b823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQ0v1+J0KApWqTmvTjCOY9tqOKIQ7nI7H23q3k373ZW3+/Gvw3K7ick3QOJsKcuKgw8rrppZS18ZP9fo5icr+MWSqKUWQT1YWFhohH5tV5QBCERWaERxqxpL1yEjUpUy0Dj7to6y9oJtMEdlCIsTKBmwcplUxCUEwxiIy/wZXry3UM05doyF8zZi6Z70C4yDDjVEgvngc9CmL4rbfgS/aIPZsfLfD9/FH1evtBWAKcprOW2mv0PJE+DkLPZZ+qe/L42qT5rZ4OPeVtsSe18As280l9CJqNFnQPYLqV/qCNeMi9AUbFyUgytx5ZGNp7NP6i2aJuOK3uOYN2hj4jcnKjuisCZWR5wCRLjp+9J55sFaXkBI870Agmnj6rTV8QGJ5RSLU4u79NDXFl4KlGXLnYtSdMwOBCfWl1AOZHEkcF5FnhUd2QO1bmDPBT1bPLuCB7T1Qss9k7fKkF0Z0ajxEuyL3Qx90mz85KUPDthfOOtOqEJqB/1TYmWUYTk1x/w80okZchPZTZ/fhe1Guc2a0csHOrhLfIqJzWSHzlhzpa1pJ0beulJ/pAFkp94s1GQ1cxBLBTaUXcxDucK3XsvELrTv+u9WZ1jDa3kkgemAJMPxyUAy73pAAbvoAkSjzdI2jHriKL2EFjzmmGEU3dQRlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WnfQXnr7UwUdz0HDFz1CBQNm/defix5DHQ54soXGP1AZ5lMFfhTA+QzW4zV?=
 =?us-ascii?Q?4/Z9FLBJy35+LZ5glYMnkXD3ZnWzCGWEdpKa5YbSQ1abpORTCjzbYNKiA14E?=
 =?us-ascii?Q?lDBp/pz41NpVOaD3jHQQzx5nvnuH0oegapCmGx2KiBjis2MPWlJBQmZXy6mx?=
 =?us-ascii?Q?PXybLI0oI0LecgQqqrlYO2aaFat5cI88LSJMC62tsyIrNrb71m+tEYuVqjoB?=
 =?us-ascii?Q?obBdLKrTdHkYvLEmr25lcFbES0vHpukEQA+weX647J/ljZZNMrKrA2pPjcGd?=
 =?us-ascii?Q?NkHnWesD8dqrYcshaldKRC2IajxI5+ACaO6KG13VFEQvs7vfQO/lZIVuZvAu?=
 =?us-ascii?Q?hx2YAafjT8wvUzFdvN1tO020SwlXFjjHTXTdXU/vIt1vL5DHEaX543ydXb/Y?=
 =?us-ascii?Q?nIooB5Ck3QHclziToAEYC7I66+Pt9uGJupNeS+ulvDolfpF2nLsfhL/PMk9H?=
 =?us-ascii?Q?j0X+Hdx++V5lVtxeOiJQevXCohH1NYXNOB7fdWR49YEfjGWNhcU16BBZNe0p?=
 =?us-ascii?Q?A9IE6FdXnNHci+B8kyBEdrSZTfvvPvhkM1lgEhe8I3RR2ocwiNwrGrljqIqO?=
 =?us-ascii?Q?VrBYfbWAzyRZqF4gCXNrqxfPRu3AGisZ6w+XlZPCnbOB8P4QRxhLwFo6aVr+?=
 =?us-ascii?Q?MIGnqe8qw25XmeSQVHtcV/80rI1Qj5bllPss42M8T4jzdbXCF8qIhupTuZ6g?=
 =?us-ascii?Q?rHZ8almrmsYpIKoo2SzfKiP7A/RdxenmLtLfHvqzzobvaXnjBDdYaLXMQnhi?=
 =?us-ascii?Q?0NXyjWQSYOiX2j5R2mO8cIdO/A+OUMgOP8jbmUk6LFRp/RrP9E4pJUkDTAH7?=
 =?us-ascii?Q?e6MGBSoiu14nkDJ9ghmlnN2uYuLZVA0RO6ru8kK96iCZ/rwulTWi+p7U6U97?=
 =?us-ascii?Q?V00jO1MVveiJ8MvxE/UEmFbYvxZeDCKkFuBaqyFVOQTdD7vzhmjTTTIcAm0G?=
 =?us-ascii?Q?Mjm+ERSg+IPmTm5q+2YFEYW7IHU5yi+h5qVRujgLjbc18hHjkV8D3hDj3o8z?=
 =?us-ascii?Q?kYJwjlX7TWS1rh4q2UgTL40xzBtFkgzsa8melIS62Nf6KqDKbSVBALtf6kLm?=
 =?us-ascii?Q?fyZyzoBzfBJ0VqcKvE3EhHalfAbczTBwDTKdCcJ0IyHC2C8KZvS1NYGHU5zv?=
 =?us-ascii?Q?8u8MmchvT+BRxgnkxR/kOAdMyPkCuHJfj/EblR9UhHCUBMI08xyvTAHx5sRR?=
 =?us-ascii?Q?43CICYiauXhTfhgq9gzO2t3yxExc8zo72WJKGxPqNI6pR+ZRDGSUCYhssaM9?=
 =?us-ascii?Q?9ZYCr0bNVCiGJ/3Wliu/bDcXVT6CojBrTFh9F2KYN2TrZutOFTh1fzUnF62j?=
 =?us-ascii?Q?+BUBQlSA5ytDmPltjruQJQMJGrjZ6oVi8XeXa5AQK21UgcMfM/1IbDtWw88f?=
 =?us-ascii?Q?Z/whOLBIQ1wcb4rNBprwbpMitA/fqNOiZEuuZ0g2nXHf0OgRS+YLlFbHsMIF?=
 =?us-ascii?Q?XMk5MHPARp0QkTIQ+vSk0Hmg/M/osCTcknUtAzYSfI1wEGO8Ux0t8qV2Ufic?=
 =?us-ascii?Q?u3j+hxl6lfytTKjOzrellgSPgpFGjIV3QU44U1k/43sst0Tof4lBsIMmeEGN?=
 =?us-ascii?Q?gbTPERNDmHZEs0ITA9DHu/1q5vacRhkWM4DeC4ucCRKAak5UOGoJ1x5PD+r9?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6YwD1KC9kFmmLPhfQ9zWVELbXzRiSZZiWSbquehfrBKoVV7b3IAVGbr5b0X7HPhtnH28MrEnC5XkDuBUNICP0jSayybY2FGvzPJP0Qd+xYwY+IeKzZtHAuLhVIIzSfLNsQYCJiz7qQfop/+zAQVQJDcys1d7L2sugktzslFtYX2pjEF8YDyp+kh1VQceplB2FP5kolYsU/ZC+w1mf5Q8JHYaQ+t2Q0jqzbZHXkweO+8Py1QneV/P/OZ5winwMGlPk4SySXpL17OBjZhprmBXRPRTIATF6/+dpUc8WdWiGMALZzZeyjhbwekMN553i6YuUDQkaVg/XzwWsCMDC9oP16eUHG56Xd/L+TpaaytH6s1B7V58r9Y6vxQK/eJ6jXHReeiol0aeiZyf0q4XQQKs0lyfSkPlmcbkeFNVv/lN8wT87qSAGFtI29S54iObG60kNfo8hCj/aX3XfysedRvdmFZN/5ZELlbCCDtx8/hKjRu1Sap+rb/wUReL0283/9olYt//uQ0giVrXfSppzrBHZrL6Y77AT4FmQFMSDjB0BvmwxfkdmDG4pPSSSYAMOWHebA3Emj94dPeU1S+4Yr3xJAnv0DnNWw7vLWk0yn7i4WUkPW/7NyD5wcTOXI21oox0IGNO4RDBqdZV04AFWy9u/qr+dHoa+7HP6mj5Lu2qo+le4lJysi8lK+cz4zZ5wsG0cWOP6BgK+Xt1xVPaTpvOJIay+YQw4MW8a6VAQs2ASBbvOXgZYXlOm5dKr1l74h7iNp8V1xo4HY1Q+gX5LRkr3vsV4wjcny1eoHzm/aPfyKrE9c/1kuDRCRO9V1/Kh8Bu4+rE+ZoZlUnu1XT+dPIoAY3rup7+knuBgLpsnjCjz1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea00997-a6ad-480f-7711-08db23a5b823
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:26.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJjkpYanIMvfVpXYnrxGg9i67dhXje4+k/HniKPXixX8m2o1w6RYkF/HofqrWrSma/M3STQL6smGbbpdxcgz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-GUID: Z7imLzIrBjI-LOW6LAH0KMqGQttTTJE6
X-Proofpoint-ORIG-GUID: Z7imLzIrBjI-LOW6LAH0KMqGQttTTJE6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a bunch of minor improvements to the driver. I have
another bunch waiting with more major changes.

Most of the changes are quite straightforward, and the only patches of note are
as follows:
- Fix the command abort feature, enabled with host option SDEBUG_OPT_CMD_ABORT
- Drop driver count of queued commands per device
- Add poll mode completions to statistics. We already have poll mode callback
  call count, so maybe it was intentional to omit poll mode from the
  statistics.
  
Difference to v1:
- rename function to get sdebug host from shost (Bart)

Based on scsi-staging 6.4 @ commit 0b31b77f281a ("Merge patch series "PCI/AER: ...")

John Garry (11):
  scsi: scsi_debug: Don't hold driver host struct pointer in
    host->hostdata[]
  scsi: scsi_debug: Stop setting devip->sdbg_host twice
  scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer
    check
  scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
  scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
  scsi: scsi_debug: Get command abort feature working again
  scsi: scsi_debug: Add poll mode deferred completions to statistics

 drivers/scsi/scsi_debug.c | 209 ++++++++++++++------------------------
 1 file changed, 76 insertions(+), 133 deletions(-)

-- 
2.35.3

