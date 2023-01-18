Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17700671FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAROmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjAROlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:41:16 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0FF2D173
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:32:45 -0800 (PST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-jt6lR6EvPcuKKoHrnjbdUg-1; Wed, 18 Jan 2023 15:32:41 +0100
X-MC-Unique: jt6lR6EvPcuKKoHrnjbdUg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0113.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Wed, 18 Jan 2023 14:32:40 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ace5:84e5:2754:a1fa%2]) with mapi id 15.20.6002.012; Wed, 18 Jan 2023
 14:32:40 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "qiangqing.zhang@nxp.com" <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 07/17] arch: arm64: imx8qm: add can node in devicetree
Thread-Topic: [PATCH v4 07/17] arch: arm64: imx8qm: add can node in devicetree
Thread-Index: AQHZKw5d/jC7Xax5/0aCdAUVMVdJO66kM6MAgAAJroA=
Date:   Wed, 18 Jan 2023 14:32:39 +0000
Message-ID: <3645c9a42797e821ced4cd9ba2985acc136376b8.camel@toradex.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
         <20230118072656.18845-8-marcel@ziswiler.com>
         <5b1f757c-92af-f91f-3fd4-ad23622add7b@linaro.org>
In-Reply-To: <5b1f757c-92af-f91f-3fd4-ad23622add7b@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0113:EE_
x-ms-office365-filtering-correlation-id: 2140b03c-7baf-43c1-34b1-08daf960da3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: /bVYMqRnR/0jzNxgnnXti/oBOoOcw1sHD5/dAEuxNVABmpb1AUzG604SK5fc8BcjldOYts17mGgfqp6ukLF3k9Qp8hs0GSrmsq+nAqFETrwlGY7WezMk/xFtNM/fXuYNLEbqMlp0O3wuFDowUgQHCV1kNX0eijzOPMpUNlhvxBS+PiOn+zyqh4l4IsOcxkMXyz6EeCk2Vk2z5DCwSR34y0kJCgd8JrUilcd6vlJlm8RlLkwY1KCE4FhY08r0PeSkfefVxFet8y1qO/fwsx9UoiV/kT3RntBg838BMcQSZHEHMxReFuTM3oS7olHh2UvzUQphSyvC1wxW+FomQlRmbQrnP6Gc0tWpyj4BaJRQAgzADPnJoahRGv4th5P/R0ikzWIGfRUYDazKXtbKpX6tneBXAdK4tM/rPly1JQMQZ5q3bSsbbcbHH2UKipqjIV7ahmhSpZFYQetDcs0mi7MA8cqKZgybBq1der5D9aMhm8DqvymJlrqtEyFDrrOvI919F1ekQ5w72zvrNj3C+SjojPym0CbPgoXFDOV2XKL8oRc5L/LwejqBj/oChafb/472c2D6EVBTCvyjXvW0RZ9mrAEEOoamO08SZLrSf/jhCiYjaeChnCQD8Dj/wsbqgHM7nND+VcYU0LDAP/crnS0QUXX8MixZ7uUO7Mh1NIyY/knaFaVZbzWoH2mGyY5RoZwMDYycrUxusZV5kT+oDuyyIUCfJ4lu1ZWqmIh7lOUhauw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39850400004)(366004)(136003)(376002)(451199015)(6512007)(86362001)(5660300002)(41300700001)(7416002)(44832011)(8936002)(6486002)(38100700002)(122000001)(36756003)(558084003)(54906003)(478600001)(186003)(71200400001)(110136005)(53546011)(38070700005)(26005)(6506007)(8676002)(66946007)(64756008)(316002)(66556008)(4326008)(66476007)(66446008)(76116006)(2616005)(2906002)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzlHRlJIS2M2NE8zdU1abklJalFxR1U1N3RNdDlBVE84VUZDZVVLdDJ5bjNT?=
 =?utf-8?B?UlpuM2c4U2tLa1dHRUZ6cktDc2RuQnhqQTNTQ0E0bCtlczdrU00wVXZwRGta?=
 =?utf-8?B?d2IvS0FIMkx2Z0hsM1lSRlMrQzQ3cjNkN0JoTVNpVktTdFpiM0VNTVJHVlM0?=
 =?utf-8?B?RGxBalMxeGJsRDVCV1VRam9TRGJuZkZjd2w0K0VFZW83U21QRWFwUndaS29T?=
 =?utf-8?B?ZnVFa1RQVXRaWFRMaitvd05VbUtJaW1mcTUrQi9kdnBhSE5qMWZ2dXk1c2pi?=
 =?utf-8?B?SHprV1duRkZDVmlvT3B3U1ptcCtoVWErV1BxSkcyV0I1U2VuSHNyV040djdT?=
 =?utf-8?B?M2tXSVBTZnVkd01lNmJWWjl1NmpiQjFuMTlDWmFUbUNrdlVCQ1lNRnpYR3VW?=
 =?utf-8?B?RUJQYmNIdkQ4cE1MNTlOY25uQTNIN0E5SDFUcUJZZDBFN1pydm5JM0svWVlF?=
 =?utf-8?B?YzdJRFVxSldRRlduZ2tGV1g5MGdjY1V3YVIwRFZVcEJ1ejEwemVJcTRtQlJI?=
 =?utf-8?B?Nkh6SmlLYnRTK3pYR212eTk5Y3EzSU01a08yNGoyeFk5K3FsaXpWa0xNbCtw?=
 =?utf-8?B?UTd0cjJyL2xQZUE2Y2pPYnkwU0J0UWEzR1JVNTc1S3lKN3hBTjlMTHJqZitF?=
 =?utf-8?B?a0J1ajl6OThEZG9jMzlHN1pKUmk5aUU4UHBUYlNXakhQUVJJY1ZYOFpidzcw?=
 =?utf-8?B?c0tTTzNKMEZUcStCS2s0M3dtVXRLZlA3cllPeDhVZWg1SWxXSE5wNGYzZGtF?=
 =?utf-8?B?THdsZXJZWjdDUHc1ZG5WZFFzbk5kWFFWbTBOaDRzS29FcXNVTUxVUDRiZmxS?=
 =?utf-8?B?WUpQMmVJN1FQbzRNbEVxaXJFbHFUWEwvTXo2R0ZpcEhETk5EaTU1QUdFSm9S?=
 =?utf-8?B?S2hORWF4KzNRdnhEcElXREl3S081dWU0N1liZGJNaFFid3ozQ2FWNWgrMElx?=
 =?utf-8?B?NnFBQXdQb01RWEpab0M0cGNuRkp1QWxvbm9CVG83OEZ3RjRkMk92cVhoSmdQ?=
 =?utf-8?B?WmpWNGErWHI3QlF2dDFMN0xWbktCLzlpS3hQSzhuL0YrMmU5Vk1ZRkRNd1Na?=
 =?utf-8?B?aUVmMUdkNkxRY3Zwb2J1czI0dFFjWXZFb3FqTGZSTG54RXBGb1VPUjI3bTdw?=
 =?utf-8?B?TXZGNVhia043WDE1blkzdm9UK3hiSlpORlpMZHlibmlZR1g3S3pkMTFCN3hK?=
 =?utf-8?B?bHNld0JVTjExNkdNMGhDRzRMZWFIRFB0Q3pZLzFIRlowL2FXQ1ZLdDZTUVhp?=
 =?utf-8?B?UDVJRTV2eklETzRVU2F0STVTME5ZajJJTXZMUHRlSHNUVnU0bFVPUXV3QllR?=
 =?utf-8?B?amtjTCtIVHRPQllEaU8wbmM2ZTU5Q08zSUdLcVE3SGEyU1o5QVBGQ2wrK3Y5?=
 =?utf-8?B?OS93Tis0RVlRNEZYMW5uWXhSdVVEOU0yaXN6VE1Sang1NDJTY2l1ZXJYeUdt?=
 =?utf-8?B?NjhiamRwNHhObWwyaWMwR2RaSU81RzR5d3BHWHNPU0dWU2YvZFk3ZWRjUHJq?=
 =?utf-8?B?c3E1VmhLVUxTdnJHWDhoT0VRVkVIQlZuN2ZwOVVEZTFnajFhd3RITUNsZi9h?=
 =?utf-8?B?SHRWdnA0bDB6RFg2UmpkWjNhWlJ3OFY0VEt6SHQ0bmJsVkRrSndzN1NESW10?=
 =?utf-8?B?T3FZMkV2dlk3WjRNUEYrOHo2eXRxalYzeTM2SnNxdThrcGs5N0lRZ3hjRmZS?=
 =?utf-8?B?dzVnMzZBTW4rWkswN2JpYkdGRkprdjJSd2R1d1paNTAxa2FYR1RSOFV2dytx?=
 =?utf-8?B?aGNzbUs2LzNZcHRXK09DMXZJTFR3RURVUHFDRHYySHIvV2JnNHJDaWJGSFdo?=
 =?utf-8?B?MXFHNVV5cnlYaUo5TnkreDk5T3QvZzNaanBnYkQ5bUk3a2luS1pqMG1XNkdC?=
 =?utf-8?B?bjFoTHdHNjJpbzdTNnpWQ2ZsY2FOZHR0cDJRNENjeVZkWjhLbW5Pb3Y5ZXZX?=
 =?utf-8?B?cjJYZmxzTnVWSWtMUDcrMDg0Y0gwZUhjeEowbTdsRU5CeUw0ejM3NFl5eko4?=
 =?utf-8?B?MmpRM01qRHZKQUdxY3ZJWjh5MGlZZUtEaUFrd01QdmQzNUk1QXNRL044M2ZF?=
 =?utf-8?B?bk5SNHNOUUVzSzBiNjlwMTdtb2RVVVdVNFp1R3J1VzQ1TkV2RExYNWRnSmNr?=
 =?utf-8?B?VmIwTXRUNzVoRVhFYmJQNU8vTHJSM3pwTi9nU3dNdzN2ODltWXRlbWlGOWVs?=
 =?utf-8?Q?BLqAlkxibqe0KPwoG4S8UQg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2140b03c-7baf-43c1-34b1-08daf960da3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 14:32:39.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: si/xk1/Yg0nopRKZOj9qmlzzkmQqBD1/pSna4Q9SkmxqaghIO4fwvxHxfrLZhfapWLtttGYoLEI9rgQh4TPCOPsKJANkYQnGw6bslxsP01w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0113
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <986BFAA30829114F8D1B01A26C352611@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE0OjU4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxOC8wMS8yMDIzIDA4OjI2LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4g
RnJvbTogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gPiANCj4gPiBB
ZGQgQ0FOIG5vZGUgZm9yIGlteDhxbSBpbiBkZXZpY2V0cmVlLg0KPiANCj4gSW5jb3JyZWN0IHN1
YmplY3QgcHJlZml4Lg0KDQpTdXJlLCB3b3VsZCB5b3UgbWluZCBlbGFib3JhdGluZyB3aGF0IHRo
ZSBjb3JyZWN0IG9uZSB3b3VsZCBiZT8NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

