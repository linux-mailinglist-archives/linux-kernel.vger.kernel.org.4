Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C16E5F25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDRKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDRKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:49:30 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46258E49;
        Tue, 18 Apr 2023 03:49:28 -0700 (PDT)
Received: from u202112136$hust.edu.cn ( [10.11.70.171] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 18 Apr 2023 18:48:29 +0800 (GMT+08:00)
X-Originating-IP: [10.11.70.171]
Date:   Tue, 18 Apr 2023 18:48:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2O6Ziz?= <u202112136@hust.edu.cn>
To:     "greg kroah-hartman" <gregkh@linuxfoundation.org>
Cc:     "felipe balbi" <balbi@kernel.org>,
        "sergey shtylyov" <s.shtylyov@omp.ru>,
        "dongliang mu" <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        hust-os-kernel-patches@googlegroups.com
Subject: Re: Re: [PATCH] usb: phy: phy-tahvo: fix memory leak in
 tahvo_usb_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <2023041832-parakeet-claim-b458@gregkh>
References: <20230418090758.18756-1-lidaxian@hust.edu.cn>
 <2023041832-parakeet-claim-b458@gregkh>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7aadd2ae.3f01f.18793faf0c3.Coremail.u202112136@hust.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: FgEQrACnuAl9dT5kFb34Ag--.41571W
X-CM-SenderInfo: rxsqjiirsrjlo6kx23oohg3hdfq/1tbiAQsFE17Em5GfHwAAsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiR3JlZyBLcm9haC1IYXJ0
bWFuIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4gU2VudCBUaW1lOiAyMDIzLTA0LTE4
IDE3OjE5OjEyIChUdWVzZGF5KQo+IFRvOiAiTGkgWWFuZyIgPGxpZGF4aWFuQGh1c3QuZWR1LmNu
Pgo+IENjOiAiRmVsaXBlIEJhbGJpIiA8YmFsYmlAa2VybmVsLm9yZz4sICJTZXJnZXkgU2h0eWx5
b3YiIDxzLnNodHlseW92QG9tcC5ydT4sICJEb25nbGlhbmcgTXUiIDxkem05MUBodXN0LmVkdS5j
bj4sIGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcKPiBTdWJqZWN0OiBSZTogW1BBVENIXSB1c2I6IHBoeTogcGh5LXRhaHZvOiBmaXggbWVtb3J5
IGxlYWsgaW4gdGFodm9fdXNiX3Byb2JlKCkKPiAKPiBPbiBUdWUsIEFwciAxOCwgMjAyMyBhdCAw
NTowNzo1N1BNICswODAwLCBMaSBZYW5nIHdyb3RlOgo+ID4gU21hdGNoIHJlcG9ydHM6Cj4gPiBk
cml2ZXJzL3VzYi9waHkvcGh5LXRhaHZvLmM6IHRhaHZvX3VzYl9wcm9iZSgpCj4gPiB3YXJuOiBt
aXNzaW5nIHVud2luZCBnb3RvPwo+ID4gCj4gPiBBZnRlciBnZXRpbmcgaXJxLCBpZiByZXQgPCAw
LCBpdCB3aWxsIHJldHVybiB3aXRob3V0IGVycm9yIGhhbmRsaW5nIHRvCj4gPiBmcmVlIG1lbW9y
eS4KPiA+IEp1c3QgYWRkIGVycm9yIGhhbmRsaW5nIHRvIGZpeCB0aGlzIHByb2JsZW0uCj4gPiAK
PiA+IEZpeGVzOiAwZDQ1YTEzNzNlNjYgKCJ1c2I6IHBoeTogdGFodm86IGFkZCBJUlEgY2hlY2si
KQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgWWFuZyA8bGlkYXhpYW5AaHVzdC5lZHUuY24+Cj4gPiBS
ZXZpZXdlZC1ieTogRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4KPiA+IC0tLQo+ID4g
VGhlIGlzc3VlIGlzIGZvdW5kIGJ5IHN0YXRpYyBhbmFseXNpcywgYW5kIHRoZSBwYXRjaCByZW1h
aW5zIHVudGVzdC4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvdXNiL3BoeS9waHktdGFodm8uYyB8IDcg
KysrKystLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9waHkvcGh5LXRhaHZvLmMgYi9k
cml2ZXJzL3VzYi9waHkvcGh5LXRhaHZvLmMKPiA+IGluZGV4IGYyZDJjYzU4NmM1Yi4uMTg0YTVm
M2Q3NDczIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy91c2IvcGh5L3BoeS10YWh2by5jCj4gPiAr
KysgYi9kcml2ZXJzL3VzYi9waHkvcGh5LXRhaHZvLmMKPiA+IEBAIC0zOTAsOCArMzkwLDExIEBA
IHN0YXRpYyBpbnQgdGFodm9fdXNiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cj4gPiAgCWRldl9zZXRfZHJ2ZGF0YSgmcGRldi0+ZGV2LCB0dSk7Cj4gPiAgCj4gPiAgCXR1LT5p
cnEgPSByZXQgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOwo+ID4gLQlpZiAocmV0IDwgMCkK
PiA+IC0JCXJldHVybiByZXQ7Cj4gPiArCWlmIChyZXQgPCAwKSB7Cj4gPiArCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJjb3VsZCBub3QgZ2V0IGlycTogJWRcbiIsCj4gPiArCQkJCXJldCk7Cj4gCj4g
V2h5IHByaW50IHRoaXMgb3V0PyAgQW5kIHdoeSB0aGUgb2RkIGxpbmUtd3JhcHBpbmc/Cj4gCj4g
dGhhbmtzLAo+IAo+IGdyZWcgay1oCkZvciB0aGUgZmlyc3QgcXVlc3Rpb24sIEkgYW0ganVzdCBl
bXVsYXRpbmcgdGhlIGNvZGluZyBzdHlsZSBvZiB0aGUgb3JpZ2luYWwgYXV0aG9yIHdobyBvdXRw
dXRzIGNvcnJlc3BvbmRpbmcgaW5mb3JtYXRpb24gYWZ0ZXIgZWFjaCBlcnJvci4gSWYgdGhlcmUg
aXMgYW55dGhpbmcgdW5yZWFzb25hYmxlIGFib3V0IGRvaW5nIHNvLCBwbGVhc2UgbGV0IG1lIGtu
b3cuIEFzIGZvciB0aGUgc2Vjb25kIHF1ZXN0aW9uLCBpdCdzIG15IG1pc3Rha2UgYW5kIEkgd2ls
bCBjb3JyZWN0IGl0IGltbWVkaWF0ZWx5LgoKcmVncmFkcywKTGkgWWFuZw==
