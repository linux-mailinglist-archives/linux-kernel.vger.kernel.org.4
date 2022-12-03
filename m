Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769FB641865
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 19:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLCSMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 13:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 13:12:27 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2089.outbound.protection.outlook.com [40.107.9.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327BCAE6D;
        Sat,  3 Dec 2022 10:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5OhNadV0ih+Vi63kbNrJZKjyhrg1Mkjqxa5chAqlU/ptzA2x4w5SEdpTjmQ54v7uLoQ1wcbCakVSCv5twuQ8aVyLkglQjEgQYWLG1xlpg9se/c617rAecZc5ElfmBq3um3eTHWOeLvwRu3Jm99z0eK1tJOsbKu73w/qQxElNfmkn1ICMPzQScTfm95jmAzggxSA/S9pAG/UxHBur7xMWG7n3+aW7a9doxBY0XEG0MNLrLFyFAWKIhq4O5hvV7LqI9B3SnqZetICaRFVW54Jsik95YvOIYIOD4HGtMKU+JSLlBGn30tVU5gP1nI+PT0Bryh54EJqz1t8hwQkpJLRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igVgAjrvwgek1wQufbKBBrYaMzft3e+MRBa50yNJ8fc=;
 b=STxMoYcqo5Sg6aJrWt52J4xNaon8z6ewTLwxux+6BuUzgl4nJj+9dPXBFXXcPFgwcCLNYohjBPHqYEHqwX6HS2YIIR2WP4nEz2xTlPpbLXr5R+vb//hX9ljfY+cToCP6X/H64GyVR5YQZhG0kKcy+l4zXxtQDdWa8Qtsqd81Ag73ae61t42fg3k9FZ33H1Uey4/l3wbnakYj5m8bUXrzG+V1UJDs7aNvATMW22S0/KucdSWcqkrSsRQBaiZ7N+0l51q3dOGDRhXuM6CqL7n5o5WgafCksp1UUt3RoI0wNiOgdBg8NfzivbmnVUd/g6nIpnIfK1NKuD+zjaFqXy3uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igVgAjrvwgek1wQufbKBBrYaMzft3e+MRBa50yNJ8fc=;
 b=C/qcRJcFLYhFnUqGYbl+R+Y7hXpYYGfdJNndNF8uIUAj6YD9+v1W806aF38to8oYNFJIKJNF7RKkmIYqe2rA87xor5T2FbDA6H5vKichUYd+wimsem37HN+59Kscaj7IwGhy2d0+zqn4rFUU+dIjczJn62X93Rh9rnh4+27GKxB9CkIevY3xPzORhXaTSeRHHjZHQXhsEaz9HRZx/NG8uUrB6k+NSp1rN1b7FkpP3rIRSl59LCiJ1YxrGhRE1IKMEsl+R7aTHLkrXIjsCI+lDszmEyKwcFjjPQCYJRB6ZOVSzIKKd+R7iiTD3zKTFVynLrThpZ2WFnWhmhQeI6Yqnw==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PR1P264MB1789.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Sat, 3 Dec 2022 18:12:23 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::44af:3ff7:9d0c:8db1]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::44af:3ff7:9d0c:8db1%5]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 18:12:23 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 3/5] Implement modalias sysfs attribute for modules
Thread-Topic: [PATCH v6 3/5] Implement modalias sysfs attribute for modules
Thread-Index: AQHZBqAs/g7bL4nmikmETVEkez1RHa5ceFUA
Date:   Sat, 3 Dec 2022 18:12:23 +0000
Message-ID: <eeb67369-538e-5e86-38a1-f7795f626d03@csgroup.eu>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
 <20221202224744.1447448-3-allenwebb@google.com>
