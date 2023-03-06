Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D36AC351
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCFOcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCFOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:32:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1CA302B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:32:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF7BE2239A;
        Mon,  6 Mar 2023 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678112759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAMmvx+OCgHvAaWNnndN13k8CLeTPLZcFUakvVDIYqA=;
        b=JtK7/Uig3EHDehsntyKyTvugE3PoH3hdo3jTWPSB2JkB907aKDH9Hxq5cV7lyo0b92eHa9
        StZcCqglFxWkMA5RDKmmpe+e2OfX0jHslzTK0mUqvAAI+iY/a8XaSFq2hsNlBBxqTewqSZ
        1uBMvX/8uJeDReB45ECX34gIWE82QfA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AC8013A66;
        Mon,  6 Mar 2023 14:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dsaAHPf3BWTJBQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Mar 2023 14:25:59 +0000
Message-ID: <771234bd-0398-da70-5595-027bd6be5d65@suse.com>
Date:   Mon, 6 Mar 2023 15:25:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306123259.12461-1-jgross@suse.com>
 <84228e23-7d16-ce4f-9b75-9afb9633f9c2@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <84228e23-7d16-ce4f-9b75-9afb9633f9c2@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZGWTAMDeMl0qDEfyUhVxcsNe"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZGWTAMDeMl0qDEfyUhVxcsNe
Content-Type: multipart/mixed; boundary="------------Zh6xCUTest0yFg0KhO1Qj6ZE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <771234bd-0398-da70-5595-027bd6be5d65@suse.com>
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
References: <20230306123259.12461-1-jgross@suse.com>
 <84228e23-7d16-ce4f-9b75-9afb9633f9c2@intel.com>
In-Reply-To: <84228e23-7d16-ce4f-9b75-9afb9633f9c2@intel.com>

--------------Zh6xCUTest0yFg0KhO1Qj6ZE
Content-Type: multipart/mixed; boundary="------------yHCu0G6NM0PkjTgyCFe0lmte"

--------------yHCu0G6NM0PkjTgyCFe0lmte
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDMuMjMgMTU6MDgsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiAzLzYvMjMgMDQ6
MzIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBGaXhlczogMDUyODk0MDJkNzE3ICgibW0v
ZGVidWdfdm1fcGd0YWJsZTogYWRkIHRlc3RzIHZhbGlkYXRpbmcgYXJjaCBoZWxwZXJzIGZv
ciBjb3JlIE1NIGZlYXR1cmVzIikNCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCj4gDQo+IFRoaXMgbG9va3Mgc2FuZS4gIEFueSByZWFzb24g
dGhpcyBzaG91bGRuJ3QgYmUgY2M6c3RhYmxlQD8NCg0KSXQgd2Fzbid0IG1pc3NlZCBmb3Ig
c2V2ZXJhbCB5ZWFycyBub3csIGFuZCBwcm9kdWN0aW9uIGtlcm5lbHMgd2lsbA0KcHJvYmFi
bHkgbm90IGhhdmUgQ09ORklHX0RFQlVHX1ZNX1BHVEFCTEUgc2V0Lg0KDQpJbiB0aGUgZW5k
IEkgZG9uJ3QgbWluZCBlaXRoZXIgd2F5LiBJdCB3YXMganVzdCBhIGJ1ZyBJIHN0dW1ibGVk
IG92ZXINCmR1cmluZyBkZXZlbG9wbWVudCBvZiBteSBNVFJSIHNlcmllcyAoc29tZW9uZSBt
ZW50aW9uZWQgYSBwcm9ibGVtIGFuZA0KSSBlbmFibGVkIHNhaWQgY29uZmlnIG9wdGlvbiku
DQoNCg0KSnVlcmdlbg0K
--------------yHCu0G6NM0PkjTgyCFe0lmte
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------yHCu0G6NM0PkjTgyCFe0lmte--

--------------Zh6xCUTest0yFg0KhO1Qj6ZE--

--------------ZGWTAMDeMl0qDEfyUhVxcsNe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQF9/cFAwAAAAAACgkQsN6d1ii/Ey/V
Kwf/XjQRu9IhdAkUfQIwJRzz0/dFQbanmbNoOvmhR3U9KRNdwFmy5p+5iqhsFd4twDzztIMcimb7
ItNAr8yV1TrpbXWbZUJ418RXB5OF2NRFu7s39VmkoogdnrmzyGDaAE2j5E/wVZ8TtsDuFg1QtQtF
FTRng7bZIfXZPqOpZpOQ2mo7P8L/1JDx3sa0Y5O7uxN7Hb3HluvxjsPgl+tsSbgAcjDZSW4ZyEhh
Vkyr7iofUqbsu3ptxLsWQffxg0IHyg/SIf82V09Rv+fRtlZW/Dj0p8WbWYsuOxfDSTiNN9P7jBvG
IyglT3CZi5w+PGlyEwJXgQGLhZdCjKyI9gc9LFL3mA==
=WbkP
-----END PGP SIGNATURE-----

--------------ZGWTAMDeMl0qDEfyUhVxcsNe--
