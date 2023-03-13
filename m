Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE56B7168
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCMIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCMIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DB329145;
        Mon, 13 Mar 2023 01:45:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CN0lJp005179;
        Mon, 13 Mar 2023 08:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JT0I1lmBwY2/I26xELUpQi/FnxBeftdM885RAyK68YI=;
 b=eDVmQs8pZsbPMF2/eV/3LFDfrallp3jh9pAkxhi/zNVu9h18OOg9sv/1i3slpv8mJ4Rq
 qljfbzo6Qw1I/kPe54idA3YFOjleAz10cD84JgoR925ae23fosnJa7oROb5J2AbuIybd
 AyKuTl3DATwN7qJq60PQNHvLyrtZwx5QC0FXn2VKoGA0wSKyarssA4tGGbQFpnZxcaXL
 odwL2kAsj6AqwAcs+gwS+n+Nf5yOcrgiRxijXhCquYG4Ce3YXe4oC7Breumo5fMLPmwG
 8svMAC1+QxE8/67zv3wUtW8X07soaRz2NBUuMtNZyK9FJ9asTL9r6xhIJIiqA/xLMkKN AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhab7rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D6tIlO033575;
        Mon, 13 Mar 2023 08:45:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g343a9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8cZFvaupNFNgvT9ctBxFpBixW3qqm1P/f2KCeJdk9R6Fx+jWs0pIRxtrGa3TszYnptQe+f4KH3npmNpiwTW8onP+zLIwhFETenOtEjeT9M6rk66oApOoiiOOg3FOjj1Vvd5LkiFq+2AqlRfcNVxhEzESaZ3JwXUSxzYdI60IZo/638jbWCatRwPSDsvyjvXteDZdeKA/9YgKRs56CEwqTpvlVFDg0AfNtRtk6roFcCuvnqUaIqY56U4VNM8xkCZLrmJiYEI3w28+EerF9UFnQCcLpQpTi0KcGJQWSn0q1C3gnKg5NkerB8EJi+y5Byo8SWmk1YdMbIHNiGob+QFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT0I1lmBwY2/I26xELUpQi/FnxBeftdM885RAyK68YI=;
 b=A/f0ZMSTgLK35fhKjtpGl8gzNwRr6g6hxd7mWpuZo89IoCJPJPEbtZNsNkPwSwKDWyEoxtV9Hz881+y32XrrQtRhG9X3B2NYgD3uFg2/4giFkF21C6lz94pGM1gpjqnBl0c2ltdZwMiUttrRmpKUi/dvMCKO00oQ/fK3LNXbpVTy6uf08Cad0KzA6a4GOrNaPJaxmocuBwd2A4+Ubjw53fjy/ydNluP+AkD0ByWPyI2QoUpD2VuVk1Twt/4tK/Ps/gzh+9bh8i+2GLjBqqm0I8C+aCsq98iJZ9STRzzqAZft1c1qEeUjGrk6iyu0Wwk6VelW8sZIADx21tE/wS1iRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT0I1lmBwY2/I26xELUpQi/FnxBeftdM885RAyK68YI=;
 b=JSvyn+0kGpcL+CsA7zpx37LFXPXd38lrfH6Txx/cRsQNBwkAn+EMFw38LRVte7uP/K01MuBn32nqJULHuhyw2xab8145p+DGl7GnDnzsuQUNHi5nlhSkPQRHWLTB36YW/rcDHlPB9Oktrl3NUvG59vOP6qtdSExIxbd5v6ECLqw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:36 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/11] scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer check
