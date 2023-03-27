Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAADD6C9C94
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjC0HoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjC0Hnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0980219A3;
        Mon, 27 Mar 2023 00:43:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7ZAsL021894;
        Mon, 27 Mar 2023 07:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CTPolVlOjH3rGDI7HOnmsS+cX2W5umFbzmjcwbFzghM=;
 b=fPakMDu+aZPNyMgPMLy1YTdSOF2XTTb8eocJQCbBFTUl7CsmDDegIXIC7Z08vh05kTRV
 UB7iPdN7PLYsiXUu/eDcZ9wkPRdiZfw1a6q0HEMJVdXw7VRpX9tFziDTdCyV77hK7OGj
 yFdaaehmkEWtJcpYQ3M1Fxji/gNzBaZRfPUyD5cGPnHdg2v/TKBGd1LlB4DlPxvi2RH+
 tZ/LMOP7bNDqhGfN4stiEKLFGXcrcj3h5Ukfka9TuJa17InI0gPDdAOSfawGRPCRq40x
 jV4yvz7uukwNJ/c4ZbjcoWr2tyauwklBXdIrKVAnJHGXXu7ESLi1eKP64jZlNJC+rcJl lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6vmr13t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R7g6O9005488;
        Mon, 27 Mar 2023 07:43:23 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4d57f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9l7kpoKOEGHUhRoQ83K58H+j4ysIfbMZz1whT9V37LFDOuSShnO/Dmo51cdolpFfvFMcAHaLu7Y1q7+a5wxd2KKNYz3ElcUMWStG12p/A+m1MdxWc7QMsKf63aGWiC7Rj4eRtzeDR5GoEuT76Al382st2IK6GTzrmFzOyxDjYK+UxtJf6aZhfnnqIeM0IHAxwNK1QwSoU6CFjIFpYwxAcezzzLdNNwO4uvHAUZOWJhngut9SyXAy/lh3GaXZBpn/sPocSqcV4hZOKzlG44LDA48MZr61WQO0Tin2IQajjCih6Xm3Hpip1GFMgQABZYh8BuQ6I5rUid2+ckGIv9ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTPolVlOjH3rGDI7HOnmsS+cX2W5umFbzmjcwbFzghM=;
 b=ctpWafmLzFkwSATS6ac6ISnr+uUvjiV9B0PEHSfMGcY+/m/q9Ti0rNWsx6e8kOF6zv8q5gwal46rOinJlll9nIWqb77UU9JBXbM6BFP9JVCU+WzWN3MtX/aTYGCrB5mcuZYZXsNkttSnvXfi9bJeY2ZA2mGyTDPVFI6di4WGTMvoTh/gwqb9S4c3fsEtgE2hSkA4eClUzNL0jihRSs0Pk50fjb6UncGTMCD43btI4sljBHcYgzRqUJzmC+KhSYvZl3i6J52rhc/s+8JLFwV+CFXlIfTo6SulEO2VgwPHgflnSKkrKLfdDqU+VrD4w1VPPR/doBmQl2lwOyWuNmo3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTPolVlOjH3rGDI7HOnmsS+cX2W5umFbzmjcwbFzghM=;
 b=RJkelobwHN5iI+Z7M6X+uvThMzcm4p95jNsJMErWp3r+mRy9YEUGtb87pTLIjTi1/Dehj9I8I7I+iFiqkAt1UmjSHEz2tHdu71ibzkAGimkl9GziLx9fGi33FBDXYRIsVUXZhX+0+KBVP3SKYz0v+e8Z6ZCVJOTslRNb21kMtMo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:21 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 02/11] scsi: scsi_debug: Don't iter all shosts in clear_luns_changed_on_target()
