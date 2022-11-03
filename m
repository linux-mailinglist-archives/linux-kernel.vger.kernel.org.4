Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D3617DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiKCNZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKCNZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:25:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C813EA6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:24:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD4EC1F8AC;
        Thu,  3 Nov 2022 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667481897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QUBuAHAGVF7m7eXHendyTsjI0pf2J3nOGew5yAs+24=;
        b=esQdGQ0tva4WxTGogmfCC1IScUwpk1vEqHcXc5keyuCapEtn1EXqCwmkYMdUdot1N6qq25
        S2NhndoR+fNVtIRdKegZjGz194e49WFuD5g7WzWFA/2hXL1gOboZdcXw/ox+NbBibcZvdt
        FZ0S1SeXeKqqhdi7Uxlxi/vbSqqLEBA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5330213480;
        Thu,  3 Nov 2022 13:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BRiJEinBY2PIWwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 13:24:57 +0000
Message-ID: <55fd2726-b54a-73a7-49ec-e66e025699a7@suse.com>
Date:   Thu, 3 Nov 2022 14:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] x86: switch to cpu_feature_enabled() for
 X86_FEATURE_XENPV
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221103113636.25543-1-jgross@suse.com>
 <20221103113636.25543-5-jgross@suse.com>
 <CAMzpN2hynmZ39ByCRg4ibm=Mz+5LbLps77k9Vhb+c+VmVUO1=A@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAMzpN2hynmZ39ByCRg4ibm=Mz+5LbLps77k9Vhb+c+VmVUO1=A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VyAi3UNXOOv0ZoAGGUlMSoRG"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VyAi3UNXOOv0ZoAGGUlMSoRG
Content-Type: multipart/mixed; boundary="------------q41ebvyIk77bWh0cY3Pf4Dl3";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Pu Wen <puwen@hygon.cn>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <55fd2726-b54a-73a7-49ec-e66e025699a7@suse.com>
Subject: Re: [PATCH 4/4] x86: switch to cpu_feature_enabled() for
 X86_FEATURE_XENPV
References: <20221103113636.25543-1-jgross@suse.com>
 <20221103113636.25543-5-jgross@suse.com>
 <CAMzpN2hynmZ39ByCRg4ibm=Mz+5LbLps77k9Vhb+c+VmVUO1=A@mail.gmail.com>
In-Reply-To: <CAMzpN2hynmZ39ByCRg4ibm=Mz+5LbLps77k9Vhb+c+VmVUO1=A@mail.gmail.com>

--------------q41ebvyIk77bWh0cY3Pf4Dl3
Content-Type: multipart/mixed; boundary="------------F1B2CDT0BNIzH628RfrxfcCc"

