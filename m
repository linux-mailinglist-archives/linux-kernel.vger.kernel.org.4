Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD9746A44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGDHC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjGDHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:02:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A4EEE;
        Tue,  4 Jul 2023 00:02:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E92B224C5;
        Tue,  4 Jul 2023 07:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688454143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I2wmCXpl436Dp8ZP2JM7afvCQOhr1hfCC2vxh1ZCMho=;
        b=bn443TypRb0QJOcKUIKKDBJ9iTJpFltDCrtc+5qGKaxTKetUK7xwPl8YdC5TXKW5atUxYM
        XF89NTrHY0zxyeqHS0SZElzSum7Qx+ZiM1PDIgHWs5N+H51231BYHgHnCHrTiz7UOp3QSL
        WY6oBYdrHUb3H3DRJkYT5WX38FvyP94=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C182133F7;
        Tue,  4 Jul 2023 07:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4NFmBf/Do2TKAQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Jul 2023 07:02:23 +0000
Message-ID: <0a05588e-68d3-1550-4c21-e282f4d66060@suse.com>
Date:   Tue, 4 Jul 2023 09:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <JBeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20230627172216.1359-1-demi@invisiblethingslab.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] xen: speed up grant-table reclaim
In-Reply-To: <20230627172216.1359-1-demi@invisiblethingslab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MNrRNEu0Gn5vUM6zQYoVYHAv"
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
--------------MNrRNEu0Gn5vUM6zQYoVYHAv
Content-Type: multipart/mixed; boundary="------------B37XGpMk5E2SqDCYefhE8oq7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jan Beulich <JBeulich@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xen developer discussion <xen-devel@lists.xenproject.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Message-ID: <0a05588e-68d3-1550-4c21-e282f4d66060@suse.com>
Subject: Re: [PATCH v3] xen: speed up grant-table reclaim
References: <20230627172216.1359-1-demi@invisiblethingslab.com>
In-Reply-To: <20230627172216.1359-1-demi@invisiblethingslab.com>

--------------B37XGpMk5E2SqDCYefhE8oq7
Content-Type: multipart/mixed; boundary="------------xtWTFltP0EaZv0PU6Wx3Xf2W"

--------------xtWTFltP0EaZv0PU6Wx3Xf2W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDYuMjMgMTk6MjIsIERlbWkgTWFyaWUgT2Jlbm91ciB3cm90ZToNCj4gV2hlbiBh
IGdyYW50IGVudHJ5IGlzIHN0aWxsIGluIHVzZSBieSB0aGUgcmVtb3RlIGRvbWFpbiwgTGlu
dXggbXVzdCBwdXQNCj4gaXQgb24gYSBkZWZlcnJlZCBsaXN0LiAgTm9ybWFsbHksIHRoaXMg
bGlzdCBpcyB2ZXJ5IHNob3J0LCBiZWNhdXNlDQo+IHRoZSBQViBuZXR3b3JrIGFuZCBibG9j
ayBwcm90b2NvbHMgZXhwZWN0IHRoZSBiYWNrZW5kIHRvIHVubWFwIHRoZSBncmFudA0KPiBm
aXJzdC4gIEhvd2V2ZXIsIFF1YmVzIE9TJ3MgR1VJIHByb3RvY29sIGlzIHN1YmplY3QgdG8g
dGhlIGNvbnN0cmFpbnRzDQo+IG9mIHRoZSBYIFdpbmRvdyBTeXN0ZW0sIGFuZCBhcyBzdWNo
IHdpbmRzIHVwIHdpdGggdGhlIGZyb250ZW5kIHVubWFwcGluZw0KPiB0aGUgd2luZG93IGZp
cnN0LiAgQXMgYSByZXN1bHQsIHRoZSBsaXN0IGNhbiBncm93IHZlcnkgbGFyZ2UsIHJlc3Vs
dGluZw0KPiBpbiBhIG1hc3NpdmUgbWVtb3J5IGxlYWsgYW5kIGV2ZW50dWFsIFZNIGZyZWV6
ZS4NCj4gDQo+IFRvIHBhcnRpYWxseSBzb2x2ZSB0aGlzIHByb2JsZW0sIG1ha2UgdGhlIG51
bWJlciBvZiBlbnRyaWVzIHRoYXQgdGhlIFZNDQo+IHdpbGwgYXR0ZW1wdCB0byBmcmVlIGF0
IGVhY2ggaXRlcmF0aW9uIHR1bmFibGUuICBUaGUgZGVmYXVsdCBpcyBzdGlsbA0KPiAxMCwg
YnV0IGl0IGNhbiBiZSBvdmVycmlkZGVuIGF0IGNvbXBpbGUtdGltZSAodmlhIEtjb25maWcp
LCBib290LXRpbWUNCj4gKHZpYSBhIGtlcm5lbCBjb21tYW5kLWxpbmUgb3B0aW9uKSwgb3Ig
cnVudGltZSAodmlhIHN5c2ZzKS4NCg0KWW91IGFyZSBzdGlsbCBtZW50aW9uaW5nIEtjb25m
aWcuDQoNCkZvciB0aGUgc3lzZnMgZW50cnkgeW91IHNob3VsZCBhZGQgc29tZXRoaW5nIHVu
ZGVyIERvY3VtZW50YXRpb24vQUJJLiBTb3JyeQ0KSSBkaWRuJ3Qgc3BvdCB0aGlzIG9taXNz
aW9uIHByZXZpb3VzbHkuDQoNCg0KSnVlcmdlbg0K
--------------xtWTFltP0EaZv0PU6Wx3Xf2W
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xtWTFltP0EaZv0PU6Wx3Xf2W--

--------------B37XGpMk5E2SqDCYefhE8oq7--

--------------MNrRNEu0Gn5vUM6zQYoVYHAv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSjw/4FAwAAAAAACgkQsN6d1ii/Ey86
+Qf7BVc79+MQbLa9SjzT0G9ygKhf8N61XHUt58BIVHzXuBPyl08NthIgPjR1XAkwDhjb9gk1TFTR
thYepMpEXviC9KuSUeNiVJ0Z64VobeQ2cCuyQ7r6MHWJSLZLtjXjH3/bXnEwXe03k0pZ3Qt0HM+1
aObCnEc26vVpbkc4tmU3W0OlZDq7w9QkVZG21qm8c+GSx3UYTQkfBE5/4s6gisF1+tDinDY0cif7
Nynh+/Ga+5bkhQ5EPHL3CXNZNtmRvzzA/SEWXAlHKEdH7JpQpwUskbzQqoBCWnk58U1np22t7VWt
qKPso3z45GZxSU6UYw8i6hMOjgi0SkEmiIVTXXvI4g==
=3vJC
-----END PGP SIGNATURE-----

--------------MNrRNEu0Gn5vUM6zQYoVYHAv--
