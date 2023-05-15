Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAC7029E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbjEOKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjEOKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:02:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937A26B2;
        Mon, 15 May 2023 03:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG6pbcNEIoPA0PA+gvn123LlFSZ+/UJWoDWpi9n6ihFrIRM807sJoSOHZ9Jn61L24x2pvJ8AGiZGAQ5T5bcu7jx6CwEDt1N6IJV/tG4I4msfapAZUWVge2UYDSsuj3grdB5R8wGnKYMB8VhT55BwTgVmExHOQ2FrPMls1Hvx7MeTgnD2HHOEMFmAe3X9ReL1c98K2mlC/1GHES1vCH9CZV+HoNDC+GmwJZCphworSzReQohiEYGw+qqIclS9p5av6iUP12RmdLfDmR920BfMiXS7pXUF2iGMQwK5rQzg9HPWBRmBuFffbDGAOGZRTBoA15V5/3VT8wRBjEn8AToB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNJL06YICJQSOxMr/8XDgokNrInBL3NHxmro0RHWKSY=;
 b=ZBGNt9CYSs5llaFpX5USZ5pCDUBnXgQxLz9IVDqtvdcjhK+cb8CJY80ZjhQTFNyTyhHUcP8Feydd9ybzKu2R6uEfyv2qZL2DngoTfPO23O4mvwjEa88tjyqhlm5pmx4S+wwvb7sdm6L+2yQCEnGxJ4MdhveSmQkdJsn9ufjPu8bEgaZ/7qIkSQotASp75ANJmVVW5DghKdp/RUEDO5DRr8pj3t3FUghHpnL9Pt/3sE0ZOWdvaX98myc0QB2BOJ0nmJbiVwHfONZanvC1L5gKngG/RtOqwUMBHyKdIe4yGg0Flx+bCd2BBecygcAka7/ncGTo4K7Sukbs+R6Ygq4f2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNJL06YICJQSOxMr/8XDgokNrInBL3NHxmro0RHWKSY=;
 b=D8sxAGS9IJLZ+YMmc1fnJk5ptPAnGnYm58V+7pPFAoGebGU6rdIUMwFCbInpIUg0CDR+UkPWLzD8ZNvbOJZbMn0jcSNzs6jP4V7wHxKe8mUWJYFNpV9mSn8nS1WDA0aYujDiVPERMgHvElp6mGFZ3aFH3EMb0oIqNxgSQ2+cOgS4pBAooBLYg7nwpa3dh1clo9W7lInRR5VbftlK2WpsAh/H2PRztO8GXb3VXPToMJgQqCJRWhASHHh2RV9ERxu1WEV8XIwkvu91ff4Ypw2hNDe0a6CBsbecu/NCux/HFtJ2eQ3wwg44TgsoVnGbSOLH0fTw4UORgwQLCcjsTLO5oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM7PR10MB3253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:01:47 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:01:47 +0000
Date:   Mon, 15 May 2023 12:01:38 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <20230515120138.66e48bd4@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230515095042.GE8963@google.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230513120818.21b99596@md1za8fc.ad001.siemens.net>
        <20230515095042.GE8963@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AM7PR10MB3253:EE_
