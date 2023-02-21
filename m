Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BC69DAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjBUG3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjBUG3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:29:20 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174442201E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:29:17 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B26885FD49;
        Tue, 21 Feb 2023 09:29:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1676960953;
        bh=J4GGD+2l/dLrAC7SommQy5cNs2a8BqaY2AypKovMSnw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=d01pEWMKvO/OxR3qkpqsGI0Y6AzK34Xjh/y99ZrzKJ/CtUTXBjmk6ICO7DnISVuzV
         7hCxRLG1MI3/iXbsCjmmTV7OaI8lunF6RaddES8RNTZ0hwLo0b1kAHPWy0gPjUxyE7
         rizvVouo3Z/RCh1jbhz03ygk1Y4jpJFW+ZMLfe308hAW1l3WEQbjps6ZFjPDezTq/M
         OioG7M6/sna6dQs0jE4coJ5UVzejIB2we4T6gsAkLiZQX7cx/HKjH6aY8HB0dig5JG
         Nl+am+UQgeiznyCbFkpfZIcfDkKekb4i6PRwLHTwfLJcwF0QidFTU10AsXXb0eNlSN
         K3pIsYKZ8ZJeA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 21 Feb 2023 09:29:11 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: meson: initialize struct with zeroes
Thread-Topic: [PATCH] mtd: rawnand: meson: initialize struct with zeroes
Thread-Index: AQHZRb3PAtJycZT9oEiE8E6P9L5Dug==
Date:   Tue, 21 Feb 2023 06:29:11 +0000
Message-ID: <60729500-b6ad-6ffe-0550-80d9d61cc3ed@sberdevices.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BA35F9B4A40D0469BBEC1BD52087B87@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/21 02:56:00 #20885447
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzdHJ1Y3R1cmUgbXVzdCBiZSB6ZXJvZWQsIGJlY2F1c2UgaXQncyBmaWVsZCAnaHctPmNv
cmUnIGlzIHVzZWQgYXMNCidwYXJlbnQnIGluICdjbGtfY29yZV9maWxsX3BhcmVudF9pbmRleCgp
JywgYnV0IGl0IHdpbGwgYmUgdW5pbml0aWFsaXplZC4NClRoaXMgaGFwcGVucywgYmVjYXVzZSB3
aGVuIHRoaXMgc3RydWN0IGlzIG5vdCB6ZXJvZWQsIHBvaW50ZXIgJ2h3JyBpcw0KImluaXRpYWxp
emVkIiBieSBnYXJiYWdlLCB3aGljaCBpcyB2YWxpZCBwb2ludGVyLCBidXQgcG9pbnRzIHRvIHNv
bWUNCmdhcmJhZ2UuIFNvICdodycgd2lsbCBiZSBkZXJlZmVyZW5jZWQsIGJ1dCAnY29yZScgY29u
dGFpbnMgc29tZSByYW5kb20NCmRhdGEgd2hpY2ggd2lsbCBiZSBpbnRlcnByZXRlZCBhcyBwb2lu
dGVyLiBUaGUgZm9sbG93aW5nIGJhY2t0cmFjZSBpcw0KcmVzdWx0IG9mIGRlcmVmZXJlbmNlIG9m
IHN1Y2ggcG9pbnRlcjoNCg0KWyAgICAxLjA4MTMxOV0gIF9fY2xrX3JlZ2lzdGVyKzB4NDE0LzB4
ODIwDQpbICAgIDEuMDg1MTEzXSAgZGV2bV9jbGtfcmVnaXN0ZXIrMHg2NC8weGQwDQpbICAgIDEu
MDg4OTk1XSAgbWVzb25fbmZjX3Byb2JlKzB4MjU4LzB4NmVjDQpbICAgIDEuMDkyODc1XSAgcGxh
dGZvcm1fcHJvYmUrMHg3MC8weGYwDQpbICAgIDEuMDk2NDk4XSAgcmVhbGx5X3Byb2JlKzB4Yzgv
MHgzZTANClsgICAgMS4xMDAwMzRdICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4NC8weDE5MA0K
WyAgICAxLjEwNDM0Nl0gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg0NC8weDEyMA0KWyAgICAxLjEw
ODQ4N10gIF9fZHJpdmVyX2F0dGFjaCsweGI0LzB4MjIwDQpbICAgIDEuMTEyMjgyXSAgYnVzX2Zv
cl9lYWNoX2RldisweDc4LzB4ZDANClsgICAgMS4xMTYwNzddICBkcml2ZXJfYXR0YWNoKzB4MmMv
MHg0MA0KWyAgICAxLjExOTYxM10gIGJ1c19hZGRfZHJpdmVyKzB4MTg0LzB4MjQwDQpbICAgIDEu
MTIzNDA4XSAgZHJpdmVyX3JlZ2lzdGVyKzB4ODAvMHgxNDANClsgICAgMS4xMjcyMDNdICBfX3Bs
YXRmb3JtX2RyaXZlcl9yZWdpc3RlcisweDMwLzB4NDANClsgICAgMS4xMzE4NjBdICBtZXNvbl9u
ZmNfZHJpdmVyX2luaXQrMHgyNC8weDMwDQoNClNpZ25lZC1vZmYtYnk6IEFyc2VuaXkgS3Jhc25v
diA8QVZLcmFzbm92QHNiZXJkZXZpY2VzLnJ1Pg0KLS0tDQogZHJpdmVycy9tdGQvbmFuZC9yYXcv
bWVzb25fbmFuZC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFu
ZC5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jDQppbmRleCA1ZWUwMTIzMWFj
NGMuLjMwZTMyNmFkYWJmYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L21lc29u
X25hbmQuYw0KKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jDQpAQCAtOTkx
LDcgKzk5MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRkX29vYmxheW91dF9vcHMgbWVzb25f
b29ibGF5b3V0X29wcyA9IHsNCiANCiBzdGF0aWMgaW50IG1lc29uX25mY19jbGtfaW5pdChzdHJ1
Y3QgbWVzb25fbmZjICpuZmMpDQogew0KLQlzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIG5mY19kaXZp
ZGVyX3BhcmVudF9kYXRhWzFdOw0KKwlzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIG5mY19kaXZpZGVy
X3BhcmVudF9kYXRhWzFdID0gezB9Ow0KIAlzdHJ1Y3QgY2xrX2luaXRfZGF0YSBpbml0ID0gezB9
Ow0KIAlpbnQgcmV0Ow0KIA0KLS0gDQoyLjM1LjANCg==
