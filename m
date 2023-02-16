Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE746998BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBPPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:24:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252693CE3B;
        Thu, 16 Feb 2023 07:24:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFO0j1018274;
        Thu, 16 Feb 2023 15:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=zxtjb2VKFRUv4hPq3tp+h48ZqmiIuk/2zTjpfIZceO0=;
 b=VSJE9w0dHREYY2MhYXXLEnKpHB6rBJYzo29GeHg5FM8uQwETJptqFYaz4yBGhmEdBuTx
 AkiQ6dPunKTJWB0pMTfpnXCWq8+vL07aV3TdhsHFQhmA7NiZ44/Cj66aQm73GH6yCqHb
 RPFzkwwJLdE+S8lKqlgEbq7wjxGEmy3BvntNMo96gcfkkIDRob4Juwfx8xFs4IiidS6c
 FUaRqhRJ7t6505RG1TyrpsumgtkJnvIJ+ShO1O2eWuFLE2IRwFxHNvyZmehCDHZWutrt
 XhEWkkwyyOFD+110QGGFrFXODpxhv/Y1bJmOLOBwGq4KrYIHjNd4BGG8DCBoIpuTivZH sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32ckewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GExCZp015064;
        Thu, 16 Feb 2023 15:24:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8rrnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUHXzR97OBkt+MNVbZtXoc0lZdpLlsOOkygRQ49u4BO+Qc9tO5mCvtlZpFN9yHGGkuMytqK1yh7zV3jflgClhb+hriXi14d/jfeN/YFPHrAwyN/7u6Vp701IZC5LAOKbfCAK3GOGuHGzfLDJZLhsCIEHNQB1L6IopslcwK7nnXhGDKVz5sdISqDIyc/n2G8Kk5c4c35RRztQ+VsLPIufY9MssRQNZQipEhEm4R1KA9UpDMWavBOBq9yEndLQcHkL4y6q51vPUgeu1dwCQojf9NbzyjUFGKXVvk/YqO5CTg3pXBxvfRkU2aGiGBBmLmpu14r92kD5d5nBv9rv6QqRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxtjb2VKFRUv4hPq3tp+h48ZqmiIuk/2zTjpfIZceO0=;
 b=k1orMKmQ37GTqrgAYTaFGIvRDAldEfBK+r3MWtudL3uvrYOoll9ljzR85lZIWBYCpk+phgU7kp6GShQvrLyPhXT9IMtWf2lFjEnLOBCMCxxImDTOLO0fS60hhm+GLTM/7y/8hUAevKwxE++Z6JgSPYJDJyvNOCeEXjBprC0SOAK5Ovg1n3V6G39KsC6uUM9sZ+Xwh38uXEQILZO8zB2nFEHvl/tYE8Rg78YkPXTNKHluhBDd51K6IrEMs9xgIF/Gf949W1TdcPZwxTwAjYXd4vQDeedzzLWubtHlRptH+AhPgLRVuomAYKc10biUIGjc+cLriJGKWp77o04igb5fXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxtjb2VKFRUv4hPq3tp+h48ZqmiIuk/2zTjpfIZceO0=;
 b=0QMf5Ar/Rd06HMfxj2a8wvDGyVDOCIUsBvltXnRLahCqSGnAJr0HpSNflforOmy8/JKS5XI7B1nM17q+RRW2WTpbbAo9xBTnJAMlIAuqr79xfmSwtmLLdENukL6ISEkiCQjVUcQvUVs/OYyuYVkpPY6SglnK631ccgLnzkXfcyo=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:26 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] MODULE_LICENSE removals, first tranche
