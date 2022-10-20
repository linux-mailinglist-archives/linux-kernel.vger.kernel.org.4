Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8B605678
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJTExf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTExc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:53:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7BB3742A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:53:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC78C1F383;
        Thu, 20 Oct 2022 04:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666241607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHbw/1F9p5A4QKdmH/L8YLPWfY6I0HOG47eZngBVF7Y=;
        b=mWZschLOb4arCOUUnfQYSTOtYyL+mLy6SNlBRbDRVclNBRLhqb2WjpMdaCM7UP6Pmjwa3d
        yVMylwDt5eZyT7vQDXwtB0B2daRsPzb+FD17If16V9Zkq3MMWPQT2iSIZQR/dv/g/gfKFo
        D0eNEUwzMCRoFIU+FROVt+h81aK4LSs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7509C139D2;
        Thu, 20 Oct 2022 04:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WLcFG0fUUGMrPwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 04:53:27 +0000
Message-ID: <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
Date:   Thu, 20 Oct 2022 06:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
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
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6Z9IqzVmO1FCdYZNmV6GEIvJ"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6Z9IqzVmO1FCdYZNmV6GEIvJ
Content-Type: multipart/mixed; boundary="------------8gx9Mr3w9Jfl0A2f8LewiR8N";
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
Message-ID: <7bbc19c8-3494-1770-d186-ce5a92d511aa@suse.com>
Subject: Re: [PATCH v4 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
References: <20221019095035.10823-1-xin3.li@intel.com>
 <20221019095035.10823-6-xin3.li@intel.com>
 <439a325f-6a00-845e-7850-43abfc60cd44@suse.com>
 <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>

--------------8gx9Mr3w9Jfl0A2f8LewiR8N
Content-Type: multipart/mixed; boundary="------------d3K7K7OddrwxW2pYQiJHq0QU"

--------------d3K7K7OddrwxW2pYQiJHq0QU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMTAuMjIgMTk6NDUsIExpLCBYaW4zIHdyb3RlOg0KPj4+ICtzdGF0aWMgaW5saW5l
IHZvaWQgX19pbml0IGxrZ3NfaW5pdCh2b2lkKSB7ICNpZmRlZg0KPj4+ICtDT05GSUdfUEFS
QVZJUlRfWFhMICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+Pj4gKwlpZiAoY3B1X2ZlYXR1cmVf
ZW5hYmxlZChYODZfRkVBVFVSRV9MS0dTKSkNCj4+PiArCQlwdl9vcHMuY3B1LmxvYWRfZ3Nf
aW5kZXggPSBuYXRpdmVfbGtnczsNCj4+DQo+PiBGb3IgdGhpcyB0byB3b3JrIGNvcnJlY3Rs
eSB3aGVuIHJ1bm5pbmcgYXMgYSBYZW4gUFYgZ3Vlc3QsIHlvdSBuZWVkIHRvIGFkZA0KPj4N
Cj4+IAlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX0xLR1MpOw0KPj4NCj4+IHRv
IHhlbl9pbml0X2NhcGFiaWxpdGllcygpIGluIGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYu
YywgYXMgb3RoZXJ3aXNlIHRoZSBYZW4NCj4+IHNwZWNpZmljIC5sb2FkX2dzX2luZGV4IHZl
Y3RvciB3aWxsIGJlIG92ZXJ3cml0dGVuLg0KPiANCj4gWWVhaCwgd2UgZGVmaW5pdGVseSBz
aG91bGQgYWRkIGl0IHRvIGRpc2FibGUgTEtHUyBpbiBhIFhlbiBQViBndWVzdC4NCj4gDQo+
IFNvIGRvZXMgaXQgbWVhbiB0aGF0IHRoZSBYZW4gUFYgdXNlcyBhIGJsYWNrIGxpc3QgZHVy
aW5nIGZlYXR1cmUgZGV0ZWN0aW9uPw0KPiBJZiB5ZXMgdGhlbiBuZXcgZmVhdHVyZXMgYXJl
IG9mdGVuIHJlcXVpcmVkIHRvIGJlIG1hc2tlZCB3aXRoIGFuIGV4cGxpY2l0DQo+IGNhbGwg
dG8gc2V0dXBfY2xlYXJfY3B1X2NhcC4NCj4gDQo+IFdvdWxkbid0IGEgd2hpdGUgbGlzdCBi
ZSBiZXR0ZXI/DQo+IFRoZW4gdGhlIGpvYiBpcyBtb3JlIGp1c3Qgb24gdGhlIFhlbiBQViBz
aWRlLCBhbmQgaXQgY2FuIHNlbGVjdGl2ZWx5IGVuYWJsZQ0KPiBhIG5ldyBmZWF0dXJlLCBz
b21ldGltZXMgd2l0aCBYZW4gUFYgc3BlY2lmaWMgaGFuZGxpbmcgY29kZSBhZGRlZC4NCg0K
VGhpcyBpcyBub3QgaG93IGl0IHdvcmtzLiBGZWF0dXJlIGRldGVjdGlvbiBpcyBnZW5lcmlj
IGNvZGUsIHNvIHdlJ2QgbmVlZCB0bw0KdHdlYWsgdGhhdCBmb3Igc3dpdGNoaW5nIHRvIGEg
d2hpdGVsaXN0Lg0KDQpBZGRpdGlvbmFsbHkgbW9zdCBmZWF0dXJlcyBkb24ndCByZXF1aXJl
IGFueSBYZW4gUFYgc3BlY2lmaWMgaGFuZGxpbmcuIFRoaXMgaXMNCm5lZWRlZCBmb3Igc29t
ZSBwYXJhdmlydHVhbGl6ZWQgcHJpdmlsZWdlZCBvcGVyYXRpb25zIG9ubHkuIFNvIHN3aXRj
aGluZyB0byBhDQp3aGl0ZWxpc3Qgd291bGQgYWRkIG1vcmUgZWZmb3J0Lg0KDQoNCkp1ZXJn
ZW4NCg0K
--------------d3K7K7OddrwxW2pYQiJHq0QU
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------d3K7K7OddrwxW2pYQiJHq0QU--

--------------8gx9Mr3w9Jfl0A2f8LewiR8N--

--------------6Z9IqzVmO1FCdYZNmV6GEIvJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNQ1EcFAwAAAAAACgkQsN6d1ii/Ey9h
/Af9FcxgFXkVx1Oj6BLllNdDNjXKnmYBnJ++6cjuIpcLEPB4Hdmx46aoItL73uxXQRpc3m//5VYl
/XFCru3r2nlq7BirzkeS6/fJu/ekum6yYaV+dXooLU2c3dTHjonPgWjtJU6MIIEaJCYwkROXK+Wx
K1dM1LK2dBA6CrmVOl0QDEkFs/d1juSSdvONjHeY67+OKgu/f4m6d9rGBukYtSMndizRNKT5RWj7
pSXpwYNhJGOIHodd4DEMhd2LAXlnFaF3p9eJZaIqOgP6GbwXvoGCsNO1QOuCiBEZaZaExvUXtXyl
YCx9oYlU3Z6tA/d7+d0CYeZ4NrDw4cw/1rTCoIMdSQ==
=KJiI
-----END PGP SIGNATURE-----

--------------6Z9IqzVmO1FCdYZNmV6GEIvJ--
