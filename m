Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5A6734F4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjASKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjASKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:00:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FA6D340;
        Thu, 19 Jan 2023 02:00:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A02437DAE;
        Thu, 19 Jan 2023 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674122405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WflaWenmJHH4rAhtkZhIjHcrqAF9qidkuyy4Rr5CBd8=;
        b=AhU/ybjSimvlzIXHPra39UaLHQzGagZb7Cpdf3URHSe8Xr0dGXzI5BDhzPd2jttocKrWym
        0UFNdcrA/nxlhEsNAQ2Y7DvJ590rmyadgR/HTgQ3WNRjT0+29p47m+morcbQJi2BipdbQu
        jBBeroX0PjpzXT+lH+oozeNeWSh9KdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674122405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WflaWenmJHH4rAhtkZhIjHcrqAF9qidkuyy4Rr5CBd8=;
        b=XVfEjhAUiOjUU4lhVy103ayaLi7ZZFSrVBd+3nqKWdCTBskbIx0LXn1Ix5qNrROxe7skGU
        odrgdI8OOV0/IVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E802134F5;
        Thu, 19 Jan 2023 10:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id An81FqUUyWOBDgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 19 Jan 2023 10:00:05 +0000
Message-ID: <419f18fe-ad37-e6d4-1b8e-51f973f21d22@suse.de>
Date:   Thu, 19 Jan 2023 11:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        "Erhard F." <erhard_f@mailbox.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20230119095323.4659-1-msuchanek@suse.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230119095323.4659-1-msuchanek@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1TgcrI16NSSsDhFGOmuhbipA"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1TgcrI16NSSsDhFGOmuhbipA
Content-Type: multipart/mixed; boundary="------------jTb7U4Y01UjAcWDHQmJCQQhg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Michal Suchanek <msuchanek@suse.de>, "Erhard F." <erhard_f@mailbox.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 open list <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Message-ID: <419f18fe-ad37-e6d4-1b8e-51f973f21d22@suse.de>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
References: <20230119095323.4659-1-msuchanek@suse.de>
In-Reply-To: <20230119095323.4659-1-msuchanek@suse.de>

