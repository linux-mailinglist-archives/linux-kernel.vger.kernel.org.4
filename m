Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844BC69B01E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBQQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBQQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:01:46 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2075.outbound.protection.outlook.com [40.92.99.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75036F7C1;
        Fri, 17 Feb 2023 08:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtrx8SV0IeMVH5O2GO8RQ5MnZK+z1eW4LndxQgB/IF7DEkvvHCVS5yeoHKDq/dF/1nQRTcHN5HI57tGa2OFYgSLmScXB8/AFqNImak1pE8higMFdmwXBu14cPmPBgmezC296GI0x+JIevTVBkERBTuYLZBAmWZ1XWMbH8EssozV2ihIR9vO6UbQRstEufFPVwsYMOYDi7vodaiIS6AXYWlaA7aEbvtCfWsMRpGHrS2Au3lxIWOVVo6AQ7q201ketktG0A89npPTTqKl6dZSImE9sxBpCzH7ZiojUZfdx9oADuY5BDHbepLGtc4G9/H16NG+hopqtpBmjcx/ZvVWgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP901/aQQXQO6r00XdO7heurYmzD95nrmWyxctMrILU=;
 b=Be92jto7WTQtdQbB7n+cNa9HtL+ATB3i64QPOZ8/Jh+rs7H/5rd1mPu1M+N+D2zB/V6PAfvWmsb/37f750T+Zbz5NLXqhCYac2wj10uo6dpWi8IFKQNSNYnuVfun8P3j5PmF7JKhWlv2MC07Insj0Y93hga6iH7HnBHB9rIMDcDfW+SKXpdAdUBXYO/QA5CjfkOGhzNTeINidqNO9g5WC+c5JXhS2lK+cwA7fKcPX4AWh39XyGCUNkiue4IKJwIpBVQAX9rXCgxJynBwQ3yZPRW1r6QuTy57AYclmcVpb9j7vgxQUdDzTkmcSY8OeLSdQRAv/TA43k/qBisqylSnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP901/aQQXQO6r00XdO7heurYmzD95nrmWyxctMrILU=;
 b=uBWgNFYFqVgTZCnKLnYzJlt2TiUaK5NWxXG4FOghTiALPBwEZRG0sA2XflH2fAMeEUakTH7UG4f1Z2jpDqRmJrSATHDbGvOV/ax4dOJkmSdielHf7U7soRWqiyzYBBAruIVtQ59INEY0qDZV26y/6R5dY3GIC7bB5SR3KH8r4kLn1roTtiN4r2iqud0AadZJbJlwMBUydoM1ds4hLrCf1+ccvX0IdJkoXKCi7pm6AaRoJqRr2zlK8u11rUmpHPVyM5zbkdUNo76JKjENbemT9xLSuFlS4L9NqOq3j3R8DnWwjn57bqY/zvwnFGB36GVZyS7Hg5CJjWQMtUsmR0UKrg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OS3P286MB1855.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Fri, 17 Feb
 2023 16:01:34 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%8]) with mapi id 15.20.6111.014; Fri, 17 Feb 2023
 16:01:34 +0000
Message-ID: <TY3P286MB26118906837CC416FA56AA0698A19@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sat, 18 Feb 2023 00:01:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To:     Michael Tretter <m.tretter@pengutronix.de>,
        devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        frattaroli.nicolas@gmail.com, heiko@sntech.de,
        jacob-chen@iotwrt.com, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de
