Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D616569B93A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBRKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:08:32 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2049.outbound.protection.outlook.com [40.92.98.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B26244A9;
        Sat, 18 Feb 2023 02:08:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6o/zXfJKuDd9jsYDhtx74RNaUY4gCo0V2QduruTuZKTp+YsBqtAl0HnhXS13w0zwgiGD5HCzxnWzvn5YzwaRvMa+1Uvkk1LD/2/5j+GmWKQw8a/Nvjav6pZ9KN4cXzDwwj4MGw8mCHANzQ4D+UWHmn817JAhDqfoPcailMjwABhMKH0DtHsNPh/MUDvssbfY/G33eHdhrrGZuOH9FT4zbFv141ti7ygRkzprR6GGpp0FnUpmSwt8m3Ou7rKgHopo1eQZWd4T/1TJpTZjxSzyAH0Yx6PX8E4Voc6sFC50hZYO1USvwrK3EFbrkf+kCTqJGAa/3raoKFsJarWMLtxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gAjW9dzORa0qbZfp6vGK1Blw5WpmGij5sFUAX9Gi0M=;
 b=JjDheIrORYiAxGmYJmWW05tqvcD4he+rKpbSIGzPmlD6u9V6Mp/KAiEGPll0g4N2KHBr/RwSkesRu6+NQhuS6CiOzZUEj7PznbeFysROIb4dFrcb0kj6NK8kF5bRvpTNSDLLUneZL0t8y2dbUOJn0Unpm0CCSj+TtyBU69A0bzu+HcN3aLCNJsXlPg9alGjloNJuo9aYi0o6aSPjdXnbnsXgCK+VjTmninYv/0igHBrU2vE0Vu4DDxLaGUouZmyQ3omB/WiQDrS0WwzRh9QmKHUeBhoDkks1uPPYwQY8aeNCtGhEgC26/2oninJQCDJWaN4hV42DZUVdWWidPoB4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gAjW9dzORa0qbZfp6vGK1Blw5WpmGij5sFUAX9Gi0M=;
 b=tQBairGqaWGdKApzHBLxf+IqhVV/Fn7GLKqH6XvdZb4Hr+vRa+ZXvGWKlYPj42mWJeUyIvzatqLta34bIShpUdiZB5/uZQ/oCqXF/Sz808YvTCYn++XlrlBHZBuvqrrNMPB33JLRWtNz8TavhZlMLjBL0zTc4Fv3illZ1R7nKt8pZ48cbS3iyiZfM9tCqivktVybMyHNoDvEJZSBemn9M/s2NhIxL2a/T7vq2Qhr542JxSs/F6i/zrA8zQmQEuDloeO2RtaFFKe0zlRrtKOY4g+sXM0u58n9l82T3Jo/1gi6ahpnAZ7E4u+5wOl/W6NfJLY9ccp6a0tNOlUfMnhgfQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2172.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:173::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 10:08:23 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cd65:1f1c:ceda:5979%8]) with mapi id 15.20.6111.018; Sat, 18 Feb 2023
 10:08:23 +0000
Message-ID: <TY3P286MB261122217B621C53B6AC1B3198A69@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sat, 18 Feb 2023 18:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v8 3/3] regulator: axp20x: Add support for AXP313a variant
To:     wens@csie.org, Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230120184500.1899814-1-martin.botka@somainline.org>
 <20230120184500.1899814-4-martin.botka@somainline.org>
 <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pB0f8F0mmFVFj0eCM5ZW34LW"
