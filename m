Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781677244ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbjFFNwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbjFFNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:52:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2050.outbound.protection.outlook.com [40.92.98.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3610F9;
        Tue,  6 Jun 2023 06:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W729DRYSTd4JBckLNM39IW124yLoXkGXNul7h6oe/b5l83Ul5w38ghpDWsFoKRs9kjoEI9Ii2ERwVL1cZ0f5F9gzY1LI5SeNlXPDHnkvyvLvb3jQzEf7BINLQCEci174b7ISEkPrRjogwlTdqc4nCshAOsiFK+Mx6/d5b6ezgSE9GxqCjtUTi/vbblNY62lAWy77ZfS1Va0fOWGBVDpiMI39eZGztBLl5shmU9APU9krhZ0O8U2oEb8yKW1hP4gMMp4nJR6lvOoTxVeZ/9ZWPYXfYB58GEyUV3OXCg+bv3HA9wF0cRhBS2DGJ+uwDdnylu+F5UrUtDklutE2y46fSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aChsfN2IXquRrPdeJbYLoVAoQYEJjDiizYZue7kUXts=;
 b=gKCipX3iMYXLO1HqXH1FRTE0x7ubqrxJha/tzL8ObYFbEqPvjmQ3MwZ9QpRono4MklOAJIAoEg3kq8CCgzLBElZ+Wi+fOx8sat6zzn7rNb3LtWPFKCpsUlHM5D2TuhiU3GLMdzXBZ7Rd/3+EUz2iAq+vi1FPcCnJGiq1rNFQwhJW2RGwCAtiPQTUO/1j3OB9K0zK90ZassnUVvleFv8Dxo5RluE6Xa9BdSTjnUofvV/sY15jFyPqGxJY8N60h6wz4SlkpTXkQsEUpRT3CMyoGdJFLMHnSQF5Tn03RLP1d5UR66dwey7ehmUA2Iqgm3UGHdziLXehXkPbnT1ddxtrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChsfN2IXquRrPdeJbYLoVAoQYEJjDiizYZue7kUXts=;
 b=qt2ZQ5GKHh1Ki+wBWdf8y4bAeQdDmpjA6Imtb3RedKNjo9JLYE33MTxsUq3Tc2l2pk5gm4s9ozPn712a2RI1lhZZ++Tolr0eLpdBbumUxHcaYgEdow2tPnNjgTtph7TAIy6UAsSyUf/SYNKxVjtaHsV7NUKwgoetCIIEgwnkUe9jk20wOrmoElaN+I46i0GMfbwGKUO5ANu1nlGOmNIAuVY8iDblYfhSt0qVzAuNkr59XeMCmmV769PWr8B2NNwuCphiwWXtMh15eMJ/ZEDSpFCfaTRtrJr/4SCxnWxZ7SUzzispH3bsGAigtXhA7mhs1u2P+id8xi8p83nR4QsfRg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2258.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:153::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 13:52:07 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 13:52:07 +0000
Message-ID: <TY3P286MB2611D89E41BA16BAD5A0B9899852A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 6 Jun 2023 21:51:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 0/3] Add JH7110 cpufreq support
To:     Mason Huo <mason.huo@starfivetech.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     wiagn233@outlook.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
In-Reply-To: <20230606105656.124355-1-mason.huo@starfivetech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------00h5fXKdF6jcVAv0QNh3Z0DW"
X-TMN:  [dGjg5h7mWt+LUSxg0V5Z3k+oTe6QqNYQ]
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <cd38f36b-863a-2066-184b-57e2512c558c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffbf9fb-c5b9-409d-9105-08db6695375e
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3rI6xxNHx/8sZRARqjRISe9Sxng9OwGLfRSD/frkIfWN+/NW0eo0+BO6GAIj3hTjB/mk9Xd2or/oiunLsrWqmTLcgCNxE/mxuM0HvLJ2jbWCk/e0w0OH7M2IFKuwEKaVetDu9Guecr2Mf78zGFAWWFJWXLONquyPfARjHi5HNkK8US88DZEKkmcCyD4IhiebtErzWNSaSIA9nnrLxYRRzkz6NYfkKQvjnFaYp2IeTf7A+GbS9Cnf2fyn9bzA/N5DuGboJKh+B+j/4ekGd8SCMTq77Agis6ocWpJWMoBCET8f20fYe7kQQtp70nbORWVu5lt0S1z8gsccPfG7PL1TI0nIzC0VlMv9mt/rKmwTrCHYqMSHKwkSeqvgceSczCkF0y8Zgd3T1spVY5vbgG9sFcK/fmi0+UWFyFlOXFtOzaIOBWqTtsN8oqwcXtRWmY39RD72d9ASKWG5ZJPu3sUvPVm8tDbQmmzM0VSNYu1NKt0dbU2ac5uSyCqCKrGJ7qxd+MmrrwUsZzkQ7Pa4l6vzMv19FWo3twJSkswhKAVU9knaLhgWm8vsQbW7WTfVB2mDoI7sWmjw/FxCCgUQ+kz4f7b8MBtwP1aMfMUFRf+DqjFSW/1TsW2X8WvjasfmzMWtufRLd98ZDhFUl6rxNGIv/j3AX615kg3j0CA8C0zGla9wSE33U94re/Tj1o2eIPDmWb0ukdECR3PeQEcVaUyrkLnM6r10oYdMcCPMq6MzwjAV8M+tXiRbU0BCvDInPFo2vVJnSKnBonJlHkkNtC3/PUtmF8R2aERlYMZ/vFB6ycCdwVOhGZ++kUw
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAQZ/ZkxbWZS+qzAwzU7f3++DQ6T12RPz3XtQzcZA9oPwsic7bZfYSo9I3m1i5HBTEwJ582UwHmKPhcQBQGKWnLucEejQ44qxcii+pxp/zB8iqGy2q22yjZUL0gF64vo+ChiJsP2jWvU2xIL7nQnjIgXwfv8Fm8Fi4EKbbgPwdkgEvrfVPeWlOe77Y44BuBw4SEbEyBNry0YOkgsgUVMtw2aJ82GjgfjFjEmyQppdrVeEryxZgxrLlPSdOBrBnp9vB1JesoY/mkySIi8Jf/vTB0QpMCuVCmkD+KPKaxoz0WCobba6wuVJZsf8yrXgOzi4kNs9USq4j5hwkhRQntd5U6JFiYKvk5APqaEYgA+sL5938U47WVsMENaTQiFB9IfWcd40wCm7sSH6pDHM5Z3fDzKXlizJz+xaNzJVUXGsVxwwgjlb1aTxjGChWlIup+KroqzfjH5D4pQlTv/AGY+0Wbz0RdKJdG7KqmUl4Hx8uVGsSa3diYYxhRo7cdiTUZ+rcsA4PH1ynNT6ak7VwfoD112hpTFK+ejqmxDDzR+aXIrFnqNnBxBvSZJYhMufuJruBqfZKdpT/Q4WJCEfP/3vYjY8y71EOkWZuvii6wXU4kxMZi5BBUoClck4CJzfFk3iTefDa2PFqZ1utS8UGFJ0g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NwdUc1U0dkVC8ya0tONHFXZjlYU3hPR1ZYN2NQQVFjVWVPVmRJb0V5ejAy?=
 =?utf-8?B?ZzRhOG0yQzR1N3B3a1ZpYTd2N3BtQXRGbkdzTkR1eWFuN2huTUFxYWxKeW8w?=
 =?utf-8?B?WXR0cklDZkRsbzN3Z2k3RUpVZXZ0N1BVelI2OU9ZTWgrUVhtVHpYUEFtME5E?=
 =?utf-8?B?NW55eEVYMDIzcDhFcnRLUEVZQUJUNEZHTGJhRS8zb0t1TnFSUHBuL0JaSTUz?=
 =?utf-8?B?WEpNTVV6cFFnaXovQ1FTYkZ6Ui9qMGxaMEN2d1V2alFsWVVmK3dCS1hqbTg2?=
 =?utf-8?B?bFBXdmRVL0dWaForWjJwRWFYd0ZpTTA2MmhkbWVmSVM5ZmZPQ1dTMzczcmY5?=
 =?utf-8?B?ZGJqWEV5dmtqVFlmdlpNYTg1aFl3YW9sQStWRy9jMW1CaFJxTFZ2dUpwbTV2?=
 =?utf-8?B?WExkYVFtTmVaRGp4RWp5OHRzS2MzUlBqVXdiQ3BNM0d3c2IrdzB2OUhyaFNo?=
 =?utf-8?B?ZitaZjVuZDVkdkl1dHBFb2ZONkQ5TDRZdGpnWVdXVGphYUozUU02ZUk2Qkxz?=
 =?utf-8?B?YndRRFEra09ieDgyYmtnSkpsMWVEMytrT2sxRG1EV3MxYlh5dE13U2NhSkcr?=
 =?utf-8?B?cTc3MVk2ZlA5bUN1aHZITnFxd0lqOWNINW1WejMvUnQwTUovNDZYNGdaVHhH?=
 =?utf-8?B?bUhLcVllRjVDb0gzVUVlbmxoa1ZyczlyRmlXQjdudlBSVjliMVJlck05SFR1?=
 =?utf-8?B?eTBPWVI2SlJhMXFWbGRTb2pyODF0b3Awa3hia0hGeFBsOU92eFJSMithbjY5?=
 =?utf-8?B?QXZPOUdQeks3eW9QOVVpaGFjVkcwcTdmU0hRWi9NTmNZdmJGNHFQMEZUZDAx?=
 =?utf-8?B?RFB0UkRWZE85WkhJNXlaaDB2VDZvMEExUkZ0Vnl0NzNxcGRUeHMwOGNpN2ZK?=
 =?utf-8?B?UUFtN2VwdFBENDJkUlhGemdzckZzellicXlMSHdBSzVocHNKRmtSTTJqdnVE?=
 =?utf-8?B?dW96MFpMbHhLV1lkaTM0cHlPYlhWRytRK2JVN1pURnVKSzNFdlRvT3JvZGpF?=
 =?utf-8?B?ZlF2L3FDN25xRTkzaDVvdDBQeXlHWHpxSWlHdjBzczlWNi8zRmdoelFrYXVs?=
 =?utf-8?B?TktMMlVyRXdxalJLZ2kxUTl0UzBJNU1qRXpoZmhuamdYc0haRzFRVVlPR0tY?=
 =?utf-8?B?NWZvenhrVkRNeUNMcGdKYVlwRWJRTmgyOEl2TVVZMzZ1ajBtWjNpWDE2L3pY?=
 =?utf-8?B?bUNvLzBQcnBUSTZFSjVwdmpjK3ZRSWxLL2owbzR6c2R2dC9MUmd6NU1ScGcy?=
 =?utf-8?B?TDBOa2FCWmRCekQrNzM3aVF1TXJ4MW91V2xPSnhVSVlNWnZFM2VnVVBxTFNU?=
 =?utf-8?B?eCtRTlVnbVU3cGhpUDZkcVhjRkJvRWw3bnVybnRvRzVldG5xS2hOK3N1SEQ3?=
 =?utf-8?B?RkgzQ3N5NmJNZHluMU1wRFQ3VHZjZVlUNGpTZDdVYnJKOHJ2RUdVd0xJM240?=
 =?utf-8?B?WmdwLzlBbkQwVm5CWW5wQXN4c2NzYjN6cXNwVCtVTjJoTGtpQU00WG40MkJ0?=
 =?utf-8?B?OTQ3V2pKd1hjb1dxN25mci9ua0kyR25vYVUwVnA1RHRRWnRYSW5lQ1A2Rkhp?=
 =?utf-8?B?dGJSQ0JESm1TVW5tdHhLTHBvRjBzK3BqV3dydkJveXhIUm9rZlRjMXgydnls?=
 =?utf-8?B?bEpzd3dqQW1XUlB2YXB1UlRmZnpFUWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffbf9fb-c5b9-409d-9105-08db6695375e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 13:52:07.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2258
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------00h5fXKdF6jcVAv0QNh3Z0DW
Content-Type: multipart/mixed; boundary="------------58jb6cncEfnhu5y2mkas0ofS";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Mason Huo <mason.huo@starfivetech.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: wiagn233@outlook.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Message-ID: <cd38f36b-863a-2066-184b-57e2512c558c@outlook.com>
Subject: Re: [PATCH v4 0/3] Add JH7110 cpufreq support
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
In-Reply-To: <20230606105656.124355-1-mason.huo@starfivetech.com>

