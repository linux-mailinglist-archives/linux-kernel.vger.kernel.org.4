Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082026157D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiKBCja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKBCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:39:27 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30028101C7;
        Tue,  1 Nov 2022 19:39:26 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Wed, 2 Nov 2022 10:39:23
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Wed, 2 Nov 2022 10:39:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Jens Axboe" <axboe@kernel.dk>
Cc:     "Christoph Hellwig" <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 4/4] blk-mq: improve readability of
 blk_mq_alloc_request()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <79c5d83f-27b2-dbe0-826b-bcb671e0766f@kernel.dk>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173727.GC20690@lst.de>
 <3caa5abc.16387a.1843622d8cf.Coremail.nickyc975@zju.edu.cn>
 <79c5d83f-27b2-dbe0-826b-bcb671e0766f@kernel.dk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <ce2b34c.1639ea.18436352501.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAXz1pb2GFjP+RcBw--.53751W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgoCB1ZdtcNVXAACs7
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

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiSmVucyBBeGJvZSIgPGF4
Ym9lQGtlcm5lbC5kaz4KPiDlj5HpgIHml7bpl7Q6IDIwMjItMTEtMDIgMTA6MjU6MjcgKOaYn+ac
n+S4iSkKPiDmlLbku7bkuro6ICJKaW5sb25nIENoZW4iIDxuaWNreWM5NzVAemp1LmVkdS5jbj4s
ICJDaHJpc3RvcGggSGVsbHdpZyIgPGhjaEBsc3QuZGU+Cj4g5oqE6YCBOiBsaW51eC1ibG9ja0B2
Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFJl
OiBbUEFUQ0ggNC80XSBibGstbXE6IGltcHJvdmUgcmVhZGFiaWxpdHkgb2YgYmxrX21xX2FsbG9j
X3JlcXVlc3QoKQo+IAo+IE9uIDExLzEvMjIgODoxOSBQTSwgSmlubG9uZyBDaGVuIHdyb3RlOgo+
ID4+IE9uIFR1ZSwgTm92IDAxLCAyMDIyIGF0IDExOjExOjM3UE0gKzA4MDAsIEppbmxvbmcgQ2hl
biB3cm90ZToKPiA+Pj4gQWRkIGEgaGVscGVyIGJsa19tcV9hbGxvY19yZXF1ZXN0X25vY2FjaGUo
KSB0byBhbGxvYyByZXF1ZXN0IHdpdGhvdXQKPiA+Pj4gY2FjaGUuIFRoaXMgbWFrZXMgYmxrX21x
X2FsbG9jX3JlcXVlc3QoKSBtb3JlIHJlYWRhYmxlLgo+ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBKaW5sb25nIENoZW4gPG5pY2t5Yzk3NUB6anUuZWR1LmNuPgo+ID4+PiAtLS0KPiA+Pj4gIGJs
b2NrL2Jsay1tcS5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxOCBkZWxl
dGlvbnMoLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2sv
YmxrLW1xLmMKPiA+Pj4gaW5kZXggODdhNjM0OGEwZDBhLi4yZmFlMTExYTQyYzggMTAwNjQ0Cj4g
Pj4+IC0tLSBhL2Jsb2NrL2Jsay1tcS5jCj4gPj4+ICsrKyBiL2Jsb2NrL2Jsay1tcS5jCj4gPj4+
IEBAIC01NzIsMzYgKzU3Miw0NyBAQCBzdGF0aWMgc3RydWN0IHJlcXVlc3QgKmJsa19tcV9hbGxv
Y19jYWNoZWRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwKPiA+Pj4gIAlyZXR1cm4g
cnE7Cj4gPj4+ICB9Cj4gPj4+ICAKPiA+Pj4gK3N0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqYmxrX21x
X2FsbG9jX3JlcXVlc3Rfbm9jYWNoZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwKPiA+Pj4gKwkJ
YmxrX29wZl90IG9wZiwgYmxrX21xX3JlcV9mbGFnc190IGZsYWdzKQo+ID4+Cj4gPj4gVGhlIG5h
bWUgaXMgYSBiaXQgb2RkLCBidXQgSSBjYW4ndCB0aGluayBvZmYgYSBiZXR0ZXIgb25lLgo+ID4+
Cj4gPj4+ICsJc3RydWN0IGJsa19tcV9hbGxvY19kYXRhIGRhdGEgPSB7Cj4gPj4+ICAJCQkucQkJ
PSBxLAo+ID4+PiAgCQkJLmZsYWdzCQk9IGZsYWdzLAo+ID4+PiAgCQkJLmNtZF9mbGFncwk9IG9w
ZiwKPiA+Pj4gIAkJCS5ucl90YWdzCT0gMSwKPiA+Pj4gIAkJfTsKPiA+Pgo+ID4+IEFuZCB0aGlz
IG5vdyBoYXMgc3VwZXJmbG91cyBpbmRlbmF0aW9uLiAgT3ZlcmFsbCwgd2hpbGUgdGhlIHNlcGFy
YXRlCj4gPj4gaGVscGVyIGxvb2tzIG1hcmdpbmFsbHkgbmljZXIsIEknbSBub3QgcmVhbGx5IHN1
cmUgaXQgaXMgd29ydGggdGhlCj4gPj4gY2h1cm4uCj4gPiAKPiA+IEknbGwgZHJvcCB0aGUgcGF0
Y2ggaWYgeW91IHRoaW5rIGl0IGlzIG5vdCB3b3J0aCB0aGUgY2h1cm4uIEJ1dCBJCj4gPiBzdGFy
dGVkIGRvaW5nIHRoaXMgYmVjYXVzZSBvZiB0aGUgZm9sbG93aW5nIGdvdG8gc3RhdGVtZW50Ogo+
IAo+IFBsZWFzZSBqdXN0IGRyb3AgaXQsIEkgZG9uJ3QgdGhpbmsgaXQncyBhbiBpbXByb3ZlbWVu
dC4KCk9rLCB0aGVuIEknbGwganVzdCByZXNlbmQgcGF0Y2ggMiB3aXRob3V0IHRoZSBzaWxseSBn
b3RvIHJldHVybiBOVUxMIGFuZApwYXRjaCAzLgoKVGhhbmtzIQpKaW5sb25nIENoZW4K
