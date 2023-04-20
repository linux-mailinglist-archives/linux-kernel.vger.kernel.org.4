Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18B6E980D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjDTPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDTPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:10:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4943B59F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:10:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9CC4821987;
        Thu, 20 Apr 2023 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682003404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KnDtPCkhzAtrpuMmA9PLsaQrJM4GdslHHPGUkrSuOZs=;
        b=KBKE5X8yZUUU7BSDp6Ju8Lt7qF0Zy89T1IKfG88aNUhTeamQc3Zw5o28A+UFi10Zld/wXb
        827IGDalevvQ8z2X2MnmHWwYaadRI9ecFecMq0oMwEsD/CzDoMnHiw2JiW2bgF/lXc+TBo
        xVDQ6Lma6llFIAySJomekl6wVO79sps=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D40C1333C;
        Thu, 20 Apr 2023 15:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YGznFMxVQWQfUgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Apr 2023 15:10:04 +0000
Message-ID: <bb77023b-8dd0-0551-5c16-92f184568161@suse.com>
Date:   Thu, 20 Apr 2023 17:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
 <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
 <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
In-Reply-To: <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TJ3jm9EE0tXubMfaCynt0Bto"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TJ3jm9EE0tXubMfaCynt0Bto
Content-Type: multipart/mixed; boundary="------------W2n06D8KYSGJqBmAT4asbjTU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <bb77023b-8dd0-0551-5c16-92f184568161@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
 <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
 <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>
In-Reply-To: <20230420145451.GFZEFSO6VmvXdK/qi9@fat_crate.local>

--------------W2n06D8KYSGJqBmAT4asbjTU
Content-Type: multipart/mixed; boundary="------------aPM5volxTsHyDfKEuz0jgAtA"

