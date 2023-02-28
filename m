Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04C6A59CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjB1NGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjB1NGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:06:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775082B62A;
        Tue, 28 Feb 2023 05:05:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6B24O010702;
        Tue, 28 Feb 2023 13:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AJ3qWwTEB4xSojrJJdgwTksmFQcUBOUBCk+yoWx/Qxg=;
 b=TAxJDmHCbsZDtD7A6lHxCRBYr416bTfy9bpSwRDUBGafOxedfMKIQebBqGYDGOl71nQ5
 zxVnsTe6DOXdGQ6ZGwST9+89RYkqu1XsKsl+3om+F95Rz6WiDoiFXlEPa4eQ7QNkSZgD
 0UsBoVy/GAvCsG6vojBiAGco3OvbMwmrvcA9M3t/z6Z5cNqYNI81s+Vpl5sT/1/NVuvU
 zPfov1SGPlBEqgpEW149fRFMSa9t6r+A17LwvknSpzhYECPA3DhzB39vp90H/TcK9QPS
 ntYsYRTUH92cye5qKrFPYharcyw+p2HwgBcwZIrgFwcXhQiVktpUGNAKRHTjr6xXu4L6 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6ee61s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SChjVB032317;
        Tue, 28 Feb 2023 13:03:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sdh874-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z05lp0mguB8y1jSKYQjlVemfGFJJ28yPCYI3lKKb8YD3Vvv6m2O/66LrxXwwH/Wt2rvJ4cbFuunFMptyvJPajhi6wz5XtWt87EOQaMIRBRxodIWBty9rj1Swd5yP9PcFz2X4PsVf0g+Tg+Gv31JT0C2CqQBtv7i5OCcL2dMS+ttyJhlMq/uR4Zjy2otVFjQRu9rhHg9yY76hhe/0x5zoGRZsgRsb5QaKIEZj82aU2n/zhtkkxZVbxn5cM/wWcvGwPjztDkeB1LqsFvTgo4igfr8KkGsn2wwXEv6fjFvnXaThnR3GmVUpVM89miYe4No7T2QOxgjZdCS0WacfGsLzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ3qWwTEB4xSojrJJdgwTksmFQcUBOUBCk+yoWx/Qxg=;
 b=VNq7tQYGUIG2ILP5EDD5wwUfqb74w80uq2pUM/95HlaaDwjjKEL3Z7/pxzFXsQDoGyu3AMh+lJ/yJJJSuyJd0qIRNhER0ThNny1XeXTvgjcUz3ISQrNuuyFcYNyIOKphDMVskjhpqoaqBiA0to0kcmExPI8JL1vztlgkATko1mnRStqPzMH5MO2nF4Au7YO6bFUWGl7YuACX0QgBu3nsz2svT8X6rvYPOO48hU5O8sq0W4ELBtSai56uuCt3qRc+ZcbN7X8/DBZMdl4QVfZYajK+iHLLegcPkPNOpXNrMsyuzN+fYYG43T/hnwC+/D7GlwIScosCGvH7Hx99rDP4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ3qWwTEB4xSojrJJdgwTksmFQcUBOUBCk+yoWx/Qxg=;
 b=HZYiq5b9/SDlIlIqNoa/fncWsIzQWGwwW2X/Ii2U332PSv9YgeqO7EGCZC34F5SObhjJ/0Ss4kySZzL2Ms5HcegplaTnEatPAt9Pl66466tRF9unoBFqj2N2QYoDocn1YB6J3JZ+6CQfklJjn2g940vFYa+Ok0MyE/v38F2Xfq0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Walle <michael@walle.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 16/20] irqchip/irq-sl28cpld: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:11 +0000
