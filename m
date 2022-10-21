Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAB607BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJUQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJUQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:10:18 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55675165CA6;
        Fri, 21 Oct 2022 09:10:13 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 93FD04633A7;
        Fri, 21 Oct 2022 18:10:11 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7C3504631AE;
        Fri, 21 Oct 2022 18:10:11 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (unknown [10.149.2.42])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri, 21 Oct 2022 18:10:11 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 21 Oct
 2022 18:10:10 +0200
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Fri, 21 Oct 2022 18:10:08 +0200
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>
CC:     "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: RE: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Thread-Topic: [PATCH V2 0/2] mmc: block: Support Host to control FUA
Thread-Index: AQHY5R8I87uqfAJat0yZdVamAN6Uba4ZAlSQ
Date:   Fri, 21 Oct 2022 16:10:07 +0000
Message-ID: <e7858446b9604b59b8270f181a1410ef@hyperstone.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
In-Reply-To: <20221021073025.18831-1-wenchao.chen666@gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.76]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27216.000
X-TMASE-Result: 10--10.591400-10.000000
X-TMASE-MatchedRID: Nail4dlEBNHUL3YCMmnG4vHkpkyUphL9ueYYfrL8B1Ln3ZLCt3rRSSsJ
        qmSIRx2Q7XjA6blEVJXAzwkq/B1Z+vn/om5XE6y/kCThXPqsqiufmd9HsjZ0UyIIO0VwKeOL2d8
        mtRIRsUMJmCLdmoamzw7Nx1vGlbMkP06ke90qDvM8o3fwIs8rQfG6GRFYrbYYnKRrn2xogKgeGj
        HdJVjPPmGCtTPv37bCIH34uYa62rLX54Vmcx7RYNEJQUcCarUjEDnDEqNPdurJVWdgKXnqZBst5
        gVpV7Hm4QRvjxz49tFvqzs520ADYJUt7uIUdjPePPov5T+l6PH4h+uI7dxXxMfASe7knCttN4J9
        ozUlDtYqOEcWPDbR6ZGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPIfiAqrjYtFiS0hbR
        lFnj1McGkBnzIck0G/J45eTpJn0vT8VYasfn3/H7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: d4159ce0-62e5-4921-8414-8c75e7c0fa47-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGVzZSBwYXRjaGVzWzFdIHN1cHBvcnRzIHRoZSBob3N0IHRvIHR1cm4gb2ZmIEZVQS4NCj4g
