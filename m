Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC10A71F9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjFBGGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjFBGGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:06:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE2D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:06:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B46C821A26;
        Fri,  2 Jun 2023 06:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685686008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uLBejDaJmLYOrHUuqsqz0VZ3P1si23qortwo9RjY10=;
        b=HI+nBsQUhAE+Yhqaj7Qt7PKRi8b6FlTScCa5DSng2LkgbeF925lem+EqJaSdE2jUe/qccQ
        kA7iOzVXfJ6j1wJtH3Txy0V9clRZzwqMLfo3esAmo5TU0CKM+r9SAY5vbsr/TM8MvdIA9K
        ZnNhJYMEZyJ1EofSloHK5eCjj5QM9Vw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D81013A2E;
        Fri,  2 Jun 2023 06:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jgVyFfiGeWSiTQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 02 Jun 2023 06:06:48 +0000
Message-ID: <ae881ab5-a6f9-20fa-0f2b-e1363af77857@suse.com>
Date:   Fri, 2 Jun 2023 08:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
 <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Cwbt90mJHsJsLjAP8FmpghOn"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Cwbt90mJHsJsLjAP8FmpghOn
Content-Type: multipart/mixed; boundary="------------2ixzVvAB9HnBwhVeQi33gWNb";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org
Cc: Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Peter Jones
 <pjones@redhat.com>, Konrad Rzeszutek Wilk <konrad@kernel.org>
Message-ID: <ae881ab5-a6f9-20fa-0f2b-e1363af77857@suse.com>
Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
References: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
 <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
In-Reply-To: <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>

--------------2ixzVvAB9HnBwhVeQi33gWNb
Content-Type: multipart/mixed; boundary="------------GMGHe0Snobo2WlCJrgyl044f"

