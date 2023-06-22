Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC973A2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjFVOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFVOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:19:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954F199B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:19:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-4bJJ1CvfPlORYTwzXmSciQ-1; Thu, 22 Jun 2023 15:19:02 +0100
X-MC-Unique: 4bJJ1CvfPlORYTwzXmSciQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Jun
 2023 15:18:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 22 Jun 2023 15:18:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Menglong Dong' <menglong8.dong@gmail.com>
CC:     Yonghong Song <yhs@meta.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
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
Thread-Index: AQHZojpWs5Lg7kC5tkqA5j50mje7+6+WgmuQgAA864CAACFjYA==
Date:   Thu, 22 Jun 2023 14:18:59 +0000
Message-ID: <84050129b8ce4db9b4579be0fc022723@AcuMS.aculab.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com>
 <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
 <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com>
 <CADxym3bY5EcZhuJG=x5s7kH+BS93ySAyvV8yZ7yYoXf7HCsZVw@mail.gmail.com>
In-Reply-To: <CADxym3bY5EcZhuJG=x5s7kH+BS93ySAyvV8yZ7yYoXf7HCsZVw@mail.gmail.com>
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

Li4uDQo+ID4gSXMgdGhhdCByaWdodCBmb3IgODYtNjQ/DQo+ID4NCj4gPiBJSVJDIGFyZ3VtZW50
cyBhbHdheXMgdGFrZSAoYXQgbGVhc3QpIDY0Yml0cy4NCj4gPiBGb3IgYW55IDMyYml0IGFyZ3Vt
ZW50IChyZWdpc3RlciBvciBzdGFjaykgdGhlIGhpZ2ggYml0cyBhcmUgdW5kZWZpbmVkLg0KPiA+
IChNYXliZSBpbiBrZXJuZWwgdGhleSBhcmUgYWx3YXlzIHplcm8/DQo+ID4gRnJvbSAzMmJpdCB1
c2Vyc3BhY2UgdGhleSBhcmUgZGVmaW5pdGVseSByYW5kb20uKQ0KPiA+DQo+IA0KPiBIZWxsbywN
Cj4gDQo+IEFjY29yZGluZyB0byBteSB0ZXN0aW5nLCB0aGUgY29tcGlsZXIgd2lsbCBhbHdheXMN
Cj4gcGFzcyB0aGUgYXJndW1lbnRzIG9uIDgtYnl0ZSBzaXplIHdpdGggInB1c2giIGluc24NCj4g
aWYgdGhlIGNvdW50IG9mIHRoZSBhcmd1bWVudHMgdGhhdCBuZWVkIHRvIGJlIHBhc3NlZA0KPiBv
biBzdGFjayBtb3JlIHRoYW4gMSBhbmQgdGhlIHNpemUgb2YgdGhlIGFyZ3VtZW50DQo+IGRvZXNu
J3QgZXhjZWVkIDgtYnl0ZS4gSW4gdGhpcyBjYXNlLCB0aGVyZSB3b24ndCBiZQ0KPiBnYXJiYWdl
LiBGb3IgZXhhbXBsZSwgdGhlIGhpZ2ggNC1ieXRlIHdpbGwgYmUgbWFkZSAwDQo+IGlmIHRoZSBz
aXplIG9mIHRoZSBhcmd1bWVudCBpcyA0LWJ5dGUsIGFzIHRoZSAicHVzaCIgaW5zbg0KPiB3aWxs
IGNvcHkgdGhlIGFyZ3VtZW50IGZyb20gcmVncyBvciBpbW0gaW50byBzdGFjaw0KPiBpbiA4LWJ5
dGUuDQoNCllvdSBoYXZlIHRvIGtub3cgd2hldGhlciBhIHZhbHVlIGlzIGV4cGVjdGVkIHRvIGJl
IDQgb3IgOA0KYnl0ZXMgLSBhIG5lZ2F0aXZlIDMyYml0IHZhbHVlIGlzIHplcm8gZXh0ZW5kZWQg
c28gY2FuJ3QNCmJlIHRyZWF0ZWQgYXMgYSA2NGJpdCB2YWx1ZS4NCg0KVGhhdCBpcyBldmVuIHRy
dWUgZm9yIHZhbHVlcyBwYXNzZWQgaW4gcmVnaXN0ZXJzLg0KDQpUaGVyZSBpcyBhbHNvIGEgY29t
bW9uIHByb2JsZW0gd2l0aCB2YWx1ZXMgcGFzc2VkIGluIHJlZ2lzdGVycw0KdG8gc3lzdGVtIGNh
bGxzIGJ5IDMyYml0IGNvZGUgKG1heWJlIGJwZiBpcyB0cmFjaW5nIHRoZXNlKS4NCkluIHRoaXMg
Y2FzZSB0aGUgaGlnaCAzMiBiaXRzIG9mIHRoZSByZWdpc3RlciBhcmUgcmFuZG9tLg0KVGhleSBk
b24ndCBnZXQgemVyb2QgaW4gMzJiaXQgbW9kZS4NCg0KPiBJZiB0aGUgY291bnQgb2YgdGhlIGFy
Z3VtZW50cyBvbi1zdGFjayBpcyAxIGFuZCBpdHMgc2l6ZQ0KPiBkb2Vzbid0IGV4Y2VlZCA0LWJ5
dGUsIHNvbWUgY29tcGlsZXIsIGxpa2UgY2xhbmcsIG1heQ0KPiBub3QgdXNlIHRoZSAicHVzaCIg
aW5zbi4gSW5zdGVhZCwgaXQgYWxsb2NhdGVzIDQgYnl0ZXMgaW4gdGhlDQo+IHN0YWNrLCBhbmQg
Y29waWVzIHRoZSBhcmd1bWVudHMgZnJvbSByZWdzIG9yIGltbSBpbnRvDQo+IHN0YWNrIGluIDQt
Ynl0ZS4gVGhpcyBpcyB0aGUgY2FzZSB3ZSBkZWFsIHdpdGggaGVyZS4NCg0KSWYgdGhlIGNvbXBp
bGVyIHNvbWV0aW1lcyB3cml0ZXMgYSA0IGJ5dGUgKG9yIHNtYWxsZXIpIHZhbHVlDQp0byBwcmUt
YWxsb2NhdGVkIHN0YWNrIHRoZW4gaXQgaXMgYWx3YXlzIGFsbG93ZWQgdG8gZG8gdGhhdC4NClNv
IHRoZSBoaWdoIGJ5dGVzIG9mIHRoZSBzdGFjayBzbG90IHRoYXQgY29udGFpbnMgYSAzMmJpdA0K
YXJndW1lbnQgbWlnaHQgYWx3YXlzIGJlIGp1bmsuDQpUaGUgY291bnQgb2Ygb24tc3RhY2sgYXJn
dW1lbnRzIGlzbid0IHJlbGV2YW50Lg0KDQo+IEknbSBub3Qgc3VyZSBpZiBJIHVuZGVyc3RhbmQg
eW91IGNvcnJlY3RseS4gRG8geW91IG1lYW4NCj4gdGhhdCB0aGVyZSB3aWxsIGJlIGdhcmJhZ2Ug
dmFsdWVzIGZvciAzMmJpdCBhcmdzPw0KDQpJJ20gcHJldHR5IHN1cmUgdGhhdCB0aGUgZnVuY3Rp
b24gY2FsbCBBQkkgZG9lc24ndCByZXF1aXJlIHRoZQ0KY2FsbGVyIHNldCB0aGUgaGlnaCBiaXRz
IG9mIHN1Yi02NGJpdCBhcmd1bWVudHMuDQpUaGUgZmFjdCB0aGF0IHRoZXkgYXJlIG9mdGVuIHdy
aXR0ZW4gd2l0aCBhIHB1c2ggaW5zdHJ1Y3Rpb24NCnRoYXQgemVyb3MgdGhlIGhpZ2ggYnl0ZXMg
aXNuJ3QgcmVhbGx5IHJlbGV2YW50Lg0KDQo+ID4gSSB0aGluayB0aGUgY2FsbGVkIGNvZGUgaXMg
YWxzbyByZXNwb25zaWJsZSBmb3JtIG1hc2tpbmcgOCBhbmQgMTZiaXQNCj4gPiB2YWx1ZXMgKGlu
IHJlYWxpdHkgY2hhci9zaG9ydCBhcmdzIGFuZCByZXR1cm4gdmFsdWVzIGp1c3QgYWRkIGNvZGUN
Cj4gPiBibG9hdCkuDQo+ID4NCj4gPiBBIDEyOGJpdCB2YWx1ZSBpcyBlaXRoZXIgcGFzc2VkIGlu
IHR3byByZWdpc3RlcnMgb3IgdHdvIHN0YWNrDQo+ID4gc2xvdHMuIElmIHRoZSBsYXN0IHJlZ2lz
dGVyIGlzIHNraXBwZWQgaXQgd2lsbCBiZSB1c2VkIGZvciB0aGUNCj4gPiBuZXh0IGFyZ3VtZW50
Lg0KPiA+DQo+IA0KPiBZZWFoLCB0aGlzIHBvaW50IGlzIGNvbnNpZGVyZWQgaW4gc2F2ZV9hcmdz
KCkuIE9uY2UNCj4gdGhpcyBoYXBwZW4sIHRoZSBjb3VudCBvZiBzdGFjayBzbG90cyBzaG91bGQg
bW9yZQ0KPiB0aGVuIDEsIGFuZCB0aGUgYXJndW1lbnRzIG9uLXN0YWNrIHdpbGwgYmUgc3RvcmVk
IHdpdGgNCj4gInB1c2giIGluc24gaW4gOC1ieXRlLiBUaGVyZWZvcmUsIHRoZXJlIHNob3VsZG4n
dCBiZSBnYXJiYWdlDQo+IHZhbHVlcyBpbiB0aGlzIGNhc2U/DQo+IA0KPiBEbyBJIG1pc3Mgc29t
ZXRoaW5nPw0KDQpUaGUgcmVnaXN0ZXIvc3RhY2sgZm9yIHRoZXNlIHR3byBjYWxscyBpcyB0aGUg
c2FtZToNCglmb28oMSwgMiwgMywgNCwgNSwgNiwgKGludDEyOF90KTcpOw0KCWJhcigxLCAyLCAz
LCA0LCA1LCAoaW50MTI4X3QpNywgNik7DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