In-Reply-To: <20221202224744.1447448-3-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|PR1P264MB1789:EE_
x-ms-office365-filtering-correlation-id: 38f4d1b5-5fb1-400a-4e04-08dad559ed46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xm9xhVBtujCpVkzkQD+MZHCx266JpyIHY6LCShwtNoGWRA6bDnZMNnJUiul9v/1xPoWYSSS9KnsCFIKY3igjOiEzs8mkT3/qqTsAdbtj3Z4vW0HjyjtBU2BEwg8OqorSwdJDGSeDZ/2GBv8tRUBRORqjrSx215ORc7LaqCq/7ccCwRP0gWu+mzfS5KrfACH//e++va3Y8z+rtT/QlphDwBfvC2w8WeIum1y2k7gQ6yFaEkvAEu73HjibpuSnOt+0xIRd2BtjxJl3DTMNoSPMacPfNTs9D47fZvp9isejcgVE896mdgXuzU7IMdmEnk5e/iYxiI+Zn6GX15J1w6HsdebU+Oq6kLSrhnElVxdrbUlLCqtLrdZTvuVeMdR18Bmi2QE+aYU56gOI36y7RCoXHs2imxL1f8IfynPBsnr0kH25Cxv3RIhHagmO9YNVTkNJ2D9jqy/UbKRpO5wWU0oz3lsJOgfd/HMYW5Y1BBoUSafWh2LllI3Fh4Z1T59d6TCPU60y3evVlG10uw3Q4CmMuz7RRlbYMCF6rjL+Xay2GEBlWcX2Kw6fqMNZnllvjl+Nuw8RdIMX4eSNc2i/rIjZX8KJjfwLd0Bc1OeWEy0+wUEANH04wipgDYWGl0XeniyICB10ucpgBTbe1RAlLEpSpiaeyVQ9RO9LaqMiZj7XTm28akxQqg52LCDYMAsrxZUNU3wCw4giH2EzWy62aaYjszIYVxhthKn/IUmoB5dd8xnHFM0V0oieL93RhT7HrtDzyAiSwcgr3fYjDnAVdJ1D2UKYZOCa9Pl4ECpruzBQwUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39830400003)(366004)(136003)(451199015)(110136005)(36756003)(6506007)(2616005)(6486002)(966005)(4326008)(66574015)(186003)(316002)(64756008)(2906002)(8676002)(31696002)(86362001)(91956017)(8936002)(6512007)(26005)(66946007)(83380400001)(66476007)(66446008)(66556008)(54906003)(478600001)(41300700001)(76116006)(31686004)(71200400001)(38070700005)(5660300002)(122000001)(38100700002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmpaYnVRR0pKRDd2M0ZQMEk4SzlTZi9HQ0M5UDcxa3VvKzZQYmZCSFdjV0lq?=
 =?utf-8?B?bWxlbG9nZTIyaEVzdnN3N1VNZTBxWVRhdXIxa1FoeGx2bmtxaW1JUGRLMnY3?=
 =?utf-8?B?NWttZDhma2hJak9pYkZUYjRPaVNGVzdYUWlSRW1nbVJ0NU5hNXAxeE5FZjFE?=
 =?utf-8?B?WHRvYTVwUmpjdjV1OGdQb1QyMmdBWDhkRmlEZjByaXo4V0dxRnBKMDJ0V05H?=
 =?utf-8?B?WUhFL2R1NEFxdTlRUWxMVklqQkxueWR1MDV6Tlc2cndFR1d1aHp6bDY4MzFu?=
 =?utf-8?B?UlZMRFNBYTgrSDFuQktmSTB5MENJSU9IMzhOU3hNN2duQjZSb05XaDdNMjR5?=
 =?utf-8?B?K2VjTXJGRFRFVzNYbnhyNUVMSjlXM21yMW9hZmIyaDkvZXdvQTVUd0E3aEY3?=
 =?utf-8?B?Zlh3RWt5dWRIcGVIMnRhQUI1NGQzanlLRlNiY1NHSFJwZUtrdGZnRE1SdXdq?=
 =?utf-8?B?amgxR1NLdDdhbnYybVpRQ3hCNDZ1czdmS2RtZHBmSElIY3Vxb1JWVG5HZ0VI?=
 =?utf-8?B?aEdoMUg4MFJ3cU9NNW9TMm8wdXpiY3d1YXNRNEtVM3VGaTd5Ri9ReXFkOE1N?=
 =?utf-8?B?dnNZb21iUVBEY0ZIVGEzcUNKRm9YNEgrdC9sK25HVDdiN1B2UVVUc2ZwYVNh?=
 =?utf-8?B?c2hyTE1nUGU5M0NvY1VJaDcrZFRiWXNjZmlSMHBxbm9iY3NIMjExTHF2Qkh5?=
 =?utf-8?B?NGswMUlxb1gxOVJIMjkyWEZEVGlMWVVKR3FlVUh3WlRVMm43NDBNTk1TRi8z?=
 =?utf-8?B?eWRzWmx5b3luSWNvMHVMY3NVY293Y0d3bkc2VVJlUGdQeTBLeUZlU0pwWmFm?=
 =?utf-8?B?NmRLNDlodndSb1o2UTkrNzZyVm1RQkdvb011Q3RnRnA4am40aE00MnVTcWYw?=
 =?utf-8?B?VjFEaUpMR3R1NDU1RnJ6eWxMV1lHckV2cTgvSVRUTFczcHBFZ2RYZXVsbWVv?=
 =?utf-8?B?cnZpSFkxVU5JRDFvUmlaODVtVGZuZ1RnYVB2WDJPSEN1ZTJJUGlwT2lOczQx?=
 =?utf-8?B?dzVYVE5Jbm11UXZERE9YMUwxQUdHYnYyQTE2RGFlTEhCdUtmQkRKTHIrUHlU?=
 =?utf-8?B?SENVYWFzNnBxN3ltb2dIYkc4Qk51QmxzZFdtU2tyQTh4VHJESnhnVk5LcUlI?=
 =?utf-8?B?L1hUUGJaYTd0TnVJWkV5eHFqdjFTb2NNdTlXWWo2LytYcitNMWVIQk9RU1N6?=
 =?utf-8?B?ZkxzYVBmZm1KMjFJUEF3emhTbXp4Z1VmbGNWQXh5WFZRNklWRk9hVGdrQXdF?=
 =?utf-8?B?Y3RzS2ljVkFzU04rZjJCRFNUYStMdHh2aENXMVV3dEJFSVV0alZlOGJlNFg4?=
 =?utf-8?B?cUJXTEtoaGlHNlpzZk9sMVJmSHViNzc2NG1OTldkaEtxRnNRMWN2dHliakND?=
 =?utf-8?B?NWZaS1k4REljVGw1VkZTYWhvQld5K3NxbStIdVBFNVkvWmVBbEl0bERBZGpt?=
 =?utf-8?B?RmRnVDF0Rm1hdXhreUpqeVMxY0R3R2NDNnZFMExibjNac0RvU08zY2Z6Y3Jj?=
 =?utf-8?B?TVBXZXI0RFVTK1dPbzh4Sy8rMUJYbWV1QkpETEdJN3M1RHZheFUvOW9Wd1NF?=
 =?utf-8?B?empBMURqV2NKbGtZUnNNazJ6bDJNUGVOcDNyeE9UTjk1NEFZMU8rVE1iK2Zl?=
 =?utf-8?B?blp5NFlZWXlhbWhicjhVOURDOFVkdlZLSGxjdzZnaEJLU2o2dmJVejhEMU54?=
 =?utf-8?B?akdPMzhwQWlYWnFRVTZkTDhDVFIvS3BXRjNUby9CLzMwYnhUYnQwSE41U0Zy?=
 =?utf-8?B?S2hGdkpXNUMwVWJyMVN3dTFNdWFyTk44UEhzbGtLZVoyUGlHRW92TzNSMVVI?=
 =?utf-8?B?c2lBMEZYQWtucTlON25NZFhFT2VyTUFtT1VlcUJYbks0dDgyR2d5aEl5UW9X?=
 =?utf-8?B?ak5KaVJIb0FSOXoyQWd1dCs2b3ZTNUVYN1NOVU1XNmVtNGpzV0RKcFppRnFv?=
 =?utf-8?B?VXBRUnp2MStCQnVGaEM4ZSsweStaWVZkaDBGb3gvb3NWOGNwanVydDhaQ2VN?=
 =?utf-8?B?THNRZzRPUzY3MHpVc05FZlJOd2pYS3gxS3gxVjFMbDBVcDlOSCs4S2VMZFZp?=
 =?utf-8?B?WUIxa0Z1dVVIT2NER2NtbDZ3eDJnZjJ1RVBnR1U1ZC9hRU83ckE4TDJQZnZ2?=
 =?utf-8?B?dzlwVkprTGd6dHRuNHMzOVc0cHpYc1JoK09FYUkydmdMTWVqUTl5bjNnV09S?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E47E0B34E1E9148ABA18502E62F47B0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f4d1b5-5fb1-400a-4e04-08dad559ed46
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 18:12:23.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhOCjDRgmVWnrs3UOWuWOEY6xHOjRyCE6KmWylYfIbKrC5vhcIzDxtCDwI4rhVTTVx8ILSkHKmX00la9HNn5v3t6unuuJLNl2Jyk4nGghSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1789
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzEyLzIwMjIgw6AgMjM6NDcsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gV2hl
biB0aGUgbW9kYWxpYXMgYXR0cmlidXRlIGlzIHJlYWQsIGludm9rZSBhIHN1YnN5c3RlbS1zcGVj
aWZpYw0KPiBjYWxsYmFjayBmb3IgZWFjaCBkcml2ZXIgcmVnaXN0ZXJlZCBieSB0aGUgc3BlY2lm
aWMgbW9kdWxlLg0KPiANCj4gVGhlIGludGVudCBvZiB0aGUgbmV3IG1vZGFsaWFzIGF0dHJpYnV0
ZSBpcyB0byBleHBvc2UgdGhlDQo+IG1hdGNoLWlkLWJhc2VkIG1vZGFsaWFzZXMgdG8gdXNlcnNw
YWNlIGZvciBidWlsdGluIGFuZCBsb2FkZWQga2VybmVsDQo+IG1vZHVsZXMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGxlbiBXZWJiIDxhbGxlbndlYmJAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICAg
aW5jbHVkZS9saW51eC9kZXZpY2UvYnVzLmggfCAgNyArKysrKw0KPiAgIGtlcm5lbC9tb2R1bGUv
c3lzZnMuYyAgICAgIHwgNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmljZS9idXMuaCBiL2luY2x1ZGUvbGlu
dXgvZGV2aWNlL2J1cy5oDQo+IGluZGV4IDgyYTU1ODM0MzcwOTkuLmNjZTBiZWRlYzYzZDkgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2aWNlL2J1cy5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvZGV2aWNlL2J1cy5oDQo+IEBAIC02MSw2ICs2MSwxMCBAQCBzdHJ1Y3QgZndub2RlX2hh
bmRsZTsNCj4gICAgKgkJCXRoaXMgYnVzLg0KPiAgICAqIEBkbWFfY2xlYW51cDoJQ2FsbGVkIHRv
IGNsZWFudXAgRE1BIGNvbmZpZ3VyYXRpb24gb24gYSBkZXZpY2Ugb24NCj4gICAgKgkJCXRoaXMg
YnVzLg0KPiArICogQGRydl90b19tb2RhbGlhczogICAgQ2FsbGVkIHRvIGNvbnZlcnQgdGhlIG1h
dGNoaW5nIElEcyBpbiBhDQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNl
X2RyaXZlciB0byB0aGVpciBjb3JyZXNwb25kaW5nIG1vZGFsaWFzZXMuDQo+ICsgKiAgICAgICAg
ICAgICAgICAgICAgICBOb3RlIHRoYXQgdGhlIHN0cnVjdCBkZXZpY2VfZHJpdmVyIGlzIGV4cGVj
dGVkIHRvIGJlbG9uZw0KPiArICogICAgICAgICAgICAgICAgICAgICAgdG8gdGhpcyBidXMuDQo+
ICAgICogQHBtOgkJUG93ZXIgbWFuYWdlbWVudCBvcGVyYXRpb25zIG9mIHRoaXMgYnVzLCBjYWxs
YmFjayB0aGUgc3BlY2lmaWMNCj4gICAgKgkJZGV2aWNlIGRyaXZlcidzIHBtLW9wcy4NCj4gICAg
KiBAaW9tbXVfb3BzOiAgSU9NTVUgc3BlY2lmaWMgb3BlcmF0aW9ucyBmb3IgdGhpcyBidXMsIHVz
ZWQgdG8gYXR0YWNoIElPTU1VDQo+IEBAIC0xMDcsNiArMTExLDkgQEAgc3RydWN0IGJ1c190eXBl
IHsNCj4gICAJaW50ICgqZG1hX2NvbmZpZ3VyZSkoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gICAJ
dm9pZCAoKmRtYV9jbGVhbnVwKShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgIA0KPiArCXNzaXpl
X3QgKCpkcnZfdG9fbW9kYWxpYXMpKHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcnYsIGNoYXIgKmJ1
ZiwNCj4gKwkJCQkgICBzaXplX3QgY291bnQpOw0KPiArDQoNCkl0IGRvZXNuJ3QgZml0IG9uIGEg
c2luZ2xlIGxpbmUgPyBVcCB0byAxMDAgY2hhcnMgYXJlIHRvbGVyYXRlZCBhcyBpdCANCndvdWxk
IGluY3JlYXNlIHJlYWRhYmlsaXR5Lg0KDQo+ICAgCWNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzICpw
bTsNCj4gICANCj4gICAJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9tbXVfb3BzOw0KPiBkaWZm
IC0tZ2l0IGEva2VybmVsL21vZHVsZS9zeXNmcy5jIGIva2VybmVsL21vZHVsZS9zeXNmcy5jDQo+
IGluZGV4IDhkYWZlYzc0NTVmYmUuLjY1MWM2NzdjNGFiOTYgMTAwNjQ0DQo+IC0tLSBhL2tlcm5l
bC9tb2R1bGUvc3lzZnMuYw0KPiArKysgYi9rZXJuZWwvbW9kdWxlL3N5c2ZzLmMNCj4gQEAgLTUs
NiArNSw4IEBADQo+ICAgICogQ29weXJpZ2h0IChDKSAyMDA4IFJ1c3R5IFJ1c3NlbGwNCj4gICAg
Ki8NCj4gICANCj4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UvYnVzLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvZGV2aWNlL2RyaXZlci5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2ZzLmg+DQo+
IEBAIC0yNDAsMTEgKzI0Miw2NCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYWRkX25vdGVzX2F0dHJz
KHN0cnVjdCBtb2R1bGUgKm1vZCwgY29uc3Qgc3RydWN0IGxvYWRfaW5mbyAqaQ0KPiAgIHN0YXRp
YyBpbmxpbmUgdm9pZCByZW1vdmVfbm90ZXNfYXR0cnMoc3RydWN0IG1vZHVsZSAqbW9kKSB7IH0N
Cj4gICAjZW5kaWYgLyogQ09ORklHX0tBTExTWU1TICovDQo+ICAgDQo+ICsvKiBUcmFjayBvZiB0
aGUgYnVmZmVyIGFuZCBtb2R1bGUgaWRlbnRpdHkgaW4gY2FsbGJhY2tzIHdoZW4gd2Fsa2luZyB0
aGUgbGlzdCBvZg0KPiArICogZHJpdmVycyBmb3IgZWFjaCBidXMuDQo+ICsgKi8NCg0KQ29tbWVu
dHMgc3R5bGUuDQoNCj4gK3N0cnVjdCBtb2RhbGlhc19idXNfcHJpbnRfc3RhdGUgew0KPiArCXN0
cnVjdCBtb2R1bGVfa29iamVjdCAqbWs7DQo+ICsJY2hhciAqYnVmOw0KPiArCXNpemVfdCBjb3Vu
dDsNCj4gKwlzc2l6ZV90IGxlbjsNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBpbnQgcHJpbnRfbW9k
YWxpYXNfZm9yX2RydihzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2LCB2b2lkICpwKQ0KPiArew0K
PiArCXN0cnVjdCBtb2RhbGlhc19idXNfcHJpbnRfc3RhdGUgKnMgPSBwOw0KPiArCXN0cnVjdCBt
b2R1bGVfa29iamVjdCAqbWsgPSBzLT5tazsNCj4gKwlzc2l6ZV90IGxlbjsNCj4gKwkvKiBTa2lw
IGRyaXZlcnMgdGhhdCBkbyBub3QgbWF0Y2ggdGhpcyBtb2R1bGUuICovDQo+ICsJaWYgKG1rLT5t
b2QpIHsNCj4gKwkJaWYgKG1rLT5tb2QgIT0gZHJ2LT5vd25lcikNCj4gKwkJCXJldHVybiAwOw0K
PiArCX0gZWxzZSBpZiAoIW1rLT5rb2JqLm5hbWUgfHwgIWRydi0+bW9kX25hbWUgfHwNCj4gKwkJ
ICAgc3RyY21wKG1rLT5rb2JqLm5hbWUsIGRydi0+bW9kX25hbWUpKQ0KPiArCQlyZXR1cm4gMDsN
Cg0KaWYvZWxzZSBzdHlsZSwgc2VlIA0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9j
b2Rpbmctc3R5bGUuaHRtbCNwbGFjaW5nLWJyYWNlcy1hbmQtc3BhY2VzDQoNCj4gKw0KPiArCWlm
IChkcnYtPmJ1cyAmJiBkcnYtPmJ1cy0+ZHJ2X3RvX21vZGFsaWFzKSB7DQo+ICsJCWxlbiA9IGRy
di0+YnVzLT5kcnZfdG9fbW9kYWxpYXMoZHJ2LCBzLT5idWYgKyBzLT5sZW4sDQo+ICsJCQkJCQlz
LT5jb3VudCAtIHMtPmxlbik7DQo+ICsJCWlmIChsZW4gPCAwKQ0KPiArCQkJcmV0dXJuIGxlbjsN
Cj4gKwkJcy0+bGVuICs9IGxlbjsNCj4gKwl9DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyBpbnQgcHJpbnRfbW9kYWxpYXNfZm9yX2J1cyhzdHJ1Y3QgYnVzX3R5cGUgKnR5cGUs
IHZvaWQgKnApDQo+ICt7DQo+ICsJcmV0dXJuIGJ1c19mb3JfZWFjaF9kcnYodHlwZSwgTlVMTCwg
cCwgcHJpbnRfbW9kYWxpYXNfZm9yX2Rydik7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgc3NpemVf
dCBtb2R1bGVfbW9kYWxpYXNfcmVhZChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGtvYmplY3Qg
KmtvYmosDQo+ICAgCQkJCSAgICBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSAqYmluX2F0dHIsDQo+ICAg
CQkJCSAgICBjaGFyICpidWYsIGxvZmZfdCBwb3MsIHNpemVfdCBjb3VudCkNCj4gICB7DQo+IC0J
cmV0dXJuIDA7DQo+ICsJc3RydWN0IG1vZHVsZV9rb2JqZWN0ICptayA9IGNvbnRhaW5lcl9vZihr
b2JqLCBzdHJ1Y3QgbW9kdWxlX2tvYmplY3QsDQo+ICsJCQkJCQkga29iaik7DQoNCkRvZXNuJ3Qg
aXQgZml0IG9uIG9uZSAxMDAgY2hhcnMgbGluZSA/DQoNCj4gKwlzdHJ1Y3QgbW9kYWxpYXNfYnVz
X3ByaW50X3N0YXRlIHN0YXRlID0ge21rLCBidWYsIGNvdW50LCAwfTsNCj4gKwlpbnQgZXJyb3Ig
PSAwOw0KDQpEb24ndCBpbml0aWFsaXNlIHZhcnMgd2hlbiBpdCdzIG5vdCBuZWVkZWQuDQoNCj4g
Kw0KPiArCWlmIChwb3MgIT0gMCkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwllcnJv
ciA9IGJ1c19mb3JfZWFjaCgmc3RhdGUsIHByaW50X21vZGFsaWFzX2Zvcl9idXMpOw0KPiArCWlm
IChlcnJvcikNCj4gKwkJcmV0dXJuIGVycm9yOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgY2Fs
bGVyIGNoZWNrZWQgdGhlIHBvcyBhbmQgY291bnQgYWdhaW5zdCBvdXIgc2l6ZS4NCj4gKwkgKi8N
Cj4gKwlyZXR1cm4gc3RhdGUubGVuOw0KPiAgIH0NCj4gICANCj4gICAvKiBVc2VkIGluIGtlcm5l
bC9wYXJhbXMuYyBmb3IgYnVpbHRpbiBtb2R1bGVzLg0K
