Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2C6DDC15
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDKNbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:31:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9A2D48
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:31:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9CBD219E5;
        Tue, 11 Apr 2023 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681219867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xV7jhJFxZWn7Ig+UVJjEFVwdV2IV1V9AGELy5/h4F38=;
        b=QsCZeFPWlD0isazZwaFYJNolN+OFGq5Fi6ZFMTE+zdsBPc28ni5nhAYoZdkcHiuozRU4qp
        pGn45cqF9mSHDump0Rev96kLGpl8jmONc1PHJLJSs6fuqeZLVMJwmmHf8tclbvruhP2gmC
        L9yTrxRlCl5SgiOby9Qo3EOZGQ6G2qg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97D3A13519;
        Tue, 11 Apr 2023 13:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KdciIxthNWRlOAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 11 Apr 2023 13:31:07 +0000
Message-ID: <e1be08f8-3156-8b35-b8b0-cf0c80d1d28c@suse.com>
Date:   Tue, 11 Apr 2023 15:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MyrZKL7FlvAXqmF6fOFVyVOk"
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
--------------MyrZKL7FlvAXqmF6fOFVyVOk
Content-Type: multipart/mixed; boundary="------------gH070pLoPu7szx24cKQXFYL0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Michael Kelley <mikelley@microsoft.com>
Message-ID: <e1be08f8-3156-8b35-b8b0-cf0c80d1d28c@suse.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-5-jgross@suse.com>
 <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>
In-Reply-To: <20230411132040.GHZDVeqCqATbbgzdXK@fat_crate.local>

--------------gH070pLoPu7szx24cKQXFYL0
Content-Type: multipart/mixed; boundary="------------UcxKLwooq0mJXfHh2SOlU0nr"

