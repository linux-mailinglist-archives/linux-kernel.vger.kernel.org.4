Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DA36B7298
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCMJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCMJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:31:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C291DB9B;
        Mon, 13 Mar 2023 02:31:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D0798f001750;
        Mon, 13 Mar 2023 09:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=F7DOKRf4GwxnVrEMQXHFYO8VfuWsdW4fBG+9/Nk6PJ8=;
 b=Wd5IiUB9427/YuSVzNlaLAu63BdeH1B1Bv0E296UMURnF1PpIrAdmqWk+rPqr4F04RDh
 LL1i/018+hye2kcIcbdAsD3E7MsXXIDCqvph1H7o+M9BiYQepakT5Br2EjhnM41iwDJD
 lYkzsCKhmNsemcjjxwmuA+BHx2ukaeHoALYGXg6gGcC1Ga1Dzs4Nb8Jw7canWFJmPd2P
 zFaIYeaD8hpV3qezKsxsisugDtm9TuQEynMKdgABbmVdIJ+JQ3PkYBeISGQ3wQzq99B/
 voF2Z+fb1/Iywd8AjvAzM0H1NkctAcvxsneP5qAwLOVuff4r54ekis652hyqAiJRYppZ 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8ge2uc3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D846UZ024963;
        Mon, 13 Mar 2023 09:31:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34d2cr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAZPsCc+XjHAuzlrr8gCmIk3V0LE6uovBR12zk70f/D22xnBp3f281Temnl46jsM99t6Y9AV9tb6m4vMgyNjEMOVyVEcQQ+2K9wkURKk1fP6DrTX8P5DbK+oULDODdFEd9/gBvg5hBPxzjHx9sd7ako1u0jZSclyW79gkrRXmu/Ko43KMhzYSoqWZva4ZwL8lv7joipMrnXONBXnorEdUBRUYy27M9J6XiG7b9OdK+5In1Z4iJmUNYUtM/biAvvFh3k3GYZgQS3a4UaYTs9TcqAUupcCAbV0FClwaDvQNnFZG/l0DMWYoGbkofoB8jJ0csY64OTwXRD7OsmHDgpaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7DOKRf4GwxnVrEMQXHFYO8VfuWsdW4fBG+9/Nk6PJ8=;
 b=ShNjboTMxhxPyIbuQz3UG+o2vqJbg90P0ZOJl9iwDgjYUgT47qUa9A2QzeKeo8TykndIu0E/sVhRQddUB+Npfb6rni3fkM5uWn/NPyDpm3I7SoQJ6qWhkB25uRbA4j5FS1GTJlyeJTJYg/J3O8jCu0N59GaWyBduKDj2LvCfmM5JHWPD/kP9YRBGz+j60HYwwO52fWAFylTlQbqPmUYJVl7TuV5dzXJ246xMb20oHkKet8hcnoTI1pZWUA30qVKBv9MIxIZA+12Prt+aCrQyaQfC3yvasQjOBb93ohsGwEI6PreT+SKwXJN6vHek7+Lu220za6C/G3SDilwQgu9nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7DOKRf4GwxnVrEMQXHFYO8VfuWsdW4fBG+9/Nk6PJ8=;
 b=KUnYzN7gHvpUkzbDMgqZmTBRnUQ8SVTleNTKmY2+FTkw1ZoBqnqtWtpoJYUapnjQ/8qaEPmhC+JOIf1s97nXHKUzWcv3P43sNYwOjsjpruz9XagHbTtGZOoaf9TkhIKHBX+ubbFzSPYN4bUNVg/ozVEqYUbfsg67LcgN+97SZiI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:29 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 02/11] scsi: scsi_debug: Stop setting devip->sdbg_host twice
