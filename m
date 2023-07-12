Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA074FED2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGLFn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGLFnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:43:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3C1992;
        Tue, 11 Jul 2023 22:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEVqWiOIcf9hOF0L4WLZtOL/SpB8WOSz5kYqu18a+kbWQar2mSgmIDCs7VNO+bMSRXHJXBRxFlDkoyLu+3sGqy9XjOcNVYDwuFxJ3yUX2MCUfm0pb9fDCUPS+V3/bRSfnv9jhLP9JlRwSRUdsXwXK0gPkrBt4cHWeTcuOXbArjzEgF1ftiX3kuPqWFEzHJg9KONqBAYYEVrTHGKHkAuZG3+rUU3drTFTLIy709U5dU02WEONLj1H1jkj2WMtkHY963ngtdpWweKj3OIZ7dCu78axJcwdGcPnjtf53oo0sBKzavTdfG6gSRFvvuSkBLwy6bdvrI1JEErXeyHHJpS2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+/oKYA5G9We+ejmALTdbYtaa4QS9/078bheMz6hQOM=;
 b=Yp4zejY6WDSkQsVf85NZvoOeehtqKbgVcwPy0UkowU5f1nBiaHrbmv2BrdSTFAw3iJEbWjTY3I8Kx8dguhZVlUTxZAr0GA/IOh5ROwdracTJXuzd5KMR/kLCrH3mbm3BX+Ede5DPEM62psVZ6hTnuYV8wcY2JWheHspDuVtMmaASEugaWZZx6t/nYA4qD86KHlCcS41ywdYoB7wM465Yd1r2AQxoCTHSdfRwTnYzmL4N3Hq4xrr9o+9W3hcL/UyzYtUDzE2vYZzAm2/6iklAAAP56xVinNnP78S2YlXFY3WT/fr/muYfiu4sVlPFx5c9j+1DiF23F/80FEm8sOY5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=pengutronix.de
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+/oKYA5G9We+ejmALTdbYtaa4QS9/078bheMz6hQOM=;
 b=0AioxflwljT4htjXsg5F9Zon8uXKQp6M54FTOOMHTqF4TM9RYa6v/sqZc2/a0ZoKwLzUvKl8I8ffVjVRrYCYIeoVKISDtlm2xGC7XsVSw7WXu40Ix4tOp8yLZIlwEiloK9IuCV1uuQUa0NIy5bmV1/y5PDfnyrce4PeDy1dR00dEN9VecP0kwFcQqQ7n7MrkG+lIweac9UcejSx2OmYr6JMcjwJvdMU4WKfY8zzEhiA738gBQCKrdzdLGNG454KmO3jT0kmubBPsQGfRCeUTRX6JOwjcRM/d3JkidYX/tLKxwGEwxN6S2u7G6Asc57ect+svFScZa1paL2+QGMtbyw==
Received: from FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a0::7) by
 AM0PR04MB6930.eurprd04.prod.outlook.com (2603:10a6:208:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 05:43:15 +0000
Received: from VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a0:cafe::cb) by FR3P281CA0171.outlook.office365.com
 (2603:10a6:d10:a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 05:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT007.mail.protection.outlook.com (10.152.2.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 05:43:15 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.108) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 12 Jul 2023 05:43:14 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 05:43:08 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::1f44:72d3:9e80:b8d1]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::1f44:72d3:9e80:b8d1%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 05:43:08 +0000
Message-ID: <cd752cb5-c244-82d1-9fbe-bb63cca222d4@topic.nl>
Date:   Wed, 12 Jul 2023 07:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c7fafffb-93a7-4f4c-9c1e-df959c3ed3bb@emailsignatures365.codetwo.com>
 <20230711152647.28673-1-mike.looijmans@topic.nl>
 <20230711-refusing-derby-9a9d4d255d30-mkl@pengutronix.de>
