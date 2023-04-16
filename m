Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B06E3AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDPR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDPR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:57:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A71FE7;
        Sun, 16 Apr 2023 10:57:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33GA7luV027140;
        Sun, 16 Apr 2023 17:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=gLERHQYQhyHOxFpZYrO6UfcDdG0tEfit62vhSMi4uU0=;
 b=2DL2+pWSBGFES2yLY5Xtm5eFD8FE4KixornpfGSdoE7UYbJhw5OhjTLyIXnsFdriaz1R
 8mA43hff6YJETc6O6mMAHHit2JyFKeBsLQwjZ77C5FgnQ2+juNShtzcgOYu7YQFoo144
 ZkcOsFD9vYgCySixrDaStjFZ7Gm6Gdz9f/Wry4WBpIef+nTQqpkjOCcfym0Juuzq0WnP
 8vy0aBt7+t4BloHVRcbekG/MAudettFh73ql+9Slp6+Jmd8is8A/s3veFTt+PTbS3To7
 GxQaUHy4puF4s37YCqXBITVODBN0nSNEEQiGV5BESRR27OwiVrgisckBumKd/iUlK5qS eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1hpen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Apr 2023 17:57:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33GDrFM9009517;
        Sun, 16 Apr 2023 17:56:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc9b8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Apr 2023 17:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6z6tZjyWVin8YANtUwWFpslI+EFwDelSF6gAmgHCH5lLorAYZb7rngAXYlTxfHZV3MTHrNgyooyxhJm4B/bz9S+49WGq0ZljG049LlkWxyQXXu92BnCZukAV0oku8v6o5J/Z1Jwfjr9u7ZCjURXo6mMA7EFNOfELW/cqvoApRQKga9HIgJI0jMp3LU07mMl1dQRTzzb6Q7N6ArIKJvMR4OBp7PmVj14yKcUOhXbVyDgChRS+NTct/4vPnqkEYrwkRbwonf1iFFgjoLvoz6umTVpO1dqWZ8+J1fKCNxWnTC7V9h4WcB+A26Hhk+AypJF43KuLHdqbPc+LK919e/omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLERHQYQhyHOxFpZYrO6UfcDdG0tEfit62vhSMi4uU0=;
 b=eGegrCqpJ8Rw+iXRIqZfRIZIeaNWRnWehXmOQTHpTqJbIR2FYfOSXsAtQfx+0v4Vyz4x4M8sMe6nbo9fc00PM1GXaBJAR7Uuf0b2if+686rrC0WjEH1wjLdRlWJvFDy0kFFsr8dfMKagM2n8N0NZp0KZo/OXLKriEwkD+Rr1Pyd5dudiJY/VQxFATEnQJqNAQFmoYITLEDoh6/ia0BhafYoosGZWG2z+9ItLbpk1yWiyAI/DZbtw7I3/NBSLaRKhOEBfFarQvzM9/V0KHvbxkhKaneE6yeLQhrykbJUTvmjyrE11oCGeDjr8m7mCvw66H1zdbY8ikSmn9yJloGbFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLERHQYQhyHOxFpZYrO6UfcDdG0tEfit62vhSMi4uU0=;
 b=gTpIxYfebhTMJvqsWdd+pxeqs8Lj0b+TAN1zv91WXAITMahVKRbWnGdYs+Mx3JoXgd5d3EaKdW1dQ88Ff/zPCHHguY3O3Lym/mTBlqlTxId1G2VZhBtFkEZAURPbcuiROaOW0g8YE4Y4YV/a05BWnGY+LGzcgk+X3Vwlh/TMx4c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4340.namprd10.prod.outlook.com (2603:10b6:a03:210::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Sun, 16 Apr
 2023 17:56:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%6]) with mapi id 15.20.6298.030; Sun, 16 Apr 2023
 17:56:57 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] scsi: scsi_debug: Abort commands from scsi_debug_device_reset()
