Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306761471E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKAJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKAJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:48:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434F18E30
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:48:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D17B33881;
        Tue,  1 Nov 2022 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667296092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWiyTS4woxsMw2AGyteEq1+VA2Tc8z/Np5UyDHLzXNE=;
        b=g0FFfR5dXK6lVwaxgyiz7gMK3/hEL7+wumCWYWXI3TkS4ML0BQrqQgBAnZk2Fju305867n
        Hl56zK9goXW1GNuHrpCGCQjamuSOJW4rkP9XLe4nCs4MzTYA+PF5p+q1fGA+m8JKuBBrHx
        gOFpOM/e+1MYhvPuvsYbhTG0DiUkC24=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE25613AAF;
        Tue,  1 Nov 2022 09:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J9GKOFvrYGOTQwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 01 Nov 2022 09:48:11 +0000
Message-ID: <ee303ab9-90b2-5679-30c0-fd1982cbaad6@suse.com>
Date:   Tue, 1 Nov 2022 10:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-17-jgross@suse.com> <Y15o4o8j6zbQuaQJ@zn.tnic>
 <dbd5861a-aa12-ea4f-c076-974613fba51c@suse.com> <Y16osqK3kbCz8Sf3@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 16/16] x86/mtrr: simplify mtrr_ops initialization
In-Reply-To: <Y16osqK3kbCz8Sf3@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IBjqr1gMLSzOkC0s7RNnUqbL"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IBjqr1gMLSzOkC0s7RNnUqbL
Content-Type: multipart/mixed; boundary="------------njWV7X2VrPVBdcO7q5lgHGCa";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ee303ab9-90b2-5679-30c0-fd1982cbaad6@suse.com>
Subject: Re: [PATCH v4 16/16] x86/mtrr: simplify mtrr_ops initialization
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-17-jgross@suse.com> <Y15o4o8j6zbQuaQJ@zn.tnic>
 <dbd5861a-aa12-ea4f-c076-974613fba51c@suse.com> <Y16osqK3kbCz8Sf3@zn.tnic>
In-Reply-To: <Y16osqK3kbCz8Sf3@zn.tnic>

--------------njWV7X2VrPVBdcO7q5lgHGCa
Content-Type: multipart/mixed; boundary="------------AE0CLzHbm0TE9EY64qSDltt3"

--------------AE0CLzHbm0TE9EY64qSDltt3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMTAuMjIgMTc6MzksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU3VuLCBP
Y3QgMzAsIDIwMjIgYXQgMDQ6MDU6MjlQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEFzIHRoZSBzcGVjaWZpYyBvcHMgdmFyaWFibGVzIGFyZSBhdmFpbGFibGUgZm9yIFg4
Nl8zMiBvbmx5LCB0aGlzDQo+PiB3b3VsZCByZXF1aXJlIHRvIGFkZCBhbiAiI2lmZGVmIENP
TkZJR19YODZfMzIiIGFyb3VuZCB0aGUgY29kZSBibG9jaw0KPj4gZG9pbmcgdGhlIGFzc2ln
bm1lbnRzLiBPdGhlcndpc2UgdGhlIGJ1aWxkIHdvdWxkIGZhaWwuDQo+IA0KPiBXZWxsLCBp
dCBsb29rcyBsaWtlIG15IGNvbXBpbGVyIGlzIHNtYXJ0IGVub3VnaCBhbmQgZWxpbWluYXRl
cyBhbGwgdGhhdA0KPiBkZWFkIGNvZGUsIHNlZSBkaWZmIGJlbG93Lg0KPiANCj4gSSBoYXZl
IHRoZSBzdXNwaWNpb24sIHRob3VnaCwgdGhhdCBjbGFuZyBtaWdodCBub3QgYmUgdGhhdCBz
bWFydC4NCg0KSG1tLCB3aXRoIHRoZSBjcHVfZmVhdHVyZV9lbmFibGVkKCkgaW1wbGVtZW50
YXRpb24gaXQgc2hvdWxkIGJlIHF1aXRlDQpvYnZpb3VzIHRoYXQgdGhpcyBpcyBhbGwgZGVh
ZCBjb2RlLg0KDQpJJ20gZ29pbmcgd2l0aCBkcm9wcGluZyB0aGUgdmVuZG9yX210cnJfb3Bz
KCkgbWFjcm8gZm9yIG5vdy4NCg0KDQpKdWVyZ2VuDQo=
--------------AE0CLzHbm0TE9EY64qSDltt3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------AE0CLzHbm0TE9EY64qSDltt3--

--------------njWV7X2VrPVBdcO7q5lgHGCa--

--------------IBjqr1gMLSzOkC0s7RNnUqbL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNg61oFAwAAAAAACgkQsN6d1ii/Ey9O
nwf/ZrQlfwDD7TkviIt2fjFTwdRvLDk3WRuVwUAEyladqyjnNRwjqVjYl2azdSQxAdlz7UmKgJPp
+/T+RRfoaZfQpP1PQMLwImTB6cY17knN2SXxZBXxBHqImn1oah0OagaT49Axi1hm14DyPuzaJch5
oXkbi0M7YQcVgKKJX5ZGLgPonLPmQa1/e9ZgvD//6kcIdbrC/6i5mdjlBB0zGJVe53cQzG2819n2
a/XYiPXpWUr+8cxVNZv0RLWiPzadWVkN/qbb5mo801hnryFCNLtop12g71P4E8PxwprTWkVUzcYP
nlXCpWTa0DKSCSvB/yK0mGUAZVhR6LGay4Bf/u3LPw==
=m/7n
-----END PGP SIGNATURE-----

--------------IBjqr1gMLSzOkC0s7RNnUqbL--
