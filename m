Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D336EC4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjDXFfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXFf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:35:28 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2138.outbound.protection.outlook.com [40.107.135.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8453A90;
        Sun, 23 Apr 2023 22:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2HWRVSy4Y8GDQGB8pCiN7LI93ufYMv9T8qZ+/QZ17W5zZNR6qiGKCnmAAqUvR41eS8uCQKwLNobvNWuVw+3WZpbCIZhjYY3dBGCYbthpPPvROyNUUHXU0tNDlko7pTd+qn5aJ030+R1tyrgX0quRVKYpbxTHsMNpvDHjScDVtSZ3lX6RZe0EGc32S2gZ9q3cfcx88fggAmXrLLNUbhpcajuQAxrV/ibxHuSgxBXAd5bw3h8OnRH/LTzHapw15hnkIdAHGiviQmGIl0rwwfi/Dc7dMFf3zu2xgibogzY05L/eMTjuASLMI1ep95a/E/+WicHM3X+W2CH1GfLNIY/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+Xn2FOLDgQrg/dLRFwLAqS5fd1WwNS7dWH5NKvYFBs=;
 b=P7+vv493H+Q4zMKpEunyVUlA1ju6wokceJERV5gMZY7yYtRmmZ1sPkODdCQ8q3SlPJoIclkaUWBaFttWmw1nEBHBl+8ikjwB04tsV2oV6mZ71JtbH8bEPe5HK4PmPlaYwu0i8vhIU3RVzI1cgTuwBDHgj6WkHGvehdTujTR+Q6QjWvkpHh8tW/Bo785aBTpjOSIJt1kFeI4Benxx/SlKcQ0RTwmQyJPap9Ls9YMbL06celxBtwghS/NMnGeFoaiqjmOP2JqbhxqtrvvYKIPTXOLz8KIBMeLQLNIAeA6KSPdnUpqE27D88Bnf/GovdGjmZB+G6MijEkzsjw15jzd/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+Xn2FOLDgQrg/dLRFwLAqS5fd1WwNS7dWH5NKvYFBs=;
 b=XnFTifWtyZaI74o5XOFB3kAZyVHqUtveqZwtFNTQ3BtTDYcv/D7zLwBjYkSOgFNqJ9KGkDLxPUxW2oziFG0EOychGcfmfkgO6jS0kk4tLnzn+UM4Tf+7/0cijyF/6mqD0WIRdTJO0afNhKQFZe/R+JblazK7AFp9zIgKUBI/9Iw=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR2P281MB2925.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:64::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:35:05 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:35:05 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] Support ROHM BU27008 RGB sensor
Thread-Topic: [PATCH v1 0/3] Support ROHM BU27008 RGB sensor
Thread-Index: AQHZdDT0ktNjFzQ3qEKCWb5IJDUnQa84zwaAgAElmgA=
Date:   Mon, 24 Apr 2023 05:35:05 +0000
Message-ID: <afff433a-9988-c7c3-3d33-c53ca05d7101@fi.rohmeurope.com>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
 <20230423130413.73960299@jic23-huawei>
