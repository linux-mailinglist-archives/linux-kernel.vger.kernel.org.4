Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2216D217F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjCaNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjCaNfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:35:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65D1BF62
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:35:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAC151FD7C;
        Fri, 31 Mar 2023 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680269708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OdmtehBBVPK0khr+v0TpKvIJ2oISQ+yIfaqJCGYBRJs=;
        b=EHsaF340GxPP4NxNENQHUOCAdojV8qWi/9p6lUAefruJ2VMI0IXaK3oXOqfC5GjSP2DWwP
        484cGr5rNh91z7muCjIthgTbrlARWCBQ8K+IKwEWY5XRLcfa1MqmU1wMnuyEGpRDC+GEyg
        1laTiw4eYHC8Rur+s3N3xejBgl0mR6A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01A28133B6;
        Fri, 31 Mar 2023 13:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2oB3OovhJmQzTQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 31 Mar 2023 13:35:07 +0000
Message-ID: <73226c11-4443-1e52-4566-5799d21e4ccb@suse.com>
Date:   Fri, 31 Mar 2023 15:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230331125740.GCZCbYxFkJOg8hIl6C@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
In-Reply-To: <20230331125740.GCZCbYxFkJOg8hIl6C@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oOh24E1ycMROYs0cPpQz6rcT"
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
--------------oOh24E1ycMROYs0cPpQz6rcT
Content-Type: multipart/mixed; boundary="------------80XQxLZjNoD00NzHRbQqme5a";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <73226c11-4443-1e52-4566-5799d21e4ccb@suse.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230331125740.GCZCbYxFkJOg8hIl6C@fat_crate.local>
In-Reply-To: <20230331125740.GCZCbYxFkJOg8hIl6C@fat_crate.local>

--------------80XQxLZjNoD00NzHRbQqme5a
Content-Type: multipart/mixed; boundary="------------h97MxBmzjIRIJmEKVteU9c0y"

--------------h97MxBmzjIRIJmEKVteU9c0y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDMuMjMgMTQ6NTcsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMDYsIDIwMjMgYXQgMDU6MzQ6MjJQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+ICsvKiBCdWlsZCB0aGUgY2FjaGVfbWFwIGNvbnRhaW5pbmcgdGhlIGNhY2hlIG1vZGVz
IHBlciBtZW1vcnkgcmFuZ2UuICovDQo+PiArdm9pZCBtdHJyX2J1aWxkX21hcCh2b2lkKQ0K
Pj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGk7DQo+PiArCXU2NCBzdGFydCwgZW5kLCBzaXpl
Ow0KPj4gKwl1OCB0eXBlOw0KPj4gKw0KPj4gKwlpZiAoIW10cnJfc3RhdGUuZW5hYmxlZCkN
Cj4gCSAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCj4+ICsJCXJldHVybjsNCj4+ICsN
Cj4+ICsJLyogQWRkIGZpeGVkIE1UUlJzLCBvcHRpbWl6ZSBmb3IgYWRqYWNlbnQgZW50cmll
cyB3aXRoIHNhbWUgdHlwZS4gKi8NCj4+ICsJaWYgKG10cnJfc3RhdGUuZW5hYmxlZCAmIE1U
UlJfU1RBVEVfTVRSUl9GSVhFRF9FTkFCTEVEKSB7DQo+IAkgICAgXl5eXl5eXl5eXl5eXl5e
Xl5eDQo+IA0KPiBGaXJzdCBjaGVjayBjYW4gZ28uDQoNCkhtbSwgdGhpcyBtYWtlcyBpdCBt
dWNoIGhhcmRlciB0byBzZWUgdGhhdCB0aGUgY29kZSByZWFsbHkgZG9lcyBub3RoaW5nDQpp
ZiBlbmFibGVkIGlzbid0IHNldC4NCg0KPiANCj4+ICsJCXN0YXJ0ID0gMDsNCj4+ICsJCWVu
ZCA9IHNpemUgPSAweDEwMDAwOw0KPj4gKwkJdHlwZSA9IG10cnJfc3RhdGUuZml4ZWRfcmFu
Z2VzWzBdOw0KPj4gKw0KPj4gKwkJZm9yIChpID0gMTsgaSA8IE1UUlJfTlVNX0ZJWEVEX1JB
TkdFUzsgaSsrKSB7DQo+IA0KPiBMb29wcyBzdGFydHMgYXQgMS4gQ29tbWVudCBleHBsYWlu
aW5nIHdoeSBwbHMuDQoNCk9rYXkuDQoNCj4gDQo+PiArCQkJaWYgKGkgPT0gOCB8fCBpID09
IDI0KQ0KPiANCj4gTWFnaWMgbnVtYmVycy4NCg0KSSdsbCBhZGQgbW9yZSBjb21tZW50cy4N
Cg0KPiANCj4gT2ssIEknbGwgc3RvcCBoZXJlLg0KPiANCj4gUGxlYXNlIHNlbmQgYSBuZXcg
dmVyc2lvbiB3aXRoIHRoZSByZXZpZXcgY29tbWVudHMgaW5jb3Jwb3JhdGVkLiBJIG5lZWQN
Cj4gdG8gbG9vayBtb3JlIGF0IHRoYXQgbWFwIHRoaW5nIG1vcmUuDQoNCldpbGwgZG8uDQoN
Cg0KVGhhbmtzLA0KDQpKdWVyZ2VuDQoNCg==
--------------h97MxBmzjIRIJmEKVteU9c0y
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------h97MxBmzjIRIJmEKVteU9c0y--

--------------80XQxLZjNoD00NzHRbQqme5a--

--------------oOh24E1ycMROYs0cPpQz6rcT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQm4YsFAwAAAAAACgkQsN6d1ii/Ey+s
CQf+O+F+y6V3imgQAGO6wp7vV7fKBDTT5MQro/F2bXIlWQsHuA+hSflQNlLp6hVPziGXP+7H67uv
UZpPhkGEdW5rMyIv7ovQqfe+H1fFYlAabHkrrYMZsMw4NTui8WqWdG4AWfQn2sLrW/xOGpbcctJj
BYDkB84qzKU7+qIZpDNmbeA2CrnZ0Bi4uySOrbtfxak8teg0rZE7BMFUV2rWV/ITqq87uw9sW5BM
zrXfSA/+vXOffW+IX7X3YS4X5vkVmighqP5ZUcAX11jvRugPH0HhPTeIrU25mFq2RFEP9Jds4KY/
dVXePhPf6VWbnP8ETQJEJl3T2zxsCimxFjcMxHHixA==
=MLsL
-----END PGP SIGNATURE-----

--------------oOh24E1ycMROYs0cPpQz6rcT--
