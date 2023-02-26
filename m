Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA36A2E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBZGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:37:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FBE12F1C;
        Sat, 25 Feb 2023 22:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7te0n6n0wxvS5qToLq8YsGz6wd/M/UEITCIbSzvPqh+gN+fq8UmPwhsuTux8YP6uC9LEjSf6rDyeNrTbsFy0ETCcd+EdDCyU6nCk4xfl1yzerGswW7ZcLDb7VEXG5XPMCWwA6ht98dDBpUdp9lNIQYHE57ybc/+gPI/butV7D8oLJKlsH0JIz+0amaTz84l1k7eSMY8jK+8ERU4ikU9leCmjip9YhabLwSAv2OfK+jylKC3oDi5CJ7/1CezzQXOjb8KrS4poWBHm8UZeMAWGMKPteQjQnDfeb+JZtqIXl7iAQTcDCxvf8T/jqlr0vE2OgMYbvlTZ/tS7M/t0Jvd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGz4/u2qQCJDgtg3yk6eDFqsn5YDhfV9rGn5/0xQNWs=;
 b=IEgIIMH8snoEyFcH9AY93EHl3nyTzqwfg8dgMZrJcl1IKKYTt2jqjjDwZHaKVzHR83GAyRAE+GCFQftfHoqEAzr3MCHqHC7AN66T+ap6ByfblP5/xYa1gb+kG4ey/PLcWOFjysOuAlAljvNpXUIJLcvfhvFL63588KxhqY4Zp+liAWrTjy6j4rdhUep8hh8Izwr9IauBkVDfP5/2N6cs2HyzTdnPT8Hb7BclM0v93hdbV6hTrHSWGTG8J2MfgpH25IcvobODlqsoDZbEV8LBT1kwnw9FIIIYYn8XIDiG3hNu62xa/1KnuINV30KDIVyIZrLTYgk7f8mtdv6uYeurRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Sun, 26 Feb
 2023 06:37:39 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::9e20:f69a:50a9:cd73]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::9e20:f69a:50a9:cd73%9]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 06:37:39 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead of
 depending on it
Thread-Topic: [PATCH 6/8] platform: x86: MLX_PLATFORM: select REGMAP instead
 of depending on it
Thread-Index: AQHZSaTFlIZZE1c2JESiHj/5m64Goq7gxkfg
Date:   Sun, 26 Feb 2023 06:37:39 +0000
Message-ID: <BN9PR12MB5381DB9F7D91833EA63374CFAFAE9@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230226053953.4681-1-rdunlap@infradead.org>
 <20230226053953.4681-7-rdunlap@infradead.org>
