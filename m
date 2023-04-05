Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005F6D75ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbjDEH4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbjDEH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:56:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15330CD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:56:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01B7322A08;
        Wed,  5 Apr 2023 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680681365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOVxNB8HtRAB/vrvcBSvvaaCDbPjbTPMfGPoFO/sRm4=;
        b=MXqjiYOyqECzjydT+vgseWpLNhB/g74XCGJkiT5MnY1wT6S50fTJoV0wuwV4gcwSma3tGy
        y17GJ47+XviQYpHu1N4Mke8OBXYLRifYX4uOh5HEg7boeAez7LWPwTdvbfYwIuUkNl2Zyg
        906G6qndhsX0bYCI1FCRDxDRqbZ5LjI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA76E13A10;
        Wed,  5 Apr 2023 07:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O3X7K5QpLWQdMAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 05 Apr 2023 07:56:04 +0000
Message-ID: <1231926a-5d03-5631-a376-b0d738c7e25c@suse.com>
Date:   Wed, 5 Apr 2023 09:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-4-jgross@suse.com>
 <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IQYPkb0olrMzgzmmwqI5EqBt"
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IQYPkb0olrMzgzmmwqI5EqBt
Content-Type: multipart/mixed; boundary="------------Ybu5ECOuFbD4KD4ejV9tEQgT";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1231926a-5d03-5631-a376-b0d738c7e25c@suse.com>
Subject: Re: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-4-jgross@suse.com>
 <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
In-Reply-To: <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>

--------------Ybu5ECOuFbD4KD4ejV9tEQgT
Content-Type: multipart/mixed; boundary="------------VcCcozEGVP00090GMJEfK0nT"

