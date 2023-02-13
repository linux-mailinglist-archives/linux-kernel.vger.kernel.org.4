Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC6B693F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBMITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:19:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA27DBD8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:19:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B951E33A08;
        Mon, 13 Feb 2023 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676276339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dVnZ7esjSavwyVx5aDMl7nXGYzgJrmRgZ8E0mkjqaU0=;
        b=pjQXaTSOIZXki8TtiDkPMi9Gk5NmWNQjKOkvzxK1OCRCDZJeWdqX8lGw+QLuv+mQh4rohh
        DnA6QzbqqfEYgk/sogw1vZomO5CKFlcKoS4ZJt7jEdYVxh/32S9L4dBOFBDZKGB6yoNFPe
        XYWMCV+zIc6Wz/rsEyI6AF0qJniYb+E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87541138E6;
        Mon, 13 Feb 2023 08:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X0SOH3Py6WP3NQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 08:18:59 +0000
Message-ID: <a045836e-25c1-3d9b-b3fa-a212f0432cda@suse.com>
Date:   Mon, 13 Feb 2023 09:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] xen: Allow platform PCI interrupt to be shared
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Paul Durrant <paul@xen.org>
References: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------XjEXuqBs0m1ktJEb7SXwGXVm"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------XjEXuqBs0m1ktJEb7SXwGXVm
Content-Type: multipart/mixed; boundary="------------sc7du0J3EGAH8GCtz6wUalHX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Paul Durrant <paul@xen.org>
Message-ID: <a045836e-25c1-3d9b-b3fa-a212f0432cda@suse.com>
Subject: Re: [PATCH] xen: Allow platform PCI interrupt to be shared
References: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>
In-Reply-To: <f9a29a68d05668a3636dd09acd94d970269eaec6.camel@infradead.org>

--------------sc7du0J3EGAH8GCtz6wUalHX
Content-Type: multipart/mixed; boundary="------------TeW6mhYtv2gyTu4GdSJwXTix"

--------------TeW6mhYtv2gyTu4GdSJwXTix
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDEuMjMgMTM6MjIsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToNCj4gRnJvbTogRGF2
aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4NCj4gDQo+IFdoZW4gd2UgZG9uJ3Qg
dXNlIHRoZSBwZXItQ1BVIHZlY3RvciBjYWxsYmFjaywgd2UgYXNrIFhlbiB0byBkZWxpdmVy
IGV2ZW50DQo+IGNoYW5uZWwgaW50ZXJydXB0cyBhcyBJTlR4IG9uIHRoZSBQQ0kgcGxhdGZv
cm0gZGV2aWNlLiBBcyBzdWNoLCBpdCBjYW4gYmUNCj4gc2hhcmVkIHdpdGggSU5UeCBvbiBv
dGhlciBQQ0kgZGV2aWNlcy4NCj4gDQo+IFNldCBJUlFGX1NIQVJFRCwgYW5kIG1ha2UgaXQg
cmV0dXJuIElSUV9IQU5ETEVEIG9yIElSUV9OT05FIGFjY29yZGluZyB0bw0KPiB3aGV0aGVy
IHRoZSBldnRjaG5fdXBjYWxsX3BlbmRpbmcgZmxhZyB3YXMgYWN0dWFsbHkgc2V0LiBOb3cg
SSBjYW4gc2hhcmUNCj4gdGhlIGludGVycnVwdDoNCj4gDQo+ICAgMTE6ICAgICAgICAgODIg
ICAgICAgICAgMCAgIElPLUFQSUMgIDExLWZhc3Rlb2kgICB4ZW4tcGxhdGZvcm0tcGNpLCBl
bnM0DQo+IA0KPiBEcm9wIHRoZSBJUlFGX1RSSUdHRVJfUklTSU5HLiBJdCBoYXMgbm8gZWZm
ZWN0IHdoZW4gdGhlIElSUSBpcyBzaGFyZWQsDQo+IGFuZCBiZXNpZGVzLCB0aGUgb25seSBl
ZmZlY3QgaXQgd2FzIGhhdmluZyBldmVuIGJlZm9yZWhhbmQgd2FzIHRvIHRyaWdnZXINCj4g
YSBkZWJ1ZyBtZXNzYWdlIGluIGJvdGggSS9PQVBJQyBhbmQgbGVnYWN5IFBJQyBjYXNlczoN
Cj4gDQo+IFsgICAgMC45MTU0NDFdIGdlbmlycTogTm8gc2V0X3R5cGUgZnVuY3Rpb24gZm9y
IElSUSAxMSAoSU8tQVBJQykNCj4gWyAgICAwLjk1MTkzOV0gZ2VuaXJxOiBObyBzZXRfdHlw
ZSBmdW5jdGlvbiBmb3IgSVJRIDExIChYVC1QSUMpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBE
YXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNvLnVrPg0KDQpQdXNoZWQgdG86IHhlbi90
aXAuZ2l0IGZvci1saW51cy02LjMNCg0KDQpKdWVyZ2VuDQoNCg==
--------------TeW6mhYtv2gyTu4GdSJwXTix
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TeW6mhYtv2gyTu4GdSJwXTix--

--------------sc7du0J3EGAH8GCtz6wUalHX--

--------------XjEXuqBs0m1ktJEb7SXwGXVm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp8nMFAwAAAAAACgkQsN6d1ii/Ey9Q
XQgAkeN5Ytwitra2Jv+KFtnD/SZfWvMnS6Gq0ml4iVdxUwKen+2jpZmczoCovziPt7hzUJSl9JiU
TVTOrNG4mqPgHnhODHjRLI4dGpzM1evLusKbS5fMODi6HPQAzKQ5R/qp7y2NQQKnVhn7z3S8bXzb
j7jO+P0f5n6FwR080IoGNmdMoB2d9LUYuQGu5wyrFP1qZ85fA1dTtrQaNugHF8fjEnk+jcMYw+re
mxeWKANCdL1u20egHPZH30P4wZHvSLKzNGwH3Ep4/f+f8Oadm5p9ECc3MRlJ6bjrlRiq0c1yVczD
UAZGCqpKexhEM7kWWq1PjAwow8xgHyuL6e29ENcVvQ==
=zttk
-----END PGP SIGNATURE-----

--------------XjEXuqBs0m1ktJEb7SXwGXVm--