In-Reply-To: <20230423130413.73960299@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR2P281MB2925:EE_
x-ms-office365-filtering-correlation-id: 852381b9-5fe1-4289-05f6-08db4485a8ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLzC8Dn2S3teqL9kJKlDk3znHEFKQi9XMIgBken7+NG4yzNu6Y/3EW8aP2ybNg3++Cwx0taA4zXiE0H/POJ3AwPUkgi4EzSFSIFxtLX8etV9kzMKqkg4iM+ccHcfQNwVa1Pfp1l37v4M3rTeTprn01hfg2I5LM6Nv0VQ17YqceNFuEiwKDn5D3xe6flOe9Kpyx3oNjc1bc3BDfuPgUOMAyYeIkI3ZRjlK7INe+NeVp8E6LBlJykM1sBkEqr2ThRRyA0x/wXKY1dqBE/UZ3yXyeLKfKu8YHNSUf+IdKBVdEKUYoUnbxkB8OhQQP8RmbWJKmY3v55YgclQGVRoLhNeKpzpWCzMLRZVxBgMmH73TUpKvxL6kXxtewh0t6W6TP8+Ql8OjTdl2HPjh8h727/a6lyDnx9wGYEm/wfhPdN8xhBNipiKNfc12jGPYZ3UCG45PtUitNg/YxlUQHAWNXUUvPUMwZps9/50RLv0Bp4A7pYHQWDDOBC5yIT9FII3AQuWM3ZQxgvWDkJSftooYsJK7lELvHoEcypUIdOPjv/ksT3ZCt1GJvNlkGL5tBCx+s6K7ZU0lkAPAVzVbQ2EwSl59rn+lvrzfxu2p4JkE5/mEVsykbPJSDAj2JORCJm5l8pOfs4QVYc9YYz0UE5DInIsW3rR9duaxtdOuH3LaQKqN7o2xg1XVPvRU84uHtz/F7Pn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39830400003)(366004)(451199021)(38100700002)(122000001)(6506007)(6512007)(53546011)(26005)(2616005)(186003)(83380400001)(2906002)(8676002)(8936002)(7416002)(5660300002)(54906003)(478600001)(6486002)(71200400001)(38070700005)(110136005)(316002)(4326008)(41300700001)(64756008)(66446008)(66556008)(31696002)(66946007)(76116006)(91956017)(86362001)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHVRcnAwVlhleDZaSTdXREhCcWdSTUh4dzV3cmFZWkkyeWh2SDYxblNXeHlG?=
 =?utf-8?B?TkJHc0FGRTM1SjNOVHdxd01NRzlTdW5KdXhuZkpwVFM5K2p0bDhiVmhhT2RG?=
 =?utf-8?B?VVpBamdmbkNLNGhjVTR0UnhuVEN0ajBSRkd6K2J3NEY5MXkvWlZqdkl6RFp2?=
 =?utf-8?B?K1VPK0lJY1pxRHdpeFdlTGJKZHQwUk41WnNWb3JhWW9yYngvVk1Pa01CRDhB?=
 =?utf-8?B?aFZmWitWdEFqV2tCejd6M2FPelVINzIyeWZQTGtFb2FXc1FwQjYyc3E5NE03?=
 =?utf-8?B?OVJXenJXZCthTmJQekJYSDU0dEI2Q016NHRQZTZiWW5PRVFUa0EzR0p1STIw?=
 =?utf-8?B?ejRUKzZzeS9SZmhPbDk2V05CVXJyckdNZ2Z1cTJEWjhFMyt2OFBSQVlmaHlu?=
 =?utf-8?B?alVnOFhRcDhsZ3gxbndoajVVL2VTSGg2TVBmQVpOMFhIV1ZRNzVNY3JZck1p?=
 =?utf-8?B?RFA3VHJEaWVQSjBGRHJqM2crWTU5T1RuS2pEeDhRMHF2SjR3ZjM1NmgvQjJN?=
 =?utf-8?B?NGl1YzRTNE1md3U4VXF2aEhja2tRU3dOa3grR3M1QnY1TUs3QWRWOUlmL0FM?=
 =?utf-8?B?bU8rTWRnSG5aUVR6ZlMzM3JWWlBVUzhFaWJPOEpsUlpjWFRGVHQ0dk12MElS?=
 =?utf-8?B?VHh4M2lRMUFnUGRRSmNGZ2NxWm12bmtHd2tGOFAvMHhUS3dhcTNodmlwRWZY?=
 =?utf-8?B?dlpzSEhaTW0zVS95eXkvMnRqVWRicTRsc3JuN0pwS0RhRnljTmd4V3FCZk5Y?=
 =?utf-8?B?b1dSdVQybklkbkhDbVRTT2dMTTVFWnRZbjBvQ0F6MTJnVkROZjBxNHVIN2R5?=
 =?utf-8?B?RGsxdXRTRW9DNjYyVnZCcG5uRHhQellVTU5xcDRhckVBSEJMVXA2Y3dpMkhL?=
 =?utf-8?B?QkZKRzlLQnVvay9rNGVsbWtjVjMxQkI4WjR5VGdCM2gxK09XMUIxUmtjaW1l?=
 =?utf-8?B?Nk1MNmJtRXBqWUs5OUoxbTUrUlBXRzVjdyt4a1RHVGhlRzhXc3l4elhVVnJL?=
 =?utf-8?B?SnVEdURLUWthN0VYQnNPTVVvUjNYd3JRTTg0bldJeG9FNFYxVFF2aEdYN2lZ?=
 =?utf-8?B?MzRaZEZLb0lLaitPUTFwM2J6ZnJhbTJRM21DV0d1UzJLOVVrYTNXQUZuMHdv?=
 =?utf-8?B?QkpFakNQZFliM0ljY0RxR0RSQlFLT0dSQzRxazJmY0MvZUJkZEVzY0cxMlNJ?=
 =?utf-8?B?ckZ4VXlEUEZUMVZtNTJ3dmVtcE9KZCtveWl1R2FJVU1DY0E2eUxUMm0rMjBi?=
 =?utf-8?B?M2w3ckNGVXRVWTJleGRPVzA5VnRBVDZjdUlSN1Y0Z1l0SWh2MDlvR2lwL1gy?=
 =?utf-8?B?NHpTbVp5azNPQ2lteXAxUU1zZmFWWWI3MCtPdy9YMnBYOEk2TTVyUi9jdE9E?=
 =?utf-8?B?K3krMU5GZUJUam5OVEoyU21ZanRueE9wWkZGUTVUTFRORm55WCttbGdnWFVB?=
 =?utf-8?B?azRQT2JDVTh1NjgxY0ZuYkxsbUlIMkdmWjlYZkd3SENBQkRZT2VPcDdiR3Ar?=
 =?utf-8?B?MTJqZmNzQi9tNit6Yy92MmU5KzBrWkFBa01mR08vZEt3VVpiTU1XdUtKbFp6?=
 =?utf-8?B?ZCszY2dxUmFiRk1LdmxKWkp1RjUyaWllZWZVZ3RDdUk4QWo1MGZBYko0Vkd5?=
 =?utf-8?B?QlhxdHZTOVJkcGFxai9WMUVSZDgvWEVHbk9jQmxvNVlVZUVoVjZMNVA0dGxp?=
 =?utf-8?B?M01mOGNaRmg2cGhWMk1wU1hlRkZrNXYxQTNJb09WS2J6NTk2c2QySU1kZEJt?=
 =?utf-8?B?SUNJdG5oK010OS81NFpsSXM4SDFzNlZCdVNhUmJxeVRwVVM5TGlwSkRMbHZu?=
 =?utf-8?B?NUxzc0RieXF0MURtbWlxTmpnWXdaYS8rT1Z1NTlNV1hGNVNpWXFLaEx0WHMx?=
 =?utf-8?B?NHpHNm1EK0x5SnppUjJTNkdVRnNpV21uby9DY0w5aUNGWU1IdEVERS90RGFU?=
 =?utf-8?B?RzhVaDZ2SEpHVlVZTEo2bjB1RUc0OE93ZUxTOWd1SGVXaU5RbHlQMHRzdzlB?=
 =?utf-8?B?SU1qbnJNL1JCQnlUKzZXWHprT0NZcWFtS3NmUXdWME5nMHVEQys3RGxlbEhw?=
 =?utf-8?B?WGhQSmVJMmFPbmZpTTdrdVBlSDZiQVA2MGtOcExFTlpNZTlBWW5rZ2JyOFli?=
 =?utf-8?B?NmlIV0VUWlYvNEUyUGZ1TFdrYlZtUitJSDd4cFh3dTNCZU9aVitSMTZZcE5j?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E819BE451995E14498DEE80A6A8BA195@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 852381b9-5fe1-4289-05f6-08db4485a8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:35:05.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBEgzqt2T+GMLBMBCfzh0QAI5d2vQeuD86lb2NcZz8qLns7KKHmVM3DNSfmU6488IoBWYUCu9ysKoK67cQUoTiwrs2p1jtLRRpstyffhu0Qheh9XeeYY850dXV98TA/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2925
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMy8yMyAxNTowNCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gRnJpLCAyMSBB
cHIgMjAyMyAxMjozNzozMCArMDMwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gQWRkIHN1cHBvcnQgZm9yIFJPSE0gQlUyNzAwOCBS
R0Igc2Vuc29yLg0KPj4NCj4+IFRoZSBST0hNIEJVMjcwMDggaXMgYSBzZW5zb3Igd2l0aCA1IHBo
b3RvZGlvZGVzIChyZWQsIGdyZWVuLCBibHVlLCBjbGVhcg0KPj4gYW5kIElSKSB3aXRoIGZvdXIg
Y29uZmlndXJhYmxlIGNoYW5uZWxzLiBSZWQgYW5kIGdyZWVuIGJlaW5nIGFsd2F5cw0KPj4gYXZh
aWxhYmxlIGFuZCB0d28gb3V0IG9mIHRoZSByZXN0IHRocmVlIChibHVlLCBjbGVhciwgSVIpIGNh
biBiZQ0KPj4gc2VsZWN0ZWQgdG8gYmUgc2ltdWx0YW5lb3VzbHkgbWVhc3VyZWQuIFR5cGljYWwg
YXBwbGljYXRpb24gaXMgYWRqdXN0aW5nDQo+PiBMQ0QgYmFja2xpZ2h0IG9mIFRWcywgbW9iaWxl
IHBob25lcyBhbmQgdGFibGV0IFBDcy4NCj4+DQo+PiBUaGlzIHNlcmllcyBzdXBwb3J0cyByZWFk
aW5nIHRoZSBSR0JDIGFuZCBJUiBjaGFubmVscyB1c2luZyBJSU8NCj4+IGZyYW1lZW9yay4gSG93
ZXZlciwgb25seSB0d28gb2YgdGhlIEJDK0lSIGNhbiBiZSBlbmFibGVkIGF0IHRoZSBzYW1lDQo+
IA0KPiBmcmFtZXdvcmsNCg0KVGhhbmtzIQ0KDQo+IA0KPj4gdGltZS4gU2VyaWVzIGFkZHMgYWxz
byBzdXBwb3J0IGZvciBzY2FsZSBhbmQgaW50ZWdyYXRpb24gdGltZQ0KPj4gY29uZmlndXJhdGlv
biwgd2hlcmUgc2NhbGUgY29uc2lzdHMgb2YgaW1wYWN0IG9mIGJvdGggdGhlIGludGVncmF0aW9u
DQo+PiB0aW1lIGFuZCBoYXJkd2FyZSBnYWluLiBUaGUgZ2FpbiBhbmQgdGltZSBzdXBwb3J0IGlz
IGJhY2tlZCBieSB0aGUgbmV3bHkNCj4+IGludHJvZHVjZWQgSUlPIEdUUyBoZWxwZXIuIFRoaXMg
c2VyaWVzIGRlcGVuZHMgb24gR1RTIGhlbHBlciBwYXRjaGVzDQo+PiBhZGRlZCBpbiBCVTI3MDM0
IHN1cHBvcnQgc2VyaWVzIHdoaWNoIGlzIGFscmVhZHkgbWVyZ2VkIGluIGlpby90b2dyZWcNCj4+
IHdoaWNoIHRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uLg0KPj4NCj4+IFRoZSBoYXJkd2FyZSBhbGxv
d3MgY29uZmlndXJpbmcgZ2FpbiBzZXR0aW5nIGJ5IHdyaXRpbmcgYSA1LWJpdCBnYWluDQo+PiBz
ZWxlY3RvciB2YWx1ZSB0byBhIHJlZ2lzdGVyLiBQYXJ0IG9mIHRoZSBnYWluIHNldHRpbmcgaXMg
Y29tbW9uIGZvciBhbGwNCj4+IGNoYW5uZWxzIChSR0JDICsgSVIpIGJ1dCBwYXJ0IG9mIHRoZSBz
ZWxlY3RvciB2YWx1ZSBjYW4gYmUgc2V0DQo+PiBzZXBhcmF0ZWx5IGZvciBSR0JDIGFuZCBJUjoN
Cj4+DQo+PiBNT0RFX0NPTlRST0wyIFJFRzoNCj4+IGJpdCA3CSAgICA2CSAgICA1CSAgICA0CSAg
ICAzCSAgICAyCSAgICAxCSAgICAwDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gfAlSR0IJc2VsZWN0b3IJCXwN
Cj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+PiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPj4gfCBoaWdoIGJpdHMgSVIJfAkJCXwgbG93IGJpdHMgSVIgc2VsZWN0b3IJfA0KPj4gKy0t
LS0tLS0tLS0tLS0tLSsJCQkrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+Pg0KPj4gSW4gdGhl
b3J5IGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIHNldCBjZXJ0YWluIHNlcGFyYXRlIGdhaW4gdmFs
dWVzIGZvcg0KPj4gUkdCQyBhbmQgSVIgY2hhbm5lbHMsIGJ1dCB0aGlzIGdldHMgcHJldHR5IGNv
bmZ1c2luZyBiZWNhdXNlIHRoZXJlIGFyZSBhDQo+PiBmZXcgJ3Vuc3VwcG9ydGVkJyBzZWxlY3Rv
ciB2YWx1ZXMuIElmIG9ubHkgUkdCQyBvciBJUiB3YXMgc2V0LCBzb21lDQo+PiBleHRyYSBoYW5k
bGluZyBzaG91bGQgYmUgZG9uZSB0byBwcmV2ZW50IHRoZSBvdGhlciBjaGFubmVsIGZyb20gZ2V0
dGluZw0KPj4gdW5zdXBwb3J0ZWQgdmFsdWUgZHVlIHRvIGNoYW5nZSBpbiBoaWdoLWJpdHMuIEZ1
cnRoZXJtb3JlLCBhbGxvd2luZyB0aGUNCj4+IGNoYW5uZWxzIHRvIGJlIHNldCBkaWZmZXJlbnQg
Z2FpbiB2YWx1ZXMgKGluIHNvbWUgY2FzZXMgd2hlbiBnYWlucyBhcmUNCj4+IHN1Y2ggdGhlIEhX
IHN1cHBvcnRzIGl0KSB3b3VsZCBtYWtlIHRoZSBjYXNlcyB3aGVyZSBhbHNvIGludGVncmF0aW9u
DQo+PiB0aW1lIGlzIGNoYW5nZWQgdG8gYWNoaWV2ZSBjb3JyZWN0IHNjYWxlIC4uLiBpbnRlcmVz
dGluZy4gSXQgbWlnaHQgYWxzbw0KPj4gYmUgY29uZnVzaW5nIGZvciB1c2VyIHRvIHRyeSBwcmVk
aWN0aW5nIHdoZW4gc2V0dGluZyBkaWZmZXJlbnQgc2NhbGVzDQo+PiBzdWNjZWVkcyBhbmQgd2hl
biBpdCBkb2VzIG5vdC4gRnVydGhlcm1vcmUsIGlmIGZvciBleGFtcGxlIHRoZSBzY2FsZQ0KPj4g
c2V0dGluZyBmb3IgUkdCQyBjYXVzZWQgSVIgc2VsZWN0b3IgdG8gYmUgaW52YWxpZCAtIGl0IGNv
dWxkIGFsc28gY2F1c2UNCj4+IHRoZSBJUiBzY2FsZSB0byAianVtcCIgdmVyeSBmYXIgZnJvbSBw
cmV2aW91cyB2YWx1ZS4NCj4+DQo+PiBUbyBtYWtlIHRoZSBjb2RlIHNpbXBsZXIgYW5kIG1vcmUg
cHJlZGljdGFibGUgZm9yIHVzZXJzLCB0aGUgY3VycmVudA0KPj4gbG9naWMgaXMgYXMgZm9sbG93
czoNCj4+DQo+PiAxLiBQcmV2ZW50IHNldHRpbmcgSVIgc2NhbGUuIChNeSBhc3N1bXB0aW9uIGlz
IElSIGlzIGxlc3MgdXNlZCB0aGFuDQo+PiBSR0JDKQ0KPj4gMi4gV2hlbiBSR0JDIHNjYWxlIGlz
IHNldCwgc2V0IGFsc28gdGhlIElSLXNlbGVjdG9yIHRvIHRoZSBzYW1lIHZhbHVlLg0KPj4gVGhp
cyBwcmV2ZW50cyB1bnN1cHBvcnRlZCBzZWxlY3RvciB2YWx1ZXMgYW5kIG1ha2VzIHRoZSBJUiBz
Y2FsZSBjaGFuZ2VzDQo+PiBwcmVkaWN0YWJsZS4NCj4+DQo+PiBUaGUgMikgY291bGQgbWVhbiB3
ZSBlZmZlY3RpdmVseSBoYXZlIHRoZSBzYW1lIHNjYWxlIGZvciBhbGwgY2hhbm5lbHMuDQo+PiBV
bmZvcnR1bmF0ZWx5LCB0aGUgSFcgZGVzaWduIGlzIHNsaWdodGx5IHBlY3VsaWFyIGFuZCBzZWxl
Y3RvciAwIG1lYW5zDQo+PiBnYWluIDFYIG9uIFJHQkMgYnV0IGdhaW4gMlggb24gSVIuIFJlc3Qg
b2YgdGhlIHNlbGVjdG9ycyBlcXVhbCBzYW1lIGdhaW4NCj4+IHZhbHVlcyBvbiBSR0JDIGFuZCBJ
Ui4gVGhlIHJlc3VsdCBpcyB0aGF0IHdoaWxlIGNoYW5naW4gc2VsZWN0b3IgZnJvbSAwDQo+PiA9
PiAxIGNhdXNlcyBSR0JDIGdhaW4gdG8gZ28gZnJvbSAxWCA9PiA0WCwgaXQgY2F1c2VzIElSIGdh
aW4gdG8gZ28gZnJvbQ0KPj4gMlggPT4gNFguDQo+Pg0KPj4gU28sIHRoZSBkcml2ZXIgcHJvdmlk
ZXMgc2VwYXJhdGUgc2NhbGUgZW50cmllcyBmb3IgYWxsIGNoYW5uZWxzIChhbHNvDQo+PiBSR0Ig
YW5kIEMgd2lsbCBoYXZlIHNlcGFyYXRlIGdhaW4gZW50cmllcyBiZWNhdXNlIHRoZXNlIGNoYW5u
ZWxzIGFyZSBvZg0KPj4gc2FtZSB0eXBlIGFzIElSIGNoYW5uZWwpLiBUaGlzIG1ha2VzIGl0IHBv
c3NpYmxlIGZvciB1c2VyIGFwcGxpY2F0aW9ucw0KPj4gdG8gZ28gcmVhZCB0aGUgc2NhbGVzIGZv
ciBhbGwgY2hhbm5lbHMgYWZ0ZXIgc2V0dGluZyBzY2FsZSBmb3Igb25lIChpbg0KPj4gb3JkZXIg
dG8gZGV0ZWN0IHRoZSBJUiBzY2FsZSBkaWZmZXJlbmNlKS4NCj4+DQo+PiBIYXZpbmcgdGhlIHNl
cGFyYXRlIElSIHNjYWxlIGVudHJ5IHdoaWNoIGFwcGxpY2F0aW9ucyBjYW4gcmVhZCB0byBkZXRl
Y3QNCj4+ICJhcmJpdHJhcnkgc2NhbGUgY2hhbmdlcyIgbWFrZXMgaXQgcG9zc2libGUgZm9yIGFw
cGxpY2F0aW9ucyB0byBiZQ0KPj4gd3JpdHRlbiBzbyB0aGV5IGNhbiBjb3BlIGlmIHdlIG5lZWQg
dG8gaW1wbGVtZW50IHRoZSAnYWxsb3cgc2V0dGluZyBzb21lDQo+PiBkaWZmZXJlbnQgZ2FpbnMg
Zm9yIElSIGFuZCBSR0JDJyAtIGxhdGVyLg0KPiANCj4gSG1tLiBJJ20gbm90IHN1cmUgcHJldmVu
dGluZyBpdCBpcyB0aGUgYmVzdCBhcHByb2FjaC4gIFRoYXQgbWFrZXMgZm9yIGFuDQo+IGludGVy
ZmFjZSB0aGF0IGlzIHBlcmhhcHMgZXZlbiBsZXNzIGludHVpdGl2ZSB0aGFuIGhhdmluZyBpdCBh
ZmZlY3QgdGhlDQo+IHNjYWxlcyBvZiB0aGUgb3RoZXIgY2hhbm5lbHMuICBTdGlsbCBoYXZpbmcg
aXQgY29uZmlndXJhYmxlIGF0IGFsbCBpcw0KPiBvcHRpb25hbCBmcm9tIGFuIEFCSSBwb2ludCBv
ZiB2aWV3LCBzbyB3ZSBjb3VsZCBnbyB3aXRoIHdoYXQgeW91IGhhdmUNCj4gaGVyZSBhbmQgc2Vl
IGlmIGFueW9uZSBzaG91dHMgYWJvdXQgaXQgaW4gZnV0dXJlLg0KDQpJIGFtIG5vdCBzdXJlIGVp
dGhlci4gVGhpcyBpcyByZWFsbHkgYSBkYW5jZSBiZXR3ZWVuIG1ha2luZyBkcml2ZXIgd2hpY2gg
DQppcyBzdGlsbCB1bmRlcnN0YW5kYWJsZSBhbmQgbWFpbnRhaW5hYmxlLCBBQkkgd2hpY2ggYWxs
b3dzIHVzIHRvIGltcHJvdmUgDQp0aGluZ3MgaWYgbmVlZGVkIGFuZCBwcm92aWRpbmcgdXNlcnMg
dGhlIGZlYXR1cmVzIHRoZXkgbmVlZC4NCg0KU28uIGxldCdzIGJlZ2luIHdpdGggdGhpcyAtIGFu
ZCBhcyB5b3Ugc2F5LCBpZiBpdCBhcHBlYXJzIHRvIGJlIA0Kc3Vib3B0aW1hbCwgdGhlbiB3ZSBj
YW4gcmUtd29yayBpdCA6KQ0KDQpZb3VycywNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0
aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1
IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2Fu
IGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
