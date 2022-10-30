Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D502C612B19
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJ3Ozt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3Ozr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:55:47 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D54DDBC08;
        Sun, 30 Oct 2022 07:55:45 -0700 (PDT)
Received: by ajax-webmail-mail-app3 (Coremail) ; Sun, 30 Oct 2022 22:55:38
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date:   Sun, 30 Oct 2022 22:55:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <9a758d91-42c5-d6b3-ddde-9c2b89d741a6@acm.org>
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
 <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
 <9a758d91-42c5-d6b3-ddde-9c2b89d741a6@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <fb1acbc.15062f.18429642056.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgCXnQxqkF5jXh95CA--.23945W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKnzgABsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFNvIEkgdGhpbmsgdGhlcmUgaXMgYSByZWR1bmRhbnQgY2FsbCB0byBibGtfZnJlZXplX3F1
ZXVlX3N0YXJ0KCksIHdlCj4gPiBqdXN0IG5lZWQgdG8gY2FsbCBibGtfbXFfZnJlZXplX3F1ZXVl
X3dhaXQoKSBhZnRlciBjYWxsaW5nCj4gPiBibGtfcXVldWVfc3RhcnRfZHJhaW4oKS4KPiAKPiBJ
IHRoaW5rIGl0IGlzIG9uIHB1cnBvc2UgdGhhdCBibGtfcXVldWVfc3RhcnRfZHJhaW4oKSBmcmVl
emVzIHRoZSAKPiByZXF1ZXN0IHF1ZXVlIGFuZCBuZXZlciB1bmZyZWV6ZXMgaXQuIFNvIGlmIHlv
dSB3YW50IHRvIGNoYW5nZSB0aGlzIAo+IGJlaGF2aW9yIGl0J3MgdXAgdG8geW91IHRvIG1vdGl2
YXRlIHdoeSB5b3Ugd2FudCB0byBjaGFuZ2UgdGhpcyBiZWhhdmlvciAKPiBhbmQgYWxzbyB3aHkg
aXQgaXMgc2FmZSB0byBtYWtlIHRoYXQgY2hhbmdlLiBTZWUgYWxzbyBjb21taXQgCj4gZDNjZmIy
YTBhYzBiICgiYmxvY2s6IGJsb2NrIG5ldyBJL08ganVzdCBhZnRlciBxdWV1ZSBpcyBzZXQgYXMg
ZHlpbmciKS4KPiAKPiBCYXJ0LgoKSSB0aGluayB0aGVyZSBtaWdodCBiZSBzb21lIG1pc3VuZGVy
c3RhbmRpbmcuIEkgZGlkbid0IHRvdWNoCmJsa19xdWV1ZV9zdGFydF9kcmFpbigpLCBzbyBpdHMg
YmVoYXZpb3IgaXMgbm90IGNoYW5nZWQuIFdoYXQgSSBoYXZlIGRvbmUKaXMganVzdCByZXBsYWNp
bmcgYmxrX2ZyZWV6ZV9xdWV1ZSgpIHdpdGggYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0KCkgaW4K
YmxrX21xX2Rlc3Ryb3lfcXVldWUoKS4KClNlZToKLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1ibG9jay8yMDIyMTAzMDA4NDAxMS5HQTUyNjJAbHN0LmRlL1QvI3QKClRoYW5rcyEKSmlu
bG9uZyBDaGVuCg==
