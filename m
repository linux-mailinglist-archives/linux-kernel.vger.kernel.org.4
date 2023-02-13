Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636A693E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBMGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBMGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:08:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0010415
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:08:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C92B75CD3C;
        Mon, 13 Feb 2023 06:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676268521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qsfFqmri5VeQIOhbx6oyEbILXronAHFdX2A+uUxFdTU=;
        b=eywu+bkq9YYWahXnvmexCTHlOnqIOmbOY/AyFhN8FGr4F9qSafaxVXvh8AHeFLDKeoSrKg
        8pnogMYZ6LVQK6mZuAdj40BTet0aNsBlgg6c4eC5/ayGefyaD5ZqVzM/qk2qOWMOZdUyh2
        7fz6TAdrfaQ60sqG/c7AENoYv83Ara0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AC3A1391B;
        Mon, 13 Feb 2023 06:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s0WBGOnT6WOHfAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 06:08:41 +0000
Message-ID: <e380b3bb-a3d3-7d69-5fed-8deaa2dc22d1@suse.com>
Date:   Mon, 13 Feb 2023 07:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <92a63877e054775884d9c7a7d15ed613cc3059bc.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <92a63877e054775884d9c7a7d15ed613cc3059bc.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0eay34a5BonW7A00EkUb5aak"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0eay34a5BonW7A00EkUb5aak
Content-Type: multipart/mixed; boundary="------------0GzQjwRXLBkYtGhs2kzzt3Bz";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "Torvalds, Linus" <torvalds@linux-foundation.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "Lutomirski, Andy" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>
Message-ID: <e380b3bb-a3d3-7d69-5fed-8deaa2dc22d1@suse.com>
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <92a63877e054775884d9c7a7d15ed613cc3059bc.camel@intel.com>
In-Reply-To: <92a63877e054775884d9c7a7d15ed613cc3059bc.camel@intel.com>

--------------0GzQjwRXLBkYtGhs2kzzt3Bz
Content-Type: multipart/mixed; boundary="------------76R72q0ufuH0XtBRAVkE44d4"

--------------76R72q0ufuH0XtBRAVkE44d4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDIuMjMgMDE6MDYsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiBPbiBUaHUs
IDIwMjMtMDItMDkgYXQgMDg6MjIgKzAxMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJs
ZS5jDQo+PiBpbmRleCBlNGY0OTllYjBmMjkuLjdiOWM1NDQzZDE3NiAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gveDg2L21tL3BndGFibGUuYw0KPj4gKysrIGIvYXJjaC94ODYvbW0vcGd0YWJs
ZS5jDQo+PiBAQCAtNzIxLDggKzcyMSw3IEBAIGludCBwdWRfc2V0X2h1Z2UocHVkX3QgKnB1
ZCwgcGh5c19hZGRyX3QgYWRkciwNCj4+IHBncHJvdF90IHByb3QpDQo+PiAgICAgICAgICB1
OCBtdHJyLCB1bmlmb3JtOw0KPiANCj4gJ210cnInIGlzIG5vdyB1bnVzZWQuIENhbiBpdCBi
ZSBkcm9wcGVkPyBTYW1lIGZvciB0aGUgcG1kX3NldF9odWdlKCkuDQoNCkkgZ3Vlc3MgaXQg
d2lsbCBiZSB1c2VkIGFnYWluLCBkdWUgdG8gdGhlIGNvbW1lbnQgeW91IG1hZGUgZm9yIHRo
ZSB3aG9sZQ0Kc2VyaWVzLg0KDQoNCkp1ZXJnZW4NCg==
--------------76R72q0ufuH0XtBRAVkE44d4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------76R72q0ufuH0XtBRAVkE44d4--

--------------0GzQjwRXLBkYtGhs2kzzt3Bz--

--------------0eay34a5BonW7A00EkUb5aak
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp0+kFAwAAAAAACgkQsN6d1ii/Ey9Y
FQgAjnaoNExP4iUDzoAzfYa1HgaiCQJaSyzU7VUwirVDx5JX/E4daA6HdABnz6JRxR3tPYh0Zr8U
MdXk5cgPJm8MzV0XYitxkRc2nTzUCj4gP/PrhowYUKJ01wPhhxXCzMotPbwk321ExoSUvq/X91J4
fOeMjHcmAatk2aGyUcmTdl5p1SLg8NRP971/BmZz8VBBNro/yZCrOTIEa1ITag4ucyxCv957VujV
XJhkfHmWt7QK3JoqbpUZHozNP+kP2Z9ZfpIxR+xeihyXeXGfffwrsgd6l7T1gOmNOoQh3XUgoIVo
od8uNF+OUqRWJSqipqZt1QZLxiIZ74uFNP7G8oV0iA==
=zClw
-----END PGP SIGNATURE-----

--------------0eay34a5BonW7A00EkUb5aak--
