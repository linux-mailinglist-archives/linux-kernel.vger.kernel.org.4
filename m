Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922D8693E09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBMGHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:07:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C377DBE2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:07:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E207334F82;
        Mon, 13 Feb 2023 06:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676268458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8S29mxbNEAwKgmDfxlS0B/eZN823kVdFQlpdZqYMjs=;
        b=GZO82gAtF+IvQwDo4TJEooJyducaGy2pkCvnps/k8Pootrfoy46hmu6la8VdBzBQVB7Q9E
        uengM75nHHIqq243lqSI7tFv63epETyLBFuz7qn92DKJTD0wtWX4NjxIdNpsx7ntPIkU74
        Hg/GLMyMn+1ISW/XMlQ8hTcAxRrP/UQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9326F1391B;
        Mon, 13 Feb 2023 06:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1EmRIqrT6WM+fAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 06:07:38 +0000
Message-ID: <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
Date:   Mon, 13 Feb 2023 07:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iMBNP70RShZLkRhy054Hh4zP"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iMBNP70RShZLkRhy054Hh4zP
Content-Type: multipart/mixed; boundary="------------iM3l0HroCBzfMV1jRrqOoOzG";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: lists@nerdbynature.de, mikelley@microsoft.com,
 torvalds@linux-foundation.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
In-Reply-To: <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>

--------------iM3l0HroCBzfMV1jRrqOoOzG
Content-Type: multipart/mixed; boundary="------------pyh9U03ywoneJpYbjux1kGpI"

