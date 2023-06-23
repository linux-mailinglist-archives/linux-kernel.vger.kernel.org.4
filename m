Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66373B2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFWI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWI27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:28:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4A8118
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:28:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2ADD621B9D;
        Fri, 23 Jun 2023 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687508937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5zSzDY8wP8yI/ZvIbhnGrW2NB8WGMEdPK0Rgi2O3vg=;
        b=LmlmyXBtR0cfflaZ04iY6wWDjMjEgEjL21FtNYNKRd6cDHqbJEbhtcThzuR2lhHQ0z0ul3
        S+fB2bOryeBGs5N7JdWLUjRseeVNPDfI3YaRE2ki3/uFhxBI9FGArialdWX4UUIpU2OJTT
        x05GQGdWpT2q40XENAl7Q8Y+2xIiMwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687508937;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5zSzDY8wP8yI/ZvIbhnGrW2NB8WGMEdPK0Rgi2O3vg=;
        b=BW9jkNvDcvzAQTwBMHl3Cc9R8K2yrHCrGaCWfHpLE8IqoHyMEd/xjaYryr5zgniGDTZ9N3
        /k6uBNgQMQinv5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8CAB1331F;
        Fri, 23 Jun 2023 08:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TAq7MMhXlWTPTQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 23 Jun 2023 08:28:56 +0000
Message-ID: <f3d8cbe7-11a6-14a3-e161-906c73c5ade3@suse.de>
Date:   Fri, 23 Jun 2023 10:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/mgag200: set variable mgag200_modeset
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, airlied@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230517134140.874179-1-trix@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230517134140.874179-1-trix@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3CoNwsP06LoWEAuceV8gzBBS"
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
--------------3CoNwsP06LoWEAuceV8gzBBS
Content-Type: multipart/mixed; boundary="------------MBtKfXqZWxCaS01uw3on05RA";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tom Rix <trix@redhat.com>, airlied@redhat.com, airlied@gmail.com,
 daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <f3d8cbe7-11a6-14a3-e161-906c73c5ade3@suse.de>
Subject: Re: [PATCH] drm/mgag200: set variable mgag200_modeset
 storage-class-specifier to static
References: <20230517134140.874179-1-trix@redhat.com>
In-Reply-To: <20230517134140.874179-1-trix@redhat.com>

--------------MBtKfXqZWxCaS01uw3on05RA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDE3LjA1LjIzIHVtIDE1OjQxIHNjaHJpZWIgVG9tIFJpeDoNCj4gc21hdGNoIHJl
cG9ydHMNCj4gZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIwMF9kcnYuYzoyMzo1OiB3
YXJuaW5nOiBzeW1ib2wNCj4gICAgJ21nYWcyMDBfbW9kZXNldCcgd2FzIG5vdCBkZWNsYXJl
ZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gDQo+IFRoaXMgdmFyaWFibGUgaXMgb25seSB1
c2VkIGluIGl0cyBkZWZpbmluZyBmaWxlLCBzbyBpdCBzaG91bGQgYmUgc3RhdGljDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQoNClJldmlld2Vk
LWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCg0KPiAtLS0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2Rydi5jIHwgMiArLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZHJ2LmMgYi9k
cml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2Rydi5jDQo+IGluZGV4IDk3NmYwYWIy
MDA2Yi4uYWJkZGYzN2YwZWExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWdh
ZzIwMC9tZ2FnMjAwX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21n
YWcyMDBfZHJ2LmMNCj4gQEAgLTIwLDcgKzIwLDcgQEANCj4gICANCj4gICAjaW5jbHVkZSAi
bWdhZzIwMF9kcnYuaCINCj4gICANCj4gLWludCBtZ2FnMjAwX21vZGVzZXQgPSAtMTsNCj4g
K3N0YXRpYyBpbnQgbWdhZzIwMF9tb2Rlc2V0ID0gLTE7DQo+ICAgTU9EVUxFX1BBUk1fREVT
Qyhtb2Rlc2V0LCAiRGlzYWJsZS9FbmFibGUgbW9kZXNldHRpbmciKTsNCj4gICBtb2R1bGVf
cGFyYW1fbmFtZWQobW9kZXNldCwgbWdhZzIwMF9tb2Rlc2V0LCBpbnQsIDA0MDApOw0KPiAg
IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVy
DQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3Nl
IDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcg
TXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFH
IE51ZXJuYmVyZykNCg==

--------------MBtKfXqZWxCaS01uw3on05RA--

--------------3CoNwsP06LoWEAuceV8gzBBS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSVV8cFAwAAAAAACgkQlh/E3EQov+DG
MA/+MthG+mFfhpt4/EKcSot3KZqnUjQgtUK8NGd7Hy2gdwSDFS8JWMwnWwG71+492glAtdXEjxZw
r97j/5xgiZaaUyMzFpEb3cexT7GZNFriLCyvCK6/wvJ9oHxzROdWGNeodCJnOt4p41KcGg3R1ZyK
fTDqESH5uBLbca21AzfVlSKuCAd3sMF2Pf6Rf2q1EuYY+KBfrwqT5CK5SsyNWd56f3jFwsDE2vhI
kAYt9HS4ytyZb1antJvAVit3OPUZjtel1hzqqkowTwVAcQIBdK3kBf1toIG0m0ISL5VmAGdMhE17
3vKyw79auVmLYqERBhz1cT4ffCZ2UBMnkfmgDcKUz66sccfn1EiLkR6T9GOcZ24kG8bsu/D7eC/Q
olQHmU7+BCmQF1jaknMLafhZKFi3v9Q5WdDVlOlvJERmix8fFvNd5RcM812DChp3W0rZasKhioQA
MUeMvr4owolAVTYUMg5y+cUnClOjv05U3jNQNR28ZQmctyfeeBtBzcm5eKKshKtPBqM7vmtEyOcO
14yPd3UreesphkrNAv3eosFGgueMxhgRAnHSQNG8H3F7wWmRk1Lcx30CYkwPZ9lacMD9Dvr3RIal
gx0ztiOqmaPbcnxakDIOZYuu7XUsdxvCWjStW2Wzzxijd0/ao4WOxN6Oh1AOpGz4+8AMUZQI8/Ku
aRU=
=NYlw
-----END PGP SIGNATURE-----

--------------3CoNwsP06LoWEAuceV8gzBBS--
