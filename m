Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7795FFA64
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJOOD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJOOD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 10:03:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5FA12AC7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:03:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA5292188F;
        Sat, 15 Oct 2022 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665842633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGyPksAXnV2jtAP6FfUhm/2POnqJYgklllRaGArfe4E=;
        b=ULXwswezUCphZWW/db50WY59mumyqvtMy97G9fl5pZknNv6JjGrnjby1R2Y1wEam2LW4YP
        87YydfBNCrRH5XpJHb2kKc6tVhXLX+wyYyDokEPTj3fBwrLtGOX6FcxMUutPQlSvYeeTXn
        Aeb3k8pAt24YTf0LX/ZMiAjXNgVkFjg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2864139F3;
        Sat, 15 Oct 2022 14:03:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GamPKcm9SmNVQQAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 15 Oct 2022 14:03:53 +0000
Message-ID: <f6918108-01db-6232-dfed-48b288dc2854@suse.com>
Date:   Sat, 15 Oct 2022 16:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 0/2] Other misc fixes for Xen grant DMA-mapping layer
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
References: <20221008151013.2537826-1-olekstysh@gmail.com>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221008151013.2537826-1-olekstysh@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OeieXWXVTqu81zQgSRYSEdaA"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OeieXWXVTqu81zQgSRYSEdaA
Content-Type: multipart/mixed; boundary="------------Lesnbvd9TdY7cIVfEpMuttXX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Xenia Ragiadakou <burzalodowa@gmail.com>
Message-ID: <f6918108-01db-6232-dfed-48b288dc2854@suse.com>
Subject: Re: [PATCH V2 0/2] Other misc fixes for Xen grant DMA-mapping layer
References: <20221008151013.2537826-1-olekstysh@gmail.com>
In-Reply-To: <20221008151013.2537826-1-olekstysh@gmail.com>

--------------Lesnbvd9TdY7cIVfEpMuttXX
Content-Type: multipart/mixed; boundary="------------5qRwEWviQKbHG4KAYZSOidAj"

--------------5qRwEWviQKbHG4KAYZSOidAj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMTAuMjIgMTc6MTAsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiBGcm9t
OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+
DQo+IA0KPiBIZWxsbyBhbGwuDQo+IA0KPiBUaGVzZSBhcmUgb3RoZXIgc2V2ZXJhbCBmaXhl
cywgd2hpY2ggd2VyZSBpZGVudGlmaWVkIGFuZCBzZW50IHNlcGFyYXRlbHksDQo+IGJ1dCBu
b3cgdGhleSBhcmUgcHV0IHRvZ2V0aGVyIGluIGNvbXBsZXRlbmVzcyBoZXJlLg0KPiANCj4g
Q3VycmVudCBzZXJpZXMgZGVwZW5kcyBvbiB0aGUgc2VyaWVzIHdoaWNoIGhhcyBiZWVuIGFs
cmVhZHkgcHVzaGVkDQo+IHRvIHhlbi90aXAuZ2l0IGZvci1saW51cy02LjE6DQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3hlbi1kZXZlbC8yMDIyMTAwNTE3NDgyMy4xODAwNzYxLTEt
b2xla3N0eXNoQGdtYWlsLmNvbS8NCj4gDQo+IE9sZWtzYW5kciBUeXNoY2hlbmtvICgyKToN
Cj4gICAgeGVuL3ZpcnRpbzogSGFuZGxlIGNhc2VzIHdoZW4gcGFnZSBvZmZzZXQgPiBQQUdF
X1NJWkUgcHJvcGVybHkNCj4gICAgeGVuL3ZpcnRpbzogQ29udmVydCBQQUdFX1NJWkUvUEFH
RV9TSElGVC9QRk5fVVAgdG8gWGVuIGNvdW50ZXJwYXJ0cw0KPiANCj4gICBkcml2ZXJzL3hl
bi9ncmFudC1kbWEtb3BzLmMgfCAyNyArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+
IA0KDQpTZXJpZXMgcHVzaGVkIHRvIHhlbi90aXAuZ2l0IGZvci1saW51cy02LjENCg0KDQpK
dWVyZ2VuDQo=
--------------5qRwEWviQKbHG4KAYZSOidAj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------5qRwEWviQKbHG4KAYZSOidAj--

--------------Lesnbvd9TdY7cIVfEpMuttXX--

--------------OeieXWXVTqu81zQgSRYSEdaA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNKvckFAwAAAAAACgkQsN6d1ii/Ey+r
2gf/beNL0ZfFOxyxjGRyA7nxjMwrATwOY6kF9Bd6uSsJEwr9kiug1NCAecdGGKGdk+5HuoBC/JP2
LIdzo2hqFYa4IFhWKrgtUrMvjMoxb80yXtGcVLPKtHuFz9rhqHIuQY3h+/gnVjkpcUCSi9sRrKAQ
Yas0DgCLR4drl8rCsPovC2jKtjPUolHLsz4NTmEGPu4mGblrR70DKMIMgonxLtquZ1T5H82ESgbj
18RUpN3Qm8B9Mq2r0/nBJ8UyoEXzNsTCxZUNlZHUu+qohuvpZHR9uWO8lKT+PYDT5+BEvsu+Sl1B
lvSimVD3jyJoN6CSnp5vM4rvpowSaVzQt/6selapOg==
=/AU/
-----END PGP SIGNATURE-----

--------------OeieXWXVTqu81zQgSRYSEdaA--
