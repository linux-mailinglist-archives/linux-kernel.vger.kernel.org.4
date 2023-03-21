Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896316C2A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCUGBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCUGBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:01:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA42FCD6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:01:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2AD4D1FD6A;
        Tue, 21 Mar 2023 06:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679378459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNPtfVmBNWB46oNqjgMOOJq5xIWbXlcYeu2ufNq9LG8=;
        b=rSNVtPZwTVj3lSpTwvhLDnGaVPXlHTgw1QrJT/LWljIG2FO6AKr4yNjThG7s0zfp2EiAYa
        l/WpBbqbfF1WNfZLG/DAlrUE7HEHTY3/aqaj4fdFOqUXd66KOpe1EqjYwvaomGBlyfAXb9
        6EYlsXbH7B8rRwZKibOZzcqevv5cDkQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E393E13440;
        Tue, 21 Mar 2023 06:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jyaSNRpIGWTHTgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 21 Mar 2023 06:00:58 +0000
Message-ID: <01ec6ce2-7639-2e4f-3433-c77c29fa7984@suse.com>
Date:   Tue, 21 Mar 2023 07:00:58 +0100
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
 <20230306163425.8324-4-jgross@suse.com>
 <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
In-Reply-To: <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------G2tmpVhdR4cxQ8mo8zLez8bc"
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
--------------G2tmpVhdR4cxQ8mo8zLez8bc
Content-Type: multipart/mixed; boundary="------------xUAyGdFcFXpYhoZ1Ywxi13aY";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <01ec6ce2-7639-2e4f-3433-c77c29fa7984@suse.com>
Subject: Re: [PATCH v4 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-4-jgross@suse.com>
 <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
In-Reply-To: <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>

--------------xUAyGdFcFXpYhoZ1Ywxi13aY
Content-Type: multipart/mixed; boundary="------------x3aUPNtfoUoXfSzqq1AXBE4A"

--------------x3aUPNtfoUoXfSzqq1AXBE4A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDMuMjMgMjA6MDUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMDYsIDIwMjMgYXQgMDU6MzQ6MTZQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+ICsvKioNCj4+ICsgKiBtdHJyX292ZXJ3cml0ZV9zdGF0ZSAtIHNldCBzdGF0aWMgTVRS
UiBzdGF0ZQ0KPj4gKyAqDQo+PiArICogVXNlZCB0byBzZXQgTVRSUiBzdGF0ZSB2aWEgZGlm
ZmVyZW50IG1lYW5zIChlLmcuIHdpdGggZGF0YSBvYnRhaW5lZCBmcm9tDQo+PiArICogYSBo
eXBlcnZpc29yKS4NCj4+ICsgKiBJcyBhbGxvd2VkIG9ubHkgZm9yIHNwZWNpYWwgY2FzZXMg
d2hlbiBydW5uaW5nIHZpcnR1YWxpemVkLiBNdXN0IGJlIGNhbGxlZA0KPj4gKyAqIGZyb20g
dGhlIHg4Nl9pbml0Lmh5cGVyLmluaXRfcGxhdGZvcm0oKSBob29rLiBYODZfRkVBVFVSRV9N
VFJSIG11c3QgYmUgb2ZmLg0KPj4gKyAqLw0KPj4gK3ZvaWQgbXRycl9vdmVyd3JpdGVfc3Rh
dGUoc3RydWN0IG10cnJfdmFyX3JhbmdlICp2YXIsIHVuc2lnbmVkIGludCBudW1fdmFyLA0K
Pj4gKwkJCSAgbXRycl90eXBlIGRlZl90eXBlKQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50
IGk7DQo+PiArDQo+PiArCWlmIChXQVJOX09OKG10cnJfc3RhdGVfc2V0IHx8DQo+PiArCQkg
ICAgaHlwZXJ2aXNvcl9pc190eXBlKFg4Nl9IWVBFUl9OQVRJVkUpIHx8DQo+IA0KPiBXaHkg
dGhhdCBjaGVjaz8NCg0KSSBndWVzcyB5b3UgYXJlIGFza2luZyBiZWNhdXNlIHRoZSBuZXh0
IHRlc3Qgc2VlbXMgdG8gY2F0Y2ggdGhlIHNhbWUgY2FzZT8NCg0KSSB0aGluayBpdCBkb2Vz
bid0LCBlLmcuIGZvciB0aGUgY2FzZSBvZiB1bmtub3duIGh5cGVydmlzb3JzICh3aGljaCBz
aG93cyB0aGF0DQpYODZfSFlQRVJfTkFUSVZFIGluIHRoZW9yeSBzaG91bGQgYmUgbmFtZWQg
WDg2X0hZUEVSX05BVElWRV9PUl9VTktOT1dOLCBvciBpdA0Kc2hvdWxkIGJlIHNwbGl0IGlu
dG8gWDg2X0hZUEVSX05BVElWRSBhbmQgWDg2X0hZUEVSX1VOS05PV04pLg0KDQo+IA0KPj4g
KwkJICAgICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpIHx8
DQo+PiArCQkgICAgKCFjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9TRVZfU05QKSAm
Jg0KPj4gKwkJICAgICAhaHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRlZCgpICYmDQo+PiArCQkg
ICAgICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSAmJg0KPj4gKwkJ
ICAgICAhY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKSkpDQo+
IA0KPiBUaGlzIGlzIHVucGFyc2VhYmxlLiBQbGVhc2Ugc3BsaXQgaXQgaW50byBzZXBhcmF0
ZSBjaGVja3M6DQo+IA0KPiAJaWYgKFdBUk5fT04obXRycl9zdGF0ZV9zZXQpKQ0KPiAJCXJl
dHVybjsNCj4gDQo+IAlpZiAoV0FSTl9PTighY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVB
VFVSRV9IWVBFUlZJU09SKSkpDQo+IAkJcmV0dXJuOw0KPiANCj4gCS4uLg0KPiANCj4gYW5k
IGFkZCBjb21tZW50cyBhYm92ZSBlYWNoIG9uZSB3aHkgd2UncmUgdGVzdGluZyB0aGlzLg0K
DQpPa2F5Lg0KDQo+IA0KPiANCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJLyogRGlzYWJs
ZSBNVFJSIGluIG9yZGVyIHRvIGRpc2FibGUgTVRSUiBtb2RpZmljYXRpb25zLiAqLw0KPj4g
KwlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX01UUlIpOw0KPj4gKw0KPj4gKwlp
ZiAodmFyKSB7DQo+PiArCQlpZiAobnVtX3ZhciA+IE1UUlJfTUFYX1ZBUl9SQU5HRVMpIHsN
Cj4+ICsJCQlwcl93YXJuKCJUcnlpbmcgdG8gb3ZlcndyaXRlIE1UUlIgc3RhdGUgd2l0aCAl
dSB2YXJpYWJsZSBlbnRyaWVzXG4iLA0KPj4gKwkJCQludW1fdmFyKTsNCj4+ICsJCQludW1f
dmFyID0gTVRSUl9NQVhfVkFSX1JBTkdFUzsNCj4+ICsJCX0NCj4+ICsJCWZvciAoaSA9IDA7
IGkgPCBudW1fdmFyOyBpKyspDQo+PiArCQkJbXRycl9zdGF0ZS52YXJfcmFuZ2VzW2ldID0g
dmFyW2ldOw0KPj4gKwkJbnVtX3Zhcl9yYW5nZXMgPSBudW1fdmFyOw0KPj4gKwl9DQo+PiAr
DQo+PiArCW10cnJfc3RhdGUuZGVmX3R5cGUgPSBkZWZfdHlwZTsNCj4+ICsJbXRycl9zdGF0
ZS5lbmFibGVkIHw9IE1UUlJfU1RBVEVfTVRSUl9FTkFCTEVEOw0KPj4gKw0KPj4gKwltdHJy
X3N0YXRlX3NldCA9IDE7DQo+PiArfQ0KPj4gKw0KPj4gICAvKioNCj4+ICAgICogbXRycl90
eXBlX2xvb2t1cCAtIGxvb2sgdXAgbWVtb3J5IHR5cGUgaW4gTVRSUg0KPj4gICAgKg0KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+PiBpbmRleCA3NTk2ZWJlYWI5MjkuLjVmZTYy
ZWUwMzYxYiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJy
LmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4+IEBAIC02
NjYsNiArNjY2LDE1IEBAIHZvaWQgX19pbml0IG10cnJfYnBfaW5pdCh2b2lkKQ0KPj4gICAJ
Y29uc3QgY2hhciAqd2h5ID0gIihub3QgYXZhaWxhYmxlKSI7DQo+PiAgIAl1bnNpZ25lZCBp
bnQgcGh5c19hZGRyOw0KPj4gICANCj4+ICsJaWYgKG10cnJfc3RhdGUuZW5hYmxlZCkgew0K
PiANCj4gSSdtIGd1ZXNzaW5nIHRoZSBwcm9wZXIgZGV0ZWN0aW9uIG9mIHRoYXQgd2VpcmQg
c3RhdGUgc2hvdWxkIGJlOg0KPiANCj4gCS8qDQo+IAkgKiBDaGVjayBmb3IgdGhlIHNvZnR3
YXJlIG92ZXJ3cml0ZSBvZiBNVFJSIHN0YXRlLCBvbmx5IGZvciBnZW5lcmljIGNhc2UuDQo+
IAkgKiBTZWUgbXRycl9vdmVyd3JpdGVfc3RhdGUoKS4NCj4gCSAqLw0KPiAJaWYgKCFjcHVf
ZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX01UUlIpICYmDQo+IAkgICAgbXRycl9zdGF0
ZS5lbmFibGVkKSB7DQo+IAkJLi4uDQoNCkl0IGJhc2ljYWxseSBkb2Vzbid0IG1hdHRlci4N
Cg0KVGhlIG9ubHkgcG9zc2liaWxpdHkgb2YgbXRycl9zdGF0ZS5lbmFibGVkIHRvIGJlIHNl
dCBhdCB0aGlzIHBvaW50IGlzIGENCnByZXZpb3VzIGNhbGwgb2YgbXRycl9vdmVyd3JpdGVf
c3RhdGUoKS4NCg0KDQpKdWVyZ2VuDQo=
--------------x3aUPNtfoUoXfSzqq1AXBE4A
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------x3aUPNtfoUoXfSzqq1AXBE4A--

--------------xUAyGdFcFXpYhoZ1Ywxi13aY--

--------------G2tmpVhdR4cxQ8mo8zLez8bc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQZSBoFAwAAAAAACgkQsN6d1ii/Ey9O
Mwf/VyOqVsWxWgMXYuuLA10gGyu8Ww3xjodlDCgigTmWKXP1LptGYJYSi3n31XjTayJhG6qO4Kka
D+8q2OVljeh5Mb+mCLQcBZw5/BVhHvKxG1Ykx7ADL8v1yHxmMyvLdAKkldU+/v0a1RHz4OlYcg9d
3Q46U+sZJYtAEm8u2Ks9BSHb7FaQeVuCG+/LN0g2jzHUmARgm7Sg/MamPtid0RDZUuKqOe0cyZtU
we+Llav9VNoBm8b6Gp8qM1pL9HGC8z8scNm3edjK1q8TX5Daj+52Yjetk1zNXZXAlASk6CWxTtsR
zu6vL7wgeerbjRT6L6lLbeS5GKgF3AkBVOLmMbKnTQ==
=vEPw
-----END PGP SIGNATURE-----

--------------G2tmpVhdR4cxQ8mo8zLez8bc--
