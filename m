Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90E687332
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjBBByp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBBByo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:54:44 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76723C287;
        Wed,  1 Feb 2023 17:54:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE7n6RfVKlIuN6cKgZcT90oRcyMJKj+oTUx3K6OsJevs8HpYgtXuPVCO7aklfpFaGlEyV4DgG81VPtgBllByPAiT2l0A1nbNmf6IEzPdVuVI6Vhob6UpHCREkXDNlfn3rb5g3X1K3iT+yFRk2WaDwsC1NR/WcZXp8M996fITpkA3eGEcFYXxTZ3vb6Q4R3fy1Xfnct3fY7qtT+Y5ojOxnYA3k94wiNIK4YdrRjPYGwJ87z6NrAXx/XiHE05igC77eqow6m1STm5YosL4IZfcI0gzLrK0WCb/BFmfHaMVqqDRHiqwM2Yy4O8+9/ySdzLdYYsCb1CMKBAfJ9G9RijtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YAx88bP+6qDwTpthDiGWjcZiebBQVfUHZBcK26d0LU=;
 b=nGC25M2mVHKeouyDztVVav5I+i5HgjAN5cdFhqWc3WB3DLT4ts1RS12VzZgWr9pyQ3ryL105N8IUBiiTXljO8QyN1LJYbihncfUbVHCLykIeuXf2xotzq26BD9evvBm0MMToJ+wJq4OqOJUtmQxRqeEb2gzhaznH368LYtAYz6rc8iRXqHT7fB/nuTykNuAgbibIFg/twS5KXwLLy0yG9S+xoYKZ2Aw0ABq7T/NT5aS9u/JACqEiIyq/qgS4/1fhFYiAKuB2p9IvAJi7kjqujNFYyJ6ZRFicVyMKS4zVUVJDzgkUbxDD4LmT6Y3VpPryf4N6RWXpRekI8LY3zsPjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=irondevice.com; dmarc=pass action=none
 header.from=irondevice.com; dkim=pass header.d=irondevice.com; arc=none
Received: from SLXP216MB0077.KORP216.PROD.OUTLOOK.COM (2603:1096:100:7::23) by
 PS2P216MB1282.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25; Thu, 2 Feb 2023 01:54:40 +0000
