Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837656D216C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjCaNXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCaNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:23:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48731A453
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:23:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72F281F38D;
        Fri, 31 Mar 2023 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680268994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohS0kh5Hd5zKyHG8WvBBFaYGz6nCgb+MCzx2JDykYl0=;
        b=gi/jQvL9m0BUn8sxhJBWcFqPgftfpejMgHHjeo/baWOpddSdcbRm32uVpfLEtQ1cZSDaCw
        Hxeit0PjiUvkaWECkzclAetAVMXrJtDPaA6+Kau9WDaIQIR+q+ZRHb3GPTftkVzRRWLRgj
        rAO1fyzeCBcXdhDK6w67xsA0F8LTm/g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33076133B6;
        Fri, 31 Mar 2023 13:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ktT6CsLeJmS8RgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 31 Mar 2023 13:23:14 +0000
Message-ID: <8860c326-3ba5-bd4c-1dab-17772e8fcda0@suse.com>
Date:   Fri, 31 Mar 2023 15:23:13 +0200
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
 <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
 <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
 <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
In-Reply-To: <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Izbf0aKKtrrEdH1AfrqRyCoX"
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
--------------Izbf0aKKtrrEdH1AfrqRyCoX
Content-Type: multipart/mixed; boundary="------------8PfGovudlXTNqu0310ilmdOj";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <8860c326-3ba5-bd4c-1dab-17772e8fcda0@suse.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
 <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
 <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
In-Reply-To: <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>

--------------8PfGovudlXTNqu0310ilmdOj
Content-Type: multipart/mixed; boundary="------------Pnfg8CI0p0Ti2PJ8pe7nhMoQ"

