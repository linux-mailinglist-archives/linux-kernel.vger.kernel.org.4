Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2DE6ADC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCGK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCGK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:56:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5953D8B;
        Tue,  7 Mar 2023 02:56:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32784MDr017687;
        Tue, 7 Mar 2023 10:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=tuVn94Qm3UrzyeLRRp8i6f+oTA+ygTIcHf33mikuf5I=;
 b=2F/fym7cHGRA6kHN0hdNnAr3HRYc1OZxrDm7vRVA6Sz8/SvarHDzciIGm6vHwTaXPHy0
 GtgLDnh/ee7xq216RaZ3Kmg++0zk028JjaJhqP3mB4Sh1Lk5cL1apZpkrgmv9/JT5HuN
 k2qynns3lSSGn39fB2kfm8NS0uHuV2Su3UGELX6cD2fUCMlWw+JfaTHN7ip5NJMuZxzj
 NMo6KcqdfojfjyitzdrH3ymgYiQIYXOX0Geh1UfBBPPi5HSnrS7KbUneckl5hMPW6go1
 4VBN8/hKJUxSJvEWpqOCCaJ0bSXZhlklhI5utir46NZsOACgbGcU0zeQxvswnkNp8iTl +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cd6w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3279xmJe009177;
        Tue, 7 Mar 2023 10:56:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2hkp34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 10:56:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDrUnrNT7M6kBfsLpGRa0vsa+rEeix7QIUcyyVA6oOzqtM201O37WOUacshtDXU9ZjdOa7A5Ja6TG09HrIt/2zGxqZKrbDsAJIMTwWk7g+P6TpLEIsGytx2GqnHNcaCZx4ik+9H4R4iED6oSepPw72zBQ/RfZoECNqIBD811EuKSQ6zpLJIXCl19gCRFp4FJmBNLJfO5CATO4AJbs/lrllfzxLm+kaL9BtTZOUc6vRjiW9971QI74tJc9yTV5vY7PWenIpLOlUXb0HqcD8Tot5vnZBDRBCFq5L3wgoSXKkTQ9NmDvS+st586yC8pG75uPAwZOXbS8SjE3AHfBRZwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuVn94Qm3UrzyeLRRp8i6f+oTA+ygTIcHf33mikuf5I=;
 b=eBXsQFNw3tpKdRg+OVWaTIdwUuBP+v5oYpVA9caRpb5TwDQhVPP+rIizBtS1HOulCOpTt4Vr6bYAaCzaTS4Xtsd5CUF5fmx9S+JjMUP+exaXxtprPSXgtzBeUaVxOBKsBwKUJgzNy0LCA5K5wNQtc4xE+qKJaoc1qOvCMZSk1y63M/MQ61o2VTMGxIXSGLncH7iQ+D9jSHxa7NdjJQfn4aSwSIVRCnFPXyrwxG8NIPV9MuIj7+9rY92cT7pn1htCajcUbq4YsjMo4/w0bLEoVZ+vyQ4Yih0q6cnu8MzFAoxl7bYD9HL0sdJKWj3QhehtTYMk9jgsR2HsUuitXHQVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuVn94Qm3UrzyeLRRp8i6f+oTA+ygTIcHf33mikuf5I=;
 b=djaCcfJ9tLnWoCK3TsMiBkHe4Xrg940+X2a16A2BgCupaxEJxle3t+aTt+OpcRnj2EFxWRtdJIlVDiG3uRMoh7v3OmwS3s+doh2WpTCKXcR1brlqeeUn9ZocMa3DuOvi5eHWDhLqKv2o/NA6pBKOaNrRzZKmCVwxX3HEOFrxyeE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:56:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::fff7:981:3ae6:92eb%4]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:56:42 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dgilbert@interlog.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 06/11] scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
