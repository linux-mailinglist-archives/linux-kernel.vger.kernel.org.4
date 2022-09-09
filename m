Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08025B3AD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiIIOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiIIOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:39:38 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB6C12D10
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:39:36 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-NsuC0PNrNPSwxGvZzOc1LQ-1; Fri, 09 Sep 2022 16:39:33 +0200
X-MC-Unique: NsuC0PNrNPSwxGvZzOc1LQ-1
Received: from ZRAP278MB0383.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2f::11)
 by GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 14:39:32 +0000
Received: from ZRAP278MB0383.CHEP278.PROD.OUTLOOK.COM
 ([fe80::21ec:3301:e620:576]) by ZRAP278MB0383.CHEP278.PROD.OUTLOOK.COM
 ([fe80::21ec:3301:e620:576%5]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 14:39:31 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>
Subject: Re: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Thread-Topic: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Thread-Index: AQHYw6J36XbPp0cJM0ex5Lib68XRDK3Vz1eAgADoJYCAAHUwgA==
Date:   Fri, 9 Sep 2022 14:39:31 +0000
Message-ID: <a202d401dabb47da24bfcbad7140281a9af6c0c4.camel@toradex.com>
References: <20220908164434.122106-1-niklas.soderlund@corigine.com>
         <3275d886491dc934e3277cde9cc766b0ce0886ea.camel@toradex.com>
         <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
In-Reply-To: <Yxrt1aa60xY0H7j0@oden.dyn.berto.se>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZRAP278MB0383:EE_|GV0P278MB0083:EE_
x-ms-office365-filtering-correlation-id: ac5b658a-0d4c-44c4-f477-08da92711baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: EmmJYNEkABsTrXm1XfnAyREIt8oCEAHEqJRzxEi2LEuCYB7IF70+GfrgGAyRhTU7xZaxDiwVtzPC1Fu3XMXfSog+unXXMsoIL/foRwSYAIDqfZ58bMkK7qYgbE3ZBto6Mol6nTyMpREGvgh1NXQWDXu8/fNOVJmKsEWtEjR3nm5C1DR4BVL1b+pgocdHMdGIn7TKBZMd324NGgKwt1MIMmGaL5FnpTfVZFb6o1N8SDlGySWSJAPSvaBZ9oiX1hDAgZFL8LSXQKSDpZb905sUo7L+Vw2eA8mu2tXiWGVx2hXKx0EF4SREWDIu3JVMMLUylEdEUDXBkwl9JHB13heuC/AegJk10i59WdCrEFWrEFdLj4pE50i+aO73j5G4K+bXOXoSM6+fkR5MifTMNxrAdbdVXOwwEOalbo6p7j3g7DfzAOMeV4eWwPQiiH4dON42TsQpnoWRqLnc0asJiI7sRDdC9RfB2MUI1OlgvOhUhJC4+tvF2BmsQN4qJIZO4rBm1ONGA3VF/Gt9P9tF+ZqwMxx1n8Er5hMFHKJQUkoLSCz89g6+YQmBDABjp818ArcKukVz17OBRImEpokmlZwl5NYtkHX3ASQ2nr7EVQa11yht26uN3V83MarNYHsXA2ZSS78FC3y4P7iG/ruvyQuG7ebPMzasUvSSObHPO1Y+MpLIhhrZjWwmu1MUlDOUlYAw7ocbU357qDeo2yF0wafkWQvPsJ0sSvYjFOShpAyjdfbUi4WdzLrOggUKwvt1Qntg0dLMxGKts07eL24wwGDImOieeXUbXLGsrzAWc28lNWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0383.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(76116006)(2616005)(966005)(6486002)(186003)(66476007)(66556008)(36756003)(66946007)(478600001)(66446008)(8676002)(4326008)(64756008)(38070700005)(7416002)(8936002)(316002)(41300700001)(54906003)(6916009)(71200400001)(6512007)(26005)(38100700002)(2906002)(44832011)(5660300002)(122000001)(53546011)(6506007)(86362001)(83380400001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGR0WXB3bVhRYjNmQWhZTEJkRmpkWXBTY3ExdXpBRGhrN21vbjRQdkt0Y0Fm?=
 =?utf-8?B?YWhVZU1iRVRNcVlGbElUeERPdHlCNmtVUUQ4R2RsM1JsTXVzUWJGSjBpd00w?=
 =?utf-8?B?SUpWaE5OTnh6VXdLZnBLZFJDaUR4bGZyR0Z1bzFEY2N0TDg0KzNISmF0Tlc1?=
 =?utf-8?B?WGh5UWFvVmZHNTQzZDVsaFFjL1AwWWV1Z3NDVkZSNjRvRTA4UTAvazNlaWpB?=
 =?utf-8?B?Y1pVeTkrRVM2OThzeHFwd2lrM1lmaUhzSGVRUWF2bmExYzRtS2ZISCtLb3hY?=
 =?utf-8?B?TXJTb29uOWhHYlU0VmJ1S2w3UHlmZGlnekcrcEh0cVpxSlZFanl4NFpBZjdy?=
 =?utf-8?B?NStGL3ptdDdZcUxhWDFiaEVIbWFlMzJhRFV3RkV3MitoL3kyblRtMkZnTVhR?=
 =?utf-8?B?Yms3YVpVbHptK1gyVDhYOGhYZ3dkdGVVQ2NvWWgvdlBEL3N6L0hYK1NJWlhm?=
 =?utf-8?B?NzFmcmJuaFdmRkdIVmc4VURXdGt5RXNnR1BRWjJtTEJ6ZThCU2FSSGljelNv?=
 =?utf-8?B?UUJhTDlYd3ZpYndkOXBkamw0Ui8xK0pDM00vTUdBMHFHc3hlMmNUZ1VjRXl2?=
 =?utf-8?B?RFR0YVB2cHpDYWJOa1Y5Q3hsZ2xoNVk2Zko1OVZiVGh4RjJPSVJmOGcwQmVn?=
 =?utf-8?B?aUtNcW0zbWZDclBKU09pQWx0V1pYUmdjQ1czVEtRQU9ickM1dFNjbHFkc0Fn?=
 =?utf-8?B?RGUvZTNObnRvZXFMMkJ3RGIwYjB4clRGTlhKQkFBRlNSam1KWHEzQTZMbExh?=
 =?utf-8?B?MUlDTzFRZ0p3bFVidFhzQStDdGZRaVFHNWZQc3VOcGFrczdBWHY5ZWg5cVYw?=
 =?utf-8?B?Z2s0QVU0aDRhVWs2QURlbnhnSFFJK01wNUxlbkhUQkRtbE1TYm1HRytjRGdV?=
 =?utf-8?B?UWtuVXhBcVFSdE0zNVJBc1JkampBeGtFTHVkUGx4SWF5OFpIVERCSi90YWhh?=
 =?utf-8?B?TDdWNzh0bWgyVUFyZlBZcWYwM3dCNFRGYVNOdWVldGcvSmFUbTlhb25GRkZQ?=
 =?utf-8?B?aDY0Ukh2TXJmMkp3ZFRaUEVZNlRQWFdndVlrK0FRdFVuR252RGNXcDMvRTM1?=
 =?utf-8?B?MXFZV2RCYWN4UFp2cm5aVGUyaU4xNG1obFByUVJ2ZytTZzlQaGlDVlYvYXJV?=
 =?utf-8?B?R1YwSzlSc2VwRnpsNEZ2R1FmSHpYZlYxUkxNaHhpWGtNenk4R2tlMWJCMWJi?=
 =?utf-8?B?ZlloRGNYK0Q2YmRBRm9KMExPclA2TVFQOTlkMXcrTTJ2TEJCeVVlRGJJdllV?=
 =?utf-8?B?MlYyK1RkNVZJUm0zTlZKcGdGa3hxSGh4L2dMc1ZYZS9ORzUvMUlTN2dZR0FJ?=
 =?utf-8?B?cWh5N0ZVYzZRUE1vSUJCYU9TaHpOVC9VVmJHdDlYbFcyRFJEZkRITFNjZHEy?=
 =?utf-8?B?NXR2U3lGRkRjd1RYemM0MDhEeSthakRmaVE1Tk80dzNIS1NaN3RpZllKZE15?=
 =?utf-8?B?V2RiVk5hYy9xbXRSNFg0eTdYMGVUbHRxZWJod3hyQVQ1VVpGU1ZCMWdjQXdM?=
 =?utf-8?B?NGdoSjNiVmthcng5QXdETFZWS2VqM0x0Z3h1MUV1VzFpUkZyVjRNTFd0dktK?=
 =?utf-8?B?ZzJZUjBqRUJ4SlZKZzFZVURpRnMyYmN0TjNSUUJaT0V1eFFwLzNUUGNMSDFK?=
 =?utf-8?B?RXVidXVmeExTZmpaZ0l0NFlnWUd1OWtrM0JlOUxhUm41UDUzaC9KWWlIdlZl?=
 =?utf-8?B?TGlpTzgwV2t1ek91QUVKRkZoRWk5cGUrNEwwdUhYTFBraEhGSFFHWEhmR2Mr?=
 =?utf-8?B?WUVqTjdpQk5NZ3J2a0tMWU9oYVJIQkprUklqRVRWLzVjRFptRWJhZEFnaGR4?=
 =?utf-8?B?TG40Wm1SK1prNXI3R05oM3RGZE9DNHVSVkw2YXdwYUZ5SXo4WmhvOTdBN2p6?=
 =?utf-8?B?VEp4a3RqMlVXcXRvUkdnSzFHNnNhN01ZTE5ZVG9YekkrTUpMUWh3VmgxbXJ5?=
 =?utf-8?B?S3pUUVBWMGhyZFZ2MnIyemVIOStLK2VoMk5RejViSVRud1pwTG9wNmJ1blo5?=
 =?utf-8?B?TklnM0NRZU9FU2F2MGdwVlIyL1FJeW5McVdLNkFIVk9wMXdXRXBKZFFGaHRP?=
 =?utf-8?B?MU1ESzUvNFJnN0VPT0dFYlhrMEZESUZML3VidDhOQjBNOTV0UUdWc2xaWE03?=
 =?utf-8?B?dC92a2xQZVZtWFI5NGtXTmJ3V1NNMEN2b3hWNVBSZHpXdDc1S0Y0ZWJMbWZK?=
 =?utf-8?Q?y870zGxSaI8SpMZlWluc8B0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0383.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b658a-0d4c-44c4-f477-08da92711baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 14:39:31.9181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/ZKNlfLVR/eW9s6uPFIU6neCJYRhSRidMdvLwZynD+q39HLPDFoYmB+CAKg3Ys6rqR3Xl5Qx9opHtOHznYRhwe2ei/6cKNES+dczwNBu2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0083
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <75BAEEFB4390AC4BB6D78C0ABDB6BD47@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDA5OjQwICswMjAwLCBuaWtsYXMuc29kZXJsdW5kQGNvcmln
aW5lLmNvbSB3cm90ZToNCj4gSGkgUGhpbGlwcGUsDQo+IA0KPiBPbiAyMDIyLTA5LTA4IDE3OjQ5
OjE0ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90ZToNCj4gPiBIaSBOaWtsYXMsIA0KPiA+
IA0KPiA+IFRoYW5rcyBmb3IgYWRkaW5nIG1lIHRvIGNjLiBJIHdpbGwgYWxzbyBhZGQgU3RlcGhl
biwgYXMgaGUgYWxzbyBzZW50DQo+ID4gc29tZSBjb21tZW50cyBvbiBteSBzdWJtaXNzaW9uIHRo
ZSBleGFjdCBzYW1lIHByb2JsZW0uIEknbQ0KPiA+IHN1cHBvcnRpdmUgb2YNCj4gPiB5b3VyIGNv
ZGUgYXMgaXQgaGFzIHRoZSBuaWNlIGFkdmFudGFnZSBvZiBzdWdnZXN0aW5nIHRoZSByaWdodA0K
PiA+IGZvcm1hdCBvZg0KPiA+IHRoZSB0YWcgaWYgaXQgbWlnaHQgYmUgd3JvbmcuIEhvd2V2ZXIg
aXQgc2VlbXMgbG90IG9mIHN0dWZmIGlzDQo+ID4gc2xpZ2h0bHkNCj4gPiBkdXBsaWNhdGVkIGFu
ZCBsb3RzIG9mIGxpbmVzIGNvdWxkIGJlIGxlZnQgYXdheSBzaW1wbGlmeWluZyBpdA0KPiA+IGdy
ZWF0bHkuDQo+ID4gSSBkb24ndCB3YW50IHRvIGhvbGQgYW55dGhpbmcgdXAgYW55d2F5IHNvIEkn
bSBmaW5lIHdpdGggaXQsIGJ1dA0KPiA+IHdpbGwNCj4gPiBzdGlsbGxlYXZlIHNvbWUgY29tbWVu
dHMgb2YgdGhpbmdzIEkgdGhpbmsgc2hvdWxkIGJlIGltcHJvdmVkLg0KPiANCj4gSSBhZ3JlZSB0
aGUgTG9DIGNvdWxkIGJlIHJlZHVjZWQsIEkgdHJ5IHRvIG1pbWljIHRoZSBzdHlsZSBmcm9tIHRo
ZSANCj4gIkNoZWNrIGZvciBnaXQgaWQgY29tbWl0IGxlbmd0aCBhbmQgaW1wcm9wZXJseSBmb3Jt
ZWQgY29tbWl0IA0KPiBkZXNjcmlwdGlvbnMiIGNoZWNrLiBBcyB0aGVyZSBpcyBzb21lIG92ZXJs
YXAgbWF5YmUgb25lIGRheSBzb21lb25lIA0KPiBjbGV2ZXJlciB0aGVuIG1lIGNhbiBmaWd1cmUg
b3V0IGhvdyB0byBzaGFyZSBjb2RlIGJldHdlZW4gdGhlbS4NCj4gDQo+ID4gPiArIyBDaGVjayBG
aXhlczogc3R5bGVzIGlzIGNvcnJlY3QNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoISRpbl9oZWFkZXJfbGluZXMgJiYgJGxpbmUgPX4gL15maXhlczo/L2kpIHsNCj4g
PiANCj4gPiBJIHdvdWxkIGNoZWNrIGFsbCBsaW5lcyB0aGF0IHN0YXJ0IHdpdGggZml4ZXMsIGV2
ZW4gaWYgdGhlcmUgaXMNCj4gPiB3aGl0ZXNwYWNlIGluIGZyb250IChhbmQgdGhlbiBmYWlsaW5n
IGxhdGVyIG9uLi4uKQ0KPiA+IA0KPiA+IGlmICghJGluX2hlYWRlcl9saW5lcyAmJiAkbGluZSA9
fiAvXlxzKmZpeGVzOj8vaSkgew0KPiANCj4gR29vZCBwb2ludCwgd2lsbCBkbyBzbyBpbiB2NS4N
Cj4gDQo+ID4gSWYgd2UgY2hlY2sgYWxzbyB0aGUgZml4ZXM6IGxpbmVzIHRoYXQgYmVnaW4gd2l0
aCB3aGl0ZXNwYWNlIHRoaXMgDQo+ID4gd291bGQgYmUgYSBnb29kIHNwYWNlIHRvIGNoZWNrIHRo
YXQgd2UgZG8gbm90IHdhbnQgYW55IHdoaXRlc3BhY2UgaW4NCj4gPiBmcm9udCBvZiBGaXhlczog
dGFnLg0KPiA+IA0KPiA+IC8oXHMqZml4ZXM6PylccysoWzAtOWEtZl17NSx9KVxzKygkYmFsYW5j
ZWRfcGFyZW5zKS9pKSB7DQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAkaWRfbGVuZ3Ro
ID0gMCBpZiAoJG9yaWdfY29tbWl0ID1+DQo+ID4gPiAvXlswLTlhLWZdezEyfSQvaSk7DQo+ID4g
DQo+ID4gSSBzdWdnZXN0IHdlIGJvcnJvdyB0aGUgcGF0dGVyIHRoYXQgaXMgYWxzbyB1c2VkIGlu
ICJDaGVjayBmb3IgZ2l0DQo+ID4gaWQNCj4gPiBjb21taXQgbGVuZ3RoIGFuZCBpbXByb3Blcmx5
IGZvcm1lZCBjb21taXQgZGVzY3JpcHRpb25zIi4gVGhpcyBoYXMNCj4gPiB0aGUNCj4gPiByZWFz
b24gYXMgY2hlY2tpbmcgc3RyaWN0bHkgZm9yIDEyIGNoYXJzIGlzIGF0IHRoZSBtb21lbnQgcmln
aHQgYnV0DQo+ID4gYXMNCj4gPiBsaW51eCBncm93cyAxMyBjaGFycyB3aWxsIGV2ZW50dWFsbHkg
Y29tZS4NCj4gPiANCj4gPiAkaWRfbGVuZ3RoID0gMCBpZiAoJG9yaWdfY29tbWl0ID1+IC9eWzAt
OWEtZl17MTIsNDB9JC9pKTsNCj4gDQo+IFRoaXMgb25lIGJvdGhlcnMgbWUgYSBiaXQuIEkgZGlk
IGRvIHRoYXQgYmVmb3JlIEkgc2VudCBvdXQgdjEgYnV0IA0KPiBjaGFuZ2VkIG15IG1pbmQuIFRo
ZSByZWFzb24gYmVpbmcgdGhhdCB0aGUgZG9jdW1lbnRhdGlvbiBhc2tzDQo+IGV4cGxpY2l0bHkg
DQo+IGZvciAxMiBjaGFycyBbMV0uIEkgaGF2ZSBubyBwcmVmZXJlbmNlIG9uIGtlZXBpbmcgaXQg
c3RyaWN0bHkgMTIgb3IgDQo+IGFsbG93aW5nIGFueXRoaW5nIGluIHRoZSAxMiB0byA0MCByYW5n
ZSwgYnV0IGkgZG8gdGhpbmsgdGhlIGNoZWNrDQo+IHNob3VsZCANCj4gcmVmbGVjdCB3aGF0cyBp
biB0aGUgZG9jdW1lbnRhdGlvbi4gSWYgd2UgY2hhbmdlIHRoaXMgbWF5YmUgd2UgYWxzbw0KPiBu
ZWVkIA0KPiB0byB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24/DQo+IA0KPiBPbmUgYXJndW1lbnQg
dG8ga2VlcCBpdCBzdHJpY3QgaXMgdGhhdCB3aGVuIExpbnV4IHRoZSBuZWVkIDEzIG9yIG1vcmUg
DQo+IGNoYXJhY3RlcnMgdGhlIGRvY3VtZW50YXRpb24gd2lsbCBuZWVkIHRvIGJlIHVwZGF0ZWQg
YW5kIGl0IGlzIG5hdHVyYWwNCj4gdGhhdCB0aGUgc2NyaXB0IHRvIGNoZWNrIHRoYXQgdGhlIHN0
eWxlIGRvY3VtZW50ZWQgaXMgZm9sbG93ZWQgaXMgDQo+IHVwZGF0ZWQgYXQgdGhlIHNhbWUgdGlt
ZS4NCg0KSW4gdGhlIGVuZCBJJ20gZmluZSB3aXRoIGJvdGggdmFyaWFudHMuIFVwIHRvIHlvdSwg
SSBqdXN0IHdvdWxkIG5vdCBoYXZlDQptYWRlIHRoZSB3aG9sZSBjaGVjayB0b28gc3RyaWN0IGFz
IHVudGlsIG5vdyB0aGVyZSB3YXMgbm8gY2hlY2sgYXQgYWxsLg0KQnV0IHRoZSBmYWN0IHdlIGFy
ZSBub3cgZXZlbiBjaGVja2luZyBvbmUgc3BhY2UgY2hhcmFjdGVyIGl0IGlzIGFsc28NCmZpbmUg
Zm9yIG1lIHRoYXQgd2UgbGltaXQgdGhpcyB0byBzdHJpY3RseSAxMiBjaGFyYWN0ZXJzLg0KDQo+
IA0KPiAxLsKgDQo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nl
c3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjZGVzY3JpYmUteW91ci1jaGFuZ2VzDQo+IA0KDQo=

