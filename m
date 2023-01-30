Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1676805B2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjA3FoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3FoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:44:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2097.outbound.protection.outlook.com [40.92.40.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B510265
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ+kumFN84m2wr2eDOyi47mJ2nPl6439JaCQ3U30g8sv5Wh3sISj2+TQKhdS23v4NSyrKGmzky0ToHZmi2xzPhIWM7Njtp9UvqJzucqPphTDKB9HjU/+e5gLvkbth/nlsrHJp4830eHqj3vlv3kesHjxr8eay0OcaCUsFNuFMd025UK3TqmWVqT16fXlxGEet/uf1ICVGyT9XLW4soObSJOykUjZMo2dFauuYoCR/TA8NmVrkIqSr9/yaba5urLo2FBY0RBj61R/U1vUV89Sgtsi2SPBxeAzGt5VHgjymHcwm6qXEeM225ov5nN56ovfMBDFqOX0ETENxL7GMOgvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDJxxfhJIVfHH1Rnvl9w3n+eno3Kfyn2He0dmwiAQXw=;
 b=Kjg4ytZLg1aPwpUtFuWsYDYJ3hkrL92tpYVsuHDBTObeAFecp2JTLbw+C6AubLsdMBXhzt1mQO1NQkfbz0C+12YEtaCYAVelhBXZQFUsnlgxFP/NqijTlho0dO+UYsqbqS1zXChUgCOgk5cp9naM+utfWfJP3BLPUyGKlh5yry32Ih0vr+7vSf0ACHjkXG8eMeSxpBg8kdpedFGVxSm2rhTOpwbPJSx/oih1apLB5s88bEut43GyA9fUKdPge/w2xXB3+VwHT184QOY3pvvKv8mGLYwHoMrU9yp7tVd3EbX9KgzenmMDQUJEpGJbFLAxO91OlO5Xc20WXt/fWans1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDJxxfhJIVfHH1Rnvl9w3n+eno3Kfyn2He0dmwiAQXw=;
 b=btW8jzYfnqumNcS/gY2sXEHmp9zaKrs19CF6bilJFJNa7jOHdS/mVP1JfvVM79Aq62Y/VAlOoR7oFfchxv3FHQxWNAk1EvSiXQivI5OjyzVFcAQdXL3LXPYCrXyujYazbSujGybxrGkbzHnBDWgF5ltbEAUfsRrr4scnujC2dPvkjP0fjoIUM6EohWAysRBTRXhdUTzSLQNv3tpaq2HhVCPJyCASF1N8cABZ8l+WE1/vQ8OodveAcHrGxACRtALUFuj4j/pg6Q9WujFG2eL9yteJyz2BPnpLSTnLMf3f8lmhTG05XO4SNAoeegi55KS8bwH0dFqKmQH0g+1XafL9jw==
Received: from BY5PR19MB3333.namprd19.prod.outlook.com (2603:10b6:a03:188::23)
 by DS7PR19MB6230.namprd19.prod.outlook.com (2603:10b6:8:9a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 05:44:14 +0000
Received: from BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::2f9f:773e:b1da:5087]) by BY5PR19MB3333.namprd19.prod.outlook.com
 ([fe80::2f9f:773e:b1da:5087%4]) with mapi id 15.20.6043.031; Mon, 30 Jan 2023
 05:44:14 +0000
From:   "katiyar26@outlook.com" <katiyar26@outlook.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Mellanox interrupts are not load balanced
Thread-Topic: Mellanox interrupts are not load balanced
Thread-Index: AQHZMjMkUEeiz2tn4ECAxfc0bz4HOq62b/ZKgAABt+CAAAVmYw==
Date:   Mon, 30 Jan 2023 05:44:14 +0000
Message-ID: <BY5PR19MB333362AF364F23C398DC351BA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
References: <BY5PR19MB3333BC15B1D33E89A679D7A7A5CC9@BY5PR19MB3333.namprd19.prod.outlook.com>
 <BY5PR19MB333326E6CB47FA6946DAF7DDA5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
 <BY5PR19MB333337F4EF2491D440453F74A5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB333337F4EF2491D440453F74A5D39@BY5PR19MB3333.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [tbj4r1yat+3t0KUHDN0gX52ZApGjLmS/]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR19MB3333:EE_|DS7PR19MB6230:EE_