Date:   Thu, 16 Feb 2023 15:24:03 +0000
Message-Id: <20230216152410.4312-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 433845ba-5957-446a-3b98-08db1031e38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6S8udrrGa6k70mGg6+c1V2/kLH0am6q8HAdiwxIoxlukOX9tXZoqtID9lDvRHO9jdBGDFGDak34iZLi2hl0QDv9chKxoeEKE2NOeCIMxKtSjFPUuWVeqhGFv++xHig70+XVKl2mdCPLwGhmKyYRY1J/zhCScS8HVsVT0KsIriXW1fW2PPRSDPc1pzCKJO0WnuhK/4Yj85Rl5JkHLftcFTEFCTCV7mH9fCLr5+X1Zvq4o6s2AWmy+2BazXon4/OzJkogdeNFU6uKw4iJCKSxLwPJpiAVfUx965G5+SVFL3qHhl9+yanRMg45Yl1nKfaZTZ4IkNm+SwhfHOtHdoDEZJm0JY6GsNM3KmycHudAjD0s1kPl+I+sAl1wByPkHJ+GQX2uNPrviT6rI3XdMM1gTOtka4F6aJQUm8rC5K8ncc+d15QiidhIJlnT7gzwYitj4c7LQpz7GidAiMcsJWH+BHB8PwL0c6ZRLEMlbjsyHZ3dIzxJdcZJpFcFnG7rhV+tAE/3WLEhkYc+tETqknBiT4N2kdDfwaVilqH6qMdqQQst7zzWf56Iq4a/zVl99zt2GiERMQHv/HmHpVRHGOQMTcel+eGNaNPIxWm2v+jG5csDZDlU3nyJ+P/jYEnrNmxb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(66556008)(8936002)(44832011)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(966005)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33WeyioObijEcZ9K1ypcv63yXVXR42bviPRrYytdtW9EgdBvoQp2P+DsRhjG?=
 =?us-ascii?Q?4OzVqRDzPNmYQgvpeQclva/7GsR/RjgEfe7OcabX/z0BgN9ArLjcdFZywRiK?=
 =?us-ascii?Q?bjzbiHV4u5Pt02P0sggcC5EPVcLZaaO1ule+Jps3q+C9gcBg5lSCeOGosonn?=
 =?us-ascii?Q?XAtjufp5200kRsB79CT9XTv15SvgXIZpUDjfeJyL7VC4KLWGxXevPIHO+Y6Y?=
 =?us-ascii?Q?zCS1FdogyP+jxvD4AJ12rVwCntaRKB73pC5KWHTButsQpX8wEYX9cXhgq6k3?=
 =?us-ascii?Q?condlChRl/6nisEDd2oQVL+GdlLKFzP+9KI9SI2d4126JnvAi5dmIeimCnGl?=
 =?us-ascii?Q?i3FpcKos1vWqWyGDQaQtuntdLl+fHuydgewYJUnODdGeqdZqIteQcDVVSy56?=
 =?us-ascii?Q?V+/gPAch8xchObEIKnXOUHl+ZdbBLk5ebrg9uOlOxRZyRjjfSHz4kWsumLtR?=
 =?us-ascii?Q?fhxwSwJZY+Ju7eCJq6mpqnZzgSej/ZT84G6vdcB4PjT0Geodu5MHsdwixhL8?=
 =?us-ascii?Q?+EBipppJ17fEpaVNORU0ceU1jHphZbwFvl8G6re8nEBWtT3ypqa/Qclw68nZ?=
 =?us-ascii?Q?h3oA1JRyyncDFE43i/P3VgBWsYk6DCKsOHdJKuVDcrgBWqI9id9X8bLmtBfM?=
 =?us-ascii?Q?PdnnUK/jRbOkBxFWRBCWOC99Yc0IXc+LRxdirk/4ZYw7riFOIf4WXIunRMqS?=
 =?us-ascii?Q?qJNtxUuo12GhKctdBsWu3OBp8Q/ftXvNZmWwugRX8cwZ3FVGLw5svjHUxaaw?=
 =?us-ascii?Q?pnB3ZkR3apCgTo4c6650hpzrFaQOY+vHB4d0BS530k10DjYR3CyhG9AgYK2Q?=
 =?us-ascii?Q?xbrLM/kJLsIiSQ0s0ccTHa9TSjbsf/uZg3QA6sPUC988UNYRHzNF3X7OwvVi?=
 =?us-ascii?Q?jYUb8sWSddfUVwhMffO7gPLGV9rccnW+vfRx6eRGflLo9HXcI93dHK4T84iB?=
 =?us-ascii?Q?i+9+FrcGjU4lyLeYqWvVx5ZuEB05SJmoRiSLtE1b1AQW3RXHfh4jfuSpmu5g?=
 =?us-ascii?Q?wU3I/GJwOgd5Q3fOfWG+o9mCvxBKFXhIjimAIqg/KKA3GevJxdwJi2efFDeT?=
 =?us-ascii?Q?Tm4k9xpzt19qNdHYYE49l1tooCD5EupD4eviT34efmjNbPNoFNsbx96IML0n?=
 =?us-ascii?Q?Se1l6h18Hna7PSyww+f8Z+7ARmlA7VczyiwlPZAVEhFjD1ct/ez+8Jr4tIK9?=
 =?us-ascii?Q?NHWiqOq4EhhB/r53ZdmhIDTmdI5HfwSNiz1GHiBf+scjqmo3uzntEDTlVx4s?=
 =?us-ascii?Q?q7ceqdd9jtkacJ2KmFlMpQxm27zDsNqRMAM9Lr3CK/Pcvf+nZKlDsw9Kfi9F?=
 =?us-ascii?Q?vecDFFY+N356CDNNSmDNgZKJqJR9RValMzzhUdJ81+jep21WC5KIddV5Wq6r?=
 =?us-ascii?Q?ngoTrPxW+nLiDT0aFVLxhrl+GKfY3tf+257EtsvNJw0bfBLKOD2ClOtC2VfR?=
 =?us-ascii?Q?7S6CP6nxsNZYCwsofrdZHrGZOETJxfevfmLH9y2U8Kzz9vmP0j2nY8q0EH2P?=
 =?us-ascii?Q?uLZySdfHjgc1/r0ihRpP9OWqV6O06qSI1nGM0wymWNRHfI7118qxpUgAwTt+?=
 =?us-ascii?Q?+X/bx6evZdgxtryTT7XBAwBCLMQwrMDpa3y7U94TVAlusFfmQQJ1q3LHn246?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9iwnTHYtjZ4+9tfyNJ7HUAZ/FR+KmvbaBFiRiFZgF9gVquSZT/PXVF+98S6JfidDnFY3eweoVkxEjD6KV64dIiiE1QjVNS4o0byIV8LekjN5h8fcPteKS1JtB2kK3wZB5ZNqulh9xOu6N9//b2TqMPoPiTFk8W1cP3s3MSI9mlsGaSPpMXo8c7/fiv5LXjUBWGqNR/4VLSeGk5SQEl/WVbmDYDB75N2TUti+dVJeOxJ9BGzZvpDjJvw3jv6DRukVEchS+I5Mp9CSGXO+OzUCcGNDS+u8eZeQlYSS6kfkX8ChXzTZRNPuE1qPC+2rse4qSQG2VYfphVFAD+kQ4zSKy1oFAqFmG08oELarIwMr8zBpKxQq3zHfnDBo2x8/jetmhlEKfhnafRKaSTffLz9OxlEkChPpg5dnXr7aALcPb9MZ/ivqYliqBqNzKcjQ7DVYXVQNjeJdMzT6dJrhbD3OOhXlIwnvv+2Eo1t+PdSUKC3LWwDT4ciSazMBWAT+xzq1zpy7K07mp5FdHQJqXuYoEx1nTbfinvwHZbdJOfQnjcg/AaWFoL6AzZ+iHdaMOPWmaNoBHBbljsJXSDXPmoZsix8ATuZlHXOrI/iHVckB/soNgFx3D8mmJL0zZ5bsldd7GbxMSLpcH6ok5z7DDXgHZ0cnMg3Sl1D8u8p8J+28u48rv70ApBzhsYJu2PgWpogLw4e4mrghMb8NrrTNjmVH3mGWsu5G7EpFJ2iv8MzNyTIEpHtBr+HYuY8/o/Q0Hoi2D0b/wzSXtZovigWJHYGgB6cd2gtYP7QIBBM+x1V7fa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433845ba-5957-446a-3b98-08db1031e38f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:26.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3YPods+I2+r69I5eofVuC3dB2aoZqJBaOqcEz7aiGplpo9/rMP1i8pG62tvAdGMM76BZQ1YfaAI5qCpNJDCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=615 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160133