In-Reply-To: <20230226053953.4681-7-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|CH3PR12MB7667:EE_
x-ms-office365-filtering-correlation-id: 6e3f51e6-3c6b-4739-6db0-08db17c3f479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/qogZS3NHPoJGlOQS3d1sfqchfzyzQGwM+qZIGdc8c7pwaI8rOTWucqbnCOl8e58zitW1nB44R/aiGdo7qkT+iKKs+MQSj7t3YOwSfHIWf0/W2ReCVLzZC/gL+NTQz7i5NgqqNsWHIRXv70GhkIevyl3pNThHtRtMlORpEtChjma0knLHq19Ogrk4dbYNu8YqsBx7mSHP9kHmUPpMq38aKLMJWwpfZT08LofsEpQvon2KNJtTnXwpz7H5dQaqKIkqk6sdpukJza5m5ty/ehvUh1xm14d7Dk0/HwCJwsTL2Iovz9986tQ7JTZ0V89A6gSFeUjRj+gkhLsHVTgChUfcyQoM6q8x+HCKWDtrgZpk6CtwjHB8O5Nm+zglCc58W5FTqCT/KdjNl/Ect0misem56xSc61yTRIBJVmS1l+uwqWQH8xbbKhwpYT9crXR0JKF1yFMJnjkAoJn1SINKLAoyDX/N+8vn8XwQUeoCoa8WJYhF2igtUTJgwxq1hybo74Z6mMFTewfn+b4NL1KjZFO7BNezspYcyM2+0d6FI2cG0I6rvVmgI3x0VOrnjild6XoJlKlCnaA38QwsoSJbrx5rDs2UdpAeu+V2vq5R+kLYo+4aL9lN9WyMs/BpDAF0eOGaEInqv+3oV5JTxT4CSUw7vtflNz8GmgGM2g0YTDiXR8/WbXoKtyKHCHu8YTxC9MbLY/7LkKfj1NTsrwwbUz2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(83380400001)(33656002)(316002)(86362001)(110136005)(54906003)(64756008)(9686003)(2906002)(5660300002)(66476007)(4326008)(66946007)(76116006)(66556008)(8936002)(8676002)(41300700001)(6506007)(66446008)(478600001)(53546011)(26005)(186003)(71200400001)(55016003)(7696005)(38100700002)(38070700005)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGlMbldFb0drWlRyZ0ZLOTlhc2tFWC9VdUJUL2tRQnJGNFgvN1lGVlJCQXBT?=
 =?utf-8?B?QzJrSElmZXBNOVlubkI0dWt3ZkRvRTRYNENqcGxxNnJlam14elFNUDRQTzZ0?=
 =?utf-8?B?bEx4eXlheVNSS083ZDhUT2N5Y1l0MXVscS9XS2MreVlsRHBkQ0JFS0trTUFY?=
 =?utf-8?B?ZVc0cDVwdnZXWEkrSm5BWjZST1V3bXRac3Jnc0h6eEJLWFFBWlB3ZEtOT2li?=
 =?utf-8?B?WlFXL2ZYQktIaVpEN29XUlEwN2E2T0UySjlXd0JNSmVnTlhmMVkrdE9XS28x?=
 =?utf-8?B?SHZ2ejR5WnBPaWVsVDRZaDNudGxTOVd0N2NTWERmRW0yWjFrNHJyanZKbW0w?=
 =?utf-8?B?ZkhpN2wzUHM0T3hIQUpnaVgyWit3azUzMWxBczZaMDA3K0ZqdHZlb0JvaVZO?=
 =?utf-8?B?VzEzczBaeUhWZlFiZURyNEhaTnNvWnoyRUd4TEo1WG9RTEtVbmk1aG9veEd3?=
 =?utf-8?B?RjljV2U0aFAyQ2Y4QWRuZm5DRzhjSWNWZGFhRFd4aFNjTytESEJBSVY4WGt4?=
 =?utf-8?B?YVlTQzJXVWd1V3dKRGQxd0QxZkJNWVhzTnRCaXNUODNBdkQ2ZG5TdGFld3p3?=
 =?utf-8?B?bCt1aFlQekswVVBKblp5aEpSWDlWbGhzNFc4Tk5kS1hXMUZwdE5OcFNGSEFC?=
 =?utf-8?B?OG5VMEhaaWpyOWJLRWpPQ1FJK25sMW9rUmx6SUI0RE0yTjhTV2hZd28reWFH?=
 =?utf-8?B?aXUyeVgydlhNeFM5UXl5a2V5Z1BiRW5iNXJxWmFSampwWlhFcUJoV2lRdzlP?=
 =?utf-8?B?SWNKQThjdlFSOU9ib0JoTFdRTXI4aTBLVmtMZTBVZWtCTGZ6S0VoTXYrakN1?=
 =?utf-8?B?YWgrQllVQ2lRZk5JT2dYdDhrVGJKSWhJVFg3ZC84RGdpS1VUWUptd0l1OW0x?=
 =?utf-8?B?dnpmWTZlT05OSm1UQVp6c0Nnc0JYUzg2bkFsc2hNNThEWHFBWG1POWtwOVhi?=
 =?utf-8?B?RDh4VGVvbVZXbTE4WGI0MURzdkkvcW1mUUhseURuQzVLNzN1K2cvNit3ZlYy?=
 =?utf-8?B?N1R4WnhsQ1g0NSt2V1grZjJ1cnhOV01MZWs1TFRVazc3OFNtSG9oTmVsVkNo?=
 =?utf-8?B?UVZWZ1BiMSswSzJvTEZVeXYvVXVFUXp6bDY3YXdkUFhMMGZIUTZraGNsZ2w4?=
 =?utf-8?B?T0VaMDRpWDNJaCtrWm53MnJlWDV5aDFEZDhJTkhrcmpnTGQ0VzR0dmpqS3JG?=
 =?utf-8?B?TnBrRGJDS0pjQkV2RHFvWDgybG5QZG5jVHg1dFpGVjRwaGpYRkJPc0RSbTky?=
 =?utf-8?B?VkFXY1cxeEFnRFZEbzJsbGYzb3lxb29VaDQ1WlJXL0xyOVhTbmFOU0tTQzNJ?=
 =?utf-8?B?TVhteW1QWU9DZUhwVHpQdGNiSEZHd3VPeDRkNTdTTGF3NDlHOGpEK0Q1RHFk?=
 =?utf-8?B?YVRFTGJ0bXJHMEhPczd2K25waU9EdHFkTm9ORkxPUzlHOEtWeVQ1SjlZaG15?=
 =?utf-8?B?L3JDNWxqU0tGM0Vqc0pzMWRKWlYrcVNLdll2b2tnTGI5bGtobFludEMxRUd5?=
 =?utf-8?B?cldlRHIrdnpTSVlxZ2h3b01iZXI4SjVnZkdiQUVxSmRHeGNLYmFpcUF4Vm5X?=
 =?utf-8?B?KzNrengvUXYrRGxoWDE5cFh5YkM3ZTIrQ09XSzJjanFGN3U5TGgxTkNGZ0s0?=
 =?utf-8?B?UmVKQlNmZDBFVk51WVJZUHFsblZxZ2dteDBxSDZxUUVIODRaL3dxMSs1Z3g2?=
 =?utf-8?B?V25kNTkrWXo5ZGZNMGgyNEJEWS9WRVhRNEpOQXA0L1BZSUltdUNYTDJuMldu?=
 =?utf-8?B?U0oydEwxZHFweVFMM1VUY1JIemNjVnByWXBuUDJqQklmdkl4K2NoaGhMTVpC?=
 =?utf-8?B?QnExTlpOdnZnZXRmdGVGeUJERXJ1ekR4aVNsR25RamtYWkNYYW1SdW9pUUt4?=
 =?utf-8?B?YzQwRXpaMlhaZzdDVmJ0cmtlM1o3Njk1ZTlOam5FT2lxSXlLNjdnYm9BcTgz?=
 =?utf-8?B?RWpicGVIa2tuS01nUEs0a3dhUnluZmJFZTdKZGU4TnZFWkpoRWV5anV1RTlt?=
 =?utf-8?B?bkM5bG9TdjFiOTJzRHd6eHJyQVNnYTZiNGZmajlndHZ3ZkpyLy9kay93M3pn?=
 =?utf-8?B?SlowRDlDbEI2UU5HSmlVWVVuWnhUcTlhVEFtckt6Zk1abVVKaUZBSHd5SU1I?=
 =?utf-8?Q?tVBrdSHr0DJkxNb3TqsVnYwyg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f51e6-3c6b-4739-6db0-08db17c3f479
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2023 06:37:39.0248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEXpcPfrb5X7nNruPZdOAoMu1RpmS4fviMMXgE7t2RL3HSSkPsoJxqX6CP2s2wByKnoeT4UKjiMksT4y18Yz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgMjYgRmVicnVhcnkgMjAyMyA3
OjQwDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBSYW5keSBEdW5s
YXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47IFZhZGltIFBhc3Rlcm5haw0KPiA8dmFkaW1wQG1l
bGxhbm94LmNvbT47IERhcnJlbiBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFkLm9yZz47IEhhbnMgZGUN
Cj4gR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJrIEdyb3NzIDxtYXJrZ3Jvc3NAa2Vy
bmVsLm9yZz47DQo+IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtQQVRDSCA2LzhdIHBsYXRmb3JtOiB4ODY6IE1MWF9QTEFURk9STTogc2VsZWN0IFJFR01B
UCBpbnN0ZWFkDQo+IG9mIGRlcGVuZGluZyBvbiBpdA0KPiANCj4gUkVHTUFQIGlzIGEgaGlkZGVu
IChub3QgdXNlciB2aXNpYmxlKSBzeW1ib2wuIFVzZXJzIGNhbm5vdCBzZXQgaXQgZGlyZWN0bHkg
dGhydQ0KPiAibWFrZSAqY29uZmlnIiwgc28gZHJpdmVycyBzaG91bGQgc2VsZWN0IGl0IGluc3Rl
YWQgb2YgZGVwZW5kaW5nIG9uIGl0IGlmIHRoZXkNCj4gbmVlZCBpdC4NCj4gDQo+IENvbnNpc3Rl
bnRseSB1c2luZyAic2VsZWN0IiBvciAiZGVwZW5kcyBvbiIgY2FuIGFsc28gaGVscCByZWR1Y2Ug
S2NvbmZpZw0KPiBjaXJjdWxhciBkZXBlbmRlbmN5IGlzc3Vlcy4NCj4gDQo+IFRoZXJlZm9yZSwg
Y2hhbmdlIHRoZSB1c2Ugb2YgImRlcGVuZHMgb24gUkVHTUFQIiB0byAic2VsZWN0IFJFR01BUCIu
DQo+IA0KPiBGaXhlczogZWYwZjYyMjY0YjJhICgicGxhdGZvcm0veDg2OiBtbHgtcGxhdGZvcm06
IEFkZCBwaHlzaWNhbCBidXMgbnVtYmVyDQo+IGF1dG8gZGV0ZWN0aW9uIikNCj4gU2lnbmVkLW9m
Zi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQoNCkFja2VkLWJ5OiBW
YWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlkaWEuY29tPg0KDQo+IENjOiBWYWRpbSBQYXN0ZXJu
YWsgPHZhZGltcEBtZWxsYW5veC5jb20+DQo+IENjOiBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJh
ZGVhZC5vcmc+DQo+IENjOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPg0KPiBD
YzogTWFyayBHcm9zcyA8bWFya2dyb3NzQGtlcm5lbC5vcmc+DQo+IENjOiBwbGF0Zm9ybS1kcml2
ZXIteDg2QHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L0tj
b25maWcgfCAgICAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L0tjb25maWcg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9LY29uZmlnDQo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZw0KPiBAQCAt
OTU1LDcgKzk1NSw4IEBAIGNvbmZpZyBTRVJJQUxfTVVMVElfSU5TVEFOVElBVEUNCj4gDQo+ICBj
b25maWcgTUxYX1BMQVRGT1JNDQo+ICAJdHJpc3RhdGUgIk1lbGxhbm94IFRlY2hub2xvZ2llcyBw
bGF0Zm9ybSBzdXBwb3J0Ig0KPiAtCWRlcGVuZHMgb24gSTJDICYmIFJFR01BUA0KPiArCWRlcGVu
ZHMgb24gSTJDDQo+ICsJc2VsZWN0IFJFR01BUA0KPiAgCWhlbHANCj4gIAkgIFRoaXMgb3B0aW9u
IGVuYWJsZXMgc3lzdGVtIHN1cHBvcnQgZm9yIHRoZSBNZWxsYW5veCBUZWNobm9sb2dpZXMNCj4g
IAkgIHBsYXRmb3JtLiBUaGUgTWVsbGFub3ggc3lzdGVtcyBwcm92aWRlIGRhdGEgY2VudGVyIG5l
dHdvcmtpbmcNCg==
