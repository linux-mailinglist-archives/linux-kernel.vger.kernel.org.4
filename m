Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11568D246
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBGJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:12:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE623846
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:12:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88A4560FED;
        Tue,  7 Feb 2023 09:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675761148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ieDQhqhMvtIeZVOGVyZ9EHW2yeVFYggP1fdTqRjwWPw=;
        b=Vc2P1BkV9tO1+P98cK8TsEy2Ra2CmmrYLd2ydrNif8RCs+MKbu8CgO+G2lSVdoEOfsmoxE
        N97MZwKkPyl4yiPPdtuKOBmWW55peXpTbNV6PeIODTgQSH+noL3xrfp2FGZniDdH5IwB1S
        NkMbBJIbUtZHDoQOYkUkBSBQg4elM+k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C67913A8C;
        Tue,  7 Feb 2023 09:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YX0qCfwV4mNFfwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 09:12:28 +0000
Message-ID: <47fcd1a8-1c5a-0044-38c4-cf04095c1150@suse.com>
Date:   Tue, 7 Feb 2023 10:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-3-jgross@suse.com> <Y+IQlJI33snDiLT1@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/6] x86/pat: check for MTRRs enabled in memtype_reserve()
In-Reply-To: <Y+IQlJI33snDiLT1@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------56CzqqYwcPQVkgangChrUD7S"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------56CzqqYwcPQVkgangChrUD7S
Content-Type: multipart/mixed; boundary="------------ygB52Fqzd40PUkLQBu5QNqll";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <47fcd1a8-1c5a-0044-38c4-cf04095c1150@suse.com>
Subject: Re: [PATCH 2/6] x86/pat: check for MTRRs enabled in memtype_reserve()
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-3-jgross@suse.com> <Y+IQlJI33snDiLT1@gmail.com>
In-Reply-To: <Y+IQlJI33snDiLT1@gmail.com>

--------------ygB52Fqzd40PUkLQBu5QNqll
Content-Type: multipart/mixed; boundary="------------Yh9nZUpsykTjqi2Snke3EUqA"

