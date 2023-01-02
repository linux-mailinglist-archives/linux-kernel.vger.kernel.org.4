Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D765B42A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjABPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjABPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:24:51 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2095.outbound.protection.outlook.com [40.92.103.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0236D95A1;
        Mon,  2 Jan 2023 07:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doLE1T2bDR7c3fPNzLPLveUV03NlxHg4SopQJD5WJt1Es/xMql9PnHtcdW32lWZYSJioaL+pZBO4hQNsqdA8Q7tLm6n31Hpzt22ciUsAR2ftCPb1L+kjXGZOkw9zq2Z+2N0wbySoHQ1LTebDlvf2ZHAXNcr46tUVDro79Z3/WA0OVyA5ZVa59PbKlJ4UT1txXwH5DhWldKd9qMZukmY93kEFUBrXC8rT8v5yJJsAUjBx/xT6EDJRWSBBu76My4PvcnPJ6dfJweFfydjEkETk162yx2KBV8NHwcpsOYraBemD79amZa+ehU3yoANy4yZQkndmjG1PFwnBTY7nio8JJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egmu33RTdji7w17M+js/NXlaNh7YmftonCNH5CUtxQw=;
 b=jC/+YTrQkkIN3wL5hCDppRfjrs8UEAWVeNUdRv6OY1Oln9HyFpB2kX5yrnVieqs3nF+/dIdmzcba1izbY/flTEbyr+LmL7UrqBSsv+UBmnOwrdgTzjV99lKG0F3KQsSdZn+PnsbwRdrzyWDyQZKbkHXIWm4VyWEDNwu41Qa6w6eEIxznJxMb+8qLV3iKICaa/ZfLWWhKw/prXFQgiUn6NhrlCpkNrcGKHBaZRBN+XSdwnvQ9wahKViDWbBjVbGLdWxasrOBQbFla+l/GNz5fzQSo0IXn6wf3z0fRYc0r4NQxVmdH6ZChQRDEAQuUzTEhNhNst3QzpwF7vhLEQPlEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egmu33RTdji7w17M+js/NXlaNh7YmftonCNH5CUtxQw=;
 b=rUdAxgwRXxCCl4Y+slKWqd8fy6Adu7G1pKyfg9yhiYlF1RHPO2wIuFx03lCgZz/+JIQ9iITp6kK9xPEP2BNfUaNrZYgGDZGc2wKzlWHvMYO/WcqkIzDgHeSxxsXos9uudnMDZxRRhCyk+mWuN7V9vDZebKkB6GcDK2+GmJYAb9zvlNaUGl+Bxr0QQcu6hKNyEF3/UpnxGP1jW3bHo4hLKuf4TbHINLT01nICyq6rkgWPcrqpK8wfbBHsJBWY9NDOzoIRi20rx5QfdIsJCst+m9yvdI40h9TyDEPKuWrxfgv5Onar1Oyq5xjw03UAJ/agOeAy/Hh2kFECiXfHPLPYrw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB8979.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 15:24:43 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 15:24:43 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Thread-Topic: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
Thread-Index: AQHZHrgZm9h4SMr74UGao8WWrkuTDa6LPK2AgAACgYA=
Date:   Mon, 2 Jan 2023 15:24:43 +0000
Message-ID: <89F492BA-38A9-4D2F-AD57-AFD8856363A4@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
 <9c5bdb0a-0877-ed16-f09f-164a9dab16d4@marcan.st>
In-Reply-To: <9c5bdb0a-0877-ed16-f09f-164a9dab16d4@marcan.st>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [S1P3IzulK8YV+i4+cGwAFegKsl/jbVD1lxPTS5MtfDKp814bwPHS1pD86mrdxohe]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB8979:EE_
x-ms-office365-filtering-correlation-id: 9c15b230-f802-4f4b-a3a6-08daecd57965
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dvt4/39dxTX5LZoQHxM8NdYGemk/mkRS+/QRAYvn70X+3ku9FK/xPNtWaIjjP8eV+blvgikPjoYez6y+Er0zTlnoOg4ghFC9dqNnwHVC1Q9wT73pyKHkSLuIyaQLikZaKo0yJVPpsllzPgB1iYnN2mNTD44Y26GivkgWFbGrQeEkrpBcBK3qVCu7L5TBPkplFTxjagWFeTnub1MreqcA4aVHIln2l4RgNWR+mRZsMJDaonvshdfLl1fimYCl0NiTVEjJCRG/WTmp6pIt+x1Mvab8HCqpISRvVYMTOA3UDO3W+no9oTUuKJLCaaim1cslsZbBiOjLcdR/7dQaGfP5Fj6DI27h/G/BpRSVvJpHRgvlri5bQGWvyHBU0696OdHGHQpt6zsSPO8Gx8HhnH3mMnPOpb+c9kxJ9xPQklFUWotZDm3OHyoUNb/2i8X7iKG3HZcFJ0hH7JmWXoYUaXQ5zhcR5E+/whyylC9B3G3f8oF+mwkR8mv2TAF+yzhRZH7UnbPTOWYt8FoPj2hHaKSTUypVJI15rwSg8Ddf06YsO8umvv+I2qOT71OjX+J3tJZI6UaYBF7Ao0McpyOo3TJ2AT8vFEk1rKesQ1d8OuKDgEp0y6g2ULvIetyeVWgaQLOOrBEjPyIiJ1YuoDIvxk45dw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y9PqMp6HpCHVx0Ij5LBnlmnFFKtAPomhGs10mXwTMtH6roLsk3i/BY530WH5?=
 =?us-ascii?Q?k5N0RY25D2dfcQN1UulMUMqExv31rdM7hnc7TXCJJ0UNzoOUDIokLHsqDwmf?=
 =?us-ascii?Q?Zmpp5DpiTjU11gTZjMHLMgRMwfB+BBAq5zmzH2I15uO42NPlMbVuAquLCp66?=
 =?us-ascii?Q?T9LRpAI6FQCalQd5hnXUIfujtNoDAVGUzL2Cm0Bza7EFhyymXq2na7qJY7Bv?=
 =?us-ascii?Q?s4wgSTsXcKARmV8PqQoOBodLYUR5FIRLhJnd8E5tbVH1+Xr1xcY9KT9HpBEy?=
 =?us-ascii?Q?871I+a1PofhYPIoMEXSIflCzTWSw5jGhtwBoDFm3/rlH4AaY6OuPshwje28h?=
 =?us-ascii?Q?58KIuWDokHSFsetoldT7J6GxT6VPQB+r/C15srhvTlgUK6cWCK0VFO7VvfOS?=
 =?us-ascii?Q?SMgu+soj0GtqOqxVqI+Klt/w2YYbGjcy0WfS9spE+erZXi08Gi2w44Pw40qm?=
 =?us-ascii?Q?msHDocj2HjbzURQ57+VneOsEYfDAUWaL2zhdnVW23Ux9fpYKi2uOcPGMZ1Xu?=
 =?us-ascii?Q?X4X4bj+79s4CHPb4JyzBHbWylCPD4S2aVqtZKEWFu5mw+61JcbEuEWbRZHEu?=
 =?us-ascii?Q?oLF3O1S0vwcDh5lM4nTv48T0QMZ5SjFaSZjvFTuX4PpvrbaxS7jFPwXviF91?=
 =?us-ascii?Q?U/TV5gw6uyacv2pgfpi5/eujmg6lwhIJLYtJDOdkQlWw75XdByXZocJD3CNM?=
 =?us-ascii?Q?dZvk15g20dU3xfQpM3+qIJZRMS0SPGnZYFXtyjbp2QXt4ieog3+x+EMFo0ie?=
 =?us-ascii?Q?7iRLxNguq6HSMVwcCCbvznw9ttXq5uNJw0Dm13TdOaqgazgIE9CZerMqYqT8?=
 =?us-ascii?Q?G8ujvUjwRugyNaCgx/cRyIqNtscg/h9VVacN6OvOqrGSCPVi51WPZvRl45Ws?=
 =?us-ascii?Q?qQC+TGC8yg4RdYB/P083WRxjTRU0MLLDMM9w7cbXwAiYUf7PSqH/u9VyH6Ww?=
 =?us-ascii?Q?I49E6ptBAWTkq12/RL5emeVdCBnMYad/DAlNXuqX/3EuApxVmUcczngDz3Oi?=
 =?us-ascii?Q?6gegJQLvF8nBTE3HAiDxH6zMH6z8zFQY3Op/uSvJviyM7fdLV9SHVTWuKqR0?=
 =?us-ascii?Q?4uPMSi1DJtwl3y3axQOmJsDauujnYggJK9+poORhr1x87iWJ4eNfNFIelo57?=
 =?us-ascii?Q?EtFhAiytQM99kfDlEkFISYPc1BC/AcsYDlmHwvAmwL79w0ZFoZhpUlPYTOqh?=
 =?us-ascii?Q?FVVdZ4tyBOnfdQeAbHj6KCiPsgwlek3MKGos23yFuZ2eGepABtoZj2mOVHQo?=
 =?us-ascii?Q?vzA+N3xl/XiGHa/tcrOcrduVixPwGYZPhKz3laG2jSXKY0uRhtuE9vkdGvPp?=
 =?us-ascii?Q?i09PW/JQdMlrOiif18X7JV6VJy++CCnMhYzGCKmoNIKmHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB51926FC2D28B47B3A1B004EC437E67@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c15b230-f802-4f4b-a3a6-08daecd57965
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 15:24:43.4771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8979
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I think my reply to Arend flew over your head.

Sorry. I am not that good in English so sometimes do misinterpret things.
>=20
> My point was that I'd rather have the Broadcom/Cypress people actually
> answer my question so we can figure out how to do this *properly*,
> instead of doing "safer-but-dumb" things (like this patch) because we
> just don't have the information to do it properly.
>=20
> - Hector