Date:   Tue,  7 Mar 2023 10:55:50 +0000
Message-Id: <20230307105555.3745277-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230307105555.3745277-1-john.g.garry@oracle.com>
References: <20230307105555.3745277-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0100.namprd06.prod.outlook.com
 (2603:10b6:5:336::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: c989a234-4253-4e30-36cf-08db1efaa29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78jhTwcKvpA36gHH4RkI9kIjDH4V7I+sWy8ToHV0UuMbtddu+7XhtB+q0O1tFJYLh+86/5oF5qgOxu72HZzkXfqPk9mhPRGK8sCZJVG8OYOYhC6gmSbQezgcEMlR3lwaaxByPjyIL//kCr/15WhNj9+kutmxbTqiKI+qejzRKeb0dcI8bnZq5HO/LyPZq576w6GEK9DUxih4whSyxQn2DDvD/Rpu+0pyXuXNHC1KDJVwSVBeHX4gDDgEpbajpPKDn1+Q6g5ejbTgxIdB/ZFFkjJwTBrW8py5c49N8NxXELQDkxM7OlQHgdy6OfLPIM0fqy9oC1J7E0oJt4o1wlamSJGvzg6Os7ilAN5yw55b1h5RvGCD7ZngmMgHDeji4HQrycsrLJXJnrgL5/MUj+Klw0sDa/+qsPy4R4QuzDd1zESMmoCTfPSmL3L6iJc6UxIZ8fJ24vkDpQV5VbXhzZSgSX20NS/jDZg7BLmCkyNvy2UhVzDvSYDFweYzVVWFIRn8MSJEhi8N/T+Vn/nmdPMxNnxrgEZTmQYqG2IQsJS4/jKtoXwbWs/OWeuzl45YeF/tcoGRSzwiqfvNXqRTH3SMzuq3M889MqFqDpExSzFyg3prinoefZeKEfffoc6hmaWkXuBXv6M67yL+KZBlxtl8nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(103116003)(66946007)(4326008)(66476007)(8676002)(41300700001)(83380400001)(2906002)(86362001)(38100700002)(8936002)(36756003)(66556008)(6486002)(478600001)(6636002)(316002)(5660300002)(26005)(186003)(2616005)(6512007)(1076003)(107886003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2rfJ84pMD2TL8PHbJg1F/ky1Tnj/xXclgAIp0v6+t5Auh13406VLiA0hTyFM?=
 =?us-ascii?Q?jQPdOL/xlzAjRr8E7vhP6ndri4iMdpmpLErca8x++8z3T/tT4xzG8UkfzEgO?=
 =?us-ascii?Q?cWNkksTy1+jeW2ziWIMfX2odZ88oDYXSrIOfvCkyI6NuAoS5aUv7t40WAFWX?=
 =?us-ascii?Q?u+mOXSg37o+dATvDpWzLiuMTPQTgdLHCONYBUSm+gErbDg1AbSps+LcowSka?=
 =?us-ascii?Q?yKV3lEBSafKlmDc7STsc4TXqKpJdZ4/PC+gUjeoqRWCs74aYzWlaJ3zAywXz?=
 =?us-ascii?Q?S3C2NJJQTwTuAPOtT7flY0KSQEgcPP4iH4ZNbmKakJYVLwt5fmpVTXUPiTMb?=
 =?us-ascii?Q?jR58fHPfUg5Gr84bCnY03qaa1yS3tPQPLwxiltmuUI4WQw/Ze8j5x3DiWF03?=
 =?us-ascii?Q?+fL8tTGGAR60zs6AFJnjJ0xc7zwYaZBsrCDj71BfNNKItxSMmxjMcj8PPEii?=
 =?us-ascii?Q?C3LgU04tlGdUJmXRoV1ohVPbSIiXwXLd0PKMDmG6xf5BWDHeQCmyZ309eBnt?=
 =?us-ascii?Q?mB5C/CsoHjVIFw8A/PGGiEDcUf1yKBCT1IdEMinqTTYNZL3jfialjX8U7N0E?=
 =?us-ascii?Q?hbG9032lBaowc+CGHpX7rE6Egp/bv0eUXsapo0JwRLi4BKSGV47laYQTrC67?=
 =?us-ascii?Q?cMOMNgrxx5RvYjc/I6WweNus1VPnw36bVG9uSMxqd+VCCJEywfOmTuRWDm8b?=
 =?us-ascii?Q?bUQqBger1MRlmUeA7QIhgSYpZtwXmMIplhj6oUS1ndD6PlFsDSwe4Zhr36ma?=
 =?us-ascii?Q?r/UhTGfJo9flX7dx5VJ85xwY3dIW/74GKugSoIBiER0qtbLdq8/KN/HL1dbi?=
 =?us-ascii?Q?g4lIfCuCzDzJXgcgiFOUCx8T0UUCtPrhtC+AnZ2SXDtEkdV0ZdHDVLNJch7k?=
 =?us-ascii?Q?0/yI2jQ1RhrzkyayyBu5jdHv1uA8Q+tOszhTJ2ygqBqBDyDZaU84ImeTPCfI?=
 =?us-ascii?Q?Rcp/6Y1V5iiHpZ2JAXC7DpfJkycnomRfA85W0SV8QDRiTUrDtibzgwlHhif0?=
 =?us-ascii?Q?weufRnDmZlEvjUvenE353hC3iJ80/H0es4sGF7NPkcHxpjZKn/t2j2F1/MtM?=
 =?us-ascii?Q?y8lIg94L2m7fD5JSD9/KA5z1zUKi94ztB4AWFQ7YDTZDR1I7fxsNuDPixkAI?=
 =?us-ascii?Q?rCg/X0kX885Ad93qsrCvxumhTd7fVa/pvIAm2cgWKDUc6tSKZwxB2r4DIQWF?=
 =?us-ascii?Q?V3g2lY0guph6QyJpPjuLhHHP9NZD+U6gqbI06V+miLhry4k6sr9wn+njUXlm?=
 =?us-ascii?Q?sxmWJWonKKpxNxlXq4+ArR4Jnlk1Axmuz2Hx1t8XVf2tKnHRaePPbJYjSU82?=
 =?us-ascii?Q?aL3W+pwcEoXpt3fm2T6sbivMwfb7IOm9k3LCToHvPfjf+rRMzn7trFeIyIqA?=
 =?us-ascii?Q?iymHPI4acc5sUtde198b4F0rS+7Xr4J+WwPF0sTyWAG+Cjd5QIzfSfE3Jtwk?=
 =?us-ascii?Q?l6ZLQUEkfj6eTjoYyLN4Nt7Wx35lBjruxH4mzu57i/kKI6jsmdciYZgpPEQC?=
 =?us-ascii?Q?Xui0shULrPB+mZO4W7TjH7bo6EGWUcMkkszHC588IsK4umYZhwzBFA7YR3P+?=
 =?us-ascii?Q?tf5+Aeu6uRg4s4O0SFA3qxIP9QefogieycZ8L00HyG1bEXk+gBDZqwjbgxBL?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8fxxMc9UqSLCCSpfh3wN5PfhKlYy0kriPZEwYVkDu8JLRr3ML5TNbDA31+YDYA41WBLfjMqv/okgW9l/UauvJuZIMiU6o/i25G7Eu5r5QZ1IfHD1qCeMSrqAHSqN2a4w4wRPejgqcqf3tFueqeBwoCVWq9fDbW3IE33RmcVfeaD8C5zvjzKlxOTN0h2Bo1vHY1T/vbuPk+DGgmdUpPc5sfuLEr5Toz3IoOh5fFao6cWPekG5YB6nKyVIpyv2TkChMAHpX9VSeT5s/VzrLvH8pKpkUvPZyRnGz1diocXDVk+u0fUB0JxWjsxCBYu+t9FHncjIvzekY0T7Ir1VxUIizOnhsyqGDJVaC1Sx2TBgknD03J+UkrDb1q0dI9K1OkdzY7Se7PdiNWpIq8cXHSriXGherot3fA+CZ01urVwDLz/J69ohqJslkOAfWaZFV9NXdL1o+nxZZ+fhtk+kFZyOJ096ZFsr85qeEjaAE1NzQlrIf5+N968GaFIUhzsufpdXgqMe5LcvFdXNT9qS2o+OMYZy9qVXgE5pJnjxnPFjFNUGPdxDuvp7YCTwEdZTnxb0iQwc7FraUBgFLPGNW6Ng3lhXoR8vLQwRY0KowSIWdKpJckt8VT1DehJ3KueopBmvBVpMLJj9Bz2T6sUJZ6cJBBJ/n4kOLrxtjERo+HXFCOGZXC44luoUGdtw0FrtJx7E+EAnSqiWLP5zmJDRZGnXukr/kcXVkY34voRp4uIqXID1ZnfphYpYMQF60u+quweYRReaYRadRBFZHC7XQD2XoMKtXQNOJrpGoix4ueuWgW1+ddRY8cJHk/fwPLL2JmSbQ/pnKNI9dTBdZiIPY8uBjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c989a234-4253-4e30-36cf-08db1efaa29c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:56:42.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2/NurEuMIpNLvy6CNFoAvbiX03w27R/ISQ4unVgCvqGB0WOy8ukQcxSmeU5Wp152itTC0EN2Lk+J5UlEAJ5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_05,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070098
X-Proofpoint-GUID: lCCvkKfJjQG_Ld-IGWIX0G0pgGJGzGbL
X-Proofpoint-ORIG-GUID: lCCvkKfJjQG_Ld-IGWIX0G0pgGJGzGbL
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

The only caller is scsi_try_bus_reset() -> eh_bus_reset_handler(),
and there those pointers cannot be NULL.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 33c0df6a3275..6f1dbd8dc37f 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5418,32 +5418,24 @@ static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
 {
 	struct sdebug_host_info *sdbg_host;
 	struct sdebug_dev_info *devip;
-	struct scsi_device *sdp;
-	struct Scsi_Host *hp;
+	struct scsi_device *sdp = SCpnt->device;
 	int k = 0;
 
 	++num_bus_resets;
-	if (!(SCpnt && SCpnt->device))
-		goto lie;
-	sdp = SCpnt->device;
+
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-	hp = sdp->host;
-	if (hp) {
-		sdbg_host = to_sdebug_host_from_shost(hp);
-		if (sdbg_host) {
-			list_for_each_entry(devip,
-					    &sdbg_host->dev_info_list,
-					    dev_list) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
-		}
+
+	sdbg_host = to_sdebug_host_from_shost(sdp->host);
+
+	list_for_each_entry(devip, &sdbg_host->dev_info_list, dev_list) {
+		set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
+		++k;
 	}
+
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
 		sdev_printk(KERN_INFO, sdp,
 			    "%s: %d device(s) found in host\n", __func__, k);
-lie:
 	return SUCCESS;
 }
 
-- 
2.35.3