--------------jTb7U4Y01UjAcWDHQmJCQQhg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDE5LjAxLjIzIHVtIDEwOjUzIHNjaHJpZWIgTWljaGFsIFN1Y2hhbmVrOg0KPiBU
aGUgY29tbWl0IDJkNjgxZDZhMjNhMSAoIm9mOiBNYWtlIG9mIGZyYW1lYnVmZmVyIGRldmlj
ZXMgdW5pcXVlIikNCj4gYnJlYWtzIGJ1aWxkIGJlY2F1c2Ugb2Ygd3JvbmcgYXJndW1lbnQg
dG8gc25wcmludGYuIFRoYXQgY2VydGFpbmx5DQo+IGF2b2lkcyB0aGUgcnVudGltZSBlcnJv
ciBidXQgaXMgbm90IHRoZSBpbnRlbmRlZCBvdXRjb21lLg0KPiANCj4gQWxzbyB1c2Ugc3Rh
bmRhcmQgZGV2aWNlIG5hbWUgZm9ybWF0IG9mLWRpc3BsYXkuTiBmb3IgYWxsIGNyZWF0ZWQN
Cj4gZGV2aWNlcy4NCj4gDQo+IEZpeGVzOiAyZDY4MWQ2YTIzYTEgKCJvZjogTWFrZSBvZiBm
cmFtZWJ1ZmZlciBkZXZpY2VzIHVuaXF1ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBT
dWNoYW5layA8bXN1Y2hhbmVrQHN1c2UuZGU+DQoNClJldmlld2VkLWJ5OiBUaG9tYXMgWmlt
bWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCg0KVGhhbmtzIGFnYWluIGZvciB0YWtp
bmcgY2FyZSBvZiB0aGlzIGlzc3VlLg0KDQo+IC0tLQ0KPiB2MjogVXBkYXRlIHRoZSBkZXZp
Y2UgbmFtZSBmb3JtYXQNCj4gLS0tDQo+ICAgZHJpdmVycy9vZi9wbGF0Zm9ybS5jIHwgMTIg
KysrKysrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL3BsYXRmb3JtLmMg
Yi9kcml2ZXJzL29mL3BsYXRmb3JtLmMNCj4gaW5kZXggZjJhNWQ2NzlhMzI0Li44YzFiMWRl
MjIwMzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvb2YvcGxhdGZvcm0uYw0KPiArKysgYi9k
cml2ZXJzL29mL3BsYXRmb3JtLmMNCj4gQEAgLTUyNSw3ICs1MjUsOSBAQCBzdGF0aWMgaW50
IF9faW5pdCBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlX2luaXQodm9pZCkNCj4gICAJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX1BQQykpIHsNCj4gICAJCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqYm9vdF9kaXNwbGF5ID0gTlVMTDsNCj4gICAJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KmRldjsNCj4gLQkJaW50IGRpc3BsYXlfbnVtYmVyID0gMTsNCj4gKwkJaW50IGRpc3BsYXlf
bnVtYmVyID0gMDsNCj4gKwkJY2hhciBidWZbMTRdOw0KPiArCQljaGFyICpvZl9kaXNwbGF5
X2Zvcm1hdCA9ICJvZi1kaXNwbGF5LiVkIjsNCj4gICAJCWludCByZXQ7DQo+ICAgDQo+ICAg
CQkvKiBDaGVjayBpZiB3ZSBoYXZlIGEgTWFjT1MgZGlzcGxheSB3aXRob3V0IGEgbm9kZSBz
cGVjICovDQo+IEBAIC01NTYsNyArNTU4LDEwIEBAIHN0YXRpYyBpbnQgX19pbml0IG9mX3Bs
YXRmb3JtX2RlZmF1bHRfcG9wdWxhdGVfaW5pdCh2b2lkKQ0KPiAgIAkJCWlmICghb2ZfZ2V0
X3Byb3BlcnR5KG5vZGUsICJsaW51eCxvcGVuZWQiLCBOVUxMKSB8fA0KPiAgIAkJCSAgICAh
b2ZfZ2V0X3Byb3BlcnR5KG5vZGUsICJsaW51eCxib290LWRpc3BsYXkiLCBOVUxMKSkNCj4g
ICAJCQkJY29udGludWU7DQo+IC0JCQlkZXYgPSBvZl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRl
KG5vZGUsICJvZi1kaXNwbGF5IiwgTlVMTCk7DQo+ICsJCQlyZXQgPSBzbnByaW50ZihidWYs
IHNpemVvZihidWYpLCBvZl9kaXNwbGF5X2Zvcm1hdCwgZGlzcGxheV9udW1iZXIrKyk7DQo+
ICsJCQlpZiAocmV0ID49IHNpemVvZihidWYpKQ0KPiArCQkJCWNvbnRpbnVlOw0KPiArCQkJ
ZGV2ID0gb2ZfcGxhdGZvcm1fZGV2aWNlX2NyZWF0ZShub2RlLCBidWYsIE5VTEwpOw0KPiAg
IAkJCWlmIChXQVJOX09OKCFkZXYpKQ0KPiAgIAkJCQlyZXR1cm4gLUVOT01FTTsNCj4gICAJ
CQlib290X2Rpc3BsYXkgPSBub2RlOw0KPiBAQCAtNTY0LDEwICs1NjksOSBAQCBzdGF0aWMg
aW50IF9faW5pdCBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlX2luaXQodm9pZCkNCj4g
ICAJCX0NCj4gICANCj4gICAJCWZvcl9lYWNoX25vZGVfYnlfdHlwZShub2RlLCAiZGlzcGxh
eSIpIHsNCj4gLQkJCWNoYXIgKmJ1ZlsxNF07DQo+ICAgCQkJaWYgKCFvZl9nZXRfcHJvcGVy
dHkobm9kZSwgImxpbnV4LG9wZW5lZCIsIE5VTEwpIHx8IG5vZGUgPT0gYm9vdF9kaXNwbGF5
KQ0KPiAgIAkJCQljb250aW51ZTsNCj4gLQkJCXJldCA9IHNucHJpbnRmKGJ1ZiwgIm9mLWRp
c3BsYXktJWQiLCBkaXNwbGF5X251bWJlcisrKTsNCj4gKwkJCXJldCA9IHNucHJpbnRmKGJ1
Ziwgc2l6ZW9mKGJ1ZiksIG9mX2Rpc3BsYXlfZm9ybWF0LCBkaXNwbGF5X251bWJlcisrKTsN
Cj4gICAJCQlpZiAocmV0ID49IHNpemVvZihidWYpKQ0KPiAgIAkJCQljb250aW51ZTsNCj4g
ICAJCQlvZl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRlKG5vZGUsIGJ1ZiwgTlVMTCk7DQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkg
TsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOk
ZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------jTb7U4Y01UjAcWDHQmJCQQhg--

--------------1TgcrI16NSSsDhFGOmuhbipA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPJFKQFAwAAAAAACgkQlh/E3EQov+Bl
FhAAtOe4ycE6kKlY8LfRKDUIhrgZoSO+CL2P7edV0ZvkvTVbV+lE1O8J/RX4FFxPKf7wCymLaet0
VRuITaF673lZ2qBvajuKQYQx1ehf3MgIfE/GpKfIznEO54nmUQi12XyjlHXdiibwZAW2iojZUzgd
WS/6YLoY6XiKukAVQ9Ysl7D7spjTSZOCwTkuFMzwbXGrHfoGK1TZoyxdrVG5iKvSrDtlfcNK9Feu
k8Isi9awo6W6/Nb9KBmJmGnU6OXU2y5HwUJ1aSZrIEl+9VSXZerPv89dQfp+yxOJ2UopvUSrxX+P
aORjGcJUPYoOxHeVa/af+aoe+DfFNrOHYhr1UMxz9gcHhRJ4aPRxGatv3rbuJFfamdW6hP9l7Kap
KSWB5ap7v8+Ut89A/FyAUua9LoR0fJby9ZMpnL4KO7KswEaMlULlmPfn4WujbheA5MnKwU03e/UF
YPrfTPR08OO/71E5AMjkIu+JisHafU+QbKt69qomWIEtIYhNsA1DElvmLNu4XBZyKu2gieUtuNnp
VjVPUgzGQp1Me0nGodY314YyrvP7gtgh5xYfkLmR4rK1jSJCMXcGKQ+biZk+dckTLwd5ELT7mInX
il31rNetQeoqFPKL3jEzblZTceimLqsQvlzioR6EMKLqFM07sWbwd0Fj4jBXrlPh9LOTITJBCyAA
DA8=
=REm2
-----END PGP SIGNATURE-----

--------------1TgcrI16NSSsDhFGOmuhbipA--
