Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9496ADCA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCGK5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCGK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931B5BC8A;
        Tue,  7 Mar 2023 02:56:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327846D9007773;
        Tue, 7 Mar 2023 10:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jTs93JwNEgtN/1ilRQDl0kkIpgUw0uHJTIQj7LpZ/Gg=;
 b=L7x28Xx1k3xwEoCYeKxxxn85SCipqm1PtwuV3jSYIXS09RXz+Qn+XU7Y/isiXATR+HDB
 ZgJIiFDLQQ+WEmWNHfyIuLGq6I8D1WKmFmYr+iAhVWEnWVxyP6qWbPnHCzFmwEieFyDZ
 mbRKKchLLSR6DbYGWZjmYdo2/O4jQDwfq5JWxcoMD3xZ3g2nBiLOXHXXgI1qIpMfB0uo
 3iuoH7JIKWWiv40cAYlSSUNblqq0/97S/cXPf+Wyb6fdyN/Xy3ucJTGYFSE5jI5Tv7Xi
 b32ghEc7slLvK+GGhU1R9BfyAotUM/aJ+WFdu9VGnHpbeGT2Vs5sc8tPsySENrIW2oqX tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn91gx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327AgfEr025120;
        Tue, 7 Mar 2023 10:56:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4ttjtwdy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/8Q35VmAyg/6Zf22MPXd30gOm5PwIjBsDA+gbSt2UD+SFBaIZydllr4KDXcC6KZ/aAWli5cHX8TAJWxXTUll2aKpAmXOl0ubhsB7/shRk9PitjSFDuOVo1ELbxkqTKJCihNjFNWDLaWJexbmgiu2H6cgLy//XD0/9qQk0P6OBJYtgGjdusafMtmn4+hXV7SFuXR4RKT4ADZQYnXFuNtwoY7aUYRKDtfE9Q/Cy3heNKgBt3OlKqxbt6RDuKdExofItDfXJOd/EV0i0pNF2K8p1NoojkLXzndjEKFsjIkAZnSWXp+q8Tffo4urLmL7NJXA4c/uozI4zKWI+okZiGn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTs93JwNEgtN/1ilRQDl0kkIpgUw0uHJTIQj7LpZ/Gg=;
 b=NTXZ4i2kV6W3EpDYSq/JH9Wusf+7UsyA1jdLROz6AdAnXJG6TsnE3mgeD52vn7PF9CTVb0OQO3aGgJ+hLscEV10HlI8qVbuwve4qBcq6aNFvX88l2FSmWF2neQ2LVNXeRC1P3VIdbIRmVnY+p+at4EnaZd6yDPhKziPiVXTFYhDNVpucjgevB/OkQ5SqzkYmH2FRdxI7Yr+pnBdIO7kFGIgMfR5UVt6KBjIulhUKnqrObeo1nMbIeLnxIDeSMJVAWr5kdQB0iiTu4vhkBjK1nC7/BKgUUAR7Z++8Sg5iLm0YHG7PNjeZ2QOWq75q8W6UBbVbWnOTZEfzQMiFF7FVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTs93JwNEgtN/1ilRQDl0kkIpgUw0uHJTIQj7LpZ/Gg=;
 b=znH/OEKWwLLtBVZyCng4/YPL+aLnlxd4xLJM5MYwEiAdT3lILGH9G+1ptZJMFMbaIrLcAvUypb4ZigLaF6ZmKwBTOjzHhn+meu9z3IujiyCfT9NfzoxohU0FGyubDiw4oDeiSKW4hnHI6KZ9K3lQ3PFKHHZXDzGfwCnSm7ZT9Rs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:48 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 10/11] scsi: scsi_debug: Get command abort feature working again
