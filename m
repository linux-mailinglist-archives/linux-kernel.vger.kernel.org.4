Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86E6C3638
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCUPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCUPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:50:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376AB1E1FD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:49:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AFA1201E3;
        Tue, 21 Mar 2023 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679413777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UJ2Iz+amkrrjC0ajsYvkZeQ+jNfieQ5XOsz75HWYu0=;
        b=tM8QXClRYiFQWHQ5sUHghSb1/ZFlN8pwmKegGYvAiFV/9aZLJSNfjKRI5B0ilby9Z/Cf2r
        GAoT9NaVTUl4y6WA+9icZ8db145V94tfWGmGsgAwjgWmlrXFKmX2Zw1p7qx3UoQenb8crW
        DZzBLQcPeQBo4rs7YI+t+8CHkxkMO68=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50A9C13451;
        Tue, 21 Mar 2023 15:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X4EyEhHSGWROZwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 21 Mar 2023 15:49:37 +0000
Message-ID: <0552d5a7-b6b7-e3e0-4d20-a64d455c2948@suse.com>
Date:   Tue, 21 Mar 2023 16:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-4-jgross@suse.com>
 <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
 <01ec6ce2-7639-2e4f-3433-c77c29fa7984@suse.com>
 <20230321103058.GAZBmHYmhs4s7J+giU@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230321103058.GAZBmHYmhs4s7J+giU@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------giNNIC0AT2HhN8koOLempJtX"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------giNNIC0AT2HhN8koOLempJtX
Content-Type: multipart/mixed; boundary="------------XLWHhQuW63PaONggRK8KcmQk";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <0552d5a7-b6b7-e3e0-4d20-a64d455c2948@suse.com>
Subject: Re: [PATCH v4 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-4-jgross@suse.com>
 <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
 <01ec6ce2-7639-2e4f-3433-c77c29fa7984@suse.com>
 <20230321103058.GAZBmHYmhs4s7J+giU@fat_crate.local>
In-Reply-To: <20230321103058.GAZBmHYmhs4s7J+giU@fat_crate.local>

--------------XLWHhQuW63PaONggRK8KcmQk
Content-Type: multipart/mixed; boundary="------------NLGy2DtqayEsWFi2P9kurJpF"

--------------NLGy2DtqayEsWFi2P9kurJpF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDMuMjMgMTE6MzAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBN
YXIgMjEsIDIwMjMgYXQgMDc6MDA6NThBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEkgZ3Vlc3MgeW91IGFyZSBhc2tpbmcgYmVjYXVzZSB0aGUgbmV4dCB0ZXN0IHNlZW1z
IHRvIGNhdGNoIHRoZSBzYW1lIGNhc2U/DQo+Pg0KPj4gSSB0aGluayBpdCBkb2Vzbid0LCBl
LmcuIGZvciB0aGUgY2FzZSBvZiB1bmtub3duIGh5cGVydmlzb3JzICh3aGljaCBzaG93cyB0
aGF0DQo+PiBYODZfSFlQRVJfTkFUSVZFIGluIHRoZW9yeSBzaG91bGQgYmUgbmFtZWQgWDg2
X0hZUEVSX05BVElWRV9PUl9VTktOT1dOLCBvciBpdA0KPj4gc2hvdWxkIGJlIHNwbGl0IGlu
dG8gWDg2X0hZUEVSX05BVElWRSBhbmQgWDg2X0hZUEVSX1VOS05PV04pLg0KPiANCj4gWWVh
aCwgd2UgZG9uJ3QgY2FyZSBhYm91dCB1bmtub3duIGh5cGVydmlzb3JzLiBUaGV5J2xsIGNy
YXNoJ24nYnVybg0KPiBhbnl3YXkuDQoNCk9rYXksIEknbGwgZHJvcCB0aGF0IHRlc3QuDQoN
Cj4gTXkgaW50ZW50IGlzIHRvIGhhdmUgZXZlcnkgY2FzZSBwcm9wZXJseSBkb2N1bWVudGVk
IHdpdGggYSBjb21tZW50IGFib3ZlIGl0DQo+IGluc3RlYWQgb2Ygb25lIGh1Z2UgY29tcG91
bmQgY29uZGl0aW9uYWwuDQo+IA0KPj4gSXQgYmFzaWNhbGx5IGRvZXNuJ3QgbWF0dGVyLg0K
PiANCj4gSXQgZG9lc24ndCBtYXR0ZXIgbm93LiBVbnRpbCBzb21lb25lIGRlY2lkZXMgdG8g
InJlZGVmaW5lIiBob3cgTVRSUnMNCj4gc2hvdWxkIGJlIGRvbmUgYWdhaW4gYmVjYXVzZSB0
aGUgbmV4dCByZXByZXNlbnRhdGl2ZSBmcm9tIHRoZSB2aXJ0IHpvbw0KPiBkZWNpZGVkIHRv
IGRvIG1hZ2ljIHBpbmsgcG9uaWVzLg0KPiANCj4gSSdtIG5vdCB0YWtpbmcgYW55IGNoYW5j
ZXMgYW55bW9yZSBqdWRnaW5nIGJ5IHRoZSBhbW91bnQgb2YgY3JhcCB0aGF0DQo+IGdldHMg
c2VudCBpbnRvIGFyY2gveDg2LyB0byBzdXBwb3J0IHNvbWUgd2VpcmQgZ3Vlc3QgY29udHJh
cHRpb24uDQo+IA0KPj4gVGhlIG9ubHkgcG9zc2liaWxpdHkgb2YgbXRycl9zdGF0ZS5lbmFi
bGVkIHRvIGJlIHNldCBhdCB0aGlzIHBvaW50IGlzIGENCj4+IHByZXZpb3VzIGNhbGwgb2Yg
bXRycl9vdmVyd3JpdGVfc3RhdGUoKS4NCj4gDQo+IFN1cmUsIHBscyBtYWtlIGl0IGV4cGxp
Y2l0IGFuZCBkZWZlbnNpdmUgc28gdGhhdCBpdCBpcyBwZXJmZWN0bHkgY2xlYXINCj4gd2hh
dCdzIGdvaW5nIG9uLg0KDQpPa2F5LCB3aWxsIGRvIHRoZSBtb2RpZmljYXRpb24geW91IHdl
cmUgc3VnZ2VzdGluZy4NCg0KDQpKdWVyZ2VuDQo=
--------------NLGy2DtqayEsWFi2P9kurJpF
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------NLGy2DtqayEsWFi2P9kurJpF--

--------------XLWHhQuW63PaONggRK8KcmQk--

--------------giNNIC0AT2HhN8koOLempJtX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQZ0hAFAwAAAAAACgkQsN6d1ii/Ey/v
ZwgAn3FrjGFOLZpLDV+qedaAveQZzaYJRsSQcHpu0tZt2OC8qtVjW0YBwv2IiufQmQ4dBHDycbUJ
hftFhjpADeU7+rG0F9u0TdqKj8CZF6JXVRmhyn3+WNkD3G6ZDP4TWTky8mz8tb6SvdZJsInQDfgc
UMdEkne2tt2ZNUayrAZ4MRkvsHni9/rUGXus+RAryh7vo6jaYj8ARammOYCAtzCucQPvuGbI5yoj
2dzsAzT/1fDUes4Wm488Qgga1fX97hegVeTTsbRheW7zfNQMmwIZQbtXGDy7giAU/dPp9jGB9EQs
Ob1/v/9BHPojJy0Vz7KNtEKhbCyC5YXZlfFA+p+icw==
=1wsJ
-----END PGP SIGNATURE-----

--------------giNNIC0AT2HhN8koOLempJtX--
