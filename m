Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273660720C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJUIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJUIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:21:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB8718E2AB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:21:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D1642293C;
        Fri, 21 Oct 2022 08:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666340466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uX9o9PYJhdJZeUz3Er72UTs/X4+CPAFUfI3wOc5u00g=;
        b=Gwulg3eDAvYZL60xX8YC8AYdK/Y+3fT2EYVzsutcMyfhdoqktFypfC8dxYcag/ObZW62Fg
        dal3bLbIxfkzbvHy9fxKnqWut3e4Sv/FYsjcHadRZLbCMpitJS5J0Nj5M9yjiux/uUHPYk
        SfYexHwrzaYTBn43EEYeG/tzWYKjpII=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26F9C1331A;
        Fri, 21 Oct 2022 08:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rPgECHJWUmObUQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 21 Oct 2022 08:21:06 +0000
Message-ID: <6eb2c033-ea00-8015-fe4f-0438f9790b77@suse.com>
Date:   Fri, 21 Oct 2022 10:21:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/xen: simplify sysenter and syscall setup
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20221020113619.17204-1-jgross@suse.com>
 <Y1EzXQP3/Pn3bme+@zn.tnic> <bd3e990b-e2a7-bbf0-7e2f-259e6a353393@citrix.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <bd3e990b-e2a7-bbf0-7e2f-259e6a353393@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WavFKfeHApFt8Lp6zKlzfJ03"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WavFKfeHApFt8Lp6zKlzfJ03
Content-Type: multipart/mixed; boundary="------------uP38kK7JYLb5sWnjgN4evDg9";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Andrew Cooper <Andrew.Cooper3@citrix.com>, Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <6eb2c033-ea00-8015-fe4f-0438f9790b77@suse.com>
Subject: Re: [PATCH] x86/xen: simplify sysenter and syscall setup
References: <20221020113619.17204-1-jgross@suse.com>
 <Y1EzXQP3/Pn3bme+@zn.tnic> <bd3e990b-e2a7-bbf0-7e2f-259e6a353393@citrix.com>
In-Reply-To: <bd3e990b-e2a7-bbf0-7e2f-259e6a353393@citrix.com>

--------------uP38kK7JYLb5sWnjgN4evDg9
Content-Type: multipart/mixed; boundary="------------NsylYV4bbPiEAniRCNr0uGoi"

