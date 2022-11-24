Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4175637B77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiKXOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKXOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:30:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD21725F2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:30:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5B21F8C3;
        Thu, 24 Nov 2022 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669300204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vUB0FAwIyPQ5hXOpD4DJq5erVm/Vd298FIRS9+/8lYw=;
        b=uJKjIcVfC27xOY/esR+Pi4eI8zLRLiuq/DyPJaixovpqHyw7s3YBo+GjthOwZNjmADCiuT
        xRFyn/rUg4Wr0DVwsebx5ZnbYU5cKhky+4SvVyhQRwQSZuhD/BrQAzikY++Taqi6Clt1p7
        xpyPmoKhkf9JXntywjZw8I820krDGf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D262D13488;
        Thu, 24 Nov 2022 14:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +mXSMet/f2NHSQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 14:30:03 +0000
Message-ID: <fd3ac3cd-7349-6bbd-890a-71a9454ca0b3@suse.com>
Date:   Thu, 24 Nov 2022 15:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] mm: introduce arch_has_hw_nonleaf_pmd_young()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Yu Zhao <yuzhao@google.com>
References: <20221123064510.16225-1-jgross@suse.com>
 <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sMCrUtg0J7YaneHFPNDduHvH"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sMCrUtg0J7YaneHFPNDduHvH
Content-Type: multipart/mixed; boundary="------------QiNlwW9WxaNhnGn33ElZgFZQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Sander Eikelenboom <linux@eikelenboom.it>, Yu Zhao <yuzhao@google.com>
Message-ID: <fd3ac3cd-7349-6bbd-890a-71a9454ca0b3@suse.com>
Subject: Re: [PATCH v2] mm: introduce arch_has_hw_nonleaf_pmd_young()
References: <20221123064510.16225-1-jgross@suse.com>
 <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>
In-Reply-To: <CAMuHMdXfCW_2u28cNiuq-6gyda2xA00+04w5v3NFcukc14RyVw@mail.gmail.com>

--------------QiNlwW9WxaNhnGn33ElZgFZQ
Content-Type: multipart/mixed; boundary="------------nFhc2Ay0VA6YTeack0yJ6RKL"