Message-Id: <20230228130215.289081-17-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 4635bcfe-5b72-4f83-8fa2-08db198c3527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amLZ4pqlwMdJOIZpDmMICxPJhJA2KN4IYEt80OHFzTCxJLAWlyDYeaY+arPjze+lScfFxMCjENDH/chuIrHFquPtgwuI1M4FtFWEnnNNst3WhLiaUb+hwnOOcsyeJcuzab96hdL2gN9cRtnYBh2biPr1YFXnBwLPKk5GTLoeBEnBeRgL6KkQPpQ9VNIOoLvaACBvkny+AIOpPwGmULquu2MJ0y30hRzVHXpKcYTQSJcElcnm7k8KnlhJUx5hTgSu4uMAkov6Ephpz8+JnE/UPx8wz+zhfPgay+eEnbVAwgG/UJNenTa5cNBS21z1wIX6//yOik2YdTLQswtMENkwThuNHLWGVxiQMAV5uCJKDVfmvJU3XI88qGXgZp0Mehf2jl2f74EyZK1aI0OzjUXqwv1KZP9Y0RLqv0xofSwrZsB19jgJSEikBjBr+Ai5dwUJlCiKyKXRCJbZyAK4m0SPxFadbSCF/7QhURkNDkpdgQDDhP5Z/+wq+Y/zuAgYqUf/b2Ox+cMICYUj9FAfbB9aIAJT1xRCiLuTHwpvHm1kxM5C8a0sLVK6nSEDFZYUKOGdXl8wNHxn5C4e3wMptra5g8pSrOe3gs6Q2Z/WLYBaVZ0gZavyXveYVtA0PFTtyusFMyu1uiIPs7YDSRgteLNFbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ep6wMz6PNvKYVXcmTywO8VzHPvaVVVjM/6voMqCbqZitMLLpt/LRMjHAo42s?=
 =?us-ascii?Q?bj33e4rq6AJDM8heh7Xnxf+AIsolTyTomIolQcLoo+TMt0DLDuhMYA5poRrL?=
 =?us-ascii?Q?Bk1vfTi5yulOX2FzOJyId/eiRRMhgGhDqaUbU1dqk2vj7xm2XBVEJNo3rhSt?=
 =?us-ascii?Q?BLt6BIH9N0/1NrLfhQuXmT0H2zXOP+hOkfYvI6xzPu7F/ClH32XYfJBmFKNt?=
 =?us-ascii?Q?p/zfUDGR/0ozFGvlxWYrUS6l49yJt9FEKHZyLD+Q4uA+sQKN3Q+awetFAEwx?=
 =?us-ascii?Q?UmiFus7ky/NnOBhnKvkv3dGd9VPIiG6UBOMLxFrx2AoXZ1Wc7UwPSwPWAaiF?=
 =?us-ascii?Q?zIiKltd4QbD9NHBWiA4ae8Fxr3tfWbtCvW7PaF0l2EU8x/BBKFgB9lntoSOV?=
 =?us-ascii?Q?BHkhAVUcBQ76TtFnrgXonLV4SrAdqnjRImBeoD+wAFbhSAH4Z35+h5SrgHyj?=
 =?us-ascii?Q?o37KoVrCCmZylPvgoTpAmxz2ZOwnT2bPKVprUKmA4H3pFmqFfHnGlw/6Y42A?=
 =?us-ascii?Q?G6ccoCoc/NB/Beo5K0eZjKfw1DXRwsU4rHjw1R6SY4R3YFx4uPkTcV6+OQhM?=
 =?us-ascii?Q?Q2Q9jxx6y77Z1+uumrLORRTZfjPTMTGNpptFrlb8r7vlPH+SWVOaXNSvrwTm?=
 =?us-ascii?Q?X4OfIEdBKdW0EDyy8qWFLDdHGigXWEkELxpn3ABSQSv71vxceL4ndDjN5NSE?=
 =?us-ascii?Q?rvue9Ai5STQgCgu0rL+jAVI/BOQl64xFqpE+z/9GWwb5MeGVbLzXb4DO976n?=
 =?us-ascii?Q?LB1koiJyEBujaVQkdx1vwSusg324J1jE5mM6or75MCZbJQytPc2pH+4n3BCj?=
 =?us-ascii?Q?cO4DqNunoXB3Kc8Mwx8xJIKm0PkbY5iwPBXGpiZF+neP3UGiJrbbqZSMsYvJ?=
 =?us-ascii?Q?SpwluhjgMHCFw93iJpR1u9SlUUpHU41ZxhOSD6kKVWmkZpszHRssg1ovkaZe?=
 =?us-ascii?Q?PEaOsCmwgxWiPyLwHFOLKIJCIX8JaiJt6z04YpMf8m+Hf+GwAdID1TM0PDQu?=
 =?us-ascii?Q?BhMFl9dxAjspDSWWm4RGyzvucux9C7I6vsWHT4DpQOyF/RT5RTFbNoHQytIz?=
 =?us-ascii?Q?rwxhnn3P8z8hjUAeRvo+d8LbJaDIdrzgX3vdlI08WEFfmuDmadnldCXFsiEp?=
 =?us-ascii?Q?6WQi1vC0Jth15zKEiz9T2BSRXtH49yM9vtO2luJBEeIASW5uQZ+jXd7+Srbo?=
 =?us-ascii?Q?UzXVkWMzwGGoOWjikk4ExmeJgqJfZyT/9JjfXORgLhiPjooewMOSRiOvcP3D?=
 =?us-ascii?Q?vqWV8IK69JFNKSKqOblqW6ubmo5njhl9m1DHMbwMEy/x7HgKI2o6B5Bzlu9T?=
 =?us-ascii?Q?vbKmSDAyR50GfUevv7lvn8kXyDMkMK25/Gg3cXtNXUFFe+6XjtHdxtcoS2C2?=
 =?us-ascii?Q?RB0VUj9vbOYr92vxYfLTePjFHFYhGzhie+3PshQshyrR02lGmD1ueM50fphT?=
 =?us-ascii?Q?PFpLgUCXKHtIywOwIs7MWFO6Q7GCOeHnAop3vSy4JvQ2A31UCCSN4o8kZm+Y?=
 =?us-ascii?Q?GwMjUl1M7SRBeqdB7FJe9yQA8DljgY2VaSMmBzqSN5/RVWxnTdoULuRTnRZs?=
 =?us-ascii?Q?mVU1Qe8OSXl25SN3tR0wy1z6qW1TcU1kuZfLedvJrqtuJxJdC2DQX4IRPyJQ?=
 =?us-ascii?Q?Fz4noWagKMW4PQ8M8kr2BmM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: enWn3jJFbOIh+VQHWSWfcAPUTnwx7nggDY6VlsMUq5jOpm3CjQQJQCpYLsslZfmlxkr4iBRSep0RlY+1Baw2FSKEByJIemCJ8+2s2R78ct8Llmzp/chgs8i8ekrHRo9P4ECrnXO4N7jeNQSPWhZCtwEkOsfk6Y/3ADd2pRZ2r76altYvDkbSAXA4z62FVy8FGb292kQekRmhJWDGcBZ3xG2yNcvf6ZD8+XcN+LRbA4zeE3ntKzpKD+esNcfU0uRuGahHJsCAtNrl2BhFIA65wwbXqaUjT0geXuCF8j8spsUeocBjmH+kAb6OMdxzzomsgKfjsnhPMgMArwylFtrSjCfdELnjSDqMAyteANS5OMSPxSnl5NTHDeYf3VcpZXxC7Fe1eH78dbmjxDJrdMuqsYU06dGncTORUBnxMPkQR2tszArmEQPurV/FnuQAet9pGB/vtjthtuid5Ws1wRcaRto03FecZRLDmbO1YLEQqkqzUSMIOC+F8EKnSTHmtDHzsY8rmPz9Iiv1AGuL8CTwg3Gf6K9FjpVZ0UdoCiq2DddvwyhJkVQXgh1ye3C6IsiYl4v8aRjgQ3btu9ZpINxPinCVqaCjpMZVET0JHRqIw/Kr1ceCccdDhodL85cJG3FAONKpUwZ8eVXt9ietmiwMuhcgfjm0PJjrgQsMtpEG5NSOFLxAmv+9oo3TGKgfFnsjVKqeQHdABSL/dmY+NaLIZTh9zkqJHCJVZxwd1zIre8iLKLlo/jZVILd/WvC/4exIjXi91ZmaEWoSdJmwT0ktcj+RSddvFpVmClx1Yd8wbDHthUG7EWp+fylhBCIFyAGBZA/+dBbFdcahy4znRqJMiWLr12VgPeYjC9um3FaL3PlJ9kA47XnJ5H6Lj/817giJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4635bcfe-5b72-4f83-8fa2-08db198c3527
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:38.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLnUx8e04N091/hiHnzmmCD4twOF4Mzocgx43X6o8YJ+bPw9MGBjAru2iFrILliQOcY+j5oYUb8PMjXjvqLHJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-ORIG-GUID: ZUkayD0yf9XOodqS1w8A_4qEgGL8AdSE
X-Proofpoint-GUID: ZUkayD0yf9XOodqS1w8A_4qEgGL8AdSE
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
Cc: Michael Walle <michael@walle.cc>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-sl28cpld.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index f2172240172c4..e50f9eaba4cd9 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -92,4 +92,3 @@ module_platform_driver(sl28cpld_intc_driver);
 
 MODULE_DESCRIPTION("sl28cpld Interrupt Controller Driver");
 MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

