Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1EB5EDE25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiI1Nva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiI1Nv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:51:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF64847BAC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:51:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-140-gzWXAywHMV-HSW-hW7fmsw-1; Wed, 28 Sep 2022 14:51:15 +0100
X-MC-Unique: gzWXAywHMV-HSW-hW7fmsw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 28 Sep
 2022 14:51:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 28 Sep 2022 14:51:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qais Yousef' <qais.yousef@arm.com>,
        John Stultz <jstultz@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>,
        "John Kacur" <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        "Abhijeet Dharmapurikar" <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: RE: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
Thread-Topic: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
Thread-Index: AQHY0zpmJr2Dk0yW7UGHJ33kyoWYZa300JwA
Date:   Wed, 28 Sep 2022 13:51:11 +0000
Message-ID: <529cd76702b44678a4d4abe539105942@AcuMS.aculab.com>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220928130043.d6ijyxbq43tfvqg7@wubuntu>
In-Reply-To: <20220928130043.d6ijyxbq43tfvqg7@wubuntu>
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

RnJvbTogUWFpcyBZb3VzZWYNCj4gU2VudDogMjggU2VwdGVtYmVyIDIwMjIgMTQ6MDENCj4gDQo+
IEhpIEpvaG4NCj4gDQo+IE9uIDA5LzIxLzIyIDAxOjI1LCBKb2huIFN0dWx0eiB3cm90ZToNCj4g
PiBIZXkgYWxsLA0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgaXMgYSBzZXQgb2YgcGF0Y2hlcyB0aGF0
IG9wdGltaXplIHNjaGVkdWxlciBkZWNpc2lvbnMgYXJvdW5kDQo+ID4gcmVhbHRpbWUgdGFza3Mg
YW5kIHNvZnRpcnFzLiAgVGhpcyBzZXJpZXMgaXMgYSByZWJhc2VkIGFuZCByZXdvcmtlZCBzZXQN
Cj4gPiBvZiBjaGFuZ2VzIHRoYXQgaGF2ZSBiZWVuIHNoaXBwaW5nIG9uIEFuZHJvaWQgZGV2aWNl
cyBmb3IgYSBudW1iZXIgb2YNCj4gPiB5ZWFycywgb3JpZ2luYWxseSBjcmVhdGVkIHRvIHJlc29s
dmUgYXVkaW8gZ2xpdGNoZXMgc2VlbiBvbiBkZXZpY2VzDQo+ID4gY2F1c2VkIGJ5IHNvZnRpcnFz
IGZvciBuZXR3b3JrIG9yIHN0b3JhZ2UgZHJpdmVycy4NCj4gPg0KPiA+IExvbmcgcnVubmluZyBz
b2Z0aXJxcyBjYXVzZSBpc3N1ZXMgYmVjYXVzZSB0aGV5IGFyZW7igJl0IGN1cnJlbnRseSB0YWtl
bg0KPiA+IGludG8gYWNjb3VudCB3aGVuIGEgcmVhbHRpbWUgdGFzayBpcyB3b2tlbiB1cCwgYnV0
IHRoZXkgd2lsbCBkZWxheQ0KPiA+IHJlYWx0aW1lIHRhc2tzIGZyb20gcnVubmluZyBpZiB0aGUg
cmVhbHRpbWUgdGFza3MgYXJlIHBsYWNlZCBvbiBhIGNwdQ0KPiA+IGN1cnJlbnRseSBydW5uaW5n
IGEgc29mdGlycS4NCj4gDQo+IFRoYW5rcyBhIGxvdCBmb3Igc2VuZGluZyB0aGlzIHNlcmllcy4g
SSd2ZSByYWlzZWQgdGhpcyBwcm9ibGVtIGluIHZhcmlvdXMNCj4gdmVudWVzIGluIHRoZSBwYXN0
LCBidXQgaXQgc2VlbXMgaXQgaXMgaGFyZCB0byBkbyBzb21ldGhpbmcgYmV0dGVyIHRoYW4gd2hh
dA0KPiB5b3UgcHJvcG9zZSBoZXJlLg0KPiANCj4gQm9ycm93aW5nIHNvbWUgYmVoYXZpb3VycyBm
cm9tIFBSRUVNUFRfUlQgKGxpa2UgdGhyZWFkZWRpcnFzKSB3b24ndCBjdXQgaXQNCj4gb3V0c2lk
ZSBQUkVFTVBUX1JUIEFGQUlVLg0KPiANCj4gUGV0ZXIgZGlkIHN1Z2dlc3QgYW4gYWx0ZXJuYXRp
dmUgYXQgb25lIHBvaW50IGluIHRoZSBwYXN0IHRvIGJlIG1vcmUgYWdncmVzc2l2ZQ0KPiBpbiBs
aW1pdGluZyBzb2Z0aXJxcyBbMV0gYnV0IEkgbmV2ZXIgbWFuYWdlZCB0byBmaW5kIHRoZSB0aW1l
IHRvIHZlcmlmeSBpdA0KPiAtIGVzcGVjaWFsbHkgaXRzIGltcGFjdCBvbiBuZXR3b3JrIHRocm91
Z2hwdXQgYXMgdGhpcyBzZWVtcyB0byBiZSB0aGUgdHJpY2t5DQo+IHRyYWRlLW9mIChhbmQgdHJp
Y2t5IHRoaW5nIHRvIHZlcmlmeSBmb3IgbWUgYXQgbGVhc3QpLiBJJ20gbm90IHN1cmUgaWYgQkxP
Q0sNCj4gc29mdGlycXMgYXJlIGFzIHNlbnNpdGl2ZS4NCg0KSSd2ZSBoYWQgaXNzdWVzIHdpdGgg
dGhlIG9wcG9zaXRlIHByb2JsZW0uDQpMb25nIHJ1bm5pbmcgUlQgdGFza3Mgc3RvcHBpbmcgdGhl
IHNvZnRpbnQgY29kZSBydW5uaW5nLg0KDQpJZiBhbiBSVCB0YXNrIGlzIHJ1bm5pbmcsIHRoZSBz
b2Z0aW50IHdpbGwgcnVuIGluIHRoZSBjb250ZXh0IG9mIHRoZQ0KUlQgdGFzayAtIHNvIGhhcyBw
cmlvcml0eSBvdmVyIGl0Lg0KSWYgdGhlIFJUIHRhc2sgaXNuJ3QgcnVubmluZyB0aGUgc29mdGlu
dCBzdG9wcyB0aGUgUlQgdGFzayBiZWluZyBzY2hlZHVsZWQuDQpUaGlzIGlzIHJlYWxseSBqdXN0
IHRoZSBzYW1lLg0KDQpJZiB0aGUgc29mdGludCBkZWZlcnMgYmFjayB0byB0aHJlYWQgY29udGV4
dCBpdCB3b24ndCBiZSBzY2hlZHVsZWQNCnVudGlsIGFueSBSVCB0YXNrIGZpbmlzaGVzLiBUaGlz
IGlzIHRoZSBvcHBvc2l0ZSBwcmlvcml0eS4NCg0KSUlSQyB0aGVyZSBpcyBhbm90aGVyIHN0cmFu
Z2UgY2FzZSB3aGVyZSB0aGUgUlQgdGhyZWFkIGhhcyBiZWVuIHdva2VuDQpidXQgaXNuJ3QgeWV0
IHJ1bm5pbmcgLSBjYW4ndCByZW1lbWJlciB0aGUgZXhhY3QgZGV0YWlscy4NCg0KSSBjYW4gKG1v
c3RseSkgaGFuZGxlIHRoZSBSVCB0YXNrIGJlaW5nIGRlbGF5ZWQgKHRoZXJlIGFyZSBhIGxvdCBv
ZiBSVA0KdGhyZWFkcyBzaGFyaW5nIHRoZSB3b3JrKSBidXQgaXQgaXMgcGFyYW1vdW50IHRoYXQg
dGhlIGV0aGVybmV0IHJlY2VpdmUNCmNvZGUgYWN0dWFsbHkgcnVucyAtIEkgY2FuJ3QgYWZmb3Jk
IHRvIGRyb3AgcGFja2V0cyAodGhleSBjb250YWluIGF1ZGlvDQp0aGUgUlQgdGhyZWFkcyBhcmUg
cHJvY2Vzc2luZykuDQoNCkluIG15IGNhc2UgdGhyZWFkZWQgTkFQSSAobW9zdGx5KSBmaXhlcyBp
dCAtIHByb3ZpZGVkIHRoZSBOQVBJIHRocmVhZCBhcmUgUlQuDQoNCglEYXZpZA0KDQoNCj4gDQo+
IEkgdGhpbmsgdGhlIHByb3Bvc2VkIGFwcHJvYWNoIGlzIG5vdCBpbnRydXNpdmUgYW5kIG9mZmVy
cyBhIGdvb2QgYmFsYW5jZSB0aGF0DQo+IGlzIHdlbGwgY29udGFpbmVkIGFuZCBlYXN5IHRvIGlt
cHJvdmUgdXBvbiBvbiB0aGUgZnV0dXJlLiBJdCdzIHByb3RlY3RlZCB3aXRoDQo+IGEgY29uZmln
dXJhdGlvbiBvcHRpb24gc28gdXNlcnMgdGhhdCBkb24ndCB3YW50IGl0IGNhbiBlYXNpbHkgZGlz
YWJsZSBpdC4NCj4gDQo+IFsxXSBodHRwczovL2dpdGxhYi5hcm0uY29tL2xpbnV4LWFybS9saW51
eC1xeS8tL2NvbW1pdHMvY29yZS9zb2Z0aXJxLw0KPiANCj4gDQo+IFRoYW5rcw0KPiANCj4gLS0N
Cj4gUWFpcyBZb3VzZWYNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

