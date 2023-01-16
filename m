Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2166B79B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjAPGpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjAPGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:45:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD04495;
        Sun, 15 Jan 2023 22:45:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B927534EA5;
        Mon, 16 Jan 2023 06:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673851527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G86aOTGRKtGT/dL2BP/zBD5nsf0SVezrWANnZeOyr08=;
        b=BOcpKiRnsFMazn2SHl1SFaYx3eOq7z8cZSJwi8fpak+xv6YFs4yJ93xt/1Wnic9duvs/ZF
        K2bc85GDUspAUwMA/b65JWhNmCNWqvf5iwIMwaUfM3JVaT++Vb9+uBANx4OnPC+7wqcOw4
        9D+1hCAsz1ekWiyn/uu8zvbSbX9Tyh4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D664138FA;
        Mon, 16 Jan 2023 06:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jL9uEYfyxGNlXwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Jan 2023 06:45:27 +0000
Message-ID: <e5cc2f96-82bc-a0dc-21fa-2f605bc867d1@suse.com>
Date:   Mon, 16 Jan 2023 07:45:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20230113140610.7132-1-jgross@suse.com>
 <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DiezvYaLwsyIRkmUHZiBoqpD"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DiezvYaLwsyIRkmUHZiBoqpD
Content-Type: multipart/mixed; boundary="------------lCn3u2Hrj53tNUYLono29aVo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <e5cc2f96-82bc-a0dc-21fa-2f605bc867d1@suse.com>
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
References: <20230113140610.7132-1-jgross@suse.com>
 <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>

--------------lCn3u2Hrj53tNUYLono29aVo
Content-Type: multipart/mixed; boundary="------------ypmOYZbFydzaBEXMU6GCKR0z"

