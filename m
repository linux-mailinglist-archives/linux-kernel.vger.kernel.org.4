Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C95BFAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIUJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiIUJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:22:24 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A4CE038;
        Wed, 21 Sep 2022 02:22:09 -0700 (PDT)
Received: from zhuyinbo$loongson.cn ( [10.180.13.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 21 Sep 2022 17:22:02
 +0800 (GMT+08:00)
X-Originating-IP: [10.180.13.64]
Date:   Wed, 21 Sep 2022 17:22:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5pyx6ZO25rOi?= <zhuyinbo@loongson.cn>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Subject: Re: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
 <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: jZEH9WZvb3Rlcl90eHQ9Mzc0MDo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Ax1OG61ypjNV8fAA--.6365W
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/1tbiAQAQDGMprV0ZSgAAs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiS3J6eXN6dG9mIEtvemxv
d3NraSIgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAy
Mi0wOS0yMSAxNTowNTowMCAo5pif5pyf5LiJKQo+IOaUtuS7tuS6ujogIllpbmJvIFpodSIgPHpo
dXlpbmJvQGxvb25nc29uLmNuPiwgIlJhZmFlbCBKIC4gV3lzb2NraSIgPHJhZmFlbEBrZXJuZWwu
b3JnPiwgIkRhbmllbCBMZXpjYW5vIiA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4sICJBbWl0
IEt1Y2hlcmlhIiA8YW1pdGtAa2VybmVsLm9yZz4sICJaaGFuZyBSdWkiIDxydWkuemhhbmdAaW50
ZWwuY29tPiwgIlJvYiBIZXJyaW5nIiA8cm9iaCtkdEBrZXJuZWwub3JnPiwgIktyenlzenRvZiBL
b3psb3dza2kiIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+LCBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnCj4g5oqE6YCBOiB6aGFuZ2hvbmdjaGVuIDx6aGFuZ2hvbmdjaGVuQGxv
b25nc29uLmNuPgo+IOS4u+mimDogUmU6IFtQQVRDSCB2MiAyLzNdIGR0LWJpbmRpbmdzOiB0aGVy
bWFsOiBDb252ZXJ0IGxvb25nc29uMiB0byBqc29uLXNjaGVtYQo+IAo+IE9uIDIxLzA5LzIwMjIg
MDM6NTYsIFlpbmJvIFpodSB3cm90ZToKPiA+IENvbnZlcnQgdGhlIGxvb25nc29uMiB0aGVybWFs
IGJpbmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZwo+ID4ganNvbi1zY2hlbWEuCj4gCj4g
SW5jb3JyZWN0IHN1YmplY3QgYW5kIGluY29ycmVjdCBjb21taXQgbXNnLiBUaGVyZSBpcyBubyBj
b252ZXJzaW9uIGhlcmUuCk91ciBzb2MgYXJjaGl0ZWN0dXJlIGlzIHRoZSBsb29uZ3NvbjIgc2Vy
aWVzLCBzbyB3ZSB3aWxsIG1vZGlmeSBpdCBhY2NvcmRpbmdseS4KCj4gCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IFlpbmJvIFpodSA8Yz4KPiA+IC0tLQo+ID4gQ2hhbmdlIGluIHYyOgo+ID4gCQkx
LiBBZGQgZGVzY3JpcHRpb24gYW5kIHR5cGUgYWJvdXQgdGhlICJpZCIuCQo+ID4gCQkyLiBNYWtl
IHRoZSBmaWxlbmFtZSB3YXMgYmFzZWQgb24gY29tcGF0aWJsZS4KPiA+IAo+ID4gIC4uLi9iaW5k
aW5ncy90aGVybWFsL2xvb25nc29uMi10aGVybWFsLnlhbWwgICB8IDUyICsrKysrKysrKysrKysr
KysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9sb29u
Z3NvbjItdGhlcm1hbC55YW1sCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9sb29uZ3NvbjItdGhlcm1hbC55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvbG9vbmdzb24yLXRoZXJtYWwueWFt
bAo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjk5NGFl
M2E1NmFhCj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdGhlcm1hbC9sb29uZ3NvbjItdGhlcm1hbC55YW1sCj4gCj4gCj4gTm8gaW1w
cm92ZW1lbnRzIGhlcmUuIFlvdSBpZ25vcmUgbXkgY29tbWVudHMsIHNvIEkgYW0gZ29pbmcgdG8g
TkFLIGl0LgpJIGRvbid0IGdldCB5b3VyIHBvaW50LCB0aGF0IGR0cyBjb21wYXRpYmxlIGlzICJs
b29uZ3Nvbixsb29uZ3NvbjItdGhlcm1hbCIsIHNvIHRoaXMgZHJpdmVyIGZpbGUgbmFtZSBpcyBu
YW1lZApsb29uZ3NvbjItdGhlcm1hbCB0aGF0IGFjY29yZGluZyB3aGF0IHlvdSBzYWlkIGFib3V0
ICJGaWxlbmFtZSBiYXNlZCBvbiBjb21wYXRpYmxlLiIKSWYgd2hhdCBJIHVuZGVyc3RhbmQgaXMg
bm90IHdoYXQgeW91IGV4cGVjdCwgcGxlYXNlIHRlbGwgbWUgaG93IHRvIG1vZGlmeSBpdC4KPiAK
PiAKPiA+IEBAIC0wLDAgKzEsNTIgQEAKPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkKPiA+ICslWUFNTCAxLjIKPiA+ICstLS0KPiA+
ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3RoZXJtYWwvbG9vbmdzb24yLXRo
ZXJtYWwueWFtbCMKPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCMKPiA+ICsKPiA+ICt0aXRsZTogVGhlcm1hbCBzZW5zb3JzIG9uIGxvb25n
c29uMiBTb0NzCj4gPiArCj4gPiArbWFpbnRhaW5lcnM6Cj4gPiArICAtIHpoYW5naG9uZ2NoZW4g
PHpoYW5naG9uZ2NoZW5AbG9vbmdzb24uY24+Cj4gPiArICAtIFlpbmJvIFpodSA8emh1eWluYm9A
bG9vbmdzb24uY24+Cj4gPiArCj4gPiArcHJvcGVydGllczoKPiA+ICsgIGNvbXBhdGlibGU6Cj4g
PiArICAgIGNvbnN0OiBsb29uZ3Nvbixsb29uZ3NvbjItdGhlcm1hbAo+ID4gKwo+ID4gKyAgcmVn
Ogo+ID4gKyAgICBtYXhJdGVtczogMQo+ID4gKwo+ID4gKyAgaWQ6Cj4gPiArICAgICRyZWY6ICcv
L3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyJwo+IAo+IE5vIGltcHJvdmVt
ZW50cyBoZXJlLCBzbyBsZXQgbWUgYmUgc3BlY2lmaWMgLSB5b3UgbmVlZCB0byByZWFsbHkganVz
dGlmeQo+IHN1Y2ggcHJvcGVydHkgb3IgaXQgY2Fubm90IGdvIHRvIHNjaGVtYS4KVGhlIGxvb25n
c29uMl90aGVybWFsLmMgZHJpdmVyIG5lZWQgcGFyc2UgdGhpcyAiaWQiIHByb3BlcnR5Lgo+IAo+
ID4gKyAgICBkZXNjcmlwdGlvbjogfAo+ID4gKyAgICAgIFNwZWNpZnkgdGhlIHRoZXJtYWwgc2Vu
c29yIGlkLgo+ID4gKyAgICBtaW5pbXVtOiAwCj4gPiArICAgIG1heGltdW06IDMKPiA+ICsKPiA+
ICsgIGludGVycnVwdHM6Cj4gPiArICAgIG1heEl0ZW1zOiAxCj4gPiArCj4gPiArICAiI3RoZXJt
YWwtc2Vuc29yLWNlbGxzIjoKPiA+ICsgICAgY29uc3Q6IDEKPiA+ICsKPiA+ICtyZXF1aXJlZDoK
PiA+ICsgIC0gY29tcGF0aWJsZQo+ID4gKyAgLSByZWcKPiA+ICsgIC0gaWQKPiA+ICsgIC0gaW50
ZXJydXB0LXBhcmVudAo+IAo+IFdoeT8KVGhlIGludGVycnVwdHMgb2Ygb3VyIGR0cyBkbyBub3Qg
c3BlY2lmeSBhbiBpbnRlcnJ1cHQgcGFyZW50LAplZy4gaW50ZXJydXB0cyA9IDw3IElSUV9UWVBF
X0xFVkVMX0xPVz4Kc28gd2UgbmVlZCB0byBhZGQgYW4gaW50ZXJydXB0IHBhcmVudCBwcm9wZXJ0
eS4KPiAKPiA+ICsgIC0gaW50ZXJydXB0cwo+ID4gKyAgLSAnI3RoZXJtYWwtc2Vuc29yLWNlbGxz
Jwo+IAo+IFVzZSB0aGUgc2FtZSBzdHlsZSBvZiBxdW90ZTogJyBvciAiLgpva2F5LCBJIHdpbGwg
aGF2ZSBhIGNoYW5nZS4KPiAKPiA+ICsKPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UK
PiA+ICsKPiA+ICtleGFtcGxlczoKPiA+ICsgIC0gfAo+ID4gKyAgICB0aGVybWFsOiB0aGVybWFs
QDFmZTAxNTAwIHsKPiAKPiBIb3cgb3RoZXIgc2ltaWxhciBub2RlcyBhcmUgbmFtZWQgKGluIG90
aGVyIERUUyBmaWxlcyk/CkkgcmVmZXIgcW9yaXEgcGxhdGZvcm0sCiAgICB0bXVAZjAwMDAgewog
ICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLHFvcmlxLXRtdSI7CgogWW91IG1lYW4gdG8gbW9kaWZ5
IGl0IGxpa2UgdGhpcwotIHRoZXJtYWw6IHRoZXJtYWxAMWZlMDE1MDAgeworIHRoZXJtYWxAMWZl
MDE1MDAgewoKcmlnaHQgPwoKClRoYW5rcywKeWluYm8uCkJScy4KCj4gCj4gCj4gCj4gQmVzdCBy
ZWdhcmRzLAo+IEtyenlzenRvZgoNCg0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv
5Lit56eR55qE5ZWG5Lia56eY5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw
5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul
5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw
5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h
5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu
5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu244CCIA0KVGhpcyBlbWFpbCBhbmQg
aXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9v
bmdzb24gVGVjaG5vbG9neSAsIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24g
b3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBp
bmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5v
dCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9y
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkg
YW5kIGRlbGV0ZSBpdC4g