--------------Pnfg8CI0p0Ti2PJ8pe7nhMoQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDMuMjMgMTQ6NTUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXIgMjksIDIwMjMgYXQgMDM6Mzk6MzVQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE5vLiA6LSkNCj4gDQo+IEJlY2F1c2U/DQoNCkluIGdlbmVyYWwgdGhlIGNyaXRpY2Fs
IGNhc2UgaXMgYWRkX21hcF9lbnRyeV9hdCgpIHJldHVybmluZyAyIChpbiB0aGUNCmNhc2Ug
aXQgaXMgcmV0dXJuaW5nIDEsIHRoZSBpbmRleCBjYW4gYmUgc2V0IHRvIC0xLCBidXQgdGhl
cmUgaXMgYWx3YXlzDQp0aGUgImNvbnRpbnVlIiBzdGF0ZW1lbnQgcmlnaHQgYWZ0ZXIgdGhh
dCwgd2hpY2ggd291bGQgZXhlY3V0ZSB0aGUgImkrKyINCm9mIHRoZSAiZm9yIiBzdGF0ZW1l
bnQpLg0KDQphZGRfbWFwX2VudHJ5X2F0KCkgY2FuIHJldHVybiAyIG9ubHksIGlmIGl0IGRl
dGVjdHMgIm1lcmdlX3ByZXYiIGFuZA0KIm1lcmdlX25leHQiLiAibWVyZ2VfcHJldiIgY2Fu
IGJlIHNldCBvbmx5IGlmIHRoZSBjdXJyZW50IGluZGV4IHdhcyA+IDAsDQp3aGljaCBtYWtl
cyBpdCBpbXBvc3NpYmxlIHRvIHJldHVybiAyIGlmIHRoZSBpbmRleCB3YXMgMC4NCg0KPj4g
VGhlIGZpbmFsIGZvcm0gb2YgdGhlIGNvZGUgaXMgdGhlIHJlc3VsdCBvZiBhbiBpdGVyYXRp
dmUgcHJvY2Vzcy4gOi0pDQo+IA0KPiBJIGhhdmUgYSBzaW1pbGFyIGl0ZXJhdGl2ZSBwcm9j
ZXNzOiB1bnRpbCBpdCBoYXNuJ3QgYmVlbiByZXZpZXdlZCBhbmQNCj4gZXhwbGFpbmVkIHBy
b3Blcmx5LCB0aGlzIGlzIG5vdCBnb2luZyBhbnl3aGVyZS4NCg0KT2YgY291cnNlLg0KDQo+
IFNvIGhvd2V2ZXIgeW91IHdhbm5hIGRvIGl0LCBmaW5lIGJ5IG1lLg0KPiANCj4+IEkndmUg
cmV1c2VkIHRoZSB3b3JkaW5nIGZyb20gY2xlYW51cC5jIChqdXN0IGFib3ZlIGFtZF9zcGVj
aWFsX2RlZmF1bHRfbXRycigpKS4NCj4gDQo+IFRoYXQgZ290IGFkZGVkIHdpdGggSzguIEs4
IGlzIGFuY2llbnQgaGlzdG9yeSBzbyBub3RoaW5nIG1hZ2ljIGFib3V0DQo+IHRoYXQgYW55
bW9yZS4gSXQgaXMgYmFzaWNhbGx5IGEgYml0IGluIHRoZSBTWVNDRkcgTVNSIHdoaWNoIHNh
eXMgdGhhdA0KPiANCj4gCVs0RyAuLi4gVE9QX01FTTJdDQo+IA0KPiBpcyBXQi4NCg0KSG93
IHNob3VsZCBpdCBiZSBuYW1lZD8gQU1EIFRPUF9NRU0yIE1TUj8NCg0KPj4+IFdoeSBub3Qg
aW4gbXRycl9icF9pbml0KCk/IFRoYXQgaXMgdGhlIGZpcnN0IENQVS4NCj4+DQo+PiBZZWFo
LCBidXQgZ2VuZXJpY19zZXRfbXRycigpIGNhbiBiZSBjYWxsZWQgYWZ0ZXIgYm9vdCwgdG9v
Lg0KPiANCj4gVGhhdCBmdW5jdGlvbiBzZXRzIGEgc2luZ2xlIE1UUlIgcmVnaXN0ZXIgc28g
eW91J2QgaGF2ZSB0byBtZXJnZSB0aGUNCj4gcmFuZ2VzLCBBRkFJQ1QuIE5vdCByZWJ1aWxk
IHRoZSB3aG9sZSBtYXAuLi4NCg0KVGhlIHByb2JsZW0gaXNuJ3QgYW4gYWRkZWQgTVRSUiBy
ZWdpc3RlciwgYnV0IGEgcG9zc2libHkgcmVwbGFjZWQgb3IgcmVtb3ZlZA0Kb25lLiBIYW5k
bGluZyB0aGF0IGlzIG11Y2ggbW9yZSBjb21wbGljYXRlZCwgc28gSSd2ZSBjaG9zZW4gdG8g
ZG8gaXQgdGhlIHNpbXBsZQ0Kd2F5Lg0KDQpJbiB0aGUgZW5kIEknZCBleHBlY3Qgc2V0dGlu
ZyBvZiBNVFJScyB0byBiZSBhIHJhcmUgZXZlbnQsIHNvIHRoZXJlIHNob3VsZG4ndCBiZQ0K
YSBwZXJmb3JtYW5jZSBpc3N1ZSB3aXRoIHRoYXQgYXBwcm9hY2guDQoNCj4gDQo+PiBVbW0s
IG5vdCByZWFsbHkuIEkgd2FudCB0byBkbyB0aGUgY29weSBldmVuIGluIHRoZSBYZW4gUFYg
Y2FzZS4NCj4gDQo+IEhvdyBhYm91dCBzb21lIGNvbW1lbnRzPyBPciB5b3UncmUgZXhwZWN0
aW5nIG1lIHRvIGJlIGFibGUgdG8gcmVhZCB5b3VyDQo+IG1pbmQ/IQ0KDQpPa2F5LCBJJ2xs
IGFkZCBzb21lIG1vcmUgY29tbWVudHMuDQoNCk9UT0gsIHdoYXQgd2FzIGhhcmQgdG8gd3Jp
dGUgc2hvdWxkIGJlIGhhcmQgdG8gcmVhZCAoanVzdCBraWRkaW5nKS4NCg0KDQpKdWVyZ2Vu
DQo=
--------------Pnfg8CI0p0Ti2PJ8pe7nhMoQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Pnfg8CI0p0Ti2PJ8pe7nhMoQ--

--------------8PfGovudlXTNqu0310ilmdOj--

--------------Izbf0aKKtrrEdH1AfrqRyCoX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQm3sEFAwAAAAAACgkQsN6d1ii/Ey9I
hQf8D5JON87843r0t9zuf+/fotjBJIF6ASIfOj9XF7iNCK+ZhRWQr77paCPiP9t4NpKhnBAqXosX
9JyWpxyPPqc1E0gMJixYF0JCu+yOgEqzj3UpYVXL7EcisMI+iC1x0nt8L1Ot9zEUCsfuAa5AfAy6
DTMHg2S1SZ/8narWri3W6zFuwD6BElsy7Xuw30qDoxsAdFMP/MT2aqTl64CHip9/jaTLn/njHDn4
zG+kjDqpgdSCQVMHoiaFh6mAnBtWb5cCzqxavoKFc17QaUsvoNckksf1TzlF+vv9wWKtT/UUzk7k
DoNWSq4mBlyGNiAljamXGQGkp/47oQRWh9vbAijk3g==
=b83F
-----END PGP SIGNATURE-----

--------------Izbf0aKKtrrEdH1AfrqRyCoX--
