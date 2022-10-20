Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A107605723
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJTGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTGI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:08:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5DF1B2BAF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:08:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CF5422B71;
        Thu, 20 Oct 2022 06:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666246103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72mBgHOA9LcOrxCyK7/mMo/XDIR1h7/199/pFLomj6Y=;
        b=CFK6N9e7gxvydnqGqg1y5IaoOYF92MhQqSsv4ySIu/e+5stLIof+C/dZQc0XGr7AW9q/2k
        E/Mx1WpxOowLz5udGjSlOZdraG+g3EzCw2+97tHO0oQe4enlMcrgeaR0/+PMnSz/aabB8m
        Q2a2tZUbg0FYx1bX0nXGaJsqAH8h2g4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BF6E13A84;
        Thu, 20 Oct 2022 06:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oY9BCdflUGOrXwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 06:08:23 +0000
Message-ID: <a7e33fc8-3333-02a3-903b-ae6ffbf09f3d@suse.com>
Date:   Thu, 20 Oct 2022 08:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
 <BN6PR1101MB21614EE46D700C24E7D77E8FA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
In-Reply-To: <BN6PR1101MB21614EE46D700C24E7D77E8FA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------I49ruxa47Pq3N4Z0S6TmIeRT"
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
--------------I49ruxa47Pq3N4Z0S6TmIeRT
Content-Type: multipart/mixed; boundary="------------9M9hxTDJRweZPWtnl9vgnxDO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Li, Xin3" <xin3.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "brgerst@gmail.com" <brgerst@gmail.com>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>
Message-ID: <a7e33fc8-3333-02a3-903b-ae6ffbf09f3d@suse.com>
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
 <BN6PR1101MB21614EE46D700C24E7D77E8FA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR1101MB21614EE46D700C24E7D77E8FA82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>

--------------9M9hxTDJRweZPWtnl9vgnxDO
Content-Type: multipart/mixed; boundary="------------IGqvKlAHS1Y0dWOJWy0ASIit"

