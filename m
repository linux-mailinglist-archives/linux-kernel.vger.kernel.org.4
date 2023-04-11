Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890626DE01E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjDKP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjDKP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:57:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A22D64
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:57:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 172FC219D7;
        Tue, 11 Apr 2023 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681228629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUoq6QFk6JCqOFY3zbsfAsV8R/J8FWve1udiJhBv0qc=;
        b=YSW2YjIMIrBeRBGlPJznE3BRJaOYcI/Op8LpQZIkmd6GGlBt+REV/S06ZcphI3VX0Ge242
        nrGPYrFKdrQ0NbRIYkSBH0YsBgt66zFWmzCeHKRMQgMwi/3LgHsRDKgU/mqwSmG7O5Bnqt
        lGsUK1GD8vG4ML1avF/YtFSs8eY2k5o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C360F13519;
        Tue, 11 Apr 2023 15:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j18eLlSDNWQzDwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 11 Apr 2023 15:57:08 +0000
Message-ID: <8c00966b-2739-4479-ff50-d5841baeb32d@suse.com>
Date:   Tue, 11 Apr 2023 17:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
 <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <6febc91b-e0ac-5b14-5bb5-98dc017440ae@suse.com>
 <20230411142633.GBZDVuGU6HaVYxlCJ6@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230411142633.GBZDVuGU6HaVYxlCJ6@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Xa8noT4EF1b7rW0RGm0gbJhb"
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
--------------Xa8noT4EF1b7rW0RGm0gbJhb
Content-Type: multipart/mixed; boundary="------------KekBHf7qyLIx6HB0RjU3RG7G";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <8c00966b-2739-4479-ff50-d5841baeb32d@suse.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
 <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <6febc91b-e0ac-5b14-5bb5-98dc017440ae@suse.com>
 <20230411142633.GBZDVuGU6HaVYxlCJ6@fat_crate.local>
In-Reply-To: <20230411142633.GBZDVuGU6HaVYxlCJ6@fat_crate.local>

--------------KekBHf7qyLIx6HB0RjU3RG7G
Content-Type: multipart/mixed; boundary="------------UZG2gCCOFv508T160whuzo5l"

--------------UZG2gCCOFv508T160whuzo5l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDQuMjMgMTY6MjYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTEsIDIwMjMgYXQgMDQ6MDQ6MDBQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFllYWgsIHRoZSBjb25kaXRpb24gbmVlZHMgdG8gYmU6DQo+Pg0KPj4gCWlmICghKGh2
X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQoKSB8fA0KPj4gCSAgICAgIGNjX3BsYXRmb3JtX2hh
cyhDQ19BVFRSX0dVRVNUX1NFVl9TTlApKSAmJg0KPiAJICAgICAgXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCj4gV2h5IGlzIHRoYXQgbmVlZGVkIGF0IGFs
bD8NCj4gDQoNClNob3J0IGFuc3dlcjogWW91IGFza2VkIG1lIHRvIGFkZCBpdCBpbiBWMiBv
ZiB0aGUgc2VyaWVzLg0KDQpMb25nZXIgYW5zd2VyOiBTRVZfU05QIGd1ZXN0cyBhbmQgVERY
IGd1ZXN0cyB3b3VsZCBjYXVzZSAjVkUgd2hlbiB3cml0aW5nDQogICBNVFJSIE1TUnMuDQoN
Cg0KSnVlcmdlbg0K
--------------UZG2gCCOFv508T160whuzo5l
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------UZG2gCCOFv508T160whuzo5l--

--------------KekBHf7qyLIx6HB0RjU3RG7G--

--------------Xa8noT4EF1b7rW0RGm0gbJhb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQ1g1MFAwAAAAAACgkQsN6d1ii/Ey9l
Uwf/dq452HsHPBfTnFXFOhh6Jn5/3SQj5kRSUcf9ytSi0oah/LMtPLCbcbtTgL13p13P2D+ahgU7
ysBg17Of2OseYV+6Br0LxTuu9ikTdUKNltpCSaONkFmjuiEeUTvTGuyyK0v+jrerbTvnsZzYHruS
07I/icORboKa3PjTTLbRbD2yhBIcVtQadsOCkgCEarrvzTcNpGR1zWuKEiRNSYL2G1D8+WnqZoQI
I1gkgjXyBMnnR+LI6uXZ3llB0NuSaQubACWB0oU4ag3SmyBL2YbTFMNC7/CidFp6zr32eXadG3Fo
BDehRQcbXhI/t2BFi+BulUL4l8sIt+uX2xch4f4njg==
=BvFd
-----END PGP SIGNATURE-----

--------------Xa8noT4EF1b7rW0RGm0gbJhb--
