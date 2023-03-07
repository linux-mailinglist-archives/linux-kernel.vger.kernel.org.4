Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8278F6ADC98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCGK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCGK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDCE574FE;
        Tue,  7 Mar 2023 02:56:53 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783pbe023546;
        Tue, 7 Mar 2023 10:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=46iqLIlJeaoqEX2H9ZKpRMpm382H/5bb8PEAoms267w=;
 b=sjh+PMI2TFpBaGQPpIr06xmSAjHqCNddyrv3GPETNB6Y43raRB+NwbE0F4kTJRh//Kn/
 OwqGt/c17L1rzhD4y6Xv+6OfAOMYMxNSZh5f2yEcwHGoAI+YCJEGvQbXLEt/FjUwIvib
 zteL4eLWR9Wykskh1jwb9IaaVXY0B37Jt71FBuI2t7grUGjJ1X0jTrKyAHNh+SPxj5m7
 LNe/s7AMjDwNWGHq5KCyEBjUFF8UieKwRcwiZATxDkp259Gmd1EsylT6Yo2mvXQeLTVz
 TmVPX3rw7fxVxGtL4DaxZFaR7nS0FhNtbVqQyxUiYJidgSd4vmlAPMPxi7pisFLrH9QO VQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wn753-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327AgfEq025120;
        Tue, 7 Mar 2023 10:56:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttjtwdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7QzZ3GD8FkqJU8UTDVxsk0JO8BzZikpZQ7K8IK1TO7Gm8pHUbIFEQqAfUT3YaLacVGqZgRaVGZ3jW/clSw+LSx/bu0YxTf5CndoBaGs2D+eYWWCf3aWLYgLnbJ7PkwfleRZttqMEdnKPQl11AfnVgJd0021RKIikO+Qz39sQTc55r+4j0RlQVWe2opyzcYLPgTxKW7q4u/1j8SrRrzgSkkjgWQ6OTY5/tfX6J1ReRPzNCkvIJcpBObxVdmJ68jItHlfnWF/YA9cygX6SbwXstVz55CqRCB5kcNOssWf5o0wrQ5cn3PUR5ci5rf04Z2dELuFtzT1rvQpI1ThKUh6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46iqLIlJeaoqEX2H9ZKpRMpm382H/5bb8PEAoms267w=;
 b=Q1JV1X7CUc9ildLcIJfK/Fa3Kmc5AFib0tmV+jP5m9S0xPIJ/FWo2bXNfiig5mbrOoWMY+SyphckFzhMSmUtL6fsptRKqb16o1iIIE0xgFVUIRSg3KYWLO5zbEzpil09y5IPOZVZ+yicqxqqJTLHPLq9Oppq498ZXInQFarJQy1oCNrvVbEpcVM1XgX1csm+NufyDcZSuGMHBM+Gqb1zKywf1XyeDAS7G9+vxZpVO71tK+xTZbGR0nwsPoZwAYyd+raWZNPOHcxy8lLsK3nkc1mst4VLht6pWIxoMxguqQYb7FK4WMOMPTJj6EG4AnjrPQ0qPt3SRYsx9vA5RafYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46iqLIlJeaoqEX2H9ZKpRMpm382H/5bb8PEAoms267w=;
 b=JVqvYlEWFLkrAZ+yTeUEHi6IMK+3Pm+ugOwIlWROyXtk20+SiylxUVnCkUKdqgyszBLUzsDZOfEHmecsc9HDeWKgVnP/3KJPsJaNwlxcnhlqMFbemrE1X2k9HTcderKzPDCjMCw0rrdFyLapNwz/ttCols4NznXhPhpUoWlH8z0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:47 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 09/11] scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
