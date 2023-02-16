Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70277699BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBPR5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:57:43 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6911BD1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:57:39 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 8E9FD5FD10;
        Thu, 16 Feb 2023 20:57:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1676570255;
        bh=SduSeqOwVL90O9MEgDTlHkV2YuE15AjLaWPjyDCCbvQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=kFmCVb1rxHNm8v5I0wrODLKy6oWi5DrJVjX3n8ylfuqC+mgu2vSVFodi/xRTa5lY4
         2fT6+47r/IzlJvv4YbX0jwJPTGo+9JPMORi3+eEaFqLqsYoHSvI+1FFQuTwGwV3naM
         hV01t8DBIQdoZW6ecsJ5hb8hDZQzzwLB+YWdvr0bkxhrlwCdwYJ/+o79NxK1YyVgas
         jiD85t+P389oy8WjJo8IpxT7Rh7SCr0ul22l57qP9lrmTdzifKHrA3PioaTya0H24+
         id7ng3Sqjty+eEOzpb0vrzy9oZNg+LiZ+iYI/aA8ONo3aVsoQrsSyO65BazcTQZt90
         jNh5GZjJ2pAKw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Feb 2023 20:57:32 +0300 (MSK)
From:   =?utf-8?B?0JrRgNCw0YHQvdC+0LIg0JDRgNGB0LXQvdC40Lk=?= 
        <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?utf-8?B?0JrRgNCw0YHQvdC+0LIg0JDRgNGB0LXQvdC40Lk=?= 
        <AVKrasnov@sberdevices.ru>, Krasnov Arseniy <oxffffaa@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: [PATCH] mtd: rawnand: meson: initialize struct with zeroes
Thread-Topic: [PATCH] mtd: rawnand: meson: initialize struct with zeroes
Thread-Index: AQHZQjAk8W+Ow1LN4Uavv419Ihk4sA==
Date:   Thu, 16 Feb 2023 17:57:32 +0000
Message-ID: <8881a365-e218-916a-e68d-d889797279be@sberdevices.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <67C80C4B08BF6441AA617A43FDA00DA0@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/16 08:39:00 #20868660
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
JywgYnV0IGl0IHdpbGwgYmUgdW5pbml0aWFsaXplZC4NClRoZSBmb2xsb3dpbmcgYmFja3RyYWNl
IGlzIHJlc3VsdCBvZiB0aGUgZGVyZWZlcmVuY2Ugb2Ygc3VjaCBwb2ludGVyOg0KDQpbICAgIDEu
MDgxMzE5XSAgX19jbGtfcmVnaXN0ZXIrMHg0MTQvMHg4MjANClsgICAgMS4wODUxMTNdICBkZXZt
X2Nsa19yZWdpc3RlcisweDY0LzB4ZDANClsgICAgMS4wODg5OTVdICBtZXNvbl9uZmNfcHJvYmUr
MHgyNTgvMHg2ZWMNClsgICAgMS4wOTI4NzVdICBwbGF0Zm9ybV9wcm9iZSsweDcwLzB4ZjANClsg
ICAgMS4wOTY0OThdICByZWFsbHlfcHJvYmUrMHhjOC8weDNlMA0KWyAgICAxLjEwMDAzNF0gIF9f
ZHJpdmVyX3Byb2JlX2RldmljZSsweDg0LzB4MTkwDQpbICAgIDEuMTA0MzQ2XSAgZHJpdmVyX3By
b2JlX2RldmljZSsweDQ0LzB4MTIwDQpbICAgIDEuMTA4NDg3XSAgX19kcml2ZXJfYXR0YWNoKzB4
YjQvMHgyMjANClsgICAgMS4xMTIyODJdICBidXNfZm9yX2VhY2hfZGV2KzB4NzgvMHhkMA0KWyAg
ICAxLjExNjA3N10gIGRyaXZlcl9hdHRhY2grMHgyYy8weDQwDQpbICAgIDEuMTE5NjEzXSAgYnVz
X2FkZF9kcml2ZXIrMHgxODQvMHgyNDANClsgICAgMS4xMjM0MDhdICBkcml2ZXJfcmVnaXN0ZXIr
MHg4MC8weDE0MA0KWyAgICAxLjEyNzIwM10gIF9fcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKzB4
MzAvMHg0MA0KWyAgICAxLjEzMTg2MF0gIG1lc29uX25mY19kcml2ZXJfaW5pdCsweDI0LzB4MzAN
Cg0KU2lnbmVkLW9mZi1ieTogQXJzZW5peSBLcmFzbm92IDxBVktyYXNub3ZAc2JlcmRldmljZXMu
cnU+DQotLS0NCiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9tZXNvbl9uYW5kLmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9tZXNvbl9uYW5kLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jh
dy9tZXNvbl9uYW5kLmMNCmluZGV4IDVlZTAxMjMxYWM0Yy4uMzBlMzI2YWRhYmZjIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jDQorKysgYi9kcml2ZXJzL210
ZC9uYW5kL3Jhdy9tZXNvbl9uYW5kLmMNCkBAIC05OTEsNyArOTkxLDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGRfb29ibGF5b3V0X29wcyBtZXNvbl9vb2JsYXlvdXRfb3BzID0gew0KIA0KIHN0
YXRpYyBpbnQgbWVzb25fbmZjX2Nsa19pbml0KHN0cnVjdCBtZXNvbl9uZmMgKm5mYykNCiB7DQot
CXN0cnVjdCBjbGtfcGFyZW50X2RhdGEgbmZjX2RpdmlkZXJfcGFyZW50X2RhdGFbMV07DQorCXN0
cnVjdCBjbGtfcGFyZW50X2RhdGEgbmZjX2RpdmlkZXJfcGFyZW50X2RhdGFbMV0gPSB7MH07DQog
CXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQgPSB7MH07DQogCWludCByZXQ7DQogDQotLSANCjIu
MzUuMA0K