Content-Language: nl, en-US
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <20230711-refusing-derby-9a9d4d255d30-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|GVXPR04MB9928:EE_|VE1EUR01FT007:EE_|AM0PR04MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: cc17c1a4-0abb-4347-6f5d-08db829ae355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: l6PS2ufFSGD1Ld8pNH33NblIq9QWy3dBhN4TWAhNXwWsiWEunDE87bCHeRHu6L96BdTMQDv1T2PSSUwcnGe/MUb+dY0PiVMYFmwrCpPjWWtbc/DSytDzKueqRYYUJWn83zjoTc0ldQyNempIxa5p07Nsr9e/M5mI8btpbdwP57BAt98Ex8iy2RsUAetVytxtyVTKYZ0obBKb5teKveqCay1Lre0je7iu12q/sKcoim1peDU8FoXq45fpm/0AyyrL/n9bdjwSiWMBrm+e4Ooma1yJnCmGvdxoRbXuwlDJYFTcV+Dz55o0UnuIJDOmGusQqe8Lc/kZjevCedoMbtgBfxnRTwrIjh3Ly7/oLwfX9eUeQJKItZ8tHZjFhwcmOuZcsE4QFlpPuQACjGSxVCVMOOY3Zi16RYWWubDSWn51E1/2JqE9kzV9l1+PwmaPL6jI4LVj3CUz8yYupKBbFluFd9IQbQlhrnnauIqqyF+7vPuE6vkUtIyRFc8uiQ0OVCBaGKdkCxcV1RBiWNe2MW7vO1fxSQwq9kSqhNQINqg5JuWB4eZOCWyDolj0z+lLbtKQaiKtMzKJP1qYncIuB4dclTMnJJqwcP/jUySkJyu/lWJXWykmce+OLMx4QrCE96JxFhJC1bQOq3xAxInuN7tzSg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(451199021)(8936002)(8676002)(83380400001)(2906002)(2616005)(36756003)(38100700002)(83170400001)(31696002)(7416002)(53546011)(44832011)(6506007)(26005)(5660300002)(186003)(42882007)(316002)(54906003)(6486002)(66476007)(66556008)(66946007)(6666004)(4326008)(36916002)(6916009)(478600001)(6512007)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928
X-CodeTwo-MessageID: a5db93ec-829a-4ecc-bc34-47062231430a.20230712054314@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f76e1050-3554-4be4-e2cc-08db829aded7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtRfR0u3h0QLWN1KAQWJSiPMbg3CCbISwRiOgUcP1rMFwwr577KOVdSDQqYEs/SkzvvZfhHT+FxUzhInyWEi7b+xpcz2aZqLxL0jkrnjMT8KR7OH4cG4cVAaXQKWZNpUMsFfe7VK78QTxeAiOhYqfPAEgP/8IxHm/fjGCYnmynpAPsFPbCyR8/InXBHFmPkO8+35/sGh/s3Is/PX3H7R1PNdUDrTP0ngP6CsnmWrvg4+sgst801v4xnpKOm2mqswUNts4mYsvBmURVLJrChZEIb/JZC3Erhql8sNJLtx/U0ggiJfyz8OOCG/sjkXVncxUBBs7zvvuF2RidYy/eCIWiNdkBBvMqHXHKmDBQzxjqmlC81EPMOjzQDThrIuU4QQtjvbdwE1Uu8Bgbl4DwyL0woP573/vgGRFGM7eLhCBx+zqVm2tH6icxHkGQCJuaW6/OG96yP+VydRvMNlo9Q45CUVwB2MijVDuyds+19EEWeLKkUh+HkyvpcFi9yqQr/Apwvr3DvHpF65pYpSHDOwX66ZwUZQhZJSrqNWi1X7aHvGV410O7LTH6wzYPalLrHv7t+YXXZZv7v31+frofXt3U1VQQShdA0FfOtF7paeBr26o2uw4IP3Docs1Yz/ZwagxyFLrIvPI52f8X2WZOau28VLQCPqkYsVOqU7nFNTWjXjth2zlQB51CR3eNDt2IjXOqsWxJG8Hb7SynM0Pj2F5wHXBkT9VtS19qiPAy5VI6E=
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39840400004)(451199021)(46966006)(36840700001)(5660300002)(8936002)(8676002)(36860700001)(83380400001)(47076005)(15974865002)(336012)(2906002)(2616005)(36756003)(356005)(7636003)(7596003)(82310400005)(83170400001)(31696002)(7416002)(53546011)(40480700001)(44832011)(26005)(6506007)(186003)(42882007)(31686004)(316002)(54906003)(70206006)(70586007)(6486002)(36916002)(4326008)(6916009)(6666004)(6512007)(41300700001)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 05:43:15.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc17c1a4-0abb-4347-6f5d-08db829ae355
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
On 11-07-2023 19:05, Marc Kleine-Budde wrote:
> On 11.07.2023 17:26:47, Mike Looijmans wrote:
>> When there's an error attempting to store the BER counter, don't abort
>> but continue shutting down the chip as required.
>=20
> If you refer to an error by __mcp251xfd_get_berr_counter(), it's not a
> store error, but a failure of regmap_read(priv->map_reg,
> MCP251XFD_REG_TREC, &trec). By default the SPI transfers are CRC enabled
> and no/wrong data from the chip will be detected and return an error
> here (after 3 retires). In out of memory conditions or other kernel
> errors might be possible here, too.
>=20
> Have you seen a problem here? But as we shut down the chip here anyways,
> we can ignore the error here.

