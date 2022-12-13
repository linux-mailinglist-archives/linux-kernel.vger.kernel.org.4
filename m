Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4EE64B73A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiLMOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiLMOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:21:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B11FF8B;
        Tue, 13 Dec 2022 06:21:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDtNbm028415;
        Tue, 13 Dec 2022 14:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=cnqBfdVZbw85DPH1nQCNAH9P9t5OdF++7AtyCjDd4AQ=;
 b=GGH30OAYrxKEgxudqCKMU0S47pIjFWXhzkyq470QB1j+DSXZokRnsmLu9RAo+Tj3sWRb
 we3zmclVmmtQqzyI5QbV/qx1dKhtu5xT2X0KLCw2BDZ743sBNfexjc6XDG1wsRZv69Jt
 2YQ7C8rVuhtOtQh38wAHYTkzhxXEA7j/tcqgoMugwwFJJbLuzzhFf8bDzFzBekh7Wdte
 wiMNffAj5UDRwh16BqCDsVonxjmYga1NYt9iHNdC7nDvIYxDbRlXThNFut6tEzlBCmVE
 9syWSoaASYKa4JtnNghS4Bo9rURFdZnfFCpaTHjVYTN5czU622nEN9yDWpAkGMlxXrPW bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcjnswcre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:21:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDDhHFW031740;
        Tue, 13 Dec 2022 14:21:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj5s1ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 14:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0+DHUGf7BFpsDOlzTIdivTFTjlmK7R5QUgCW4dsVzEPAvOEH60Ci8E/br4gdzwp4PPqXLhYQ26wjlUTq5y4FRZziH/p4LasyFfpWjeTKPpx2uRS9ncNNyQk2SmRM8eXmozA/VZRFzNDfIWaaYKHz9l271jmotE5/J0SldX41ksCKpbltj0StSCEMRCjY9kW9HznswWxnvmxv8UbPyL4kLD+jxOqnuPrpf1JQJX+fxbJd4AoHOvjDZaqVwUfsxMQKCeM2rzKh2kSWxxhjfD7ana9TXut5jLLhQ/9cjREdS8c6YM9VgJGD0dQUXC2HqoQ1mKE1vcQeqxVhYivbztlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnqBfdVZbw85DPH1nQCNAH9P9t5OdF++7AtyCjDd4AQ=;
 b=Zk2MCCKXHvGiffCpTAaSwLSRfQ23Vt+YvGZp8I50+nLznD31Kbm4g3HdJm++Mhwk7YZ1HjTnByYhttnoFELu/Hjib33sow6pb0+wIGaph8eunhLW23IhBIuClrYF89q7ApyRSFfhuiNa06fn4N30M2Xa37FJxX4iCsmaKNV5JfXLk7DZvcC/NdtkbGfkj6R5iTB8bV2jMJaub4cqyiAayXV/s77umky2QOKN9e3EvwFZPjZFLVaKhVflz9KIiFNdbD82MvnFv4esaUxhUwqUXv+vTlGQ4/hpD1Hcap/e/GI0GE9J6ErojHNg0cvIcpa1tSmZgNE+jzcyTlIbwn/noQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnqBfdVZbw85DPH1nQCNAH9P9t5OdF++7AtyCjDd4AQ=;
 b=PvjWMJxUtBpv1eXRvUDKDANb7kBr+m9SyRYOju/Mx2b7vviAtoVRiK4QMhB0V4m4oFEEaczgIxRCc2bWlz44wVFyV26edP/wlsk5xh11IvNzgVsi9KBuzEjzU56T1iaxEPATDp8vhLVMd7MiqpIcae53XaPXqVXXHv+QmcWvBl0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 14:21:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 14:21:36 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] scsi: scsi_debug: Delete unreachable code in inquiry_vpd_b0()
