Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E43697DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBONkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjBONkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:40:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30451392BB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:40:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2B4209CC;
        Wed, 15 Feb 2023 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676468407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=63eoPhVvZhky21DiItpAbe4CWe6GFbedractIVhDGqo=;
        b=dKsOfjvmQ5BY6oW/ARcl/bI1uQIjlHcWSnQCUNeF3kQtDRPtn5di2r/aGrkz51ijvCZNpp
        E7lJBP0ndVOq/ltSXzcTJBrWDTCMC7w9KiPJyn1Sj0poovb3LEe4nM/4NPxyVad6U3Llk8
        imyOWPbQUI2nfxVyTNU3pXBtXIUWiyA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19FED134BA;
        Wed, 15 Feb 2023 13:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1e/hBLfg7GP9bQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Feb 2023 13:40:07 +0000
Message-ID: <7e4c5d0f-4cdc-8aca-0ce9-19b5f2371ea6@suse.com>
Date:   Wed, 15 Feb 2023 14:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------14rUxmbALOm0n0B064OMi4t0"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------14rUxmbALOm0n0B064OMi4t0
Content-Type: multipart/mixed; boundary="------------giUHBOV5to0s67byfhmyod0n";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <7e4c5d0f-4cdc-8aca-0ce9-19b5f2371ea6@suse.com>
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------giUHBOV5to0s67byfhmyod0n
Content-Type: multipart/mixed; boundary="------------IHm9kXqBfM9hlJa33KwJLd0r"

