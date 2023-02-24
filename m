Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0856A1E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBXPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271C6ADFA;
        Fri, 24 Feb 2023 07:09:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEo1cp012033;
        Fri, 24 Feb 2023 15:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ZdUxf61p40EOTlfQcGooePeUwFYbN1UtJqNqrt/PKt4=;
 b=o7quL1igiAcONrxlQaB/iCO94H28IGpPvtEcKGtDgjgTeSJdx9Iy2r6NhWR2WBrpD3vK
 ELhpjwmFXOVcCKhIxkMpzvELUjdntJyns7D9VEKzTFpC8s17QiMnD05xr+z9kMz0Vd5q
 U9ekG6la5du7ZALIZFnhk5myZS76R4+njuWEIJ7vLRmIgjmpwOpZCIMTu6JZXWxwqMCb
 MzNY9H3dFF+eukHsS32HoL3lMBEZA1PW22+Eb94DZhGpTVrOv9lKWOwUp6xM8oKH4AzJ
 DaXyGuTjpkNgc5DewFTPZ6shr835JizNlxn0yFjrnKJOY9/evw3/05tuA88JWpeze0V2 Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpjad7xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODdHJL031833;
        Fri, 24 Feb 2023 15:09:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49qn30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5GHjcqqSXKWz9qMiEGn3Fi3EEOsgBEXg1HOFv4FPGvQxJsc1+vehwWFIDgVFyP7YApRhnSCX/RPydl3h9RNOJ8dj6f6pfeujM14Qyuv3M+UDIJi1qsmxP9rhfOiDg2t3kwYNBeqJFO7IMKE4aRl7lB2XbAa1CaygXHpQiG+jimwSUT2RIBKeEcEul1dlASikHMKD9VIlcxCzdjE2yaWkNm8pv0xVZbVgAZwqoW523wY/A5Szt7td+JPQd1rnfRUxEJtWe8rUgJcIt25ppb6Q8AjaePjpCv1k/5mBH83QyjtJ39mduqOXEaQf30QNQpMq5nwEdMLPCeUPXwGQ+cmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdUxf61p40EOTlfQcGooePeUwFYbN1UtJqNqrt/PKt4=;
 b=m6Zs7rAsA/SXyTK2lN64YEUvGsbKn0h2M5++HBX0Ow8MIZ32FxVFJAMiKsXldwoeSJhrPgRPW6Iv8rI++Xaac0E2MLfW6Bf3aS1YoumAaa+FhJyhTLOEH68B4wX+L+v5+mGuihEMVbpg8Bw+/2i6erXemVyKu4R8CrhYYb/rgvpAukR6abPIMGBhGU13hs7ej0X/wREa8lTiky0pfsBjd3BO8hYGpJH4DIE5KWUJ2wRH9Q1cPrtzfMqsSOCqyFLJ7gMAluGLuQZ/PaW7lZwJQgaigGZeRtxZv/1QP285yHsbhPMD2gPGxrtOH2CFO+rNtUmLl6dncaP2xT81UfbKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdUxf61p40EOTlfQcGooePeUwFYbN1UtJqNqrt/PKt4=;
 b=ehEunke7OKNUTSJtNiBAkyEC8xhiyt9OwM/xht0WOuj9eSOgtXDFjVu9Friou4t+OOCwTntA6LwLJbvE9l4oJAnqS7l/HZw26fwuM/Sc4IMJQ8NnPcFbGaAE++0lz5s59e1azhiAdeuHXCJhU4V4D7T9iuWWzMkH3dxJVJs0cJw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:06 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:06 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:53 +0000
