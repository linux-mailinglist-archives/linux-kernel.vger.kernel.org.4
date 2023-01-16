Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C184366B797
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAPGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjAPGn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:43:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B64495
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:43:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA01C34E8C;
        Mon, 16 Jan 2023 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673851406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqQqkkW8vDqXYBwySLpMuxVJV9a63KYmU1amJWZzGc4=;
        b=P2wXriVIfUN3At+wL+o1ULRQl7N/2JdPYEOOoKn4IkbYr7aJqKzEAr2DR7fxmzyIWpjuZZ
        YQUJbqqMFE8so695aDnsbRO0ClAdncmMWZK3pZyfq2ngtcbcuXFdRg+rbAwJJJ31qlnVf6
        hv0iVP0TVetu/KwwIg71uWDVuXR8TCU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C10B139C2;
        Mon, 16 Jan 2023 06:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /f+PHA7yxGOZXgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Jan 2023 06:43:26 +0000
Message-ID: <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
Date:   Mon, 16 Jan 2023 07:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f2QYQmcp7oyhJ0GflGkKSPBI"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f2QYQmcp7oyhJ0GflGkKSPBI
Content-Type: multipart/mixed; boundary="------------PYYImwLJ6duLYMmgfXqX04GL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Message-ID: <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
In-Reply-To: <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>

--------------PYYImwLJ6duLYMmgfXqX04GL
Content-Type: multipart/mixed; boundary="------------0z6dtOJSlYZ8eWZSil6wUXCH"

