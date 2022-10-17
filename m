Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B816007D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJQHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJQHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:39:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B45C19;
        Mon, 17 Oct 2022 00:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/OJtq08Oh7r2fAKWsSdMHu+pK5shnSXWdpu61jx6qxJpi7aNXXhSIOjGAcjaZzaOUH4/dYFBEOYdP406Y/2qjHdkgVNIBEpqTPPxHj8S08Ufo76qYT6w5w3kQQ2HiZJE5p8dFVn1kCWK26Z3X8iERpf75l2L9tU4SQsAhSS4bZ2Q0gIYDLkKsQ+hLfGUvwI/nsP6wm6po+jBwM45ytTzXhrByf/DZEDQft17AFZ0yirFTfXgMYztEisbXb40w+4QHajgdYBj9Eagf28AK123wshtoTX18WghEfiYnLz52MmM3oB/sDoG4UZhVDnuWL4/JyJpZH7X1aURiqdrms3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fck7mTDhmjf8nwLQsn1PXGx7vdwOQ+cBHkdih45XHj4=;
 b=cSvKls8trk2eYb9+ggXpCiQlTUiTVssF+vW9DL2v/rOfsSN72W6wUkjcd1Ri5Ia9cZyzY3fcEV5h5pQ8MIkpUq3+JRyg+mAXxBjRJjfJedKZoyCu69T31PGbKQGmxOYNQCEB5taHqBaiJyxAjQmLCe+1vwOI8kY+vVHQQ8qW73PMgib8CwH98DZ+iIa/M2dBRrAmO7CC8HqnVrk3UmBWI/B+JTynBi5LF/6Y3TldvLjtd57D8FpSWoh/Th2dYCFOFwpCvScRps6Es3n1S6ZRWVh38Ld4qNlvjqTsIW3VmFVZFYkrqlDwQ4BSQmslViuTHc4rwxeqs/9azaa/nbQG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fck7mTDhmjf8nwLQsn1PXGx7vdwOQ+cBHkdih45XHj4=;
 b=XoaFPTFhURi6iEUphgEBuP8W5//SIXHyFStMs8DC7deQyWsJ4BaOlwc2aI3O16e55KZfq/EM0RW22HYjGFpJ9VFGbDWv4hsvmwYPB7nUA7UDG9ugOrAyAXuxGPNavYQcEk5l2c5kFHs0YJSEDFqXHGCCe+sM/s/eY/Zp06oAVZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 07:39:18 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 07:39:18 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH RESEND v4 0/2] drivers: bus: Add Freescale i.MX8qxp pixel link MSI bus support
