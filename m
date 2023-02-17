Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8069ADCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBQOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBQOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:20:10 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn20818.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::818])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C74BDD9;
        Fri, 17 Feb 2023 06:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNnPYhgoJu/XgYh0nP9jn4DFtP5LpYfOrzUUtVL/76wddUQGe8jRnSl3VcVLWwdpBH3zGnLNhZgsYlvgru/usazh+Asb56fZ0DLOeu0Viqe6DyCRREfL541dmsi04qz8/J1yQB/eGyv6xDDCwStUW4FzOyJaleZiRY/HBxDpwKsmB47reoIWB3JHAq3gVXRdLbyoU3FSJH7nBOLr/PZvOWvJVQovPKhlwM7Hp+GpwL5tNHw86+FQn+BuO7ofwKXy2tJZXaW8qH+QpG1nR+rqKkInjudMEngx87IKpQH0Rw1jjSapCVivb9rhN/kjmwfy6F8ytXBtLygMic4PuC60fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn+hnj0UhXOndDhKg3at8Ck3yIuePUsOMHHDNC92gvo=;
 b=nk9eQ5tqluYxN4Ryj93NRMeB4v1LWsXPmFJWIjssDB9kpnsX5NCD4kULwOcXc9NrjzkLS/+X9OZ6bTMDE3FzIKszBXcAAmQjIdl9hbv3Y42iJS9afrroT+T7L1KnT2GKRjDAgjzkFkfmf/GKalaKL3tVuewqtBvNX3qArvTN/aoMoghhY6FBCeuGnsKtblmwjPmhuc/dIs0BJa44w4mgW5fp4ydSJWzaI58RsxG81jIFs18mJbtcukC8lhMxJdQEiTW+/Mn2oESPfrvOh57ISK044GOBCisi7N7v4NOOmpuY09NXaG1GU9JFieDK6hE8zuBzb4C2C2KsbirSIBkeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn+hnj0UhXOndDhKg3at8Ck3yIuePUsOMHHDNC92gvo=;
 b=p69fh7SjBH24LYpnstF2Q8nN8nbUHoXGzGsQYU2CSWb1fT8pFvN990yzwBkb6zPBzia/xZbLafcla8aPNl9R92PJVLJeQK/XZhLTb7p6NaGDPUnl/TqCMlRATY5jQmPJoE6XO2uVjQIzWpPc1EWpP7LfBCVG+jxD8PQn4d8gjt4K7q/K3cFQGzudb2v6SDPai7JMJbIpSYECKuSKka69OgUPgSBsHo7fBn4Y6LVizsx19tOKYsweGFW7HDhjdAqUZ7vqPwnG7+wRshWyZ++v2yCwLBn5d36zWTCi43gIBVCCcWmCa3LOWAnOx9t0h/t94TneCkThCyomKdRwbTqADA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYYP286MB1740.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Fri, 17 Feb
 2023 14:14:32 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%8]) with mapi id 15.20.6111.014; Fri, 17 Feb 2023
 14:14:32 +0000