--------------GMGHe0Snobo2WlCJrgyl044f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDYuMjMgMTg6NTcsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiA1LzMwLzIzIDA4
OjAxLCBSb3NzIExhZ2Vyd2FsbCB3cm90ZToNCj4+IFNpbmNlIGZpcm13YXJlIGRvZXNuJ3Qg
aW5kaWNhdGUgdGhlIGlCRlQgaW4gdGhlIEU4MjAsIGFkZCBhIHJlc2VydmVkDQo+PiByZWdp
b24gc28gdGhhdCBpdCBnZXRzIGlkZW50aXR5IG1hcHBlZCB3aGVuIHJ1bm5pbmcgYXMgRG9t
IDAgc28gdGhhdCBpdA0KPj4gaXMgcG9zc2libGUgdG8gc2VhcmNoIGZvciBpdC4gTW92ZSB0
aGUgY2FsbCB0byByZXNlcnZlX2liZnRfcmVnaW9uKCkNCj4+IGxhdGVyIHNvIHRoYXQgaXQg
aXMgY2FsbGVkIGFmdGVyIHRoZSBYZW4gaWRlbnRpdHkgbWFwcGluZyBhZGp1c3RtZW50cw0K
Pj4gYXJlIGFwcGxpZWQuDQo+Pg0KPj4gRmluYWxseSwgaW5zdGVhZCBvZiB1c2luZyBpc2Ff
YnVzX3RvX3ZpcnQoKSB3aGljaCBkb2Vzbid0IGRvIHRoZSByaWdodA0KPj4gdGhpbmcgdW5k
ZXIgWGVuLCB1c2UgZWFybHlfbWVtcmVtYXAoKSBsaWtlIHRoZSBkbWlfc2NhbiBjb2RlIGRv
ZXMuDQo+IA0KPiBUaGlzIGlzIGNvbm5lY3RpbmcgWGVuLCBpU0NTSSBhbmQgeDg2LiAgU29t
ZSBiYWNrZ3JvdW5kIGhlcmUgd291bGQgYmUNCj4gKnJlYWxseSogbmljZSBmb3IgZHVtbWll
cyBsaWtlIG1lIHRoYXQgZGVhbCBoZWF2aWx5IGluIG9ubHkgb25lIG9mIHRob3NlDQo+IHRo
cmVlLg0KPiANCj4gT25lIG9yIHR3byBzZW50ZW5jZXMgbGlrZSB0aGlzOg0KPiANCj4gCUZp
cm13YXJlIGNhbiBwcm92aWRlIGFuIGlTQ1NJLXNwZWNpZmljIHRhYmxlIGNhbGxlZCB0aGUg
aUJGVA0KPiAJd2hpY2ggaGVscHMgdGhlIE9TIGJvb3QgZnJvbSBpU0NTSSBkZXZpY2VzLg0K
PiANCj4gY2FuIGdvIGEgbG9uZyB3YXkgZm9yIGR1bW1pZXMgbGlrZSBtZS4gIEFzIGNvdWxk
IHNvbWUgYmFja2dyb3VuZCBhYm91dA0KPiB3aHkgdGhpczoNCj4gDQo+IAkuLi4gYWRkIGEg
cmVzZXJ2ZWQgcmVnaW9uIHNvIHRoYXQgaXQgZ2V0cyBpZGVudGl0eSBtYXBwZWQgd2hlbg0K
PiAJcnVubmluZyBhcyBEb20gMCBzbyB0aGF0IGl0IGlzIHBvc3NpYmxlIHRvIHNlYXJjaCBm
b3IgaXQuDQo+IA0KPiBUaGVzZSBhcmUgYWxsIEVuZ2xpc2ggd29yZHMsIGJ1dCBvZmYgdGhl
IHRvcCBvZiBteSBoZWFkLCBJIGhhdmUgbm8gaWRlYQ0KPiB3aHkgcmVzZXJ2ZWQgcmVnaW9u
cyBnZXQgaWRlbnRpdHkgbWFwcGVkIHdoZW4gcnVubmluZyBhcyBEb20gMCBvciB3aHkNCj4g
dGhhdCBtYWtlcyBpdCBwb3NzaWJsZSB0byBzZWFyY2guDQo+IA0KPiBUaGUgYWRkcmVzc2Vz
IGFuZCBzaXplIGhlcmU6DQo+IA0KPj4gKyNpZmRlZiBDT05GSUdfSVNDU0lfSUJGVF9GSU5E
DQo+PiArCQkvKiBSZXNlcnZlIDAuNSBNaUIgdG8gMSBNaUIgcmVnaW9uIHNvIGlCRlQgY2Fu
IGJlIGZvdW5kICovDQo+PiArCQl4ZW5fZTgyMF90YWJsZS5lbnRyaWVzW3hlbl9lODIwX3Rh
YmxlLm5yX2VudHJpZXNdLmFkZHIgPSAweDgwMDAwOw0KPj4gKwkJeGVuX2U4MjBfdGFibGUu
ZW50cmllc1t4ZW5fZTgyMF90YWJsZS5ucl9lbnRyaWVzXS5zaXplID0gMHg4MDAwMDsNCj4+
ICsJCXhlbl9lODIwX3RhYmxlLmVudHJpZXNbeGVuX2U4MjBfdGFibGUubnJfZW50cmllc10u
dHlwZSA9IEU4MjBfVFlQRV9SRVNFUlZFRDsNCj4+ICsJCXhlbl9lODIwX3RhYmxlLm5yX2Vu
dHJpZXMrKzsNCj4+ICsjZW5kaWYNCj4gDQo+IGFsc28gYXBwZWFyIHRvIGJlIGNvbmp1cmVk
IG91dCBvZiB0aGluIGFpci4NCg0KSSdkIHN1Z2dlc3QgdG8gbW92ZSB0aGUgZGVmaW5pdGlv
bnMgb2YgSUJGVF9TVEFSVCBhbmQgSUJGVF9FTkQgZnJvbQ0KZHJpdmVycy9maXJtd2FyZS9p
c2NzaV9pYmZ0X2ZpbmQuYyB0byBpbmNsdWRlL2xpbnV4L2lzY3NpX2liZnQuaCBhbmQgdXNl
DQp0aGVtIGhlcmUuDQoNCg0KSnVlcmdlbg0K
--------------GMGHe0Snobo2WlCJrgyl044f
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------GMGHe0Snobo2WlCJrgyl044f--

--------------2ixzVvAB9HnBwhVeQi33gWNb--

--------------Cwbt90mJHsJsLjAP8FmpghOn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR5hvcFAwAAAAAACgkQsN6d1ii/Ey+x
/gf6AkOb1VnquAu0exCaTE9S55Td1Fr8djwzPygVCiGKvoryAzRca3B2buFkUwgKZBweR1r6fX13
8hbuRe1tr/YBuafg8+gyLRgtjwQETw0w8sCVtc3MrlH6/BxNKsCpbFFvBqSeZFiCc4Ilwi1j309X
Spc0qBwqN24ENn4duoR/AYUg6Gc0LkXflYL99iGYnslyzWcqAFH9R6nxyBRtrLsNA8y8f/vUbAFj
ynad89gKWMBFntFhdgakhXNjkEy9hchwJ6hv2jSZu4fnyrJxo+L75GSJCeB/moou65nERaJei7cf
YY6BnpNdjz64wAVARoo8gYbg6wtSsi3XuD6i3J7Rmg==
=xQUA
-----END PGP SIGNATURE-----

--------------Cwbt90mJHsJsLjAP8FmpghOn--
