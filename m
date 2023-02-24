Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC116A1E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBXPJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBXPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EF6CF12;
        Fri, 24 Feb 2023 07:09:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmsd1005529;
        Fri, 24 Feb 2023 15:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YmcNkv6pAg5FC/arLfJJBq8XxEfbt/bhsTk8A9sLRUs=;
 b=xtdL1Y6FF24vhXZV+yd6DIdmAkHWUYijx4HQmVl9QHwtaIVqRIfGgxd9WeH6OtDqKyJg
 9s/r5ajZylJpqEKS011fw0k0rZ/QiOmDBF4SioZ6ZI9e8ZSrCv2koFt/sYP19D4s1oco
 PM9J0xyg816fHOmww9bEdJR5gVFo2VAQGfCv5t3YL/jCUP/7adlI8WHpBua2SlnHIOxf
 hJcZm+EwtAm16AnUJjGaTLR4hvwSSccnVt6sBsAkTzW63VJ+TLpVfz/J7S1Ge72oyYNI
 FprSfgtrlGMspIRmrzo6c7hNOGjRU5u/rk7kQWmRnaYwnKokHMGqBNkMK6Vcdl6zibFh ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9twega-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODsDM4018057;
        Fri, 24 Feb 2023 15:09:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v85t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiXPeB9M4osnh1Ud9WyBmV1yqoFWhBpyZ9GjElOqAfw5Tc2jhd0F+L9UNtPlXIIYU0PZhBQBdozppsBAGOkEVY2cCRnHbKClf+GDBbziZjmDlf8wYwIq1jkyyAnC72OyayL1FRVORTwfjvYTjTDaIeJ9aWJcNov3VhgEi5FKyxayJRoWzKr8oOwP5Q2AbCMN5+QcgQQAwxEMZCDSkNdzlTGtkDky48oXlv4r4gyIp3f+K2R+/PwRNbCFvF0EA37wOnIA/XvzE+cqtqi3TMS27Rd84+cdAEnXulcYjJEbBNK1NcHr65iXXcC0yq2PPDHDEaEKzRZdH0EHD+Ax06mieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmcNkv6pAg5FC/arLfJJBq8XxEfbt/bhsTk8A9sLRUs=;
 b=ICg1HsBDa0WF5BLVPFvlyj8Wc/ytoSQf1X9bvrCgLzG6vkM902btDzgYU5PqatE6q1NFrYUCxBq1H8wcuLDUQpfB8vgcCLsJDbp+3dvHXJQrprRX+eQfhz6LyYa1cwktQI2MLdUszPsBEgyB6oWzR47e7GsJ0F62cpReqkU+gtxQSia7aG4XngaAAhtrVlkuEQNCO3gijuX94N8j74zrclPlX1VbZKcvlhggX9aUuPKdrY8arCF0biirOqRa72V3gYemqg/Kt5vQKGXIaIbsD8YEo8kZ10PI6HwnyG8Q9667VFYuwzt5x10gxpvYo4VznacbRDoQKHnRrKebPcqsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmcNkv6pAg5FC/arLfJJBq8XxEfbt/bhsTk8A9sLRUs=;
 b=p4YIANZ4eJvrE7Q/w/b2j4VGI9359jU5k3vxojKXrtenQAnln4OgmtBRmNGBtN3Kap4mGEr0QNOx4hqFWYQs43TORUD1erdE65WjfduZXRQvGk/xJQTAPje08kNKGb0gVo9BxvVyoMluSdZZiUJSgsRzjbH3fYYs2hEQfdqIgr0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:01 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:01 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 08/27] irqchip: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:52 +0000
