Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349471409F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 23:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjE1VwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 17:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1VwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 17:52:14 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62327B1;
        Sun, 28 May 2023 14:52:11 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 9810D5FD05;
        Mon, 29 May 2023 00:52:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685310728;
        bh=Nghv6m8D7/4zP2PXOsESsldyieGQgyXv09d5y46DBk8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=BKKa1QVQudsYb4AHa7wiar01zuXsdWCwJtipGAdaqqwHldenhGJdmZXjWDaASQy/s
         KJqjxsmW0Wv7GzOnffju2UnHjiWznfogJQRkf+EmSnmwrZCOHXzJDCHjHWjT0iHpsA
         i659nXdWC6QmX9RaT3znfu2wWtAZ6QmyM6sWPCk94yGVt/ZClp+vBlUY1LB9gfnhUI
         4KJ6ERzgDgy3FAbRRXdso3sJs7rQXgNVtestL+5OqvRApK/pcDEw5M4Eq84TcnOCVq
         bysdfdjhCgtCvxKIOT/pbK0XwcKylDSDNHOoAsQqxeMKZ/LG0k5yMU6Q+kSDT8WpLw
         d/+7L2/MyRwlg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 29 May 2023 00:52:05 +0300 (MSK)
From:   George Stark <GNStark@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
Thread-Topic: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
Thread-Index: AQHZkOUaOx1SJmc/HEOeHScMc8VAp69vmTiAgABuz4A=
Date:   Sun, 28 May 2023 21:52:05 +0000
Message-ID: <4d5a7691-68ac-6626-5502-383fad3a9436@sberdevices.ru>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
 <20230528161117.197f7e61@jic23-huawei>
