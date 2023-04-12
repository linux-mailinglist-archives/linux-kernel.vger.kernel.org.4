Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE146DF644
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDLM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDLM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:57:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AB72A3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:56:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10CDF1F6E6;
        Wed, 12 Apr 2023 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681304194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKFgvanqs67nb7HWJ7AEqB8QD7XZ22eV4w13DCH2PSQ=;
        b=imJWxFbND3rwHWfuu5qcHi3jnuVkRJarZb9ypxKXb041/8791/Xq0LwN8yM6WUmQvwCztl
        ojAognCscroQRR/Q8ayegocnuIgYKRQ5/U7gKHmbnx9K+2GE5gX8ci5gj1gqKKfvMLLJu/
        70kyKxDlv7kolkHHl3k3i9H/5yxjHIY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB4F6132C7;
        Wed, 12 Apr 2023 12:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ncw4MIGqNmS5ZQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 12 Apr 2023 12:56:33 +0000
Message-ID: <a8523ee6-6c1b-07f3-41ce-b6f28eeeeee4@suse.com>
Date:   Wed, 12 Apr 2023 14:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-9-jgross@suse.com>
 <20230412123044.GJZDakdLatRW26J+1k@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 08/15] x86/mtrr: have only one set_mtrr() variant
In-Reply-To: <20230412123044.GJZDakdLatRW26J+1k@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------P6Avbna0eh0HV5LfECoqIQmV"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------P6Avbna0eh0HV5LfECoqIQmV
Content-Type: multipart/mixed; boundary="------------h8X0x0uIwt9riDk7xHJWrggS";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <a8523ee6-6c1b-07f3-41ce-b6f28eeeeee4@suse.com>
Subject: Re: [PATCH v5 08/15] x86/mtrr: have only one set_mtrr() variant
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-9-jgross@suse.com>
 <20230412123044.GJZDakdLatRW26J+1k@fat_crate.local>
In-Reply-To: <20230412123044.GJZDakdLatRW26J+1k@fat_crate.local>

--------------h8X0x0uIwt9riDk7xHJWrggS
Content-Type: multipart/mixed; boundary="------------FiArdfd8L1SfqFVNroePhkZS"

