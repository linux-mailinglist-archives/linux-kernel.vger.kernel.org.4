Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C8D69931A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjBPL26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBPL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:28:56 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2027.outbound.protection.outlook.com [40.92.98.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092491EBC1;
        Thu, 16 Feb 2023 03:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWI6BtXKxzRmWSz2ehcWN8AUmuw/0+VLIU4M5I+4apxQo5g2ovn//lUx1DBVupK2dta2Oj6T4RVjoFqDSsv22U+UGWX2MXgrLFETdmb4RlPcaFDn8nNqU0dX/zfla0GjzWxYUrcFY6Zu59rTtK/b/y97PrL6OoEP0yLNnCZek+5lJvqFziD/R6sIqps31A/LnzRnUihBiVT1l0Q2aJmchEY+ijLHoJqfrlRDBRoNbeHx3boCOh/90klfDd/pL34VnN94iszunQJT8D7smjugztV/GPOzajcGaJ05jsl4ijodqkAO84ZA0JO9t6dKbhz7pkPL8hUQKBf+424B+lo/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p0tfz1P1IyB7m4x+RvJRM3MeRqQr0a0W06hKvo6Rog=;
 b=XIbiTL8LOIb40zqt016ErIk9vkPVj2rWg1FHLLqlHL+m41tDnUuPqJiA2TAbOY1M9j104g6zH/bsb3L58EWobWja30guuDCUX9dmkC0ozZkbYJ/okWePC8GpqdkVNeGqonb5cOaid0Qlc/ksW9i/ojvwU++/0Ppn4TeKUHDJjlyL9z4T6Syy9PkVwcZvmFdEQvwViZOA89D5JcKjVYywVGdNaV4e1hKs6MReqh5lpP/JhqLQ9Se6tf70Ltidn7HZ7oEbM540of0hRUyNxov6CkrhyyNtzm+s+GYPLzdnlU8hjzMXsC8+OKIyXCnCLG2R7uxPIl4q/afHMG279Nubzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p0tfz1P1IyB7m4x+RvJRM3MeRqQr0a0W06hKvo6Rog=;
 b=VchrYsoxzY31C/DJ9pbSqYKagqFNLpACnnTjlLjft1J8Xy/LrJQp6cB2z5Cf6gg12zmUJ0J7stwv+59rLGJARFf52mzTI7EYSF05OAwutduYw2ldDca3tgJWVWpmC0+jFnB1d0qF1gy2MNOHRvIE9JoB3MpDn+NxJQI2EY0OZEZCTmDoBQGJcl79lCLCoIszu+R85LRqjrSrN7t4oIhplY+RrLSm3AHuVb+O+oyIp2g3POkeHiVIDKxUPBd9kZd2fRBX3O7KqjHSIk06zK3qP09wcWEE8EZLy+NGG9wowZtoRDgEx9CQgMvGJB7/W+rM3GvDp1iDaNMKSzRgJoGq6w==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OS3P286MB2475.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 10:40:06 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%8]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 10:40:06 +0000
