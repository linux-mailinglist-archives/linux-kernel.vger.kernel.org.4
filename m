Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C195693F66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBMIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBMIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:17:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7368911649
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:17:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3402E67AB1;
        Mon, 13 Feb 2023 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676276259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StpQBZwza4sJYTV0zdJUm/BBOAaYyUvS/zTc8OBhzug=;
        b=OsU1ItPZOWgPikaPoXumOAb74LaUquqlKDQFwUxkShD+c6ndgnl0WxTkT8bPSHE7zFeZa0
        nQbSOlNMU7mrZM5aOnwWZoeuAxkmCuCa0I+Ip+8k9vtZ0vX+j3BXxjRYds3T4DAgkvwtBb
        DWZfYBh+rc5bB4m0NXRPlW3ATWwq/JQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 068E5138E6;
        Mon, 13 Feb 2023 08:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHcQACPy6WM6NQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 08:17:39 +0000
Message-ID: <5847d0b4-04ce-f412-e0d6-4517c0dff2b1@suse.com>
Date:   Mon, 13 Feb 2023 09:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
 boundary="------------RaRG7cOKtNWOYX9dGkvl5yvn"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RaRG7cOKtNWOYX9dGkvl5yvn
Content-Type: multipart/mixed; boundary="------------i51NBJAy4qfMHQfYpHGYhZH2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <5847d0b4-04ce-f412-e0d6-4517c0dff2b1@suse.com>
Subject: Re: [PATCH v3] drivers/xen/hypervisor: Expose Xen SIF flags to
 userspace
References: <20230103130213.2129753-1-per.bilse@citrix.com>
In-Reply-To: <20230103130213.2129753-1-per.bilse@citrix.com>

--------------i51NBJAy4qfMHQfYpHGYhZH2
Content-Type: multipart/mixed; boundary="------------0888ix6X9VRTBjOLUH0ruqnM"

--------------0888ix6X9VRTBjOLUH0ruqnM
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
bHNlQGNpdHJpeC5jb20+DQoNClB1c2hlZCB0byB4ZW4vdGlwLmdvdCBmb3ItbGludXMtNi4z
DQoNCg0KSnVlcmdlbg0KDQo=
--------------0888ix6X9VRTBjOLUH0ruqnM
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0888ix6X9VRTBjOLUH0ruqnM--

--------------i51NBJAy4qfMHQfYpHGYhZH2--

--------------RaRG7cOKtNWOYX9dGkvl5yvn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp8iIFAwAAAAAACgkQsN6d1ii/Ey8j
JAf/fxi6jU96yMOPfpl/bafO23MGg+TXJtrdGWexTW6vpPTqOh2xcmwST5CQYgoOKk0Wk7YiB+7k
h6/DMV+Q9D2tX7S9FrzhygA7eu15d8nu6nX8epmQTb2k+G4vLpPrL8yoMlsNTcThYyQbP2tlSVk8
BSpGaHh44HvYKC0Qyf28UTgTHIgJRPH+gRpPsgwdk5THv6M3oinPkM3AbxO4cHJ0+sY9zJDQC6Za
yYO80JgIFWsYe4R7DDOl/fLpTKWYxQf3+7+lYfKrArFpwX0JM9CgRtWKS5qj/SOqdrTPZc5pE2pM
ufQ9/duYJdo32/8Qvg1M7tu7Fb9hwHq39qX8W7TZOg==
=4AYr
-----END PGP SIGNATURE-----

--------------RaRG7cOKtNWOYX9dGkvl5yvn--
