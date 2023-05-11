Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485E96FED73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjEKIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjEKIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:05:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750E2684
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:05:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 459E72189D;
        Thu, 11 May 2023 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683792355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhD2nQXEvUKkjKoAXqg0T6rcqGBuxn+66YJTxoOvIQA=;
        b=k7tF9kFqaRqL0KdhII7mVJghE6Ypa/0GxpeIQ47f6CxdtAB9FeMI1zgqAFs8D0PnzocYBg
        880AAAaUhhVFpIOtawDLpCsykPNQV9U/j+dT9UtQQVnI5juQirQJfpk1DOBGac690SErFj
        Ocn4cla1TJzqoLMg36cJqiSvsJh76sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683792355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhD2nQXEvUKkjKoAXqg0T6rcqGBuxn+66YJTxoOvIQA=;
        b=Hk9B1oHrZzPTHF02evvrKtptKnUryygYaXaAkFmiX5SLUtJLi9HKV6hUhw2EQira+qZ8k/
        dmHAiZru+/tgpnDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1ED9E134B2;
        Thu, 11 May 2023 08:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rR+nBuOhXGSibQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 11 May 2023 08:05:55 +0000
Message-ID: <b8f673e9-1a89-c3b6-7801-5f2d2d2f6c7b@suse.de>
Date:   Thu, 11 May 2023 10:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] firmware/sysfb: Fix VESA format selection
Content-Language: en-US
To:     Pierre Asselin <pa@panix.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230420155705.21463-1-pa@panix.com>
 <2f4370b6-8426-400a-8be1-36a48dadccad@suse.de>
 <1f2a1e8ee99fc9f0a89ad47d112728c9.squirrel@mail.panix.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <1f2a1e8ee99fc9f0a89ad47d112728c9.squirrel@mail.panix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5DY0GRN0zHylaZNGkHuaJo00"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5DY0GRN0zHylaZNGkHuaJo00
Content-Type: multipart/mixed; boundary="------------dkyeW3W7xDuwTETfQPslEVLU";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Pierre Asselin <pa@panix.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Message-ID: <b8f673e9-1a89-c3b6-7801-5f2d2d2f6c7b@suse.de>
Subject: Re: [PATCH v3] firmware/sysfb: Fix VESA format selection
References: <20230420155705.21463-1-pa@panix.com>
 <2f4370b6-8426-400a-8be1-36a48dadccad@suse.de>
 <1f2a1e8ee99fc9f0a89ad47d112728c9.squirrel@mail.panix.com>
In-Reply-To: <1f2a1e8ee99fc9f0a89ad47d112728c9.squirrel@mail.panix.com>

--------------dkyeW3W7xDuwTETfQPslEVLU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTAuMDUuMjMgdW0gMTk6MjUgc2NocmllYiBQaWVycmUgQXNzZWxpbjoNCj4g
VGhvbWFzIFppbW1lcm1hbiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4gd3JpdGVzOg0KPj4NCj4+
IEkgZm91bmQgdGhpcyBjYXN0aW5nIG1lc3MgZXZlbiBtb3JlIHVucmVhZGFibGUuIEkgd2Vu
dCBiYWNrIHRvIHYyLCBmaXhlZA0KPj4gdGhlIHN0eWxlIGlzc3VlcyBhbmQgY29tbWl0dGVk
IHRoZSBwYXRjaCBhcyB2NCAoc3RpbGwgdW5kZXIgeW91ciBuYW1lKS4NCj4+DQo+PiBodHRw
czovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tdGlwL2NvbW1pdD9pZD0xYjYxN2Jj
OTMxNzg5MTJmYTM2Zjg3YTk1N2MxNWQxZjE3MDhjMjk5DQo+IA0KPiBXaWxsIHRoaXMgcGF0
Y2ggbWFrZSBpdCBpbnRvIExpbnV4IDYuNCA/DQoNCkl0IGFwcGVhcnMgdG8gYmUgc3R1Y2sg
aW4gdGhlIGRybS1taXNjLWZpeGVzIHRyZWUuIFRoZSB0aW1lIGFyb3VuZCB0aGUgDQptZXJn
ZSB3aW5kb3cgaXMgYWx3YXlzIGNvbXBsaWNhdGVkLiBJJ3ZlIHNlbmQgb3V0IGEgcmVtaW5k
ZXIgdG8gdGhlIA0KbWFpbnRhaW5lcnMgdG8gZmV0Y2ggdGhlIHBhdGNoLg0KDQpCZXN0IHJl
Z2FyZHMNClRob21hcw0KDQo+IA0KPiAtLVBBDQo+IA0KDQotLSANClRob21hcyBaaW1tZXJt
YW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBH
ZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwg
Qm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------dkyeW3W7xDuwTETfQPslEVLU--

--------------5DY0GRN0zHylaZNGkHuaJo00
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRcoeIFAwAAAAAACgkQlh/E3EQov+CG
1w//ejLLpCBzmdFAM5YxxufCSJJHp7XCLYVqIY1A6Z2H3MxpHX+6vDg1Pp6UerxqqmsfUT5OUZP8
0g/MVr8AP0vXy8tk2fUd/rYdTwbv3u8pdW3kaalRR9gLI/fLIdnTOP9lhMAoARXyjWVbdMsW91s1
+VWJRpxdvoMb6uRJcOu4896XUeL36y+PCfMe+aYz5AoRRKL0E3tUElKAYydiTe2hwR9Ogkl5+sCL
4Pv3J+igha9Pk1mtCx1/Li6/3ErNSqdEc0tdjD+LnnCYNWTsTYDB2zJZXkSjI4oxLicpEsFZPmkv
JknKz32EJi4Sh5FW3CmQVq6tWlPuK1F8nVJhfiL0ysvInfqGqPe8WDQByYpYQ4ukxqKKw+mloLcj
dEWX0EscjIYnwnGe6WZmb9ZB/KQLZGi3pOc3ABdjosbjxeDF79WvoswEsEsc8Bgf+k8LY3Q+9eUL
awYYtnE+EF31ArDg5pPwE+rjDgWHz/yJubZJIcTRC0H0rN/psNaTsSmDjR8dnG90ik6Eu5EmUX9w
lOYt2dk6ZJvAQygD6DvzvOkwi3BYlRcbATIce4DvYxR/dBnQ+FPaTXr3xYleJOSbBvbJnHIHQB9Y
4fGMz8rsi+hS/l+duB1CAT1EiP8+nu4uzvLXnp3jSnGQEyk1UAdSb1KjvRlqe4Q69I8Udgz61fC1
TJY=
=AJMs
-----END PGP SIGNATURE-----

--------------5DY0GRN0zHylaZNGkHuaJo00--