References: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
 <TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230217110413.GA28242@pengutronix.de>
 <TY3P286MB2611256E28AF951F2B38A5B098A19@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230217153214.GB28242@pengutronix.de>
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
In-Reply-To: <20230217153214.GB28242@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zZ2mXJdOg6nyxOcH8GlGNn0T"
X-TMN:  [zTVib898QWSqT0OyDHllKbm5WWmLEuv+J8Djao0sDWrUftVZIXyFZju1OKnQOvgf]
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <234646ce-3c1c-f4f2-1a99-0155705bfa1a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db5b664-9425-4c67-9b67-08db11003e04
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ib98Xk9o+5p7ZH25EEZmXD9FDqG6ds+4ryu9z0+xkhRyG9leEl3ASZvlV6O0sTcXW5rbpLQPB28roTfApPm6L6zMq2jbJmEJEuMGt19dAkv+xsMF8DabsZP9y/BeG7KQfulDDim5wV/WFXYQ5xzL81QwcNmOmZaeHEaIy3YyvbedIjmOPYOCWjgEuWP6AEUYxnx8Pwhj1s7WDRGyhq9sVt41ogbRG6csuvUl6irp+TY+SjV3fa0qmQv0QOrj/BApS5eDnqeGNEc6xwsmPbrXDvbiIBFl2FpYkBn5SVvfrtugsnehaoXLPoaO2gHKvbVb6ddh3/F0ygjN1UryfBEII855CfHeJODaS7YvUAv0T6xSjUHcbbdoTcJT1+ScyNwff1Ee2jPZx30KgF4RY2Xqlmzt6RfSDQ4KezrBTAN1hIQoyas9eGQc7FluKWzVoRp3+KF37WwOXVRmmeNOCEek1Kne8yWms3vW4tSGKLzfOu4X798ZlEloqKebfZ0mRNAe04hOUjVR8lUnmYuL+5uEDVLWpR/lGysarfAM/i/beiXTg15DAfb4xLmbBZiRmo/692dRvmvZCRPTY9WK+Z1vmgKhLagrWnVw4rKnfz7ORYP9hLgFspoElT9znMC644YDW8FXHUqsBKynHcWJ7Te7vg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZzdmt0b1BnUExYdUFqNXVHalR3bGQ5VWlIOEVDbHVTMEJoWG92czM5WUhS?=
 =?utf-8?B?MGt2VUdqc3lyZHA2SzlVSUkvWkxRSW11NUZtbXNzUVYrTzkzSWEzMVFkb2xH?=
 =?utf-8?B?RnppcGY4TzM1THVuaHQ1a2w0QlliL2lxSE1MM242dEVqV1p3VXFnV3Y5WXZW?=
 =?utf-8?B?QUxmcVNNMEZlYWErL2ovMW15RGFLWHFQMHRDd29nMUhQd2NDUXQzeUhOQ25G?=
 =?utf-8?B?cFhxWWpHcUJJZ256Rjl1U3NJOFpyRHVPRWVXamUra25NbXd1SHNlMmZsbTJZ?=
 =?utf-8?B?VHZqdkVpUHUyZFdqb00wUjdtYVVrdGlaMm1id29CR21kOUx5Rmk3eUNZQlI5?=
 =?utf-8?B?dllQTXo1dFdINEIwdzVrMENCVFNHOWo4S054ZG9ZelNoNzFZdTdONUZOZW1u?=
 =?utf-8?B?clhoZDN1akx6akF1UmJKWkJTdFIwZG4vVFBMRDc4QU0vR2xodFREa1U2T1lG?=
 =?utf-8?B?eFM2N05CZWpsNlN4UFlHckVyVDdzMjRJTUwwM2tJRWxYVU5sVW5LYUxMYktU?=
 =?utf-8?B?aDlwVVlEZDVuNXpyb3RoQjdpdE9nMy80OU1pZ3BCNjY3Zm43aUNHUHNvcHB5?=
 =?utf-8?B?bEpXalA4MjUrVXlKRXgzMm9USzAzWWc3Q0ZqOVpwVjFrV1d5aG9VL1UzRnJB?=
 =?utf-8?B?eEVPNkk5VUt0V0QweUJZUUZlV0JTVWFiV2tjRGFsVTJZMk1vOEloeG52bS9T?=
 =?utf-8?B?dFRSUGF3Vk5kbHJxNWg0L2hLR3hiVUczVmN6ZUw4L0VjRUtuZjhNQmlqMVg5?=
 =?utf-8?B?L09FdlAvZnhGUG5QS2R0QVovS0hvUENrVzQyWkhTVEJDNUhlS2VQR2tSc2lU?=
 =?utf-8?B?enJoeEtBZ3BSdExtc24xbW9NamVXVmR4YjJmK3Y3Y0N1d1lORWlkcE4raXBG?=
 =?utf-8?B?ZFUxZkpzTWovaFZzOHM4SUk0aml2Z1B4eTlVM3M2MytBd2ZYRk9Wa3dxTnQv?=
 =?utf-8?B?dWlkM3NNQ3JxTDhiUllMZE8yRFRlWlhXTWxYZkRiYWh5TWdqMUdwUkVKelpa?=
 =?utf-8?B?ckc2VFFLMmdiWTkzOTZXT1dHWml2V0lQanJmTEVCWkNNdk96WkJPbmZtMmZH?=
 =?utf-8?B?cWtSVVlTNmc2RHdyeTdRK3ZJNVQ3MVIzV2MwaU5CMVRaWGJLV1hWdjgxM2U3?=
 =?utf-8?B?UFZ3dldyengzZDdnV1ZmSkNZeTh1eGYycW5nOEdTZitoWXYxZ0lnZXFJWmU2?=
 =?utf-8?B?bCtwckVGaC91U3B3SGFSQVMvV1BQZzJNS2p6amg4OWZuUEx5dDRVbGVtdWlp?=
 =?utf-8?B?ZnFzdmx1VW5zYzI1ZUUwYUhXbGw2N2tPV21jdWxFZVRTeHk0VUl4RFlDUzFY?=
 =?utf-8?B?bmY4aWRmMS9vRHlmTk8xallycVV0bmUzS2x6WlkzVmJDdHdSS3djS3d1WFND?=
 =?utf-8?B?RjJOMzRyVFVOc1Yrd1l0dVI1clpUc2E0eEZTTnQ1N2xDN2Ryc1NzcUJRS2Nx?=
 =?utf-8?B?cDNXNXVXQUJGQktwMHY2aTJBS0FRWTdrOHg1bFdGUFR6MHg4dGhHYmpyMUwr?=
 =?utf-8?B?bksxcENIeCt3Zzc0UXR4VVIrYUc5OU5Cb3hOSXpEbVM3VythTUN5RWRxWkJK?=
 =?utf-8?B?UTZzcVVLK25CM05NNCszNmtzbUphbUFWMXlOcnEweStXUFhoSDk0UWs4M3ly?=
 =?utf-8?B?cU5qNDQ3ZndVV282WXdwWXFQSmszZVFwNGRTWEkxeXpCY053MVlkNFA0alY3?=
 =?utf-8?B?ZFEva29BcDBCNlZablhjdTRJNjZlVnpNcklCa2ZiNnRFcmYxNzVLaGpPbTVy?=
 =?utf-8?B?RUFtbjZGdTFxMzhPaFgvS2h2Rmp2QXRRZWpOczMrY2RVQXJLSm5sODlibVN6?=
 =?utf-8?B?VVEzTGZYdVNGR25MQlU2dz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db5b664-9425-4c67-9b67-08db11003e04
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 16:01:34.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1855
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------zZ2mXJdOg6nyxOcH8GlGNn0T
Content-Type: multipart/mixed; boundary="------------P6J5G38TM01ysUzKm8EatSkl";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Michael Tretter <m.tretter@pengutronix.de>, devicetree@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, frattaroli.nicolas@gmail.com,
 heiko@sntech.de, jacob-chen@iotwrt.com, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, mchehab@kernel.org, robh+dt@kernel.org,
 kernel@pengutronix.de