--------------58jb6cncEfnhu5y2mkas0ofS
Content-Type: multipart/mixed; boundary="------------qQVgOSGcyg3grfywrBUwP1Q2"

--------------qQVgOSGcyg3grfywrBUwP1Q2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkFYUDE1MDYwIHNlcmllcyBqdXN0IGdvdCBtZXJnZWQsIGp1c3QgdG8gcmVt
aW5kIHRoaXMgZm9yIGFueW9uZSB3aG8gDQp3YW50cyB0byB0ZXN0IHRoaXMgc2VyaWVzLg0K
DQpCZXN0IHJlZ2FyZHMsDQpTaGVuZ3l1DQoNCj4gVGhlIFN0YXJGaXZlIEpINzExMCBTb0Mg
aGFzIGZvdXIgUklTQy1WIGNvcmVzLA0KPiBhbmQgaXQgc3VwcG9ydHMgdXAgdG8gNCBjcHUg
ZnJlcXVlbmN5IGxvYWRzLg0KPg0KPiBUaGlzIHBhdGNoc2V0IGFkZHMgdGhlIGNvbXBhdGli
bGUgc3RyaW5ncyBpbnRvIHRoZSBhbGxvd2xpc3QNCj4gZm9yIHN1cHBvcnRpbmcgdGhlIGdl
bmVyaWMgY3B1ZnJlcSBkcml2ZXIgb24gSkg3MTEwIFNvQy4NCj4gQWxzbywgaXQgZW5hYmxl
cyB0aGUgYXhwMTUwNjAgcG1pYyBmb3IgdGhlIGNwdSBwb3dlciBzb3VyY2UuDQo+DQo+IFRo
ZSBzZXJpZXMgaGFzIGJlZW4gdGVzdGVkIG9uIHRoZSBWaXNpb25GaXZlIDIgYm9hcmRzIHdo
aWNoDQo+IGFyZSBlcXVpcHBlZCB3aXRoIEpINzExMCBTb0MgYW5kIGF4cDE1MDYwIHBtaWMu
DQo+DQo+IC0tLQ0KPiBUaGlzIHBhdGNoc2V0IGlzIGJhc2VkIG9uIHY2LjQtcmM0IHdpdGgg
dGhlc2UgcGF0Y2hlcyBhcHBsaWVkOg0KPiBbMV0gKCJyZWd1bGF0b3I6IEFkZCBYLVBvd2Vy
cyBBWFAxNTA2MC9BWFAzMTNhIFBNSUMgc3VwcG9ydCIpDQo+ICAgICAgaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDIzMDUyNDAwMDAxMi4xNTAyOC0xLWFuZHJlLnByenl3YXJh
QGFybS5jb20vDQo+DQo+IENoYW5nZXMgc2luY2UgdjM6DQo+IC0gRml4IHRoZSBkdGJfY2hl
Y2sgaXNzdWVzIGZvciBheHAxNTA2MCBwbWljIGR0cyBjb25maWd1cmF0aW9uLg0KPg0KPiBD
aGFuZ2VzIHNpbmNlIHYyOg0KPiAtIEZpeCB0aGUgbmV3IGJsYW5rIGxpbmUgYXQgRU9GIGlz
c3VlIGluIGR0c2kuDQo+DQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IC0gRml4IGR0cyBub2Rl
IG5hbWluZyBpc3N1ZXMuDQo+IC0gTW92ZSBjbG9jayBwcm9wZXJ0aWVzIG9mIGNwdSBub2Rl
IGZyb20gPGJvYXJkPi5kdHNpIHRvIDxzb2M+LmR0c2kuDQo+IC0gRm9sbG93IHRoZSBhbHBo
YWJldGljYWwgb3JkZXIgdG8gcGxhY2UgdGhlIGNwdWZyZXEgZHQgYWxsb3dsaXN0Lg0KPg0K
PiBNYXNvbiBIdW8gKDMpOg0KPiAgICByaXNjdjogZHRzOiBzdGFyZml2ZTogRW5hYmxlIGF4
cDE1MDYwIHBtaWMgZm9yIGNwdWZyZXENCj4gICAgY3B1ZnJlcTogZHQtcGxhdGRldjogQWRk
IEpINzExMCBTT0MgdG8gdGhlIGFsbG93bGlzdA0KPiAgICByaXNjdjogZHRzOiBzdGFyZml2
ZTogQWRkIGNwdSBzY2FsaW5nIGZvciBKSDcxMTAgU29DDQo+DQo+ICAgLi4uL2poNzExMC1z
dGFyZml2ZS12aXNpb25maXZlLTIuZHRzaSAgICAgICAgIHwgMzMgKysrKysrKysrKysrKysr
KysrKw0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kgICAg
ICB8IDMzICsrKysrKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJl
cS1kdC1wbGF0ZGV2LmMgICAgICAgICAgfCAgMiArKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwg
NjggaW5zZXJ0aW9ucygrKQ0KPg0K
--------------qQVgOSGcyg3grfywrBUwP1Q2
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------qQVgOSGcyg3grfywrBUwP1Q2--

