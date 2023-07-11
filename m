Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46474F35F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjGKP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjGKP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:27:07 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEE10EA;
        Tue, 11 Jul 2023 08:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6hO39gwPebwbt9mbZmMiPTOAVLTC6SM5u3dRS7ZhzxHhUJw5QMQal36eNiui1vqZVesb7T6fwf9POsLcUPlfxFovu3y3f5iZLvSrfZ6dhjyT1Z/dE7kKHUJpTBKZBvBqjMfZsSPCH6G0rYdMJ+zweOy8Tm0v5QBKNLD9r0A7/BwOBUrUZTZsIYN+LHmbiCdjepmUo0GujIYr6hC1/omAJrhPY1drVwmWWCRR7L1y5qacsqUE0iMdlPtNQttrVmpj10KiSvu9/h9oXoXcwM1XQQUWqB8HJf/xkcoVKZhS1CNDjwMfd4CM9YqzvmuZd00XitaKfqtdMnaVSCOI2BniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tepGR5gbHQ1Y1TmtKSgPxFeBrr8yydjntaf683rahq4=;
 b=R6IhngfoLL5dOIcVI5Jeo1bjFqaHjNwEsiEQLalY69LxmKff7FNYjby7iVC7rkmS4Fq8IL2Xm2DYaJx8SGw1ktwUTblRWi5zr5z2m/TNkEERUUJyf3z+o2Wti54Fx3ENSlH/PN4PxfAQWElQgp6uXAnvHrXPcjVCrTnOJPTTZz5jmT5mU+9fY6y+rdIF4xlVxPU1obmZp0cPeciXdAg30KV3tBAvs5obQOndlrQS+AHKJrsN+Om79jdE5njttGZq48LfkyopPmt7/6n0isnNbEIv154gy5Um5H4CLA36urxYjKU2pJ4sWJ5mpgr6wj2xOLfWmZ9OJ0Y0oS/AZkbovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tepGR5gbHQ1Y1TmtKSgPxFeBrr8yydjntaf683rahq4=;
 b=Ljgan1lDH0fdFUhr+sRtAQknSCIJUg5/MLFUaa30GmSH7/kvyX96NX2Ey0muW6AgfGKiNVjZ7J9mcepCEer/LHNEx/B0UfsDfaLOClVH42/bbwUyjavsRp4eZQqUwfk30Mfds1ItCAhaAi34tuAKO4bLpcNDDkkK0ZJSfS4h5o62o0dA1ioyEzYTBNgDkjE2L7EFaP3IwTIrvcAo7UYn9QqaTpcrMmARBA4L5Uq8V+z2mR9eLgEI0XQNOXK2+rVOvexqpC/zLAs7vHD7yqeDRl0ycjLc3UG90sckdcfb6pec7kOb6KMcFYP5vLgPLkPn/1RC0XacGIqXumTu2YPf8A==
Received: from FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::8) by
 AM7PR04MB6887.eurprd04.prod.outlook.com (2603:10a6:20b:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 15:26:59 +0000
Received: from VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::9c) by FR0P281CA0150.outlook.office365.com
 (2603:10a6:d10:96::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 15:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT034.mail.protection.outlook.com (10.152.2.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 15:26:59 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.57) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 11 Jul 2023 15:26:58 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 15:26:55 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::1f44:72d3:9e80:b8d1]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::1f44:72d3:9e80:b8d1%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 15:26:54 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-can@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call netif_stop_queue
