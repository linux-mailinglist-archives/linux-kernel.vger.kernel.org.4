Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52CB6C9B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjC0Fog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjC0Fod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:44:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD54C2B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:44:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACBA11FD8E;
        Mon, 27 Mar 2023 05:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679895870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MklHkeIeOj7c0UoSijNLsxcj/Wfg8tEABlLMoRZnQGk=;
        b=gEHo+psr9KrpDSd4efYI/lKi67++lvej1gH7cQT/AEC8guZKiN4vL/ajR3K2ez4wRiITTy
        LaAaIGJr88BNMO3fvPp4nfOKFM6q0g6IHruhrMnyi+LvixFAtDTYD+Gcx6G/uZgBnCqtwe
        G7zkndKs+VvXTHPXhpPgXXSrsY0Ewto=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70B6E13596;
        Mon, 27 Mar 2023 05:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vvgHGj4tIWTxfAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 27 Mar 2023 05:44:30 +0000
Message-ID: <ef53ce07-6d7e-efbd-0301-4984297c0f5b@suse.com>
Date:   Mon, 27 Mar 2023 07:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <20230326220520.GJZCDBoPI+YhN5RUDg@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230326220520.GJZCDBoPI+YhN5RUDg@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AoK6mdpyc6unzP30H1pJUPPi"
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
--------------AoK6mdpyc6unzP30H1pJUPPi
Content-Type: multipart/mixed; boundary="------------8H5tsXSUJQsiI4iWc5h5fy5S";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ef53ce07-6d7e-efbd-0301-4984297c0f5b@suse.com>
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <20230326220520.GJZCDBoPI+YhN5RUDg@fat_crate.local>
In-Reply-To: <20230326220520.GJZCDBoPI+YhN5RUDg@fat_crate.local>

--------------8H5tsXSUJQsiI4iWc5h5fy5S
Content-Type: multipart/mixed; boundary="------------q7UY4THjMAxVe0ip3WycktKc"

--------------q7UY4THjMAxVe0ip3WycktKc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDMuMjMgMDA6MDUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBN
YXIgMDYsIDIwMjMgYXQgMDU6MzQ6MjBQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFRoZSBtdHJyX3ZhbHVlW10gYXJyYXkgaXMgYSBzdGF0aWMgdmFyaWFibGUsIHdoaWNo
IGlzIHVzZWQgb25seSBpbiBhDQo+PiBmZXcgY29uZmlndXJhdGlvbnMuIENvbnN1bWluZyA2
a0IgaXMgcmlkaWN1bG91cyBmb3IgdGhpcyBjYXNlLA0KPiANCj4gQWgsIHRoYXQgc3RydWN0
IG10cnJfdmFsdWUgaXMgb2Ygc2l6ZSAyNCBkdWUgdG8gdGhhdCBmaXJzdCBtZW1iZXINCj4g
bXRycl90eXBlIGdldHRpbmcgcGFkZGVkIGV2ZW4gaWYgaXQgaXMgYSB1OC4NCj4gDQo+PiBl
c3BlY2lhbGx5IGFzIHRoZSBhcnJheSBkb2Vzbid0IG5lZWQgdG8gYmUgdGhhdCBsYXJnZSBh
bmQgaXQgY2FuIGVhc2lseQ0KPj4gYmUgYWxsb2NhdGVkIGR5bmFtaWNhbGx5Lg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0t
LQ0KPj4gICBhcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jIHwgMyArKy0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jIGIvYXJjaC94
ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPj4gaW5kZXggMGM4Mzk5MDUwMWY1Li41MGNk
MjI4N2I2ZTEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRy
ci5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvbXRyci5jDQo+PiBAQCAt
NTgxLDcgKzU4MSw3IEBAIHN0cnVjdCBtdHJyX3ZhbHVlIHsNCj4+ICAgCXVuc2lnbmVkIGxv
bmcJbHNpemU7DQo+PiAgIH07DQo+PiAgIA0KPj4gLXN0YXRpYyBzdHJ1Y3QgbXRycl92YWx1
ZSBtdHJyX3ZhbHVlW01UUlJfTUFYX1ZBUl9SQU5HRVNdOw0KPj4gK3N0YXRpYyBzdHJ1Y3Qg
bXRycl92YWx1ZSAqbXRycl92YWx1ZTsNCj4+ICAgDQo+PiAgIHN0YXRpYyBpbnQgbXRycl9z
YXZlKHZvaWQpDQo+PiAgIHsNCj4+IEBAIC03NTAsNiArNzUwLDcgQEAgc3RhdGljIGludCBf
X2luaXQgbXRycl9pbml0X2ZpbmlhbGl6ZSh2b2lkKQ0KPj4gICAJICogVEJEOiBpcyB0aGVy
ZSBhbnkgc3lzdGVtIHdpdGggc3VjaCBDUFUgd2hpY2ggc3VwcG9ydHMNCj4+ICAgCSAqIHN1
c3BlbmQvcmVzdW1lPyBJZiBubywgd2Ugc2hvdWxkIHJlbW92ZSB0aGUgY29kZS4NCj4+ICAg
CSAqLw0KPj4gKwltdHJyX3ZhbHVlID0ga2NhbGxvYyhudW1fdmFyX3Jhbmdlcywgc2l6ZW9m
KCptdHJyX3ZhbHVlKSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBQbHMgcHV0IHRoYXQgb3ZlciB0
aGUgY29tbWVudC4NCj4gDQo+IEFsc28sIHlvdSBuZWVkIHRvIGhhbmRsZSBrY2FsbG9jKCkg
cmV0dXJuaW5nIGFuIGVycm9yLg0KDQpPa2F5Lg0KDQoNCkp1ZXJnZW4NCg0K
--------------q7UY4THjMAxVe0ip3WycktKc
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------q7UY4THjMAxVe0ip3WycktKc--

--------------8H5tsXSUJQsiI4iWc5h5fy5S--

--------------AoK6mdpyc6unzP30H1pJUPPi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQhLT4FAwAAAAAACgkQsN6d1ii/Ey+d
NAf/SSLg9/xLe2DwUPpETCviL3KtABBgtBPm3AgbN1G7mU2bc4D1fK8L4wE2XTeXv7ouuoQzoaO3
QnkZ4bGWPvnvscUBUxa3TCnkldwheF8thgg61Kp+EC16N/FHeuhS8GqZEd4RWDXIN6x6ZAkZfsUn
5RbGQ6dS0VRTnSIBWYgqZqoxH0Nw1GUfiazzR3eVi4gi6zIswSvzW74lSltNM88OiqVW2W6LhoBX
HdAJERyzSiBUOSx8vRvYNfR6jQjYScATFCjCHrn3t644WxwtuCVV/JrYrdR2FsDTdtQM1w4PxCWf
NvZL6UlVgHcNwhnwJN+Q8oZYHJ+oAboqPReKa7u+pw==
=15Y0
-----END PGP SIGNATURE-----

--------------AoK6mdpyc6unzP30H1pJUPPi--
