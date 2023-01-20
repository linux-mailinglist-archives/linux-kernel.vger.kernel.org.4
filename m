Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ED3674E01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjATHYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjATHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:24:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBA79E95
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:24:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB34D21F2C;
        Fri, 20 Jan 2023 07:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674199451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVCoiGuOSiNwE408h17hFokKY1abJGIIRxIQ6PgC4r8=;
        b=KpzSZkpSn1sDPgojQBN+ZEIF3zLp9epIWmQdOf3PjLW5sQCMb3Pm6MDxNY5LDQdoKLxSaf
        yehxJS1LPx5t3lFET3tkifRLHT0cp/hM7/O+VXzLwYWumHYDmfzsC4W/g0QoKSHei7AGtf
        SgKbMpqT7zox8KjnoBRbtlwQM3CLw2E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB1781390C;
        Fri, 20 Jan 2023 07:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ZxVKJtBymPvawAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 20 Jan 2023 07:24:11 +0000
Message-ID: <c7f89ae6-4e12-8430-b807-628e8ffda6f3@suse.com>
Date:   Fri, 20 Jan 2023 08:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] xen/pvcalls-back: fix permanently masked event channel
Content-Language: en-US
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
References: <20230119211037.1234931-1-volodymyr_babchuk@epam.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230119211037.1234931-1-volodymyr_babchuk@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6v9Ljt46l0xlOcGWn9YQNeSF"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6v9Ljt46l0xlOcGWn9YQNeSF
Content-Type: multipart/mixed; boundary="------------uGQ0hPMt3AfYxpWRp7vu56vC";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Message-ID: <c7f89ae6-4e12-8430-b807-628e8ffda6f3@suse.com>
Subject: Re: [PATCH] xen/pvcalls-back: fix permanently masked event channel
References: <20230119211037.1234931-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20230119211037.1234931-1-volodymyr_babchuk@epam.com>

--------------uGQ0hPMt3AfYxpWRp7vu56vC
Content-Type: multipart/mixed; boundary="------------5HrkPxkWODe3kjOtrpwUOODX"

--------------5HrkPxkWODe3kjOtrpwUOODX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDEuMjMgMjI6MTEsIFZvbG9keW15ciBCYWJjaHVrIHdyb3RlOg0KPiBUaGVyZSBp
cyBhIHNlcXVlbmNlIG9mIGV2ZW50cyB0aGF0IGNhbiBsZWFkIHRvIGEgcGVybWFuZW50bHkg
bWFza2VkDQo+IGV2ZW50IGNoYW5uZWwsIGJlY2F1c2UgeGVuX2lycV9sYXRlZW9pKCkgaXMg
bmV3ZXIgY2FsbGVkLiBUaGlzIGhhcHBlbnMNCj4gd2hlbiBhIGJhY2tlbmQgcmVjZWl2ZXMg
c3B1cmlvdXMgd3JpdGUgZXZlbnQgZnJvbSBhIGZyb250ZW5kLiBJbiB0aGlzDQo+IGNhc2Ug
cHZjYWxsc19jb25uX2JhY2tfd3JpdGUoKSByZXR1cm5zIGVhcmx5IGFuZCBpdCBkb2VzIG5v
dCBjbGVhcnMgdGhlDQo+IG1hcC0+d3JpdGUgY291bnRlci4gQXMgbWFwLT53cml0ZSA+IDAs
IHB2Y2FsbHNfYmFja19pb3dvcmtlcigpIHJldHVybnMNCj4gd2l0aG91dCBjYWxsaW5nIHhl
bl9pcnFfbGF0ZWVvaSgpLiBUaGlzIGxlYXZlcyB0aGUgZXZlbnQgY2hhbm5lbCBpbg0KPiBt
YXNrZWQgc3RhdGUsIGEgYmFja2VuZCBkb2VzIG5vdCByZWNlaXZlIGFueSBuZXcgZXZlbnRz
IGZyb20gYQ0KPiBmcm9udGVuZCBhbmQgdGhlIHdob2xlIGNvbW11bmljYXRpb24gc3RvcHMu
DQo+IA0KPiBNb3ZlIGF0b21pY19zZXQoJm1hcC0+d3JpdGUsIDApIHRvIHRoZSB2ZXJ5IGJl
Z2lubmluZyBvZg0KPiBwdmNhbGxzX2Nvbm5fYmFja193cml0ZSgpIHRvIGZpeCB0aGlzIGlz
c3VlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVm9sb2R5bXlyIEJhYmNodWsgPHZvbG9keW15
cl9iYWJjaHVrQGVwYW0uY29tPg0KPiBSZXBvcnRlZC1ieTogT2xla3NpaSBNb2lzaWVpZXYg
PG9sZWtzaWlfbW9pc2llaWV2QGVwYW0uY29tPg0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg0K
--------------5HrkPxkWODe3kjOtrpwUOODX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------5HrkPxkWODe3kjOtrpwUOODX--

--------------uGQ0hPMt3AfYxpWRp7vu56vC--

--------------6v9Ljt46l0xlOcGWn9YQNeSF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPKQZsFAwAAAAAACgkQsN6d1ii/Ey9a
jwf+NSCsTPXNEIqSmfln+gntX+LU7sW3klmuzqzFw35Ipugm6F5gU3YitzgAMQBoHG3QNzpGxubw
2tr4KyVQEKrsdkiWO5OWPKTLJlRYxW1fXUL1dvNYZx4FoLaXmL1ROc2i8v5TuxJAx2GbfWTY5ymW
+COJoTJt57N+DzsPipupn4iCPbMG2tLI95j9d0DbYkLW0IS2f7miRrUsIJl35eNSSauQhl9NMzm6
Hg8sn1b0wl10OxlVHi1mVgsEEeq+wYZ0pK5nyA28UXSZfIh2R4SwU4FYZVygqbr4bCZG1NwEPIKX
e+9BZVxx3OLnVC7o1IhGVtRNKXX4Dfr8bJDGSOi+5w==
=qImL
-----END PGP SIGNATURE-----

--------------6v9Ljt46l0xlOcGWn9YQNeSF--
