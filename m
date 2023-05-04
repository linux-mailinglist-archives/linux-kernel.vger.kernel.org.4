Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D16F66B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEDIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjEDIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:03:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E154494
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:02:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B74D1338D7;
        Thu,  4 May 2023 08:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683187360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7i7LEAd3fADBjgmnL94UzS3BbhLvumMQ4AwQheLdrzE=;
        b=mvTmbdbQk02z24xj3lLzuCQ1eeNLtkq5L4VUxTjPEIOh96wUPHJKtFA/nDtMybNPPr6ZGx
        5SWfxuDtAHLpZVIs12OfR0vemCIcWgwwlY71maLPt5SEr8iZoTBeqz89a6ZuFzvUN+wo0E
        vhRIGwDK3SUxvaqlXPSJHTPJZL0Gjbk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76B3E133F7;
        Thu,  4 May 2023 08:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cbOnG6BmU2QrKAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 04 May 2023 08:02:40 +0000
Message-ID: <dce291a8-c791-36f5-ec04-3b1648668330@suse.com>
Date:   Thu, 4 May 2023 10:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 01/16] x86/mtrr: remove physical address size
 calculation
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-2-jgross@suse.com>
 <20230504074733.GAZFNjFeptgXvizi3J@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230504074733.GAZFNjFeptgXvizi3J@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------igpAi0QSZmI2POXGPIxO0sG1"
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------igpAi0QSZmI2POXGPIxO0sG1
Content-Type: multipart/mixed; boundary="------------dyt1ZdZJfnZ08RT8poJmLYTo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, mikelley@microsoft.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <dce291a8-c791-36f5-ec04-3b1648668330@suse.com>
Subject: Re: [PATCH v6 01/16] x86/mtrr: remove physical address size
 calculation
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-2-jgross@suse.com>
 <20230504074733.GAZFNjFeptgXvizi3J@fat_crate.local>
In-Reply-To: <20230504074733.GAZFNjFeptgXvizi3J@fat_crate.local>

--------------dyt1ZdZJfnZ08RT8poJmLYTo
Content-Type: multipart/mixed; boundary="------------TWtM0K6dfnTCny4Yzz0gucvp"

--------------TWtM0K6dfnTCny4Yzz0gucvp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDUuMjMgMDk6NDcsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBN
YXkgMDIsIDIwMjMgYXQgMDI6MDk6MTZQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jIGIv
YXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYw0KPj4gaW5kZXggZWUwOWQzNTll
MDhmLi4zOTIyNTUyMzQwYjEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1
L210cnIvZ2VuZXJpYy5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvZ2Vu
ZXJpYy5jDQo+PiBAQCAtMzgsNiArMzgsMTYgQEAgdTY0IG10cnJfdG9tMjsNCj4+ICAgc3Ry
dWN0IG10cnJfc3RhdGVfdHlwZSBtdHJyX3N0YXRlOw0KPj4gICBFWFBPUlRfU1lNQk9MX0dQ
TChtdHJyX3N0YXRlKTsNCj4+ICAgDQo+PiArc3RhdGljIHU2NCBzaXplX29yX21hc2ssIHNp
emVfYW5kX21hc2s7DQo+PiArDQo+PiArdm9pZCBfX2luaXQgbXRycl9zZXRfbWFzayh2b2lk
KQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IHBoeXNfYWRkciA9IGJvb3RfY3B1X2RhdGEu
eDg2X3BoeXNfYml0czsNCj4+ICsNCj4+ICsJc2l6ZV9vcl9tYXNrID0gfkdFTk1BU0tfVUxM
KHBoeXNfYWRkciAtIFBBR0VfU0hJRlQgLSAxLCAwKTsNCj4+ICsJc2l6ZV9hbmRfbWFzayA9
IH5zaXplX29yX21hc2sgJiBHRU5NQVNLX1VMTCgzOSwgMjApOw0KPiANCj4gV2hhdCBoYXBw
ZW5lZCB0byBnZXR0aW5nIHJpZCBvZiB0aG9zZToNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3IvMjAyMzA0MDUyMDI2MzMuR0ZaQzNaZVZXdG1qa09EWVc3QGZhdF9jcmF0ZS5s
b2NhbA0KPiANCj4gYW5kIHVzaW5nIHRoZSByZXNlcnZlZCBiaXRmaWVsZCBtYXNrcyBhcyB0
aGV5J3JlIGRlZmluZWQgZm9yIHRoZSBNU1JzPw0KPiANCg0KU2VlIHBhdGNoIDIuDQoNCg0K
SnVlcmdlbg0K
--------------TWtM0K6dfnTCny4Yzz0gucvp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TWtM0K6dfnTCny4Yzz0gucvp--

--------------dyt1ZdZJfnZ08RT8poJmLYTo--

--------------igpAi0QSZmI2POXGPIxO0sG1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRTZqAFAwAAAAAACgkQsN6d1ii/Ey8Q
zQf/RcYvRV35Uud1Rw8VP5Rz8LpvMSAUZl8s80So6iW3a8HiJLN2VxZrMeuuw+c/+MZm//S10R08
504ON72b3X6CkNm/k01dco6j40ukPpQX8pQWBuWDASl3ZfESxP2FhLM2QazqxBM08Th4J6AGpiPs
Ox6QrWshr4z1Y8uxY6QvYms3ZEFb4nBn5CZmkbxVqdSl490QI889anKxfn3V+oJB0CWXIPDyO0HR
jv4sz6tqpSBmyeGrsnDFKBJW0O2aHIh4HbwMQ3s1vkwJjpxX0AR1aDIGl3GUrSs/U3LrCqWA4cqs
vc5auAuhFhCBq18DkAWGSW0PVUvtCBLYFVtxt06Z3g==
=CbS9
-----END PGP SIGNATURE-----

--------------igpAi0QSZmI2POXGPIxO0sG1--
