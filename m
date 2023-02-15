Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755369813B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBOQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBOQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:49:44 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2023.outbound.protection.outlook.com [40.92.107.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8743C8685;
        Wed, 15 Feb 2023 08:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFp+AGhIm2VkQogh00Cptiy9dJgac68G42LQY/y8vOFZ0dXBHWi2PuS62aj6sYfWx4SRngHkEN96ljY7DhSseXdOD6Sg3LHdqQsaKQ8mgWfVjOXBSt4WPRKCK9f/VuhN5QhxdhKtjXE9QiTmfOL/t4Zhsn+YcRvkdUfBx/uqiv90oixN/SYguPo/tv/AsKcNDTCTDHnxE0SqacDkSfpTLKBVHQHglc4cfxfHTOfkI/wNRAXgUkbIQDE7TUDecgPWFvCCnhkXg5pE+jWyvPmz/XHexeJqWS2nVaGKoGK/LDI5JWyRQPfqmeRdjsx0wmy/JNpDi7E1d2FzDiHj0SROug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fV8TZq7GK3oiSnIgmeT9rbSFnQEB17NJsL7bB+y0HU=;
 b=K8Bu31OEV2XJMYwDrylvdZE7ez0JsNvfPXgWv7RE5iEC2qm8q+wJXFiRhAkRJEMPZuPuXqYfW9DDGSFJb0d1Wet7I0PR5n1DmblBdGH9duhvLXrG2KFqM3xTWk6xf7Z0oWR0nuf4D1QDcUTb2Al/24x7BmnFTW0gW8Mc0kBfInMsnjoq74RV3D3HD9Iu5bjZ8sEhVSlZ50Z4q6IoHp/4XnMXSKwOShkXP/oTIG8ki1NHQ//QpXPe0cuj0h9mpPF7nopqxung5s71c5AT6gI57BmcAk81hSeeu2qLq6nq2RUH3dVi+gjJXMrqEdDejPWD0T94THNaoMGL32RK6XhvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fV8TZq7GK3oiSnIgmeT9rbSFnQEB17NJsL7bB+y0HU=;
 b=Ni6iiYL0DbhSNPNLB8W1ZgCzI4iQq7bj7QcPGoTs8MY2TjTE0KkKQRTD9EFNmIrYBdLdltCriqHGmZG5NLvyritHatDqfAVD/TVKals38StRug2b/QGp0JOdbzsB7OBnudWouZyNWj/WZD6bstdEGlKmPm9y11f5SRLhZD6CY4t6XZOmCAXf/Jj+So4OJNw5O/+7js4lRaDvn6ppc6Tx5Y12MRRxY9WuNVJEAv++pagk+XHhuWpzuw1h+wV3GPJ9kynKPxiVEW7JO3sI2S66rjckvIy1vFLxV/Kk92FKU27piD46ZlKfqBOSF59egjPM11ZQCFP449uJIS5PJPq8hQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2029.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:184::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 16:49:38 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 16:49:38 +0000
Message-ID: <TY3P286MB26119E3AC14A5D4CB47D3D1D98A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 16 Feb 2023 00:49:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <9ef960ae-7b61-9ed3-5bab-822e6d7d5a76@starfivetech.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <9ef960ae-7b61-9ed3-5bab-822e6d7d5a76@starfivetech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DIXsi5xvezAjZ1NCpKzTS1A0"
X-TMN:  [m7JKOPZZzvA2qRVOeDlrKrzPoAD2BSXHSeNwe66uXNvemtc7mwlS972ete66kEIE]
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <760aa378-cb56-160e-a771-5b9f71cd755d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2029:EE_
X-MS-Office365-Filtering-Correlation-Id: db29f8e7-239f-4b39-d67a-08db0f74a051
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAPu7zcqkHN/tJDzC6tcH0Q4HWrCCh+t0gqEreJYix7dCGm/J7wccsU3BpwfNsYmXU0uimq0QNHyw2CEw5MCyCsSzQd02wjYQtIV0aWGrdZGibO2lTTLJ3sbgQ1B3m4uM5F4i34ZT7kwp2f8KNRJe8pI9LeGQdB+7D+zJpPQNBhu3jbCox/wIJMZzBgH2weA85Ulz0moE9tyM6eW+3qmZ4TS23giZq4lVNkqMuHvEFWYiWdHyMFVivBrJ67KhbQYnp1CX96u64uOhBOzZmuXRqgaHQZvVFja6qODfnFa7rBfggBFrewLwtwxFLP2Vq29QeLNDuFvGI9sqwj06vbqugj1h/OPoza30fM62v75ITNcIxKZd6IPb/pn+fdWnN2bh58tF9gG9lE9276eUq8HK5CgNU7AK+YNlnHISm69OXwZKc3p4zkxE2kkWVVc26cbgjF1QuMVLtcWCdwHcv7fmu42AQDeVlndIKLb0yXJmnOmuIsgwA2qNKFTLVNtCvwFU8APW3caZJyR3L1H6VQGKJhk4b79JyzqnKdj4HLUXky3A9rRceOWGamRDCbnUaFyXoTddDpYbbmhZ6XFTId/WA7mNOH0CRwWrIcZsHXagIJr8uou6sKe17x6YX918X4hXk7Cq6mJevUYcjK8C5M+pw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZlTVprVEpob0pqSzMyeml6SXcwaGt4R2x4SDBiT3lVSm1zcDd1YnNXWWJ5?=
 =?utf-8?B?RTdUZ3pxM2JPSTBlQ09aN1l1NFlwdmJsSiswdytmUFFDU1hLbHdyMXlKbDdQ?=
 =?utf-8?B?MjJrN2M1ckJVaURDQWJVa0FPSk1keC92SVFvTDZ3UHYwd3VNYXdXdVdiOXZL?=
 =?utf-8?B?OGh2bXhRc1gwZDV0TVVUcStwaHFSY1g1Ny9EQi9wTmFHM25nN2pIaTNpemV0?=
 =?utf-8?B?dXBsV0RRMmdnV1JVQ3IvUm83ZU94aE5TWHBjbzJPem5KeTQ1SStBOVFQQkJh?=
 =?utf-8?B?Q1V3ZG1PQUVOY2Q2SG56RDZpcEtMbjVWK21mV05tUjBqWEFmSkxFZThuYTJ1?=
 =?utf-8?B?WmFtbSt4bmE4YjNxMVFBUnlsczh3RXZ1bStJT0QzaHE5RkEwZlVPTmZUQTl3?=
 =?utf-8?B?VHU1TEEzT2l5amRTVkdWb3g4R2x3VkFCRXVUK1pxdXJzSksrMlFxUW5OcGhm?=
 =?utf-8?B?emRTT1dQWGZNS3Z1OGVZKzBNSlZPS1ZpWEFWQmw5QUZVNHdESTVGaFRIdDds?=
 =?utf-8?B?eTRYdWdYZGM2ZVhKUnVCdzUzcDF1M3lkMjJHMjNCMWV3MlhpcXZnb1ptdThJ?=
 =?utf-8?B?Z2YwbUlkNyt4S29RQlQzTFc5YmdkRDJWc1p5VDlJaWZiVXh5KzJySEFYRGJG?=
 =?utf-8?B?VHJybzZNdk1WRlkyMjVUdzVFbTJ3eUEyTThsVEl0NGk5QSswaHFCUDZEcWhZ?=
 =?utf-8?B?QkRNcllzM1JFcHoyNXBrL2VWR3VSQVp2aUZmSVp6WmFlV1VacUZVZDhmbnIz?=
 =?utf-8?B?eG84dFdZM0FwZHIvVm9ybDdoSEpUanJGc3oyNEltcFBDZnZuY29PNXFiVmM2?=
 =?utf-8?B?eVBWRThFRG93cSszOGRRZnkyZGZNSUxnbGloOUhYZE02SkVBekxkS3krVTR3?=
 =?utf-8?B?OFY3Z3JkZ2IvbnhkVTlaei95SERnNDh2R00xSEloSzlKeWg1aWpQNkFSZlNp?=
 =?utf-8?B?UW80bzJFWGlnbGsva3FzVFRnMURNZCsyWEs1dm1PbTcrczhZWjBpQlNuYXpm?=
 =?utf-8?B?c1h4bCtRUG5ocHV4Ti9WaWx1bHJia3dkanIrNURLYUFveXNaa2JYRG11YUU5?=
 =?utf-8?B?RGFPOUlRZVlQZUs1K1dKNXhNTWFNU21HMzU0bklHaGw3bkdlcU5COVNGR1NZ?=
 =?utf-8?B?YitBUWp0MTBBV2ZoNFdvb1JvSzB0TVBRSlhQOVRRNzBpRjZMVXY2S2NZenNr?=
 =?utf-8?B?d0xKSSs0TmdJamhzTVdHOXpTR0JsMUtxTnIvOXNuZGxKWG9OUmZPRnpDcXlR?=
 =?utf-8?B?WEhjT1NOUGpqelhWeUZkQzNwVkZEUVRmUndoQUxYb045UU5yMExiK2IzNkFF?=
 =?utf-8?B?WkR1RW4rWkFiK2YyckVqdUpKZ3NYVUQ3UXhFditzNVdyd3lpaUVyTG94T29y?=
 =?utf-8?B?V3VWdm5xQ0w1UWN2WEloT1FwMXFoQytlWHN5SVpUaThORm41Qld3aDVTaE5R?=
 =?utf-8?B?YXhnRnZQaEdkOHZTS3daVmhaSmtCSmZOQWRNN2ducmpDSGNPVWx2QWMvOTJR?=
 =?utf-8?B?c1oyQm12MWhmOWNoNnJPVGNMVzFaUjl3bWpqcWV6L2pTLyt2ZVdKdUFtZENx?=
 =?utf-8?B?ZEw2RDU2bEhjaHNWdi9UY0hZK1RRUHEzMHZBK21VdzQ1RitJYWRjSjNDMGo4?=
 =?utf-8?B?Y2JWWnd0d1RIcEJSYjRFbzUvZXlQZ01zYWlCdkFzTlRCVlRObUt3MHZXeGpT?=
 =?utf-8?B?ZnBGTXM0OU9RNGVjOTY5NjlHRW43YXhqV0FEU0F6TndJUGxOY0U2WDB6Y3p6?=
 =?utf-8?B?UVJPWW1hSlJtdlpHcGV3aVdHSjMvcW9HTjdLSW9vRTY2UENMdHhwMVdrZTc1?=
 =?utf-8?B?bldyc09QZHpzYnBneDVEZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db29f8e7-239f-4b39-d67a-08db0f74a051
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 16:49:38.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2029
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------DIXsi5xvezAjZ1NCpKzTS1A0
Content-Type: multipart/mixed; boundary="------------qy007dIJrKKwSgzUv0zy0WUq";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: William Qiu <william.qiu@starfivetech.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Message-ID: <760aa378-cb56-160e-a771-5b9f71cd755d@outlook.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <TY3P286MB26111053410F3F96C9C71D2798A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <9ef960ae-7b61-9ed3-5bab-822e6d7d5a76@starfivetech.com>
In-Reply-To: <9ef960ae-7b61-9ed3-5bab-822e6d7d5a76@starfivetech.com>

--------------qy007dIJrKKwSgzUv0zy0WUq
Content-Type: multipart/mixed; boundary="------------qD761AineHL8u4fTvpoLQUDR"

--------------qD761AineHL8u4fTvpoLQUDR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gV2lsbGlhbSwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5LiBTbyB0aGVyZSdzIHY1
IHNlcmllcz8gQnR3LCBwbGVhc2UgZml4IG1haW50YWluZXIgDQppbmZvcm1hdGlvbjoNCg0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJpc2N2L3BhdGNo
LzIwMjMwMjE1MDgwMjAzLjI3NDQ1LTEtbHVrYXMuYnVsd2FobkBnbWFpbC5jb20vDQoNCkJl
c3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+DQo+IE9uIDIwMjMvMi8xNSAxOTo1OSwgU2hl
bmd5dSBRdSB3cm90ZToNCj4+IEhlbGxvIFdpbGxpYW0sDQo+Pg0KPj4gQXJlIHlvdSBzdXJl
IGNoYW5naW5nIGRyaXZlciBpcyBiZXR0ZXIgdGhhbiBjaGFuZ2luZyB5YW1sIGJpbmRpbmdz
PyBBbGwNCj4+DQo+PiBwcmV2aW91cyB2ZXJzaW9uIHNlbnQgd2FzIHN5c2NvbiBhbmQgc3lz
cmVnIHNlZW1zIG5vdCBjb25zaXN0ZW50IHdpdGgNCj4+DQo+PiBvdGhlciBjb2Rlcy4NCj4+
DQo+PiBCZXN0IHJlZ2FyZHMsDQo+Pg0KPj4gU2hlbmd5dQ0KPj4NCj4gSGkgU2hlbmd5dSwN
Cj4NCj4gQWZ0ZXIgZGlzY3Vzc2luZyB3aXRoIGNvbGxlYWd1ZXMsIHdlIGRlY2lkZWQgdG8g
cmVzdG9yZSB0aGUgbGFibGUgbmFtZSB0bw0KPiBzeXNfc3lzY29uLCBhbmQgc3lzcmVnIHdh
cyBqdXN0IGEgdW5pcXVlIG5hbWUgZm9yIHRoZSBmdW5jdGlvbmFsaXR5IG9mIE1NQywNCj4g
d2hpY2ggd2lsbCBiZSB1c2VkIGluIGFsbCBmdXR1cmUgdmVyc2lvbnMuDQo+DQo+IFRoYW5r
cyBmb3IgdGFraW5nIHRpbWUgcmV2aWV3aW5nIHRoaXMgcGF0Y2ggc2VyaWVzLg0KPg0KPiBC
ZXN0IFJlZ2FyZHMNCj4gV2lsbGlhbQ0KPg0KPj4+IEFkZCBkb2N1bWVudGF0aW9uIHRvIGRl
c2NyaWJlIFN0YXJGaXZlIGRlc2lnbndhcmUgbW9iaWxlIHN0b3JhZ2UNCj4+PiBob3N0IGNv
bnRyb2xsZXIgZHJpdmVyLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogV2lsbGlhbSBRaXUg
PHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+PiAt
LS0NCj4+PiAgwqAgLi4uL2JpbmRpbmdzL21tYy9zdGFyZml2ZSxqaDcxMTAtbW1jLnlhbWzC
oMKgwqDCoCB8IDc3ICsrKysrKysrKysrKysrKysrKysNCj4+PiAgwqAgMSBmaWxlIGNoYW5n
ZWQsIDc3IGluc2VydGlvbnMoKykNCj4+PiAgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3RhcmZpdmUsamg3MTEwLW1tYy55
YW1sDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9zdGFyZml2ZSxqaDcxMTAtbW1jLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL3N0YXJmaXZlLGpoNzExMC1tbWMueWFtbA0KPj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi41MWUxYjA0ZTc5
OWYNCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9zdGFyZml2ZSxqaDcxMTAtbW1jLnlhbWwNCj4+PiBAQCAtMCww
ICsxLDc3IEBADQo+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25s
eSBPUiBCU0QtMi1DbGF1c2UNCj4+PiArJVlBTUwgMS4yDQo+Pj4gKy0tLQ0KPj4+ICskaWQ6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21tYy9zdGFyZml2ZSxqaDcxMTAtbW1j
LnlhbWwjDQo+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KPj4+ICsNCj4+PiArdGl0bGU6IFN0YXJGaXZlIERlc2lnbndhcmUg
TW9iaWxlIFN0b3JhZ2UgSG9zdCBDb250cm9sbGVyDQo+Pj4gKw0KPj4+ICtkZXNjcmlwdGlv
bjoNCj4+PiArwqAgU3RhckZpdmUgdXNlcyB0aGUgU3lub3BzeXMgZGVzaWdud2FyZSBtb2Jp
bGUgc3RvcmFnZSBob3N0IGNvbnRyb2xsZXINCj4+PiArwqAgdG8gaW50ZXJmYWNlIGEgU29D
IHdpdGggc3RvcmFnZSBtZWRpdW0gc3VjaCBhcyBlTU1DIG9yIFNEL01NQyBjYXJkcy4NCj4+
PiArDQo+Pj4gK2FsbE9mOg0KPj4+ICvCoCAtICRyZWY6IHN5bm9wc3lzLWR3LW1zaGMtY29t
bW9uLnlhbWwjDQo+Pj4gKw0KPj4+ICttYWludGFpbmVyczoNCj4+PiArwqAgLSBXaWxsaWFt
IFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbT4NCj4+PiArDQo+Pj4gK3Byb3Bl
cnRpZXM6DQo+Pj4gK8KgIGNvbXBhdGlibGU6DQo+Pj4gK8KgwqDCoCBjb25zdDogc3RhcmZp
dmUsamg3MTEwLW1tYw0KPj4+ICsNCj4+PiArwqAgcmVnOg0KPj4+ICvCoMKgwqAgbWF4SXRl
bXM6IDENCj4+PiArDQo+Pj4gK8KgIGNsb2NrczoNCj4+PiArwqDCoMKgIGl0ZW1zOg0KPj4+
ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IGJpdSBjbG9jaw0KPj4+ICvCoMKgwqDCoMKg
IC0gZGVzY3JpcHRpb246IGNpdSBjbG9jaw0KPj4+ICsNCj4+PiArwqAgY2xvY2stbmFtZXM6
DQo+Pj4gK8KgwqDCoCBpdGVtczoNCj4+PiArwqDCoMKgwqDCoCAtIGNvbnN0OiBiaXUNCj4+
PiArwqDCoMKgwqDCoCAtIGNvbnN0OiBjaXUNCj4+PiArDQo+Pj4gK8KgIGludGVycnVwdHM6
DQo+Pj4gK8KgwqDCoCBtYXhJdGVtczogMQ0KPj4+ICsNCj4+PiArwqAgc3RhcmZpdmUsc3lz
cmVnOg0KPj4+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvcGhhbmRsZS1hcnJheQ0KPj4+ICvCoMKgwqAgaXRlbXM6DQo+Pj4gK8KgwqDCoMKgwqAg
LSBpdGVtczoNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IHBoYW5k
bGUgdG8gU3lzdGVtIFJlZ2lzdGVyIENvbnRyb2xsZXIgc3lzY29uIG5vZGUNCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IG9mZnNldCBvZiBTWVNfU1lTQ09OU0FJ
Rl9fU1lTQ0ZHIHJlZ2lzdGVyIGZvciBNTUMgY29udHJvbGxlcg0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogc2hpZnQgb2YgU1lTX1NZU0NPTlNBSUZfX1NZU0NG
RyByZWdpc3RlciBmb3IgTU1DIGNvbnRyb2xsZXINCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
IC0gZGVzY3JpcHRpb246IG1hc2sgb2YgU1lTX1NZU0NPTlNBSUZfX1NZU0NGRyByZWdpc3Rl
ciBmb3IgTU1DIGNvbnRyb2xsZXINCj4+PiArwqDCoMKgIGRlc2NyaXB0aW9uOg0KPj4+ICvC
oMKgwqDCoMKgIFNob3VsZCBiZSBmb3VyIHBhcmFtZXRlcnMsIHRoZSBwaGFuZGxlIHRvIFN5
c3RlbSBSZWdpc3RlciBDb250cm9sbGVyDQo+Pj4gK8KgwqDCoMKgwqAgc3lzY29uIG5vZGUg
YW5kIHRoZSBvZmZzZXQvc2hpZnQvbWFzayBvZiBTWVNfU1lTQ09OU0FJRl9fU1lTQ0ZHIHJl
Z2lzdGVyDQo+Pj4gK8KgwqDCoMKgwqAgZm9yIE1NQyBjb250cm9sbGVyLg0KPj4+ICsNCj4+
PiArcmVxdWlyZWQ6DQo+Pj4gK8KgIC0gY29tcGF0aWJsZQ0KPj4+ICvCoCAtIHJlZw0KPj4+
ICvCoCAtIGNsb2Nrcw0KPj4+ICvCoCAtIGNsb2NrLW5hbWVzDQo+Pj4gK8KgIC0gaW50ZXJy
dXB0cw0KPj4+ICvCoCAtIHN0YXJmaXZlLHN5c3JlZw0KPj4+ICsNCj4+PiArdW5ldmFsdWF0
ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4+ICsNCj4+PiArZXhhbXBsZXM6DQo+Pj4gK8KgIC0g
fA0KPj4+ICvCoMKgwqAgbW1jQDE2MDEwMDAwIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgY29t
cGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtbW1jIjsNCj4+PiArwqDCoMKgwqDCoMKgwqAg
cmVnID0gPDB4MTYwMTAwMDAgMHgxMDAwMD47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNsb2Nr
cyA9IDwmc3lzY3JnIDkxPiwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgPCZzeXNjcmcgOTM+Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoCBjbG9jay1uYW1lcyA9ICJi
aXUiLCJjaXUiOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXNldHMgPSA8JnN5c2NyZyA2ND47
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJlc2V0LW5hbWVzID0gInJlc2V0IjsNCj4+PiArwqDC
oMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9IDw3ND47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGZp
Zm8tZGVwdGggPSA8MzI+Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoCBmaWZvLXdhdGVybWFyay1h
bGlnbmVkOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBkYXRhLWFkZHIgPSA8MD47DQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHN0YXJmaXZlLHN5c3JlZyA9IDwmc3lzX3N5c2NvbiAweDE0IDB4MWEg
MHg3YzAwMDAwMD47DQo+Pj4gK8KgwqDCoCB9Ow0K
--------------qD761AineHL8u4fTvpoLQUDR
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------qD761AineHL8u4fTvpoLQUDR--

--------------qy007dIJrKKwSgzUv0zy0WUq--

--------------DIXsi5xvezAjZ1NCpKzTS1A0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPtDRUACgkQX75KBAfJ
sRkOcA//f74lsVw3junEuy1EwEmdYqsbNTSX4vDyHUATc9fp/aYC1uAAqj+T4zV9
FnXh78PW4fBp9ZB9xVSqRNpJwEoZJlrobM5vlna8S7KcKXyvbQgnZZP0p7Ma1Yqu
GJSTSeajUcsWzZ9V9rHOhY25toB0ldAEMf4F9k9fDG30wX+lw/4t4CMdqmHcyn5r
54fcZDJtk0aFDzm3oWOQdZ6bXRIz5uaqJu1hhDksGhho3EUFOHnW5cP+y4KjBBiN
mpAfwf6fwpw/EqxN1oTC2/l+YHNHI09WQlfqGFwEgO2XgT3MiSYFefxDsmSpsToO
vLW2IzraZQy/BYAgwSROf7GBQrAIkkIGEIznTkNOT3RpezoAAt3yOrXQxsdTVlP3
YPWZHkaBE4h4xV4Pb/fAyDPZY4X6h0QhWkE6DpGdUmiiR918NmoYhsjLqOEDAQgY
Fy7NKkgWrR+hEc1rLIdfR6+uYPmnAY27n61BYSB003vZnDMN8EJJ7QgEJTt0leIF
tW1lqvCkpdzzKWIKgOyulCsAc17+j9e49Wda/LNsPwsLgYlr0oMUAbzskmCmRQkT
oLPaoziLXx8TSPIsPssDFAe4rgDEH2vpykaAHv1BO0nRbFxsFeM8ccdWJYOzZZKp
H4Dm3uP5OXA+8Pl5dzGfxllAsTt4XsI+s2Ady2RUkojePOY1HGc=
=AsPX
-----END PGP SIGNATURE-----

--------------DIXsi5xvezAjZ1NCpKzTS1A0--
