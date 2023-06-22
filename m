Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9E739C69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFVJPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjFVJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:15:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBA9869F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:07:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-57-x3SlzytNPyGGTD3StBb1SA-1; Thu, 22 Jun 2023 10:06:50 +0100
X-MC-Unique: x3SlzytNPyGGTD3StBb1SA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Jun
 2023 10:06:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 22 Jun 2023 10:06:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yonghong Song' <yhs@meta.com>,
        "menglong8.dong@gmail.com" <menglong8.dong@gmail.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "benbjiang@tencent.com" <benbjiang@tencent.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
Subject: RE: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
Thread-Topic: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
Thread-Index: AQHZojpWs5Lg7kC5tkqA5j50mje7+6+WgmuQ
Date:   Thu, 22 Jun 2023 09:06:48 +0000
Message-ID: <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com>
 <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
In-Reply-To: <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4gKwkvKiBHZW5lcmFsbHkgc3BlYWtpbmcsIHRoZSBjb21waWxlciB3aWxsIHBhc3Mg
dGhlIGFyZ3VtZW50cw0KPiA+ICsJICogb24tc3RhY2sgd2l0aCAicHVzaCIgaW5zdHJ1Y3Rpb24s
IHdoaWNoIHdpbGwgdGFrZSA4LWJ5dGUNCj4gPiArCSAqIG9uIHRoZSBzdGFjay4gT24gdGhpcyBj
YXNlLCB0aGVyZSB3b24ndCBiZSBnYXJiYWdlIHZhbHVlcw0KPiANCj4gT24gdGhpcyBjYXNlIC0+
IEluIHRoaXMgY2FzZS4gVGhlIHNhbWUgZm9yIGJlbG93IGFub3RoZXIgY2FzZS4NCj4gDQo+ID4g
KwkgKiB3aGlsZSB3ZSBjb3B5IHRoZSBhcmd1bWVudHMgZnJvbSBvcmlnaW4gc3RhY2sgZnJhbWUg
dG8gY3VycmVudA0KPiA+ICsJICogaW4gQlBGX0RXLg0KPiA+ICsJICoNCj4gPiArCSAqIEhvd2V2
ZXIsIHNvbWV0aW1lcyB0aGUgY29tcGlsZXIgd2lsbCBvbmx5IGFsbG9jYXRlIDQtYnl0ZSBvbg0K
PiA+ICsJICogdGhlIHN0YWNrIGZvciB0aGUgYXJndW1lbnRzLiBGb3Igbm93LCB0aGlzIGNhc2Ug
d2lsbCBvbmx5DQo+ID4gKwkgKiBoYXBwZW4gaWYgdGhlcmUgaXMgb25seSBvbmUgYXJndW1lbnQg
b24tc3RhY2sgYW5kIGl0cyBzaXplDQo+ID4gKwkgKiBub3QgbW9yZSB0aGFuIDQgYnl0ZS4gT24g
dGhpcyBjYXNlLCB0aGVyZSB3aWxsIGJlIGdhcmJhZ2UNCj4gPiArCSAqIHZhbHVlcyBvbiB0aGUg
dXBwZXIgNC1ieXRlIHdoZXJlIHdlIHN0b3JlIHRoZSBhcmd1bWVudCBvbg0KPiA+ICsJICogY3Vy
cmVudCBzdGFjayBmcmFtZS4NCg0KSXMgdGhhdCByaWdodCBmb3IgODYtNjQ/DQoNCklJUkMgYXJn
dW1lbnRzIGFsd2F5cyB0YWtlIChhdCBsZWFzdCkgNjRiaXRzLg0KRm9yIGFueSAzMmJpdCBhcmd1
bWVudCAocmVnaXN0ZXIgb3Igc3RhY2spIHRoZSBoaWdoIGJpdHMgYXJlIHVuZGVmaW5lZC4NCihN
YXliZSBpbiBrZXJuZWwgdGhleSBhcmUgYWx3YXlzIHplcm8/DQpGcm9tIDMyYml0IHVzZXJzcGFj
ZSB0aGV5IGFyZSBkZWZpbml0ZWx5IHJhbmRvbS4pDQoNCkkgdGhpbmsgdGhlIGNhbGxlZCBjb2Rl
IGlzIGFsc28gcmVzcG9uc2libGUgZm9ybSBtYXNraW5nIDggYW5kIDE2Yml0DQp2YWx1ZXMgKGlu
IHJlYWxpdHkgY2hhci9zaG9ydCBhcmdzIGFuZCByZXR1cm4gdmFsdWVzIGp1c3QgYWRkIGNvZGUN
CmJsb2F0KS4NCg0KQSAxMjhiaXQgdmFsdWUgaXMgZWl0aGVyIHBhc3NlZCBpbiB0d28gcmVnaXN0
ZXJzIG9yIHR3byBzdGFjaw0Kc2xvdHMuIElmIHRoZSBsYXN0IHJlZ2lzdGVyIGlzIHNraXBwZWQg
aXQgd2lsbCBiZSB1c2VkIGZvciB0aGUNCm5leHQgYXJndW1lbnQuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

