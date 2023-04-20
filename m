Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844116E966E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDTN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjDTN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:57:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3B1FC7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:57:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D3C2218FC;
        Thu, 20 Apr 2023 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681999064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chsE1MOdHhOi8raP+kjLKuQ+yClAsiPnVXZ4L0IfJRM=;
        b=PRNsFEVG0MgRex5T5v13ZRuU7v5iAnEN0saOywuuLSmQZuo77+CaCDPSaDq+BoK8gSL3sO
        KemHT9ivl/9G9sffxtM5R5dz1WFC0Cn4gHyPN71X3MYB2lfBf4pSaIxmDLwMUA8XhV0J52
        0htk5KIQegHuYtmMzM9sFAhxFn59lBc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2766E13584;
        Thu, 20 Apr 2023 13:57:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P73IB9hEQWTxKAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Apr 2023 13:57:44 +0000
Message-ID: <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
Date:   Thu, 20 Apr 2023 15:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
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
Content-Language: en-US
In-Reply-To: <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ckv1scanN7lk60nwTgombUj7"
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
--------------ckv1scanN7lk60nwTgombUj7
Content-Type: multipart/mixed; boundary="------------VS8wYEdJM0vlplTdr1zdIb32";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <681c5d8e-0e42-07e1-f91c-7696a2360f1c@suse.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
 <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
 <d164d84b-6773-36e3-1136-672072e9233d@suse.com>
 <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>
In-Reply-To: <20230420130113.GCZEE3mfOTxcDn6e3/@fat_crate.local>

--------------VS8wYEdJM0vlplTdr1zdIb32
Content-Type: multipart/mixed; boundary="------------rdhkmtQKTlXqPbllHZEaCRxM"