--------------NsylYV4bbPiEAniRCNr0uGoi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMTAuMjIgMTA6MDYsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+IE9uIDIwLzEwLzIw
MjIgMTI6MzksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+IE9uIFRodSwgT2N0IDIwLCAy
MDIyIGF0IDAxOjM2OjE5UE0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4geGVu
X2VuYWJsZV9zeXNlbnRlcigpIGFuZCB4ZW5fZW5hYmxlX3N5c2NhbGwoKSBjYW4gYmUgc2lt
cGxpZmllZCBhIGxvdC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCj4+PiAtLS0NCj4+PiAgIGFyY2gveDg2L3hlbi9zZXR1cC5j
IHwgMjMgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L3hlbi9zZXR1cC5jIGIvYXJjaC94ODYveGVuL3NldHVwLmMNCj4+PiBpbmRl
eCBjZmE5OWU4ZjA1NGIuLjBmMzNlZDZkM2E3YiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4
Ni94ZW4vc2V0dXAuYw0KPj4+ICsrKyBiL2FyY2gveDg2L3hlbi9zZXR1cC5jDQo+Pj4gQEAg
LTkxMCwxNyArOTEwLDkgQEAgc3RhdGljIGludCByZWdpc3Rlcl9jYWxsYmFjayh1bnNpZ25l
ZCB0eXBlLCBjb25zdCB2b2lkICpmdW5jKQ0KPj4+ICAgDQo+Pj4gICB2b2lkIHhlbl9lbmFi
bGVfc3lzZW50ZXIodm9pZCkNCj4+PiAgIHsNCj4+PiAtCWludCByZXQ7DQo+Pj4gLQl1bnNp
Z25lZCBzeXNlbnRlcl9mZWF0dXJlOw0KPj4+IC0NCj4+PiAtCXN5c2VudGVyX2ZlYXR1cmUg
PSBYODZfRkVBVFVSRV9TWVNFTlRFUjMyOw0KPj4+IC0NCj4+PiAtCWlmICghYm9vdF9jcHVf
aGFzKHN5c2VudGVyX2ZlYXR1cmUpKQ0KPj4+IC0JCXJldHVybjsNCj4+PiAtDQo+Pj4gLQly
ZXQgPSByZWdpc3Rlcl9jYWxsYmFjayhDQUxMQkFDS1RZUEVfc3lzZW50ZXIsIHhlbl9lbnRy
eV9TWVNFTlRFUl9jb21wYXQpOw0KPj4+IC0JaWYocmV0ICE9IDApDQo+Pj4gLQkJc2V0dXBf
Y2xlYXJfY3B1X2NhcChzeXNlbnRlcl9mZWF0dXJlKTsNCj4+PiArCWlmIChib290X2NwdV9o
YXMoWDg2X0ZFQVRVUkVfU1lTRU5URVIzMikgJiYNCj4+IENhbiB5b3Ugc3dpdGNoIHRoYXQg
YW5kIGJlbG93IHRvIGNwdV9mZWF0dXJlX2VuYWJsZWQoKSB3aGlsZSBhdCBpdCwgcGxzPw0K
PiANCj4gV2h5Pw0KPiANCj4gVGhpcyBmdW5jdGlvbiAoc2hvdWxkKSBiZSBjYWxsZWQgb24g
dGhlIEJTUCBvbmx5IChiZWNhdXNlIFhlbidzIEFQSSBsZXRzDQo+IHRoaXMgYmUgc3BlY2lm
aWVkIHdoZW4gc3RhcnRpbmcgQVBzKS4NCg0KTm8sIHRoaXMgaXMgdHJ1ZSBmb3IgdGhlIHN5
c2NhbGwgY2FsbGJhY2sgb25seS4gdGhlIHN5c2VudGVyIGFuZCB0aGUgc3lzY2FsbDMyDQpj
YWxsYmFja3MgY2FuIG9ubHkgYmUgc2V0IHZpYSBYZW4gdG9vbHMgb3Igb24gdGhlIGxvY2Fs
IGNwdSBieSByZWdpc3RlcmluZy4NCg0KPiANCj4gV2hldGhlciBpdCdzIG9uY2UsIG9yIG9u
ZSBwZXIgY3B1LCBpdCBkb2Vzbid0IG1hdHRlci4NCg0KSXQgZG9lcy4NCg0KDQpKdWVyZ2Vu
DQo=
--------------NsylYV4bbPiEAniRCNr0uGoi
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------NsylYV4bbPiEAniRCNr0uGoi--

--------------uP38kK7JYLb5sWnjgN4evDg9--

--------------WavFKfeHApFt8Lp6zKlzfJ03
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNSVnEFAwAAAAAACgkQsN6d1ii/Ey/C
bggAkxDmRLgLQ3prqBFrN51n3XUJr98tqT3lMGJtyzWNw2ihVqPrg9I1L9e672N4XYd3OYzurj5h
QGHTsALHrCHgw2Y1J0d0vpjj962ByY0hoDvEqcdR3BG8sC7Nlqk/zLUwRxwg9sEZ4X38obrltrZZ
6Y/2XXDvIaammWb64pcvZpyIXb6unPy+G0UL+5KJjGTJLNXLB/keaqWXTIqSKe6iXLE7w8aA274T
DPMOywd/dmpNN8yjzYX1rUC+V7jv5mNVMi5p6qAPg9JzeLSoPAU490Q33P6a5NiIf+Aja6Zsv2Zw
0U+tTnzNOxD6bt4fYF/W2PADwFU6VFw+6L6lK1LzlA==
=zF00
-----END PGP SIGNATURE-----

--------------WavFKfeHApFt8Lp6zKlzfJ03--
