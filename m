Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53956CBB40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC1JkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjC1Jjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:39:47 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3C619C;
        Tue, 28 Mar 2023 02:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST2DARC6q9TIlaGSAlqhNDvcG/154bReRC24ZUFT33wKnD+IAToYsp4lSgocg5SvgtuTAR5kN9tEEa/0SBq7QFvGX5/8s6CH0E7xHcYKXD1cboRwTcrbBQY2BLFo1sbVKiN4U3lds18GUg1iUtDZUZQpSkzo0wD3g591j+Xu2zPKs6SS94BWZhI2WEFOTV3FDY/EV/ZRWzcockHFxKx3P6xyK1gUZs1nJ6TMeJ+nj55eXorFym/gcTPsGPli6L1JjY6j3a2bVGMyCXgQ9hdFk6MhR40gKyFJoAGW83T5sFKALVNHAY3w22smpfNus2iLWUcWhLFfxxPtrZlUWOK2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqnHQP3h0RGkaQfzjAwhjGtSU6JGxmB3YE2JSZoAE/c=;
 b=AMmfCr5ulUFKbYzaz1TSKnDrcTZxipTa78RW5doQzpCph7OAEjTqY9MzDLa7Bovl1iqLmHGyDbkn/zU6242ir9X/wPxkXDIji0+fAf1DyS4QmCP7Ama5t8JkCsXwYnAiLBY/ChcP13El+bnIPXlpVTgSmIGzl2aDN0QnjIui3zoBESfuyjuif/pVULncgPThCwO6EhcKrxHECfGCEuWE74JfDy32zh6lKHEumhfXBohaYJpu0PWeOKqO+hJJwJ0dckxUsFWmqPUYraxQODAzH6a5/lz5iPihDu4N8NtIUt5UHHsAU/6JgYzL28lEAl/bryuEs3ZZsJ2Ss8AR1rDfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqnHQP3h0RGkaQfzjAwhjGtSU6JGxmB3YE2JSZoAE/c=;
 b=SwKWzSg8uWGDXtOqJOsM8BxV3vxjmS9GsfvqgEyVWYIGEf9/A0dNc6oS7UDEVaYjGsSXPnPSHW5l5Ry3uZ9NTOx/rSCKFySDahMF/4h3mDXBFsxVuXDSDdwFNEsDSqw+sZ3nA1vD00G64DDl3UISDhz9dza7K9fSQf4lzL9bscpLYdp7ofGP8HMfwMjIhyFIzCXqw6WEZhLlxviEMXWEyZts5ybgZFqq5NrgTuckJ9jDdTR8zR/FKFqt5Z0eTf/zFJeP9IXWhrvX7S4ZFNsdYB5sKqb//Wkffwf1nbqcI5R8FpXErik5LqQOaH26AN6jOlMgtmy+GJs9alURE35rhQ==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by GV1PR10MB6123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Tue, 28 Mar
 2023 09:39:38 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a5de:aa91:6d51:426e]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a5de:aa91:6d51:426e%2]) with mapi id 15.20.6254.018; Tue, 28 Mar 2023
 09:39:38 +0000