Date:   Sun, 16 Apr 2023 17:56:54 +0000
Message-Id: <20230416175654.159163-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:5:54::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: b24b41ad-ba5e-4a16-c8c2-08db3ea3f873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCamyQXmb9IVIhhTc/14BUd2c9Gl9ytXy/dJSXeIcAK8TOmn+NMSREqIL99eGvOJ5ApzgD4uByKxaOqcW5ZZGTDnOs4/5Fqyj35FTNDozdy2ZKat/qiUt83kqa8UI0kwKKwqLrSD6wIin0Y/x6gKw+Iwbc0S2x/zBVnExag4ebHO7/a/cS5lAMpfwvnp5AywrwYJXy3apM0dKYS/1vpTMXArVnE/EVDQFmUuiOUIF7qf2LAgINu9Loy0yTDYXyVDd+n9GjusH4pSmnw5zYGtQalFKjJsgYaYyX6ApGVkcUsVEg2qGqdxu8qUwHKcyJBrRetsaOpG0cidskmx7tmQfpMWadErGwmOxy/ktuirOxjygXWH4mzbDEiT0SEIxs72AqbzqKIBAACSoP9Er5G+okt0dI5JGSfJN2GliU23DxqUl7om43yRNgYeTMF41RWIz4Bnmbh5pYAZ0CnReLHgvfW2vNj3imZC2IfR1ywImDINBFUTvklrdRD6ahfuh3sxBCKS/3+DlFMVANGfoAjQ2KHMCERwUifqDnBEq5nFyIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39850400004)(366004)(346002)(376002)(451199021)(38100700002)(66899021)(8676002)(8936002)(5660300002)(2906002)(36756003)(103116003)(86362001)(478600001)(6486002)(6666004)(54906003)(186003)(966005)(2616005)(6512007)(6506007)(1076003)(26005)(66476007)(66946007)(316002)(41300700001)(83380400001)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ky2HSwWIsrdb+3yxZZI7zMa9Y/8XP5G7P56mckj/uhpE5EZJBntAYX/WD0Wc?=
 =?us-ascii?Q?9UumI4LszzrfxxKacdvtEyVq/Zu5C4ONwvHufznD+Z/aYEf0YznvhDk35CKj?=
 =?us-ascii?Q?vVx5IoDeTKrVG7r49qyFXENLZjImiJdkwqY3C2zw12H0zFYHPA7emaCZJUm6?=
 =?us-ascii?Q?oLiyiaDQR4lo2jRS5RwTBZE1nt5cpwXwVHryWvDZSstp4CKP9Je+HcvYxIIk?=
 =?us-ascii?Q?5lE1AKrI3acuOxRldAZs2Mhrj5CDRv/GG7A0rV4WCO9AfOTO/lbBWivvslO8?=
 =?us-ascii?Q?oWevRDB5b4rh+g8Tz53ZDIgB835heNtEWpYiIk6K/aCAKLGnxBAAd2kaw9p/?=
 =?us-ascii?Q?XI3y1Ief4CfXJS4lvgULPcMB+wBQVTIUBPUkNfuaP+nvVEmK4A8SwcT7TVZD?=
 =?us-ascii?Q?tkAZnKsG2PArlguHrFZatSdKzgjl9cmJIBVCKtBmTJnzl4vX24Rxa28CMSO/?=
 =?us-ascii?Q?pmgP2MVS04rUmGJbhFmbXbUCJe7w9SDS3g0Znan4zZUhBmY8+B0mD4qR0Nte?=
 =?us-ascii?Q?z+XhhBLx6VzHptR9UVKD1IykGepeYAPLMfd+hvrBi/JbrP3/W/MZsUvK7E0A?=
 =?us-ascii?Q?tIrKBPZndk21SFm1oCiXTRaFq5otxi6H9QD7ADli9kRwd02meVtgB6nXXLNW?=
 =?us-ascii?Q?JrzmIkC6w95VQAQjsmE6Gi6QqVv/fIIFcWxJ3Aew8ibbt/ZVi6nECl6v1cr7?=
 =?us-ascii?Q?Gjj0u/qMExKhzti2+Jt+TKE/ms9E2z0YcSM1xnykt7NZdtNGtYq2IVRf1wAv?=
 =?us-ascii?Q?7i+7NzDccnRfaEx9qpa9yQBSMk5t+Idp7UmMov2O9sN7kQ3SnMDtPap+hXrH?=
 =?us-ascii?Q?qyFlezbdlBSFys11zn9vYR+X4XRd+1eohStb0HwLX6HBbD0F6pRlpxkVbiIs?=
 =?us-ascii?Q?CC+NQZsrLzqSx3jjtlMWDuPCYBidm2XiCfeZptFU7IR6C/DzDurw38qeKXP9?=
 =?us-ascii?Q?U4n7HDHPoi7ubqjO+HnrBzf2iEyD759uR3GSX7LXXeEc6FqGpWKgcquyG/54?=
 =?us-ascii?Q?299PbNrwBe1LwS9aK7xGiRakZul/irrmdUqjbhQx5Eq2X2rn/o2nSpN3rdRM?=
 =?us-ascii?Q?DeVMI475/Ar+Lrf0a9JSOTdXb5Gfp9u0FYM1ewd1oCg8G26Ivk4ibLIzB4N4?=
 =?us-ascii?Q?G/HxgBQvNid57dnvF87VVJ7GMWrNxq+KRZLdDwdVBJDAI1MsNLmJopulKFKw?=
 =?us-ascii?Q?LwwKDypPxhoQI41E6k8O1Aga4/uhGi8zxnpaG33+t/3UaXpm9+jca6oiKQwB?=
 =?us-ascii?Q?aE8zdccxmnegGa2EhgteE9QxfrGz4a5leNBsQI5tTHdP4aBPbeTUhrfi/qva?=
 =?us-ascii?Q?wOM+ouLcKRY0LAdHM2uiOoKrOTQ06ON4rPWgGgsf42k2o5RuKEcQKeK07sqC?=
 =?us-ascii?Q?QO+zeAeUz5lBIorhHAYhqhxmOZyUWGcS4VYI+KMDQR9IitxOSGhkEpL0K+4R?=
 =?us-ascii?Q?nFRdNk7paBcEJKjhj9oT7IKTsieZOLQlt90ICORheRfpU5ugh3y9lekmF/Dd?=
 =?us-ascii?Q?+H2SuDhSINf4xJPsOlBrS8/zDYOy8H4Xv9GfsM1aK77IH60IOW9E26l+o63R?=
 =?us-ascii?Q?yIywDfOKIVuSphugS9QKoGMlCW5faKr4Gs//cVw4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: woHvOodGnxHX7Au8m0U8YeM+MjXuSQLvXdJYHbclByiYOcCdEPvviYVJ7h3K4Wr4wRwGj5odVJtz3Rd0PEiztKxFSSFNw5FhQ+T0Z0FKP0IqnwSGhZDZLkx21JrShTUsyFq21+OM8RYpx+Kh1UuYGcVaBt1EJ6JkDhQ129W2WYwJMRXSqqc6Yddq4fNQRzvDdKIrqGn0rAoiZ62MmlgqBH5RTB9jwOKzrXDxVh3A8HvDqdPioVIUI8CcA/ngPV+VIQJmWSQLw01spWPkm4j3NYDNpmOSuVamDBi0rvJfaiYNXKgoqLUWv6sK3EHlbXWqCdWpbGkJEVrEnVYdpWAmNU9GtLlT7+uYOKrCEwXqaLR3x1ECXX/OnbsTMbQKMcWJXNq1VenQEk/h5BMdfMnB4KnCTo5Ssl8DTPeW+8vy0g6xI9ifx8jENqPEy58f7ao69GeQrPQ+HBXrQKDIjjdYChXjkLaX78G0adIEUIJvGPg7uXNsSB/OqbgdXu/93/2RZuJHFvOWLWfiX1dEMuWrjDlDAMdYzX4/mqO2TlvPdLZjmzjG6NkM5jc8l/mt6k4yQmcsRWY5FXi1lsq0t+D4NNWRJK7HSg1LIvb7bz/5YUbhtBfPPYUsccPKvx6s7s4R8c780wsMdJpxRCLZkZCBJaFO0g+YKLXJ9kyrrvzOWKXa/rLMY05oCfgjP1q8+3Sy3buIdnTmu1XofoByaK4XDurPD0F5FkjkicHNRv7RQtCo1SLqvSdUQ9DXk6rZKMFBtbcqziiDYoqc1sej6FcnxmL8fXnhf11kHYw83flC7oAFTUxp0W9zS9f6two9da7IKtZ1XrwOTcX0W2OVG1QdqJgaaloD849Dmppc8GzWx54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24b41ad-ba5e-4a16-c8c2-08db3ea3f873
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 17:56:57.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNCroLg0LUgk9SyAy8+xZZokjZuvJbrzCoFLT57oocAjObMo8FFym+TWfVNrU2cCRtOgzax2dLycFNGKCbU7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-16_12,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304160169
X-Proofpoint-GUID: W8JIAnHfxPaqeETw-hbNUt1yIldhBeOz
X-Proofpoint-ORIG-GUID: W8JIAnHfxPaqeETw-hbNUt1yIldhBeOz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently scsi_debug_device_reset() does not do much apart from setting
the SDEBUG_UA_POR ("Power on, reset, or bus device reset") flag, which is
eventually passed back to the SCSI midlayer later for a "unit attention"
command.

