Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1514F6B72B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCMJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjCMJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:33:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1722DC8;
        Mon, 13 Mar 2023 02:32:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNEtuP011324;
        Mon, 13 Mar 2023 09:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=71CBl6OUE/KdEwxSdcAvNYP0lkXTQJ/ovxP3w8FCjgg=;
 b=OpxEZAsJ44aUhiFLr6rsZGXgPpxkbJ2oWeONAh+d05Xt7I+mfvd1ATV0to/IKIPe5jla
 SmJxIgnRjHR1xhNYa//qprgDG+7yd6ZIR5ts2tkGgQgHGN1DxkozgeFryk8U95olylpK
 qiyQ2PSCOAK30JStZDpiG0RshSIRPMvLsDYecCuj2SwkoopUAbtpMKx5RHKZBeE1FCh1
 YihLU57rwHerw7vTKZZwzeBObRE1vvzhJxLiKz4S7M24hfL4vb3g1MWrOvYoWJbcWlWW
 RhyJ21+jF9EHPyQO1yVRA+30xEEfjDcWvVH0bq15xrTA5/vCJWG3lEJmOlvW9xZdXu9E bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8ge2uc4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:32:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7PpAp007433;
        Mon, 13 Mar 2023 09:32:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b5g2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7xRbXvEqLeJuIR7peVSklzAWA+8B6vU1vAVJU0YH+qUyfWmsu1pQMv96I3TPpF3EXKbtrRuXk1eM2RJ6juSo1DFDo30dWWWlB/Li9GJ2ikP5JeDJ71T5Vva2hUPrIWAtdYbcWqFoqkWIyVbQiNtaNls/zfl8Ayp7/zJXfFB608nxAJGMdybiXMz01KZFarpAEwBbPN+16EFnKJ9sXzcfJn4G/yjCLvo4q6WT+a0ttvpo7Ux06uv+21928kKIkszvJ7Q5IMb1Tlv1uLhwK5x4TMsb3RTPnDcc/WlqcisB8xcGZuW/F2u8xEOlwdXooiEUkpRbKO84exm503XwRk0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71CBl6OUE/KdEwxSdcAvNYP0lkXTQJ/ovxP3w8FCjgg=;
 b=U8OQIcM/QiPlp1pT8Jjlegf2grbMxMXJR3uP3VXQa4ciw9BezpoNWcT+avSbRQOp5dbp+3L0ietMhARmBc/MMV6SDmrhUcbT5rJHqsIjUvB7wRskarwAYFDQ6MhI9fCzYVVv7WdqGLDWfnXmgPbvBV/dS7zmpEOcRK5LzejfARNLrI8UqkyefTRjsUjDa599p5zUO+3szLjnflSbaXjcOhBHSMxk1OX1wpbvzAaNfWPBVE0Qm7/rDc9mAfQkDK3Gj6RS5Rhk5nmyizmBSgAiFQa3AhvOkLHK/UTimF9RD6viz6DhNHeVYu4wh0cz3ckpQTmX3Ns5abJCJCHjhuEflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71CBl6OUE/KdEwxSdcAvNYP0lkXTQJ/ovxP3w8FCjgg=;
 b=SXx8qe4/yfN8sdFQbc1NcQCT0gmHueSq9PD4lyY1Tdh9ISHm8pDgO3aXjccPZd94/girC0cLPc66YLxuCtTJvxXAlx73rwVc/NIFIeGSaE4VyjQCEqMOtrhNQkMMaInJljnmx5zTn0lRH2l9AvYlCGNqPLn2h3B08Ow4gGXkkQ8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:32:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:32:08 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 11/11] scsi: scsi_debug: Add poll mode deferred completions to statistics