Message-Id: <20230224150811.80316-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: fb96f371-b524-446b-8b7c-08db1679127e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcwC/g7JU9vTpU8iiKc/MSV7UM054lilAUe407VJNO9zs/ODDyKF/U4q2tBEeJkVG9Hcm2P0IlQB4I3/ZBqe0KLOYJskklJ2DPWHOuZZvhNLzJXmrnzVVqlwqBq0sqNdB/LdL2ft3TS0Fg4qAAVAOnUAwtb5mNjF7X+jboBFdJZRKVS2O1fi0Giz1gwFII8EAfqR/4pvH5amjI9IP2pkNtFDqCVkP0CpAfvp2G6BpxstbAhCR3hXnjxCc7qfkXFA+g+Evm3P8AlE+bHLB8YaGbJkuojn9AHAEYW/Fq9hkXtoabWCeW+NupBogf2B4BLPnxYt9hW2io0PZV809C/QffWXAQIg4d53tXDN/Fn9UAGqQ3U69LxOOiteUXFbVaxz5vO+hIfLPYC6fwPboMaWafLmzfE9fHoweakoDdEn2YSm4LwIgsNKkTPjZ8Rm5QDsbYIbpuY/PX4EwSpDf/sexYnQd3vRUv3DOkVISY+yVSRRbtQ9XUpHLpjSW181O4KNCXIuw5ao0BmyJFSvTU6q0H4xSciZd3zioVQe84AD6tcBcSEUmiurHtaYPdz4ki1/RvA6EViGTFjQtMjOjb+q0pxQRvnZp9tFT/zfaAP77hdcZ2lVQh3GcmeEnFv5B63CN0Uip8I36l8n+qeXvX9wwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7I78LJCK5F07BQ/A363sSisUecZc6YijSjtb1bqYTpL6262+m31fDf/iQd4Q?=
 =?us-ascii?Q?nKU3raoZ1Ht805SuTO3EjFuSgiL/3LZETH5ngPwOOvcOWoepXVgkCH/qzYkW?=
 =?us-ascii?Q?ALSJhZ8FXPVK75iR3KjpongQShe9aRTsMvNKuqVL7iWQCBqH71dhycDDSvWK?=
 =?us-ascii?Q?jNyGKCidjw3vMMstevy3i/ZsyLLvPdD24Jt1AHlyU53SDF5DuDjnR3KQBL3e?=
 =?us-ascii?Q?1M/l7lVtl8H90aPA1v/76t22qLtIycECKTrwzFMTgMAfAHZTXJYQGhKwqqKH?=
 =?us-ascii?Q?giMasT5VrNHlNjOprpEFesUmc225bu4irnfY7dYmj0gFYp/iBASuNQZRvzQ8?=
 =?us-ascii?Q?f+btw46W6rt6RX3vgOFbiKdZHi2DxB+ZIh67PMVCJWzRZtAFFxCJyk0IVwxm?=
 =?us-ascii?Q?ZgXG1WR2xKdHXiw0kUnOVnM7nLxOjSStQNmUmX0K4xITGdDlaT16W6t74dka?=
 =?us-ascii?Q?NaxoHaGNuzkrRJo3h5Kf8iX+hBuHKWrnx8xVhTXsa2CS2fPFKIFixcIZda9c?=
 =?us-ascii?Q?0ySMdSb7chkl5vTEUPXy3v2H6L4s+0zZXc9xWdpuKn4MC/IxAOg8131mTcEm?=
 =?us-ascii?Q?9cZHn0XDPS2B5mIMwiIvO6sPwDgIugpg/K56ZNpYiH5JPBMvqlrblky7ZVZN?=
 =?us-ascii?Q?OM7BrKEMad6ORVvVE+afxmMhlrHPCbsD0x2TZzMdoDXB/Ye32BJOzDTSX4TL?=
 =?us-ascii?Q?HLoh1L3tWw5Vvww50Sjhndh41p+6+0/EbTMy48LjIql7eMJNYupQa+XtZVuO?=
 =?us-ascii?Q?JR2cxYiq4GIeCO14BqQFCqm4JDTgMv7/n+kUrx0d4LiNqXG99jX08oV2NDb1?=
 =?us-ascii?Q?NuzY/t4IOBAI0OZZ7jOKT++Ksc/NtuO5Kyse/JFyCGFBxzLZrqJUx7riHEZg?=
 =?us-ascii?Q?Dq2NB240ifQhlhVj70YqxCBXq93xv/05Z6BBlzln2gplYO3oGi6mHH5hM0wJ?=
 =?us-ascii?Q?POXZnANZ67Wnu9Gw4++u3CKIpcsdo7bTU/HHVx3Nbr1h1oiVEd1w5lNN+4oi?=
 =?us-ascii?Q?VKSlyzAVCPQLo8yjiHoJy0erVDpumKe5zR+LtPTslA2X4jNl90Vn2y3bKajA?=
 =?us-ascii?Q?MG1hoZVflPJWuQ7cAQ6mU3yMYut7jdtfsDeA4+hnStwZMQLRPsxHk73CsDTL?=
 =?us-ascii?Q?x54J50OSbcHw810H9Bd8dLiI1mrLcvns3ZjGm80DeJnCuMCwzDmabbhGST+5?=
 =?us-ascii?Q?w1tLRU6QjQkgulHrqDd3elYgsQ+MsVYfduDD1zA5g9ne5BQtdWZskNcZ/Hh6?=
 =?us-ascii?Q?9P7cN0YDGSwLb7YlRNbi0fOCVE3ggzA3YJO7Btp1LB2UTvPZAidZ8MNGmzNv?=
 =?us-ascii?Q?h4Ceco937vsosskW1v8UOeicMVSAAx553s+Swc2uyN0cHhdhNg33e2O/pKXl?=
 =?us-ascii?Q?jANV9KsM53F0LfunLx/2bLheNUxeeMYHLi/oQykhdaYfNc7iL0rI6w5Y+wm1?=
 =?us-ascii?Q?n53ZIMhUCHDNEsXg1nyo7kMZBKk9rTmgRShblwtWg03RBB6XB540Xr/GaDk0?=
 =?us-ascii?Q?u2BUBwVWuPx98Awk4JpILQdorPnfycg4+TNbMzH8JiM+gG/FVa3uOiDYV7BN?=
 =?us-ascii?Q?qfFsfCpIw8QtDjIn1qsjK6qyyRVyGIQXrjPFCTFH/6RbuJsiVeFx+ZxmZZVx?=
 =?us-ascii?Q?LQVPgYRvbufUsSFE1tD/JyI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uVwh7yOSKzfZ3TXHIOufR5vzd9w+HGLrnSsILNPeHtonwgssMMrwcTT7PK7BHjhIudd6lUmSAOwVXKmgshFjDsU3jeHz4y3E17J0dCp6lp9vXDannvRWqypUfdGwKycWEHUAq7RxVcLdraaq5fcS06orSt3iHDlITHAYw3KpgYvchslNjveq58pjU6Og68vDscAn77hspTSnjKRtSZS0wJxQ7spcQQHKJtCiQWrH7pud4yLCi2MMP/SqYPaWe1knOsFDH84iVukcgPx2U5VhwVX3poTuGpiScsNtFS0eo9/yPIFIR6MX9Yl8+297qH0FnA70gBxyjjG8S/wsahyfFbIevfmzsY86S2PbUN/9DXkTko+pZrctYdNhoUdaN9B4ASdWT1urjLxbVCEnNkMexC3cPn+I15LWGheNpeRHYEHnicxZAuQf0F/EEsgF3YmLcZdRYEUn1kPM/+wEVV7y1YYjBpvI/t4FuCmq3SEBTHQqnWy29pZfP5sCXUtoBAhTP5IY5tDZMmxOWx3n6Q6c8YWvGLzZgQQjHTad/UWtdS4//mG8NO1s88hS4xZKyi3PV5uBsGWUsAgBEB+52vslCKrvFuAI4XJnUFHOVFv1qsouXMCgiXzdGeUyeijFrcdAAe+sD31XmW0sQdDXFYZXkarXHunpiG4PIxFriWCZpa+WjlDiIr12uoVKh5qjjaGFvICG7QmSe3ZXD30SWerEqrPbKa9MVoAAYqTM9NyIATcc/qmQhufmHJjUNmUR3LPsJp0GUADH9nvspnVynHq31l4N79SULsYCD5vCAPnTxxcrlh5Mk2OuAqfI4i9pZAVEnOdYuPGiB+QsWYCnexo/gY0B8e7gFOKuNlMpiuT7g2EZplg8azJH0bSbA5lKb+N0F+5mEGjcyNvuh2dw3jiXlg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb96f371-b524-446b-8b7c-08db1679127e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:06.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaznvK6tBObexDxf48XQGGalSQiGMCHrTgUu//etuS1IcOSn0Qig9LcsWrcDkTq8EEZTKu7WO8fDrIVQ8NbgUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: LTywqWeHdjGPSj_824irozWNOIUZ1B9L
X-Proofpoint-GUID: LTywqWeHdjGPSj_824irozWNOIUZ1B9L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 25fd8ee66565..4bbfa2b0a4df 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -390,4 +390,3 @@ IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