Message-ID: <TY3P286MB261159F102FB522F41427B7698A09@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 16 Feb 2023 18:39:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <4bb1e640-475c-8516-2f73-ddfa0a3c23e0@linaro.org> <Y+4F/V0ZJtWJ3290@wendy>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <Y+4F/V0ZJtWJ3290@wendy>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w0ZXW40MMvZ0XiM4NAxD1Wx8"
X-TMN:  [RUnLlWFWj0dVVwVL8JrH4Eku/5cGOaBtQNBD1au6ug7Ug/aV4xDXCAXX2cDSTJK2]
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <ec54970d-27ab-e93a-fbae-a8aef0b0f0a5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2475:EE_
X-MS-Office365-Filtering-Correlation-Id: 07eb654f-fc6a-47d3-7601-08db100a2b16
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6m72rpeuH4E4kFTJQ6QV7MN7YqmGPb4OI5Dd+6HT1ePmDzoeBHqrZcegEPUfYsedGBalWGnbszOWhNscqpfgjiQpF3jlOLrLtiXKxE9kIL3Qh8JKFPwXV3Ct+8xz8oE2h+YR+GQgdoaR3doc68jYBtE8iKpAHNMursHgUomFjnTT0DCnw2FPDSHAv76SkMHXMEF2Wv35MBuo+OtrbaTfauDefiBA6R6b2h4SbwjSb/c5YZInrI9uSPVM84m+u20jUFH1W525MahXjnpTdGpkfk7SAd3axLpKfDIZARGbs4tT6aGwn/Zai4I5gq+69DxHtXQIkQkUJKVWqqLWzYL02zgO0HuAgoCTobFmyx50/lcYFT5iK4sEn8yxqsgp9v6H0wJqHe9U+nZesdG2sbr0NVpsZlUkEsegVCgfmhOVftfF/dqmvHzwHwHE0IETbjtSpLpdGwJRiN0R6vxn+yBJF4Ib+9aJYRVWPMl8Rx92Hg6FNUwSi744n9rPBGlM8wk+/GN8rAZcSAdV3KJK1u+5k2zhbAuiDXdltrI7OIKR1PvCbsCjVIih41wgcWXo7vRL0lC5XfkDyGP9+HQKS7AfBiv/dtJSX5rKqX5xIw3tjqyigLNijOkQSAoZnUW1saltXqGYDSIVGRUG06TqwQdWdg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBBSHNXdmhCSHhKQzROT2hIejJBbGxVVDVtTGZybytvTHFyVmhiYzF3ckJI?=
 =?utf-8?B?aTg1dkpOY1RFZlovWWVxdXNoTHc2S0w2aU5QYjJqYkJVMXJjVUJROUo5U2gv?=
 =?utf-8?B?cm94bUV0VnNPMmJnRW4vRFF3S2hZbXR6VjFzT0UzbUZveXR6K2VKblZuaDJ3?=
 =?utf-8?B?b3pCQVhEMlVzcHZMSTlDelY4RXIydFZwbHFYK2cxYU9MZ0M1bHJWMDRLblAr?=
 =?utf-8?B?YmdtVDNIa0hrbjRUV2hwL0pQSjdUME9ZREh5U2QxSzkwSDI3dU8wM0c2NDZS?=
 =?utf-8?B?WHFORnRuT2M5RkN3M3hXSXprVGlJU2M1R1BSRFAyMGhDcGhWL1d2S3NFbGhO?=
 =?utf-8?B?WEhaQmRFUHR4RTFIcGRDbW05VkhodzhQVXF3eDRBWFZwdmtGUjRab25uZ1Rx?=
 =?utf-8?B?OFpuT3JEekNsRldtTGZ5VnlQSk5taXhrUVVtSjJLakpoWkpYVnJSQXRoMFNL?=
 =?utf-8?B?bmFVeTdoTzN0M2VyL1BZemFhcmJ5T1NJTFBLRW4xZmNBdjVLdGxRT2dQeFZI?=
 =?utf-8?B?Q2VoR0RoNEdYSVhqNklXakUwWjM0bTVTa3YyaXlMT3E2NFZPZ3h0TTVKSUhE?=
 =?utf-8?B?WmhDWUx6NEhNUFAvOUZiQXl3cngzYTBxNGRrSWpWenBTNHFYRE9PZENqeUQw?=
 =?utf-8?B?SktKZ0pvcTNWbnlBOXZkTEZ3cjNOVWR4bUlEdzlnaTJZRldEcDNiZ2llQ0NO?=
 =?utf-8?B?ZURVKytDc3pqS3g5SVhXZlQ3QmZreTZJY3JUZ0NKSjdmMTRHUTlvVmxVN25m?=
 =?utf-8?B?MXhoekhMaEdzMmtVcGVrVWs5VCtyNjJTMzg4T0VqcllneDdyaUQxa29Rd3Yx?=
 =?utf-8?B?Q1BuTFRlOTdTQWdoS1c4dHpUdkVxNXkrSkJvby9KZk5SM0ZsM29lbzNqTEcw?=
 =?utf-8?B?MnJ4SnJrYkwwYUNhV0g0cXoxZHFkNk1McUxHZ2RkYStWUlVrZHR5dUNuQldK?=
 =?utf-8?B?aERJV3NpSHBnSGd6UnB4dllrZ0pZL1Q4dHIvckpVamVHM0tTcGpxUm5tL2Fl?=
 =?utf-8?B?Y3ZUOG5HL1FvWFpCd0o5anhIdzhMNnlkS0RDc1hWTkU4VzdNVHloSWcrdHBC?=
 =?utf-8?B?TGlET1FGZzIrMnQxcjBYd2sxZGJzN1dudzc5dVAzWkJlYjZjR2EzOFRsdjR4?=
 =?utf-8?B?VWF4RW1IWXpZNWRsRHFHaXpscXVDV0thSTJwVW04QW15VWFEeHI4Qnd5Rmhs?=
 =?utf-8?B?NFZzdWEzd2xCU2pkL1p4NmpmZ29STHVMUHN6R0dZSmt5R3N4eVRzaDNsUmdS?=
 =?utf-8?B?ZU5SOE5pd29qZ083cXU4T2tHakUzcWo5clVvWkZQUHVteStwcUorQldsTWtD?=
 =?utf-8?B?Y04wdUk1YkpKWU0rbGRBcENVUUFsUUJ1R2JVOHN4SVJCQ0MxblpSLzVFTUI5?=
 =?utf-8?B?a2J6aUdMZFR1WXQzeWxvcG4wZFduY2RLTktXRmZRM1Q2aUdXZ2VFeVRvS1lM?=
 =?utf-8?B?ZFNna3hkd05VdVZIWkVrT0t2UFRiTno5dEdDMUVpSUZMQVN2cUN6R0dLdkJi?=
 =?utf-8?B?UUNaSXR3SmdPRHVyM214ckVuck42ckN1S2tVV0JIbGViVWFIUWlyZzVsK0ZE?=
 =?utf-8?B?VStJSUl3WnQwTzJhRHp5QW8yNlJSajNSTjNzSHQ4bmhMc2NnQnk5WWJ1c29I?=
 =?utf-8?B?QmxCRyt6Q2huc3pDZ2RKaFJVdmRablF2VjVIY3Q5RS9RSDNEN2tDK2NQclN3?=
 =?utf-8?B?WjE3VkRXckVST0RQM3NIaTZoL0NYOXF2MEtKMFVRY1VMTWVTWjZlblBIbGxV?=
 =?utf-8?B?Q0UvYmwxY0pyZGhsVy9sUzJsL1A4aUU2RjJEOGt2Rzh2TTdrak5Ldmlua0pm?=
 =?utf-8?B?TEFXcHlSUDVUa1dZajVCdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07eb654f-fc6a-47d3-7601-08db100a2b16
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:40:06.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2475
X-OriginatorOrg: outlook.com
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------w0ZXW40MMvZ0XiM4NAxD1Wx8
Content-Type: multipart/mixed; boundary="------------rQVu5g6U8H0l5G3fvXqD0raF";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: William Qiu <william.qiu@starfivetech.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Message-ID: <ec54970d-27ab-e93a-fbae-a8aef0b0f0a5@outlook.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <4bb1e640-475c-8516-2f73-ddfa0a3c23e0@linaro.org> <Y+4F/V0ZJtWJ3290@wendy>
In-Reply-To: <Y+4F/V0ZJtWJ3290@wendy>

