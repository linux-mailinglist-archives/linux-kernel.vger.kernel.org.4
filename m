Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74C0746EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGDKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjGDKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:39:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E21A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:39:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6402B204D8;
        Tue,  4 Jul 2023 10:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688467181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufUyszN3FOTy1keSsZFTm+VxsQdbtQ8iR1hztEdTO+U=;
        b=pA9V4VHpYj7BS1DxBVycwdaAXi++0qHtjb0hgEmEQotmgbu0x7nT0crDnrltGWSWHHWbGe
        6f/CEBJ1Vkq2Q9UghaMYK5MylCKZpKUGPQjwn+9t+LBm7ceWUGs/5eT7MtsZ1Xt7/gQd3A
        nCmjQnCt6xATm+NwX0RuhLGnLIlw/rA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B0541346D;
        Tue,  4 Jul 2023 10:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jF/6CO32o2QEdQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Jul 2023 10:39:41 +0000
Message-ID: <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
Date:   Tue, 4 Jul 2023 12:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xX4qTw8UY8621tTesaaATWaa"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xX4qTw8UY8621tTesaaATWaa
Content-Type: multipart/mixed; boundary="------------gidE6FoEsgf7uP6gzz4RP2TS";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 vikram.garhwal@amd.com
Message-ID: <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
In-Reply-To: <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>

--------------gidE6FoEsgf7uP6gzz4RP2TS
Content-Type: multipart/mixed; boundary="------------L2wHyOVyIZUNYvNlG5ywcrPl"

