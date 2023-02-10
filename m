Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D360C6923C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjBJQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjBJQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:57:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F641A674;
        Fri, 10 Feb 2023 08:57:32 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMfWb015489;
        Fri, 10 Feb 2023 16:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OuTm+7WkAj6GARxSQUuwR1+lMMJW0700mUJ9OgHB7ZM=;
 b=yGKHvLNB0a4trKsj9JWBC8poIyIel34ndcVLec1v9oQbgcm0B04fwEbvf6yZopZP8c4d
 dwr1q0l+r/KcwYx9qgugrgIFdl9iLNG1V/wOw9TVJD7SEBZenhtX/19ZTzIy4Z9QfPYB
 VyyZRSRSE3bsaMmEkMAFES607c0zqE0LbEmPVEF6io6Wgc3PTtDF0LOliPt2BrWvlkeE
 /ZrTKzILiF6YSD6ZZx7j64qWE2BwjbfI32pGMJNkC5lC59LeMaBxWYfucspeUO0QzclH
 sCz5FmyTdOpF2cIHeSVKLtEWDzNdA1SCZveJEvxDcB0Bei7pxBesY+nEVHN/aSVU7XAH zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcnt5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:56:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AG5sxo036007;
        Fri, 10 Feb 2023 16:56:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtgtq1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjZEKzC6gw4ClWzIR1gPvNDfZq+41jp2ZgcMa++xjPKJnItnLXbhNFaz8Gj9Udt/a8ruzC2GbfVlDG5+FWM+o3LdSx0MpYxfO3K8qBXcOlS9+Nuey27CpaR+3BVr3eLhoIZ81k6lW0nzjpRgy9C2IpHuMk0STvC5uShtuQ2M5DyKK2yJZyomqEaPHLa8zeYz7iilRY1pxZR5+nNj3P5FqDCzfWXvPXMzr2kNGb1/x7NKkChXRsTEtLNVop7fiP4eWLad8b51Y6O8TL5TwMvl9oxxaf99+tZT3Fjm9ecGYtPDo1QRKKh7q2ojOirYDk854HtrgED8JCc6zU4U/ReymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuTm+7WkAj6GARxSQUuwR1+lMMJW0700mUJ9OgHB7ZM=;
 b=n2Ko/5305pVY6YEewj2JBSVnacAgmAOyUiaKpcmwi7r+Xfy7duMw44pn2tf0HIan5FFIkKkwGerVyWdwRgi5/uJpg5BhnFfTlAGIQkZIldsGiK3DI3mmgNo4+M9uH5cf6LM6N+CFQV33b/50bKN1SwllyEK24SgagBLBLfzgzuQFpfU+3jErd569tEf7MEwhT6Z+7BTYQwhKIJPQO6Kzj9usyMhyhAdekolZWyC991IU+WEKMGjbY3DHy8vzEMIaEiS21pgfGSnFL9ovCRaHjqC05ajjosSyyQFrhxuz69zHPLL0xbbDGYxFscEGYMVqhkeFDPb/yxGFfkm4udiWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuTm+7WkAj6GARxSQUuwR1+lMMJW0700mUJ9OgHB7ZM=;
 b=MtHqVd8+nAQTBrUwjAfT3gavVilHjFmVO2IQUf5C/6a1P0n+q40wG3XtWwfcZVxdq4lGl/LNfF5afQ2S3hs49q4tDtfh39Yz0xVNVJ97YkTTVN5Nu2FSIc+YKqXc1QFdanUr9yFScUdAEDvyk2IGEdLVqo8xd6ndxWShCtyYKQQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA3PR10MB7094.namprd10.prod.outlook.com (2603:10b6:806:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Fri, 10 Feb
 2023 16:56:54 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 16:56:54 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] MODULE_LICENSE removals, first tranche