Date:   Tue,  7 Mar 2023 10:55:54 +0000
Message-Id: <20230307105555.3745277-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:5:100::40) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea82c69-81fa-4c3a-4494-08db1efaa664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3LzNIjZaYMOKExyboekoeEzU7uuaXbYxtx7xkZfSi9nIKNWObx5A0+lwx1GzZhFej2sjrckPgQVmpEvhehhdp1vXU9KsljlFaT4WBWisnhlgnfEFZ6/85mnKzbRRkkUfVwprkYaxU/UWojaZpUX6YT3aSmtbc2F5sHNDESvCntPryE+Fs/w5kEQEti8DbmP5kpRg/3hxhdCLUEH5LQhmEXf0y3KU9JRgDm0nuciOeokUTXEKMPiBglwYIrfQ29Plb0sR4KMC6rTjQS+z9DKxwi6RcMI/bmE8US3c47gOeHN008XpX8sbAMdx/EHcNMVynVJryCe9vYI3bhPTc90uBche8yBt9SjxiQ9iAq/caXXv3tWiVQO1V+5/Qh/B1dFbg5nSLkmBot9yV56oPgeGf+jNJkksQW/qkv8OCjjf5fXKxVqoK58NWpfm8rJ0RXyV1ny5Ng9Xt9VaiwXhc6AFk03+XTIxWskeeLu+tW0ubQRXKSD8BporhzfTf1gVHrHssDTb7yN4aVJMAmALIRY/J4NzrcprHGa6SEULiZqFMEEqcqDREt96VsM7lfWoVst0+Qz02wq8EFyFatuiixy+yNtzd4u0oem5B91DEBl7Er+rbqdHXbSHZwb+WXGtGgSDAVtKq4vsTuVzsBLpfZEOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bYAF8cVUF6oSthlCrIQG0Y+NQd4YDCyukzPsyi4vSfXMZ2KTmXN+MpoWJei?=
 =?us-ascii?Q?PFzC/pRNSaxEhub4CES/ae/BLoY9gH+afuXvNKOciTFaxUCQDBsW1fwPaq3h?=
 =?us-ascii?Q?ep3VzR6Cpd1wtHVGWbrkeczb0vzPkZ8oVdolhMZNRGs176nTZe5SCupHI5nf?=
 =?us-ascii?Q?MBNhJ6ZQfGAbJx4me8I0AqJlffmTl8ZKQjr5n59p6h8rckHGcRtZXl0r3ori?=
 =?us-ascii?Q?hHWIu3i644ekml7v6NQOhovPNhCcdpo3rWi34kP/e8jJDEksRgTvmufpNFg8?=
 =?us-ascii?Q?sMHu0C16eHT+tQZO+RKGu57/wfqmc/W11bmObDJYrbPKACF0WotbqV3BXCWP?=
 =?us-ascii?Q?bo0TxU1ntTzvZjZc62Hg43Tz0BmWJ9i3uubuZA3wEDV1CMo5Iepea7crqFY1?=
 =?us-ascii?Q?qrYr/jtNl4i6iBE/rtl+Z4UBWPcJid6gqB+jCRb7S4yfVHg1EaMOnzc9sj+E?=
 =?us-ascii?Q?wJkxKR1SqYliHlZuBBwJcPJzNfuySLOaW2pzT9By2k7UJm4XQUGn/VttlQIw?=
 =?us-ascii?Q?RcZK4bYJ7fHQl1imPpSfRtvyhSH9cLG/VNZBkGT1SF0VEH2iexfWLVD2M5Ra?=
 =?us-ascii?Q?b79w0oP3ENuVYtB12oiocAXn3lN4UUYcXuClVQDdJU3FlGZW2pCiZrbjTHOE?=
 =?us-ascii?Q?LHFuRBt+n6WrPT+BTTC3XtCHBmyLEngGVfwC6ZV/BxfibJpQ+HhRwCs7WQiT?=
 =?us-ascii?Q?mk9Kl1VeFZ1C6XV4Ab2aVevtj9pHG0JyFo3Cg+1qP/wYKF9C4zRKTAvCzDq/?=
 =?us-ascii?Q?y6HzoqsGiv3MqLoCt25DYTWvYcW0GlWpAWyqJZKvxU5RGBalMoU97RQntMkR?=
 =?us-ascii?Q?HHK31jKzz3hShGQjoUx05Y7pD/tAlpO0fFbvuCvVcdX3hA3jHUA+5DiSXrq/?=
 =?us-ascii?Q?m/iroirG9qdHwJC4aM9EC7VgutGTvMBARPFWgB1+aZMa5gRSdpT1XxrGXAcd?=
 =?us-ascii?Q?jFpAS+L3b9Wp+l9iom4dUckNcm4n5kK88UIqRXUa06zlP+AE3+ARM5zS97rS?=
 =?us-ascii?Q?t5JKzTSXgBjOsZONYYvIXf/HQ/hXYwr2yYPiOjB1W0KelPU2pKSlnbw414xN?=
 =?us-ascii?Q?fcclwZqDHztfMl/YzWo4cqusVfJRd0zM/41iJfz1RVvB6AZ5tThwVpw4YDp5?=
 =?us-ascii?Q?8mvEHZ37xFUIFg45YVxAIFHptgeuVnQf7nizRFH9RAXW9X4jWmVOnrb8sYka?=
 =?us-ascii?Q?dwlRb3T7Gu/2Ta1E556hRngQf0GR6YXRG0SAg+psqB8hCFmK5FWEn5rsM+/7?=
 =?us-ascii?Q?6n/u16e1XUJphjHSAC7AXC9CQXI21zdeCBW5P8mdV1NYGQ3dHd+2TIcqONa4?=
 =?us-ascii?Q?3YaVqQfV27u47TmCp8jZQaAbFYMLBbhSx7tO4fUlLsG3xXODXwYHs1rmpQm4?=
 =?us-ascii?Q?GzDnto3L43TwGxXi6aZ1rAy+O8ZTuAeq7vlaI4cUvVqenzunA98kbfixsiAu?=
 =?us-ascii?Q?eJRr6MmxZipIBMncxQLUW3oW2ug1qmZNwCwCVsHxICEkCQ6Rg1kc1ag5xVFl?=
 =?us-ascii?Q?KwtLP97SvVWYZ6ywWPWUaIqcim7p3oNqD4p3FH2cply04iEwDhktisYmjwrg?=
 =?us-ascii?Q?klyK0wRqhuBScucuodZ+3hYDTJuCmIHolMq4Voz1h6CmmGLj2vXcK4Hzfc/m?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZrOOm5j5PVZ9ayjGlHjGaOvBj4jxjCctx8vTafXVJO2NMR8FpaOxzpeLJ4XCMYtrywaPfSlg0+m/CF3pqA++Go2ZKQyX7p/rqXmXQGa73C7pR8rJqkq3jnaEb7XTh/1SkGgMcw5ErQMsa3c9ziHSqmC4A50QSuOMEEaB08iBz68decxnPTLdUFF7hhPqsu+vPdtCOOPtIPQSi7M0iFzu47P6QXQzt2R1Mt82lWkgRZWj3A+3ZHGJej5s9J3sFATSuvv0koEdV2XbgVEv6079IzhgyJ3IaoAfGONdY2EA95s/KSFuLqYXZFY961hPtHs16mfGoPgoNBFn2HjA/Oi/hXht3Ush8BanlBMGM6/k1NGx3xjTiYOD5SrKu5KkFoo2jpXXJtOIvSX7B3j/eKYotwUVX3V3Sem9p1eri58BF+13fqFK0NB201a7EIuKOHQQoc/sQed0hfgrTlRQ1RYFiA7Kxwnqx9Iman67RsTslZTLy/jff/hisF9ff+tCCX3X53npZBvNoIOFuif/IMPPiN07gyEP3Do9d6T4Z1PVkmwGF/asAbA3ycIT5jo7qWdCC0ua3uGRInK0NJftFRjCbhr07lPb67F7WicOU4xDTnJW2Qgy4Fh4Wh0CE3ZYLAFHbgBlid10vRpzBcWECM0QUHtNPpZC3p8jHJENTt7/qt6coef0rUbyIVSQ5ihYT6DPx7/cGfYwOwex/Mr753epsuhmWw033JHA8gFOX4FnJlIPGZARcnRhR/RguVAyLXvfmLg/RSwFr/vCptHH2HZWjAtDYlmch6mNruhehQ7rqc4lipULgoHnHjfdor+T+0iPeK3wvC42t8q9nsTBaNoz2w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea82c69-81fa-4c3a-4494-08db1efaa664
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:48.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++NHwqZUwLbzaq7AqoYsgyqPaf8wtsm8/cdbf/v2rcICn4Dvvp8LSqY++ILbY1njE9im3pqoxL3WkfzQhvF7Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070098
X-Proofpoint-GUID: UwXzWWmvM349DpyMgEX2icKhh2pDuOzV
X-Proofpoint-ORIG-GUID: UwXzWWmvM349DpyMgEX2icKhh2pDuOzV
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
index cf3745d7b8f9..6cf30fceab78 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -4985,7 +4985,8 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 	if (unlikely(aborted)) {
 		if (sdebug_verbose)
-			pr_info("bypassing scsi_done() due to aborted cmd\n");
+			pr_info("bypassing scsi_done() due to aborted cmd, kicking-off EH\n");
+		blk_abort_request(scsi_cmd_to_rq(scp));
 		return;
 	}
 	scsi_done(scp); /* callback to mid level */
@@ -5718,8 +5719,13 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
@@ -5744,13 +5750,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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

