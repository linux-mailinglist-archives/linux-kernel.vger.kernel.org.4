Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8F612280
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJ2LlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2LlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:41:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C401691AD
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:40:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-tdaEMazbNHyIPPice42m6A-1; Sat, 29 Oct 2022 12:40:56 +0100
X-MC-Unique: tdaEMazbNHyIPPice42m6A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 29 Oct
 2022 12:40:56 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Sat, 29 Oct 2022 12:40:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>
CC:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Thread-Topic: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Thread-Index: AQHY6xELipAvmJyFFEuIWausI26LLa4lP1gQ
Date:   Sat, 29 Oct 2022 11:40:55 +0000
Message-ID: <560dd92c1f764005b519b038ae82d053@AcuMS.aculab.com>
References: <20221028210527.never.934-kees@kernel.org>
In-Reply-To: <20221028210527.never.934-kees@kernel.org>
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

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDI4IE9jdG9iZXIgMjAyMiAyMjowNg0KPiANCj4gR0ND
IDEyIGFwcGVhcnMgdG8gcGVyZm9ybSBjb25zdGFudCBwcm9wYWdhdGlvbiBpbmNvbXBsZXRlbHko
PykgYW5kIGNhbg0KPiBubyBsb25nZXIgbm90aWNlIHRoYXQgImxlbiIgaXMgYWx3YXlzIDAgd2hl
biAiZGF0YSIgaXMgTlVMTC4gRXhwYW5kIHRoZQ0KPiBjaGVjayB0byBhdm9pZCB3YXJuaW5ncyBh
Ym91dCBtZW1jcHkoKSBoYXZpbmcgYSBOVUxMIGFyZ3VtZW50Og0KLi4uDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9kZXNjX2NvbnN0ci5oIGIvZHJpdmVycy9jcnlwdG8v
Y2FhbS9kZXNjX2NvbnN0ci5oDQo+IGluZGV4IDYyY2U2NDIxYmIzZi4uZGRiYmE4YjAwYWI3IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9jYWFtL2Rlc2NfY29uc3RyLmgNCj4gKysrIGIv
ZHJpdmVycy9jcnlwdG8vY2FhbS9kZXNjX2NvbnN0ci5oDQo+IEBAIC0xNjMsNyArMTYzLDcgQEAg
c3RhdGljIGlubGluZSB2b2lkIGFwcGVuZF9kYXRhKHUzMiAqIGNvbnN0IGRlc2MsIGNvbnN0IHZv
aWQgKmRhdGEsIGludCBsZW4pDQo+ICB7DQo+ICAJdTMyICpvZmZzZXQgPSBkZXNjX2VuZChkZXNj
KTsNCj4gDQo+IC0JaWYgKGxlbikgLyogYXZvaWQgc3BhcnNlIHdhcm5pbmc6IG1lbWNweSB3aXRo
IGJ5dGUgY291bnQgb2YgMCAqLw0KPiArCWlmIChkYXRhICYmIGxlbikgLyogYXZvaWQgc3BhcnNl
IHdhcm5pbmc6IG1lbWNweSB3aXRoIGJ5dGUgY291bnQgb2YgMCAqLw0KPiAgCQltZW1jcHkob2Zm
c2V0LCBkYXRhLCBsZW4pOw0KDQpJJ2QgZ3Vlc3Mgbm9uLWNvbnN0YW50IHplcm8gbGVuZ3RocyBh
cmUgdW5saWtlbHk/DQpTbyBob3cgYWJvdXQ6DQoJLyogQXZvaWQgY2FsbGluZyBtZW1jcHkoKSB3
aGVuIHRoZXJlIGlzIG5ldmVyIGEgYnVmZmVyICovDQoJaWYgKCFfX2J1aWx0aW5fY29uc3RhbnQo
bGVuKSB8fCBsZW4pDQoJCW1lbWNweShvZmZzZXQsIGRhdGEsIGxlbik7DQoNClRoZW4gdGhlIHRl
c3Qgc2hvdWxkIG5ldmVyIGFjdHVhbGx5IGVuZCB1cCBpbiB0aGUgb2JqZWN0IGNvZGUuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