--------------Yh9nZUpsykTjqi2Snke3EUqA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDIuMjMgMDk6NDksIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IFRvZGF5IG1lbXR5cGVf
cmVzZXJ2ZSgpIGJhaWxzIG91dCBlYXJseSBpZiBwYXRfZW5hYmxlZCgpIHJldHVybnMgZmFs
c2UuDQo+PiBUaGUgc2FtZSBjYW4gYmUgZG9uZSBpbiBjYXNlIE1UUlJzIGFyZW4ndCBlbmFi
bGVkLg0KPj4NCj4+IFRoaXMgd2lsbCByZWluc3RhdGUgdGhlIGJlaGF2aW9yIG9mIG1lbXR5
cGVfcmVzZXJ2ZSgpIGJlZm9yZSBjb21taXQNCj4+IDcyY2JjOGYwNGZlMiAoIng4Ni9QQVQ6
IEhhdmUgcGF0X2VuYWJsZWQoKSBwcm9wZXJseSByZWZsZWN0IHN0YXRlIHdoZW4NCj4+IHJ1
bm5pbmcgb24gWGVuIikuIFRoZXJlIGhhdmUgYmVlbiByZXBvcnRzIGFib3V0IHRoYXQgY29t
bWl0IGJyZWFraW5nDQo+PiBTRVYtU05QIGd1ZXN0cyB1bmRlciBIeXBlci1WLCB3aGljaCB3
YXMgdHJpZWQgdG8gYmUgcmVzb2x2ZWQgYnkgY29tbWl0DQo+PiA5MGI5MjZlNjhmNTAgKCJ4
ODYvcGF0OiBGaXggcGF0X3hfbXRycl90eXBlKCkgZm9yIE1UUlIgZGlzYWJsZWQgY2FzZSIp
LA0KPj4gYnV0IHRoYXQgYWdhaW4gcmVzdWx0ZWQgaW4gcHJvYmxlbXMgd2l0aCBYZW4gUFYg
Z3Vlc3RzLg0KPj4NCj4+IEZpeGVzOiA3MmNiYzhmMDRmZTIgKCJ4ODYvUEFUOiBIYXZlIHBh
dF9lbmFibGVkKCkgcHJvcGVybHkgcmVmbGVjdCBzdGF0ZSB3aGVuIHJ1bm5pbmcgb24gWGVu
IikNCj4+IEZpeGVzOiA5MGI5MjZlNjhmNTAgKCJ4ODYvcGF0OiBGaXggcGF0X3hfbXRycl90
eXBlKCkgZm9yIE1UUlIgZGlzYWJsZWQgY2FzZSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvbW0v
cGF0L21lbXR5cGUuYyB8IDEwICsrKysrKystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvbW0vcGF0L21lbXR5cGUuYyBiL2FyY2gveDg2L21tL3BhdC9tZW10eXBlLmMNCj4+
IGluZGV4IGZiNGIxYjVlMGRlYS4uMThmNjEyYjQzNzYzIDEwMDY0NA0KPj4gLS0tIGEvYXJj
aC94ODYvbW0vcGF0L21lbXR5cGUuYw0KPj4gKysrIGIvYXJjaC94ODYvbW0vcGF0L21lbXR5
cGUuYw0KPj4gQEAgLTU1Nyw4ICs1NTcsMTIgQEAgaW50IG1lbXR5cGVfcmVzZXJ2ZSh1NjQg
c3RhcnQsIHU2NCBlbmQsIGVudW0gcGFnZV9jYWNoZV9tb2RlIHJlcV90eXBlLA0KPj4gICAJ
CXJldHVybiAtRUlOVkFMOw0KPj4gICAJfQ0KPj4gICANCj4+IC0JaWYgKCFwYXRfZW5hYmxl
ZCgpKSB7DQo+PiAtCQkvKiBUaGlzIGlzIGlkZW50aWNhbCB0byBwYWdlIHRhYmxlIHNldHRp
bmcgd2l0aG91dCBQQVQgKi8NCj4+ICsJLyoNCj4+ICsJICogUEFUIGRpc2FibGVkIG9yIE1U
UlJzIGRpc2FibGVkIGRvbid0IHJlcXVpcmUgYW55IG1lbW9yeSB0eXBlDQo+PiArCSAqIHRy
YWNraW5nIG9yIHR5cGUgYWRqdXN0bWVudHMsIGFzIHRoZXJlIGNhbid0IGJlIGFueSBjb25m
bGljdHMNCj4+ICsJICogYmV0d2VlbiBQQVQgYW5kIE1UUlJzIHdpdGggYXQgbGVhc3Qgb25l
IG9mIGJvdGggYmVpbmcgZGlzYWJsZWQuDQo+PiArCSAqLw0KPj4gKwlpZiAoIXBhdF9lbmFi
bGVkKCkgfHwgIW10cnJfZW5hYmxlZCgpKSB7DQo+PiAgIAkJaWYgKG5ld190eXBlKQ0KPj4g
ICAJCQkqbmV3X3R5cGUgPSByZXFfdHlwZTsNCj4gDQo+IERvZXNuJ3QgbWVtdHlwZV9yZXNl
cnZlKCkgYWxzbyBjaGVjayBmb3Igb3ZlcmxhcHBpbmcgcmFuZ2VzICYgdHlwZQ0KPiBjb21w
YXRpYmlsaXR5IGluIG1lbXR5cGVfY2hlY2tfY29uZmxpY3QoKSwgZXRjLiwgd2hpY2ggY2Fu
IG9jY3VyIGV2ZW4gaW4gYQ0KPiBwdXJlIFBBVCBzZXR1cD8gSWUuIGFyZSB3ZSAxMDAlIHN1
cmUgdGhhdCBpbiB0aGUgIU1UUlIgY2FzZSBpdCB3b3VsZCBiZSBhDQo+IE5PUD8NCj4gDQo+
IEJ1dCBldmVuIGlmIGl0J3MgYSBmdW5jdGlvbmFsIE5PUCBhcyB5b3UgY2xhaW0sIHdlJ2Qg
c3RpbGwgYmUgYmV0dGVyIG9mZiBpZg0KPiB0aGUgbWVtdHlwZSB0cmVlIHdhcyBzdGlsbCBp
bnRhY3QgLSBpbnN0ZWFkIG9mIGp1c3QgdHVybmluZyBvZmYgdGhlIEFQSS4NCg0KWWVzLCB0
aGF0J3MgYmFzaWNhbGx5IHRoZSBpc3N1ZSBkaXNjdXNzZWQgaW4gW3BhdGNoIDAvNl0uDQoN
Ckl0IHNob3VsZCBzdGlsbCBiZSBiZXR0ZXIgdGhhbiB0aGUgb3JpZ2luYWwgY2FzZSAoUEFU
IGFuZCBNVFJSIG9mZiwgYnV0DQp0aGUgYWJpbGl0eSB0byB1c2UgUEFUIG5ldmVydGhlbGVz
cyksIHRob3VnaC4NCg0KPiANCj4gQWxzbywgc3BlbGluZyBuaXQ6DQo+IA0KPiAgICAgcy9v
bmUgb2YgYm90aA0KPiAgICAgIC9vbmUgb3IgYm90aA0KDQpIbW0sIGJ1dCBvbmx5IGlmIEkg
ZHJvcCB0aGUgImF0IGxlYXN0Ii4gSSBkb24ndCByZWFsbHkgbWluZCBlaXRoZXIgd2F5Lg0K
DQoNCkp1ZXJnZW4NCg==
--------------Yh9nZUpsykTjqi2Snke3EUqA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Yh9nZUpsykTjqi2Snke3EUqA--

--------------ygB52Fqzd40PUkLQBu5QNqll--

--------------56CzqqYwcPQVkgangChrUD7S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPiFfsFAwAAAAAACgkQsN6d1ii/Ey/q
YAgAim/rpihkMhugugo5zwunFC68eRv84Gn+jSJFY312I7R/406i9WR7GShE7eyPYs2089GsbQLN
IoHaAEyCu8sQMrXz/QtZuUNHlD/uEC3ecCwtDvtPXj+eZ4nQg/v+m5TU2dgBdS6kkmBCrAwmvbLK
BhZj2EDw3zSclJ37pa9IPiBhTF6cmGTqupOe7koSxOdOq3RYX7nYOEMlavHH6mGq4hgCB9Gitot/
Fe33Lj4eT44htMbr2zJnUeQsZhJ3BJSIQ3IIOprTnKwHi9rJ61bE3sC2Nz/XTokd6mdH1NcBNmr4
XAFzwsdZshFAvlg7LBDgJuEbhkhO6BVsFz+VOmmn4A==
=xnHm
-----END PGP SIGNATURE-----

--------------56CzqqYwcPQVkgangChrUD7S--
