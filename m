Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA160567B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJTEy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTEyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:54:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510A81692
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:54:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BAB7433690;
        Thu, 20 Oct 2022 04:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666241689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3iA16HmuFFXNGBGIKzIu2WUxC5zpDH0XZZAFk9ySg0=;
        b=DwccUfqXZToLf7joOzBHSajiB5QHFAPnceQ+w108Poho4clQ75ssC1NFc3VT33Td6Q7kEA
        gEzVYaLuqKva3o+Pmn72YNQ3l3WQtECCQ3+Y76Dz0kUllcpDSfAKBPH2lti2zkU3278WOa
        C++75ZLOGs3HLhX7YNnjGF5kcgwqFto=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C08D139D2;
        Thu, 20 Oct 2022 04:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 04UcGZnUUGO3PwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 04:54:49 +0000
Message-ID: <826853e4-f7ce-349d-c0c0-74516af6ff8c@suse.com>
Date:   Thu, 20 Oct 2022 06:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>, "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <FDC4F3E7-DEDD-41CC-93E6-8021F16B509D@zytor.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <FDC4F3E7-DEDD-41CC-93E6-8021F16B509D@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VuKPs22vyCHx8bbBRj0FoSPA"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VuKPs22vyCHx8bbBRj0FoSPA
Content-Type: multipart/mixed; boundary="------------KZV1AUAFULLfItnPdIhpX06e";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Li, Xin3" <xin3.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "brgerst@gmail.com" <brgerst@gmail.com>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>
Message-ID: <826853e4-f7ce-349d-c0c0-74516af6ff8c@suse.com>
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <FDC4F3E7-DEDD-41CC-93E6-8021F16B509D@zytor.com>
In-Reply-To: <FDC4F3E7-DEDD-41CC-93E6-8021F16B509D@zytor.com>

--------------KZV1AUAFULLfItnPdIhpX06e
Content-Type: multipart/mixed; boundary="------------310aJ3XjUWzWI3oLeIQVjx1A"

--------------310aJ3XjUWzWI3oLeIQVjx1A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTAuMjIgMjA6MDEsIEguIFBldGVyIEFudmluIHdyb3RlOg0KPiBPbiBPY3RvYmVy
IDE5LCAyMDIyIDEwOjQ1OjA3IEFNIFBEVCwgIkxpLCBYaW4zIiA8eGluMy5saUBpbnRlbC5j
b20+IHdyb3RlOg0KPj4+PiArc3RhdGljIGlubGluZSB2b2lkIF9faW5pdCBsa2dzX2luaXQo
dm9pZCkgeyAjaWZkZWYNCj4+Pj4gK0NPTkZJR19QQVJBVklSVF9YWEwgI2lmZGVmIENPTkZJ
R19YODZfNjQNCj4+Pj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9M
S0dTKSkNCj4+Pj4gKwkJcHZfb3BzLmNwdS5sb2FkX2dzX2luZGV4ID0gbmF0aXZlX2xrZ3M7
DQo+Pj4NCj4+PiBGb3IgdGhpcyB0byB3b3JrIGNvcnJlY3RseSB3aGVuIHJ1bm5pbmcgYXMg
YSBYZW4gUFYgZ3Vlc3QsIHlvdSBuZWVkIHRvIGFkZA0KPj4+DQo+Pj4gCXNldHVwX2NsZWFy
X2NwdV9jYXAoWDg2X0ZFQVRVUkVfTEtHUyk7DQo+Pj4NCj4+PiB0byB4ZW5faW5pdF9jYXBh
YmlsaXRpZXMoKSBpbiBhcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMsIGFzIG90aGVyd2lz
ZSB0aGUgWGVuDQo+Pj4gc3BlY2lmaWMgLmxvYWRfZ3NfaW5kZXggdmVjdG9yIHdpbGwgYmUg
b3ZlcndyaXR0ZW4uDQo+Pg0KPj4gWWVhaCwgd2UgZGVmaW5pdGVseSBzaG91bGQgYWRkIGl0
IHRvIGRpc2FibGUgTEtHUyBpbiBhIFhlbiBQViBndWVzdC4NCj4+DQo+PiBTbyBkb2VzIGl0
IG1lYW4gdGhhdCB0aGUgWGVuIFBWIHVzZXMgYSBibGFjayBsaXN0IGR1cmluZyBmZWF0dXJl
IGRldGVjdGlvbj8NCj4+IElmIHllcyB0aGVuIG5ldyBmZWF0dXJlcyBhcmUgb2Z0ZW4gcmVx
dWlyZWQgdG8gYmUgbWFza2VkIHdpdGggYW4gZXhwbGljaXQNCj4+IGNhbGwgdG8gc2V0dXBf
Y2xlYXJfY3B1X2NhcC4NCj4+DQo+PiBXb3VsZG4ndCBhIHdoaXRlIGxpc3QgYmUgYmV0dGVy
Pw0KPj4gVGhlbiB0aGUgam9iIGlzIG1vcmUganVzdCBvbiB0aGUgWGVuIFBWIHNpZGUsIGFu
ZCBpdCBjYW4gc2VsZWN0aXZlbHkgZW5hYmxlDQo+PiBhIG5ldyBmZWF0dXJlLCBzb21ldGlt
ZXMgd2l0aCBYZW4gUFYgc3BlY2lmaWMgaGFuZGxpbmcgY29kZSBhZGRlZC4NCj4+DQo+PiBY
aW4NCj4+DQo+Pj4NCj4+Pg0KPj4+IEp1ZXJnZW4NCj4+DQo+IA0KPiBNb3N0IHRoaW5ncyBk
b24ndCBmcm9iIHRoZSBwYXJhdmlydCBsaXN0Lg0KPiANCj4gTWF5YmUgd2Ugc2hvdWxkIG1h
a2UgdGhlIHBhcmF2aXJ0IGZyb2JiaW5nIGEgc2VwYXJhdGUgcGF0Y2gsIGF0IGl0IGlzIHNl
cGFyYWJsZS4NCg0KV29ya3MgZm9yIG1lLg0KDQoNCkp1ZXJnZW4NCg==
--------------310aJ3XjUWzWI3oLeIQVjx1A
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------310aJ3XjUWzWI3oLeIQVjx1A--

--------------KZV1AUAFULLfItnPdIhpX06e--

--------------VuKPs22vyCHx8bbBRj0FoSPA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNQ1JkFAwAAAAAACgkQsN6d1ii/Ey+L
Twf+M9+GooW/PBmC1ZdFvv2aVFasIlkhogNhYvJWo2l5LZNtYieGKEDOaoUuRs3Spm6/YG7oybLT
g+4BGRqjiHvwYMrr6oAVCTf0sI09mV+CCtnbTBJ5wyW3Z2hXdHwwOc53EHiyoiQ5PAPiCRhP8Zui
1MuYzaTmulgP8Pq1t/Nn8J0ZrZrcKLljHBDXJsmh2+bcdn16Ysy+rN+RWt5VVi7s5mijrBNt2f+2
R79cyJKPwjtmsZDWvIJ49raoIRfrifg9+GQQnSoW3nb+iMzCJIDYlQFJ//zfZ2ph7LEmArjAEryH
hA17lRHitkJTV+Il9gE5GY0masVLy4CvMXF8+yWz7w==
=Cotk
-----END PGP SIGNATURE-----

--------------VuKPs22vyCHx8bbBRj0FoSPA--