Date:   Mon, 13 Mar 2023 09:31:05 +0000
Message-Id: <20230313093114.1498305-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:208:19b::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1925fd-5e8e-43bd-a798-08db23a5b9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzQfC1bCusqZbYnAADQdoVx4x34HBlLtLeyM/9VC4szcN3qNzWJi29dUuUtUPArCxAMRBTvWNExmVvapc2jnfzPfpJJxPDwZRQEZ+nvsZMPjTAanKVFGl1luKfhN+Chkd6SdqrhL+/qkGPH3PVRXKScVIRPhk2Wj/L8zBa2xMO91zoEavPLf0P9YWpI486azL1IvSrvRmF0wiclGEwe5eDb0VrKp0IyvsDZtyyBJ9hhthGfQwdPDWoFaEd+dayxDHcMCDa66TdfdN9Am4w1CiatUIeM+EzdiH+i9HDS6OkEgYNDHAyIFu1T5c7RjWZOYoyAbgS5QjSB7012xYwH7jxbaVKgOKAzt4ekzmorTloEjFSJc2b/rjsLqzhYF7VwtKqUo3IPYrmvghPEJr/AnOG5l2yRsVJXVOaYzmQkAeUkkr29S++Pv9GvtqQq/Qyo7v76CwX69YS8N4FegF+wRkbFpSZwSw5cJLTRpWkKOnaREc2BUvxdTKlpP0b0xQ6ndjKJN74M8arMxnf9eryujCuuiLjEtxwieMdrwh0esLDPSaqny2w45tUMg8qBWpYQmuIBSee2aC7aY5BUN5141z8jPYarIMi5DrC2H3aJoUkofuWrHCnWAWM8+Y+cCzWTYgIaNlVcnP5uC/6e/gXeaHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRE+eSNNHT5pWn9g6Jkq1X4k4/FyMXgi9vlFJSdY+aqTVBUASQWFOVHK93Sg?=
 =?us-ascii?Q?tTYESZUSgIeCh7TnrDesFoeCN3PfbBtUPRg7XCeRKje2fnGm4mB9z2C1hlGv?=
 =?us-ascii?Q?Gqj9vgxrfxrvFsfeCQfntEXtiCl6wh7Pdqbsni/WjQSkuLJoxoIxauI2OFwm?=
 =?us-ascii?Q?ojENzkK1hoJNlCTrDk+BYKu6Q+KJht3FpYNTFCNa6whiYYawxqbn90fWWN5e?=
 =?us-ascii?Q?YkChl5rSVTAsFQA9oF7irkO+fqeQKUmgAJM8VJI/suRCwIXBfJOHz+O+zIM6?=
 =?us-ascii?Q?Ypm1TMfowTFIIZq9+WKmiZkqqhLcQC2NmbUfv4LQiW51k4nPwgAcpoMAgMFB?=
 =?us-ascii?Q?poiREmKvo18SqhmeiATODOfYC3XIWgke/vyz0Mlb8kFHSw8HrS5VGLUetOmy?=
 =?us-ascii?Q?eycDxrY5pXL9g7/vHdfexGRtwXQi9IrTC6tvCtBcsH66p2YZda/ar9QikPZd?=
 =?us-ascii?Q?Ixym/+iYT5JjbQ0L2E1LheO4ooRS/K8HLoIK5IrTo/Su3X8RBGvtLwYnPbts?=
 =?us-ascii?Q?KH413xlktJUb+Q2mb2hyJWR2V7CNPnFi5SiiJnV/mTaDrlmyUnI5Xu70UMKL?=
 =?us-ascii?Q?+3qHKNY1T2W29xULrhcE12Qhk48fe88ots7ynEEmUqxSfnFl9Gs2aoIU3SOR?=
 =?us-ascii?Q?Vdr/s+UivU7Iou7w19Kl/A6TwMa0fFEJFLahJTdXF2kYuHeX7TANidgC0WPd?=
 =?us-ascii?Q?+xgfb24hkasE0N+oURNO9Ink+4U3DTeFWluCP8k169b9eIJnO26Rgxi6HfSx?=
 =?us-ascii?Q?u+kaSbTL4aImWa1rjqq4dFGcmcw7QF+YnHhUj8ity5SVmU+Fokuft2m5rmbm?=
 =?us-ascii?Q?yK1LjmJahMYgHbgLTMWn8yN9u3hyjprPh43k4V8lF0Pba6HBpKhBKMEMQDdJ?=
 =?us-ascii?Q?DkNp9HsuSjA0cSM8NvlSBRvtbTeMyaO82pWrRb+DNbqRZ4yLld2/XNgVkPGb?=
 =?us-ascii?Q?u+CJzFluMmWos1WSX0OhGmscapKlhPF7O4tKgnKkCXN1rX1lZgJLtz0yP7iw?=
 =?us-ascii?Q?NDeZ1vTC5zI8jQNB7h3MAOFIAklpbmAQu2eAytgLuriaeZJlR+r0LGzxIgrl?=
 =?us-ascii?Q?DO3tJ2cOg3G0Z3+fmfdzypEWZV6AFTL6v7PHY6wGYaTyf3D/w5PWfIEE2FHX?=
 =?us-ascii?Q?45zZULvkQ4zCCDN7MzHkertlnrdrAHSXxJKOddfcSMjieJcZY/yAleMTMJsJ?=
 =?us-ascii?Q?4Qxj6bvaRkBjVN5jYC7ywWjA3WVTOdKW7WWyIfXXI7dUwFYlA5ah51Uoql7+?=
 =?us-ascii?Q?4BgbYgQQotsLdbXxe+3y8Hv0izHuMLRZQcIdx7v8stRExGqg5TeKQC+MclhA?=
 =?us-ascii?Q?2YqYAZou7Hs3hb5q0vuyCzrbt8OWY3U9TPbb6331xb6XViJV0ZOEEUNXdkA+?=
 =?us-ascii?Q?ubMufNo3SW3m9PTjEeN2tzVEsnYQEkFPJjVTajnXSKJBQ3vLRA48LOZ+QGjh?=
 =?us-ascii?Q?Rp0TEJdNtSDXimrjeuwXr1TwBra4xU6kU0BTaHTRiAFztLRHaF/TKmu8laK+?=
 =?us-ascii?Q?SuP6bL88SOAvXBB18y1TE2jO+wwM1qDw0BDCSnoRgC6ZxVAvYY9bbH7vw4tm?=
 =?us-ascii?Q?1ZZHwU5MOQArWm9el1k4zDZVhh2B+CYSDZ24Ay8R8a+Qe6DJFURotLWZDyV7?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TOVpu2EkCU9JEIWQGDFK+hkh3FDEykrEPesDHnZBnYZs+0APecRCeUJ93ODoPIVKuz3n4ZrUVyP9870wllb+ELAawVPdmiGDdaAfztAUdMy+okGFdYnJDvKhrnxI2+dQuCKGoYpE4qNz7tvHqQsKj0WCzX4yLOW783lC570+GKg9nX+Kul45aR8NK7RgEnLhT4TQoKDZzYdLfwhOWMh8+tZ0FXpmXIkKjqzz09KsKpH9n51HqDljsv0Twmk3AjdwK4MehQVF6rs1zxnURlPal/pDWpkWQTq5vz+ZvRARioWzLUpnVFSeJECpHN9L+IecSM7ytelUj9q2s17+LYQbCFXcNPgDdBc9uWfNWf7xfb44L+GMggSgmqnkqM5yLk5xwuyh1XVOV3jebFIoxx1O18wRQbyIs/lVnmTmgYS6DPkpvpHWVCffBSophPTF/Na6kD+nDYAY0c/8bX1wL/GTeevQgaNL1on4bgR7wuKmgLCj7JRBRMASMHX89LyosGl596Vx37PlO+vUvEKY66b2uyShPx5Z4ocd86WFSSRiOwzvVaGae3dS8t2uOk02ty6GfuKWP760+cV6VStDmgcR0Is4EBJ2K0pNN431rhB9oDkDx1OeGuUK93/nkVEh3SmC76Un52PpB8gAeQOaKROmQjDEGsHhuz11dbeQOkTWeIit1EJMocJeQ2mjNIjGweSuXYBI2y/kx5QS7Jd1X5hgz8QE9EbngDpd6FdBV/uSTGG9rpiqogMjQU7LOza+uyovN++PCi98okitqGtb1i09sNQFXeY/yY1b9Mot0pmXGcOkFhA+5ePYrq00rDhR9tTHkIR2M44urlSrDMxAcJp6ZTcmTgqpQ6zPypqy+djP7pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1925fd-5e8e-43bd-a798-08db23a5b9c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:29.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L57DM6P8t3a9CZcDUdP4L6MWcDghrM+xDwKxltEKF16Yz2qzG7UUC3yws5mBnQuYxOZFJoNp9pOX+LPeIjTbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=987 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-GUID: XpNiwspGpqbG4txIujBCDLmCre3bMs4b
X-Proofpoint-ORIG-GUID: XpNiwspGpqbG4txIujBCDLmCre3bMs4b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdebug_device_create(), the devip->sdbg_host pointer is needlessly set
twice, so stop doing that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 554c03d7a648..4c60a055610a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5155,7 +5155,6 @@ static struct sdebug_dev_info *sdebug_device_create(
 		} else {
 			devip->zmodel = BLK_ZONED_NONE;
 		}
-		devip->sdbg_host = sdbg_host;
 		devip->create_ts = ktime_get_boottime();
 		atomic_set(&devip->stopped, (sdeb_tur_ms_to_ready > 0 ? 2 : 0));
 		list_add_tail(&devip->dev_list, &sdbg_host->dev_info_list);
-- 
2.35.3

