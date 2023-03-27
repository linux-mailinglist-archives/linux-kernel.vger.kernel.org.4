Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835706CA78F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjC0O15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjC0O1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:27:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671F59EF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:26:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B7C791FDB1;
        Mon, 27 Mar 2023 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679927185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zkUGfTBzri88vyqVRAjr/zBGLSkKyUU2kKjDDkG9L+I=;
        b=AzKV+n6O7HzHwGPodrH53Kh/y/+Wx1niqMAj8L+r8sRmOqSk45BihCwrXstKZc/CW6v840
        tDzxArmKyUkljptD+sU//4sykzqafSl4Hf3dqzC/yJ2s+OMTs7QCzLZbVbpM7Kq2dZlrKj
        sQJXIQV4zVSV9fRu3b8VdavH8FYxCGw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AB3413482;
        Mon, 27 Mar 2023 14:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rr0vHJGnIWTiEgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Mar 2023 14:26:25 +0000
Message-ID: <d5f7e4ac-2085-41ac-11c6-8cb3085a666f@suse.com>
Date:   Mon, 27 Mar 2023 16:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306123259.12461-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EjWHNbc13qvC6nsinH0B5LKF"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EjWHNbc13qvC6nsinH0B5LKF
Content-Type: multipart/mixed; boundary="------------5x5b1r5f3Ip9uZpSkVM8Wcwt";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d5f7e4ac-2085-41ac-11c6-8cb3085a666f@suse.com>
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
References: <20230306123259.12461-1-jgross@suse.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>

--------------5x5b1r5f3Ip9uZpSkVM8Wcwt
Content-Type: multipart/mixed; boundary="------------cUCYvEIEk35DiR9lq2vPWw0O"

--------------cUCYvEIEk35DiR9lq2vPWw0O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDMuMjMgMTM6MzIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE5vcm1hbGx5IF9f
c3dwX2VudHJ5X3RvX3B0ZSgpIGlzIG5ldmVyIGNhbGxlZCB3aXRoIGEgdmFsdWUgdHJhbnNs
YXRpbmcNCj4gdG8gYSB2YWxpZCBQVEUuIFRoZSBvbmx5IGtub3duIGV4Y2VwdGlvbiBpcyBw
dGVfc3dhcF90ZXN0cygpLCByZXN1bHRpbmcNCj4gaW4gYSBXQVJOIHNwbGF0IGluIFhlbiBQ
ViBndWVzdHMsIGFzIF9fcHRlX3RvX3N3cF9lbnRyeSgpIGRpZA0KPiB0cmFuc2xhdGUgdGhl
IFBGTiBvZiB0aGUgdmFsaWQgUFRFIHRvIGEgZ3Vlc3QgbG9jYWwgUEZOLCB3aGlsZQ0KPiBf
X3N3cF9lbnRyeV90b19wdGUoKSBkb2Vzbid0IGRvIHRoZSBvcHBvc2l0ZSB0cmFuc2xhdGlv
bi4NCj4gDQo+IEZpeCB0aGF0IGJ5IHVzaW5nIF9fcHRlKCkgaW4gX19zd3BfZW50cnlfdG9f
cHRlKCkgaW5zdGVhZCBvZiBvcGVuDQo+IGNvZGluZyB0aGUgbmF0aXZlIHZhcmlhbnQgb2Yg
aXQuDQo+IA0KPiBGb3IgY29ycmVjdG5lc3MgZG8gdGhlIHNpbWlsYXIgY29udmVyc2lvbiBm
b3IgX19zd3BfZW50cnlfdG9fcG1kKCkuDQo+IA0KPiBGaXhlczogMDUyODk0MDJkNzE3ICgi
bW0vZGVidWdfdm1fcGd0YWJsZTogYWRkIHRlc3RzIHZhbGlkYXRpbmcgYXJjaCBoZWxwZXJz
IGZvciBjb3JlIE1NIGZlYXR1cmVzIikNCj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KDQpBbnkgZnVydGhlciBjb21tZW50cyAoYXBhcnQgZnJv
bSAiSXQgbG9va3Mgc2FuZSIpPw0KDQoNCkp1ZXJnZW4NCg0K
--------------cUCYvEIEk35DiR9lq2vPWw0O
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------cUCYvEIEk35DiR9lq2vPWw0O--

--------------5x5b1r5f3Ip9uZpSkVM8Wcwt--

--------------EjWHNbc13qvC6nsinH0B5LKF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQhp5EFAwAAAAAACgkQsN6d1ii/Ey/E
owf+PVmqjkOPs7w1cO4uAHOljMzBXJmWDCcvsGTpzRt69oQqWOU7RZHSYEn3aG7jsboLqkn6pb7v
cXhnV+fpyssbzKQik/F/0Lm1HGMwpN4prDWbn3nQFHm0wZmzveKvvWLQVlynBy83AuWdZytOWD3O
T+6zmtHycOmn0++JvdTWuHw8kiQ5CJWWHxhFmIs7Yw9Gvnq7jiVNrOn45lJ3FQwuTjVV3lgjHwNy
nycQoJ3Uus/2Yi5YCFjUZ7S8OCw+seiIqJgxaBu5GbRITm1W4w0nNdwo/+PeVwTp1iSGIasZgvgV
Eq9VlRWgK4y/oTNiIApWQSn2UyFmjn3JnQ9h1PNyjw==
=S3X8
-----END PGP SIGNATURE-----

--------------EjWHNbc13qvC6nsinH0B5LKF--
