Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A066D69D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjAQHEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjAQHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:04:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5623847
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:04:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D856A37FB9;
        Tue, 17 Jan 2023 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673939061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdkjSkzm05RohS38Rjt/aDDs5GVqQVYmitRleVxiinY=;
        b=XeUZOtGH+yWGLqh9SNMWgJi/8VmlchyK7y0ykgYEnSNgOcyOjBjNQ8pF6d22mxQbYDAFhJ
        oD9H7axJMLGV5QkvuNloq1OGTr++xtgq1Irm55KTE/snqEnxOXHJNkx0zzwpKJJFEl1U+r
        aEfdMDQuNZqRUL14MaI3b71vJQYMGnY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD3341390C;
        Tue, 17 Jan 2023 07:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DZXUKHVIxmOmKgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 17 Jan 2023 07:04:21 +0000
Message-ID: <d800f7f9-ab9a-93d8-289c-2154d2d55939@suse.com>
Date:   Tue, 17 Jan 2023 08:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] drivers/xen/hypervisor: Expose Xen SIF flags to
 userspace
Content-Language: en-US
To:     Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20230103130213.2129753-1-per.bilse@citrix.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230103130213.2129753-1-per.bilse@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VBISEoQwMG6EX6bDl5I0EGSt"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VBISEoQwMG6EX6bDl5I0EGSt
Content-Type: multipart/mixed; boundary="------------9j8AUhJFMzy1LYMUehCXOwxp";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <d800f7f9-ab9a-93d8-289c-2154d2d55939@suse.com>
Subject: Re: [PATCH v3] drivers/xen/hypervisor: Expose Xen SIF flags to
 userspace
References: <20230103130213.2129753-1-per.bilse@citrix.com>
In-Reply-To: <20230103130213.2129753-1-per.bilse@citrix.com>

--------------9j8AUhJFMzy1LYMUehCXOwxp
Content-Type: multipart/mixed; boundary="------------BYVuKDEJh9JsAxr30ovnRW3y"

--------------BYVuKDEJh9JsAxr30ovnRW3y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDEuMjMgMTQ6MDIsIFBlciBCaWxzZSB3cm90ZToNCj4gL3Byb2MveGVuIGlzIGEg
bGVnYWN5IHBzZXVkbyBmaWxlc3lzdGVtIHdoaWNoIHByZWRhdGVzIFhlbiBzdXBwb3J0DQo+
IGdldHRpbmcgbWVyZ2VkIGludG8gTGludXguICBJdCBoYXMgbGFyZ2VseSBiZWVuIHJlcGxh
Y2VkIHdpdGggbW9yZQ0KPiBub3JtYWwgbG9jYXRpb25zIGZvciBkYXRhICgvc3lzL2h5cGVy
dmlzb3IvIGZvciBpbmZvLCAvZGV2L3hlbi8gZm9yDQo+IHVzZXIgZGV2aWNlcykuICBXZSB3
YW50IHRvIGNvbXBpbGUgeGVuZnMgc3VwcG9ydCBvdXQgb2YgdGhlIGRvbTAga2VybmVsLg0K
PiANCj4gVGhlcmUgaXMgb25lIGl0ZW0gd2hpY2ggb25seSBleGlzdHMgaW4gL3Byb2MveGVu
LCBuYW1lbHkNCj4gL3Byb2MveGVuL2NhcGFiaWxpdGllcyB3aXRoICJjb250cm9sX2QiIGJl
aW5nIHRoZSBzaWduYWwgb2YgInlvdSdyZSBpbg0KPiB0aGUgY29udHJvbCBkb21haW4iLiAg
VGhpcyB1bHRpbWF0ZWx5IGNvbWVzIGZyb20gdGhlIFNJRiBmbGFncyBwcm92aWRlZA0KPiBh
dCBWTSBzdGFydC4NCj4gDQo+IFRoaXMgcGF0Y2ggZXhwb3NlcyBhbGwgU0lGIGZsYWdzIGlu
IC9zeXMvaHlwZXJ2aXNvci9zdGFydF9mbGFncy8gYXMNCj4gYm9vbGVhbiBmaWxlcywgb25l
IGZvciBlYWNoIGJpdCwgcmV0dXJuaW5nICcxJyBpZiBzZXQsICcwJyBvdGhlcndpc2UuDQo+
IFR3byBrbm93biBmbGFncywgJ3ByaXZpbGVnZWQnIGFuZCAnaW5pdGRvbWFpbicsIGFyZSBl
eHBsaWNpdGx5IG5hbWVkLA0KPiBhbmQgYWxsIHJlbWFpbmluZyBmbGFncyBjYW4gYmUgYWNj
ZXNzZWQgdmlhIGdlbmVyaWNhbGx5IG5hbWVkIGZpbGVzLA0KPiBhcyBzdWdnZXN0ZWQgYnkg
QW5kcmV3IENvb3Blci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlciBCaWxzZSA8cGVyLmJp
bHNlQGNpdHJpeC5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NA
c3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------BYVuKDEJh9JsAxr30ovnRW3y
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------BYVuKDEJh9JsAxr30ovnRW3y--

--------------9j8AUhJFMzy1LYMUehCXOwxp--

--------------VBISEoQwMG6EX6bDl5I0EGSt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPGSHUFAwAAAAAACgkQsN6d1ii/Ey+A
GQf+NGqEepBADdoTrIer/vgh3nTiZqCxC01/ltV/V5KGNNC/EmeDnfBSJIKiG88lgVn/ON5dgKCn
q3hqEZ1T80iPutavOMYQH4pBcGebcaMo9doNSqnC1dVvBpEzJ3gkhsxIQDHRvG8HUHB6u9SFRuyW
ybU/xhcZDKaZCpviv0DkSMJKr9LqOBt5Rgx8MWeNKPqNq8AzcQQLFUuyeOEqDo/BwugRv56CKtH5
iiJzKdxZjR6xKb2Ikxqq238hF89orXX4D1ydMnyaI35Y8w2EKJZK6ErTPDfF6o3LysLJcB9/KhzD
PG8T3MJk3MrgMK54huWkZPDuh1DDvLd3AgPitlL1/Q==
=qrOc
-----END PGP SIGNATURE-----

--------------VBISEoQwMG6EX6bDl5I0EGSt--