X-Proofpoint-GUID: qgHJCITd35mIcfa2XrJPFUAGYhuzbc9n
X-Proofpoint-ORIG-GUID: qgHJCITd35mIcfa2XrJPFUAGYhuzbc9n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series, based on current modules-next, is part of a treewide cleanup
suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
files/objects that are not tristate.  Due to recent changes to kbuild, these
uses are now problematic.  See the commit logs for more details.

(The commit log prefixes and Cc lists are automatically determined using
the script mentioned below.  I've eyeballed them, and they seem reasonable:
my apologies if they are not.)

This is a small initial tranche to see if the general approach is valid:
larger tranches can follow if desired and if these patches seem OK.
I'll be sending a second 24-patch tranche in a few hours if this
one meets with general approval.

(In total, there are 121 patches in this series.)


Differences from v1:
 - just remove MODULE_LICENSE, don't comment it out
 - Cc: paid maintainers as well as unpaid ones
 - improvements to the prefix determination code (notable in
   PCI: versatile in particular)

The series at a whole can be found here:
  https://github.com/nickalcock/linux module-license

The patch splitter (not for upstreaming!) used to prepare these
commits can be found here:
  https://github.com/nickalcock/linux mass-split

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Nick Alcock (7):
  kbuild, PCI: versatile: remove MODULE_LICENSE in non-modules
  kbuild, PCI: mobiveil: remove MODULE_LICENSE in non-modules
  kbuild, PCI: tegra: remove MODULE_LICENSE in non-modules
  kbuild, PCI: endpoint: remove MODULE_LICENSE in non-modules
  kbuild, PCI: hip: remove MODULE_LICENSE in non-modules
  kbuild, shpchp: remove MODULE_LICENSE in non-modules
  kbuild, PCI: dwc: remove MODULE_LICENSE in non-modules

 drivers/pci/controller/dwc/pcie-histb.c              | 1 -
 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 1 -
 drivers/pci/controller/pci-tegra.c                   | 1 -
 drivers/pci/controller/pci-versatile.c               | 1 -
 drivers/pci/controller/pcie-hisi-error.c             | 1 -
 drivers/pci/endpoint/pci-ep-cfs.c                    | 1 -
 drivers/pci/endpoint/pci-epc-core.c                  | 1 -
 drivers/pci/endpoint/pci-epc-mem.c                   | 1 -
 drivers/pci/endpoint/pci-epf-core.c                  | 1 -
 drivers/pci/hotplug/shpchp_core.c                    | 1 -
 10 files changed, 10 deletions(-)

-- 
2.39.1.268.g9de2f9a303

