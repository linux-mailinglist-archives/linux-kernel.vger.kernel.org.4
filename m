Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9C694DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjBMRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBMRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:24:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0518B06
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:24:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 578AF1FEAA;
        Mon, 13 Feb 2023 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676309066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMGufvMzYvrkDBg3RM+U7Dytpf9CCuWhYPXuaL25o58=;
        b=OrKGyzXZctuOzhh0SswCw/zv7QIHDyPNXk2FQSLxF8K4POfxQS/tDFrV+092bxmp4Q2OV+
        LxsDdpJcqIiBf+85Va+x/tDbDtZaWPU3UdKiNK4VTjaIlDiSwVnfQaveKnaOKFouUpKh4D
        QttPn87ds1ZfsvSiuPQu0zyFPA/FM6M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAFAD138E6;
        Mon, 13 Feb 2023 17:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w/XaN0ly6mNkXwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 17:24:25 +0000
Message-ID: <4c53bfac-8751-9873-197b-38b9c0d05cb2@suse.com>
Date:   Mon, 13 Feb 2023 18:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Christian Kujau <lists@nerdbynature.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
 <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
 <BYAPR21MB1688F89BB288FDC8FCF7C760D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB1688F89BB288FDC8FCF7C760D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lezqEZSYG6gQSBEWDUYG0VcJ"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lezqEZSYG6gQSBEWDUYG0VcJ
Content-Type: multipart/mixed; boundary="------------d1U20E3eVVhOSIfiVz5eB2Ul";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Christian Kujau <lists@nerdbynature.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <4c53bfac-8751-9873-197b-38b9c0d05cb2@suse.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
 <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
 <BYAPR21MB1688F89BB288FDC8FCF7C760D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688F89BB288FDC8FCF7C760D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------d1U20E3eVVhOSIfiVz5eB2Ul
Content-Type: multipart/mixed; boundary="------------IibwjcrS2V28NKZAjyhSiA4X"