Message-Id: <20230224150811.80316-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: efa1d4ad-c7e0-4f43-bcdb-08db16790f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tn5uT8ww3buECeN47ottQrLS7ww7ftH25rEI2/40JYcf0qR9UGNx6YPvkb1tnmnbv2+TL5DspFyU7Qbp6FMc3xxF1c+U3qBUUAppZ5eSxIEcG9uU4hViJakTsOQY5tnnSXG04zOgv6WbbSmwBOd3HdRAFAqttqCxFrWcAMAUtslgYuU6WHHW+M1tI7xxcH2m9YxqcXSF+DmCNwWjc57KenzmbBwSogyx+lypv+3xVlFI75XSudsixRbWV3vUVN1WCsNlb3U2d/J0h16du+BohaHqhxLbO/vs95111VzECO8QF45H0XKBjMXFerMt1sjg6jq7dmu+FS60oTPwfPsJcUUTl266flMBLy4Xv9LbKYhWuvAazUibVvyyZlgR1VuP1QaQQM/MJY/e8wkUZOoAg5EF0pttNRRIP0aWuCcYlnNZ05cNjbw1MD0+uwi1hfE+RZIh362U6l6rVaDVzBcTj/3Cbkj2LtA8Q47wc214tAhIHk5VIo9UsCPz9oOrWM8F0D3VZE0f7g4gKngLs3eKxUcAQcVh6gI3FMwpQApPa4bspGxquAEODNT5/M8xnvTOHgwtLbUwSKWoP/1e/6fbyXLB3IiSBnwCddj8mwnSj83UGIrsFgxUabj6AyVeQ92WYjsCscyBm0kabgCjYnFqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tZgpVjxSBVceWKbIa3zbjDzaDvv9yxLVNin/LXlngNccNDDLz7FBXVNMTXKd?=
 =?us-ascii?Q?RYaguhBTcY6j/L9H2yXoBQy2GD+lcvaEwLWmMa6n8H/kn+mnRZmQrZ7Gmc7K?=
 =?us-ascii?Q?DOACQQmaSmG4pzTte5Lp9zLiPQWlNnmZSKbX7kgD1zQTXny8yKsCrMLbxi8k?=
 =?us-ascii?Q?jWzERETCJWzheMRaqmoDzyhq7r2SRYc31oPxtQg7wwXMBktP/ppdCkm5piQ4?=
 =?us-ascii?Q?hA+3iL5FpBLF7/BhpxKkuyBNpfCDylCeUHLQLkQFWTYX27sN0NkXasyYRsxG?=
 =?us-ascii?Q?TvZoAtBNckPdDJnz+stBw8weKPBx9M3m4lbCefpT9UKxxXfC+1ZiQ3LzgHW6?=
 =?us-ascii?Q?SDsuB7sN9ZDA+L5MzOiMeGX7LccrMJ2boKYJRi6QSEQTRW/a+1WwZ6JWE0KI?=
 =?us-ascii?Q?EdKl3CWZdjdHFbXKASmxoq9r9Gx9Kga6r6q8QUfrQzoWoejVijib8vT6T7cg?=
 =?us-ascii?Q?VetbxegskbB5xB6mE0x8o/cMspskwSnr3iyeLo4b+i5jaiiBm6QwqdrpWrM0?=
 =?us-ascii?Q?HpHu/ZmBdzsCzQVIHo84aZAE+sG2TKcqjBw8tI8cgFAp6pRq+Xy6wbnDJQIl?=
 =?us-ascii?Q?qPEkROdFd9Vu0A3GQU0yItita331paC9qopEySvWmcIHpQg1RIFGn1NADWyx?=
 =?us-ascii?Q?yK8gqohH1Z9kwqmYfratVqynVNap63y7yEc59G/5nIkKJS5ziUPbKfu+J44b?=
 =?us-ascii?Q?QxE+bsq+cPwjHLxvD7QfeMEmpbEk6JgjsLTCVRFcFKT2uWxR2MWVB0vhJ39F?=
 =?us-ascii?Q?bhmCgrpivSxrLe9pEoKTaV8Y72d3i224yumTndcOVyzFpfD2aS3FmwZBpisB?=
 =?us-ascii?Q?7bYQcilIS/Dh23b1Rve8QJGQHrJqnNr4XbXxSC3ZSKkE/2mPnpMT/LCA9LNa?=
 =?us-ascii?Q?i4Zcr0+7TVFm9kYrwB+t3jqRxCoY84Z6qx4blqe4JkVUg+9f/61SjFoBpTVu?=
 =?us-ascii?Q?sr4HDHWGJd5lifsnLnvkXA3i5cynz/QV4dHJqadBYrhQEpWBt6teElu9PZta?=
 =?us-ascii?Q?yxsUh5iAYeYecZNTBo6UQ5SMnBRuzhX62ghq47WZwUNo7aoiLVdS8IjpUQCR?=
 =?us-ascii?Q?NGIFCyZG0+Blb7s3DAqkBtIK4pMN0A2iWj0KiDoWy2bAmrVAz7wQLSIfVdzN?=
 =?us-ascii?Q?6waHTuB50l5i03+GzXdNcyduz3d9Lapn9Fcfe7TW5Jxj0oxU17NGPamI2XNG?=
 =?us-ascii?Q?ohtMFF5Na7vKIuTrzfR0oApQ5EWAy7v5HOjuDscduL09if+uWKNauDnQWGyG?=
 =?us-ascii?Q?8uN0c/1sXXy3pjgfchbP9LcZ8l+RsYF3+tpuWg6zYpd0QRZV+EyAx9je+cPm?=
 =?us-ascii?Q?e/pN2zKnG0vUy18C6/hoVzjlv9yPb19rLIOaTAIz85uDy6KC+MbcajiUYn1W?=
 =?us-ascii?Q?i+IzU6goh9Oz3JPa4zkEN08M0O+BtPzGK8xcMKqZPlWJbUdGLEuDgPS5ZAuL?=
 =?us-ascii?Q?dBPRIBwr4R+DWvYHVQAJ679GZkADxnZ/Rua5vh8G0pELtAJymjT2bFOREuMT?=
 =?us-ascii?Q?EP/Z8UDdmxrAxNFfdIDNnZdFE63Lvg1EHGIe4X9v0qMFN4PAl+jeuOUv6R8G?=
 =?us-ascii?Q?29Bq+OUXESpgKWbEC4EHbwDXHkyniA8p5qYCbd1GjfNNvIsK//8SpcWE1okk?=
 =?us-ascii?Q?n3gpMFoVdhu21fxVp4qa0r8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hDcaPcgSfiS3j7KTKdSgqMNYBfkDCGgl6J5F51V4B5Z+lV3THHFjumWfuoyezZqzNLmhmZesU/aOc9MKQu9aOJzSsDFsI07DhIgyJmWBfj2LicAyswXkSCKmVgrZpvNdu7EcEVnVTmrxfGZPkru5dEAIFjrR2jQPkB3QE4rRvRT3QOrzlCgaQCbWzYeE25qtK2Nosi81qZuEqVEywlDmYD1f03l6xBq2WwM2GG5jDzQiP2Aw6/zJ2e0ihwkmGZyVH2E++bVionb8aAJqkHy/ozMOvlkngDUtLXjQCEOU7gdzgfuek6NJVySkjIlAyu2q8ssALkus5/RjB4bI8oRVxFa21shQquVxRpF93E20V1M/X2vFoFWtcSrGgmbcmdFJ9sCq/msT+DlBo0n0A+Gyf8v0cHXnAK87LlNSvx9h2/5cYD4USUD7jXFlRhkdNVSeCyyAj2N89pIoeKD0nqCJPQJt27wVk8RhwOLm8THC30KD7KcXgBuM8O6xEzsHNiiB/XniPFEn/XBOqoibFgtaBFGGRw6IrEFiwcdxw5v2EqBrqo+L33fFfq2LepOIPK/BKHrHhORXcMYEclNdCifARcxWSDX8iFBBHGwO+uvme1JfpXJ2Skz1rbR4n+YtQlrZCMrcLFUEryfLddUJgjOFjXaKwZywOC1jWXTbp37Z9fNt/gLs9da7ems4GgvRKQoYDSXSje3pYiKRhM3A6Bf3Su12iAS75lQQ2QUtao0DZT0q4/e4ZeWpv65OV8WzRFZcEk4kqryotEMuowPN/GO6aNAxBA7Q3XfIeyVlAhP9fjarWnFl6nEnDRHWYGs2m9yQ8TPuDxrkY4BYKaTsJ42pp89n09VGhG7Zho6E4RncVQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa1d4ad-c7e0-4f43-bcdb-08db16790f72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:01.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 593HB9EHzYyePIk7XMd0K2XhPJNck5v8F22iFK3gM6GB0JB24lQ0Le1n3inrPZ0EX362lx4JkWOuxNKv7Yi7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: EdYKX7WKRYAgiara3y4Q-umDJmcQwwGD