X-MS-Office365-Filtering-Correlation-Id: f7aff86b-ed9f-484b-6d7b-08db552b6527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzSAjT0A/LqUX20b2F2L/vW/LEKZk+BSaJw32ywbRyrf4c4H8kvcKmW1Q0sQyCfUz9MpIPzFRWlcffme53aiZVPRD18QxLP0b0TLeTJtx2hfiPlrht5RFv5Waq+ObwPC++YJMb+GUxQnE9mhR9aAnQfFNA8ruBgFaHuGMYgh8fAUOJ78lEyKmjsC4Uzstq9Rof6eEx1rzb9wi/Y6JGhuIzvyRoONLHfqW5y0xMTTpLOFmF6sUbsm4aQhhC4fnWEcqFp5wPQXSD8yf1PPG5p/zfv0895E+VfPt+ReFomG3h/gAUzHiboOpH/bcty/QzFx+y7+6xGVYGjrUclATkbu33tY3IBlPUy1XjccgU3osua3CvryWGTgTbqv4UWokGf+Kl/PU6L6jtZcX5k4tqIaRctnfMcIg7L86mjAxfzIx/FjBzi4n2sqUhku37wOCUU/rFtjP0Lejods8rtTYboHxH674vBfLeV8TkcV3Q9h1gIb9bPB+X3VlRq/9er5ahGqwkx6xaCSuo+TOk3yAPRFMpEVC/H9q23LR/L8uXm4MsfWtH3hcfP4UZ/Fo/+5VSLf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(82960400001)(38100700002)(186003)(1076003)(9686003)(44832011)(6506007)(6512007)(4744005)(2906002)(41300700001)(5660300002)(8936002)(8676002)(6486002)(478600001)(6666004)(66476007)(66556008)(66946007)(316002)(4326008)(86362001)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NBzSpU7OPBgzWkcUKyq6jLkICwbTzzBy7v++GKeAUjcgmM22SjaeMW71d5ZF?=
 =?us-ascii?Q?umS2zr2Un0CNKg+BEIekL0/OSTTgkdDuRBSKLuuq1St+otmRXuu78GqIQbKS?=
 =?us-ascii?Q?HAjMcAHCQJsIG8X5v/8Mei6NjuokHbJuVeulFrq4ZzVNcOF7nUDDk8mp5NpY?=
 =?us-ascii?Q?DHXK8Ge79P0s7K/cXZalrJweEdy+Groie4RAtt+D6Z0e2FeLg4btOCp8p5A0?=
 =?us-ascii?Q?BMXIzBsv2dwyuje1/OFdsVhtWhmIdRB9yMxN0+hHwIxpMT+64asBL/8FyYn/?=
 =?us-ascii?Q?svXXlWoklzn51p8aSo5BLOqAKIlA007yDJciQLPWxr5Wtzj0m+qieKyx5PGB?=
 =?us-ascii?Q?jEkce00FT3riGBmGJlOeeaO4yYT2c0NWj7HsbBHKP6PF3KP+r8LLmJ8T6tlE?=
 =?us-ascii?Q?6cl9nr35/nuOiPfyxkGJJiFZChRZKq5VvO3wX66JJRe/RH5CtnGmhANyZPAN?=
 =?us-ascii?Q?ff4AkpCCDL6eoMovGMKTgpYgtIgYmxCkb3E05KwqYucHmAyHeeOVcSEY9n5+?=
 =?us-ascii?Q?6BCypSTr1mO3NZrSTJkDp/Koqb8RNiNZbQn9IeTpUfP8NOqgwRM3Vxw5P9S/?=
 =?us-ascii?Q?r/XrJcsWiwHLlAI6vK54NM3uWncD+1nZmBtBvtgUp7H3TBwQoqns8h11H/lV?=
 =?us-ascii?Q?wgeaoMXwYUbyQU1fl8BysPhPNvgzn/gxrwTSSw3WKsUzMNo3c7mjhZaVW7FY?=
 =?us-ascii?Q?tvqckwXgwXRi7vHqxXLa/pkJTlEccTvm1XuCks+ZyuvG3QqBFeVEyJmnAejK?=
 =?us-ascii?Q?WUDoCxmDLUiYhm+Blav9MyjIWd3luDVDC5zgs7e6R6Rzp4ykaX2tGhRIqeTx?=
 =?us-ascii?Q?v/+iipuFa4YY1rDt5W/0XpETeHSCG0zcpGifUxibg5f2/76HEAWviRzZKTAX?=
 =?us-ascii?Q?9TCkTd+PIGcfKYO0HiZZcyaYu2SjDJKs5Wiq+8JMh94neledZgjfcBZHDivz?=
 =?us-ascii?Q?6futWv/2B6lhGkwB9yGTFlnqcB5UkkkQTxydpb+byKDvWPUkL5t0mxsKxb1A?=
 =?us-ascii?Q?Wh7ntlnpak5lV7+O9FCUPaOoS3hectvWN5DqTqNQULIpmI6LzaXtZZWuRwrd?=
 =?us-ascii?Q?MHwIlUhkZM70Q4ubcpP5Eaz4hG4Kfl6Me8SzXpXAm13fZPXNCP/DzHT4bChc?=
 =?us-ascii?Q?9EtxT/cJamETlrSgfXrMt8YvbvOpN2UMJeTPQchZL+Tdjxs2FaNGH5+mzaBi?=
 =?us-ascii?Q?NGmKlOdH6xKbsHTDqA2o8qZjLxAmo3mhhxHuAFCj2LyJlxhe4OydJ/ACVRzI?=
 =?us-ascii?Q?JuKYI9F5p/KCmmYKeu6PTdOxJcVV7Hk19mnpgOiwLqQ/Z0vNOzqW713y9Voc?=
 =?us-ascii?Q?bZkDxGI0XWMGg+vyBUW/BDCjAqtJVEInjj0y5iSCYduHJiM5MtyzG++6lw0e?=
 =?us-ascii?Q?GYcHmiN8JxDpr9hzvHbqH4kn3XzDOQXGrIjRa7aj+QRBu7GHQVNZfyTpMbEF?=
 =?us-ascii?Q?4T0owtSrownuVnwso+gSr54aD/QQOEBCrPuE8KsT+cGVa6BUTICLPvjgS6lD?=
 =?us-ascii?Q?OnnhHR0Py2HgCKg11/0DpufsgWpEEDf7b8QpGZ57toFbVRZ/dpSxj4siDQn6?=
 =?us-ascii?Q?XmllEDPehmDQH4U/jH/ATAKRdOXiOV3QGE11orDjwNHT1PxVgq6LMariQiGx?=
 =?us-ascii?Q?Vgwb1Q0eJOAexZ72Igvh9EelyYeibtRVkAbcSNgVpz3FOZdzyx4CqnaBiAq4?=
 =?us-ascii?Q?BM7e1g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aff86b-ed9f-484b-6d7b-08db552b6527
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 10:01:47.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sbrCNX7vzuYS4uza6xDA22mkpq0glrxDTskDpBy+0reN4vGg1oJb3MGXjfsHN/N4NjAHvuPZTGuISTUq0pkorOH9n56fA2AMQ+JVxQ6XMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 15 May 2023 10:50:42 +0100
schrieb Lee Jones <lee@kernel.org>:

> On Sat, 13 May 2023, Henning Schild wrote:
> 
> > Ping.
> > 
> > As far as i remember this one should be ready to merge.
> > 
> > ACKed by Hans, and Andy had no objections given the maintainers
> > would accept the patches.
> > 
> > So i think it is the maintainers turn now, Pavel and/or Lee i
> > guess.  
> 
> Looks like there are lots of mail threads in reply to each of the
> patches.  If these culminated in acceptance, please collect all of the
> Acks you've received until this point and submit a [RESEND].  If there
> are changes to be made still, please do the same but submit as a new
> version.

Ok i will send it again and include the ACK from Hans. There would be no
code change. Please review the code already, if you find it acceptable
we might receive a second ACK from Andy.

Henning