Received: from SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
 ([fe80::3d9:7f82:fa73:e727]) by SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
 ([fe80::3d9:7f82:fa73:e727%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 01:54:40 +0000
From:   Ki-Seok Jo <kiseok.jo@irondevice.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Thread-Topic: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303
 binding
Thread-Index: AQHZNj6z/oQKqHubAEaPcBezJAe7N666EYoAgAANx4CAAAs2AIAABPOAgAC2qMA=
Date:   Thu, 2 Feb 2023 01:54:40 +0000
Message-ID: <SLXP216MB00776F066D70DB2F3F77B09E8CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
 <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
 <Y9p+p6wt8WugDBuH@sirena.org.uk>
In-Reply-To: <Y9p+p6wt8WugDBuH@sirena.org.uk>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=irondevice.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SLXP216MB0077:EE_|PS2P216MB1282:EE_
x-ms-office365-filtering-correlation-id: 2cc8de75-e744-47fd-8ecf-08db04c07288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nxEzAn5hXDtQyZIy6Vkm7MoQ5EBVO4o/tvdaHh2VU+H2wXAQVBWN6W0iNTVSkt2rV1GwzGjIRVzH9TYbZD9oThxikcva5YHBPUeOvnHRkiJ1lKfq/2XIezC4beRPE/fuZkkkHoeGa+FLw3y2CLPWZsWumrJd7UXvkrHS71ieBxYxqLs74f+04rvMsxEAUwBq/dKnNJkBLnRpx8JmwKMpuA/EXYSNQRuLqwTJOD2rF77ZwJuHRiZGaKbmPih6V223LbZ4oMVj104/7SefsxyvXpaavUMztucrzwegrz4EAjfzul3eNyMtISEkCh34DU/myr4Drtzg+TKayTU6o4itb4LqsnDgvDNxC52akXvTang9cWPx3z+SkOLdMBTupyWRXTt9Nf0VL4oeP9JRYqO7JLdjBLeJNqKKq12tZ4P2g79bQjXZ0LCk5gqTvWdutX81fT70Ft+zkjbD/fzUavS4VVpAgUBMD5MnPBNy41xAMf90mwZOzzTdhjsdNahLiMAkyZapesDxThqSMgXur6yIIMIOFyb1P38nqd1ZdVmucr5cfExcLPUqZU2KDpAsYZIDUowCQdRuWcYyWKhozRBk4edfQBmkbQuty+CvYmWaN0y1ZNtznFoUX6Pd/lDqz9NbrBGA1rqSBBBlGoRxjxlhjKHpUQtRg2ZcRwlyqgTDn/WH9D7m7Rhv/y6qaxM2R9l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB0077.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(39840400004)(396003)(346002)(451199018)(478600001)(122000001)(110136005)(54906003)(316002)(38100700002)(71200400001)(83380400001)(7696005)(7416002)(6506007)(99936003)(86362001)(5660300002)(2906002)(38070700005)(33656002)(186003)(52536014)(8676002)(26005)(9686003)(4326008)(76116006)(41300700001)(66476007)(66556008)(66946007)(64756008)(8936002)(66446008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VYduGrpM/6iaWRYTP/mcoGo2NpuHnPC0MYtG2iPAs/FIh8K7ET9FiSgTcR7N?=
 =?us-ascii?Q?RB+mYGBNK17mHLVz1IhTYVUtPoV/gbsnArQzWxdzv6faEZ9XOO6LqsdQ92/v?=
 =?us-ascii?Q?MN1K/08KtU3RYsc/CQKIHS76VPUHB8G4JJfeDS9UTnb5tvtWaDls9c//bK3c?=
 =?us-ascii?Q?jP0UruPQjtr/eoiO4ciIOGWb7+UIlCXBLjm5DLSdK8HzgTLcP0qUh8+EF9eW?=
 =?us-ascii?Q?WgaUI11m/hgErEfrMl8YNjludaodOjNci9BB+60pDrpVqw0rtXpoADr8laNV?=
 =?us-ascii?Q?D5xp1G8YW/uyqyHUhYPw1W/MIFJMM/+fLrU72WqT9PM+Oxmyvzcgq76Qy+bD?=
 =?us-ascii?Q?dt8/ufuV4uwTIeRr1zRfJYsRtk6eUL9vauU7EGH6FISDj0O2gLzkcadgE0iS?=
 =?us-ascii?Q?ZoY1SpBQE6rxZr8CVS9NAJey+rfU7Ws5PVLWFPN+vuo9xHXUDLY3EoEpWFtL?=
 =?us-ascii?Q?bqB7iRwfPRp8oJr4KxzbTN4ZrsFAD7S/yqgb+2Z0YV2shQFloNI1ijC8uP+Q?=
 =?us-ascii?Q?ABPfoDsxesooAD2z5+pr4ADXi6aN4O8wZQl/PTq/43/+Nm8EBtRxdGZ+MBAD?=
 =?us-ascii?Q?sE8yujEiNK+l/iOZAWCki/LRUuQS5BzMWMsQ+3qvHZH3Wfs0FuVsazzqBl8O?=
 =?us-ascii?Q?vnzaNy6PC8ihfBNqm8FEB5xPVBjjpAVgjCF8svyqmLDdY69OFMuLjFrXyXiq?=
 =?us-ascii?Q?Z8o/3TjkX0AAtwsjAtjpibvIjZXo91QXNivkl66owHQSu006fhls/5UXAdSD?=
 =?us-ascii?Q?icVJ3YWRbY9v07SQ4gnZSSv1w1Y/KNyMQlz6m5NLTcVQffnJG2onlQIIqwxh?=
 =?us-ascii?Q?9lbjMKOa0cJ4hz66qNu4+VaijpRKRKQU5swiccKDvtp4vO+wobAKmh+JwU0g?=
 =?us-ascii?Q?8WhhNf+iqKLUp2GAzzBR80ZQnkAgYZ+jzUfobEBydRzbTvJ98WnpjVOBeNII?=
 =?us-ascii?Q?ScB44GYi6jzh4PwwWHJeUGlIXf10JGqSV3IC6dU/7PQm11lyBsHI+Srt1+tF?=
 =?us-ascii?Q?XDLwWT83H55nZrwrxSxRpxC8fI+ZCKRmqXp2GPTQd/DRA3oTJRGw40pC9IuB?=
 =?us-ascii?Q?4MAbnwpMnIg4i708ZrLlZ+Nx0gWiccJzd2ixBDO3P3yJezfG8W4inOqeg/0/?=
 =?us-ascii?Q?OYiQe7TgmHhYly8qwFKE1og4MziiRsMPi0CpnxOljjPkk7m0R3vTxQwZZTWH?=
 =?us-ascii?Q?Oyt7t7LO6Vne/60JtgJ/Wxmvjsb2CD0gg3qv0dgg0QXP6E0LFdC7IC6S5Zbp?=
 =?us-ascii?Q?1wGEsQIoKZZgMCXLSNAnfeRi4LUDK2XyEr+q5cSxxw8m3RhtoQfNnbFnCPx5?=
 =?us-ascii?Q?liurLIUjwW+QYpSH5agmRK2jxzAZgnCIucZWVWRX9ouIrn0FjT4kctpZUbyu?=
 =?us-ascii?Q?wg1rgHAQHeRlinPXzqTpaxEWXC14S6ZsnmHeo7s9LnDa/Q71n68PAcyOJ4IQ?=
 =?us-ascii?Q?4CeksdIfCCdlO5f8IedIhL+H/pBU9NHe5CLPAw+aDHIYFdKZDSI9XjQSuVXC?=
 =?us-ascii?Q?ls4FLTf2qdK/Xwc4Fp95XDsZYOFHP5zt9hD65tNHu7tlm9VWXLhBJg5T1kVZ?=
 =?us-ascii?Q?v7C6VxTDwH8ZcthhmSxgI6pbiMD6UE/D19dmTEjb?=
Content-Type: multipart/mixed;
        boundary="_002_SLXP216MB00776F066D70DB2F3F77B09E8CD69SLXP216MB0077KORP_"
MIME-Version: 1.0
X-OriginatorOrg: irondevice.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB0077.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc8de75-e744-47fd-8ecf-08db04c07288
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 01:54:40.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b4849faa-3337-494e-a76a-cb25a3b3d7d1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5KnsCfeR7RUhiIhnP9mSg/Y9dubxSpgIeFx2pcSz7K6QoWM2BsVZTr7xudn+uYpp+RoAS2YFgs9DJQhYoQjXdfUacF6GPRxqfJP3VDrYG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1282
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_SLXP216MB00776F066D70DB2F3F77B09E8CD69SLXP216MB0077KORP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> On Wed, Feb 01, 2023 at 03:43:12PM +0100, Krzysztof Kozlowski wrote:
>=20
> > I tried. I started writing patch to fix few things in this binding and
> > then noticed that it is entirely empty and documents nothing.
>=20
> I really don't see an empty binding as a major problem in and of itself,
> we can always add properties later.  Again, I can't tell what the problem=
s
> you're seeing are.
>=20
> > The trouble is that soon you will send it to Linus and then it becomes
> > the ABI even though no one ever approved or reviewed the actual ABI.
>=20
> So send a patch to delete the property parsing code then, like I say
> removing the entire driver is very much an overraction.  The properties a=
re
> all optional in the code.

Ok. I'm sorry for not checking correctly.
I only reviewed using the full source build and checkpatch.pl.
But I missed the config setting...

So, could I get the information how to test the binding files?
From what I've checked now, using make dt_binding_check, right?

I'll try to read again like submitting-patches.rst and writing-bindings.rst=
.
And then re-write the patch. I'm sorry again for not checking properly.


Thanks Mark and Krzysztof to feedback.

Best Regards,
Kiseok Jo

--_002_SLXP216MB00776F066D70DB2F3F77B09E8CD69SLXP216MB0077KORP_
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: signature.asc
Content-Disposition: attachment; filename="signature.asc"; size=499;
	creation-date="Thu, 02 Feb 2023 01:54:40 GMT";
	modification-date="Thu, 02 Feb 2023 01:54:40 GMT"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBQUJDZ0FkRmlFRXJlWm9xbWRY
R0xXZjRwL3FKTmFMY2wxVWg5QUZBbVBhZnFZQUNna1FKTmFMY2wxVQ0KaDlCNFNRZi9WL3NkTldB
SEFrdGdMbC9UL2R0RktyeDM3UWU5d3hObHNJczVuQ0xEeCtQNEEwNzVMaG1MUUM3Lw0KQ0JSaE1J
alZQbVdvWE12TXorUWNyTDFZWnc0WXVxdCtwTWcwdk94a0t1UVFwbFBMSytzajFPczM2alQrTkxB
Ug0KVlhtdmhoc3kvb2hYdG5UZEQ3dHgrWXljcmxRQncyNVdkL2lNQkt6QlJIb3FqQkZDWVN5SnFL
Y1l0cXh3MmpxUQ0Kd0FveFl1TkppM05JWllIbE9kNHFWTEpUcDh6R21XMDIzTCtNb21oVEZUaW1i
cjk0bnBDVGJ6NDlDalZaOEI1dg0KYTlZSEFLaTNqc0RXcEl6NDVoTHNvNUdRWnZydmJ2UmJzdDN1
OTJkQU4yQ1hTUXBiM21XNzVFRG0rcm4yMVR1Rg0KQU50ZVYrcTVjUG9PMkNUOXpHZEdZQmhGWWU1
cEx3PT0NCj1tRmh6DQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

--_002_SLXP216MB00776F066D70DB2F3F77B09E8CD69SLXP216MB0077KORP_--