Message-ID: <234646ce-3c1c-f4f2-1a99-0155705bfa1a@outlook.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
References: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
 <TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230217110413.GA28242@pengutronix.de>
 <TY3P286MB2611256E28AF951F2B38A5B098A19@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230217153214.GB28242@pengutronix.de>
In-Reply-To: <20230217153214.GB28242@pengutronix.de>

--------------P6J5G38TM01ysUzKm8EatSkl
Content-Type: multipart/mixed; boundary="------------IcswZKqDa1p3Nw70YKvsUWI9"

--------------IcswZKqDa1p3Nw70YKvsUWI9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksIE1pY2hhZWwsDQoNCj4gSSBkb24ndCB0aGluayB0aGUgR0ZQX0RNQTMyIGZsYWcgd29y
a3Mgd2l0aCBEbWFCdWYgaW1wb3J0LiBUaGUgYnVmZmVyIG1heSBiZQ0KPiBhbGxvY2F0ZWQg
Ynkgc29tZSBvdGhlciBkcml2ZXIgdGhhdCBpcyBhYmxlIHRvIGFkZHJlc3MgbW9yZSB0aGFu
IDRHIGFuZA0KPiBpbXBvcnRlZCBpbnRvIHRoZSBSR0EgZHJpdmVyLiBJbiB0aGlzIGNhc2Us
IGxpbWl0aW5nIHRoZSBhbGxvY2F0aW9ucyBpcyBub3QNCj4gZW5vdWdoLCBidXQgd2Ugd291
bGQgc3RpbGwgbmVlZCBlcnJvciBoYW5kbGluZyBpbiB0aGUgbWFwIGZ1bmN0aW9uIGZvciBi
dWZmZXJzDQo+IHRoYXQgY2Fubm90IGJlIGFkZHJlc3NlZCBieSB0aGUgUkdBLg0KPg0KPiBJ
IGd1ZXNzIHdlIG5lZWQgYm90aCwgYSBsaW1pdCBmb3IgdGhlIGFsbG9jYXRpb24gYW5kIGVy
cm9yIGNoZWNraW5nIGZvciB0aGUNCj4gbWFwLg0KDQpNYXliZSB5b3UgYXJlIHJpZ2h0Li4g
SSBoYXZlbid0IGRpZ2dlZCBpbnRvIHY0bDItbTJtIEFQSSwgc28gSSdtIG5vdCANCnN1cmUg
YWJvdXQNCg0KaXQuIFNlZW1zIHdlIG5lZWQgb3RoZXJzJyBoZWxwLg0KDQpTaGVuZ3l1DQoN
Cg==
--------------IcswZKqDa1p3Nw70YKvsUWI9
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------IcswZKqDa1p3Nw70YKvsUWI9--