Date:   Mon, 13 Mar 2023 09:31:14 +0000
Message-Id: <20230313093114.1498305-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfd535b-a787-47cf-a741-08db23a5d0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6aQInVxRCWB8zWfEhDinIDJoba7c6SGTYQiGRhaPKlRYHHr8UXB/l7PtmJNyVbi2G/W4PGQ4cYbSZPlkJeuIKcUXv7f1v7WvI4VFswG0wlBETGppvOy7xbhyn4WKMIZ7QSoqltqlDa5ETlei/eJED8eS4rUjUg1OOMkSFTzBqeFTjEWVkqrCpaoowXhTa6Mc7hwYiLuFumE+dEEYIqPAM+k+JwYUgdnhnM6/d2wKyNpb4Gne5JsBEyRj3fFJlV3rJvhvS5B9Rkm6wyuIazD5eOsIIqiseecWiT1Oji9pqRCcYw2s3rwzh8BQw4U0O7P56YsQ8pdupljMA/fHViVlAajZO6rN8pmVQjCHdyTIxDaY8NUHFqNhfoVa91wYSZLlX8Rc0X4eLjQjdKRvcFQxlWZW+iGoIsDCXByvNJZehTl1f3SAR4SOoMlKyw2ajyj3nUb1PfVaqXPi0Wl3zmcBz9zKsaaeZrGOVl8202sDz012+qRXEFIRdbZwJHExOIa2ppf54PlOpZE6b3unvVm4K/9d5dUhqh0preezmLjprQ8aoLlNe6vXfHJ4Lah2aRbLVZhB2ZGJk5A6wF04M9R3E9zZWbdZ98JaVR3TLYW7iku4paj3q/5mTXHSJiQ7oauvTrHL9PybEqpo9qEkciuFuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wDt/idR29r3P5Fi9/CunsAbuKcxJnpZprLIrpfNlFebSDqdsYL9VevkiXX7?=
 =?us-ascii?Q?J8eXZ6CYz80WkNTSNjSPN+xuJh/5Rr7w4YlP31quJALo4omPf6QxYfR9LmQ8?=
 =?us-ascii?Q?ggY5oiIWpaX1/WQUZfUrR+Z3gAl1dI2mCuQeMlPVgICj0kPuveS/DnUgtZdi?=
 =?us-ascii?Q?yvYJv/Ch4f8qKKmhWMFmbgLws0IR/9h3KHFpPaxwaY3ko9gz6NCnb7RtWgpi?=
 =?us-ascii?Q?zkISPuFS+W36TZwqkuOmcUaBrnP33UXwRzdLvqrYZPBqFMXqXsGz3pJ4BHfg?=
 =?us-ascii?Q?EglB8Qc7L8cU6qdiJziHgESWe2JNOT/0XMjQtz6Zyo4Amu4tgo5pg/1y6zyw?=
 =?us-ascii?Q?G/3Vb/6FuVDvtvEHw1FeknFYSZg4bJlzUOklJ3PGmsRug2J9dWgVY/iexX9b?=
 =?us-ascii?Q?hBuHZ9aaW4yb5fhvzfihSLdFa/YTrDnybeHe8c6qfUBDrCD4DIR17kQa/l3e?=
 =?us-ascii?Q?2f3QtYP3KV+rLBviSTYrlP6YnF2swmSh4Dj2OoR/z3riOUdPiUIkQujYyyfd?=
 =?us-ascii?Q?y0pmZ2PVgg80kGGh81BjpcxJT8J3bjaGuUticsCO/xfGEmqaYP5cwzQF/KiA?=
 =?us-ascii?Q?EsuBid4w4nmIhJn3rnDPWAWesjrQUrDkd1+nNT6Xa1c+3D+WHKMp2OhPdRzu?=
 =?us-ascii?Q?dBANi/j/cv1g3TVqxFfQ2GcDhDTt3tI6K2AP6v/6M43reem5pWYKpE94xTqS?=
 =?us-ascii?Q?glMl8IPByBCBHiuP7Hc5XvncwwRrbL2AUswCWXc+5BTDRxkAfnJTHOFdxFMv?=
 =?us-ascii?Q?fHGvT8bKn4DcPjtgoYSHkd5ADVEFFWmFGW69fGPzFMmobG5Bf3m1WSWp/HZx?=
 =?us-ascii?Q?weH67oYr8I5pZD8CwIgl/pInOjsh0d6+IS01wqRa5bgZmrmZNDnaUVqTjBBK?=
 =?us-ascii?Q?j9vwz1B8I2Klrqi12cFLg2YZEL6a6DgEoyTTqNkmYwhEZcOO2TgRE4KieK0C?=
 =?us-ascii?Q?5kzkCDwVWDIZBumvRZFOqd0/MD0TNjdJaXNNKpTRMA1Ao+qtv2SyhTUKG6kx?=
 =?us-ascii?Q?WIfzWzzCY3pnochTpLWoIQDO7dzUBDyhrgLLck+N5LpMm3keAwlgsdya344O?=
 =?us-ascii?Q?WMsubQtnEutDftfnzpBz+cC/Q4IAr230ZYSUXKDk0flds+/dQ+htAgOUudf3?=
 =?us-ascii?Q?A90/V0IgD5P7FFuwp+Kw1ybw11iYQKUlGSum4oag1YV1TPwcu88dLwWf8yMw?=
 =?us-ascii?Q?c+T4xs3PVj4DKNQX7V8jN8yCnSdkrGeSrx1qBHVB17HJEMQxFqsqZBqTLMXg?=
 =?us-ascii?Q?1SfgTSZ6+jFZTqNZRJLCOHR8PlpfnF81UT38cMfBWsb3FfJP0LHCqv0p5ALy?=
 =?us-ascii?Q?pPHIyBwvMFW2jVE6+GY+45jC6G5vBbr+NRNzbyFaEjZ95K91h0imbytSUJnP?=
 =?us-ascii?Q?5ammS9Pcac3gt8/Feh7jcBB2yOo01QRlgsAji9Grx6kq9d4Ize6I8aA2fc2i?=
 =?us-ascii?Q?FLbVMzFPJ1BEP0whzxY6p/k39G7QS/Aoo7M+Ha5CO/YV60LzRhRY9818e9Mj?=
 =?us-ascii?Q?NFk1kvDabh3DK13WJaHgR8in9tAwTqE8hLY8fK5sLAf0T9xfnXatqDlhHWBe?=
 =?us-ascii?Q?OfsrSRX7tHARtI5rHKt+SPOTSRUZN7NVeHANAnrLgqCPS94GDrJvfgVjM6uQ?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9eaxylGaKHZ5xP+VE10XyXbupyyms9BvhLJnn18aS4L6ZcQYnCyWbKBLvT3vBVbW06Z2KZJhC1rwyhrbnXeWnoG1XenTWgbh5fpT3JFMvn2wK3WEEARAJHK6ZegAwa8zzP6UP+Qd5YRoSxY6ndU6r89fDlJiQZrABHQ3WhHtH02DW9KxsWmZ2FfBjWjh7cvC7q6oHeHLhuRLHo+0S6i5wu6uJ4s1qC739N2TPbvVgRQhUOv7C4JWPLb/W2aWUVXgPiLucKNO6bHfBND6+uDanYXo+ILMEzViqrXO937IynJLKCfDhNbEMlbhCjt+4yi9UU2kwbubgmiKskKi+AlgWk3Vsi2Bl8NmSms1aVmQMhOITEXj+tJsgpFjgbjEhlYvrwpJbtKi0tjwzLF5UOdALt4oIaEEC3HfoGcCNwRdrmiYKbNWGlG/G2xTrT8iEc/ij/rMBCmplanKPmMx84TfEHe5aXYQt+XQCUsLDaS9tm/lZCSLJq0MVijMJPcAqLn8JjrgJG4V6aPt/dHkoXcARHfJTaO0J+Lnh0jo0ac8S09kEwVOk+I3ppnvu2BVxVkndFF58ETBu8Bj/QGM6hiu4YugnmJW2twSi7zSrNKAkyPUJ2rVOVDYG2bUkIwD7uOXqJb8SQHKR+p/CG/NxE7Vt8yNWnX7c/fLyArSKFdyg7YehFYIVChDonwywZ1rk32ZCBIuUMH2HlFMWOdryanUNZoywDP2aO1050iwexeOdsrwAG/QJQ+3ahcYSW/7oFhJbrip1BhlEH6DcvIdAvqTMYDHKz/ZZhG6jrk5dxU0idxCfXfsYp8tSGt3Vkn2zV99EstLehTdQ+vlYr0YpVBD9EmHnlobthnB81ZutoUXr9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfd535b-a787-47cf-a741-08db23a5d0f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:32:08.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EKN1ity3l7qjeSQ2cI0UgXwygxYDX3vULtBPxK93ocfoK0qTxmBiQAcF4K+UKpIuwx6Sryt+4AvrX3bb/N5Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-GUID: vAwTx6WtlGugOwCUGLogDmpfMiZSuRRF
X-Proofpoint-ORIG-GUID: vAwTx6WtlGugOwCUGLogDmpfMiZSuRRF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently commands completed via poll mode are not included in the
statistics gathering for deferred completions and missed CPUs.

Poll mode completions should be treated the same as other deferred
completion types, so add poll mode completions to the statistics.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1463e54179bf..073fc02f9fed 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7531,6 +7531,13 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 		}
 		WRITE_ONCE(sd_dp->defer_t, SDEB_DEFER_NONE);
 		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+
+		if (sdebug_statistics) {
+			atomic_inc(&sdebug_completions);
+			if (raw_smp_processor_id() != sd_dp->issuing_cpu)
+				atomic_inc(&sdebug_miss_cpus);
+		}
+
 		scsi_done(scp); /* callback to mid level */
 		num_entries++;
 		spin_lock_irqsave(&sqp->qc_lock, iflags);
-- 
2.35.3

