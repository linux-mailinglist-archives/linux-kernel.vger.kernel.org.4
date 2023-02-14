Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F047F695A71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBNHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBNHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:16:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067CF23328
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:13:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 943CF20DDA;
        Tue, 14 Feb 2023 07:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676358819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Juev4MCugyBal5aOdlC1DGUJhHAf0mUiaq/OtoKYe5s=;
        b=az+VW+QqXbWCfJ4JjQObLvVZ24Jhae+WJDr6kh0aRp0Yz28gedBuCJGunO7hYnOvIiDTL3
        UlJfANAwjCijj5sPUgdAh5tBQCXRsynSW3dSZWXP3UR/TlkpeKY2kUxJX3aY4NY00Rxwb4
        uXGjvFptQuW3zAs8U8fRhUu7FKkdayc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 311C913A21;
        Tue, 14 Feb 2023 07:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JUV1CqM062OUDQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Feb 2023 07:13:39 +0000
Message-ID: <3081c6de-f731-109c-7d30-b2eadd1dbd34@suse.com>
Date:   Tue, 14 Feb 2023 08:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     mikelley@microsoft.com,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
 <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
 <47d6d93f-defd-d18a-276a-417252e7ddce@nerdbynature.de>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
In-Reply-To: <47d6d93f-defd-d18a-276a-417252e7ddce@nerdbynature.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------y2gkz1w3jMjOsr97464n31sw"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------y2gkz1w3jMjOsr97464n31sw
Content-Type: multipart/mixed; boundary="------------q0qBKklV0mXvFlnsAxcQ9sXq";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christian Kujau <lists@nerdbynature.de>
Cc: mikelley@microsoft.com,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org, x86@kernel.org, torvalds@linux-foundation.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3081c6de-f731-109c-7d30-b2eadd1dbd34@suse.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
 <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
 <47d6d93f-defd-d18a-276a-417252e7ddce@nerdbynature.de>
In-Reply-To: <47d6d93f-defd-d18a-276a-417252e7ddce@nerdbynature.de>

--------------q0qBKklV0mXvFlnsAxcQ9sXq
Content-Type: multipart/mixed; boundary="------------Y0Dcd0u0I0glVxQjN6BxxIGZ"

--------------Y0Dcd0u0I0glVxQjN6BxxIGZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMjM6NTQsIENocmlzdGlhbiBLdWphdSB3cm90ZToNCj4gT24gTW9uLCAx
MyBGZWIgMjAyMywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IEhtbSwgdGhpcyB3b3VsZCBt
YWtlIEh5cGVyLVYgU0VWLVNOUCBndWVzdHMgc2xvdyBhZ2Fpbi4NCj4+DQo+PiBJJ20gbm90
IGNvbXBsZXRlbHkgYWdhaW5zdCBpdCwgYnV0IE9UT0ggSSdtIGEgbGl0dGxlIGJpdCBiaWFz
ZWQgYXMgdGhlDQo+PiBtYWludGFpbmVyIG9mIHRoZSBYZW4gY29kZS4gOi0pDQo+IA0KPiBV
bmRlcnN0b29kLiBJJ20gYSBiaXQgcHV6emxlZCB3aHkgbm9ib2R5IGVsc2UgcmVwb3J0cyB0
aGlzLCBtYXliZSBYZW4gRG9tMA0KPiBhbmQgZXh0ZXJuYWwgVVNCIGVuY2xvc3VyZXMgYXJl
IG5vdCB0aGF0IGNvbW1vbi4NCg0KTm90IGFsbCBVU0IgZHJpdmVycy9pbnRlcmZhY2VzIGhh
dmUgdGhpcyBwcm9ibGVtLiBZb3VyIHByb2JsZW1zIGFyZSB3aXRoOg0KDQogICBJbnRlbCBD
b3Jwb3JhdGlvbiA4IFNlcmllcy9DMjIwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBVU0IgeEhD
SSAocmV2IDA1KQ0KDQp3aGlsZSBhIHN5c3RlbSBJJ20gd29ya2luZyB3aXRoIHRoZSBmb2xs
b3dpbmcgaGFzIG5vIHByb2JsZW1zOg0KDQogICBJbnRlbCBDb3Jwb3JhdGlvbiA4IFNlcmll
cy9DMjIwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBVU0IgeEhDSSAocmV2IDA0KQ0KDQpUaGUg
b25seSBkaWZmZXJlbmNlIHNlZW1zIHRvIGJlIHRoZSByZXZpc2lvbiBvZiB5b3VyIGFkYXB0
ZXIuDQoNCj4gDQo+PiBNaWNoYWVsLCB3b3VsZCB5b3Ugc2VlIG1ham9yIHByb2JsZW1zIHdp
dGggZG9pbmcgdGhlIHJldmVydCBiZWZvcmUgaGF2aW5nDQo+PiB0aGUgZmluYWwgcGF0Y2hl
cyBmb3IgZml4aW5nIHlvdXIgaXNzdWUsIHRvbz8NCj4gDQo+IElmIHRoYXQgcmV2ZXJ0IGVu
ZHMgdXAgaW4gbWFpbmxpbmUsIGZlZWwgZnJlZSB0byBhZGQ6DQo+IA0KPiAgIFRlc3RlZC1i
eTogQ2hyaXN0aWFuIEt1amF1IDxsaXN0c0BuZXJkYnluYXR1cmUuZGU+DQoNClRoYW5rcywN
Cg0KDQpKdWVyZ2VuDQoNCg==
--------------Y0Dcd0u0I0glVxQjN6BxxIGZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Y0Dcd0u0I0glVxQjN6BxxIGZ--

--------------q0qBKklV0mXvFlnsAxcQ9sXq--

--------------y2gkz1w3jMjOsr97464n31sw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPrNKIFAwAAAAAACgkQsN6d1ii/Ey9n
HggAjVA2y1WQ70O3HCG0t8bQBh0+r5nEAFUDNGKn56x70iY1stwwcrCj/JrlJht+Gcqma6DvonAX
xFg5rpAYI5NSwqbB3Yrgw5Z0j/bjzhZZKjRUQ1eIxrhGW+CaqxtFfmIRFvXJtWiLNWNBHVzu5uzx
VWZ9vqW7kpC85FPGvrrm/+43KlW35ac7ALTkJNoJz4pxhAKDssd6CEJH3UHDdeIy5CRrzkrWP58j
5pZwoS2ofwqFBvHPWZm7jhi1pPKyYBbzPpd7lxjcy88V1LjFOpa2Tt2KaWSyTOlBHqDg9IJyqGFX
vX04kLyRETjgdn1w8TkE7Z6DvEf7yAiGPLfRWuA+Tg==
=3eVp
-----END PGP SIGNATURE-----

--------------y2gkz1w3jMjOsr97464n31sw--
