Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8A6DDC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDKNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDKNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:32:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7F6135
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:32:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A79E219E3;
        Tue, 11 Apr 2023 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681219946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96zGISNOKSVSbd46qfLFa+72DlgbXajQcJLpGAv1mnk=;
        b=iZPTfDQGG1HK6rxZeRles6jk0nXDnVfMbAomy7tlJSiePBkkYLKg8Bjw0wyra7tz6Egewg
        WhX6hMYb7l4AyQOm1dbcQIFVqM2JwUXpY2ECLV2jCKWgzPwYsd5voR8fX4NRU27uyO4e8B
        HgyfTZRM1G+AsgMMZUSeX6IWV/tYhz0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2B0313519;
        Tue, 11 Apr 2023 13:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gDPjLWlhNWQUOQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 11 Apr 2023 13:32:25 +0000
Message-ID: <6190f3d4-6fdf-5826-a9a7-f15c09bdec67@suse.com>
Date:   Tue, 11 Apr 2023 15:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-4-jgross@suse.com>
 <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
 <1231926a-5d03-5631-a376-b0d738c7e25c@suse.com>
 <20230405202633.GFZC3ZeVWtmjkODYW7@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230405202633.GFZC3ZeVWtmjkODYW7@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HSY2zHk3z5wWUP0ueAz7nrVw"
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HSY2zHk3z5wWUP0ueAz7nrVw
Content-Type: multipart/mixed; boundary="------------QsH06WKk8cBMStU0auiNfRWi";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6190f3d4-6fdf-5826-a9a7-f15c09bdec67@suse.com>
Subject: Re: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-4-jgross@suse.com>
 <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
 <1231926a-5d03-5631-a376-b0d738c7e25c@suse.com>
 <20230405202633.GFZC3ZeVWtmjkODYW7@fat_crate.local>
In-Reply-To: <20230405202633.GFZC3ZeVWtmjkODYW7@fat_crate.local>

--------------QsH06WKk8cBMStU0auiNfRWi
Content-Type: multipart/mixed; boundary="------------bndhP0Us8MWt0ce00n0mGFRy"

--------------bndhP0Us8MWt0ce00n0mGFRy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDQuMjMgMjI6MjYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMDUsIDIwMjMgYXQgMDk6NTU6NTlBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9uIDAzLjA0LjIzIDE4OjAzLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4gT24g
U2F0LCBBcHIgMDEsIDIwMjMgYXQgMDg6MzY6NDBBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3
cm90ZToNCj4+Pj4gQEAgLTY0MywxMCArNjQ2LDEyIEBAIHN0YXRpYyBib29sIHNldF9tdHJy
X3Zhcl9yYW5nZXModW5zaWduZWQgaW50IGluZGV4LCBzdHJ1Y3QgbXRycl92YXJfcmFuZ2Ug
KnZyKQ0KPj4+PiAgICAJdW5zaWduZWQgaW50IGxvLCBoaTsNCj4+Pj4gICAgCWJvb2wgY2hh
bmdlZCA9IGZhbHNlOw0KPj4+PiArI2RlZmluZSBCQVNFX01BU0sJKE1UUlJfQkFTRV9UWVBF
X01BU0sgfCAoc2l6ZV9hbmRfbWFzayA8PCBQQUdFX1NISUZUKSkNCj4+Pj4gKyNkZWZpbmUg
TUFTS19NQVNLCShNVFJSX01BU0tfVkFMSUQgfCAoc2l6ZV9hbmRfbWFzayA8PCBQQUdFX1NI
SUZUKSkNCj4+Pg0KPj4+IE5vLCAiTUFTS19NQVNLIiBpcyB0b28gbXVjaC4gOi0pDQo+Pg0K
Pj4gQW55IGJldHRlciBzdWdnZXN0aW9uIGZvciB0aGUgbmFtZT8gOi0pDQo+IA0KPiBMb29r
aW5nIGF0IHRoaXMgYWdhaW4sIHdoYXQgdGhpcyBpcyBhY3R1YWxseSBkb2luZyBpcyBtYXNr
aW5nIG91dCB0aGUNCj4gcmVzZXJ2ZWQgYml0cy4gQnV0IGluIGFuIHVubmVjZXNzYXJpbHkg
Y29tcGxpY2F0ZWQgd2F5Lg0KPiANCj4gV2hhdCBpdCBzaG91bGQgZG8sIGluc3RlYWQsIGlz
IGRvIHRoYXQgZXhwbGljaXRseToNCj4gDQo+IAkvKiBaYXAgdGhlIHJlc2VydmVkIGJpdHMg
YW5kIGNvbXBhcmUgb25seSB0aGUgdmFsaWQgZmllbGRzOiAqLw0KPiAJaWYgKCgodnItPmJh
c2VfbG8gJiB+UkVTVl9MT1cpICE9IChsbyAmIH5SRVNWX0xPVykpIHx8DQo+IAkgICAgKCh2
ci0+YmFzZV9oaSAmIH5SRVNWX0hJKSAhPSAoaGkgJiB+UkVTVl9ISSkpKQ0KPiANCj4gd2hl
cmUNCj4gDQo+ICNkZWZpbmUgUkVTVl9MT1cJR0VOTUFTS19VTEwoOCwgMTEpDQo+ICNkZWZp
bmUgUkVTVl9ISQkJR0VOTUFTSyhwaHlzX2FkZHIgLSAxLCA2MykNCj4gDQo+IGFuZCB0aGVu
IHdlIGNhbiBnZXQgcmlkIG9mIHRoYXQgc2l6ZV9vcl9tYXNrIGFuZCBzaXplX2FuZF9tYXNr
DQo+IHN0dXBpZGl0eS4NCj4gDQo+IEkgdGhpbmsgdGhhdCB3b3VsZCBzaW1wbGlmeSB0aGlz
IHZhcmlhYmxlIHJhbmdlcyBoYW5kbGluZyBjb2RlIGEgbG90DQo+IG1vcmUgYW5kIG1ha2Ug
aXQgcHJldHR5IHN0cmFpZ2h0Zm9yd2FyZC4uLg0KDQpZZWFoLCBwcm9iYWJseSBhIGdvb2Qg
aWRlYS4NCg0KDQpKdWVyZ2VuDQo=
--------------bndhP0Us8MWt0ce00n0mGFRy
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------bndhP0Us8MWt0ce00n0mGFRy--

--------------QsH06WKk8cBMStU0auiNfRWi--

--------------HSY2zHk3z5wWUP0ueAz7nrVw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQ1YWkFAwAAAAAACgkQsN6d1ii/Ey8F
vAf/e91z7X7qOwYhfAyfupyfOJOFpywQ0eSmVpLXXHgSYMSE8mLfrW6eT3Dkgpd8vGBdq5YEnqcU
YUVtt7L89+rG2nnlSz7eYjHTY1hSnk+tG8w3J5aiSHakEVKfr2Xbo21TTFNubSuMUwn+LYbdH9xe
CfswI6tqD67XDR1z16JW0dWKI9tJCxwwifC8o9qIhEseL4RTO2gyoWGm46OPCRYb3X+A2A95Lz/g
G/iV5WwJT6CPzKupOWrkHR4vnK5B3+NsVhoI7YLxlOia/LPqPhIGU6K5j9SqA1OthwsUCxMF6jz8
jf+W7ZqrVBlmrSHpEANeJOlTXqX/T4OcTubFXQrt+g==
=tSnr
-----END PGP SIGNATURE-----

--------------HSY2zHk3z5wWUP0ueAz7nrVw--