--------------0z6dtOJSlYZ8eWZSil6wUXCH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDEuMjMgMDU6MjcsIFNyaXZhdHNhIFMuIEJoYXQgd3JvdGU6DQo+IA0KPiBIaSBK
dWVyZ2VuLA0KPiANCj4gT24gMS8xMi8yMyA3OjIxIEFNLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4gVGhlIHR3byBwYXJhdmlydCBjYWxsYmFja3MgLm1tdS5hY3RpdmF0ZV9tbSBhbmQg
Lm1tdS5kdXBfbW1hcCBhcmUNCj4+IHNoYXJpbmcgdGhlIHNhbWUgaW1wbGVtZW50YXRpb25z
IGluIGFsbCBjYXNlczogZm9yIFhlbiBQViBndWVzdHMgdGhleQ0KPj4gYXJlIHBpbm5pbmcg
dGhlIFBHRCBvZiB0aGUgbmV3IG1tX3N0cnVjdCwgYW5kIGZvciBhbGwgb3RoZXIgY2FzZXMN
Cj4+IHRoZXkgYXJlIGEgTk9QLg0KPj4NCj4gDQo+IEkgd2FzIGV4cGVjdGluZyB0aGF0IHRo
ZSBkdXBsaWNhdGVkIGZ1bmN0aW9ucyB4ZW5fYWN0aXZhdGVfbW0oKSBhbmQNCj4geGVuX2R1
cF9tbWFwKCkgd291bGQgYmUgbWVyZ2VkIGludG8gYSBjb21tb24gb25lLCBhbmQgdGhhdCBi
b3RoDQo+IC5tbXUuYWN0aXZhdGVfbW0gYW5kIC5tbXUuZHVwX21tYXAgY2FsbGJhY2tzIHdv
dWxkIGJlIG1hcHBlZCB0byB0aGF0DQo+IGNvbW1vbiBpbXBsZW1lbnRhdGlvbiBmb3IgWGVu
IFBWLg0KPiANCj4+IFNvIG1lcmdlIHRoZW0gdG8gYSBjb21tb24gY2FsbGJhY2sgLm1tdS5l
bnRlcl9tbWFwIChpbiBjb250cmFzdCB0byB0aGUNCj4+IGNvcnJlc3BvbmRpbmcgYWxyZWFk
eSBleGlzdGluZyAubW11LmV4aXRfbW1hcCkuDQo+Pg0KPiANCj4gSW5zdGVhZCwgdGhpcyBw
YXRjaCBzZWVtcyB0byBiZSBtZXJnaW5nIHRoZSBjYWxsYmFja3MgdGhlbXNlbHZlcy4uLg0K
PiANCj4gSSBzZWUgdGhhdCdzIG5vdCBhbiBpc3N1ZSByaWdodCBub3cgc2luY2UgdGhlcmUg
aXMgbm8gb3RoZXIgYWN0dWFsDQo+IHVzZXIgZm9yIHRoZXNlIGNhbGxiYWNrcy4gQnV0IGFy
ZSB3ZSBzdXJlIHRoYXQgbWVyZ2luZyB0aGUgY2FsbGJhY2tzDQo+IGp1c3QgYmVjYXVzZSB0
aGUgY3VycmVudCB1c2VyIChYZW4gUFYpIGhhcyB0aGUgc2FtZSBpbXBsZW1lbnRhdGlvbiBm
b3INCj4gYm90aCBpcyBhIGdvb2QgaWRlYT8gVGhlIGNhbGxiYWNrcyBhcmUgaW52b2tlZCBh
dCBkaXN0aW5jdCBwb2ludHMgZnJvbQ0KPiBmb3JrL2V4ZWMsIHNvIHdvdWxkbid0IGl0IGJl
IHZhbHVhYmxlIHRvIHJldGFpbiB0aGF0IGRpc3RpbmN0aW9uIGluDQo+IHNlbWFudGljcyBp
biB0aGUgY2FsbGJhY2tzIGFzIHdlbGw/DQo+IA0KPiBIb3dldmVyLCBpZiB5b3UgYmVsaWV2
ZSB0aGF0IHR3byBzZXBhcmF0ZSBjYWxsYmFja3MgYXJlIG5vdCByZWFsbHkNCj4gcmVxdWly
ZWQgaGVyZSAoYmVjYXVzZSB0aGVyZSBpcyBubyBzaWduaWZpY2FudCBkaWZmZXJlbmNlIGlu
IHdoYXQgdGhleQ0KPiBtZWFuLCByYXRoZXIgdGhhbiBiZWNhdXNlIHRoZWlyIGNhbGxiYWNr
IGltcGxlbWVudGF0aW9ucyBoYXBwZW4gdG8gYmUNCj4gdGhlIHNhbWUgcmlnaHQgbm93KSwg
dGhlbiBjb3VsZCB5b3UgcGxlYXNlIGV4cGFuZCBvbiB0aGlzIGFuZCBjYWxsIGl0DQo+IG91
dCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHBsZWFzZT8NCg0KV291bGQgeW91IGJlIGZpbmUg
d2l0aDoNCg0KICAgSW4gdGhlIGVuZCBib3RoIGNhbGxiYWNrcyBhcmUgbWVhbnQgdG8gcmVn
aXN0ZXIgYW4gYWRkcmVzcyBzcGFjZSB3aXRoIHRoZQ0KICAgdW5kZXJseWluZyBoeXBlcnZp
c29yLCBzbyB0aGVyZSBuZWVkcyB0byBiZSBvbmx5IGEgc2luZ2xlIGNhbGxiYWNrIGZvciB0
aGF0DQogICBwdXJwb3NlLg0KDQoNCkp1ZXJnZW4NCg==
--------------0z6dtOJSlYZ8eWZSil6wUXCH
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0z6dtOJSlYZ8eWZSil6wUXCH--

--------------PYYImwLJ6duLYMmgfXqX04GL--

--------------f2QYQmcp7oyhJ0GflGkKSPBI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPE8g0FAwAAAAAACgkQsN6d1ii/Ey8t
Ngf/d6OpWFNSFigpwYK7Kc+TkmGV5RqwiPEJMARDOsmaX6zjIzYvRHgoC6x2XUwznZlE8lTWf1gV
EfFTLU3ZqmW3RwxZJp8Be1GKpDJwHlVtIiuK5PUV44QPQbiCWlaqHZtMZ/UV8n5ToaFL8ocXG/sl
vWEgWlgZps0DvwculC02JvVYmhV4+oiaO48Ko796E5XpXskYzd72e3IP9TuLo+gH6uDPKRaU3fmc
1QBVa4Da7mcD/JIQ8++Lt5L/DtaApmTFlgk6jqUUjo0xKJumtDzyuoTsV8o/kGXP4PFEgLfKJZy4
KM8/GTRX4GVomox/Ate31wf6jZCRkibNzLebhhUnIQ==
=EPIp
-----END PGP SIGNATURE-----

--------------f2QYQmcp7oyhJ0GflGkKSPBI--
