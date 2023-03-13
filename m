Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E06B72A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCMJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCMJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:31:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB3498B9;
        Mon, 13 Mar 2023 02:31:44 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMFvgG003364;
        Mon, 13 Mar 2023 09:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=xBVeTvLzBsoJHRKo7CEnffiNcOIz9zRSdm+Wg+Lq5Qs=;
 b=Bk+ykmbt/fD8KG2oeZ9lbrQarrTPvfVtiPPgu4VuZeRVXlfU3lAjP5FRiVD2tWo0PV1h
 xmCWJZ04eQ7ANkCufrP2YYJP4TsJEJPiYKGoOIFqGqYr0JEWsoW5ReVoJPBnj53+vPYB
 JQiHqT9RiqSM8rmPJC/Hf3xP1jjlT2mooZymBK1aGjb1BmG0L12oaLOD9lLjU+67u5Ew
 F9IqXNda3lOWgiqSRrklf1/izfqyEg+SLv8Z5ye68Tme7PTcoCSv5+k2omZdKyd5WVnX
 9hc1J2lqpN6uDlRMPciB3YeCiJd4eZiYTV8L0Wgkq0WPXXFz5MSqGs+pDPjCBVoz+ShF 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8gjbbdf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D7l0H7025093;
        Mon, 13 Mar 2023 09:31:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34d2hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+M0QPphzzVy5DlWg9FLD1dektY48uUVuwgrOz3yUvtgROg7yPK7h1bgnV83l46Et8oeNG8+3CmFT4kH8vL9L/zBrbsPb8+/F7kIX/FWzdqyZudv8vBKYowccNQj5QSJ57JjQbeh6SMMRAHYq7JBI2pSNggGmel7fPbLCuJ0QbU82G0RNUPxlgrU0wN2eQpVStvzWxy4HKMmJGf07hqFfxdaMHo4KX1i5q+GjFAVQPpf1uUUkdkDOx41JvnrShuPF5NKfnBIBT1huleZPSvvftkwNn5kkWxEnl0giAIUjlrCL2PG8l+U3fKlLc4BmmZdB3uQZ0FeYC+gtoPZl4CA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBVeTvLzBsoJHRKo7CEnffiNcOIz9zRSdm+Wg+Lq5Qs=;
 b=FxvFkgKuzM8Hdrh0RgDCpw+A1tm703925wCkMIONj2yK0sFkTjslrOVRqyB086yoEM232e5hNDH4XYHU5Qe471ifxhnMibBqoy/kYHxiV5AP51SbrXGYn5IJ6EAC1lod1xLllw0T1J+M0roqaKKun+FqBT9dCGiZ5nYvUdtPY08XhjQtgsSQp5tlC5QbnCChIk0pXSD8OnS7d7Cj6Ea5nToHN81xS4qJViWWoABe57HK03tmi227eU9gb5gOV6FePCBoOOWpnguRofKtnSD+oo8daMMIBbe2pZU+xSJc0HaAP7eu1H+TEaTkuR4syetVym8d8wZdgey63mDJ5AXMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBVeTvLzBsoJHRKo7CEnffiNcOIz9zRSdm+Wg+Lq5Qs=;
 b=H6iJHM2RX1yI62W0zesdWg/oRlN0CoC/betKzQrGXwdFqSEIwwjTMBeEvPE/45oD/5uKJzRTdesXa6AM+ke10LV/hy5UXLA6KN4iUnAnfixWO2ot1D9ApIsQMAj94fWiPmoXy5IOzHAD86qHqrx8xDQYJ0GvjQ0ZPHkKPGjWL50=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:38 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 05/11] scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
