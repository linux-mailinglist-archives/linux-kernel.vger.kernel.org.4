Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866771FF58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjFBKcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjFBKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:31:14 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5A173C;
        Fri,  2 Jun 2023 03:29:32 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3522oJu8029978;
        Fri, 2 Jun 2023 03:27:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=proofpoint;
 bh=VK49erWtzMW8D6IHLfaHktCV+GvGoA1HoQENXH4oeFE=;
 b=Hhrz/9sd+Yj8yGEWQ/qDvrAdvDe3cADtUhrNQP0gs9daFtK0Jr5OmwFheKn7mYdiz2MD
 XNxG6DVFdFKR7j8jmV+1DOG+AUL5lU2KyTS0tSpAoojoCsgSPoxTNygpXK74nhLamqU+
 55xAGpxNbfz64dSpe7LyBxujy49QRRu+5wf2M6zFZD9z6+dpKDGEMqzZ361ROXNAm2G+
 s5nU4EjKWSpuHoZPUGJaLEJTZDL2SeJ7fx41j14WbEm/77m//xlQkrJBOBRfjVFuuAk+
 at58TONXWGzAtzcxnNu8jJBwIfVnEyik5sKfHQlxxhvO0IFaNsUPEGUEuu8a3XwnjyKW bg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3qx6x9hjfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOiqydbfdund30EC+R6khbCwh36QHRF5IwWMBF1qeebQRX9455K5CGxaAM4Bj4MCpZIP6qVT8PoU9ud4y386B50l6s4R/tu2gqpz1qvnECcD7we/65t8us/Dg1ew1LcLBHQfvS5yfhF77s/1bkJLcqZTxxRrDI+Cdf6iAJ61IGNt74QF52TkPKYiINwG8N/uJKEsnYkIm5Gduxoo2irABZW5WqmfvE0HBXxgvVmTdMgCvNu88V9ONw1T7ae0rkkGABV3h1rPzdkp+cI8MqyL+AXcjhaVKBQQUv2F3LxYfSRAraymzeHKjedKgdoK3Z/VtVbSM7N7jMKV4pQkPX8QYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK49erWtzMW8D6IHLfaHktCV+GvGoA1HoQENXH4oeFE=;
 b=A61YC9fA2JU3XLkKg3fv1VapKQg9EpqCjB+jD7SjZaVD8ZIvFtXtT4jN2sj6n3n9sr030+BmCmH/f6uO+HTTXv4SqS72t1QSOCO2X5geRSVXhQEfOlU+PLpcbLpM4EgXxfEUrPxRyXtC7KszQcg7BMKRoREZKFQ1Ur0DC7gYZ7/XpZt248BQQE3P/LZuqj9/6FzC4kcB+enmqLhESAPJMR3FKNHbDOAxTIKZx5365Q/luGHb1L5eFuolidCzh6SGjor1KUMKxn/xbp3AZeynh9cjJOu/pU46++3JnuDLoq14WVYYa8r8rFGNzNhkhkvfgnvki/Bv49FAkT/6Yz7z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK49erWtzMW8D6IHLfaHktCV+GvGoA1HoQENXH4oeFE=;
 b=2x1EfsrYBymY4H4kNPRs+HGVnF1BxRmgJvv7Ad3fN6kaX3LaXIJhE/4gXpYK+WCqx8HgdIX9eejruBeIGCB7lJaFpfvmPOd/2xceBTQADqY0blT55rbOw+5YjVFc8BNnq0QvAr46Dwrp0Lp6tGGM/CWtDkmea/3tav3oMSLCkfA=
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by CY8PR07MB9449.namprd07.prod.outlook.com (2603:10b6:930:63::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 10:27:21 +0000
Received: from MW2NAM12FT106.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::4d) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 10:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT106.mail.protection.outlook.com (10.13.180.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.10 via Frontend Transport; Fri, 2 Jun 2023 10:27:20 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 352ARGt6005656
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2023 03:27:17 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Jun 2023 12:27:03 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Fri, 2 Jun 2023 12:27:03 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 352AR3VH077885;
        Fri, 2 Jun 2023 06:27:03 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 352AQvHP077803;
        Fri, 2 Jun 2023 06:26:57 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <tony@atomide.com>, <jdelvare@suse.de>, <neal_liu@aspeedtech.com>,
        <linus.walleij@linaro.org>, <egtvedt@samfundet.no>,
        <biju.das.jz@bp.renesas.com>, <herve.codina@bootlin.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 0/4] Introduced new Cadence USBHS Driver