--------------nFhc2Ay0VA6YTeack0yJ6RKL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDI0LjExLjIyIDE1OjA4LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+
IEhpIErDvHJnZW4sDQo+IA0KPiBPbiBXZWQsIE5vdiAyMywgMjAyMiBhdCA3OjUzIEFNIEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gd3JvdGU6DQo+PiBXaGVuIHJ1bm5pbmcg
YXMgYSBYZW4gUFYgZ3Vlc3RzIGNvbW1pdCBlZWQ5YTMyOGFhMWEgKCJtbTogeDg2OiBhZGQN
Cj4+IENPTkZJR19BUkNIX0hBU19OT05MRUFGX1BNRF9ZT1VORyIpIGNhbiBjYXVzZSBhIHBy
b3RlY3Rpb24gdmlvbGF0aW9uDQo+PiBpbiBwbWRwX3Rlc3RfYW5kX2NsZWFyX3lvdW5nKCk6
DQo+Pg0KPj4gICBCVUc6IHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVz
czogZmZmZjg4ODAwODMzNzRkMA0KPj4gICAjUEY6IHN1cGVydmlzb3Igd3JpdGUgYWNjZXNz
IGluIGtlcm5lbCBtb2RlDQo+PiAgICNQRjogZXJyb3JfY29kZSgweDAwMDMpIC0gcGVybWlz
c2lvbnMgdmlvbGF0aW9uDQo+PiAgIFBHRCAzMDI2MDY3IFA0RCAzMDI2MDY3IFBVRCAzMDI3
MDY3IFBNRCA3ZmVlNTA2NyBQVEUgODAxMDAwMDAwODMzNzA2NQ0KPj4gICBPb3BzOiAwMDAz
IFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkNCj4+ICAgQ1BVOiA3IFBJRDogMTU4IENvbW06IGtz
d2FwZDAgTm90IHRhaW50ZWQgNi4xLjAtcmM1LTIwMjIxMTE4LWRvZmxyKyAjMQ0KPj4gICBS
SVA6IGUwMzA6cG1kcF90ZXN0X2FuZF9jbGVhcl95b3VuZysweDI1LzB4NDANCj4+DQo+PiBU
aGlzIGhhcHBlbnMgYmVjYXVzZSB0aGUgWGVuIGh5cGVydmlzb3IgY2FuJ3QgZW11bGF0ZSBk
aXJlY3Qgd3JpdGVzIHRvDQo+PiBwYWdlIHRhYmxlIGVudHJpZXMgb3RoZXIgdGhhbiBQVEVz
Lg0KPj4NCj4+IFRoaXMgY2FuIGVhc2lseSBiZSBmaXhlZCBieSBpbnRyb2R1Y2luZyBhcmNo
X2hhc19od19ub25sZWFmX3BtZF95b3VuZygpDQo+PiBzaW1pbGFyIHRvIGFyY2hfaGFzX2h3
X3B0ZV95b3VuZygpIGFuZCB0ZXN0IHRoYXQgaW5zdGVhZCBvZg0KPj4gQ09ORklHX0FSQ0hf
SEFTX05PTkxFQUZfUE1EX1lPVU5HLg0KPj4NCj4+IEZpeGVzOiBlZWQ5YTMyOGFhMWEgKCJt
bTogeDg2OiBhZGQgQ09ORklHX0FSQ0hfSEFTX05PTkxFQUZfUE1EX1lPVU5HIikNCj4+IFJl
cG9ydGVkLWJ5OiBTYW5kZXIgRWlrZWxlbmJvb20gPGxpbnV4QGVpa2VsZW5ib29tLml0Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4g
QWNrZWQtYnk6IFl1IFpoYW8gPHl1emhhb0Bnb29nbGUuY29tPg0KPj4gVGVzdGVkLWJ5OiBT
YW5kZXIgRWlrZWxlbmJvb20gPGxpbnV4QGVpa2VsZW5ib29tLml0Pg0KPj4gLS0tDQo+PiBW
MjoNCj4+IC0gY29ycmVjdCBmdW5jdGlvbiBuYW1lIGluIGNvbW1pdCBtZXNzYWdlIHRvIG1h
dGNoIHBhdGNoDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gsIHdoaWNoIGlzIG5vdyBj
b21taXQgM2Y4NWU3MTFkNWFmNGZiNCAoIm1tOg0KPiBpbnRyb2R1Y2UgYXJjaF9oYXNfaHdf
bm9ubGVhZl9wbWRfeW91bmcoKSIpIGluIG5leHQtMjAyMjExMjQuDQo+IA0KPiBub3JlcGx5
QGVsbGVybWFuLmlkLmF1IHJlcG9ydGVkIGEgYnVpbGQgZmFpbHVyZSBmb3IgbTY4ay9hbGxt
b2Rjb25maWcsDQo+IHdoaWNoIEkgaGF2ZSBiaXNlY3RlZCB0byB0aGlzIGNvbW1pdC4NCj4g
DQo+PiAtLS0gYS9tbS92bXNjYW4uYw0KPj4gKysrIGIvbW0vdm1zY2FuLmMNCj4gDQo+PiBA
QCAtNDA3MywxNCArNDA3MywxNCBAQCBzdGF0aWMgdm9pZCB3YWxrX3BtZF9yYW5nZShwdWRf
dCAqcHVkLCB1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCwNCj4+ICAg
I2VuZGlmDQo+PiAgICAgICAgICAgICAgICAgIHdhbGstPm1tX3N0YXRzW01NX05PTkxFQUZf
VE9UQUxdKys7DQo+Pg0KPj4gLSNpZmRlZiBDT05GSUdfQVJDSF9IQVNfTk9OTEVBRl9QTURf
WU9VTkcNCj4+IC0gICAgICAgICAgICAgICBpZiAoZ2V0X2NhcChMUlVfR0VOX05PTkxFQUZf
WU9VTkcpKSB7DQo+PiArICAgICAgICAgICAgICAgaWYgKGFyY2hfaGFzX2h3X25vbmxlYWZf
cG1kX3lvdW5nKCkgJiYNCj4+ICsgICAgICAgICAgICAgICAgICAgZ2V0X2NhcChMUlVfR0VO
X05PTkxFQUZfWU9VTkcpKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFw
bWRfeW91bmcodmFsKSkNCj4gDQo+IG1tL3Ztc2Nhbi5jOjQxMDI6MzA6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbg0KPiAncG1kX3lvdW5nJzsgZGlkIHlvdSBt
ZWFuICdwdGVfeW91bmcnPw0KPiBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJh
dGlvbl0NCj4gDQo+IHBtZF95b3VuZygpIHNlZW1zIHRvIGJlIGRlZmluZWQgb25seSBvbiBh
IGhhbmRmdWwgb2YgYXJjaGl0ZWN0dXJlcy4NCg0KV2hhdCB3b3VsZCBiZSB0aGUgcHJlZmVy
cmVkIGZpeCBmb3IgdGhhdD8NCg0KSSBjb3VsZCBvZmZlcjoNCg0KLSB1c2UgVjEgb2YgdGhl
IHBhdGNoDQotIGFkZCB0aGUgI2lmZGVmcyBhZ2FpbiB0byB0aGlzIHBhdGNoICh3aGljaCB3
b3VsZCBiZSBraW5kIG9mIHdlaXJkKQ0KLSB1c2UgdGhlIGF0dGFjaGVkIHBhdGNoDQoNCg0K
SnVlcmdlbg0KDQo=
--------------nFhc2Ay0VA6YTeack0yJ6RKL
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mm-add-dummy-pmd_young-for-architectures-not-having-.patch"
Content-Disposition: attachment;
 filename*0="0001-mm-add-dummy-pmd_young-for-architectures-not-having-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5ZjE2Yzc1ZGZiZmY5OTRjMDFhMDAzZTQ3MDFmNWJkZDQ4Y2JmYzNmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IFRodSwgMjQgTm92IDIwMjIgMTU6MTg6MDMgKzAxMDAKU3ViamVjdDogW1BBVENI
