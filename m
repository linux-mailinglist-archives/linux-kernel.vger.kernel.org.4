Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5B640012
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiLBF4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiLBF4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:56:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780CCDC4F9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:56:49 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E97AA21C26;
        Fri,  2 Dec 2022 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669960607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e5Qhleh6hKXDm+oqXFN78ksEK0h92aJ1A16NTsWbdQc=;
        b=jChMQqbMNkMKV9L5cXPawPWr06sqNz44TIwIoU3UMBhtnQarm1zBg2jHxogYwyfbcZr2Iy
        F9vu33XV/9WPUw8GoDpQaldOkTEtLRY+qghZ+3uOqQveNu+Zs5TijGHvZ47XgxrKSuUDvg
        KlaR5RRMBMjiXJxYZXZHWTgaFaStcD4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 99FFC13644;
        Fri,  2 Dec 2022 05:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IqgwJJ+TiWOEXwAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 02 Dec 2022 05:56:47 +0000
Message-ID: <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
Date:   Fri, 2 Dec 2022 06:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
In-Reply-To: <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FjbS7qxI0TTMsfUjM4LdOINs"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FjbS7qxI0TTMsfUjM4LdOINs
Content-Type: multipart/mixed; boundary="------------76nko0n3mx0T0TvaaFdczH0M";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
In-Reply-To: <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>

--------------76nko0n3mx0T0TvaaFdczH0M
Content-Type: multipart/mixed; boundary="------------qIRlnUsnE0YoorvkOvYRKO4j"

