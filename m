Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AC716DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjE3Tkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3Tkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:40:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA6C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:40:37 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJW1sb002469;
        Tue, 30 May 2023 19:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=hhhOUCpYBVH4VZf1N8XxipTG52TjIiZ8NY5mX3onVPc=;
 b=vyulezeL7ega+cRMyAv6IbH/aBkTCS0d/wt7uo+3gJFj5rvmj7EauOGdd80EMcoptz11
 IQGp9V4FaZZyLJJGvAPcmNnUqqC/XWr9+vJvQyL4eVKCPqUzOjFzLWk20XUGywKCIuBd
 uPtodOjtLkAb7epW9b7GeweIkZZIcqt7AaYFaVtPOHdtl2o1Pp+ZPVfg+DyF65qWPtN8
 oKRDyPNW6ZwcxYhhkcr82KrvFFP6A1uyZM+Vm6+6XkRNXVTTXV1LyJmLJh/ATtrDj6lQ
 /7ygu+bZlJLimUrIT2uH64FcF/qE5jzztVHhrhMCfw/75jVEs308Tx3C5eZk7ONsgoWw 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9uubm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UIpHCF019777;
        Tue, 30 May 2023 19:40:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a4mb09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuSo4nN2qaqu3x/MMWbp8lAsqfdSK3flsJSgLb7rs3ktPR3mhDuDhUnidBA4b4LEJBtIdWnnMCETP5k2yJqKtaGc8EY2PnK34qVlQP2/tOICb8hv8AXdd2n4lKoM7bZZpcJG0QyyL+0qCSwlih4YjGH00yzMaDAz3zJ88Gwxqx6vkKs6fgrs2XiZN8nkuX4ihYHfD3rOo2cvOzR4DmPq8qQrPxy07qTVPf9xyN+Lw0BpsbMAIC58wHDmyHX0DWjjgRfvrUXwO+h5aXoq6xFTsrDY8ttQI9zaEv71IOWpCThjGpmOLJ0NIBxl6LOG/uPc0NzVu1MXEawrI3yACcn69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhhOUCpYBVH4VZf1N8XxipTG52TjIiZ8NY5mX3onVPc=;
 b=cmWKvrSfQlUchHtjI9UvoD7nPcUugnpflka7Fi4aWLWJ+rB9p0h7r1+s0khtlAgSj0mfexTCKXXYZu2fp7jEVOiMD7aisqCJdtai6cNn+GXHy3E4AA3+i/WRSaIcyscBcZMKePXibW/3BM3CHTgQ1HpTNxTGuGN/gzeqUc/i2oyZHgSyMHmkgY/b4TPvxPzNOGX93cHZtkYaQ6O2XhNc2Fyq5vthymbwfLbbiVsUO4Rn64b+HBox5A48ChaCzXNs1216MqY0ST0iss5Q5b3IPLzCgBocd/fTO2C0wGNDyC/qenSe3e11WyqwBS+KaxmXFI/be2JAcD9MTeI5J7MwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhhOUCpYBVH4VZf1N8XxipTG52TjIiZ8NY5mX3onVPc=;
 b=DYvQP6uBaHu4J2b2m/hjRapQdWeO/TbAYERP+BBKv58/dVYS/7j6oxg9oJjguGTYeyoEmLKbLqyLcTwFTM+Em1cHkNzxnC7qbCWyucbeKhuC6/Gak3h23BHUC60j+pTfRzS9RzOeSNmY6BlnfKaVwYARFQV5k7dCCCjONyp8eKA=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 19:40:27 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:40:27 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/4] debugfs: Add simple min/max "files" to debugfs to fix sched debug code.
