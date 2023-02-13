Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE9693F78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBMIUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBMIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:20:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506CD126D8;
        Mon, 13 Feb 2023 00:20:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A2BE37706;
        Mon, 13 Feb 2023 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676276423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T67QN63umXnc0fRsL1qO+KXl0rONIm141v5QsXiqc7U=;
        b=nIZERco8BTO8Q9GkwypnEoUodoHwrDRZ6gVAHupOktjw74RpgcU3SdsiVBy8zC1nCXIOpV
        RNTMh5kE5zg8GlrELal5E9+o2kSFYYG9AJlort/DtAHv9MjyB3sfVyvWJ/jvt05uQa3Mw2
        ygeiym/agAdWVhgk22j2m/6qu2gh3n8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E345F138E6;
        Mon, 13 Feb 2023 08:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x741Nsby6WPDNgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 08:20:22 +0000
Message-ID: <589edfa4-ae52-49dd-08b2-25ffb506084a@suse.com>
Date:   Mon, 13 Feb 2023 09:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH][next] xen: Replace one-element array with flexible-array
 member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <Y9xjN6Wa3VslgXeX@work>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y9xjN6Wa3VslgXeX@work>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mUBn580fjrlxklzUomy0ToCm"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mUBn580fjrlxklzUomy0ToCm
Content-Type: multipart/mixed; boundary="------------MEG0JBht7zMjbG92DYZ0qhxr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Message-ID: <589edfa4-ae52-49dd-08b2-25ffb506084a@suse.com>
Subject: Re: [PATCH][next] xen: Replace one-element array with flexible-array
 member
References: <Y9xjN6Wa3VslgXeX@work>
In-Reply-To: <Y9xjN6Wa3VslgXeX@work>

--------------MEG0JBht7zMjbG92DYZ0qhxr
Content-Type: multipart/mixed; boundary="------------ZuHhLaWGSyu994BrV7gofsrQ"

--------------ZuHhLaWGSyu994BrV7gofsrQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDIuMjMgMDI6MjgsIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+IE9uZS1l
bGVtZW50IGFycmF5cyBhcmUgZGVwcmVjYXRlZCwgYW5kIHdlIGFyZSByZXBsYWNpbmcgdGhl
bSB3aXRoIGZsZXhpYmxlDQo+IGFycmF5IG1lbWJlcnMgaW5zdGVhZC4gU28sIHJlcGxhY2Ug
b25lLWVsZW1lbnQgYXJyYXkgd2l0aCBmbGV4aWJsZS1hcnJheQ0KPiBtZW1iZXIgaW4gc3Ry
dWN0IHhlbl9wYWdlX2RpcmVjdG9yeS4NCj4gDQo+IFRoaXMgaGVscHMgd2l0aCB0aGUgb25n
b2luZyBlZmZvcnRzIHRvIHRpZ2h0ZW4gdGhlIEZPUlRJRllfU09VUkNFDQo+IHJvdXRpbmVz
IG9uIG1lbWNweSgpIGFuZCBoZWxwIHVzIG1ha2UgcHJvZ3Jlc3MgdG93YXJkcyBnbG9iYWxs
eQ0KPiBlbmFibGluZyAtZnN0cmljdC1mbGV4LWFycmF5cz0zIFsxXS4NCj4gDQo+IFRoaXMg
cmVzdWx0cyBpbiBubyBkaWZmZXJlbmNlcyBpbiBiaW5hcnkgb3V0cHV0Lg0KPiANCj4gTGlu
azogaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzc5DQo+IExpbms6IGh0
dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy8yNTUNCj4gTGluazogaHR0cHM6
Ly9nY2MuZ251Lm9yZy9waXBlcm1haWwvZ2NjLXBhdGNoZXMvMjAyMi1PY3RvYmVyLzYwMjkw
Mi5odG1sIFsxXQ0KPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0
YXZvYXJzQGtlcm5lbC5vcmc+DQoNClB1c2hlZC10bzogeGVuL3RpcC5naXQgZm9yLWxpbnVz
LTYuMw0KDQoNCkp1ZXJnZW4NCg0K
--------------ZuHhLaWGSyu994BrV7gofsrQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ZuHhLaWGSyu994BrV7gofsrQ--

--------------MEG0JBht7zMjbG92DYZ0qhxr--

--------------mUBn580fjrlxklzUomy0ToCm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp8sYFAwAAAAAACgkQsN6d1ii/Ey+z
iggAlU6pTFIxYTeG+qBwseJU8IrA0YQD3rA/JBTv+2jARNlwIGkEwuZL5sAy6zYiIbGT6hADym+u
WfKfojYMs2mEmylJBPQCgDWpW9K2924G7btecf3T5DPdqAeR9VkMMg2Y1eLPZ23xZA0Hc9xIreP8
5pRH3T966LJOXzn5J4nDCrU8fwSgUhIKmeSNw5kToVTkJKpdFmjd0zfO94ymQmMGEm0n8m184iUk
4O1SjtrSWG07d8UOqIvHlZpfGnabh6jY5h01oUS/i8DVqI76YT4/HBl/ze7I2T+zaUE1n7yuj8go
6JpL9C/kOGxzovfKVvw7WbdEUt2YOMSVNBEiJrVYkw==
=6d2w
-----END PGP SIGNATURE-----

--------------mUBn580fjrlxklzUomy0ToCm--