Message-ID: <TY3P286MB2611256E28AF951F2B38A5B098A19@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 17 Feb 2023 22:14:13 +0800
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
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
In-Reply-To: <20230217110413.GA28242@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TlDJ9kAPCmQKsXgOKIzDjYea"
X-TMN:  [E0eg4PNwkAPN7fU7D2nWaiX4xUFWrML4tkMzZSgm9yLup0PDs+oYqD+9+YJIVWJ6]
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <35fe0ae1-d9a1-dce6-abc9-2fb3c124b953@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYYP286MB1740:EE_
X-MS-Office365-Filtering-Correlation-Id: 1017d0f0-69c9-471d-da97-08db10f14a26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzV9ZvYVKxjT6Pnme5YtBbNK9Le13tL957WFMpta6Ti9f0/NaPvdQ8h3M+0b/d8EVU+6vGmX7ZB3LhbC0ajFRxsVdciZWRGfRs55eIgjWctYcsZApp47SpJb9V4Y7+ANuiwrW0gvuHR8pLmRliJbK2SKoZcHm9MarO1B2gjJn/8OcwkYeO4Sxh5jOBfPxfhysZlB4+uLo+vZLecuAd7xZds6N6AvFSFQqnpYmY08MTNXvzFH/f8wIsmUOLOY9uelrH6OFJMqaGo2Zc9YkOux5g0kJLELm3V07F/Y9uA4OsRN/vyRnkTQJO81fRHfhXT7O5pXc3cblx2dCkSfhScq40bgYA0e5t85ulTGwGqlgLvJvqP0wuxfmczwSEKFR8IrBR/O9ydcD7/wP4kqJb1+eVW/CId+d7RV8O2Hzzegi4xREfI/t95v88WawRCvDjEz5sDHFeY99xOeFbntuKEhXlbXr6W46WI7NLWiougpvQGeMdkx7JrsFcb1Ud9sOaJDy4pPFfJMmNrRkYpzeLmrPvlM5JfDzPrWZDt2oeUwrdqoSjXvoF184qwVBMjP0rqIguR3DTwhPfRt2jyfN6RMyxbjPEh7WZVFKXkyW0/ne0TZ0+n9yD9azSMZZTseoD9K/eJ2I5zxgI+d8f+ywISRIA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2VIK3hkU2k2b21mMnQ2cjRHWG5xRmMvRWpDUDNGQTZwOFkzQjdJWnlmbWlJ?=
 =?utf-8?B?RENwOGxCL1luL2Y2VmhIcFdxVFpmRXBzS3BDckxGd1hERUkvTDZCZDkycThR?=
 =?utf-8?B?NHpteFlpako0bEYyUUluQmdmYTJtYmRvcTlNM3BNZFJ5YkN6Z0MyTTZCV1lD?=
 =?utf-8?B?TTNyUTVvNk1lRVpHUktCVGU3ci9halh5RHl2VHdWendIMjN1L204c2RJQk9B?=
 =?utf-8?B?YkZSR21kaVgvU2hXWkw2azBUMGtSTWxlK3EyNUZheWhlMStQelQydnh5ZWpP?=
 =?utf-8?B?US9VQXBUYnF0c0NwR2RPQS9lNGxoWjdkZzlnemdTUmJZYXM1VFRNVFhGVlA3?=
 =?utf-8?B?aGZieVFtTWpUQytHcHF5QUhPVzJnMmx2WWsrdUlTUk8yVzBPcDMrOTRzeERj?=
 =?utf-8?B?dGlMMENGd0NLU0pzc2ViRmN3NFdESFBweVo2cHpEMW55eDRabTlqeHAzTCtk?=
 =?utf-8?B?aDVTYnRRWVRBVzJjTnF6OXU2WmZkRHpoZkxDWlUvRU55RWNKU1JkdmtBQ3FB?=
 =?utf-8?B?STBMQ1VYWDNXZDc1RzB1UjIvQTF6UDZ6eFdQTTE3eURwWktaUzBqMUFWVGtu?=
 =?utf-8?B?YlhYQVp5Vy9XYUFTOTl2bUxXS056b2cvanZNdVpKTjA4N3FLelBkMk9sV3o2?=
 =?utf-8?B?blVoMzNXajRnbXBqQUNhVVdjNnFOcG45MVByWU11cmF0Z3dwNWlyWmFPR3lI?=
 =?utf-8?B?MFNhclV6aEdyc1djdlVoTWJVSG1NckNPMkRIZ0Jkam9xUEo3KysxZzdib29v?=
 =?utf-8?B?aC9mamdBL01Yc09zczlwbjl3VXd2TXFYOFNaOU1BalJKM1dGZ3dwWkFhcGtk?=
 =?utf-8?B?TW9BRFhpODZEN0RudlROYUx4Z2xsVXg3N3Ivbi9Fb2VKRnFCb1FMeldOVTBu?=
 =?utf-8?B?dk1oc3pHSTZOSHpwK2tWUWRaSXo5N3BqOUhpT2YwSk83YVprQUNTZDJsZjRi?=
 =?utf-8?B?VHdwaFlEVDgrTlFZd3VXbWpoVDNZTDBLSlRHVDdaR0NGclJaZ3lBSTZwV3N5?=
 =?utf-8?B?WHllblQ1RGF1eUFkNVVQYmJwUnp5Zm14Z2N4KzB6S2FVZEUrSzZWYitYVFc2?=
 =?utf-8?B?ZTd1akZoNHFlRGpQUE4zd0VTZHdITGNLUFNKR1RuZEhMTHE0Tm4zUnZRbHJL?=
 =?utf-8?B?ZTBPZXdwSC9aODdtL2pzbnNNZmx2OVlCWlYrN29Ia3pOMDVWLzk1eVUvNkFz?=
 =?utf-8?B?THJhZzZGOVRhbDk1MTBiOUg1NHZoUVg4Q2loMXhWUXhUb3hvdE45MHFZa0RI?=
 =?utf-8?B?cTArL1ZqY1ZuMkZpR0RpZVVMQktxU3NGbHFlckhuUFQ3U2xRY0xObS9EaGNi?=
 =?utf-8?B?VVAxY1lTL2k3ZWpiNkVIWEY1aFg3SFVvM2V6aWIvdnFVcmx5ZFBoRm8yU1Rw?=
 =?utf-8?B?OENoejJQenNqb255M2x3S2F0L3RQczZ5cWpnejQ1TEd6TVJja0kvOWJDMFdJ?=
 =?utf-8?B?Vk10S1BZNjhnL2I1T1MrdlZxc0tVRHc3a0VaTklZZ0c2WTh4VndJNzQrY3FQ?=
 =?utf-8?B?ZEhNTVcyM1ZWOXRNK3F4VmREOXNDOGZFNDVHUENPeTM3UHdsSGpMdVIvNXBn?=
 =?utf-8?B?TEhvMEZKMnZMNXJrbzJqakNKekxOdzIyaDBaNWRzSTF5ZHg2SU02TG4zM3NW?=
 =?utf-8?B?S0l6NW9lSWg1cjQra0JhSkFJU2w4SFluMmhrZGtyQzBJZWVRVGowS3I2U2Z6?=
 =?utf-8?B?QXZvTWVKN2R2YzVOUW5hRzZEanh1TGovWXp5bmlBZ3VyamZhVXNPYWZPTm5K?=
 =?utf-8?B?OEpNOGEwajQyMytBWTlXSHFtSWZMWHl3Z0t0V3pLYlNMNWhKeXdsemtiU1JC?=
 =?utf-8?B?V09DZ2NUbk5rUUdpWGFHZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1017d0f0-69c9-471d-da97-08db10f14a26
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:14:32.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1740
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------TlDJ9kAPCmQKsXgOKIzDjYea
Content-Type: multipart/mixed; boundary="------------A4T2JPqVGvOsEtJF9dsFrqtF";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Michael Tretter <m.tretter@pengutronix.de>, devicetree@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, frattaroli.nicolas@gmail.com,
 heiko@sntech.de, jacob-chen@iotwrt.com, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, mchehab@kernel.org, robh+dt@kernel.org,
 kernel@pengutronix.de
