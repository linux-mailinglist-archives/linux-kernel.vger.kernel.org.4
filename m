Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F268B916
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBFJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:54:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392AC18A8E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:54:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42CB460574;
        Mon,  6 Feb 2023 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675677284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ib3mjL2iwK97szUwWn3vx2w2xDZEHj6cH0d6/bZ8qCA=;
        b=t1XDFT6hKHvnIKWMk7+EO1d4Tr6ttnsYf3jJHu032H8JCLHCYdLi22IfPTRKfxhGw8ERw2
        tF8ZnWwZzpInOKUq0dCS4PA3M7OpxTjonEG0kxIGSPJKmV7fnH1a41241ZK30bsm3UARXW
        284j9OZ8qB0nEIpQAGKeU0MdULj1+yU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3BCE13677;
        Mon,  6 Feb 2023 09:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W5YwOmPO4GNqQgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Feb 2023 09:54:43 +0000
Message-ID: <21e1f36c-3c2f-d1e6-e1ba-6f86316a262a@suse.com>
Date:   Mon, 6 Feb 2023 10:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com>
 <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
 <Y9+tDmLAlqg37TS+@zn.tnic>
 <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
 <093a90b7-3365-bc66-f0bf-c78c75814879@suse.com>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
In-Reply-To: <093a90b7-3365-bc66-f0bf-c78c75814879@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Je0v8R20oloAnbTuSR8NxPgf"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Je0v8R20oloAnbTuSR8NxPgf
Content-Type: multipart/mixed; boundary="------------Z69huRdVFoUUbVu0hw9lSaNQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>
Cc: Christian Kujau <lists@nerdbynature.de>,
 Michael Kelley <mikelley@microsoft.com>, linux-kernel@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Message-ID: <21e1f36c-3c2f-d1e6-e1ba-6f86316a262a@suse.com>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info>
 <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com>
 <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
 <Y9+tDmLAlqg37TS+@zn.tnic>
 <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
 <093a90b7-3365-bc66-f0bf-c78c75814879@suse.com>
In-Reply-To: <093a90b7-3365-bc66-f0bf-c78c75814879@suse.com>

--------------Z69huRdVFoUUbVu0hw9lSaNQ
Content-Type: multipart/mixed; boundary="------------hnruGK80AxsXZ6w8FgoBZYlZ"