Date:   Mon, 27 Mar 2023 07:43:01 +0000
Message-Id: <20230327074310.1862889-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327074310.1862889-1-john.g.garry@oracle.com>
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:5:335::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a69e6e-548d-48d4-b5f7-08db2e96f053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIclQ1o/Hasx1PVyU1l6qGMtRgbZPY5pKhtulx+Dv46fl0fEB9pMOsqn7oaJdHy6tQSsJOtQ6y89V83aecAlOLRzrjuFDxsWYnW9daEnLi/Xw0s0tQ1/xpZaQxfhZyEo3iHKG5iHmVHfNny5n+TnnkMKE5c/7ALkP98Sev093wp651yVw6MpjmFeFBuzzGFjapsJKaXMK3XnvwnfDArSK9oGc40Vz7eZ+w7dKhHd2b5PE7mTxUpNMHjh56cn95M4qWne0J/pHEXcYn+An1E/ycv+fwh6GHjH13rqbfjIvpmppoazJTr6/TqEJtgDmxayYu5r0gbQn3EsLMLe06o7hx+ng7l5qn59ogk45+k8cuq29fLcMZwUkSS57H0HMsCIs8A8D/HA4HSQOePLJ/Fl5bdq+Rpf24fAt6VpC6jUrOSpCX446yO3mBlnBcYfAzEPxLNPuQyf0zKLyffQrLHRwbn73G8EiRyXXa5AVYsUTVYLI2KS4pu7NpDtsmV/dXX8E3gzEcyw0RG/WZvTuNvHMQHeg3hyF7vGgrJMEP/Fr9Eb2KPkXeWT2m//wBnR92U8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3uOgYgX/yO5Mor1BDndTcp4jzCAEUQ8UE5N3E+tjZrFsReAo3/FNRv2EBjYb?=
 =?us-ascii?Q?8MQWDEh9O3J7k0KZ2LdeEm/kFh/sqyLyDxHsOiiHuApLi9cgQh3tg4KPF9LH?=
 =?us-ascii?Q?pWV2Sf/3xAqK14+EGTDa+KIV96zUI1lxHC4/sXHORuuvH3S2PkLeGdL9EsSe?=
 =?us-ascii?Q?1TemcK/YKwtDTgheqfFcJo29L+1vvkZa3w+rCzeRrWEzWYU0UWG1s6zkXBDH?=
 =?us-ascii?Q?9K4lrzgQe5kscjIBfOjAPvyKI23ahT6ZdvQ9kkv//5S8sBuxc6f5qYHeIw0m?=
 =?us-ascii?Q?tIl8fwVa2n0dpCt3r9rfEyd2gUg41yhwRwtJsK9BCtQr8CGQaZ0RElaNmvaq?=
 =?us-ascii?Q?u7iVDykLL7saCZ/WTxG3bwO4i8p83S7rqqGo8UJv6IjbWc77mwXn3Eh+KN9+?=
 =?us-ascii?Q?0vkahnnQsCG37kwVnuCrPqzH/7AqR4CF1yJTfsh8vw6qeftgm7y3VutTRKT3?=
 =?us-ascii?Q?zfBNqfXezIJaB1pDJDTnZiOZ6jfQ4zgfjR2cY47JSO/UugLAow6E+QKRKGrJ?=
 =?us-ascii?Q?70wKEb1kHmyzN9A+cpc35Jx2dR2iYv/mmIZp5dT0hnCHJti6k645H6V7AIVs?=
 =?us-ascii?Q?yeKFG7Y3xHk/uYdOGn4oboYJWrj1aQda3Us8ZOYVH+C1Y4pDjaGPhkkPKwG/?=
 =?us-ascii?Q?wBKw5V1E+6QxlkAgLErFU4AteRCBM1JSNjVV2BqxAQE/S68b3Jtir2XYlhZh?=
 =?us-ascii?Q?7YxHUF7MzskQdHxZPbv5FXFy7q4jTNlQObumuF7LvIBP3CBL2SXkdSsbWVkH?=
 =?us-ascii?Q?krRPczGL+ovslZ1c1iZDw9dN/Uy1Hmn8zCpVJA41gkunFAaGQFNxctjWKOaJ?=
 =?us-ascii?Q?esrSUI4VC7y4/mSRjSjY+h5zcJwxqVVO49jShjLonyoGcxsJUuBgVhKNsnEC?=
 =?us-ascii?Q?BnMdE6jtPPtSPhvCeBcz2YssltzehcG66w4Ptq4A9hJ70Aue/dBtjhpZBL6M?=
 =?us-ascii?Q?aLt3oSg5yhh1IcQwyB8ORb6EiZ4+CenkJpkklRvXF8hSbhTvdRri8HcYhc4U?=
 =?us-ascii?Q?Ugwctyxx5pXfUaLircdPKihSSqwk+i0EZohrPOfpJJ3OLUshGwYEu80vG8dk?=
 =?us-ascii?Q?KvbUQnJZKV/xrJJofW4yYtYDCSGfoXAeC10CM96RksjIsk+7z4teqyQ3w4VF?=
 =?us-ascii?Q?K/PKnTi5Vy33z9Ax6uagt+Y1jn23DAyxdnx5l4DPbEBidaVjS121E1ihO4sd?=
 =?us-ascii?Q?o4ovDAeTdE2lVMstf8vf1JnUz1Gxcy+3nj6E453OoMN5KL9JBZApe6ntWJrv?=
 =?us-ascii?Q?n+5ERg96sQvn6sAAiIhR2SrHSdk4EgVTP6qgSjTWbpkFEjLB07s+TrWc5R+L?=
 =?us-ascii?Q?aEwumJ6iTFAURQPdcAiVfYBTyfDuSZrgvSXKSpG4hLumES3rFineNtrTg9eL?=
 =?us-ascii?Q?Z4EdQduBCwYtYLzbIFg4VIjMk+M6SDoy9z2OxVMjEPNF1VrpsxgWs2xgd3Gs?=
 =?us-ascii?Q?0dq//kjfxy9wZoIZ7X634AB4QvkWkN/OEXeh8hRTCjDKh9V5yf/354iWNpmT?=
 =?us-ascii?Q?QsBkFZ+2FSsHyQhq8kHIIO9DbP+7dVjKXtQBKzN10JdGRMQ9nZ3ucv+adgtZ?=
 =?us-ascii?Q?mjQQEgqam53DSx9mzSorXGRPlTzk/yAr4GkwmATY+cpaY4bQFUEOCJDiCK8f?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EbYuII+OQftvaYH4+8X8z0JNgjpNpEXWs4elWnFeiL2nuK4mPzG5ewewkXgDXzUgKhPBq2xRAWFAHh9YJw3Mbz5SeSXIDdj7OguOyY/BVpp96+ZnklXz6wEOaKD8WBrXSmyNmQ/rYZfxVvXYFethE5QyKLCZZrYGZCsu5djFQEaxHhZlgiWX6QS2fmpZ7AjEa6Kh4v8AEi1rAqWYwig/q/zpTnkIXmvZeTdCRGwA7564j+smEmtxHqUS4TVQfMQfLKWzB/Y8dhP10D7E0EFDYr95vage4+TjmyXdGoix5qB4qougNEJR3va78xy3Fhhc6jdmLl/RtgZ4uDIFpYSLl5SrVXhHBLiIWEOgGEE9bmDbSQyFfgVe/Z4gWZt/f/Iz2aqs4XA+JvSoqZP8i1h3luInoP52yD6UCoBVbTMrgrAvym51fT8gzeU3O246bhS8eA4tu8cu7alDjzBV75HYdxy7uDtKQntDbBuUD1AC66dZdBcGAswJb0MUK10wFuSVvU3GFUQunI5P0vlrLckNOQjS/xjynyo4UfIYMsLjy19NSmOAskpzVbarzjT51CJGbplPiap/z6KRs/ZDU+ZRQ7e3zfK3LVG88JSgpf/0/I34gx6Rc6cU0kWo3k7J/OFLSucxa27U5jHMw6AxdbbwsuuUqYlEqtI9d3G0F82eNZFR6Osb/azExWkaBx5sPPWV8qDQM/42QDKC73AqglQrQMPKZLJXKSEvLqE71+fBy+aHJheTcPjGrD/sCIH5XXcSIBWc5BDd7aWPi7mM9WvF5HsljBCNGxHOPUWnltdi0vt0LGVzGjT9gE58wuZUpjC4Pi6JbTtVw2lqE1ltz2iFKxvKq/IEF5NXV4R7DA/tQqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a69e6e-548d-48d4-b5f7-08db2e96f053
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:21.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQp1AV6dSIVtEh2gFTj0+P1vzsPyij/m3bysRC3BHXvc1yRzvyETLNhKaXdqrjFMxUgNua/Z3pe6H2/bSrCRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Proofpoint-ORIG-GUID: E4bcptEgjTaHcCUNOOELuuaEYSoo7d4v
X-Proofpoint-GUID: E4bcptEgjTaHcCUNOOELuuaEYSoo7d4v
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clear_luns_changed_on_target(), we iter all devices for all shosts to
conditionally clear the SDEBUG_UA_LUNS_CHANGED flag in the per-device
uas_bm.