--------------L2wHyOVyIZUNYvNlG5ywcrPl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDcuMjMgMDk6NDgsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+IE9uIFRodSwg
SnVuIDI5LCAyMDIzIGF0IDAzOjQ0OjA0UE0gLTA3MDAsIFN0ZWZhbm8gU3RhYmVsbGluaSB3
cm90ZToNCj4+IE9uIFRodSwgMjkgSnVuIDIwMjMsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdy
b3RlOg0KPj4+IE9uIDI5LjA2LjIzIDA0OjAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6
DQo+Pj4+IEkgdGhpbmsgd2UgbmVlZCB0byBhZGQgYSBzZWNvbmQgd2F5PyBJdCBjb3VsZCBi
ZSBhbnl0aGluZyB0aGF0IGNhbiBoZWxwDQo+Pj4+IHVzIGRpc3Rpbmd1aXNoIGJldHdlZW4g
YSBub24tZ3JhbnRzLWNhcGFibGUgdmlydGlvIGJhY2tlbmQgYW5kIGENCj4+Pj4gZ3JhbnRz
LWNhcGFibGUgdmlydGlvIGJhY2tlbmQsIHN1Y2ggYXM6DQo+Pj4+IC0gYSBzdHJpbmcgb24g
eGVuc3RvcmUNCj4+Pj4gLSBhIHhlbiBwYXJhbQ0KPj4+PiAtIGEgc3BlY2lhbCBQQ0kgY29u
ZmlndXJhdGlvbiByZWdpc3RlciB2YWx1ZQ0KPj4+PiAtIHNvbWV0aGluZyBpbiB0aGUgQUNQ
SSB0YWJsZXMNCj4+Pj4gLSB0aGUgUUVNVSBtYWNoaW5lIHR5cGUNCj4+Pg0KPj4+DQo+Pj4g
WWVzLCBJIHJlbWVtYmVyIHRoZXJlIHdhcyBhIGRpc2N1c3Npb24gcmVnYXJkaW5nIHRoYXQu
IFRoZSBwb2ludCBpcyB0bw0KPj4+IGNob29zZSBhIHNvbHV0aW9uIHRvIGJlIGZ1bmN0aW9u
YWwgZm9yIGJvdGggUFYgYW5kIEhWTSAqYW5kKiB0byBiZSBhYmxlDQo+Pj4gdG8gc3VwcG9y
dCBhIGhvdHBsdWcuIElJUkMsIHRoZSB4ZW5zdG9yZSBjb3VsZCBiZSBhIHBvc3NpYmxlIGNh
bmRpZGF0ZS4NCj4+DQo+PiB4ZW5zdG9yZSB3b3VsZCBiZSBhbW9uZyB0aGUgZWFzaWVzdCB0
byBtYWtlIHdvcmsuIFRoZSBvbmx5IGRvd25zaWRlIGlzDQo+PiB0aGUgZGVwZW5kZW5jeSBv
biB4ZW5zdG9yZSB3aGljaCBvdGhlcndpc2UgdmlydGlvK2dyYW50cyBkb2Vzbid0IGhhdmUu
DQo+IA0KPiBJIHdvdWxkIGF2b2lkIGludHJvZHVjaW5nIGEgZGVwZW5kZW5jeSBvbiB4ZW5z
dG9yZSwgaWYgbm90aGluZyBlbHNlIHdlDQo+IGtub3cgaXQncyBhIHBlcmZvcm1hbmNlIGJv
dHRsZW5lY2suDQo+IA0KPiBXZSB3b3VsZCBhbHNvIG5lZWQgdG8gbWFwIHRoZSB2aXJ0aW8g
ZGV2aWNlIHRvcG9sb2d5IGludG8geGVuc3RvcmUsIHNvDQo+IHRoYXQgd2UgY2FuIHBhc3Mg
ZGlmZmVyZW50IG9wdGlvbnMgZm9yIGVhY2ggZGV2aWNlLg0KDQpUaGlzIGFzcGVjdCAoZGlm
ZmVyZW50IG9wdGlvbnMpIGlzIGltcG9ydGFudC4gSG93IGRvIHlvdSB3YW50IHRvIHBhc3Mg
dmlydGlvDQpkZXZpY2UgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJzIGZyb20gZG9tMCB0byB0
aGUgdmlydGlvIGJhY2tlbmQgZG9tYWluPyBZb3UNCnByb2JhYmx5IG5lZWQgc29tZXRoaW5n
IGxpa2UgWGVuc3RvcmUgKGEgdmlydGlvIGJhc2VkIGFsdGVybmF0aXZlIGxpa2UgdmlydGlv
ZnMNCndvdWxkIHdvcmssIHRvbykgZm9yIHRoYXQgcHVycG9zZS4NCg0KTWFwcGluZyB0aGUg
dG9wb2xvZ3kgc2hvdWxkIGJlIHJhdGhlciBlYXN5IHZpYSB0aGUgUENJLUlkLCBlLmcuOg0K
DQovbG9jYWwvZG9tYWluLzQyL2RldmljZS92aXJ0aW8vMDAwMDowMDoxYy4wL2JhY2tlbmQN
Cg0KPiANCj4+IFZpa3JhbSBpcyB3b3JraW5nIG9uIHZpcnRpbyB3aXRoIGdyYW50cyBzdXBw
b3J0IGluIFFFTVUgYXMgd2Ugc3BlYWsuDQo+PiBNYXliZSB3ZSBjb3VsZCBmaW5kIGEgd2F5
IHRvIGFkZCBhIGZsYWcgaW4gUUVNVSBzbyB0aGF0IHdlIGNhbiBkZXRlY3QgYXQNCj4+IHJ1
bnRpbWUgaWYgYSBnaXZlbiB2aXJ0aW8gZGV2aWNlIHN1cHBvcnQgZ3JhbnRzIG9yIG5vdC4N
Cj4gDQo+IElzbid0IHRoZXJlIGEgd2F5IGZvciB0aGUgZGV2aWNlIHRvIGV4cG9zZSBjYXBh
YmlsaXRpZXMgYWxyZWFkeT8gIEZvcg0KPiBleGFtcGxlIGhvdyBkb2VzIGEgdmlydGlvLWJs
ayBiYWNrZW5kIGV4cG9zZSBzdXBwb3J0IGZvciBpbmRpcmVjdA0KPiBkZXNjcmlwdG9ycz8N
Cg0KVGhvc2UgY2FwYWJpbGl0aWVzIGFyZSBkZWZpbmVkIGluIHRoZSB2aXJ0aW8gc3BlYyBb
MV0uIEFkZGluZyB0aGUgYmFja2VuZA0KZG9taWQgd291bGQgYmUgcG9zc2libGUsIGJ1dCBp
dCBwcm9iYWJseSB3b3VsZG4ndCBiZSB0aGF0IGVhc3kgKHJlcXVpcmVzDQpjaGFuZ2luZyB0
aGUgdmlydGlvIHNwZWMgYnkgZWl0aGVyIGV4cGFuZGluZyBhbiBleGlzdGluZyBjb25maWcg
YXJlYSBvciBieQ0KYWRkaW5nIGEgbmV3IG9uZSkuIEknbSBub3Qgc3VyZSBoYW5kbGluZyBp
biB0aGUgc3BlY2lmaWMgZnJvbnRlbmRzIGlzDQpnZW5lcmljIGVub3VnaCBmb3IgYmVpbmcg
YWJsZSB0byBoYXZlIGEgY2VudHJhbCBwbGFjZSB3aGVyZSB0aGUgYmFja2VuZA0KZG9taWQg
Y291bGQgYmUgcmV0cmlldmVkLCB3aXRob3V0IHJlcXVpcmluZyBhbnkgY2hhbmdlIG9mIHRo
ZSBmcm9udGVuZHMuDQoNCg0KSnVlcmdlbg0KDQpbMV06IGh0dHA6Ly9kb2NzLm9hc2lzLW9w
ZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEuMi92aXJ0aW8tdjEuMi5odG1sDQo=
--------------L2wHyOVyIZUNYvNlG5ywcrPl
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------L2wHyOVyIZUNYvNlG5ywcrPl--

--------------gidE6FoEsgf7uP6gzz4RP2TS--

--------------xX4qTw8UY8621tTesaaATWaa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSj9uwFAwAAAAAACgkQsN6d1ii/Ey+9
yggAm/nnfzU+zzUQjNzpq4jgN4FPFkr5ki16LnPe/evdn7hmqs8k/+VXrXCW+2xyXD+VoDibBl9Q
pckoziwZFXP4jomvW+oR17HpmibmQ96nXtiRGJvH5oRB1Pul82aEy2PbbkeM357nts2i6IYtR86W
xJalTzeCBRept1bMjYgxyPZmdbGAskeYquTug5wOG2wr9TJRZ3YZohauH3kfKQfnuuqdhbgHYQiu
wexNRngYZHoIH9uHcb2cQnlP4z3Tfhr4ClcIcabczqxKv4qLTD3lrUmRhIUHAVdJjWJQhLoIr/py
A9prgAkJHf5ibJvV4HLe5bNAlri8zB+8gHqmtZibxQ==
=ZF9q
-----END PGP SIGNATURE-----

--------------xX4qTw8UY8621tTesaaATWaa--