Date:   Mon, 17 Oct 2022 15:40:37 +0800
Message-Id: <20221017074039.4181843-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: c971b774-4c25-4eb4-9ce2-08dab012b2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsD7ksbu8qofmQckYxBJqC7hPr0Y0YUZraM5NCVeF3o4D821puyBQet3XLHFloTBV+JdB0riKN2+B6Y+hoeo6Z+NqWvP+QXhFF5kPS952M0v1tx94AEJmVUUKkQnxxy0l//pzzYRl4FDvamQfGRFADQcWTymnWbBYTcvfJPRMniL8mahNuzXlBNkVZGP33I3DPvQZZugGCbUZ1hTG0ZoFqf1EUGt64bnj34ZKxHAEX15gk6g3KjOUHc8tzPgQAaRiJzql2h/2q0sIhtQZeHJrlIIwWR0q+yW00V08yJVzFmxkA0H+lalZfZZY37P318IwXS93/JeaGRUtvZ3jx5baHRRdcb+RMBbFb0/ll927K/vwW+gXLKq9q01NP3N52bO26MXLqD8ZmoxnKiU7BncJElVQOq85EexoqKH//9BVDIlU4wNw5ClblYtvFpxtsTsGtkzrbTBgM2EtNPxqLVxUzv+1BoiwSMOPy7GAfwNXAcdwjJ2M6VHmuwlBdKm25USJMaEX4ozBE/vb7PkHCO+nnmRI1t1xqa0GvBWn/VcMyz3j5wQ4KXUin6/hnBj1Ftzm5OkIJlqY735bj7DcJ8TBGI+M6ePdz8GvDn7VYE+5k9MhC1pryMPSwRl1nVz19dT1Qw175CnY4hUUrv3iVFjGmlNbYseYzSq4dBCUIZd9J+lYlp1Gr9eCfUT+LTD0ecRRMBKl3mnkOMqUfWIzZI3eRtYh+u9tSJCU4yTOshZ8NxjiAcW5FdPaapu8WkibGQcpAWMYSIIMbwW3PwxlCO5TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(4326008)(8676002)(6666004)(66476007)(66556008)(66946007)(83380400001)(52116002)(6506007)(36756003)(86362001)(41300700001)(5660300002)(26005)(6512007)(8936002)(7416002)(316002)(2616005)(2906002)(38100700002)(1076003)(186003)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M22lm3nQR4qOU6VTh8wtDAxBn7d0P/MNitV9PxcvOonZJObldum/9HGu5+Fy?=
 =?us-ascii?Q?74wgJ4DlsXJobtoZJ/tQXah4Q+EDUk6yrIJxxqsMexErrrAJS0efDeEDl143?=
 =?us-ascii?Q?U2B012tNPz+hD6TbX81JGRAR0OfVgpl5myc+JxsiYHfnFw5g22rq6RatKk5M?=
 =?us-ascii?Q?j8LJS2cyZeQ6b3XfwcDzmJroTpDbWsVBTw9smj6RbtArU7J99yvi1fdnmGWL?=
 =?us-ascii?Q?XqyoLBmb5V9SHN2tJB/K+4MvJ08pwNFhR4BINB+7u1w+AAaALSEW/fPOdlke?=
 =?us-ascii?Q?SHwValMWdOhJHgFmlAyiB1BN3S1VG1CuKpkirlt1rV5Q7upVJtcn+TrGjAjP?=
 =?us-ascii?Q?o9g0sNUcW0K58vX+ZU58ftIam0QC+4WcXFb6beyF+1fnzxR+4SkjSLZ2v3Q5?=
 =?us-ascii?Q?7sZ3r0jQTyDt5fV9QGlsfPbRk0bA9hD6kwyjfOkN4pAf/mz19Y3p6d/0F8zA?=
 =?us-ascii?Q?WWxExnH8RsEx/30ANKI+FsdavFJEzZi0bcvvaXdxSODIDHdJDschC8Z0LfTm?=
 =?us-ascii?Q?boqhMqC+lFYabXq6xsPq7P/Q5JkH4Zr4DfUl5cYQad+uPNe4fF1FuGRUBG3C?=
 =?us-ascii?Q?azFVAhhcAoDi0bODN/xP3cG7a5GDmj67CDF/k96UC8KAvevfN7MgRLapLW5L?=
 =?us-ascii?Q?pYoPy7ligoCwZXWITRO6ECnyJwKL2ymDyBjlyTuqbT7QWVWlRRqVFbY7WjMx?=
 =?us-ascii?Q?9ppZhytZvyrPqKI/cO7qii2uxPw4wLxHJZuIkQ3xCyeYxo75tDU1/0PM9KcX?=
 =?us-ascii?Q?sbpRf9aIoviltDSahISIlK2Pdh45K/8GQoUFojvk3QXgY/FpyewAWDiqXeoG?=
 =?us-ascii?Q?ZhmzIkHoaWYx7T097WpGx6to/DQFRWCUupZhJb291TzYIv4vDXtui06ZxCFM?=
 =?us-ascii?Q?3Ri26A5Jyh0+AXUmGvOWgUFUpnD8bKnkyBspXcyEJ6XUSbVAY+TejRUUdVv9?=
 =?us-ascii?Q?ZiKwbvqMr9nQhXcE3puwT7TNI2xG+my9lJPiF4MzNM7Pbk9BSWUEx/39jVUU?=
 =?us-ascii?Q?I8Tk+gydlKnYW0Zfxal24MdPdIvh5twftkIXMjgy+A+zjOCujnd37xB2L8DS?=
 =?us-ascii?Q?qMV0KhQq4vqJ5+ePvwu2935EdeD2FJT96gBI7IGtMC/ORv1vYn+BMfVgGilX?=
 =?us-ascii?Q?2US88vGVrCgpG1rBRf54ob0jQxBnX5OVSmcIgcXLGL6jFaj4Uz0hpLCUkuTO?=
 =?us-ascii?Q?jqX5nKXq/VrJhaghQUo0ZwVHcMwqtkT0Pjtvt02Rgi+43MLr5yM/0KbAADLf?=
 =?us-ascii?Q?Md+IvCwWoEfZznKso79gbrbiIdhoDWOfJwjbVM4837mcf5jLvnxQ51suvPFN?=
 =?us-ascii?Q?b4IZYO2LmAI8NHztzdk5ezQ9ya1SKd0/vl9RmrAFZmti+VMfqWbR47n8rfo6?=
 =?us-ascii?Q?a4ZL76ImRtSSpUbGteMTlhVQLw1tGwKv9LhJffw29aX5mnDznwjRTUg5qp/Q?=
 =?us-ascii?Q?K/avwNt+XzGfr/AMbnC1Pl2zamw2RnOdSLjRByFhXax90Dnd+uZ/lhn04QGy?=
 =?us-ascii?Q?PTgHIfFDSQ0VwIdaMKxMjc61UyGb9Be9+iGD4lq67GHe7f/NF1rPyzXzdlEl?=
 =?us-ascii?Q?JRDXUc07R+0nJVdrkgc7LnX+G17PhqRU+OqOW+4X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c971b774-4c25-4eb4-9ce2-08dab012b2a8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:39:18.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If+sYSThBXaRnsZwqk2T/sv+hTrSYHF6Q3v3KoSlvl1QqjqPGee9QHWMg97tQMhqMTERKqivb/7AZQS6X61VZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qxp pixel link MSI bus support