From:   "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Topic: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Index: AQHZXitnsElEVi8SeUyEotrWHWfO2q8KKDUAgAAS5ICABBn0BA==
Date:   Tue, 28 Mar 2023 09:39:38 +0000
Message-ID: <AS1PR10MB5675DC0F58D71A8C82B49B14EB8B9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB56750EFD7BEA779D033A68CBEB849@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <ZB3XaNtVqGtYHHBw@arm.com> <20230324180904.GA28266@willie-the-truck>
In-Reply-To: <20230324180904.GA28266@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-28T09:39:37.487Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|GV1PR10MB6123:EE_
x-ms-office365-filtering-correlation-id: 41dfc1d3-121f-4ca6-6c73-08db2f705922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qifdzfhjQ9Gsj73aWEhAKoKGoH2sPFxJA0qSLhhRHIbtwk95sLN6t+LOtZZ99SVtzE8I54UJQlxw9d7oTJX7M7b9QdHJt878Nmejis/p4SbCb2nRSamZ3tWVeXgPb4mP14YWCyQVCL8d9RvYnMw+F+QM6jLwn/vE1JXb/9W3sEfjAyWlvIPrJHEA5yqhR3vc1p5u45SfEMXOZaOvmnsuPYs/QamhY84Zyhtgka/B+ZsJ7kvyBand5o6mS9ceBYVk86PXjQgMxyv5G1qs/leaqKeUPehMjHRzmqUwRKAz8zSAonK7dsngIEYxhr6mWFjORdvGlObUxD0Ki05yGEJNSEym9UrCcEVTXxqCdEYdrO9jZR/iPq1oKg7LG8k02CujTVGAorg3xEhuG4DUiIu6RD2nlNEMBRDG5zp+TxfNO1IYyIFP5g6pIGh2RiJb3ek3OZN8TNzFmCRtlcQ38GPzP0tiRmkowchjyaMb2JQHmDaSBmxo621gmS8Wwn/6g2cy4IWMmkhMIgIoXJnD3blB6iFjZckrF5LvaIvr/mz+CNMBjhYkKr9pr79t9y4xiWxqi7w04GXOr0HsoFEj5hIPUPJZqYVgTfgbDUCg/vx5DMY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(9686003)(6506007)(41300700001)(55016003)(186003)(966005)(7696005)(71200400001)(478600001)(54906003)(316002)(110136005)(38100700002)(4326008)(64756008)(66476007)(66446008)(2906002)(4744005)(76116006)(66946007)(66556008)(91956017)(8676002)(33656002)(52536014)(86362001)(38070700005)(82960400001)(5660300002)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?mdYb3OwvF6sovYwODOsv2buZDdAnbChD0n1mNtWMJ4umDlR3myfgqwnF6F?=
 =?iso-8859-2?Q?GfzOxU4sBybbyTDp4M7SwzGRWGv8T2cmk6ur5/tY8+tVinO7bxXyk8E71A?=
 =?iso-8859-2?Q?qef6g17XsLzUWqY//+Ko+4RszUATQ+Ob1TYPORE4j4VRyB3QndfzGG29ty?=
 =?iso-8859-2?Q?vU2bXRVZ8h4GsG5h2ZPnIzvkr0Agf7lOqYy/jITrIxhoa0Pp1qlUiBLP29?=
 =?iso-8859-2?Q?unS/2GSzDwZJLuKCZqmEc1UYvX8uEnmX0WzvYPQ8P47E/R8JNOGuNXcBca?=
 =?iso-8859-2?Q?IBxlTTj5klay9QNw+MoLhybigwsZ6x8Z/kqq01F1O5K1aLJ82ZTA5bFcEx?=
 =?iso-8859-2?Q?ryOOB476EFcFsb5jfEbX25j1AJolXyBBVye7Mquu7kBPm9b0IRYccqEByp?=
 =?iso-8859-2?Q?X97uZwq+j+iMe5ue3LqMa7sj+mSHuTSJSTlvQIPdIqLg7VC5sr7cx0z76M?=
 =?iso-8859-2?Q?xst5VQlIWKyZqccGb59GyZJ7M9Vd5khUjZymwTR3PIDsJdwH123TSMQ5FL?=
 =?iso-8859-2?Q?oQMFR7iQL/JumJvfJZCjyfZmF0F2nmDOgEoEtlQS2xTA45rG1FFAsRmMZ2?=
 =?iso-8859-2?Q?gANOpgJ6c7WGjcrMwIm6FucWvhXfOVKuDdLyRM86iKkSdAdz8ilKYdW+eB?=
 =?iso-8859-2?Q?gpC5TSHouXpO//uSHrfnNqQ0KbUWfCCAStjmrls80C0lgRWqip8o4ukHqW?=
 =?iso-8859-2?Q?WDWCWP5DgHEFgN7kXRrvPeKHy1oki8fPfDuuoFtk/S/SU3tNoqxGR/gtCe?=
 =?iso-8859-2?Q?WjfTo7a1GwUnHxuPb8rOtF2b+mmYyrZrPz/oLRx2ffG4i4fFwE4wJnkbQT?=
 =?iso-8859-2?Q?ThV9r2D6QmxfVPAFy29cH7zihMhv4RV/bsUhMoW355Z34b01g6FGB4ce5C?=
 =?iso-8859-2?Q?NxpX9YyJhupncZ76njTzECka44cl03eW+qzxfu4RJHw7DnTjpmGS0/3V4D?=
 =?iso-8859-2?Q?sRBnwUsgv4KFVCsXWaNAbs5GjulZHIUlATaHBWAm+5xFIibkXTP32tm7AS?=
 =?iso-8859-2?Q?kB6ohGaZZl94hwJiXXnyrUV8+6q5WKG+MVzHhGRTxNbOXrZzObED5XwC7Z?=
 =?iso-8859-2?Q?Sxf4YvYOacblTq8Oy/3FJ6qCz2Zeyd7nYxUBt8Afkw0ACNjiLYvPRJyEzk?=
 =?iso-8859-2?Q?khZor/q+TesygXg8MLG7KXCstGcuTL+L6C1HhZs/elnikqyinNyZU52z9u?=
 =?iso-8859-2?Q?9RZuLWNd0i80MTaQ0ZEauqOJCKYPoVg978bcAf1KJb9U+mw8cem7qoO32V?=
 =?iso-8859-2?Q?XSQYobeSDcVZW0TcdXctajYP94hssd4iEy7qDlmUcgOOjTUue1feOvioFb?=
 =?iso-8859-2?Q?iCSjjy2V0bN3G/TreuSNf8GkGSjpcefEl9LZc3fSjs2y5Acp6dklg4KVmA?=
 =?iso-8859-2?Q?4E9etoCJZVxlffde7+PqZHMBBO6A4ET1MO670VYeSosKKK33n2jhjvo2IH?=
 =?iso-8859-2?Q?EZup1fpsnW5JrA3sebtvAs9WgTR2B02TFFf+cF/sXgLn3AibkFXQT9laPP?=
 =?iso-8859-2?Q?nAmksZ7hc02lHvkS1G4eewzPjcgMiF6tXxK6hrICSwgnHtXkl3ls4OmkZY?=
 =?iso-8859-2?Q?PDNHdLODuu4TRegyow74n7zHIVW3LL0QPAZni/Go+GYw1DZpbn2wA5z0Av?=
 =?iso-8859-2?Q?lND/s64Wi7ck7s4k9ytCQ1io+mVZN6HG9r/EDel0MYP8c88zvhqIHmHqAv?=
 =?iso-8859-2?Q?XHz0PflMMnN9J6cwrTA=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dfc1d3-121f-4ca6-6c73-08db2f705922
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 09:39:38.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fFIkn37dY/09pDNo1i/+LjeBne4LmyKrkXOMWFcJo+PMB1QjVjxDtXVAfefoYQI2WBobawdFabZ8H/oaluPpWf95INIdGnnP2Vybb5KJcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6123
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > A longer cpu_relax() here would improve things (on arm64 this function=
=0A=
> > is a no-op) but maybe Thomas or Will have a better idea.=0A=
>=0A=
> I had a pretty gross cpu_relax() implementation using wfe somewhere on=0A=
> LKML, so you could try that if you can dig it up.=0A=
=0A=
Do you mean cpu_relax() implementation from this email [1] from=0A=
Fri, 28 Jul 2017 ?=0A=
=0A=
I tried to rebase it on recent Linux, but it did not even boot for me.=0A=
Only this was printed:=0A=
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]=0A=
[    0=0A=
=0A=
But cpu_relax() implementation from [1] fixes my problem if I use it=0A=
only in irq_finalize_oneshot().=0A=
=0A=
[1] https://lore.kernel.org/lkml/20170728092831.GA24839@arm.com/=0A=
=0A=
Zdenek Bouska=0A=
=0A=
--=0A=
Siemens, s.r.o=0A=
Siemens Advanta Development=