Message-ID: <35fe0ae1-d9a1-dce6-abc9-2fb3c124b953@outlook.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
References: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
 <TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230217110413.GA28242@pengutronix.de>
In-Reply-To: <20230217110413.GA28242@pengutronix.de>

--------------A4T2JPqVGvOsEtJF9dsFrqtF
Content-Type: multipart/mixed; boundary="------------m5mrDA4twJNAY0Eec7HGshL2"

--------------m5mrDA4twJNAY0Eec7HGshL2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWljaGFlbCwNCg0KU2VlbXMgd2UgY291bGQgdXNlIEdGUF9ETUEzMiBmbGFnIHRvIGxp
bWl0IG1lbW9yeSByZXF1aXJlZCBieSBkcml2ZXIgaW50bw0KDQp1cHBlciBzaXplIHJhbmdl
KGFjdHVhbGx5IHVzaW5nIFpPTkVfRE1BMzIgY29uZmlndXJlZCBieSBkZXZpY2UgdHJlZSku
IEp1c3QNCg0Kc29tZSBkcml2ZXIgbW9kaWZpY2F0aW9uIG5lZWRlZC4gTWF5YmUgTmljb2xh
cyBjb3VsZCBoZWxwIHRlc3Rpbmc/IEkgd291bGQNCg0KbGlrZSB0byBmaXggdGhpcywgYnV0
IEkgZG9uJ3QgaGF2ZSBtdWNoIGZyZWUgdGltZSB0aGVzZSBkYXlzLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQoNClNoZW5neXUNCg0KPiBIaSwNCj4NCj4gT24gU3VuLCAyMiBKYW4gMjAyMyAwMDo1
MDozNyArMDgwMCwgU2hlbmd5dSBRdSB3cm90ZToNCj4+IFNpbmNlIHdlIGhhdmUgdGhlIG92
ZXItNEdCIHByb2JsZW0gbm93LCBzaG91bGQgd2UgbWFyayB0aGlzIHByb2JsZW0gYXMgYQ0K
Pj4gVE9ETyBvciBzb21ldGhpbmc/DQo+IEkgYW0gbm90IHJlYWxseSBzdXJlIHdoZXJlIHRv
IHB1dCBzdWNoIGEgVE9ETyB0byBtYWtlIGl0IHZpc2libGUgZm9yIHBlb3BsZQ0KPiB0aGF0
IGFyZSBydW5uaW5nIGludG8gdGhlIGlzc3VlIGFuZCB0byBtYWtlIHN1cmUgdGhhdCBpdCBp
cyByZW1vdmVkIG9uY2UgaXQgaXMNCj4gZml4ZWQuDQo+DQo+IE1heWJlIGl0IHdvdWxkIGJl
IGJldHRlciB0byBhZGQgZXJyb3IgaGFuZGxpbmcgdG8gdGhlIHJnYV9idWZfbWFwIGZ1bmN0
aW9uIHRvDQo+IGZhaWwgaWYgdGhlIGFkZHJlc3Mgb2YgdGhlIGJ1ZmZlciB0aGF0IHNob3Vs
ZCBiZSBtYXBwZWQgaGFzIHRoZSB1cHBlciAzMiBiaXQNCj4gc2V0IGFuZCBwcmludCBhIHdh
cm5pbmcuIEZ1cnRoZXJtb3JlLCB0aGUgZHJpdmVyIHdvdWxkIGJlIGFibGUgdG8gc2tpcCB0
aGUNCj4gYnVmZmVyIGFuZCBwcmV2ZW50IHBvdGVudGlhbCBtZW1vcnkgY29ycnVwdGlvbiBj
YXVzZWQgYnkgdGhlIGVycm9uZW91cw0KPiBtYXBwaW5nLg0KPg0KPiBVbmZvcnR1bmF0ZWx5
LCBJIGRvbid0IGhhdmUgaGFyZHdhcmUgdGhhdCBhbGxvd3MgbWUgdG8gdGVzdCB0aGlzLg0K
Pg0KPiBNaWNoYWVsDQo=
--------------m5mrDA4twJNAY0Eec7HGshL2
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------m5mrDA4twJNAY0Eec7HGshL2--

