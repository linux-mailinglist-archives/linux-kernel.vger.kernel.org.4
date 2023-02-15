Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494EA697B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBOMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjBOMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:04:12 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2097.outbound.protection.outlook.com [40.92.52.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC637716;
        Wed, 15 Feb 2023 04:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwiSyGKfAs92gMbDsfWw2gMoeLtC/hlXGc+rvIm121SSnAYzJZgcSWqMJ3P2TrYRWKdb9D1kur36ow4Os0bAMk689Lr8T4kCXSXlEZK6NyTbKN/LILXpWdAffKd56jn+amqF63AF3k1ZkNt/F/GvzJpMX/ZWhFIAdItKQNMvejoeKWiQx1jrL+90TzipkHhEDxix56R5veNcg/zcdyplHsxWHR04W0gwsn0hcisl/eaDIhO/CLmfIqHcztOHy2iKhjRvt+AJqw7G14Nd+n/5vQlfVsRJShgBr6em8q1X0qiES3cVQ75UbUqxixTeJrCMe6Bi50PcsdsLS//DffCCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp//OpfQPC2sr/xdmIIHQJOOmPuHo7Kig0Ten0EaQB8=;
 b=hYPt+sI8saTYVuDp3kGBKI7+7JrjmqmWg0xCy2DRhG/X3YfXL4i9ZJMoM45EUlk6WKUR21fvD/QphU+LJQGYZRGBqZZsdzj/nUCq1AYAM/n1gLXMnxL2R3QlkQeOKsS0/QdOtUJXIS1BiN/iXJGbNsUVf/EtzATpUm1xuKcJhcycqR4rO6krmFR6XxslaZfUHsNPhx2Ap01sDQveLFk8k2/hC8tYsJZVJCNA2PP2rbeY1EKdyzaVq4gZC0LxQC+FKInIzzgJjQRJW/StefIPKOiHw0gmFlxnkZ3t46XPsE0cIKEdatouFaeea2Ui8w5/XI+AmUs5bx47Y5P/eGt++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp//OpfQPC2sr/xdmIIHQJOOmPuHo7Kig0Ten0EaQB8=;
 b=AjPbWXxYZWQe7I53u9yZSpCo65h5AVnUJWO/R2kSW0DSrEZ3IgDJzVHEp/4abNqlsc0kMhKNVU0q3xRDP2mATHCLZ2pH3AkX9geeYvnhw+KAhocAbo3iJuGV/docnlVh7f+x2QtVqMIjn3A/Z0WEWM+dpkOU6SBEyBd15txyOiqMSXGSh8Mm/wD1uNDLyB3WAktfLCkz2ALlgXa1K/2+XWYcwAPiIFm/Jdpj+u8ZNKjkorPTMlnURawEPgKhiIE4fopDPgj26amGr1fs14Y7fDVrHmeo8XWtwzZCOLdMCCZ4B5fVE8zEPD1dYai0WZqQ2wD18JGiz7q9bGyQRs4MZA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYYP286MB1620.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 12:04:01 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 12:04:01 +0000
Message-ID: <TY3P286MB26117CEA02DF37498969BAE598A39@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 15 Feb 2023 20:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
From:   Shengyu Qu <wiagn233@outlook.com>
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
 <a7b51602-3ba4-d822-4da0-f6e51e7dddea@outlook.com>
In-Reply-To: <a7b51602-3ba4-d822-4da0-f6e51e7dddea@outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7BpbygI9hta5voDBHWreMKqk"
X-TMN:  [kIxBx4UmqPvcWn1ke9ZY0mbsN99BR1cTjGv3CkGAx4Bd+qm19epgBqTN+X0hBU2Q]
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <0097920d-28f9-0216-bb09-1ac923775a18@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYYP286MB1620:EE_
X-MS-Office365-Filtering-Correlation-Id: c461a202-3809-4f28-e562-08db0f4cb9db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yupeHwtN4knux2UQ3RojRqxj7cctmT5pjqarY7ZbjxEJJ/OCgU0MCUvSnCDDDKxhHXbw/cnV0LD/e6VWyWpLKxaQl3QBnUL3xGrBnY7CAdByAKajphqGx49kxctR2j1IwKjlawaNqOxdLRoj9GCVp/ONLWm37ybt6fk8gxeRVTVfY3tNiWQH6nFor5senIyK9/3wplFmWtXmewO1qoLHCpZcITB+uf6qqX+gnvQVrDTGoKx878PRHqectVy4TqYJrdpcV/4WEHHVp9qcQcm5BnJ8GZwbHT6X/lKDAJV0eoHqc6euxvihWCJfhc2PEE598DeY79DDnZ4BMaNtafgdHPnAaK2C1P+XIiVTFjtoYrvGZUyBpXLqg8KFQ+VW7nOXM+zZI+CN4o5Jkh4H9ECyx7SgT0f7698Q12HgcGuY8CwrMMMmEc7Nud8IZDgMU9REl1Q4Q+ClO3iR2DH5qg/zyexDQZAHKTdoj+aebALGJmboDZ7SRWlttyfnpoyps3hdxg8VeafzjlBQp9rSVuUPVW3oi0x+E0AOHA/r2w9QJppoTcMn2xYTvZqxhFlEkDOS0Yq5ZmmcG2Z2/PFFzuCx6jZp+209CkBsg3EtfUTbpJ1s2nMPY9FUukMOoD3+/RgTqG21UquB0PGsc5+Q+05f6A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGF5enVrT1VwVndLb3MrbFFlVE9GSSsrUVFoYkV3Q3Z2TlBiL3ZXeEVqK1Z1?=
 =?utf-8?B?V2s5R3RqSUNoRXZMakplaVJ4Tm9YamtnUkZKN1ErNUFERWthdmZPT3BLVFdx?=
 =?utf-8?B?eE9YQXZPL2dJM2xLZ3VMN09oa1d1RmZJWG1aZDZNdGtrb0djZFlFNmZGTXdG?=
 =?utf-8?B?Nmdtb2xzOFJOUzhwbkQ2Q1pJTXc1NVBoWW11T0F6clZ1d2kyQ2FGY2hjZ1F6?=
 =?utf-8?B?ckhidDZCM05jK2ZicFE3S1ZmNWRieGkwUnh5YXB1c2RzQ2FRNDZDMmNPL0Yv?=
 =?utf-8?B?ZWZUV3lGbytYVWxqTktJVk4rMDFsRDc3Q0R0WWN3dkdxNHYwWEJuNHdTOGFj?=
 =?utf-8?B?U09nZ0xjTDZaVW5aL0o0bjBBelhKcWpRd0htUHBtTWs3RkhoWFpqdWRDSHBP?=
 =?utf-8?B?ci9qa1lHK3dBMks2b09HWnJ0bHN6SGZiTWJGR2VNczRWcVByNVVxZzZrdjNo?=
 =?utf-8?B?T3RqT1VPbDIvclNocXhOZUJhTlpKalA5UklRMEc4em5mZjJPcXRTV0NNUE5S?=
 =?utf-8?B?WGV6UWZ0ZzQ4YVdCY0JWWitRYUM4bGtrWjBVQU5paDNkTTd5MlhBZHQ2WFNr?=
 =?utf-8?B?eVhzcFFiWVZ0aXdGVSthUVUybUdOY3hUODZjWXphbW9VTS8vSmhwOVAvUjJD?=
 =?utf-8?B?MzVpdG9WZDh4QzVzT0d6RzBXM1FGQWZmbTk3QWV1L0xUSmxQM2dwTGJsVm5L?=
 =?utf-8?B?dFN5RmNySVFLeXVMUWM2NWlLTkZ4c05sR0F1cFFUOUx4Wk8rNHRUWEFUMDdH?=
 =?utf-8?B?RnJlVzhMQ1NicE5wbTlhRUMzdTBaTmJpWG9ua1lyZlIrMzVqQ2w1SmxzVk9q?=
 =?utf-8?B?cjFDY0wrZmZGWERWMUpLVGh5Q2RLMyt0MUxncERWeUtNYkdIRVR6SkxZVUUw?=
 =?utf-8?B?aytmSzRqeU5mbld2L293OXRlZjJvNjcvK3NVNTRNazFtUXk0dllmQmdGMTdJ?=
 =?utf-8?B?R21scFljU0xEc1h2bUdVSmpIb2FJMWZOZDFLY25Rd0NDNGUxaTY2R2U1WHVS?=
 =?utf-8?B?OFlFZk9WcXBTeW9hVkdnQ0l6SDRtZDViVDltUE1HZ09rMTJ5NHJrYnIwVFhu?=
 =?utf-8?B?WDU3bkdWNXBRTlB0amxabU9oUU5OSWtkWkUxWElvejdEL1ZuenV2ZEtqTGlP?=
 =?utf-8?B?UExMaFpXUTF5blhGbDRUaHMvVE83OG5yWUVnZVpiV0ttbHZxWjM4MWQvbkgw?=
 =?utf-8?B?VDMwbzdPT2t2UlR2ZjJSWEpZQldoNzR0TFNmYnBJS3pMN0h6UkIvQkE4RFpw?=
 =?utf-8?B?cHBHbTZURnhWS2ZVRFhQUUhPZDZObHoxc0N2dUhLWlpwdXhaMTJBcFI4T2lt?=
 =?utf-8?B?c3pCODRGMWxiZ1hlVVVsWFVxSGZ4RTFSUnNWWlpRRW5rdWNmL0tsNWpaN0dW?=
 =?utf-8?B?NU9ac2w4d0RER1dSQUwzUXFtRzkwLzByUVdURnU1bnFrckgzZVlyaTFmMjF6?=
 =?utf-8?B?VGt6U2dTb3ZCYlpyazlWTTNROEEvcEtGTC84SmF0aGlQSlhSazZZcStPQS84?=
 =?utf-8?B?eVczdFlLS0hwQjJJcVBHckZEM1RVMWJMWDBJbHNlaFB0RE93V29ndjI4emp2?=
 =?utf-8?B?Q1ZGQ3R3aEdmNE11V0lyTkJOb28vSzNkTkp0U3pzOFpDOEdQWUxQK1piZThM?=
 =?utf-8?B?Q29abnl4YzVOMTJ4YTFCZVhidzV6NWM2cjlyZzh3ZXFpTm5abnptMVRFWCtI?=
 =?utf-8?B?cVBKQ0tmVFQrOUw0NC81YWtMVktrWWUzaHVGTkJRczVWY1lReFovNmNuWHM4?=
 =?utf-8?B?MHNySmxHanYxL0k0eklralNHc05ndUloUDBDNnlRRWFpdHNiUndhSCtueUJF?=
 =?utf-8?B?WUpuU3U5T0xPTWdrTTlXZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c461a202-3809-4f28-e562-08db0f4cb9db
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:04:01.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1620
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

--------------7BpbygI9hta5voDBHWreMKqk
Content-Type: multipart/mixed; boundary="------------jHyRRH3P0WH9IGSML3SSPeL0";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: William Qiu <william.qiu@starfivetech.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Message-ID: <0097920d-28f9-0216-bb09-1ac923775a18@outlook.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add StarFive MMC module
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-2-william.qiu@starfivetech.com>
 <a7b51602-3ba4-d822-4da0-f6e51e7dddea@outlook.com>
In-Reply-To: <a7b51602-3ba4-d822-4da0-f6e51e7dddea@outlook.com>

--------------jHyRRH3P0WH9IGSML3SSPeL0
Content-Type: multipart/mixed; boundary="------------Nuz36agsDKTJU08rsWZZgAGA"

--------------Nuz36agsDKTJU08rsWZZgAGA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29ycnksIGZvcmdvdCB3aGF0IEkgc2FpZC4gSSBkaWRuJ3Qgc2VlIEtyenlzenRvZidzIHJl
cGx5IG9uIFYzIHNlcmlyZXMuDQoNCkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+IEhl
bGxvIFdpbGxpYW0sDQo+DQo+IEFyZSB5b3Ugc3VyZSBjaGFuZ2luZyBkcml2ZXIgaXMgYmV0
dGVyIHRoYW4gY2hhbmdpbmcgeWFtbCBiaW5kaW5ncz8gQWxsDQo+DQo+IHByZXZpb3VzIHZl
cnNpb24gc2VudCB3YXMgc3lzY29uIGFuZCBzeXNyZWcgc2VlbXMgbm90IGNvbnNpc3RlbnQg
d2l0aA0KPg0KPiBvdGhlciBjb2Rlcy4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPg0KPiBTaGVu
Z3l1DQo+DQo+PiBBZGQgZG9jdW1lbnRhdGlvbiB0byBkZXNjcmliZSBTdGFyRml2ZSBkZXNp
Z253YXJlIG1vYmlsZSBzdG9yYWdlDQo+PiBob3N0IGNvbnRyb2xsZXIgZHJpdmVyLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRl
Y2guY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gwqAgLi4uL2JpbmRpbmdzL21t
Yy9zdGFyZml2ZSxqaDcxMTAtbW1jLnlhbWzCoMKgwqDCoCB8IDc3ICsrKysrKysrKysrKysr
KysrKysNCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspDQo+PiDCoCBj
cmVhdGUgbW9kZSAxMDA2NDQgDQo+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL3N0YXJmaXZlLGpoNzExMC1tbWMueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgDQo+
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3RhcmZpdmUsamg3
MTEwLW1tYy55YW1sIA0KPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL3N0YXJmaXZlLGpoNzExMC1tbWMueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTFlMWIwNGU3OTlmDQo+PiAtLS0gL2Rldi9udWxs
DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N0YXJm
aXZlLGpoNzExMC1tbWMueWFtbA0KPj4gQEAgLTAsMCArMSw3NyBAQA0KPj4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UNCj4+ICsl
WUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL21tYy9zdGFyZml2ZSxqaDcxMTAtbW1jLnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0
bGU6IFN0YXJGaXZlIERlc2lnbndhcmUgTW9iaWxlIFN0b3JhZ2UgSG9zdCBDb250cm9sbGVy
DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArwqAgU3RhckZpdmUgdXNlcyB0aGUgU3lu
b3BzeXMgZGVzaWdud2FyZSBtb2JpbGUgc3RvcmFnZSBob3N0IGNvbnRyb2xsZXINCj4+ICvC
oCB0byBpbnRlcmZhY2UgYSBTb0Mgd2l0aCBzdG9yYWdlIG1lZGl1bSBzdWNoIGFzIGVNTUMg
b3IgU0QvTU1DIGNhcmRzLg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gK8KgIC0gJHJlZjogc3lu
b3BzeXMtZHctbXNoYy1jb21tb24ueWFtbCMNCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+
ICvCoCAtIFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0KPj4g
Kw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArwqAgY29tcGF0aWJsZToNCj4+ICvCoMKgwqAgY29u
c3Q6IHN0YXJmaXZlLGpoNzExMC1tbWMNCj4+ICsNCj4+ICvCoCByZWc6DQo+PiArwqDCoMKg
IG1heEl0ZW1zOiAxDQo+PiArDQo+PiArwqAgY2xvY2tzOg0KPj4gK8KgwqDCoCBpdGVtczoN
Cj4+ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IGJpdSBjbG9jaw0KPj4gK8KgwqDCoMKg
wqAgLSBkZXNjcmlwdGlvbjogY2l1IGNsb2NrDQo+PiArDQo+PiArwqAgY2xvY2stbmFtZXM6
DQo+PiArwqDCoMKgIGl0ZW1zOg0KPj4gK8KgwqDCoMKgwqAgLSBjb25zdDogYml1DQo+PiAr
wqDCoMKgwqDCoCAtIGNvbnN0OiBjaXUNCj4+ICsNCj4+ICvCoCBpbnRlcnJ1cHRzOg0KPj4g
K8KgwqDCoCBtYXhJdGVtczogMQ0KPj4gKw0KPj4gK8KgIHN0YXJmaXZlLHN5c3JlZzoNCj4+
ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRs
ZS1hcnJheQ0KPj4gK8KgwqDCoCBpdGVtczoNCj4+ICvCoMKgwqDCoMKgIC0gaXRlbXM6DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IHBoYW5kbGUgdG8gU3lzdGVt
IFJlZ2lzdGVyIENvbnRyb2xsZXIgDQo+PiBzeXNjb24gbm9kZQ0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBvZmZzZXQgb2YgU1lTX1NZU0NPTlNBSUZfX1NZU0NG
RyByZWdpc3RlciANCj4+IGZvciBNTUMgY29udHJvbGxlcg0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoCAtIGRlc2NyaXB0aW9uOiBzaGlmdCBvZiBTWVNfU1lTQ09OU0FJRl9fU1lTQ0ZHIHJl
Z2lzdGVyIA0KPj4gZm9yIE1NQyBjb250cm9sbGVyDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
IC0gZGVzY3JpcHRpb246IG1hc2sgb2YgU1lTX1NZU0NPTlNBSUZfX1NZU0NGRyByZWdpc3Rl
ciBmb3IgDQo+PiBNTUMgY29udHJvbGxlcg0KPj4gK8KgwqDCoCBkZXNjcmlwdGlvbjoNCj4+
ICvCoMKgwqDCoMKgIFNob3VsZCBiZSBmb3VyIHBhcmFtZXRlcnMsIHRoZSBwaGFuZGxlIHRv
IFN5c3RlbSBSZWdpc3RlciANCj4+IENvbnRyb2xsZXINCj4+ICvCoMKgwqDCoMKgIHN5c2Nv
biBub2RlIGFuZCB0aGUgb2Zmc2V0L3NoaWZ0L21hc2sgb2YgDQo+PiBTWVNfU1lTQ09OU0FJ
Rl9fU1lTQ0ZHIHJlZ2lzdGVyDQo+PiArwqDCoMKgwqDCoCBmb3IgTU1DIGNvbnRyb2xsZXIu
DQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArwqAgLSBjb21wYXRpYmxlDQo+PiArwqAgLSBy
ZWcNCj4+ICvCoCAtIGNsb2Nrcw0KPj4gK8KgIC0gY2xvY2stbmFtZXMNCj4+ICvCoCAtIGlu
dGVycnVwdHMNCj4+ICvCoCAtIHN0YXJmaXZlLHN5c3JlZw0KPj4gKw0KPj4gK3VuZXZhbHVh
dGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICvCoCAtIHwN
Cj4+ICvCoMKgwqAgbW1jQDE2MDEwMDAwIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRp
YmxlID0gInN0YXJmaXZlLGpoNzExMC1tbWMiOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHJlZyA9
IDwweDE2MDEwMDAwIDB4MTAwMDA+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIGNsb2NrcyA9IDwm
c3lzY3JnIDkxPiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JnN5
c2NyZyA5Mz47DQo+PiArwqDCoMKgwqDCoMKgwqAgY2xvY2stbmFtZXMgPSAiYml1IiwiY2l1
IjsNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXNldHMgPSA8JnN5c2NyZyA2ND47DQo+PiArwqDC
oMKgwqDCoMKgwqAgcmVzZXQtbmFtZXMgPSAicmVzZXQiOw0KPj4gK8KgwqDCoMKgwqDCoMKg
IGludGVycnVwdHMgPSA8NzQ+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIGZpZm8tZGVwdGggPSA8
MzI+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIGZpZm8td2F0ZXJtYXJrLWFsaWduZWQ7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgZGF0YS1hZGRyID0gPDA+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIHN0
YXJmaXZlLHN5c3JlZyA9IDwmc3lzX3N5c2NvbiAweDE0IDB4MWEgMHg3YzAwMDAwMD47DQo+
PiArwqDCoMKgIH07DQo=
--------------Nuz36agsDKTJU08rsWZZgAGA
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------Nuz36agsDKTJU08rsWZZgAGA--

--------------jHyRRH3P0WH9IGSML3SSPeL0--

--------------7BpbygI9hta5voDBHWreMKqk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPsyh8ACgkQX75KBAfJ
sRnRjQ/7BvYJ6DMpaLxngpffPat5ea1WdzaULzaDuachd+FGYj2y1+egcTu6N4VY
FTBM8CJeqJn/BM4blfY2zfr8/YsSogYXVXN9CM/fc1UudoZgzWlG+WTN2ZiX0xQ9
qoO39OV0PnkiAZS77ts7YL2yd5rVgl+jfIJwqoVizyaPNDyHmhuVn2NjDHe1yecj
jW6wu7FVa0FNrcw6C+ruHWJ4WbdBYh44y+YyP1Q7ZZy85r2aeKn8Lahp5AtbbukL
4LwBz8Ct+xqLaQzovqcmlwTMDPDwQWOU9S+e7PZzxnuE7vMXHMrS7IZvksMUzKIt
AVnQ7MYJE6WroyPtRu2RkjDLWVz8/ewql1wGcNfZCPF0fx/d0r3yuQs+X3gRpS1J
7O212J12eO7FijV73CmGDggvgsDxJDqeuJnmJdwj6qkt3oF19mZtvjQPdJqVDmG5
Ds3SX3DgzvEItAH8F/32M1Few+bcrt4o+X5ZvKVGSRs1VU4f1bpoAcuIzj7t+JBz
iuU3C5Ulwrw3t9a+EwmQb1BV+5VK/Rdl22dNaZsRTTqKUrG2uPIeatuhMPbBcM92
4MAwecjUOcrO53jjdJNX249aC+puwIMAZFt/pnm6ghNiuXm1OWcFav7z5BCkdo3r
U9SMzPpxWyyRlel99esev3NZfkE587K3UhCrSZvHigqzsCH7Pcg=
=jdBC
-----END PGP SIGNATURE-----

--------------7BpbygI9hta5voDBHWreMKqk--
