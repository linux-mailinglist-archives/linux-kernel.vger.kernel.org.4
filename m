Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA087031C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjEOPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEOPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:44:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2019.outbound.protection.outlook.com [40.92.99.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE801FD5;
        Mon, 15 May 2023 08:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJeKiILqLLoxS6p1aNet+Lk8ldLH2GyVtjt0rSZiYc+ACBkatrMpB/12pHs41fzDnb90Yd/e1cq/Na+RkZ1PICUJTJ4NslJwPbw34uisz/9WcFFdx7Awyw1NcJP07gZKwn0aykwjtwEb5ULI8ePEwYVmEZwzW2IT3G+Ho1vXjdpDUOfWerKsrbWhCMjpHarLV4mrhD5feGnJuaFQ/TU3dXxQ8/iDEKsHqEskbH1Y39/kkxaRxkWJl4mH2AMLm4LMQD7kyMkO7e3PVN+iwAzWHeX1VKikWG4ljcBXO5P3gBhUPpwDjAP9rfiYIu/r8FZJXLEAQWyWH9rMok0CTKxS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8ogCK7DDHIGByloEpNgM83uRSPo3J8dktip/glADcM=;
 b=e+QP7Q9p5HEI6Xh9fsIsN9AqHRT8H6NcGyt5BqxfZI741O/g23AOcS7qyjDr+P9ch3PhwK/3HyWFhui1Q4HYs84xosRSgowAcVbMUC0oW8r92HsbRkWvrLysWHyqev9kl3SBaRDkW0yQ7Z3f6TMlxeQVUjotVxyqZrKSBTwByh+1MU9kKNAwyo75eE2RU8qBCSiyeRWFVBoQ9BV0fVtbE0jMGcApPYPLfRF4xwPGDRj9H817GL2EBtuc/R/ol2YiX6867l5bUZhYr1yoom2I3WpnaQItnGfwwj1SMxr3r4WNWH3BdGsXyORcS8AUJHFJIMTCfUbA+igWzCMvi5XDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8ogCK7DDHIGByloEpNgM83uRSPo3J8dktip/glADcM=;
 b=DLrRxlYoeIUwpsRfLbycVf/XGCBT7RyIwvrW65krIEKvdGeLOdJJFEDKanNDjO36tJELWhRAa0oYvoDcHCu4h/AOThO+FfsFjykD6ydnGURT+Z8t6ia1fIe9YqOdoVVIk+RgilgEUYgrDnvWsqp1NYWBUOzCzpRlfdvi6MaXEmQWMd1+j1uD78K/0Stek0RvTVuOjNxw1W/fAW26piAX/LWMSKa43p3o/n2yheS7pSNLch7PgZ4CCoMsP8ppgqP4mskjssa/jKjfQBhJqMxx/RxdetaJgYteT0sEJMmjt//lUMEGth8bHmQf0wqMI+18krHLymxNvT3j9RJbk3Y/oQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2684.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:44:19 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:44:19 +0000
Message-ID: <TY3P286MB2611E4814895D1F6CBD127E198789@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 15 May 2023 23:44:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     wiagn233@outlook.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
To:     Andre Przywara <andre.przywara@arm.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
 <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
 <20230515105229.GI8963@google.com>
 <20230515161940.3bcbe932@donnerap.cambridge.arm.com>
 <20230515152829.GW10825@google.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230515152829.GW10825@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------biUYpBf4IWMKDLktWBDHNkeD"
X-TMN:  [35+6nGtqycYmmUS0fdRAsgmdbsaSFkDT]
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <172ecfac-f443-fd35-c7de-4fc12d2a0f78@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2684:EE_
X-MS-Office365-Filtering-Correlation-Id: f1956873-56f8-4143-4ef5-08db555b3f23
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT/OA0+UPAYL1ow5eioUeC8gm8LChimQtrwKzG0a+XT0NZnFk91nI6l9hlryKvnQfwshBH36Ja2H/7CFEdsqiWmgDgNsyTJT/AZa2+oIkO1RyZQrHLvu1VO6q42reYdHOp7rkRHjyh8Jc3TJ9qkvoixtY38iGd4CF2E8PxgReHgI0M4FOQw41/anSr7A8HE2Msu+Nbu/e/6gTgjFqeSnKOoK+E+WgvfeKvfvztm3B5QEJdM16dXfXZCWhyzhYke8YNhY5G4uI+hxYK8pDSZaXP4vHdne/fiu3kk2HL5r6YmmXmFqwiIN8uRuGa/p2y/v7VR7ftTgXIHMkLV+Q9DHjirSUIFshcu4Zgnam5v0muPyALqrTk26XfQ4tB2iNNDZ6eQHXU00lyKN8m4yTkm3LL8pDSXephtqWGdPKiDk5xXQjRC1uVjboPS5RuDloLQ8+97W41jPvOA20QWsUmdtmFIkMIjYAfJdu6TClAN+s/DH0hdf6ss0ITY+Sm5KtWQyk/QbCA+JtN20Awr2bVAwmGjDMnQQQgq9/VF4iJq4Xf+svAeXFWwhaV0RemgZ8DE0PuaySDpD235RxiGz4gXQ8sEZd/x4GEGG3UNCaM1sPq9o4Q/j3Xgq8QMzmOjrHYGE9qRrYHcagXx6F+77RNbLviFiaetc9s80ExL1THz7lFj3/fLxMu8vdLwRT+/spDqVQk1mVEQug+qy8sDQPiLGiaZ3j8oR2IoY8UFxNHvDSTMvevC3/qsFAFUag+K8t4Zq9NFEAQR+CAvZhkWOEOj0tksIqz9uV/fXkyOyysBuDavO2Pm8be737Jrj
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oiv4FoQsYDzFm4Rh+Zl5y9SU1z3vDGs76fnixeL1/oNuhPMYB8q871WCdVunqAate5+A1n+iqk7bNay3W73EbsKtcTbafODEyYXV6kX23NXnM8hlAFHdcDH5SIn05r4xTNsHXvkI6gXUiQA8jfIY3vvnTzNb+XXUVzT51h0IZVaG5qR3RqO9UUln2G+ecU/rbnVz5rC7hQROnBhMP7hKu28EjgurdD68sPEMmAoEdU8EvprRsWR+wQQ9cWML/tN3QhPTtZoRoSB3lMVeDTLdD9GP7WlcgPMTkhzNrXy7BLbY3oDKVx1IcSp9D1IzD6erhS4P3tC0AK7RV9lgErlPKhyZnTp54gSMOA7fSB1ngAmkEcQuLNZE+zJUuP9aOal+z38RmN5Mg5Np1JNOdL5LHMSLV1nETY6E1i2j6DGiT6AuFeUUeqtzeYeDOn+x0KHxMgmzlZ7FhAR25j9jwrtRX+MYtLERH4heWJRVCJ9KVMP9ha/D1ham96fRvc3XrIDv1PGbqd0dn/F6OZAZAlLEjE50mS8U3VSfV+xSm+77S5OKwMLzD6lHBE7IB0lrVJ6pcUJHr6QVgZvUtOd8MFUUHCsC4kfarxlJ2dP7IDDlXaOuFpE62F+nW1ztsavTOSveQuRxSl1pCEcUAKEvXTPgGjap5viZFKOkyS/S+XVfcr1m/mneM2NMPRf/UUNV7RbZVYtGl1Aulz7fz0b0rbLXEA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFUZ2VyQVZVS1VQWnljN1NmUTE1eURXZm1DSmk4THg5TDJ5SnV4OTgwbmdt?=
 =?utf-8?B?NFE0R1VSRWNDNU9sSHJqUzhsODFhY01XdjFBMDdNaldHbEtXdGk3bXJVNnJo?=
 =?utf-8?B?WTV1WXNBN29oOGIvd1I0elUrNWZtaktZM1JWN2ZQZnFmVndBTHh5TjMyVGtY?=
 =?utf-8?B?a2wrUDQ0WFV6dUhjL3RhOVQvazlwTkNEMjlnVHJDVWI5eDQ1eWN4cFNQTVBD?=
 =?utf-8?B?K2k3bkJNYzFkYktIVzQyQ3pIQlkrWVA5UU9lazIyZDd3N2JSYmxTZEtMV3RQ?=
 =?utf-8?B?a0pTWUFOZFFXdklUSmZteXVWdUJwTk9hc1VFdWJZNmhlNmROWkNManJ3NEVx?=
 =?utf-8?B?bzNHU01vVTFWMlE0YjlKOXMvR2xYS2FZRnJTbi9qY3ZrQllMZFF0alFOVitP?=
 =?utf-8?B?N0EwZFEzSVA5RXhxTnkxL3ZSY1ZhYVFSU0lwanhmOVJRbnRCeGdrVnNUN2Qw?=
 =?utf-8?B?VXJvNWRGbEJOWTJKNXhWWGgzOUlYcGpDZkRINjJZMTFrMGdIUUlsN0JFTjBG?=
 =?utf-8?B?Qnd1aUtHMDV3dXRKOFhTdWoxUmkyUlNKRDFrTTJ3bWxWNW9nMXI2RW9Db2tl?=
 =?utf-8?B?OWJLVmNvanRmVVdWS3lZZGhMRVI0ZlBzZWE4UGlQRVgwQXZYUWZheWFDMGEy?=
 =?utf-8?B?d3VwVk5tQUoyd1NSZzk1dHVpR1F2bExyVlh0bFhoMnNXZlJCb0pXRHF1L0Z0?=
 =?utf-8?B?djk3Qk1JRDBRd09yTk1iK1ZacmRjNW9hYnJ5YjVZYW5wR0h2aldMdUNDSjJx?=
 =?utf-8?B?WHhJbDlzNHFNWVplamVQNHlqTTVqNlpWSGhXMW9EazZReXFWQzkzRThtVita?=
 =?utf-8?B?Qkd1bEVpZ0tVR1NlT25mMFh2OXVvK2Y1eEJ2SXp5ekh4aDE4NDk3QTZWSDdu?=
 =?utf-8?B?RExpOU9TczMrSWtDOW1zTGRML0g5b1pWa2RvYUJJMU1lSmd2UEpPQ3RRUWND?=
 =?utf-8?B?b2s1ejR4NnFRNkRtaFR2SlVCMGxFNmJMOFIxVGFRNXVQbHFJdzhFcWFKamVI?=
 =?utf-8?B?LzA1eHpkVDNUekpkbXl0NlBBeUNOZlRFQUZKMzMweUh5Sk1La1duQURvTGYz?=
 =?utf-8?B?ZEgyeGZLVHdqcjhpWllIWE13dmEvZXlBbDJHb0x1dkdMcVJXWm9jVTgyMm1t?=
 =?utf-8?B?RThvMGNwSXdrS0cwQXN2RWllK0hoemx2UURrUUc5NG90WW9WRXYxL3FCUW1B?=
 =?utf-8?B?bng0N09HOU9meGE1TXVTclZvWDFwenFPMTdUeFNYeXlLTjlYTlkvcFVveTdo?=
 =?utf-8?B?UGN3RVVUSjcxZ1JuV3dSSEwxaWhuSlJ6Z0N1S05zRGhHNW1Dd1lrUFhuVk1M?=
 =?utf-8?B?SGdYUGRxSUErNnc5dDFWQjJBN2RVQnpmZC9SV3BwUmg4TXE5N2NjL0wzY0Nj?=
 =?utf-8?B?dzNVdE9WdGVZcnFScyt6NGxSSjdFcUNFcXRrUG9ZcDFIdG1Lbmw5WTc2djAx?=
 =?utf-8?B?bUxQWDlxdkJteWtBUTE4WGRuSEdiaUFSVlpNaUozb3VPRS92WmNYZmg3MHpp?=
 =?utf-8?B?YkxOMTJ2TlhhOEFjUDlvS2lXNWh3S1VJUzYvNjEwYU9veXNNWXpDc2hSNjZ4?=
 =?utf-8?B?YWtIWTRUOS9lUGlOclZxMThLUG1VRlN2QTVaRDcvWWFXL3JIQ2ZZMHk5ZS95?=
 =?utf-8?B?czVHVExMQm5aSjI4OHh2eXhTMk9wNmc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1956873-56f8-4143-4ef5-08db555b3f23
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:44:19.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2684
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------biUYpBf4IWMKDLktWBDHNkeD
Content-Type: multipart/mixed; boundary="------------T5piAJ8X5IJz8xAMSSOMAppq";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: wiagn233@outlook.com, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, wens@csie.org, lgirdwood@gmail.com,
 broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
 Martin Botka <martin.botka@somainline.org>, Lee Jones <lee@kernel.org>
Message-ID: <172ecfac-f443-fd35-c7de-4fc12d2a0f78@outlook.com>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
 <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
 <20230515105229.GI8963@google.com>
 <20230515161940.3bcbe932@donnerap.cambridge.arm.com>
 <20230515152829.GW10825@google.com>
In-Reply-To: <20230515152829.GW10825@google.com>

--------------T5piAJ8X5IJz8xAMSSOMAppq
Content-Type: multipart/mixed; boundary="------------1aV5DJnHpzW0wDOvo0q0Dp6x"

--------------1aV5DJnHpzW0wDOvo0q0Dp6x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmUsDQoNClBsZWFzZSBwaW5nIG1lIGlmIHlvdXIgbmV3IHZlcnNpb24gb2YgYXhw
MzEzYSBzZXJpZXMgaXMgc2VudCwgSSB3b3VsZCB1cGRhdGUNCg0KbWluZSBhcyBzb29uIGFz
IHBvc3NpYmxlLg0KDQpCZXN0IHJlZ2FyZHMsDQoNClNoZW5neXUNCg0KPiBPbiBNb24sIDE1
IE1heSAyMDIzLCBBbmRyZSBQcnp5d2FyYSB3cm90ZToNCj4NCj4+IE9uIE1vbiwgMTUgTWF5
IDIwMjMgMTE6NTI6MjkgKzAxMDANCj4+IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4NCj4+PiBPbiBUaHUsIDA0IE1heSAyMDIzLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPj4+DQo+Pj4+IE9uIDAzLzA1LzIwMjMgMTM6MDcsIEFuZHJlIFByenl3YXJh
IHdyb3RlOg0KPj4+Pj4gT24gV2VkLCAyNiBBcHIgMjAyMyAxNToyNzo0MCArMDEwMA0KPj4+
Pj4gTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4gSGkg
TGVlLA0KPj4+Pj4NCj4+Pj4+IEkgc2VlIHRoaXMgcGF0Y2ggaW4gTGludXMnIHRyZWUsIGJ1
dCBzb21ldGhpbmcgbXVzdCBoYXZlIGdvbmUgd3JvbmcgaGVyZSwNCj4+Pj4+IGNhbiB5b3Ug
cGxlYXNlIGNoZWNrPyBTZWUgYmVsb3cgLi4uDQo+Pj4+PiAgICANCj4+Pj4+PiBPbiBGcmks
IDIxIEFwciAyMDIzLCBTaGVuZ3l1IFF1IHdyb3RlOg0KPj4+Pj4+ICAgDQo+Pj4+Pj4+IFRo
ZSBBWFAxNTA2MCBpcyBhIFBNSUMgY2hpcCBwcm9kdWNlZCBieSBYLVBvd2VycywgYW5kIGNv
dWxkIGJlIGNvbm5lY3RlZA0KPj4+Pj4+PiB2aWEgYW4gSTJDIGJ1cy4NCj4+Pj4+Pj4NCj4+
Pj4+Pj4gRGVzY3JpYmUgdGhlIHJlZ21hcCBhbmQgdGhlIE1GRCBiaXRzLCBhbG9uZyB3aXRo
IHRoZSByZWdpc3RlcnMgZXhwb3NlZA0KPj4+Pj4+PiB2aWEgSTJDLiBFdmVudHVhbGx5IGFk
dmVydGlzZSB0aGUgZGV2aWNlIHVzaW5nIGEgbmV3IGNvbXBhdGlibGUgc3RyaW5nDQo+Pj4+
Pj4+IGFuZCBhZGQgc3VwcG9ydCBmb3IgcG93ZXIgb2ZmIHRoZSBzeXN0ZW0uDQo+Pj4+Pj4+
DQo+Pj4+Pj4+IFRoZSBkcml2ZXIgd291bGQgZGlzYWJsZSBQRUsgZnVuY3Rpb24gaWYgSVJR
IGlzIG5vdCBjb25maWd1cmVkIGluIGRldmljZQ0KPj4+Pj4+PiB0cmVlLCBzaW5jZSBzb21l
IGJvYXJkcyAoRm9yIGV4YW1wbGUsIFN0YXJmaXZlIFZpc2lvbmZpdmUgMikgZGlkbid0DQo+
Pj4+Pj4+IGNvbm5lY3QgSVJRIGxpbmUgb2YgUE1JQyB0byBTT0MuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IEdQSU8gZnVuY3Rpb24gaXNuJ3QgZW5hYmxlZCBpbiB0aGlzIGNvbW1pdCwgc2luY2Ug
aXRzIGNvbmZpZ3VyYXRpb24NCj4+Pj4+Pj4gb3BlcmF0aW9uIGlzIGRpZmZlcmVudCBmcm9t
IGFueSBleGlzdGluZyBBWFAgUE1JQ3MgYW5kIG5lZWRzDQo+Pj4+Pj4+IGxvZ2ljIG1vZGlm
aWNhdGlvbiBvbiBleGlzdGluZyBkcml2ZXIuIEdQSU8gc3VwcG9ydCBtaWdodCBjb21lIGlu
IGxhdGVyDQo+Pj4+Pj4+IHBhdGNoZXMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+
IFlvdSBtdXN0IG5vdCB1c2UgdGhlc2UgYWJvdmUgdGhlIHRhZ3Mgb3IgR2l0IHdpbGwgZHJv
cCB0aGVtLg0KPj4+Pj4+ICAgDQo+Pj4+Pj4+IENoYW5nZXMgc2luY2UgdjI6DQo+Pj4+Pj4+
ICAgLSBSZWJhc2UgdG8gQVhQMzEzYSBzZXJpZXMgdjEwIFsxXSArIG5ld2VzdCAoMjAyMzA0
MjApIC1uZXh0IGJyYW5jaA0KPj4+Pj4gU28gdGhpcyBwYXRjaCB3YXMgYmFzZWQgb24gdGhl
IEFYUDMxM2Egc2VyaWVzLCBidXQgSSBkb24ndCBzZWUgdGhhdCBpbg0KPj4+Pj4gTGludXMn
IHRyZWUgKG9yIGluIGFueSBvZiB5b3VyIHRyZWVzLCBpZiBJIGhhdmUgY2hlY2tlZCBjb3Jy
ZWN0bHkpLg0KPj4+Pj4gVGhlcmUgbXVzdCBoYXZlIGJlZW4gYSBjb25mbGljdCwgYXMgdGhp
cyBbUEFUQ0ggdjMgMi8zXSBkaWZmIGFjdHVhbGx5IGxpc3RzDQo+Pj4+PiB0aGUgYXhwMzEz
YSBlbnRyeSBpbiB0aGUgY29udGV4dCBsaW5lcy4NCj4+Pj4+ICAgIA0KPj4+Pj4+PiAgIC0g
QWRkIGF4cF9yZWd1bGF0b3Jfb25seV9jZWxscyByYXRoZXIgdGhhbiBkaXJlY3RseSB1c2lu
ZyBheHA4MDZfY2VsbHMNCj4+Pj4+Pj4gICAgIGZvciBjYXNlcyB0aGF0IElSUSBsaW5lIGlz
bid0IGNvbm5lY3RlZC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+
Pj4+Pj4gICAtIE5vdGhpbmcNCj4+Pj4+Pj4NCj4+Pj4+Pj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXN1bnhpLzIwMjMwNDAxMDAxODUwLjQ5ODgtMS1hbmRyZS5wcnp5
d2FyYUBhcm0uY29tLw0KPj4+Pj4+Pg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ3l1
IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4gUHV0IGNo
YW5nZS1sb2dzIGhlcmUgaW5zdGVhZC4NCj4+Pj4+PiAgIA0KPj4+Pj4+PiAgIGRyaXZlcnMv
bWZkL2F4cDIweC1pMmMuYyAgIHwgICAyICsNCj4+Pj4+Pj4gICBkcml2ZXJzL21mZC9heHAy
MHguYyAgICAgICB8IDEwNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+Pj4+Pj4+ICAgaW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmggfCAgODUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDE5NCBp
bnNlcnRpb25zKCspDQo+Pj4+Pj4gSSBtYW51YWxseSBhZGRlZCB0aGUgbWlzc2luZyB0YWdz
IGZvciB0aGlzIGFuZCB0aGUgRFQgcGF0Y2ggYW5kIGFwcGxpZWQuDQo+Pj4+PiBTbyB0aGlz
IHBhdGNoIGRvZXNuJ3QgbGlzdCBhbnkgdGFncyBhc2lkZSBmcm9tIFNoZW5neXUncw0KPj4+
Pj4gU2lnbmVkLW9mZi1ieS4gVGhlIHBhdGNoIGluIExpbnVzJyB0cmVlIGxpc3QgYSBSZXZp
ZXdlZC1ieTogZnJvbQ0KPj4+Pj4gS3J6eXN6dG9mLCB3aGljaCBJIGRvbid0IHNlZSBhbnl3
aGVyZSBpbiB0aGUgdGhyZWFkLCBoZSBqdXN0IHJldmlld2VkIHRoZQ0KPj4+Pj4gYmluZGlu
ZyBwYXRjaCwgQUZBSUNULg0KPj4+PiBZZXAsIEkgbmV2ZXIgcmV2aWV3ZWQgdGhpcy4NCj4+
Pj4gICAgDQo+Pj4+PiBJIHNlZSB5b3VyIHRlbnRhdGl2ZSBSLWI6IG9uIHYyLCBidXQgd2l0
aCB0aGUNCj4+Pj4+IHJlcXVlc3QgdG8gcmViYXNlIGFuZCByZXNlbmQsIHdoaWNoIGhlIGRp
ZCB3aXRoIHYzLiBUaGUgYXBwbGllZCBwYXRjaA0KPj4+Pj4gbG9va3MgbGlrZSB2MywgYnV0
IG5vdCBvbiB0aGUgYmFzZSBjb21taXQgdGhpcyB3YXMgc2VuZCBhZ2FpbnN0Lg0KPj4+Pj4N
Cj4+Pj4+IFNvIEkgYW0gc2xpZ2h0bHkgY29uZnVzZWQsIGFuZCBhbSBhbHNvIHdvbmRlcmlu
ZyB3aGF0IGhhcHBlbmVkIHRvIHRoZQ0KPj4+Pj4gQVhQMzEzYSBwYXRjaGVzPyBJIHNlZSB0
aGUgYmluZGluZyBwYXRjaCBtZXJnZWQsIGJ1dCBub3QgdGhlIE1GRCBwYXJ0LA0KPj4+Pj4g
ZXZlbiB0aG91Z2ggeW91IHJlcGxpZWQgc2F5aW5nIHNvLg0KPj4+PiBCZWNhdXNlIHRoZSBw
YXRjaCAjMSB3YXMgYnJva2VuLCBzZWU6DQo+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9UWTNQMjg2TUIyNjExNzdDRjdBQTI5NTlCRDk1MTdEQTk5ODYwOUBUWTNQMjg2TUIy
NjExLkpQTlAyODYuUFJPRC5PVVRMT09LLkNPTS8NCj4+Pj4NCj4+Pj4gVGhlIFNvQiBhbmQg
UmV2aWV3ZWQtYnkgd2VyZSBhZnRlciAtLS0gYW5kIGFwcGFyZW50bHkgYjQgdW5kZXJzdG9v
ZCBpdA0KPj4+PiBhcyBjb3ZlciBsZXR0ZXIgYW5kIGFwcGxpZWQgZXZlcnl3aGVyZS4NCj4+
Pj4NCj4+Pj4gTGVlLA0KPj4+PiBEbyB5b3UgaGF2ZSB0aGUgbGF0ZXN0IGI0PyBJZiB5ZXMs
IHRoaXMgc2hvdWxkIGJlIHJlcG9ydGVkIGFzIGI0IGJ1ZywNCj4+Pj4gYXNzdW1pbmcgeW91
IHVzZWQgaXQuDQo+Pj4gSSBhbSB1c2luZyBiNCwgYWx0aG91Z2ggdGhlIHZlcnNpb24gSSdt
IHVzaW5nIGlzIHF1aXRlIG9sZCAoMC45LjApLg0KPj4+DQo+Pj4gQWxzbywgdGhpcyB3YXMg
cXVpdGUgc29tZSB0aW1lIGFnbyAtIEkgaGF2ZSBzbGVwdCBzaW5jZSBhcHBseWluZyB0aGlz
DQo+Pj4gYW5kIGRvIG5vdCBkaXN0aW5jdGx5IHJlbWVtYmVyIGRvaW5nIHNvLiAgVGh1cywg
dGhlIGFwcGxpY2F0aW9uIG9mIHlvdXINCj4+PiBSLWIgbWF5IHdlbGwgaGF2ZSBiZWVuIGEg
bWlzdGFrZSBvbiBteSBwYXJ0LiAgSSdsbCBrZWVwIGFuIGV5ZSBmb3Igc3VjaA0KPj4+IHRo
aW5ncyBpbiB0aGUgZnV0dXJlIGFuZCBpZiBJIHNlZSAoYW5kIHJlbWVtYmVyKSBhbiBpc3N1
ZSwgSSdsbCByZXBvcnQNCj4+PiBpdC4NCj4+IFNvIHdoYXQgYXJlIHdlIGdvaW5nIHRvIGRv
IGFib3V0IHRoZSB0d28gc2VyaWVzIG5vdz8gSSBndWVzcyBpdCdzIG5vdA0KPj4gd29ydGh3
aGlsZSB0byByZXZlcnQgU2hlbmd5dSdzIHBhdGNoLCBqdXN0IGZvciB0aGUgd3JvbmcgUi1i
OiB0YWc/DQo+IE5vLCBJIHdvbid0IGJlIHJldmVydGluZyBhbnkgcGF0Y2hlcy4NCj4NCj4+
IFNvIGRvZXMgdGhpcyBtZWFuIGJvdGggc2VyaWVzIHNob3VsZCBiZSByZWJhc2VkIG9uIHRv
cCBvZiB0aGF0IGFuZCByZS1zZW50Pw0KPiBZZXMgcGxlYXNlLg0KPg0K
--------------1aV5DJnHpzW0wDOvo0q0Dp6x
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------1aV5DJnHpzW0wDOvo0q0Dp6x--

--------------T5piAJ8X5IJz8xAMSSOMAppq--

--------------biUYpBf4IWMKDLktWBDHNkeD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmRiU0MACgkQX75KBAfJ
sRkz+A//dGndPq4eT3GJbVxyPo1aSvdeW5Y/fKlgcfJ0kUQqyQaGTG7BAHze5Hdc
JvcWxyr5Ddj44D0JHc+imi6NtqLhuG9VuIXMgo8hv6WfkyOjRndMWR42tW9IDhsD
NUzuqqYZXNMcGIukFpHojG/EGuPayRQFefptH4znE4tpYtFhXXfxqIVFqomS4qxr
lKlriDjV2TNlLbCRpiXdBt8F/fFyJw1K589mUzG68B6THCHwyZACZxqRTgI2eqpn
v+lkXTJPoFwUEKpdiC03r53hP/FwRgOvoKYbPf6GRRFXt9PxBTPLegtbtV6ueV0T
DBd2HFhfQa8tOP1Q4ssBdgh2kT4XRJHz1EQB69mhpKakhmsjz4d8beffKp+krdbP
ULLgMqkk6vpzml2I5vKcycSMW7XVQ15GSWHdaW/3rjtn7PMDNQcrM1k94fvq4SbM
t5jy1ajpkz17wem/JXced7OMn3KqG7XEjSrwXRryPHDA+1uxeE48yUPkMtS9w1T5
ErLpxU8Px5G08bvpwQd0fKZbynebuTJiM+s+2f8k91rhLX/4TImKCKOvnOv+Az65
we4bDk/yXA8ad6eX+JZnKZKJHcZjOdL89pluhNvvA9hM2rd6trzZpUK3ZlkKIkTW
D4G81RfvZFB0/06f8E3egWLCdkcSYG6RDWIQ73iN5NYvFA+OZv4=
=tf15
-----END PGP SIGNATURE-----

--------------biUYpBf4IWMKDLktWBDHNkeD--