Date:   Tue, 11 Jul 2023 17:26:47 +0200
Message-ID: <20230711152647.28673-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AS8PR04MB7750:EE_|VE1EUR01FT034:EE_|AM7PR04MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: f13cf846-8e37-479a-086e-08db822344ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pIm+yJIrzJCwwDzSDHOmtL6WvsyC+gKypnWDyU2SuLbs+e4F/xo54j+91R0FDiS0RvilPlGDRS8IvMgEhSk0NULNhwuNHkZJSVR2Ih8xuJ+PyTfyaTjSCc4SQgO05enRJfuBDzitKdoE/NCnAJGzwDP+WoqpirfMHTCGDNKT5eLVJfK0XdB8r9fopiQ3SKt8DoqikenwE6YkGCD61RxRlP8oIdalhVwdVyPTjBhwokwr2bS1sQ3WdMx6ZSk5YESzV5egsWwDnGy3b4YfI2RQprhgCrwkIcQDcc4R8EJ/IcQR5IzaAQ1QN82KNO6UxhTVQf/VgjWv7AdzoV23TF4me1xCy0Kp6k7kyDmEi/UzFYjAXg4r4/AlaqIGfbosQZnexDEVrfrvdH+1KMaR1Dh0aTWi+e2fO1MDLIRw9VtWz5XjR2zP2XsbMfjUFs2TyQ6SLmAGeD9sLBQ/pJN86ThK/trm1MjKxXOLcvsocYE7jw3zZVlAV6ntGG0+utrTtR8ovei2kn/tVeEXsuVMxyi9XerXYXg0FpcnkuEiqKVH0N6OOIsnPO9rGYvOLzVgnDdtL1mzlqsMJZrxvQo74HKSFipSe9+M66rBChpQxEayxw+4wRJR53xwYWBOrK/VZN/u
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(451199021)(8936002)(8676002)(5660300002)(478600001)(41300700001)(6512007)(316002)(6486002)(4326008)(52116002)(6916009)(7416002)(6506007)(1076003)(186003)(26005)(42882007)(54906003)(6666004)(66556008)(66946007)(66476007)(44832011)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(83170400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750
X-CodeTwo-MessageID: 888e6179-8e5d-4b48-84a3-44955c35a541.20230711152658@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c7fafffb-93a7-4f4c-9c1e-df959c3ed3bb@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ab0b35f-4852-4a7d-2ca6-08db82234211
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqoikpQ6RRTpAfX+/tVkYqUTN6Haomi+6MwYIXZIcPW1x+kn95CmqXEtzaYh1ogGR1XwZKpAqKreqTb/NJy12CNGkkxlG4B891bR5q+eAULjnbJMzy0NvnhjghGp8iwVzBF3KHDvqsdGKNOyF1x/sM0t6fUTggRVYOsxgUQlwBTZXephVHFFzbIvTTJxs7O2GjWAMs71ZgEzfsOAEMh1xZg8ZFtdWQdE2qAMSBS+MtR4vmJLCrTF+KzYOFH22sZOQf3xgUcw8INQTL+ICGoWxP/CDKeOnYUzZul+g3g/gFgMyDQDxadiNHH/s/4GYuEOTSMScRMH/H5u7Ph1zsIxe+Rhsw/jTXhzVqW2eiNt637oeJIUuNC5fwsXBkA4x/Nq7+YCteGf2PonzuZM42sBNgu0F4JNuwv7muH3isk02AvormIM61HRI+iCzCp1GIhVVNBUmHlft71E0xxfuRACy3lwP0nvixIiVEWnhOMAedc0WCXoicmDxGcZv3IDiwMTKJpU2q7T5EfTbMo5ELNpDeCpJ5cDUwCZNqskaGr92XEKsgHaRVIbMO9Yu861HOqBBItmF/60kK/Y+lPCFSsfujEgXeR3qBul4eIWqS1dvdQ5L3BtAFSG6dmSVBZAkKFnkheuYPNdw64fE44P40DKAO6BJBzy4HW18ywTJRk4uXillWOP+NfYjWgpme5LBM9z
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39830400003)(451199021)(36840700001)(46966006)(54906003)(478600001)(6666004)(6486002)(26005)(6506007)(1076003)(42882007)(70586007)(7636003)(6512007)(186003)(336012)(70206006)(2906002)(82310400005)(7596003)(6916009)(41300700001)(5660300002)(316002)(4326008)(44832011)(7416002)(8936002)(83170400001)(8676002)(356005)(15974865002)(36756003)(47076005)(36860700001)(83380400001)(40480700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 15:26:59.2227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13cf846-8e37-479a-086e-08db822344ed
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6887
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's an error attempting to store the BER counter, don't abort
but continue shutting down the chip as required.

After disabling communications, also stop the TX queue with a call to
netif_stop_queue. When the interface restarts, mcp251xfd_set_mode will
call netif_wake_queue and resume.

This fixes a hangup in either send() or poll() from userspace. To
reproduce: I ran "cansequence can0 -p" to flood the system with packets.
While running that, I shorted the CAN signals, causing a bus error.
Usually communications would resume after the CAN bus restarted, but
sometimes the system got stuck and refused to send any more packets.
The sending process would be in either poll() or send(), waiting for
the queue to resume. To "unstuck" the process from send() it was
sufficient to send any packet on the can interface from another
process. To get it out of the poll() hang, only bringing the can
interface down (and up) would work.

After adding the netif_stop_queue call, I was unable to reproduce the
problem.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5..854e0644764c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1084,10 +1084,11 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd=
_priv *priv)
 		 */
 		err =3D __mcp251xfd_get_berr_counter(priv->ndev, &priv->bec);
 		if (err)
-			return err;
+			netdev_err(priv->ndev, "Failed to store BER counter\n");
=20
 		mcp251xfd_chip_stop(priv, CAN_STATE_BUS_OFF);
 		can_bus_off(priv->ndev);
+		netif_stop_queue(priv->ndev);
 	}
=20
 	if (!skb)
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
