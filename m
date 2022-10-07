Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70145F740B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGF5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJGF5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:57:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA821142F5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 22:57:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6B31F8C6;
        Fri,  7 Oct 2022 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665122234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Sk/Wai7OL6bCl05p5gxU/lW31/U1SnkzvU73Y4Wl1U=;
        b=fZ/soGn8d/ZTWVptwhYeZz8cqBRToxqb6C4hkyEJD6Fm6dcfdAMgNqM2Upt5R/rqQx7lVz
        XkhGt+1dEdwJ7Hz+iQyU4Ao5FHoAR/I+FyTclssAgFa9ceGuGSoKC6teDqqdoOhydHqjro
        zIh+0M4iKz7mPWbywWSjUIG1OiDKDPo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E273E13A9A;
        Fri,  7 Oct 2022 05:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TGbXNbm/P2N3OgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 05:57:13 +0000
Message-ID: <014e7036-5daf-6465-663c-b690d6f719ee@suse.com>
Date:   Fri, 7 Oct 2022 07:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20221006174804.2003029-1-olekstysh@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/virtio: Handle PCI devices which Host controller is
 described in DT
In-Reply-To: <20221006174804.2003029-1-olekstysh@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vPlS10kX7W0yziMi5kKHRSH0"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vPlS10kX7W0yziMi5kKHRSH0
Content-Type: multipart/mixed; boundary="------------M20S0RLBbR0aQSj1w20tEhYl";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <014e7036-5daf-6465-663c-b690d6f719ee@suse.com>
Subject: Re: [PATCH] xen/virtio: Handle PCI devices which Host controller is
 described in DT
References: <20221006174804.2003029-1-olekstysh@gmail.com>
In-Reply-To: <20221006174804.2003029-1-olekstysh@gmail.com>

--------------M20S0RLBbR0aQSj1w20tEhYl
Content-Type: multipart/mixed; boundary="------------wjbTJXDYWf4092hEeeVUGVdn"

--------------wjbTJXDYWf4092hEeeVUGVdn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMTk6NDgsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiBGcm9t
OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+
DQo+IA0KPiBVc2UgdGhlIHNhbWUgInhlbi1ncmFudC1kbWEiIGRldmljZSBjb25jZXB0IChi
YXNlZCBvbiBnZW5lcmljIElPTU1VDQo+IGRldmljZS10cmVlIGJpbmRpbmdzKSBmb3IgdGhl
IFBDSSBkZXZpY2VzIGJlaGluZCBkZXZpY2UtdHJlZSBiYXNlZA0KPiBQQ0kgSG9zdCBjb250
cm9sbGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9s
ZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KPiAtLS0NCj4gU2xpZ2h0bHkgUkZDLiBU
aGlzIGlzIG5lZWRlZCB0byBzdXBwb3J0IFhlbiBncmFudCBtYXBwaW5ncyBmb3IgdmlydGlv
LXBjaSBkZXZpY2VzDQo+IG9uIEFybSBhdCBzb21lIHBvaW50IGluIHRoZSBmdXR1cmUuIFRo
ZSBYZW4gdG9vbHN0YWNrIHNpZGUgaXMgbm90IHB1Ymxpc2hlZCB5ZXQuDQo+IEhlcmUsIGZv
ciBQQ0kgZGV2aWNlcyB3ZSB1c2UgdGhlIHNhbWUgd2F5IHRvIHBhc3MgYmFja2VuZCBkb21p
ZCB0byB0aGUgZ3Vlc3QgYXMgZm9yDQo+IHBsYXRmb3JtIGRldmljZXMuDQoNCkkgc2hvdWxk
IG1lbnRpb24gd2UgZGVjaWRlZCBhdCB0aGUgWGVuIFN1bW1pdCwgdGhhdCBJIHdpbGwgc3Rh
cnQgYSB0cnkgdG8NCm1vZGlmeSB0aGUgdmlydGlvIHNwZWMgdG8gaW5jbHVkZSB0aGUgYmFj
a2VuZCBpZCAoZG9taWQgaW4gdGhlIFhlbiBjYXNlKQ0KaW4gdGhlIGRldmljZSBpbmRlcGVu
ZGVudCBjb25maWcgcGFydC4NCg0KQXMgdGhpcyB3aWxsIHRha2Ugc29tZSB0aW1lIHRvIGJl
IGFjY2VwdGVkIChpZiBldmVyKSwgb3RoZXIgbWVhbnMgdG8NCnNwZWNpZnkgdGhlIGJhY2tl
bmQgZG9taWQgYXJlIG5lZWRlZCB1bnRpbCB0aGVuLiBEVCBpcyBvbmUgcG9zc2liaWxpdHkN
CihhdCBsZWFzdCBvbiBBcm0pLCB3aGlsZSBYZW5zdG9yZSBpcyB0aGUgd2F5IHRvIGdvIGZv
ciBzZXR1cHMgd2l0aCBhDQpYZW4gdG9vbHN0YWNrLg0KDQoNCkp1ZXJnZW4NCg==
--------------wjbTJXDYWf4092hEeeVUGVdn
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wjbTJXDYWf4092hEeeVUGVdn--

--------------M20S0RLBbR0aQSj1w20tEhYl--

--------------vPlS10kX7W0yziMi5kKHRSH0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM/v7kFAwAAAAAACgkQsN6d1ii/Ey/a
oAf+M7BYmmsyCqqYqE/sUb5gWvcFBqjmeJJpq6IlyY3JTUc2Zew9h850V2ijUDdQ50bIa2hML+g9
jwxuoohx8JC2z7kI6E6/+zs+1hvn3C9hU6uxgr1p0kRZWq18TRITThO4frBIT1vp6OuGYLgUD8qp
Stlcqth2+veKUxYiF0d+dhOI2IkwSkRVVYD0Lm0Bga836ogRevgfQWWTFpPnIREPvOJ7DaqCEaNW
QiCWCT4bePhpAHxRyOzDGh9+sNCrqiPzpPfgeo0Akps0bw3y1Lr6UTGJwx5dbyZFk/z1j50e9ehE
MoyYquZiuqzJQbydkRTik0sUfFW5agQHdm0MNz9fOg==
=LQRo
-----END PGP SIGNATURE-----

--------------vPlS10kX7W0yziMi5kKHRSH0--
