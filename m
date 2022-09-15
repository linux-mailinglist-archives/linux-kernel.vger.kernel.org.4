Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7D5B98AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIOKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIOKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:20:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047746D86
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:20:34 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8BDC338F0;
        Thu, 15 Sep 2022 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663237232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhCePKYJ0tLeg3/2ELCexaxAxIag9Q8crxOOmoxZ4DI=;
        b=OSVd22bhANnJOZaYiZ5Lfb723Nx8fgTdw6AY7I/f5Lifn1KSGFPXFv9iMFGAdfEh8kjp79
        +W4tQLQgQSoLkZd/wtpqjc4lE/N+XDleuNsOSjMYei7zJZhaYWAFsy1LnvpW4FLZZ8v8X4
        QgEoRNgoRBiYNc0N3dsOo/65JWbqwAI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A437F132BD;
        Thu, 15 Sep 2022 10:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oDKvJnD8ImP5NQAAGKfGzw
        (envelope-from <jgross@suse.com>); Thu, 15 Sep 2022 10:20:32 +0000
Message-ID: <4a95c3d1-d4e8-9b59-8db8-231b59cdb8f5@suse.com>
Date:   Thu, 15 Sep 2022 12:20:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] xen/privcmd: remove privcmd_ioctl_mmap()
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20220915083944.10097-1-jgross@suse.com>
 <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Q7QhaY2nHUQ8dW2e63hvwHvn"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Q7QhaY2nHUQ8dW2e63hvwHvn
Content-Type: multipart/mixed; boundary="------------zOFfHkeq8k55aRjmtD0rMPzf";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <4a95c3d1-d4e8-9b59-8db8-231b59cdb8f5@suse.com>
Subject: Re: [PATCH] xen/privcmd: remove privcmd_ioctl_mmap()
References: <20220915083944.10097-1-jgross@suse.com>
 <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com>
In-Reply-To: <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com>

--------------zOFfHkeq8k55aRjmtD0rMPzf
Content-Type: multipart/mixed; boundary="------------di5Y7bRE4bzUsm9soBTDm6Mu"

--------------di5Y7bRE4bzUsm9soBTDm6Mu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDkuMjIgMTE6MzIsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxNS4wOS4yMDIy
IDEwOjM5LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gVGhlIElPQ1RMX1BSSVZDTURfTU1B
UCBpc24ndCBpbiB1c2UgYnkgWGVuIHNpbmNlIGF0IGxlYXN0IFhlbiA0LjAuDQo+Pg0KPj4g
UmVtb3ZlIGl0IGZyb20gdGhlIHByaXZjbWQgZHJpdmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gDQo+IENhbiB3ZSByZWFz
b25hYmx5IHJlbW92ZSBhbiBJT0NUTCwgd2l0aG91dCBiZWluZyBlbnRpcmVseSBjZXJ0YWlu
IHRoYXQNCj4gbm8gdXNlcnMgZXhpc3Qgb3V0c2lkZSBvZiB4ZW4uZ2l0Pw0KDQpUaGlzIGlz
IGEgdmFsaWQgcXVlc3Rpb24uIEknbSBub3Qgc3VyZSBob3cgcHJvYmFibGUgaXQgaXMgdGhh
dCBzdWNoIGEgdXNlcg0KaXMgZXhpc3RpbmcuIEFyZSB0aGVyZSBhbnkgWGVuIHRvb2wgc3Rh
Y2tzIG5vdCB1c2luZyB0aGUgWGVuIGxpYnJhcmllcz8NCg0KSWYgc28sIHdoeT8gRG8gd2Ug
d2FudCB0byBzdXBwb3J0IHRob3NlIHVzZSBjYXNlcz8NCg0KPiBFdmVuIGlmIHNvLCBzaG91
bGRuJ3QgdGhlcmUgYmUgYQ0KPiBzdGFnZWQgZGVwcmVjYXRpb24gcHJvY2Vzcz8NCg0KRGVw
ZW5kcyBvbiB0aGUgYW5zd2VyIHRvIGFib3ZlIHF1ZXN0aW9ucy4NCg0KDQpKdWVyZ2VuDQo=

--------------di5Y7bRE4bzUsm9soBTDm6Mu
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------di5Y7bRE4bzUsm9soBTDm6Mu--

--------------zOFfHkeq8k55aRjmtD0rMPzf--

--------------Q7QhaY2nHUQ8dW2e63hvwHvn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMi/HAFAwAAAAAACgkQsN6d1ii/Ey+J
Wwf/dqSi4udORAWWWkoB3jGSosa2tXXbXdxOUQdfbXCM6UQwer9J+Gu/IjD6ArMFIeUKMRJEf4bM
CHAB+rZRg6RTWFqESi64lETQoLf1XPZo6/+sdjZQt/cragMrtZ2dYlVxqrSZLmNVUSxMAn8a72qI
On6qu2/ZhCGI7+z8r5St8jmlMiExXAshh3zGn6Y80M6evONXEVJNAPgLioH+AZ2xmBo5Nhd0aFjA
v+cMl1CUxv5z9ORAaEHgEwJ/enYopNz4laAdvFC+LyHmBK++REXER5FOuB5RSUNFF4JTu4Ec+GEu
qfvlstLzE+9YxdnkytM4bQ1/KLQhF9WxG7adZkI+Tw==
=ozXT
-----END PGP SIGNATURE-----

--------------Q7QhaY2nHUQ8dW2e63hvwHvn--
