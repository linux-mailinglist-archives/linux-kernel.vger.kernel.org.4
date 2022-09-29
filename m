Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C95EF06A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiI2I1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiI2I1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:27:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C8126B52
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:27:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 813131F85D;
        Thu, 29 Sep 2022 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664440020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xRyhuXmwMkLW8QlZukWqPWaxqTYhVhbGpA0KQ8ifdM8=;
        b=BgIt661n2anXdyW6D7SP+svUANLeuiq0//ITS+gu1sg7eJWk+x88v0xanYrnYQVHgYKMm4
        1RwFbUSKfQMOStAOle29m0/GjUln8WBlPSISsW5vElok9L5MrqC5QwgH0d+H2hFPMxYuZg
        xAyvskX13zdmv3C91BNkm+tlqvXt/I0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43F6213A71;
        Thu, 29 Sep 2022 08:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1TH3DtRWNWOBGQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 29 Sep 2022 08:27:00 +0000
Message-ID: <b707e459-4e21-80f5-c676-c275528c06ae@suse.com>
Date:   Thu, 29 Sep 2022 10:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com> <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com> <YzRyaLRqWd6YSgeJ@zn.tnic>
 <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
In-Reply-To: <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LWnRAw3GXgBlglJ5NNsTIBeg"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LWnRAw3GXgBlglJ5NNsTIBeg
Content-Type: multipart/mixed; boundary="------------5WxHoVEGcQnJX10ESZlcFax9";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b707e459-4e21-80f5-c676-c275528c06ae@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
 <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com> <YzQui+rOGrM6otzp@zn.tnic>
 <c67d3887-498b-6e4d-857d-1cef7835421d@suse.com> <YzRyaLRqWd6YSgeJ@zn.tnic>
 <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>
In-Reply-To: <6d37c273-423c-fdce-c140-e5b90d723b9e@suse.com>

--------------5WxHoVEGcQnJX10ESZlcFax9
Content-Type: multipart/mixed; boundary="------------Pvv00nTI34oY5YpXg9t0w1ip"