--------------A4T2JPqVGvOsEtJF9dsFrqtF--

--------------TlDJ9kAPCmQKsXgOKIzDjYea
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPvi7kACgkQX75KBAfJ
sRkpDA/8C0rlFYgsMHAEdOVeaWdeDSI06YV3AKtYaOjvDp4h+TTckZrfzBn2MWY7
6OVYM1Djc7i4bxIdbgRvizjm1oUIXPiprDVhFcrvcbtSGf9UEjQCKiRFLLXK86uE
sdLn0kUw/I3XZ4pV5cTKLrOK2XscLd9AqmLO9SgBE82i7tcb69rwnfuEUrQWf2Mt
9KxuIEcixyBXDiSkDsFCl1QDxHk0BU8RnN0buk2IcbEyl10VgzLB5iiDh0MhlH1V
GfQLRafzWlO2atRrRXqIHdrpvjvLKMgt9nK4S3+CDhZVTptOGBGODUmbgEeCraDM
ZGMFlsmUC3CtgwDYAidrjjE0dMO4Y8R18kOGKlpLF26vXYp9GWLiWgLPTsNLec/0
NMkruGyphoIZj2B6Eo2aMUBYRjrojavNrYqMeb0BB8nowPCft8VEsal7qw4iQBnU
e+sH+EPF9I4HWJ7gY017GG/WJYxvT+THJhxgDFqxBsCzZwh7QvKY52aFxChcXlCu
Ej1VZo1OXAFx+wXqsJ+9ioPiRu4Swo66nwSC5eOrrX7NCCU3alUiTR8KkOay6xxr
KGnTVi8PKhg57gXmjuUXfXcK8aGDNL6j2te+B0LRTkyqyZjF4teixS4nUo+ueZ5K
Rl30o92ZeC+6ZcdQjHdHHzpEeXttXPopidLD5INpJZcdF/MfeX0=
=eW22
-----END PGP SIGNATURE-----

--------------TlDJ9kAPCmQKsXgOKIzDjYea--
