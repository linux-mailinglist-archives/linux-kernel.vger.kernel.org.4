Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4876126E1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJ3C1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3C1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:27:38 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 595D527FC5;
        Sat, 29 Oct 2022 19:27:35 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 30 Oct 2022 10:27:22
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date:   Sun, 30 Oct 2022 10:27:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBXXP0K4V1j+p2eBw--.49366W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAggTB1ZdtcKM4AAAsO
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

SGksIEJhcnQuCgo+ID4gQ2FsbGluZyBibGtfZnJlZXplX3F1ZXVlIHJlc3VsdHMgaW4gYSByZWR1
bmRhbnQgY2FsbCB0bwo+ID4gYmxrX2ZyZWV6ZV9xdWV1ZV9zdGFydCBhcyBpdCBoYXMgYmVlbiBj
YWxsZWQgaW4gYmxrX3F1ZXVlX3N0YXJ0X2RyYWluLgo+ID4gCj4gPiBSZXBsYWNlIGJsa19mcmVl
emVfcXVldWUgd2l0aCBibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXQgdG8gYXZvaWQgdGhlCj4gPiBy
ZWR1bmRhbnQgY2FsbC4KPiAKPiBibGtfbXFfZGVzdHJveV9xdWV1ZSgpIGhhcyBtb3JlIGNhbGxl
cnMgdGhhbiBibGtfcXVldWVfc3RhcnRfZHJhaW4oKSBzbyAKPiB0aGUgYWJvdmUgZGVzY3JpcHRp
b24gaXMgYXQgbGVhc3QgbWlzbGVhZGluZy4KPiAKPiBBZGRpdGlvbmFsbHksIHRoZSB3b3JkICJj
bGVhbnVwIiBmcm9tIHRoZSBwYXRjaCBzZXJpZXMgdGl0bGUgaW5kaWNhdGVzIAo+IHRoYXQgbm8g
cGF0Y2ggaW4gdGhpcyBzZXJpZXMgY2hhbmdlcyB0aGUgYmVoYXZpb3Igb2YgdGhlIGNvZGUuIFRo
aXMgCj4gcGF0Y2ggaW52b2x2ZXMgYSBiZWhhdmlvciBjaGFuZ2UuCgpTb3JyeSBmb3IgbXkgcG9v
ciBkZXNjcmlwdGlvbi4gSSdsbCBzZW5kIGEgbmV3IHNlcmllcyB3aXRoIHRoZXNlCmRlc2NyaXB0
aW9uIHByb2JsZW1zIHJlc29sdmVkLgoKPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaW50cm9kdWNlcyBh
IGhhbmcgZm9yIGV2ZXJ5IGNhbGxlciBvZiAKPiBibGtfbXFfZGVzdHJveV9xdWV1ZSgpIG90aGVy
IHRoYW4gYmxrX3F1ZXVlX3N0YXJ0X2RyYWluKCkuCj4gCj4gQmFydC4KCkkgZG9uJ3Qgc2VlIHdo
eSB0aGUgcGF0Y2ggaW50cm9kdWNlcyBhIGhhbmcuIFRoZSBjYWxsaW5nIHJlbGF0aW9uc2hpcCBp
bgpibGtfbXFfZGVzdHJveV9xdWV1ZSBpcyBhcyBmb2xsb3dzOgoKYmxrX21xX2Rlc3Ryb3lfcXVl
dWUoKQogICAgLi4uCiAgICAtPiBibGtfcXVldWVfc3RhcnRfZHJhaW4oKQogICAgICAgIC0+IGJs
a19mcmVlemVfcXVldWVfc3RhcnQoKSAgPC0gY2FsbGVkCiAgICAgICAgLi4uCiAgICAtPiBibGtf
ZnJlZXplX3F1ZXVlKCkKICAgICAgICAtPiBibGtfZnJlZXplX3F1ZXVlX3N0YXJ0KCkgIDwtIGNh
bGxlZCBhZ2FpbgogICAgICAgIC0+IGJsa19tcV9mcmVlemVfcXVldWVfd2FpdCgpCiAgICAuLi4K
ClNvIEkgdGhpbmsgdGhlcmUgaXMgYSByZWR1bmRhbnQgY2FsbCB0byBibGtfZnJlZXplX3F1ZXVl
X3N0YXJ0KCksIHdlCmp1c3QgbmVlZCB0byBjYWxsIGJsa19tcV9mcmVlemVfcXVldWVfd2FpdCgp
IGFmdGVyIGNhbGxpbmcKYmxrX3F1ZXVlX3N0YXJ0X2RyYWluKCkuCgpUaGFua3MhCkppbmxvbmcg
Q2hlbgoK
