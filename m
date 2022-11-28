Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59B63B08F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiK1Rx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiK1Rtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:49:47 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF929347;
        Mon, 28 Nov 2022 09:43:26 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E8EE55FD0A;
        Mon, 28 Nov 2022 20:43:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669657402;
        bh=uBniatlo47DGx0lnxknS3xJ2KdJNJ8RaoGC2aR+v2RM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=TRnKVvefUaR191+nwFAbtemWiswm77vLpkF7hY/bd3I5covoZGfEkawBQyR+3Tnww
         cIW+fmUMDfgXVn4WCIMq/0FMoIgRVOJ6jsGMJSBqvNtm4oEFUIUVvU881QcfVEuTwZ
         8DwgiSA8n5MeDt0kxhAkmvROK3Fd2HRUjK1QBsBTQubFzjGmXjogHIPiTdFd2bkUzh
         TQE9oW6s8HDj4lFIbvzxUJQJftjwp+bwl+qa2AIR9jt7btbbamFRhPbaozFFWXzYlr
         DLM6iz3cg6OkgEhp7WEoLB5vu3jUU3zII/aakBGD3eTv4Ui9cK5JBqOeoNZglTepnf
         csKL9n6d1MDpA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 28 Nov 2022 20:43:21 +0300 (MSK)
From:   Martin Kurbanov <MMKurbanov@sberdevices.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Thread-Topic: [PATCH v1 1/2] dt-bindings: leds: add binding for aw200xx
Thread-Index: AQHZAEYwBWEF8prNpk6+2LUuJGE9X65PHTAAgAVRwwA=
Date:   Mon, 28 Nov 2022 17:43:19 +0000
Message-ID: <0a9e7d65-4ad7-b753-ec9b-8e58a549b5db@sberdevices.ru>
References: <20221124204807.1593241-1-mmkurbanov@sberdevices.ru>
 <20221124204807.1593241-2-mmkurbanov@sberdevices.ru>
 <bb12ea88-b416-7e32-93b9-730b6f009b98@linaro.org>
In-Reply-To: <bb12ea88-b416-7e32-93b9-730b6f009b98@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A18C8B1A0353749B852380231CEA62A@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/28 12:12:00 #20620243
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkuIFRoYW5rIHlvdSBmb3IgcXVpY2sgcmVwbHkuIA0KDQpPbiAyNS4xMS4yMDIyIDExOjI5LCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gKw0KPj4gKyAgaW1heDoNCj4+ICsgICAgbWF4
SXRlbXM6IDENCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgTWF4aW11bSBzdXBwbHkg
Y3VycmVudCwgc2VlIGR0LWJpbmRpbmdzL2xlZHMvbGVkcy1hdzIwMHh4LmgNCj4gDQo+IE5vLiBV
c2UgZXhpc3RpbmcgcHJvcGVydGllcyBmcm9tIGNvbW1vbi55YW1sLiBUaGlzIGxvb2tzIGxpa2UN
Cj4gbGVkLW1heC1taWNyb2FtcCBhbmQgaXQgaXMgcGVyIExFRCwgbm90IHBlciBlbnRpcmUgZGV2
aWNlLg0KDQpUaGUgQVcyMDBYWCBMRUQgY2hpcCBkb2VzIG5vdCBzdXBwb3J0IGltYXggc2V0dXAg
cGVyIGxlZC4NCkltYXggaXMgdGhlIGdsb2JhbCBwYXJhbWV0ZXIgb3ZlciB0aGUgYWxsIGxlZHMu
IEkgc3VwcG9zZSwgaXQncyBiZXR0ZXINCnRvIGFkZCB2ZW5kb3IgcHJlZml4IG9yIHRha2UgbWlu
aW11bSBmcm9tIGFsbCBzdWJub2Rlcz8NCkhvdyBkbyB5b3UgdGhpbms/DQoNCg0KPj4gKy8qIEds
b2JhbCBtYXggY3VycmVudCAoSU1BWCkgKi8NCj4+ICsjZGVmaW5lIEFXMjAwWFhfSU1BWF8zXzNN
QSAgOA0KPj4gKyNkZWZpbmUgQVcyMDBYWF9JTUFYXzZfN01BICA5DQo+IA0KPiBOby4gQmluZGlu
Z3MgYXJlIG5vdCBmb3Igc3RvcmluZyByZWdpc3RlciBjb25zdGFudHMuIEZlZWwgZnJlZSB0byBz
dG9yZQ0KPiBoZXJlIElEcyAoSUQgc3RhcnQgZnJvbSAwIG9yIDEgYW5kIGlzIGluY3JlbWVudGVk
IGJ5IDEpLi4uIGJ1dCBob3cgdGhlDQo+IElNQVggZXZlbiBtYXRjaGVzIGFueSBuZWVkIGZvciAi
SUQiPw0KDQpJTUFYIGNhbiBiZSBjaG9zZW4gZnJvbSB0aGUgcHJlZGVmaW5lZCB2YWx1ZXMgaW4g
dGhlDQpkYXRhc2hlZXQgKDEwbUEsIDIwbUEsIGV0YykuIERvIHlvdSBtZWFuIHRoZSBJTUFYIHNo
b3VsZCBiZSByb3VuZCBkb3duDQp0byBuZWFyZXN0IHN1cHBvcnRlZCB2YWx1ZSBpbiB0aGUgZHJp
dmVyPw0KDQotLSANCkJlc3QgUmVnYXJkcywNCkt1cmJhbm92IE1hcnRpbg0KDQo=
