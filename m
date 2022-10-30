Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24B9612909
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ3IUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ3IUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:20:08 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C13CD33E;
        Sun, 30 Oct 2022 01:20:05 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 30 Oct 2022 16:19:49
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date:   Sun, 30 Oct 2022 16:19:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jinlong Chen" <nickyc975@zju.edu.cn>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 3/3] block: hide back blk_freeze_queue_start
 and export its blk-mq alias
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221030074010.GD4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn>
 <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
 <20221030074010.GD4131@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBXXP2lM15jsZ+fBw--.49559W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKYKQAAsd
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

PiBPbiBTdW4sIE9jdCAzMCwgMjAyMiBhdCAwMToyNjo0NlBNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBibGtfZnJlZXplX3F1ZXVlX3N0YXJ0IGlzIHVzZWQgaW50ZXJuYWxseSBmb3Ig
dW5pdmVyc2FsIHF1ZXVlIGRyYWluaW5nIGFuZAo+ID4gZXh0ZXJuYWxseSBmb3IgYmxrLW1xIHNw
ZWNpZmljIHF1ZXVlIGZyZWV6aW5nLiBLZWVwIHRoZSBub24tYmxrLW1xIG5hbWUKPiA+IHByaXZh
dGUgYW5kIGV4cG9ydCBhIGJsay1tcSBhbGlhcyB0byB1c2Vycy4KPiAKPiBJIHJlYWxseSBkb24n
dCBzZWUgdGhlIHBvaW50IGhlcmUuICBFdmVudHVhbGx5IGFsbCBvZiB0aGUgZnJlZXppbmcKPiBz
aG91bGQgbW92ZSBvdXQgb2YgdGhlIG1xIG5hbWVzcGFjZS4gIEJ1dCB0aGF0IGdpdmVuIHRoYXQg
d2UgaGF2ZQo+IGFjdHVhbCB0ZWNobmljYWwgd29yayBwZW5kaW5nIGhlcmUgSSdkIHN1Z2dlc3Qg
dG8ganVzdCBsZWF2ZSBpdCBhbG9uZQo+IGZvciBub3csIGFuZCBqdXN0IHJlc3BpbiBhIHZlcnNp
b24gb2YgcGF0Y2ggMSB3aXRob3V0IHRoZSBwb2ludGxlc3MKPiBjb21tZW50LgoKSSBhZ3JlZSB0
aGF0IHRoZSBmcmVlemluZyBzdHVmZiAobWF5YmUgYWxzbyB0aGUgcXVpZXNjaW5nIHN0dWZmKSBz
aG91bGQKbW92ZSBvdXQgb2YgdGhlIG1xIG5hbWVzcGFjZS4gSWYgbm93IGlzIG5vdCB0aGUgcHJv
cGVyIHRpbWUsIEknbGwgbGVhdmUKdGhlbSBhbG9uZS4gSSdsbCByZXNlbmQgcGF0Y2ggMSBhbG9u
ZSB3aXRob3V0IHRoZSBjb21tZW50LgoKVGhhbmtzIQpKaW5sb25nIENoZW4K
