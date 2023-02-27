Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000C76A3B90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjB0HNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:13:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E373598
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:13:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 249171FD63;
        Mon, 27 Feb 2023 07:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677482023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQm6lWmm76u3GPESJsc3omjXkCbqPOghCtzoVCOAhi8=;
        b=JmH4ykEAiKXK1dl6fqbaG35ON3B22s58d8dNhv8RMH67T5Aa7USMeHQK4C7DFOKTWwOQU1
        WsmoEsWtYCPUhhpTmnvPtPYF4v4DgrJYvuEzEe5xepey+iFSPh9lQKH1pIjOYwIDB/WGid
        T/tSMQFWU8fgIxcLDx1gi6UMAfjjy90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D607C13912;
        Mon, 27 Feb 2023 07:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZlKlMiZY/GO4EwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Feb 2023 07:13:42 +0000
Message-ID: <ef7510e0-958f-6c17-06c4-19e2506496ad@suse.com>
Date:   Mon, 27 Feb 2023 08:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-4-jgross@suse.com>
 <BYAPR21MB16886880C8B115233F48C3CFD7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB16886880C8B115233F48C3CFD7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j2gG0bzqiWJkKux0vcdIzVxs"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j2gG0bzqiWJkKux0vcdIzVxs
Content-Type: multipart/mixed; boundary="------------HtyXPTJZOmVGg8ppo17p0GBS";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ef7510e0-958f-6c17-06c4-19e2506496ad@suse.com>
Subject: Re: [PATCH v3 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-4-jgross@suse.com>
 <BYAPR21MB16886880C8B115233F48C3CFD7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16886880C8B115233F48C3CFD7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------HtyXPTJZOmVGg8ppo17p0GBS
Content-Type: multipart/mixed; boundary="------------siHhz4TzIGktIpr1FIRZQT8R"

--------------siHhz4TzIGktIpr1FIRZQT8R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDIuMjMgMTg6MTIsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogVGh1cnNkYXksIEZl
YnJ1YXJ5IDIzLCAyMDIzIDE6MzMgQU0NCj4+DQo+PiBXaGVuIHJ1bm5pbmcgdmlydHVhbGl6
ZWQsIE1UUlIgYWNjZXNzIGNhbiBiZSByZWR1Y2VkIChlLmcuIGluIFhlbiBQVg0KPj4gZ3Vl
c3RzIG9yIHdoZW4gcnVubmluZyBhcyBhIFNFVi1TTlAgZ3Vlc3QgdW5kZXIgSHlwZXItViku
IFR5cGljYWxseQ0KPj4gdGhlIGh5cGVydmlzb3Igd2lsbCByZXNldCB0aGUgTVRSUiBmZWF0
dXJlIGluIENQVUlEIGRhdGEsIHJlc3VsdGluZw0KPj4gaW4gbm8gTVRSUiBtZW1vcnkgdHlw
ZSBpbmZvcm1hdGlvbiBiZWluZyBhdmFpbGFibGUgZm9yIHRoZSBrZXJuZWwuDQo+Pg0KPj4g
VGhpcyBoYXMgdHVybmVkIG91dCB0byByZXN1bHQgaW4gcHJvYmxlbXM6DQo+Pg0KPj4gLSBI
eXBlci1WIFNFVi1TTlAgZ3Vlc3RzIHVzaW5nIHVuY2FjaGVkIG1hcHBpbmdzIHdoZXJlIHRo
ZXkgc2hvdWxkbid0DQo+PiAtIFhlbiBQViBkb20wIG1hcHBpbmcgbWVtb3J5IGFzIFdCIHdo
aWNoIHNob3VsZCBiZSBVQy0gaW5zdGVhZA0KPj4NCj4+IFNvbHZlIHRob3NlIHByb2JsZW1z
IGJ5IHN1cHBvcnRpbmcgdG8gc2V0IGEgc3RhdGljIE1UUlIgc3RhdGUsDQo+PiBvdmVyd3Jp
dGluZyB0aGUgZW1wdHkgc3RhdGUgdXNlZCB0b2RheS4gSW4gY2FzZSBzdWNoIGEgc3RhdGUg
aGFzIGJlZW4NCj4+IHNldCwgZG9uJ3QgY2FsbCBnZXRfbXRycl9zdGF0ZSgpIGluIG10cnJf
YnBfaW5pdCgpLiBUaGUgc2V0IHN0YXRlDQo+PiB3aWxsIG9ubHkgYmUgdXNlZCBieSBtdHJy
X3R5cGVfbG9va3VwKCksIGFzIGluIGFsbCBvdGhlciBjYXNlcw0KPj4gbXRycl9lbmFibGVk
KCkgaXMgYmVpbmcgY2hlY2tlZCwgd2hpY2ggd2lsbCByZXR1cm4gZmFsc2UuIEFjY2VwdCB0
aGUNCj4+IG92ZXJ3cml0ZSBjYWxsIG9ubHkgZm9yIHNlbGVjdGVkIGNhc2VzIHdoZW4gcnVu
bmluZyBhcyBhIGd1ZXN0Lg0KPj4gRGlzYWJsZSBYODZfRkVBVFVSRV9NVFJSIGluIG9yZGVy
IHRvIGF2b2lkIGFueSBNVFJSIG1vZGlmaWNhdGlvbnMgYnkNCj4+IGp1c3QgcmVmdXNpbmcg
dGhlbS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+DQo+PiAtLS0NCj4+IFYyOg0KPj4gLSBuZXcgcGF0Y2gNCj4+IFYzOg0KPj4gLSBv
bWl0IGZpeGVkIE1UUlJzLCBhcyB0aG9zZSBhcmUgY3VycmVudGx5IG5vdCBuZWVkZWQNCj4+
IC0gZGlzYWJsZSBYODZfRkVBVFVSRV9NVFJSIGluc3RlYWQgb2YgdGVzdGluZyBpdA0KPj4g
LSBwcm92aWRlIGEgc3R1YiBmb3IgIUNPTkZJR19NVFJSIChNaWNoYWVsIEtlbGxleSkNCj4+
IC0gdXNlIGNwdV9mZWF0dXJlX2VuYWJsZWQoKSAoQm9yaXMgUGV0a292KQ0KPj4gLSBhZGQg
dGVzdHMgZm9yIG10cnJfb3ZlcndyaXRlX3N0YXRlKCkgYmVpbmcgYWxsb3dlZCAoQm9yaXMg
UGV0a292KQ0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL210cnIuaCAgICAg
ICAgfCAgOCArKysrKysNCj4+ICAgYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMu
YyB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L210cnIvbXRyci5jICAgIHwgIDkgKysrKysrKw0KPj4gICBhcmNoL3g4Ni9r
ZXJuZWwvc2V0dXAuYyAgICAgICAgICAgIHwgIDIgKysNCj4+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCA2MiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL210cnIuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL210cnIuaA0KPj4gaW5kZXgg
ZjBlZWFmNmU1ZjVmLi5mMWNiODEzMzBhNjQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9tdHJyLmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL210cnIu
aA0KPj4gQEAgLTMxLDYgKzMxLDggQEANCj4+ICAgICovDQo+PiAgICMgaWZkZWYgQ09ORklH
X01UUlINCj4+ICAgdm9pZCBtdHJyX2JwX2luaXQodm9pZCk7DQo+PiArdm9pZCBtdHJyX292
ZXJ3cml0ZV9zdGF0ZShzdHJ1Y3QgbXRycl92YXJfcmFuZ2UgKnZhciwgdW5zaWduZWQgaW50
IG51bV92YXIsDQo+PiArCQkJICBtdHJyX3R5cGUgZGVmX3R5cGUpOw0KPj4gICBleHRlcm4g
dTggbXRycl90eXBlX2xvb2t1cCh1NjQgYWRkciwgdTY0IGVuZCwgdTggKnVuaWZvcm0pOw0K
Pj4gICBleHRlcm4gdm9pZCBtdHJyX3NhdmVfZml4ZWRfcmFuZ2VzKHZvaWQgKik7DQo+PiAg
IGV4dGVybiB2b2lkIG10cnJfc2F2ZV9zdGF0ZSh2b2lkKTsNCj4+IEBAIC00OCw2ICs1MCwx
MiBAQCB2b2lkIG10cnJfZGlzYWJsZSh2b2lkKTsNCj4+ICAgdm9pZCBtdHJyX2VuYWJsZSh2
b2lkKTsNCj4+ICAgdm9pZCBtdHJyX2dlbmVyaWNfc2V0X3N0YXRlKHZvaWQpOw0KPj4gICAj
ICBlbHNlDQo+PiArc3RhdGljIGlubGluZSB2b2lkIG10cnJfb3ZlcndyaXRlX3N0YXRlKHN0
cnVjdCBtdHJyX3Zhcl9yYW5nZSAqdmFyLA0KPj4gKwkJCQkJdW5zaWduZWQgaW50IG51bV92
YXIsDQo+PiArCQkJCQltdHJyX3R5cGUgZGVmX3R5cGUpDQo+PiArew0KPj4gK30NCj4+ICsN
Cj4+ICAgc3RhdGljIGlubGluZSB1OCBtdHJyX3R5cGVfbG9va3VwKHU2NCBhZGRyLCB1NjQg
ZW5kLCB1OCAqdW5pZm9ybSkNCj4+ICAgew0KPj4gICAJLyoNCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9tdHJyL2dlbmVyaWMuYw0KPj4gaW5kZXggZWUwOWQzNTllMDhmLi40MGM1OWQ1MjJmNTcg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jDQo+
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jDQo+PiBAQCAtOCwx
MCArOCwxMiBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPj4gICAjaW5jbHVk
ZSA8bGludXgvaW8uaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+PiArI2luY2x1
ZGUgPGxpbnV4L2NjX3BsYXRmb3JtLmg+DQo+Pg0KPj4gICAjaW5jbHVkZSA8YXNtL3Byb2Nl
c3Nvci1mbGFncy5oPg0KPj4gICAjaW5jbHVkZSA8YXNtL2NhY2hlaW5mby5oPg0KPj4gICAj
aW5jbHVkZSA8YXNtL2NwdWZlYXR1cmUuaD4NCj4+ICsjaW5jbHVkZSA8YXNtL2h5cGVydmlz
b3IuaD4NCj4+ICAgI2luY2x1ZGUgPGFzbS90bGJmbHVzaC5oPg0KPj4gICAjaW5jbHVkZSA8
YXNtL210cnIuaD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9tc3IuaD4NCj4+IEBAIC0yNDAsNiAr
MjQyLDQ3IEBAIHN0YXRpYyB1OCBtdHJyX3R5cGVfbG9va3VwX3ZhcmlhYmxlKHU2NCBzdGFy
dCwgdTY0IGVuZCwgdTY0DQo+PiAqcGFydGlhbF9lbmQsDQo+PiAgIAlyZXR1cm4gbXRycl9z
dGF0ZS5kZWZfdHlwZTsNCj4+ICAgfQ0KPj4NCj4+ICsvKioNCj4+ICsgKiBtdHJyX292ZXJ3
cml0ZV9zdGF0ZSAtIHNldCBzdGF0aWMgTVRSUiBzdGF0ZQ0KPj4gKyAqDQo+PiArICogVXNl
ZCB0byBzZXQgTVRSUiBzdGF0ZSB2aWEgZGlmZmVyZW50IG1lYW5zIChlLmcuIHdpdGggZGF0
YSBvYnRhaW5lZCBmcm9tDQo+PiArICogYSBoeXBlcnZpc29yKS4NCj4+ICsgKiBJcyBhbGxv
d2VkIG9ubHkgZm9yIHNwZWNpYWwgY2FzZXMgd2hlbiBydW5uaW5nIHZpcnR1YWxpemVkLiBN
dXN0IGJlIGNhbGxlZA0KPj4gKyAqIGZyb20gdGhlIHg4Nl9pbml0Lmh5cGVyLmluaXRfcGxh
dGZvcm0oKSBob29rLiBYODZfRkVBVFVSRV9NVFJSIG11c3QgYmUgb2ZmLg0KPj4gKyAqLw0K
Pj4gK3ZvaWQgbXRycl9vdmVyd3JpdGVfc3RhdGUoc3RydWN0IG10cnJfdmFyX3JhbmdlICp2
YXIsIHVuc2lnbmVkIGludCBudW1fdmFyLA0KPj4gKwkJCSAgbXRycl90eXBlIGRlZl90eXBl
KQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGk7DQo+PiArDQo+PiArCWlmIChXQVJOX09O
KG10cnJfc3RhdGVfc2V0IHx8DQo+PiArCQkgICAgaHlwZXJ2aXNvcl9pc190eXBlKFg4Nl9I
WVBFUl9OQVRJVkUpIHx8DQo+PiArCQkgICAgIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZF
QVRVUkVfSFlQRVJWSVNPUikgfHwNCj4+ICsJCSAgICAoIWNjX3BsYXRmb3JtX2hhcyhDQ19B
VFRSX0dVRVNUX1NFVl9TTlApICYmDQo+IA0KPiBXaXRoIGN1cnJlbnQgdXBzdHJlYW0gY29k
ZSwgdGhpcyB0ZXN0IGRvZXNuJ3QgYWxsb3cgSHlwZXItViBTTlAgdlRPTSBWTXMNCj4gdG8g
ZG8gdGhlIG92ZXJ3cml0ZSwgYXMgY3VycmVudCB1cHN0cmVhbSB2VE9NIGNvZGUgZG9lc24n
dCBwYXJ0aWNpcGF0ZSBpbiB0aGUNCj4gY2NfcGxhdGZvcm1faGFzKCkgbWVjaGFuaXNtLiAg
VGhhdCdzIGJlaW5nIHJld29ya2VkIGluIGEgc2VwYXJhdGUgcGF0Y2gNCj4gc2V0LiAgQ2Fu
IHlvdSBhZGQgdGhpcyB0ZXN0IHRvIGNvdmVyIHRoZSBTTlAgdlRPTSBjYXNlPw0KPiANCj4g
CQkgICAgIWh2X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQoKSAmJg0KPiANCj4gVGhpcyBpcyB0
aGUgc2FtZSB0ZXN0IHVzZWQgaW4gX19zZXRfbWVtb3J5X2VuY19kZWMoKSwgZm9yIGV4YW1w
bGUuICBZb3UnbGwNCj4gaGF2ZSB0byBhZGQgI2luY2x1ZGUgPGFzbS9tc2h5cGVydi5oPi4g
IFRoZXJlJ3MgYWxyZWFkeSBhIHN0dWIgdGhhdCByZXR1cm5zDQo+ICdmYWxzZScgc28gdGhh
dCBldmVyeXRoaW5nIHdvcmtzIHdoZW4gYnVpbGRpbmcgd2l0aCBDT05GSUdfSFlQRVJWPW4u
DQoNClllcywgdGhpcyB3YXMgYW4gb3BlbiBxdWVzdGlvbi4gSW4gY2FzZSBub2JvZHkgb2Jq
ZWN0cywgSSdsbCBkbyB0aGUNCm1vZGlmaWNhdGlvbi4NCg0KPiBPbmNlIG15IG90aGVyIHBh
dGNoIHNldCBpcyBhY2NlcHRlZCwgSSdsbCByZXZpc2UgdGhpcyB0byByZW1vdmUgdXNlIG9m
DQo+IGh2X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQoKSBvdXRzaWRlIG9mIEh5cGVyLVYgc3Bl
Y2lmaWMgY29kZSwgYW5kIHVzZQ0KPiB0aGUgbmV3ZXIgY2NfcGxhdGZvcm1faGFzKCkgaW5z
dGVhZC4NCg0KVGhhbmtzLA0KDQoNCkp1ZXJnZW4NCg==
--------------siHhz4TzIGktIpr1FIRZQT8R
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------siHhz4TzIGktIpr1FIRZQT8R--

--------------HtyXPTJZOmVGg8ppo17p0GBS--

--------------j2gG0bzqiWJkKux0vcdIzVxs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmP8WCYFAwAAAAAACgkQsN6d1ii/Ey+9
4AgAimV18cJKYtq4LCT8ZRwnB8854AbLwwn89pLu/AsXBj1Q6Ap3qbtq5qarLDc7TAvkRg3qLMNb
sv04T160Rbsb3fovJ0LbGvlNii6OblX74SeTjszFY3IKfUlE+7EebS/5g2vftsGntBW0pKNOBIr0
MPgzqHLpXYNmh7tF9hiA/5kWS9GMxpsmP6fCUBTGsej8gmyq62kP8IFmM+At/C2F3qAgWENRjTHb
VaanGBG2QQr8Nx3SdozM0se09TJg4avtT+CORS8DXG6d3aN9F1+PEsQKwxV763GObjB8sjDb/hvD
i8+/NkoP2N30dajIXSgx3XrrdV9tuHYpzeHYsv6csw==
=xKtG
-----END PGP SIGNATURE-----

--------------j2gG0bzqiWJkKux0vcdIzVxs--
