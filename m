Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73F695DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBNJC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjBNJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:02:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C38C9EE8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:02:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8E9C21A28;
        Tue, 14 Feb 2023 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676365371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bF3jDApjNW26t4tLyDhWytyu2IQI1stRwWXu/B9AtW8=;
        b=NpPAdo0z659OUQOa5eR8ThPzmaxX1fPEwS8VbnMRvFipa8Ae70T4T09LdLMpxNHl7Onqh2
        RWTB1VCyvHWMoS4RIXVOAGgwo1zCQtEidJ4X+INgpNHv1VjTqwUNOUErdYKMwv4rJZVZdV
        wVy4tzDLm5zJn1P2FySkvwZiE3Sx+XM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A628138E3;
        Tue, 14 Feb 2023 09:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L9kOJDtO62OAOQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Feb 2023 09:02:51 +0000
Message-ID: <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com>
Date:   Tue, 14 Feb 2023 10:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic> <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic> <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
 <Y+qHMsZhYaYEmtTo@zn.tnic> <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com>
 <Y+tNQvpXdOAfZztQ@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y+tNQvpXdOAfZztQ@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nsT2iSRPHxREuCnBuARkjR0w"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nsT2iSRPHxREuCnBuARkjR0w
Content-Type: multipart/mixed; boundary="------------blNVoTU84NBASNEzyEVItI7E";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3520cd7f-0e60-b140-9fd3-032ddb6778b5@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic> <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
 <Y+pZ5ccprqequvpE@zn.tnic> <ca2e1560-5846-2a4b-6c27-aa8ceb17ee5c@suse.com>
 <Y+qHMsZhYaYEmtTo@zn.tnic> <6f561386-9bc4-a3bf-656d-db27a2275413@suse.com>
 <Y+tNQvpXdOAfZztQ@zn.tnic>
In-Reply-To: <Y+tNQvpXdOAfZztQ@zn.tnic>

--------------blNVoTU84NBASNEzyEVItI7E
Content-Type: multipart/mixed; boundary="------------aNFAgLncfhUMdpJAJGQmszg2"

--------------aNFAgLncfhUMdpJAJGQmszg2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDIuMjMgMDk6NTgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBG
ZWIgMTQsIDIwMjMgYXQgMDg6MDQ6NDdBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9rYXksIGlmIHlvdSByZWFsbHkgd2FudCB0byBkaWN0YXRlIHRoZSBhbGxvd2VkIHVz
ZSBjYXNlcyAodGhpcyBzZWVtcyB0byBiZQ0KPiANCj4gUmVhZCB1cHRocmVhZCAtIFREWCBn
dWVzdHMgY2F1c2UgI1ZFcyBmb3IgTVRSUiBhY2Nlc3Nlcy4gI1ZFcyB3aGljaCBhcmUNCj4g
dW5uZWVkZWQgYW5kIHNob3VsZCBiZSBhdm9pZGVkIGlmIHBvc3NpYmxlLg0KDQpPZiBjb3Vy
c2UsIEkgZG9uJ3QgcXVlc3Rpb24gdGhlIG5lZWQgZm9yIFREWCBndWVzdHMgdG8gdXNlIHRo
ZSBvdmVyd3JpdGUuDQoNCj4gDQo+PiBhIGxheWVyaW5nIHZpb2xhdGlvbiksIGJ1dCB5b3Ug
YXJlIHRoZSBtYWludGFpbmVyIG9mIHRoYXQgY29kZS4NCj4gDQo+IEFuZCB3aHkgYXJlIHlv
dSBzbyBhZ2FpbnN0IGNhdGNoaW5nIG1pc3VzZXMgb2YgdGhpcywgd2hpY2ggc2hvdWxkDQo+
IGFic29sdXRlbHkgKm5vdCogYmUgbmVlZGVkIGJ5IGFueXRoaW5nIGVsc2UNCg0KSSBqdXN0
IGRvbid0IGxpa2UgdGhlIGlkZWEgb2YgdHJ5aW5nIHRvIGNhdGNoIGFsbCBwb3NzaWJsZSBt
aXN1c2VzIGluDQpsb3dlciBsZXZlbHMsIGF0IHRoZSBzYW1lIHRpbWUgaW50cm9kdWNpbmcg
dGhlIG5lZWQgdG8gbW9kaWZ5IHRob3NlDQp0ZXN0cyBpbiBjYXNlIGEgbmV3IHZhbGlkIHVz
ZSBjYXNlIGlzIHBvcHBpbmcgdXAuDQoNCkJ1dCBhcyBzYWlkLCB5b3UgYXJlIHRoZSBtYWlu
dGFpbmVyLCBzbyBpdHMgeW91ciBmaW5hbCBkZWNpc2lvbi4NCg0KDQpKdWVyZ2VuDQo=
--------------aNFAgLncfhUMdpJAJGQmszg2
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------aNFAgLncfhUMdpJAJGQmszg2--

--------------blNVoTU84NBASNEzyEVItI7E--

--------------nsT2iSRPHxREuCnBuARkjR0w
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPrTjsFAwAAAAAACgkQsN6d1ii/Ey82
FwgAjEKiTJzONmIvA6QhiJ4RXLn0XFdkBTdVEqjX+p7Hkx5aPK9Ui18FhCjrkbakcg5L63VVkzKC
61Kv1scz6qs/RbhrsBu0JBMcbelPuM4likEnZPPSe3KEUgrGdHawL1eAErhiR0sozfR6SQZRyq0Q
8CF7ty0fFdhUGGLX9jcvIK6kGKLdk2mQqBtW0ZEaHABjElMjc+aMVjRxyhWL64eSK5K6cx/lBEZw
D2WIwYrUOTbxp+7YqwRpJbYJdTSu6+VEhgSKvkY94GC4CZxEXLRVNBjyehb5U+Jcl8/AWxnlb3D5
xpaOgIV62N2/LfOpf3/YxfBmeHyWkQyWYDJmBhnK5A==
=FNW+
-----END PGP SIGNATURE-----

--------------nsT2iSRPHxREuCnBuARkjR0w--
