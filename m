Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7274DDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjGJSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGJSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:55:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1325137;
        Mon, 10 Jul 2023 11:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8aokrR3L3nSSqpCFK4VUZn+xxjZ75c/9tGJIS5Rbj5ByLWuVJ3iGAMpBLHgJRf78vKIfgYz/cc2qC8IG3l794CLCsE1bQkhuzKzX/Tl1E2SUTbQQrJ4upC92JA3+Bw4qEeSo8DGC66E81SUnzPnsuItuvQkI+SuftaMAfSpXs5TKSbLryLd8DfA1mrEXlJXTxyQIv/GYhOG/FnC5UnRA9WxXQbz+cCTBodUtpFXuhPbsmQ+OZJ9dbLFedV5f4VFVgJFeqh4C5giK2fwrBMT6RegLoqcf2ZW/wyO3NdAjQmRFakw6jjA/RlWLu/ewNoVU+6ybe0QGnX18yx5TmPXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q5YRDn5H5A3zZSldbHYAEh5jtBe7Qc326nV9lNIbXs=;
 b=ZhVjrccd5MteZbS8mGYJDgwrV0ucWjZsuuKUvYmlTbg2zumqVxonz8Mkm5QoVGUzmbxOaJ/lx6bhmsS2ZJIrifnsE3NJWZlxvuJs3K/dGrbQTFgXcYZ+rNihuxFcURNE5w8oIXn8MqcKUKMXEh84OmdTg5S2y13z3eoVLSwyDYjClXfujXE17F+PKFIWQLHUuOarHY7tToeku+YczTM6GjaSoFWy1qtVFMnjwPMKq5rOTs2uFwhcwMdkzfztkyf26MlIN4DQBGT1gL16T0tAd2UInAsVc0G4Q8lxpDNJWbEA7n6JUjaj04M6VxNB7DEvGQqJDPgcYqgwU2Lzqb3xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q5YRDn5H5A3zZSldbHYAEh5jtBe7Qc326nV9lNIbXs=;
 b=Re5KPaOh3PGbpTWI1K84CEpxnA0/eEX6l7MDGXgp5Nl5mYWd13wN0fv0MyLS2X7Mv+bs5XXc8cC/YhGlsh97JVorhKbnTVyPGagO7MBMdiHXAEEee++6R0rktQVUR5bNvEO0OIKjeVcfn5sq0siWb6htNU6UF8t8NWtII7xPxcpSYq+MTGNwDyrswGgLzX1o1aY+BcA5X9QGgehG1cUnF48UMUQAtEAmOtjtk4pcz4x+FskgOu04cXa925qKurjajpRJpI4Ar92Lue5aEu9/YaHocgQ+qaxcoCuSO6YnDlvYpdEl8mtvkwf27C1XTgKAqQWy7k7Y2TRj2rc+ts1AAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB6522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 18:55:02 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 18:55:02 +0000
Date:   Mon, 10 Jul 2023 20:54:57 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 1/2] watchdog: simatic-ipc-wdt: make IO region access of
 one model muxed