x-ms-office365-filtering-correlation-id: dd41cdeb-fca1-4a7c-5637-08db0285057c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XU9Dz/8NZaGIxaTngym3Kw6rIGOyO4+9QNtyPozAdJHfRTqy3dB6R4AKslVvYyCnc3cNw2aTPV8cP0l/sz36Su8S2mWqNw/8iqycqDXJOpwRZZr4QHMavPAWQrgTDXyYBZlyn26TbVRWev56kWnrQtr8Xq30SoqDzKspEeHwOk80O21j4Q2krbDfkoZwkALHu2eJYl1keLbTZXGhhjBzzJTp5neY+rDbfZEkzk8uEbKyKFNwYC+O3gKA7W45eN39gT2Y1z5Zhdd/SFku/M3S1TUiS6nKR45Yu5pe4PYkdWmb54OAyDJsha/ZO0uPHNEukYiDrDu2BCjFBLH7lktkeDdXBghkxi/s5nHEIi2R5+cJQSBKVCVIV/mTaT+kEo8ZUoLrcYOaPB8lLXZ4GXmsiD5ooT3fy4Rean5K3FzoP0fTcv2XWneGZrqGOPRJRGApFo/Vsucvj6S+SJARoyS44lQigS2odg2CqTQoa0ecgwr4Ru/XSJWRymPDVtjr2g2Laduc2997Q9rpOkk1yTcKmfDpuRuzRQ9qtYMzbd987Ob4qT5GXWbz1r5d8Tjp8eqmJBotsi+RMG2NhpqVQ9cIfkCHmwCGuTlEhld9lb+9ymg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FNjZi6OYZngYnJkYjVXgSXYbZtHB6S0JHC0b+lmgC2i/kaVb+z7RUph0pL?=
 =?iso-8859-1?Q?zvSF8j+VHvBANGiXcbCM3+odzr+NwG9b1UPPNJ32zTLC0rxxGnEBtxgJUp?=
 =?iso-8859-1?Q?/E4xV9BDiPKqh2WbmMv6pZUvRZfPnh+FDc9QwCX6ZowaY5fzrnh5YEKtgT?=
 =?iso-8859-1?Q?YQYT83OZlh65UfqsDEVA2M9OuFfYrZnuGJ5xK6+cMVb1rrAHv1yrhzKQyO?=
 =?iso-8859-1?Q?XdTd6DRODH6+bC/8YGMLf6HzCtmGvi8CSHd9vMcnjcPtRazS/04cDoWJn7?=
 =?iso-8859-1?Q?WYI168pV3XwSTt4RAQl7GfzRe3WSZe7newjkos/ZPLDqUA3K5KCA+LDmHq?=
 =?iso-8859-1?Q?o5iR86XSK/1AoSlHlLwNL9N2omXSU7JhMpcXBlMwzNT5OkLtgJ23+mOIui?=
 =?iso-8859-1?Q?ZJ9hVHlq85qPGXCb4RbBaNQ52YPQNMmI7CASIK2HCz3Fy4q+FNBfqw7GGU?=
 =?iso-8859-1?Q?J+RAvLkU4yK0qBkqK/lmMubxFf5g49+7/G6fDgrcCku7oqZsOSn5o0oiEZ?=
 =?iso-8859-1?Q?+XJXBG4RKFJzTjbe8Cudc7S9y7qU2LptbEZ6SBDP5Ze1yAM9lzEqoPad8l?=
 =?iso-8859-1?Q?2q4kmm4OQvn2yK3/Uk6C4YGXIzAYjjtHgetvKFtgZqDSnXMuZv0SDhuknt?=
 =?iso-8859-1?Q?WaSFPJ4KyJimAgPXGNsl8KtZlzMZupxnEqWB+RhXwvtdShp3smaHRBMDko?=
 =?iso-8859-1?Q?qvZ6TIF6GUcPkPBe232jFBkagHvEJ3FElF57S0+S5pD/HEikdrt6N3R6yL?=
 =?iso-8859-1?Q?JUbAxOmNSzeBEl1X4XyB98sQ2r4WbZqgXk6r076BBCalnVKYHfbc7LxqfT?=
 =?iso-8859-1?Q?Nnm1KSQfO86+jLpyY6Kzm8f8yWOjqE3tJz7oY4te/eDRRVfqlVsKHidjjL?=
 =?iso-8859-1?Q?F/IlK9aSe9TeXDPacKSELyML9AW1Ab4aeejpEjTZiYOkmkxuEPxHEkv7oD?=
 =?iso-8859-1?Q?Az8uWDp3wQfvJtsGY1yleUbI4hmC9jlqqkQUQA3rKc8OiC1MqYqd00XWkw?=
 =?iso-8859-1?Q?5Z9Cx1PPBOBxoDjf+MYxOmH9bj+v9ZyRidC9XFfEOkblV1N5QBM52JJ0XP?=
 =?iso-8859-1?Q?wtPby9jFqR5CLMBR57PxoFn7aRNzfdDgWt9RvuT+vzmqzvzrs5svneAPYM?=
 =?iso-8859-1?Q?VUJZXnLRlTyb+6xezwC48YvETrzIP0KIAUpl4kBeIj3t5GEDUvTjnuozvT?=
 =?iso-8859-1?Q?5vgGufsJWto43kvCPtjgBIiXdPIUWXwSEoUvA0SIliOYQvu9WNXFWvT+Rd?=
 =?iso-8859-1?Q?8r598o6QjuRwriLMjd4u+RpSQljzF1/0hrEiQqbF7DF8m0fulIHJ/h/VFh?=
 =?iso-8859-1?Q?wEU9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR19MB3333.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dd41cdeb-fca1-4a7c-5637-08db0285057c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 05:44:14.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6230
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
I am running centos 7.7 VM in azure with Mellanox (mlx5_core) driver for NI=
C. It is running customized 3.10.0-1062.18.1.el7 kernel image with some min=
or changes in net directory. =0A=
=0A=
It has created as many queues and irqs as the number of CPUs in VM but all =
the interrupts are being processed by CPU0 only. Irqbalance service is also=
 running and smp_affinity is set differently for different irqs. I tried se=
