Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6471D6B4CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCJQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjCJQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:22:18 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2082c.outbound.protection.outlook.com [IPv6:2a01:111:f403:7011::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09A5D74F;
        Fri, 10 Mar 2023 08:18:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOPD4bwonAE8RLWUYeW45nh0RCBBNVfZnY+kVgB7T8LioD8e972gNzYSGChQpNMEVzl+Mfna81n8UnX2iwst/F4ft2kLS17L/8KpweCwimqk+YblU1wo3eJ7Rv6tQTk7Qal78O1mxB8Lo/qpne8t+C+EwvvZA8FXQsD949E7H3AhmczI7hYU0J8qzZ2iI8RqrPSviiZbtoAcS2dFcyV8Lc9hhSopmGsVZ2+3szTg+VA4NqK82Iby/WN6f3iCNq5MBflSHnFpHZJTl2MPJKfv4YS96F2e68nAOl6NsQh+KJkr4e/Na+d4MwvdvGhVyR73j2MBuwJtDz/OIlIQ3vkKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2NtUzhnfFSfq/iZksZZGTVHbYTEaaGj/GVA/5X2di4=;
 b=gBClOtR8BS/ysLbGnT6SUXTDJLsdQWsVwi+UbaV9aGX10EhP+Mq3rnwvOuAe+3RMiC0J+1t1ZDSa6BKgpOdRymGfDQaSlIIZPgvHlzPq9kdcy62XkC3ky9MapER53zlcky8LkNSTL8eVFwQSPn8kj/yuwE8xCGCoM2KM3/qxoFzSeVnIIXbG8QRees7I5QXPUocCBYV31fCeeJSttk6v3TLXnsO1NlLk/EN3Ga7/6bsI4Q9q6Ia3ElHr/UIqKpKCtTCrod7lMUGULA+6BGUW+dq/ICXQB+6CKbEHnHaCqa/9kKMnfVxnqwDJVJP+V885Z7epoQ2AoXKTOBLGj1HPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2NtUzhnfFSfq/iZksZZGTVHbYTEaaGj/GVA/5X2di4=;
 b=s6x31hSDFg+Fca4ZWZGNYb00tr65EeBAg7jhm+5zOk3FX7ebOVSdx0HtPr6rUB3Z289eo4kI2D3RZatE+mEOGIqlkch+dxCrZa7L3M084vyH7Atk1tfALrQgn+eVDK7kQSbf0EOmEzcW6MV6ZhebDZH5UjoGLLz+l2JCzOwnUXk7hEvSoFaDu5+9ceB5oT9PihAE9t6DPXRS4Yx28lv7FIaerYst4g5371Xo3WI5udKOmOnquxzJgrALdm6KSV8pLlJuWxObPCJIkcOrr7mg13no3kJnzF8h2atgadT0Rl4I1hmVrv1q+zLpladaQsWbxZF3yHqhkf7eONRzwDjbwg==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB0427.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:122::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 16:16:12 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::945f:41d7:1db:1fd3]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::945f:41d7:1db:1fd3%9]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 16:16:12 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v5 0/2] Apple Magic Keyboard Backlight
Thread-Topic: [PATCH v5 0/2] Apple Magic Keyboard Backlight
Thread-Index: AQHZRSHQtk/6TmX0P0KgTUJwSEQZ/a70MSkAgAAb1a8=
Date:   Fri, 10 Mar 2023 16:16:11 +0000
Message-ID: <MA0P287MB021727E7ED58C8C74F879CE4B8BA9@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20230220115203.76154-1-orlandoch.dev@gmail.com>
 <nycvar.YFH.7.76.2303101535440.1142@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2303101535440.1142@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Wyomo9HO5vpJDSL+c+fy4adhx+/r9mLF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB0427:EE_
