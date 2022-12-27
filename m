Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB44656CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiL0QPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0QPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:15:39 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2028.outbound.protection.outlook.com [40.92.102.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDDB100B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL1NDXCeNb6Pj0vVd8XynkNroGsZwMDDB6clLrs5jwEQ67SZMxvGDxzlE1/POHF3XWyf5FGF7nAtLwZEsMEC96uaJHbzbT7kqDHiyL4rXFe/ZK9PSHaxVF9ZAHnqGBkCMM8hJ3Sc2dNB4J/02NeBDvL+Aip8hF91gFRJsqTEzIY7jfW6DB2YeOrEg7yvXsSzxGsQ+9mprfnTEEkTDlGISvNN+KWrk6vvoWCFhv7mzhYazp4MwTJz3YcvfKlwxjouGCXqowfGC8JhTiGbXz+5Qhr9hqD/OY0TudcU0NRhwLhEwzzPiW5EXzS2o04KlVPEJ7W75wHvj0EzFYWR4J/N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch/8saabiqztRNfU0DJmTYSWgrPfXf1rFDJ8hLMsEMI=;
 b=FQvU2hafkMJEzPZ6NG7wS1vFRl7+ElVTjpmoFWt+AzeO7rL3o/XDaojpVWVOVzRkG+n5bop7UAZehIpd3r4GVfRS9vIg5zcFcR4GwYW2tqKHFy7a5DdzaHWZKQEvch/aKFPNhBDuA2Y5zrfUeUj/72cPyCtRX+2mBf6YTndD20cs20hkcvBAPU4FOUq74cjmX5cq2pWQW9Xxy0Zv9VN6NMSHlg+oqPRuJjHBH602xS2gJ09jdTI7L8S1+I2hrOBIuFuylrnJNo4UX92CJWsgCaCgxSbfcD9eolFqrFElx93A5f8+E48vp3YOUszHeldHxijZsCh87VPWX8ZALsGGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch/8saabiqztRNfU0DJmTYSWgrPfXf1rFDJ8hLMsEMI=;
 b=kLsHqgGlzBbTDBjDaGFD1Q8ZgpsW+feaS6gfYBWiV1ctYr/kxq562EA+U1+PMpHtPP1/tFrxzZgDkD/N2T2+qIpk8btc1xv++zbuXXwc3Ac1v7Hx+p4pLea3KxtSGL4GzJRe9umqhpxs9rL5b9wBFztQIgLFIG/OnUOfnn7t8OnDjUpw/kOl+kOy2DKFNzzgLFl/MjzfPzikr0i7eHcuQBtjiAm3fZVTVkPpxfoCcivLVJIGaiIhobjMIOLS6UYq5jgXQxyqlU6AAaTjCFtAsdMBl41etHZ9HN0MW4WnpagyxhSxbjg8zDUODZI6psmItu7R4fpD6FJ1y5bMofgtkQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN0PR01MB9023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 16:15:33 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 16:15:33 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Alex Deucher <alexdeucher@gmail.com>
CC:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
Thread-Topic: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
Thread-Index: AQHZGRb6yHJ4kgfUzkiN2hv0kLVX366B5SuAgAAFeIA=
Date:   Tue, 27 Dec 2022 16:15:33 +0000
Message-ID: <CA3D493A-3695-46ED-A78A-D6C6709FDBF1@live.com>
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
 <CADnq5_NiDE7a5dmhhuLntQe88DS5JmiZTGqQ6ongXuWyh1A4wg@mail.gmail.com>
In-Reply-To: <CADnq5_NiDE7a5dmhhuLntQe88DS5JmiZTGqQ6ongXuWyh1A4wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eVqTPu8KSWUbnc7CWJOzSNjGj9jIjhJLHiqtUQI4dqf5S8CXeBViSRnN+E3eI84Z]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN0PR01MB9023:EE_
x-ms-office365-filtering-correlation-id: a3b5ff3b-61d0-4841-3de3-08dae82594ab
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CY9ctoMPo86sJm5HzuGez0OwTUxb0BEuSJqeFyJ5obk9xrkJorBCWchzOxki8iGtwM1vGyMnot+Sxc7B7dytgUqm3r4pD7ud1fpLsrNz+lgJHyXCAwLTzi/bVsJSMprAKtcVQw5AMms8uFn7IroKgZ9oueleQuNlGtSe+Xf2FML/8Uy6OQyWa3TVBIvPZ3Ji9T6o542YROLnq8GZoUS5SUJbm3VtE37y+BQCqZDAUim7RM88uQStT/05xc1ZTXAtD2TVMuC/PBSbcUp/xoY6lzjla9IJqk3yCYK3cIv5K3xH55ymjUvXozg74UVyim7+qu3xjk50ed+NkcZexXOU3bGm5K3jMgdAOLLpSMM1TAB8hRKbYSv9JeEy4R5Nv6FeyBdVHqvN26n02ysSSspfRJnqAmyHmeDhZy2mxMYRZVfa2WqJMZu6mMzHMZN9skkFe1+ykhNKdWx0j3FR+ttfWck134HU27otOolSUzECRYSZo5o+7ba4n6/+36xr+HLQulQpBvmp1+0U+1boz0uYVQTHXhygyI765jerrFF9ad67o07clRXVTMrYGIIvKeq6hHj3jmaBbF4481osZlIiT2XK+lGI31xIdSCh+0biPhY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?82PR6Flf5UFc6libtbZU2uH8lK4RK+dgGqlWOfStpwYZnL0aHyG4y3+9tB5L?=
 =?us-ascii?Q?sPn9VhBa5jHpSpqAEayZFB5B4n4JgyoCUkXfgIEAnG3TP5LvCND3Yw8T4MTI?=
 =?us-ascii?Q?HPdlhJ/jfWKhll7i0H2OwZu5LM6+7Fevud2SSJ4MXtYhwYDVGBP80qT0QRer?=
 =?us-ascii?Q?TSuyYyiYHcu9lMIE1zFjMnr687VcAyJFzNVhQxoN4DnkYH6sPPIuPFPNZrRG?=
 =?us-ascii?Q?Sa3bfQmaIK91AAFAQe++xGSvMiU+8u1V4N7oM5RFAPnA3quSBEHv010xAOD3?=
 =?us-ascii?Q?C+nC4QhyPXk2K+roAudjLT0SGwtGD7wcz+KT3yMSa55C7OKWV7vNj4wodKua?=
 =?us-ascii?Q?jiGAdugX2VkNG3MmXjhnJ6gjtL6OoBI3zl1CNqG5pDvKj7vr1CQ63zYiE6ZJ?=
 =?us-ascii?Q?huTwGR0gl+EodjCQVtHiAvcMl3NNEOWhZOjXhOgKqOIFj18argILhsf/KI7f?=
 =?us-ascii?Q?S8LGJ1vWPA9DkwYUNrukdr7c6Wq+0r5z/3VKnV4B/+Z9AEygb6hgYcZjbFgl?=
 =?us-ascii?Q?bLjELMLb7yEn7uM7AAPkQ0gAuJk+beBWR5ArdD+zkb/DwhrJ6IR3iJXuv7/x?=
 =?us-ascii?Q?1SJFs2DVWPTXci4VKScuyBWlF6MjN/UCxbZGTy2zRTHjY/iER+oRqh7xxI7q?=
 =?us-ascii?Q?eWZd8l8WEODe443Bir+LiHRdLcP1/rrKbRUX5a9OLJzkLsKnkjkYMDjibGYw?=
 =?us-ascii?Q?4DYw5IzPCLYYhBRlQp5GBag35FaqQ3TdQXlkNQN1Ht3NhqlvG/8St0/hGCpO?=
 =?us-ascii?Q?SQMkGPmE+bt5GHLbTm29V+gomjKNQabFpyDnmTUgklRPjmsxl8KA69Ksafeq?=
 =?us-ascii?Q?NRHboPqHH5+fuTl8ZJu5vavFXDpqyGTcqrXeXnMtMsHwaeXJ2WSuQuX2D9G8?=
 =?us-ascii?Q?3xEZYzSrMBaofpP1qBipMwKMR8kCTJbla+BxbR3dAtWKMJJauAQX77m4+Hnx?=
 =?us-ascii?Q?cdrUjMczx3AkzNqN5VGvjIVWQNnGswtdi6gOEpuLHRz0ox5SzBerQyAodg6L?=
 =?us-ascii?Q?NbgfPZ9MXu6056y9gVn2P7BOx708trj3II+WgmJMrlYpPIq+NjQBx0N1FFbI?=
 =?us-ascii?Q?YSNvo9JMhZwaeO9q8EQoSkfqT4ZoHFvUU2EGSMAU9nJ2Fx8Ry9PIDnKirQf3?=
 =?us-ascii?Q?utmwlghqMULd5HOHmoIUHj1ApBXOZJVDpYqT1wjnYPpkmiJgvvTpihhoqD9p?=
 =?us-ascii?Q?SMHGaxhskNZfNvgNmaoxItg67PvRyP5kayJJ6/RLFunnR2Bp7qZ1LqkwRC/m?=
 =?us-ascii?Q?gdLPBye4NlIoLo9LXAx4M0GcGZMt0ahE8NzZNX12QTaR4xkL981uAUch+RKv?=
 =?us-ascii?Q?BD91o0bqesqquTKCJS0aKITV3Rz+3JfAXBHoa4p3oZ5q1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <708A828935568A4786CD6872AE50C6C8@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b5ff3b-61d0-4841-3de3-08dae82594ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 16:15:33.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9023
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Can you file a bug report:
> https://gitlab.freedesktop.org/drm/amd/-/issues/

https://gitlab.freedesktop.org/drm/amd/-/issues/2318

>=20
> What sort of monitor are you using?  It looks to be failing mode validati=
on:
> [drm] Mode Validation Warning: Urgent latency failed validation.
>=20

Well its Apple's 16 inch built in Retina display.

The same is used in models with :-
1. AMD Radeon Pro 5300M with 4GB of GDDR6 memory
2. AMD Radeon Pro 5500M with 4GB of GDDR6 memory
3. AMD Radeon Pro 5500M with 8GB of GDDR6 memory

But these models work perfectly with AMD GPU enabled.=
