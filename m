Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851C6C29FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCUFrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:46:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE01B2FD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:46:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 641211FD6C;
        Tue, 21 Mar 2023 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679377614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=37GC4VJhAC/IqstfkyAnKas1JN15Zt+fTln7QOtrFUs=;
        b=VAggRJLnp8rbYKHl+wljY5aLbvkJN/GUFYXu3kG/U2WSPqPx0R1BSF1ljNEcq4hj0Z6069
        yLB0titeSBYEPtNkrDJM5NILJJI9QtOHac4v7mnpkmTJ/wm6MkqPUAt7Hkx+vslZBk7j7E
        LlhNV/4UJdxcrGVUGjLIyLBYuenjfjs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2598213443;
        Tue, 21 Mar 2023 05:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yV6hB85EGWTpSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 21 Mar 2023 05:46:54 +0000
Message-ID: <2b292b59-0b9b-b752-de5f-f057cd84c671@suse.com>
Date:   Tue, 21 Mar 2023 06:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC smp] Remove diagnostics and adjust config for CSD lock
 diagnostics
Content-Language: en-US
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, corbet@lwn.net
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------17c90BvlF6G6Jf6ZDVy7B32e"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------17c90BvlF6G6Jf6ZDVy7B32e
Content-Type: multipart/mixed; boundary="------------20fBpv9ceUnE2Cg6StICYAEX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, rostedt@goodmis.org, mingo@kernel.org,
 peterz@infradead.org, corbet@lwn.net
Message-ID: <2b292b59-0b9b-b752-de5f-f057cd84c671@suse.com>
Subject: Re: [PATCH RFC smp] Remove diagnostics and adjust config for CSD lock
 diagnostics
References: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
In-Reply-To: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>

--------------20fBpv9ceUnE2Cg6StICYAEX
Content-Type: multipart/mixed; boundary="------------wOxAHOmBs6kh7hWJgvr26y7P"

--------------wOxAHOmBs6kh7hWJgvr26y7P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDMuMjMgMDE6NTQsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+IEhlbGxvIQ0K
PiANCj4gVGhpcyBzZXJpZXMgcmVtb3ZlcyBDU0QtbG9jayBkaWFnbm9zdGljcyB0aGF0IHdl
cmUgb25jZSB2ZXJ5IHVzZWZ1bA0KPiBidXQgd2hpY2ggaGF2ZSBub3Qgc2VlbiBtdWNoIGFj
dGlvbiBzaW5jZS4gIEl0IGFsc28gYWRqdXN0cyBLY29uZmlnIGFuZA0KPiBrZXJuZWwtYm9v
dC1wYXJhbWV0ZXIgc2V0dXAuDQo+IA0KPiAxLglsb2NraW5nL2NzZF9sb2NrOiBBZGQgS2Nv
bmZpZyBvcHRpb24gZm9yIGNzZF9kZWJ1ZyBkZWZhdWx0Lg0KPiANCj4gMi4JbG9ja2luZy9j
c2RfbG9jazogUmVtb3ZlIGFkZGVkIGRhdGEgZnJvbSBDU0QgbG9jayBkZWJ1Z2dpbmcuDQo+
IA0KPiAzLglsb2NraW5nL2NzZF9sb2NrOiBSZW1vdmUgcGVyLUNQVSBkYXRhIGluZGlyZWN0
aW9uIGZyb20gQ1NEDQo+IAlsb2NrIGRlYnVnZ2luZy4NCj4gDQo+IDQuCWtlcm5lbC9zbXA6
IE1ha2UgY3NkbG9ja19kZWJ1Zz0gcmVzZXR0YWJsZS4NCj4gDQo+IAkJCQkJCVRoYW54LCBQ
YXVsDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+ICAgRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgICB8ICAgMTcgLQ0KPiAgIGIvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgfCAgICA2DQo+
ICAgYi9rZXJuZWwvc21wLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDINCj4gICBiL2xpYi9LY29uZmlnLmRlYnVnICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgOQ0KPiAgIGtlcm5lbC9zbXAuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMjYwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICA1IGZp
bGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDI0NyBkZWxldGlvbnMoLSkNCg0KRm9y
IHRoZSBzZXJpZXM6DQoNCkFja2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+DQoNCg0KSnVlcmdlbg0K
--------------wOxAHOmBs6kh7hWJgvr26y7P
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------wOxAHOmBs6kh7hWJgvr26y7P--

--------------20fBpv9ceUnE2Cg6StICYAEX--

--------------17c90BvlF6G6Jf6ZDVy7B32e
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQZRM0FAwAAAAAACgkQsN6d1ii/Ey9V
TAf/V6Aq6zo/cHjHRK2Xz0Zwc8JVbGELCS6NxMyoK2tuEIGsCcFEln+GwUu9s/FEFeoy5dKbVVAv
upjsMx4sj1wPrkhqFjfCjsM8m88a+3JR7zlYw1g83ZH97ZF5Hv8IHWRvifX7U4B24Xlj9P4mISb7
OHKbeNjmXKop+dXCshyljyAGK250nj4Y5A6oriwDMDNxZqSx8A1/ODmBrTIqXcLpknShijXaoJAT
CSD/rfqEvwwZlqciVd75QxzhcWtT4zhKmGsEOQ+OFKvDfOEkmkGPYRz2e+9TB7dQgVgn2d4QmmxE
F1tI7XtUzPhY09SQV1tfvVfK1Q879R8FP2IIPCRyWw==
=dBlt
-----END PGP SIGNATURE-----

--------------17c90BvlF6G6Jf6ZDVy7B32e--