--------------hnruGK80AxsXZ6w8FgoBZYlZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDIuMjMgMDc6MzMsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IEkgc3RpbGwgZG9u
J3Qgc2VlIHdoeSB0aGUgb3JpZ2luYWwgcmVwb3J0IG9mIENocmlzdGlhbiBpcyBtYWtpbmcg
c2Vuc2U6DQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGVycm9yIG1lc3NhZ2UsIHRoZSBfcmVx
dWVzdGVkXyBtZW1vcnkgdHlwZSB3YXMgVUMtLCBidXQNCj4gdGhlIHJldmVydGVkIHBhdGNo
IG9ubHkgYWZmZWN0cyBjYXNlcyB3aGVyZSB0aGUgcmVxdWVzdGVkIHR5cGUgaXMgV0IuIFNv
DQo+IHdoeSBkb2VzIGEgcmV2ZXJ0IG9mIDkwYjkyNmU2OGY1MCBpcyBoZWxwaW5nIHRvIG1h
a2UgdGhpcyBtZXNzYWdlIGdvIGF3YXk/DQo+IFRoZSBtZXNzYWdlIHdhczoNCj4gDQo+ICDC
oCBpb3JlbWFwIGVycm9yIGZvciAweGYyNTIwMDAwLTB4ZjI1MzAwMDAsIHJlcXVlc3RlZCAw
eDIsIGdvdCAweDANCj4gDQo+IE1lYW53aGlsZSBJJ3ZlIGZvdW5kIGEgc3lzdGVtIHdoaWNo
IGlzIGlzc3Vpbmcgc3VjaCBhIG1lc3NhZ2UgdW5kZXIgWGVuLg0KPiBJJ2xsIGludmVzdGln
YXRlIGZ1cnRoZXIgX3doeV8gYSByZXF1ZXN0IG9mIFVDLSBlbmRzIHVwIHRvIGdldCBXQi4N
Cg0KT2theSwgaGVyZSB0aGUgcmVzdWx0IG9mIG15IGludmVzdGlnYXRpb246DQoNCkR1cmlu
ZyBBQ1BJIGluaXRpYWxpemF0aW9uIEFDUEkgY29kZSBzZWVtcyB0byB0cnkgbWFwcGluZyBh
IG1lbW9yeSBhcmVhDQpiZWluZyBtYXJrZWQgYXMgInJlc2VydmVkIiBpbiB0aGUgbWVtb3J5
IG1hcCB3aXRoIHR5cGUgV0IgKHRoaXMgaGFwcGVucw0KaW4gYWNwaV9vc19tYXBfaW9tZW0o
KSkuDQoNCldpdGggY29tbWl0IDkwYjkyNmU2OGY1MCB0aGlzIGlzIG5vdyBhY2NlcHRlZCwg
cmVzdWx0aW5nIGluIHRoaXMgbWVtb3J5DQphcmVhIGJlaW5nIHJlZ2lzdGVyZWQgd2l0aCB0
aGUgV0IgdHlwZS4NCg0KTXVjaCBsYXRlciB0aGUgZHJpdmVyIGZvciB0aGUgZGV2aWNlIG93
bmluZyB0aGlzIHJlc2VydmVkIG1lbW9yeSBhcmVhDQp0cmllcyB0byBtYXAgdGhlIGFyZWEg
YXMgVUMtLCBidXQgaXQgZ2V0cyBXQiBkdWUgdG8gdGhlIG11Y2ggZWFybGllcg0KbWFwcGlu
ZyB2aWEgYWNwaV9vc19tYXBfaW9tZW0oKS4NCg0KQmVmb3JlIGNvbW1pdCA3MmNiYzhmMDRm
ZTIgKHdoaWNoIDkwYjkyNmU2OGY1MCB0cmllZCB0byBmaXgpIHRoaXMgd2hvbGUNCm1lc3Mg
d29ya2VkLCBiZWNhdXNlIG1lbXR5cGVfcmVzZXJ2ZSgpIHRvb2sgdGhlIGVhcmx5IGV4aXQg
ZHVlIHRvDQpwYXRfZW5hYmxlZCgpIHJldHVybmluZyBmYWxzZS4NCg0KSnVzdCByZXZlcnRp
bmcgOTBiOTI2ZTY4ZjUwIHdpbGwgcmVpbnRyb2R1Y2UgdGhlIFREWCBndWVzdCBpc3N1ZSBN
aWNoYWVsDQpyZXBvcnRlZCAobWFzc2l2ZSBzbG93IGRvd24gZHVlIHRvIGdldHRpbmcgbWVt
b3J5IGFyZWFzIG1hcHBlZCBhcyBVQy0pLg0KDQpJIGJlbGlldmUgdGhlIG1vc3QgcHJvbWlz
aW5nIHdheSBvdXQgb2YgdGhpcyBtZXNzIHdvdWxkIGJlIHRvIGxldA0KaW50ZXJlc3RlZCBw
YXJ0aWVzIChYZW4gZ3Vlc3RzLCBIeXBlci1WIFREWCBndWVzdHMpIHNldCB0aGUgTVRSUiBt
ZW1vcnkNCnR5cGUgdGhleSB3YW50IHRvIGdldCBiYWNrIGZyb20gbXRycl90eXBlX2xvb2t1
cCgpIGZvciB0aGUgY2FzZXMgaXQNCnJldHVybnMgTVRSUl9UWVBFX0lOVkFMSUQgdG9kYXku
DQoNCkkgZ3Vlc3MgWGVuIERvbTAgd291bGQgc3BlY2lmeSBNVFJSX1RZUEVfVU5DQUNIQUJM
RSwgd2hpbGUgSHlwZXItViBURFgNCmd1ZXN0cyBjb3VsZCBzZXQgaXQgdG8gTVRSUl9UWVBF
X1dSQkFDSy4NCg0KQW55IHRob3VnaHRzPw0KDQoNCkp1ZXJnZW4NCg==
--------------hnruGK80AxsXZ6w8FgoBZYlZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------hnruGK80AxsXZ6w8FgoBZYlZ--

--------------Z69huRdVFoUUbVu0hw9lSaNQ--

--------------Je0v8R20oloAnbTuSR8NxPgf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPgzmMFAwAAAAAACgkQsN6d1ii/Ey9I
0AgAg5oQvZMf6ZYgbrJPv1AjKU0R2Rw5uOLZ+ZN5cC7xh+JI2+D7TGIXJ3Dyi8++DIcU77jIsDvF
q2CnNtFD1xe5r7vq+tp80kQpo/BOTO65O9MSzZYtBiYzHDhAaS1IdHNQKK+tbeSSmyaXidYQc1z7
QBlsoepFiVjNru/ixtSu5xEjAT3nRskS50oOBRgcMscsjvuNHvKVc6Djf3l0WywBiW6g5aDKZgsL
t0ykwomNNrHqTjYPXCKTNrOPDveUihbZHeINHeQVn6cezyYk40Ip2k+osEsDY6XUqmskyp4XSB7R
lAl54TMV/MgbzjeCDnjqjKtvH62oMgPlC0WB5/WL2A==
=kHMY
-----END PGP SIGNATURE-----

--------------Je0v8R20oloAnbTuSR8NxPgf--