There is a report that blktest scsi/007 test fails due to commit
1107c7b24ee3 ("scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd").
The problem there is that there are dangling scsi_debug queued commands
when we attempt to remove the driver.

scsi/007 test triggers SCSI EH and attempts to abort a timed-out command.
Function scsi_debug_device_reset() is called as part of the EH, but does
not deal with outstanding erroneous command. Prior to the named commit,
removing the driver caused all dangling queued commands to be stopped -
this should have not been necessary.

Fix by aborting outstanding commands on a scsi_device basis from
scsi_debug_device_reset().

Fixes: 1107c7b24ee3 ("scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd")
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202304071111.e762fcbd-yujie.liu@intel.com
Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index fd1c28352df0..c2d2ed3a2db1 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5291,6 +5291,26 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 	return SUCCESS;
 }
 
+static bool scsi_debug_stop_all_queued_iter(struct request *rq, void *data)
+{
+	struct scsi_device *sdp = data;
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
+
+	if (scmd->device == sdp)
+		scsi_debug_abort_cmnd(scmd);
+
+	return true;
+}
+
+/* Deletes (stops) timers or work queues of all queued commands per sdev */
+static void scsi_debug_stop_all_queued(struct scsi_device *sdp)
+{
+	struct Scsi_Host *shost = sdp->host;
+
+	blk_mq_tagset_busy_iter(&shost->tag_set,
+				scsi_debug_stop_all_queued_iter, sdp);
+}
+
 static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 {
 	struct scsi_device *sdp = SCpnt->device;
@@ -5300,6 +5320,8 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
+
+	scsi_debug_stop_all_queued(sdp);
 	if (devip)
 		set_bit(SDEBUG_UA_POR, devip->uas_bm);
 
-- 
2.35.3

