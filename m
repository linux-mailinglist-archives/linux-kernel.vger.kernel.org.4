Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A65740CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjF1J0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:26:43 -0400
Received: from mail-vi1eur05olkn2105.outbound.protection.outlook.com ([40.92.90.105]:60681
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234984AbjF1JVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG4FsRHyF4yhE1GcJVnYD+uqMe1tFFy6PoPblmHEt1fCfDkmZqxtcGuqAMeAP/caCw6QbltEMjUJsD3EpV3H8Mrq8+jk8YsVL89Crtoy1QByw7wuwvY1k2rrylCHaZ8bnbT6SaiLw0lxsA54BFK5PGrdDiPb9XhrEBizW5tXJ4jxjqNH4iHfdKjAqrbZufwPrcyn69HnJZGzspMFrI1Vn2Vo5u/T4pokGVlxFUMxk4thKzHh6yaXPOuHR6/LaYpD0cpBeE9tNdH2DCSfOnqxkYtGe/2wOz51SyxvsmseH2Td3rHzoXfitbAMamsNyaWbV2PMk7nnIG3JjnRkIx5v/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEI18wTuNzoj9j2pj92Mi3+1i/m/T/94NAFS+DVIJpY=;
 b=dGhy2Bw3tnZE2e+yCltLvwEIUYxPnAQjScP4HAE34imMztBvzXNBxVaMZNL6tRPkSM8U4s/kea74GZpcG1BhL4PLdSKXy1yfq/SByVzsbE3LYZ2D4kFXdkGlqlRzBQn8Pn6h5ZhwbTU/QWBEErp6AgffbRsGSjrxplhaBGOyQdmLpp38Z28gEg7yN7o/JGPprRAC4jaT5+61q4ftl7ZRK99HULfmv61uw1qcxm715y6i8ol2eRCBASLTfvJOsWIVJgLSHi+m4gEvi/T2sViDWaKaKyHlqArUkuF4a8kp10LitRb9sW4Dsn3b7jsiae3BdjGcpPdD2Z6EtAuV+OzNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEI18wTuNzoj9j2pj92Mi3+1i/m/T/94NAFS+DVIJpY=;
 b=F02PVFFToyaJk3AzorEQ9oCrj8T+M2XSltup7hZYIElT/m3BBXRn54V59ceK9lcTR8TOxW6eVApB94TD6itRPobK7+8/+s6n1prjr8+JtKKpCb2SEeqFN58jKvp6oPfce5OF7bfi0hnp8+4jYgPkiWY2Mmo9mtccrfODYJ6mUdE0CebApRZ39LP3BJCafdq+4orqdexM/FFmYA1m/LODUpQG4OWhPcdxjgpzhjWDE6mdnxNU1DWxBO/PB2CqEAazos5/gbP9C4YexJqEVUBaBqQXa3QuI3uKl0GuoFxGXdaaAwqWJvbmfUZzkNxSDnyxIAdUIoL0xgKgTmbtx75sEg==
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:323::12)
 by AS8P192MB2260.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:628::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 09:21:28 +0000
