Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14332707956
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjERExT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERExS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:53:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86112693;
        Wed, 17 May 2023 21:53:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBFFB1F74D;
        Thu, 18 May 2023 04:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684385594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dU3g2TFNel7/mtylcwF6Urz1FR7CgmiQ4S1MWDIfah4=;
        b=IgDOyJp1EG/qrBRpPOz4jHiH8ZxPqROwmlNwZr4EDOrQoXtDmWpS/mBRRMOIw3lTtvbAUy
        9DYmDZq9hlbTZqOPVC8EqenHiE7VtoMYROu0EZFVyGwm7++loOWfL7xyOCaZf6CujBxXkU
        /fV3qFfl5nBXsTtYgaiZ7ZO11JIeRCM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9848C138F5;
        Thu, 18 May 2023 04:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BQKpIzqvZWRqYAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 18 May 2023 04:53:14 +0000
Message-ID: <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
Date:   Thu, 18 May 2023 06:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
In-Reply-To: <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0YLph03U21dwa7hmV1rNcJeY"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0YLph03U21dwa7hmV1rNcJeY
Content-Type: multipart/mixed; boundary="------------sXLgrPQOvEJ2lCg0c0fNOTSc";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
Message-ID: <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
In-Reply-To: <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>

--------------sXLgrPQOvEJ2lCg0c0fNOTSc
Content-Type: multipart/mixed; boundary="------------Deb0hiwjyTcmRu6pYJgabK7i"

--------------Deb0hiwjyTcmRu6pYJgabK7i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDUuMjMgMTc6MDUsIEpvaG4gR2Fycnkgd3JvdGU6DQo+IE9uIDE3LzA1LzIwMjMg
MDU6NTQsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBPbiAxNy4wNS4yMyAwNDowNiwgTWFy
dGluIEsuIFBldGVyc2VuIHdyb3RlOg0KPj4+DQo+Pj4gSnVlcmdlbiwNCj4+Pg0KPj4+PiBT
b21lIGNhbGxlcnMgb2Ygc2NzaV9leGVjdXRlX2NtZCgpIChsaWtlIGUuZy4gc2Rfc3BpbnVw
X2Rpc2soKSkgYXJlDQo+Pj4+IHBhc3NpbmcgYW4gdW5pbml0aWFsaXplZCBzdHJ1Y3Qgc3No
ZHIgYW5kIGRvbid0IGxvb2sgYXQgdGhlIHJldHVybg0KPj4+PiB2YWx1ZSBvZiBzY3NpX2V4
ZWN1dGVfY21kKCkgYmVmb3JlIGxvb2tpbmcgYXQgdGhlIGNvbnRlbnRzIG9mIHRoYXQNCj4+
Pj4gc3RydWN0Lg0KPj4+DQo+Pj4gV2hpY2ggY2FsbGVycz8gc2Rfc3BpbnVwX2Rpc2soKSBh
cHBlYXJzIHRvIGRvIHRoZSByaWdodCB0aGluZy4uLg0KPj4+DQo+Pg0KPj4gTm90IHJlYWxs
eS4gSXQgaXMgY2FsbGluZyBtZWRpYV9ub3RfcHJlc2VudCgpIGRpcmVjdGx5IGFmdGVyIHRo
ZSBjYWxsIG9mDQo+PiBzY3NpX2V4ZWN1dGVfY21kKCkgd2l0aG91dCBjaGVja2luZyB0aGUg
cmVzdWx0LiANCj4gDQo+IElzIHRoZXJlIGEgcmVhc29uIHRoYXQgY2FsbGVycyBvZiBzY3Np
X2V4ZWN1dGVfY21kKCkgYXJlIG5vdCBhbHdheXMgY2hlY2tpbmcgdGhlIA0KPiByZXN1bHQg
Zm9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSAoYmVmb3JlIGV4YW1pbmluZyB0aGUgYnVmZmVy
KT8NCg0KSSBkb24ndCBrbm93Lg0KDQpJJ3ZlIHN0dW1ibGVkIG92ZXIgdGhlIHByb2JsZW0g
d2hpbGUgbG9va2luZyBpbnRvIHRoZSBjb2RlIGR1ZSB0byBhbmFseXppbmcgYQ0KY3VzdG9t
ZXIncyBwcm9ibGVtLiBJJ20gbm8gU0NTSSBleHBlcnQsIGJ1dCB0aGUgY3VzdG9tZXIgd2Fz
IHJ1bm5pbmcgWGVuIGFuZA0KdGhlcmUgd2FzIHRoZSBzdXNwaWNpb24gdGhpcyBjb3VsZCBi
ZSBhbiB1bmRlcmx5aW5nIFhlbiBpc3N1ZSAod2hpY2ggaXMgbXkNCmFyZWEgb2YgaW50ZXJl
c3QpLg0KDQpJdCBiZWNhbWUgY2xlYXIgcmF0aGVyIHF1aWNrbHkgdGhhdCB0aGUgdW5pbml0
aWFsaXplZCBzc2hkciB3YXNuJ3QgdGhlIHJvb3QNCmNhdXNlIG9mIHRoZSBjdXN0b21lcidz
IHByb2JsZW1zLCBidXQgSSB0aG91Z2h0IGl0IHNob3VsZCBiZSBmaXhlZCBhbnl3YXkuIEFz
DQp0aGVyZSBzZWVtIHRvIGJlIHF1aXRlIHNvbWUgcHJvYmxlbWF0aWMgY2FsbGVycyBvZiBz
Y3NpX2V4ZWN1dGVfY21kKCksIEkndmUNCmNob3NlbiB0byBhZGQgdGhlIG1pbmltYWwgbmVl
ZGVkIGluaXRpYWxpemF0aW9uIG9mIHNzaGRyIHRvIHNjc2lfZXhlY3V0ZV9jbWQoKQ0KaW5z
dGVhZCBvZiB0cnlpbmcgdG8gZml4IGFsbCBjYWxsZXJzLg0KDQpSZWFzb25pbmcgd2h5IHRo
ZSBjb2RlIGlzIGxvb2tpbmcgbGlrZSBpdCBkb2VzIGlzIHN1cmVseSBub3Qgd2hhdCBfSV8g
d2FudCB0bw0KZG8uDQoNCg0KSnVlcmdlbg0K
--------------Deb0hiwjyTcmRu6pYJgabK7i
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Deb0hiwjyTcmRu6pYJgabK7i--

--------------sXLgrPQOvEJ2lCg0c0fNOTSc--

--------------0YLph03U21dwa7hmV1rNcJeY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRlrzoFAwAAAAAACgkQsN6d1ii/Ey9l
Nwf/dNei0Pl/zUVyyvKbyHMntT1j8ar3DK3QFQ5NiCrjpwartHJGGjnJ76JCxJhDIaH3iZ0MjDUQ
DGHtvDcbqSfq81FBV+JZdqPR1aWedbRtgRIxLd/c/VxWbZeFJl2XrAO+OR+8AXfhUWv26Xl1v5zn
vdnSvX6oRk2aGEzLZ8E+WcrMjlTDNmjdk5AhAkssln6b+M36xXKWJHy/04tXbDg9MBJUmiir5Wfr
/x/XTCwYffgp7a8XAkHvLskTP1/tZWpx5EXcHFDpZLQoZ2+PnZ0BjCkOXU7xV8p0VMeYGIRSmySw
uozZEZDeo9WQNgnItonsIRWedk1CilEeeoMpFO/xew==
=N7bv
-----END PGP SIGNATURE-----

--------------0YLph03U21dwa7hmV1rNcJeY--