X-TMN:  [/MgjSptIfjZucPeE9pQxPjN5nBbU6DsGxcYGMM5xy2TGQRK4cD6oneDYiqiU1nUX]
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <be62405d-f4d5-d3a8-97ea-2528707847a9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2172:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0520d1-dfad-4ef2-c339-08db119811ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiw4I5djlL3w8MYs777Y/nSzxiFQvYrK1YQzsHMpndKe4C2IJLCM86neVlo3HRg8QgZs9pggDIzDKj52uAymaSSB2KEL+YvtV13+HLPBGKjvBvu6t7oP4h05Ti0tUuLTxTkQpnFAJ30kVI52NBo9NPMLv5h7TiEb8r44QSSIovu1FTJjViiPPIFdduTGLLqwwZK+hFfLvbwvVcMtpR8lVw4F1Ouq+T3E3MkV3zylp7r9p51BiF5j5DDdEbUSUteUQPxiWw8VeqGd2zVw8zXZxAtgkRBRFYCq8deXkp4QC06Y/gfK3Ts19t9HMTR7mMJ3MwybMmySq6E2SOyEsMiPk7lmhIfZDixBjc2kMaY07X2kPcn6IfuwTq+ynnuSYsXG3fT1QGAD0DvQOiwuM9StEkGvJc0WdBOLrLcPemTGjFQ2wGi4BmhvWIKx4eZ2lFO+3kgfU4hvdaaSaukSY3hvC/gnNgfhx/8QfNh3m208/JjDhOpoB2Z2C2fs0dIA1ZYlgl9UqutqkTayWbDgtrGAh+aX6u8/J413u4Wqd649eJX2WpoMOJjZEJXLIK+Kb6XRy0dQeXr2T0PAT74XzCGIbNEGjF0/aAZLuzZ7FQPmZvBfjzIBRaje22padKdd+H5C+bHoZ6VWTVjwyuumGNtcdw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRjQW9xa0xiMXBoSkRWcGtkODFzQ2ZTbGZQbm04bDV5dXU3dVAxaTVBRktV?=
 =?utf-8?B?d3daOUlEUHQ2a3Q2YS9Wd0ljbGhQMzJ2QWYyeER4RFNOcjlMZUFyK0ZKTWpO?=
 =?utf-8?B?V00xUVFNaENUZ0JyNEJuMEQ4eTV0WndBU0phMlBUelljQ09qZ3JXSlRYQWZX?=
 =?utf-8?B?L1VubytOaVYzeFZWZi9yb1RrT2ZIOFZyMk9KN3Q2VlRWbUZnZ3lmZDFhM2JR?=
 =?utf-8?B?enVxQm9qbGozRW4yWkJ2RVZEZjIyS0EveVBGZlFhU2VrZEhUT2d4N25XSW5h?=
 =?utf-8?B?Qkg5clZldHRjeUZ0WENPM0NhanNTM2pEWUlwc0k5bFZOZ0thOWxqdnpOT08x?=
 =?utf-8?B?Qk1mOHFldURPUFVyRE9vcGxFSzJyaWlYK1RCaGQ2WmllRkIrQ2tvN1RGVXV0?=
 =?utf-8?B?cjV3cExSRTFONTVYRlVaK0ZleVdONHNQeS9GenJmZU5TT0pWMWs4RlAvbllu?=
 =?utf-8?B?RlJhVTJUU0k3MkFyL2xaTTZaQ25NdkJPSFZOWXJsdFBiLzZla2NORytxQlhl?=
 =?utf-8?B?VWpLRDZ0bmVDdkRtVUlqcXNzZzRteEJvSXo5am95VE1CT1dGVWRFZkdzUHdQ?=
 =?utf-8?B?N0dpYjA3T3pVWHcvN2Y1NnBKL3JKRmlFYVVSQjhDZmFiVXdaQzNPTHkxY2w3?=
 =?utf-8?B?ZGFwZWhtWHVRazdpZVNNaHVxaXNzY3Q1d00wQWxjeDQvZTEwNTF0YWZPU3Vs?=
 =?utf-8?B?elp1MzBlcVhqNXZGWmp2cnlwWit0dU83QmJKWkJqTll4elBMQ3ZMU3AxMXR4?=
 =?utf-8?B?VFJ0OWIxNzRVc1o1bnBTWlNCaXZ3Yjg4MTBFamxyb3h2aDJUSGVxS3pQSUJQ?=
 =?utf-8?B?bE8xc1RyMVg0S0ZiQmtkeTBJenA5M3R0TU1LKzY3YnhNWmd4RE1VMmM4Y2dS?=
 =?utf-8?B?QVkzclBtWnJqUzRIVXc2UEZaVmYwTTlMbVR2TXE3Y2VwSmN5a0NTbVVPMUkr?=
 =?utf-8?B?SXEyN0owOFo0NUIvZnFTNlpPdmcwQkttNGorNGhGYXBpYUFQbUtHVldWY2Iy?=
 =?utf-8?B?eWc1TWxXOFdYdGFuekdIRmxyemdlaU1jUGdlVjg5dC9EQ2lPNGphY3o3Z0VQ?=
 =?utf-8?B?RDZhSU9kQyt2eGlmelZodEJoSzd0VEVlc1NQODdDWEg5VHMxQkNvZ29nbUdo?=
 =?utf-8?B?V2hMSCt4eGsyWUNybU9ubStoS3dLMWhjNEljRDJ6WWJGTzBlVlo4MmN4cDRX?=
 =?utf-8?B?a0I4ckNmaUthK3BmUnQ4ejVTajlrbjlCSFZIUk1qZERkbG0zL3dWTWQvS1pX?=
 =?utf-8?B?WmRzd0Zrd0VBeHN4Y0xkLzZWR2JYN3UvVkRVbHdMQmtCWDVnaWlQR1BVUkJN?=
 =?utf-8?B?Sy9QZzdoRWlvOTF3eFBtQ2Yzd3phQnA0bmRYN054QzV5WHVmTFpVL1BESzEw?=
 =?utf-8?B?VFlPYVU5WDVpcVNTYUtXaWI1anBZaVJmWjZRZjZqc1JuRFhERzIySDFIM0Ni?=
 =?utf-8?B?NE0wYmRuZTZKbUxHSGVTT21TSjhyN0MzK2hIUllWa3dnbkZ0emdlbHRwRTZQ?=
 =?utf-8?B?WWhLMFpSM2N4QUxYb25VZUd0V1lSRFVFaTZlL2pCd0kxNkc1VkZhQytPckJQ?=
 =?utf-8?B?YjVxRVExUTZMbGQ3Qm9STzZaL0pBbEY5MFdDOER1Z1p5UTFqdkR5RFVCL2xz?=
 =?utf-8?B?ejJWM29RTFFJNlRLZi9iSFJoNjlpWEhGMkpJd253R0FaQXRBVjhQUDZRTkpy?=
 =?utf-8?B?aGJWZnZLL2tWcXB4YnNOWGtRZXB1VUNWQ01UeW9WS1FaSFcxNFZkZWVBbHFM?=
 =?utf-8?B?Ny9tQzlxS1lvZXBjSE54NUk4bzhsOVFZdk1jUkJFWng2NTFnQUFRcWthQUJy?=
 =?utf-8?B?dDFrUE9NQmVxeUdPR05WZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0520d1-dfad-4ef2-c339-08db119811ca
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 10:08:23.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2172
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

