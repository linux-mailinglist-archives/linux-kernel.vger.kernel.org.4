Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21D6FC551
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjEILrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEILrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:47:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568F40C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:47:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F95821C56;
        Tue,  9 May 2023 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683632868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXyUgItNUzdOnwHTdLJfV2azkJ/FXeuxfK4Udj5Jc+s=;
        b=uQmaS91w5lvLmz2/RZgnNxaZxJvQhwVXvCB6f8WPpVI/q4nqHO02dbfGKa5o2MF0ehX9wA
        EkhBwVV2xRzgG98/EJkkglQ4ForWf4MO4d4c4B636PfJ3Q6jfEWWX1MG1ckXBlvTRsKubA
        qDDScs2YB2iPruEzZRkG2GjKjr6yFSA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FD80139B3;
        Tue,  9 May 2023 11:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V/wUCuQyWmSQMgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 09 May 2023 11:47:48 +0000
Message-ID: <1048ca31-bc34-fd29-c0da-6df141ff8b68@suse.com>
Date:   Tue, 9 May 2023 13:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 11/16] x86/mtrr: construct a memory map with cache
 modes
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-12-jgross@suse.com>
 <20230509113640.GDZFowSMVK66B30cAA@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230509113640.GDZFowSMVK66B30cAA@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AvP5OXvHkZzjVr21jKdFsmc0"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AvP5OXvHkZzjVr21jKdFsmc0
Content-Type: multipart/mixed; boundary="------------6zcPhlNKx1BTqeEgcnPz4D47";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, mikelley@microsoft.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1048ca31-bc34-fd29-c0da-6df141ff8b68@suse.com>
Subject: Re: [PATCH v6 11/16] x86/mtrr: construct a memory map with cache
 modes
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-12-jgross@suse.com>
 <20230509113640.GDZFowSMVK66B30cAA@fat_crate.local>
In-Reply-To: <20230509113640.GDZFowSMVK66B30cAA@fat_crate.local>

--------------6zcPhlNKx1BTqeEgcnPz4D47
Content-Type: multipart/mixed; boundary="------------N5dKOKgFG0j5QDEx7QDCD0Xv"

