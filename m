Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD87698FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBPJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBPJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:32:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D47EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:32:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E775321DD6;
        Thu, 16 Feb 2023 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676539948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQGGh0+aQKoMs9jkQE18Hu5wUNl3MbfUQWveNSNG/3o=;
        b=Ewp6/OUfjmV7uiXEeQxFWVLdp8kivGcJzYFJS99KcrgAQSrg2e8gj9BlDbpF4Tdc/yu2cx
        KhmfqMGBNHAbnG9yJtZt931P9AzdT+m5rps2FMeKoI6ioJzPUIJDVtPz+y9QlP+vsyivrg
        XfQm9meyv4LjZaDwn0RTxNv5mV++4JY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C50C13484;
        Thu, 16 Feb 2023 09:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gh9vJCz47WP9KgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Feb 2023 09:32:28 +0000
Message-ID: <cc6c58a8-b162-a6eb-37d4-40786f532837@suse.com>
Date:   Thu, 16 Feb 2023 10:32:28 +0100
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
 boundary="------------GZlBcdN97K0Ko47SmRuLt09p"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GZlBcdN97K0Ko47SmRuLt09p
Content-Type: multipart/mixed; boundary="------------nvD3HbiZsMbWmwnQx4LKBhNy";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <cc6c58a8-b162-a6eb-37d4-40786f532837@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
In-Reply-To: <Y+ohfE/wICFKO/93@zn.tnic>

--------------nvD3HbiZsMbWmwnQx4LKBhNy
Content-Type: multipart/mixed; boundary="------------CBWiUEXdu0AJH9bM7gkN0hRw"