Date:   Tue,  7 Mar 2023 10:55:53 +0000
Message-Id: <20230307105555.3745277-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:4:60::45) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: c57c4108-f8f6-4582-6420-08db1efaa586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/yYYjSdY6yvf9KJWiQI+cw0c7Maxfusda0hdPUKOoXMgkuUnSjs8U6vVDGFFW+uQiTJZ4ho+viWwQThx1kDUQ8SN1IJBiV+QeygkWtpPNMbnMwVxHOjeHWKkRW//ZFGjPLlKM36Djz7b4HtR3wewyn9rgOAfBD55P5Gh7JOjckfQIG2PHYPlpdrN/4YccEkX8H4Cc9ChfOsHD+nLek4rWTCriun1t31v3kJWYbP+WtTuyvnlLCBqk+czietG2Dv/eLlMQVo4NeWawmQU/365FeP+OARxV1fhCBbwnXl/w6HhMhoh0H6mcQ8gJlJPTs77OTFrx+TlsCBCHekDrl6SMvKLTrACbblx5rcaSt7q72FI17hoQ/kzqJK543uuUYK8ws4o5ayP1D2EkFkwGkadVC9v7xEqiv0b9D3bQdfsCGf9bv4E4dhvnBeToC0aUk90ncfPQ+3yBX437DTNJw3jVqGH4a0qFhKz+WbrdAdMCGmby+Ax8o6TezIiG4RAovdArv0Gbp+z8Tj6kNdud5wScx3oz5QSQ6XhWlZQ49n+sWYMr5qxn9TYZlqieROWLONbCPp2i+ivRTx1s7gwNopGS2T8OV0yMnwVhscRTqYpOi+eAq2BMvd26l92dViLO6tLCpA1fijIUqTs5jl/Jlhpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?waSCjIm2PUJdmFbKf1MQmtZVBt5XBORnCBoW7ObBW3n5OKNOVwMipK36fAgx?=
 =?us-ascii?Q?2jtH97sQQRY2+r03D2oTkGpkqu1giyAuSU908BjZoknRZ4va+bSrylLhQq/q?=
 =?us-ascii?Q?13LGKu4jfExm2ogHImwCzSCVhP7uZ4J8KL3ZFAyt4QdZ7jDqjXQNgMoQI98T?=
 =?us-ascii?Q?XKrDyxpeJH/z0WsyTz5xmRl4l0JD3vnZEyOEmphIKrhGeL6TccyI6RhIHKwt?=
 =?us-ascii?Q?y8sSRnipil88tnV4Eh1AvhArSAgTpJD3Mk2U/adWYKyMWaI9CcF1TGX28JDw?=
 =?us-ascii?Q?FI/aau0dR5yIrMwNWNa81mMyUTd+oPfRqQT4hJ/qdxCoMcPmwAh5GGbCw4OQ?=
 =?us-ascii?Q?Jbl4Fx35JvX6XaTU5+RmygoiBR5NMfg1XWvSbg9TbH2oVbDtMDvvlz4+2IcX?=
 =?us-ascii?Q?mYJs+ArItOz3faYYWrJLzJg/GOjgBHoxDx2z2FyVn63VGILlQS4b3YLiDD2L?=
 =?us-ascii?Q?gavisMQ5Kfun7VYElrWFKcM3OPFJ+vQv3/rplKeZsQiX2tkt70zz/jkZj1xA?=
 =?us-ascii?Q?HtWzXAT1Aiu/2SNCFaEUVS7fHSERgGEDA1NwtTwi3H9lO1RfM3yY+bguEYni?=
 =?us-ascii?Q?HhUo7b9w9zwY7/MfB2/hkmLPZJk+MNPmx/jXZKE3YcDFM6sFIzcPH6uTIO96?=
 =?us-ascii?Q?dPVCe1KOQeokh3CCXyz5Rn+ynQ6NKX6yF0olqDB/HA2rZkjV3MGppRkqn8iu?=
 =?us-ascii?Q?OK8mjzHWH9xSqhrlKA48OiAbUW1PhwuaHnU24mTdUeQHKH/zW6EHR1LY9gVq?=
 =?us-ascii?Q?cA8hnA/pnguOGd0Q2GVwT83ZdvUycZ8lm32uvvkAvHmIPaxXYc5d+2GbtGnl?=
 =?us-ascii?Q?LRLeKR5m8TKLHTdVuanP86ncXiPoknIhx3nERUrB2nkmto7taus8FjPaftMy?=
 =?us-ascii?Q?AdsrZa49A39/JKhFZKKLqsAlM7ZZgMj4zWnd87FThb6Y/oQ//FgQxU6Znj+2?=
 =?us-ascii?Q?bNygMMkbK3N2rfD5G8VSUmQA6zebL+LpJI1sr7tjo+gezoV11PhnNVT8Y3Ny?=
 =?us-ascii?Q?ZCcw6bYO07UI4qA27Igkfh40z1VwqhHhF1JLxNJmHh0Utvp/i5Ey3EJEjose?=
 =?us-ascii?Q?B7d7xYGH1YnCfuTp38adFYJsH0sxtudJlLoNzQPzCqR+7pmRIOq3LW0nGweJ?=
 =?us-ascii?Q?W6jrwSP4XzPjwZJb1teMBxtuODvsOj1OzsX+69bSQQccRKjtKp0wc1v+WJJP?=
 =?us-ascii?Q?Yr0NKlNJkOdhLHITjcLJzMxr+Bcn3rs3EgwmAeVyDfPwTOlv/e6mcPfw7v5x?=
 =?us-ascii?Q?OYl0kqTbK+ItMPAfpm1VlBoh3T/5GnSN7g+E1hix/kNHK2VEaKwaMocp4arP?=
 =?us-ascii?Q?ybiuoy9gwcjE35+oq9sNt+7K5P/YGjdsOw7mj6Jg0zVap5J+lOhTXY6JOclu?=
 =?us-ascii?Q?wla7QerS/PC6VkdrJvj+HqNQeFNYWmh07ABA9bP2BxbK9Eo/7+KfVRCY1zU2?=
 =?us-ascii?Q?7BA8UnUaE1wB/pOBpEgCWA9yxsNZy+ogot9eGRwM12wGdh2bGVB6199zNKv9?=
 =?us-ascii?Q?h8nQNqVip7GJp8x+G6fCnirxHHsd1RWhJ6OZQeMRH1uecr2gDhZqaNPpZsdU?=
 =?us-ascii?Q?9rrPVFgQL4764w8erCGv0ZE+KXRPHOhOiY/1MY51s9zy60BEsHgA85qqr0Hu?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S8N8zaNnvr6kv8DL2k6geWmRpHX9eWyGis9BX76dT0jYer9Me0jFCoQckPoq0Et3bgrswldafczbvZbs846u1LxF0oWnLC0U3CoRtJ6Xi2uy/Nxsfz54LptcA6+I+j3L4yvPRUuOlenm5U2dN2ZZLncNUG8hN1G0SIqTgFam1tV/ctH64paBDIdaXtos9sD/a6IgjcMnhHN4P/tb2XLFzD8XTQ1dHk3wYUoxZhPcpk2AyjzYdl7xwEjzDeenSM/p/JHg07BPu3fT4Y0Ikr7u+/96ePwl8BnhYXWwJarMWycfvhiTD81kLn7e8E6c2YEwahoSzVIgmlBxcq/hsQ5aBB/1dp1GfXRFTkbrkAAfKfSlCffMy7K/8oVbG7EQ7rYUq0//ZCnJ5crv6Rre0OK2Hr6lENDtvj9byYmDabLG3rt7WOBiqR+QPbTKVwGbSPenWFNLE1ygrLIPYAcvrIqTwrYOigsURlyZ0y9ricFiCvIU/NkNU5TVMyryiTz3sY70tV8fvXWcryXZSqKBK8UgK9JaCbD5HFhf/kT+u0zbqq1jMLi7PHvY1LLcdnasj56yzWZVFYzT4GPGMXQkhYso9ojVaes5AFqS7q4ElIINTknF8/whqJRZvSKHuQmOn8P/v0A0MjRtz29n/6DlxdIS2RuAnJ3CYuCcuok/TefRNE3iDhLLeimRLMx016Zrcjwmf0RNlBpzO4JtKybESCQdH5/oXrh4QNdzC5E/56JSzPrlTVzYoqkfNYlz1yVsl205LEw6wjXvXh7+OIsoG/VWaKdPXAsqOgIQD26wDmhr+pbGOoKPbHO/vXb9p+xXfyKdMcq7gYmEvrm4vpD3b03W2A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57c4108-f8f6-4582-6420-08db1efaa586
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:47.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfyBDsXmrYM1a8VpUpwcTsVDQWT5GVMnoUYP2QrPksX8Rha4UPlWuyl57OB6BFA099OEEakCandYoFaZfsAosw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070098
X-Proofpoint-GUID: RVTaIiKk_0yintXYF_-VmJH1bLNABMmU
X-Proofpoint-ORIG-GUID: RVTaIiKk_0yintXYF_-VmJH1bLNABMmU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In schedule_resp(), under certain conditions we check whether the
per-device queue is full (num_in_q == queue depth - 1) and we may inject a
"task set full" (TSF) error if it is.

