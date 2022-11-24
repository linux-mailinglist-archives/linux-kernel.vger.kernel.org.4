Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E226372EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKXHey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:34:53 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 652B79A263
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:34:49 -0800 (PST)
Received: from dzm91$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app1
 (Coremail) ; Thu, 24 Nov 2022 15:34:00 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Thu, 24 Nov 2022 15:34:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pcmcia: typo fix
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2022 www.mailtech.cn hust
In-Reply-To: <20221116014550.2716308-1-dzm91@hust.edu.cn>
References: <20221116014550.2716308-1-dzm91@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <35be0c6b.467d9.184a88ec7d5.Coremail.dzm91@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: FgEQrAAnlkVoHn9j23l1AA--.12935W
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/1tbiAQsAD17Em1CP4AABs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiRG9uZ2xpYW5nIE11IiA8
ZHptOTFAaHVzdC5lZHUuY24+Cj4g5Y+R6YCB5pe26Ze0OiAyMDIyLTExLTE2IDA5OjQ1OjUwICjm
mJ/mnJ/kuIkpCj4g5pS25Lu25Lq6OiBsaW51eEBkb21pbmlrYnJvZG93c2tpLm5ldAo+IOaKhOmA
gTogIkRvbmdsaWFuZyBNdSIgPGR6bTkxQGh1c3QuZWR1LmNuPgo+IOS4u+mimDogW1BBVENIXSBk
cml2ZXJzOiBwY21jaWE6IHR5cG8gZml4Cj4gCj4gdGhlbXNlbGZ2ZXMgLT4gdGhlbXNlbHZlcwoK
cGluZz8KCj4gCj4gU2lnbmVkLW9mZi1ieTogRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5j
bj4KPiAtLS0KPiAgZHJpdmVycy9wY21jaWEvcGNtY2lhX3Jlc291cmNlLmMgfCAyICstCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjbWNpYS9wY21jaWFfcmVzb3VyY2UuYyBiL2RyaXZlcnMvcGNtY2lhL3Bj
bWNpYV9yZXNvdXJjZS5jCj4gaW5kZXggZDc4MDkxZTc5YTBmLi5lOWUzMWM2MzhhNjcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9wY21jaWEvcGNtY2lhX3Jlc291cmNlLmMKPiArKysgYi9kcml2ZXJz
L3BjbWNpYS9wY21jaWFfcmVzb3VyY2UuYwo+IEBAIC02ODQsNyArNjg0LDcgQEAgRVhQT1JUX1NZ
TUJPTChwY21jaWFfcmVxdWVzdF9pbyk7Cj4gICAqIHBjbWNpYV9yZXF1ZXN0X2lycSgpIGlzIGEg
d3JhcHBlciBhcm91bmQgcmVxdWVzdF9pcnEoKSB3aGljaCBhbGxvd3MKPiAgICogdGhlIFBDTUNJ
QSBjb3JlIHRvIGNsZWFuIHVwIHRoZSByZWdpc3RyYXRpb24gaW4gcGNtY2lhX2Rpc2FibGVfZGV2
aWNlKCkuCj4gICAqIERyaXZlcnMgYXJlIGZyZWUgdG8gdXNlIHJlcXVlc3RfaXJxKCkgZGlyZWN0
bHksIGJ1dCB0aGVuIHRoZXkgbmVlZCB0bwo+IC0gKiBjYWxsIGZyZWVfaXJxKCkgdGhlbXNlbGZ2
ZXMsIHRvby4gQWxzbywgb25seSAlSVJRRl9TSEFSRUQgY2FwYWJsZSBJUlEKPiArICogY2FsbCBm
cmVlX2lycSgpIHRoZW1zZWx2ZXMsIHRvby4gQWxzbywgb25seSAlSVJRRl9TSEFSRUQgY2FwYWJs
ZSBJUlEKPiAgICogaGFuZGxlcnMgYXJlIGFsbG93ZWQuCj4gICAqLwo+ICBpbnQgX19tdXN0X2No
ZWNrIHBjbWNpYV9yZXF1ZXN0X2lycShzdHJ1Y3QgcGNtY2lhX2RldmljZSAqcF9kZXYsCj4gLS0g
Cj4gMi4zNS4xCg==
