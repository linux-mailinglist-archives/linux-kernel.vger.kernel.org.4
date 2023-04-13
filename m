Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F26E1657
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDMVMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDMVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:12:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B893C0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:11:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-1-IpWHsB8NM7ugMmOTQXH9Pg-1; Thu, 13 Apr 2023 22:10:48 +0100
X-MC-Unique: IpWHsB8NM7ugMmOTQXH9Pg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 13 Apr
 2023 22:10:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 13 Apr 2023 22:10:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Atish Patra' <atishp@atishpatra.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/4] riscv: Allow userspace to directly access perf
 counters
Thread-Topic: [PATCH 0/4] riscv: Allow userspace to directly access perf
 counters
Thread-Index: AQHZbjzyrjlAD1jWcEaLGLNw35Pifq8pufOQ
Date:   Thu, 13 Apr 2023 21:10:46 +0000
Message-ID: <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
In-Reply-To: <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXRpc2ggUGF0cmENCj4gU2VudDogMTMgQXByaWwgMjAyMyAyMDoxOA0KPiANCj4gT24g
VGh1LCBBcHIgMTMsIDIwMjMgYXQgOTo0N+KAr1BNIEFsZXhhbmRyZSBHaGl0aSA8YWxleGdoaXRp
QHJpdm9zaW5jLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiByaXNjdiB1c2VkIHRvIGFsbG93IGRpcmVj
dCBhY2Nlc3MgdG8gY3ljbGUvdGltZS9pbnN0cmV0IGNvdW50ZXJzLA0KPiA+IGJ5cGFzc2luZyB0
aGUgcGVyZiBmcmFtZXdvcmssIHRoaXMgcGF0Y2hzZXQgaW50ZW5kcyB0byBhbGxvdyB0aGUgdXNl
ciB0bw0KPiA+IG1tYXAgYW55IGNvdW50ZXIgd2hlbiBhY2Nlc3NlZCB0aHJvdWdoIHBlcmYuIEJ1
dCB3ZSBjYW4ndCBicmVhayB0aGUNCj4gPiBleGlzdGluZyBiZWhhdmlvdXIgc28gd2UgaW50cm9k
dWNlIGEgc3lzY3RsIHBlcmZfdXNlcl9hY2Nlc3MgbGlrZSBhcm02NA0KPiA+IGRvZXMsIHdoaWNo
IGRlZmF1bHRzIHRvIHRoZSBsZWdhY3kgbW9kZSBkZXNjcmliZWQgYWJvdmUuDQo+ID4NCj4gDQo+
IEl0IHdvdWxkIGJlIGdvb2QgcHJvdmlkZSBhZGRpdGlvbmFsIGRpcmVjdGlvbiBmb3IgdXNlciBz
cGFjZSBwYWNrYWdlczoNCj4gDQo+IFRoZSBsZWdhY3kgYmVoYXZpb3IgaXMgc3VwcG9ydGVkIGZv
ciBub3cgaW4gb3JkZXIgdG8gYXZvaWQgYnJlYWtpbmcNCj4gZXhpc3Rpbmcgc29mdHdhcmUuDQo+
IEhvd2V2ZXIsIHJlYWRpbmcgY291bnRlcnMgZGlyZWN0bHkgd2l0aG91dCBwZXJmIGludGVyYWN0
aW9uIG1heQ0KPiBwcm92aWRlIGluY29ycmVjdCB2YWx1ZXMgd2hpY2gNCj4gdGhlIHVzZXJzcGFj
ZSBzb2Z0d2FyZSBtdXN0IGF2b2lkLiBXZSBhcmUgaG9waW5nIHRoYXQgdGhlIHVzZXIgc3BhY2UN
Cj4gcGFja2FnZXMgd2hpY2gNCj4gcmVhZCB0aGUgY3ljbGUvaW5zdHJldCBkaXJlY3RseSwgd2ls
bCBtb3ZlIHRvIHRoZSBwcm9wZXIgaW50ZXJmYWNlDQo+IGV2ZW50dWFsbHkgaWYgdGhleSBhY3R1
YWxseSBuZWVkIGl0Lg0KPiBNb3N0IG9mIHRoZSB1c2VycyBhcmUgc3VwcG9zZWQgdG8gcmVhZCAi
dGltZSIgaW5zdGVhZCBvZiAiY3ljbGUiIGlmDQo+IHRoZXkgaW50ZW5kIHRvIHJlYWQgdGltZXN0
YW1wcy4NCg0KSWYgeW91IGFyZSB0cnlpbmcgdG8gbWVhc3VyZSB0aGUgcGVyZm9ybWFuY2Ugb2Yg
c2hvcnQgY29kZQ0KZnJhZ21lbnRzIHRoZW4geW91IG5lZWQgcHJldHR5IG11Y2ggcmF3IGFjY2Vz
cyBkaXJlY3RseSB0bw0KdGhlIGN5Y2xlL2Nsb2NrIGNvdW50IHJlZ2lzdGVyLg0KDQpJJ3ZlIGRv
bmUgdGhpcyBvbiB4ODYgdG8gY29tcGFyZSB0aGUgYWN0dWFsIGN5Y2xlIHRpbWVzDQpvZiBkaWZm
ZXJlbnQgaW1wbGVtZW50YXRpb25zIG9mIHRoZSBJUCBjaGVja3N1bSBsb29wDQooYW5kIGNvbXBh
cmUgdGhlbSB0byB0aGUgdGhlb3JldGljYWwgbGltaXQpLg0KVGhlIHBlcmYgZnJhbWV3b3JrIGp1
c3QgYWRkZWQgZmFyIHRvbyBtdWNoIGxhdGVuY3ksDQpvbmx5IGRpcmVjdGx5IHJlYWRpbmcgdGhl
IGNwdSByZWdpc3RlcnMgZ2F2ZSBhbnl0aGluZw0KbGlrZSByZWxpYWJsZSAoYW5kIGNvbnNpc3Rl
bnQpIGFuc3dlcnMuDQoNCkNsZWFybHkgcHJvY2VzcyBzd2l0Y2hlcyAoZXNwZWNpYWxseSBjcHUg
bWlncmF0aW9ucykgY2F1c2UNCnByb2JsZW1zLCBidXQgdGhleSBhcmUgb2J2aW91c2x5IGludmFs
aWQgdmFsdWVzIGFuZCBjYW4NCmJlIGlnbm9yZWQuDQoNClNvIHdoaWxlIGEgbG90IG9mIHVzZXMg
bWF5IGJlICdoYXBweScgd2l0aCB0aGUgdmFsdWVzIHRoZQ0KcGVyZiBmcmFtZXdvcmsgZ2l2ZXMs
IHNvbWV0aW1lcyB5b3UgZG8gbmVlZCB0byBkaXJlY3RseQ0KcmVhZCB0aGUgcmVsZXZhbnQgcmVn
aXN0ZXJzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

