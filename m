Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1A6E9363
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjDTLvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjDTLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:51:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432B40F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:51:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-3-VYKQSiZZMzCrXX5nBd03kw-1; Thu, 20 Apr 2023 12:50:58 +0100
X-MC-Unique: VYKQSiZZMzCrXX5nBd03kw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Apr
 2023 12:50:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 20 Apr 2023 12:50:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Fangrui Song' <maskray@google.com>,
        Florent Revest <revest@google.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>
Subject: RE: clangd cannot handle tree_nocb.h
Thread-Topic: clangd cannot handle tree_nocb.h
Thread-Index: AQHZcvnZ+BIUvq3YZUeAuVWwOlp7wa80FdDw
Date:   Thu, 20 Apr 2023 11:50:57 +0000
Message-ID: <e6c8e08dfc8a4895aca44571d26fa445@AcuMS.aculab.com>
References: <20230414005309.GA2198310@google.com>
 <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <CAKwvOdk+D6HuWwAH3EJtwDyPqoiP+2z62ek2hnmbhDV2CJwnbw@mail.gmail.com>
 <CALGbS4V+x1JkiPL2o59LgtbSQhzg_RKM5TYE7i7qZx0qz23y-g@mail.gmail.com>
 <CAFP8O3KQRbmgyvuyuxNOa6TZ7MawN7YoGHvpFQ=oibEo3aUfDQ@mail.gmail.com>
In-Reply-To: <CAFP8O3KQRbmgyvuyuxNOa6TZ7MawN7YoGHvpFQ=oibEo3aUfDQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFuZ3J1aSBTb25nDQo+IFNlbnQ6IDE5IEFwcmlsIDIwMjMgMjE6MDINCi4uLi4NCj4g
U29tZSBpbmZvcm1hdGlvbiBhYm91dCBDbGFuZyBiYXNlZCBsYW5ndWFnZSBzZXJ2ZXJzDQo+IA0K
PiBJdCdzIGdvb2QgcHJhY3RpY2UgdG8gZW5zdXJlIHRoYXQgYSBoZWFkZXIgZmlsZSBpcyBzZWxm
LWNvbnRhaW5lZC4gSWYNCj4gbm90LCBmb3IgZXhhbXBsZSwgaWYgYS5jIGluY2x1ZGVzIGEuaCwg
d2hpY2ggaXMgbm90IHNlbGYtY29udGFpbmVkLA0KPiBhLmggaXMgZ2VuZXJhbGx5IGNvbXBpbGVk
IG9uIGl0cyBvd24gKGFzIGlmIHVzaW5nIGNsYW5nIFtvcHRpb25zXSBhLmgpDQo+IHRvIGNvbmZp
bmUgZGlhZ25vc3RpY3MvY29tcGxldGlvbiByZXN1bHRzIHRvIGEuaCBhbmQgbm90IHRvIG90aGVy
DQo+IGhlYWRlcnMgaW5jbHVkZWQgYnkgYS5jLg0KPiANCj4gSG93ZXZlciwgdGhpcyBkZXNpZ24g
Y2hvaWNlIG1heSBjYXVzZSBsYW5ndWFnZSBzZXJ2ZXJzIHRvIGVtaXQNCj4gZGlhZ25vc3RpY3Mg
dGhhdCB5b3UgZG9uJ3Qgc2VlIHdoZW4gYnVpbGRpbmcgdGhlIHByb2plY3QuDQoNClRoYXQgcmVh
bGx5IGRvZXNuJ3Qgd29yayBmb3IgLmggZmlsZXMgdGhhdCBjb250YWluIHByb2dyYW0NCmdlbmVy
YXRlZCBkYXRhIHVzZWQgdG8gaW5pdGlhbGlzZSBhcnJheXMuDQoNClRoZXkgbWF5IG5vdCBldmVu
IGNvbnRhaW4gbnVtYmVycywganVzdCByZWZlcmVuY2VzIHRvDQojZGVmaW5lcyB0aGF0IHRoYXQg
aW5jbHVkaW5nIGZpbGUgaXMgZXhwZWN0ZWQgdG8gZGVmaW5lLg0KDQpTbyB0aGVyZSB3aWxsIGFs
d2F5cyBiZSAuaCBmaWxlcyB0aGF0IGFyZSBub3QgY29tcGlsYWJsZS4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

