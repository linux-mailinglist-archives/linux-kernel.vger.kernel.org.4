Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3816469E823
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBUTNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBUTNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:13:33 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2023.outbound.protection.outlook.com [40.92.103.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B57DCDCE;
        Tue, 21 Feb 2023 11:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RofQBWut2LK5YAGJjgr59HnYKwEHpiFXnZppZSFRhGLDdtrY6b8e2WBYi5uggLHh5Cm7jaDSyNZZC11TJPxbYGpOBF0EdGeDLD51MvnM2WGrs7C5dnMzXU95tYeLEW+mbB/aVJ03FAfbVXc1s02UAkOlNPgzmpxFYxYOi77ERU2V9oI7NvMLrkP5z3uPXgZPZskE/sas1iRyZVitqz9LsYPLHXf3K6hAAGaBUa85ABgsxd/SbXsNSXs97bxT1rY6Pb2vUpsN5KdBJvQ/BHbqp/EOIRpQxPPdAjGH1X4tCRC7hj2wicLElG9WAdkHHzGXB+M6QvQUzPPp8Y+KY/I+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwMweFHMnGFr/L34VT1ywOvWyMdpMmPKtUT5+V7qnII=;
 b=RYoZMsZL68kIcnicXCo3nDJ66+cCKC8TShW+hCfJbD9d0pbFkOcVSsA7WFTDeSpJ1HX1dd8PxsGaza0XBXb3b883dYF6D9G5s/tX9NqBb8ijonTy3gnnRDhHsfbLRuQNerbaMpL2zcHpt7Llg90jYDaSGmR1rQUjTeLil4G/fmqD2imyoLi8n/jGhb8NFQQRhzNvWY8fdVS/gloI0i0k4sqcI26ilUXkTK5ebFjVAoPnyCnACp4yRvo48ykS1TVwmR9DniPfte5rPO2J/i57N1DTFk5gN/FmqqrkNyC/0FrdOgktZuk3hxLbNf1YG6CrR/SKa4A5x5OJE8Gu8ii65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwMweFHMnGFr/L34VT1ywOvWyMdpMmPKtUT5+V7qnII=;
 b=CyXhc5WkjzfVVTzMNqp77skrAkZOj/TbYKrZ6lDBbRTBOHpmhvu4l0rSLSbW0QJ4yvvl11havf1JFsOjRUcrMBMO/voZAaADlIIj7ZVt8K9rnDgS/WZodpy++Xy08UXEAvK/osyN+lUBNL6nivfjOyR0+MVQpCLRttXtU9wtwlYBX+3Kb6Uslv3QtHoijTzPEgN1JD2TYk9fVGQxKDsHOxxGGFFZy4PUbo18SYhp60eLBeixkiMTiAAWxRTC/nMA/066RXTRAaYyrbpnhCAjNoEK9y/BZISXViRTW/uBINqxq57IHEwjJlEXsuHt+67AEgFLLao1Jxe0nNRctxSrpw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB7600.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ca::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17; Tue, 21 Feb 2023 19:13:26 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f156:868f:a45b:aeee%11]) with mapi id 15.20.6134.017; Tue, 21 Feb
 2023 19:13:26 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Thread-Topic: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Thread-Index: AQHZRdZPnsOA0zlv+UikzIJmE+f5Ta7ZVTYAgABwQxg=
Date:   Tue, 21 Feb 2023 19:13:26 +0000
Message-ID: <BM1PR01MB09313E8C98F63BD65CCD3362B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB0931B467250831916F7C55B3B8A59@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
 <60dad2c6-9f37-86af-5f37-aa5d45c33afa@redhat.com>