--------------UcxKLwooq0mJXfHh2SOlU0nr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDQuMjMgMTU6MjAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBB
cHIgMDEsIDIwMjMgYXQgMDg6MzY6NDFBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFdoZW4gcnVubmluZyB2aXJ0dWFsaXplZCwgTVRSUiBhY2Nlc3MgY2FuIGJlIHJlZHVj
ZWQgKGUuZy4gaW4gWGVuIFBWDQo+PiBndWVzdHMgb3Igd2hlbiBydW5uaW5nIGFzIGEgU0VW
LVNOUCBndWVzdCB1bmRlciBIeXBlci1WKS4gVHlwaWNhbGx5DQo+PiB0aGUgaHlwZXJ2aXNv
ciB3aWxsIHJlc2V0IHRoZSBNVFJSIGZlYXR1cmUgaW4gQ1BVSUQgZGF0YSwgcmVzdWx0aW5n
DQo+PiBpbiBubyBNVFJSIG1lbW9yeSB0eXBlIGluZm9ybWF0aW9uIGJlaW5nIGF2YWlsYWJs
ZSBmb3IgdGhlIGtlcm5lbC4NCj4+DQo+PiBUaGlzIGhhcyB0dXJuZWQgb3V0IHRvIHJlc3Vs
dCBpbiBwcm9ibGVtczoNCj4gDQo+IExldCdzIGFkZCB0aGUgbGlua3MgdG8gdGhvc2UgcHJv
YmxlbXM6DQo+IA0KPj4gLSBIeXBlci1WIFNFVi1TTlAgZ3Vlc3RzIHVzaW5nIHVuY2FjaGVk
IG1hcHBpbmdzIHdoZXJlIHRoZXkgc2hvdWxkbid0DQo+IA0KPiBJIGNhbid0IGZpbmQgTWlj
aGFlbCdzIG9yaWdpbmFsIHJlcG9ydCwgZG8geW91IGhhdmUgYSBsaW5rPw0KDQpEWU0gDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0JZQVBSMjFNQjE2ODgzQUJDMTg2NTY2QkQ0
RDJBMTQ1MUQ3RkU5QEJZQVBSMjFNQjE2ODgubmFtcHJkMjEucHJvZC5vdXRsb29rLmNvbS8g
DQo/DQoNCj4gDQo+PiAtIFhlbiBQViBkb20wIG1hcHBpbmcgbWVtb3J5IGFzIFdCIHdoaWNo
IHNob3VsZCBiZSBVQy0gaW5zdGVhZA0KPiANCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzRmZTk1NDFlLTRkNGMtMmIyYS1mOGM4LTJkMzRhNzI4NDkzMEBuZXJkYnlu
YXR1cmUuZGUvDQo+IA0KPj4NCj4+IFNvbHZlIHRob3NlIHByb2JsZW1zIGJ5IHN1cHBvcnRp
bmcgdG8gc2V0IGEgc3RhdGljIE1UUlIgc3RhdGUsDQo+IA0KPiBzL2J5IHN1cHBvcnRpbmcg
dG8gc2V0IGEvYWxsb3dpbmcgYW4gTVRSUiBzdGF0aWMgc3RhdGUgb3ZlcnJpZGUvDQo+IA0K
Pj4gK3ZvaWQgbXRycl9vdmVyd3JpdGVfc3RhdGUoc3RydWN0IG10cnJfdmFyX3JhbmdlICp2
YXIsIHVuc2lnbmVkIGludCBudW1fdmFyLA0KPj4gKwkJCSAgbXRycl90eXBlIGRlZl90eXBl
KQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGk7DQo+PiArDQo+PiArCS8qIE9ubHkgYWxs
b3dlZCB0byBiZSBjYWxsZWQgb25jZSBiZWZvcmUgbXRycl9icF9pbml0KCkuICovDQo+PiAr
CWlmIChXQVJOX09OKG10cnJfc3RhdGVfc2V0KSkNCj4gDQo+IFdBUk5fT05fT05DRSgpIGlz
IHByb2JhYmx5IGJldHRlci4NCg0KSWYgeW91IGxpa2UgdGhhdCBiZXR0ZXIgKEkgZG9uJ3Qg
c2VlIHRoZSByZWFsIGJlbmVmaXQsIGFzIHNvbWV0aGluZyB3b3VsZA0KYmUgc2V2ZXJlbHkg
YnJva2VuIGlmIHRoaXMgdHJpZ2dlcnMgbW9yZSB0aGFuIG9uY2UsIGJ1dCBJIGRvbid0IHJl
YWxseQ0KbWluZCkuDQoNCj4gDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCS8qIE9ubHkg
YWxsb3dlZCB3aGVuIHJ1bm5pbmcgdmlydHVhbGl6ZWQuICovDQo+PiArCWlmICghY3B1X2Zl
YXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9IWVBFUlZJU09SKSkNCj4+ICsJCXJldHVybjsN
Cj4+ICsNCj4+ICsJLyoNCj4+ICsJICogT25seSBhbGxvd2VkIGZvciBzcGVjaWFsIHZpcnR1
YWxpemF0aW9uIGNhc2VzOg0KPj4gKwkgKiAtIHdoZW4gcnVubmluZyBhcyBTRVYtU05QIGd1
ZXN0DQo+PiArCSAqIC0gd2hlbiBydW5uaW5nIGFzIEh5cGVyLVYgaXNvbGF0ZWQgZ3Vlc3QN
Cj4gDQo+IAl3aGVuIHJ1bm5pbmcgYXMgYSBTRVYtU05QIGd1ZXN0IG9uIGEgSHlwZXJWIHdp
dGggdlRPTSBlbmFibGVkDQo+IA0KPiB0aGF0J3MgYSBzaW5nbGUgY29uZGl0aW9uLg0KPiAN
Cj4+ICsJICogLSB3aGVuIHJ1bm5pbmcgYXMgWGVuIFBWIGd1ZXN0DQo+PiArCSAqIC0gd2hl
biBydW5uaW5nIGFzIFRTWCBndWVzdA0KPj4gKwkgKi8NCj4+ICsJaWYgKCFjY19wbGF0Zm9y
bV9oYXMoQ0NfQVRUUl9HVUVTVF9TRVZfU05QKSAmJg0KPj4gKwkgICAgIWh2X2lzX2lzb2xh
dGlvbl9zdXBwb3J0ZWQoKSAmJg0KPj4gKwkgICAgIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2
X0ZFQVRVUkVfWEVOUFYpICYmDQo+PiArCSAgICAhY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZf
RkVBVFVSRV9URFhfR1VFU1QpKQ0KPiANCj4gSU9XOg0KPiANCj4gCWlmICghKGh2X2lzX2lz
b2xhdGlvbl9zdXBwb3J0ZWQoKSAmJiBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9T
RVZfU05QKSkgJiYNCj4gCSAgICAhY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9Y
RU5QVikgJiYNCj4gCSAgICAhY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhf
R1VFU1QpKQ0KDQpPa2F5Lg0KDQoNCkp1ZXJnZW4NCg0K
--------------UcxKLwooq0mJXfHh2SOlU0nr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------UcxKLwooq0mJXfHh2SOlU0nr--

--------------gH070pLoPu7szx24cKQXFYL0--

--------------MyrZKL7FlvAXqmF6fOFVyVOk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQ1YRoFAwAAAAAACgkQsN6d1ii/Ey/G
tgf+P49ayTZ60Tfmf5dIkEGVl+sH8FGFY3sKn2ZRzY1yQUNxmu3MMdXAZL8jafGLIyOcrOXp3wrc
Q0U5uvcTa91J+geXMFFc7Z7lX6cyKod1rAqoKGcUSQSjmUs9TgFHN+0ZCzRH/weA+zWD19V5uTIy
VKZW/CReW4DlVFggT48g5okMDGoAQcLWyu9Kh4q/PBdXi9UXpSgICdwR7V6Nb/9BhqUpIOWd8Wkn
CQB5bLzz/K/91kUwGUI4zNh9MrDxvhCrKlwN5iY37JCI+spIVozNc/0/Q/UnULJyBm68uQlLrVBp
ytmBKHI8s6o545Q7mTfxTsNG09Ay/nn0vi57X9bXXA==
=kuyh
-----END PGP SIGNATURE-----

--------------MyrZKL7FlvAXqmF6fOFVyVOk--