Date:   Tue, 30 May 2023 15:40:08 -0400
Message-Id: <20230530194012.44411-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:a03:60::32) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 247cfe07-776c-46aa-7cea-08db6145b83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbyqE3wWzdlfRHKlz4yZXhml/J+gs8AJASRmK9HknSKyKSQv/5SMxj1nZlRzs1YWfHm+2y1ZJWa9K5q2SiSwmIPNu2YO2oNxyVAwVwUcsrbCH+n2YR1rsctyQ8yrkYVazNuDyXxacmuc4QRJ/IvAk53VmA3K0PVY5424QAmGatA78XQu8AJsMznONBqHMb8QSBr6CDIC4zok12p8ZF8hdOxYXM9V8i8xhENP+Y1NyuWaLoJzvmiKL0Pc88vTgS1SVEZ0PDUUam/jcr6gj5KDOm2mij0EKWx09TaXS4MEBW1cQyFbRS8zDIAlvDQgKBmaulFSdnEHmsx1Pzg1ndzR/L9ERgbxE81DQv15nXtsKoKU0mPfdr0drxDy1XCPX5Dw2ElA/IFNk4z/b9vkd2Y/WTpvpKy8OXW702O78k+24NqPuqoq/yAfu6VVt5OytiDhDAWOkdcOViTaYBAdFT9agOSQlaMga6zbGMZ9VNi/NH9ywsfdlwB7raa75/9QgzsXBhQ///Vg5yb0T+7cqmoPShkNN9kqjdGKQkDfiC7nZA/QR3YlVFk2HyauDRFbtpBf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(478600001)(8676002)(8936002)(5660300002)(6916009)(36756003)(2906002)(86362001)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(6512007)(26005)(1076003)(6506007)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QfdcTbHIyq9szlQiFT0cKPzsEMYTntiTnuhXQXJ2rtoRy7ErHGfrXizwhTbW?=
 =?us-ascii?Q?X0wSN452IxNPuloOglDTwzr/+ezGOJWduF5JetCZmHhFpm7sbQRJ44iGN9Mj?=
 =?us-ascii?Q?2zM6hF5VkyNeXgvKidnaD5sWiNdBzXa5LWRizpW/l3zCjWxjTaWCLk5SHsDc?=
 =?us-ascii?Q?RUlRM/t+MgEHeNwu8t0NcZiE9w8ZPtRAY+af++AsJaQr1nGGxO2oQNg+Zy47?=
 =?us-ascii?Q?KwTyYfQw+1mlD29seODczyTYLPWppHUWJUV4TK0ZmCdwnFwxW4Ot6++V6rK/?=
 =?us-ascii?Q?grqJkQaZRW3AtGJPHriX+rkeTi1YPz1JDUxKj8aJpzE3gKvddJq5luOgQzqF?=
 =?us-ascii?Q?CWWhYalHc1MV6Onf8JjDjQAk0hCUVqnPo2xEULX3NBXqseH8+uL0rzlY6f4/?=
 =?us-ascii?Q?3k20wZfpzDy0rwrM7zJGAA11c9e/1OZD7ipfe3Sq0uxAAPky2HE1I1psRuv1?=
 =?us-ascii?Q?dy4UvJzRPp4rM0EaXofyyacBSZ691aC6hz0kQt6bZxxfizGMeDdfdiN/r3MJ?=
 =?us-ascii?Q?EFJ+k+qxnUeenR/HtWPsRlLh9/9IMtu4b9Shd6LKQo8E0m045gCZG6oTmMYj?=
 =?us-ascii?Q?Fl/ueB4GcSlekdJD8kgUTHLuWJya0m9MEgtIf47KX5P6drCESnhL6AgIuw/j?=
 =?us-ascii?Q?Q9gXQN3v1v8COZVtnAkIG7WXux2jsQvZ6S7gcQ68/Yk5D3wYGI0yKXpkRddQ?=
 =?us-ascii?Q?dYXITEPDKjUKpdYLSHUofad0cWP+c6xQ+6sKRT1ltl6/XnUWQYXoYzokv+Pi?=
 =?us-ascii?Q?HoKM8JDHxt8q96fa4yebLKUZ7MYtj4YRe9fxmKN2aQnPMm0U5GnX5fUUWalb?=
 =?us-ascii?Q?9ToxDYlKFGDSP4lZxeHrXmUbdd0RjJfoMBCXMGc3A0ZPlKtMBPcgWmVNOgue?=
 =?us-ascii?Q?qGKCF14UuaeRSBEo8zwPRyQI/ZYlvKxoXmkOK09cqlOqzfvftnjo02xDrcW3?=
 =?us-ascii?Q?t4ljM1shMCBodNWI0lZddMlrBD3pAUXdfB+HjcbHR1UgowAe5QK9DC8k/nTJ?=
 =?us-ascii?Q?ldbsmniyH3XYEpaVuF+0eWA8v9EmiPMsKjwu18mqCmD4DKXHaqXrrtOBhcij?=
 =?us-ascii?Q?iUkItq1zFqx5exSu2vEUid/ODy79K0W/tr/NJc8zT33Nit+qJVvg72bAJG8r?=
 =?us-ascii?Q?kNtudnvX06m0+EN/b1cMQBtTteqc3g0ZU1yE+S35AN6PoRquo2b8iCXTqec9?=
 =?us-ascii?Q?KsOY5MP5vISfCF+axstzHMNYHRW1VVQ22R5y4dtREXUhk35eh35jRMn21/6G?=
 =?us-ascii?Q?QNLfEbLcOw0+q2jQiYsrFBrBDXnEw3z0Nxjv2u/83JPKPPUrt/PcRr0mBEQD?=
 =?us-ascii?Q?MM9Ap0uEnXlUDdGNpKw4gwrqGfeX4+ISDFFty+EXohUXz1rAwWyZMUr8HZH9?=
 =?us-ascii?Q?EVyAoOrU/928IvtovxcXJZKMBbhNqEhYWPRp3GiNs5ETsL+PLSZwa4FgWhi4?=
 =?us-ascii?Q?ekRmtFC4lERytYVH3hhTcpBCF4Xis3N7g7cZo4O1lr5xumabzMfsZi18gUH/?=
 =?us-ascii?Q?KikC1AJhLgsu8fBf2DWUxB4EJJsS3NK157QQWd3nYOoISg2h9OekQ/jkLnfI?=
 =?us-ascii?Q?tQGDrKPzHLPbIwOS0NoUtaOTztJDjWtt7GscZEVt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oeZI2BbXCO4wDlk3u2RX8CRutt39e01P2WNZBKz2xc1H2s3a0oFGlnawKXDs7xMTL5zb0rb9ATxFxNyoGTXjy0hshVW1IuGdIVdmPhI2V3HnrzJ08VXB8jZqqXKaIKzSvfC2zv7jh57zEaXd6JbzYHRaSzO0H3MMo0AoAcAGPEcJGP7qWgkXajMcMvfHY3ZCfC/y1e5Wlp/cO+J2LEXpAos4XTLP1iBhFvudOryn0rcaOgHaefgPEhadW0M2DC3/NURSFpG4ktPKu0/SH/2HGdhb5cdLe7/jSGH08bHQAw0IKesLWttwO75Nw1m2xKbQBBQg8N+wQr6Gl5Af2GtjlPPPNpbIVatz9yNs4sfmIc1VEfHEdUszrbVY5FzRIp7GGFh7No0ntU0D4VK+9ROu8Up6ZwpuYcSYcS5hXBMCmZzXxPSVCxDOQM6DpV6SYiaFckIGkUvsLZZ9JT5R1PRfprjDmVXLPDWa3lOqLq04mdpJTRtByx1JKIwkvrhWJJx9sDq/C8Po9tMepJL8qDStTRHu+aFQstaAg0eF69XclvIXYo3+Hyk+KWkeRrbJPu8ZROejV8c5qsKtx8o7eFM+KstEp3vW9p9N/Z6VFmBCoxK7b1f98exaeD7xpPqJHEZJNFE6Cmo6PSJPhVGbVBCVmNvl18L/A+kbZiINLCamWH5GoXUsGi5SbW/qLliBbi5kFMa5oGTMgYkf3+Wiqx37GtHQ9RGdBO0CKRFPDiBja3GGE15eQ/HsRYJtc/OvDsjDgCNvk4mj+9davj2SD8rdcuQ1Q12kWAgXmiGDeZN7xbJWMZkeO44DX5DOD94NIZkC/MpHS3NJcd6EKJiPezLRRMF9kr8A8kcSsoFJNPXMw650YFO0pncNJTuiaLAN7YXd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247cfe07-776c-46aa-7cea-08db6145b83f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:40:27.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCjdX8PkdkloDIGI/HKaJuFEWUVnrSfoY1dr91OLjLZrXFxNJK/szAxhezfrgZboJGMWjHp8jiQwYeesK5clRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_15,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300159