X-Proofpoint-ORIG-GUID: EdYKX7WKRYAgiara3y4Q-umDJmcQwwGD
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
---
 drivers/irqchip/irq-ls-scfg-msi.c         | 1 -
 drivers/irqchip/irq-mbigen.c              | 1 -
 drivers/irqchip/irq-renesas-intc-irqpin.c | 1 -
 drivers/irqchip/irq-renesas-irqc.c        | 1 -
 drivers/irqchip/irq-renesas-rza1.c        | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 527c90e0920e..f5ba3f9f8415 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -430,4 +430,3 @@ module_platform_driver(ls_scfg_msi_driver);
 
 MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@nxp.com>");
 MODULE_DESCRIPTION("Freescale Layerscape SCFG MSI controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f3faf5c99770..d6763ea9f310 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -389,5 +389,4 @@ module_platform_driver(mbigen_platform_driver);
 
 MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
 MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
-MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("HiSilicon MBI Generator driver");
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index e83756aca14e..26e4c17a7bf2 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -608,4 +608,3 @@ module_exit(intc_irqpin_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("Renesas INTC External IRQ Pin Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 1ee5e9941f67..49b446b396f9 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -270,4 +270,3 @@ module_exit(irqc_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("Renesas IRQC Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index 72c06e883d1c..e4c99c2e0373 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -281,4 +281,3 @@ module_exit(rza1_irqc_exit);
 
 MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
 MODULE_DESCRIPTION("Renesas RZ/A1 IRQC Driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

