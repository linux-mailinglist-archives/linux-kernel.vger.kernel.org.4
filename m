Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA56FAF97
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEHMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjEHMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:02:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7BA47569
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:59:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A8D122094;
        Mon,  8 May 2023 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683547103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5la5HdDyFDWRwDuAjJZPMu94UDPo4M8jI+4gdZynGQ=;
        b=RwTGeKjh8QjmX/DSmTvaAt9qy0B+poou0f6w4bY6TP25Py4A/HxKGRfjUnqvVtyqkZ5at3
        DGERyS1S0dGc9arJRsZ6pqidf1L3IWvoYgmkC6gLRbYXnIt8OtNKZ6fkUPHATLiYEUr81X
        CZ19g4i6SJSq8G+VLsSoIOCqy6dDlyg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0748F1346B;
        Mon,  8 May 2023 11:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tuUfAN/jWGS3PAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 08 May 2023 11:58:23 +0000
Message-ID: <63321442-ee0d-c525-ba20-e99cf135399c@suse.com>
Date:   Mon, 8 May 2023 13:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 15/22] xen/pvcalls: Use alloc_ordered_workqueue() to
 create ordered workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-16-tj@kernel.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230421025046.4008499-16-tj@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Dglk4qYyyprX0NlIxjCYwpTm"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Dglk4qYyyprX0NlIxjCYwpTm
Content-Type: multipart/mixed; boundary="------------sf1MvrCR4PwyBby3JUNqu6Sc";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org
Message-ID: <63321442-ee0d-c525-ba20-e99cf135399c@suse.com>
Subject: Re: [PATCH 15/22] xen/pvcalls: Use alloc_ordered_workqueue() to
 create ordered workqueues
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-16-tj@kernel.org>
In-Reply-To: <20230421025046.4008499-16-tj@kernel.org>

--------------sf1MvrCR4PwyBby3JUNqu6Sc
Content-Type: multipart/mixed; boundary="------------NFpaZFlUybo8IS9YTRCX05u6"

