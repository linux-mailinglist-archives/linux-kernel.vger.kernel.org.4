Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52526663A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbjAJIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAJIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:07:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803130566
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:07:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A68AB4D6EE;
        Tue, 10 Jan 2023 08:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673338056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xohioAh1kapJutPJWQnyJIvtrut+K4fCdUNvyrvvEps=;
        b=F/1x9PdCXjPQpN04iGPzwZgJ9ewZMUL6Am2p+uO7S6oRkx1yxxHLC2OkN2nirzqHxJ/eiO
        lkmdc9OI/RFJP8wF1UH6d3f1vS4dNjAaB2KDnNinVFybpOkVE9FUHcIiTtwx/x5UwgvwJP
        3X8qReklSQNoZijRLpF81364vnxmPVA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 374CE1358A;
        Tue, 10 Jan 2023 08:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LNETDMgcvWNKBgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 10 Jan 2023 08:07:36 +0000
Message-ID: <8a2abe27-361a-aab1-60fe-00a3cc8684ff@suse.com>
Date:   Tue, 10 Jan 2023 09:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] xen: make remove callback of xen driver void returned
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     roger.pau@citrix.com, peterhuewe@gmx.de,
        oleksandr_andrushchenko@epam.com, airlied@gmail.com,
        dmitry.torokhov@gmail.com, wei.liu@kernel.org, bhelgaas@google.com,
        jejb@linux.ibm.com, gregkh@linuxfoundation.org, ericvh@gmail.com,
        tiwai@suse.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB23238119AB4DF190997075C9CAE39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <TYCP286MB23238119AB4DF190997075C9CAE39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0lgsG4DjM2bogqj9tDjcsDeD"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0lgsG4DjM2bogqj9tDjcsDeD
Content-Type: multipart/mixed; boundary="------------r84Y64pzyXf8LsYbXQjpT04r";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dawei Li <set_pte_at@outlook.com>, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com
Cc: roger.pau@citrix.com, peterhuewe@gmx.de,
 oleksandr_andrushchenko@epam.com, airlied@gmail.com,
 dmitry.torokhov@gmail.com, wei.liu@kernel.org, bhelgaas@google.com,
 jejb@linux.ibm.com, gregkh@linuxfoundation.org, ericvh@gmail.com,
 tiwai@suse.com, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <8a2abe27-361a-aab1-60fe-00a3cc8684ff@suse.com>
Subject: Re: [PATCH v2] xen: make remove callback of xen driver void returned
References: <TYCP286MB23238119AB4DF190997075C9CAE39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB23238119AB4DF190997075C9CAE39@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>

--------------r84Y64pzyXf8LsYbXQjpT04r
Content-Type: multipart/mixed; boundary="------------BJxvnO001IhyRZyK5BKNLhzp"

--------------BJxvnO001IhyRZyK5BKNLhzp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTIuMjIgMTY6NDYsIERhd2VpIExpIHdyb3RlOg0KPiBTaW5jZSBjb21taXQgZmM3
YTYyMDlkNTcxICgiYnVzOiBNYWtlIHJlbW92ZSBjYWxsYmFjayByZXR1cm4gdm9pZCIpDQo+
IGZvcmNlcyBidXNfdHlwZTo6cmVtb3ZlIGJlIHZvaWQtcmV0dXJuZWQsIGl0IGRvZXNuJ3Qg
bWFrZSBtdWNoIHNlbnNlIGZvcg0KPiBhbnkgYnVzIGJhc2VkIGRyaXZlciBpbXBsZW1lbnRp
bmcgcmVtb3ZlIGNhbGxiYWxrIHRvIHJldHVybiBub24tdm9pZCB0bw0KPiBpdHMgY2FsbGVy
Lg0KPiANCj4gVGhpcyBjaGFuZ2UgaXMgZm9yIHhlbiBidXMgYmFzZWQgZHJpdmVycy4NCj4g
DQo+IEFja2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IERhd2VpIExpIDxzZXRfcHRlX2F0QG91dGxvb2suY29tPg0KDQpQdXNoZWQg
dG8geGVuL3RpcC5naXQgZm9yLWxpbnVzLTYuMg0KDQoNCkp1ZXJnZW4NCg0K
--------------BJxvnO001IhyRZyK5BKNLhzp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------BJxvnO001IhyRZyK5BKNLhzp--

--------------r84Y64pzyXf8LsYbXQjpT04r--

--------------0lgsG4DjM2bogqj9tDjcsDeD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmO9HMcFAwAAAAAACgkQsN6d1ii/Ey+f
1wf+K+5GUrDsbaaoBFao/iA/yd9cCF6PTSRa8C28Z0Xu+s5K30n0thAK7JjyRMZJmzbemu4XZVA6
OxCGIQdrkLTmgoGRTZjdYbFhz7C4ByTAEqkgk72umn3WZEqthOfZY1EE2Imd1beYJzeLfjM6U32h
DuUK14cuf7PbMVfAxpMgPvk+awBFO7fjD5gdNRpAE/F1eseawanTnJSeD5AVm4MRJCwnQr9/8xWA
M0lm0kk3xCfAu1tlqV2XXuAXF8pZCdXr6/heuDpg2UwwakevfI3rHCsGO85anJ1vWiWJR+5N3hrz
8f7fsLu5VuBRJPVziQO8zwQUNBXYTCjlBj7/Ba8lJQ==
=VY/4
-----END PGP SIGNATURE-----

--------------0lgsG4DjM2bogqj9tDjcsDeD--
