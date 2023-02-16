Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F1D69938B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBPLsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBPLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:48:11 -0500
X-Greylist: delayed 1682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 03:48:10 PST
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82606303E1;
        Thu, 16 Feb 2023 03:48:10 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8uO49007096;
        Thu, 16 Feb 2023 02:54:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=GnrNFDWiqsXCjNQzrbWvVG/p1Ipodq1Skkq/daHCbHo=;
 b=hhHQ4VvTJsF/VzSu48eez/kpl5OTDQ0gRQC2Lr1lpFYDE31mHXuIXDFiXJoskx+thrCI
 lJg4NoXn57yF3nWVODmZV1qJIv+eLvanWQzjX78ev9QthE3ydRu7Hvxv/Hg3iWWXj/3a
 tbscVKTXeyFNXD5yUgLGVqFEEK7BfgS6mjY31eUJ8NI2FJG6gwW1BAucPSzK2pXd0roD
 bGQElxBrf+cd1uQse4ks6QN+n53WgiJLPN4FxIOo96wWJyzDQ3oKpAAohhJcMTx8NyRN
 d6+tTgHwyboJw0z/y9s3Bnw37gmkyuiqHg/XWYwNJ8UkYHm9/wsc2tyfXADrOH/xlffP Ng== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3np8f3a0wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 02:54:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pen8UfIWIZdi01yiiJiXMFkPl8ppaz68z2JP56eHUWJz4C8A33elI35pFM4aIPLyMIC2HukIaxdcmKA3im9MQAcuxtNrI8OaBAR8qzzhTY7H6361+pSvmwZpzOou9m80z9XPdCnZ8rPhtpNIgbsNJ6cTIrgUPQvged6nFDD0p5AT8fc2zCJ3Hn3NCCfR6Ak45BlJyS1x/uQwvRAkmD9YqOcwVCc3ULtebStEKp5zQIKtK6VQbIIbem7tu7uBHMrAGr9yrYL6q2/l9GETDOAb3yQLu2PnnautJthChuM1ZDcG12gqT/FA7hAA75L1TElDpp6+wJEkEk85q+ehAy8Sng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnrNFDWiqsXCjNQzrbWvVG/p1Ipodq1Skkq/daHCbHo=;
 b=Ak3oVRkP/BVacEjvM+ujqo4yAJ5aRDzv9HF3pThAwiEh1Oh5HWFQXNy+vGagXYmlF+Ao/spf1n4MpRQaY9XAp/YGBOnZpynGL9W+/k8mte1VdfZmctqtJvsgjSokGHzemi43LRMav4OfmPkzwr9uOKlIfg4+rWRQpVU09NT9XROyrk9weMv0qMLaNOBuaZN3eJ+9oSzl05nDo3AjH89EusaDXKoe9wQb8Pxxkf0MZRDgowYVQi3DyeH5ZZPIB9h1xIrvr7yMB26sZlKzTzfbK/Xu2nNm5/lI/P9MMn/Gp8Ewlarw1BglHrTOVGmAe+ce7W2a2QiCR99if4FR0Uy58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnrNFDWiqsXCjNQzrbWvVG/p1Ipodq1Skkq/daHCbHo=;
 b=K0OW2BYQ34sH6ddkggIWFbW+bcO7Q8HIsEYO/Ye4xknOQXSjAujitmr0hzfk7/Q/gWourAhb7aSUTj903ysfI4LyslTf97r6d0OycMLBSIQLGv2x2y7RQypK78scauYPS21bryLzAbb9iPlTLThYt94Dhr5TU0tL09H0VU8eHX0=
