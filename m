Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490926B7174
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCMIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCMIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:46:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13834DBC7;
        Mon, 13 Mar 2023 01:45:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNfBN1011019;
        Mon, 13 Mar 2023 08:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AIiTWATWPyFuTDZUG5HFf0bdHkWMXoIf2fbBo+ky270=;
 b=pb/KEusICC4FGAcF70dKX+PIblV1kHXsuy36aqXYi1w9gqSqCxK9e3B3mBgJ9k9O0SDu
 6Zkdl0btNXaDVTVXCOqq0iypD/T8xDl+79KH3ZSgxjU8DPMWEdImbTG0qYz1dyUy4aLB
 DAxfpt//E3MSwotgqeNNVV1CS0merVLwOICgjKKEralI4oRR7H4svgOSlFU1GX4tc/rk
 AyWRruxnrld4M0WvYWtPYOr/w/cIxbU26yv+kQ2LnUaEElndvjapSOJoNlv/O5H8DLQc
 vfh/iG+ypCikVWPHINSp4ao3hdY2p1use6fwtgea8ElKYiJXRTvyizQ2totKe1u2+mTZ rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhab7s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D83W0k008260;
        Mon, 13 Mar 2023 08:45:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34b4vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbHO0srKUMPVF2amIZ/JlMzxSR3Oq7IvcuVAmuygGhGQIxSHswl0EbAnp8Po5HOuNsUXeDxM3iJ1Nrf2F+kT0cZyKtAmBpos1DgPhBwuV9mBwn7CYZlRRy3JedNToAGOmK7tLmJP8gg/Bn+XN1o+WgPGy5l5kk3lmCgeWfW8U1zDCfLjoNb4hoRnBe2qGBWZNnOB1MHdBHJO/F+YfpkpBdYsUUHJZX1mo+eZXkil+Jm3zW2qfk7zoHNSOzn471LRyswpWIwOs00F3eVYDAOJjdDitvl5WB5jhcZrMFSHLya/sL4+7kC+Kc9Kg8h6qEDn5hRFs5rOk0QHmt1zO+1H5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIiTWATWPyFuTDZUG5HFf0bdHkWMXoIf2fbBo+ky270=;
 b=e1oldIx6WqtcWWL9OkReqhAO/AuH2Jtsq5VRj7WmPwVOlupy0LDNwatbP5MlRSJ9RhArJeuPgaacR+oNHVQX9dPqL6/f9RsG5LDaZRdTqjxc2w9CT9/q1hys7fN1GzOEG6PtgR/iaulH0Yeerqg5+hXZQjoi5iCclGWcTG58EvvGjv0ljmFvl/FvmB6BvN59gIAAckSQEGAG3SKtYWZ/mF4JzZhXh2HUdP62fMIF8o/KJYK4d/Yxx4w/tUjGp7Ff23Fh8i81wlaY8nLWMt4/Wwu7DmuG0zjiHsPtk/0W6ZSiDaaviFgrLO0g4ku1PRc7bmYP32Ld+VrH2DOFydgT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIiTWATWPyFuTDZUG5HFf0bdHkWMXoIf2fbBo+ky270=;
 b=d8XTRT1JL5Q/wX1XHg0kqVfPa2X0p9L3Afd2JL+l7gepPaLfYL4fPLs7opdDrCqO2WLHkmATvZ5LJDlebzFlXdvDA3Do6IuQZSQVXR9iQl/bI5YIYwXSCk/ERTdZj2iNBiaAtOhn8/Q1VkSGGxcET+eUB6djLNeWOnUBIZ4JM5U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:39 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/11] scsi: scsi_debug: Get command abort feature working again