Received: from PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::dbfc:6761:1748:b4d6]) by PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
 ([fe80::dbfc:6761:1748:b4d6%4]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:21:28 +0000
From:   =?iso-8859-1?Q?Ywe_C=E6rlyn?= <ywec4rlyn@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: EIN X (OS Philosophy perfected)
Thread-Topic: EIN X (OS Philosophy perfected)
Thread-Index: AQHZqXf/wYI7NwnaQkeYxuL0KSIUIq+f8Anx
Date:   Wed, 28 Jun 2023 09:21:28 +0000
Message-ID: <PAVP192MB21350326E54AE0A0D6B6F612E924A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
References: <PAVP192MB213538D278341020BA2F10C6E924A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <PAVP192MB213538D278341020BA2F10C6E924A@PAVP192MB2135.EURP192.PROD.OUTLOOK.COM>
Accept-Language: nb-NO, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [KNMklvjq8c5N1oGiIVycikcFOcTmiXsg]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVP192MB2135:EE_|AS8P192MB2260:EE_
x-ms-office365-filtering-correlation-id: f97adaa0-d6de-4c3c-9538-08db77b90d75
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgesZgqbGnfXwrUdDk0lgR4ADOXc0JFVheZBj9hNSykcDTu+eAw/Ip8JoWgpo23R1b0Kq0TjwR5CZzToBtx6z/i/Xipnn2xm4zM0ftec37uOsIcgChViNGLmwQm8G7b9o6H7Dj7iC+u2jJRJNajR03ydhcB1vRtXJWifl1qZigZVV0SxGfuQK0BRHSTcEThHKH1u90aTBlggjKb6VKyfVxkpecfkj+5vPOLgN23hn7V9AqJtJ1Dzm4l9bRnJ2EDm9V1tvkaXEdm4kyWWTa7gI0uDjhANXMOo1T0GLfQCV2YTNZm+JOrS2EnOYt6zvEJmmH9njDhvIOo6tcX6Ki2wiV/5MArxSAhR7OuzrLhINpNo9OPDeqhij5voL5Pe0gM0DHzOWY65eN7xFN6b4EHlSBExx9SCEQUL1jHN3EutMb+u1eHpVmDcHVHF6/naVjjiZ0bTo6y+FPJe+/PYKHpYUvGX8bTuNJ/nZCitzTfJZHMWGkbtOA5Z50oqKL5mTjwyJYwLk0LGKJrJzj+0zALArBYPBQsepjVyE498A8ximAp7dYdOITOgVp6s5GzZHETR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c6qohNUPMkdoccfFaK2FPyBz28pCh+6F4tWCGoQ+B5108hhLFlIq/3wnja?=
 =?iso-8859-1?Q?L0+hZvPMCHSchT5nU3RdifjuPE6oR9usGZ6KENSYLMerDhh19Hf4CeAi4i?=
 =?iso-8859-1?Q?7xjWDjjzY2y7Bpc5xDeXxKLxvYI94y3ycBDjPHLbUIY3FVsqKhqxMd/da3?=
 =?iso-8859-1?Q?xkYPLFAaX1wgChL1fBn6YfJrNG4Ei7rXAVTewS0GqZKq4soW1j62m/p6ad?=
 =?iso-8859-1?Q?mHkHpwaveVnisgDCF6oZZX2bLquDiqcItPGyfuk+Xxey9B1h8JgbhaTMXf?=
 =?iso-8859-1?Q?GkeY3BXi84HI187n9aw188u3ltXp9H17f14C0BYz3TxUqKrx8RDK78iFlL?=
 =?iso-8859-1?Q?MA+YDqUgi6N7XE8nNg+a+BnjAutdDtALv3dv5DbXKAFUruJru6E1tTdAgG?=
 =?iso-8859-1?Q?spmSkPIb0pugSQT1ncCh4vlaNUZ7LWmN0iq302tM97C0IZir0TuH6ONlSk?=
 =?iso-8859-1?Q?pGHQUj9upymoUPPpKF5H7sJkLOgrVaYB7j2ojBZYI44a8wnrVdGmS0Vdp9?=
 =?iso-8859-1?Q?uMbz0IPogRh5HQBiOY/oNMY0S0TPbDjXzrGr1fe5KZnRqdClwnQeYjNSzm?=
 =?iso-8859-1?Q?jk+qFZBAvQ0UfDh/lhHi5qtKBNF6U8KvkMXBI3sn9YrJ//Q/OTn1fqVyil?=
 =?iso-8859-1?Q?YUAT/GEnQhqmKj0Mt/HEDxDR+o0X6vFUHikmrZ5gLNlYKjXPUlWTp4RJ1m?=
 =?iso-8859-1?Q?LQ0eCNXeYSJHq+e0us6CLLKbohBxDTdpGy6FfCGIseGuO0i/dyKr05FzLV?=
 =?iso-8859-1?Q?jHISuJif5sO1JWpKrDpaDjKiOWpUP59ANNK664YA/s6P9Tq1BaxscPuheu?=
 =?iso-8859-1?Q?bbOA2G0La028Bu/XZ8IXq/mn5nEsToQ5Z5xoydRUICwKAIPhYAnLkEfY1X?=
 =?iso-8859-1?Q?Pyz9AFDn2W5xrZMAHnJSXFmJCcd+1dHi5Cc8jrCnaOvVmP1s7O1J5xVOQC?=
 =?iso-8859-1?Q?vMkazhT09v3oTSUBSQwv3qLCmFQQ2PQ1tYvmrHmhRxkDaEs+itBpTip5tV?=
 =?iso-8859-1?Q?zA8cw34rB+7J4bpyLNyT5YH77/ZrjOZSQ5VaOFXZkHze9fgTpMgyyJNYPi?=
 =?iso-8859-1?Q?vEPsku0mjH2kIZlfXVqpbePg3qRJoO+DW9+4EASG4jVgPb1xq74SyBdaC8?=
 =?iso-8859-1?Q?+Uc7tielemOADMPhDBD8+lhc5tNC2krPdpmoQA3OAT3RAvus23eU4T4rZ2?=
 =?iso-8859-1?Q?bdCBQpB8crVLRogHIPH57KViEaaqHVmA6SAX0Q4bYqmmAGy+ihVXrDFQFm?=
 =?iso-8859-1?Q?L6Fk0QZL+haj5PzmS8YQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVP192MB2135.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f97adaa0-d6de-4c3c-9538-08db77b90d75
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 09:21:28.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2260
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many feel that God, and the Bible, has too many regressions to be used in r=
eal life philosophy. That is why I suggest a correct latinization of the Qu=
ranic god instead, and the quranic initials hints at this being Ein. This g=
ives us a background from The Quran, which is perfected and intact, with fa=
ir pay principles. Deal Justly, as The Quran would say. For a big scope suc=
h as an OS project, a name like EIN X, is suitable. And correct latinizatio=
n is important, or else one might aswell have jokes as Superman has become =
for Yah.=0A=
=0A=
And so I suggest this as the step forward for the open source OS. And reall=
y the concepts Unix and Linux, suggests the same. And also a less strict st=
ance on source being open, for user space applications.=0A=
=0A=
Peace.=0A=
Ywe C=E6rlyn.=0A=