Message-ID: <20230710205457.6894d978@md1za8fc.ad001.siemens.net>
In-Reply-To: <087368d7-15d6-45e2-bd1e-5955bf81d206@roeck-us.net>
References: <20230706154831.19100-1-henning.schild@siemens.com>
        <20230706154831.19100-2-henning.schild@siemens.com>
        <876f6a08-1850-21cd-83d1-b309e7e1e912@roeck-us.net>
        <4a11393d-69bb-8e9d-3bfe-21aa7a7fb1e3@redhat.com>
        <087368d7-15d6-45e2-bd1e-5955bf81d206@roeck-us.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB9PR10MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: c1155e08-82ea-4177-39b6-08db81772a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWXxenQksyIuWRoT+D6i+3B/o9xo9D5pop2ASwlHP13bWFcHXfT/XAzWHMpyK75PCv728tz1amBdM65JyvWxT94dpCu3Mr5rUaghvMssrxsG7r0T7i+HlcffmuEhGK+1dKPKnfgVMwTNZpJaWr9EmV4vTdr+2TFo+F7udUuLYo5gzyZdqB/k2+1tekKTNZPSk7vVcIYt6Wea4a8ptanWWE0cBxkyBXuW6MTh8GqPhMdaqFu16DRXxNf8AEvIJKDcYJLiF2LAX0XHDISTcVUVcFdr4bUD838WobAI2u8CpkYREcdQS1D7a26HiWNMpwcJ/BaeGvcEdE4UhHFWRIxg3ZCZ3PgrtAtCYGNO5hTUzJG6jlRROMmLTSv5dNRwaWDwN8XvSX84Q229y1NZnWeZ3AmXNpT/xRWH8/+Lk37jU5zKhkSDjDWUxwc0JxqgZI9nGnOk4UAJKTMG16ZJocK0sKXdxv8zduIzcZ87gCrBKnoGAVcvUMePChYoJkRWWqFyZ3itxV8MICtKxH2dAs0f14j2bUEz/ei7FAZ6NhorBHy1TTRUZBrXbmFZzIoj3RIZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199021)(186003)(6506007)(53546011)(6512007)(1076003)(107886003)(9686003)(83380400001)(41300700001)(4326008)(6916009)(66556008)(316002)(2906002)(5660300002)(66476007)(8676002)(66946007)(44832011)(8936002)(478600001)(6486002)(6666004)(54906003)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEpSS3ovMGdLVkVWNmI1Q2MvUHRTeU1hdmI2TTNQU28wTTE0QWNNcVlZeUwr?=
 =?utf-8?B?aEsrSWFoQ3h4Y0R1a0pzYTNzNzRTWlZoeVNFaVpKZ3M2c2Foa0ZKZVZHbitX?=
 =?utf-8?B?Tm9aZThpTlQwNFlmZ1Bua1N6amZ1N0hhN1BTTlZUdGZpN1pFNUhncThGZ1Fv?=
 =?utf-8?B?WW1yQXFjQUVFaEtSUG1XYjNKOXlNSHJ2bXF1NzRGVlBMalVCTFp6WEx2cHRT?=
 =?utf-8?B?ZGZUajlrdkIyc3VmdGFYZGZZRjNrM1R5a3kxdWNnQ0Y4b29wUkIxN3FjSlRl?=
 =?utf-8?B?T2E3cmhFN0NoRk9sKzlnUE9ocDF1MWdvWEIyV2FSaC9UdlZCdkdFQUdHOW85?=
 =?utf-8?B?WHNBWWpJL0tYMkljY2xoaGVNUDl3blA3dmVhcG5BTVVTakVNWGZyNUNCejRa?=
 =?utf-8?B?U3FEQ2dINlMyWno4V0hTNDRVcFh2bXFreWhBcm1xSUtBN2pYRFBQQWcxd0pF?=
 =?utf-8?B?ZS9QSSsxazR0VmtCdWw5NWphaWEyV1JKcEFSSDdFVGZxUmpSU0xaZlYxTXJF?=
 =?utf-8?B?RTg3OGRmVENGdGc2LzVxNXZMTTBJSGpGNDlHNVlqNHBMMnQ2bUZhN2VocUpQ?=
 =?utf-8?B?YWNueHAyd0w2Y0hyVEFndEMwZ0Z5RFNqVjdQWFVpVlNSRFl2bDlobUVMY3VK?=
 =?utf-8?B?T1J2ZHp5VkZDUjB3K0l4eU1zdkx0Y0ZjdE05OU9qKzZIUXBDV2ZRdVBTSVF5?=
 =?utf-8?B?SnJZT3V0V0JuejdudVZURHZGbU9DeTFRbm5SNkl3cGcvTVhwRjFhZW5CZ2lv?=
 =?utf-8?B?SEtwdUFqSk5OR2hMWmJGaENtQzJJdlhNNlRQT1MycGp1N1I4bXBDN1ZwODli?=
 =?utf-8?B?Tm52ckUwNUpVQlJ1TlJXVWJLRGxSazJtRU96ZHVnS0ROeW82OHZ6dUt0dnJT?=
 =?utf-8?B?UG9Tak5jNnRSSVdKbjdHczR1MlhJemlrYmYvUm9keW03VXllVko1WEFmemhu?=
 =?utf-8?B?OWhQa1RzSXVVek9NTG9MVm5mUG1XWkZaRXFBYTc1WHE0MXJhZHlMNiswUVhr?=
 =?utf-8?B?Yk10cWR4MW5pUTd4NVF4ZHFyT2VyQXJIRk80cWFMWUlpcjFZOS9jd216YWEx?=
 =?utf-8?B?S1Y1Y2dlSnRHNHlCellIT0dkOG4wRWVNdVNFWkdWM1hJN2FyQ1dwUldpOWhW?=
 =?utf-8?B?ODdMZDJEZDcweU8zdm44RThidGQ4VWpmbjZGSlZSRmVFMDBFcld1ZUhndjFz?=
 =?utf-8?B?cm0ra01DTGUxTDZHUFdwR28xTUFkUGJ5dThmWUtOY1diSzJ3N2NGMG5BTnVV?=
 =?utf-8?B?aXdZVHl3Q09xZVRkWk1Ic1VZMjYxWElyNHJpV1RDZm05bTBFOS9IWVpKNUZG?=
 =?utf-8?B?YURxMW1PNTBaa3o5VUR4aU13ZXM0WWVaMENSRmRCZEhiaERndGNZUmhpaGtj?=
 =?utf-8?B?ZEdydFk3ZmsvT0F4WFBvSGY0eTY3bi9INzRFVUk4RnBvbG5DVE9vWjM0S0RQ?=
 =?utf-8?B?djRhbmRMKzgybTE5SmNmWWJXRXBLdVV1ZlUrdnZRQzVxdWJFL2JRQ2ZteEZQ?=
 =?utf-8?B?dU95OFV4cVpuYUMvRUFVbGtWY1U3WGtZYm1vYm1xN1B0dVV2OW54bXdlY0dN?=
 =?utf-8?B?dUtWYTVBQnUzNFBCNlUxN3dtMTJHY1BrVlNlUzVYeGJpR0IxK09XUjZPRHA0?=
 =?utf-8?B?VTRFQ1JaQVg3c2ZYYnlaaHM1SllZeFlRUWI5bHFDTGZDa29ERWY4QXp4c2JI?=
 =?utf-8?B?VWtDMEVvbXhGak9hNVZpVno1NzhSY29YZ1kxbkN4VzNvYlJKODlJSVlMRjZx?=
 =?utf-8?B?aWRBaGFpcXJjN1kxTzlMRFp1NGk1Ty8xd1ZYdnBGWms2WlN0cWxSVHQ4dEtQ?=
 =?utf-8?B?aURVZ25oRDNiMVp1QmVjT1g2d3djTmUyeXZRV3BkUjFrRFFKN3BFeEhHeEZV?=
 =?utf-8?B?UkJodGoyUjVFNHpmcnovVWJmb3I3ZnQ4MjlNckVPenNrWXBIS3dmVlJGZlNl?=
 =?utf-8?B?TTJXZ1doL0puVjZuUEVUbU1HNm9pa0NrdTRTekJJc1Uyc3ZiMHZWN1NMbVpU?=
 =?utf-8?B?YUY5UnB0RHdsZ0svUjhmTEFFbzIyUElQRWhrSEtwN2ZhYlFEMDBVeXRLci9r?=
 =?utf-8?B?S2tWc3J4QmR0R2pMT2YvTEl2UkJuMlZtQzZ1MUF3bm9WNnR0SDN3QldZUm4v?=
 =?utf-8?B?Rk5mMzI1TUpiK1RNY3FqNWRDdHJMQ2tVUG5YcVA0RStCOENNQ1FwVFU3V0xW?=
 =?utf-8?B?Y1VmQlBOYUJIbHNWR1VBR3EwVGk1QlNLdWRXSjhwZVZPTFhaMmYzaWM2MGpI?=
 =?utf-8?B?YjkzNUIwdHpYVWtqQm80SGJtT2dRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1155e08-82ea-4177-39b6-08db81772a85
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 18:55:01.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31HeOopfnjUznUw7xqFYSBImW2pTc+r+gPuU93Iy3yeKNmqENI09ObDHXxAugaBqIpelXQr6g73l2JIZtzV4hTrN0hb2/cjagGKz+nCTg1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6522
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 10 Jul 2023 06:45:14 -0700
schrieb Guenter Roeck <linux@roeck-us.net>:

