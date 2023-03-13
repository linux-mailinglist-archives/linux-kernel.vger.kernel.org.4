Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170B06B729E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCMJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCMJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:31:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF121299;
        Mon, 13 Mar 2023 02:31:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CN629d032552;
        Mon, 13 Mar 2023 09:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=36dDPHXcLpMsV0S9kqXd6k2T64d3FwQN/6vyDHhEMCU=;
 b=IbyVeR0/63bm2pYOe6w9O8kXzCCXlF+qrkDUcjqAfQcs0BWqgu6hOorCxupJ0XzS2V+9
 suAvO3qZjNz34qoxcf2i74xcsFXcWMPQJn+BTwMr30zSQnXLdeV98q2W3ypuFXvd5k8q
 Z7y+2PNmWALBpZc08h5aWTS2rS8FK+H0p/EM4/7JWmhx3qIiA9GZfizneU8tnl3eQsGX
 EbAstiCDbi6YTiNTnzBzQX/bO8SLeUJLuzX7p+evywBGtavFtnIAt6PI6vVwTcTo1AUX
 Ijo1xxm7Z2krCjnZQsYFz7fJ/bsU34q/bmCBj7Bkj3XV3qejR8ejVAfLydhHOlT3aGO6 PQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u3b65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D83WMr008260;
        Mon, 13 Mar 2023 09:31:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34cjn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB9vIJlVgi48P2dlnkYWGpN0Cv7uYUfeNOP3SpKPM1+8QDx/t71zfh6zuE96b8wqqoOSKv4i63LJpe7RcfQb5LMaSVvGIMAefDdlfgmCI+aHNTFgLD5lEYuMapQ5K6L63N4D47Bc1L2v/Lw4I401PSg9mChAagqwwI+9X/Uoww8AAZi7LGjDYSPWIJ8AEiopkDDz/GUNCTIV1tTZE0Vgl8sN9oWA9FekN2BFeCAfSdruqE7c2w2b2tjaKylanycQ/kjG+2GiEPvsWdrBL6QguzKhLuhdTzS37AROoSC6vGnQ3RDJp4pbvMZOTsqPDTkUVXI8WyRRm97nWI8PaA5LCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36dDPHXcLpMsV0S9kqXd6k2T64d3FwQN/6vyDHhEMCU=;
 b=kkm+mne92kVeFI+8VKIQkPwDemGdOBj2YxurQooIe2SvGUsehteafQxNRfHNbZk5CJ312n+df2kY9Hmd45FS0HR2jybnerNzlPFRdr6DW7xOLVITwmNofmuZfmT03LWVkRARDyFcdFrX5+hE0dg/4trn0rdNQPrnRLnzJMNa776SaZ9XVnhR7pGSv7t4Rx9fE6G8dk8NC6stntytehbUcP1KHqk0swOtG/nHA2lpfkOh7ej4eTEv/oTFNEKAknAPvTOGTjyWG1NJKMNKmrl2DpkRb37VaWn92hlbJP98Nc3t9as1dgOp9AeSyuXqkfHZLiuUoelfmfmSWd3CKUIZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36dDPHXcLpMsV0S9kqXd6k2T64d3FwQN/6vyDHhEMCU=;
 b=kvIRV4jjZUXXGMgS6Bs6PsOfSG1OpPOIOmlRgVDBNy3aOjgfm1LxKvjyTiaxCzWl3PHVWHW2dy2BpGhU0USaRjfv7uTIFvo3Jc/Tqx93Ppt4OHm63DgFH/iG2PZeedYZHAcOUWDloHSPoNZRNyU6BkivaDLn7qp52PVldmz/JYg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:33 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 04/11] scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
