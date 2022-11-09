Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFCB6228E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKIKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:47:02 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75AD51;
        Wed,  9 Nov 2022 02:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeA4hjsePVzigT/EEWJSu9ZrMaoS4wNnAGh52wWVWEtPnav6eVTUW3uT89H7pgxrG2eGV+9Kf+Xomh6ShrXVoRn2i5Ox6cy2q+DBeUR7XYvvD9dF4Y7aH7GHgTp+PrMpLN9PH7gDPiWTJZ8b52goHc7gHp3CKvAiackVVCzhTirw/Eq9ZXkslLehFj25QmRAqj5aCdnc7W53eS9am0v7dN9WPZNSVRvB6tPwlkI/wJOhDZBu6kdEafzq+ILXMMR3T8j2rgBYsK5PA306aqZRaL4dJW8pL9/Blqzpfd6xpUIy4pcWXk1KsP+pdpYR6H+aGxFf4bhg5XkSfnAbPd6k4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUR2wQfu7Zrk6hZwjMbmRe2uTw0e27OMu1gfoSUI3IM=;
 b=IOzWRLzvYYpWQGiVhKxgCrgron8ennaJnDSMjPPoqWD3lGuSG5mF3YKDk/PL6G+mjmykIYP63tYcrzrl6j7zEl/FgVtf8csIPyQjU/rkcWKkbOtXSEihzEk7enXXMNfd/UWq7fK3X0OajZ3WT8bv/k5zN2A+dIduCYN4Z3+goZ9AKdLcJ/C2aDSc4oqCov4J5h4PQWfOEHI7AOWAa/mQDcZc4Jw8eM2HJUowT7ItB7EfFag/OUdTiehNHoFScYyWYxNofRD8zlRi1CXF+pU2wLU29/M5lA9HNS22tV0iM4Zpi44Um6DmmMZmKHIlKIUDcyCBjaUC1qHBji1iylCYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUR2wQfu7Zrk6hZwjMbmRe2uTw0e27OMu1gfoSUI3IM=;
 b=Jgso5yA/QPS8M0zLWXSAzbDSTmtgH9sz6Ds0cpQdf0rpPErN//rweONVLHtDGKiLpa9661IBu6eDqYU/Ffrv9YHunHlEODkl4cMqWmS20hoUoT9Or60gTzhZkzmCyvg8TpCVL+tNOFVqpMzZoXfEdnaRp34okhLOe6zkF3+39bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8974.eurprd04.prod.outlook.com (2603:10a6:102:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 9 Nov
 2022 10:46:58 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 10:46:58 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/2] fsl_lpuart: improve Idle Line Interrupt and registers handle in .shutdown()
