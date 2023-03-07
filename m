Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36256ADC89
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCGK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjCGK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6397574FE;
        Tue,  7 Mar 2023 02:56:41 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32784Cv4001853;
        Tue, 7 Mar 2023 10:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/WSKckEbUSVt5D7kzGlMREy+vUNR4zK/sl6IpcEUTi0=;
 b=1S5cLbU1bcMzZ8l9I5Cdt78vTs8qYTWWxTzUDDQvgqjEbPO5DYvdCyW0OBCuEpnVSwry
 VwFAZI5ERGMQV3OzeYrO8CCHhTZMMOAUgd1AotDe5tRiZsgyr8eDrSVM6wUuc5RLAvMR
 k0MYl5v3T/U3uYHvBlCKDU/SqK6wkodmVhgy2KaQbYXUBRJqwA8RfMP3pjwmYugo9dbd
 8+/SgKrmLWxPMC2saLkF5vqLQ+E4Zto8g+GK+hpiXW1cFvB7Bj5es0HuFcrfjya/u60V
 cFl2dSOWp2N3JR4TBWujBCEeEYbWtOXjdr5Y4HTkFb+R9QzW/KZpxPEoWPKwtWf/mtLV yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415hw875-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327AY0gZ023444;
        Tue, 7 Mar 2023 10:56:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u062k94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgrFiXK3+PPt8KUrwbw0QEKCSAQWE5xZRCixhhSp7/zFj8ncWcrMrHkxAUbjAO0cMhUGsB/Hz0cQnMK/SDv+Ua2Lg+GMYueYX2bR7bzrFcwfTJhXvL6Q33NYQqAP8WpWGQbKFgUrCR1qxQgL4ADdbTOSZxyRVWA9PJtGSTKRjhVqtj7a7fSv7ZjcIXRfHFxf9ISg+6GS7uNWsC1nYy/Y8sJzSt1+6uYY9HSdW7jLKUbtmkrc6l2o+Q23tpF+vKvmlqv2lSJejnEHVcO4EFTM4LfQgJjzDh5DgMQYrSDs6O4qQXGU51Hexlqw9WX21Rds4eZ/d1EA7FR3oGdt7jsWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WSKckEbUSVt5D7kzGlMREy+vUNR4zK/sl6IpcEUTi0=;
 b=mYvyA3Ev7in4lIWi0wdih9wh1gYNtVLchrdMIQqABljlpQr9xFkwb9SHg0QaDkHzYc+2oXPzqoXGmByrnFKVxscyxgjtHZ0KOtMAynyd4cLT4YhI7c/tJ2lb8vVXMGrTbQ0rT2Fu7T9hBl2tGhyTxc3wsLDzU5IDJ0zwS78NrbBXQAhRsyHLo8rj8a+sH9T58xnKlVxAWeVRpKc8/ZB4vnZ2Om4q0AKFZ6YVD/9MVFJqti4zkNstlV5MP6t+yF3tRQEPiQ5zSF6NuI5SD9FL3Tkyw7SJOWYCT6i8Hvco6NK4ZqcvGMGULwK7OxPrswODr0RX8RPSqaLfNYOc+6LmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WSKckEbUSVt5D7kzGlMREy+vUNR4zK/sl6IpcEUTi0=;
 b=X0TizPFTLiHOXNGkA1yMugIrglyIH0W/ZQnc7QsEudR4+955Yga2Mt0TJeqyOReQ/H0RiZoU2lSudOVYghOJcPKYqSoxFgdivZp09qQLy22yaoqUIcNKtTG47nNpMOY1qw9Ciravh+MckCBkVsaXHhYEqoD6iZbII6uf5wQ3WNM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:36 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 02/11] scsi: scsi_debug: Stop setting devip->sdbg_host twice