--------------FiArdfd8L1SfqFVNroePhkZS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDQuMjMgMTQ6MzAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBB
cHIgMDEsIDIwMjMgYXQgMDg6MzY6NDVBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRvZGF5IHRoZXJlIGFyZSB0d28gdmFyaWFudHMgb2Ygc2V0X210cnIoKTogb25lIGNh
bGxpbmcgc3RvcF9tYWNoaW5lKCkNCj4gDQo+ICIuLi4gdHdvIHZhcmlhbnRzIHdoaWNoIHNl
dCBNVFJSczogc2V0X210cnIoKSBhbmQgc2V0X210cnJfY3B1c2xvY2tlZCgpLA0KPiBmaXJz
dCBjYWxsaW5nIC4uLiINCj4gDQo+PiBhbmQgb25lIGNhbGxpbmcgc3RvcF9tYWNoaW5lX2Nw
dXNsb2NrZWQoKS4NCj4+DQo+PiBUaGUgZmlyc3Qgb25lIChzZXRfbXRycigpKSBoYXMgb25s
eSBvbmUgY2FsbGVyLCBhbmQgdGhpcyBjYWxsZXIgaXMNCj4+IGFsd2F5cyBydW5uaW5nIHdp
dGggb25seSBvbmUgQ1BVIG9ubGluZSBhbmQgaW50ZXJydXB0cyBiZWluZyBvZmYuDQo+IA0K
PiBXYWl0LCB3aGFhYXQ/DQo+IA0KPiBJdCdzIG9ubHkgY2FsbGVyIGlzIG10cnJfcmVzdG9y
ZSgpIGFuZCB0aGF0IGlzIHBhcnQgb2Ygc3lzY29yc2Ugb3BzDQo+IHdoaWNoIGlzIHJlZ2lz
dGVyZWQgZm9yDQo+IA0KPiAiVGhlIENQVSBoYXMgbm8gTVRSUiBhbmQgc2VlbXMgdG8gbm90
IHN1cHBvcnQgU01QLiINCj4gDQo+IERvIHlvdSBtZWFuIHRoYXQsIHBlciBjaGFuY2U/DQoN
CkknbSBub3Qgc3VyZSB0aGUgY29tbWVudCBpcyBhY2N1cmF0ZSAoImhhcyBubyBNVFJSIiBp
cyBhIGJhZCB3YXkNCnRvIHNheSB0aGF0IFg4Nl9GRUFUVVJFX01UUlIgaXMgMCwgQlRXKS4N
Cg0KVGhlIG1haW4gcG9pbnQgaXMgdGhhdCBtdHJyX3Jlc3RvcmUoKSBpcyBjYWxsZWQgd2l0
aCBpbnRlcnJ1cHRzIG9mZg0KYW5kIGJlZm9yZSBhbnkgb3RoZXIgcG90ZW50aWFsIENQVXMg
YXJlIHN0YXJ0ZWQgYWdhaW4uDQoNCj4gSWYgeW91IGRvLCBwbGVhc2UgZXhwbGFpbiB0aGF0
IHByb3Blcmx5IGluIHRoZSBjb21taXQgbWVzc2FnZSAtIHRoaXMgaXMNCj4gbm90IGEgZ3Vl
c3NpbmcgZ2FtZS4NCg0KT2theS4NCg0KPiBCeSB0aGUgbG9va3Mgb2YgdGhhdCBzeXNjb3Jl
IHRoaW5nLCBpdCBpcyBuZWVkZWQgZm9yIHRoZSB2ZXJ5IG9sZCBNVFJSDQo+IGltcGxlbWVu
dGF0aW9ucyB3aGljaCB3ZXJlbid0IFNNUCAoSzYsIENlbnRhdXIsIEN5cml4IGV0YykuDQo+
IA0KPiBQbGVhc2UgZXhwbGFpbiB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZSB0b28uIEl0
IG5lZWRzIHRvIHNheSAqd2h5KiB0aGUNCj4gdHJhbnNmb3JtYXRpb24geW91J3JlIGRvaW5n
IGlzIG9rLg0KDQpJJ3ZlIG91dGxpbmVkIHRoZSAid2h5IiBhYm92ZS4gSSdsbCByZXBsYWNl
IHRoZSBwYXJhZ3JhcGggeW91IHdlcmUgcmVmZXJyaW5nDQp0by4NCg0KPiANCj4gInRoaXMg
Y2FsbGVyIGlzIGFsd2F5cyBydW5uaW5nIHdpdGggb25seSBvbmUgQ1BVIG9ubGluZSIgaXMg
bm90IG5lYXJseQ0KPiBiZWdpbm5pbmcgdG8gZXhwbGFpbiB3aGF0IHRoZSBzaXR1YXRpb24g
aXMuDQo+IA0KPj4gUmVtb3ZlIHRoZSBmaXJzdCB2YXJpYW50IGNvbXBsZXRlbHkgYW5kIHJl
cGxhY2UgdGhlIGNhbGwgb2YgaXQgd2l0aA0KPj4gYSBjYWxsIG9mIG10cnJfaWYtPnNldCgp
Lg0KPj4NCj4+IFJlbmFtZSB0aGUgc2Vjb25kIHZhcmlhbnQgc2V0X210cnJfY3B1c2xvY2tl
ZCgpIHRvIHNldF9tdHJyKCkgbm93IHRoYXQNCj4+IHRoZXJlIGlzIG9ubHkgb25lIHZhcmlh
bnQgbGVmdC4NCj4gDQo+IFRob3NlIGFyZSB2aXNpYmxlIGZyb20gdGhlIGRpZmYgaXRzZWxm
IC0geW91IGRvbid0IG5lZWQgdG8gZXhwbGFpbiB3aGF0DQo+IHRoZSBwYXRjaCBkb2VzIGJ1
dCB3aHkuDQoNCk9rYXksIEknbGwgZHJvcCB0aGF0IHBhcmFncmFwaC4NCg0KDQpKdWVyZ2Vu
DQo=
--------------FiArdfd8L1SfqFVNroePhkZS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------FiArdfd8L1SfqFVNroePhkZS--

--------------h8X0x0uIwt9riDk7xHJWrggS--

--------------P6Avbna0eh0HV5LfECoqIQmV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQ2qoEFAwAAAAAACgkQsN6d1ii/Ey9p
kAgAmqp8oxK1bKkTZO/lKS3/IsaOMA4+KUFstx/OMB9Uz0WAuGvCGFYC3nB3k2paq1Ml84ZquFm3
nZ/m9L2eqGdH/OQde0c/OA86QqmdrsWVn5iwxEyUT3oXf19TaC8KV6cb9n2eJKA6C4pbPvp0jYu1
7KrAzv8mB0RBN6g/wQMy34TB6uFAhr8x+4NkVnUNfBGhug/JIgyKrNy2mdhYRB5Md7G2R/F4Sedm
GMioC1pan/9InHn+kHOwRhzplwTUvO8GVukPhmNBuIf+7L52aW7xgy0OJI2vz4CqQQB1eNkToMmV
+NlV0uUVH9OUFWnZbbfKW+gTkmtrc5tnLG+MbGVWfQ==
=vkhD
-----END PGP SIGNATURE-----

--------------P6Avbna0eh0HV5LfECoqIQmV--
