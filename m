Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D66DDD30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDKOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:04:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0221519C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:04:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 971F11FDB1;
        Tue, 11 Apr 2023 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681221841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LC2T79hHE1b6Xm3QI7TDQ+uuw/B4s4v8EQV0v9OkK8I=;
        b=FPmBawrxaImA0wIHfuSa/57fKLJ8sOM/nemwPu3WdPBnBkeP4+QQcGqfDBnTbOLg6vGB1B
        1pf1r5a1qmZANeMsISiEgaESWWetqqTUs2g/9WqhIlqw3GbgYIDPs+M7gznabl4oj/uQLw
        +boSZzCVv73aefT1geJeMD55sHvvyfg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E9DA13519;
        Tue, 11 Apr 2023 14:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fMRSEdFoNWSYSwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 11 Apr 2023 14:04:01 +0000
Message-ID: <6febc91b-e0ac-5b14-5bb5-98dc017440ae@suse.com>
Date:   Tue, 11 Apr 2023 16:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
 <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Md06zI6py0rbr4ErFlFUbrdj"
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Md06zI6py0rbr4ErFlFUbrdj
Content-Type: multipart/mixed; boundary="------------J1TEqymdWVu77qv6a003FTsv";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6febc91b-e0ac-5b14-5bb5-98dc017440ae@suse.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
 <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168853F1DD1B76FACC1CFFFBD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------J1TEqymdWVu77qv6a003FTsv
Content-Type: multipart/mixed; boundary="------------8Mta09tbVEiDwd0Ht5HYbqUv"

--------------8Mta09tbVEiDwd0Ht5HYbqUv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDQuMjMgMTU6NTksIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiBTZW50OiBUdWVzZGF5LCBBcHJp
bCAxMSwgMjAyMyA2OjIxIEFNDQo+Pg0KPj4gT24gU2F0LCBBcHIgMDEsIDIwMjMgYXQgMDg6
MzY6NDFBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gDQo+IFtzbmlwXQ0KPiAN
Cj4+Pg0KPj4+ICsNCj4+PiArCS8qDQo+Pj4gKwkgKiBPbmx5IGFsbG93ZWQgZm9yIHNwZWNp
YWwgdmlydHVhbGl6YXRpb24gY2FzZXM6DQo+Pj4gKwkgKiAtIHdoZW4gcnVubmluZyBhcyBT
RVYtU05QIGd1ZXN0DQo+Pj4gKwkgKiAtIHdoZW4gcnVubmluZyBhcyBIeXBlci1WIGlzb2xh
dGVkIGd1ZXN0DQo+Pg0KPj4gCXdoZW4gcnVubmluZyBhcyBhIFNFVi1TTlAgZ3Vlc3Qgb24g
YSBIeXBlclYgd2l0aCB2VE9NIGVuYWJsZWQNCj4+DQo+PiB0aGF0J3MgYSBzaW5nbGUgY29u
ZGl0aW9uLg0KPj4NCj4+PiArCSAqIC0gd2hlbiBydW5uaW5nIGFzIFhlbiBQViBndWVzdA0K
Pj4+ICsJICogLSB3aGVuIHJ1bm5pbmcgYXMgVFNYIGd1ZXN0DQo+Pj4gKwkgKi8NCj4+PiAr
CWlmICghY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfR1VFU1RfU0VWX1NOUCkgJiYNCj4+PiAr
CSAgICAhaHZfaXNfaXNvbGF0aW9uX3N1cHBvcnRlZCgpICYmDQo+Pj4gKwkgICAgIWNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpICYmDQo+Pj4gKwkgICAgIWNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfVERYX0dVRVNUKSkNCj4+DQo+PiBJT1c6DQo+
Pg0KPj4gCWlmICghKGh2X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQoKSAmJiBjY19wbGF0Zm9y
bV9oYXMoQ0NfQVRUUl9HVUVTVF9TRVZfU05QKSkgJiYNCj4+IAkgICAgIWNwdV9mZWF0dXJl
X2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpICYmDQo+PiAJICAgICFjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX1REWF9HVUVTVCkpDQo+Pg0KPiANCj4gVGhhdCdzIGRvZXNu
J3Qgd29yay4gIEh5cGVyLVYgZ3Vlc3RzIHdpdGggdlRPTSBkb24ndCBoYXZlDQo+IENDX0FU
VFJfR1VFU1RfU0VWX1NOUC4NCg0KWWVhaCwgdGhlIGNvbmRpdGlvbiBuZWVkcyB0byBiZToN
Cg0KCWlmICghKGh2X2lzX2lzb2xhdGlvbl9zdXBwb3J0ZWQoKSB8fA0KCSAgICAgIGNjX3Bs
YXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX1NFVl9TTlApKSAmJg0KICAJICAgICFjcHVfZmVh
dHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBWKSAmJg0KICAJICAgICFjcHVfZmVhdHVy
ZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1REWF9HVUVTVCkpDQoNClRoaXMgaXMgZXF1aXZhbGVu
dCB0byB0aGUgY29uZGl0aW9uIGluIG15IHBhdGNoLg0KDQoNCkp1ZXJnZW4NCg==
--------------8Mta09tbVEiDwd0Ht5HYbqUv
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------8Mta09tbVEiDwd0Ht5HYbqUv--

--------------J1TEqymdWVu77qv6a003FTsv--

--------------Md06zI6py0rbr4ErFlFUbrdj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQ1aNAFAwAAAAAACgkQsN6d1ii/Ey/H
hAf9EMVpoWFSrPN8Yml5ch6C645wGuk/sswGU96acQuJle4XIb/FxgA6XOyGkZkAEKTyFyfXhTio
CItjPEqMAgDsjRPbXnUDn0EgsLRMKyNInL5CfBFrtx9VY4UeruNnGg+f/XY7gNIDbpoJAyn5Kiqx
UvxnXynsVVrWN0Mnj/PauS0e+4JF6P5R+Of36wp3ksq87aOfxZXrS6YlkcADwrl5+BoWl6bsQu2j
gS8iqz3u5iksF4+z1kF/XOGxbG9fHoia8FRB5O8fWPeAQRrfswySLsObnQNL4p6GqVf2gCgBBqsn
AAe6k7BdGYZwkTySYbGUbZ7MMSBz+9Vrf3pukXi4Pw==
=fftU
-----END PGP SIGNATURE-----

--------------Md06zI6py0rbr4ErFlFUbrdj--