--------------qIRlnUsnE0YoorvkOvYRKO4j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTIuMjIgMDA6NTcsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gVGh1
LCBEZWMgMDEsIDIwMjIgYXQgMDU6MzM6MjhQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IE9uIDAxLjEyLjIyIDE3OjI2LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+
Pj4gT24gV2VkLCBOb3YgMDIsIDIwMjIgYXQgMDg6NDc6MTBBTSArMDEwMCwgSnVlcmdlbiBH
cm9zcyB3cm90ZToNCj4+Pj4gVG9kYXkgUEFUIGlzIHVzYWJsZSBvbmx5IHdpdGggTVRSUiBi
ZWluZyBhY3RpdmUsIHdpdGggc29tZSBuYXN0eSB0d2Vha3MNCj4+Pj4gdG8gbWFrZSBQQVQg
dXNhYmxlIHdoZW4gcnVubmluZyBhcyBYZW4gUFYgZ3Vlc3QsIHdoaWNoIGRvZXNuJ3Qgc3Vw
cG9ydA0KPj4+PiBNVFJSLg0KPj4+Pg0KPj4+PiBUaGUgcmVhc29uIGZvciB0aGlzIGNvdXBs
aW5nIGlzLCB0aGF0IGJvdGgsIFBBVCBNU1IgY2hhbmdlcyBhbmQgTVRSUg0KPj4+PiBjaGFu
Z2VzLCByZXF1aXJlIGEgc2ltaWxhciBzZXF1ZW5jZSBhbmQgc28gZnVsbCBQQVQgc3VwcG9y
dCB3YXMgYWRkZWQNCj4+Pj4gdXNpbmcgdGhlIGFscmVhZHkgYXZhaWxhYmxlIE1UUlIgaGFu
ZGxpbmcuDQo+Pj4+DQo+Pj4+IFhlbiBQViBQQVQgaGFuZGxpbmcgY2FuIHdvcmsgd2l0aG91
dCBNVFJSLCBhcyBpdCBqdXN0IG5lZWRzIHRvIGNvbnN1bWUNCj4+Pj4gdGhlIFBBVCBNU1Ig
c2V0dGluZyBkb25lIGJ5IHRoZSBoeXBlcnZpc29yIHdpdGhvdXQgdGhlIGFiaWxpdHkgYW5k
IG5lZWQNCj4+Pj4gdG8gY2hhbmdlIGl0LiBUaGlzIGluIHR1cm4gaGFzIHJlc3VsdGVkIGlu
IGEgY29udm9sdXRlZCBpbml0aWFsaXphdGlvbg0KPj4+PiBzZXF1ZW5jZSBhbmQgd3Jvbmcg
ZGVjaXNpb25zIHJlZ2FyZGluZyBjYWNoZSBtb2RlIGF2YWlsYWJpbGl0eSBkdWUgdG8NCj4+
Pj4gbWlzZ3VpZGluZyBQQVQgYXZhaWxhYmlsaXR5IGZsYWdzLg0KPj4+Pg0KPj4+PiBGaXgg
YWxsIG9mIHRoYXQgYnkgYWxsb3dpbmcgdG8gdXNlIFBBVCB3aXRob3V0IE1UUlIgYW5kIGJ5
IHJld29ya2luZw0KPj4+PiB0aGUgY3VycmVudCBQQVQgaW5pdGlhbGl6YXRpb24gc2VxdWVu
Y2UgdG8gbWF0Y2ggYmV0dGVyIHdpdGggdGhlIG5ld2x5DQo+Pj4+IGludHJvZHVjZWQgZ2Vu
ZXJpYyBjYWNoZSBpbml0aWFsaXphdGlvbi4NCj4+Pj4NCj4+Pj4gVGhpcyByZW1vdmVzIHRo
ZSBuZWVkIG9mIHRoZSByZWNlbnRseSBhZGRlZCBwYXRfZm9yY2VfZGlzYWJsZWQgZmxhZywg
c28NCj4+Pj4gcmVtb3ZlIHRoZSByZW1uYW50cyBvZiB0aGUgcGF0Y2ggYWRkaW5nIGl0Lg0K
Pj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+DQo+Pj4NCj4+PiBUaGlzIHBhdGNoIGJyZWFrcyBib290IGZvciBURFggZ3Vlc3QuDQo+
Pj4NCj4+PiBLZXJuZWwgbm93IHRyaWVzIHRvIHNldCBDUjAuQ0Qgd2hpY2ggaXMgZm9yYmlk
ZGVuIGluIFREWCBndWVzdFsxXSBhbmQNCj4+PiBjYXVzZXMgI1ZFOg0KPj4+DQo+Pj4gCXRk
eDogVW5leHBlY3RlZCAjVkU6IDI4DQo+Pj4gCVZFIGZhdWx0OiAwMDAwIFsjMV0gUFJFRU1Q
VCBTTVAgTk9QVEkNCj4+PiAJQ1BVOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyIE5vdCB0YWlu
dGVkIDYuMS4wLXJjMS0wMDAxNS1nYWRmZTc1MTJlMWQwICMyNjQ2DQo+Pj4gCUhhcmR3YXJl
IG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDAuMC4w
IDAyLzA2LzIwMTUNCj4+PiAJUklQOiAwMDEwOm5hdGl2ZV93cml0ZV9jcjAgKGFyY2gveDg2
L2tlcm5lbC9jcHUvY29tbW9uLmM6NDI3KQ0KPj4+IAkgQ2FsbCBUcmFjZToNCj4+PiAJICA8
VEFTSz4NCj4+PiAJID8gY2FjaGVfZGlzYWJsZSAoYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1
ZmVhdHVyZS5oOjE3MyBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jOjEwODUpDQo+
Pj4gCSA/IGNhY2hlX2NwdV9pbml0IChhcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5j
OjExMzIgKGRpc2NyaW1pbmF0b3IgMykpDQo+Pj4gCSA/IHNldHVwX2FyY2ggKGFyY2gveDg2
L2tlcm5lbC9zZXR1cC5jOjEwNzkpDQo+Pj4gCSA/IHN0YXJ0X2tlcm5lbCAoaW5pdC9tYWlu
LmM6Mjc5IChkaXNjcmltaW5hdG9yIDMpIGluaXQvbWFpbi5jOjQ3NyAoZGlzY3JpbWluYXRv
ciAzKSBpbml0L21haW4uYzo5NjAgKGRpc2NyaW1pbmF0b3IgMykpDQo+Pj4gCSA/IGxvYWRf
dWNvZGVfYnNwIChhcmNoL3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9jb3JlLmM6MTU1KQ0K
Pj4+IAkgPyBzZWNvbmRhcnlfc3RhcnR1cF82NF9ub192ZXJpZnkgKGFyY2gveDg2L2tlcm5l
bC9oZWFkXzY0LlM6MzU4KQ0KPj4+IAkgIDwvVEFTSz4NCj4+Pg0KPj4+IEFueSBzdWdnZXN0
aW9uIGhvdyB0byBmaXggaXQ/DQo+Pj4NCj4+PiBbMV0gU2VjdGlvbiAxMC42LjEuICJDUjAi
LCBodHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29udGVudC83MzM1NjgNCj4+
DQo+PiBXaGF0IHdhcyB0aGUgc29sdXRpb24gYmVmb3JlPw0KPj4NCj4+IEkgZ3Vlc3MgTVRS
UiB3YXMgZGlzYWJsZWQsIHNvIHRoZXJlIHdhcyBubyBQQVQsIHRvbz8NCj4gDQo+IFJpZ2h0
Og0KPiANCj4gTGludXMnIHRyZWU6DQo+IA0KPiBbICAgIDAuMDAyNTg5XSBsYXN0X3BmbiA9
IDB4NDgwMDAwIG1heF9hcmNoX3BmbiA9IDB4MTAwMDAwMDAwMDANCj4gWyAgICAwLjAwMzk3
Nl0gRGlzYWJsZWQNCj4gWyAgICAwLjAwNDQ1Ml0geDg2L1BBVDogTVRSUnMgZGlzYWJsZWQs
IHNraXBwaW5nIFBBVCBpbml0aWFsaXphdGlvbiB0b28uDQo+IFsgICAgMC4wMDU4NTZdIENQ
VSBNVFJScyBhbGwgYmxhbmsgLSB2aXJ0dWFsaXplZCBzeXN0ZW0uDQo+IFsgICAgMC4wMDY5
MTVdIHg4Ni9QQVQ6IENvbmZpZ3VyYXRpb24gWzAtN106IFdCICBXVCAgVUMtIFVDICBXQiAg
V1QgIFVDLSBVQw0KPiANCj4gdGlwL21hc3RlcjoNCj4gDQo+IFsgICAgMC4wMDM0NDNdIGxh
c3RfcGZuID0gMHgyMGI4ZSBtYXhfYXJjaF9wZm4gPSAweDEwMDAwMDAwMDAwDQo+IFsgICAg
MC4wMDUyMjBdIERpc2FibGVkDQo+IFsgICAgMC4wMDU4MThdIHg4Ni9QQVQ6IENvbmZpZ3Vy
YXRpb24gWzAtN106IFdCICBXQyAgVUMtIFVDICBXQiAgV1AgIFVDLSBXVA0KPiBbICAgIDAu
MDA3NzUyXSB0ZHg6IFVuZXhwZWN0ZWQgI1ZFOiAyOA0KPiANCj4gVGhlIGRhbmdsaW5nICJE
aXNhYmxlZCIgY29tZXMgbXRycl9icF9pbml0KCkuDQo+IA0KPiANCj4+IElmIHRoaXMgaXMg
dGhlIGNhc2UsIHlvdSBjYW4gZ28gdGhlIHNhbWUgcm91dGUgYXMgWGVuIFBWIGd1ZXN0cyBk
by4NCj4gDQo+IEFueSByZWFzb24gWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUiBjYW5ub3QgYmUg
dXNlZCBpbnN0ZWFkIG9mDQo+IFg4Nl9GRUFUVVJFX1hFTlBWIHRoZXJlPw0KPiANCj4gRG8g
d2UgaGF2ZSBhbnkgdmlydHVhbGl6ZWQgcGxhdGZvcm0gdGhhdCBzdXBwb3J0cyBpdD8NCg0K
WWVzLCBvZiBjb3Vyc2UuIEFueSBoYXJkd2FyZSB2aXJ0dWFsaXplZCBndWVzdCBzaG91bGQg
YmUgYWJsZSB0byB1c2UgaXQsDQpvYnZpb3VzbHkgVERYIGd1ZXN0cyBhcmUgdGhlIGZpcnN0
IG9uZXMgbm90IGJlaW5nIGFibGUgdG8gZG8gc28uDQoNCkFuZCBhYm92ZSBkbWVzZyBzbmlw
cGxldHMgYXJlIHNob3dpbmcgcmF0aGVyIG5pY2VseSB0aGF0IG5vdCBkaXNhYmxpbmcNClBB
VCBjb21wbGV0ZWx5IHNob3VsZCBiZSBhIGJlbmVmaXQgZm9yIFREWCBndWVzdHMsIGFzIGFs
bCBjYWNoaW5nIG1vZGVzDQp3b3VsZCBiZSB1c2FibGUgKHRoZSBQQVQgTVNSIHNlZW1zIHRv
IGJlIGluaXRpYWxpemVkIHF1aXRlIGZpbmUpLg0KDQpJbnN0ZWFkIG9mIFg4Nl9GRUFUVVJF
X1hFTlBWIHdlIGNvdWxkIGludHJvZHVjZSBzb21ldGhpbmcgbGlrZQ0KWDg2X0ZFQVRVUkVf
UEFUX1JFQURPTkxZLCB3aGljaCBjb3VsZCBiZSBzZXQgZm9yIFhlbiBQViBndWVzdHMgYW5k
IGZvcg0KVERYIGd1ZXN0cy4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------qIRlnUsnE0YoorvkOvYRKO4j
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------qIRlnUsnE0YoorvkOvYRKO4j--

--------------76nko0n3mx0T0TvaaFdczH0M--

--------------FjbS7qxI0TTMsfUjM4LdOINs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOJk58FAwAAAAAACgkQsN6d1ii/Ey+S
/Af+PyEyZm2dU+IxGwY94OS9XLzapGBBKCAR1CEKwP2LnIBBwYmsL1U31R5IDJWd+vCf2HUI+CYT
mHqHdlnmSugpiJohi3r3QFt9jDUVskdIGRO7jkBfDQ+ycvJ6TIPbQymZlv2z+2I4uuixIWZ9NGMS
lWfXgdjoQNgPSiigRm602tCm1yp+wAt7MDn1bn+fVmDi5CXW8C03D7ftA3l9zPRIwseyUfO0vFmO
4nRLPywvZSBEeHxA/ooVR+cYLat4W3sVf6NC15s0rVC9noFphvzs5W4LZDHORi2ZuDxvPK5JFwC7
HnQ03/2FyVQNTbdPkt0hdLolxrolnZ7ExaP4ek1k9w==
=npWI
-----END PGP SIGNATURE-----

--------------FjbS7qxI0TTMsfUjM4LdOINs--