--------------IGqvKlAHS1Y0dWOJWy0ASIit
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMTAuMjIgMDc6NTgsIExpLCBYaW4zIHdyb3RlOg0KPj4gT24gMTkuMTAuMjIgMTk6
NDUsIExpLCBYaW4zIHdyb3RlOg0KPj4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2luaXQg
bGtnc19pbml0KHZvaWQpIHsgI2lmZGVmDQo+Pj4+PiArQ09ORklHX1BBUkFWSVJUX1hYTCAj
aWZkZWYgQ09ORklHX1g4Nl82NA0KPj4+Pj4gKwlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChY
ODZfRkVBVFVSRV9MS0dTKSkNCj4+Pj4+ICsJCXB2X29wcy5jcHUubG9hZF9nc19pbmRleCA9
IG5hdGl2ZV9sa2dzOw0KPj4+Pg0KPj4+PiBGb3IgdGhpcyB0byB3b3JrIGNvcnJlY3RseSB3
aGVuIHJ1bm5pbmcgYXMgYSBYZW4gUFYgZ3Vlc3QsIHlvdSBuZWVkDQo+Pj4+IHRvIGFkZA0K
Pj4+Pg0KPj4+PiAJc2V0dXBfY2xlYXJfY3B1X2NhcChYODZfRkVBVFVSRV9MS0dTKTsNCj4+
Pj4NCj4+Pj4gdG8geGVuX2luaXRfY2FwYWJpbGl0aWVzKCkgaW4gYXJjaC94ODYveGVuL2Vu
bGlnaHRlbl9wdi5jLCBhcw0KPj4+PiBvdGhlcndpc2UgdGhlIFhlbiBzcGVjaWZpYyAubG9h
ZF9nc19pbmRleCB2ZWN0b3Igd2lsbCBiZSBvdmVyd3JpdHRlbi4NCj4+Pg0KPj4+IFllYWgs
IHdlIGRlZmluaXRlbHkgc2hvdWxkIGFkZCBpdCB0byBkaXNhYmxlIExLR1MgaW4gYSBYZW4g
UFYgZ3Vlc3QuDQo+Pj4NCj4+PiBTbyBkb2VzIGl0IG1lYW4gdGhhdCB0aGUgWGVuIFBWIHVz
ZXMgYSBibGFjayBsaXN0IGR1cmluZyBmZWF0dXJlIGRldGVjdGlvbj8NCj4+PiBJZiB5ZXMg
dGhlbiBuZXcgZmVhdHVyZXMgYXJlIG9mdGVuIHJlcXVpcmVkIHRvIGJlIG1hc2tlZCB3aXRo
IGFuDQo+Pj4gZXhwbGljaXQgY2FsbCB0byBzZXR1cF9jbGVhcl9jcHVfY2FwLg0KPj4+DQo+
Pj4gV291bGRuJ3QgYSB3aGl0ZSBsaXN0IGJlIGJldHRlcj8NCj4+PiBUaGVuIHRoZSBqb2Ig
aXMgbW9yZSBqdXN0IG9uIHRoZSBYZW4gUFYgc2lkZSwgYW5kIGl0IGNhbiBzZWxlY3RpdmVs
eQ0KPj4+IGVuYWJsZSBhIG5ldyBmZWF0dXJlLCBzb21ldGltZXMgd2l0aCBYZW4gUFYgc3Bl
Y2lmaWMgaGFuZGxpbmcgY29kZSBhZGRlZC4NCj4+DQo+PiBUaGlzIGlzIG5vdCBob3cgaXQg
d29ya3MuIEZlYXR1cmUgZGV0ZWN0aW9uIGlzIGdlbmVyaWMgY29kZSwgc28gd2UnZCBuZWVk
IHRvDQo+PiB0d2VhayB0aGF0IGZvciBzd2l0Y2hpbmcgdG8gYSB3aGl0ZWxpc3QuDQo+Pg0K
PiANCj4gWWVzLCBhIFhlbiBQViBndWVzdCBpcyBiYXNpY2FsbHkgYSBMaW51eCBzeXN0ZW0u
ICBIb3dldmVyIElJUkMsIHRoZSBYZW4gUFYNCj4gQ1BVSUQgaXMgcGFyYS12aXJ0dWFsaXpl
ZCwgc28gaXQncyBYZW4gaHlwZXJ2aXNvcidzIHJlc3BvbnNpYmlsaXR5IHRvIGRlY2lkZQ0K
PiBmZWF0dXJlcyBleHBvc2VkIHRvIGEgWGVuIFBWIGd1ZXN0LiAgTm8/DQoNCkluIHRoZW9y
eSB5b3UgYXJlIHJpZ2h0LCBvZiBjb3Vyc2UuDQoNCk9UT0ggdGhlIFhlbiBQViBpbnRlcmZh
Y2UgaGFzIGEgbG9uZyBhbmQgY29tcGxpY2F0ZWQgaGlzdG9yeSwgYW5kIHdlIGhhdmUgdG8N
CmRlYWwgd2l0aCBvbGQgaHlwZXJ2aXNvciB2ZXJzaW9ucywgdG9vLg0KDQo+PiBBZGRpdGlv
bmFsbHkgbW9zdCBmZWF0dXJlcyBkb24ndCByZXF1aXJlIGFueSBYZW4gUFYgc3BlY2lmaWMg
aGFuZGxpbmcuIFRoaXMgaXMNCj4+IG5lZWRlZCBmb3Igc29tZSBwYXJhdmlydHVhbGl6ZWQg
cHJpdmlsZWdlZCBvcGVyYXRpb25zIG9ubHkuIFNvIHN3aXRjaGluZyB0byBhDQo+PiB3aGl0
ZWxpc3Qgd291bGQgYWRkIG1vcmUgZWZmb3J0Lg0KPj4NCj4gDQo+IExLR1MgaXMgYWxsb3dl
ZCBvbmx5IGluIHJpbmcgMCwgdGh1cyBvbmx5IFhlbiBoeXBlcnZpc29yIGNvdWxkIHVzZSBp
dC4NCg0KUmlnaHQsIGl0IHdvdWxkIGJlIG9uZSBvZiB0aGUgZmVhdHVyZXMgd2hlcmUgYSB3
aGl0ZWxpc3Qgd291bGQgYmUgbmljZS4NCg0KT1RPSCB0b2RheSBvbmx5IDExIGZlYXR1cmVz
IG5lZWQgc3BlY2lhbCBoYW5kbGluZyBpbiBYZW4gUFYgZ3Vlc3RzLCB3aGlsZQ0KdGhlIHJl
c3Qgb2YgbW9yZSB0aGFuIDMwMCBmZWF0dXJlcyBkb2Vzbid0Lg0KDQoNCkp1ZXJnZW4NCg==

--------------IGqvKlAHS1Y0dWOJWy0ASIit
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IGqvKlAHS1Y0dWOJWy0ASIit--

--------------9M9hxTDJRweZPWtnl9vgnxDO--

--------------I49ruxa47Pq3N4Z0S6TmIeRT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNQ5dYFAwAAAAAACgkQsN6d1ii/Ey/S
+Qf/e1GZLwcnYSjvIIyTNoYuMZiEuiKRrP7mjYoqz9quQ2j3XD9bs+ZTsqkdVnQ3+CGjswZx8i20
m1egxMzJ4OEve5HC0qf8zbm6Re6Md9QfVLXVqzMGTXGDbCz+B84WO4qPDn+0g9ujZi88VSlDP8I6
N0ITlcZgo9dDLNqkVq2yFwsLDIuQhTVGknxlMly+UU79sdXrhWkSFLQYFJWunti8hEB5nLX5DLoE
Ojf6vZY/UX+u0tS+f3nIthggFTXCMe7WsXHnFH0G7lSJzXfJnh2O/OQ3YqwpPpW6SHpUUTgVaQMm
ZE6S+IUNZ24uarYLFr3iwVezciZF+9zPZpM025iuiw==
=fXK0
-----END PGP SIGNATURE-----

--------------I49ruxa47Pq3N4Z0S6TmIeRT--
