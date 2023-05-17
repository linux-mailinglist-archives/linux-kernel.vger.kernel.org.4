Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC8706697
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjEQL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEQL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:27:23 -0400
X-Greylist: delayed 2479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 04:27:17 PDT
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0CE30C8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:27:16 -0700 (PDT)
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id 34HAjrrH010386
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:45:53 +0800 (GMT-8)
        (envelope-from zhengyan@asrmicro.com)
Received: from exch02.asrmicro.com (exch02.asrmicro.com [10.1.24.122])
        by spam.asrmicro.com with ESMTPS id 34HAjJZO010357
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 17 May 2023 18:45:19 +0800 (GMT-8)
        (envelope-from zhengyan@asrmicro.com)
Received: from exch03.asrmicro.com (10.1.24.118) by exch02.asrmicro.com
 (10.1.24.122) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 17 May
 2023 18:45:22 +0800
Received: from exch03.asrmicro.com ([::1]) by exch03.asrmicro.com ([::1]) with
 mapi id 15.00.0847.030; Wed, 17 May 2023 18:45:22 +0800
From:   =?gb2312?B?WWFuIFpoZW5no6jRz9X+o6k=?= <zhengyan@asrmicro.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?R2FvIE1laXRhb6OouN/DtczOo6k=?= <meitaogao@asrmicro.com>,
        =?gb2312?B?WmhvdSBRaWFvKNbcx8gp?= <qiaozhou@asrmicro.com>,
        =?gb2312?B?WmhhbmcgWmhpemhvdSjVxdbO1t4p?= 
        <zhizhouzhang@asrmicro.com>
Subject: RE: [PATCH] irqchip/gic-v3: workaround for ASR8601 when reading
 mpidr
Thread-Topic: [PATCH] irqchip/gic-v3: workaround for ASR8601 when reading
 mpidr
Thread-Index: AQHZiJTvP0JzizWi8EWX3jYwRrRS6a9dnPCAgACenBA=
Date:   Wed, 17 May 2023 10:45:22 +0000
Message-ID: <9dcef1c9343041c49a92ec8cd40d6331@exch03.asrmicro.com>
References: <20230517075500.43516-1-zhengyan@asrmicro.com>
 <86ttwbl5nq.wl-maz@kernel.org>