Date:   Mon, 13 Mar 2023 09:31:07 +0000
Message-Id: <20230313093114.1498305-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 860caf8c-dd7e-44ac-c15d-08db23a5bbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKLTMc0Ll/q0pnjIY4Qi70Qn9j9c/7PxtdaPwDasTEUtV6r+i0fO7d/omN6bIZzmJybw2CRbRvz10Uv5lvp8j150wcIDUxTNHpMb18zxxC6DI61Svfa0nM3Cua7Z/S7JNDpOZ9uKngu+Sey8o5GYct/+16dvMtKFkvYnTUEsuvlVKpcHiCb9XQmSpcL1GpHqMvgpUeAsLhlKSYB8D/blQ3Tsa1yCjapLzt3gENdCKWQI0XtrDgVA2j/HAMsFDhAq+WtQespTcko2uWzsheBYbfFKybC4nXjjR4GWhJYVtHjcd061N8gLoNCjgAzS9XnnHO/feAnnv05Ajr98Va7kvdv3ZDyRKY7oJh0PlkyZKlmtxUGMhcd1zTvtfyEcngoXiZjVGpOqebrR52qF4qjG5MXNbhG9+411lbQ574Uf97MWbERVolJVFgbfZQo0nUAyC2PSIP9lgZbTwKXrNV0PC4TwB7zotBXtmJxCe625A+qTIQT1HKZ2b5GQkkG/TvI4ydb+ykytYcLZscaVeZCizhtY0MWxyjijmRIv4NEzAfx8hQKDCbLu1eqd7S55JiXkjIOOZx6AutXMurKCMJtC3qlpwT3eGDktN/3XT0QbYwqrkpdHwUEcQ84K04veNcrdUKae0JKIWTKjk7OChV6QIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YxbTW3RSklOSy5eLyhiaeFehvi1DmJ9xknBImm2grnX6I1AQtyW0IYcj+AOe?=
 =?us-ascii?Q?RWC6Y8ufsNQ8CKuqOqZvtwY3QkqP9aiAJ+SyGQGG1BP2pppfxCqNON2TdOC8?=
 =?us-ascii?Q?2xhwFvOPF+pIGQ/hgJD7WHNNYxKl8Kq8Aw+ky9VTUQEEUOJd509bJYy73oT6?=
 =?us-ascii?Q?kBfFSQ0jIYQ2EUvDZcDHGGBjEkhqKZqJzs2n/JGNJ5CgEP8QTxA4wSfFgoIp?=
 =?us-ascii?Q?AfBEqugpBTfJUpdfVu/nFoVXHVhqdlh9JdTyVz8Y+i/pbTAJp0ZfTTVyaNqH?=
 =?us-ascii?Q?hIA++MmVNqA68st3IksfIqhuDpvAzehInhjxaSUU8aU5vqhj0UoORPtaYH/J?=
 =?us-ascii?Q?YJbJ9ERIDeXf93x0v3zvG6X3tD47g3Rr7ZDUkqsLGw3YJoPRcqMG3dFeGTQW?=
 =?us-ascii?Q?lZiZjcHDtpSbIHfsp40d3fxsRoOu3CGohiefpFGaW0zPRwATUZryRdHL/mCV?=
 =?us-ascii?Q?+SbYxBiqu8ICdtuQcoTcjHRIxCzhZXPCcIwYbr2ZsTt1q5IKf0lu6Jl+nkhL?=
 =?us-ascii?Q?d3OzZEbXLKNmQqr6lFMnLtXovyPC7vHZXGan+aMBmExmAPET4Bp/f/xbI5aj?=
 =?us-ascii?Q?TT21JgyEPHkUBN4H0ArCWuq1IDK2t3IYQWfEjfQRu8D2S8ypvTqnyGoLRxKO?=
 =?us-ascii?Q?AVjPXkbCIQQOtLEPUhtI7plbViSbw4I72ztARy8wOAoOqTmp6RRyk3XkWX3W?=
 =?us-ascii?Q?nKmxYhIXNBUmPsBGn3Qixo5FIzR0nPdtMHRgb49cPi0AcuFQ0TWhYsq/m9r9?=
 =?us-ascii?Q?ZFc7T7QTOjRoIO9CVcIwgud/26NDll5TaUGvoUiMrgmT6RrRGtHt5KVDOI41?=
 =?us-ascii?Q?XoTTPaAhTCjFY+HHgw85P6TL2RdJ2h+G5fqr8ye0ouNTuouZLG6EbPyIEGB4?=
 =?us-ascii?Q?mC8iGh0RTVZjQnctJ6w74gZ8Fjpw4mJOTHex32p0RArm+Qt6YIWzirzAa8wv?=
 =?us-ascii?Q?7XanVaWWVB4Prs+zDpIgf1CmlYr9CLNAXwdankaFYwkSpZ7ZrZSChPz39wCO?=
 =?us-ascii?Q?2so8Z/CVpyoP1l2aIEA7Wr9IwDwV0yuctK1Y8Q0bTvYHs2YRCEpHWuVK/HdI?=
 =?us-ascii?Q?Okjs6Xn5KJ5GLAaoJ1ye8rXlAherOgC/moHml9dYsWFGUEzoK9/ZgL+1sPcz?=
 =?us-ascii?Q?0tfKh9JvBVSoHGcF35j9pIGGTirlwLzCe5QUOr7dyygfwrqwEJPqqcEW2GB5?=
 =?us-ascii?Q?XE/FwFm1Av96reO/ebOSTiShu3Kw5Ba60fdC9r9oWme+6+Fp2mx4qhOWAYww?=
 =?us-ascii?Q?3lCHJWsHgdOlhB7QN/SgH61crm41ArYnWfldsRfVSTjDGAPkMJul70GJQtuY?=
 =?us-ascii?Q?xt5JtmzJJgeRqt2O5xDfwqLRD4YULNwPtE72+wtTLqpynr2hz9n0Z8YpK2Rp?=
 =?us-ascii?Q?r4YlRxASVA/8SeX6Y8vLBsGxC2krktGg4zslATC0UYw3qMnHT9UChqNr3Ub7?=
 =?us-ascii?Q?Gwm166/OB9iB6ZZmEgdqyWCXW7RRIRhYWjgG6xPaHX/GdrbVDhsF/TQHfp8h?=
 =?us-ascii?Q?lc3dQha1VINrv66VPD4J8kdz9EYqhzKVuJX1HM2qmZfBzrokwYOYkJBRElh1?=
 =?us-ascii?Q?2YgIMJRsFMRCkTfXVkbQQPz+HQ5OgZlknvzmVfXTLTHFyTR3QV95fTHufDk0?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4WUkUpmb65U5UIzbWjH1Y5UjbrtwAOtfWytms+nRZT74F/QGNi9q3r3ecce6Bf9TgAncmBoy5Qa8qhhErw06jhuKHCZtU1Zy2zOb9rV0HO4jq5xW0gGUpVA+lOgYKyfmMkfVGy9lJLTJ7Iaf86UHW8owm4XthfCidMmRUKNFUx5Y573ZLS7pPSqIb3t3uYSzLv/mln+wlgkuXwIMnNvdP+cAPLS07fj1pEjmKoylO+0fEm9JKj4LYOsb1kOt/RppBnIdEGKIF0K5zAlQlWlCnuHRa+lbUNNYAuim24u+ZxFNfzE38HQnC/xoGmKJCckgmcHtYivEieKh1UvLaCR063UkKG4LWGN5FhedrPLfGc8TcZM2dXVZosW0oXOqdam1kmuKtiXbsREji7h8zpWhtgB18MUjqYBlaXrD3OXmscYfhmzXAqxFCJeCuPddEjz5NQORU3/yZvrgsADHm/Vdmq7Il+Wj30ZAkpHe5iarKLWD2DLLmAq20jqPLHPboQkeJTGcS0+DRjWorkkwvmprcypgl+avRdFHw6pU2uN9HddHf5eHUX5ro50x5tljXvrg4P+eLnzqBwD1AOKiKeLrJhQf3Zo7Toh1Z30POiddyDKoPeqqYgT3YM0q1LdOJXpSeVaMiitE1vsW3ozVNVLmdp0XZHD6MKVBx9/21kgJ1ciZBPP5o6FDsADqXsQGtj/Tgtk86w7l6XbOu4kvUsaAgY7zYGjFmj/Yfq2ns3dIDhZIsyyJHlkIejb2vn7HiEGp53IQ1j89QOdT0DDUHzS/d3wN47hGxNdyzAwCCAKkTVUVBXqbQFW2CxeVjibfYmezuei5K24gk66wszkY+MJmPuQ0hwKjkbOfuCxbvI2SRtw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860caf8c-dd7e-44ac-c15d-08db23a5bbaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:32.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUakb+9sdwsoZeE3VMLdBJm0A50ZnJ9GYPFh4Yp0mP5Ta4xUlJu9oTLtOJ0jxna8t5/i8sfr43jRzeolu+aOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130077
X-Proofpoint-GUID: pVT8DSAzC1KW-IQeEC58lBfvoyH6JoiH
X-Proofpoint-ORIG-GUID: pVT8DSAzC1KW-IQeEC58lBfvoyH6JoiH
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
addition, its SCSI device pointer would never be NULL (so drop that check
also).

The only caller is scsi_try_bus_device_reset(), and the command and its
device pointer could not be NULL when calling eh_device_reset_handler()
there.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2c2a41b99641..5b51c24f7d09 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5372,17 +5372,16 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 {
+	struct scsi_device *sdp = SCpnt->device;
+	struct sdebug_dev_info *devip = sdp->hostdata;
+
 	++num_dev_resets;
-	if (SCpnt && SCpnt->device) {
-		struct scsi_device *sdp = SCpnt->device;
-		struct sdebug_dev_info *devip =
-				(struct sdebug_dev_info *)sdp->hostdata;
 
-		if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
-			sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-		if (devip)
-			set_bit(SDEBUG_UA_POR, devip->uas_bm);
-	}
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
+		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
+	if (devip)
+		set_bit(SDEBUG_UA_POR, devip->uas_bm);
+
 	return SUCCESS;
 }
 
-- 
2.35.3

