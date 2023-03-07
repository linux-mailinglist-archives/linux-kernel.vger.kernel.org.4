Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7B6ADC91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjCGK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCGK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E9953736;
        Tue,  7 Mar 2023 02:56:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32783kIO010517;
        Tue, 7 Mar 2023 10:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=g+hgas+uJmbPd8ldoWoJBR6FqmoeDKkraJThfdi3n+s=;
 b=08Wfn7u8I7uJbSGUptnqeMsHilvDUVvEdaalVeAHzOA42mY3Mu/MIBstXyC/EcbHs0i8
 qDdRqSq4beqQJbIZOpxOFRjCAmGAsex9JZ5vGrVSe9MygRH9MJQLjKi/RFR3EKG619Sc
 WNhKGuSCcOo5oFdPGSNS9a0v5ze7OzLdHA1WIvRYlcpFpm5/vSpep98gDqSSVUCwmLLW
 pVbcg813OE/oAlSkjwOwyfEn3KmCciyDTZeVxo26nwapFPqI+t4qgbrhfDqic6S561XM
 zey2uj3VfTwMNTY3AFnn/e6fjao04k4IAVqBSecuytl1z7Uh4k0TEad1OTl/mgKlmDhi ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180w5ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3279RxW7011193;
        Tue, 7 Mar 2023 10:56:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2hkp1j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuN2F0creOO3syO/fSdQFIC/dMYQ9nS7mas6R+dIYY8mYwQATIJ0AKIfcoz3AUF0oU8VCHioK0H5zkHWE4LYM1EY+dK+IWo1kM+Mov18H0PPrm3+RI0BueCPA1KhmeU3gJg3tKl4m+qzgJRmFDyXZ5BngoiFLJq9z3M6XXy+ROnZP0iBq0/F1Jes1s/SucJcV/v1TGtYX/RBDmmr61w1wGMR/A03ueCoKVNNwyXvM3BJK0fXwA6RhJhgqAhBQJQsnAJkuSTE75tgDSf3QTzcmH4UIBAYpYXOxDwp3r4ugmXU/L8rpw/UY8N3o23FMIMCIzvhTAf3SBv1NzsI//UCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+hgas+uJmbPd8ldoWoJBR6FqmoeDKkraJThfdi3n+s=;
 b=aN2UKoys2Ludxvx3FFFT3oWgWJavqGFrVbSdTaMhbStXXEgURrSCkJQt0ztf0fa9h+k3qGVRc7cF75NooXLoNFlpDQYemsR/CclymVCzQkWChiBtBOqE5gdWYkJ0oE4ENHYjsnwQfLsrNaopJlfEZ+i4qf3qdc5eYVJnh5NrTkpby3oDhpvVGnHVfRUFmj4ya3xuA8sZ1LKr2MvvMTENO3jvp8AhBL5XxVEkBt+AKM4l8Wwa4CwcuGOW8Ay9IJRoIangNLRYb0WCbMPMnZ6YxflbZNO8zms2SnYY4jVm0xYxmHkMgbhylgO/7E8jv6mLr0AVAQuvGgit9dJ1h9vAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+hgas+uJmbPd8ldoWoJBR6FqmoeDKkraJThfdi3n+s=;
 b=r6v1EmqiAf+bTDUx8Z53lE2TO4IOUzTZNak68nuiZYq3iyQYLkdkvplIMV5ONzmJdj8AxxAyzILFRpRqVF69tIC9FxAKPeHYNcDaXvCdy6YlR7XogMcLIuHnL80H0+g4PHCgEp3qrVJg/ExJ6wK6b4tRpoqNeEehI5qJuZizEOE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:41 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 05/11] scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