--------------VcCcozEGVP00090GMJEfK0nT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDQuMjMgMTg6MDMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBB
cHIgMDEsIDIwMjMgYXQgMDg6MzY6NDBBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEBAIC02NDMsMTAgKzY0NiwxMiBAQCBzdGF0aWMgYm9vbCBzZXRfbXRycl92YXJfcmFu
Z2VzKHVuc2lnbmVkIGludCBpbmRleCwgc3RydWN0IG10cnJfdmFyX3JhbmdlICp2cikNCj4+
ICAgCXVuc2lnbmVkIGludCBsbywgaGk7DQo+PiAgIAlib29sIGNoYW5nZWQgPSBmYWxzZTsN
Cj4+ICAgDQo+PiArI2RlZmluZSBCQVNFX01BU0sJKE1UUlJfQkFTRV9UWVBFX01BU0sgfCAo
c2l6ZV9hbmRfbWFzayA8PCBQQUdFX1NISUZUKSkNCj4+ICsjZGVmaW5lIE1BU0tfTUFTSwko
TVRSUl9NQVNLX1ZBTElEIHwgKHNpemVfYW5kX21hc2sgPDwgUEFHRV9TSElGVCkpDQo+IA0K
PiBObywgIk1BU0tfTUFTSyIgaXMgdG9vIG11Y2guIDotKQ0KDQpBbnkgYmV0dGVyIHN1Z2dl
c3Rpb24gZm9yIHRoZSBuYW1lPyA6LSkNCg0KPiBBbnl3YXksIHNvIEkgc3RhcnRlZCBsb29r
aW5nIGF0IHRoaXMgYW5kIGhlcmUncyB3aGF0IEknbSBzZWVpbmcgb24gbXkNCj4gbWFjaGlu
ZSBldmVuIHdpdGggdGhlIG9sZCBjb2RlOg0KPiANCj4gICAgICAgICAgcmRtc3IoTVRSUnBo
eXNCYXNlX01TUihpbmRleCksIGxvLCBoaSk7DQo+ICAgICAgICAgIGlmICgodnItPmJhc2Vf
bG8gJiAweGZmZmZmMGZmVUwpICE9IChsbyAmIDB4ZmZmZmYwZmZVTCkNCj4gICAgICAgICAg
ICAgIHx8ICh2ci0+YmFzZV9oaSAmIChzaXplX2FuZF9tYXNrID4+ICgzMiAtIFBBR0VfU0hJ
RlQpKSkgIT0NCj4gICAgICAgICAgICAgICAgICAoaGkgJiAoc2l6ZV9hbmRfbWFzayA+PiAo
MzIgLSBQQUdFX1NISUZUKSkpKSB7DQo+IA0KPiANCj4gc2l6ZV9hbmRfbWFzazoJCTB4MDAw
MDAwMGZmZmYwMDAwMA0KPiB0aGUgc2hpZnRlZCB2ZXJzaW9uOgkweDAwMDAwMDAwMDAwMGZm
ZmYNCj4gDQo+IHdoaWNoIGlzIGJpdHMgWzE1OjBdDQo+IA0KPiBOb3csIGxvb2tpbmcgYXQg
TVRSUnBoeXNCYXNlX01TUidzIGRlZmluaXRpb24sIHRoZSBoaWdoIDMyIGJpdHMgYXJlOg0K
PiANCj4gWzYzIC4uLiByZXNlcnZlZCAuLi4gXVsgbWF4X2FkZHIgLi4uIDMyIF0NCj4gDQo+
IGFuZCB0aGF0IHNlY29uZCBzbGljZTogZnJvbSBtYXhfYWRkciB0byB0aGUgMzJuZCBiaXQg
b2YgdGhlIHdob2xlIE1TUiBpcw0KPiB0aGUgc2Vjb25kIHBhcnQgb2YgUGh5c0Jhc2UuDQo+
IA0KPiBtYXhfYWRkciBha2EgcGh5c19hZGRyIGNvbWVzIGZyb206DQo+IA0KPiAJcGh5c19h
ZGRyID0gY3B1aWRfZWF4KDB4ODAwMDAwMDgpICYgMHhmZjsNCj4gDQo+IG9uIHRoYXQgbWFj
aGluZSwgdGhhdCB2YWx1ZSBpcyA0OC4NCj4gDQo+IFdoaWNoIG1lYW5zLCB0aGUgcGh5c2Fk
ZHIgc2xpY2Ugc2hvdWxkIGJlIFs0OCAuLiAzMl0sIGkuZS4sDQo+IA0KPiAJMHgwMDAxZmZm
ZjAwMDAwMDAwDQoNCk5vLiBUaGUgIjQ4IiBpcyB0aGUgX251bWJlcl8gb2YgcGh5c2ljYWwg
YWRkcmVzcyBiaXRzLCBzbyB0aGUgNjQgYml0IGFkZHJlc3MNCm1hc2sgd2lsbCBiZSAwMDAw
ZmZmZi5mZmZmZmZmZiAoNDggYml0cyBzZXQpLg0KDQo+IA0KPiBhbmQgd2hlbiB5b3Ugc2hp
ZnQgdGhhdCBieSAzMiBzbyB0aGF0IGl0IGNhbiBiZSBBTkRlZCB3aXRoIHRoZSBoaWdoDQo+
IHBvcnRpb24gb2YgdGhlIE1TUiwgaXQgYmVjb21lcw0KPiANCj4gMHgwMDAwMDAwMDAwMDFm
ZmZmDQo+IA0KPiBpLmUuLCBiaXQgMTYgaXMgc2V0IHRvby4NCj4gDQo+IEFuZCB0aGF0IG1h
eCBhZGRyZXNzIGNhbiBiZSB1cCB0byA1MToNCj4gDQo+ICJSYW5nZSBQaHlzaWNhbCBCYXNl
LUFkZHJlc3MgKFBoeXNCYXNlKeKAlEJpdHMgNTE6MTIuIFRoZSBtZW1vcnktcmFuZ2UgYmFz
ZS1hZGRyZXNzIGluDQo+IHBoeXNpY2FsLWFkZHJlc3Mgc3BhY2UuIFBoeXNCYXNlIGlzIGFs
aWduZWQgb24gYSA0LUtieXRlIChvciBncmVhdGVyKSBhZGRyZXNzIGluIHRoZSA1Mi1iaXQN
Cj4gcGh5c2ljYWwtYWRkcmVzcyBzcGFjZSBzdXBwb3J0ZWQgYnkgdGhlIEFNRDY0IGFyY2hp
dGVjdHVyZS4gUGh5c0Jhc2UgcmVwcmVzZW50cyB0aGUgbW9zdC0NCj4gc2lnbmlmaWNhbnQg
NDAtYWRkcmVzcyBiaXRzIG9mIHRoZSBwaHlzaWNhbCBhZGRyZXNzLiBQaHlzaWNhbC1hZGRy
ZXNzDQo+IGJpdHMgMTE6MCBhcmUgYXNzdW1lZCB0byBiZSAwLiINCj4gDQo+IExvbmcgc3Rv
cnkgc2hvcnQsIHNpemVfYW5kX21hc2sgbmVlZHMgdG8gYmUgZG9uZSBmcm9tDQo+IA0KPiAJ
c2l6ZV9hbmRfbWFzayA9IH5zaXplX29yX21hc2sgJiAweGZmZmZmMDAwMDBVTEw7DQo+IA0K
PiB0bw0KPiANCj4gCXNpemVfYW5kX21hc2sgPSB+c2l6ZV9vcl9tYXNrICYgR0VOTUFTS19V
TEwocGh5c19hZGRyLCAyMCk7DQoNClRoaXMgbXVzdCBiZSBwaHlzX2FkZHIgLSAxLCBhcyB3
ZSBzdGFydCB0byBjb3VudCB3aXRoIGJpdCAwLg0KDQo+IA0KPiBzaXplX29yX21hc2sgYml0
cyBhbHJlYWR5IHRvb2sgaW50byBjb25zaWRlcmF0aW9uIHRoZSBwaHlzX2FkZHI6DQo+IA0K
PiAJc2l6ZV9vcl9tYXNrID0gU0laRV9PUl9NQVNLX0JJVFMocGh5c19hZGRyKTsNCj4gDQo+
IGFuZCBzaXplX2FuZF9tYXNrIG5lZWRzIHRvIGRvIGl0IHRvby4NCj4gDQo+IFJpZ2h0Pw0K
PiANCj4gSSdsbCB0ZXN0IHRoaXMgb24gdGhlIGJveGVzIGhlcmUgZXZlcnl3aGVyZS4gSSBn
dWVzcyB0aGlzIGdldHMgaGl0IG9ubHkNCj4gb24gYm94ZXMgd2hlcmUgdGhlIHBoeXNfYWRk
ciBvZiB0aGUgdmFyaWFibGUgTVRSUnMgZ29lcyBvdmVyIHRoZSAxNg0KPiBiaXRzLg0KPiAN
Cj4gQXMgdG8gdGhpcyBwYXRjaDogcGxlYXNlIG1ha2UgYWxsIHRoZSBiaXQgYW5kIG1hc2sg
ZGVmaW5pdGlvbnMgeW91J3JlDQo+IGFkZGluZyBhcyBjbG9zZSB0byB0aGUgTVRSUiBiaXQg
YW5kIG1hc2sgZGVmaW5pdGlvbiBuYW1lcyBpbiB0aGUNCj4gQVBNK1NETS4gSSd2ZSBzdGFy
dGVkIHRoaXMgYWxyZWFkeSAob250b3Agb2YgeW91cnMpOg0KDQpPa2F5Lg0KDQoNCkp1ZXJn
ZW4NCg==
--------------VcCcozEGVP00090GMJEfK0nT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------VcCcozEGVP00090GMJEfK0nT--

--------------Ybu5ECOuFbD4KD4ejV9tEQgT--

--------------IQYPkb0olrMzgzmmwqI5EqBt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQtKY8FAwAAAAAACgkQsN6d1ii/Ey8m
6wf+KO3iTJGZQrcDvgDCOqpSfswsNY4aYRcFlURCVgHK2a7hUB2pR6qTbkcpSyExdyPaZTHe5deD
4q05pl0F9SF3A2rYUOL/s/IER1hMVL4zBjGazXbqqxP9j0BPbDkjGkB24JDjaE5/7+Q2J/3cDytt
rKR+VBsu5NBo0vrY2DHyPbWWcTwLOkAhKytYaCLsL/YUM3RoZ3SG4rPHVSDXi9Qe7anyzE757/Bq
AgKs+Uoq2ypUHvNNtiwPQ/UeC3zUgjEUmxOOqdl/l49tjqJHZdIP43fr90EAV2FwF24VoolLgXLd
nxCHgp3VfMRUzU81EH9rIVIhYD+nvosGeJw9xC77tg==
=F5pu
-----END PGP SIGNATURE-----

--------------IQYPkb0olrMzgzmmwqI5EqBt--