XSBtbTogYWRkIGR1bW15IHBtZF95b3VuZygpIGZvciBhcmNoaXRlY3R1cmVzIG5vdCBoYXZp
bmcgaXQKCkluIG9yZGVyIHRvIGF2b2lkICNpZmRlZmZlcnkgYWRkIGEgZHVtbXkgcG1kX3lv
dW5nKCkgaW1wbGVtZW50YXRpb24gYXMKYSBmYWxsYmFjay4KClNpZ25lZC1vZmYtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KLS0tCiBhcmNoL2xvb25nYXJjaC9pbmNs
dWRlL2FzbS9wZ3RhYmxlLmggfCAxICsKIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9wZ3RhYmxl
LmggICAgICB8IDEgKwogYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgIHwg
MSArCiBhcmNoL3MzOTAvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgfCAxICsKIGFyY2gv
c3BhcmMvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oICB8IDEgKwogYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGd0YWJsZS5oICAgICAgIHwgMSArCiBpbmNsdWRlL2xpbnV4L3BndGFibGUuaCAg
ICAgICAgICAgICAgfCA3ICsrKysrKysKIDcgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3BndGFibGUu
aCBiL2FyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3BndGFibGUuaAppbmRleCA5NDY3MDRi
ZWU1OTkuLjEwZTBiZDkwMDllMiAxMDA2NDQKLS0tIGEvYXJjaC9sb29uZ2FyY2gvaW5jbHVk
ZS9hc20vcGd0YWJsZS5oCisrKyBiL2FyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3BndGFi
bGUuaApAQCAtNDgyLDYgKzQ4Miw3IEBAIHN0YXRpYyBpbmxpbmUgcG1kX3QgcG1kX21rZGly
dHkocG1kX3QgcG1kKQogCXJldHVybiBwbWQ7CiB9CiAKKyNkZWZpbmUgcG1kX3lvdW5nIHBt
ZF95b3VuZwogc3RhdGljIGlubGluZSBpbnQgcG1kX3lvdW5nKHBtZF90IHBtZCkKIHsKIAly
ZXR1cm4gISEocG1kX3ZhbChwbWQpICYgX1BBR0VfQUNDRVNTRUQpOwpkaWZmIC0tZ2l0IGEv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvbWlwcy9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLmgKaW5kZXggNmNhZWMzODZhZDJmLi40Njc4NjI3NjczZGYgMTAwNjQ0Ci0t
LSBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKKysrIGIvYXJjaC9taXBzL2lu
Y2x1ZGUvYXNtL3BndGFibGUuaApAQCAtNjIyLDYgKzYyMiw3IEBAIHN0YXRpYyBpbmxpbmUg
cG1kX3QgcG1kX21rZGlydHkocG1kX3QgcG1kKQogCXJldHVybiBwbWQ7CiB9CiAKKyNkZWZp
bmUgcG1kX3lvdW5nIHBtZF95b3VuZwogc3RhdGljIGlubGluZSBpbnQgcG1kX3lvdW5nKHBt
ZF90IHBtZCkKIHsKIAlyZXR1cm4gISEocG1kX3ZhbChwbWQpICYgX1BBR0VfQUNDRVNTRUQp
OwpkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggYi9hcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaAppbmRleCA3ZWM5MzY5MTBhOTYuLjkyZWMy
ZDlkNzI3MyAxMDA2NDQKLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgK
KysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKQEAgLTYwMCw2ICs2MDAs
NyBAQCBzdGF0aWMgaW5saW5lIGludCBwbWRfZGlydHkocG1kX3QgcG1kKQogCXJldHVybiBw
dGVfZGlydHkocG1kX3B0ZShwbWQpKTsKIH0KIAorI2RlZmluZSBwbWRfeW91bmcgcG1kX3lv
dW5nCiBzdGF0aWMgaW5saW5lIGludCBwbWRfeW91bmcocG1kX3QgcG1kKQogewogCXJldHVy
biBwdGVfeW91bmcocG1kX3B0ZShwbWQpKTsKZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9pbmNs
dWRlL2FzbS9wZ3RhYmxlLmggYi9hcmNoL3MzOTAvaW5jbHVkZS9hc20vcGd0YWJsZS5oCmlu
ZGV4IGYxY2I5MzkxMTkwZC4uMTFlOTAxMjg2NDE0IDEwMDY0NAotLS0gYS9hcmNoL3MzOTAv
aW5jbHVkZS9hc20vcGd0YWJsZS5oCisrKyBiL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3Rh
YmxlLmgKQEAgLTc2Myw2ICs3NjMsNyBAQCBzdGF0aWMgaW5saW5lIGludCBwbWRfZGlydHko
cG1kX3QgcG1kKQogCXJldHVybiAocG1kX3ZhbChwbWQpICYgX1NFR01FTlRfRU5UUllfRElS
VFkpICE9IDA7CiB9CiAKKyNkZWZpbmUgcG1kX3lvdW5nIHBtZF95b3VuZwogc3RhdGljIGlu
bGluZSBpbnQgcG1kX3lvdW5nKHBtZF90IHBtZCkKIHsKIAlyZXR1cm4gKHBtZF92YWwocG1k
KSAmIF9TRUdNRU5UX0VOVFJZX1lPVU5HKSAhPSAwOwpkaWZmIC0tZ2l0IGEvYXJjaC9zcGFy
Yy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmggYi9hcmNoL3NwYXJjL2luY2x1ZGUvYXNtL3Bn
dGFibGVfNjQuaAppbmRleCBhNzc5NDE4Y2ViYTkuLjNiYzk3MzZiZGRiMSAxMDA2NDQKLS0t
IGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmgKKysrIGIvYXJjaC9zcGFy
Yy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmgKQEAgLTY5Myw2ICs2OTMsNyBAQCBzdGF0aWMg
aW5saW5lIHVuc2lnbmVkIGxvbmcgcG1kX2RpcnR5KHBtZF90IHBtZCkKIAlyZXR1cm4gcHRl
X2RpcnR5KHB0ZSk7CiB9CiAKKyNkZWZpbmUgcG1kX3lvdW5nIHBtZF95b3VuZwogc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBsb25nIHBtZF95b3VuZyhwbWRfdCBwbWQpCiB7CiAJcHRlX3Qg
cHRlID0gX19wdGUocG1kX3ZhbChwbWQpKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaAppbmRl
eCA1MDU5Nzk5YmViZTMuLjFkNTVhZjhkODJiOSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGd0YWJsZS5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUu
aApAQCAtMTM5LDYgKzEzOSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHBtZF9kaXJ0eShwbWRf
dCBwbWQpCiAJcmV0dXJuIHBtZF9mbGFncyhwbWQpICYgX1BBR0VfRElSVFk7CiB9CiAKKyNk
ZWZpbmUgcG1kX3lvdW5nIHBtZF95b3VuZwogc3RhdGljIGlubGluZSBpbnQgcG1kX3lvdW5n
KHBtZF90IHBtZCkKIHsKIAlyZXR1cm4gcG1kX2ZsYWdzKHBtZCkgJiBfUEFHRV9BQ0NFU1NF
RDsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oIGIvaW5jbHVkZS9saW51
eC9wZ3RhYmxlLmgKaW5kZXggYTEwOGI2MGE2OTYyLi42YjBkNTkyNjliMzMgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCisrKyBiL2luY2x1ZGUvbGludXgvcGd0YWJs
ZS5oCkBAIC0xNjUsNiArMTY1LDEzIEBAIHN0YXRpYyBpbmxpbmUgcHRlX3QgKnZpcnRfdG9f
a3B0ZSh1bnNpZ25lZCBsb25nIHZhZGRyKQogCXJldHVybiBwbWRfbm9uZSgqcG1kKSA/IE5V
TEwgOiBwdGVfb2Zmc2V0X2tlcm5lbChwbWQsIHZhZGRyKTsKIH0KIAorI2lmbmRlZiBwbWRf
eW91bmcKK3N0YXRpYyBpbmxpbmUgaW50IHBtZF95b3VuZyhwbWRfdCBwbWQpCit7CisJcmV0
dXJuIDA7Cit9CisjZW5kaWYKKwogI2lmbmRlZiBfX0hBVkVfQVJDSF9QVEVQX1NFVF9BQ0NF
U1NfRkxBR1MKIGV4dGVybiBpbnQgcHRlcF9zZXRfYWNjZXNzX2ZsYWdzKHN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hLAogCQkJCSB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHB0ZV90ICpw
dGVwLAotLSAKMi4zNS4zCgo=
--------------nFhc2Ay0VA6YTeack0yJ6RKL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------nFhc2Ay0VA6YTeack0yJ6RKL--

--------------QiNlwW9WxaNhnGn33ElZgFZQ--

--------------sMCrUtg0J7YaneHFPNDduHvH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/f+sFAwAAAAAACgkQsN6d1ii/Ey8V
/wgAmxTBHE0+T+DwrzC7aNfqQcE+GxvnZZSoEgWehHuzQHqs/o6GjbVROzXcLLwi73zGPi1boGB+
UGIKx/KP+5RcYvOBdL1Yja98vb5E9ACvCCZVwZuZei+nn9b02BUNCqfWjud75JtQo7cRoc8U3fvI
ETh+wp5JnFPfhp5z6pRZlSN5uT7vtQElAMhPX5RCJEPn/bmbkFWdrrxhpK8qozI8/abNMddMi98r
PXAvIHYKIwi110gq/RSleIq7089dS61iw6vyttbtSZ1eTYd/LdQk1s5s2aBVkyhacnb/EfYK9UQV
ecr0yVQw3cD+vQRyZWTms0uu1wjPEHVUtC2xiWYtjQ==
=uPGy
-----END PGP SIGNATURE-----

--------------sMCrUtg0J7YaneHFPNDduHvH--
