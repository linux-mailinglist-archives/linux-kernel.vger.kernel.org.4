Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F6699429
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBPMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBPMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:19:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8F358D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:19:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BD382256B;
        Thu, 16 Feb 2023 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676549963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcGc5Fs3o+GhbZ98oBi6ykMMQB3zQFbUQKKaXMUlVA8=;
        b=somzvnDnwCEc+MN/x+FFwBeMFnmdMiQuT1Gu77b4xX9IpkBeQMpr/cfyGgNCM0y6eKASfZ
        TmwaQxyA/hv7B8PL84IpsWjChJZoSC5xcLZPepvMeY8k9srCWSwz6Hnr95HqBKZtMMOP6n
        T5CEYuaDwD/Gg4S1geOcGEfV98xrpd0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C6A8131FD;
        Thu, 16 Feb 2023 12:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 52k2DUsf7mPmPQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Feb 2023 12:19:23 +0000
Message-ID: <e5138aad-175e-d9bb-93f2-2fc563e09a41@suse.com>
Date:   Thu, 16 Feb 2023 13:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <cc6c58a8-b162-a6eb-37d4-40786f532837@suse.com> <Y+4SqDN2Hssau4fq@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
In-Reply-To: <Y+4SqDN2Hssau4fq@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2y2KcSCeLuKlTR6z3mIx3kRS"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2y2KcSCeLuKlTR6z3mIx3kRS
Content-Type: multipart/mixed; boundary="------------8GME1A4O8ZBAj40UTbs7FvY7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e5138aad-175e-d9bb-93f2-2fc563e09a41@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <cc6c58a8-b162-a6eb-37d4-40786f532837@suse.com> <Y+4SqDN2Hssau4fq@zn.tnic>
In-Reply-To: <Y+4SqDN2Hssau4fq@zn.tnic>

--------------8GME1A4O8ZBAj40UTbs7FvY7
Content-Type: multipart/mixed; boundary="------------N150eovGJJQf0olzfsZWugIk"

--------------N150eovGJJQf0olzfsZWugIk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDIuMjMgMTI6MjUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBG
ZWIgMTYsIDIwMjMgYXQgMTA6MzI6MjhBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IElzIHRoYXQgZmxhZyBfcmVhbGx5XyBtZWFudCB0byBpbmRpY2F0ZSB3ZSBhcmUgcnVu
bmluZyBhcyBhIFNFVi1TTlAgZ3Vlc3Q/DQo+IA0KPiBZZXMuDQo+IA0KPj4gR2l2ZW4gdGhh
dCB0aGUgcmVmZXJlbmNlZCBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBTRVYtU05QIGhvc3Qgc3Vw
cG9ydCBzZXJpZXMsDQo+PiBJJ20gaW5jbGluZWQgdG8gc3VzcGVjdCBpdCB3b24ndCBiZSBz
ZXQgZm9yIHN1cmUgaW4gSHlwZXJWIFNFVi1TTlAgZ3Vlc3RzLg0KPiANCj4gSXQgYmV0dGVy
IGJlLiBJZiBpdCBpcyBhIG1vZGlmaWVkIGd1ZXN0IC0gbm8gbWF0dGVyIGhvdyBtb2RpZmll
ZCAtIGl0DQo+IHNob3VsZCBzZXQgdGhhdCBmbGFnLiBUaGUgdlRPTSB0aGluZyBpcyBzdGls
bCBiZWluZyBkaXNjdXNzZWQuDQo+IA0KPj4gQW5kIHdobyBpcyBzZXR0aW5nIGl0IGZvciBL
Vk0gU0VWLVNOUCBndWVzdHM/DQo+IA0KPiBUaGF0IHNhbWUgcGF0Y2ggZG9lcy4NCg0KSG1t
LCBJIG11c3QgYmUgYmxpbmQuIEkgY2FuJ3Qgc3BvdCBpdC4NCg0KSSdtIHNlZWluZyBvbmx5
IHRoZSBmZWF0dXJlIGJpdCAjZGVmaW5lIGFuZCBhIGNhbGwgb2YNCnNldHVwX2NsZWFyX2Nw
dV9jYXAoWDg2X0ZFQVRVUkVfU0VWX1NOUCkgaW4gdGhpcyBwYXRjaC4NCg0KT3IgaXMgaXQg
ZG9uZSBieSBoYXJkd2FyZSBvciB0aGUgaHlwZXJ2aXNvcj8NCg0KDQpKdWVyZ2VuDQo=
--------------N150eovGJJQf0olzfsZWugIk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------N150eovGJJQf0olzfsZWugIk--

--------------8GME1A4O8ZBAj40UTbs7FvY7--

--------------2y2KcSCeLuKlTR6z3mIx3kRS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPuH0oFAwAAAAAACgkQsN6d1ii/Ey8N
8Qf8Cljg+r2WO2K/giaYbQ4GdS3AC03ibOeQj0yOwV+jkAc9IPWXM8CuwBMWtsixOzRQoPCt6Yqh
32tHqloKFKPRMZ4KC6NLCU0pMSv+yRoUGA3TSNqjbFLAPZCu2o3TLMrCjRV2ORpnK+WAX6eNloN3
22gnGBy/uNILKDEgqYHwFXIxvjBLQpoztHqzV7A8ig7OQIVrEVGY9XTFKOpwF+uUGDJZ5ZSHW4OJ
YsEsRqHQOzcRtkr/ORCjcrqIqZMk6+wu5vMYL8IFmw/2D1hsUspgZBPQQLtDRiPqnJICvOHXnSUF
+a1aURPCqq3S0TSwY4ZcvwcEP0kO8VJNUXmIPIZq7w==
=3bIb
-----END PGP SIGNATURE-----

--------------2y2KcSCeLuKlTR6z3mIx3kRS--