--------------pB0f8F0mmFVFj0eCM5ZW34LW
Content-Type: multipart/mixed; boundary="------------9b3XdZL2QJeY13hMdUooho8q";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: wens@csie.org, Martin Botka <martin.botka@somainline.org>
Cc: martin.botka1@gmail.com, Konrad Dybcio <konrad.dybcio@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jami Kettunen <jamipkettunen@somainline.org>,
 Paul Bouchara <paul.bouchara@somainline.org>, Jan Trmal <jtrmal@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara
 <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <be62405d-f4d5-d3a8-97ea-2528707847a9@outlook.com>
Subject: Re: [PATCH v8 3/3] regulator: axp20x: Add support for AXP313a variant
References: <20230120184500.1899814-1-martin.botka@somainline.org>
 <20230120184500.1899814-4-martin.botka@somainline.org>
 <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>
In-Reply-To: <CAGb2v649yQVcNn7uv1eKtnEDnb=D4X9yGYB1eOC3zeAe+encFg@mail.gmail.com>

--------------9b3XdZL2QJeY13hMdUooho8q
Content-Type: multipart/mixed; boundary="------------HkFMGGm9YQGUs6C0NxR3MuYX"

--------------HkFMGGm9YQGUs6C0NxR3MuYX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWFydGluLA0KDQo+IE9uIFNhdCwgSmFuIDIxLCAyMDIzIGF0IDI6NDUgQU0gTWFydGlu
IEJvdGthDQo+IDxtYXJ0aW4uYm90a2FAc29tYWlubGluZS5vcmc+IHdyb3RlOg0KPj4gVGhl
IEFYUDMxM2EgaXMgeW91ciB0eXBpY2FsIEkyQyBjb250cm9sbGVkIFBNSUMsIGFsdGhvdWdo
IGluIGEgbGlnaHRlcg0KPj4gZmFzaGlvbiBjb21wYXJlZCB0byB0aGUgb3RoZXIgWC1Qb3dl
cnMgUE1JQ3M6IGl0IGhhcyBvbmx5IHRocmVlIERDREMNCj4+IHJhaWxzLCB0aHJlZSBMRE9z
LCBhbmQgbm8gYmF0dGVyeSBjaGFyZ2luZyBzdXBwb3J0Lg0KPj4NCj4+IFRoZSBBWFAzMTNh
IGRhdGFzaGVldCBkb2VzIG5vdCBkZXNjcmliZSBhIHJlZ2lzdGVyIHRvIGNoYW5nZSB0aGUg
RENEQw0KPj4gc3dpdGNoaW5nIGZyZXF1ZW5jeSwgYW5kIHRhbGtzIG9mIGl0IGJlaW5nIGZp
eGVkIGF0IDMgTUh6LiBUaGUgQlNQDQo+PiBkcml2ZXIgaGludHMgYXQgYSByZWdpc3RlciBi
ZWluZyBhYmxlIHRvIGNoYW5nZSB0aGF0LCBidXQgd2UgaGF2ZW4ndA0KPj4gdmVyaWZpZWQg
dGhhdCwgc28gbGVhdmUgdGhhdCBvbmUgb3V0LiBJdCBjYW4gYmUgYWRkZWQgbGF0ZXIsIGlm
IG5lZWRlZA0KPj4gYW5kL29yIHJlcXVpcmVkLg0KPiBUaGUgZGF0YXNoZWV0IHJlbGVhc2Vk
IGJ5IE1hbmdvUGkgc2F5cyB0aGlzIGlzbid0IGNvbmZpZ3VyYWJsZS4gVGhlDQo+IHRoaW5n
IHRoYXQgaXMgY29uZmlndXJhYmxlIGlzIHNwcmVhZC1zcGVjdHJ1bSBvcGVyYXRpb24sIGFu
ZCBtb2RlDQo+IHN3aXRjaGluZyBiZXR3ZWVuIGZpeGVkIFBXTSBhbmQgaHlicmlkIFBGTS9Q
V00uIFNvIGp1c3QgZHJvcCB0aGUNCj4gRENEQyBmcmVxdWVuY3kgc3R1ZmYgYW5kIHVzZSB0
aGUgZGVmYXVsdCBjb2RlIHBhdGguDQoNCllvdSBjb3VsZCBnZXQgZnVsbCBkYXRhc2hlZXQg
b2YgQVhQMzEzQSBoZXJlOg0KDQpodHRwczovL2dpdGh1Yi5jb20vWXV6dWtpSEQvWXV6dWtp
Q2hhbWVsZW9uL2Jsb2IvbWFzdGVyL0RhdGFzaGVldC9BWFAzMTNBX0RhdGFzaGVldF9WMS4w
X2NuLnBkZg0KDQpCdHcgSSdtIHdvcmtpbmcgb24gQVhQMTUwNjAgc3VwcG9ydCBtb3N0bHkg
YmFzZWQgb24geW91ciBzZXJpZXMuDQoNCg0KQmVzdCByZWdhcmRzLA0KDQpTaGVuZ3l1DQoN
Cg==
--------------HkFMGGm9YQGUs6C0NxR3MuYX
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------HkFMGGm9YQGUs6C0NxR3MuYX--

