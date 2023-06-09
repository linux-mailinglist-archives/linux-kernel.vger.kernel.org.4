Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706B9729EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjFIPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFIPib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:38:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E6C30F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:38:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 730CE21A4B;
        Fri,  9 Jun 2023 15:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686325109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qu4g/0lz+t2182vt8zT6T7jCYPp63y4X08mVeLVanZg=;
        b=D++mz5CO/Xkn38Y6EGRhk9w2ysav8sDSr+ZKC6wVlTI6HdPYdc9hFESzYVhwiXM3Lta9xA
        xKL/lRdmCYGnIb6uYh2tDEoqSf4QzhKYUtjtNi8QfDNpb7Fi657fu4OPF82Ag04/fvJLHs
        xU67f/R54oYYAD7uVySeJ+tAjr7QEf0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1A2113A47;
        Fri,  9 Jun 2023 15:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GohIOXRHg2SNCAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 09 Jun 2023 15:38:28 +0000
Message-ID: <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
Date:   Fri, 9 Jun 2023 17:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <20230518134253.909623-1-hch@lst.de>
 <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
 <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl>
 <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com>
 <20230607131257.GB19206@lst.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230607131257.GB19206@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------90t7m9Jx5Xk69a4ZuetOcZUR"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------90t7m9Jx5Xk69a4ZuetOcZUR
Content-Type: multipart/mixed; boundary="------------csx4aCZJXTkhgehRBNI804YW";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Message-ID: <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling
References: <20230518134253.909623-1-hch@lst.de>
 <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
 <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl>
 <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com>
 <20230607131257.GB19206@lst.de>
In-Reply-To: <20230607131257.GB19206@lst.de>

--------------csx4aCZJXTkhgehRBNI804YW
Content-Type: multipart/mixed; boundary="------------IGSz9KXXZgxtj0Jz1Oxp28BQ"

--------------IGSz9KXXZgxtj0Jz1Oxp28BQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDYuMjMgMTU6MTIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBNb24s
IE1heSAyMiwgMjAyMyBhdCAxMDozNzowOUFNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4gSW4gbm9ybWFsIGNhc2VzIFBDSSBwYXNzdGhyb3VnaCBpbiBQViBndWVzdHMgcmVx
dWlyZXMgdG8gc3RhcnQgdGhlIGd1ZXN0DQo+PiB3aXRoIGU4MjBfaG9zdD0xLiBTbyBpdCBz
aG91bGQgYmUgcmF0aGVyIGVhc3kgdG8gbGltaXQgYWxsb2NhdGluZyB0aGUNCj4+IDY0TUIg
aW4gUFYgZ3Vlc3RzIHRvIHRoZSBjYXNlcyB3aGVyZSB0aGUgbWVtb3J5IG1hcCBoYXMgbm9u
LVJBTSByZWdpb25zDQo+PiBlc3BlY2lhbGx5IGluIHRoZSBmaXJzdCAxTUIgb2YgdGhlIG1l
bW9yeS4NCj4+DQo+PiBUaGlzIHdpbGwgY292ZXIgZXZlbiBob3RwbHVnIGNhc2VzLiBUaGUg
b25seSBjYXNlIG5vdCBjb3ZlcmVkIHdvdWxkIGJlIGENCj4+IGd1ZXN0IHN0YXJ0ZWQgd2l0
aCBlODIwX2hvc3Q9MSBldmVuIGlmIG5vIFBDSSBwYXNzdGhyb3VnaCB3YXMgcGxhbm5lZC4N
Cj4+IEJ1dCB0aGlzIHNob3VsZCBiZSByYXRoZXIgcmFyZSAoYXQgbGVhc3QgSSBob3BlIHNv
KS4NCj4gDQo+IFNvIGlzIHRoaXMgYW4gQUNLIGZvciB0aGUgcGF0Y2ggYW5kIGNhbiB3ZSBn
byBhaGVhZCB3aXRoIGl0Pw0KDQpBcyBsb25nIGFzIGFib3ZlIG1lbnRpb25lZCBjaGVjayBv
ZiB0aGUgRTgyMCBtYXAgaXMgZG9uZSwgeWVzLg0KDQpJZiB5b3Ugd2FudCBJIGNhbiBzZW5k
IGEgZGlmZiB0byBiZSBmb2xkZWQgaW50byB5b3VyIHBhdGNoIG9uIE1vbmRheS4NCg0KPiAN
Cj4gKEknZCBzdGlsbCBsaWtlIHRvIG1lcmdlIHN3aW90bGIteGVuIGludG8gc3dpb3RsYiBl
dmVudHVhbGx5LCBidXQgaXQncw0KPiBwcm9iYWJseSBub3QgZ29pbmcgdG8gaGFwcGVuIHRo
aXMgbWVyZ2Ugd2luZG93KQ0KDQpXb3VsZCBiZSBuaWNlLg0KDQoNCkp1ZXJnZW4NCg==
--------------IGSz9KXXZgxtj0Jz1Oxp28BQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IGSz9KXXZgxtj0Jz1Oxp28BQ--

--------------csx4aCZJXTkhgehRBNI804YW--

--------------90t7m9Jx5Xk69a4ZuetOcZUR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSDR3QFAwAAAAAACgkQsN6d1ii/Ey/V
CwgAgbJpH1odyDVntfaeroRGArp+yXBmzdpZp9I4wIu/Ioc/TgAnKzT9ol4v9FwCbFCNtECT6bMy
Pwe7QnfTHA+qK3S8pfDZUY2mzZqbkCq9Er02jSPBjyWNLPYJZ+rZl5qGvVTjob6j32mguYM79XMM
DBkGi9e1eJE/71mZHdpujEAF5bB5QwpzpTwcuSFxSXS/WLB+EFy/IsxldV773qErDnDapZSV0WRo
ZC3r1FLrbq4PZjqGzyIW+k26Xh0ZT3gAsa9c9pyQtPJ5bSiT9aVas4uUcQki6EMkWSpQr8Jn3CSj
f4WIfQQ/Lx6UKfC54bKshAISK3UDT7WTtR8zAGGDYw==
=HTe9
-----END PGP SIGNATURE-----

--------------90t7m9Jx5Xk69a4ZuetOcZUR--