tting it manually after stopping the irqbalance service but still all the i=
nterrupts were targeted to CPU0 as can be seen from below output.=0A=
=0A=
> cat /proc/interrupts =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU0=A0=A0=A0=A0=A0=A0 CPU1=A0=A0=A0=A0=A0=
=A0 CPU2=A0=A0=A0=A0=A0=A0 CPU3=A0=A0=A0=A0=A0=A0 CPU4=A0=A0=A0=A0=A0=A0 CP=
U5=A0=A0=A0=A0=A0=A0 CPU6=A0=A0=A0=A0=A0=A0 CPU7=A0=A0=A0=A0=A0=A0 =0A=
=A0 0:=A0=A0=A0=A0=A0=A0 9881=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 timer=0A=
=A0 1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 9=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 i8042=0A=
=A0 3:=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0=A0=A0=A0=A0=A0=A0 25=A0=A0=A0=A0=A0=
=A0=A0=A0 13=A0=A0=A0=A0=A0=A0=A0=A0 19=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=A0=A0=A0=A0 3=A0=A0=A0=A0=A0=A0=A0 8=
56=A0=A0 IO-APIC-edge=A0=A0=A0 =0A=
=A0 4:=A0=A0=A0=A0=A0=A0=A0=A0 68=A0=A0=A0=A0=A0=A0=A0=A0=A0 6=A0=A0=A0=A0=
=A0=A0=A0=A0 25=A0=A0=A0=A0=A0=A0=A0=A0 22=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0=
=A0=A0=A0=A0=A0=A0 10=A0=A0=A0=A0=A0=A0=A0=A0 19=A0=A0=A0=A0=A0=A0=A0 360=
=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 serial=0A=
=A0 8:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 rtc0=0A=
=A0 9:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0 IO-APIC-fasteoi=A0=A0 acpi=0A=
12:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 5=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 i8042=0A=
14:=A0=A0=A0=A0=A0=A0=A0 602=A0=A0=A0=A0=A0=A0=A0 318=A0=A0=A0=A0=A0=A0=A0 =
226=A0=A0=A0=A0=A0=A0=A0 232=A0=A0=A0=A0=A0=A0=A0 278=A0=A0=A0=A0=A0=A0=A0 =
205=A0=A0=A0=A0=A0=A0=A0=A0 69=A0=A0=A0=A0=A0=A0 8917=A0=A0 IO-APIC-edge=A0=
=A0=A0=A0=A0 ata_piix=0A=
15:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 IO-APIC-edge=A0=A0=A0=A0=A0 ata_piix=0A=
24:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_pages_eq@pci:8b76:00:=
02.0=0A=
25:=A0=A0=A0=A0=A0 19694=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_cmd_eq@pci:8b76:00:02.0=0A=
26:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_async_eq@pci:8b76:00:=
02.0=0A=
28:=A0=A0=A0=A0 123648=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp0@pci:8b76:00:02.0=0A=
29:=A0=A0=A0=A0 152455=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp1@pci:8b76:00:02.0=0A=
30:=A0=A0=A0=A0 102308=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp2@pci:8b76:00:02.0=0A=
31:=A0=A0=A0=A0=A0 89403=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp3@pci:8b76:00:02.0=0A=
32:=A0=A0=A0=A0=A0 86793=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp4@pci:8b76:00:02.0=0A=
33:=A0=A0=A0=A0 107817=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp5@pci:8b76:00:02.0=0A=
34:=A0=A0=A0=A0 117091=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp6@pci:8b76:00:02.0=0A=
35:=A0=A0=A0=A0=A0 59714=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp7@pci:8b76:00:02.0=0A=
36:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_pages_eq@pci:83a4:00:=
02.0=0A=
37:=A0=A0=A0=A0=A0 12427=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_cmd_eq@pci:83a4:00:02.0=0A=
38:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_async_eq@pci:83a4:00:=
02.0=0A=
40:=A0=A0=A0=A0=A0 35520=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp0@pci:83a4:00:02.0=0A=
41:=A0=A0=A0=A0=A0=A0=A0 576=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp1@pci:83a4:00:02.0=0A=
42:=A0=A0=A0=A0=A0 34139=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp2@pci:83a4:00:02.0=0A=
43:=A0=A0=A0=A0=A0 19951=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp3@pci:83a4:00:02.0=0A=
44:=A0=A0=A0=A0=A0 41038=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp4@pci:83a4:00:02.0=0A=
45:=A0=A0=A0=A0=A0 36569=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp5@pci:83a4:00:02.0=0A=
46:=A0=A0=A0=A0=A0 42023=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp6@pci:83a4:00:02.0=0A=
47:=A0=A0=A0=A0=A0 12610=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0=A0=A0 PCI-MSI-edge=A0=A0=A0=A0=A0 mlx5_comp7@pci:83a4:00:02.0=0A=
NMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Non-maskable interrupts=0A=
LOC:=A0=A0=A0=A0=A0=A0 1536=A0=A0=A0=A0=A0=A0 1224=A0=A0=A0=A0=A0=A0 1240=
=A0=A0=A0=A0=A0=A0 1107=A0=A0=A0=A0=A0=A0 1299=A0=A0=A0=A0=A0=A0 1379=A0=A0=
=A0=A0=A0=A0 1171=A0=A0=A0=A0=A0=A0 2152=A0=A0 Local timer interrupts=0A=
SPU:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Spurious interrupts=0A=
PMI:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 Performance monitoring interrupts=0A=
IWI:=A0=A0=A0=A0=A0=A0=A0 726=A0=A0=A0=A0=A0=A0=A0 143=A0=A0=A0=A0=A0=A0=A0=
 776=A0=A0=A0=A0=A0=A0=A0 309=A0=A0=A0=A0=A0=A0=A0 780=A0=A0=A0=A0=A0=A0=A0=
 370=A0=A0=A0=A0=A0=A0=A0 748=A0=A0=A0=A0=A0=A0 1047=A0=A0 IRQ work interru=
