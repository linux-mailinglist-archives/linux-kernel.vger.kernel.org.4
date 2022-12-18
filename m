Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA264FEF6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 14:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLRNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 08:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLRNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 08:12:11 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E26442BC0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 05:12:07 -0800 (PST)
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 18 Dec 2022 21:11:51
 +0800 (GMT+08:00)
X-Originating-IP: [10.162.98.155]
Date:   Sun, 18 Dec 2022 21:11:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, laforge@gnumonks.org, arnd@arndb.de,
        linux@dominikbrodowski.net, baijiaju1990@gmail.com
Subject: Re: [PATCH] Revert "char: pcmcia: cm4000_cs: Replace mdelay with
 usleep_range in set_protocol"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <Y5783zWoitPPyoOG@kroah.com>
References: <20221128053915.90474-1-duoming@zju.edu.cn>
 <Y5783zWoitPPyoOG@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42c270ca.4dcb6.185255cb762.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDn70+XEZ9jhFBnCQ--.32528W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgQIAVZdtc6J+QARse
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

SGVsbG8sCgpPbiBTdW4sIDE4IERlYyAyMDIyIDEyOjQzOjI3ICswMTAwIEdyZWcgS0ggd3JvdGU6
Cgo+IE9uIE1vbiwgTm92IDI4LCAyMDIyIGF0IDAxOjM5OjE1UE0gKzA4MDAsIER1b21pbmcgWmhv
dSB3cm90ZToKPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYmU4MjZhZGE1MmYxZmNhYmVkNWI1MjE3
Yzk0NjA5ZWJmNTk2NzIxMS4KPiA+IAo+ID4gVGhlIGZ1bmN0aW9uIG1vbml0b3JfY2FyZCgpIGlz
IGEgdGltZXIgaGFuZGxlciB0aGF0IHJ1bnMgaW4gYW4KPiA+IGF0b21pYyBjb250ZXh0LCBidXQg
aXQgY2FsbHMgdXNsZWVwX3JhbmdlKCkgdGhhdCBjYW4gc2xlZXAuCj4gPiBBcyBhIHJlc3VsdCwg
dGhlIHNsZWVwLWluLWF0b21pYy1jb250ZXh0IGJ1Z3Mgd2lsbCBoYXBwZW4uCj4gPiBUaGUgcHJv
Y2VzcyBpcyBzaG93biBiZWxvdzoKPiA+IAo+ID4gICAgIChhdG9taWMgY29udGV4dCkKPiA+IG1v
bml0b3JfY2FyZCgpCj4gPiAgIHNldF9wcm90b2NvbCgpCj4gPiAgICAgdXNsZWVwX3JhbmdlKCkg
Ly9zbGVlcAo+ID4gCj4gPiBUaGUgb3JpZ2luIGNvbW1pdCBjMTk4NmVlOWJlYTMgKCJbUEFUQ0hd
IE5ldyBPbW5pa2V5IENhcmRtYW4KPiA+IDQwMDAgZHJpdmVyIikgd29ya3MgZmluZS4KPiA+IAo+
ID4gRml4ZXM6IGJlODI2YWRhNTJmMSAoImNoYXI6IHBjbWNpYTogY200MDAwX2NzOiBSZXBsYWNl
IG1kZWxheSB3aXRoIHVzbGVlcF9yYW5nZSBpbiBzZXRfcHJvdG9jb2wiKQo+ID4gU2lnbmVkLW9m
Zi1ieTogRHVvbWluZyBaaG91IDxkdW9taW5nQHpqdS5lZHUuY24+Cj4gPiAtLS0KPiA+ICBkcml2
ZXJzL2NoYXIvcGNtY2lhL2NtNDAwMF9jcy5jIHwgNCArKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2hhci9wY21jaWEvY200MDAwX2NzLmMgYi9kcml2ZXJzL2NoYXIvcGNtY2lhL2NtNDAw
MF9jcy5jCj4gPiBpbmRleCBhZGFlYzhmZDRiMS4uNzEyNWY4OTUzMWYgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL2NoYXIvcGNtY2lhL2NtNDAwMF9jcy5jCj4gPiArKysgYi9kcml2ZXJzL2NoYXIv
cGNtY2lhL2NtNDAwMF9jcy5jCj4gPiBAQCAtNTI5LDcgKzUyOSw3IEBAIHN0YXRpYyBpbnQgc2V0
X3Byb3RvY29sKHN0cnVjdCBjbTQwMDBfZGV2ICpkZXYsIHN0cnVjdCBwdHNyZXEgKnB0c3JlcSkK
PiA+ICAJCQlERUJVR1AoNSwgZGV2LCAiTnVtUmVjQnl0ZXMgaXMgdmFsaWRcbiIpOwo+ID4gIAkJ
CWJyZWFrOwo+ID4gIAkJfQo+ID4gLQkJdXNsZWVwX3JhbmdlKDEwMDAwLCAxMTAwMCk7Cj4gPiAr
CQltZGVsYXkoMTApOwo+ID4gIAl9Cj4gPiAgCWlmIChpID09IDEwMCkgewo+ID4gIAkJREVCVUdQ
KDUsIGRldiwgIlRpbWVvdXQgd2FpdGluZyBmb3IgTnVtUmVjQnl0ZXMgZ2V0dGluZyAiCj4gPiBA
QCAtNTQ5LDcgKzU0OSw3IEBAIHN0YXRpYyBpbnQgc2V0X3Byb3RvY29sKHN0cnVjdCBjbTQwMDBf
ZGV2ICpkZXYsIHN0cnVjdCBwdHNyZXEgKnB0c3JlcSkKPiA+ICAJCQl9Cj4gPiAgCQkJYnJlYWs7
Cj4gPiAgCQl9Cj4gPiAtCQl1c2xlZXBfcmFuZ2UoMTAwMDAsIDExMDAwKTsKPiA+ICsJCW1kZWxh
eSgxMCk7Cj4gCj4gQ2FuIHlvdSBhZGQgYSBjb21tZW50IHRoYXQgc2F5cyAiY2FuIG5vdCBzbGVl
cCBhcyB0aGlzIGlzIGF0b21pYwo+IGNvbnRleHQiIGZvciB0aGVzZSBjYWxscyBzbyB0aGF0IHRo
aXMgZG9lc24ndCBnZXQgY2hhbmdlZCBhZ2FpbiBpbiB0aGUKPiBmdXR1cmU/CgpUaGFuayB5b3Ug
Zm9yIHlvdXIgcmVwbHkgYW5kIHN1Z2dlc3Rpb25zISBJIHdpbGwgYWRkIHRoZSBjb21tZW50IGFu
ZCByZS1zZW5kIHRoaXMgcGF0Y2guCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=
