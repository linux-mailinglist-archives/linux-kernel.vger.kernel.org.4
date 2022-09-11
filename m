Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80D5B4FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIKPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIKPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:38:37 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62724095
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:38:35 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-Xw_u3jROMOeSCjPaEpnWNw-1; Sun, 11 Sep 2022 17:38:32 +0200
X-MC-Unique: Xw_u3jROMOeSCjPaEpnWNw-1
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::14)
 by GVAP278MB0119.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Sun, 11 Sep
 2022 15:38:30 +0000
Received: from ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ec07:64ae:a4df:d320]) by ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ec07:64ae:a4df:d320%5]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 15:38:30 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "niklas.soderlund@corigine.com" <niklas.soderlund@corigine.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "apw@canonical.com" <apw@canonical.com>
CC:     "louis.peens@corigine.com" <louis.peens@corigine.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "oss-drivers@corigine.com" <oss-drivers@corigine.com>
Subject: Re: [PATCH v6] checkpatch: warn for non-standard fixes tag style
Thread-Topic: [PATCH v6] checkpatch: warn for non-standard fixes tag style
Thread-Index: AQHYxPDHPeguu16klUiagfGnsXRIOq3aXzWA
Date:   Sun, 11 Sep 2022 15:38:30 +0000
Message-ID: <7b2159922e989b1a5d5a3662fddb3c5ee2a97761.camel@toradex.com>
References: <20220910083835.2219239-1-niklas.soderlund@corigine.com>
In-Reply-To: <20220910083835.2219239-1-niklas.soderlund@corigine.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0377:EE_|GVAP278MB0119:EE_
x-ms-office365-filtering-correlation-id: 947ebb42-219a-4330-6b0c-08da940badb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 6JhwJFiURCDmz5fByUdzoLyIkHAk+/43FxLAjvzOECI/xxu6Up3PMTcVHKzlhenFj8LDih/DSA7M1B8aiyIQNvIQd46wWK4q3kfo/VKaMRpVQwUDB91XksjU/BBfaQSDpHYfvnG5FUrfbiZ6vRty5BE9NQKdENd1qFd9C4HQ9uDmyUCynZMDJtCa88paJ1yLq8TUM4EkkEmCAuGhpF+CS19qK/YMKmtq2yRKHlngzYZ+j53MhJcSbOQoYUplKVbP1O8Bo3hk29qybuptnVvDxWyKq+h/PhmFWDBjAAAh5p4kEl99Xpr70T2/s1k947cZp14q9wWkII4yn4lQTfwViPpcmZIHwwwoTMiFMlVyICotYlVm/cKgMIEPP0SWgS9XfHgm/qOH9bgatPJG4vD6xxC0V6x8cR0N3UjYZnSU37MDJ82+vWHWgLQpQNieHYy4VFaKTgbbx2ECZeygDuZSQB+1viKL/fb0iSBYvxcAeKdX+AazCjnCCTxHYJPWNj4nQcG4yS2uarBW6hbU7KE2E75lfHEoPJB0z01mJWHyax+7/CnqgXnHF7BSDw01DVB6V7U2NPLLW7WIArlwzPTcfk/F5r4jEXWPwms2sYD4Peoe1IwokzYZtK1eLPynJ6t+K4yOW+Zwx0mtnaLEZmXpfT9aNk2ZcTSR0VANO5k9lC4qxViMpxiK4HK6Ol79lXAtf3J5pknRNnOVjoEdt7AP/Q6VvwT0XGWkjR/bteEn97AMtUAUuAH6tsbIZv01aPRycCoMTB/wNNioazX8ZQuo19zd/VPTjJorf/Uo3r2EbL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39830400003)(346002)(376002)(2616005)(122000001)(83380400001)(36756003)(66446008)(64756008)(66556008)(66946007)(66476007)(76116006)(4326008)(2906002)(66574015)(5660300002)(38100700002)(8936002)(7416002)(44832011)(8676002)(966005)(86362001)(316002)(54906003)(110136005)(6486002)(38070700005)(41300700001)(478600001)(6506007)(71200400001)(6512007)(26005)(186003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEJnWTJFOGlFV2NrMmRDMFRORlhHcmhiZ3A3ZER5cW85SkxkNU1ROU1KenRs?=
 =?utf-8?B?NkRpZ2NiNGYzcXBIYTc1YkFxMjRuMUJ3TXp2ZGVXMnFEV2Y1bzA3Mm9vMUJC?=
 =?utf-8?B?R1UzcFdiQXBDdGcxZWJPdG1TeW9ZZXJOdHNhNlhFSHE5WGdQTVVtVlVLVXli?=
 =?utf-8?B?M050MzR1ZGovSk5wTU1ZRHZTUzBFRDhqMTFqTG9HTklKYkYzbjdmOER6c09B?=
 =?utf-8?B?S0g2Zkl4dmFPWGV1T3RrNi9Xd1lQV21heTF6UU0xZVhSYzFrbFh4SGJWYk9R?=
 =?utf-8?B?djUwNXF1MjI5V3c2UHpIZmZ1SGNPdVBZVlM5ZXczMlE2TEw0TlpoSGxlSVlM?=
 =?utf-8?B?dTY2cWJSWFpUYVZDL1RaWURYREthT3ZrTXREdmY4cTNXSmd4bkJIR3l3S3B5?=
 =?utf-8?B?YWFTT0YwSzlzeHF0ZHBBNktZeDNmQUYxOVF1NnR3VXRqa0UxZkFYdkQrb1pt?=
 =?utf-8?B?NHBBNkFxZE5UWWpYbDlBN2ltTjZiOGNCUFQ4d2ZwOHdKQ2thOVJaMk5EOFZy?=
 =?utf-8?B?NUNpMkVFdjhZZmFSNFFBS3hiZ09XY3MxbkpaUHRTWWRTVnh0K2RKUjBONEpD?=
 =?utf-8?B?SUhKR1RIZGJ1QStsekNTeUFXRXh6aFBRUGpqNlpBZlgvV2NEZVVNcVVQWTFF?=
 =?utf-8?B?b3VzbkR4ZldlZ1hvZVh2WmZVNTVIdyt0eUV1cEpSTTRzdHlkRzlxRUNHUmdP?=
 =?utf-8?B?cW95SVBsdXB3UUI5Q3NTYnUyM1dKVlJncXR5VGpGWFB3RTkrZ0lmeXlMN0p5?=
 =?utf-8?B?Z29FMUNYSjZTaDg1dVBMczBEVXFxZWtFQ0ZLRTRQQ3FScUFKMmdJd01SWDlL?=
 =?utf-8?B?c1VwcXFxcFk3RkVUM3c2NksyTzB4UlJuNnhSbkJmYWFDWEd2dGtXcDZpRmpE?=
 =?utf-8?B?dENDbXVCWWxJSmdWcyt2Um5sQ2loczJuRXUxRFpQWWIxRUZ2enBMeHo4cTdD?=
 =?utf-8?B?K0RBYkZaOWJHbEMzK292Z0JuQWlOb1B2bzJkMmcxbUJLQU9YV0MzbnBWQ3Rs?=
 =?utf-8?B?VUUrWVNNOG9OMTVoMGt4eUpCV3R2YTdZWGJHVUdyZi83Y3BQTWZKT2Jkejg2?=
 =?utf-8?B?aDRzUlJscjVWcm5GMWxmTGJUU0NNeW5ndVpPdHFCM21pbnIwMVZONVV2SjQ1?=
 =?utf-8?B?bjdNTy9KUXBrV3VyRG91b0w0NjZvTkp2Ky9CTVhtU1N1QmdLaitJZVlLV3lj?=
 =?utf-8?B?N3MzanhPYjlTdHFXTVUwazQ2ejlsK2pMZjVlNHR5dENJUzR6QVk0d2NJbC9S?=
 =?utf-8?B?TGJrQ0tpN25EY1EvOCtuRmZWOXF3US9Kd1FtaWV3M2RPZjU2NkFWT0k3L2FT?=
 =?utf-8?B?d2xsM1B3M3ovem02TGl0UnZ2cWwyVWNXRW1Yc1p4YXF5bHdiNEZtVkFaZHBv?=
 =?utf-8?B?MjRNOXlINitKK2gzRFF1SHhuT2l0cEt6cWtTTkFGb3dDUDA3ZWRFMFE3Rmll?=
 =?utf-8?B?WkJpNG9KQUM4b1hkakNTM0VEV1pIM0NOdG1MNjdneG4rcWZHcWtGQmhiSnQv?=
 =?utf-8?B?QXlnV2Y2R1cwTlZaSW9keHRyTlRhT3BQZjd6V3NnU2tXblhlVWZ2enhVcktQ?=
 =?utf-8?B?RU03R3h1L0Nib0w0VUtEZFBDRzc1NXgxZG9FQjM1Y1c5c1V0TGEvbDdqbENk?=
 =?utf-8?B?dk42SENFYkNobW81ZGkyeS9xMlQ0R2dBSWN2TTMyZ0w1QTN5YVhJbmsrY200?=
 =?utf-8?B?cTdWTG1YQVB1c2NJdEc4MDRmdFZmTGZoT2YzVFJBQ0tqUGI4K2NwNmVTcjIv?=
 =?utf-8?B?Q3VuaENJdzVrUGJ5VVRGbXNGZVhtbHNSY0JUaW4xSVNxZ3Ywd2s3TTdzbGpq?=
 =?utf-8?B?eEJLNk1nZ2s5Mi9VRlovSWNBc0xXWDQxelVuemZnRVc3TjNNUHBUQnE4dHRB?=
 =?utf-8?B?Q08rOFBvem1nWWR0dWw3MzRDekRDbENKcU9xR0RPZ0hpS1NqeG9jcGxmd3NI?=
 =?utf-8?B?dUYxZGpYWEF2WStzNnhPOHdhWk05czUvbzJhU1VTREkzRWY2SmI2dDJuSGtX?=
 =?utf-8?B?SkY4WE5LWlBSek40WnBWZ3ZqalpqU0svbDZib0hsTFFNcDRlaVl6SXk2Y0do?=
 =?utf-8?B?eUtGZTZJMk1Ta0ZVMjJ5eDFJa0ZiOWJpdkNrSCs3TkVTVXpFZGdCYW96VHJU?=
 =?utf-8?B?YVIrcFl5QzBqNHRYU09uWVlST3RqMXpYZGdKQi9CSk1weGZnU0Z2dU5UTWdy?=
 =?utf-8?Q?TCd9FS7R8sVry/w0aFp2M/w=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0377.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 947ebb42-219a-4330-6b0c-08da940badb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 15:38:30.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkIInkYFzzKB+0iWxKEftRPSFhPgdwWEYTvttKeGECEq16QD/JZmm7ewgHAJq+WTktpZyVf0izPuIo62ZDPdBS4vCSndQBX+jtjrOEw4Z+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0119
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E4D2DA6CBA47E34E8CA21EE511956F37@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA5LTEwIGF0IDEwOjM4ICswMjAwLCBOaWtsYXMgU8O2ZGVybHVuZCB3cm90
ZToKPiBBZGQgYSB3YXJuaW5nIGZvciBmaXhlcyB0YWdzIHRoYXQgZG9lcyBub3QgZmFsbCBpbiBs
aW5lIHdpdGggdGhlCj4gc3RhbmRhcmRzIHNwZWNpZmllZCBieSB0aGUgY29tbXVuaXR5Lgo+IAo+
IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBTw7ZkZXJsdW5kIDxuaWtsYXMuc29kZXJsdW5kQGNvcmln
aW5lLmNvbT4KPiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxzaW1vbi5ob3JtYW5AY29yaWdp
bmUuY29tPgo+IFJldmlld2VkLWJ5OiBMb3VpcyBQZWVucyA8bG91aXMucGVlbnNAY29yaWdpbmUu
Y29tPgoKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0
b3JhZGV4LmNvbT4KCj4gLS0tCj4gKiBDaGFuZ2VzIHNpbmNlIHY1Cj4gLSBBZGQgc3VwcG9ydCBm
b3IgLS1maXggb3B0aW9uIGZvciBjaGVja3BhdGNoLnBsLgo+IAo+ICogQ2hhbmdlcyBzaW5jZSB2
NAo+IC0gRXh0ZW5kIHRlc3QgdG8gY292ZXIgbGluZXMgd2l0aCB3aGl0ZXNwYWNlIGJlZm9yZSB0
aGUgZml4ZXM6IHRhZywKPiBlLmcuCj4gwqAgbWF0Y2ggY2hlY2sgb24gL15ccypmaXhlczo/L2ku
Cj4gCj4gKiBDaGFuZ2VzIHNpbmNlIHYzCj4gLSBBZGQgdGVzdCB0aGF0IHRpdGxlIGluIHRhZyBt
YXRjaCB0aXRsZSBvZiBjb21taXQgcmVmZXJlbmNlZCBieSBzaGExLgo+IAo+ICogQ2hhbmdlcyBz
aW5jZSB2Mgo+IC0gQ2hhbmdlIHRoZSBwYXR0ZXJuIHRvIG1hdGNoIG9uICdmaXhlczo/JyB0byBj
YXRjaCBtb3JlIG1hbGZvcm1lZAo+IMKgIHRhZ3MuCj4gCj4gKiBDaGFuZ2VzIHNpbmNlIHYxCj4g
LSBVcGRhdGUgdGhlIGRvY3VtZW50YXRpb24gd29yZGluZyBhbmQgYWRkIG1lbnRpb24gb25lIGNh
dXNlIG9mIHRoZQo+IMKgIG1lc3NhZ2UgY2FuIGJlIHRoYXQgZW1haWwgcHJvZ3JhbSBzcGxpdHMg
dGhlIHRhZyBvdmVyIG11bHRpcGxlCj4gbGluZXMuCj4gLS0tCj4gwqBEb2N1bWVudGF0aW9uL2Rl
di10b29scy9jaGVja3BhdGNoLnJzdCB8wqAgOCArKysrKwo+IMKgc2NyaXB0cy9jaGVja3BhdGNo
LnBswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQzCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiDCoDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQo+IAo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9jaGVja3BhdGNoLnJzdAo+IGIv
RG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMvY2hlY2twYXRjaC5yc3QKPiBpbmRleCBiNTI0NTJiYzI5
NjMuLjhjODQ1NmEzYmQxOCAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9j
aGVja3BhdGNoLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2NoZWNrcGF0Y2gu
cnN0Cj4gQEAgLTYxMiw2ICs2MTIsMTQgQEAgQ29tbWl0IG1lc3NhZ2UKPiDCoAo+IMKgwqDCoMKg
IFNlZToKPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1
Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2Rlc2NyaWJlLXlvdXItY2hhbmdlcwo+IMKgCj4gK8KgICoq
QkFEX0ZJWEVTX1RBRyoqCj4gK8KgwqDCoCBUaGUgRml4ZXM6IHRhZyBpcyBtYWxmb3JtZWQgb3Ig
ZG9lcyBub3QgZmFsbCBpbiBsaW5lIHdpdGggdGhlCj4gc3RhbmRhcmRzCj4gK8KgwqDCoCBzcGVj
aWZpZWQgYnkgdGhlIGNvbW11bml0eS4gVGhpcyBjYW4gb2NjdXIgaWYgdGhlIHRhZyBoYXZlIGJl
ZW4KPiBzcGxpdCBpbnRvCj4gK8KgwqDCoCBtdWx0aXBsZSBsaW5lcyAoZS5nLiwgd2hlbiBwYXN0
ZWQgaW4gZW1haWwgcHJvZ3JhbSB3aXRoIHdvcmQKPiB3cmFwcGluZwo+ICvCoMKgwqAgZW5hYmxl
ZCkuCj4gKwo+ICvCoMKgwqAgU2VlOgo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjZGVzY3JpYmUteW91ci1jaGFu
Z2VzCj4gKwo+IMKgCj4gwqBDb21wYXJpc29uIHN0eWxlCj4gwqAtLS0tLS0tLS0tLS0tLS0tCj4g
ZGlmZiAtLWdpdCBhL3NjcmlwdHMvY2hlY2twYXRjaC5wbCBiL3NjcmlwdHMvY2hlY2twYXRjaC5w
bAo+IGluZGV4IDc5ZTc1OWFhYzU0My4uNzdmNTc3NTM1ZmMzIDEwMDc1NQo+IC0tLSBhL3Njcmlw
dHMvY2hlY2twYXRjaC5wbAo+ICsrKyBiL3NjcmlwdHMvY2hlY2twYXRjaC5wbAo+IEBAIC0zMTQw
LDYgKzMxNDAsNDkgQEAgc3ViIHByb2Nlc3Mgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oH0KPiDCoAo+ICsjIENoZWNrIEZpeGVzOiBzdHlsZXMgaXMgY29ycmVjdAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoISRpbl9oZWFkZXJfbGluZXMgJiYgJGxpbmUgPX4gL15c
cypmaXhlczo/L2kpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG15ICRvcmlnX2NvbW1pdCA9ICIiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbXkgJGlkID0gIjAxMjM0NTY3ODlhYiI7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBteSAkdGl0bGUgPSAiY29tbWl0
IHRpdGxlIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG15ICR0YWdfY2FzZSA9IDE7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBteSAkdGFnX3NwYWNlID0gMTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG15ICRpZF9sZW5ndGggPSAxOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXkgJGlkX2Nhc2UgPSAxOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXkgJHRpdGxlX2hhc19x
dW90ZXMgPSAwOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmICgkbGluZSA9fiAvKFxzKmZpeGVzOj8pXHMrKFswLTlhLQo+IGZdezUsfSlccyso
JGJhbGFuY2VkX3BhcmVucykvaSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG15ICR0YWcgPSAkMTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAkb3Jp
Z19jb21taXQgPSAkMjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAkdGl0bGUgPSAkMzsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJHRhZ19jYXNl
ID0gMCBpZiAkdGFnIGVxICJGaXhlczoiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCR0YWdfc3BhY2UgPSAwIGlmICgkbGlu
ZSA9fiAvXmZpeGVzOj8KPiBbMC05YS1mXXs1LH0gKCRiYWxhbmNlZF9wYXJlbnMpL2kpOwo+ICsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAkaWRfbGVuZ3RoID0gMCBpZiAoJG9yaWdfY29tbWl0ID1+Cj4gL15bMC05YS1mXXsx
Mn0kL2kpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCRpZF9jYXNlID0gMCBpZiAoJG9yaWdfY29tbWl0ICF+IC9bQS0KPiBG
XS8pOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAjIEFsd2F5cyBzdHJpcCBsZWFkaW5nL3RyYWlsaW5nIHBhcmVucwo+
IHRoZW4gZG91YmxlIHF1b3RlcyBpZiBleGlzdGluZwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCR0aXRsZSA9IHN1YnN0cigk
dGl0bGUsIDEsIC0xKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoJHRpdGxlID1+IC9eIi4qIiQvKSB7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCR0aXRsZSA9IHN1YnN0cigkdGl0bGUsIDEsIC0KPiAxKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgJHRpdGxlX2hhc19xdW90ZXMgPSAxOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBteSAoJGNpZCwgJGN0aXRs
ZSkgPQo+IGdpdF9jb21taXRfaW5mbygkb3JpZ19jb21taXQsICRpZCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAkdGl0bGUp
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
ICgkY3RpdGxlIG5lICR0aXRsZSB8fCAkdGFnX2Nhc2UgfHwKPiAkdGFnX3NwYWNlIHx8Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJGlkX2xl
bmd0aCB8fCAkaWRfY2FzZSB8fAo+ICEkdGl0bGVfaGFzX3F1b3Rlcykgewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChX
QVJOKCJCQURfRklYRVNfVEFHIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUGxlYXNlIHVzZSBjb3JyZWN0
IEZpeGVzOiBzdHlsZQo+ICdGaXhlczogPDEyIGNoYXJzIG9mIHNoYTE+IChcIjx0aXRsZSBsaW5l
PlwiKScgLSBpZTogJ0ZpeGVzOiAkY2lkCj4gKFwiJGN0aXRsZVwiKSdcbiIgLiAkaGVyZWN1cnIp
ICYmCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICRmaXgpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJGZpeGVk
WyRmaXhsaW5lbnJdID0gIkZpeGVzOgo+ICRjaWQgKFwiJGN0aXRsZVwiKSI7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgIyBDaGVjayBlbWFpbCBzdWJqZWN0
IGZvciBjb21tb24gdG9vbHMgdGhhdCBkb24ndCBuZWVkIHRvIGJlCj4gbWVudGlvbmVkCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoJGluX2hlYWRlcl9saW5lcyAmJgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICRsaW5lID1+Cj4gL15TdWJqZWN0
Oi4qXGIoPzpjaGVja3BhdGNofHNwYXJzZXxzbWF0Y2gpXGJbXjpdL2kpIHsKCg==