Date:   Mon, 13 Mar 2023 09:31:08 +0000
Message-Id: <20230313093114.1498305-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d97eb86-3b83-4b81-cfe6-08db23a5becf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abwqERINt/rRyUuU/KuFxJL4cMf/tlIFLe0O62ts5cWbylPQ/5wyLk3yyhp/DnAQgrbbyXA+T17mPRMwXQDrKxCz0Vh5Viy6bdNUDlCAIjub2bUrWIUvuHyZTIJ3Ro11LMv3PY1aJ+bTkFTOo7eSwDzmivHRoxgx/1P5D8BHEW7IBS13g/sf1EKWIzjvzs36N/90ErewwB4GpgcM/weQj5NwqBI7qYMrqDUpoKjBeQQDx6qzOi77+Weue4xCDu6DXv75YmJlAaRi7Uu5N70Zwfao03SnAH2jGlpX+BTsuwaWfw/chdjr2Rgj8qlMvb2a38QJ1kdjIDgzhVM8gmbg2tX1XpfSETKnsSsRio/rcA0n5YcIsJp3v6xkMo2u2ADM5OKnHOPjDbtKrAZooS5RKURZziZBjPgPyFxlhc/fU+a1bmMPL+BpGgZoq22Yf07Y+zxE+CHpjGlDJM43xIhEONgDr77Jl1KM/0Eo78c1Hm/rbTrixMNao/S5u9rgAucP9ahSTISk3f8IttupkPUdjVV9YqBkkTuLu2OL1lTgj01Ify3lWYC9YFdOiiuPclP5e8reCYGoGLu+cIWD2v2cAjZ33yMKiduvuMjQ7KiU9bIPW+1Cesjmh+yzREexvHfp0nwMdCj7gasdh4xqY/840Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZuEquCTA0j6GJflog5viVeQB8YPl+Z5j6Lj/95sSD280LwKHT40MkSn4MSH?=
 =?us-ascii?Q?ZcK09sfZh4SFLahKPFq9I8UurP90A7r/wYs3+OubgP3XUYTFRXzN6K1mxDXz?=
 =?us-ascii?Q?RWfg7dtuDdQ4gQNFOJQ6mddl6TeYi+hPpEaBbP9ve82iQbS4Lzx3BmLGLS0P?=
 =?us-ascii?Q?w83eXNImnUW4CNO6zh1Ag9lDTSvenD7SFLUbmsoLfbQFQ71kAU19KIk0/4vv?=
 =?us-ascii?Q?VeCAiz84CskSC5m870EZFjQ/XMXpC2QCppTJpaacO/jd2+Pq5iiYnj1tsebD?=
 =?us-ascii?Q?PGV3oL2Hlq1LfktPX1O754EJl+MiINm/hwIx0Q84ztXCJOVlhQijzgNxxQly?=
 =?us-ascii?Q?fa1nbGEA3t6Q/2REH1Oyz9kh9vcjK3wY4CDrlMLmBuG9eH2cgzQ8jpFxnrpi?=
 =?us-ascii?Q?7aYRjyM9wPlA778mnjsYWiAsRHgRRpkWOWXKgzjD7wdIyi+3c8nIctOsHPKl?=
 =?us-ascii?Q?aEAQzGVbVf8SjoQDn+FZFEAE4tF+o5zngo2jqb8qLi96E7HWbuKnZ1XJQcU1?=
 =?us-ascii?Q?6DEpk7mcH4XRzQBoV/3/NokYQxweqcz4/Ql04VDjGhhI9baZk9zZvoElb2z7?=
 =?us-ascii?Q?hWKd6NsxxFHYKMhhq4zGG2Qp3vbrtz6R9WtCUMFaSxSmfrnLNM41vWkCfPER?=
 =?us-ascii?Q?RNWne7Ro7rsAKmH8a+CgWsTEdJpPk+4mVGQMNWOT2Y8z4ZyMyjovsCdP2vqg?=
 =?us-ascii?Q?gQfR4MXVcqqVnbBDrJV0XOukrDZ0h6WiQ3eq4BJH4dwhYSFB0D0DUQht66i2?=
 =?us-ascii?Q?zxuUZ+sJp2LAiLcRBmqFknyRzoUonjywAdaMTChEX3cfsFhF3ZGDL2OrGrbT?=
 =?us-ascii?Q?9kdIcA2YXrHTsqdzSNgJHiBU0pQM6UHTgFrkqP28EKHW96bNEPpf0K+/OBfK?=
 =?us-ascii?Q?sZsDLQhSdxXK9JLVhtGtlkuzZg4aBt8GJBJ5nqF4lDKjMeedc+daIaFcsNWy?=
 =?us-ascii?Q?T3dLGnsA8gNFls1f7eabkF/odQ7oQIMJPYWnuWy0aLKBFwuwqbi3wPh3b0EC?=
 =?us-ascii?Q?TRXcy2THwZMBcE7HhL7kBDN2Dn+PCRpZj4d1XfjnTm7wHpPd7H8nODSNduWb?=
 =?us-ascii?Q?bbySnYyl14TUPEjwWRO4cZ+H9OBa/xBHtMYDl0b7pzLdS7zD3VJyhk4U2+FJ?=
 =?us-ascii?Q?E0FGghOebSSpDHrXVatKQneFvHEVwRD9nH+uJPzVSBpk6yKsmN7WKQtZU1fM?=
 =?us-ascii?Q?L1t01xI97rMoJUyf5Sn5+BzgKJDm/UiqQi/GztaYDSr0ASD5ojx4UrqBhGbu?=
 =?us-ascii?Q?pIvZ6IsPsO/vx3Y15YX47yoWnmob9lgMNSWyg3j9uJTAuSUTQIlNcpm6e8Om?=
 =?us-ascii?Q?Q6HtV+RBScjwswMGeRJONv4nyZGf6vunaq8+Jgw8X+a9HK8MCv3FVsYuFuTN?=
 =?us-ascii?Q?rs3GmVE/nUOPCy+KoaX0WKxc/+SBCGs67NKEJkfY4hW7L0goAC5KEqMQlILS?=
 =?us-ascii?Q?gRzjiNRgg0DwCxzV3W7l0q1DnvCrqWjsXE74P/zmjQGQR9AiisVUfhpOfyDk?=
 =?us-ascii?Q?lKNNM3gW7chnZAVLy80u8Zffe/EZXLgC2H0C2mmUIZ6QWng5F7ACGV9imhs7?=
 =?us-ascii?Q?6hMjab54kLjiNPWtQkSbimpTqiwMe9T6smrBVg+mkKJ9Xyqpmfcbm8kEn1g4?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HYYtADIoBZUufLqXeakQ7qc0avkjXgn7aocsv72m1Lgt5e5Jrxu/ocmhM9vnjx/quRtfgo4lymtD3tUFAv9mZ6Pmn21jkN5fcoBFyr/j1hyKf8YkNf/waAa6Ln5ndbUDVZSsC1ftF2TIm9LuMgC/xUwXaVYBHIhrjvHhAi6DuGbavMYd97K2ri25EKs3BwfU+FQlh9BK8Ad6aq1vInzBm0SdDehftFmzkTAAAo4sicfr92973y9lwt3WHaNQJS86uju/U6wRJea2JMzXKCxhDPG0KZV5huoUlY5gPkmXlI6CwPf3PsEjFmbdflPd8HJ/MzGLuNhz6NUYM3Zq1pJ462jVZ5HxfQI9jobBPhjY/nviYtgXbH45aYDdbHQSNWC8jQkFPTcrIFyTRDM6z+Vi3ev4f3yFVFr+BySjCZZ1bd2matl6ZFWQXDLvq2jYYqr2QivWhuF0/3UQR9CyTNGZExy9VvwKDD9FKH0Ml+/JYeZGygZZSldpqmo4RMA48ect1vxmQLZUO3bJTLY5b9nE1N7kYniIUf6eHho4m1CXdoNXfys9bU+AtI08GTG6wyjKV5NEJhNDZm6UB//R8KOyB1u8mO+m/I+5gIjPmOo2YeBBdOZlsFm/zZyTLwq1pm4TV5DpYFvvb1wXTbwYqJEusimNai3mFyNWN7hLacgiP9FzRWyAmjVETk6oZQ2WeydybcAMVmPhDm5N/1xUeYgsdZa89MutNLWfdYiiUfUYagFHOqEbM60ZTNToxnQRqcEn9k1HFF2N7na335SPmZWy7Rt/b0MSc8hlBB674+XOcKKKx8RD3Gp1FowWprBZNcAWAUeUoYHqT593KoL9uSzssEXxSZEsOfNELEJS8S1BT5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d97eb86-3b83-4b81-cfe6-08db23a5becf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:38.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K32TcK0+JUtJhwYux6BOsZtQeLalHNWhoH1b2/gzw8RCOs/AAJevLpPupEltHZHyOscTejl+4g7UsQ7YgSSMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-ORIG-GUID: B6paqOCrczLEfvQCI1X8yFgYJBfuEPMB
