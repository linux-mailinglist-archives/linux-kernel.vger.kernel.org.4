Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443155F9723
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiJJDH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJJDHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:07:55 -0400
Received: from m1374.mail.163.com (m1374.mail.163.com [220.181.13.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94C0651A3F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=FPlOv
        6E0d95uizJ1AnrTWWJMw+0UCKD22EtcCEPuDrc=; b=atH7QxfZYsINri0EMxa1M
        MPKYocZw/Phrt2JnTEhsgv+lqkLfN8djn3flKUbywZDfnQEnfzoL4F5Uf7yjihYi
        z/voMcI4z6p54/VlKHLbkgfnSCs2wSIf1E0L4l37oW6XTDpV4YzIR9D0/2IhHOvu
        a12QIJUV5fiErn5XhS6jJc=
Received: from 13667453960$163.com ( [111.48.58.12] ) by
 ajax-webmail-wmsvr74 (Coremail) ; Mon, 10 Oct 2022 11:07:31 +0800 (CST)
X-Originating-IP: [111.48.58.12]
Date:   Mon, 10 Oct 2022 11:07:31 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re:Re: [PATCH] staging: rtl8723bs: fix spelling typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Y0MROo7YMrVoYyZ8@kroah.com>
References: <20221009065647.2635700-1-13667453960@163.com>
 <Y0MROo7YMrVoYyZ8@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <382427df.1d30.183bfdca4b0.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: SsGowAA3w2xzjENjFpdMAA--.52374W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivhOW+1Zce8mgdAAAss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjItMTAtMTAgMDI6MjE6NDYsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gU3VuLCBPY3QgMDksIDIwMjIgYXQgMDI6NTY6NDdQTSArMDgwMCwg
SmlhbmdzaGFuIFlpIHdyb3RlOgo+PiBGcm9tOiBKaWFuZ3NoYW4gWWkgPHlpamlhbmdzaGFuQGt5
bGlub3MuY24+Cj4KPlRoZW4gd2h5IGlzIHRoaXMgYmVpbmcgc2VudCBmcm9tIGEgMTYzLmNvbSBh
ZGRyZXNzPwo+Cgo+V2hhdCBpcyB3cm9uZyB3aXRoIHVzaW5nIHlvdXIgcmVhbCBtYWlsIHNlcnZl
cj8KCgpUaGVyZSBpcyBhIHByb2JsZW0gd2l0aCB0aGUgY29tcGFueSdzIG1haWxib3gsIGFuZCBz
b21ldGltZXMgSSBjYW4ndCByZWNlaXZlIGVtYWlscy4gU28gSSB0ZW1wb3JhcmlseSB1c2UgbXkg
cGVyc29uYWwgbWFpbGJveCB0byBzZW5kIHBhdGNoZXMsIHNvIHRoYXQgSSBjYW4gcmVjZWl2ZSBm
ZWVkYmFjayBmcm9tIHRoZSBjb21tdW5pdHkgaW4gYSB0aW1lbHkgbWFubmVyLgoKCj4+IEBAIC0x
NjU2LDcgKzE2NTYsNyBAQCB1OCBydHdfYzJoX3BhY2tldF93a19jbWQoc3RydWN0IGFkYXB0ZXIg
KnBhZGFwdGVyLCB1OCAqcGJ1ZiwgdTE2IGxlbmd0aCkKPj4gIAlyZXR1cm4gcmVzOwo+PiAgfQo+
PiAgCj4+IC0vKiBkb250IGNhbGwgUi9XIGluIHRoaXMgZnVuY3Rpb24sIGJldWNhc2UgU0RJTyBp
bnRlcnJ1cHQgaGF2ZSBjbGFpbSBob3N0ICovCj4+ICsvKiBkb24ndCBjYWxsIFIvVyBpbiB0aGlz
IGZ1bmN0aW9uLCBiZWNhdXNlIFNESU8gaW50ZXJydXB0IGhhdmUgY2xhaW0gaG9zdCAqLwo+Cj5U
aGF0IGlzIG5vdCBhIHNwZWxsaW5nIGZpeCwgYnV0IHJhdGhlciBhICJwdW5jdHVhdGlvbiIgZml4
IGlmIHlvdSB3YW50Cj50byBiZSBwaWNreSA6KQoKClRoZSBwYXRjaCBkb2VzIHMvYmV1Y2FzZS9i
ZWNhdXNlLyAgYW5kICBzL2RvbnQvZG9uJ3QvLgpGb2xsb3cgRG9jdW1lbnRhdGlvbi9wcm9jZXNz
L2NvZGluZy1zdHlsZS5yc3SjrHNvbWV0aGluZyB3cml0ZSBsaWtlIHRoaXM6Ci0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpLZXJuZWwgZGV2ZWxvcGVycyBsaWtlIHRvIGJl
IHNlZW4gYXMgbGl0ZXJhdGUuIERvIG1pbmQgdGhlIHNwZWxsaW5nCm9mIGtlcm5lbCBtZXNzYWdl
cyB0byBtYWtlIGEgZ29vZCBpbXByZXNzaW9uLiBEbyBub3QgdXNlIGluY29ycmVjdApjb250cmFj
dGlvbnMgbGlrZSBgYGRvbnRgYDsgdXNlIGBgZG8gbm90YGAgb3IgYGBkb24ndGBgIGluc3RlYWQu
IE1ha2UgdGhlCm1lc3NhZ2VzIGNvbmNpc2UsIGNsZWFyLCBhbmQgdW5hbWJpZ3VvdXMuCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTbyBkb2VzIHRoZSBjb21tZW50LgoK
Cj4+ICAvKiBvciBkZWFkbG9jayB3aWxsIGhhcHBlbiBhbmQgY2F1c2Ugc3BlY2lhbC1zeXN0ZW1z
ZXJ2ZXItZGllZCBpbiBhbmRyb2lkICovCj4+ICB1OCBydHdfYzJoX3drX2NtZChzdHJ1Y3QgYWRh
cHRlciAqcGFkYXB0ZXIsIHU4ICpjMmhfZXZ0KQo+PiAgewo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGFnaW5nL3J0bDg3MjNicy9jb3JlL3J0d19lZnVzZS5jIGIvZHJpdmVycy9zdGFnaW5nL3J0
bDg3MjNicy9jb3JlL3J0d19lZnVzZS5jCj4+IGluZGV4IDA2ZTcyN2NlOWNjMi4uNzE4MDA5MTdk
MTMyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvcnRsODcyM2JzL2NvcmUvcnR3X2Vm
dXNlLmMKPj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL3J0bDg3MjNicy9jb3JlL3J0d19lZnVzZS5j
Cj4+IEBAIC0yNzcsNyArMjc3LDcgQEAgYm9vbAkJYlBzZXVkb1Rlc3QpCj4+ICAJcmV0dXJuIGJS
ZXN1bHQ7Cj4+ICB9Cj4+ICAKPj4gLS8qICAxMS8xNi8yMDA4IE1IIFdyaXRlIG9uZSBieXRlIHRv
IHJlYWxkIEVmdXNlLiAqLwo+PiArLyogIDExLzE2LzIwMDggTUggV3JpdGUgb25lIGJ5dGUgdG8g
cmVhbCBFZnVzZS4gKi8KPgo+VGhlIGRhdGUgc2hvdWxkIGp1c3QgYmUgcmVtb3ZlZCBlbnRpcmVs
eSwgcmlnaHQ/CgoKWW91J3JlIHJpZ2h0LgoKCnRoYW5rcywKCgpKaWFuZ3NoYW4gWWkK
