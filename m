Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EF6A3B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjB0HLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjB0HLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:11:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF1CC3D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:11:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73F68219ED;
        Mon, 27 Feb 2023 07:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677481867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rGiZFIZZcpZ2e1eAvWqROva1o2JkejP96m1qMOruYg4=;
        b=qMX+tsLAMNZTcwv7skdmOWSICoz+e7EjiLgeh7Z0z1JOmG/zx/IQx/zWY3gOZpO97Fisim
        UkEDwx6kVyCBoEQuZ94OQd/UyWG4Va5jBppf/89x2vg9PxSna8qZok6WdUkKY+q6hzgrO2
        n0ZsquvGIwv9QzGzuTn805AOllOGyXM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 363E613912;
        Mon, 27 Feb 2023 07:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f//9C4tX/GO2EgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Feb 2023 07:11:07 +0000
Message-ID: <37c1ad33-e567-d120-08ba-4a30831c2509@suse.com>
Date:   Mon, 27 Feb 2023 08:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3.1 10/12] x86/mtrr: use new cache_map in
 mtrr_type_lookup()
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230223093243.1180-11-jgross@suse.com>
 <20230224063718.27666-1-jgross@suse.com>
 <BYAPR21MB168858E9992B909FB7A8D7B8D7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB168858E9992B909FB7A8D7B8D7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zGzzqnusEaaIEV56m8HV7DNy"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zGzzqnusEaaIEV56m8HV7DNy
Content-Type: multipart/mixed; boundary="------------DJtJfYKBwN4ymJFIeg4Vix03";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <37c1ad33-e567-d120-08ba-4a30831c2509@suse.com>
Subject: Re: [PATCH v3.1 10/12] x86/mtrr: use new cache_map in
 mtrr_type_lookup()
References: <20230223093243.1180-11-jgross@suse.com>
 <20230224063718.27666-1-jgross@suse.com>
 <BYAPR21MB168858E9992B909FB7A8D7B8D7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168858E9992B909FB7A8D7B8D7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------DJtJfYKBwN4ymJFIeg4Vix03
Content-Type: multipart/mixed; boundary="------------BgxYzakw49aadpnbSGTF0ZWf"

