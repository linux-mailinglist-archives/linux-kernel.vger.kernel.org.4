Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A84693F76
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBMIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBMIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:20:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6478F12878
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:19:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 162A467AC1;
        Mon, 13 Feb 2023 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676276398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QE3+ImDbv+iRMg0urx+hhREwWMlTqSaDmNJTX/t3b28=;
        b=K8wk7UwJ8jvwXSQrTwUKGkT21bQRUW0XeObdsuY1QkLrz3CyFqteBaEltPWKxsPfaBqH3L
        Uk+qI6aAlvsVmHvplKSJyMn3aBLlmYGvls0b8UbxBPteNBCaCp55AYhBtHWKjwz+DVqXYb
        BuhDnfscfGqW2IQq3z1BJOqzUNG08lU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB979138E6;
        Mon, 13 Feb 2023 08:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eZO8M63y6WN4NgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 08:19:57 +0000
Message-ID: <ecb93fed-ee16-0688-ec3b-744d599f0598@suse.com>
Date:   Mon, 13 Feb 2023 09:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] xen/grant-dma-iommu: Implement a dummy probe_device()
 callback
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20230208153649.3604857-1-olekstysh@gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230208153649.3604857-1-olekstysh@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RBH6UhIRkHMiUqsxgvy3xsXY"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RBH6UhIRkHMiUqsxgvy3xsXY
Content-Type: multipart/mixed; boundary="------------NGWlZ7vq7DpqRSV3qtp1bda3";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Message-ID: <ecb93fed-ee16-0688-ec3b-744d599f0598@suse.com>
Subject: Re: [PATCH] xen/grant-dma-iommu: Implement a dummy probe_device()
 callback
References: <20230208153649.3604857-1-olekstysh@gmail.com>
In-Reply-To: <20230208153649.3604857-1-olekstysh@gmail.com>

--------------NGWlZ7vq7DpqRSV3qtp1bda3
Content-Type: multipart/mixed; boundary="------------gsVpOz0V7CNMqpfHNUPpAH8n"

--------------gsVpOz0V7CNMqpfHNUPpAH8n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMDIuMjMgMTY6MzYsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiBGcm9t
OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+
DQo+IA0KPiBVcGRhdGUgc3R1YiBJT01NVSBkcml2ZXIgKHdoaWNoIG1haW4gcHVycG9zZSBp
cyB0byByZXVzZSBnZW5lcmljDQo+IElPTU1VIGRldmljZS10cmVlIGJpbmRpbmdzIGJ5IFhl
biBncmFudCBETUEtbWFwcGluZyBsYXllciBvbiBBcm0pDQo+IGFjY29yZGluZyB0byB0aGUg
cmVjZW50IGNoYW5nZXMgZG9uZSBpbiB0aGUgZm9sbG93aW5nDQo+IGNvbW1pdCA1NzM2NWEw
NGM5MjEgKCJpb21tdTogTW92ZSBidXMgc2V0dXAgdG8gSU9NTVUgZGV2aWNlIHJlZ2lzdHJh
dGlvbiIpLg0KPiANCj4gV2l0aCBwcm9iZV9kZXZpY2UoKSBjYWxsYmFjayBiZWluZyBjYWxs
ZWQgZHVyaW5nIElPTU1VIGRldmljZSByZWdpc3RyYXRpb24sDQo+IHRoZSB1bmluaXRpYWxp
emVkIGNhbGxiYWNrIGp1c3QgbGVhZHMgdG8gdGhlICJrZXJuZWwgTlVMTCBwb2ludGVyDQo+
IGRlcmVmZXJlbmNlIiBpc3N1ZSBkdXJpbmcgYm9vdC4gRml4IHRoYXQgYnkgYWRkaW5nIGEg
ZHVtbXkgY2FsbGJhY2suDQo+IA0KPiBMb29rcyBsaWtlIHRoZSByZWxlYXNlX2RldmljZSgp
IGNhbGxiYWNrIGlzIG5vdCBtYW5kYXRvcnkgdG8gYmUNCj4gaW1wbGVtZW50ZWQgYXMgSU9N
TVUgZnJhbWV3b3JrIG1ha2VzIHN1cmUgdGhhdCBjYWxsYmFjayBpcyBpbml0aWFsaXplZA0K
PiBiZWZvcmUgZGVyZWZlcmVuY2luZy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBWaXJlc2ggS3Vt
YXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2Fu
ZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQoNClB1c2hl
ZC10bzogeGVuL3RpcC5naXQgZm9yLWxpbnVzLTYuMw0KDQoNCkp1ZXJnZW4NCg0K
--------------gsVpOz0V7CNMqpfHNUPpAH8n
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------gsVpOz0V7CNMqpfHNUPpAH8n--

--------------NGWlZ7vq7DpqRSV3qtp1bda3--

--------------RBH6UhIRkHMiUqsxgvy3xsXY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp8q0FAwAAAAAACgkQsN6d1ii/Ey/S
QAf/fRXsFUEMr+WD5+EQRdD8h1X1IsQTLpZWHreyPibtO4+gl1AooVP8oBzbGTPhKeygMpT0A8BK
8i6optXzCxLAL6LYh8GNklO7XnwwSWCb39TKMtKrJ7kFkERbp1afX+EaWpArLoYzhOfQagpRZ7IX
5ABbAT+kmH3incsqG9BPePDOO0h5Rzrx7Kzv2xW4o9ZRgqCYGVC2XFBiTcyMNoKLY1xIY/tyB1II
zxpG+A0v1cgX2xmxyvQOFOHXn/CqSEgUa9b+f//4r8+9V7mUCHyx75DXBM+kqTtRBAQTtWnrBdGH
Cvfb/Y3fLUPVh4MNrI0IKc1f0YLoSoBF3AryktWAPQ==
=Gzun
-----END PGP SIGNATURE-----

--------------RBH6UhIRkHMiUqsxgvy3xsXY--
