Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5856EC80C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDXIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjDXIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:46:13 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B79610D;
        Mon, 24 Apr 2023 01:46:11 -0700 (PDT)
Received: from lihuya$hust.edu.cn ( [172.16.0.254] ) by ajax-webmail-app2
 (Coremail) ; Mon, 24 Apr 2023 16:45:14 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Mon, 24 Apr 2023 16:45:14 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5qKB5a6H6Iiq?= <lihuya@hust.edu.cn>
To:     "thinh nguyen" <thinh.nguyen@synopsys.com>
Cc:     "greg kroah-hartman" <gregkh@linuxfoundation.org>,
        "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] usb: dwc3: remove dead code in dwc3_otg_get_irq
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230324182853.rbguxi2lng2mhm3s@synopsys.com>
References: <20230323053946.53094-1-lihuya@hust.edu.cn>
 <20230324182853.rbguxi2lng2mhm3s@synopsys.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4d6dd98f.41e10.187b27043ca.Coremail.lihuya@hust.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: GQEQrAAXaJWaQUZkR_i_Aw--.55381W
X-CM-SenderInfo: bpsqjjaxrxlko6kx23oohg3hdfq/1tbiAQsLAl7Em5Oi2wABsp
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiVGhpbmggTmd1eWVuIiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4KPiBTZW50IFRpbWU6IDIwMjMtMDMtMjUgMDI6Mjg6NTYg
KFNhdHVyZGF5KQo+IFRvOiBsaWh1eWEgPGxpaHV5YUBodXN0LmVkdS5jbj4KPiBDYzogIlRoaW5o
IE5ndXllbiIgPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+LCAiR3JlZyBLcm9haC1IYXJ0bWFu
IiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+LCAiZHptOTFAaHVzdC5lZHUuY24iIDxkem05
MUBodXN0LmVkdS5jbj4sICJodXN0LW9zLWtlcm5lbC1wYXRjaGVzQGdvb2dsZWdyb3Vwcy5jb20i
IDxodXN0LW9zLWtlcm5lbC1wYXRjaGVzQGdvb2dsZWdyb3Vwcy5jb20+LCAibGludXgtdXNiQHZn
ZXIua2VybmVsLm9yZyIgPGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc+LCAibGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZyIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Cj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiByZW1vdmUgZGVhZCBjb2RlIGluIGR3YzNfb3RnX2dl
dF9pcnEKPiAKPiBPbiBUaHUsIE1hciAyMywgMjAyMywgbGlodXlhIHdyb3RlOgo+ID4gcGxhdGZv
cm1fZ2V0X2lycSgpIG9ubHkgcmV0dXJuIG5vbi16ZXJvIGlycSBudW1iZXIgb24gc3VjY2Vzcywg
b3IKPiA+IG5lZ2F0aXZlIGVycm9yIG51bWJlciBvbiBmYWlsdXJlLgo+ID4gCj4gPiBUaGVyZSBp
cyBubyBuZWVkIHRvIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgcGxhdGZvcm1fZ2V0X2lycSgp
Cj4gPiB0byBkZXRlcm1pbmUgdGhlIHJldHVybiB2YWx1ZSBvZiBkd2MzX290Z19nZXRfaXJxKCks
IHJlbW92aW5nCj4gPiB0aGVtIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4KPiA+IAo+ID4gU2lnbmVk
LW9mZi1ieTogbGlodXlhIDxsaWh1eWFAaHVzdC5lZHUuY24+Cj4gPiAtLS0KPiA+ICBkcml2ZXJz
L3VzYi9kd2MzL2RyZC5jIHwgNSAtLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9u
cygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kcmQuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZHJkLmMKPiA+IGluZGV4IDAzOWJmMjQxNzY5YS4uYzJlMDk3MDAyMTJkIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kcmQuYwo+ID4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9kcmQuYwo+ID4gQEAgLTE1NCwxMSArMTU0LDYgQEAgc3RhdGljIGludCBkd2MzX290
Z19nZXRfaXJxKHN0cnVjdCBkd2MzICpkd2MpCj4gPiAgCQlnb3RvIG91dDsKPiA+ICAKPiA+ICAJ
aXJxID0gcGxhdGZvcm1fZ2V0X2lycShkd2MzX3BkZXYsIDApOwo+ID4gLQlpZiAoaXJxID4gMCkK
PiA+IC0JCWdvdG8gb3V0Owo+ID4gLQo+ID4gLQlpZiAoIWlycSkKPiA+IC0JCWlycSA9IC1FSU5W
QUw7Cj4gPiAgCj4gPiAgb3V0Ogo+ID4gIAlyZXR1cm4gaXJxOwo+ID4gLS0gCj4gPiAyLjM0LjEK
PiA+IAo+IAo+IEFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+Cj4gCj4gVGhhbmtzLAo+IFRoaW5oCgpIaSBUaGluaCwKCkknbSBjaGVja2luZyBpbiBhYm91
dCBteSBwYXRjaCBzdWJtaXNzaW9uIGZvciB1c2IgZHdjMyB0aGF0IHdhcyAKImFjaydlZCIgb24g
My8yNSwgYnV0IGhhc24ndCBiZWVuIG1lcmdlZCBpbnRvIHRoZSBzdWJ0cmVlIHlldC4gCkNvdWxk
IHlvdSBwbGVhc2UgcHJvdmlkZSBtZSB3aXRoIGFuIHVwZGF0ZSBvbiBpdHMgc3RhdHVzIGFuZCBs
ZXQgCm1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMgb3IgY29uY2VybnMgdGhhdCBuZWVk
IHRvIGJlIGFkZHJlc3NlZD8K
