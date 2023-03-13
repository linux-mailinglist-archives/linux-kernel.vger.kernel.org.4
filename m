Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49C6B7164
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCMIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCMIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C6274A0;
        Mon, 13 Mar 2023 01:45:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMWwJ2001346;
        Mon, 13 Mar 2023 08:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=F7DOKRf4GwxnVrEMQXHFYO8VfuWsdW4fBG+9/Nk6PJ8=;
 b=Z5qk1JJXsRbLqMiB/yVj3E5fpXV2SjEs+lIR21GZASUA/sRM1sXIIhFPiaKe3HdOw15W
 rThwZ4pjhIsPm1YJ9FHN0gcCo/YmDNK7uELCRbRm7FDRdSiQoqLU+miVmpdmTZwlQg6a
 iRSXLb0yL2oZsCsiQ4cFPzHomM30AvGNQzXuldrW7XbeKGHP09LYXIN1SXW3JqPZrMtA
 w/EuipBUkeIHm5sF3WH5nHwbbDrs0SozbVBvkPxLjuUUyj0Z4BcW5Mu2+9Sz4kKTpeef
 d4GOjMa3cKyHom4S5FJrYMS+dbFNOb51RL0nDHHOpy5fhTd1duKaeJt4fHhp4JIYczDE +Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8h8tb7y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7NBJx024989;
        Mon, 13 Mar 2023 08:45:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34bjuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebPA2JkFpTbzJ8obEcGIciaUWwF08BsizKzPZ2IocIatHlztUMplvP8ybMSYZbnzOPZ64WLnJA85KmTT/d+xfWYFOwYL1PcAh9jX6jAh8C3Om15Az1Ar8JiKLzxAx4/TNFFquvRjrYXAmCTGw6cw0r9l3UVrk8qzGy4TRfpDP21qGPRieNINSXQCI2tiyJjimXl3KGRkIzstXuqBXtqX8WbCBe6lu0nq2PPUiimxS0LIeSlU98gr2zbebsJKlSEo+7d0+LyYTDsem4bqe+8GeEUiRGUO05eOhzhbhwBet8F/aqqUnkGG62Z2addrYPfldLG5LAKbiDNszk6Vzz6yZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7DOKRf4GwxnVrEMQXHFYO8VfuWsdW4fBG+9/Nk6PJ8=;
 b=ChKNamKZOLXBjXeIeD+Z/tpiC+lIh7+tgzQLV/5KhACojHPyJCG6d1P94mbqj9CaXU2IIMVREnGI6VNi+wu5HDSW4sNOvaZHuZLfZtU/aVHtLfbxHeBI+pOAJnhkBd0igQqTAwvyQOiH/NK41022piOyasa1cRSXhNy2Otx+/zCpcsoUEBwIvB69zXYtU57SrtFzbkNgsyjYNPb+6aZAnAPBqYIP1BKPUyMXRvH867dx3aE5KORsPLr/ofVu4Ri5FCzXfUkHwsmUZ7hNmT3YZLxhJCWOHlpNOrmUIhqojkxM0p72wB2tLYnNS9YL8keoGO6lnSsBmXZEBhjVWeuekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7DOKRf4GwxnVrEMQXHFYO8VfuWsdW4fBG+9/Nk6PJ8=;
 b=wgII5TAG7Cl5SMeB0RQ8fhbqr1nPYZ10EKMFVNq7Fh/pMyV+wx9/A6eCVoI2MA9IEVNQqdjWKFlETfVa2u6vVwUAR/ESgpbbwG/O2nqvWGinsPLDKUvNFMEWcEJcquiW658/aFzjTBTKPOIvkD5Nw+qmv5ONVC1p5Odt1ZbUHdA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:28 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/11] scsi: scsi_debug: Stop setting devip->sdbg_host twice
