Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7D6B715F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCMIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCMIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:45:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A1722DE4;
        Mon, 13 Mar 2023 01:45:29 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMo8vI004881;
        Mon, 13 Mar 2023 08:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=BPrnZslTo9kfHxJ7OT6fURQ/wPLEqWRnM1ifwDhPCKE=;
 b=NJL4rHRtZfPACM6vIdPuMV5a9vsAZyrKFj2uUOXRGHI6DrJjyzfowTRUtWMfuodIhH5R
 yE5OdpJ99yN/DJ1XWYEr+3FZG/b/UY3aFsBVLEHDIoSJDRpX6q+BJlZkP2vDTlExwK1h
 oh2fDWW0FPLugI93HHalj9JtdeExP2a01YD+i3v8ZzOGecbNlTSygZdr/EiEFsPsxBi8
 8jF3jEliInFRtd74OfxMxKGSsu+Wk4AVibo1RHPYQl7CsegBPJT2Zh91U7nTJqKImcrh
 QV4aTLYqeOni16n14q23gHJeSInw8E6vpj4pfU8J5fPcdJD+l1nWry7TWFR7izoDkHwW ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8j6u381e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32D6q9Lf008306;
        Mon, 13 Mar 2023 08:45:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g34b4d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 08:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXd35YgNNUbkSsDvijE/fIUIOst28uNktE/114JGRdo3UK8SvFYwcsMWASEQ/SGP2lTRiwYknehLjKkfDjXGEwozvnskCAEuRFWHG/Ac+ip4/E1b5sAKUHfHorA1E0KSSLSbmrNEIwv1yJuCMFW795sgNOtc1t6YpYkvPsc+QlCaZ4Lk3loFhih2VaeoyoDo7sj07Sa58ZHgOSUd14NiMW9CeiX2Sbs9rcSHL0BpkTsO7h9+vqgGXL3K69tlK5g5x63jsIPgOvk3ZhNk5akdNPgDFQsWNgaceaZ4qFJB/0a76S5DZbj9PhJNWbeV+s5A2jc7BNK2nBXZfHNqCqsfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPrnZslTo9kfHxJ7OT6fURQ/wPLEqWRnM1ifwDhPCKE=;
 b=Z50wwJhQeCbUHAJiavIk2770IpoBNA5/k2o1DRZRTjv+m+2InIT/xEthIpCGypJBNS701U+IicXiwSzy2p6otjHzHAPCwP/U0aP22ZypayHk0xEoY5FIJ8dB7REhAKWHmAMDn2/nG90Q9WJB+NlbBtV7GQ/J/6aRvPbaV7o4qWqckAG/JH5dyYWBSban8IotD6xnGYUDsIuTYvhkccODb1mPpHP3cSJGb1O12t37SbSkxs/fsJs+5XJy92ZvlAvcU5Qxuc8s/9uMLTbdXgaJPX2Qxbea9Wc8p8xUtM30V8pxqhrKO8GYDUiZcw80ciO0wQpLXvgQvbE96XyOHw0G6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPrnZslTo9kfHxJ7OT6fURQ/wPLEqWRnM1ifwDhPCKE=;
 b=HimhOHuwn6jnKTvU5HHPcc9DAfpiilbFGyfEnocWLP259Eqnq1IqSNHRxd9SB09IwfFmlHUZmxNFszcucnxfd6khCtviBEnQaYjex5eeseaStQAd1rAjPIGOXXeeQLbn6CiURVRJpmdQKKm0m+1m7zP09GjqRMVQXjqT89zXVUo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:45:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:45:20 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, dgilbert@interlog.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/11] scsi_debug: Some minor improvements