--------------Pvv00nTI34oY5YpXg9t0w1ip
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDkuMjIgMTg6MzIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDI4LjA5LjIy
IDE4OjEyLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBXZWQsIFNlcCAyOCwgMjAy
MiBhdCAwMzo0Mzo1NlBNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+IFdvdWxk
IHlvdSBmZWVsIGJldHRlciB3aXRoIGFkZGluZyBhIG5ldyBlbnVtIG1lbWJlciBDUFVIUF9B
UF9DQUNIRUNUUkxfT05MSU5FPw0KPj4+DQo+Pj4gVGhpcyB3b3VsZCBhdm9pZCBhIHBvc3Np
YmxlIHNvdXJjZSBvZiBmYWlsdXJlIGR1cmluZyByZXN1bWUgaW4gY2FzZSBubyBzbG90DQo+
Pj4gZm9yIENQVUhQX0FQX09OTElORV9EWU4gaXMgZm91bmQgKHF1aXRlIGltcHJvYmFibGUs
IGJ1dCBpbiB0aGVvcnkgcG9zc2libGUpLg0KPj4NCj4+IExldCdzIGtlZXAgdGhhdCBpbiB0
aGUgYmFnIGZvciB0aGUgdGltZSB3aGVuIHdlIGdldCB0byBjcm9zcyB0aGF0IGJyaWRnZS4N
Cj4+DQo+Pj4gWW91IHdvdWxkbid0IHdhbnQgdG8gZG8gdGhhdCB0aGVyZSwgYXMgdGhlcmUg
YXJlIG11bHRpcGxlIHBsYWNlcyB3aGVyZQ0KPj4+IHBtX3NsZWVwX2VuYWJsZV9zZWNvbmRh
cnlfY3B1cygpIGlzIGJlaW5nIGNhbGxlZC4NCj4+DQo+PiBXZSB3YW50IGFsbCBvZiB0aGVt
LCBJJ2Qgc2F5LiBUaGV5J3JlIGFsbCBzb21lIHNvcnQgb2Ygc3VzcGVuZCBBRkFJQ1QuDQo+
PiBCdXQgeWVzLCBpZiB3ZSBnZXQgdG8gZG8gaXQsIHRoYXQgd291bGQgbmVlZCBhIHByb3Bl
ciBhdWRpdC4NCj4+DQo+Pj4gQWRkaXRpb25hbGx5IG5vdCBhbGwgY2FzZXMgYXJlIGNvbWlu
ZyBpbiB2aWENCj4+PiBwbV9zbGVlcF9lbmFibGVfc2Vjb25kYXJ5X2NwdXMoKSwgYXMgdGhl
cmUgaXMgZS5nLiBhIGNhbGwgb2YNCj4+PiBzdXNwZW5kX2VuYWJsZV9zZWNvbmRhcnlfY3B1
cygpIGZyb20ga2VybmVsX2tleGVjKCksIHdoaWNoIHdhbnRzIHRvDQo+Pj4gaGF2ZSB0aGUg
c2FtZSBoYW5kbGluZy4NCj4+DQo+PiBXaGljaCBtZWFucywgbW9yZSBoYWlyeS4NCj4+DQo+
Pj4gYXJjaF90aGF3X3NlY29uZGFyeV9jcHVzX2JlZ2luKCkgYW5kIGFyY2hfdGhhd19zZWNv
bmRhcnlfY3B1c19lbmQoKSBhcmUNCj4+PiB0aGUgZnVuY3Rpb25zIHRvIG1hcmsgc3RhcnQg
YW5kIGVuZCBvZiB0aGUgc3BlY2lhbCByZWdpb24gd2hlcmUgdGhlDQo+Pj4gZGVsYXllZCBN
VFJSIHNldHVwIHNob3VsZCBoYXBwZW4uDQo+Pg0KPj4gWWFwLCBpdCBzZWVtcyBsaWtlIHRo
ZSBiZXN0IHNvbHV0aW9uIGF0IHRoZSBtb21lbnQuIFdhbnQgbWUgdG8gZG8gYQ0KPj4gcHJv
cGVyIHBhdGNoIGFuZCB0ZXN0IGl0IG9uIHJlYWwgaHc/DQo+IA0KPiBJIGNhbiBkbyB0aGF0
Lg0KDQpPa2F5LCBsZXRzIGRlZmluZSB3aGF0IGlzIG1lYW50IGJ5ICJ0aGF0IiBqdXN0IHRv
IGJlIG9uIHRoZSBzYW1lIHBhZ2UuDQoNClRoZSBpZGVhIHRvIHVzZSBhIGhvdHBsdWcgY2Fs
bGJhY2sgc2VlbXMgdG8gYmUgcmF0aGVyIHJpc2t5IElNSE8uIEF0IGxlYXN0DQpDUFVIUF9B
UF9PTkxJTkVfRFlOIHNlZW1zIHRvIGJlIHdheSB0b28gbGF0ZSwgYXMgdGhlcmUgYXJlIHNl
dmVyYWwgZGV2aWNlDQpkcml2ZXJzIGhvb2tpbmcgaW4gd2l0aCB0aGUgc2FtZSBvciBsb3dl
ciBwcmlvcml0eSBhbHJlYWR5LiBBbmQgZGV2aWNlDQpkcml2ZXJzIG1pZ2h0IHJlbHkgb24g
UEFUIHNldHRpbmdzIGluIFBURXMgb2YgTVRSUiBiZWluZyBzZXR1cCBjb3JyZWN0bHkuDQoN
CkFub3RoZXIgcHJvYmxlbWF0aWMgY2FzZSBpcyBDUFVIUF9BUF9NSUNST0NPREVfTE9BREVS
LCB3aGljaCBpcyBleHBsaWNpdGx5DQpkb2luZyBjYWNoZSB3cml0ZWJhY2sgYW5kIGludmFs
aWRhdGlvbiwgd2hpY2ggc2VlbXMgdG8gYmUgcmlza3kgd2l0aG91dA0KaGF2aW5nIGEgc2Fu
ZSBQQVQvTVRSUiBzdGF0ZSBvZiB0aGUgcHJvY2Vzc29yLiBJdCBzaG91bGQgYmUgbm90ZWQg
dGhhdCB0aGUNCm1pY3JvY29kZSBsb2FkZXIgaXMgcmVnaXN0ZXJlZCB2aWEgbGF0ZV9pbml0
Y2FsbCgpLCBzbyBib290IGlzbid0IGFmZmVjdGVkDQpieSB0aGUgZGVsYXllZCBNVFJSL1BB
VCBpbml0IHdoZW4gYm9vdGluZy4NCg0KU28gdGhlIG9ubHkgc2VjdXJlIHdheSB0byB1c2Ug
YSBob3RwbHVnIGNhbGxiYWNrIHdvdWxkIGJlIHRvIGhhdmUgYSByYXRoZXINCmVhcmx5IHBy
ZXJlZ2lzdGVyZWQgc2xvdCBpbiBlbnVtIGNwdWhwX3N0YXRlLg0KDQpSZWdhcmRpbmcgcmVz
dW1lIGFuZCBrZXhlYyBJJ20gbm8gbG9uZ2VyIHN1cmUgZG9pbmcgdGhlIGRlbGF5ZWQgTVRS
Ui9QQVQNCmluaXQgaXMgc3VjaCBhIGdyZWF0IGlkZWEuIEl0IG1pZ2h0IHNhdmUgc29tZSBt
aWxsaXNlY29uZHMsIGJ1dCB0aGUgcmlza3MNCm1lbnRpb25lZCBhYm92ZSB3aXRoIGUuZy4g
bWljcm9jb2RlIGxvYWRpbmcgc2hvdWxkIGFwcGx5Lg0KDQpTbyByaWdodCBub3cgSSdtIGlu
Y2xpbmVkIHRvIGJlIGJldHRlciBvbiB0aGUgc2FmZSBzaWRlIGJ5IG5vdCBhZGRpbmcgYW55
DQpjcHUgaG90cGx1ZyBob29rLCBidXQgdG8gdXNlIGp1c3QgdGhlIHNhbWUgImRlbGF5ZWQg
QVAgaW5pdCIgZmxhZyBhcyB0b2RheSwNCmp1c3QgcmVuYW1pbmcgaXQuIFRoaXMgd291bGQg
bGVhdmUgdGhlIGRlbGF5ZWQgTVRSUi9QQVQgaW5pdCBpbiBwbGFjZSBmb3INCnJlc3VtZSBh
bmQga2V4ZWMgY2FzZXMsIGJ1dCBkZWZlcnJpbmcgdGhlIE1UUlIvUEFUIGNsZWFudXAgZHVl
IHRvIHRoaXMNCnBvdGVudGlhbCBpc3N1ZSBzZWVtcyBub3QgYXBwcm9wcmlhdGUsIGFzIHRo
ZSBjbGVhbnVwIGlzbid0IGNoYW5naW5nIHRoZQ0KYmVoYXZpb3IgaGVyZS4NCg0KV2Ugc2hv
dWxkLCBob3dldmVyLCBoYXZlIGEgZGlzY3Vzc2lvbiBpbiBwYXJhbGxlbCBvciBsYXRlciwg
d2hldGhlciB0aGUNCndob2xlIHRoYXdfc2Vjb25kYXJ5X2NwdXMoKSBoYW5kbGluZyBpcyBy
ZWFsbHkgb2theSBvciB3aGV0aGVyIGl0IHNob3VsZA0KYmUgY2hhbmdlZCBpbiBzb21lIHdh
eS4NCg0KDQpKdWVyZ2VuDQo=
--------------Pvv00nTI34oY5YpXg9t0w1ip
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Pvv00nTI34oY5YpXg9t0w1ip--

--------------5WxHoVEGcQnJX10ESZlcFax9--

--------------LWnRAw3GXgBlglJ5NNsTIBeg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM1VtMFAwAAAAAACgkQsN6d1ii/Ey9S
Gwf+M4ca1gLNxUnvM+fmZIU2oIjgjBJ8/gX6wP3u15uRs3/Nmn/gcSfxWAP44hsxI7niAs7Xi9S6
QLjCNnpYIczLk/6OTycvn4Zt/FiCZhka2Iqwok/9EDtBH6w99vkPribqkKjSB/Ys/LGpxjrg+kML
7NEu9DLFAhrjO28FHRfzdNmu8MOIw6KFUHBQqWsCi0xrs1BDXkAcdaQ07zz8fBC2XjXAQyyx72me
C7N8xDlim/lWs40PkvwR0DQ6st6FH+CDVPAICM5Ik7CVDL1KJMJxpKiweRzc3QQ6SbC/bAimt554
J7g6rxmfyuMoBEmyyFsqsEDTCMzsDxcfejMpk67FYw==
=NUqX
-----END PGP SIGNATURE-----

--------------LWnRAw3GXgBlglJ5NNsTIBeg--