--------------rdhkmtQKTlXqPbllHZEaCRxM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjMgMTU6MDEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjAsIDIwMjMgYXQgMDI6MzA6MDlQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9UT0ggdGhlIGFkZGl0aW9uYWwgY29tcGFyZSB0byAwIGhhcyBjb3N0cywgdG9vLCBh
bmQgdGhpcyBjb3N0IGlzIHNwZW50IGZvcg0KPj4gQUxMIGNhbGxzDQo+IA0KPiBJJ2xsIHRh
a2UgdGhlIGNvc3Qgb2YgYSBzaW5nbGUNCj4gDQo+IAljbXBsICAgICVlZGksICVlZHgNCj4g
DQo+IGZvciBhIGhhbmRmdWwgb2YgZW50cmllcyBhbnkgZGF5IG9mIHRoZSB3ZWVrLg0KPiAN
Cj4+IHdoaWxlIHRoZSB6ZXJvIHNpemUgY2FsbCBpcyBhIHJhdGhlciByYXJlIGNhc2UuDQo+
IA0KPiAkIGdyZXAgIm1lbW1vdmUgc2l6ZSIgL3RtcC9tdHJyLnR4dA0KPiBtZW1tb3ZlIHNp
emUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiBtZW1tb3ZlIHNp
emUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiBtZW1tb3ZlIHNp
emUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiBtZW1tb3ZlIHNp
emUgMA0KPiBtZW1tb3ZlIHNpemUgMA0KPiANCj4gZm9yIC0gSSBhZG1pdCBhIGxhcmdlbHkg
Y29udHJpdmVkIG1hcCAtIGJ1dCA1IGVudHJpZXMgb25seToNCj4gDQo+IEN1cnJlbnQgbWFw
Og0KPiAwOiBzdGFydDogMHgwMDAwMDAwMDAwMDAwMDAwLCBlbmQ6IDB4MDAwMDAwMDAwMDEw
MDAwMCwgdHlwZTogMHgwDQo+IDE6IHN0YXJ0OiAweDAwMDAwMDAxMDAwMDAwMDAsIGVuZDog
MHgwMDAwMDAwODIwMDAwMDAwLCB0eXBlOiAweDYNCj4gMjogc3RhcnQ6IDB4MDAwMDUwZDcw
MDAwYzAwMCwgZW5kOiAweDAwMDA2MmE2MDAwMGMwMDAsIHR5cGU6IDB4NA0KPiAzOiBzdGFy
dDogMHgwMDAwNjJhNjAwMDBjMDAwLCBlbmQ6IDB4MDAwMWQ2ZDIwMDAwMTAwMCwgdHlwZTog
MHgwDQo+IDQ6IHN0YXJ0OiAweDAwMDFkNmQyMDAwMDEwMDAsIGVuZDogMHgwMDAxZGQ4MTAw
MDAxMDAwLCB0eXBlOiAweDYNCj4gDQo+PiBSZWdhcmRpbmcgImNhY2hlX21hcCArIGlkeCAr
IDEgaXMgbm90IHZhbGlkIjogdGhlIHN0YW5kYXJkIGNsZWFybHkgcG9pbnRzDQo+PiBvdXQg
dGhhdCBhIGNhbGwgd2l0aCBzaXplIDAgaXMgdmFsaWQgYW5kIHdvbid0IGNvcHkgYW55dGhp
bmcNCj4gDQo+IFRoYXQncyBub3Qgd2hhdCBJIG1lYW50LiBQbGVhc2UgcmVhZCBhZ2FpbiB3
aGF0IEkgc2FpZDoNCj4gDQo+ICJJIHdvdWxkbid0IHdhbnQgaXQgZ2V0dGluZyBwcmVmZXRj
aGVkIGZyb20gJXJzaSBpbiB0aGUgaHcgd2hlbiB0aGVyZSdzDQo+IG5vIHJlYXNvbiBmb3Ig
aXQiLg0KDQpTbyB5b3UgYXJlIHN1Z2dlc3RpbmcgdGhhdCBwcmVmZXRjaGluZyBjYW4gaGFw
cGVuIGFjcm9zcyBvbmUgd3Jvbmcgc3BlY3VsYXRlZA0KYnJhbmNoLCBidXQgbm90IGFjcm9z
cyB0d28gb2YgdGhlbT8gQW5kIHlvdSBhcmUgbm90IHdvcnJ5aW5nIGFib3V0IHByZWZldGNo
ZXMNCnBhc3QgdGhlIGVuZCBvZiBhIGNvcHkgd2l0aCBzaXplID4gMD8NCg0KPiBJT1csIEkg
ZG9uJ3Qgd2FudCB0byBwdXQgaW52YWxpZCB2YWx1ZXMgaW4gaHcgcmVnaXN0ZXJzIGlmIEkg
Y2FuLiBUaGluaw0KPiBodyBtaXRpZ2F0aW9ucyBhbmQgKnZlcnkqIGh1bmdyeSBwcmVmZXRj
aGVycy4NCj4gDQo+Pj4gQ3VycmVudCBtYXA6DQo+Pj4gMDogc3RhcnQ6IDB4MDAwMDAwMDAw
MDAwMDAwMCwgZW5kOiAweDAwMDAwMDAwMDAxMDAwMDAsIHR5cGU6IDB4MA0KPj4+IDE6IHN0
YXJ0OiAweDAwMDAwMDAxMDAwMDAwMDAsIGVuZDogMHgwMDAwMDAwODIwMDAwMDAwLCB0eXBl
OiAweDYNCj4+PiAyOiBzdGFydDogMHgwMDAwMDJmMTAwMDBjMDAwLCBlbmQ6IDB4MDAwMDAz
YmYwMDAwYzAwMCwgdHlwZTogMHgyDQo+Pj4gMzogc3RhcnQ6IDB4MDAwMDAzYmYwMDAwYzAw
MCwgZW5kOiAweDAwMDE5ZmMwMDAwMDEwMDAsIHR5cGU6IDB4MA0KPj4+IDQ6IHN0YXJ0OiAw
eDAwMDE5ZmMwMDAwMDEwMDAsIGVuZDogMHgwMDAxZGYyZDAwMDAxMDAwLCB0eXBlOiAweDIN
Cj4+DQo+PiBUaGUgbWFwIHdvdWxkIHJlZmxlY3QgaGFyZHdhcmUgYmVoYXZpb3IuIFR5cGUg
MCB3aW5zIGluIGNhc2Ugb2Ygb3ZlcmxhcHBpbmcNCj4+IE1UUlJzLg0KPiANCj4gVHlwZSAw
IGlzIE1UUlJfVFlQRV9VTkNBQ0hBQkxFLCAxIGlzIE1UUlJfVFlQRV9XUkNPTUIuDQo+IA0K
PiAiVW5jYWNoZWFibGUgKFVDKeKAlFJlYWRzIGZyb20sIGFuZCB3cml0ZXMgdG8sIFVDIG1l
bW9yeSBhcmUgbm90IGNhY2hlYWJsZS4gUmVhZHMgZnJvbSBVQw0KPiBtZW1vcnkgY2Fubm90
IGJlIHNwZWN1bGF0aXZlLiBXcml0ZS1jb21iaW5pbmcgdG8gVUMgbWVtb3J5IGlzIG5vdA0K
PiBhbGxvd2VkLiINCj4gDQo+IFRoYXQgbGFzdCBzZW50ZW5jZS4NCg0KIklmIHR3byBvciBt
b3JlIHZhcmlhYmxlIG1lbW9yeSByYW5nZXMgbWF0Y2ggYW5kIG9uZSBvZiB0aGUgbWVtb3J5
IHR5cGVzIGlzIFVDLA0KdGhlIFVDIG1lbW9yeSB0eXBlIHVzZWQuIg0KDQpTbyB0ZWNobmlj
YWxseSBubyBwcm9ibGVtLCBhcGFydCBmcm9tIGxvd2VyIHBlcmZvcm1hbmNlLg0KDQo+IFNv
IGlmIHlvdSBoYXZlIGNvbmZsaWN0aW5nIHJlZ2lvbnMgYW5kIG9uZSBpcyBXQyBidXQgdGhl
biBzb21ldGhpbmcgaXMNCj4gZXhwZWN0aW5nIGl0IHRvIGJlIFVDIGFuZCB0aGF0IHNvbWV0
aGluZyBkb2Vzbid0IHdhbnQgZm9yIGl0IHRvDQo+ICplc3BlY2lhbGx5KiB0byBiZSBXQyBi
ZWNhdXNlIGl0IHNob3VsZCBub3QgY29tYmluZSB3cml0ZXMgdG8gaXQsIHRoZW4NCj4gdGhh
dCBjbGVhcmx5IGlzIGEgbWlzY29uZmlndXJhdGlvbiwgSSdkIHNheS4NCg0KV291bGQgeW91
IGJlIGZpbmUgd2l0aCBhZGRpbmcgdGhhdCBhcyBhbiBhZGRpdGlvbmFsIHBhdGNoPw0KDQpJ
IGJlbGlldmUgaWYgd2UgcmVhbGx5IHdhbnQgdGhhdCwgdGhlbiB3ZSBzaG91bGQgYmUgYWJs
ZSB0byBkaXNhYmxlIHN1Y2ggYQ0KY2xlYW51cC4gU28gaXQgc2hvdWxkIGJlIGFuIGFkZC1v
biBhbnl3YXkuDQoNCj4+IE5vdyB0aGlzIGlzIGFub3RoZXIgcmVxdWlyZW1lbnQsIHJpZ2h0
PyBUb2RheSdzIE1UUlIgY29kZSB3b3VsZG4ndCBzY3JlYW0NCj4+IGVpdGhlci4NCj4gDQo+
IFNvIGFyZSB3ZSBmaXhpbmcgdGhpcyByaWdodCBvciBvbmx5IGEgbGl0dGxlPw0KDQpJJ20g
bm90IGFnYWluc3QgYWRkaW5nIHN1Y2ggYWRkaXRpb25hbCBjaGVja3MuIEkgd291bGRuJ3Qg
bGlrZSB0byBmb3JjZSB0aGVtDQppbnRvIHRoaXMgc2VyaWVzIHJpZ2h0IG5vdywgYmVjYXVz
ZSB3ZSBuZWVkIHRoaXMgc2VyaWVzIGZvciBIeXBlci1WIGlzb2xhdGVkDQpndWVzdCBzdXBw
b3J0Lg0KDQo+PiBBdCBsZWFzdCB3ZSBkb24ndCBjb3JyZWN0IHN1Y2ggbWlzdGFrZXMgdG9k
YXkuIERvIHlvdSB0aGluayB3ZSBzaG91bGQgY2hhbmdlDQo+PiB0aGF0Pw0KPiANCj4gSSdt
IHRoaW5raW5nIGNvbnNpZGVyaW5nIGhvdyBvZnRlbiB3ZSd2ZSBzZWVuIGFsbCB0aG9zZSBl
cnJvciBtZXNzYWdlcw0KPiBmcm9tIG10cnJfc3RhdGVfd2FybigpLCB3ZSBzaG91bGQgYXQg
bGVhc3Qgd2FybiB3aGVuIHdlIGVuY291bnRlcg0KPiBpbmNvbnNpc3RlbmNpZXMuDQoNCkp1
c3QgdG8gc2F5IGl0IGV4cGxpY2l0bHk6IHlvdSBhcmUgY29uY2VybmVkIGZvciB0aGUgY2Fz
ZSB0aGF0IGEgY29tcGxldGUNCk1UUlIgaXMgaGlkZGVuIGJlbmVhdGggYW5vdGhlciBvbmUg
KGUuZy4gYSBsYXJnZSBVQyBNVFJSIGhpZGluZyBhIHNtYWxsZXINCk1UUlIgd2l0aCBhbm90
aGVyIHR5cGUsIG9yIGEgdmFyaWFibGUgTVRSUiBiZWluZyBoaWRkZW4gYnkgZml4ZWQgTVRS
UnMpPw0KDQo+IFRoaXMgd29uJ3QgaGVscCB3aXRoIHJlbGVhc2VkIEJJT1NlcyBidXQgaXQg
d2lsbCBoZWxwIHdoZW4gdGhleSBkbyBuZXcNCj4gQklPUyB2ZXJpZmljYXRpb24gYW5kIHNl
ZSB0aG9zZSBtZXNzYWdlcy4gUGVvcGxlIGRvIHVzZSBMaW51eCBmb3IgdGhhdA0KPiBhIGxv
dCBhbmQgdGhlbiB0aGV5J2xsIGRlZmluaXRlbHkgbG9vayBhbmQgYWRkcmVzcyB0aGVtLg0K
DQpPa2F5Lg0KDQo+IEFuZCB0aGlzIGlzIGEgcHJldHR5IGdvb2QgZ29hbCB0byBoYXZlLCBJ
TU8uDQoNClByb2JhYmx5LCB5ZXMuDQoNCg0KSnVlcmdlbg0K
--------------rdhkmtQKTlXqPbllHZEaCRxM
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------rdhkmtQKTlXqPbllHZEaCRxM--

--------------VS8wYEdJM0vlplTdr1zdIb32--

--------------ckv1scanN7lk60nwTgombUj7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRBRNcFAwAAAAAACgkQsN6d1ii/Ey9j
xgf+Mkzw4rzpjNjumK2U4a1UWiZaWxOS0oldp42yNHW6tcw46C9Ci9CBdky1D48dywhSp8Hf3/29
1XOoOlMB9S0Nluqxs6KP1BtX6Ccm3cEEPjSq1ro4EYPMoLZy72+Cg5k+HI4+EVAxkzJe3+olgji2
O1KQ8OjcmHY4gCR5gP2M+PeNOBw3lFIeOnnPzmyduLeJNI7rNW3gWXPlg2PBlS66vQWJvt6owz0Y
gC3dxIz9EnMkMIHzMtSoOeMFf0AVBRSikDZ37g8NMca+czDo8sZzbSL3EtA2JrHBFvYacAmW5qvD
rBTj49qlOHzGDbxH2LCI6k568Yqeb6opa9mZQB1hwg==
=kRZ0
-----END PGP SIGNATURE-----

--------------ckv1scanN7lk60nwTgombUj7--