> On Mon, Jul 10, 2023 at 03:33:45PM +0200, Hans de Goede wrote:
> > Hi Guenter,
> >=20
> > On 7/6/23 18:03, Guenter Roeck wrote: =20
> > > On 7/6/23 08:48, Henning Schild wrote: =20
> > >> The IO region used for the watchdog also hold CMOS battery
> > >> monitoring information. Make the access muxed so that a hwmon
> > >> driver can use the region as well.
> > >>
> > >> Signed-off-by: Henning Schild <henning.schild@siemens.com> =20
> > >=20
> > > Acked-by: Guenter Roeck <linux@roeck-us.net> =20
> >=20
> > Thank you. Is it ok if I pick up his patch and merge it together
> > with 2/2 through the pdx86 tree ?
> >  =20
>=20
> Yes. That was my assumption.

Thanks guys. Cant believe i made it with v1. Getting better at this ;)

Henning

> Guenter
>=20
> > Regards,
> >=20
> > Hans
> >=20
> >  =20
> > >  =20
> > >> ---
> > >> =C2=A0 drivers/watchdog/simatic-ipc-wdt.c | 9 ++++++---
> > >> =C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/watchdog/simatic-ipc-wdt.c
> > >> b/drivers/watchdog/simatic-ipc-wdt.c index
> > >> 6599695dc672..cdc1a2e15180 100644 ---
> > >> a/drivers/watchdog/simatic-ipc-wdt.c +++
> > >> b/drivers/watchdog/simatic-ipc-wdt.c @@ -155,9 +155,8 @@ static
> > >> int simatic_ipc_wdt_probe(struct platform_device *pdev) switch
> > >> (plat->devmode) { case SIMATIC_IPC_DEVICE_227E:
> > >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!devm_request_region=
(dev,
> > >> gp_status_reg_227e_res.start,
> > >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resource_size(&gp_st=
atus_reg_227e_res),
> > >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBUILD_MODNAME)) {
> > >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D &gp_status_reg_2=
27e_res;
> > >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!request_muxed_regio=
n(res->start,
> > >> resource_size(res), res->name)) { dev_err(dev,
> > >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Unable to register IO resource at %pR=
\n",
> > >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gp_status_reg_227e_res);
> > >> @@ -210,6 +209,10 @@ static int simatic_ipc_wdt_probe(struct
> > >> platform_device *pdev) if (wdd_data.bootstatus)
> > >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(dev,=
 "last reboot caused by watchdog
> > >> reset\n");
> > >> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (plat->devmode =3D=3D SIMATIC_IPC_DEVI=
CE_227E)
> > >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_region(gp_status=
_reg_227e_res.start,
> > >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resource_size(&gp_status_reg_227=
e_res));
> > >> +
> > >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_set_nowayout(&wdd_data, nowa=
yout);
> > >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_stop_on_reboot(&wdd_data);
> > >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_watchdog_register_device(=
dev, &wdd_data); =20
> > >  =20
> >  =20