In-Reply-To: <86ttwbl5nq.wl-maz@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.170.215]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: spam.asrmicro.com 34HAjrrH010386
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIFtt
YWlsdG86bWF6QGtlcm5lbC5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE3LCAyMDIzIDQ6
MzIgUE0NCj4gVG86IFlhbiBaaGVuZ6Oo0c/V/qOpIDx6aGVuZ3lhbkBhc3JtaWNyby5jb20+DQo+
IENjOiB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdh
byBNZWl0YW+jqLjfw7XMzqOpDQo+IDxtZWl0YW9nYW9AYXNybWljcm8uY29tPjsgWmhvdSBRaWFv
KNbcx8gpIDxxaWFvemhvdUBhc3JtaWNyby5jb20+Ow0KPiBaaGFuZyBaaGl6aG91KNXF1s7W3ikg
PHpoaXpob3V6aGFuZ0Bhc3JtaWNyby5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlycWNo
aXAvZ2ljLXYzOiB3b3JrYXJvdW5kIGZvciBBU1I4NjAxIHdoZW4gcmVhZGluZw0KPiBtcGlkcg0K
PiANCj4gT24gV2VkLCAxNyBNYXkgMjAyMyAwODo1NTowMCArMDEwMCwNCj4gemhlbmd5YW4gPHpo
ZW5neWFuQGFzcm1pY3JvLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZCB3b3Jr
YXJvdW5kIGZvciBBU1I4NjAxLCB3aGljaCB1c2VzIGFuIGFybXY4LjIgcHJvY2Vzc29yDQo+ID4g
d2l0aCBhIGdpYy01MDAuIEFSTXY4LjIgdXNlcyBNdWx0aXByb2Nlc3NvciBBZmZpbml0eSBSZWdp
c3RlciB0bw0KPiA+IGlkZW50aWZ5IHRoZSBsb2dpY2FsIGFkZHJlc3Mgb2YgdGhlIGNvcmUgYnkN
Cj4gPiB8IGNsdXN0ZXIgfCBjb3JlIHwgdGhyZWFkIHwuDQo+IA0KPiBOb3QgcXVpdGUuIFRoZSBB
Uk12OC4yIGFyY2hpdGVjdHVyZSBkb2Vzbid0IHNheSAqYW55KiBvZiB0aGF0LiBJdCBpcyBBUk0n
cw0KPiAqaW1wbGVtZW50YXRpb25zKiB0aGF0IGZvbGxvdyB0aGlzIHNjaGVtZS4NCj4gDQoNClJl
YWxseSB0aGFuayB5b3UgZm9yIHJhcGlkIHJlc3BvbnNlLCANClllcywgYXMgYXJtIGRvY3VtZW50
cyBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VlbnRhdGlvbi9rYTAwMjEwNy9sYXRlc3Qg
c2FpZA0KSXQgY29tZXMgZnJvbSBhcm12OC4yIGdldCAzIHR5cGVzIGZvciBhZmZpbml0eSAoYXJt
IHY4LjAgY3B1cyBvbmx5IGdldCAyIHR5cGVzKQ0KQW5kIGl0J3MgYW4gaW1wbGVtZW50YXRpb25z
IGlzc3VlLg0KDQo+ID4gSG93ZXZlciwgZ2ljLTUwMCBvbmx5IHN1cHBvcnRzIHRvcG9sb2dpZXMg
d2l0aCBhZmZpbml0eSBsZXZlbHMgbGVzcw0KPiA+IHRoYW4gMiBhcw0KPiA+IHwgY2x1c3RlciB8
IGNvcmV8Lg0KPiA+DQo+ID4gU28gaXQgbmVlZHMgdGhpcyBwYXRjaCB0byBzaGlmdCB0aGUgTVBJ
RFIgdmFsdWVzIHRvIGVuc3VyZSBwcm9wZXINCj4gPiBmdW5jdGlvbmFsaXR5DQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiB6aGVuZ3lhbiA8emhlbmd5YW5AYXNybWljcm8uY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5jIHwgMjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYz
LmMNCj4gPiBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMgaW5kZXggNmZjZWUyMjFmMjAx
Li40MzViOThhODY0MWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1naWMt
djMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMNCj4gPiBAQCAtMzks
NiArMzksNyBAQA0KPiA+DQo+ID4gICNkZWZpbmUgRkxBR1NfV09SS0FST1VORF9HSUNSX1dBS0VS
X01TTTg5OTYJKDFVTEwgPDwgMCkNCj4gPiAgI2RlZmluZSBGTEFHU19XT1JLQVJPVU5EX0NBVklV
TV9FUlJBVFVNXzM4NTM5CSgxVUxMIDw8IDEpDQo+ID4gKyNkZWZpbmUgRkxBR1NfV09SS0FST1VO
RF9NUElEUl9BU1I4NjAxCQkoMVVMTCA8PCAyKQ0KPiANCj4gV2hhdCBpcyBBU1I4NjAxPyBJcyBp
dCBhIHN5c3RlbT8gT3IgYW4gZXJyYXR1bSBudW1iZXI/IEZvciBpc3N1ZXMgdGhhdCBhcmUgdGhl
DQo+IHJlc3VsdCBvZiBhIEhXIGludGVncmF0aW9uIGlzc3VlLCBwbGVhc2UgcHJvdmlkZSBhbiBv
ZmZpY2lhbCBlcnJhdHVtIG51bWJlciwgYW5kDQo+IHVwZGF0ZSBEb2N1bWVudGF0aW9uL2FybTY0
L3NpbGljb24tZXJyYXRhLnJzdC4NCj4gDQoNCkFTUjg2MDEgaXMgb3VyIHNvYydzIG5hbWUsIGFu
ZCB5ZXMgaXShr3MgYSBraW5kIG9mIEhXIGludGVncmF0aW9uIGlzc3VlDQpCdXQgbWF5YmUgaXSh
r3Mgbm90IGFuIGVycmF0dW0gc2luY2Ugb3VyIEhXIGRlc2lnbiBpcyBsaWtlIHRoYXQsIGFsdGhv
dWdoDQpBcm0gZG9lc24ndCByZWNvbW1lbmQgdGhpcyB3YXkuDQpBbmQgSSB3b3VsZCBsaWtlIHRv
IGFkZCBtb3JlIGNvbW1lbnRzDQpVbmRlciB0aGUgbmV4dCBwYXJ0IGJlZm9yZSAqZGVzYwk9ICJH
SUN2MzogQVNSIDg2MDEgTVBJRFIgc2hpZnQiKg0KTWF5YmUgdGhpcyBpcyBhIGJldHRlciB3YXk/
IE9yIGFkZCBzb21ldGhpbmcgdW5kZXIgRG9jdW1lbnRhdGlvbqO/DQoNCj4gPg0KPiA+ICAjZGVm
aW5lIEdJQ19JUlFfVFlQRV9QQVJUSVRJT04JKEdJQ19JUlFfVFlQRV9MUEkgKyAxKQ0KPiA+DQo+
ID4gQEAgLTY1OSw2ICs2NjAsOSBAQCBzdGF0aWMgdTY0IGdpY19tcGlkcl90b19hZmZpbml0eSh1
bnNpZ25lZCBsb25nDQo+ID4gbXBpZHIpICB7DQo+ID4gIAl1NjQgYWZmOw0KPiA+DQo+ID4gKwlp
ZiAoZ2ljX2RhdGEuZmxhZ3MgJiBGTEFHU19XT1JLQVJPVU5EX01QSURSX0FTUjg2MDEpDQo+ID4g
KwkJbXBpZHIgPj49IDg7DQo+ID4gKw0KPiA+ICAJYWZmID0gKCh1NjQpTVBJRFJfQUZGSU5JVFlf
TEVWRUwobXBpZHIsIDMpIDw8IDMyIHwNCj4gPiAgCSAgICAgICBNUElEUl9BRkZJTklUWV9MRVZF
TChtcGlkciwgMikgPDwgMTYgfA0KPiA+ICAJICAgICAgIE1QSURSX0FGRklOSVRZX0xFVkVMKG1w
aWRyLCAxKSA8PCA4ICB8IEBAIC05NzAsNiArOTc0LDkNCj4gQEANCj4gPiBzdGF0aWMgaW50IF9f
Z2ljX3BvcHVsYXRlX3JkaXN0KHN0cnVjdCByZWRpc3RfcmVnaW9uICpyZWdpb24sIHZvaWQgX19p
b21lbQ0KPiAqcHRyKQ0KPiA+ICAJICogQ29udmVydCBhZmZpbml0eSB0byBhIDMyYml0IHZhbHVl
IHRoYXQgY2FuIGJlIG1hdGNoZWQgdG8NCj4gPiAgCSAqIEdJQ1JfVFlQRVIgYml0cyBbNjM6MzJd
Lg0KPiA+ICAJICovDQo+ID4gKwlpZiAoZ2ljX2RhdGEuZmxhZ3MgJiBGTEFHU19XT1JLQVJPVU5E
X01QSURSX0FTUjg2MDEpDQo+ID4gKwkJbXBpZHIgPj49IDg7DQo+ID4gKw0KPiA+ICAJYWZmID0g
KE1QSURSX0FGRklOSVRZX0xFVkVMKG1waWRyLCAzKSA8PCAyNCB8DQo+ID4gIAkgICAgICAgTVBJ
RFJfQUZGSU5JVFlfTEVWRUwobXBpZHIsIDIpIDw8IDE2IHwNCj4gPiAgCSAgICAgICBNUElEUl9B
RkZJTklUWV9MRVZFTChtcGlkciwgMSkgPDwgOCB8IEBAIC0xMjY1LDYgKzEyNzIsOA0KPiBAQA0K
PiA+IHN0YXRpYyB1MTYgZ2ljX2NvbXB1dGVfdGFyZ2V0X2xpc3QoaW50ICpiYXNlX2NwdSwgY29u
c3Qgc3RydWN0IGNwdW1hc2sNCj4gKm1hc2ssDQo+ID4gIAl1bnNpZ25lZCBsb25nIG1waWRyID0g
Y3B1X2xvZ2ljYWxfbWFwKGNwdSk7DQo+ID4gIAl1MTYgdGxpc3QgPSAwOw0KPiA+DQo+ID4gKwlp
ZiAoZ2ljX2RhdGEuZmxhZ3MgJiBGTEFHU19XT1JLQVJPVU5EX01QSURSX0FTUjg2MDEpDQo+ID4g
KwkJbXBpZHIgPj49IDg7DQo+ID4gIAl3aGlsZSAoY3B1IDwgbnJfY3B1X2lkcykgew0KPiA+ICAJ
CXRsaXN0IHw9IDEgPDwgKG1waWRyICYgMHhmKTsNCj4gPg0KPiA+IEBAIC0xMjc0LDcgKzEyODMs
OCBAQCBzdGF0aWMgdTE2IGdpY19jb21wdXRlX3RhcmdldF9saXN0KGludCAqYmFzZV9jcHUsDQo+
IGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrLA0KPiA+ICAJCWNwdSA9IG5leHRfY3B1Ow0KPiA+
DQo+ID4gIAkJbXBpZHIgPSBjcHVfbG9naWNhbF9tYXAoY3B1KTsNCj4gPiAtDQo+ID4gKwkJaWYg
KGdpY19kYXRhLmZsYWdzICYgRkxBR1NfV09SS0FST1VORF9NUElEUl9BU1I4NjAxKQ0KPiA+ICsJ
CQltcGlkciA+Pj0gODsNCj4gPiAgCQlpZiAoY2x1c3Rlcl9pZCAhPSBNUElEUl9UT19TR0lfQ0xV
U1RFUl9JRChtcGlkcikpIHsNCj4gPiAgCQkJY3B1LS07DQo+ID4gIAkJCWdvdG8gb3V0Ow0KPiA+
IEBAIC0xMzIxLDYgKzEzMzEsOCBAQCBzdGF0aWMgdm9pZCBnaWNfaXBpX3NlbmRfbWFzayhzdHJ1
Y3QgaXJxX2RhdGEgKmQsDQo+IGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrKQ0KPiA+ICAJCXU2
NCBjbHVzdGVyX2lkID0gTVBJRFJfVE9fU0dJX0NMVVNURVJfSUQoY3B1X2xvZ2ljYWxfbWFwKGNw
dSkpOw0KPiA+ICAJCXUxNiB0bGlzdDsNCj4gPg0KPiA+ICsJCWlmIChnaWNfZGF0YS5mbGFncyAm
IEZMQUdTX1dPUktBUk9VTkRfTVBJRFJfQVNSODYwMSkNCj4gPiArCQkJY2x1c3Rlcl9pZCA9DQo+
IE1QSURSX1RPX1NHSV9DTFVTVEVSX0lEKGNwdV9sb2dpY2FsX21hcChjcHUpID4+IDgpOw0KPiAN
Cj4gWW91J3ZlIHdyaXR0ZW4gdGhlIHNhbWUgY2hlY2sgNSB0aW1lcy4gTWF5YmUgeW91IGNvdWxk
IHN0YXJ0IGJ5IHJlZmFjdG9yaW5nDQo+IHRoYXQgY29kZSBzbyB0aGF0IHRoZSBoYWNrIGNhbiBi
ZSBpbiBhIHNpbmdsZSBwbGFjZT8NCj4gDQoNCk9rYXksIEknbGwgdHJ5IHRvIHJlZmFjdG9yIGl0
DQoNCj4gPiAgCQl0bGlzdCA9IGdpY19jb21wdXRlX3RhcmdldF9saXN0KCZjcHUsIG1hc2ssIGNs
dXN0ZXJfaWQpOw0KPiA+ICAJCWdpY19zZW5kX3NnaShjbHVzdGVyX2lkLCB0bGlzdCwgZC0+aHdp
cnEpOw0KPiA+ICAJfQ0KPiA+IEBAIC0xNzI5LDYgKzE3NDEsMTUgQEAgc3RhdGljIGJvb2wgZ2lj
X2VuYWJsZV9xdWlya19jYXZpdW1fMzg1Mzkodm9pZA0KPiAqZGF0YSkNCj4gPiAgCXJldHVybiB0
cnVlOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgZ2ljX2VuYWJsZV9xdWlya19hc3I4
NjAxKHZvaWQgKmRhdGEpIHsNCj4gPiArCXN0cnVjdCBnaWNfY2hpcF9kYXRhICpkID0gZGF0YTsN
Cj4gPiArDQo+ID4gKwlkLT5mbGFncyB8PSBGTEFHU19XT1JLQVJPVU5EX01QSURSX0FTUjg2MDE7
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBi
b29sIGdpY19lbmFibGVfcXVpcmtfaGlwMDZfMDcodm9pZCAqZGF0YSkgIHsNCj4gPiAgCXN0cnVj
dCBnaWNfY2hpcF9kYXRhICpkID0gZGF0YTsNCj4gPiBAQCAtMTgyMyw2ICsxODQ0LDExIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZ2ljX3F1aXJrIGdpY19xdWlya3NbXSA9IHsNCj4gPiAgCQkubWFz
awk9IDB4ZmZmZmZmZmYsDQo+ID4gIAkJLmluaXQJPSBnaWNfZW5hYmxlX3F1aXJrX252aWRpYV90
MjQxLA0KPiA+ICAJfSwNCj4gPiArCXsNCj4gPiArCQkuZGVzYwk9ICJHSUN2MzogQVNSIDg2MDEg
TVBJRFIgU0hJRlQiLA0KPiANCj4gcy9TSElGVC9zaGlmdC8NCj4gDQoNCk9rYXkNCj4gPiArCQku
Y29tcGF0aWJsZSA9ICJhc3IsYXNyODYwMS1naWMtdjMiLA0KPiANCj4gU28gQVNSODYwMSAqaXMq
IGEgc3lzdGVtLi4uIElzIGl0IERUIG9ubHk/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJTS4NCj4g
DQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5vcm0sIHByb2dyZXNzIGlzIG5v
dCBwb3NzaWJsZS4NCg0KWWVzLCBhc3I4NjAxIGlzIG91ciBzb2MsIGFuZCB3ZSB3YW50IHRvIHVz
ZSBjb21wYXRpYmxlIG5vZGUgaW4gZGV2aWNlcy10cmVlIHRvIGNvbnRyb2wgaXQsDQpBcyBJIG1l
bnRpb25lZCBhdCBwcmV2aW91cyBwYXJ0LCBpdCBtaWdodCB3b3JrcyB3ZWxsIHVuZGVyDQphcm12
OC4yKDMgdHlwZXMgb2YgYWZmaW5pdHkpIHdpdGggZ2ljNTAwLCBidXQgdGhlc2UgY29kZSBnZXQg
c3Ryb25nbHkgb3JkZXIgd2l0aCBIVyBpbnRlZ3JhdGlvbg0KDQpUaGFua3MgYWdhaW4sDQoNCg0K
