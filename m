Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA38734CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjFSHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFSHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:48:01 -0400
Received: from mail.inventec.com (mail.inventec.com [218.32.67.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CACC0;
        Mon, 19 Jun 2023 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=sEx03; d=inventec.com;
    h=from:to:cc:subject:date:message-id:in-reply-to:content-type:
      mime-version;
    bh=8SApXZkGgOeFsWFeTThrw5Y0o/+JYCBncaziLDbuwuc=;
    b=QXivl8xrM3UHk0nqNlz65C3MyDhIvvsBQi1hNUgJzij/aUoLaWSFA3uw1k1P5T
      JT9kXFvfiF2eiLHpWPLNdnTpvYfLXrZWY2ozsN67on3bpbBJJWUkit3hRdeP87
      DuhSX8Srv4MhID+O6vzfTBuJnfjshk9qHJLBVo+4xpP09cY=
Received: from IEC1-EX2016-04.iec.inventec (10.1.254.222) by
 IEC1-EX2016-03.iec.inventec (10.15.2.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 15:47:55 +0800
Received: from IEC1-MSE-FE2.inventec.com (10.1.254.204) by
 IEC1-EX2016-04.iec.inventec (10.1.254.222) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 15:47:55 +0800
Received: from IEC1-EX2016-02.iec.inventec (IEC1-EX2016-02.iec.inventec [10.1.254.221])
        by IEC1-MSE-FE2.inventec.com with ESMTP id 35J7lom5069730;
        Mon, 19 Jun 2023 15:47:50 +0800 (GMT-8)
        (envelope-from Chen.PJ@inventec.com)
Received: from IEC1-EX2016-01.iec.inventec (10.15.2.58) by
 IEC1-EX2016-02.iec.inventec (10.1.254.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 15:47:51 +0800
Received: from IEC1-EX2016-01.iec.inventec ([fe80::81ed:c8de:ba4:c745]) by
 IEC1-EX2016-01.iec.inventec ([fe80::81ed:c8de:ba4:c745%7]) with mapi id
 15.01.2507.023; Mon, 19 Jun 2023 15:47:50 +0800
From:   =?utf-8?B?Q2hlbi5QSiDpmbPmn4/ku7sgVEFP?= <Chen.PJ@inventec.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
CC:     =?utf-8?B?WWUuVmljIOiRieWuh+a4hSBUQU8=?= <ye.vic@inventec.com>,
        =?utf-8?B?SHVhbmcuQWxhbmcg6buD6Iux6YOOIFRBTw==?= 
        <Huang.Alang@inventec.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Inventec
 starscream-bmc
Thread-Topic: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Inventec
 starscream-bmc
Thread-Index: AQHZonlGhub8MK1GcUC3/L5H9ZwPt6+RK0EAgACQAKA=
Date:   Mon, 19 Jun 2023 07:47:50 +0000
Message-ID: <832a9af9c9024ed3b7bee0d36a482837@inventec.com>
References: <20230619064249.3623-1-chen.pj@inventec.com>
 <2a9e503b-7a5b-3b1e-a912-5d54a23c1ca1@linaro.org>
In-Reply-To: <2a9e503b-7a5b-3b1e-a912-5d54a23c1ca1@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.6.245.192]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: IEC1-MSE-FE2.inventec.com 35J7lom5069730
X-TM-SNTS-SMTP: 9DCE9D045593F2EF9FC039E1ACED29B7002FF0250890EEAFEE7D2B4813BA86872000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpTb3JyeSBmb3IgYnJvdGhlcmluZyB5b3UgYW5kIHRoYW5rcyBmb3Ig
eW91ciBwYXRpZW5jZS4NCg0KSSB1c2UgImdpdCBpbWFwIHNlbmQiIGFuZCBjYW4gb25seSBzZW5k
IHR3byBwYXRjaCBzZXBhcmF0ZWx5Lg0KQWZ0ZXIgeW91ciBpbnN0cnVjdGlvbiwgd2Ugc2V0dXAg
dGhlIHNtdHAgc2VydmVyIGFuZCBub3cgc2VuZCB0d28gcGF0Y2ggdG9nZXRoZXIuDQoNCkJ1dCBp
dCBzZWVtcyBzdGlsbCBub3QgZW5vdWdoLg0KRGlkIHlvdSBtZWFuIHdlIG5lZWQgdG8gY29tYmlu
ZSB0d28gcGF0Y2ggdGhhdCBtb2RpZnkgdGhlIGRvY3VtZW50IGFuZCBkdHMgaW4gIm9uZSIgcGF0
Y2g/DQoNCkJlc3QgUmVnYXJkcw0KUEogQ2hlbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8u
b3JnPiANClNlbnQ6IE1vbmRheSwgSnVuZSAxOSwgMjAyMyAyOjU2IFBNDQpUbzogQ2hlbi5QSiDp
mbPmn4/ku7sgVEFPIDxDaGVuLlBKQGludmVudGVjLmNvbT47IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+OyBPbG9mIEpvaGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+OyBzb2NAa2VybmVsLm9y
ZzsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kg
PGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IEpvZWwgU3RhbmxleSA8am9lbEBq
bXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1PjsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmcN
CkNjOiBZZS5WaWMg6JGJ5a6H5riFIFRBTyA8eWUudmljQGludmVudGVjLmNvbT47IEh1YW5nLkFs
YW5nIOm7g+iLsemDjiBUQU8gPEh1YW5nLkFsYW5nQGludmVudGVjLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczogYXJtOiBhc3BlZWQ6IGFkZCBJbnZlbnRlYyBz
dGFyc2NyZWFtLWJtYw0KDQpPbiAxOS8wNi8yMDIzIDA4OjQyLCBQSiBDaGVuIHdyb3RlOg0KPiBG
cm9tOiBDaGVuIFBKIDxDaGVuLnBqQGludmVudGVjLmNvbT4NCj4gDQo+IERvY3VtZW50IHRoZSBu
ZXcgY29tcGF0aWJsZXMgdXNlZCBvbiBJbnZlbnRlYyBzdGFyc2NyZWFtLWJtYw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hlbiBQSiA8Q2hlbi5wakBpbnZlbnRlYy5jb20+DQoNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8zMTA2YzRhMS1jZTViLWE5YzQtNWNmNC02YWRlYWQ3ZmNlODBAbGlu
YXJvLm9yZy8NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzJlMDZlN2RiLTY0ZjktNTFm
OC1hZGYxLWIyNDBmMzBhMjYwOEBsaW5hcm8ub3JnLw0KDQpXaGF0J3MgdW5jbGVhciBoZXJlPyBZ
b3UgZGlkIG5vdCBjYXJlIHRvIHJlc3BvbmQgdG8gdGhhdCAodGhlIHNlY29uZCBwYXJ0IG9mIHRo
YXQgbWVzc2FnZSkuDQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQo=