--------------N5dKOKgFG0j5QDEx7QDCD0Xv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDUuMjMgMTM6MzYsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBN
YXkgMDIsIDIwMjMgYXQgMDI6MDk6MjZQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEBAIC04NDEsNiArMTEzNywxMCBAQCBzdGF0aWMgdm9pZCBnZW5lcmljX3NldF9tdHJy
KHVuc2lnbmVkIGludCByZWcsIHVuc2lnbmVkIGxvbmcgYmFzZSwNCj4+ICAgDQo+PiAgIAlj
YWNoZV9lbmFibGUoKTsNCj4+ICAgCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+ICsN
Cj4+ICsJLyogT24gdGhlIGZpcnN0IENQVSByZWJ1aWxkIHRoZSBjYWNoZSBtb2RlIG1lbW9y
eSBtYXAuICovDQo+PiArCWlmIChzbXBfcHJvY2Vzc29yX2lkKCkgPT0gY3B1bWFza19maXJz
dChjcHVfb25saW5lX21hc2spKQ0KPj4gKwkJcmVidWlsZF9tYXAoKTsNCj4gDQo+IEkgc3Rp
bGwgZG9uJ3QgbGlrZSB0aGlzLiBBbnl0aGluZyBhZ2FpbnN0IGRvaW5nIHRoaXMgaW5zdGVh
ZD8NCg0KTm8sIFNob3VsZCBiZSBmaW5lLiBBcGFydCBmcm9tIC4uLg0KDQo+IA0KPiAtLS0N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmljLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jDQo+IGluZGV4IDE2M2RjYTUzNzk2
Yy4uZTY5YzhjNTY4OTdmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210
cnIvZ2VuZXJpYy5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9nZW5lcmlj
LmMNCj4gQEAgLTQ1OCw4ICs0NTgsMTEgQEAgc3RhdGljIHZvaWQgbWFwX2FkZF92YXIodm9p
ZCkNCj4gICAgKiByZW1vdmFscyBvZiByZWdpc3RlcnMsIHdoaWNoIGFyZSBjb21wbGljYXRl
ZCB0byBoYW5kbGUgd2l0aG91dCByZWJ1aWxkIG9mDQo+ICAgICogdGhlIG1hcC4NCj4gICAg
Ki8NCj4gLXN0YXRpYyB2b2lkIHJlYnVpbGRfbWFwKHZvaWQpDQo+ICt2b2lkIHJlYnVpbGRf
bWFwKHZvaWQpDQo+ICAgew0KPiArCWlmIChtdHJyX2lmICE9ICZnZW5lcmljX210cnJfb3Bz
KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gICAJY2FjaGVfbWFwX24gPSBjYWNoZV9tYXBfZml4
ZWQ7DQo+ICAgDQo+ICAgCW1hcF9hZGRfdmFyKCk7DQo+IEBAIC0xMTI3LDEwICsxMTMwLDYg
QEAgc3RhdGljIHZvaWQgZ2VuZXJpY19zZXRfbXRycih1bnNpZ25lZCBpbnQgcmVnLCB1bnNp
Z25lZCBsb25nIGJhc2UsDQo+ICAgDQo+ICAgCWNhY2hlX2VuYWJsZSgpOw0KPiAgIAlsb2Nh
bF9pcnFfcmVzdG9yZShmbGFncyk7DQo+IC0NCj4gLQkvKiBPbiB0aGUgZmlyc3QgQ1BVIHJl
YnVpbGQgdGhlIGNhY2hlIG1vZGUgbWVtb3J5IG1hcC4gKi8NCj4gLQlpZiAoc21wX3Byb2Nl
c3Nvcl9pZCgpID09IGNwdW1hc2tfZmlyc3QoY3B1X29ubGluZV9tYXNrKSkNCj4gLQkJcmVi
dWlsZF9tYXAoKTsNCj4gICB9DQo+ICAgDQo+ICAgaW50IGdlbmVyaWNfdmFsaWRhdGVfYWRk
X3BhZ2UodW5zaWduZWQgbG9uZyBiYXNlLCB1bnNpZ25lZCBsb25nIHNpemUsDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbGVnYWN5LmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L210cnIvbGVnYWN5LmMNCj4gaW5kZXggZDI1ODgyZmNmMTgxLi4zMGEzZDUx
ZDA2ZTAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9sZWdhY3ku
Yw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbGVnYWN5LmMNCj4gQEAgLTY3
LDYgKzY3LDcgQEAgc3RhdGljIHZvaWQgbXRycl9yZXN0b3JlKHZvaWQpDQo+ICAgCQkJCSAg
ICAgbXRycl92YWx1ZVtpXS5sdHlwZSk7DQo+ICAgCQl9DQo+ICAgCX0NCj4gKwlyZWJ1aWxk
X21hcCgpOw0KDQouLi4gdGhpcyBjYWxsIG5vdCBiZWluZyBuZWVkZWQgYXQgYWxsLiBXZSBj
YW4gcmVhY2ggdGhpcyBwb2ludCBvbmx5IGZvcg0KbXRycl9pZiAhPSAmZ2VuZXJpY19tdHJy
X29wcy4NCg0KDQpKdWVyZ2VuDQo=
--------------N5dKOKgFG0j5QDEx7QDCD0Xv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------N5dKOKgFG0j5QDEx7QDCD0Xv--

--------------6zcPhlNKx1BTqeEgcnPz4D47--

--------------AvP5OXvHkZzjVr21jKdFsmc0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRaMuMFAwAAAAAACgkQsN6d1ii/Ey9e
Pgf+LUYNIOl3t5l0yinOdHiqB5i1FU1GL04sUgXbJn9oXHciUPsqw/ogug8PiGxoxpZfLVGoGjVc
tzFPiGK0XAnD9wKT6DnyLMojBvgHamOOIasmP0Kx5lJC/eprn5wW1cUFOVICdLT+vPbX6oTp81Ey
jKGK5xwL5xHJkqGqnBAoNdMEWvWNmrDbPPgwP+DF4OKmGcB9gSFC1Mgq44qVmxOd4OrCenhQpeiJ
ZnU00GP2twIoBqy0aQGhxeaq5+aVS7agtBXURbsYchn53f8Ax0r1J+HW5+S54Zjc5tvvMTAYTAlr
rETYIono0dDq06Vt4+2TLEVwu2JpaEdoGSGlPfr9aA==
=m7z/
-----END PGP SIGNATURE-----

--------------AvP5OXvHkZzjVr21jKdFsmc0--
