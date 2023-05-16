Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5D7045CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjEPHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjEPHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:09:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432B19A;
        Tue, 16 May 2023 00:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLSCe2LEfXlCw8tQ9e2qG6EozU0f2ts8TgwEcXRSA8gn8uxSU9W/R9LPyCR9+L3pPG9fAtnJHNZO/GxC9up3KAgnZe5WRRVl7/x+X30z15fwHnLxh6/2y/Of17+rMe1FMY0PDBOIYQPFcv+uLzB3zSXzS+n93yoCGYB4oiLh8y7T/utoByIv+xZTeuW+bd7MOQFfMyOGnTE/kdo61+lZ1ZyUaqBz86UX3AH9udzS9jWlZWJ60sN/2f9p2iRHeffZKHmnAlvedVPnaT0iSc+tLv+LfGjSx7CS0plCk4a77VAgbQmEjzee2yMhuxDsxfZqFaD8gw7Um1hV8xiK5WCBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JBzsNr98FQHrkORfc9UT2IfoaBKokWJiPmEz1cRmhk=;
 b=G2VBG3FlkDhRqKSTyG/Jba30m2RUpKKlaOLLkamaohRem2/dK3F+P3FG0PgKH87KHPmZRuOXuG3ick2zRapJPRAtGV9vKNcC37jFjLue+Wqmd30q5hR1PS28DyhL8e3VJvaQ+qMVU9f+3FpE5t1h1TccJzfIhqDmiCO+n6aBtiSZIa2a/sPkqbGvqDhNpxdpDAEj1mYBWRXxxB63Qihoy3yC7c3c5CW2Xvz2NjFs4RVZmm1wbKy63R3duhEnCerZ+vx3tAfTwNagS6d49INCkaFBkwxKI97+f97xyDDbDwOoL5F1ElpRtknWiIdcMFOrabWV+Ss7bAUQjT2IHRm2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JBzsNr98FQHrkORfc9UT2IfoaBKokWJiPmEz1cRmhk=;
 b=YB4yZOqwJyF2sSuEN05gOb1j2/vDj8htYJwWpDcBUC54xVBVOI2WVnFiDadW0stbYssvgD51jah/obwmSR+SMWRnHFpIccoJJ7CSGI8I2z/PN+7Q5XTkn1If/MM3y6XtOVI/tSLhVBMmLfY0I8YeAXWmQBmH2+x8inU8D/7WQrjIu+eYv9LHmYxxQ/9/9gT6CmhML9xCn/Ksu7N1dpsg5Ta9PcvTbo6Rc/B9XUKaS5f2AEAn9HiUW299s2uzsA0FFNIgwNz1lg513zdGFyLKxpqpUkauNtBbNhpFbbJlCXptlBAJK658ckEkW3WGpd0RFyVGu5YXSirtBClhNRsRUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS2PR10MB7501.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 07:09:11 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 07:09:11 +0000
