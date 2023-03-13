Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C996B72AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjCMJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCMJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:33:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604AE56163;
        Mon, 13 Mar 2023 02:32:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CNEIgH024676;
        Mon, 13 Mar 2023 09:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=iS3oQQgc7Zn8ODNsyFBZug+VoRiFIqNLNpm4/xSdDHU=;
 b=NVa4BXiNqwUYB6tQzhbtt8AdZAaC8exhZxO9Qah0/nLOu9+GrpvK9shZMxTm9orDGe0d
 Ji1h9hR15KRCb1jRWy5EhxEXUPGGsNBBmlxaacrqv97a04sDEf+mnSegvP7uVYSs4tUi
 7Hne+cYzf5gF4E/vVPFeHJ0xi3lgjGrfgZkONLvTaO+//XQtBMmH4//LCM2TPU03SVIs
 0+aT+xn7HDswtuNv+cVAFpTQ56SuwpMgUOU8pG7JBRV9T7vdneoUZq0+3dJwJHXkTzu9
 Cgv961VrJfMpN5B8d3zX6tpF7/2mpHPaOyBx0gEYL3Ol/qqxebjOksMMjbRW1uB4BKvN Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8gjbbdfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:32:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D8gK1m007336;
        Mon, 13 Mar 2023 09:32:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b5fvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 09:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2RkFAnRpophrLUSPjKsstgDOYDC0faIwVTJXdMxfTfTmANTjpdjOY+AJPPCeYPsA/18feYx32CEtHDbtotPm9Bz/yCHTitNkP/SOIkV1rPhz+FQx3X/aZHeJfZKyuS3G1Yv80IbcbyZpqkp6G/n5N5z9ACaBLnFPZSGkwoWB+NDp8kSgzjJS3sbBdJPeVqmNjvrawb7kivtFqFKomilAcTQMq8VSKgYZHsXYAVumOfRyB47dS6Op3RRKRO2GX8yhyG3O6hKgcZIL0ajpKWUGLihe2nWR6F/Jo4qz1xFOdfRBlZU/m30iwP7YTcxOGXNw7kDLkMeiusE5BjzE0sjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS3oQQgc7Zn8ODNsyFBZug+VoRiFIqNLNpm4/xSdDHU=;
 b=koZVQYtrK8C/zNaIwNDDxNUnzk6ifIMv5u6ciPuCDthvWppaQy/utjqmj6tsPhAVyDKeaLDwKZn9qL60Osmpt9YqNAfhkXASRQpuCk151N7a+THZwu/Nj75nYdWRuGTC1WtAct6iD+M2J3FNz7clXKndEdezyINAz96S8u41EkH4Necp5nbT803yFuNcIlRWzgXzvdh82/6X34bsudbdRazDFOe1ue7F3DWehd3SFyENo3urqk00aeIyORx8ER+p8+0UNY2vlrVkfnd1IT8I57hc/JOsbhRmGnKLKLyyFueqxZciEVmcTDvV5naBGuzsFuvAjxf9JHeD5zDTlxoA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS3oQQgc7Zn8ODNsyFBZug+VoRiFIqNLNpm4/xSdDHU=;
 b=JJJbbIHAXtB4rLiDuRiDiTSFd/OXByWvE9kCIXC5TexhqhkkIwP9fZrlzT4n7w8NzOl5JZREiPXUy0ve4Zl9KHR1p+adu52zaQuIwP9pnbzO5IXHirzqalToEDmtJhDe5Ttnqv234GW5Q+EAFPWNZRQwDPFYb7Iw424UXbzye1w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB7048.namprd10.prod.outlook.com (2603:10b6:806:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:31:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:31:58 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RESEND v2 09/11] scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
