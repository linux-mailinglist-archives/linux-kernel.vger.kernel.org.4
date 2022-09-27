Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0438D5EBDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiI0I5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiI0I5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:57:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABB7C1CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:57:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5F8F1F999;
        Tue, 27 Sep 2022 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664269057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5aHiD4rZbP/VHCDDbsZS6HtaQz2jtnZB5/EX4LRiKc=;
        b=dRpWNwpOnnK8mVkTRo+xhlF0Vkfjj3xIipCxOz9xtapCSVZJtJNdelOv9m2A2WhGyq0YuM
        e/57kid22xPmOXn+Dls3imbcVJdIoSDs/BxC5wwphUjtAhJFj2ddtHQT2z//nZezqPYL7r
        b4Df8ktj1m/Vpov2mvFMbx+/Jj2sYwg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2543139BE;
        Tue, 27 Sep 2022 08:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OGo1JgG7MmOvJgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 27 Sep 2022 08:57:37 +0000
Message-ID: <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
Date:   Tue, 27 Sep 2022 10:57:37 +0200
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
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
In-Reply-To: <YzIVfj/lvzQrK15Y@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0omw3ZfM27TVCp1IFTspqxRw"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0omw3ZfM27TVCp1IFTspqxRw
Content-Type: multipart/mixed; boundary="------------iOwbv5oefZcAe4yIQj1pJUSW";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
In-Reply-To: <YzIVfj/lvzQrK15Y@zn.tnic>

--------------iOwbv5oefZcAe4yIQj1pJUSW
Content-Type: multipart/mixed; boundary="------------VF8nyolFe3q90VxADFU1RzkZ"

--------------VF8nyolFe3q90VxADFU1RzkZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDkuMjIgMjM6MTEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBT
ZXAgMDgsIDIwMjIgYXQgMTA6NDk6MTJBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IC12b2lkIHNldF9tdHJyX2Fwc19kZWxheWVkX2luaXQodm9pZCkNCj4+IC17DQo+PiAt
CWlmICghY2FjaGVfZ2VuZXJpYykNCj4+IC0JCXJldHVybjsNCj4+IC0NCj4+IC0JbXRycl9h
cHNfZGVsYXllZF9pbml0ID0gdHJ1ZTsNCj4+IC19DQo+PiAtDQo+IA0KPiBFeGNlcHQgdGhh
dCB5b3UndmUgcmVtb3ZlZCB0aGUgYWNjZXNzb3JzIGFuZCBtYWRlIHRoYXQgYm9vbCBnbG9i
YWwuDQo+IFdoaWNoIGlzIGxlc3MgcHJldHR5IHRoYW4gaXQgd2FzIGJlZm9yZS4uLg0KPiAN
Cg0KVGhlIGFjY2Vzc29yIHdvdWxkIG5vdyBvbmx5IG5lZWQgdG8gc2V0IHRoZSBib29sLCB3
aGlsZSBpdCBoYWQgYXQgbGVhc3QNCnNvbWUgbG9naWMgYmVmb3JlLg0KDQpUQkggSSBkb24n
dCBzZWUgdGhlIHBvaW50IG9mIGhhdmluZyBhbiBhY2Nlc3NvciB3aGljaCBpcyBqdXN0IHNl
dHRpbmcgYQ0KdmFyaWFibGUgdG8gInRydWUiLiBCdXQgaWYgeW91IGxpa2UgaXQgYmV0dGVy
LCBJIGNhbiBrZWVwIGl0Lg0KDQpBbm90aGVyIHBvc3NpYmlsaXR5IHdvdWxkIGJlIHRvIG1v
dmUgdGhlIGFyY2hfdGhhd19zZWNvbmRhcnlfY3B1c19iZWdpbigpDQphbmQgYXJjaF90aGF3
X3NlY29uZGFyeV9jcHVzX2VuZCgpIGZ1bmN0aW9ucyB0byBjYWNoZWluZm8uYywgcmVzdWx0
aW5nDQppbiBvbmx5IGEgc2luZ2xlIHBsYWNlIG91dHNpZGUgb2YgY2FjaGVpbmZvLmMgc2V0
dGluZyB0aGUgdmFyaWFibGUgKGluDQp0aGVvcnkgdGhlIGFyY2hfdGhhd19zZWNvbmRhcnlf
Y3B1c18qKCkgZnVuY3Rpb25zIGNvdWxkIGp1c3QgYmUgcmVkZWZpbmVkDQp0byB0aGUgYWNj
ZXNzb3IgYW5kIGNhY2hlX2Fwc19pbml0KCksIGJ1dCB0aGlzIHdvdWxkIGJlIHJhdGhlciBo
YWNreSBJTU8pLg0KDQoNCkp1ZXJnZW4NCg==
--------------VF8nyolFe3q90VxADFU1RzkZ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------VF8nyolFe3q90VxADFU1RzkZ--

--------------iOwbv5oefZcAe4yIQj1pJUSW--

--------------0omw3ZfM27TVCp1IFTspqxRw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMyuwEFAwAAAAAACgkQsN6d1ii/Ey8g
hAf/ffuLvYbtvTozZxPD7F3rv26Okz0If7EaJkiWS7vKU/LKQGAITr3GxMcbrKg6F/MGE8sXfq1I
BekA8owLDMvhqqKbFg68rikW8Coy9h67lJsWMzOqkctEUsGXBTD2IW9Yqfd4UvqCcT1YwfEQWgtl
QmM/ID6E/krI7ee6dk/gs5dDze0kTwKCnHCG7L1slL+tHPQ0K6lyeFoxGLPNvq+tar5IhjEu8aJP
+PkcmyzCUspxl8mLtk13eixPWYjfPxZb0nO29io3zUO4uuyms74or6Wx3o5gt76/wInoJGLa3bSl
w7wUNAD8k2d8KfXLLhS8XTbvqDGGXng/bl1NfmeEiA==
=B+dC
-----END PGP SIGNATURE-----

--------------0omw3ZfM27TVCp1IFTspqxRw--
