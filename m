Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D7D6947B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBMOHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBMOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:07:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45AADBF4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:07:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C495D1F37E;
        Mon, 13 Feb 2023 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676297227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVc3CMeoFC6TcLJLM/TdBG2vyLqosoP+DMqqkFhBfcw=;
        b=NfrbRruMg9u1fYFG3I/9NAg4o+YLqMwoOoLj5KcFUwMtTgS8JXQaxpjHUFCTeaxDiBoFDe
        sR+sMh0wr0BaGUFOucDIE6oJ8Ag1sfNpwSQJy/RPvCZgpquxbCtntqsK1KSPUoO7y4sZDB
        pEBnRbMBbcoZuSPXHiHiVEa7nxx0d0g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71C9E138E6;
        Mon, 13 Feb 2023 14:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w6Y4GgtE6mNgdgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 14:07:07 +0000
Message-ID: <6257114d-a957-f586-145c-d2a885417360@suse.com>
Date:   Mon, 13 Feb 2023 15:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
In-Reply-To: <Y+ohfE/wICFKO/93@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bekH4HypIReNX3yMbA68bT3Y"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bekH4HypIReNX3yMbA68bT3Y
Content-Type: multipart/mixed; boundary="------------BVWhzXUGOnlGUuVb87B33N4t";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6257114d-a957-f586-145c-d2a885417360@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
In-Reply-To: <Y+ohfE/wICFKO/93@zn.tnic>

--------------BVWhzXUGOnlGUuVb87B33N4t
Content-Type: multipart/mixed; boundary="------------J90A00f0z4eeYlNwP2uO69AW"