In-Reply-To: <60dad2c6-9f37-86af-5f37-aa5d45c33afa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [h4/XCofWnMwiSCmxJpH3vm+6ey93Kfb6fdxfQPoM/D21oDHWBgbV6GCvJuxlbGpt]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB7600:EE_
x-ms-office365-filtering-correlation-id: 61450ec1-7594-4ab4-2254-08db143fb5b2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rt+Jn+JTUNuKqzamaS2Y7ficaY9i5GJKR2vNuPAqB9fmTCPQUpBtM7IWbNPRVF1hGOrs+JtsO01aZ4NgJ0lxzrOqDGiyw0glGnhjksdmA2aAYo9D9e9h3ShaGkKMQKPLKL23lT0+A5twxib43QwWXJcaGG2cygZAb4iWtoZUbYipEwz8OgdpmbwRY5JMhmc4pVvJd1UAw2MQh6vie1n9FFcG/ovdxL/NbcQcwCTLTv+LSm1NKo32rucYyX5wRF76W/TDrvinlFbni7lfpuPs59cGfJ8sM9n0GbFpvRjlf60RXMU+Vj2jV1DkGLxGPMlzZmEQaCvL82nYZGWMuRCEEpvsMCzx7zV3FZs/35lPmLYgMbRucxODUGeraF87WIO432u5zRFGX0Ve2OGevpl76I0ccfuzGjaxrw4z7sSZKiNZndXaC1miDQV1bpyRHsZqyWeokkP/HJn1dYfAwogc5a2FIMt5DBE+zu2JYhnvnZkJOKFaht4vcLQ+DVkZvn0pl1ipQjsH5wTJf71nemKW5GEg5gl6649ItedyauteFajVH06EqcF5QZfIfiW2v/AJBP3Qs9JCubcVvDNIcDff7ZNA6BxagKSs4aF3yYECupcYoaJDlBeUfxWYAN9jQnOWznfquhFJZXQJdJ5uuZZTug==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TbWqmL3Ht76VvThsT8P98fNGcMRB30/SuR3RCD4VmS8jNhxYDdrGq1VNbaE?=
 =?us-ascii?Q?Hyk4/JEi8auP6SmjNnD6koVunlEFJsKeUm1L+iyJ+Ys3NPgrjhREDBkpHVh8?=
 =?us-ascii?Q?9vf2rN6gRxkb2iYDyk47AUVpzmQEJv0RntupCCpgKL0Vb2FBF9NTqrOCeXB2?=
 =?us-ascii?Q?APVG3Eim8Y98Z8FTsgsLapose0iLOvXIDukWawiK9nVvh6kHdXEs2DiTJnw/?=
 =?us-ascii?Q?BL3Fy5smR43LhoS/8iPUKZhSolUyDCTPc/rQtnatyMsx2wUysCPM0VlrU74W?=
 =?us-ascii?Q?E0fpMxYbkyOMciSDclLVk7Vqml+jS4Sj8UPOW83BvLqzbhUiy7lPaQqe9Q5v?=
 =?us-ascii?Q?KxdkUVTt6jJx+kitzNFhX8ZGi/PxvuznkcIy6zJRFDrML4jHdDq0cQyymjJ1?=
 =?us-ascii?Q?7yWozMlLJ5NuaIOlMbt5E7sA8BA/pK5Q2ggJdN4GonIWJfmf5dTcu9noi6o6?=
 =?us-ascii?Q?AxxseCQHE/rDQID4yUWiqHP51Zn4Lak4BEDBW+S24U1si0mIlTFXM/VdkFAz?=
 =?us-ascii?Q?e8QeSUqoUPaRenayqw+KUI627d9eOqECSxE+WDe/hwzUUBOpA7N0u1qpl6j0?=
 =?us-ascii?Q?+4nPe7xHalQY4Lnum8WcP34X9CAKJHGF5hFXsH/rajIeZemQ2O4KdnKje2y/?=
 =?us-ascii?Q?EAaSTGLoSDLeam/V8KpFR5uc3jc7AlLH+zwe9qY71Ugtk0mk76P9vYpJnl6v?=
 =?us-ascii?Q?aOs9im8y7g8SBuA4fpVsEP9KG2bvmJPKjqzbwaZdkpISX7qL+9qdgL0GRqTc?=
 =?us-ascii?Q?dpzgxjHxPOQ3xn7485X4F98aAe9yBu7erx7fh7tpL8Cvu/YZ5UU5PqZgHmGh?=
 =?us-ascii?Q?r2Sdi8pR2D8/76cUY86i4+/cBiMYNqozRC2As9hX0bRJNgedqZEOxpQuNOMq?=
 =?us-ascii?Q?OJCas7rCHg34fsASSQ36MhxOSLASNenISksut3xXSpRyURYgnzZPwajfBcEL?=
 =?us-ascii?Q?ZQB9S88YfJAevUUv5x7CpAcGMEpIqGRm5VfFZTHapYKqmp3IejeOe9BC7V3H?=
 =?us-ascii?Q?TCXxiHQNAJ/5hIbr4D/tTQpskG90P828/gqm9qnhhWgEFBr4pZoHk+wnEDbo?=
 =?us-ascii?Q?w9NjZJ0gEFvkp5HQEs7U8xuqb9WQ66MODTcohmC21CC2oJ7RfvELAIuPS5Zj?=
 =?us-ascii?Q?ufj0YW4Z+o7BSH2o1NvuO94u47mkf33R6f3b0Ej8gdzrHKvo1MyAh6j68AIc?=
 =?us-ascii?Q?T4mZg9BJ+lFCt8KSRZT18XtRTqp/FMWnma9L6E4oO84lax1Lkgu8RTL2MwlV?=
 =?us-ascii?Q?uRrmhVAlDO/HCftxXNM/xlfndeKB+UVpPbBZHK3H1ekygkv+sgWlQoFF+n/7?=
 =?us-ascii?Q?cLo9BRcf30qXII5xIWZJnow9jrzYYHsbcLIcME4vmTHPgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 61450ec1-7594-4ab4-2254-08db143fb5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 19:13:26.6590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7600
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Currently the backlight registration in apple-gmux.c is unconditional
> (if a GMUX is detected).
>=20
> I have attached a patch to make it honor the acpi_backlight=3Dxxx
> kernel commandline option like most other x86/ACPI backlight drivers
> do, please give this a test.
>=20
> Regards,
>=20
> Hans
>=20

Also, another issue, I have pluymouth enabled with FRAMEBUFFER=3Dy. After u=
sing the gmux patches, the size of the theme has become too tiny for an ini=
tial few seconds, then it gets normal. I tested this by compiling a kernel =
without these patches, and the bug got fixed. I also tried using acpi backl=
ight using command line (that made me discover the `acpi_backlight=3Dvideo`=
 not working bug). Is that also related to some upstream bug?=
