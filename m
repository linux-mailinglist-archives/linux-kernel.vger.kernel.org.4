Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D1612ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJaCDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:03:07 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 536F529F;
        Sun, 30 Oct 2022 19:03:04 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 31 Oct 2022 10:02:57
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date:   Mon, 31 Oct 2022 10:02:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ming Lei" <ming.lei@redhat.com>
Subject: Re: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <036eb44a-fd6a-4460-49d0-5f596452d1e1@acm.org>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
 <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
 <9a758d91-42c5-d6b3-ddde-9c2b89d741a6@acm.org>
 <fb1acbc.15062f.18429642056.Coremail.nickyc975@zju.edu.cn>
 <036eb44a-fd6a-4460-49d0-5f596452d1e1@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <56d1e0a7.15bd47.1842bc712d6.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBHC7HRLF9j8gBQBw--.51449W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAg0AB1ZdtcK5UwAAse
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

PiBPbiAxMC8zMC8yMiAwNzo1NSwgSmlubG9uZyBDaGVuIHdyb3RlOgo+ID4+PiBTbyBJIHRoaW5r
IHRoZXJlIGlzIGEgcmVkdW5kYW50IGNhbGwgdG8gYmxrX2ZyZWV6ZV9xdWV1ZV9zdGFydCgpLCB3
ZQo+ID4+PiBqdXN0IG5lZWQgdG8gY2FsbCBibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXQoKSBhZnRl
ciBjYWxsaW5nCj4gPj4+IGJsa19xdWV1ZV9zdGFydF9kcmFpbigpLgo+ID4+Cj4gPj4gSSB0aGlu
ayBpdCBpcyBvbiBwdXJwb3NlIHRoYXQgYmxrX3F1ZXVlX3N0YXJ0X2RyYWluKCkgZnJlZXplcyB0
aGUKPiA+PiByZXF1ZXN0IHF1ZXVlIGFuZCBuZXZlciB1bmZyZWV6ZXMgaXQuIFNvIGlmIHlvdSB3
YW50IHRvIGNoYW5nZSB0aGlzCj4gPj4gYmVoYXZpb3IgaXQncyB1cCB0byB5b3UgdG8gbW90aXZh
dGUgd2h5IHlvdSB3YW50IHRvIGNoYW5nZSB0aGlzIGJlaGF2aW9yCj4gPj4gYW5kIGFsc28gd2h5
IGl0IGlzIHNhZmUgdG8gbWFrZSB0aGF0IGNoYW5nZS4gU2VlIGFsc28gY29tbWl0Cj4gPj4gZDNj
ZmIyYTBhYzBiICgiYmxvY2s6IGJsb2NrIG5ldyBJL08ganVzdCBhZnRlciBxdWV1ZSBpcyBzZXQg
YXMgZHlpbmciKS4KPiA+IAo+ID4gSSB0aGluayB0aGVyZSBtaWdodCBiZSBzb21lIG1pc3VuZGVy
c3RhbmRpbmcuIEkgZGlkbid0IHRvdWNoCj4gPiBibGtfcXVldWVfc3RhcnRfZHJhaW4oKSwgc28g
aXRzIGJlaGF2aW9yIGlzIG5vdCBjaGFuZ2VkLiBXaGF0IEkgaGF2ZSBkb25lCj4gPiBpcyBqdXN0
IHJlcGxhY2luZyBibGtfZnJlZXplX3F1ZXVlKCkgd2l0aCBibGtfbXFfZnJlZXplX3F1ZXVlX3dh
aXQoKSBpbgo+ID4gYmxrX21xX2Rlc3Ryb3lfcXVldWUoKS4KPiAKPiBIaSBKaW5sb25nLAo+IAo+
IERvZXMgdGhpcyBtZWFuIHRoYXQgeW91IHdhbnQgbWUgdG8gcHJvdmlkZSBtb3JlIGluZm9ybWF0
aW9uIGFib3V0IHdoYXQgSSAKPiB3cm90ZT8gV2l0aG91dCB0aGlzIHBhdGNoLCBibGtfbXFfZGVz
dHJveV9xdWV1ZSgpIHVzZXMgdHdvIG1lY2hhbmlzbXMgdG8gCj4gYmxvY2sgZnV0dXJlIEkvTyBy
ZXF1ZXN0czoKPiAxLiBTZXQgdGhlIGZsYWcgUVVFVUVfRkxBR19EWUlORy4KPiAyLiBGcmVlemUg
dGhlIHJlcXVlc3QgcXVldWUgYW5kIGxlYXZlIGl0IGZyb3plbi4KCkkgYWdyZWVkLgoKPiBZb3Vy
IHBhdGNoIG1vZGlmaWVzIGJsa19tcV9kZXN0cm95X3F1ZXVlKCkgc3VjaCB0aGF0IGl0IHVuZnJl
ZXplcyB0aGUgCj4gcmVxdWVzdCBxdWV1ZSBhZnRlciBJL08gaGFzIGJlZW4gcXVpZXNjZWQgaW5z
dGVhZCBvZiBsZWF2aW5nIGl0IGZyb3plbi4gCgpUaGlzIGlzIHdoYXQgYmxrX21xX2Rlc3Ryb3lf
cXVldWUoKSBsb29rcyBsaWtlIHdpdGggdGhlIHBhdGNoIChyZW1vdmVkCnRoZSBzdHVwaWQgY29t
bWVudCBhcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0b3BoIEhlbGx3aWcpOgoKdm9pZCBibGtfbXFfZGVz
dHJveV9xdWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKewoJV0FSTl9PTl9PTkNFKCFxdWV1
ZV9pc19tcShxKSk7CglXQVJOX09OX09OQ0UoYmxrX3F1ZXVlX3JlZ2lzdGVyZWQocSkpOwoKCW1p
Z2h0X3NsZWVwKCk7CgoJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfRFlJTkcsIHEpOwoJ
YmxrX3F1ZXVlX3N0YXJ0X2RyYWluKHEpOwoJYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0KHEpOwoK
CWJsa19zeW5jX3F1ZXVlKHEpOwoJYmxrX21xX2NhbmNlbF93b3JrX3N5bmMocSk7CglibGtfbXFf
ZXhpdF9xdWV1ZShxKTsKfQoKSSBjYW4ndCBzZWUgd2hlcmUgdGhlIHVuZnJlZXppbmcgaGFwcGVu
cy4gRGlkIEkgbWlzcyBzb21ldGhpbmc/Cgo+IEkgd291bGQgYXBwcmVjaWF0ZSBpdCBpZiBNaW5n
IExlaSAoQ2MtZWQpIGNvdWxkIGNvbW1lbnQgb24gdGhpcyBjaGFuZ2UgCj4gc2luY2UgSSB0aGlu
ayB0aGF0IE1pbmcgaW50cm9kdWNlZCAoMikgaW4gYmxrX21xX2Rlc3Ryb3lfcXVldWUoKSAKPiAo
Zm9ybWVybHkgY2FsbGVkIGJsa19jbGVhbnVwX3F1ZXVlKCkpLgoKSSB3b3VsZCBhcHByZWNpYXRl
IGl0IHRvby4KClRoYW5rcyEKSmlubG9uZyBDaGVuCg==