One condition to see whether we clear the flag is to test whether the host
for the device under consideration is the same as the matching device's
(devip) host. This check will only ever pass for devices for the same
shost, so only iter the devices for the matching device shost.

We can now drop the spinlock'ing of the sdebug_host_list_lock in the same
function. This will allow us to use a mutex instead of the spinlock for
the global shost lock, as clear_luns_changed_on_target() could be called
in non-blocking context, in scsi_debug_queuecommand() -> make_ua() ->
clear_luns_changed_on_target() (which is why required a spinlock).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 782515abca2c..eba6eca81e84 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1063,18 +1063,15 @@ static void all_config_cdb_len(void)
 
 static void clear_luns_changed_on_target(struct sdebug_dev_info *devip)
 {
-	struct sdebug_host_info *sdhp;
+	struct sdebug_host_info *sdhp = devip->sdbg_host;
 	struct sdebug_dev_info *dp;
 
-	spin_lock(&sdebug_host_list_lock);
-	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
-		list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
-			if ((devip->sdbg_host == dp->sdbg_host) &&
-			    (devip->target == dp->target))
-				clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
+	list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
+		if ((devip->sdbg_host == dp->sdbg_host) &&
+		    (devip->target == dp->target)) {
+			clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
 		}
 	}
-	spin_unlock(&sdebug_host_list_lock);
 }
 
 static int make_ua(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
-- 
2.35.3