--------------rQVu5g6U8H0l5G3fvXqD0raF
Content-Type: multipart/mixed; boundary="------------0bPaHCQyQQ0GEhHnELLyUWdK"

--------------0bPaHCQyQQ0GEhHnELLyUWdK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

PiBPbiBUaHUsIEZlYiAxNiwgMjAyMyBhdCAxMToyMToxNkFNICswMTAwLCBLcnp5c3p0b2Yg
S296bG93c2tpIHdyb3RlOg0KPj4gT24gMTUvMDIvMjAyMyAxMjo1OSwgU2hlbmd5dSBRdSB3
cm90ZToNCj4+PiBIZWxsbyBXaWxsaWFtLA0KPj4+DQo+Pj4gQXJlIHlvdSBzdXJlIGNoYW5n
aW5nIGRyaXZlciBpcyBiZXR0ZXIgdGhhbiBjaGFuZ2luZyB5YW1sIGJpbmRpbmdzPyBBbGwN
Cj4+IFdoYXQgZG8geW91IG1lYW4gLSBjaGFuZ2luZyBkcml2ZXI/IFRoaXMgaXMgbmV3IGRy
aXZlciwgbmV3IGNvZGUsIGlzbid0IGl0Pw0KPiBDaGFuZ2luZyB3LnIudC4gdGhlIHYzIHRo
YXQgd2FzIGFwcGxpZWQgSSBzdXBwb3NlLg0KPiBUaGUgdjMgd2FzIGRyb3BwZWQgYW5kIHBh
dGNoZXMgMSAmIDIgaGVyZSBoYXZlIGJlZW4gYXBwbGllZCBpbnN0ZWFkLCBzbw0KPiB0aGlz
IHJlcXVlc3QgZnJvbSBTaGVuZ3l1IGlzIG1vb3Qgbm93IGFueXdheS4NCj4NCj4gQ2hlZXJz
LA0KPiBDb25vci4NCg0KVGhhdCdzIG15IG1pc3Rha2UuIEkgbWlzdW5kZXJzdG9vZCBjdXJy
ZW50IHNpdHVhdGlvbiA6KA0KDQpCZXN0IHJlZ2FyZHMsDQoNClNoZW5neXUNCg0K
--------------0bPaHCQyQQ0GEhHnELLyUWdK
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------0bPaHCQyQQ0GEhHnELLyUWdK--