Date:   Tue,  7 Mar 2023 10:55:46 +0000
Message-Id: <20230307105555.3745277-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247c82e-2f8d-4304-9b93-08db1efa9f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2IdmTSeA5luFjxZ9tYWLdxeUpX1F9YeqyxlbBKmVtBPcC48/kklF0iY2YjM7N7tDwUWGnU1RM+7LgadL/GpXemMk4jWmM38v6DPf3zoT8gfxYOXLqsdup5qv3IwU988Ho8vM3ja+72bx1RJ5bD5fPqGZtSmdgmYNB/R+wuWsDCpc7qaPVBkN9uul4STBR1ohojFPSeMG8v6RwUjKJiNm0FPxo58XkvxZF8up3ctQKBOz9AWDeH++jgrH+DbudgTZlVaQeu5I8svs0NiMHG3WNowm5JVfH72ctPQ0sFtPGeArGM0ELT/GjIthikEHXOfij+3PKZ9x2GdGPp2dfCs9ET896Ln9E/dCv3AgCCQdtEN3bR1ZwwHn45lqUDS+TsOmjDNukteniOyfNRTa9QvouHtNGLpCaMx8OAEn4KlaCVVo4U8Ou0syIX1r4kuQvxind9UNHiQhltG44lYlNtuFYCaqbiGkR3Evz7iqHdFD6KGDw1CwfZkF+9aCzJpYyPAyBAvpm64ZuEmqWcbCca7PcgNS40Ydq8k42R+KOUuf69uNwbYSk6QL0TOCg5qc7KJ74fFiTyOBIfE5750iDmwgDhfJZPetaxKzMEzUvUm51P6Vd/J6/x0Mu+hzTyxGdjouDMtpY2JZNEzg/ldQHwcIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJQo5rr/iERpgInslEdUaQk46xYef/I3elqPDSvq9h+ykkeRwMZTBpsTr/6J?=
 =?us-ascii?Q?SR7Wxpg2KCnVPSmhVOITL37Ttl8f9JbdwwHG5yGCKZhyr5p6GZlVo6bAFjRA?=
 =?us-ascii?Q?pFtNFI29hAtOOhyF3ugPqZ3t6ZGmuVtiAEnC1c1ioV9YCm1DFWups0KQ6q2N?=
 =?us-ascii?Q?Nh2dhgJocAM5EkkcwaX3oivGHtxq6Y5N5GfzR/hJHmJjtTSaLyMwX+zwpmLi?=
 =?us-ascii?Q?cVFN+eO91dYS3FJNNbM4D2+7NTOOdY6zAGWwfm8LAC9TZczZpjrl3Xe0uOSO?=
 =?us-ascii?Q?ujRAow5CbUBqMHGN6JwTUKNetKQVBoKTGf1YKk8JdAKpaDgXOTrxZkTJ67QA?=
 =?us-ascii?Q?LRa71teqMj+peE/E4NWjgf3H4Opyp8Eat6Piv8eAY8VAbiAYk7SQKLjsfHuV?=
 =?us-ascii?Q?Lr1g3oo/0F/DKQ2On5mrOOp9ihj3jiiWqp9vUdhdNlu8pgmNbLy9bT4T2ipc?=
 =?us-ascii?Q?BUZ52tg8bxDG4FPZioQP1CeCG35mOglxla3gqFFRyGazCI4TQqK9vngtoCGR?=
 =?us-ascii?Q?kMtC/vcI5qZXNBI59dfokTNmc71T4Bh51auDmW/xBC9FjVrn02hpKXCtKZ6x?=
 =?us-ascii?Q?86yCrBqn/WlGgd5yR3lMalmUo0ed+H0v0J9fyrqOZkqg3YSPj7naCFdydgfU?=
 =?us-ascii?Q?GFc5nu6BKL4G+BxLitci1yrxtuQA0ozWCSY1FG3SwsoIOHPp0fH+IUARKDyx?=
 =?us-ascii?Q?LahEhcNkzxtiTifyTj7n1dhDc20XbT8zVBO2Gocu4g0DNem+nL+Ic0j54jgJ?=
 =?us-ascii?Q?wzjujtqmzQO2utaoDHpm9gvkMohT86qsZTG9gsUMNi8SFRUiyGga85fTKO1Q?=
 =?us-ascii?Q?dwV802MUGOTIxywEc51d7caPmjbix4/mUvcjSFk9u3oQPuBz8bo4tBRNidf1?=
 =?us-ascii?Q?USKG4g6iYRSI4oGEcnE0etXoauwKoorZrgj1iPBzvOmUNHRUULM80U9iaNLG?=
 =?us-ascii?Q?UDIaIp5+WHQEHBddQngwCV3h4I9ztt23rgoN1pkrvmDcz84zGprz3Ztto6l/?=
 =?us-ascii?Q?lAa6VIcgWv2xIdI/Vbm2olp6UF1T+6HTbp37ToU29H03vqyNRcfPKag1DWCN?=
 =?us-ascii?Q?kKMY81whmfWtUb7lsN3inawJfz0zwFJ3vP9MR6QiEfNuC92ejRGNW5Ww44a/?=
 =?us-ascii?Q?OmhvUDLTqGW9WCGhkNT4TTHLT5zwLI8JGsHh4a/F7AO6TA78QBxiGQm3f5AF?=
 =?us-ascii?Q?6ZomFT+SZ1uTDVO9kwAOXyasMfr9KY3TiAZZ8YJZQFE8d66femw4gUQFz0nj?=
 =?us-ascii?Q?aoiksScP7IEDZvtHXH7cxt2T3IzWj5igwNM0RHmi4eyRu8wZE2aSuhfMWLsG?=
 =?us-ascii?Q?X95IJgn8uoMrILsjiyqESTgO/13xl2vUKnsjXMzf7gNTdxfhUbNdDnFO3F0S?=
 =?us-ascii?Q?vqiQBBKSa6EuFl8HH8A/YaVwjFbrtf/ftU5wlXp3zMdixKIPokmWW/U9zcK3?=
 =?us-ascii?Q?qdaHNAzfyfM5nXQRBgV5Y5jD4nGWqforAHzpRNKpJbvmaki4sVEPxwap1K1/?=
 =?us-ascii?Q?wHrzRHVKPAhSMF2dCTI2uw7IV5Mdl/Yof4jo5UzwJ1+3K0YAemjOEGh3+nVw?=
 =?us-ascii?Q?2oUD+lcJVRdiKTxIbvFzK1O4iGVJYkQhi+0EtU4khYJoDKhaCBCnBxPB/iby?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j1yVQykTNGjFL3Tq6RPfCbhU+fZ1xEttMSzA6x0Qi4cbaGWjFPLz4NDCrmZfBLsWnxsVqijdCaXtyqOXNcs4j0SEqCwGSo3iYQn1KfktQ50jVvK+lvAoaHcSiFO60NV0T9F+uelhVhCPqhDkT8o60ImZQjKyLNFV/MQpcuAONKxaIaAwerFFXP55UfweAskRVZJyanQ2RNRFykgMiRRIDPSADFQ2uZEPzc+FuGcaB8eOZCGEkq9Y22ddbQvVaNIeNAH1eyudV2xGXgzNF51vJKKWjqbHYUhdr/3CusZ0/B857/tXiEW9vDvzUV2LbCtUEvLzYZuVgSEH5n8spxozm4YPg6p+zXaPQ6XE1Mu8yL8b8W9mvVeHpI9KIQfCSBdnR/r2/24jwchQMabrQz7FA0cAMkDQFgSCEyykSRooAW1Bze9JUOQCRS3o5w4rkv7vmjvteq/J8BxCCTTdQ4K1bQPe/jguof3Xmt5RgTcHDyOtgWu5ASbOQ5dAz0C8vb9RjRZNgOxAhe6d84iJQdgs3gnDTDhwZBinS5UulwHVdraQsIssX8/slOrrzbGtlpNDdz0o7SiurpBYW1CQNqMj0TKlB7y9AgolrTKmpk48X9sm83UsWzfz0KFyGd5wAUT8gb4w/TU8/aoqs4yiQz6dBwNj7c+8//wmTDAuJqT2k4jBz5F2RN5dXKtXllR+hCZ+dJi24z00u210g1GAlZW0kKoYf2oiSbu+atClmZBfpBusNRngBcq5qlfm0FnW4QLyuzCj0QLPOki1Qhz4DwFOtziDQsqbVcRIwmSFs4WXGTzEB6gSjPAhhQfhv6TY1/kggs3iWxvnq1WGxx/U10IUbA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247c82e-2f8d-4304-9b93-08db1efa9f60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:36.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW8HditmiujQDiGJtB7njh2BmE+hOIuCUp5d0DWDgBwMqQzfg69Tvtt2XOoBpZ8uWKg3sW6EOfmvdLoP7vZvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=982
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: eScSKhL36Jp0cz6-pafRoO3dcs1hCumX
X-Proofpoint-ORIG-GUID: eScSKhL36Jp0cz6-pafRoO3dcs1hCumX
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
index f713117a5f2e..6d1c483a0a3b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5157,7 +5157,6 @@ static struct sdebug_dev_info *sdebug_device_create(
 		} else {
 			devip->zmodel = BLK_ZONED_NONE;
 		}
-		devip->sdbg_host = sdbg_host;
 		devip->create_ts = ktime_get_boottime();
 		atomic_set(&devip->stopped, (sdeb_tur_ms_to_ready > 0 ? 2 : 0));
 		list_add_tail(&devip->dev_list, &sdbg_host->dev_info_list);
-- 
2.35.3