Date:   Mon, 13 Mar 2023 08:45:02 +0000
Message-Id: <20230313084505.1487337-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 963c57e3-06cb-4e49-b129-08db239f50e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sa0hnsDNumlO8WxN9NHlgMAgvds1D66TrcDPyAAbdr/HHZ6NZfDFWW+hu0XmgyDgNjzMPPoHYYHPQJZOVL8I7ZPuC2OPW+L2BMaDqx9xlEZf3N/XNE3cqGcwvRiDihBqQgMAv1is29EaBZxa2Jbq8miCrZwt874FoPuvDzvqvCG5F+BTXs9SGq1kg5/fO+cOneiSTochx7j+nGOX8EkzqZfvpHHf5pTULTMwMpJ4/807lJJbHwg/Utkx2Ls1gby+7UKkTvC0oBteuGlMJ/zUD73Ur8WvLTRrPyMP92N1dzxeQGHpzo/8q7mTJJkZhEMrAyzNbuwsh/jDMzfiIAjb46pzf+zmmwQE5uVKQ/LFx6ElT2GxncGxF51bXBwcSluEUX0C9Ccfw5L2WmmGL00Jp/VBx1nSDSngFpTPkexl0xCZWGlWV9gyP2MzbVV9MPZ8knpOkzwENGRoQvAUMQrOIjQVNdHJbsCG7ARf6YIV4hN41jOChLQ1Od7/cw4fHk2g0wmjz5tOOa7DPUVS5AKolf85S5xz4QAYhFCoohYcXppSJYrdZGc4bCkYVfcGmthbQsFrCt4iBBCANesWS+gqfthF0NDBhP+0vXHUJTqtr/Jw6LbT6x4z1CePKRnR07ZrGuBHREl4RzNa+3yK6OFL6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(4744005)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJd7QllXxuSmpmVeRGSHID1XyyOFqeMNDTsdyEu8v0YWj8JTWlNhTu+jEe05?=
 =?us-ascii?Q?Lh9jMcfbHWg5SVkQhehtp9tTUHUg7a1gfbMjK/g7F3VDiaHauTzWVmc2TI8y?=
 =?us-ascii?Q?pZK9tU8A1YW+JKbNfQk1P1LVicbHFbuN9ASaul8pPVbeigXfh1eunCivfw9B?=
 =?us-ascii?Q?Eb+am63f602HCgw8XsM7MJX+K+qyCvGo5wjZvmjoKcu2v1xzHs4xshZLc3iN?=
 =?us-ascii?Q?PNU7cglkSoDAVvxJB7Yqjsf4UGsZ/CkhSIbV2kbWEWWUUuCgPQjpMcER6roT?=
 =?us-ascii?Q?iDG80XYvuIpT2LKIiw6JclckRHAHagHa3cFUTTirm2Zblmi0+RXpsBByZc2T?=
 =?us-ascii?Q?RqSABH1Bl23GA9REL+r14kT6IFGrXKHUX82DOB06m7GRMnxmqw69jXbFhoJT?=
 =?us-ascii?Q?1IwA/7mftCk+qn/2oQ1qZ3af98647ZJ4QFeQCKnGYKeEs6i7q5U0UES6TDbY?=
 =?us-ascii?Q?vtLx3dXKb81VUiifWogSxcYAL2xn5U6JRY+Cr4C4bBXMV3S84yfW3ccORWmZ?=
 =?us-ascii?Q?RVH9eBNNVeMfX6aMFnFg5x/8VO2MDc3mLYReqyxtqRpTMMG4vzMLpq50vuqf?=
 =?us-ascii?Q?JYssHBKB1iBj3sk4WW6+aXKyHnIFQ2jma0HpCYJLfFDbTapy2b4wizm7+z8m?=
 =?us-ascii?Q?ZhGzaRjP5otKzaqkqFiweSiYZdMh00I/ed5hoJ5qKluvcyEODmi8gRAlgrk8?=
 =?us-ascii?Q?0qjSXygYyfw225oEpKhiMg51gei4cpPloyqgk6vgrpNfbMmlOpykSKbuzBBs?=
 =?us-ascii?Q?IbFELGMRP32/MWOQK4Lfc36vGsD+/udv2c4t3wC7P3tf6PTJ0uQidLUuVTIB?=
 =?us-ascii?Q?wxu11Jn6ngjqjVE/yJ+nmq//NoFt5EK3iUF/rTLu6qerOgjXwhBjLOi2fDCV?=
 =?us-ascii?Q?IJhkyDL+tcQRiXlStZ1qKcm2wjr5PF4kVFX8QsNtuHaAEMBS6/ekhfOnAJG1?=
 =?us-ascii?Q?kf6bJ1CobYB/DrmzzGJ6GEpETlieUQ88ezSXnf5eEwTiEArmzwsI6e5w54KQ?=
 =?us-ascii?Q?vpQUWO+vYRhToREDnLk3O0d3Igc7Ln79IrQigt7O382S8+6TSUAAiHCfHUGi?=
 =?us-ascii?Q?lnhaDbdGTNqBD68ovPsK2AerC1+XCxI/N4bDrnPuSb5sIdrGa5XLT8RJmgZ/?=
 =?us-ascii?Q?vOAtzGU/BCjJHRW36QAwdpOwi5I0jk6ACwAs71rlOaW2jBol/s9zVd5DFT3/?=
 =?us-ascii?Q?3OlOYr/X03nVg3TJ8QxzljA7GqV9Y3iMiMklvWOVbqgBN9w0opvDMYO9/dOB?=
 =?us-ascii?Q?ElJ0asxOw7reBCDb28bvQmBrfNmI2V8+x6Y7rdjO1kgISmiMzVNc5gxlKkAx?=
 =?us-ascii?Q?L/Ox7kP8j3OEOn6p9IcVIPDoG/fUk8gbRDK5tdYkMlOAQ+kPfP4f012H17ED?=
 =?us-ascii?Q?LOna6RZ05kxt4hw06O/gVl5zhPs5oASF9/yESnaME/iAX6kJsbTMvZ+14C62?=
 =?us-ascii?Q?t5PDupW8Q6slGVQ9R5b6pYZ+Of//aypKKFsL5MgI6K0pCIWLjF0zlZC5lQ/9?=
 =?us-ascii?Q?IpGyDCXj36xhMpCdiIVlcj51KibQoAXFw5Cs0rO0xNc14BPCfgLd/AoSfefU?=
 =?us-ascii?Q?bOVJobndSMtde/Fm4FWyY9UVXmulVulhwCz628xZFtD+J7k9P+zgU7gnOxnO?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IFt6ny+AUvTyyMyA7YWrptVeZJ+c3PWgjdaVsmdah3RR0/u29Ch7USmEckqA7M2F1u7dG5J0mFLGXbVuD2Z1tjTKbccs91kxuJETCUJ719LHFQAHkMAgjuaMkw5w/KDQQIb54oxg/jGeaLUTCo8OIEYPmiC6DKSdJNdKtMmDR/xwQR+p1wnnxC9yCRit39lwOtpzHPgchNHxBnEyFwrWbQl/+USsAd9xau5f/1c2W5DQ1iCi/L/UNheGnXd+6ieg9xsGfyVmB8uymPBcx8wif42qK8MGRw6vQspxBx7tOKX7mgIglZFuT2qJO430Iukc8/y8Ls6lbl+yYmvKkV14rntM9iiockZvhVmeQlnKCjOQYTYECesHtfFHUN9BBygA8yNXEGwYr/BmcyOaACy+telvD1AbE68ST1CECd8TAmPX6uKXrQ2P8RKJ74FN1ixLacdL94pxSRqcc/IM/ZoweflEEZnCjClGnDcBLJoSf+Z4fuWF+NFrTqddS2eLTHaqLOWtiM3o/0zB/Ky4tvOl7os2NG6Omp39BRrhnS/TDORbBpirsQ01vp/HDDVh1Hs9q37HeNgxt0dWL9e7q43lloqDEVwCVY8Z/uG1xA6h+Fhk+5U7fXdBbCA9hoZ7IzTWVmMNKYAQVY6Dew22SQBRdltFg/TVZtOO3h7dUZT1v19BPTF0gfvML43i3QynlI8qNE+GZQfNWbennWxDE5lkEX2ERBM5rDP2uwyCRVT4amB/46zSpduuNIczqWnCCAQ6uptA9yLe0/Z5xCl4O6tf2RXjF3dvLj8ryEBpXAwHc3/2NjVMcnPuNZY8ZWZPJLICFqpzcsbztnyM2jKy8KtwuaB1oTvM1VL/v2kgRPVv03k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963c57e3-06cb-4e49-b129-08db239f50e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:36.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw/n6Fq7JTlFGkpmDAz3mhsiWB/VuzCKuRS9t0N7bEHmke/RWAziDFhDCb35S+aiuwXCJ6QNp5enjUl0TnxogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-GUID: KnIuZP1N7orhC0GPR893yP3L2NMVBYk7
X-Proofpoint-ORIG-GUID: KnIuZP1N7orhC0GPR893yP3L2NMVBYk7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for device pointer for the SCSI command is unnecessary, so drop
it.

The only caller is scsi_try_host_reset() -> eh_host_reset_handler(),
and there that pointer cannot be NULL.

Indeed, there is already code later in the same function which does not
check the device pointer for the SCSI command.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 749358b48335..47820b9f6326 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5440,7 +5440,7 @@ static int scsi_debug_host_reset(struct scsi_cmnd *SCpnt)
 	int k = 0;
 
 	++num_host_resets;
-	if ((SCpnt->device) && (SDEBUG_OPT_ALL_NOISE & sdebug_opts))
+	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, SCpnt->device, "%s\n", __func__);
 	spin_lock(&sdebug_host_list_lock);
 	list_for_each_entry(sdbg_host, &sdebug_host_list, host_list) {
-- 
2.35.3

