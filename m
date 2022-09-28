Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2755EDB85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiI1LPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiI1LOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:14:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D713D78
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:14:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 395891F8A3;
        Wed, 28 Sep 2022 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664363652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tqwjTNsNpcERWjDz1fPON8xYqOIAIB1dbYDmCmw5vcU=;
        b=s2j/BTUEXoHigtOP0NP3smq+bX7JycHyjAEsT+lU7PpRhL8PPylsgDsoJpJ++tEcayuQXf
        qT4vNrvVothrRH/ywshInHHLUq2JenK90tk4X6tTSTboDFsBPfBTtvYe9y/K2+0m250bh2
        kFuVBWdui+aJHO7Y5DWTvVujYQwPkx0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F080D13677;
        Wed, 28 Sep 2022 11:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RA1iOYMsNGOPHQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 28 Sep 2022 11:14:11 +0000
Message-ID: <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
Date:   Wed, 28 Sep 2022 13:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
 <YzLMKk4OK9FtjjKQ@zn.tnic> <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic> <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
In-Reply-To: <YzQmeh50ne8dyR2P@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ETT5g0gHWN2exwGxTbC4Uq0u"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ETT5g0gHWN2exwGxTbC4Uq0u
Content-Type: multipart/mixed; boundary="------------C3cZWpcpO0cpAejN1RTVDpfh";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f8da6988-afa3-1e85-b47d-d91fc4113803@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
 <YzLMKk4OK9FtjjKQ@zn.tnic> <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic> <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic> <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic> <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com> <YzQmeh50ne8dyR2P@zn.tnic>
In-Reply-To: <YzQmeh50ne8dyR2P@zn.tnic>

--------------C3cZWpcpO0cpAejN1RTVDpfh
Content-Type: multipart/mixed; boundary="------------pkOBvL0jXdBhxRtMG2wraaA9"

--------------pkOBvL0jXdBhxRtMG2wraaA9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDkuMjIgMTI6NDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBT
ZXAgMjgsIDIwMjIgYXQgMDg6MTY6NTNBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+PiBBcmUgc3VyZSB0aGUgaG90cGx1ZyBub3RpZmllciBkb2Vzbid0IGdldCBjYWxsZWQg
aW4gdGhlIGJvb3QgYW5kIGluIHRoZQ0KPiANCj4gSXQgZG9lc24ndCBiZWNhdXNlIGl0IGdl
dHMgcmVnaXN0ZXJlZCBhZnRlciBzbXBfaW5pdCgpLi4uDQo+IA0KPj4+IHJlc3VtZSBjYXNl
cz8NCj4gDQo+IC4uLiBidXQgaXQgZ2V0cyBjYWxsZWQgZHVyaW5nIHJlc3VtZSBiZWNhdXNl
IGJ5IHRoYXQgdGltZSB0aGUgbm90aWZpZXINCj4gaGFzIGJlZW4gcmVnaXN0ZXJlZCBhbHJl
YWR5LiBTZWUgbXkgbm90ZXMgYXQgdGhlIGVuZCBvZiB0aGlzIG1haWwgb2YNCj4gd2hhdCB0
aGUgY29kZSBkb2VzIGN1cnJlbnRseS4NCj4gDQo+PiBJbiBjYXNlIG15IHN1c3BpY2lvbiBp
cyBjb3JyZWN0OiB0aGlzIGNhbiBzdGlsbCBiZSBzb2x2ZWQgYnkgYWRkaW5nIHRoZQ0KPj4g
aG90cGx1ZyBub3RpZmllciBvbmx5IGluIG10cnJfYXBzX2luaXQoKSwgYW5kIHJlbW92aW5n
IGl0IGFnYWluIGluDQo+PiBhcmNoX3RoYXdfc2Vjb25kYXJ5X2NwdXNfYmVnaW4oKS4NCj4g
DQo+IFByZXR0eSBtdWNoLiBZZWFoLCB3ZSBzdGlsbCBuZWVkIGEgYm9vbC4gOy0oDQoNCk5v
LCB3ZSBkb24ndC4NCg0KVXNpbmcgYmFzaWNhbGx5IHlvdXIgcGF0Y2gsIGJ1dCB3aXRoDQoN
CisJbXRycl9vbmxpbmUgPSBjcHVocF9zZXR1cF9zdGF0ZV9ub2NhbGxzKENQVUhQX0FQX09O
TElORV9EWU4sDQorCQkJCQkJIng4Ni9tdHJyOm9ubGluZSIsDQorCQkJCQkJbXRycl9hcF9p
bml0LCBOVUxMKTsNCg0KbW92ZWQgdG8gdGhlIGVuZCBvZiBtdHJyX2Fwc19pbml0KCksIGFu
ZDoNCg0KK3ZvaWQgbXRycl9hcHNfdGhhdyh2b2lkKQ0KK3sNCisJY3B1aHBfcmVtb3ZlX3N0
YXRlX25vY2FsbHMobXRycl9vbmxpbmUpOw0KK30NCg0KDQpKdWVyZ2VuDQo=
--------------pkOBvL0jXdBhxRtMG2wraaA9
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------pkOBvL0jXdBhxRtMG2wraaA9--

--------------C3cZWpcpO0cpAejN1RTVDpfh--

--------------ETT5g0gHWN2exwGxTbC4Uq0u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM0LIMFAwAAAAAACgkQsN6d1ii/Ey/j
Owf/RL1w9WJzcN+awH6cnj7SpHSu0q93P9keOjhDUnshuEl0+Are4SqCEePlZ1H7d0H7DJ8OOUl5
+GrIz88AXcTDeU+lWlzFmqB9+sPqBZH5GEMUV2mHTZsXwR9yuaoutabP7RKSxZW6XHZvQfnvZUkQ
XwRiSD5fY7OIt0h9Qx5uFNA5dJipZrLNadCF+UgKD8bgOy4ah09dLoCJotottqyvhQQYaNgffsRF
8JAF7v8/0STXdpErNLyRIPdVFycKQBSh8saWyAAdkPkO2widm2gpquRmBdc4GZ2TC/iKEp/XzkYO
pa97GtsV27M4g7jwdE59veoizcv166dIKA2of2PC7A==
=YBSE
-----END PGP SIGNATURE-----

--------------ETT5g0gHWN2exwGxTbC4Uq0u--