Date:   Tue,  7 Mar 2023 10:55:49 +0000
Message-Id: <20230307105555.3745277-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:5:80::41) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b577e37-67ff-4ce1-4d37-08db1efaa1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQKyOtnjN/dDRKsQ3n8LEtZSHbYhIZUJnuyuKAsuEpHKaidfwMTFyn46DRx+SvYRcFXgEoXVJFg1AvGYZqNaK3Tmq5StyFfyOrwIuhsw4XyQ7Cy94IR0yKpq2D969ouGtChsXqPXDvOyN3k1MmgbvKj+xK5Ocmba98PxmiT8hiWVXiveHI/B7n4NSZxp/3CCTuYbbwfLnhyfwI0kBAf4WuIDSfhOo74WzAHNi+uRQBwhn+oiAZXrsRvMlKJhlQwTOpSPgYi3v7saSi2CydTZdHfacMRMSloigqroPo5yVu7FxiAP483axoNH1fS+0j+gx0KuaecI99fOJaPsU/9DhVP0MSuXvU7OCRaR+GD0wV3gXDtw9OYKMQEcsrZJIhF6HdKmtcwpl/Odqpx2kZSqVHmiOvMMtx//b+qQISTnZkbioYHNBdulKeoMs5MeoB0Fbpi32dURQeHEOfXyecjSG14f+/m0fA0Rrv9+3MKtGXm9VGPcH4LDohWx9uqOKM2JUkSGpv/IItgyzERzwrnVTKNbhhLXSmQmZzK67C6SwDq7T7xiwp5kBZdFsmqHn2s3QlxM59UBGo12RC3+dgQwXOigU0jjwVRMPdalnIj4zYn8aPHJLa/JCxLy+05Ut4LIBs4D1XlllfdLWoaNQj5vUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k81oeMgPsVAKSnHei0/4kOqmG1hox5xMBjJSHaQD9RfAwt9KKxGq/vBPGqFu?=
 =?us-ascii?Q?LDhj8pfOsnn6ex8RG7Jd7qrJZkLRKUXM/3vhhLQkKYvlMrPuNTgezHl9l5n8?=
 =?us-ascii?Q?rmom37xkznq6pcdnem50hP9Gdw/1218vhxchXQMydav+M2mqEqJKOvpsgQtb?=
 =?us-ascii?Q?UWEmab99KccisfqIQC21q/1yZ/7dOTRd0S3H2ksvhNwAAaGVpMvkDBIobiUU?=
 =?us-ascii?Q?7SfMNjYuBkaZFM+xrGT0Z0wz8nyHQ0Iq8BqbDPQF0oHI8rF9c+iq8x+OaxQJ?=
 =?us-ascii?Q?H7ZGGyNyqcHTsPUcFOBHfO0D3v2aKSgSoaPeF+oqEv/2xYqtz8osC7QpKJvA?=
 =?us-ascii?Q?2asHNWpXQjVxPOk5VEMdlhFpnF8I1BJWiaJj2xZo5F9cbYnx6OJsPOb2ArVV?=
 =?us-ascii?Q?zstprQLQH+1wiPlXTtsiLSoFHxE5LR0DLNcHj+IKO0E8RgU3MKvQoUxd0lva?=
 =?us-ascii?Q?AaOZ/GUyN8uI0s5WNGUvs10erUMUwvR85xZVgNxuvR+r0oF9dGzppVar+BKk?=
 =?us-ascii?Q?iV81MhUMLHnHgoNiu9QIAUwLkOJQtnh/D/+jWO63/3Fvs93evllJJv+SLjJa?=
 =?us-ascii?Q?6xPDyIXCn7CiebBbqCcV4xppZ0+3HH66MlZuFMaqBwXLUHYuGlX0mbpVFDuv?=
 =?us-ascii?Q?KPbDE1rMxm9nLr40tpbyPtbmWI+6XtMwhl5X/4M3XsSs/CpVySmDVuy8rXdO?=
 =?us-ascii?Q?EpZAyTWJY0Q8xcT3LR0GNN2znP+Fqo33MHN4/wJYhKk9FpkUvZBIY93D/Mtp?=
 =?us-ascii?Q?kRCaY843HgT6JlAI92eTPm4jH6AY6S4EQW8qQAP9wUVLN0tbMQ+gCjxMMed7?=
 =?us-ascii?Q?kfukvdpmCF7RTw4rwf/QZyWLW+lUMJGKg3j4f5m/kZFi6pEHmW27XnkGiOGn?=
 =?us-ascii?Q?ctB/O9ygUvao+/ksYDqmZKnsKaIZxESv3DtWp7cMYx8WxuJhDglVDLFVhuEq?=
 =?us-ascii?Q?bv+BLono4F9vA2O3jtwkan+tsctdh6g6GRrO9O5Jy0RPI3xwnecJW0VgDqkZ?=
 =?us-ascii?Q?ixo8CjiF+YJ4BTDoMKG1WnxMp50tQ3EfNu92B1XJG6zim+Fix2h3C0tkSnzk?=
 =?us-ascii?Q?+yBaVdDgGNd71x8DhInI6cPtwDbCO1AzhBbZayzHT3zkB2P2VGqto4mEjzs3?=
 =?us-ascii?Q?qfFpJAXuFTeH6aLsgb7chwx1/LSuPqK8XL5DSpzJHLWD11o43n/RcjijbaDq?=
 =?us-ascii?Q?OekJZ8/i6wS/PXQBTLzlBzQZgyF5XxboA94GozES+JXSTC9iSbKOWbvCHwKF?=
 =?us-ascii?Q?apNpgcO5hK5dBRWKZTBw8GXEyTQ/OzmLjqNjbCHFYEFpJ4OuzawZBQdhXIOP?=
 =?us-ascii?Q?cMwJPct7sdGkY9DgSrrV4O03CKTUn2DAspOol4BTgMI0024zsNsCRoc84YUc?=
 =?us-ascii?Q?h4rrd/x5lJyqWKAk62/ADi+iGr19Q0mID7FBeOcYDX3/AU4dwopkSPk732uK?=
 =?us-ascii?Q?DTL0PDYcpsXSKF/GjKHiJ1duXjwaMm7xVxkj1dKnx6Z9MGMQa5azY75Rwpmr?=
 =?us-ascii?Q?Q7skK36xD3C3rU+pfolNbLv/hadMrU1mfnnKDyYKtTZksz6OomvXSDGX9BQ3?=
 =?us-ascii?Q?UVwFO7Df6Y9q5AxeJlpMu9ZKbxFPGC2Ntru5G2KVBcEEQkfPMm/Lc2973Q5y?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bs7B4nZxS5Lv3THaRzuBZAJHQtbJkU/+iFix0c63M2nGnTVmDLE6+tDYFEVB3Pz1Ie+8QGCXlSQB95TUpVxMf1wycgn783h47pnEzhF1FE1plj1Q1QaRClEiHWh/k6glFv4N+MEblCYDQWmfFR2L7NLXYLFo+SnM1XocmmsrqgCneOEm0CIRv2S3IGCpnFFtAAio1IoMq84B0mt0jijSF9saIzS1wog+nj/I8chWmVn7vSGO1dU7UozYE4TaxpQfSzR7BwcE2bMbyCaKF7dvc2Sag+FDiv94+H1vRtsoCTc/JQ+c/1HD7hF2+C9+kpg+EvmCaSz/Zuz77r8vtEFCr1R2j98otPXNI7Q+2fHxDOJ7UZsb9ZA+csbv1wRFElyKyZxGowcu28a+6u/wQ3PuiPyBBpus/xn17fBmSe7EGaPR4AOtP4/qN3TDlWnIxhrqb1HHtfonc2cK2vP9Pv2l1H3dREva4dMTOHX6g1uM2GuSc30Li5D6StvRVk2dLiEIvIQMTkLRLP7bKPi9NSiYyU8a5lTjypHyKAN3RE/ohWgx3noKVOw8MeqyH627lHaSto4CHbas6jB8RlDQB036cAnx1hzQs9VlDm3ILuOrffwO3vY/Vpr7wvwvxLh+qJ+J/+6H7A+oMzrzgWNsir5WOkWqKycV5oBgT597S/TuTFKHxot8+0GS9txXKEwJrB0qGaNJ1ob8OGtneJNcFPAmcoZUzJ4JbIhqO7Y1VAd5PVTLA/lyK91P0slknTPDXIzwZV/RCr9qc7reqVpxodAwGBqYPHgTzGuJKoRL2p2dUfmphzgBXyZXfoZq+oj54aaF91Ro5SNkNTK997TSvBl+mA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b577e37-67ff-4ce1-4d37-08db1efaa1d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:40.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FghyD20cK+rCuFNzTEEnI5+YmD7DsKrgrDyZvOa8A+CoGmkGieNIAMskKj8kt0RJgqUTMbUU43bnu7+kMI6D/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-ORIG-GUID: 6GUYQJ-9NszgxCX4vLgAfNtmX2-klosN
X-Proofpoint-GUID: 6GUYQJ-9NszgxCX4vLgAfNtmX2-klosN
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
 drivers/scsi/scsi_debug.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b67d0c72118c..33c0df6a3275 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5389,37 +5389,28 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 
 static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 {
+	struct scsi_device *sdp = SCpnt->device;
 	struct sdebug_host_info *sdbg_host;
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
-	sdbg_host = to_sdebug_host_from_shost(hp);
-	if (sdbg_host) {
-		list_for_each_entry(devip,
-				    &sdbg_host->dev_info_list,
-				    dev_list)
-			if (devip->target == sdp->id) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
+
+	sdbg_host = to_sdebug_host_from_shost(sdp->host);
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