pts=0A=
RTR:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=A0=A0 APIC ICR read retries=0A=
RES:=A0=A0=A0=A0=A0 59746=A0=A0=A0=A0=A0 34162=A0=A0=A0=A0 150579=A0=A0=A0=
=A0=A0 45146=A0=A0=A0=A0 149421=A0=A0=A0=A0=A0 87954=A0=A0=A0=A0 149095=A0=
=A0=A0=A0=A0 47137=A0=A0 Rescheduling interrupts=0A=
CAL:=A0=A0=A0=A0=A0=A0 2562=A0=A0=A0=A0=A0=A0 2717=A0=A0=A0=A0=A0=A0 2601=
=A0=A0=A0=A0=A0=A0 2590=A0=A0=A0=A0=A0=A0 2577=A0=A0=A0=A0=A0=A0 2649=A0=A0=
=A0=A0=A0=A0 2572=A0=A0=A0=A0=A0=A0 2557=A0=A0 Function call interrupts=0A=
=0A=
Mellanox driver version is :=0A=
version:=A0=A0=A0=A0=A0=A0=A0 5.0-0=0A=
license:=A0=A0=A0=A0=A0=A0=A0 Dual BSD/GPL=0A=
description:=A0=A0=A0 Mellanox 5th generation network adapters (ConnectX se=
ries) core driver=0A=
author:=A0=A0=A0=A0=A0=A0=A0=A0 Eli Cohen <eli@mellanox.com>=0A=
rhelversion:=A0=A0=A0 7.7=0A=
srcversion:=A0=A0=A0=A0 7D9FFD656B0EB1000804CB2=0A=
=0A=
Same kernel with different NIC driver (in AWS) and igb driver in physical s=
erver works fine.=0A=
I tried centos7.9 (3.10.0-1160.76.1.el7) available in Azure market place an=
d there I don't see the issue.=0A=
=0A=
Please help in debugging/resolving this issue.=0A=
=0A=
Please CC to katiyar26@outlook.com while replying.=0A=
=0A=
regards,=0A=
Nitin=
