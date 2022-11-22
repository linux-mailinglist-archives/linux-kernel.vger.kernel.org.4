Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722CE633CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiKVMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKVMpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:45:02 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D011D1C402;
        Tue, 22 Nov 2022 04:44:57 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 22 Nov 2022 20:44:54
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Tue, 22 Nov 2022 20:44:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [RFC PATCH 0/2] elevator: restore old io scheduler on
 failure in elevator_switch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221122122446.GA5068@lst.de>
References: <cover.1668772991.git.nickyc975@zju.edu.cn>
 <20221121071305.GB23882@lst.de>
 <6d74b4a9.5489.1849f42de2d.Coremail.nickyc975@zju.edu.cn>
 <20221122122446.GA5068@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7724857b.55d9.1849f5eb423.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgD3_6tGxHxjlFJeCQ--.57695W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgECB1ZdtcipPgABsm
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

PiBPbiBUdWUsIE5vdiAyMiwgMjAyMiBhdCAwODoxNDozMFBNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBNb3N0bHkgZmFpbHVyZXMgc3BlY2lmaWMgdG8gdGhlIGludGVuZGVkIGlvIHNj
aGVkdWxlciwgbGlrZSBjb25zdW1pbmcgbW9yZQo+ID4gcmVzb3VyY2VzIHRoYW4gdGhlIG9sZCBv
bmUgdGhhdCB0aGUgc3lzdGVtIGNhbiBub3QgYWZmb3JkLiBCdXQgc3VyZSBpdCdzCj4gPiByYXJl
LCBzbyBkbyB5b3UgdGhpbmsgSSBzaG91bGQganVzdCBjb3JyZWN0IHRoZSBvdXRkYXRlZCBkb2N1
bWVudD8KPiAKPiBJJ2QgYmUgdGVtcHRlZCB0byBqdXN0IGRvY3VtZW50ZWQgdGhlIGJlaGF2aW9y
LCBiZWNhdXNlIEkgdGhpbmsgdGhlCj4gY2hhbmNlcyBhcmUgaGlnaCB0aGF0IGlmIHN3aXRjaGlu
ZyB0byBvbmUgc2NoZWR1bGUgd2lsbCBmYWlsIHRoYXQKPiBzd2l0Y2hpbmcgYmFjayB0byB0aGUg
b2xkIG9uZSB3aWxsIGZhaWwgYXMgd2VsbC4gIEkndmUgZG9uZSBhIHF1aWNrCj4gYXVkaXQgb2Yg
YWxsIHRocmVlIHNjaGVkdWxlcnMsIGFuZCB1bmxlc3MgSSBtaXNzZWQgc29tZXRoaW5nIHRoZXJl
Cj4gYXJlIG5vIG90aGVyIGZhaWx1cmUgY2FzZXMgZXhjZXB0IGZvciBydW5uaW5nIG91dCBvZiBt
ZW1vcnkuCj4gCj4gTWF5YmUgYSBwcmludGsgdG8gZG9jdW1lbnQgdGhhdCBzd2l0Y2hpbmcgdGhl
IHNjaGVkdWxlciBmYWlsZWQgYXJlCj4gd2UgYXJlbid0IHVzaW5nIGFueSBzY2hlZHVsZXIgbm93
IG1pZ2h0IGJlIHVzZWZ1bCwgdGhvdWdoLgoKT2ssIHRoZW4gSSdsbCBzZW5kIHR3byBwYXRjaGVz
IHdpdGggdGhlIGRvY3VtZW50IHVwZGF0ZWQgYW5kIHRoZSBwcmludGsgYWRkZWQuCgpUaGFua3Mh
CkppbmxvbmcgQ2hlbgo=