--------------IHm9kXqBfM9hlJa33KwJLd0r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMDI6MDgsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSA4LCAyMDIzIDExOjIyIFBNDQo+Pg0KPj4gVG9kYXkgcHVkX3NldF9odWdlKCkg
YW5kIHBtZF9zZXRfaHVnZSgpIHRlc3QgZm9yIHRoZSBNVFJSIHR5cGUgdG8gYmUNCj4+IFdC
IG9yIElOVkFMSUQgYWZ0ZXIgY2FsbGluZyBtdHJyX3R5cGVfbG9va3VwKCkuIFRob3NlIHRl
c3RzIGNhbiBiZQ0KPj4gZHJvcHBlZCwgYXMgdGhlIG9ubHkgcmVhc29uIHRvIG5vdCB1c2Ug
YSBsYXJnZSBtYXBwaW5nIHdvdWxkIGJlDQo+PiB1bmlmb3JtIGJlaW5nIDAuIEFueSBNVFJS
IHR5cGUgY2FuIGJlIGFjY2VwdGVkIGFzIGxvbmcgYXMgaXQgYXBwbGllcw0KPj4gdG8gdGhl
IHdob2xlIG1lbW9yeSByYW5nZSBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5nLCBhcyB0aGUgYWx0
ZXJuYXRpdmUNCj4+IHdvdWxkIG9ubHkgYmUgdG8gbWFwIHRoZSBzYW1lIHJlZ2lvbiB3aXRo
IHNtYWxsZXIgcGFnZXMgaW5zdGVhZCB1c2luZw0KPj4gdGhlIHNhbWUgUEFUIHR5cGUgYXMg
Zm9yIHRoZSBsYXJnZSBtYXBwaW5nLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogTGludXMgVG9y
dmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPj4gU2lnbmVkLW9mZi1i
eTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gv
eDg2L21tL3BndGFibGUuYyB8IDYgKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L21tL3BndGFibGUuYyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KPj4gaW5kZXggZTRm
NDk5ZWIwZjI5Li43YjljNTQ0M2QxNzYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9tbS9w
Z3RhYmxlLmMNCj4+ICsrKyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KPj4gQEAgLTcyMSw4
ICs3MjEsNyBAQCBpbnQgcHVkX3NldF9odWdlKHB1ZF90ICpwdWQsIHBoeXNfYWRkcl90IGFk
ZHIsIHBncHJvdF90IHByb3QpDQo+PiAgIAl1OCBtdHJyLCB1bmlmb3JtOw0KPj4NCj4+ICAg
CW10cnIgPSBtdHJyX3R5cGVfbG9va3VwKGFkZHIsIGFkZHIgKyBQVURfU0laRSwgJnVuaWZv
cm0pOw0KPj4gLQlpZiAoKG10cnIgIT0gTVRSUl9UWVBFX0lOVkFMSUQpICYmICghdW5pZm9y
bSkgJiYNCj4+IC0JICAgIChtdHJyICE9IE1UUlJfVFlQRV9XUkJBQ0spKQ0KPj4gKwlpZiAo
IXVuaWZvcm0pDQo+PiAgIAkJcmV0dXJuIDA7DQo+Pg0KPj4gICAJLyogQmFpbCBvdXQgaWYg
d2UgYXJlIHdlIG9uIGEgcG9wdWxhdGVkIG5vbi1sZWFmIGVudHJ5OiAqLw0KPj4gQEAgLTc0
OCw4ICs3NDcsNyBAQCBpbnQgcG1kX3NldF9odWdlKHBtZF90ICpwbWQsIHBoeXNfYWRkcl90
IGFkZHIsIHBncHJvdF90IHByb3QpDQo+PiAgIAl1OCBtdHJyLCB1bmlmb3JtOw0KPj4NCj4+
ICAgCW10cnIgPSBtdHJyX3R5cGVfbG9va3VwKGFkZHIsIGFkZHIgKyBQTURfU0laRSwgJnVu
aWZvcm0pOw0KPj4gLQlpZiAoKG10cnIgIT0gTVRSUl9UWVBFX0lOVkFMSUQpICYmICghdW5p
Zm9ybSkgJiYNCj4+IC0JICAgIChtdHJyICE9IE1UUlJfVFlQRV9XUkJBQ0spKSB7DQo+PiAr
CWlmICghdW5pZm9ybSkgew0KPj4gICAJCXByX3dhcm5fb25jZSgiJXM6IENhbm5vdCBzYXRp
c2Z5IFttZW0gJSMwMTBsbHgtJSMwMTBsbHhdIHdpdGggYSBodWdlLXBhZ2UgbWFwcGluZyBk
dWUgdG8gTVRSUiBvdmVycmlkZS5cbiIsDQo+PiAgIAkJCSAgICAgX19mdW5jX18sIGFkZHIs
IGFkZHIgKyBQTURfU0laRSk7DQo+IA0KPiBJJ20gc2VlaW5nIHRoaXMgd2FybmluZyB0cmln
Z2VyIGluIGEgbm9ybWFsIEh5cGVyLVYgZ3Vlc3QgKGkuZS4sICpub3QqIGFuDQo+IFNFVi1T
TlAgQ29uZmlkZW50aWFsIFZNKS4gIFRoZSBvcmlnaW5hbCBmaWx0ZXJpbmcgaGVyZSBiYXNl
ZCBvbg0KPiBNVFJSX1RZUEVfV1JCQUNLIGFwcGVhcnMgdG8gYmUgaGlkaW5nIGEgYnVnIGlu
IG10cnJfdHlwZV9sb29rdXBfdmFyaWFibGUoKQ0KPiB3aGVyZSBpdCBpbmNvcnJlY3RseSB0
aGlua3MgYW4gYWRkcmVzcyByYW5nZSBtYXRjaGVzIHR3byBkaWZmZXJlbnQgdmFyaWFibGUN
Cj4gTVRSUnMsIGFuZCBoZW5jZSBjbGVhcnMgInVuaWZvcm0iLg0KPiANCj4gSGVyZSBhcmUg
dGhlIHZhcmlhYmxlIE1UUlJzIGluIHRoZSBub3JtYWwgSHlwZXItViBndWVzdCB3aXRoIDMy
IEdpQnl0ZXMNCj4gb2YgbWVtb3J5Og0KPiANCj4gWyAgICAwLjA0MzU5Ml0gTVRSUiB2YXJp
YWJsZSByYW5nZXMgZW5hYmxlZDoNCj4gWyAgICAwLjA0ODMwOF0gICAwIGJhc2UgMDAwMDAw
MDAwMDAwIG1hc2sgRkZGRjAwMDAwMDAwIHdyaXRlLWJhY2sNCj4gWyAgICAwLjA1NzQ1MF0g
ICAxIGJhc2UgMDAwMTAwMDAwMDAwIG1hc2sgRkZGMDAwMDAwMDAwIHdyaXRlLWJhY2sNCg0K
SSd2ZSByZWFkIHRoZSBTRE0gY2hhcHRlciBmb3IgTVRSUnMgYWdhaW4uIERvZXNuJ3QgIzEg
dmlvbGF0ZSB0aGUgcmVxdWlyZW1lbnRzDQpmb3IgTVRSUiBzZXR0aW5ncz8gVGhlIFNETSBz
YXlzOg0KDQogICBGb3IgcmFuZ2VzIGdyZWF0ZXIgdGhhbiA0IEtCeXRlcywgZWFjaCByYW5n
ZSBtdXN0IGJlIG9mIGxlbmd0aCAyXm4gYW5kIGl0cw0KICAgYmFzZSBhZGRyZXNzIG11c3Qg
YmUgYWxpZ25lZCBvbiBhIDJebiBib3VuZGFyeSwgd2hlcmUgbiBpcyBhIHZhbHVlIGVxdWFs
IHRvDQogICBvciBncmVhdGVyIHRoYW4gMTIuIFRoZSBiYXNlLWFkZHJlc3MgYWxpZ25tZW50
IHZhbHVlIGNhbm5vdCBiZSBsZXNzIHRoYW4gaXRzDQogICBsZW5ndGguIEZvciBleGFtcGxl
LCBhbiA4LUtCeXRlIHJhbmdlIGNhbm5vdCBiZSBhbGlnbmVkIG9uIGEgNC1LQnl0ZSBib3Vu
ZGFyeS4NCiAgIEl0IG11c3QgYmUgYWxpZ25lZCBvbiBhdCBsZWFzdCBhbiA4LUtCeXRlIGJv
dW5kYXJ5Lg0KDQpUaGlzIG1ha2VzIHRoZSByZWFzb25pbmcgYmVsb3cgd3JvbmcuDQoNCj4g
WyAgICAwLjA2Mzk3Ml0gICAyIGRpc2FibGVkDQo+IFsgICAgMC4wNjY3NTVdICAgMyBkaXNh
YmxlZA0KPiBbICAgIDAuMDcwMDI0XSAgIDQgZGlzYWJsZWQNCj4gWyAgICAwLjA3Mjg1Nl0g
ICA1IGRpc2FibGVkDQo+IFsgICAgMC4wNzYxMTJdICAgNiBkaXNhYmxlZA0KPiBbICAgIDAu
MDc4NzYwXSAgIDcgZGlzYWJsZWQNCj4gDQo+IFZhcmlhYmxlIE1UUlIgIzAgY292ZXJzIGFk
ZHJlc3NlcyB1cCB0byA0IEdpQnl0ZSwgd2hpbGUgIzEgY292ZXJzDQo+IDQgR2lCeXRlIHRv
IDY0IEdpQnl0ZS4gICBCdXQgaW4gbXRycl90eXBlX2xvb2t1cF92YXJpYWJsZSgpLCBhZGRy
ZXNzDQo+IHJhbmdlIDB4RjgwMDAwMDAgdG8gMHhGODFGRkZGRiBpcyBtYXRjaGluZyBib3Ro
IE1UUlJzLCB3aGVuIGl0DQo+IHNob3VsZCBiZSBtYXRjaGluZyBqdXN0ICMwLg0KPiANCj4g
VGhlIHByb2JsZW0gbG9va3MgdG8gYmUgdGhpcyBjb2RlIGluIG10cnJfdHlwZV9sb29rdXBf
dmFyaWFibGUoKToNCj4gDQo+ICAgICAgICAgICAgICAgIGlmICgoc3RhcnQgJiBtYXNrKSAh
PSAoYmFzZSAmIG1hc2spKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
DQo+IA0KPiBJZiB0aGUgbWFzayBiaXRzIG9mIHN0YXJ0IGFuZCBiYXNlIGFyZSBkaWZmZXJl
bnQsIHRoZW4gdGhlDQo+IE1UUlIgZG9lc24ndCBtYXRjaCwgYW5kIHRoZSBjb250aW51ZSBz
dGF0ZW1lbnQgc2hvdWxkIGJlDQo+IGV4ZWN1dGVkLiAgVGhhdCdzIGNvcnJlY3QuICBCdXQg
aWYgdGhlIG1hc2sgYml0cyBhcmUgdGhlIHNhbWUsDQo+IHRoYXQncyBub3Qgc3VmZmljaWVu
dCBmb3IgdGhlIE1UUlIgdG8gbWF0Y2guICBJZiB0aGUgZW5kDQo+IGFkZHJlc3MgaXMgbGVz
cyB0aGFuIGJhc2UsIHRoZSBNVFJSIGRvZXNuJ3QgbWF0Y2gsIGFuZA0KPiB0aGUgY29udGlu
dWUgc3RhdGVtZW50IHNob3VsZCBzdGlsbCBiZSBleGVjdXRlZCwgd2hpY2gNCj4gaXNuJ3Qg
aGFwcGVuaW5nLg0KPiANCj4gQnV0IHNvbWVib2R5IHBsZWFzZSBjaGVjayBteSB0aGlua2lu
Zy4gOi0pDQoNCkkgdGhpbmsgeW91IG5lZWQgdG8gY29ycmVjdCB0aGUgaHlwZXJ2aXNvci4N
Cg0KDQpKdWVyZ2VuDQoNCg==
--------------IHm9kXqBfM9hlJa33KwJLd0r
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IHm9kXqBfM9hlJa33KwJLd0r--

--------------giUHBOV5to0s67byfhmyod0n--

--------------14rUxmbALOm0n0B064OMi4t0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPs4LYFAwAAAAAACgkQsN6d1ii/Ey9c
MQgAht5w0rTpCzcLM0D56BAyz/Fesbqzqdny518Pj38gTOmzv3oEvcbtkS1Z1R+k3RmOblBLuObh
ZYL1+8++2O7uoh0ZlN7Z9P16kiJ7qx8CRv+fYHfqS3YnVaJxML27EJO3eUlGMUO6iWPr2IF7epOQ
79R7IgsOZtSh3LG5noSSpdDxtKsk0QNagOaTxq6e5xV1IC4fgqp4RhXiPPykAkfTKZhC9/GcIzOA
zzTrfCdg3I1ZzpONRdz5wQISnsbnVABuXZfH+zNmgLpD1Glk3mPMv4Ss/TPEG2YuH4n2dgXPN82J
WnqI5NQa9ISPBceHq3SUvSbk8fXngW21bx0lxGDVLg==
=WpXt
-----END PGP SIGNATURE-----

--------------14rUxmbALOm0n0B064OMi4t0--