Date:   Tue, 13 Dec 2022 14:21:22 +0000
Message-Id: <20221213142122.1011886-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b51229-2559-4d32-d94a-08dadd15578f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSWVlpnFbnS8ipyrO88WKkQVZQhs/chL3UslFb7mKHaSrVp3+8DpVb+Zn1b9uOG0Ic74BCegfS8zio6KNHTXimAOYNmc60GIyEfb18JdQ2kR3GKh1GzpaT/eO09NLP2/oNwIn2apSWw5Br0uF0hcHulV4eMdwjvK8PyyYhZY+67duZ5aD/zt59Bv94hBsiGLtsuAHQjnR9XHoYmuaztzj+uMtEWc0E6dtbQN5+KAkO5pq2Ph/w6efdBekDghPhonO8XngTWmtCYnOBfsS3+Q8Z4vMcO5vXM8PBLA9AlFJmlZcu4U02rwkPUU1VtQaFjnjSehGIF9H/EZme7aeLoXhaVlwCeCzVCzV4Ps9OicRCjz6DiRcX12A0wavnYH0vTQHw97+Vf8L3wGr0SDWr7xuudAMD16oGKA4yqwhvoRZgpIVSTvopodnL+HyDKXHp7a8xtJ0CxVw6FUrfYEymtQW9nk5eNVvWTp7/WHnY7POqPZ1fjoK0CMyS6Bs+H5trWCib+ESFsTlkBe90gtO5CRDN1L1sJzUIkWTEdwKy6yrWp+TJU7gr5GiwxEFsaQnHZfkbJ28xkgVimrE256HY0lH5+BAdi7mfriZpUV9kiCQlOebv2xN5SgUVDaV+5BULNvNzqOi7KVtGuBXuTHMN1IjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(83380400001)(66476007)(66556008)(41300700001)(8676002)(86362001)(66946007)(5660300002)(38100700002)(4326008)(8936002)(316002)(6506007)(6666004)(186003)(6512007)(2906002)(26005)(1076003)(107886003)(2616005)(6486002)(478600001)(4744005)(36756003)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YzzQH0Th292cNRrWmMppQ1MDdP9AcYiG5Cf7xqKdP0myLcZhhyVisNqusO+w?=
 =?us-ascii?Q?ff5O9fh8InH1G+OisrPR6uTKh6D1aSOwEd/p1io9kEQ+3VCZ6gGTil5dVpwn?=
 =?us-ascii?Q?QmTsD1etosRi+q4eYEwvoZ3mzLFpMq2Eu5+4UbIsNFb9oMHRo9zNS8cd+mm6?=
 =?us-ascii?Q?asTrt6sPVq5NM4XJnlK+ZeIap4AqJV38zgD0BtrMbJm6+xKrs3uxy0r5O/DT?=
 =?us-ascii?Q?LG3kC02NI1Vw0SWki4bnbDpk7CPHwO5sot/M4j4uhdO7m1K5Tj/Bo41+RNG5?=
 =?us-ascii?Q?dc4bDs2VRnjAQYgUOZfPhJXtIMRvAVAkGqiCqljOfHLHDiZ1PUAKAd2+Whyp?=
 =?us-ascii?Q?iMDihAleAgQzitqv/oTQ1+wk1SpPOJ0GKkkrlk9Zt2HhNrtOOGPUHyJjdWY/?=
 =?us-ascii?Q?y6e0rzOH/IA1I68JEM9LvCfU1qo72Z05ilH0WywR0NtoMz8lUV0GnUbNo71b?=
 =?us-ascii?Q?3KdPY3dGpZfD7lN6+bf9onfpq20I53f3GbOTNic6woq714lEKvpVR85UeuwE?=
 =?us-ascii?Q?vD54pqjqoEA1JXvl/kPgvopIc15YejIU1xnzNj7miv6EihgFMUwdF8Ded7gd?=
 =?us-ascii?Q?P0iMzmDucyajU7qvHOivW9Y1ccGA8D9lCLVLStgEP3t7Q13CkTjtF8SSFTI7?=
 =?us-ascii?Q?TueX5Ucgl/6lhGTNv+L4IB3YtpIdrIQGh9q3GKK9luHkMs4/cAeVQEbF9WI/?=
 =?us-ascii?Q?ln8g5FDtO2JWHeIPOKEMB7arBYTlxhKe7KE+O91kLWa4RfWU2mJfNsSrSMf2?=
 =?us-ascii?Q?sQHPxLotWCZ6zYwnchgrZM/gWTYA/f99++fFgfLWqGiSt+tosDfuOgv21Y43?=
 =?us-ascii?Q?EUDlG2YJF4tWMPyRcvabjZ9lKbd52EWw+m3A3AR4X0hnMufN2v4pmI/MXsx0?=
 =?us-ascii?Q?xZpTWTHcNeGeZq00mipymXRWJBt3ddVLEksjPMbxKhgibqoxN3l7Cl/l9cTd?=
 =?us-ascii?Q?3KpfmbM6KFZzVnPQf2x1DnGnAJDL21EWkOygT4KSvzBBK6nqm8t6Hvcl94+Z?=
 =?us-ascii?Q?fHg2PPaL9nGth0hjupwCSTecq3lHjb3r0d9q/Rs4ZTnP5fJdEojrTE1k0Yg+?=
 =?us-ascii?Q?lBXlRcTmItXHB+sFRrNmQu/jnjWL2zab9hD8x8SF3YrHbU1Y1rxKlZ2gHAKJ?=
 =?us-ascii?Q?L+tYpeR+ArybCyErzo1pDH+m4f7ELlOHGkLpAoKABbnCG2nHgeXEn7BHx3fp?=
 =?us-ascii?Q?4giM/gX/cem0K4qJ94W3NR8kVzuwPwLiUrxe6NsExvcBvztp/NYNL3Hw4DOh?=
 =?us-ascii?Q?kEclv6j3wdETFMN9Hm7jCNEj6jMPETpNWdcef/+K5X8D7ro2HeVEW68O3He1?=
 =?us-ascii?Q?eu4T+rYDTMGdZyY240BUZ/gAU2O7Qkhvo8rSKtQVxExjwdsQg/nCuMR19D7d?=
 =?us-ascii?Q?u+35n2F8ZNBo5ey+zAgNAcP+AfdD+329OnCqZ+dmUnljQTe8DHhryMvt2k+s?=
 =?us-ascii?Q?UygjqUpDJZtBV5PegvSn5GUzMbsqJkmr/SVfejDdcihV91P6XWvpZdse2h1+?=
 =?us-ascii?Q?vOWVCyhcCqKZqn71PalG4ld9J2sm6MTx177FFfRryLQVXBa3DsnHvCZi2N0/?=
 =?us-ascii?Q?thXngbFEQHmYOccmSyIOEyRzKCXvKkKKbxTVGmTzxaaa3AORWSAgDOPYcbk0?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b51229-2559-4d32-d94a-08dadd15578f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 14:21:36.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KiS2Zk9bQG8HgonZKX1qbv6BOz0rRitA7R2FF7nMQxOFO4LYHTgxQcbKw8DDA9mXtmkF5P7AnIScJqeyAiMAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130127
X-Proofpoint-GUID: u6leWyS-c73EkImH32QSeXx4PdZzQbOY
X-Proofpoint-ORIG-GUID: u6leWyS-c73EkImH32QSeXx4PdZzQbOY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2nd return statement in inquiry_vpd_b0() is unreachable, so delete it.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b8a76b89f85a..6f637501539c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1511,8 +1511,6 @@ static int inquiry_vpd_b0(unsigned char *arr)
 	put_unaligned_be64(sdebug_write_same_length, &arr[32]);
 
 	return 0x3c; /* Mandatory page length for Logical Block Provisioning */
-
-	return sizeof(vpdb0_data);
 }
 
 /* Block device characteristics VPD page (SBC-3) */
-- 
2.35.3

