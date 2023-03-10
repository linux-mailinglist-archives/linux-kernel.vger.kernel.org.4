Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652946B4025
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCJNUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCJNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:20:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE6414EA7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:20:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 741F222AB9;
        Fri, 10 Mar 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678454429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Na7IReUqp04yyYni6gLzqdg28AZY0BZDGd6IjPJJaxo=;
        b=i1yiuv+xQXiPmy1Vzn1pcxQHYP6cRFvd4fIWhc6Q3lzJtumHP8HfzdTbjquhrRwIZ6fznx
        LBsDaWiqLAKmH+UPTsWRdTSIndIkRETMrgZff8YltEMUWBh064Jza/YinMhXbtmeq4Anm+
        ka+fGzK9ssqKjkw3i1luzhiv0AKLxT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678454429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Na7IReUqp04yyYni6gLzqdg28AZY0BZDGd6IjPJJaxo=;
        b=NElPwiuJaEfuSCu1YzakYOO+cvdidG/jtCl3MvmAJj9FiQgoYZxEwiz/wWeF1hIWo2hsaJ
        Avy87IdKhRlY23BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FDAE134F7;
        Fri, 10 Mar 2023 13:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2RVuCp0uC2SYPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 10 Mar 2023 13:20:29 +0000
Message-ID: <6c556799-6a78-4b67-a4c7-4de0a8f082fa@suse.de>
Date:   Fri, 10 Mar 2023 14:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/virtio: Enable fb damage clips property for the
 primary plane
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Bilal Elmoussaoui <belmouss@redhat.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Christian Hergert <chergert@redhat.com>,
        Albert Esteve <aesteve@redhat.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20230310125943.912514-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230310125943.912514-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------H0HUDGi9zGc6QAbfhXC4QAHh"
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
--------------H0HUDGi9zGc6QAbfhXC4QAHh
Content-Type: multipart/mixed; boundary="------------0tC6cVnrTiqjK9gsD3MhcpKk";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Bilal Elmoussaoui <belmouss@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Christian Hergert <chergert@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <6c556799-6a78-4b67-a4c7-4de0a8f082fa@suse.de>
Subject: Re: [PATCH] drm/virtio: Enable fb damage clips property for the
 primary plane
References: <20230310125943.912514-1-javierm@redhat.com>
In-Reply-To: <20230310125943.912514-1-javierm@redhat.com>

