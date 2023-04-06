Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17CE6D914F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjDFIQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjDFIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:15:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFA119
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:15:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-7-YVjMLhzINku5loDUzSosnA-1; Thu, 06 Apr 2023 09:15:53 +0100
X-MC-Unique: YVjMLhzINku5loDUzSosnA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 6 Apr
 2023 09:15:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 6 Apr 2023 09:15:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Luis Chamberlain' <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "petr.pavlu@suse.com" <petr.pavlu@suse.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Thread-Topic: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Thread-Index: AQHZZ98c6jprfqRD8kOXCEPd17f6W68d7Shg
Date:   Thu, 6 Apr 2023 08:15:51 +0000
Message-ID: <979c8cf9ab2d4fcba811adc0c563b8bb@AcuMS.aculab.com>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
 <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
 <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
 <ZC2nbiarELlUVcSj@bombadil.infradead.org>
In-Reply-To: <ZC2nbiarELlUVcSj@bombadil.infradead.org>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVpcyBDaGFtYmVybGFpbiAgTHVpcyBDaGFtYmVybGFpbg0KPiBTZW50OiAwNSBBcHJp
bCAyMDIzIDE3OjUzDQo+IA0KPiBPbiBXZWQsIEFwciAwNSwgMjAyMyBhdCAwOToyMzowOUFNIC0w
NzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gPiBPbiBXZWQsIEFwciA1LCAyMDIzIGF0IDk6
MTHigK9BTSBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4g
Pg0KPiA+ID4gT2ggYnV0IEkgZG9uJ3QgZ2V0IHRoZSBhdG9taWMgaW5jcywgc28gd2UnZCBuZWVk
IGRlYnVnZnNfY3JlYXRlX2F0b21pY19sb25nX3QoKS4NCj4gPg0KPiA+ICAgZGVidWdmc19jcmVh
dGVfdWxvbmcoInRvdGFsX21vZF9zaXplIiwNCj4gPiAgICAgICAgMDQwMCwgbW9kX2RlYnVnZnNf
cm9vdCwNCj4gPiAgICAgICAgJnRvdGFsX21vZF9zaXplLmNvdW50ZXIpOw0KPiA+DQo+ID4gYnV0
IEkgZGlkbid0IGFjdHVhbGx5IHRyeSB0byBjb21waWxlIHRoYXQga2luZCBvZiB2ZXJzaW9uLg0K
PiA+DQo+ID4gKEkgdGhpbmsgImNvdW50ZXIiIGlzIGFjdHVhbGx5IGEgX3NpZ25lZF8gbG9uZywg
c28gbWF5YmUgdGhlIHR5cGVzIGRvbid0IG1hdGNoKS4NCj4gDQo+IEkgc2VlIHllcywgc2FkbHkg
d2UnZCBoYXZlIHRvIGNhc3QgdG8gKHVuc2lnbmVkIGxvbmcgKikgdG8gbWFrZSB0aGF0DQo+IHdv
cmsgYXMgYXRvbWljX2xvbmcgY291bnRlcnMgYXJlIGxvbmcgbG9uZyBpbnQ6DQo+IA0KPiAgICBk
ZWJ1Z2ZzX2NyZWF0ZV91bG9uZygidG90YWxfbW9kX3NpemUiLA0KPiAgICAgICAgIDA0MDAsIG1v
ZF9kZWJ1Z2ZzX3Jvb3QsDQo+IC0gICAgICAgICZ0b3RhbF9tb2Rfc2l6ZS5jb3VudGVyKTsNCj4g
KyAgICAgICAgKHVuc2lnbmVkIGxvbmcgKikmdG90YWxfbW9kX3NpemUuY291bnRlcik7DQo+IA0K
PiBUaGF0J3M6DQo+IA0KPiB1bnNpZ25lZCBsb25nIG1pbiBiaXRzIDMyDQo+IGxvbmcgbG9uZyAg
ICAgbWluIGJpdHMgNjQNCj4gDQo+IEJ1dCBzaW5jZSB3ZSdkIGJlIGRvaW5nIG91ciBhY2NvdW50
aW5nIGluIGF0b21pY19sb25nIGFuZCBqdXN0IHVzZQ0KPiBkZWJ1Z2ZzIGZvciBwcmludHMgSSB0
aGluayB0aGF0J3MgZmluZS4gSnVzdCBhIGJpdCB1Z2x5Lg0KDQpUaGF0IGlzbid0IGdvaW5nIHRv
IHdvcmsuDQpJdCBpcyBwcmV0dHkgbXVjaCBuZXZlciByaWdodCB0byBkbyAqKGludGVnZXJfdHlw
ZSAqKSZpbnRlZ2VyX3ZhcmlhYmxlLg0KDQpCdXQgYXJlIHlvdSByZWFsbHkgc3VyZSAnYXRvbWlj
X2xvbmcnIGlzICdsb25nIGxvbmcnDQpkb2Vzbid0IHNvdW5kIHJpZ2h0IGF0IGFsbC4NCidsb25n
IGxvbmcnIGlzIDEyOGJpdCBvbiA2NGJpdCBhbmQgNjRiaXQgb24gMzJiaXQgLSBzbyBpcyBhbHdh
eXMNCmEgZG91YmxlLXJlZ2lzdGVyIGFjY2Vzcy4NClRoaXMgaXMgd29yc2UgdGhhbiBhdG9taWNf
dTY0Lg0KDQpJIHNob3VsZCBwcm9iYWJseSB0cnkgdG8gbG9va3VwIGFuZC9vciBtZWFzdXJlIHRo
ZSBwZXJmb3JtYW5jZQ0Kb2YgYXRvbWljIG9wZXJhdGlvbnMgKGVzcC4gY21weGNoZykgb24geDg2
Lg0KSGlzdG9yaWNhbGx5IHRoZXkgd2VyZSBhIHNlcGFyYXRlIHJlYWQgYW5kIHdyaXRlIGJ1cyBj
eWNsZXMgd2l0aA0KdGhlICdsb2NrJyBzaWduYWwgYXNzZXJ0ZWQgKGFuZCBzdGlsbCBhcmUgaWYg
dGhleSBjcm9zcyBjYWNoZQ0KbGluZSBib3VuZGFyaWVzKS4NCkJ1dCBpdCBpcyBwb3NzaWJsZSB0
aGF0IGF0IGxlYXN0IHNvbWUgb2YgdGhlIGxvY2tlZCBvcGVyYXRpb25zDQooZXNwLiB0aGUgeGNo
ZyBvbmVzKSBhcmUgaW1wbGVtZW50ZWQgd2l0aGluIHRoZSBjYWNoZSBpdHNlbGYNCnNvIGFyZSBq
dXN0IGEgc2luZ2xlIGNwdSAtPiBjYWNoZSBvcGVyYXRpb24uDQpJZiBub3QgaXQgaXMgYWN0dWFs
bHkgcG9zc2libGUgdGhhdCB0aGUgX2xvY2FsIHZhcmlhbnRzIHRoYXQNCnNlZW0gdG8gaGF2ZSBi
ZWVuIGFkZGVkIHNob3VsZCBub3QgdXNlIHRoZSBsb2NrZWQgaW5zdHJ1Y3Rpb25zIQ0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