--------------rQVu5g6U8H0l5G3fvXqD0raF--

--------------w0ZXW40MMvZ0XiM4NAxD1Wx8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPuB/cACgkQX75KBAfJ
sRlNYg/+OpQsYv0BNyTGsEqBOj56ZW9EhRHGgvVhsvid8pWahTH1U8JURUehK03W
MXpCMJa4EdDUqpKHsIE1C8XNDtpncy+omyfTQo2YN+ze5Mxf2C1Z3D2oGWrWznOm
tL2HCQWU24haPDVfbQa7prFr96hiqkfHaHZ43TNbL07W0BSqnDxvlazYqe/ssQa1
tmjCtlmOhUD1Bj75d73oDZ6y/d/F3fPJMDEt/VVrMh60Dcs8xdAqUSKs56i+1pXJ
ucR5i/ofK9nVYZkc+SLurtDE/50/2AyOrSLgjRHhVbPsLZkAslIk6nt/fe6CF4wg
dOLdEq+BWDalkG8txjngz3UPHTCZKx6Go2sgtSjwA8EpHUbUuyLI1vF+h9QBMaBt
h6WFLeFLmAx0TISTrwRTqxNS99Xa/GQeVSH2dPJLslJrQKiI4wLXAsl7TUAQknnd
O+TQPEhNcV0Z5BMrgeYLH4JWOWBzLEFXOSMScf1/VjMQL8ZIK/7dlAHUHyLhK/dJ
opJa7PIOxGHjQRNMMjoL7n4i0E6N7AQrHXeiJEFtC+w1qwgeu02nOYYUECHRvnKW
YJDXaqGfazGHTTIeDAiAPtbnljHv5/nRC87EOpRfIZ4BO31Ebzs5XBBmuV/F+4al
aFxyp59JthaRnC7jCecpIHSW/S9Op1hw2Ce+KPbjthwmw9Nbyuo=
=vVgs
-----END PGP SIGNATURE-----

--------------w0ZXW40MMvZ0XiM4NAxD1Wx8--