--------------BgxYzakw49aadpnbSGTF0ZWf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDIuMjMgMTg6MDAsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogVGh1cnNkYXksIEZl
YnJ1YXJ5IDIzLCAyMDIzIDEwOjM3IFBNDQo+Pg0KPj4gSW5zdGVhZCBvZiBjcmF3bGluZyB0
aHJvdWdoIHRoZSBNVFJSIHJlZ2lzdGVyIHN0YXRlLCB1c2UgdGhlIG5ldw0KPj4gY2FjaGVf
bWFwIGZvciBsb29raW5nIHVwIHRoZSBjYWNoZSB0eXBlKHMpIG9mIGEgbWVtb3J5IHJlZ2lv
bi4NCj4+DQo+PiBUaGlzIGFsbG93cyBub3cgdG8gc2V0IHRoZSB1bmlmb3JtIHBhcmFtZXRl
ciBhY2NvcmRpbmcgdG8gdGhlDQo+PiB1bmlmb3JtaXR5IG9mIHRoZSBjYWNoZSBtb2RlIG9m
IHRoZSByZWdpb24sIGluc3RlYWQgb2Ygc2V0dGluZyBpdA0KPj4gb25seSBpZiB0aGUgY29t
cGxldGUgcmVnaW9uIGlzIG1hcHBlZCBieSBhIHNpbmdsZSBNVFJSLiBUaGlzIG5vdw0KPj4g
aW5jbHVkZXMgZXZlbiB0aGUgcmVnaW9uIGNvdmVyZWQgYnkgdGhlIGZpeGVkIE1UUlIgcmVn
aXN0ZXJzLg0KPj4NCj4+IE1ha2Ugc3VyZSB1bmlmb3JtIGlzIGFsd2F5cyBzZXQuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4g
LS0tDQo+PiBWMzoNCj4+IC0gbmV3IHBhdGNoDQo+PiBWMy4xOg0KPj4gLSBmaXggdHlwZV9t
ZXJnZSgpIChNaWNoYWVsIEtlbGxleSkNCj4gDQo+IFRoYW5rcy4gIFRoaXMgdmVyc2lvbiBm
aXhlcyB0aGUgcHJvYmxlbSBJIHByZXZpb3VzbHkgcmVwb3J0ZWQgd2l0aCBhIG5vcm1hbA0K
PiBWTS4NCj4gDQo+IEhvd2V2ZXIsIEknbSBzZWVpbmcgYSBkaWZmZXJlbnQgcHJvYmxlbSBp
biBhIENvbmZpZGVudGlhbCBWTSB3aGVyZQ0KPiBtdHJyX292ZXJ3cml0ZV9zdGF0ZSgpIGlz
IHVzZWQuICBJbiB0aGlzIGNhc2UsIHdlIGhhdmUgbm8gTVRSUnMsIGFuZCB3aGVuDQo+IG10
cnJfY29weV9tYXAoKSBpcyBjYWxsZWQsIHRoZSBjb3B5IGlzIG5vdCBkb25lLCBhbmQgY2Fj
aGVfbWFwIGlzIHNldA0KPiB0byBOVUxMLiAgU3Vic2VxdWVudGx5IHdoZW4gbXRycl90eXBl
X2xvb2t1cCgpIGlzIGNhbGxlZCwgdGhlIGNoZWNrDQo+IGZvciBhIE5VTEwgY2FjaGVfbWFw
IGNhdXNlcyBNVFJSX1RZUEVfVU5DQUNIQUJMRSB0byBiZSByZXR1cm5lZC4NCj4gVGhlbiB3
ZSdyZSBiYWNrIHRvIHRoZSBvcmlnaW5hbCBwcm9ibGVtIHdoZXJlIHBhdF94X210cnJfdHlw
ZSgpDQo+IHJldHVybnMgVUMtIGluc3RlYWQgb2YgV0IuDQoNClNpZ2guIEp1c3QgcmVtb3Zp
bmcgdGhlIHRlc3QgZm9yIGNhY2hlX21hcCBiZWluZyBOVUxMIGluIG10cnJfdHlwZV9sb29r
dXAoKQ0Kc2hvdWxkIGRvIHRoZSBqb2IuDQoNCldpbGwgc2VuZCBWNCBzb29uLg0KDQoNCkp1
ZXJnZW4NCg==
--------------BgxYzakw49aadpnbSGTF0ZWf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------BgxYzakw49aadpnbSGTF0ZWf--

--------------DJtJfYKBwN4ymJFIeg4Vix03--

--------------zGzzqnusEaaIEV56m8HV7DNy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmP8V4oFAwAAAAAACgkQsN6d1ii/Ey+B
JggAnGD6b76+1y8cgEUGI7OnOjvq1LOzC7ugCETkvAWuh4qx43UCOQQWS6zCXg8y7gUxRe8seUyl
RPwBVlITHrFBr1rOtmsEMfB8Ulw+V7r2GlB9SnF2omgZ/tN8J913YTh6MdP73wveWaW+Zx9SBP9D
svPt4QEgJ70OUqpPtBd9dMUrmDwnpmtvJINtlQW3MHnOZa+2YRSPuEBTzcLJk8X3Q+t5eWWGfgZQ
L3dohGPT5SMsIbDP1pSrqibBAp4HPXy7dJ8DvKsogzkqwDSs0phrQceHAVOj2iIBU+oG5YDkx/M5
+R65B4dlj26LXo8g3nuc6fq3icshsx+yXxBuy62dhw==
=o7Jz
-----END PGP SIGNATURE-----

--------------zGzzqnusEaaIEV56m8HV7DNy--