--------------P6J5G38TM01ysUzKm8EatSkl--

--------------zZ2mXJdOg6nyxOcH8GlGNn0T
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPvpNAACgkQX75KBAfJ
sRktow//WXw8JVXwCJT4gbKlhWGM+Ch3T2l99GaO+2gEKR+3XDHsuAaaXyNm8z8u
dY+ysDhqKTmMR4AX88uvuXbhDFkn7AMbyoFjBm7p2szIAosZNDj18AafIkhFjuQc
yEljWyrwpyqPVdZ/i9laZnM2QGtQkJXM0CuaFatwXbcbxgMo3hSQYM5FXRUSLf2L
FnMdT/YXPPJw8q22wAfVvKDAKaZp8YYAMiSwdmCN/cE2K2gtulRNgjaB/aEwm3/w
NI+0z3GWUslBwK/m3WdKO3FE7BZ9Sjk96VQ9ezvgluK9CZT0xN1iycn54S3T1BnY
IacjIxDbJIHrGhvWwSC+9Q/MmXkXfF6g5zxf9f7lK8dg6nVTU2sn/xt/3mWCLF7q
+qpZ+OUYuZlkdsrQy4s845eg13XXHBZEe0KKtFW1Rpocf2OCKVZYfqRoyrbP9UKu
kzI+UmPgbKNWhJkUYIq9oFo22MxjLoKvZvQs7eCa5r2pAXjBbE1OqCTr8STP5SGm
/zZ7HHd9glWmFOz+tA9ooACPfqqg1z5DjAbXBY1U0yEo4yZboKEWJ1VdYEB2pLbP
PLGw+qe3DRta+uQ+9Bc12YBjD3EtAaBy2WE37Nz0XJLni5dCg48yaVTLEu75fhQm
fKA6xKNhxoLHOHIdeHh7Ne4v69cE0wPtamoQBawZnMm8RiEGpes=
=7lbU
-----END PGP SIGNATURE-----

--------------zZ2mXJdOg6nyxOcH8GlGNn0T--