--------------ypmOYZbFydzaBEXMU6GCKR0z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDEuMjMgMjA6NDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBGcmks
IEphbiAxMywgMjAyMyBhdCAzOjA2IFBNIEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gQ29tbWl0IGYxZTUyNTAwOTQ5MyAoIng4Ni9ib290OiBTa2lw
IHJlYWxtb2RlIGluaXQgY29kZSB3aGVuIHJ1bm5pbmcgYXMNCj4+IFhlbiBQViBndWVzdCIp
IG1pc3NlZCBvbmUgY29kZSBwYXRoIGFjY2Vzc2luZyByZWFsX21vZGVfaGVhZGVyLCBsZWFk
aW5nDQo+PiB0byBkZXJlZmVyZW5jaW5nIE5VTEwgd2hlbiBzdXNwZW5kaW5nIHRoZSBzeXN0
ZW0gdW5kZXIgWGVuOg0KPj4NCj4+ICAgICAgWyAgMzQ4LjI4NDAwNF0gUE06IHN1c3BlbmQg
ZW50cnkgKGRlZXApDQo+PiAgICAgIFsgIDM0OC4yODk1MzJdIEZpbGVzeXN0ZW1zIHN5bmM6
IDAuMDA1IHNlY29uZHMNCj4+ICAgICAgWyAgMzQ4LjI5MTU0NV0gRnJlZXppbmcgdXNlciBz
cGFjZSBwcm9jZXNzZXMgLi4uIChlbGFwc2VkIDAuMDAwIHNlY29uZHMpIGRvbmUuDQo+PiAg
ICAgIFsgIDM0OC4yOTI0NTddIE9PTSBraWxsZXIgZGlzYWJsZWQuDQo+PiAgICAgIFsgIDM0
OC4yOTI0NjJdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgLi4uIChlbGFw
c2VkIDAuMTA0IHNlY29uZHMpIGRvbmUuDQo+PiAgICAgIFsgIDM0OC4zOTY2MTJdIHByaW50
azogU3VzcGVuZGluZyBjb25zb2xlKHMpICh1c2Ugbm9fY29uc29sZV9zdXNwZW5kIHRvIGRl
YnVnKQ0KPj4gICAgICBbICAzNDguNzQ5MjI4XSBQTTogc3VzcGVuZCBkZXZpY2VzIHRvb2sg
MC4zNTIgc2Vjb25kcw0KPj4gICAgICBbICAzNDguNzY5NzEzXSBBQ1BJOiBFQzogaW50ZXJy
dXB0IGJsb2NrZWQNCj4+ICAgICAgWyAgMzQ4LjgxNjA3N10gQlVHOiBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDFjDQo+PiAgICAg
IFsgIDM0OC44MTYwODBdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwg
bW9kZQ0KPj4gICAgICBbICAzNDguODE2MDgxXSAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAt
IG5vdC1wcmVzZW50IHBhZ2UNCj4+ICAgICAgWyAgMzQ4LjgxNjA4M10gUEdEIDAgUDREIDAN
Cj4+ICAgICAgWyAgMzQ4LjgxNjA4Nl0gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5P
UFRJDQo+PiAgICAgIFsgIDM0OC44MTYwODldIENQVTogMCBQSUQ6IDY3NjQgQ29tbTogc3lz
dGVtZC1zbGVlcCBOb3QgdGFpbnRlZCA2LjEuMy0xLmZjMzIucXViZXMueDg2XzY0ICMxDQo+
PiAgICAgIFsgIDM0OC44MTYwOTJdIEhhcmR3YXJlIG5hbWU6IFN0YXIgTGFicyBTdGFyQm9v
ay9TdGFyQm9vaywgQklPUyA4LjAxIDA3LzAzLzIwMjINCj4+ICAgICAgWyAgMzQ4LjgxNjA5
M10gUklQOiBlMDMwOmFjcGlfZ2V0X3dha2V1cF9hZGRyZXNzKzB4Yy8weDIwDQo+Pg0KPj4g
Rml4IHRoYXQgYnkgYWRkaW5nIGFuIGluZGlyZWN0aW9uIGZvciBhY3BpX2dldF93YWtldXBf
YWRkcmVzcygpIHdoaWNoDQo+PiBYZW4gUFYgZG9tMCBjYW4gdXNlIHRvIHJldHVybiBhIGR1
bW15IG5vbi16ZXJvIHdha2V1cCBhZGRyZXNzICh0aGlzDQo+PiBhZGRyZXNzIHdvbid0IGV2
ZXIgYmUgdXNlZCwgYXMgdGhlIHJlYWwgc3VzcGVuZCBoYW5kbGluZyBpcyBkb25lIGJ5IHRo
ZQ0KPj4gaHlwZXJ2aXNvcikuDQo+IA0KPiBIb3cgZXhhY3RseSBkb2VzIHRoaXMgaGVscD8N
Cg0KSSBiZWxpZXZlZCB0aGUgZmlyc3Qgc2VudGVuY2Ugb2YgdGhlIGNvbW1pdCBtZXNzYWdl
IHdvdWxkIG1ha2UgdGhpcw0KY2xlYXIgZW5vdWdoLg0KDQpJIGNhbiBleHBhbmQgdGhlIGNv
bW1pdCBtZXNzYWdlIHRvIGdvIG1vcmUgaW50byBkZXRhaWwgaWYgeW91IHRoaW5rDQp0aGlz
IGlzIHJlYWxseSBuZWVkZWQuDQoNCg0KSnVlcmdlbg0K
--------------ypmOYZbFydzaBEXMU6GCKR0z
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ypmOYZbFydzaBEXMU6GCKR0z--

--------------lCn3u2Hrj53tNUYLono29aVo--

--------------DiezvYaLwsyIRkmUHZiBoqpD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPE8oYFAwAAAAAACgkQsN6d1ii/Ey9J
ZAgAi4CoUUPJ9ONm01UIjdAlhMyh5th9qLyYKLOUDPzBQegwPpK3s6Mo1YOl12jqDLcspdbgsXLV
KGvkA3oqqLDHZJV257VZqSAHHHcbjmOohiAa2monvmfQJULL4lLSG0nR/yjkqNcxR2Md8XHBFX12
RP0b7v7WLMa29o2GCPQNu/RWbsv/rfXLj5xjy8TfRDbzMkAugfmLxaz133kVZuoqScHpT7NbQZFB
XYNfm3uaGTlCasOqNCrIAWyxGUtpX5qV3SfdOk5XTeJW9VN+GVSjQmwpyllQYtkNEE23DYYaWNME
6mCyQ4pe/TD3UerPryakVNnS4JIbGj7v1Okk+X+u1Q==
=ZhOs
-----END PGP SIGNATURE-----

--------------DiezvYaLwsyIRkmUHZiBoqpD--