X-Proofpoint-GUID: B6paqOCrczLEfvQCI1X8yFgYJBfuEPMB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for SCSI cmnd, SCSI device, and SCSI host are unnecessary, so
drop them. Likewise, drop the NULL check for sdbg_host.

The only caller is scsi_try_target_reset() -> eh_target_reset_handler(),
and there those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5b51c24f7d09..6364d6f08861 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5387,37 +5387,26 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 {
-	struct sdebug_host_info *sdbg_host;
+	struct scsi_device *sdp = SCpnt->device;
+	struct sdebug_host_info *sdbg_host = shost_to_sdebug_host(sdp->host);
 	struct sdebug_dev_info *devip;
-	struct scsi_device *sdp;
-	struct Scsi_Host *hp;
 	int k = 0;
 
 	++num_target_resets;
-	if (!SCpnt)
-		goto lie;
-	sdp = SCpnt->device;
-	if (!sdp)
-		goto lie;
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-	hp = sdp->host;
-	if (!hp)
-		goto lie;
-	sdbg_host = shost_to_sdebug_host(hp);
-	if (sdbg_host) {
-		list_for_each_entry(devip,
-				    &sdbg_host->dev_info_list,
-				    dev_list)
-			if (devip->target == sdp->id) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
+
+	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
+		if (devip->target == sdp->id) {
+			set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
+			++k;
+		}
 	}
+
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp,
 			    "%s: %d device(s) found in target\n", __func__, k);
-lie:
+
 	return SUCCESS;
 }
 
-- 
2.35.3