Date:   Mon, 13 Mar 2023 08:44:55 +0000
Message-Id: <20230313084505.1487337-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c5ee3f-8f57-48da-b561-08db239f46d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTecG5d0saqrfLsNag4uClEwM7sISJCvenW2dklvjk9eJCk+U8XvTWRMYeHBJWYu+ymqBHVG6yubWrnI1I0bk7UAt3R01s6jjb/muysZVSFV73SsjZcrMNFfMOzTv068gDI7681l0LOVy2hi27HjN/na/LW5LO7PI2Iqz6F9VOBkDjHZHAAG7XA9Ii9AVSoOMI8Jw2FGd1KvROQ9psp6lfFESULloucMza9BE2RXTGC0Lro2XFcnJ8DgUfrwUy2O06qUSajZTESZkb7GDwzF0l7hvtsPhVHJFtid3vEKMH8sruYtMt42JGFPZSxfz18I6dGvlwcMnASM/+NhjY9Vqs8QC8vGV1NXcIuL4f3T5VDf9hrJ+E9Z1lWgMdzj+H5rAYGSDpqMoizqmf19vtxTWSLJ63tCe5/VxRh7NrqSgbE50lVVRM+bpZD5z8x1Gs4L4ZmnPkS7JQHYudEpkzFnxxtRYlz4ajGOX/VpcexNPwLdCYEyWxPLXG+/cuW6+3SMTkqD6SRNo6/HbprQAFs1SdnuKgV+8wnSTCSsJty+iBvLY6QQ8uENC28s6PbT/ll7XmD1AUcUKxetNAGY7sUjjTpeziULtfYUyITic5t0SbpU9yvFuiQPD9SSXdtEFZ3JybdjGa4Mi43JZV6pawrTdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(83380400001)(36756003)(5660300002)(66946007)(66556008)(41300700001)(8936002)(4326008)(103116003)(8676002)(66476007)(38100700002)(6636002)(86362001)(316002)(478600001)(186003)(2616005)(6486002)(26005)(107886003)(6666004)(6506007)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31cqbPohAp7fr4wHJkEMlmf6AWiKzxrvUuWq+gWYRvk8u+QJYYgIwSwKvA+H?=
 =?us-ascii?Q?q1nZXsaA/bbdV9wXikggkP0T5iRts2VfgdcWsm5kXZ1bAn0CcEjma1WdOTw9?=
 =?us-ascii?Q?orDn2e2QqUoNT8/mMm45Kp54K3V2Fy28yMcr5xqq5slHD2OhcQ3S4nw/zalb?=
 =?us-ascii?Q?YJrfFpM5HySwIl1NKLIhI6vYZ4k63HuPRCD9bHAdHqmfwYZ7oaSPYHeLGcCF?=
 =?us-ascii?Q?TiEL1hAsWWQ7DULoxv3UoDqyuMXIP9sNvN4a0t7nE5IO7/7u6M/5Md4S86uf?=
 =?us-ascii?Q?TdCs5pAQDPApCtNlEXUhUneT2cU+jr7b8jnJqGDmMSNQ67DYMvJMPega7JQS?=
 =?us-ascii?Q?LpbTp0aBC8ZDVoHafOgfEemUPSqMeN2xx6KXUXtQo2/TN6iRp0qb9DcOm7HP?=
 =?us-ascii?Q?s2iCuph9Kl8giWZBBhigkyoF/J/pW8Pp7VmSdpZGeMHqRoQ/HI92Ht+RiqO/?=
 =?us-ascii?Q?X3E/PhczjOarHHF3AEHU2yvH+QOICHZC1w5A11VnWzfWwuuJyouxS+4R5NYu?=
 =?us-ascii?Q?NeaYAuznbEMC3uzDXEsQmnkYbGJjm6EwGdFOefOBWX4DZu9hPGumFuukv9V/?=
 =?us-ascii?Q?+A3xVW5tVtaT9vcvi76CPwfLqQZfH6kZ2a/wuZm9//2kx92Gs2dbKseujpZE?=
 =?us-ascii?Q?QHCmSunV/8OC++HUZ3Jcd3roMs+O02DMQiH7vHF4eUnGv53cag+6XlLxH1iO?=
 =?us-ascii?Q?iS91GuDK+OWRVp98p74EpucOD2ZlpYRc/Hssjug0ev5Vund6+aTVde6apW1h?=
 =?us-ascii?Q?WP+p+SWa5LepaY9sjG1UzIU7krkooJbFWmqrQU51bYwGNOsMjT4KikFv8z1C?=
 =?us-ascii?Q?hVshsvW38oH/d+PpGTlsFwSuU1MjeC7aHlO1HPvSyzrVZAmEnDxmM/pR0LRr?=
 =?us-ascii?Q?v8nSIOxfC+7MrX7lc0KeOqba2KJBUf5ks67fGlIbAhBhxO/t38RG6CvNiGgB?=
 =?us-ascii?Q?LBIWVkHDnbrmdyTRuu7g2X+cutgC5bWH58t70uMx5plBl8ZuIRe0Yb8VMS6j?=
 =?us-ascii?Q?RZWTu0F4Tb01e5CsvpHdrYV6ktj88XwaBA2iopuLkx9ZRWjoK+ppicc+Q+TT?=
 =?us-ascii?Q?6j4Fd+3EptHNkuneOCUJLzhCk39ulLgmN5V4eR+y2pQtuUhIUuLNfu3IA8g5?=
 =?us-ascii?Q?MufR7mWzvUu+B6TiLCGDA3fLKWBk6AlvH9wdSo2BXX1BYoeLd6WOfsDFQ2Cd?=
 =?us-ascii?Q?NpeFvf9fCA/H7Cfxg991GK+tbeN6bDjDZboZN999iS841rCVTRMRL+QrBG0D?=
 =?us-ascii?Q?0ywR+d7EJF84AwanZlAfomJSaUWQjIWCJXeT0FjmsVXhSEUv563KUmaeLzhs?=
 =?us-ascii?Q?Ini3Q9X4EF/u2hzAzSzM2MXkiOZpikci84U6jZK1jjFWQT4RzEIb9FTL/NJE?=
 =?us-ascii?Q?c3WKGRvYPGIpazMElQwrC/4kmpIrER8LEf1lUXbze4gsuW2jUwAQC1Uz4l0V?=
 =?us-ascii?Q?0oWDksr3cpiBhSciYbC62syBbYLzmHQpx+3siDgyrkcZeSUfaFJDitjk/5a5?=
 =?us-ascii?Q?FsAVNYmEuYMQx60KR2mtnJG1KOXXjQReqny01xb2XobetxqI9UZKusvYozxw?=
 =?us-ascii?Q?mahttXmaHUz/JnnsMMgG5TlBq4/g7BWte9ellCZflI9PI/Sdj2PUAyB/gdDv?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vW9OlSso9H3rIVcOlZcu4iEfclBGIJccVzuAci9/FjyxhW0wEAbVAyxtLyrsv+0pFEdMPo6MZ4WlR8z4sHfUojuCduvx90IUO0hkySmug06qYoZcH9zGrAdJDdLcAwUO1EjKKJyb0flLWT795G05qDqYsaUgY41HDZ/W0JbqW85B5um4cKWNVdFTeu7REMAf8qGP4Vsbycay2zHZr0lWqHwXBxHv+kmdz0TNsf2wQqTTCtOr9BJD2vloZUPKdWTykP7dfiGh7ImcVtgcIx5WOPPf7S29jUtbAtHinu/msdTnAILsRGLWilVuQYbjP5Prp1eNFqtipOtSo3I7h6p4QYEZHi3cnYPmzxh9zvzr3/1nuZ8xEvtRoXsIwYIwszQ1QMrHGExgmvJ+i72L3sXGXosP8VhmZqQQVePHji9H/KuSK0sL5e7aPdtN2GNvpuAuBSJ2PoItfHocZXIv4UrC1etkMGFaC3eWrHwv/HYFynXEiIWrjiOAWiSGAGzUpDBjskR6Y3tOyTj2++F5o9djZUVAMbN3gfunsk+7pztihgGwajD9AnP1zuZ+Tm68QyTUe0T82vK/ve6d+HmdiW2yNxZwYXFcX+9Ndfxy5J0TVtnVXfbZCoNRBtPF2rkRRD44Kn1nAIWaufi7mcDU/uRPEbNYH9MwAcee0mEBAQtGamLDjLMX8VWpAsqLum1uhfuj4LPa2UsiP3a6IXgAP0zlG2dbnsOlStmGLoSiOO/pfGLSrQPNhMnwwjYoZ0/aBFOU8bVFpyUlVYKGND7YNd4IEgxshN+5c7hyGjvBh6vnbGnbHqk3MEeBErbkDq98iV4QNAs3XsWuoRVvGae2hpTgKTrs6+bVXQ6xy218We360M0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c5ee3f-8f57-48da-b561-08db239f46d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:45:19.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBW61f8tqL6aIRbT9VaIWPyhHAcuGdGethPOLCQifJ2hQMw9NKI4wanA5Tf5IvHdAJq+Ejpsstwe3FcUh+Fy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_01,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130070
