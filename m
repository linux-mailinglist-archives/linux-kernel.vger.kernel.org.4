Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A537A61577E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKBCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKBCTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:19:30 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 228851EEDD;
        Tue,  1 Nov 2022 19:19:27 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 2 Nov 2022 10:19:24
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Wed, 2 Nov 2022 10:19:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 4/4] blk-mq: improve readability of
 blk_mq_alloc_request()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221101173727.GC20690@lst.de>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173727.GC20690@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3caa5abc.16387a.1843622d8cf.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHz1us02FjoMxcBw--.54801W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAAAs5
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

PiBPbiBUdWUsIE5vdiAwMSwgMjAyMiBhdCAxMToxMTozN1BNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBBZGQgYSBoZWxwZXIgYmxrX21xX2FsbG9jX3JlcXVlc3Rfbm9jYWNoZSgpIHRv
IGFsbG9jIHJlcXVlc3Qgd2l0aG91dAo+ID4gY2FjaGUuIFRoaXMgbWFrZXMgYmxrX21xX2FsbG9j
X3JlcXVlc3QoKSBtb3JlIHJlYWRhYmxlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaW5sb25n
IENoZW4gPG5pY2t5Yzk3NUB6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiAgYmxvY2svYmxrLW1xLmMg
fCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiA+IAo+
ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMKPiA+IGluZGV4
IDg3YTYzNDhhMGQwYS4uMmZhZTExMWE0MmM4IDEwMDY0NAo+ID4gLS0tIGEvYmxvY2svYmxrLW1x
LmMKPiA+ICsrKyBiL2Jsb2NrL2Jsay1tcS5jCj4gPiBAQCAtNTcyLDM2ICs1NzIsNDcgQEAgc3Rh
dGljIHN0cnVjdCByZXF1ZXN0ICpibGtfbXFfYWxsb2NfY2FjaGVkX3JlcXVlc3Qoc3RydWN0IHJl
cXVlc3RfcXVldWUgKnEsCj4gPiAgCXJldHVybiBycTsKPiA+ICB9Cj4gPiAgCj4gPiArc3RhdGlj
IHN0cnVjdCByZXF1ZXN0ICpibGtfbXFfYWxsb2NfcmVxdWVzdF9ub2NhY2hlKHN0cnVjdCByZXF1
ZXN0X3F1ZXVlICpxLAo+ID4gKwkJYmxrX29wZl90IG9wZiwgYmxrX21xX3JlcV9mbGFnc190IGZs
YWdzKQo+IAo+IFRoZSBuYW1lIGlzIGEgYml0IG9kZCwgYnV0IEkgY2FuJ3QgdGhpbmsgb2ZmIGEg
YmV0dGVyIG9uZS4KPiAKPiA+ICsJc3RydWN0IGJsa19tcV9hbGxvY19kYXRhIGRhdGEgPSB7Cj4g
PiAgCQkJLnEJCT0gcSwKPiA+ICAJCQkuZmxhZ3MJCT0gZmxhZ3MsCj4gPiAgCQkJLmNtZF9mbGFn
cwk9IG9wZiwKPiA+ICAJCQkubnJfdGFncwk9IDEsCj4gPiAgCQl9Owo+IAo+IEFuZCB0aGlzIG5v
dyBoYXMgc3VwZXJmbG91cyBpbmRlbmF0aW9uLiAgT3ZlcmFsbCwgd2hpbGUgdGhlIHNlcGFyYXRl
Cj4gaGVscGVyIGxvb2tzIG1hcmdpbmFsbHkgbmljZXIsIEknbSBub3QgcmVhbGx5IHN1cmUgaXQg
aXMgd29ydGggdGhlCj4gY2h1cm4uCgpJJ2xsIGRyb3AgdGhlIHBhdGNoIGlmIHlvdSB0aGluayBp
dCBpcyBub3Qgd29ydGggdGhlIGNodXJuLiBCdXQgSQpzdGFydGVkIGRvaW5nIHRoaXMgYmVjYXVz
ZSBvZiB0aGUgZm9sbG93aW5nIGdvdG8gc3RhdGVtZW50OgoKCXJxID0gYmxrX21xX2FsbG9jX2Nh
Y2hlZF9yZXF1ZXN0KHEsIG9wZiwgZmxhZ3MpOwoJaWYgKCFycSkgewoJCVsuLi5dCgkJcmV0ID0g
YmxrX3F1ZXVlX2VudGVyKHEsIGZsYWdzKTsKCQlbLi4uXQoJCXJxID0gX19ibGtfbXFfYWxsb2Nf
cmVxdWVzdHMoJmRhdGEpOwoJCWlmICghcnEpCgkJCWdvdG8gb3V0X3F1ZXVlX2V4aXQ7Cgl9Cglb
Li4uXQpvdXRfcXVldWVfZXhpdDoKCWJsa19xdWV1ZV9leGl0KHEpOwoJcmV0dXJuIEVSUl9QVFIo
LUVXT1VMREJMT0NLKTsKClF1ZXVlIGVudGVyaW5nIGhhcyBiZWVuIG1vdmVkIGludG8gdGhlIGZh
bGxiYWNrIHBhdGgsIGxlZnQgcXVldWUgZXhpdGluZwpvdXRzaWRlLiBTaG91bGQgSSBqdXN0IGVs
aW1pbmF0ZSB0aGUgZ290byBzdGF0ZW1lbnQgYW5kIG1vdmUgdGhlIGVycm9yCmhhbmRsaW5nIGlu
dG8gdGhlIGZhbGxiYWNrIHBhdGggdG9vPyBMaWtlOgoKCXJxID0gYmxrX21xX2FsbG9jX2NhY2hl
ZF9yZXF1ZXN0KHEsIG9wZiwgZmxhZ3MpOwoJaWYgKCFycSkgewoJCVsuLi5dCgkJcmV0ID0gYmxr
X3F1ZXVlX2VudGVyKHEsIGZsYWdzKTsKCQlbLi4uXQoJCXJxID0gX19ibGtfbXFfYWxsb2NfcmVx
dWVzdHMoJmRhdGEpOwoJCWlmICghcnEpIHsKCQkJYmxrX3F1ZXVlX2V4aXQocSk7CgkJCXJldHVy
biBFUlJfUFRSKC1FV09VTERCTE9DSyk7CgkJfQoJfQoKVGhhbmtzIQpKaW5sb25nIENoZW4=