Date:   Mon, 13 Mar 2023 08:44:57 +0000
Message-Id: <20230313084505.1487337-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313084505.1487337-1-john.g.garry@oracle.com>
References: <20230313084505.1487337-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:2d::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 8186e702-83f5-4e62-5eed-08db239f4bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPtVtioR32qH811D7E4wdZTw4+ojmygqqQiaNU31LhqJGDAUcHiRslt5hz+ZRdVzLIluAG+Ohr5CbTewC7mt/utoZEvbh5/L9+t1Ruk7syMpBX+7mNb5hCxCmxhZhT+2Xq28wPaLQH7KJc2wcvw60ZjfIz6JYsnPAuXydBPBElET/+Q8GYqN48FswAXSaQvrc1qKlKG4BZ0iJhi3F0e+iOwDNG2v3fAbqNYCrbQKP6REpORcMj1yLQVBhfznjzdMFZWf8FX3VeKTkvh276wuBethvXAQzPWNpjOmn8qMS/FWFOeh2tyyIlSsVKTy8COl+YnLUuLMcGmbhDWvRIq99tMX5/SEBE+pYJP8YNEEyV/cT/1vPF6rKKWPYIrbBqdNCyJWuJZCGpEYuDg22dQBQGn/HPNlaXN+kxENm+bDGm0CxX9wIp74kAQNKb++orv7RwPMIkguCA64Z7r2atlINDGv5wEVcKVQ1s06RGTevgHt7TiYV5q+iWLoV1JCzFbZCv/KTdmKdE9Iya0RDzcx/XqYvAjlRQd94qNzdJoVXdIlgD0Dl+PcSAhEZsEIAeLOUmy+ao6p+vLWsYE5JABan1jjfdVrWe6g1chFUxD4DZRHrVW5KYWxpSTkB9lXFv1U3m89rTlU0CqVfO2DcghigA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(4744005)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G42TkTzxHFRhglm2IU5c9CsqmtCrcqlUxybTx2/XjW0etYZdxfBH1pZmirhB?=
 =?us-ascii?Q?LQDc9a1nZE+RkVhQEEApm58OYGsRK/kWhVs23yCB4IcE4H3MYMpadXrPRRXW?=
 =?us-ascii?Q?zKIAJ1oLwRjkORgorlXAu1CuW5fc4Bemvc7QMFdUEYaKagG3tEAAfiYHjQ93?=
 =?us-ascii?Q?pojskC5mN+bTHSsTy3NIDqs77rV9lNYnYYBoQ637bL9Glyzc94hErCEYuRad?=
 =?us-ascii?Q?JPR0dO343BFNEp9tdot+KVYf8ga5Acp/Lv62OncPxw6cw2adH+V68nnqypid?=
 =?us-ascii?Q?ixm12MttLzSgUAOGFvcCX+c3K9wBslcVMPohyv0rcBFo8MNXmkLuyAvSc45s?=
 =?us-ascii?Q?LSkNoyIT3Y3qn/Y7y6H4Xf9Fkr4VCTWBgqQA4CJWPdQkNV9MA+udfgPIFIkd?=
 =?us-ascii?Q?HhAA0YrfK8lK41IK2EPvRL21/NgX4kShx4e/eBhkhW/FNxgBq8DLiTUlCP+M?=
 =?us-ascii?Q?F2LQAC+3PodFvviJRPePZTug7ZUPI+ACcpeThppaUTdyZnCQPmhLNljiMdM2?=
 =?us-ascii?Q?WzezZfG6d0TkGTs4T+1IQtPd4BHl+Ck8SfuKcf5BZRFAvvUdUchLbcdK/Fyv?=
 =?us-ascii?Q?DfLp54nJlALFf1FWwMrc9fhRUt78UtdtkrFIY67wFShbT/JzZHg3aZvHCIgu?=
 =?us-ascii?Q?ewXhVmeRvNTyp8LZYPdN6YrXdl3bhXyhaA9kguwKYrn3U0oe/lrGO4BZKIy4?=
 =?us-ascii?Q?tUECDa+v2LHAdVAOdc6EY+pxd8mvKj8SI6s0sChBCTat0gbO+kcN8ptJhgTG?=
 =?us-ascii?Q?7VHFMk7XLRDMzKItbShLWfNthsCz/D6UeOP9gLbiUJLTeFqa0GqiBLG5pe6L?=
 =?us-ascii?Q?97BxOWfT1Sj12tarhg1h8NCJTv3tb7sXCftu/lToKHjotLtuNhkGOguijKIT?=
 =?us-ascii?Q?VmcX4tA3MzV37WnnsExU6N7az5D0jPRDC0BwF8iXWLZ4BZ43UacZLZfj9vPW?=
 =?us-ascii?Q?nMIJ/4BGt24rqPHM+ZQudW/trr3iColPpuzFR16f96nWgsQkOwps9K6xFljo?=
 =?us-ascii?Q?38zcY2vBfqAQOccyf2+joG8daraNIVUieJ7aLscIkjz0rGXBdXVY9pMbsuVA?=
 =?us-ascii?Q?803LhSeTeyj/ZHDT6k89otKEVhKCGuIgWTJmumm7WUOs7iV9YDEvH1OfFvY3?=
 =?us-ascii?Q?MRXq/O3Iq4b39uZUNZZEzGaWexY7DALQlKIVH414n4xa0I8pDz3k3hyoiwxe?=
 =?us-ascii?Q?fAZE3IMlio4olKJf6CWVNAC5FCeChlueMavn8v2Dpzw5Gne4xgo+4MdK2J0M?=
 =?us-ascii?Q?ihzPW60vVwIAS4eoa3DfMBSuQGEnGE7ONhKa3ttvlkx5+vARxi+GZ2t/wOp3?=
 =?us-ascii?Q?9TClvogkK+oHGj/AIYuUcq17P33vnCkakG4IZRlNXgH46Oybl0M1g8Yk8ZF1?=
 =?us-ascii?Q?o23MV3gUJ/N7aAGEurJOkacMfvb73aYCeUpmgiLcZrvZFgJuGhIYFfD4i+kj?=
 =?us-ascii?Q?6+Y7aDqo5vGdhg/Dsg19SfGeNl8drFzFJ7tL4WDpfX1qcKlc4wvN5c+9T1Jl?=
 =?us-ascii?Q?Hd7LxQQjT3/qIZFet1WU0aePL4rSZkwaBkOfpfehfmeWf9i6soxdj4TAN86c?=
 =?us-ascii?Q?+22DfbxkWm3+zHhSnzR4JjEXPDBgzSGpB1Z+DwQU6k8/Uk9d9DzGU4y6dbVz?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DIC9T9d7YWY+HtxiFy2UkFILxDjj7ZJUO+W4/gK8y93Ndw1fV+63g9B7Wo0RL5Huyw2LTP/AsaPIG05Tp3XT7vFVMe4uPBwcgaIVcx24sXCsYxkC6wgLBJGNNFtAh1GATMsLnT6vhxMlTGgX5RGCYYyYi5famjHfvXM0hynIIXgdosSGDiBc9bqIUyjh+p9ESO/eT9mm+lajwN/QhJ+RQnRloTa6806CeuRTXza1KNHC9tQA5FoKI1lCkU8tDSNHt08lUNAQtIidCnzQ/5U+ZTKD1EHSiUQMedi/EOFQ85oub20gx9M6dPVTdMglCHFVF3dajXuWIuHqv71qVDNMvMxmyecbGEksRm/X7QcYw9eM4F1pxK8RXMAdO86FulRa4f3DilNKYmIwRyX7WzrbwOzdn9DkcgDdDJ7vQ2S+XLTg8uxMs5ohsNdjdG+MKJ1aSXLJIm5hzdfUv7GVsC1+dU1uCBXSv3b6lb0dEt7+CPgd7LfKzkkPyyYSPL2kNYyJRyadYRSwB7xrDHjV1/cjMAuZMNv6VwUZzbiNYoNjwkirQV0wvq6suRhCNyd6tvaAufL6tUs3ICoJw2T+djZVY2QMcHN6XajvK/fhgu9Al+9GqLFmG0Eq37SQSyORcIOweQRKi3DJ0w/bkpt8MqekllwGM48lDPYmI/qWz51Qu7lCe9/kpau4oSThWN9wbeTQsToHGzI9jR2pZW+quoCiq0Cv0pqHfZvEv1BlGuGVTXBvwznfoBsMVry/tlgdW/VdJcUV7+xqAoZU+gNohU1Eg17PJUBs6xQg1iSImoujP//qqPgJKpEw4osZFaEL2OpJQ+l2VMy8x9A4kNdMtWBILeVThBVrSR8ZaERl3YTRYfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8186e702-83f5-4e62-5eed-08db239f4bfe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:28.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj+onAmrKJkKBEst5fR9RwGyyIBiF0bmpfolwbdXI1SfStehZqiM79N2AyHV5CfHTYKvks/mLoDLYis4+xuEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=987 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130070
X-Proofpoint-ORIG-GUID: 0k4PWZ2U4IsFIJaidopPfWfUXXtbNFPV
X-Proofpoint-GUID: 0k4PWZ2U4IsFIJaidopPfWfUXXtbNFPV
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