Date:   Tue, 16 May 2023 09:09:06 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <20230516090906.0d7c6058@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZGKnCmPbAw17R+sn@smile.fi.intel.com>
References: <20230515150352.30925-1-henning.schild@siemens.com>
        <20230515150352.30925-3-henning.schild@siemens.com>
        <ZGKnCmPbAw17R+sn@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::8) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS2PR10MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e48f4d-bfed-4094-5f6d-08db55dc72a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfG+2NGD615/nZdQOzxw9pbaovmrfKbTlRp8dowk/lJxj5p32gRNnhGaXKvoIwddyuSyugUAyixg93rWvQlD2GghYwutb1fZXGY7yff8nLH8ebR2gO+BxwLKJ/e/OvwhlxRA2QgdQs4hYkULInnB5NxVoDjOJi58Zk4nASt8Ekgf9MnhXaq9F+C7+aG2X3s4So/KkFBSdFJ3Xr7O++4s6UNJ62ymIv6oWKC4Zv7zLasRGkJP9z2mqwSZ9UN9gTxaC2BAEjAj/fkphl7eZQ6lGU95poc+xLvI7Eq4wfSgU9NoNrEdlfqFymPQ6++8A99pVLJWDI9mpZ12cSn3bYEozjWZNVRJxs/fSyjsOiVRfgRlKKsggWFIG7bGsqzo0xXfVS+jr6Wyvq3RGAqEolAkIaH9qiuV5uLfAY7m68vEpAPfNItSIQbRP4ZYPjise894yvrAfih4rjizZlb/Mnggb9pK9pOpOWp0aaYgssZ09xB3yYg6TN7JBdfu0herDqS32je2T/Pmaywo5nR5FRURb9zUZBNWFjiitTaqPBWH5sDM6sNyOqIYPk+YnDsC67+O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(54906003)(2906002)(4744005)(478600001)(41300700001)(86362001)(8936002)(8676002)(38100700002)(44832011)(82960400001)(4326008)(6916009)(5660300002)(66946007)(66556008)(66476007)(6506007)(6512007)(9686003)(83380400001)(1076003)(316002)(186003)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIQ4RIv2DWB9Cr1ue03mbK5pALnOMu18ZA5J+pI0uX7TwOs62xWSXYXmFNH2?=
 =?us-ascii?Q?yuE5AN/2ckZp5xMzMDrW04LTo4D3xrn35mXBcS3/u8m9I32qGGxzT8gYE7N5?=
 =?us-ascii?Q?dschChvh3Bh6kh25OyVVToJvH6F4PtKsMl8PvpRQUV1N6Vj8E016CFQAJH+l?=
 =?us-ascii?Q?TI875MGCfROYJbwpkhi7jE9Cg7JJtiSlYkNkmRBBugckyWXC9e/jOH2xLm6J?=
 =?us-ascii?Q?csbvkTTh94yeL4R0PrUIIwAX4PQFQ0ZHTeYDtAZzr50L3opQo7k+GcIE6Vq9?=
 =?us-ascii?Q?/nFGBg/33ysfkcbQm5qzubEnA+KzSgl1v9PY7PPLKwNWSCnG3idxGrRLVb33?=
 =?us-ascii?Q?VqnVxm1pi6J0tSMsO2ay95CVASHiP7Ya5jgvGqiBD3iFV9h6clrNEqRNQc3U?=
 =?us-ascii?Q?5Vc/28zSvV+Yq30o/r6Yd9hKMMpt6fPBC9GFvUdTMsu7/mLe4duXvm9nBsYq?=
 =?us-ascii?Q?3hFVT5pLQTXTkEfcwJQdp7Up+WEX1csddi+fwYNtTgSJab8yYUK9ANZzOp6k?=
 =?us-ascii?Q?AhtPpeulbcmhm5uG0jKKleogQyw5gqRnoZxuNaWuWK9W8eJAeeqRYppM7ay7?=
 =?us-ascii?Q?te6/vkIZV/z3JsHggeZzbkJGlHWevK1qvqdJ6CHbRydJIr8RCOZn6Oyr6xug?=
 =?us-ascii?Q?ykQhzoFp9lUOtVNEE49rMuC/qlp5lglH3yvMjJ7WoUbjrDQvC0SoURKFhIEI?=
 =?us-ascii?Q?JG4h+4dJczFOaFhKEpll1ZYcr3hp3megwmSxTZtP+2kz0Kv2+MdT6lfjO2SZ?=
 =?us-ascii?Q?+Vx8iUp8Pq/XxiavbpmpZ86GY5yUg5ilj8WhORl7H+XGntbhZLegnNVUHDsN?=
 =?us-ascii?Q?d5t0EZw8wfEgCXvtTNz/tk5zutJaKnczHdji9YkuROnSkP5FbyLybDTQ4DrC?=
 =?us-ascii?Q?gz3e2OC1DeZa5qDNvrw1wzIH6JHat8DiQoXCtFCl3U0q2euQLSex/DlI5VM1?=
 =?us-ascii?Q?FwFtd2xGx6tNiLBR7jZp24w95jKF9N9UIP2LxUoaI5/1Zq/oYld626Vu6pRS?=
 =?us-ascii?Q?wsu3LSUIDHV9/LG9ld8F8s6vXPcEsUVBS11MkuXifmz3r0+nJ+5mbipAZml9?=
 =?us-ascii?Q?s24eG+8ZTL48RrlAJwGOMeai7nVQyGtciMj0yWFGQy3TDoHrSK9dOPAuqouK?=
 =?us-ascii?Q?XKYZU4+Um+5NgFZXyLz0zkvOb6XHoi5uywXLy6yNC6oQlO/j+8OuQQWGoIsg?=
 =?us-ascii?Q?8H5cBjY5G2mjnfTWDpqsrXVUXHdoU2iFSXGwy7+yFrEwLDPMXWOogW9LnPgI?=
 =?us-ascii?Q?mQYnGgqqTJGGeWvsmviThe7YeqdcDUe6uoTE1PKYXBWJ7+X5dLsE/QCykJy9?=
 =?us-ascii?Q?+j4rDvp5a37RwYyUDEwp6rgTHXf0JSnu1j+ScTPQXMLQM9h8vdggLLjrEsyB?=
 =?us-ascii?Q?xsbJxXF2b+0F37ZjS6MpYSJLeBUQud6ViDoPKTH66jpo7j4TPCN5EoEx+S+U?=
 =?us-ascii?Q?K/GKocF9TKrgi6HKLmuNcUGPsjD0JqZ/YrdA6DlkU38bKAnt++DD0Fv2AEdx?=
 =?us-ascii?Q?SfUvpq4oy1sf2K5PrrXrnxrYxoXIMl3Qkg7YBvlgM+hEho/Q/SK2t5Hd+bGX?=
 =?us-ascii?Q?eNOK6fS27oSWEQ1nAnU0BN0rL8MdvJqXhQ6DWFSfMK9RxCfjMDAPyATSFut+?=
 =?us-ascii?Q?tz9YNFOp/TMpPR/63vQe34v0wXDGsRKy5SvX96lyfkAAjg4RKZVqQMrlVguL?=
 =?us-ascii?Q?6B7Abw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e48f4d-bfed-4094-5f6d-08db55dc72a9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 07:09:11.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qihEVTTZDGf2Dv9sIRapX0ws84TBtcY4nzB8+QZ9istcyxif2w9hZxuyrMi/HmER6L6u560ywrcFY2jeXw7pLoclu+29spkMM1X/6KOSgv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7501
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 16 May 2023 00:41:30 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Mon, May 15, 2023 at 05:03:51PM +0200, Henning Schild wrote:
> > In order to clearly describe the dependencies between the GPIO
> > controller drivers and the users the driver is split up into a core,
> > two drivers and a common header.  
> 
> AFAIU the GPIO lookup tables need a terminator entry.

They never had one in the first place and that worked, i did not add
terminators here and that also works. My guess is that .num_leds =
ARRAY_SIZE(simatic_ipc_gpio_leds) tells "leds-gpio" how many entries
there are. (another array without a terminator)

But i will add them in a v4 so things are explicit and aligned with
other similar drivers.

Henning