--------------9b3XdZL2QJeY13hMdUooho8q--

--------------pB0f8F0mmFVFj0eCM5ZW34LW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPwo4cACgkQX75KBAfJ
sRmcihAAjEyizRLqeltJfNcC/g9MkIFv60qI+4S+Aw03g4z0rWczVd1ZTXYWBHKO
rn6a7iuI7oOjTB0x5j35W4awhM1fYy2GCNsGpNGKPlj2DuUhL2CKMTe3oZr/SXcT
8o15tJF237YtPTUTf6Ts7QqIKgf1w5YMP10n9i8bDKd1Dk+vbVrdKJfs3owZGXis
b0MuC+7ywDP2SLnQrq3X2Ws6aWo08maLmsbRCuEYvOUiBfkgt5n9e+Fo38zBNtZ1
9P1HZlEZw2pA/7TVtlXK2B2FZEORYjPHAmKYHwzJ82AypKdf+YfxrJVU93BT/14w
OW53EC42SAe3KRUym1YfNk2diH0g6nLOQytUjDNJayLfBHmji8MBqMsk9EoAH8qT
IfXfDb46t+uJ9fVkUZeEGkrIh3opUH/E1AAT87nVEPFCJgEjfjRa5/KnzmEnu02P
BcWZYwWfhIqu253Q8yLxTZYVqsanVJVY9VSDEFLPEoaucFW3tDevaLU+wGrh9fLO
F4Bs1aVZ/9gOEugNugUFIl2vkTosyim5U74h+RfcsxVf2WfImV9F36nkz5zy7xA1
Ri4I0C9TxNMZ7HIYbc3ZeLzFo0XHnP07m/Q4+q5+Z1SDmvMCh9exol8N8+G+3mS/
ZX5fQlJZ3apqPo2dntc5XFkRNp/iZsxdjAHSNlQWW4UPdMy99/4=
=tRkR
-----END PGP SIGNATURE-----

--------------pB0f8F0mmFVFj0eCM5ZW34LW--