Date:   Fri, 10 Feb 2023 16:47:41 +0000
Message-Id: <20230210164749.368998-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0246.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA3PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f92385-9a71-4e91-6916-08db0b87cfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWTCD1rCYFNInpxy72xNFj9sQLZKqQ8MmbJk7YFuigS7NVqG7Hy4vnu8+5GAs/9nRXRf95fJAT86F1/k/gNi9Bug0BZpF3IYXkSoU/1EYJhyNYNMIZxxTNQnXPbCBHg7HMb9fUTZTMyQCPqjfRHWmUHa4I4CAeP67LlnoF/BMVO96egm322tcl/45DozHaWJyM0rc1RbbhAGqnKksxvTLtl9t7Li18IwVCFG6CXgctOQds3cbFXjzLJDUWDRhbOc8RJJCYQZSLZ4LaqBGTcMctO8C8ZhPlxJ3NRgaC1tBfOncgwbAy5CcHdgLO/+otDh1YcCbCZYJqK3GoggWxCPdGvqGLSRKCCyonEEsvCsdDwfEODTXK9gURy5lzU5NbqOMuAB/LLPFu1JFCVv8Yvq/4QhiNfZ/35xFNMzR0MjSMGh6jyPMJTfrWXr/rmB1qPEgtr7B8SdUsqBCGDL4L8q/18N0JBmb/n5VrK16Promkca77dX1ra4+9okz1fhx+iUSigqqz8K1diXOvOwY8/xT3LuC+S4YgiD7+S30DGYx/1cp/R4GQFguVnAq02gC5B5S3a9/rbRtj3g+inzWN1gSdXwZpkuGTsanqcr8xRAKLfGA5BSVGUtqunPy90XjtBIu1KE9AK5R3apGPjUZvy1wlEEugxekhm9Mhxy6xnxqIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199018)(36756003)(38100700002)(86362001)(6512007)(186003)(26005)(83380400001)(2616005)(6666004)(6506007)(1076003)(2906002)(8676002)(66946007)(4326008)(6916009)(66556008)(66476007)(6486002)(478600001)(966005)(44832011)(5660300002)(8936002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4EfkCyrJ9SnwSBlTdDoZJfGZB27qXGm9HvTqZM6OZz71pyHesLhXuhr4DYx?=
 =?us-ascii?Q?kFFpvWB0AyxOxJP401ImZahPt1ggSIs0RLe00saLceLVrOm7pNyZO24zuoeK?=
 =?us-ascii?Q?15IpAu8RFzCKTK9z+ORLAmlTPOq8ZpNeDEgNZ8/yddgUJPqDu5KaWe7F09Zf?=
 =?us-ascii?Q?oi/aqvQv2A0NaqSm/dTGeqF2YWun11cW8KcXTrWQQpspEBBZZLJ4wpYkKOZ5?=
 =?us-ascii?Q?ak8zS8Qw9mg1RzNcnU88mtoMy9A7y0+vdWmmJOJbK4QjbxjC1AWs+tYA0VA3?=
 =?us-ascii?Q?1w07SEYYvWrpozIFLwF8I1ZroBY7hX/yb0v+FfYti1TlxVcpwALvv2n1Ubev?=
 =?us-ascii?Q?fRcJamm5q7G8dmi17hEr0RkLcNaUOSvgdn3vXkM6ky+Tv7PZzG1k3z3XJhRi?=
 =?us-ascii?Q?B0+tbaIPRaIIiAZXmSG4asrvoeo7EQS4E/9ymVxamR6my4y7rbFsEOD/qtCB?=
 =?us-ascii?Q?Fe2zzXr7X3w0MdX49i5vB9/Fmb995B6QEHd+rcABJBxs9OvxsWBYK1O1Wn0b?=
 =?us-ascii?Q?JsSVblkgedKjOqm68gwUtCD5Ij6J542bLjYzpRsTgO0JemhBqCbP5UaEoGQ8?=
 =?us-ascii?Q?FmiTJca/VSW1wuwZgHmguf9RNkeJU0UXfyv2lkApu3tsp7TEjbc+jJHpURD/?=
 =?us-ascii?Q?UPapa0KdyTcfOJ7Fr+4t0kD7SSZBzXcZouHz84abXWQCa01vAVeSVDk1H14k?=
 =?us-ascii?Q?0noO2bcFWXHWD0bHcGIeYPn8f1/pZOxfAv2pBKFW/ghAwDxzVR8XFhKzdDre?=
 =?us-ascii?Q?ZbhK/rR196dfwT+Pr6/Blw5OjOCacQi+i3SVcHpnRi0Lg9WGY5f6d9ZW7154?=
 =?us-ascii?Q?c1sHJSovyZWkrQUyYpoh6uoL/I7g8yMfBYuXiLzw70QLSUGG00a0IEuQnMd0?=
 =?us-ascii?Q?9wyuVXy3UR91HmvaZH8Qu2OvWaxrW9DlPdBFLVZP+dlUidLVtoaspkh/8mc2?=
 =?us-ascii?Q?n+W/hAHWrcP2Mai0ec/ugKzNOzNJqPwRibEhu1oJczmuLDHNOuFXF3pubydH?=
 =?us-ascii?Q?yVGF+bDUJ0uN8wJws5oru/SD183aGT4zfz6NO3UM9NP4UF35OB5S9EGYkYuE?=
 =?us-ascii?Q?K8FivyEpNlrU3HfogzYze5hqGTYZrN6C6X7KGEQ2WiKX6YM26DYiXdPc0z4y?=
 =?us-ascii?Q?EBAjSRrNq6yguj4MLn7UbKFmAiVG1jK11Op1jEehup9BWnoF12McyfVtGaQl?=
 =?us-ascii?Q?Ip4jUWPQzfMeolDo7p1SVG6KJdFmj8+UYBjUt6aJXoLX5DEtXGqT7hIvQnj7?=
 =?us-ascii?Q?k9PI3y/p/bzszo7TLPba0QqqoKEPwUc+aAMAxnDjnT1gSe1+TD6B+lkwkAjE?=
 =?us-ascii?Q?31sMJqMBg3KFeT8Micptxq3dcYJvIyxFS2TZiw/Ee+GBxIfd6I6Ejy///oxu?=
 =?us-ascii?Q?S7j4YlRzHQO3hVLC/WTJPb7ZnEM5YeY0pIy6h2kov98RIG6FLpCouui2OUyn?=
 =?us-ascii?Q?2AK9IpO8jZzXgQbvVI5BhXxABKKuxgzNsNMDgrVz7sSCut7KgymZq5eJswVt?=
 =?us-ascii?Q?NK1B1MkJgCvPDir+3bWmPUaSCL/jSKJygklfCbflYspKGq8ET88WVFcpbnjT?=
 =?us-ascii?Q?HI8gWjcr+rMEqYgUPoSUUnU3xGFzz/xiTg54FzifZlLIB5M1bVp6b9YHGkJc?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 70jlIo2e7AroqcHVuCVEFLfnIbgap5VghhAQUCaeeL1zt2iiqh8i1zufZGtGhF7V1EXE8OO/ZvEnVq4ysAN8+mniOp3W7CuROd0Sa/irz/i3zMc0B+6Nnh5HP+iXXx5dhk5X+VcdwaW7cLnYV7Tmt/ZUPhjevGLmuvZghFzF59cUMWM1VJ8xOhRPjzioleFeAAkCiQZGH2JBqlosGuGTGDaRDmbi07QGMjxjSXwy0gDQsgS6RxYc06Q/ZotlXkMoZ+O1GQrNhs7PB8CSMBsl8HRssVMzD3zSOrHuB8KA2RKd6au41ZaV3TQW/S6+HnXEsoTm4/F3eq+Y5PtA9sLw085DTLY0z9zz0457J1DxyweTkNi4r9fdJM3/+m2dH9vtSLGlD7pk3i9NL2xxDW6YLU+oWL5IJ91xsnzm25PiB3i1KjkLjZHhaR6V+lqjsPjBiibBbbiQd2R7wF8M/HyxK59nr6Ot0kqyRFWFYuLIs0ILpcvfdP69o88QtpOcdMpXrWsFALFNVLmOrr/p4WGU+BvCD/GJYz8YkhyMRGL8P/zOFTUy6pFrMNi41Ll1RIFnBmj8FAt6iLUWaV680jbCIZbdyOgoltDtDJFO7XKZNTiVAyKDVxOMcjse800BCPyA1sWrlXhVKezXBUALuYdoCex0pzdObcxwEyDOc1OkFaZqWbWm7bf2HmhBGV/MS7Ju+OKoUcdcS49IDU3VSUA8d7Iyw8zfTXN6GVufV3Qb9wpeAG7jCktHaF4A2GnLgACdL2eOue2ciz/w1uO+LVHuP9U8OGFo1eWaZuekci5k0Qo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f92385-9a71-4e91-6916-08db0b87cfc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:56:53.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be9UZ/J6/G1YvNxomFyNZLlZ871a78ZhHkMxe2c3nUmhnwhP3mvSxS8AV594PZOGuimtpTI9+/Gb2cFNbQK0Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=661
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100141
X-Proofpoint-GUID: MyuEngpypMVo8_U4aJdMx77J23tY-Ex3
X-Proofpoint-ORIG-GUID: MyuEngpypMVo8_U4aJdMx77J23tY-Ex3
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

This is a small initial tranche to see if the general approach is valid:
larger tranches can follow if desired and if these patches seem OK.
(In total, there are 123 patches.)


The series at a whole can be found here:
  https://github.com/nickalcock/linux module-license

The kallsyms series is at https://github.com/nickalcock/linux kallsyms

The tristate checker used to put this series together (not for upstreaming yet,
and not necessary for any of this to work) is at
https://github.com/nickalcock/linux tristate-checker

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Nick Alcock (8):
  kbuild, PCI: generic,versatile: comment out MODULE_LICENSE in
    non-modules
  kbuild, PCI: mobiveil: comment out MODULE_LICENSE in non-modules
  kbuild, ARM: tegra: comment out MODULE_LICENSE in non-modules
  kbuild, PCI: endpoint: comment out MODULE_LICENSE in non-modules
  kbuild, PCI: hip: comment out MODULE_LICENSE in non-modules
  kbuild,  shpchp: comment out MODULE_LICENSE in non-modules
  kbuild, PCI: dwc: histb: comment out MODULE_LICENSE in non-modules
  kbuild, PCI: microchip: comment out MODULE_LICENSE in non-modules

 drivers/pci/controller/dwc/pcie-histb.c              | 2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 2 +-
 drivers/pci/controller/pci-tegra.c                   | 2 +-
 drivers/pci/controller/pci-versatile.c               | 2 +-
 drivers/pci/controller/pcie-hisi-error.c             | 2 +-
 drivers/pci/controller/pcie-microchip-host.c         | 2 +-
 drivers/pci/endpoint/pci-ep-cfs.c                    | 2 +-
 drivers/pci/endpoint/pci-epc-core.c                  | 2 +-
 drivers/pci/endpoint/pci-epc-mem.c                   | 2 +-
 drivers/pci/endpoint/pci-epf-core.c                  | 2 +-
 drivers/pci/hotplug/shpchp_core.c                    | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.39.1.268.g9de2f9a303