However how we read num_in_q is racy - many threads may see the same
"queue is full" value (and also issue a TSF).

There is per-queue locking in reading per-device num_in_q, but that would
not help.

Replace how we read num_in_q at this location with a call to
scsi_device_busy(). Calling scsi_device_busy() is likewise racy (as reading
num_in_q), so nothing lost or gained. Calling scsi_device_busy() is also
slow as it needs to read all bits in the per-device budget bitmap, but we
can live with that since we're just a simulator and it's only under
a certain configs which we would see this.

Also move the "task set full" print earlier as it would only be called
now under this conditions. However, previously it may not have been
called - like returning early - but keep it simple and always call it.

At this point we can drop sdebug_dev_info.num_in_q - it is difficult to
maintain properly and adds extra normal case command processing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 63 ++++++++++-----------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index fb7434d09cb9..cf3745d7b8f9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -288,7 +288,6 @@ struct sdebug_dev_info {
 	uuid_t lu_name;
 	struct sdebug_host_info *sdbg_host;
 	unsigned long uas_bm[1];
-	atomic_t num_in_q;
 	atomic_t stopped;	/* 1: by SSU, 2: device start */
 	bool used;
 
@@ -4933,7 +4932,6 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_cmnd *scp;
-	struct sdebug_dev_info *devip;
 
 	if (unlikely(aborted))
 		sd_dp->aborted = false;
@@ -4958,11 +4956,7 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 		       sd_dp->sqa_idx, qc_idx, sd_dp->hc_idx);
 		return;
 	}