Date:   Wed,  9 Nov 2022 18:45:13 +0800
Message-Id: <20221109104515.17266-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c4f547-5edd-4b1b-3f5b-08dac23fb996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3KdP7u3VlewblbbBvvgGiCB253RhA7wcotIcua8UtLzdwEKu1iXrUo7907gX03kiZlpZ1wmzFOAyFrmMInB+dNavu0Q9eJvE705F7HzoibOdvWKxhYmQTuBzpg1h3tWvmPnLXjLItsCfg1tWKI2oGLTVBZJ5Tg/pxZHSmMioJMt7k9CKeK99/W66wcwz0U15DUY2xZL/rSzMH/ABBPDWaiCvjXwo/YaesAxhDavxCdurXnZKQcHtAZK/dbxbOauCiqTM2Dy3aYmkjTIZWXGzpKg9s/pff7F/s4/nc+IG8WnNGiILP+1I8C0poXOIJfQPwhCUCfErP8PoQdSxis+x76ls2wkXMRhvhgSEKqzoWD7UIS7028bsylrOAzeKYGqo3WMqFcGSs8TK3YY6cdWlawgxeZ+0+bKw0bsjfIYwU/wfOONxl7Ahx8UYd15in2sBeTk0JjDWXpveCtfOq8+/IYSpyiB+MnzjqHkp1Lx56mPKTsRnDeIrjOx7dMAoTCEEUyPz2yw71mfttS9PWtbICmvjVGnP+km3Smv4YayylL33zuV8W3OTKEm584Q1KwpvL1AEQc6s5cCCO0U037UsqIVeeQYhlRU2NPwbE/D1MOpUhMySAlLQ2nc0UNZC7cKXuL4K+dZQkndrRsfpFUHV4khXrtioh3MD3z3ydCQPMHSlX1586oE0P1xEBoBGpncRSTzakspDl0TtmWpid3YVFYaRJ44ChldS4rT8E6W/w9RmAkizyNGCbA31bJSlsZb29Fd61NPIwPKfcNgCAqc5O0HO6t9QIGzq8JfdfkeK/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(186003)(86362001)(38100700002)(38350700002)(316002)(66476007)(66556008)(66946007)(8936002)(8676002)(2906002)(4744005)(44832011)(41300700001)(6666004)(4326008)(26005)(52116002)(1076003)(2616005)(6506007)(83380400001)(5660300002)(6512007)(6486002)(478600001)(36756003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzk7YTvLjelUVo8ALVcZdVkoiuKHxIGZNQU6Z2zXAZIjhiiGJpJ3WwUMejhb?=
 =?us-ascii?Q?SENIFrlfaOVkUUC7IP9u0k1FmsabXzoS4M3fY4lIsawmv6NG8aBrYBg1hzK5?=
 =?us-ascii?Q?eWVxj/DXNaAi6e/PxkDKO9Uxs3DKfbvH6qHEHvQu7ijv+PumzenS/tssvhTs?=
 =?us-ascii?Q?pxcyxF24PBSSnkotdRZGBUDNz01yBa8kQqXrK/kdpZ37BEvL4TCTXbqc3pWR?=
 =?us-ascii?Q?z9kOLkYMCsk1lYlzCYOjAmUb86WbRRUZDJ3a8BA66uwm7Qj5mryptpZRFRYl?=
 =?us-ascii?Q?yHbCusnlniIDanO81JbpWXHFXKnkbkEAmDrMnSyagYhGO8sHJvfVg7Qi47eS?=
 =?us-ascii?Q?adYG5auT0YLx2lOx4DkpMIVj0zm5YP2ZpzpCp8GTcSzIijlCnRJNx14yB/m4?=
 =?us-ascii?Q?ZornU7m2XhPCQ7ZK6LkeaHFKCR8hHntHofI9ZzQiYUiaQN+rm3Txku7iOKNi?=
 =?us-ascii?Q?mixSA4dYZiXBy7hdy3M7eM2jQffhlrpsRNARngiWy//sqek/hH5DkWMd0wsJ?=
 =?us-ascii?Q?ioighfeVu1/3khl+xIUqrKhI0wtZN0Akw/ifs2rDDyrxCuh99iBSC1l4jQXb?=
 =?us-ascii?Q?Yak7RUYHP+NKUG2gwQWkV7yJd/ZMc5ao3wImDYzIMVySbaMiZnPrnrT5Zc9b?=
 =?us-ascii?Q?EBesSZ/xOZtmVxPOy3R/foaDZDUu07RxvT0Rsu4zAzXIChad2nlM+TaAVIzv?=
 =?us-ascii?Q?nfb/l/lnoh6CApXhIxh+IpUGaQT8AEDw66Oge1obrec+s2QHNt0uONx1subK?=
 =?us-ascii?Q?52f9vPhSjRtl5iqX+pcndVGWT1CfeuqgEUa4LZkm0EounNcbLA8KI1l1GCn+?=
 =?us-ascii?Q?DuP0s5EyaF3E45o5mYv48gdd5bBAjqXDZ2FNpO+agQSPT2xvlzIyzdbCIIJF?=
 =?us-ascii?Q?VGAg2HHgY7EFqhIAyvc5WBTuVgTkSzZgdrnYSzIkod6Qx7/NYfsGSqOE7x9r?=
 =?us-ascii?Q?cWRd0uic9ZCZwxRnAHimSwzS/kndkleI/FoOv1DmDKW0dyzlMBcfipi/XWtK?=
 =?us-ascii?Q?ecVUDy0oCGXARniHdlKteEzG8y+wc5IHBDs8FoFQolIadas7jJlLGtMUFq35?=
 =?us-ascii?Q?FMbAoPJuTZF+OHMyhqDHvi+yRVlXsBqhWtCOp5SAL+SbI9ChO8k4XjBJJR9E?=
 =?us-ascii?Q?6AAKU3fqIeCUgfwiGYCK9tCwzQOFkV5Wwr4HTfykT+4cLUaF5/r5ZrMhPCtc?=
 =?us-ascii?Q?LXA5SsCGAcdsKYZWIbECCwlvr4LuTMANVzhS4dd5tW6fmzXpj8QvDTvY60SY?=
 =?us-ascii?Q?+wMRiIvSzF0u4MufFEuG2+OL95omQI+E601y5IyUXjDkPlZTmzuoUyf2oT9O?=
 =?us-ascii?Q?QE+RgqpFFi2pcpAzoyiKRplmR+0Y7Lz8CCySBf+EO1V5nu71mmKgZeW4HEqP?=
 =?us-ascii?Q?IiNAr8xQr3KRBjkMcezaBopDy2MEtR9yKlpcZLcFV3E3BA6l/UDmPEmEZjXk?=
 =?us-ascii?Q?FS1VH0BxK65AljKULW/fvMAmshoOVcxs3vV1K95JVVs8MvA1UQS6sTvNA5uu?=
 =?us-ascii?Q?7KH3y6iNPZX/l94wmkJY+mpJwVg5XELwpX/CMrPbWBpwVx79HxLuhlLykM5e?=
 =?us-ascii?Q?+m3lnxJzlCyOjbJLorh6acNxgY2J2YJT5oD9oxuA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c4f547-5edd-4b1b-3f5b-08dac23fb996
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:46:58.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVgeEt5/9vZ8X69wVkouqUUV9kIyfUzECfHcXe5IiFDc7DPcP86IuwE33e1bRyBHNeo/jAiUXl23vlv6dnkUsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset improve the Idle Line Interrupt for lpuart driver, also handle
the registers correctly for lpuart32 when shutdown the uart port.

The patches have been tested on imx8ulp-evk platform.

Sherry Sun (2):
  tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma
    case
  tty: serial: fsl_lpuart: improve lpuart32 registers clearing when
    shutdown

 drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.17.1