--------------CBWiUEXdu0AJH9bM7gkN0hRw
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
L0NQVUlEL2cNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NA
c3VzZS5jb20+DQo+PiAtLS0NCj4+IFYyOg0KPj4gLSBuZXcgcGF0Y2gNCj4+IC0tLQ0KPj4g
ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmggICAgICAgIHwgIDIgKysNCj4+ICAgYXJj
aC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYyB8IDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jICAg
IHwgIDkgKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vbXRyci5oDQo+PiBpbmRleCBmMGVlYWY2ZTVmNWYuLjBiOGY1
MWQ2ODNkYyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL210cnIuaA0K
Pj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oDQo+PiBAQCAtMzEsNiArMzEs
OCBAQA0KPj4gICAgKi8NCj4+ICAgIyBpZmRlZiBDT05GSUdfTVRSUg0KPj4gICB2b2lkIG10
cnJfYnBfaW5pdCh2b2lkKTsNCj4+ICt2b2lkIG10cnJfb3ZlcndyaXRlX3N0YXRlKHN0cnVj
dCBtdHJyX3Zhcl9yYW5nZSAqdmFyLCB1bnNpZ25lZCBpbnQgbnVtX3ZhciwNCj4+ICsJCQkg
IG10cnJfdHlwZSAqZml4ZWQsIG10cnJfdHlwZSBkZWZfdHlwZSk7DQo+PiAgIGV4dGVybiB1
OCBtdHJyX3R5cGVfbG9va3VwKHU2NCBhZGRyLCB1NjQgZW5kLCB1OCAqdW5pZm9ybSk7DQo+
PiAgIGV4dGVybiB2b2lkIG10cnJfc2F2ZV9maXhlZF9yYW5nZXModm9pZCAqKTsNCj4+ICAg
ZXh0ZXJuIHZvaWQgbXRycl9zYXZlX3N0YXRlKHZvaWQpOw0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L210cnIvZ2VuZXJpYy5jDQo+PiBpbmRleCBlZTA5ZDM1OWUwOGYuLjc4OGJjMTY4ODhhNSAx
MDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMNCj4+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMNCj4+IEBAIC0yNDAs
NiArMjQwLDQ0IEBAIHN0YXRpYyB1OCBtdHJyX3R5cGVfbG9va3VwX3ZhcmlhYmxlKHU2NCBz
dGFydCwgdTY0IGVuZCwgdTY0ICpwYXJ0aWFsX2VuZCwNCj4+ICAgCXJldHVybiBtdHJyX3N0
YXRlLmRlZl90eXBlOw0KPj4gICB9DQo+PiAgIA0KPj4gKy8qKg0KPj4gKyAqIG10cnJfb3Zl
cndyaXRlX3N0YXRlIC0gc2V0IGZpeGVkIE1UUlIgc3RhdGUNCj4gDQo+IGZpeGVkIG9ubHk/
IFlvdSBwYXNzIGluIHZhcmlhYmxlIHRvby4uLg0KPiANCj4+ICsgKg0KPj4gKyAqIFVzZWQg
dG8gc2V0IE1UUlIgc3RhdGUgdmlhIGRpZmZlcmVudCBtZWFucyAoZS5nLiB3aXRoIGRhdGEg
b2J0YWluZWQgZnJvbQ0KPj4gKyAqIGEgaHlwZXJ2aXNvcikuDQo+PiArICovDQo+PiArdm9p
ZCBtdHJyX292ZXJ3cml0ZV9zdGF0ZShzdHJ1Y3QgbXRycl92YXJfcmFuZ2UgKnZhciwgdW5z
aWduZWQgaW50IG51bV92YXIsDQo+PiArCQkJICBtdHJyX3R5cGUgKmZpeGVkLCBtdHJyX3R5
cGUgZGVmX3R5cGUpDQo+PiArew0KPj4gKwl1bnNpZ25lZCBpbnQgaTsNCj4+ICsNCj4+ICsJ
aWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9NVFJSKSkNCj4gDQo+IGNoZWNrX2Zvcl9k
ZXByZWNhdGVkX2FwaXM6IFdBUk5JTkc6IGFyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5l
cmljLmM6MjU0OiBEbyBub3QgdXNlIGJvb3RfY3B1X2hhcygpIC0gdXNlIGNwdV9mZWF0dXJl
X2VuYWJsZWQoKSBpbnN0ZWFkLg0KPiANCj4+ICsJCXJldHVybjsNCj4gDQo+IFNvIHRoaXMg
aGVyZSBuZWVkcyB0byBjaGVjazoNCj4gDQo+IAlpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikgJiYNCj4gCSAgICAhKGNwdV9mZWF0dXJlX2VuYWJs
ZWQoWDg2X0ZFQVRVUkVfU0VWX1NOUCkgfHwNCj4gCSAgICAgIGNwdV9mZWF0dXJlX2VuYWJs
ZWQoWDg2X0ZFQVRVUkVfWEVOUFYpKSkgew0KPiAJCVdBUk5fT05fT05DRSgxKTsNCj4gCQly
ZXR1cm47DQo+IAl9DQo+IA0KPiBhcyB3ZSBkb24ndCB3YW50IHRoaXMgdG8gYmUgY2FsbGVk
IHNvbWV3aGVyZSBvciBieSBzb21ldGhpbmcgZWxzZS4NCj4gDQo+IFRoZSBTRVZfU05QIGZs
YWcgY2FuIGJlIHVzZWQgZnJvbToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyMjEyMTQxOTQwNTYuMTYxNDkyLTE0LW1pY2hhZWwucm90aEBhbWQuY29tDQo+IA0KPiBJ
J20gYXNzdW1pbmcgaGVyZSBIeXBlclYgU0VWLVNOUCBndWVzdHMgcmVhbGx5IGRvIHNldCB0
aGF0IGZlYXR1cmUgZmxhZw0KPiAodGhleSBiZXR0ZXIpLiBXZSBjYW4gZXhwZWRpdGUgdGhh
dCBwYXRjaCBvZmMuDQoNCklzIHRoYXQgZmxhZyBfcmVhbGx5XyBtZWFudCB0byBpbmRpY2F0
ZSB3ZSBhcmUgcnVubmluZyBhcyBhIFNFVi1TTlAgZ3Vlc3Q/DQoNCkdpdmVuIHRoYXQgdGhl
IHJlZmVyZW5jZWQgcGF0Y2ggaXMgcGFydCBvZiB0aGUgU0VWLVNOUCBob3N0IHN1cHBvcnQg
c2VyaWVzLA0KSSdtIGluY2xpbmVkIHRvIHN1c3BlY3QgaXQgd29uJ3QgYmUgc2V0IGZvciBz
dXJlIGluIEh5cGVyViBTRVYtU05QIGd1ZXN0cy4NCkFuZCB3aG8gaXMgc2V0dGluZyBpdCBm
b3IgS1ZNIFNFVi1TTlAgZ3Vlc3RzPw0KDQoNCkp1ZXJnZW4NCg==
--------------CBWiUEXdu0AJH9bM7gkN0hRw
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------CBWiUEXdu0AJH9bM7gkN0hRw--

--------------nvD3HbiZsMbWmwnQx4LKBhNy--

--------------GZlBcdN97K0Ko47SmRuLt09p
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPt+CwFAwAAAAAACgkQsN6d1ii/Ey9Q
Jwf/fv2NuEW5I6MAjokIy+uvtyDuUYLCvdiJK5b8axxKOnrzxlWtsfG1CjJNYrOKhKaaZ+Rp8byz
U/vuM72rUf2OBYN3KlwVeKjHvDCDcXRzNoY9sEnhTqx0dftkibjVJ6QGe8xMvYABCVSWx1tP8yWr
0s6ZFJ1dKg/zWZHSH3PworVfB6p9t4GHLV9kqC6U4bJUin95ClZaqCJIOCdOXrKuAqapm3CkLpN9
DNPORzZbqYX/012ihYGSSO4bgW0QMcEL/Dlok+obVX4oQiTEK2BbwTi+gU25u/LxD/mlSkWaZvKN
hjsImhXevxU8qvHNQCxTc+iuGc24I1m6lqHo+31uTg==
=Dyqx
-----END PGP SIGNATURE-----

--------------GZlBcdN97K0Ko47SmRuLt09p--