--------------pyh9U03ywoneJpYbjux1kGpI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDIuMjMgMTk6NTksIExpbnV4IHJlZ3Jlc3Npb24gdHJhY2tpbmcgKFRob3JzdGVu
IExlZW1odWlzKSB3cm90ZToNCj4gSGksIHRoaXMgaXMgeW91ciBMaW51eCBrZXJuZWwgcmVn
cmVzc2lvbiB0cmFja2VyLg0KPiANCj4gT24gMDkuMDIuMjMgMDg6MjIsIEp1ZXJnZW4gR3Jv
c3Mgd3JvdGU6DQo+PiBDb21taXQgOTBiOTI2ZTY4ZjUwICgieDg2L3BhdDogRml4IHBhdF94
X210cnJfdHlwZSgpIGZvciBNVFJSIGRpc2FibGVkDQo+PiBjYXNlIikgaGFzIGludHJvZHVj
ZWQgYSByZWdyZXNzaW9uIHdpdGggWGVuLg0KPj4NCj4+IFJldmVydCB0aGUgcGF0Y2guDQo+
IA0KPiBUaGF0IHJlZ3Jlc3Npb24geW91IHJlZmVyIHRvIGlzIGFmYWljcyBvbmUgSSdtIHRy
YWNraW5nWzFdIHRoYXQgd2FzDQo+IGludHJvZHVjZWQgdGhpcyBjeWNsZS4gVGhhdCBtYWtl
cyBtZSB3b25kZXI6IGNvdWxkIHRoaXMgcGF0Y2ggYmUgYXBwbGllZA0KPiBkaXJlY3RseSB0
byBmaXggdGhlIGlzc3VlIHF1aWNrbHk/IE9yIGFyZSBwYXRjaGVzIDEgdG8gNCBuZWVkZWQg
YXMgd2VsbA0KPiAob3IgdGhlIHdob2xlIHNlcmllcz8pIHRvIGF2b2lkIG90aGVyIHByb2Js
ZW1zPw0KDQpQYXRjaGVzIDEtNCBhcmUgbmVlZGVkLCB0b28sIGFzIG90aGVyd2lzZSB0aGUg
aXNzdWUgY2xhaW1lZCB0byBiZSBmaXhlZA0Kd2l0aCBwYXRjaCA1IHdvdWxkIHNob3cgdXAg
YWdhaW4uDQoNCkknbSB3b3JraW5nIG9uIGFkZHJlc3NpbmcgdGhlIGNvbW1lbnRzIEkndmUg
cmVjZWl2ZWQuDQoNCg0KSnVlcmdlbg0KDQo+IA0KPiBDaWFvLCBUaG9yc3Rlbg0KPiANCj4g
WzFdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80ZmU5NTQxZS00ZDRjLTJiMmEt
ZjhjOC0yZDM0YTcyODQ5MzBAbmVyZGJ5bmF0dXJlLmRlLw0KPiANCj4gUC5TLjogQlRXOyBs
ZXQgbWUgdGVsbCByZWd6Ym90IHRvIG1vbml0b3IgdGhpcyB0aHJlYWQ6DQo+IA0KPiAjcmVn
emJvdCBeYmFja21vbml0b3I6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80ZmU5
NTQxZS00ZDRjLTJiMmEtZjhjOC0yZDM0YTcyODQ5MzBAbmVyZGJ5bmF0dXJlLmRlLw0KPiAN
Cj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvbW0vcGF0L21lbXR5cGUuYyB8IDMgKy0tDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGF0L21lbXR5cGUuYyBiL2FyY2gveDg2L21t
L3BhdC9tZW10eXBlLmMNCj4+IGluZGV4IGZiNGIxYjVlMGRlYS4uNDZkZTljZjVjOTFkIDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvbW0vcGF0L21lbXR5cGUuYw0KPj4gKysrIGIvYXJj
aC94ODYvbW0vcGF0L21lbXR5cGUuYw0KPj4gQEAgLTM4Nyw4ICszODcsNyBAQCBzdGF0aWMg
dW5zaWduZWQgbG9uZyBwYXRfeF9tdHJyX3R5cGUodTY0IHN0YXJ0LCB1NjQgZW5kLA0KPj4g
ICAJCXU4IG10cnJfdHlwZSwgdW5pZm9ybTsNCj4+ICAgDQo+PiAgIAkJbXRycl90eXBlID0g
bXRycl90eXBlX2xvb2t1cChzdGFydCwgZW5kLCAmdW5pZm9ybSk7DQo+PiAtCQlpZiAobXRy
cl90eXBlICE9IE1UUlJfVFlQRV9XUkJBQ0sgJiYNCj4+IC0JCSAgICBtdHJyX3R5cGUgIT0g
TVRSUl9UWVBFX0lOVkFMSUQpDQo+PiArCQlpZiAobXRycl90eXBlICE9IE1UUlJfVFlQRV9X
UkJBQ0spDQo+PiAgIAkJCXJldHVybiBfUEFHRV9DQUNIRV9NT0RFX1VDX01JTlVTOw0KPj4g
ICANCj4+ICAgCQlyZXR1cm4gX1BBR0VfQ0FDSEVfTU9ERV9XQjsNCg0K
--------------pyh9U03ywoneJpYbjux1kGpI
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------pyh9U03ywoneJpYbjux1kGpI--

--------------iM3l0HroCBzfMV1jRrqOoOzG--

--------------iMBNP70RShZLkRhy054Hh4zP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp06kFAwAAAAAACgkQsN6d1ii/Ey+W
1wgAgt9ZqqbbmTywt1ix7LAsSdQ0IZrxSP4sQmbsW9oJWyvv/fTEwX/UDFPhDEikmgBdRdazEh0B
OKA1w2ORlEJqv3AzSM/lXcChaUPPGde6c9yzGMrVrlZj1DR57Yww41PyeeTiW/ujTMK0P725spH5
JZbK60EHMDDX7QW5v8k7nPjB68GZSCvVP2nna/znE8I2KVHMCAKyyy8HNPXUVqFduf1J+EH3dMWd
WGSpN2gHlC9ue4SD42Ga2WlFHECDyj2MlD3LtBtScsGSCvHCEwEdX+BfUGuKiUV3qMWvUgp3J5QE
nssY+414GsPiGTJ6eGYjKWgGZ3150A7+66tqs4FoWA==
=d8sM
-----END PGP SIGNATURE-----

--------------iMBNP70RShZLkRhy054Hh4zP--