Date:   Mon, 13 Mar 2023 08:45:04 +0000
Message-Id: <20230313084505.1487337-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a58df55-746b-4252-56ae-08db239f5294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOEUclo4GMNo50tc0mrhInwbdnXpYx03aG93ztvOj4/8SX16gpsOOnpmjo2zKB76ARRWcuX6TT+u+yZBom1+vv4OHMEwTsh3J741qh1NmpJmuqEI8gSzk/n1ltAWSUuSkNBEc+IHBsEZ8cK86PzenvzcoLSphzZUDn+ix8qv3HzCC9RNmu8EQZzqM+HUQ6zTWU8SfElZmkAziFMh5M8471m2r12+fIV5EtO0gvzBioW9ics73rYipUvuyuMwaSOcPP1ytz7Ex2RDfhgLzjatGaLfSdmGKMkvW2TFiDFl38ls+lTknSbHtXjeayL6rKRjSl4zSkLOkVpj4nfXJOtTnW2njO7qcPtiwPEV3gnz7Ov0RGemR18jN4i2hl/pkrbXimSG8WfhUd8I9GLETpoNsob/5sa6ik1eDRVcYMNifkWgNFkfpC3GmijuV6PQJFXrtP0bNNBWY8Z4n6lQYZZKAsLfzUhG8XI2I+/IuhDsRAR4KSKXm03s6h0Wl9OOis4RzGvtOU7S2ENWiaHSMuSc2gf/tcWFCOT/7baJAlkoQQPpV2GOeqeAQI56XSrf/LIx+SKYF5oZBjVe7DWComb/XT4Djvo6AsBEVB5w+OJfg7X/j6ufXVmXZGUeEBz3ERfSYGVaElnJhwPNR6kcRFlzUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRwusIl01+sGD4wjLxtz5W7X6gXrZ8VTyQ5h4zJtr3KeshqwiGunlCWC0ALi?=
 =?us-ascii?Q?NWqjuZ/AX4huLmnWp/LO32EY1JUPha8sYIZmSdJgQK/bECh3lMqDv3U5Qice?=
 =?us-ascii?Q?6XA/MyzjjKcZ9q5mdXbBpr/v/RL51KhsPsKZvg8jVPNsWFN5xyAy3wOXBBLq?=
 =?us-ascii?Q?/qpeQktQIXBWkpExjE2P5PgO8avdmxYvYzaxYuCr25c8xmewl9u5+EApGV+g?=
 =?us-ascii?Q?lRJiaLBdkWy5hQynYNt/zE0AB5+qmBTlbm8lZf2Pqlk8DQASVE5pxr41ZlCB?=
 =?us-ascii?Q?74zrLxSSoqgRz7x/zAGKDHFe3cf+2UuEDpoPDXaLqr15RuTz8hjkCSFn/IiG?=
 =?us-ascii?Q?QPQ9FLM/YzU2wmf6cvsUCf/AFvy3poCcJvYVs/SooLxVvAXuLaWMYp/vVpsg?=
 =?us-ascii?Q?oy+07HIdPssb22nVtIrnRbSXMlcH1R6SBFWUZGMkHmLuJP3tIx9h3MfxsGWQ?=
 =?us-ascii?Q?72ARC8yIo1ys0xA3EtDXASCxesrz06kj5ozAlZZ4ysu5D8LhEKcKfOBIBi1f?=
 =?us-ascii?Q?6fgOZSK9ZEdL7lURHrCK31NYS7FTyUWU/yYCXYeV7gpnaVXrwgBC4NmjxZc0?=
 =?us-ascii?Q?XQXGB5Aw6DSuk4yTa9j6MBkxrmEE4NkQ1TqOCPfv2QC2klGT153zoZsE+cqy?=
 =?us-ascii?Q?FO+ncUArX3vRybD/s3W/bPBIRpnxmcP+SXh5xIHDYmz5mxRwN312ZBQmPmwr?=
 =?us-ascii?Q?z1NqURVP5DU4008pbUN3IGJloPvWcIDc7KWvwjvw+MFyAzZKIeKvi9GNN0Bp?=
 =?us-ascii?Q?ayDKDiBwWD8GpD096xOCD5Epkn9AQETEkADBbpexoKgtFeAxtm9UbPCAePCl?=
 =?us-ascii?Q?zSkPRMUHgfJtTDZqDwTaZxuVWMc88EDdMalDmGmn+BpcB32yIr6fhZnoTM7e?=
 =?us-ascii?Q?8LohIJ6YbnjFJkV4rqPIiJ9cXLMc65TGxp3JERveX3tRCr+Nee7bzzyGgX4B?=
 =?us-ascii?Q?wBY+d16zG57bkTLRHxkqfi9E3jTeIpSMnIG+cDlwES8G0XOtyyPnZebUkpoz?=
 =?us-ascii?Q?tvCWkJXXCQTTyO+xdKSRV4M7T29Ghun+F3wKGH9T0XfGZFxUCPIY9eqoVksb?=
 =?us-ascii?Q?mT5yFqOWJ5qyK9IwUa7JJzuO4dPz2uoL+/F7jWwKCssx7rkX5Cb8qM6yyBb8?=
 =?us-ascii?Q?WOZs+CZXQpRrkRNuc4o85Zvp9cYWZGMtjS+QTOTN/omzuq6psn7q433FpqxO?=
 =?us-ascii?Q?BMqWAGeLggJSpxeyJ+tOEak7Jz6H98ybxVMw7AiZYOG2Z2245wKteiHyWSN+?=
 =?us-ascii?Q?j6fsnFcrKEoOQ7VDyNaI8BtKJzzsFzafr1ss/+e0io09PEXl6J0qEgrcu/x7?=
 =?us-ascii?Q?qgiMaoc3Dv94ZDgPbKR1D726ZgVTmA5DpgC71pxQwwPLRxvZyUge38sWfDo2?=
 =?us-ascii?Q?K+T+eP1bSRv5St4lrRrNK4tSPETzBj/Q/Vc17NXfwTkvNgv7kFgfwyWGY8nl?=
 =?us-ascii?Q?fOqy3mjKXIBWyFyTCjvNsEB7YspR80t04uxWJEV/qMdNEzR406/RZwqG0o6A?=
 =?us-ascii?Q?nMfQdRUMUrYbSTVwNgLGHgDlK7YhAVzFs5SEuxjB1Q9cTLR7oIhVIeD7CUDA?=
 =?us-ascii?Q?X3VRVI379CegUN8ZoIr/oQ4qA9Snc/gMqf30uzULSJehtj//kxPRnMLb4APS?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ov2a0+ZltlESu70GnIroCmUOkwcTBU4tjTjp7+WJFKUtcUc7y0rRUJUEZXmoAVQ/VzZgCk8B/pY8PzIlwA8Lk2g2ybASqQBcmvhgsIE85Q1iTpNiDxSMWyIWDfUjVwINeFYLZ9t84JZLjJSBnT2thcwGMZjg0/vAXDnCP5tP/49OWuo6JlSsEUCGD5nKA93RAImzwOoNqhjrNyxkau4BnZktCvfa4gWWp88hiNiRztI3lIkyZ9niQ6Egg4Bs1OBe4nflrSdd0KRaCziZmJfbFDsFCmC3Ikj3UVS6b8U1hbk+bQlUgXlp/Odc7/CN0XkVqr1Pe0Ij7WYJ0ZX5F8Cy4kR38FQRcDA96IXhRpMwv4dy6Dq/OhTzHF8WmyhmmGZ/EOohlbyWn8kgDh7601K6jDi5N3CRY66jV3PlQyzfn5nf6LYzNfZUEGT5xeFIauBEfr0IPQ+2soIHlEYuGEMyAVOlMGdfYk++1I0ByGIcC4hzEkVP0Ew3JIVpD2nzbvRP7rTaCrhx2S8Xppoy+ItLsXV53klNsjSfmGStH1fj2Yn4wmZ7QCAcaAeSuaeR+s91m7Z35tZ0Igtkx6RfzVDc5ouGr+Ft+FhT1FTiUMt3rsuPH3GyzBLfSHsvGu3Jg8y1VIvhwcH8WyuH9e1ahcVoi5mx3UsrN189BHxNj42annVoYqX6eddX3L4RtOufJtBYVc8j8Hz1mXMvzr88yO/ehjifK7i7HDUyN8yXS1X/Z4q38o3FgchPLXvrIHFLs6nfJgEhUyBSQE5Xak7iSCV/yJFwxLsZCirZUZl4g9sp5fynXPuxT46ui0nR+hfvCVL87hsLDR4iwKrCDh/ENd/DmoHnLNEoURtASIIMC36yyqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a58df55-746b-4252-56ae-08db239f5294
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:39.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZUpnOpUEvf9MnDRGKiYDQtw/vzlu/tsyvEAzjRtLume8njAaW88ipnKZsFcbFaftbzgqGMQYycdWzZdT7y/HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130070
X-Proofpoint-GUID: hQHB58_Ug8Kh9bsZfZNFKEGf5TffUVo_
X-Proofpoint-ORIG-GUID: hQHB58_Ug8Kh9bsZfZNFKEGf5TffUVo_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command abort feature allows us to test aborting a command which has
timed-out.