--------------J90A00f0z4eeYlNwP2uO69AW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTI6MzksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBG
ZWIgMDksIDIwMjMgYXQgMDg6MjI6MTRBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFdoZW4gcnVubmluZyB2aXJ0dWFsaXplZCwgTVRSUiBhY2Nlc3MgY2FuIGJlIHJlZHVj
ZWQgKGUuZy4gaW4gWGVuIFBWDQo+PiBndWVzdHMgb3Igd2hlbiBydW5uaW5nIGFzIGEgU0VW
LVNOUCBndWVzdCB1bmRlciBIeXBlci1WKS4gVHlwaWNhbGx5DQo+PiB0aGUgaHlwZXJ2aXNv
ciB3aWxsIHJlc2V0IHRoZSBNVFJSIGZlYXR1cmUgaW4gY3B1aWQgZGF0YSwgcmVzdWx0aW5n
DQo+PiBpbiBubyBNVFJSIG1lbW9yeSB0eXBlIGluZm9ybWF0aW9uIGJlaW5nIGF2YWlsYWJs
ZSBmb3IgdGhlIGtlcm5lbC4NCj4+DQo+PiBUaGlzIGhhcyB0dXJuZWQgb3V0IHRvIHJlc3Vs
dCBpbiBwcm9ibGVtczoNCj4+DQo+PiAtIEh5cGVyLVYgU0VWLVNOUCBndWVzdHMgdXNpbmcg
dW5jYWNoZWQgbWFwcGluZ3Mgd2hlcmUgdGhleSBzaG91bGRuJ3QNCj4+IC0gWGVuIFBWIGRv
bTAgbWFwcGluZyBtZW1vcnkgYXMgV0Igd2hpY2ggc2hvdWxkIGJlIFVDLSBpbnN0ZWFkDQo+
Pg0KPj4gU29sdmUgdGhvc2UgcHJvYmxlbXMgYnkgc3VwcG9ydGluZyB0byBzZXQgYSBmaXhl
ZCBNVFJSIHN0YXRlLA0KPj4gb3ZlcndyaXRpbmcgdGhlIGVtcHR5IHN0YXRlIHVzZWQgdG9k
YXkuIEluIGNhc2Ugc3VjaCBhIHN0YXRlIGhhcyBiZWVuDQo+PiBzZXQsIGRvbid0IGNhbGwg
Z2V0X210cnJfc3RhdGUoKSBpbiBtdHJyX2JwX2luaXQoKS4gVGhlIHNldCBzdGF0ZQ0KPj4g
d2lsbCBvbmx5IGJlIHVzZWQgYnkgbXRycl90eXBlX2xvb2t1cCgpLCBhcyBpbiBhbGwgb3Ro
ZXIgY2FzZXMNCj4+IG10cnJfZW5hYmxlZCgpIGlzIGJlaW5nIGNoZWNrZWQsIHdoaWNoIHdp
bGwgcmV0dXJuIGZhbHNlLiBBY2NlcHQgdGhlDQo+PiBvdmVyd3JpdGUgY2FsbCBvbmx5IGlu
IGNhc2Ugb2YgTVRSUnMgYmVpbmcgZGlzYWJsZWQgaW4gY3B1aWQuDQo+IA0KPiBzL2NwdWlk
L0NQVUlEL2cNCg0KT2theS4NCg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jv
c3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gVjI6DQo+PiAtIG5ldyBwYXRjaA0K
Pj4gLS0tDQo+PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL210cnIuaCAgICAgICAgfCAgMiAr
Kw0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jIHwgMzggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbXRy
ci9tdHJyLmMgICAgfCAgOSArKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9t
dHJyLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmgNCj4+IGluZGV4IGYwZWVhZjZl
NWY1Zi4uMGI4ZjUxZDY4M2RjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vbXRyci5oDQo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmgNCj4+IEBA
IC0zMSw2ICszMSw4IEBADQo+PiAgICAqLw0KPj4gICAjIGlmZGVmIENPTkZJR19NVFJSDQo+
PiAgIHZvaWQgbXRycl9icF9pbml0KHZvaWQpOw0KPj4gK3ZvaWQgbXRycl9vdmVyd3JpdGVf
c3RhdGUoc3RydWN0IG10cnJfdmFyX3JhbmdlICp2YXIsIHVuc2lnbmVkIGludCBudW1fdmFy
LA0KPj4gKwkJCSAgbXRycl90eXBlICpmaXhlZCwgbXRycl90eXBlIGRlZl90eXBlKTsNCj4+
ICAgZXh0ZXJuIHU4IG10cnJfdHlwZV9sb29rdXAodTY0IGFkZHIsIHU2NCBlbmQsIHU4ICp1
bmlmb3JtKTsNCj4+ICAgZXh0ZXJuIHZvaWQgbXRycl9zYXZlX2ZpeGVkX3Jhbmdlcyh2b2lk
ICopOw0KPj4gICBleHRlcm4gdm9pZCBtdHJyX3NhdmVfc3RhdGUodm9pZCk7DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMNCj4+IGluZGV4IGVlMDlkMzU5ZTA4Zi4uNzg4
YmMxNjg4OGE1IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dl
bmVyaWMuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYw0K
Pj4gQEAgLTI0MCw2ICsyNDAsNDQgQEAgc3RhdGljIHU4IG10cnJfdHlwZV9sb29rdXBfdmFy
aWFibGUodTY0IHN0YXJ0LCB1NjQgZW5kLCB1NjQgKnBhcnRpYWxfZW5kLA0KPj4gICAJcmV0
dXJuIG10cnJfc3RhdGUuZGVmX3R5cGU7DQo+PiAgIH0NCj4+ICAgDQo+PiArLyoqDQo+PiAr
ICogbXRycl9vdmVyd3JpdGVfc3RhdGUgLSBzZXQgZml4ZWQgTVRSUiBzdGF0ZQ0KPiANCj4g
Zml4ZWQgb25seT8gWW91IHBhc3MgaW4gdmFyaWFibGUgdG9vLi4uDQoNCkZpeGVkIGluIHRo
ZSBzZW5zZSBvZiBzdGF0aWMuDQoNCj4gDQo+PiArICoNCj4+ICsgKiBVc2VkIHRvIHNldCBN
VFJSIHN0YXRlIHZpYSBkaWZmZXJlbnQgbWVhbnMgKGUuZy4gd2l0aCBkYXRhIG9idGFpbmVk
IGZyb20NCj4+ICsgKiBhIGh5cGVydmlzb3IpLg0KPj4gKyAqLw0KPj4gK3ZvaWQgbXRycl9v
dmVyd3JpdGVfc3RhdGUoc3RydWN0IG10cnJfdmFyX3JhbmdlICp2YXIsIHVuc2lnbmVkIGlu
dCBudW1fdmFyLA0KPj4gKwkJCSAgbXRycl90eXBlICpmaXhlZCwgbXRycl90eXBlIGRlZl90
eXBlKQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGk7DQo+PiArDQo+PiArCWlmIChib290
X2NwdV9oYXMoWDg2X0ZFQVRVUkVfTVRSUikpDQo+IA0KPiBjaGVja19mb3JfZGVwcmVjYXRl
ZF9hcGlzOiBXQVJOSU5HOiBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jOjI1
NDogRG8gbm90IHVzZSBib290X2NwdV9oYXMoKSAtIHVzZSBjcHVfZmVhdHVyZV9lbmFibGVk
KCkgaW5zdGVhZC4NCg0KT2theS4NCg0KPiANCj4+ICsJCXJldHVybjsNCj4gDQo+IFNvIHRo
aXMgaGVyZSBuZWVkcyB0byBjaGVjazoNCj4gDQo+IAlpZiAoIWNwdV9mZWF0dXJlX2VuYWJs
ZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikgJiYNCj4gCSAgICAhKGNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfU0VWX1NOUCkgfHwNCj4gCSAgICAgIGNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpKSkgew0KPiAJCVdBUk5fT05fT05DRSgxKTsNCj4g
CQlyZXR1cm47DQo+IAl9DQo+IA0KPiBhcyB3ZSBkb24ndCB3YW50IHRoaXMgdG8gYmUgY2Fs
bGVkIHNvbWV3aGVyZSBvciBieSBzb21ldGhpbmcgZWxzZS4NCg0KV291bGRuJ3QgIWNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikgYmUgZW5vdWdoPw0KDQpJ
J20gbm90IHN1cmUgd2Ugd29uJ3QgbmVlZCB0aGF0IGZvciBURFggZ3Vlc3RzLCB0b28uDQoN
Cj4gDQo+IFRoZSBTRVZfU05QIGZsYWcgY2FuIGJlIHVzZWQgZnJvbToNCj4gDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjEyMTQxOTQwNTYuMTYxNDkyLTE0LW1pY2hhZWwu
cm90aEBhbWQuY29tDQo+IA0KPiBJJ20gYXNzdW1pbmcgaGVyZSBIeXBlclYgU0VWLVNOUCBn
dWVzdHMgcmVhbGx5IGRvIHNldCB0aGF0IGZlYXR1cmUgZmxhZw0KPiAodGhleSBiZXR0ZXIp
LiBXZSBjYW4gZXhwZWRpdGUgdGhhdCBwYXRjaCBvZmMuDQo+IA0KPiBBbmQgZm9yIGRvbTAg
SSAqdGhpbmsqIHdlIHVzZSBYODZfRkVBVFVSRV9YRU5QViBidXQgSSBsZWF2ZSB0aGF0IHRv
IHlvdS4NCg0KWWVzLCBpdCBpcyBvbmx5IHJlbGV2YW50IGZvciBQViBkb20wLg0KDQo+IA0K
Pj4gKw0KPj4gKwlpZiAodmFyKSB7DQo+PiArCQlpZiAobnVtX3ZhciA+IE1UUlJfTUFYX1ZB
Ul9SQU5HRVMpIHsNCj4+ICsJCQlwcl93YXJuKCJUcnlpbmcgdG8gb3ZlcndyaXRlIE1UUlIg
c3RhdGUgd2l0aCAldSB2YXJpYWJsZSBlbnRyaWVzXG4iLA0KPj4gKwkJCQludW1fdmFyKTsN
Cj4gDQo+IFdoYXQncyB0aGF0IGNoZWNrIGZvcj8gU2FuaXR5IG9mIGNhbGxlcnM/DQoNClll
cy4NCg0KPiANCj4+ICsJCQludW1fdmFyID0gTVRSUl9NQVhfVkFSX1JBTkdFUzsNCj4+ICsJ
CX0NCj4+ICsJCWZvciAoaSA9IDA7IGkgPCBudW1fdmFyOyBpKyspDQo+PiArCQkJbXRycl9z
dGF0ZS52YXJfcmFuZ2VzW2ldID0gdmFyW2ldOw0KPj4gKwkJbnVtX3Zhcl9yYW5nZXMgPSBu
dW1fdmFyOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmIChmaXhlZCkgew0KPj4gKwkJZm9yIChp
ID0gMDsgaSA8IE1UUlJfTlVNX0ZJWEVEX1JBTkdFUzsgaSsrKQ0KPiANCj4gWW91J3JlIG5v
dCBkb2luZyB0aGlzIHNhbml0eSBjaGVjayBoZXJlLCBleHBlY3RpbmcgdGhhdCBjYWxsZXJz
IHdvdWxkDQo+IGtub3cgd2hhdCB0aGV5J3JlIGRvaW5nLi4uDQoNClRoZSBudW1iZXIgb2Yg
Zml4ZWQgTVRSUnMgaXMgbm90IGR5bmFtaWMgQUZBSUsuDQoNCj4gDQo+PiArCQkJbXRycl9z
dGF0ZS5maXhlZF9yYW5nZXNbaV0gPSBmaXhlZFtpXTsNCj4+ICsJCW10cnJfc3RhdGUuZW5h
YmxlZCB8PSBNVFJSX1NUQVRFX01UUlJfRklYRURfRU5BQkxFRDsNCj4+ICsJCW10cnJfc3Rh
dGUuaGF2ZV9maXhlZCA9IDE7DQo+PiArCX0NCj4+ICsNCj4+ICsJbXRycl9zdGF0ZS5kZWZf
dHlwZSA9IGRlZl90eXBlOw0KPj4gKwltdHJyX3N0YXRlLmVuYWJsZWQgfD0gTVRSUl9TVEFU
RV9NVFJSX0VOQUJMRUQ7DQo+PiArDQo+PiArCW10cnJfc3RhdGVfc2V0ID0gMTsNCj4+ICt9
DQo+IA0KPiBJIGNhbid0IHNheSB0aGF0IEknbSBjcmF6eSBhYm91dCB0aGUgY2FsbCBzaXRl
czoNCj4gDQo+IAltdHJyX292ZXJ3cml0ZV9zdGF0ZShOVUxMLCAwLCBOVUxMLCBNVFJSX1RZ
UEVfV1JCQUNLKTsNCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBpdCB3YW50cyBhDQo+IA0KPiAJ
bXRycl9vdmVycmlkZV9kZWZfdHlwZShNVFJSX1RZUEVfV1JCQUNLKTsNCj4gDQo+IGluc3Rl
YWQgb2YgcGFzc2luZyBpbiBhbGwgdGhvc2UgbnVsbHMgYXMgcGFyYW1zLg0KPiANCj4gVGhp
czoNCj4gDQo+IAltdHJyX292ZXJ3cml0ZV9zdGF0ZSh2YXIsIHJlZywgTlVMTCwgTVRSUl9U
WVBFX1VOQ0FDSEFCTEUpOw0KPiANCj4gSSBndWVzcyBpcyBhIGJpdCBiZXR0ZXIuDQo+IA0K
PiBEdW5ubywgaWYgaXQgaXMgb25seSB0aG9zZSB0d28gY2FsbGVycyB3ZSBjYW4gc2F5LCBt
ZWgsIHdoYXRldmVyLCB0aGlzDQo+IGludGVyZmFjZSBpcyBub3QgcHJldHR5IGJ1dCBkb2Vz
IHRoZSBqb2IgYXQgbGVhc3QuIEJ1dCBpZiBtb3JlIHVzZXJzDQo+IHN0YXJ0IHBvcHBpbmcg
dXAgdGhlbiBJIGd1ZXNzIHdlIGNhbiBkbw0KPiANCj4gCW10cnJfb3ZlcnJpZGVfZml4ZWQo
KQ0KPiAJbXRycl9vdmVycmlkZV92YXJpYWJsZSgpDQo+IAltdHJyX292ZXJyaWRlX2RlZl90
eXBlKCkNCg0KQSBzaW5nbGUgaW50ZXJmYWNlIG1ha2VzIGl0IGVhc2llciB0byBhdm9pZCBt
dWx0aXBsZSBjYWxscy4NCg0KSW4gdGhlIGVuZCBJJ20gZmluZSB3aXRoIGVpdGhlciB3YXku
DQoNCj4gDQo+IC4uLg0KPiANCj4gDQo+PiAgIC8qKg0KPj4gICAgKiBtdHJyX3R5cGVfbG9v
a3VwIC0gbG9vayB1cCBtZW1vcnkgdHlwZSBpbiBNVFJSDQo+PiAgICAqDQo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvbXRyci9tdHJyLmMNCj4+IGluZGV4IDU0MmNhNTYzOWRmZC4uYjczZmUyNDNjN2Zk
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPj4g
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPj4gQEAgLTY2OCw2ICs2
NjgsMTUgQEAgdm9pZCBfX2luaXQgbXRycl9icF9pbml0KHZvaWQpDQo+PiAgIAljb25zdCBj
aGFyICp3aHkgPSAiKG5vdCBhdmFpbGFibGUpIjsNCj4+ICAgCXVuc2lnbmVkIGludCBwaHlz
X2FkZHI7DQo+PiAgIA0KPj4gKwlpZiAobXRycl9zdGF0ZS5lbmFibGVkKSB7DQo+IA0KPiBO
b3QgY3JhenkgYWJvdXQgdGhpcyBlaXRoZXI6IHRoaXMgcmVsaWVzIG9uIHRoZSBmcmFnaWxl
IGJvb3Qgb3JkZXJpbmcNCj4gd2hlcmUgaW5pdF9oeXBlcnZpc29yX3BsYXRmb3JtKCkgcnVu
cyBiZWZvcmUgdGhpcyBzbyBpdCBoYXMgYSBjaGFuY2UNCj4gdGhhdCBtdHJyX3N0YXRlLmVu
YWJsZWQgd2lsbCBiZSBhbHJlYWR5IHNldC4NCj4gDQo+IFllYWgsIHllYWgsIGNhY2hlX2Jw
X2luaXQoKSBhbmQgYWxsIHRoZSBNVFJSIEJTUCBzZXR1cCBzdHVmZiBoYXBwZW5zDQo+IGFm
dGVyIGl0IGJ1dCB0aGVyZSBzaG91bGQgYXQgbGVhc3QgYmUgYSBjb21tZW50IG92ZXINCj4g
aW5pdF9oeXBlcnZpc29yX3BsYXRmb3JtKCkncyBjYWxsIHNpdGUgaW4gc2V0dXBfYXJjaCgp
IHN0YXRpbmcgdGhhdA0KPiBjYWNoZV9icF9pbml0KCkgbmVlZHMgdG8gaGFwcGVuICphZnRl
ciogaXQgYmVjYXVzZSA8cmVhc29uPi4NCg0KSSdsbCBhZGQgdGhhdCBjb21tZW50Lg0KDQo+
IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBhbHNvIGNoZWNrDQo+IA0KPiAJeDg2X2h5cGVyX3R5
cGUNCj4gDQo+IGhlcmUgYW5kIG5vdCBkbyBhbnl0aGluZyBpZiBub3Qgc2V0LiBBcyB0aGlz
IGlzIGFsbCBIVi1yZWxhdGVkIG11Y2suDQo+IA0KPiBYZW4gSSBndWVzcyBpcyBhIGJpdCBi
ZXR0ZXIgYmVjYXVzZSB0aGF0IGNhbGwgdGhlcmUgaGFwcGVucyBldmVuIGVhcmxpZXINCj4g
YnV0IHdlIG5lZWQgdGhlIGNvbW1lbnRzIHRvIHNheSB0aGF0IHRoZSBvcmRlcmluZyBtYXR0
ZXJzIGJlY2F1c2UgZnV0dXJlDQo+IHJlb3JnYW5pemF0aW9uIGNvdWxkIGNhdXNlIGl0IHRv
IGJsb3cgdXAgYW5kIHBlb3BsZSB3b3VsZCBzZWFyY2gNCj4gdGhlbXNlbHZlcyBjcmF6eSB3
aHkgaW4gdGhlIGhlbGwgaXQgYnJlYWtzLi4uDQo+IA0KPiBDYW4gWGVuIHVzZSB4ODZfaHlw
ZXJfdHlwZSgpIHRvbz8NCg0KSXQgZG9lcy4NCg0KDQpKdWVyZ2VuDQo=
--------------J90A00f0z4eeYlNwP2uO69AW
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------J90A00f0z4eeYlNwP2uO69AW--

--------------BVWhzXUGOnlGUuVb87B33N4t--

--------------bekH4HypIReNX3yMbA68bT3Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPqRAsFAwAAAAAACgkQsN6d1ii/Ey/q
mwf/dEpFQKOWdEF6YQduRUawcoqFoKRL/wqIeSlH6vN7DASwG4Yf1yadMeIMllwV1t7r3NPvrQdy
pxuutWNekroA2rA1PIxlw2rnzxuljJJvDylYEHgCxrTepe2OmLTFVLoHeUG8h98jh+ekQ8VIT0Ie
7eYyvZPjGG/On6BHkLNl/6uWiz1A16bvhplc4sVB8OWvPhpHoCsVXtFNKQEwAHgY3UGSvJhRorHv
Cj6J3wo0L+Ve1Jolfg9ls9BBXasiOxlQ1NWwGQ/dFYZYJssqs4rxq9bfHIgEU6++ShqGSRkFxtx1
2lHkBKfbg3ic5fda36XOjimREbtVaNUAT7BUFBt/Sw==
=uQP+
-----END PGP SIGNATURE-----

--------------bekH4HypIReNX3yMbA68bT3Y--