-	devip = (struct sdebug_dev_info *)scp->device->hostdata;
-	if (likely(devip))
-		atomic_dec(&devip->num_in_q);
-	else
-		pr_err("devip=NULL\n");
+
 	if (unlikely(atomic_read(&retired_max_queue) > 0))
 		retiring = 1;
 
@@ -5194,7 +5188,6 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
 	open_devip->target = sdev->id;
 	open_devip->lun = sdev->lun;
 	open_devip->sdbg_host = sdbg_host;
-	atomic_set(&open_devip->num_in_q, 0);
 	set_bit(SDEBUG_UA_POOCCUR, open_devip->uas_bm);
 	open_devip->used = true;
 	return open_devip;
@@ -5265,7 +5258,6 @@ static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
 	enum sdeb_defer_type l_defer_t;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
@@ -5280,10 +5272,6 @@ static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
 				if (cmnd != sqcp->a_cmnd)
 					continue;
 				/* found */
-				devip = (struct sdebug_dev_info *)
-						cmnd->device->hostdata;
-				if (devip)
-					atomic_dec(&devip->num_in_q);
 				sqcp->a_cmnd = NULL;
 				sd_dp = sqcp->sd_dp;
 				if (sd_dp) {
@@ -5310,7 +5298,6 @@ static void stop_all_queued(void)
 	enum sdeb_defer_type l_defer_t;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
@@ -5320,10 +5307,6 @@ static void stop_all_queued(void)
 				sqcp = &sqp->qc_arr[k];
 				if (sqcp->a_cmnd == NULL)
 					continue;
-				devip = (struct sdebug_dev_info *)
-					sqcp->a_cmnd->device->hostdata;
-				if (devip)
-					atomic_dec(&devip->num_in_q);
 				sqcp->a_cmnd = NULL;
 				sd_dp = sqcp->sd_dp;
 				if (sd_dp) {
@@ -5571,9 +5554,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			 int delta_jiff, int ndelay)
 {
 	bool new_sd_dp;
-	bool inject = false;
 	bool polled = scsi_cmd_to_rq(cmnd)->cmd_flags & REQ_POLLED;
-	int k, num_in_q, qdepth;
+	int k;
 	unsigned long iflags;
 	u64 ns_from_boot = 0;
 	struct sdebug_queue *sqp;
@@ -5597,16 +5579,21 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
-	num_in_q = atomic_read(&devip->num_in_q);
-	qdepth = cmnd->device->queue_depth;
+
 	if (unlikely(sdebug_every_nth && (SDEBUG_OPT_RARE_TSF & sdebug_opts) &&
 		     (scsi_result == 0))) {
+		int num_in_q = scsi_device_busy(sdp);
+		int qdepth = cmnd->device->queue_depth;
+
 		if ((num_in_q == (qdepth - 1)) &&
 		    (atomic_inc_return(&sdebug_a_tsf) >=
 		     abs(sdebug_every_nth))) {
 			atomic_set(&sdebug_a_tsf, 0);
-			inject = true;
 			scsi_result = device_qfull_result;
+
+			if (unlikely(SDEBUG_OPT_Q_NOISE & sdebug_opts))
+				sdev_printk(KERN_INFO, sdp, "%s: num_in_q=%d +1, <inject> status: TASK SET FULL\n",
+					    __func__, num_in_q);
 		}
 	}
 
@@ -5622,7 +5609,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		goto respond_in_thread;
 	}
 	set_bit(k, sqp->in_use_bm);
-	atomic_inc(&devip->num_in_q);
 	sqcp = &sqp->qc_arr[k];
 	sqcp->a_cmnd = cmnd;
 	cmnd->host_scribble = (unsigned char *)sqcp;
@@ -5632,7 +5618,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (!sd_dp) {
 		sd_dp = kzalloc(sizeof(*sd_dp), GFP_ATOMIC);
 		if (!sd_dp) {
-			atomic_dec(&devip->num_in_q);
 			clear_bit(k, sqp->in_use_bm);
 			return SCSI_MLQUEUE_HOST_BUSY;
 		}
@@ -5692,7 +5677,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				if (kt <= d) {	/* elapsed duration >= kt */
 					spin_lock_irqsave(&sqp->qc_lock, iflags);
 					sqcp->a_cmnd = NULL;
-					atomic_dec(&devip->num_in_q);
 					clear_bit(k, sqp->in_use_bm);
 					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 					if (new_sd_dp)
@@ -5768,9 +5752,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			sd_dp->aborted = false;
 		}
 	}
-	if (unlikely((SDEBUG_OPT_Q_NOISE & sdebug_opts) && scsi_result == device_qfull_result))
-		sdev_printk(KERN_INFO, sdp, "%s: num_in_q=%d +1, %s%s\n", __func__,
-			    num_in_q, (inject ? "<inject> " : ""), "status: TASK SET FULL");
+
 	return 0;
 
 respond_in_thread:	/* call back to mid-layer using invocation thread */
@@ -7375,17 +7357,12 @@ static void sdebug_do_remove_host(bool the_end)
 
 static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 {
-	int num_in_q = 0;
-	struct sdebug_dev_info *devip;
+	struct sdebug_dev_info *devip = sdev->hostdata;
 
-	block_unblock_all_queues(true);
-	devip = (struct sdebug_dev_info *)sdev->hostdata;
-	if (NULL == devip) {
-		block_unblock_all_queues(false);
+	if (!devip)
 		return	-ENODEV;
-	}
-	num_in_q = atomic_read(&devip->num_in_q);
 
+	block_unblock_all_queues(true);
 	if (qdepth > SDEBUG_CANQUEUE) {
 		qdepth = SDEBUG_CANQUEUE;
 		pr_warn("%s: requested qdepth [%d] exceeds canqueue [%d], trim\n", __func__,
@@ -7396,10 +7373,8 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
 	if (qdepth != sdev->queue_depth)
 		scsi_change_queue_depth(sdev, qdepth);
 
-	if (SDEBUG_OPT_Q_NOISE & sdebug_opts) {
-		sdev_printk(KERN_INFO, sdev, "%s: qdepth=%d, num_in_q=%d\n",
-			    __func__, qdepth, num_in_q);
-	}
+	if (SDEBUG_OPT_Q_NOISE & sdebug_opts)
+		sdev_printk(KERN_INFO, sdev, "%s: qdepth=%d\n", __func__, qdepth);
 	block_unblock_all_queues(false);
 	return sdev->queue_depth;
 }
@@ -7501,7 +7476,6 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_cmnd *scp;
-	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
 
 	sqp = sdebug_q_arr + queue_num;
@@ -7539,11 +7513,6 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
 		} else		/* ignoring non REQ_POLLED requests */
 			continue;
-		devip = (struct sdebug_dev_info *)scp->device->hostdata;
-		if (likely(devip))
-			atomic_dec(&devip->num_in_q);
-		else
-			pr_err("devip=NULL from %s\n", __func__);
 		if (unlikely(atomic_read(&retired_max_queue) > 0))
 			retiring = true;
 
-- 
2.35.3