--------------IibwjcrS2V28NKZAjyhSiA4X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTg6MDEsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+DQo+PiBPbiAxMy4wMi4y
MyAxMjo0NiwgQ2hyaXN0aWFuIEt1amF1IHdyb3RlOg0KPj4+IE9uIE1vbiwgMTMgRmViIDIw
MjMsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+IE9uIDEwLjAyLjIzIDE5OjU5LCBMaW51
eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykgd3JvdGU6DQo+Pj4+
PiBIaSwgdGhpcyBpcyB5b3VyIExpbnV4IGtlcm5lbCByZWdyZXNzaW9uIHRyYWNrZXIuDQo+
Pj4+Pg0KPj4+Pj4gT24gMDkuMDIuMjMgMDg6MjIsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
Pj4+Pj4gQ29tbWl0IDkwYjkyNmU2OGY1MCAoIng4Ni9wYXQ6IEZpeCBwYXRfeF9tdHJyX3R5
cGUoKSBmb3IgTVRSUiBkaXNhYmxlZA0KPj4+Pj4+IGNhc2UiKSBoYXMgaW50cm9kdWNlZCBh
IHJlZ3Jlc3Npb24gd2l0aCBYZW4uDQo+Pj4+Pj4NCj4+Pj4+PiBSZXZlcnQgdGhlIHBhdGNo
Lg0KPj4+Pj4NCj4+Pj4+IFRoYXQgcmVncmVzc2lvbiB5b3UgcmVmZXIgdG8gaXMgYWZhaWNz
IG9uZSBJJ20gdHJhY2tpbmdbMV0gdGhhdCB3YXMNCj4+Pj4+IGludHJvZHVjZWQgdGhpcyBj
eWNsZS4gVGhhdCBtYWtlcyBtZSB3b25kZXI6IGNvdWxkIHRoaXMgcGF0Y2ggYmUgYXBwbGll
ZA0KPj4+Pj4gZGlyZWN0bHkgdG8gZml4IHRoZSBpc3N1ZSBxdWlja2x5PyBPciBhcmUgcGF0
Y2hlcyAxIHRvIDQgbmVlZGVkIGFzIHdlbGwNCj4+Pj4+IChvciB0aGUgd2hvbGUgc2VyaWVz
PykgdG8gYXZvaWQgb3RoZXIgcHJvYmxlbXM/DQo+Pj4+DQo+Pj4+IFBhdGNoZXMgMS00IGFy
ZSBuZWVkZWQsIHRvbywgYXMgb3RoZXJ3aXNlIHRoZSBpc3N1ZSBjbGFpbWVkIHRvIGJlIGZp
eGVkDQo+Pj4+IHdpdGggcGF0Y2ggNSB3b3VsZCBzaG93IHVwIGFnYWluLg0KPj4+DQo+Pj4g
VGhlIChsYXN0PykgLXJjOCB2ZXJzaW9uIHdhcyByZWxlYXNlZCB5ZXN0ZXJkYXkuIFdvdWxk
IGl0IGJlIHBvc3NpYmxlIHRvDQo+Pj4gaW5jbHVkZSBhdCBsZWFzdCAob25seSkgdGhlIHJl
dmVydCBpbiBtYWlubGluZSBzbyB0aGF0IDYuMiB3aWxsIGJlDQo+Pj4gcmVsZWFzZWQgd2l0
aCBhIHdvcmtpbmcgc3RvcmFnZSBjb25maWd1cmF0aW9uIHVuZGVyIFhlbj8NCj4+DQo+PiBI
bW0sIHRoaXMgd291bGQgbWFrZSBIeXBlci1WIFNFVi1TTlAgZ3Vlc3RzIHNsb3cgYWdhaW4u
DQo+Pg0KPj4gSSdtIG5vdCBjb21wbGV0ZWx5IGFnYWluc3QgaXQsIGJ1dCBPVE9IIEknbSBh
IGxpdHRsZSBiaXQgYmlhc2VkIGFzIHRoZQ0KPj4gbWFpbnRhaW5lciBvZiB0aGUgWGVuIGNv
ZGUuIDotKQ0KPj4NCj4+IE1pY2hhZWwsIHdvdWxkIHlvdSBzZWUgbWFqb3IgcHJvYmxlbXMg
d2l0aCBkb2luZyB0aGUgcmV2ZXJ0IGJlZm9yZSBoYXZpbmcNCj4+IHRoZSBmaW5hbCBwYXRj
aGVzIGZvciBmaXhpbmcgeW91ciBpc3N1ZSwgdG9vPw0KPj4NCj4gDQo+IEknbSBPSyB3aXRo
IGRvaW5nIHRoZSByZXZlcnQuICBJdCdzIHByb2JhYmx5IHRoZSByaWdodCB0cmFkZW9mZiBm
b3IgdGhlDQo+IGJyb2FkZXIgY29tbXVuaXR5IGJlY2F1c2UgdGhlIEh5cGVyLVYgdXNlIGNh
c2UgaXMgbW9yZSBuYXJyb3cgYW5kDQo+IHJlcXVpcmVzIG1vcmUgY3VyYXRpb24gZm9yIG90
aGVyIHJlYXNvbnMuICBUaGUgdXNlIGNhc2UgaXMgdGhlIEF6dXJlDQo+IHB1YmxpYyBjbG91
ZCwgYW5kIHdlIGNhbiBwcmV0dHkgbXVjaCBtYWtlIHN1cmUgdGhhdCBvbmUgb2YgdGhlIHNv
bHV0aW9ucw0KPiBpcyBhcHBsaWVkIHRvIGtlcm5lbHMgdXNlZCB3aXRoIFNFVi1TTlAgaW4g
dGhhdCBlbnZpcm9ubWVudC4NCg0KVGhhbmtzLg0KDQpCb3Jpcywgd291bGQgeW91IHRha2Ug
dGhlIHJldmVydCAocGF0Y2ggNSBvZiBteSBzZXJpZXMpIHZpYSB4ODYvdXJnZW50LCBwbGVh
c2U/DQoNCg0KSnVlcmdlbg0K
--------------IibwjcrS2V28NKZAjyhSiA4X
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IibwjcrS2V28NKZAjyhSiA4X--

--------------d1U20E3eVVhOSIfiVz5eB2Ul--

--------------lezqEZSYG6gQSBEWDUYG0VcJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPqckkFAwAAAAAACgkQsN6d1ii/Ey/h
jQf/XB4hL/3MDxMMBlgXtMyU0jKm2vbqoKNzTVxBRENNSCJFFVifrGfm7xpoZ+g3z06WI+EcNK/C
pRfNpelHDP4OAoiBNduw2021PA91q/BKmyRd0pcun2LNNYtg8BtVqd43lvyrXUWzUQQlgyCVTqmg
ospZWoaVDfTUB/cZPfQ2OuNEKO5+EAvK+TrntmwvMXYIuHIQ7gwwcs2ZEbf5n2/tszTxUUTwY1iJ
+WPqmpY1O/Mcx2L4h3UkXez2yAVYO37mcEzZqoYafEibeFUrtXxkYaklSYftIZrNHxsln6qdYBMT
9JIU15VH0KdoL2K2BNQK0oTzyZyYFpBzmDJR1JFWEQ==
=hOeE
-----END PGP SIGNATURE-----

--------------lezqEZSYG6gQSBEWDUYG0VcJ--