Received: from DM6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:5:120::32)
 by DM6PR07MB5289.namprd07.prod.outlook.com (2603:10b6:5:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 10:54:32 +0000
Received: from DM6NAM12FT086.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::1e) by DM6PR06CA0019.outlook.office365.com
 (2603:10b6:5:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 10:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT086.mail.protection.outlook.com (10.13.179.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.6 via Frontend Transport; Thu, 16 Feb 2023 10:54:32 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 31GAsRqg021870
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 02:54:28 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Feb 2023 11:54:26 +0100
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 16 Feb 2023 11:54:26 +0100
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 31GAsQLn364441;
        Thu, 16 Feb 2023 05:54:26 -0500
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 31GAsISn364304;
        Thu, 16 Feb 2023 05:54:18 -0500
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <arnd@arndb.de>, <tony@atomide.com>, <jdelvare@suse.de>,
        <neal_liu@aspeedtech.com>, <linus.walleij@linaro.org>,
        <egtvedt@samfundet.no>, <biju.das.jz@bp.renesas.com>,
        <herve.codina@bootlin.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 0/4] Introduced new Cadence USBHS Driver
Date:   Thu, 16 Feb 2023 05:54:07 -0500
Message-ID: <20230216105411.364157-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT086:EE_|DM6PR07MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d39952-c004-49af-3c45-08db100c2f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GNmLDdSPGXbcrtYnhQDNl6RrbzgUxLx0zTqLW6aFVjnwPI4rerkp7xjwHUqdsG77Mzm7Hp4bXQhCVpkri5ulg2QkfVBz1Y0qc9ukLL5Z6PX8M0x50g4OBYsA/z5+OQ3iMbHqLOSLynu6Gk9jNKDuBejqkCZDqCuJGuiRLUJsbEy6/JOZ7JWI6gB/LbOJhxGkN+iNXTGEHcucOLEIPpl8OA5jBro8VkvRnk4gqWCdfOG+I/C8iGmoZ+lUVrB95GOLxRLMs1ZXivjG7p2lLhHvO/1Gsi17COfr6yo7YocVOCqVyA+bWb1m1UTxVTsFFqAytifbGOKs6ZO5RJJ81FpS6KPWIP68RvREQfoDiWPp1PPOg13ezdc5e3zSHt3GFMsjFUh7Qr+hlQD+N9FtQDdQsr3sMnqFrJXqz4TjzSzkJovDZeNmkoNqHrFUpBGDgw8B7KYM4PPuC/KTBFWGKzEkbtHhV/DTu4AU5ocmHQy3viZ4dLk5CyxIUCwmlyUIvqIgw8FVjcS/r7mh/+3V95QDrQIpiYiM3Xy0oChsKbJ7sG+95RDSiDERdSeFAnwf97+DCTHYO1a6gL4/auiwPk3wwODuGbU2E25p6sIn5AZ5hy3xWso6aHoJB5ao2NU6wWr8m9GGMYx2lLvEzJRzUyjidfJijOXm7Lqwrn4O53qN1GKY87KHmmtx8TlA5jrdXrToD+Jy246f3eTL4id18cGCg==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(36092001)(451199018)(36840700001)(46966006)(40470700004)(356005)(40460700003)(8936002)(316002)(42186006)(1076003)(82310400005)(478600001)(6666004)(86362001)(36756003)(2906002)(4326008)(7416002)(8676002)(40480700001)(6916009)(5660300002)(107886003)(186003)(26005)(54906003)(426003)(47076005)(36860700001)(70586007)(70206006)(41300700001)(83380400001)(7636003)(2616005)(336012)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:54:32.2214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d39952-c004-49af-3c45-08db100c2f5a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT086.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5289
X-Proofpoint-ORIG-GUID: p8mRslAbEeV6hLz3Ee2t1SQXhrXbvwG4
X-Proofpoint-GUID: p8mRslAbEeV6hLz3Ee2t1SQXhrXbvwG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_07,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=288
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302160092
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce new Cadence USBHS peripheral driver to linux kernel.

The Cadence USBHS Controller is a highly configurable IP Core which
can be instantiated as Peripheral which supports both full and high speed
data transfer.

The current driver has been validated with PCI based on FPGA platform.

To simplyfiy reviewing the driver has been splited into 3 part:
The patch 1: contains main header file.
The patch 2: main part that implements whole driver functionality.
The patch 3: adds to driver tracepoints.
The patch 4: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
---

Pawel Laszczak (4):
  usb: cdns2: Device side header file for CDNS2 driver
  usb: cdns2: Add main part of Cadence USBHS driver
  usb: cdns2: Add tracepoints for CDNS2 driver
  MAINTAINERS: add Cadence USBHS driver entry

 MAINTAINERS                                 |    6 +
 drivers/usb/gadget/udc/Kconfig              |    2 +
 drivers/usb/gadget/udc/Makefile             |    1 +
 drivers/usb/gadget/udc/cdns2/Kconfig        |   11 +
 drivers/usb/gadget/udc/cdns2/Makefile       |    7 +
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h  |  200 ++
 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  662 ++++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2362 +++++++++++++++++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h |  670 ++++++
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c    |  151 ++
 drivers/usb/gadget/udc/cdns2/cdns2-trace.c  |   11 +
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h  |  609 +++++
 12 files changed, 4692 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/cdns2/Kconfig
 create mode 100644 drivers/usb/gadget/udc/cdns2/Makefile
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-debug.h
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-pci.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.c
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.h

-- 
2.25.1

