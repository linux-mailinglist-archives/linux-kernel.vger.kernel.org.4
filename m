Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01780633F99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiKVO6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiKVO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:58:25 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B41707720C;
        Tue, 22 Nov 2022 06:55:56 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 22 Nov 2022 22:55:46
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Tue, 22 Nov 2022 22:55:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] elevator: printk a warning if switching to a new io
 scheduler fails
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <d51ed0fb457db7a4f9cbb0dbce36d534e22be457.1669126766.git.nickyc975@zju.edu.cn>
References: <cover.1669126766.git.nickyc975@zju.edu.cn>
 <d51ed0fb457db7a4f9cbb0dbce36d534e22be457.1669126766.git.nickyc975@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <17ab2daa.5b5b.1849fd681f2.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgD3_6vy4nxjLJVgCQ--.57835W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgECB1ZdtcivzQABsT
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

PiAKPiBwcmludGsgYSB3YXJuaW5nIHRvIGluZGljYXRlIHRoYXQgdGhlIGlvIHNjaGVkdWxlciBo
YXMgYmVlbiBzZXQgdG8gbm9uZQo+IGlmIHN3aXRjaGluZyB0byBhIG5ldyBpbyBzY2hlZHVsZXIg
ZmFpbHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSmlubG9uZyBDaGVuIDxuaWNreWM5NzVAemp1LmVk
dS5jbj4KPiAtLS0KPiAgYmxvY2svZWxldmF0b3IuYyB8IDYgKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYmxvY2svZWxldmF0b3IuYyBi
L2Jsb2NrL2VsZXZhdG9yLmMKPiBpbmRleCAwMWFhOWYzOGYyMmUuLjFmYTQ1NzE3YjFkNiAxMDA2
NDQKPiAtLS0gYS9ibG9jay9lbGV2YXRvci5jCj4gKysrIGIvYmxvY2svZWxldmF0b3IuYwo+IEBA
IC02ODMsNiArNjgzLDEyIEBAIGludCBlbGV2YXRvcl9zd2l0Y2goc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEsIHN0cnVjdCBlbGV2YXRvcl90eXBlICpuZXdfZSkKPiAgb3V0X3VuZnJlZXplOgo+ICAJ
YmxrX21xX3VucXVpZXNjZV9xdWV1ZShxKTsKPiAgCWJsa19tcV91bmZyZWV6ZV9xdWV1ZShxKTsK
PiArCj4gKwlpZiAocmV0KSB7Cj4gKwkJcHJfd2FybigiZWx2OiBzd2l0Y2ggdG8gXCIlc1wiIGZh
aWxlZCwgZmFsbGluZyBiYWNrIHRvIFwibm9uZVwiXG4iLAo+ICsJCQluZXdfZS0+ZWxldmF0b3Jf
bmFtZSk7Cj4gKwl9Cj4gKwo+ICAJcmV0dXJuIHJldDsKPiAgfQo+ICAKCkhpLCBKZW5zIQoKVGhp
cyBwYXRjaCBpcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0b3BoLCBidXQgSSBmb3Jnb3QgdG8gYWRkIHRo
ZSBTdWdnZXN0ZWQtYnkKdGFnLiBXb3VsZCB5b3UgcGxlYXNlIGFkZCAiU3VnZ2VzdGVkLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4iCmlmIHlvdSBhcHBseSB0aGUgcGF0Y2g/CgpU
aGFua3MhCkppbmxvbmcgQ2hlbgo=