DQo+IEFib3V0IEZVQSwgcm91Z2hseSBkZWFsIHdpdGggdGhlIGZvbGxvd2luZyB0d28gcGFydHM6
DQo+IDEpIEZVQShGb3JjZWQgVW5pdCBBY2Nlc3MpOg0KPiAtIFRoZSBSRVFfRlVBIGZsYWcgY2Fu
IGJlIE9SIGVkIGludG8gdGhlIHIvdyBmbGFncyBvZiBhIGJpbyBzdWJtaXR0ZWQgZnJvbSB0aGUN
Cj4gICBmaWxlc3lzdGVtIGFuZCB3aWxsIG1ha2Ugc3VyZSB0aGF0IEkvTyBjb21wbGV0aW9uIGZv
ciB0aGlzIHJlcXVlc3QgaXMgb25seQ0KPiAgIHNpZ25hbGVkIGFmdGVyIHRoZSBkYXRhIGhhcyBi
ZWVuIGNvbW1pdHRlZCB0byBub24tdm9sYXRpbGUgc3RvcmFnZS4NCj4gDQo+IDIpIEluIGVtbWMs
IEZVQSBpcyByZXByZXNlbnRlZCBhcyBSZWxpYWJsZSB3cml0ZS4gY29kZSBzaG93IGFzIGJlbG93
Og0KPiBzdGF0aWMgdm9pZCBtbWNfYmxrX2RhdGFfcHJlcChzdHJ1Y3QgbW1jX3F1ZXVlICptcSwg
c3RydWN0IG1tY19xdWV1ZV9yZXEgKm1xcnEsDQo+IAkJaW50IHJlY292ZXJ5X21vZGUsIGJvb2wg
KmRvX3JlbF93cl9wLCBib29sICpkb19kYXRhX3RhZ19wKSB7DQo+IAkuLi4NCj4gCS8qDQo+IAkg
KiBSZWxpYWJsZSB3cml0ZXMgYXJlIHVzZWQgdG8gaW1wbGVtZW50IEZvcmNlZCBVbml0IEFjY2Vz
cyBhbmQNCj4gCSAqIGFyZSBzdXBwb3J0ZWQgb25seSBvbiBNTUNzLg0KPiAJICovDQo+IAlkb19y
ZWxfd3IgPSAocmVxLT5jbWRfZmxhZ3MgJiBSRVFfRlVBKSAmJg0KPiAJCQlycV9kYXRhX2Rpcihy
ZXEpID09IFdSSVRFICYmDQo+IAkJCShtZC0+ZmxhZ3MgJiBNTUNfQkxLX1JFTF9XUik7DQo+IAku
Li4NCj4gfQ0KDQpTbyByZWxpYWJsZSB3cml0ZXMgYXJlIG9ubHkgaXNzZWQgd2hlbiBGVUEgZmxh
ZyBpcyBzZXQsIHNvIGFzIGl0IHNob3VsZCBiZT8NCg0KPiANCj4gUGF0Y2ggc3RydWN0dXJlDQo+
ID09PT09PT09PT09PT09PQ0KPiBwYXRjaCMxOiAgZm9yIGJsb2NrDQo+IHBhdGNoIzI6ICBmb3Ig
c2RoY2ktc3ByZA0KPiANCj4gVGVzdHMNCj4gPT09PT0NCj4gUmFuICdBbmRyb0JlbmNoJyB0byBl
dmFsdWF0ZSB0aGUgcGVyZm9ybWFuY2U6DQo+IDEuIGZ1YV9kaXNhYmxlID0gMQ0KPiAvc3lzL2Js
b2NrL21tY2JsazAvcXVldWUgIyBjYXQgZnVhIDANCj4gSSB0ZXN0ZWQgNSB0aW1lcyBmb3IgZWFj
aCBjYXNlIGFuZCBvdXRwdXQgYSBhdmVyYWdlIHNwZWVkLg0KPiANCj4gMSkgU2VxdWVudGlhbCBy
ZWFkOg0KPiBTcGVlZDogMjY2LjhNaUIvcywgMjY1LjFNaUIvcywgMjYyLjlNaUIvcywgMjY4LjdN
aUIvcywgMjY1LjJNaUIvcyBBdmVyYWdlIHNwZWVkOiAyNjUuNzRNaUIvcw0KPiANCj4gMikgUmFu
ZG9tIHJlYWQ6DQo+IFNwZWVkOiA5OC43NU1pQi9zLCA5OC43TWlCL3MsIDk4LjVNaUIvcywgOTku
NE1pQi9zLCA5OC43TWlCL3MgQXZlcmFnZSBzcGVlZDogOTguODFNaUIvcw0KPiANCj4gMykgU2Vx
dWVudGlhbCB3cml0ZToNCj4gU3BlZWQ6IDE5OS45NE1pQi9zLCAxOTkuMU1pQi9zLCAyMDUuNU1p
Qi9zLCAyMDYuNU1pQi9zLCAxOTEuNU1pQi9zIEF2ZXJhZ2Ugc3BlZWQ6IDIwMC41TWlCL3MNCj4g
DQo+IDQpIFJhbmRvbSB3cml0ZToNCj4gU3BlZWQ6IDY4LjZNaUIvcywgNzEuOE1pQi9zLCA3Ny4x
TWlCL3MsIDY0LjhNaUIvcywgNjkuM01pQi9zIEF2ZXJhZ2Ugc3BlZWQ6IDcwLjMyTWlCL3MNCj4g
DQoNClVubGVzcyB0aGVyZSBpcyBzb21ldGhpbmcgc3BlY2lhbCAvIHdyb25nIHdpdGggc2RoY2kt
c3ByZCAodW5saWtlbHk/IEl0cyBqdXN0IGEgZmxhZykgb3IgeW91ciBlTU1DIChtYXliZSBtb3Jl
IGxpa2VseT8pDQp0aGVuIElkIGV4cGVjdCB0aGlzIG9yIHNpbWlsYXIgcGVyZm9ybWFuY2UgZGVn
cmFkYXRpb24gZm9yIGFueSBob3N0IGNvbnRyb2xsZXIgYW5kIGVNTUMuDQpJIGNhbiByZWRvIHNv
bWUgbWVhc3VyZW1lbnQgaWYgeW91IHByb3ZpZGUgeW91ciB3b3JrbG9hZC4NCkJ1dCBJJ2Qgc2F5
IGlmIHlvdSBkb27igJl0IHdhbnQgdG8gcGF5IHRoZSBwcmljZSBvZiByZWxpYWJsZSB3cml0ZSB0
aGVuIG1ha2Ugc3VyZSB0byBub3QgaXNzdWUgdGhlbSwgYnkgbm90IGlzc3VpbmcNCkZVQT8NCk1h
eWJlIEknbSBtaXN1bmRlcnN0YW5kaW5nLCBidXQgd2h5IHdvdWxkIHRoZSBob3N0IGNvbnRyb2xs
ZXIgZHJpdmVyIGNvbnRyb2wgRlVBPw0KDQo+IDIuIGZ1YV9kaXNhYmxlID0gMCAoZGVmYXVsdCAw
KQ0KPiAvc3lzL2Jsb2NrL21tY2JsazAvcXVldWUgIyBjYXQgZnVhIDENCj4gSSB0ZXN0ZWQgNSB0
aW1lcyBmb3IgZWFjaCBjYXNlIGFuZCBvdXRwdXQgYSBhdmVyYWdlIHNwZWVkLg0KPiAJDQo+IDEp
IFNlcXVlbnRpYWwgcmVhZDoNCj4gU3BlZWQ6IDI1OS4zTWlCL3MsIDI1OC44TWlCL3MsIDI1OC4y
TWlCL3MsIDI1OS41TWlCL3MsIDI1My41TWlCL3MgQXZlcmFnZSBzcGVlZDogMjU3Ljg2TWlCL3MN
Cj4gCQ0KPiAyKSBSYW5kb20gcmVhZDoNCj4gU3BlZWQ6IDk4LjlNaUIvcywgMTAxTWlCL3MsIDEw
MU1pQi9zLCA5OU1pQi9zLCAxMDEuMU1pQi9zIEF2ZXJhZ2Ugc3BlZWQ6IDEwMC4yTWlCL3MNCj4g
CQ0KPiAzKSBTZXF1ZW50aWFsIHdyaXRlOg0KPiBTcGVlZDogMTUzLjdNaUIvcywgMTQ2LjJNaUIv
cywgMTUxLjJNaUIvcywgMTQ4LjhNaUIvcywgMTQ3LjVNaUIvcyBBdmVyYWdlIHNwZWVkOiAxNDku
NDhNaUIvcw0KPiAJDQo+IDQpIFJhbmRvbSB3cml0ZToNCj4gU3BlZWQ6IDEyLjlNaUIvcywgMTIu
M01pQi9zLCAxMi42TWlCL3MsIDEyLjhNaUIvcywgMTIuOE1pQi9zIEF2ZXJhZ2Ugc3BlZWQ6IDEy
LjY4TWlCL3MNCj4gCQ0KPiBBY2NvcmRpbmcgdG8gdGhlIGFib3ZlIGRhdGEsIGRpc2FibGUgRlVB
IChmdWFfZGlzYWJsZSA9IDEpIGltcHJvdmVzIHRoZQ0KPiBwZXJmb3JtYW5jZToNCj4gMSlTZXF1
ZW50aWFsIHJlYWQgaW1wcm92ZWQgYnkgMyUuDQo+IDIpUmFuZG9tIHJlYWQgd2VyZSBkb3duIDEl
Lg0KPiAzKVNlcXVlbnRpYWwgd3JpdGUgaW1wcm92ZWQgYnkgMzQlLg0KPiA0KVJhbmRvbSB3cml0
ZSBpbXByb3ZlZCBieSA0NTQlLg0KPiBUaGVyZWZvcmUsIGl0IGlzIHJlY29tbWVuZGVkIHRvIHN1
cHBvcnQgdGhlIGhvc3QgdG8gY29udHJvbCBGVUEuDQo+IAkNCj4NCg0KSHlwZXJzdG9uZSBHbWJI
IHwgUmVpY2hlbmF1c3RyLiAzOWEgIHwgNzg0NjcgS29uc3RhbnoKTWFuYWdpbmcgRGlyZWN0b3I6
IERyLiBKYW4gUGV0ZXIgQmVybnMuCkNvbW1lcmNpYWwgcmVnaXN0ZXIgb2YgbG9jYWwgY291cnRz
OiBGcmVpYnVyZyBIUkIzODE3ODI=

