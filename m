Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F575EC284
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiI0MWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiI0MVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:21:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A618680A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:21:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C00D81FA91;
        Tue, 27 Sep 2022 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664281277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKy3/moRIdFAMGNhek51h7yqMFijHHtClPF21SoHMKs=;
        b=a58T2mSXRLCVNqcJ36AU2wUVXLjUtH/1/cyaf/STlSzuTqHdH//6202Qw+PKVDoxYKSgZl
        x9/cCeoZByLSjVJQgn+BfH8MkfAtYm0THS70kZJ+gSLDbGxgSiRsTeGG31+8j6rK6VsjJ7
        py1g6JOiYJ0dk3ClnhX7qTxMRDMICxk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82518139B3;
        Tue, 27 Sep 2022 12:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIoaHr3qMmMmBQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 27 Sep 2022 12:21:17 +0000
Message-ID: <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
Date:   Tue, 27 Sep 2022 14:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com> <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com> <YzLo9IFDYW1T8BVZ@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YzLo9IFDYW1T8BVZ@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yYCrDFoMk0gOvmlfzVAQh1tI"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yYCrDFoMk0gOvmlfzVAQh1tI
Content-Type: multipart/mixed; boundary="------------NR0JWcGWJyz81n5HDCe0mI11";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com> <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com> <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com> <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com> <YzLo9IFDYW1T8BVZ@zn.tnic>
In-Reply-To: <YzLo9IFDYW1T8BVZ@zn.tnic>

--------------NR0JWcGWJyz81n5HDCe0mI11
Content-Type: multipart/mixed; boundary="------------6QxzthD9fEp8A1HWmnFw8r2u"

--------------6QxzthD9fEp8A1HWmnFw8r2u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDkuMjIgMTQ6MTMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBT
ZXAgMjcsIDIwMjIgYXQgMDE6MjU6NDdQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFlvdSBtZWFuIGJ5IHJlcGxhY2luZyBpdCB3aXRoICIoc3lzdGVtX3N0YXRlICE9IFNZ
U1RFTV9SVU5OSU5HKSIgPw0KPiANCj4gUmlnaHQsIG9yIG1heWJlIGV2ZW4gc29tZXRoaW5n
IG1vcmUgZWxlZ2FudC4gSSd2ZSBiZWVuIG1lYW5pbmcgdG8gYXNrDQo+IHRnbHggYWJvdXQg
aXQgYXMgSSBuZWVkZWQgaXQgZm9yIHRoZSBtaWNyb2NvZGUgbG9hZGVyIHRvby4NCg0KU28g
cmVwbGFjaW5nIHRoZSBib29sIHdpdGggIihzeXN0ZW1fc3RhdGUgIT0gU1lTVEVNX1JVTk5J
TkcpIiBpcyBmaW5lDQp3aXRoIHlvdSByaWdodCBub3c/IFdlIGNhbiBsYXRlciBzd2l0Y2gg
dGhhdCB0byB0aGUgIm1vcmUgZWxlZ2FudCINCnNvbHV0aW9uIHdoZW4gaXQgc2hvd3MgdXAu
DQoNCg0KSnVlcmdlbg0KDQo=
--------------6QxzthD9fEp8A1HWmnFw8r2u
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------6QxzthD9fEp8A1HWmnFw8r2u--

--------------NR0JWcGWJyz81n5HDCe0mI11--

--------------yYCrDFoMk0gOvmlfzVAQh1tI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMy6r0FAwAAAAAACgkQsN6d1ii/Ey/P
lAf9GthN38mAfTvZKcMI3RiXtTERbG/QBGU61+A3H0u30HfnLF6XZRTWxdbIDm7lLxIVSLRn7E8D
RXw+AUaweXh8hGR8FDvX/lfbm0o2FctODWDcZKWWfcbWuxPQDvX5/4tag/+ux3jAn/QAg6l7hlvg
o8nd5HZ/de1eA+b6fMTm0Oemwk6hYOStfyA0jdtIdEj3myvGB33sSC7ThFPeTaYS1kHkjK+02llY
AH9EnJr+7d3HvGVsMH7gr3l2i4Cjp5LgjrJhIcvyxmrXRd6iDxLVyhDvH1y9GTzLiKiXB2j//Lp8
ErxoYPbnkaQ6dBunPGP3n+Ornqz+A9EKONAw7BLOsw==
=A11H
-----END PGP SIGNATURE-----

--------------yYCrDFoMk0gOvmlfzVAQh1tI--