--------------F1B2CDT0BNIzH628RfrxfcCc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTEuMjIgMTQ6MTksIEJyaWFuIEdlcnN0IHdyb3RlOg0KPiBPbiBUaHUsIE5vdiAz
LCAyMDIyIGF0IDg6MzcgQU0gSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPiB3cm90
ZToNCj4+DQo+PiBDb252ZXJ0IHRoZSByZW1haW5pbmcgY2FzZXMgb2Ygc3RhdGljX2NwdV9o
YXMoWDg2X0ZFQVRVUkVfWEVOUFYpIGFuZA0KPj4gYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJF
X1hFTlBWKSB0byB1c2UgY3B1X2ZlYXR1cmVfZW5hYmxlZCgpLCBhbGxvd2luZw0KPj4gbW9y
ZSBlZmZpY2llbnQgY29kZSBpbiBjYXNlIHRoZSBrZXJuZWwgaXMgY29uZmlndXJlZCB3aXRo
b3V0DQo+PiBDT05GSUdfWEVOX1BWLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4g
R3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L2FtZC5jICAgIHwgMiArLQ0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyAg
IHwgMiArLQ0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2h5Z29uLmMgIHwgMiArLQ0KPj4g
ICBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jIHwgNCArKy0tDQo+PiAgIGFyY2gveDg2
L2tlcm5lbC90b3BvbG9neS5jICAgfCAyICstDQo+PiAgIGFyY2gveDg2L21tL2NwdV9lbnRy
eV9hcmVhLmMgfCAyICstDQo+PiAgIDYgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2FtZC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9hbWQuYw0KPj4gaW5kZXggODYwYjYw
MjczZGYzLi42OTdmZTg4MWU5NjcgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L2FtZC5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5jDQo+PiBAQCAt
OTg1LDcgKzk4NSw3IEBAIHN0YXRpYyB2b2lkIGluaXRfYW1kKHN0cnVjdCBjcHVpbmZvX3g4
NiAqYykNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBzZXRfY3B1X2NhcChjLCBYODZf
RkVBVFVSRV8zRE5PV1BSRUZFVENIKTsNCj4+DQo+PiAgICAgICAgICAvKiBBTUQgQ1BVcyBk
b24ndCByZXNldCBTUyBhdHRyaWJ1dGVzIG9uIFNZU1JFVCwgWGVuIGRvZXMuICovDQo+PiAt
ICAgICAgIGlmICghY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9YRU5QVikpDQo+PiArICAgICAg
IGlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9YRU5QVikpDQo+PiAgICAg
ICAgICAgICAgICAgIHNldF9jcHVfYnVnKGMsIFg4Nl9CVUdfU1lTUkVUX1NTX0FUVFJTKTsN
Cj4+DQo+PiAgICAgICAgICAvKg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4+IGluZGV4IGRhN2Mz
NjFmNDdlMC4uN2Y3OGUxNTI3YzVlIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2NwdS9idWdzLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+PiBA
QCAtMTMwMiw3ICsxMzAyLDcgQEAgc3RhdGljIGVudW0gc3BlY3RyZV92Ml9taXRpZ2F0aW9u
X2NtZCBfX2luaXQgc3BlY3RyZV92Ml9wYXJzZV9jbWRsaW5lKHZvaWQpDQo+PiAgICAgICAg
ICAgICAgICAgIHJldHVybiBTUEVDVFJFX1YyX0NNRF9BVVRPOw0KPj4gICAgICAgICAgfQ0K
Pj4NCj4+IC0gICAgICAgaWYgKGNtZCA9PSBTUEVDVFJFX1YyX0NNRF9JQlJTICYmIGJvb3Rf
Y3B1X2hhcyhYODZfRkVBVFVSRV9YRU5QVikpIHsNCj4+ICsgICAgICAgaWYgKGNtZCA9PSBT
UEVDVFJFX1YyX0NNRF9JQlJTICYmIGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
WEVOUFYpKSB7DQo+PiAgICAgICAgICAgICAgICAgIHByX2VycigiJXMgc2VsZWN0ZWQgYnV0
IHJ1bm5pbmcgYXMgWGVuUFYgZ3Vlc3QuIFN3aXRjaGluZyB0byBBVVRPIHNlbGVjdFxuIiwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgIG1pdGlnYXRpb25fb3B0aW9uc1tpXS5vcHRp
b24pOw0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gU1BFQ1RSRV9WMl9DTURfQVVUTzsN
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2h5Z29uLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L2h5Z29uLmMNCj4+IGluZGV4IDIxZmQ0MjUwODhmZS4uMWMyNzY0NWZk
NDI5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9oeWdvbi5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2h5Z29uLmMNCj4+IEBAIC0zMzksNyArMzM5LDcg
QEAgc3RhdGljIHZvaWQgaW5pdF9oeWdvbihzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+PiAg
ICAgICAgICBzZXRfY3B1X2NhcChjLCBYODZfRkVBVFVSRV9BUkFUKTsNCj4+DQo+PiAgICAg
ICAgICAvKiBIeWdvbiBDUFVzIGRvbid0IHJlc2V0IFNTIGF0dHJpYnV0ZXMgb24gU1lTUkVU
LCBYZW4gZG9lcy4gKi8NCj4+IC0gICAgICAgaWYgKCFjcHVfaGFzKGMsIFg4Nl9GRUFUVVJF
X1hFTlBWKSkNCj4+ICsgICAgICAgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX1hFTlBWKSkNCj4+ICAgICAgICAgICAgICAgICAgc2V0X2NwdV9idWcoYywgWDg2X0JV
R19TWVNSRVRfU1NfQVRUUlMpOw0KPj4NCj4+ICAgICAgICAgIGNoZWNrX251bGxfc2VnX2Ns
ZWFyc19iYXNlKGMpOw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNz
XzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jDQo+PiBpbmRleCA2YjM0MThi
ZmYzMjYuLmUyZjQ2OTE3NWJlOCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9w
cm9jZXNzXzY0LmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzXzY0LmMNCj4+
IEBAIC0xNjUsNyArMTY1LDcgQEAgc3RhdGljIG5vaW5zdHIgdW5zaWduZWQgbG9uZyBfX3Jk
Z3NiYXNlX2luYWN0aXZlKHZvaWQpDQo+Pg0KPj4gICAgICAgICAgbG9ja2RlcF9hc3NlcnRf
aXJxc19kaXNhYmxlZCgpOw0KPj4NCj4+IC0gICAgICAgaWYgKCFzdGF0aWNfY3B1X2hhcyhY
ODZfRkVBVFVSRV9YRU5QVikpIHsNCj4+ICsgICAgICAgaWYgKCFjcHVfZmVhdHVyZV9lbmFi
bGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSkgew0KPj4gICAgICAgICAgICAgICAgICBuYXRpdmVf
c3dhcGdzKCk7DQo+PiAgICAgICAgICAgICAgICAgIGdzYmFzZSA9IHJkZ3NiYXNlKCk7DQo+
PiAgICAgICAgICAgICAgICAgIG5hdGl2ZV9zd2FwZ3MoKTsNCj4+IEBAIC0xOTAsNyArMTkw
LDcgQEAgc3RhdGljIG5vaW5zdHIgdm9pZCBfX3dyZ3NiYXNlX2luYWN0aXZlKHVuc2lnbmVk
IGxvbmcgZ3NiYXNlKQ0KPj4gICB7DQo+PiAgICAgICAgICBsb2NrZGVwX2Fzc2VydF9pcnFz
X2Rpc2FibGVkKCk7DQo+Pg0KPj4gLSAgICAgICBpZiAoIXN0YXRpY19jcHVfaGFzKFg4Nl9G
RUFUVVJFX1hFTlBWKSkgew0KPj4gKyAgICAgICBpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfWEVOUFYpKSB7DQo+PiAgICAgICAgICAgICAgICAgIG5hdGl2ZV9zd2Fw
Z3MoKTsNCj4+ICAgICAgICAgICAgICAgICAgd3Jnc2Jhc2UoZ3NiYXNlKTsNCj4+ICAgICAg
ICAgICAgICAgICAgbmF0aXZlX3N3YXBncygpOw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC90b3BvbG9neS5jIGIvYXJjaC94ODYva2VybmVsL3RvcG9sb2d5LmMNCj4+IGlu
ZGV4IDg2MTdkMWVkOWQzMS4uMWI4MzM3NzI3NGI4IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL3RvcG9sb2d5LmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC90b3BvbG9n
eS5jDQo+PiBAQCAtMTA2LDcgKzEwNiw3IEBAIGludCBhcmNoX3JlZ2lzdGVyX2NwdShpbnQg
bnVtKQ0KPj4gICAgICAgICAgICogWGVuIFBWIGd1ZXN0cyBkb24ndCBzdXBwb3J0IENQVTAg
aG90cGx1ZyBhdCBhbGwuDQo+PiAgICAgICAgICAgKi8NCj4+ICAgICAgICAgIGlmIChjLT54
ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwgfHwNCj4+IC0gICAgICAgICAgIGJvb3Rf
Y3B1X2hhcyhYODZfRkVBVFVSRV9YRU5QVikpDQo+PiArICAgICAgICAgICBjcHVfZmVhdHVy
ZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSkNCj4+ICAgICAgICAgICAgICAgICAgY3B1
MF9ob3RwbHVnZ2FibGUgPSAwOw0KPj4NCj4+ICAgICAgICAgIC8qDQo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvbW0vY3B1X2VudHJ5X2FyZWEuYyBiL2FyY2gveDg2L21tL2NwdV9lbnRy
eV9hcmVhLmMNCj4+IGluZGV4IDZjMmYxYjc2YTBiNi4uYzgzNzk5NzUzZDQ0IDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC94ODYvbW0vY3B1X2VudHJ5X2FyZWEuYw0KPj4gKysrIGIvYXJjaC94
ODYvbW0vY3B1X2VudHJ5X2FyZWEuYw0KPj4gQEAgLTE0Nyw3ICsxNDcsNyBAQCBzdGF0aWMg
dm9pZCBfX2luaXQgc2V0dXBfY3B1X2VudHJ5X2FyZWEodW5zaWduZWQgaW50IGNwdSkNCj4+
ICAgICAgICAgICAqIE9uIFhlbiBQViwgdGhlIEdEVCBtdXN0IGJlIHJlYWQtb25seSBiZWNh
dXNlIHRoZSBoeXBlcnZpc29yDQo+PiAgICAgICAgICAgKiByZXF1aXJlcyBpdC4NCj4+ICAg
ICAgICAgICAqLw0KPj4gLSAgICAgICBwZ3Byb3RfdCBnZHRfcHJvdCA9IGJvb3RfY3B1X2hh
cyhYODZfRkVBVFVSRV9YRU5QVikgPw0KPj4gKyAgICAgICBwZ3Byb3RfdCBnZHRfcHJvdCA9
IGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpID8NCj4+ICAgICAgICAg
ICAgICAgICAgUEFHRV9LRVJORUxfUk8gOiBQQUdFX0tFUk5FTDsNCj4+ICAgICAgICAgIHBn
cHJvdF90IHRzc19wcm90ID0gUEFHRV9LRVJORUw7DQo+PiAgICNlbmRpZg0KPiANCj4gVGhp
cyBpcyBhbm90aGVyIGNhc2UgdGhhdCBjYW4gYmUgcmVtb3ZlZCBiZWNhdXNlIGl0J3MgZm9y
IDMyLWJpdC4NCg0KT2ggeWVzLCBpbmRlZWQuIFRoYW5rcyBmb3Igbm90aWNpbmcuDQoNCg0K
SnVlcmdlbg0KDQo=
--------------F1B2CDT0BNIzH628RfrxfcCc
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------F1B2CDT0BNIzH628RfrxfcCc--

--------------q41ebvyIk77bWh0cY3Pf4Dl3--

--------------VyAi3UNXOOv0ZoAGGUlMSoRG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNjwSgFAwAAAAAACgkQsN6d1ii/Ey9S
Qwf8DAg2WORBlH4UtVe5sxilRRF+JJ/5DXToY6JWvsLa+H0nNrvRdrkL1SN/J7UZdv98T1e9faOM
pu4RYI3jzPItVJOD6/g9bjm3ip0a/iiWWbCCOPMJ7P88DBGgYL/+YlFTJTp2UkfeJ4UEYJcNGsEr
MSOdgELW8YBEKtlETTKnfMW1MR5pC6ejzJMtdF6XJsiyPkUCXXCy6IipnXiS5VkFOzrcht1rQ6Er
FB/7JBor8jG1npjSlnQhgEkdvglmZdv87bMeaPkvaWe/d2TajUqSrreJ1rmv0eqnIFRKhhXDzw6u
3Lg7Eiw0Tce4vvPk1bOLjPl/Yg095U76OJ2GSIShag==
=bQOZ
-----END PGP SIGNATURE-----

--------------VyAi3UNXOOv0ZoAGGUlMSoRG--
