Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684560080F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJQHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJQHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:49:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C71B9F2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:49:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-hNVG5PM6O2GdTIkRWreGEg-1; Mon, 17 Oct 2022 08:49:43 +0100
X-MC-Unique: hNVG5PM6O2GdTIkRWreGEg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Oct
 2022 08:49:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Mon, 17 Oct 2022 08:49:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'H. Peter Anvin'" <hpa@zytor.com>, 'Xin Li' <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Thread-Topic: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Thread-Index: AQHY30Gyx3nzbyqdTEiu3El5Q4Xlsa4N0NzAgADfHoCAA4gHQA==
Date:   Mon, 17 Oct 2022 07:49:41 +0000
Message-ID: <bdf3f750103f4b64a697191d1edb8ad0@AcuMS.aculab.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
 <20221013200134.1487-4-xin3.li@intel.com>
 <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com>
 <1FCB6543-A666-4423-986B-4CDA1B4DD016@zytor.com>
In-Reply-To: <1FCB6543-A666-4423-986B-4CDA1B4DD016@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMTUgT2N0b2JlciAyMDIyIDAzOjQxDQo+IA0K
PiBPbiBPY3RvYmVyIDE0LCAyMDIyIDU6Mjg6MjUgQU0gUERULCBEYXZpZCBMYWlnaHQgPERhdmlk
LkxhaWdodEBBQ1VMQUIuQ09NPiB3cm90ZToNCj4gPkZyb206IFhpbiBMaQ0KPiA+PiBTZW50OiAx
MyBPY3RvYmVyIDIwMjIgMjE6MDINCj4gPj4NCj4gPj4gRnJvbTogIkguIFBldGVyIEFudmluIChJ
bnRlbCkiIDxocGFAenl0b3IuY29tPg0KPiA+Pg0KPiA+PiBMZXQgZ2NjIGtub3cgdGhhdCBvbmx5
IHRoZSBsb3cgMTYgYml0cyBvZiBsb2FkX2dzX2luZGV4KCkgYXJndW1lbnQNCj4gPj4gYWN0dWFs
bHkgbWF0dGVyLiBJdCBtaWdodCBhbGxvdyBpdCB0byBjcmVhdGUgc2xpZ2h0bHkgYmV0dGVyDQo+
ID4+IGNvZGUuIEhvd2V2ZXIsIGRvIG5vdCBwcm9wYWdhdGUgdGhpcyBpbnRvIHRoZSBwcm90b3R5
cGVzIG9mIGZ1bmN0aW9ucw0KPiA+PiB0aGF0IGVuZCB1cCBiZWluZyBwYXJhdmlydHVhbGl6ZWQs
IHRvIGF2b2lkIHVubmVjZXNzYXJ5IGNoYW5nZXMuDQo+ID4NCj4gPlVzaW5nIHUxNiB3aWxsIGFs
bW9zdCBhbHdheXMgbWFrZSB0aGUgY29kZSB3b3JzZS4NCj4gPkF0IHNvbWUgcG9pbnQgdGhlIHZh
bHVlIGhhcyB0byBiZSBtYXNrZWQgYW5kL29yIGV4dGVuZGVkDQo+ID50byBlbnN1cmUgYW4gb3V0
IG9mIHJhbmdlIHZhbHVlIGRvZXNuJ3QgYXBwZWFyIGluDQo+ID5hIHJlZ2lzdGVyLg0KPiA+DQo+
ID4JRGF2aWQNCj4gDQo+IElzIHRoYXQgYSBnZW5lcmFsIHN0YXRlbWVudCBvciBhcmUgeW91IGFj
dHVhbGx5IGludm9raW5nIGl0IGluIHRoaXMgY2FzZT8NCj4gVGhpcyBpcyBhYm91dCBpdCBiZWlu
ZyBhIG5hcnJvd2luZyBpbnB1dCwgKnJlbW92aW5nKiBzdWNoIGNvbnN0cmFpbnRzLg0KDQpJdCBp
cyBhIGdlbmVyYWwgc3RhdGVtZW50Lg0KWW91IHN1Z2dlc3RlZCB5b3UgbWlnaHQgZ2V0IGJldHRl
ciBjb2RlLg0KSWYgZmFjdCB5b3UnbGwgcHJvYmFibHkgZ2V0IHdvcnNlIGNvZGUuDQpJdCBtaWdo
dCBub3QgbWF0dGVyIGhlcmUsIGJ1dCAuLi4NCg0KTW9zdCBtb2Rlcm4gY2FsbGluZyBjb252ZW50
aW9ucyB1c2UgY3B1IHJlZ2lzdGVyIHRvIHBhc3MgYXJndW1lbnRzDQphbmQgcmVzdWx0cy4NClNv
IHRoZSBjb21waWxlciBpcyByZXF1aXJlZCB0byBlbnN1cmUgdGhhdCB1MTYgdmFsdWVzIGFyZSBp
biByYW5nZQ0KaW4gZWl0aGVyIHRoZSBjYWxsZXIgb3IgY2FsbGVkIGNvZGUgKG9yIGJvdGgpLg0K
SnVzdCBiZWNhdXNlIHRoZSBkb21haW4gb2YgYSB2YWx1ZSBpcyBzbWFsbCBkb2Vzbid0IG1lYW4g
dGhhdA0KdGhlIGJlc3QgdHlwZSBpc24ndCAnaW50JyBvciAndW5zaWduZWQgaW50Jy4NCg0KQWRk
aXRpb25hbGx5IChleGNlcHQgb24geDg2KSBhbnkgYXJpdGhtZXRpYyBvbiBzdWItMzJiaXQgdmFs
dWVzDQpyZXF1aXJlcyBhZGRpdGlvbmFsIGluc3RydWN0aW9ucyB0byBtYXNrIHRoZSByZXN1bHQu
DQoNCkV2ZW4gb24geDg2LTY0IGlmIHlvdSBpbmRleCBhbiBhcnJheSB3aXRoIGFuICdpbnQnIHRo
ZSBjb21waWxlcg0KaGFzIHRvIGdlbmVyYXRlIGNvZGUgdG8gc2lnbiBleHRlbmQgdGhlIHZhbHVl
IHRvIDY0IGJpdHMuDQpZb3UgZ2V0IGJldHRlciBjb2RlIGZvciAnc2lnbmVkIGxvbmcnIG9yIHVu
c2lnbmVkIHR5cGVzLg0KVGhpcyBpcyBwcm9iYWJseSB0cnVlIGZvciBhbGwgNjRiaXQgYXJjaGl0
ZWN0dXJlcy4NCg0KU2luY2UgKG1vc3QpIGNwdSBoYXZlIGJvdGggc2lnbiBleHRlbmRpbmcgYW4g
emVybyBleHRlbmRpbmcNCmxvYWRzIGZyb20gbWVtb3J5LCBpdCBjYW4gbWFrZSBzZW5zZSB0byB1
c2UgdTggYW5kIHUxNiB0bw0KcmVkdWNlIHRoZSBzaXplIG9mIHN0cnVjdHVyZXMuDQpCdXQgZm9y
IGZ1bmN0aW9uIGFyZ3VtZW50cyBhbmQgZnVuY3Rpb24gbG9jYWxzIGl0IGFsbW9zdA0KYWx3YXlz
IG1ha2VzIHRoZSBjb2RlIHdvcnNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