--------------NFpaZFlUybo8IS9YTRCX05u6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDQuMjMgMDQ6NTAsIFRlanVuIEhlbyB3cm90ZToNCj4gQkFDS0dST1VORA0KPiA9
PT09PT09PT09DQo+IA0KPiBXaGVuIG11bHRpcGxlIHdvcmsgaXRlbXMgYXJlIHF1ZXVlZCB0
byBhIHdvcmtxdWV1ZSwgdGhlaXIgZXhlY3V0aW9uIG9yZGVyDQo+IGRvZXNuJ3QgbWF0Y2gg
dGhlIHF1ZXVlaW5nIG9yZGVyLiBUaGV5IG1heSBnZXQgZXhlY3V0ZWQgaW4gYW55IG9yZGVy
IGFuZA0KPiBzaW11bHRhbmVvdXNseS4gV2hlbiBmdWxseSBzZXJpYWxpemVkIGV4ZWN1dGlv
biAtIG9uZSBieSBvbmUgaW4gdGhlIHF1ZXVlaW5nDQo+IG9yZGVyIC0gaXMgbmVlZGVkLCBh
biBvcmRlcmVkIHdvcmtxdWV1ZSBzaG91bGQgYmUgdXNlZCB3aGljaCBjYW4gYmUgY3JlYXRl
ZA0KPiB3aXRoIGFsbG9jX29yZGVyZWRfd29ya3F1ZXVlKCkuDQo+IA0KPiBIb3dldmVyLCBh
bGxvY19vcmRlcmVkX3dvcmtxdWV1ZSgpIHdhcyBhIGxhdGVyIGFkZGl0aW9uLiBCZWZvcmUg
aXQsIGFuDQo+IG9yZGVyZWQgd29ya3F1ZXVlIGNvdWxkIGJlIG9idGFpbmVkIGJ5IGNyZWF0
aW5nIGFuIFVOQk9VTkQgd29ya3F1ZXVlIHdpdGgNCj4gQG1heF9hY3RpdmU9PTEuIFRoaXMg
b3JpZ2luYWxseSB3YXMgYW4gaW1wbGVtZW50YXRpb24gc2lkZS1lZmZlY3Qgd2hpY2ggd2Fz
DQo+IGJyb2tlbiBieSA0YzE2YmQzMjdjNzQgKCJ3b3JrcXVldWU6IHJlc3RvcmUgV1FfVU5C
T1VORC9tYXhfYWN0aXZlPT0xIHRvIGJlDQo+IG9yZGVyZWQiKS4gQmVjYXVzZSB0aGVyZSB3
ZXJlIHVzZXJzIHRoYXQgZGVwZW5kZWQgb24gdGhlIG9yZGVyZWQgZXhlY3V0aW9uLA0KPiA1
YzAzMzhjNjg3MDYgKCJ3b3JrcXVldWU6IHJlc3RvcmUgV1FfVU5CT1VORC9tYXhfYWN0aXZl
PT0xIHRvIGJlIG9yZGVyZWQiKQ0KPiBtYWRlIHdvcmtxdWV1ZSBhbGxvY2F0aW9uIHBhdGgg
dG8gaW1wbGljaXRseSBwcm9tb3RlIFVOQk9VTkQgd29ya3F1ZXVlcyB3Lw0KPiBAbWF4X2Fj
dGl2ZT09MSB0byBvcmRlcmVkIHdvcmtxdWV1ZXMuDQo+IA0KPiBXaGlsZSB0aGlzIGhhcyB3
b3JrZWQgb2theSwgb3ZlcmxvYWRpbmcgdGhlIFVOQk9VTkQgYWxsb2NhdGlvbiBpbnRlcmZh
Y2UNCj4gdGhpcyB3YXkgY3JlYXRlcyBvdGhlciBpc3N1ZXMuIEl0J3MgZGlmZmljdWx0IHRv
IHRlbGwgd2hldGhlciBhIGdpdmVuDQo+IHdvcmtxdWV1ZSBhY3R1YWxseSBuZWVkcyB0byBi
ZSBvcmRlcmVkIGFuZCB1c2VycyB0aGF0IGxlZ2l0aW1hdGVseSB3YW50IGENCj4gbWluIGNv
bmN1cnJlbmN5IGxldmVsIHdxIHVuZXhwZWN0ZWRseSBnZXRzIGFuIG9yZGVyZWQgb25lIGlu
c3RlYWQuIFdpdGgNCj4gcGxhbm5lZCBVTkJPVU5EIHdvcmtxdWV1ZSB1cGRhdGVzIHRvIGlt
cHJvdmUgZXhlY3V0aW9uIGxvY2FsaXR5IGFuZCBtb3JlDQo+IHByZXZhbGVuY2Ugb2YgY2hp
cGxldCBkZXNpZ25zIHdoaWNoIGNhbiBiZW5lZml0IGZyb20gc3VjaCBpbXByb3ZlbWVudHMs
IHRoaXMNCj4gaXNuJ3QgYSBzdGF0ZSB3ZSB3YW5uYSBiZSBpbiBmb3JldmVyLg0KPiANCj4g
VGhpcyBwYXRjaCBzZXJpZXMgYXVkaXRzIGFsbCBjYWxsc2l0ZXMgdGhhdCBjcmVhdGUgYW4g
VU5CT1VORCB3b3JrcXVldWUgdy8NCj4gQG1heF9hY3RpdmU9PTEgYW5kIGNvbnZlcnRzIHRo
ZW0gdG8gYWxsb2Nfb3JkZXJlZF93b3JrcXVldWUoKSBhcyBuZWNlc3NhcnkuDQo+IA0KPiBX
SEFUIFRPIExPT0sgRk9SDQo+ID09PT09PT09PT09PT09PT0NCj4gDQo+IFRoZSBjb252ZXJz
aW9ucyBhcmUgZnJvbQ0KPiANCj4gICAgYWxsb2Nfd29ya3F1ZXVlKFdRX1VOQk9VTkQgfCBm
bGFncywgMSwgYXJncy4uKQ0KPiANCj4gdG8NCj4gDQo+ICAgIGFsbG9jX29yZGVyZWRfd29y
a3F1ZXVlKGZsYWdzLCBhcmdzLi4uKQ0KPiANCj4gd2hpY2ggZG9uJ3QgY2F1c2UgYW55IGZ1
bmN0aW9uYWwgY2hhbmdlcy4gSWYgeW91IGtub3cgdGhhdCBmdWxseSBvcmRlcmVkDQo+IGV4
ZWN1dGlvbiBpcyBub3QgbmNlc3NhcnksIHBsZWFzZSBsZXQgbWUga25vdy4gSSdsbCBkcm9w
IHRoZSBjb252ZXJzaW9uIGFuZA0KPiBpbnN0ZWFkIGFkZCBhIGNvbW1lbnQgbm90aW5nIHRo
ZSBmYWN0IHRvIHJlZHVjZSBjb25mdXNpb24gd2hpbGUgY29udmVyc2lvbg0KPiBpcyBpbiBw
cm9ncmVzcy4NCj4gDQo+IElmIHlvdSBhcmVuJ3QgZnVsbHkgc3VyZSwgaXQncyBjb21wbGV0
ZWx5IGZpbmUgdG8gbGV0IHRoZSBjb252ZXJzaW9uDQo+IHRocm91Z2guIFRoZSBiZWhhdmlv
ciB3aWxsIHN0YXkgZXhhY3RseSB0aGUgc2FtZSBhbmQgd2UgY2FuIGFsd2F5cw0KPiByZWNv
bnNpZGVyIGxhdGVyLg0KPiANCj4gQXMgdGhlcmUgYXJlIGZvbGxvdy11cCB3b3JrcXVldWUg
Y29yZSBjaGFuZ2VzLCBJJ2QgcmVhbGx5IGFwcHJlY2lhdGUgaWYgdGhlDQo+IHBhdGNoIGNh
biBiZSByb3V0ZWQgdGhyb3VnaCB0aGUgd29ya3F1ZXVlIHRyZWUgdy8geW91ciBhY2tzLiBU
aGFua3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+
DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IENjOiBTdGVmYW5v
IFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+DQo+IENjOiBPbGVrc2FuZHIg
VHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQo+IENjOiB4ZW4t
ZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCg0KQWNrZWQtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------NFpaZFlUybo8IS9YTRCX05u6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------NFpaZFlUybo8IS9YTRCX05u6--

--------------sf1MvrCR4PwyBby3JUNqu6Sc--

--------------Dglk4qYyyprX0NlIxjCYwpTm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRY494FAwAAAAAACgkQsN6d1ii/Ey/7
Bwf+OJXAmz1RWO7eG2WkDpbZH+arNDyS1afUPhFyYrSPPmoceOw9jhDlK/AC2CDZifAKdsZgKtKv
zc98yqEYW3/Cy+uRAgvvOCzA0JXQ2/c/OnlYK14G+3PE/AItI9v0lLghC9wb1y9U6vS5Igau+fAD
BfcWkg2WunVKz0B+cS6kcyDUU6aMxpED7j0SKee57XqeIKZmYnUSEo6rH045DEU+WbnWt1eyz28y
D7z0bAHFq592inBwBgeTMD6ojcclmACl55JPfKX8PCJhupcc1lhhS6coAtYdmlvDm8US+RSC02HA
HTNySfrIso+OURph0Lln2Laj0I0Mw4H9QpAeUi6YGQ==
=Yiej
-----END PGP SIGNATURE-----

--------------Dglk4qYyyprX0NlIxjCYwpTm--