--------------58jb6cncEfnhu5y2mkas0ofS--

--------------00h5fXKdF6jcVAv0QNh3Z0DW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmR/OfsACgkQX75KBAfJ
sRlhCBAAjMimU8co5RdUqWBvqPSO/SMGwtFmz4UViM8cQVzGouB0fTdP2hC9sqbF
7x+YRgIdK26ZKHPFjK9cs3o9HWChGbwAQzsaknMbBm6LMp2hZ1lcmaP22X+ym6Ch
1s063KooYFNJTVOJTWlsZfNtJDGHfBFNJkqK6ahwr7+6Yf+dewbTwdlm0oPpSA0b
+wf4FmUwAKoC1GEXtBqwVs4ai+aL8iHEav3b7LP/nhSJYGcSGXnGGX1WO94JTELG
a+d0ptTP5mXZ53umnyHJdV3ArdfOz/fR9jxPyeqzEGoasooUjwuUwtdZraSmbpMK
Zsx9rs3Mbw1PExYLe5aNeU4a/mXfSgTV1j8V3XWb2Ai78CGrXwE29rSkW+8siyqw
QJrvnmMZighhm8y9Q/BqUeDYjWXmH37Tgvr6lVqEsc/M91MsKjXWrfCzzufQTt67
O0YdOrNRjR7DQ8lzI2iMT2qT5bfRnQzrbC27uV7VlbTGCyCLp9mjv86BUMkj6cS8
6umvfRUzQgvaYnM6H7AaV/DYI01Evt9/rp3inY9gASZ2kgHiw3j2TIryv23ei5lR
IbjAR8scphYqlZmFMilQTGGkkDiZgVdQWuKMESUU2/iugJBuQFSQqd4c8ms8hpSi
gPSCYpDye30ndMbQb7nKVKxSk1/xlaZMZyfJ6zYw+yqLXPEzmVg=
=X3Fm
-----END PGP SIGNATURE-----

--------------00h5fXKdF6jcVAv0QNh3Z0DW--