Date:   Mon, 13 Mar 2023 09:31:12 +0000
Message-Id: <20230313093114.1498305-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313093114.1498305-1-john.g.garry@oracle.com>
References: <20230313093114.1498305-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: c25c24bf-1c10-4d9e-1d22-08db23a5ca7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccj8S8ng+r4lKwKf+kJm/S0ffCBr2H4IlPtngbUR6/5HbatWy7oBVUldjnZsiAK8KS5cFeL+Pt7f5NteNSAi49LGAd1sKVA742rKEdLWpZflEOAEVkaqI7SefXlNWIXD/P0pw/tMjBegXw6NeobK+Cm6mA/rJuTSSLSED0aUd3vy3i2o70v4TqsmyVkLJiX66rjWGy6vjKCK1FnH+NqW8vrn9pXoUelC4tJGubhBJDrdhNSvRzxnMozSNacJBU1lbYitP79FazdnxgUYZOLG++03ZpDRxH5IRcnEkHMgkdpj46BXukvgno1AKbRenZgX5BfDtV93i9nBvD+zuRzGAdOy1CQ/vl5HMCzP6UDmcV/voGisL8bTq9jwazUMU23pR1/seIXCW5sVEW56Ow2tdMpykUnw5xYdZYJH/xnprHQHqQMkIhwJQMA1AsLD190Y/FzNKMwRQBGQJhbPa0t2LepgMpte9sHW8FA95vT41aN5Rsj2jRoTjV0fPknM4xvtpCmigSsQpBgM/GsspRCtFMmtruWA22rRSBQ4b710ws97Njy57q+pHaL1SBFkw0FJBBQ1pU07MqJhaDsLEZB9YWSjsrEsmNDCb40x0nOVZPgB0llPNvY44104klRUogrt2vqpj1n9nZqak77jMLbeHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(2616005)(186003)(6506007)(26005)(1076003)(6512007)(103116003)(6486002)(478600001)(83380400001)(6636002)(316002)(2906002)(41300700001)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(8936002)(6666004)(107886003)(36756003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?se/TVY8QThGwzcNFV+Gs9bC+Sc9ineJ/Q5eC3mW3pUo3rvtJJbb0z1HYwucI?=
 =?us-ascii?Q?4CVJzB8Jk9keFQ/Il3GwnGgor4Paxbp3gjxEIP9geBs/RGxvdRK3/1em5ku0?=
 =?us-ascii?Q?Mw9esBxAB1HyO08W0hDzLjdiJ2oiLa0dGkXeEa/PHu55CGeCePvvN+PlJPpj?=
 =?us-ascii?Q?l1S6kBJlCdC1lGwlQeX+IGpV1M6fBm4xfUIzU3sIBQ+EEiDtju46LkeOvTSf?=
 =?us-ascii?Q?oZDnHl/2VqmgeVHnhRs2+aFOTb10MbvGoND7P6FRELkJLDmBTBmVbdwum+q9?=
 =?us-ascii?Q?z3e0HOn4z2KdfwrTZb5/Byle8uC6EiS1pmuUvRvmfLe50hZzf+67JD402x4V?=
 =?us-ascii?Q?0sNqWdRW7diKF9ycmGr0QXdp58ZjHW92ULot9tL3xdfRgxgAYaBfl0omo32l?=
 =?us-ascii?Q?E3wgpXTf1D7eClbLF3ixAg3V6ZCvGa3FuqFnli2lFDqAahgIv/SY1sN7VCKw?=
 =?us-ascii?Q?T5nDX3e/0nDLnNi41FiIw49iB5PKOsl7WJ3Uxi3X+1/7+yDDMWku0EJN14s7?=
 =?us-ascii?Q?CWjV3G8YpsVgWNl3YHfOqgVj9YPBeGuQNTj//W5mtcBPDm3nYepA1ANWQp84?=
 =?us-ascii?Q?CYE5sK4cCMNd6dTKAGsVWWRX4scyA6qqjjuj9kPp9m0T41sxgbSs3UGs+tea?=
 =?us-ascii?Q?huq/Iy+lNMN4AZfCV11P1THOP9GQ2sgT6WJrPuPzUqC10pPa5zkefaD/+Oxy?=
 =?us-ascii?Q?HTT9XfasMCXwCXvfQlJ6EJ6lF9vg+WOql2YFjdNps0DuEebUyTzIAx8S6pHe?=
 =?us-ascii?Q?mrZX5zB2sxrUUY56M52uAhTaqYWkQ6mqfDWuvEIFpV8tBAoG5v8LCdrJlRyL?=
 =?us-ascii?Q?IEFQfMpH/RiPrtXGPeElCk18STBn8apYQ1jJIYxAfBBAnF5p6lUsiLo9HTQz?=
 =?us-ascii?Q?XTYameMcFeEsWQw+IJMaLtfyrIsV3yb0bSztMmlkTnHmZtDnIBningpE4FTW?=
 =?us-ascii?Q?OigP5BQa36U3VeCO+kw1dh4xRnGL5fINEAvByci/i3tYGTn5j+bmz95/LW3V?=
 =?us-ascii?Q?qCa6T/nnwui1Iue9zGz1trZeQNb7gv2ApX7o0myP7FQsd463V1euGPXa21cR?=
 =?us-ascii?Q?f3hyny3tmFxk7AOgzd7x69+NXyUc8dniz0BC+43ssxK4muWkDSh+qfiETESc?=
 =?us-ascii?Q?gkLOAJL9R3XDY/5szHvCbflIvN2J6bjMhMGlPsS6/Cih09C0+QFX1GyIztxE?=
 =?us-ascii?Q?s5FnaU+0iPVSbxih3JF3e05/OQKHbAnWw3I0OWpDIy/No86oSOjB5/a7dDwt?=
 =?us-ascii?Q?WH+0wX52uiYXAfS+YSl6q5gNBw0iKgH/nXPZlzpWQqqfq4R6DVBy9a5fUAOj?=
 =?us-ascii?Q?oOVXMmvx0q3sxcttvc1gEif7sQXIK1wS0TrtV/GgROilA5KlG89pd+y3tWBU?=
 =?us-ascii?Q?MTXqvdDdpo45BcVES6dmhOIDQaEpuI3AFleoVlhLqopCNRNy3bUNRg6cLGbo?=
 =?us-ascii?Q?LiQkd6qCY9neYiDNMn98tn0V8Fsd+88omGPK630adWBQvzStV1AmHIeX/x2v?=
 =?us-ascii?Q?kxpUfq6K5EZPBEnxN9xhR996viR4wzlAMEWQQPo0BICeeEqdyj6NvutUlarA?=
 =?us-ascii?Q?GBj6788Th8Wg4a93zB0NOlMRgF1vMj/bhlik0pYO3uQU1DkBa8EEh2nRFYGM?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qBP7176wihnTZPOgCYtzF9VvDaMUaMTuPgxD6m+1wddS0MdQlIq6Vlau37MDs8ivpdsTz/3ZD5FkyVNUqDYT2Spc1OCQly3wbkKlvoaJ1kGQqtVskiHQToS4yy/Dc5T5gx7zCghlLGBQlgbvXFeTJ3ALjdgK/S6uCUn2uI3P78ibBVYEwWnGyViKizSYJqpdv/5l5J2AV1mx4BP8d9vF0Cq9eF1YQqhDVmj74VY7GsapEAnjgUdq6NphHkgvgOJ7IMNo5JJaA24M7s0pxerOOC3yGZTHDcTb4lVsg0BVQDIjSavy+1klikEOwEn6y1qCr9yVQghkx7r77+r0c4A8cdFjAbFyly8/q2k5A5usshyl/eB6WGTOCzw4zE6fIrcSXIPImb/LW/sykbiBbhYFJrwc3XUWLTUO/ww2MCcVSTKZlolHC5Zus799/T6a3REAa069BiJxsNrvIqfrahI4cqd5uIiYR5wQsoOiCqfFI5ctsrfu4P5uuccOiNA2OTeo/7Y8LPe28Zm5RNBzkgyLPX3+zCDFAde5rYcEuz97yfJ/vNymdkJmqX1ywhtxQxcCDDttA4AlIvQMsBnZhNPRLlvdn0bEJG66e2F9p1NR4nTdlMDHYmA5aBynieFjiUdf5owjOujjC7vyMFBChIeVOg37yCyvV7a8l8EMA7lqmW6gmtNzjiSj5MVQNBeK7P0KOF4bg39mHs4KXasKc6PHIMVO+M4mIraAfaFEJ0dBCvPoTYziBpi+7KVkr+ZJj9Il6tYrQ9Scd3YSVkIW+rgErYrLTgU1HwfvdO6PvN0MD6qMfaUw2GSRNYW4lURvo6qtYBHxLQFP55lAMR4+oFhPsiltOz2AsaJrZ5pb3VJuIag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25c24bf-1c10-4d9e-1d22-08db23a5ca7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:31:57.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMnogREw4vL8yiKSsOsgvg6ib3+nD3k5dM2LZqr91DW0lJ4Fo3kNYGysw8pnFrX1TaCkG7UVdUXoAMU1Mt4z5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_02,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130077
X-Proofpoint-ORIG-GUID: us49QNoRhyJ68M7972DdxVZL8VKIebW-
X-Proofpoint-GUID: us49QNoRhyJ68M7972DdxVZL8VKIebW-
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
now under this condition. However, previously it may not have been
called - like returning early - but keep it simple and always call it.

At this point we can drop sdebug_dev_info.num_in_q - it is difficult to
maintain properly and adds extra normal case command processing.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 63 ++++++++++-----------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 0d515bac93bf..449b460e4c1b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -288,7 +288,6 @@ struct sdebug_dev_info {
 	uuid_t lu_name;
 	struct sdebug_host_info *sdbg_host;
 	unsigned long uas_bm[1];
-	atomic_t num_in_q;
 	atomic_t stopped;	/* 1: by SSU, 2: device start */
 	bool used;
 
@@ -4931,7 +4930,6 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_cmnd *scp;
-	struct sdebug_dev_info *devip;
 
 	if (unlikely(aborted))
 		sd_dp->aborted = false;
@@ -4956,11 +4954,7 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
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
 
@@ -5192,7 +5186,6 @@ static struct sdebug_dev_info *find_build_dev_info(struct scsi_device *sdev)
 	open_devip->target = sdev->id;
 	open_devip->lun = sdev->lun;
 	open_devip->sdbg_host = sdbg_host;
-	atomic_set(&open_devip->num_in_q, 0);
 	set_bit(SDEBUG_UA_POOCCUR, open_devip->uas_bm);
 	open_devip->used = true;
 	return open_devip;
@@ -5263,7 +5256,6 @@ static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
 	enum sdeb_defer_type l_defer_t;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
@@ -5278,10 +5270,6 @@ static bool stop_queued_cmnd(struct scsi_cmnd *cmnd)
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
@@ -5308,7 +5296,6 @@ static void stop_all_queued(void)
 	enum sdeb_defer_type l_defer_t;
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
-	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
 
 	for (j = 0, sqp = sdebug_q_arr; j < submit_queues; ++j, ++sqp) {
@@ -5318,10 +5305,6 @@ static void stop_all_queued(void)
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
@@ -5565,9 +5548,8 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
@@ -5591,16 +5573,21 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
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
 
@@ -5616,7 +5603,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		goto respond_in_thread;
 	}
 	set_bit(k, sqp->in_use_bm);
-	atomic_inc(&devip->num_in_q);
 	sqcp = &sqp->qc_arr[k];
 	sqcp->a_cmnd = cmnd;
 	cmnd->host_scribble = (unsigned char *)sqcp;
@@ -5626,7 +5612,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (!sd_dp) {
 		sd_dp = kzalloc(sizeof(*sd_dp), GFP_ATOMIC);
 		if (!sd_dp) {
-			atomic_dec(&devip->num_in_q);
 			clear_bit(k, sqp->in_use_bm);
 			return SCSI_MLQUEUE_HOST_BUSY;
 		}
@@ -5686,7 +5671,6 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				if (kt <= d) {	/* elapsed duration >= kt */
 					spin_lock_irqsave(&sqp->qc_lock, iflags);
 					sqcp->a_cmnd = NULL;
-					atomic_dec(&devip->num_in_q);
 					clear_bit(k, sqp->in_use_bm);
 					spin_unlock_irqrestore(&sqp->qc_lock, iflags);
 					if (new_sd_dp)
@@ -5762,9 +5746,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 			sd_dp->aborted = false;
 		}
 	}
-	if (unlikely((SDEBUG_OPT_Q_NOISE & sdebug_opts) && scsi_result == device_qfull_result))
-		sdev_printk(KERN_INFO, sdp, "%s: num_in_q=%d +1, %s%s\n", __func__,
-			    num_in_q, (inject ? "<inject> " : ""), "status: TASK SET FULL");
+
 	return 0;
 
 respond_in_thread:	/* call back to mid-layer using invocation thread */
@@ -7369,17 +7351,12 @@ static void sdebug_do_remove_host(bool the_end)
 
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
@@ -7390,10 +7367,8 @@ static int sdebug_change_qdepth(struct scsi_device *sdev, int qdepth)
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
@@ -7495,7 +7470,6 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct sdebug_queue *sqp;
 	struct sdebug_queued_cmd *sqcp;
 	struct scsi_cmnd *scp;
-	struct sdebug_dev_info *devip;
 	struct sdebug_defer *sd_dp;
 
 	sqp = sdebug_q_arr + queue_num;
@@ -7533,11 +7507,6 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 
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

