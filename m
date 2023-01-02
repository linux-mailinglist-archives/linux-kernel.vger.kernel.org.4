Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7AF65ADD0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 08:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjABHqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 02:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 02:46:48 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2020.outbound.protection.outlook.com [40.92.102.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BABAF;
        Sun,  1 Jan 2023 23:46:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9njF6cz62kCV+70nAvB6D+bIUzZb1J5sWx/J/ppRGa4Kufjz4HDDqVCMxd65y7ARkjK2iOnPu2rLgXW6BkLkHSPyv1Ys58fOltPJcoWbn3gEiFfl4C1zV7Ne4f/TGctlq5V4Cs+Btq2O6eDzTrv9rOfrbk2Cv+d3T9tP+Bvp1Gi8xcOZvzg53eML8xuDq5G3vHITeTkbSTJ26Uub7j4SZVGxlavM9zQVKAGsN+3hX/donYTmMP5Af9JMm4UmUot9UqXeuk5zyqVvyDneJpUZw+RRwoF2nbZKbrfBXunX5WCO5nxUcQ1VH2nX7JPqpZN8qjw40QVRw3J6O73RAtd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLqmp8WlamHTHwZyc5tRYRrb7qs0L5jW+tpjWn7btBE=;
 b=dJCLgDueI24nUG5HQTJIf4vuBdNlaFF2CjGiS6k2ijKdcvNeH8uVhyNSwS50hKhrizQEvRfpHsVbc9BKLwGv7V4/C2rZAeQMaMaT4zDyKt4WNUe6jPt/EgS6Ba7AWEPh2tfEi1N741qgpv8U918NowfnjIxPd1Efdcz1/6uIqOjE3iFr3UBiG8Krt11kpXLqwJo+3y15shK/RMVuPYjkLIpPE8jragyFx1sBsGAGqziLPOyqBfG0hniTE0HtaUQ/rPi4RpKOhejUHVhlDnxDU3CKc+V9tyet/qyYfbzp8pNDvWrY+IHo5hNPT86boNvgRsEkx8iLNvvxBHMqLGDtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLqmp8WlamHTHwZyc5tRYRrb7qs0L5jW+tpjWn7btBE=;
 b=a6Dsy2nqCoerdHhODT5UvjCi5rhG0/+8IECGl9QCSc+pigEK9SqJhnDnnPZjqDiy5KEVljEbkPOpoPjcDRMpoAZ3Qu+TLKwubZ/YqxNmVhJHpN/x0K55LX4xEjfttHYK1ysVsVl8Us3KODChlkxW+sOMalwisa5Rl7Rh170RSNED/Wb6t/vnvbAs+qb1DgtFQ3HZrM2QdrJezONht/S/tNSykV4k5N3buUz5tFQMZ1m8JtDpjSZaP3qYNNo+l++Mz2L+6punKRDWcFkMbT6Oi7+xR+G9NOs8mRmjaBGO4ECOF9rffe0LJE7vSueJ4LwUUcWxVoCQ1/QomwBbnZ40wA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN0PR01MB5552.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:63::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 07:46:39 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 07:46:39 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "ranky.lin@broadcom.com" <ranky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "marcan@marcan.st" <marcan@marcan.st>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [REGRESSION] Wi-Fi fails to work on BCM4364B2 chips since kernel 6.1
Thread-Topic: [REGRESSION] Wi-Fi fails to work on BCM4364B2 chips since kernel
 6.1
Thread-Index: AQHZHn5ZYiR/LeXaDESiGnD9Ztj3ew==
Date:   Mon, 2 Jan 2023 07:46:39 +0000
Message-ID: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [S0qBGJax/08tnA+IMQjRoOgQe/jBv6/1NalR/Yk+ZTkaJ5lY9htks7riqLbCQu3d]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN0PR01MB5552:EE_
x-ms-office365-filtering-correlation-id: da144f34-a6e6-407d-270c-08daec957ba1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jH3kB0YMJo/8DN/yhrXGCsbDHUfLNlYrVN2YKzNbiGNYbmVDWGqiSHmijXIl6s2Z9dppkThbZBr4apLsYZEkDOqtNK0r+xGvfrGs9gw03MKZvkGAitWO+GeeAWGUrGmvVe7aPL4T4bm5F/AA7tXfxBDJOBzGQbstkD/odmvxE4ZAPLdeKhMhGYkGCAYo7c/HmFgzNb38P3b0X467r/Oh1n5vHMm3HlyAmz2MgBhtl1mNEe9+jswY39DGglmiN2sNhaW6ouMp+GPIj3gr2GqAZz58tybuTvSOm/kG5ebRPN8nLS36aDmr+KiEheeLrQLDeJfbTVUrhydEzH0BIhVRM0TTtWFGYORXvPBZ+D4JwkJHsbknvPKaxbUJz5eqozZRURCdU6S4ovVaw07SpK34L+qxyPXR50pjjGwJbb1CLISHspjZpZXQsjSd5MTY6FKo6EkYfHv3kBHGmFYaPuxsznrJ1+JqwzIsqZSKTSOt1zVo7Ay9XelrdyjrmrhovyvFQIWtJQRYxUawlfUG3nCH/D5hkraYYzGHl2a27riWl/qeHap6961RaGy+Nvd5hOCC3AdzBsWMJ6aPGL8DKuQSNg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iO/QzIoGZBif6NoG+LPh6UuhVwgBkaH0fX+59Vlac/cmjrckAgqzh9xLkwjT?=
 =?us-ascii?Q?sCDX6JqoO0PEXL0szDElzUREXwpPScbNRI1f15LoMOaS2SMn5p75dFDoeHgx?=
 =?us-ascii?Q?5gvPQQMWBq0wa6RdutAMDEusJip/lm64kjAY6iIuQv8m1gFvYOYgk3G6oUbt?=
 =?us-ascii?Q?VFjRuYte0kY9v3i1WhASxvV5oDAaaCuo9Cf10yM/mPtncxxh18uL2J3oVAqT?=
 =?us-ascii?Q?LI60ujoUqkf50GtYTrNyLBpnHB0vz+tFCIAEzx2VWslzEs5MgCOqwpjy6B7G?=
 =?us-ascii?Q?IyEFdKNfx5W+lLyAGenxa2YVG0JgazG+/Eq7xPWNXWL8NQ1nMq0iN2mEpkhT?=
 =?us-ascii?Q?TJJEcJWhLcgozUCeSLTFoayrzqVL8EzD3O5219axp87sx+FMfYUzLsfMYX2K?=
 =?us-ascii?Q?VHsPKBzjd8yG/2gHxppVGcjliCM5uNL2otTu5FuMms9LLp/B8iD7+18NU7an?=
 =?us-ascii?Q?Sffj/sLRJ6uSghLXYvUEtqdgFQsNxTBjkAoCq8BgpbzMjauOXAtB7nDrejsi?=
 =?us-ascii?Q?ABVixpsKu0EiBAvhc22RE0TCvV9f1vg797FC/jrh/+EA/2geT5CuCAiRrmMs?=
 =?us-ascii?Q?KH1cpNk8O9NF3xiGwK1QOsYbKl9WFA9tPSH5h1/ARtHHFR0RuCHzk8pt+34H?=
 =?us-ascii?Q?TxWhxDeQJswUW2oF9M+SJR84dJul3/0HyQE2m31i+cwY4lEBAhyYehY4w+WU?=
 =?us-ascii?Q?S5ylodt/CFYu+wlIbWn6BX3ygW07wG2x5CoKNilq18CSo20ddU7liS7PNQqy?=
 =?us-ascii?Q?n9QvTl3oLe5UYVo51ZK8vokO25B7R/K3mUMGB7Lym9nijcCzEdVLHrfnEifL?=
 =?us-ascii?Q?SlDZsuFpLvdngVJIElpKCjojuaAm9NN5icOxw+qcPJeRoCoKuY417XwnWK8S?=
 =?us-ascii?Q?1mOl37JJoIwKXF135gQpbbgfcjdzXVYCP6+6EBktV0gTcTpAmjj6sLUkNYLd?=
 =?us-ascii?Q?a7FUC9VEvBNLzLb69gkja+gSupOvqR7xeoiVVbV3Zxc8O9ZVaIMDJjnnOyFm?=
 =?us-ascii?Q?VpExTtTIlBCUbI+ACtv8CZnLkrI+SJI+ZfQfavQWLoaI1utcZwCnZcbb+Qfd?=
 =?us-ascii?Q?27iCS0VTZDd0MbMGzoEL4gm/OgmsnpOX24tx6pyiy/o92OqzueimuGWX45EG?=
 =?us-ascii?Q?S1XEOaUEcji2pU8Z52dTkMqanLMdqXkWi/qdlnXqFj7PJ0lW2ymUcQ5yjDJw?=
 =?us-ascii?Q?hV3LOY1MYI5Xi+zMiO7RiQ1YXPLy132qLkvhbYTFcufOEe/3jU9q0EEthqw4?=
 =?us-ascii?Q?zqtc5bzJSjftYYQS8Hj4yEZ+92bLtDsWkXw8aJ+veopsuvwPbs2KLG3E7Iyi?=
 =?us-ascii?Q?ic+EcejnXu+wmXyNHssZWSlSkbWkpcma7avZiZ1ZXTUSxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E6F69AD0FEA754F988B9B111EE9A5FB@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: da144f34-a6e6-407d-270c-08daec957ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 07:46:39.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5552
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 6.1, Wi-Fi is failing to work on Macs with the BCM4364 rev 3 c=
hips and journalctl reports that the firmware has crashed.

The complete journalctl is given here :- https://gist.github.com/AdityaGarg=
8/a25b187e7f1462798de87e048f4840db

This bug has been reported by users of iMac19,1 as well as Macmini8,1.=