X-Proofpoint-GUID: Le8bhh6hKHU9SUAr8vH4RoACQMSGfTdw
X-Proofpoint-ORIG-GUID: Le8bhh6hKHU9SUAr8vH4RoACQMSGfTdw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a bunch of minor improvements to the driver. I have
another bunch waiting with more major changes.

Most of the changes are quite straightforward, and the only patches of note are
as follows:
- Fix the command abort feature, enabled with host option SDEBUG_OPT_CMD_ABORT
- Drop driver count of queued commands per device
- Add poll mode completions to statistics. We already have poll mode callback
  call count, so maybe it was intentional to omit poll mode from the
  statistics.
  
Difference to v1:
- rename function to get sdebug host from shost (Bart)

Based on scsi-staging 6.4 @ commit 0b31b77f281a ("Merge patch series "PCI/AER: ...")

John Garry (11):
  scsi: scsi_debug: Don't hold driver host struct pointer in
    host->hostdata[]
  scsi: scsi_debug: Stop setting devip->sdbg_host twice
  scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
  scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer
    check
  scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
  scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
  scsi: scsi_debug: Get command abort feature working again
  scsi: scsi_debug: Add poll mode deferred completions to statistics

 drivers/scsi/scsi_debug.c | 209 ++++++++++++++------------------------
 1 file changed, 76 insertions(+), 133 deletions(-)

-- 
2.35.3