The idea is that for specific commands we just don't call scsi_done() and
allow the request to timeout, which ensures SCSI EH kicks-in we try to
abort the command.

Since commit 4a0c6f432d15 ("scsi: scsi_debug: Add new defer type for
mq_poll") this does not seem to work. The issue is that we clear the
sd_dp->aborted flag in schedule_resp() before the completion callback has
run. When the completion callback actually runs, it calls scsi_done() as
normal as sd_dp->aborted unset. This is all very racy.

Fix by not clearing sd_dp->aborted in schedule_resp(). Also move the call
to blk_abort_request() from schedule_resp() to sdebug_q_cmd_complete(),
which makes the code have a more logical sequence.

I also note that this feature only works for commands which are classed
as "SDEG_RES_IMMED_MASK", but only practically triggered with prior RW
commands. So for my experiment I need to run fio to trigger the error on
the "nth" command (see inject_on_this_cmd()), and then run something like
sg_sync to queue a command to actually trigger the abort.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 449b460e4c1b..1463e54179bf 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4983,7 +4983,8 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (unlikely(aborted)) {
 		if (sdebug_verbose)
-			pr_info("bypassing scsi_done() due to aborted cmd\n");
+			pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
+		blk_abort_request(scsi_cmd_to_rq(scp));
 		return;
 	}
 	scsi_done(scp); /* callback to mid level */
@@ -5712,8 +5713,13 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			sd_dp->issuing_cpu = raw_smp_processor_id();
 	} else {	/* jdelay < 0, use work queue */
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
-			     atomic_read(&sdeb_inject_pending)))
+			     atomic_read(&sdeb_inject_pending))) {
 			sd_dp->aborted = true;
+			atomic_set(&sdeb_inject_pending, 0);
+			sdev_printk(KERN_INFO, sdp, "abort request tag=%#x\n",
+				    blk_mq_unique_tag_to_tag(get_tag(cmnd)));
+		}
+
 		if (polled) {
 			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
@@ -5738,13 +5744,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		}
 		if (sdebug_statistics)
 			sd_dp->issuing_cpu = raw_smp_processor_id();
-		if (unlikely(sd_dp->aborted)) {
-			sdev_printk(KERN_INFO, sdp, "abort request tag %d\n",
-				    scsi_cmd_to_rq(cmnd)->tag);
-			blk_abort_request(scsi_cmd_to_rq(cmnd));
-			atomic_set(&sdeb_inject_pending, 0);
-			sd_dp->aborted = false;
-		}
 	}
 
 	return 0;
-- 
2.35.3