by using the existing simple-pm-bus driver. A power domain and two input
clocks need to be enabled before the MSI bus accesses it's child devices,
which matches what a simple power-managed bus is(See simple-pm-bus.yaml).

Patch 1 enables/disables functional clock(s) as a bulk in the
simple-pm-bus driver when the simple-pm-bus is being power managed,
since the MSI bus takes the two input clocks as functional clocks.

Patch 2 adds dt-bindings for the MSI bus.

v3->v4:
* Drop patch 1 in v3, because simple-bus/simple-mfd devices probed by the
  simple-pm-bus driver should not be child nodes of simple-pm-bus at all,
  as simple-bus/simple-mfd's child devices PM operations cannot be propagated
  to simple-pm-bus. Those simple-bus/simple-mfd devices needs dedicated drivers.
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  for patch 1 in v4. (Geert)
* Add Geert's R-b tag on patch 1 in v4.
* Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
* Resend v4 to imply this series is based on v6.0-rc1 so that there are not any
  dependencies for the MSI bus dt-binding. (Rob)
* Resend v4 based on v6.1-rc1. (Greg)
* Add Rob's R-b tag on patch 2 in v4.

v2->v3:
* Add a pattern property to allow child nodes in the MSI bus dt-binding. (Rob)

v1->v2:
Address Krzysztof's comments on patch 3:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

Liu Ying (2):
  drivers: bus: simple-pm-bus: Use clocks
  dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
 drivers/bus/simple-pm-bus.c                   |  48 ++++
 2 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

-- 
2.37.1