--------------0tC6cVnrTiqjK9gsD3MhcpKk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmF2aWVyDQoNCkFtIDEwLjAzLjIzIHVtIDEzOjU5IHNjaHJpZWIgSmF2aWVyIE1hcnRp
bmV6IENhbmlsbGFzOg0KPiBDaHJpc3RpYW4gSGVyZ2VydCByZXBvcnRzIHRoYXQgdGhlIGRy
aXZlciBkb2Vzbid0IGVuYWJsZSB0aGUgcHJvcGVydHkgYW5kDQo+IHRoYXQgbGVhZHMgdG8g
YWx3YXlzIGRvaW5nIGEgZnVsbCBwbGFuZSB1cGRhdGUsIGV2ZW4gd2hlbiB0aGUgZHJpdmVy
IGRvZXMNCj4gc3VwcG9ydCBkYW1hZ2UgY2xpcHBpbmcgZm9yIHRoZSBwcmltYXJ5IHBsYW5l
Lg0KPiANCj4gRG9uJ3QgZW5hYmxlIGl0IGZvciB0aGUgY3Vyc29yIHBsYW5lLCBiZWNhdXNl
IGl0cyAuYXRvbWljX3VwZGF0ZSBjYWxsYmFjaw0KPiBkb2Vzbid0IGhhbmRsZSBkYW1hZ2Ug
Y2xpcHMuDQo+IA0KPiBSZXBvcnRlZC1ieTogQ2hyaXN0aWFuIEhlcmdlcnQgPGNoZXJnZXJ0
QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxh
cyA8amF2aWVybUByZWRoYXQuY29tPg0KPiAtLS0NCj4gDQo+ICAgZHJpdmVycy9ncHUvZHJt
L3ZpcnRpby92aXJ0Z3B1X3BsYW5lLmMgfCA0ICsrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Zp
cnRpby92aXJ0Z3B1X3BsYW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRncHVf
cGxhbmUuYw0KPiBpbmRleCA0YzA5ZTMxM2JlYmMuLmEyZTA0NWYzYTAwMCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3BsYW5lLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3BsYW5lLmMNCj4gQEAgLTM5MCw1ICsz
OTAsOSBAQCBzdHJ1Y3QgZHJtX3BsYW5lICp2aXJ0aW9fZ3B1X3BsYW5lX2luaXQoc3RydWN0
IHZpcnRpb19ncHVfZGV2aWNlICp2Z2RldiwNCg0KdmlydGlvX2dwdV9wbGFuZV9pbml0KCkg
c2hvdWxkIHJlYWxseSBiZSB0d28gc2VwYXJhdGUgZnVuY3Rpb25zLiBCdXQgDQp3aXRoaW5n
IHRoZSBjb25zdHJhaW5zIG9mIHRoZSBjdXJyZW50IGNvZGUNCg0KUmV2aWV3ZWQtYnk6IFRo
b21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KDQpCZXN0IHJlZ2FyZHMN
ClRob21hcw0KDQo+ICAgCQlyZXR1cm4gcGxhbmU7DQo+ICAgDQo+ICAgCWRybV9wbGFuZV9o
ZWxwZXJfYWRkKHBsYW5lLCBmdW5jcyk7DQo+ICsNCj4gKwlpZiAodHlwZSA9PSBEUk1fUExB
TkVfVFlQRV9QUklNQVJZKQ0KPiArCQlkcm1fcGxhbmVfZW5hYmxlX2ZiX2RhbWFnZV9jbGlw
cyhwbGFuZSk7DQo+ICsNCj4gICAJcmV0dXJuIHBsYW5lOw0KPiAgIH0NCj4gDQo+IGJhc2Ut
Y29tbWl0OiAzZTg1M2I5Zjg5ZTRiY2M4YWEzNDJmYTM1MGQ4M2ZmMGRmNjdkN2U5DQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkg
TsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOk
ZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------0tC6cVnrTiqjK9gsD3MhcpKk--

--------------H0HUDGi9zGc6QAbfhXC4QAHh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQLLpwFAwAAAAAACgkQlh/E3EQov+Am
GBAAvJ3XEh+sW5ic+HXC4WBZJdHwDSW2DMjgbbn2NHT/Fs4DA7BuLK5F4uGp0zNTWUZ3nOfTRAIm
45lVRZtefYzzM+/thEEomZtpZxpg7NLU1eZ48nMCvJiaZsqe5ujzN2MNej+Z299z+z5n0dVIYPdT
XF3mRsAVlFqmCKEH8+7rbnWyQwkwEJkX5YqC/MT2e+pXWm/dNbU40cZsPKXdtY14elSkaJyEcZuY
f7xuKdvuptb/0rb6J2JXpeb8QWjCu3ogKBoHxK+Ofl+RiNaJjHaFldOvtOWLsqKhiHGKeQpTwXZ+
IXZTFk6266ju2SSGxLa8M2XABJOStIw58NkksxoBK4dLMZarKSBgoAsOY1xG2pPKTNCcoqGK9re0
erK/ZPT2nkZei+pW8KzX5vGVRcYtVSxdQZ8p0kHCU5z9w12DM2YkHSztJprvBgIre0S5KFBGoQtn
GoqcNffQ4XYnZfIIjsTUEZm7gPc799KWpJZtlkxG+E209AOtUk2jFVttZhnVrHNeoGw1MwcBz3BQ
PD1TRYP49fPlQGLOXHskqpTI0cTkFViA8VuCTRLJIrLQByHRu5JqEubxdFXyhBjzV1kcyNI0GcgX
60lWEBoPR5HjkrjgMECgegVksP1GSq170/adkQmxwqcHAR6FOLPtcDLCgbL9QWCc2JqUqI68mMqr
r+s=
=/TF1
-----END PGP SIGNATURE-----

--------------H0HUDGi9zGc6QAbfhXC4QAHh--