Date:   Fri, 2 Jun 2023 06:26:40 -0400
Message-ID: <20230602102644.77470-1-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT106:EE_|CY8PR07MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f60fc1-4bc7-472c-8a4c-08db6353f2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOHAPetDuZzZrPTMrcVIzl8/+1XgCgdmwKo6ivRQdTgROBmIwIXrurKGBHlHbazy9SGwOWvtHfhFeulvpLetOQQPGuo5852vHMU1BWMVrO4Te8Ku99rbtHJXg8KdJU34W/gmHEbVx5MzshZRBS48PMeSTsKmXtEMrSOHVCZucb3WUf7uf6gYbQjtZXWcimck/jkJQye+YEQbnv91SeslGNga9KK3UsBqGWbTJl5KaVcUme8CA0ESqMDvKUdMHHunacy3FQOGtwDUm8R0opcgoqcAlAzSZnK6Rp5oA3HEf781Ww/FOk+ZurmyrG8A0O1HU9HBos/NExZ0A0ykRmY/0BwLl6XovYNKr98U1uRREK37LFjQalzUogdNY2qBMpypFhYgWLZdM1zkPEJILjcJIVueMNHrHXahL8HFmDOfJx1jY7i1jp+YPhwy+xPdJyOzlme5maMW7iWZFvu54wNBvnIARaG32BacduaASn5vTQ++viIJ1E15Lh+osBI6A0RAaGfrfb5H3mXsbXj0RWXvR4etBvN5wdOqOXIXR1dW6JVncuuaSeVNo4EWkb58SIzFYMJM7Z7QMWL6X7OB3O9Z489a4mrz7oeU6M3nlTRT3mJQch+3kFQrbM+E0Jst8Vl04akTiH3jCxO32QFVxus5wSKB2wjZuTyJLa5caQ1TtNDoMWevSXXuc/niMNHqrN3Ys9319ukWorglZkGHARC+2Yo31vSHDc9OcyXwvg+nYwDT2Li9ubdcZqlbDdVWFSxw
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70206006)(6916009)(70586007)(8676002)(316002)(7416002)(41300700001)(5660300002)(8936002)(2906002)(54906003)(42186006)(36860700001)(82740400003)(40460700003)(6666004)(478600001)(40480700001)(7636003)(107886003)(186003)(47076005)(336012)(426003)(83380400001)(356005)(1076003)(36756003)(2616005)(26005)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 10:27:20.8244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f60fc1-4bc7-472c-8a4c-08db6353f2bb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT106.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR07MB9449
X-Proofpoint-ORIG-GUID: jrzxEGeniPN6HS7qGRLvDZznw8Qit0Xb
X-Proofpoint-GUID: jrzxEGeniPN6HS7qGRLvDZznw8Qit0Xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_07,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxlogscore=449 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Changlog from v1:
- changed some __dynamic_array() to __get_buf()
- removed kernel-doc warnings
- removed some compiler warnings reported with option W=1
- removed unnecessary casting from cdns2_pci_remove function
- fixed issue with ISO mult = 1 and mult = 2
- improved ISO transfer performance

Changlog from v2:
- used SYSTEM_SLEEP_PM_OPS() instead of SET_SYSTEM_SLEEP_PM_OPS()
- simplified code in cdns2_req_ep0_handle_status function
- raplaced wmb with dma_wmb
- added __aligned(4) to all packed structures

Changlog from v3:
- corrected module name in Kconfig
- Replaced some 'return ret' with 'return 0'
- removed initialization of sg_iter variable in cdns2_ep_tx_isoc
- fixed handling of error code returned by pcim_enable_device in
  cdns2_pci_probe function
- replaced kzalloc with devm_kzalloc() in cdns2_pci_probe function
- removed unnecessary pci_disable_device from cdns2-pci.ko file
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
 drivers/usb/gadget/udc/cdns2/cdns2-debug.h  |  203 ++
 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  659 +++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2474 +++++++++++++++++++
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h |  707 ++++++
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c    |  138 ++
 drivers/usb/gadget/udc/cdns2/cdns2-trace.c  |   11 +
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h  |  605 +++++
 12 files changed, 4824 insertions(+)
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
2.37.2

