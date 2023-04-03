Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A76D40C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjDCJh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjDCJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:37:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5E1165E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:36:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DBABB1F8D9;
        Mon,  3 Apr 2023 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680514540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sQsLyx1gubCJfclC/Ta4ETdqTF1+xJi5O/1DqQ++/tw=;
        b=ieYJ6IVK+SVYaT2WtUuaj9MiFafOxOspmG+qPAYOldpr73Y4N+6S6kNMm0g9lCRN3CZhrM
        H3MYAmNAW4gZEcyWnqcu3hRq9cM0FcGQP1XnMQJTWj2NH0GsYYvRZRpmAWNDX4wPH6SRnx
        eScOjKYHY6uCByiKS6Vhw05LJcqDV6o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98F4B13416;
        Mon,  3 Apr 2023 09:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p7/kI+ydKmSAZgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 03 Apr 2023 09:35:40 +0000
Message-ID: <d5df822d-a8bc-c08c-cab4-53a0e1df2ff2@suse.com>
Date:   Mon, 3 Apr 2023 11:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "bp@alien8.de" <bp@alien8.de>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
 <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
 <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vZKsiMNKs6bc1PHV9NYMHlNn"
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vZKsiMNKs6bc1PHV9NYMHlNn
Content-Type: multipart/mixed; boundary="------------XU70SLyBYZ7yAa08TYJOZ0ml";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Huang, Kai" <kai.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>
Message-ID: <d5df822d-a8bc-c08c-cab4-53a0e1df2ff2@suse.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
 <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
 <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
In-Reply-To: <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>

--------------XU70SLyBYZ7yAa08TYJOZ0ml
Content-Type: multipart/mixed; boundary="------------ancYYE7s0yjyv4Ll7jKboDOh"

--------------ancYYE7s0yjyv4Ll7jKboDOh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDQuMjMgMTE6MjcsIEh1YW5nLCBLYWkgd3JvdGU6DQo+IA0KPj4+PiAgIMKgLyoq
DQo+Pj4+ICAgwqAgKiBtdHJyX3R5cGVfbG9va3VwIC0gbG9vayB1cCBtZW1vcnkgdHlwZSBp
biBNVFJSDQo+Pj4+ICAgwqAgKg0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2NwdS9tdHJyL210cnIuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4+
Pj4gaW5kZXggMWJlYjM4ZjdhN2EzLi4xYzE5ZDY3ZGRhYjMgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4+Pj4gKysrIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9tdHJyL210cnIuYw0KPj4+PiBAQCAtNjY2LDYgKzY2NiwxNSBAQCB2b2lk
IF9faW5pdCBtdHJyX2JwX2luaXQodm9pZCkNCj4+Pj4gICDCoAljb25zdCBjaGFyICp3aHkg
PSAiKG5vdCBhdmFpbGFibGUpIjsNCj4+Pj4gICDCoAl1bnNpZ25lZCBpbnQgcGh5c19hZGRy
Ow0KPj4+PiAgICANCj4+Pj4gKwlpZiAoIWdlbmVyaWNfbXRycnMgJiYgbXRycl9zdGF0ZS5l
bmFibGVkKSB7DQo+Pj4+ICsJCS8qIFNvZnR3YXJlIG92ZXJ3cml0ZSBvZiBNVFJSIHN0YXRl
LCBvbmx5IGZvciBnZW5lcmljIGNhc2UuICovDQo+Pj4gCQkJCQkJCSAgICAgIF4NCj4+PiAJ
CQkJCQkJICAgICAgIWdlbmVyaWMgY2FzZT8NCj4+DQo+PiBOby4gVGhpcyB0ZXN0IGp1c3Qg
dmVyaWZpZXMgdGhhdCB0aGUgKHZpc2libGUpIE1UUlIgZmVhdHVyZSBpcyBzd2l0Y2hlZCBv
ZmYsDQo+PiBhcyB0aGVyZSBhcmUgbm8gd2F5cyB0byBtb2RpZnkgYW55IE1UUlIgcmVnaXN0
ZXJzIGluIHRoZSBvdmVyd3JpdGUgY2FzZS4NCj4+DQo+PiBJIGNhbiBtYWtlIHRoaXMgbW9y
ZSBvYnZpb3VzIGluIGEgY29tbWVudC4NCj4gDQo+IFNob3VsZCB0aGUgY29tbWVudCBzYXkg
c29tZXRoaW5nIGxpa2UgKGJlY2F1c2UgaXQgYXBwbGllcyB0byB0aGUgY29kZSBpbnNpZGUg
dGhlDQo+IGNoZWNrKToNCj4gDQo+IA0KPiAJSWYgd2UgaGF2ZSBhIHN0YXRpYyAoc3ludGhl
dGljKSBNVFJSIGFscmVhZHkgZXN0YWJsaXNoZWQgZm9yIHNwZWNpYWwNCj4gCVZNcywgd2Ug
c3RpbGwgbmVlZCB0byBjYWxjdWxhdGUgdGhlIHBoeXNpY2FsIGFkZHJlc3MgYml0cyB1c2lu
Zw0KPiBnZW5lcmljDQo+IAl3YXksIGJlY2F1c2UgdGhlIGhhcmR3YXJlIHRvIHJ1biB0aG9z
ZSBzcGVjaWFsIFZNcyBpbmRlZWQgaGFzwqBNVFJSLg0KPiANCj4gVGhhdCBleHBsYWlucyB3
aHkgJ3RydWUnIGlzIHBhc3NlZCB0byBtdHJyX2NhbGNfcGh5c2JpdHMoKS4NCg0KSSdkIHJh
dGhlciBzYXkgdGhhdCB0aGUgaW50ZXJmYWNlIG9mIG10cnJfb3ZlcndyaXRlX3N0YXRlKCkg
aXMgYmFzZWQgb24gdGhlDQppbnRlcmZhY2Ugb2YgZ2VuZXJpYyBNVFJScy4NCg0KDQpKdWVy
Z2VuDQo=
--------------ancYYE7s0yjyv4Ll7jKboDOh
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ancYYE7s0yjyv4Ll7jKboDOh--

--------------XU70SLyBYZ7yAa08TYJOZ0ml--

--------------vZKsiMNKs6bc1PHV9NYMHlNn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQqnewFAwAAAAAACgkQsN6d1ii/Ey/Q
3QgAnU+8tUZw2mMM9/FLGEbtu/pNNUYav8fUa1W8EjmcaUO7/N3nBxM4memhpVsEj8llFSltEh4t
mw0kS2z22Q9PrvZBIEMJcjau5UB8BugNKXQzfL5xIYTobyuC+DtsoGsu+M6SIsgPNPgLZ3f3UudQ
a+d0t0OtuZkJCIxFxQ2xG71d93/rxlWSOISLs02gnwjHXQMqXAfAuUrRBGQmvPnmVcZWQTUXyW+/
tVqKia+64nyaHYFQvCcxXASeSMEJxiWec1wM1vgqJCzTLetj1hbY0UfCVrFzbFSdy913Xs+Q2x06
8JXsIP0ByasW/9ezJHzeIeJMg03JY/6PCSFoT78DgQ==
=Ps3S
-----END PGP SIGNATURE-----

--------------vZKsiMNKs6bc1PHV9NYMHlNn--