In-Reply-To: <20230528161117.197f7e61@jic23-huawei>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.13]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A12E2CA0EA8F9449AF67FDB6431CE8D8@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/28 19:12:00 #21364717
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOC8yMyAxNzo1NSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gU3VuLCAyOCBN
YXkgMjAyMyAwMDo0ODo1NCArMDMwMA0KPiBHZW9yZ2UgU3RhcmsgPGduc3RhcmtAc2JlcmRldmlj
ZXMucnU+IHdyb3RlOg0KPg0KPj4gUGF0Y2ggYWRkcyB0d28gc3lzZnMgbm9kZXM6IGNoYW43X211
eCB0byBzZXQgbXV4IHN0YXRlDQo+PiBhbmQgY2hhbjdfbXV4X2F2YWlsYWJsZSB0byBzaG93IGF2
YWlsYWJsZSBtdXggc3RhdGVzLg0KPj4gTXV4IGNhbiBiZSB1c2VkIHRvIGRlYnVnIGFuZCBjYWxp
YnJhdGUgYWRjIGJ5DQo+PiBzd2l0Y2hpbmcgYW5kIG1lYXN1cmluZyB3ZWxsLWtub3duIGlucHV0
cyBsaWtlIEdORCwgVmRkIGV0Yy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBHZW9yZ2UgU3Rhcmsg
PEdOU3RhcmtAc2JlcmRldmljZXMucnU+DQo+IEEgZmV3IGtleSB0aGluZ3MgaGVyZS4NCj4gMSkg
QUJJIGRvY3MgbWlzc2luZyAoRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtaWlv
LSoNCj4gICAgIFdpdGhvdXQgdGhhdCBpdCdzIGhhcmQgdG8gcmV2aWV3IG5ldyBBQkkuMg0KPiAy
KSBXZSBhcmUgdmVyeSBjb25zZXJ2YXRpdmUgd2hlbiBpdCBjb21lcyB0byBhZG9wdGluZyBuZXcg
QUJJIGFzIHRoZQ0KPiAgICAgcmVhbGl0eSBpcyB0aGF0IHVzZXJzcGFjZSBoYXMgbm8gaWRlYSB3
aGF0IHRvIGRvIHdpdGggaXQuDQo+ICAgICBEZXNpZ25pbmcgaW50ZXJmYWNlcyB0aGF0IHdvcmsg
Zm9yIGEgd2lkZSByYW5nZSBvZiBkZXZpY2VzIGlzIGhhcmQNCj4gICAgIGJ1dCBuZWNlc3Nhcnkg
dG8gZW5hYmxlIGdlbmVyYWwgcHVycG9zZSBzb2Z0d2FyZS4NCj4NCj4gQmFzZWQgb24gdGhlIGxp
bWl0ZWQgZGVzY3JpcHRpb24gd2UgaGF2ZSBoZXJlLCBJJ20gbm90IHVuZGVyc3RhbmRpbmcgd2h5
DQo+IHlvdSBkb24ndCBqdXN0IGV4cHJlc3MgdGhpcyBhcyBhIHNldCBvZiBjaGFubmVscy4gT25l
IGNoYW5uZWwgcGVyIG11eA0KPiBzZXR0aW5nLCB3aXRoIHRoZSBpbl92b2x0YWdlWF9sYWJlbCBw
cm92aWRpbmcgdGhlIGluZm9ybWF0aW9uIG9uIHdoYXQgdGhlDQo+IGNoYW5uZWwgaXMgY29ubmVj
dGVkIHRvLg0KPg0KPiBUaGlzIGlzIGFuIGludGVyZXN0aW5nIGZhY2lsaXR5LCBzbyBnb29kIHRv
IGVuYWJsZSBmb3IgaGlnaCBwcmVjaXNpb24gY2FsaWJyYXRpb24NCj4gYnV0IHdlIHN0aWxsIHdh
bnQgdG8gbWFwIGl0IHRvIHN0YW5kYXJkcyBzaWduYWxzLiAgVXNlcnNwYWNlIGRvZXNuJ3QNCj4g
Y2FyZSB0aGF0IHRoZXNlIGFyZSBhbGwgYmVpbmcgbWVhc3VyZWQgdmlhIHRoZSBzYW1lIGlucHV0
IDcgLSB3aGljaA0KPiBpcyBpdHNlbGYgcHJvYmFibHkgYW4gaW5wdXQgdG8gYSBNVVguDQo+DQo+
IEpvbmF0aGFuDQoNCkhlbGxvIEpvbmF0aGFuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0K
WW91ciBpZGVhIG9mIGV4cG9zaW5nIHRoZSBtdXggc2V0dGluZyBhcyBpaW8gY2hhbm5lbHMgaXMg
dmVyeQ0KaW50ZXJlc3RpbmcgYW5kIGF0IGxlYXN0IHdvcnRoIHRyeWluZy4NClRoZSBzeXNmcyBh
cHByb2FjaCB3YXMgY2hvc2VuIGJlY2F1c2Ugb2YgdGhlIGNvZGUgY2hhbmdlcyBhcmUgc2ltcGxl
IGFuZA0KbmVhdCAoY29tcGFyZSB0byBjaGFubmVscyBhcHByb2FjaCkuDQpBbHNvIGNhbGlicmF0
aW9uIGJ5IHVzaW5nIHRob3NlIG11eCBpbnB1dHMgYXJlIGFscmVhZHkgc3VwcG9ydGVkIGluIHRo
ZQ0KZHJpdmVyIChwZXJmb3JtZWQgYXQgcHJvYmUgc3RhZ2UpIHNvIEkgZXhwZWN0IHZlcnkgc3Bl
Y2lhbCB1c2VjYXNlcyBmb3INCnRob3NlIG11eCBzZXR0aW5ncyBsaWtlIGRlYnVnIG9yIGRldmlj
ZSBwcm9kdWN0aW9uIHN0YWdlIHRlc3RzLiBJbiB0aG9zZQ0KdXNlc2Nhc2VzIGhhcmR3YXJlIHNw
ZWNpZmljIGtub3dsZWRnZSBpcyByZXF1aXJlZCBhbnl3YXkuDQoNCkJlc3QgcmVnYXJkcw0KR2Vv
cmdlDQoNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2lpby9hZGMvbWVzb25fc2FyYWRjLmMgfCA2NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2
NSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9tZXNv
bl9zYXJhZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9tZXNvbl9zYXJhZGMuYw0KPj4gaW5kZXggZTA1
ZTUxOTAwYzM1Li42OTU5YTAwNjQ1NTEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMv
bWVzb25fc2FyYWRjLmMNCj4+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tZXNvbl9zYXJhZGMuYw0K
Pj4gQEAgLTExLDYgKzExLDcgQEANCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+PiAg
ICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0K
Pj4gKyNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4+ICAgI2luY2x1ZGUgPGxp
bnV4L252bWVtLWNvbnN1bWVyLmg+DQo+PiBAQCAtMzIwLDYgKzMyMSw3IEBAIHN0cnVjdCBtZXNv
bl9zYXJfYWRjX3ByaXYgew0KPj4gICAJYm9vbAkJCQkJdGVtcGVyYXR1cmVfc2Vuc29yX2NhbGli
cmF0ZWQ7DQo+PiAgIAl1OAkJCQkJdGVtcGVyYXR1cmVfc2Vuc29yX2NvZWZmaWNpZW50Ow0KPj4g
ICAJdTE2CQkJCQl0ZW1wZXJhdHVyZV9zZW5zb3JfYWRjX3ZhbDsNCj4+ICsJdTgJCQkJCWNoYW43
X211eF9zZWw7DQo+PiAgIH07DQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHJlZ21h
cF9jb25maWcgbWVzb25fc2FyX2FkY19yZWdtYXBfY29uZmlnX2d4YmIgPSB7DQo+PiBAQCAtNDgz
LDYgKzQ4NSw3IEBAIHN0YXRpYyB2b2lkIG1lc29uX3Nhcl9hZGNfc2V0X2NoYW43X211eChzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4gICAJcmVnbWFwX3VwZGF0ZV9iaXRzKHByaXYtPnJl
Z21hcCwgTUVTT05fU0FSX0FEQ19SRUczLA0KPj4gICAJCQkgICBNRVNPTl9TQVJfQURDX1JFRzNf
Q1RSTF9DSEFON19NVVhfU0VMX01BU0ssIHJlZ3ZhbCk7DQo+PiAgIA0KPj4gKwlwcml2LT5jaGFu
N19tdXhfc2VsID0gc2VsOw0KPj4gICAJdXNsZWVwX3JhbmdlKDEwLCAyMCk7DQo+PiAgIH0NCj4+
ICAgDQo+PiBAQCAtMTEzMCw4ICsxMTMzLDcwIEBAIHN0YXRpYyBpbnQgbWVzb25fc2FyX2FkY19j
YWxpYihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPj4gICAJcmV0dXJuIHJldDsNCj4+ICAg
fQ0KPj4gICANCj4+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGNoYW43X3ZvbFtdID0gew0K
Pj4gKwkiZ25kIiwNCj4+ICsJInZkZC80IiwNCj4+ICsJInZkZC8yIiwNCj4+ICsJInZkZCozLzQi
LA0KPj4gKwkidmRkIiwNCj4+ICsJImNoN19pbnB1dCIsDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0
aWMgc3NpemVfdCBjaGFuN19tdXhfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLA0KPj4gKwkJCSAgICAgIGNoYXIgKmJ1ZikNCj4+ICt7DQo+PiAr
CXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBkZXZfdG9faWlvX2RldihkZXYpOw0KPj4gKwlz
dHJ1Y3QgbWVzb25fc2FyX2FkY19wcml2ICpwcml2ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4+
ICsJdW5zaWduZWQgaW50IGluZGV4ID0gcHJpdi0+Y2hhbjdfbXV4X3NlbDsNCj4+ICsNCj4+ICsJ
aWYgKGluZGV4ID49IEFSUkFZX1NJWkUoY2hhbjdfdm9sKSkNCj4+ICsJCWluZGV4ID0gQVJSQVlf
U0laRShjaGFuN192b2wpIC0gMTsNCj4+ICsNCj4+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAi
JXNcbiIsIGNoYW43X3ZvbFtpbmRleF0pOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgc3NpemVf
dCBjaGFuN19tdXhfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPj4gKwkJCSAgICAgICBzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4+ICsJCQkgICAgICAgY29uc3QgY2hhciAqYnVm
LCBzaXplX3QgY291bnQpDQo+PiArew0KPj4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0g
ZGV2X3RvX2lpb19kZXYoZGV2KTsNCj4+ICsJaW50IGk7DQo+PiArDQo+PiArCWkgPSBzeXNmc19t
YXRjaF9zdHJpbmcoY2hhbjdfdm9sLCBidWYpOw0KPj4gKwlpZiAoaSA8IDApDQo+PiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4+ICsJbWVzb25fc2FyX2FkY19zZXRfY2hhbjdfbXV4KGluZGlvX2Rldiwg
aSk7DQo+PiArCXJldHVybiBjb3VudDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIElJT19ERVZJ
Q0VfQVRUUl9SVyhjaGFuN19tdXgsIC0xKTsNCj4+ICsNCj4+ICtzdGF0aWMgc3NpemVfdCBjaGFu
N19tdXhfYXZhaWxhYmxlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0
dHJpYnV0ZSAqYXR0ciwNCj4+ICsJCQkgICAgICBjaGFyICpidWYpDQo+PiArew0KPj4gKwlpbnQg
aSwgbGVuID0gMDsNCj4+ICsNCj4+ICsJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoY2hhbjdf
dm9sKTsgaSsrKQ0KPj4gKwkJbGVuICs9IHN5c2ZzX2VtaXRfYXQoYnVmLCBsZW4sICIlcyAiLCBj
aGFuN192b2xbaV0pOw0KPj4gKw0KPj4gKwlyZXR1cm4gbGVuOw0KPj4gK30NCj4+ICsNCj4+ICtz
dGF0aWMgSUlPX0RFVklDRV9BVFRSX1JPKGNoYW43X211eF9hdmFpbGFibGUsIC0xKTsNCj4+ICsN
Cj4+ICtzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqbWVzb25fc2FyX2FkY19hdHRyc1tdID0gew0K
Pj4gKwkmaWlvX2Rldl9hdHRyX2NoYW43X211eF9hdmFpbGFibGUuZGV2X2F0dHIuYXR0ciwNCj4+
ICsJJmlpb19kZXZfYXR0cl9jaGFuN19tdXguZGV2X2F0dHIuYXR0ciwNCj4+ICsJTlVMTA0KPj4g
K307DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgbWVzb25f
c2FyX2FkY19hdHRyX2dyb3VwID0gew0KPj4gKwkuYXR0cnMgPSBtZXNvbl9zYXJfYWRjX2F0dHJz
LA0KPj4gK307DQo+PiArDQo+PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gbWVzb25f
c2FyX2FkY19paW9faW5mbyA9IHsNCj4+ICAgCS5yZWFkX3JhdyA9IG1lc29uX3Nhcl9hZGNfaWlv
X2luZm9fcmVhZF9yYXcsDQo+PiArCS5hdHRycyA9ICZtZXNvbl9zYXJfYWRjX2F0dHJfZ3JvdXAs
DQo+PiAgIH07DQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG1lc29uX3Nhcl9hZGNf
cGFyYW0gbWVzb25fc2FyX2FkY19tZXNvbjhfcGFyYW0gPSB7DQo+DQoNCg==