Excactly my point, the important task here is to report the bus off state.

I haven't seen the error trigger, so it wasn't the cause of our problems.

In retrospect, maybe I should have split this in two patches?


>> After disabling communications, also stop the TX queue with a call to
>> netif_stop_queue.
>=20
> can_bus_off() will call netif_carrier_off(), isn't this sufficient? Have
> you enabled automatic restart in case of bus off? I think the netdev
> watchdog will kick you, if the interface has a stooped queue for too
> long (IIRC 5 seconds).


Apparently not. The problem also occurred in the field, where the CAN=20
communication got stuck for something like a full day.

Automatic restart was enabled, with a 100ms timeout. Setting a shorter time=
out=20
like 50 ms seemed to make the problem more likely to occur

What I also noticed, but didn't accurately measure, is that the time it too=
k=20
to recover used to be somewhat random, it could take up to about a second f=
or=20
packets to start going out again, as observed by watching LEDs. After addin=
g=20
netif_stop_queue the recovery was almost instantaneous.


>=20
>> When the interface restarts, mcp251xfd_set_mode will
>> call netif_wake_queue and resume.
>>
>> This fixes a hangup in either send() or poll() from userspace. To
>> reproduce: I ran "cansequence can0 -p" to flood the system with packets.
>> While running that, I shorted the CAN signals, causing a bus error.
>> Usually communications would resume after the CAN bus restarted, but
>> sometimes the system got stuck and refused to send any more packets.
>> The sending process would be in either poll() or send(), waiting for
>> the queue to resume. To "unstuck" the process from send() it was
>> sufficient to send any packet on the can interface from another
>> process. To get it out of the poll() hang, only bringing the can
>> interface down (and up) would work.
>>
>> After adding the netif_stop_queue call, I was unable to reproduce the
>> problem.
>=20
> The newly added netif_stop_queue() will cause the netif_wake_queue() in
> the mcp251xfd_set_mode() to actually wake the queue. If you observe a
> problem, I think it's a general problem, so all drivers would be
> effected.

After two days digging, my conclusion was that "something" wasn't getting a=
=20
proper "kick" when the CAN interface came back online.


One could argue the netif_stop_queue should be put into can_bus_off. But th=
e=20
netif_wake_queue call is in the driver, so that would break symmetry.


>=20
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> Marc
>=20