X-Proofpoint-GUID: ZrjZamWv-nUtzUbZDf90GqDQMvHb6t1J
X-Proofpoint-ORIG-GUID: ZrjZamWv-nUtzUbZDf90GqDQMvHb6t1J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
Apologies. I sent this the first time without including lkml.

v1:
This originally started as an attempt to solve a divide by zero issue in sched
debug code that was introduced when a sysctl value with non-zero checking was
moved to a simple u32 debugfs file. In looking at ways to solve this, it was
mentioned I should look at providing general debugfs files with min/max
checking. 

One problem was that a check for greater than zero for say a u8 succeeds for a
number like 256 (but stores a zero anyway) as the upper bits that don't fit into
storage are silently dropped. Therefore values greater than the storage capacity
must also fail. Getting an error when what the user wrote is not what was
actually stored, seems like a useful requirement for the other simple files and
so I moved the check into there.

To enable easy testing, a test module and test script are provided which can
validate the new functions as well as check the new limits on the older
functions. This was stuck under selftests, but it is not currently tied into the
testing infrastructure.

 Documentation/filesystems/debugfs.rst          |  47 +++++++++++++++--
 fs/debugfs/file.c                              | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h                        |  60 +++++++++++++++++++++
 kernel/sched/debug.c                           |   9 +++-
 tools/testing/selftests/debugfs/Makefile       |  15 ++++++
 tools/testing/selftests/debugfs/minmax_test.c  | 140 +++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/debugfs/test_minmax.sh | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 609 insertions(+), 4 deletions(-)