--------------aPM5volxTsHyDfKEuz0jgAtA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjMgMTY6NTQsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjAsIDIwMjMgYXQgMDM6NTc6NDNQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFNvIHlvdSBhcmUgc3VnZ2VzdGluZyB0aGF0IHByZWZldGNoaW5nIGNhbiBoYXBwZW4g
YWNyb3NzIG9uZSB3cm9uZyBzcGVjdWxhdGVkDQo+PiBicmFuY2gsIGJ1dCBub3QgYWNyb3Nz
IHR3byBvZiB0aGVtPyBBbmQgeW91IGFyZSBub3Qgd29ycnlpbmcgYWJvdXQgcHJlZmV0Y2hl
cw0KPj4gcGFzdCB0aGUgZW5kIG9mIGEgY29weSB3aXRoIHNpemUgPiAwPw0KPiANCj4gTWF5
YmUgaXQgd2lsbCwgbWF5YmUgaXQgd29uJ3QuDQo+IA0KPiBJIGFtIHdvcnJpZWQgYWJvdXQg
Y2FsbGluZyBhIGZ1bmN0aW9uIHVubmVjZXNzYXJpbHkuIEknbSB3b3JyaWVkIGFib3V0DQo+
IGNhbGxpbmcgdGhlIGFzbSB2ZXJzaW9uIF9fbWVtbW92ZSgpIHdpdGggemVybyBsZW5ndGgg
dW5uZWNlc3NhcmlseS4gSSdtDQo+IHdvcnJpZWQgYWJvdXQgZXhlY3V0aW5nIHRoZSByZXR1
cm4gdGh1bmsgdW5uZWNlc3NhcmlseToNCj4gDQo+IGZmZmZmZmZmODEwNGM3NDk6ICAgICAg
IDQ4IDgzIGM0IDI4ICAgICAgICAgICAgIGFkZCAgICAkMHgyOCwlcnNwDQo+IGZmZmZmZmZm
ODEwNGM3NGQ6ICAgICAgIGU5IDcyIDJhIDliIDAwICAgICAgICAgIGptcCAgICBmZmZmZmZm
ZjgxOWZmMWM0IDxfX3g4Nl9yZXR1cm5fdGh1bms+DQo+IGZmZmZmZmZmODEwNGM3NTI6ICAg
ICAgIDMxIGMwICAgICAgICAgICAgICAgICAgIHhvciAgICAlZWF4LCVlYXgNCj4gZmZmZmZm
ZmY4MTA0Yzc1NDogICAgICAgZTkgNmIgMmEgOWIgMDAgICAgICAgICAgam1wICAgIGZmZmZm
ZmZmODE5ZmYxYzQgPF9feDg2X3JldHVybl90aHVuaz4NCj4gZmZmZmZmZmY4MTA0Yzc1OTog
ICAgICAgMGYgMWYgODAgMDAgMDAgMDAgMDAgICAgbm9wbCAgIDB4MCglcmF4KQ0KPiANCj4g
SnVzdCBzYXkgdGhhdCB5b3UgZG9uJ3Qgd2FudCB0byBkbyB0aGlzIHNpbXBsZSBjaGVjayBh
bmQgSSB3aWxsIGRvIGl0DQo+IG15c2VsZiBiZWNhdXNlIEknbSB0aXJlZCBvZiBkZWJhdGlu
Zy4NCg0KSSBqdXN0IHdhbnQgdG8gbWFrZSBzdXJlIHRvIHVuZGVyc3RhbmQgeW91ciBjb25j
ZXJucyBhbmQgdGhhdCB0aGUgcmVhc29uaW5nDQppcyBzYW5lLg0KDQpZb3Ugc2VlbSB0byBm
ZWVsIHJhdGhlciBzdHJvbmcgaGVyZSwgc28gSSdsbCBhZGQgdGhlIHRlc3QuDQoNCj4gDQo+
PiAiSWYgdHdvIG9yIG1vcmUgdmFyaWFibGUgbWVtb3J5IHJhbmdlcyBtYXRjaCBhbmQgb25l
IG9mIHRoZSBtZW1vcnkgdHlwZXMgaXMgVUMsDQo+PiB0aGUgVUMgbWVtb3J5IHR5cGUgdXNl
ZC4iDQo+Pg0KPj4gU28gdGVjaG5pY2FsbHkgbm8gcHJvYmxlbSwgYXBhcnQgZnJvbSBsb3dl
ciBwZXJmb3JtYW5jZS4NCj4gDQo+IEhvdyBkbyB5b3UgY29tZSBmcm9tICJXcml0ZS1jb21i
aW5pbmcgdG8gVUMgbWVtb3J5IGlzIG5vdCBhbGxvd2VkIiB0bw0KPiAibG93ZXIgcGVyZm9y
bWFuY2UiPw0KPiANCj4gTm90IGFsbG93ZWQgaXMgbm90IGFsbG93ZWQuIEdlZXouDQoNClll
cy4gQW5kIHVzaW5nIFVDIGluc3RlYWQgb2YgV0MgdXN1YWxseSBtZWFucyBsb3dlciBwZXJm
b3JtYW5jZSBvZiB3cml0ZXMuDQoNCj4+IFdvdWxkIHlvdSBiZSBmaW5lIHdpdGggYWRkaW5n
IHRoYXQgYXMgYW4gYWRkaXRpb25hbCBwYXRjaD8NCj4+DQo+PiBJIGJlbGlldmUgaWYgd2Ug
cmVhbGx5IHdhbnQgdGhhdCwgdGhlbiB3ZSBzaG91bGQgYmUgYWJsZSB0byBkaXNhYmxlIHN1
Y2ggYQ0KPj4gY2xlYW51cC4gU28gaXQgc2hvdWxkIGJlIGFuIGFkZC1vbiBhbnl3YXkuDQo+
IA0KPiBTdXJlLCB3aGF0ZXZlci4NCg0KT2theSwgdGhhbmtzLg0KDQpJIHRoaW5rIHRoaXMg
d2lsbCBuZWVkIGFub3RoZXIgZmluYWwgbG9vcCBvdmVyIHRoZSBNVFJScyB0byBjaGVjayBh
Z2FpbnN0IHRoZQ0KY29uc3RydWN0ZWQgbWFwIGlmIGEgTVRSUiBpcyBjb21wbGV0ZWx5IHVz
ZWxlc3MuDQoNCkFub3RoZXIgcXVlc3Rpb246IGluIGNhc2Ugd2UgZGV0ZWN0IHN1Y2ggYSBo
aWRkZW4gTVRSUiwgc2hvdWxkIGl0IGJlIGRpc2FibGVkDQppbiBvcmRlciB0byBoYXZlIG1v
cmUgTVRSUnMgYXZhaWxhYmxlIGZvciBydW4tdGltZSBhZGRpbmc/DQoNCj4gDQo+PiBJJ20g
bm90IGFnYWluc3QgYWRkaW5nIHN1Y2ggYWRkaXRpb25hbCBjaGVja3MuIEkgd291bGRuJ3Qg
bGlrZSB0byBmb3JjZSB0aGVtDQo+PiBpbnRvIHRoaXMgc2VyaWVzIHJpZ2h0IG5vdywgYmVj
YXVzZSB3ZSBuZWVkIHRoaXMgc2VyaWVzIGZvciBIeXBlci1WIGlzb2xhdGVkDQo+PiBndWVz
dCBzdXBwb3J0Lg0KPiANCj4gV2Ugd2lsbCBhZGQgdGhpcyBzZXJpZXMgd2hlbiB0aGV5J3Jl
IHJlYWR5LiBJZiBIeXBlci1WIG5lZWRzIHRoZW0NCj4gaW1tZWRpYXRlbHkgdGhleSBjYW4g
dGFrZSB3aGF0ZXZlciB0aGV5IHdhbnQgYW5kIGRvIHdoYXRldmVyIHRoZXkgd2FudC4NCj4g
DQo+IE9yIHlvdSBjYW4gZG8gYSBzaW1wbGVyIGZpeCBmb3IgSHlwZXItViB0aGF0IGdvZXMg
YmVmb3JlIHRoaXMsIGlmIHlvdQ0KPiB3YW50IHRvIGFkZHJlc3MgSHlwZXItVi4NCj4gDQo+
PiBKdXN0IHRvIHNheSBpdCBleHBsaWNpdGx5OiB5b3UgYXJlIGNvbmNlcm5lZCBmb3IgdGhl
IGNhc2UgdGhhdCBhIGNvbXBsZXRlDQo+PiBNVFJSIGlzIGhpZGRlbiBiZW5lYXRoIGFub3Ro
ZXIgb25lIChlLmcuIGEgbGFyZ2UgVUMgTVRSUiBoaWRpbmcgYSBzbWFsbGVyDQo+PiBNVFJS
IHdpdGggYW5vdGhlciB0eXBlLCBvciBhIHZhcmlhYmxlIE1UUlIgYmVpbmcgaGlkZGVuIGJ5
IGZpeGVkIE1UUlJzKT8NCj4gDQo+IEkgYW0gY29uY2VybmVkIGFib3V0IGNhdGNoaW5nIGFu
eSBhbmQgYWxsIGluY29uc2lzdGVuY2llcyB3aXRoIHRoZSBNVFJScw0KPiBhbmQgY2F0Y2hp
bmcgdGhlbSByaWdodC4gSWYgd2UncmUgZ29pbmcgdG8gc3BlbmQgYWxsIHRoaXMgdGltZSBv
biB0aGlzLA0KPiB0aGVuIGxldCdzIGRvIGl0IHJpZ2h0LCBvbmNlIGFuZCBmb3IgYWxsIGFu
ZCBkbyBpdCBpbiBhIG1hbm5lciB0aGF0IGNhbg0KPiBiZSBpbXByb3ZlZCBpbiB0aGUgZnV0
dXJlLg0KDQpPa2F5Lg0KDQoNCkp1ZXJnZW4NCg0K
--------------aPM5volxTsHyDfKEuz0jgAtA
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

--------------aPM5volxTsHyDfKEuz0jgAtA--

--------------W2n06D8KYSGJqBmAT4asbjTU--

--------------TJ3jm9EE0tXubMfaCynt0Bto
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRBVcsFAwAAAAAACgkQsN6d1ii/Ey8I
xgf/TvfsCiDsNOWU2D71vjeM1mVjtkgVr2Dt1J/2mgfVQmVemoGXrkDsktA9XsAumrpvtk8GtN2O
hIrE8W9GoKVUAF2mS0YyyGxDcwxLSnZmt33emK7G1+3T1NNWWQ6DSreoVXzUDGLUHHzc5X8gHt3m
pX8etbuYp7F25JIJj8CGaghycG2Yxr8Hr3i4QxhKcnZ01tptEQnwQV1fqQsUMb0PZFHUcrLhWO1z
shDF8nJDLBzkMwNYdt70fT5KWokTe+CGVXh4w84Gpse+wx1OzA2eroyjhkYh6QssyGuLtJbaLs6z
/zeDXxESK4+oM/zjFpLgxHQqUMXX8TQsQRY9IbabAw==
=n0WK
-----END PGP SIGNATURE-----

--------------TJ3jm9EE0tXubMfaCynt0Bto--