x-ms-office365-filtering-correlation-id: c593cdd9-dba8-4141-90b3-08db2182c3cd
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2l4slyfgnccVVGxqFN9lwy5zqYR9juw08D12j2dljlJZgly7xU/tuiccsYvN6cYVIea8rvatXQRamWzCbEN5RlIpjFiYePtO2r3fK+IHeUI3FRjhpdWA4iie+F4kz5vW0zrDKxnQcjWXcERq7CRd9bkO38Cvk/GjoyazAbBsB8XjiHOUltJMf8CZLFy7jeXPib2bV0rFd3rqGm4F1U2FTTNkrcdo6GxG/ETnuf7N+nUFPMx0GEuN/EQXx+WS6xs7YJPa3Tt8o3nLkBNvnuF4pyI/S743MHCg2FVGOfx7v9RvFrXIWDqTbLFjcExw6fczBYYY4vStdkrWRzIHR4ABWLhomltu0C1/XfOLjVQ9UJyNlkIyKoZhf3j5e88WiP78mQor3BEjZKtjHlMaUsjZ4jPVfuAn6/WO3i7LOAKkCGhp2IqbI/5ZJDFH6rG0zEL6/HNI7B5IJu1E6JxdjmhYPsR8x9uKuMc2xmgoMkc1tdj/GLtHxxhzQqhjA7fuR4I8rurke3TIlYer/HN1R7Fk3rQpqV0XIWNiiALR00n76luKXRwKOUkYwib+3bGABrnqevLhQpms+8hWt0gzy3IF1poZGd6EtioDDnESTSOq3ej9wlj5vXlCcbBQS5tOecv9flrSA6mniXJgjqw6PFxpg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GbzlB4TnSbdn7tOof1aSOvFPNOC+jlxn64aoNklsui08xPyPRJ8o1nva89?=
 =?iso-8859-1?Q?P1HOmIqWxcPb045hK/l1LKZRRpgGni2oTvKvyj03VuUaVxsvt4uVM1eoU+?=
 =?iso-8859-1?Q?M+5y9Sa0IuCKf9twz/r3i8Wi/TODoKr9tv6G2RVjRb0iENjkLEdCItDqoj?=
 =?iso-8859-1?Q?K07lLpPSdJsnDAhxKxCD56+9YO4KtnEytUjrjVrI5j7wsmmc7iqPBJcafB?=
 =?iso-8859-1?Q?aJTz/4kcPjWRBqQRFtH8GAgHhvf0Bs3yWNn1N5IpMp+tR5iKcZ9PnyP7ih?=
 =?iso-8859-1?Q?au6U7iGG7iCNR9F+nZyDN0li49KOucp23e6ma1ZMQje+oCUcn4zGvgV0vB?=
 =?iso-8859-1?Q?7bBmbYyHM8EIJx05QUq/lHmRRzRgCvEAHVWq54yRVAAYQ8i8A0Z9tdlqYI?=
 =?iso-8859-1?Q?BbuFv5PEzqXgx20vJjlhj01UZlJW4ZvlM8W1FN6aSDmhWuAZWHta+dVDKo?=
 =?iso-8859-1?Q?xqGNrKnhSkHNHJ66cLM/CpPfPaLRod/EKSQtBo1CxKLcFxVXTodruhxWFH?=
 =?iso-8859-1?Q?VhmUnKrWyi23orby1z8joJkJ9QhL4Hd+MSj+Ri5nXCzSOdui2EaQ/hUvoe?=
 =?iso-8859-1?Q?LdR0Tj0ppfnvI9xf5plg7htgCF4bIoqgDjYQmVfPj43hlzVi2CuYSNnbbj?=
 =?iso-8859-1?Q?rqMEg3q7N9z1IfbLfCCB3Pb9vhq/35+EpD50LhL3pBWs4xVqoR//OTAT+2?=
 =?iso-8859-1?Q?9KuMa1ofgGKq6US4Ab8UxyL/uRnEQ+8DWmBK58yJm4gVjQeCfKatXnXlI6?=
 =?iso-8859-1?Q?HM4NivOdcdHXWsnVC7vnaFHedA2lcjc3BzfBAtDmhEttsxAyyxZT0bVpTC?=
 =?iso-8859-1?Q?WzOrBfjtuywjEifalMebAbeAclj62Vr8xdi0mynRQ9qW9z1eo9mMFRMZpI?=
 =?iso-8859-1?Q?OUUXuuQhDdsZgA8ATNxPAHIvW3uDKBXi8Ybpc9SQ6fw0xf+pwSgeiXvSuB?=
 =?iso-8859-1?Q?CMvUx6b7IJd6wcvM6+kIH8M9lv1T2f9V/RCPEcyIGtc7BaUFaxiIWsC/Xy?=
 =?iso-8859-1?Q?8RFzTOBkoDOpnysv15EqZBP73lYiGVUk+92aKO5P8HHSrxJ3uIU11iYd6D?=
 =?iso-8859-1?Q?WqVgAFzZhRtB8+af4kUO82R/B0osDhDp+FXHYVn0a6ibqQtMwudLzP5Pe6?=
 =?iso-8859-1?Q?sqyv3+B5+Jbw2UdFt6TmdtTS1O3A+hBbEc6hHH/ekibbTeKLb46y6pzBV7?=
 =?iso-8859-1?Q?u6heQ4CBd3hNTMATGPYHRURKNdkp+TMzeUR8rh74/CBVYHcpuF9MJFpmwa?=
 =?iso-8859-1?Q?qwxqdXC0tnCUnpyK01UjeHWDqxq69iFo0HNPqQMOZ+jmAzG3KIsyNZQ/rn?=
 =?iso-8859-1?Q?bnHCQ3Fwam7UyKgd33BZ+R7JOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c593cdd9-dba8-4141-90b3-08db2182c3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 16:16:11.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0427
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>=20
> thanks for creating the support for backlight.
>=20
> Is there any reason why not to fold all this into existing hid-apple? I=20
> don't think we need separate driver for the backlist, separated from the=
=20
> rest of hid-apple support.
>=20
> Thanks,
>=20
> --=20
> Jiri Kosina
> SUSE Labs
>=20

As far as I know, hid-apple manages the keyboards and trackpads on Macs.

The magic backlight is managed by the touchbar on T2 Macs, so if you wanna =
integrate the driver in some other one, then it should be the to-be-upstrea=
med touchbar driver.

But when we did that, the MacBook Air 2020, the model which has magic backl=
ight, but no touchbar faced issues. lsusb interestingly shows presence of t=
ouch bar backlight even on this model, but backlight is registered at the 0=
th interface on Air, and 1st interface on the Pros. So, the co-author, Kere=
m Karabay suggested using a separate driver.

Although, the authors may give more detailed reason for the same.=
