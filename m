Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E560B24A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiJXQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiJXQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:43:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E884E44;
        Mon, 24 Oct 2022 08:30:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D40D02213C;
        Mon, 24 Oct 2022 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666617643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHBLuiMwnA8vneJD/y631wvIrPqdbeaAk1VJvORMBPs=;
        b=O/RU9fxrsH2ba+KdtTWinFMRVldY7tMWlhqpZiQCPXllCaErxDVueMznrbznDeI1DmzoPh
        xdf34QScHE6ptVYb+Vnb9Zc5umM8msuWMc/c8VzCv1MUQqUkZPRZ8Pc72VFMCCsf1LGGUl
        Tp9nG5hDe9SfvPa/qF/S1QTzUFV39Q0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78FAB13357;
        Mon, 24 Oct 2022 13:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mhzHGyuRVmNIeAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 24 Oct 2022 13:20:43 +0000
Message-ID: <30a056c8-071f-4259-3253-75e718af619d@suse.com>
Date:   Mon, 24 Oct 2022 15:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     jejb@linux.ibm.com, Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
In-Reply-To: <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gOALCS2n06jZ1galIJq0LM4A"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gOALCS2n06jZ1galIJq0LM4A
Content-Type: multipart/mixed; boundary="------------mB8BSwhtZarR0gI4al0uD1q2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: jejb@linux.ibm.com, Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, sathya.prakash@broadcom.com,
 suganath-prabu.subramani@broadcom.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 adi@kriegisch.at
Message-ID: <30a056c8-071f-4259-3253-75e718af619d@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
In-Reply-To: <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>

--------------mB8BSwhtZarR0gI4al0uD1q2
Content-Type: multipart/mixed; boundary="------------Cd4S1bW6l9Vep0Vez9WtewrK"

--------------Cd4S1bW6l9Vep0Vez9WtewrK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTAuMjIgMTQ6NTEsIEphbWVzIEJvdHRvbWxleSB3cm90ZToNCj4gT24gTW9uLCAy
MDIyLTEwLTI0IGF0IDE3OjI2ICswNTMwLCBTcmVla2FudGggUmVkZHkgd3JvdGU6DQo+PiBP
biBTdW4sIE9jdCAyMywgMjAyMiBhdCA2OjU3IEFNIEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFz
c2NoZUBhY20ub3JnPg0KPj4gd3JvdGU6DQo+Pj4gT24gMTAvMjEvMjIgMDI6MjIsIFNhbHZh
dG9yZSBCb25hY2NvcnNvIHdyb3RlOg0KPj4+PiBXZSBnb3QgdGhlIGZvbGxvd2luZyByZXBv
cnQgaW4gRGViaWFuIGFmdGVyIGFuIHVwZGF0ZSBmcm9tDQo+Pj4+IDUuMTAuMTQwIHRvDQo+
Pj4+IHRoZSBjdXJyZW50IDUuMTAuMTQ5LiBGdWxsIHF1b3RpbmcgYmVsb3cgKGZyb20NCj4+
Pj4gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvMTAyMjEyNikuIERvZXMgdGhpcyByaW5nIHNv
bWUgYmVsbCBhYm91dA0KPj4+PiBrbm93bg0KPj4+PiByZWdyZXNzaW9ucz8NCj4+Pg0KPj4+
IE9ubHkgdGhyZWUgbXB0M3NhcyBjaGFuZ2VzIGFyZSBuZXcgaW4gdjUuMTAuMTQ5IGNvbXBh
cmVkIHRvDQo+Pj4gdjUuMTAuMTQwOg0KPj4+ICQgZ2l0IGxvZyAtLWZvcm1hdD1vbmVsaW5l
IHY1LjEwLjE0MC4udjUuMTAuMTQ5DQo+Pj4gMmI5YWJhMGM1ZDU4ZTE0MWUzMmJiMWJiNGM3
Y2Q5MWQxOWYwNzViOCBzY3NpOiBtcHQzc2FzOiBGaXggcmV0dXJuDQo+Pj4gdmFsdWUgY2hl
Y2sgb2YgZG1hX2dldF9yZXF1aXJlZF9tYXNrKCkNCj4+PiBlN2ZhZmVmOTgzMGM0YTAxZTYw
Zjc2ZTM4NjBhOWJlZjAyNjIzNzhkIHNjc2k6IG1wdDNzYXM6IEZvcmNlIFBDSWUNCj4+PiBz
Y2F0dGVybGlzdCBhbGxvY2F0aW9ucyB0byBiZSB3aXRoaW4gc2FtZSA0IEdCIHJlZ2lvbg0K
Pj4+IGVhMTBhNjUyYWQyYWUyY2YzZWNlZDZmNjMyYTVjOThmMjY3MjcwNTcgc2NzaTogbXB0
M3NhczogRml4IHVzZS0NCj4+PiBhZnRlci1mcmVlIHdhcm5pbmcNCj4+Pg0KPj4+IFNyZWVr
YW50aCBhbmQgU3VnYW5hdGgsIGNhbiB5b3UgaGVscCB3aXRoIGJpc2VjdGluZyB0aGlzIGlz
c3VlPyBGb3INCj4+PiB0aGUNCj4+PiBmdWxsIHJlcG9ydCwgc2VlIGFsc28NCj4+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1zY3NpL1kxSmt1S1RqVllyT1didm1AZWxkYW1h
ci5sYW4vLg0KPj4NCj4+IFRoaXMgaXNzdWUgaXMgZ2V0dGluZyBvYnNlcnZlZCBhZnRlciBo
YXZpbmcgdGhlIGJlbG93IHBhdGNoIGNoYW5nZXMsDQo+PiAyYjlhYmEwYzVkNThlMTQxZTMy
YmIxYmI0YzdjZDkxZDE5ZjA3NWI4IHNjc2k6IG1wdDNzYXM6IEZpeCByZXR1cm4NCj4+IHZh
bHVlIGNoZWNrIG9mIGRtYV9nZXRfcmVxdWlyZWRfbWFzaygpDQo+Pg0KPj4gV2hhdCBpcyBo
YXBwZW5pbmcgaXMgdGhhdCBvbiBYZW4gaHlwZXJ2aXNvciwgdGhpcw0KPj4gZG1hX2dldF9y
ZXF1aXJlZF9tYXNrKCkgQVBJIGFsd2F5cyByZXR1cm5zIGEgMzIgYml0IERNQSBtYXNrLiBJ
LmUuIEl0DQo+PiBzYXlzIHRoYXQgdGhlIG1pbmltdW0gRE1BIG1hc2sgcmVxdWlyZWQgdG8g
YWNjZXNzIHRoZSBob3N0IG1lbW9yeSBpcw0KPj4gMzIgYml0IGFuZCBoZW5jZSBtcHQzc2Fz
IGRyaXZlciBpcyBzZXR0aW5nIHRoZSBETUEgbWFzayB0byAzMmJpdC4NCj4gDQo+IFRoaXMg
c291bmRzIGVudGlyZWx5IGNvcnJlY3QgYmVjYXVzZSB0aGUgVk0gaXMgYm9vdGVkIHdpdGgg
KGZyb20gdGhlDQo+IG9yaWdpbmFsIGRlYmlhbiBidWcgcmVwb3J0KToNCj4gDQo+IGRvbTBf
bWVtPTQwOTZNLG1heDo0MDk2TSBkb20wX21heF92Y3B1cz00IGRvbTBfdmNwdXNfcGluDQo+
ICAgIHVjb2RlPXNjYW4geHB0aT1kb20wPWZhbHNlLGRvbXU9dHJ1ZSBnbnR0YWJfbWF4X2Zy
YW1lcz0xMjgNCj4gDQo+IFNvIGl0IGhhcyBubyBtZW1vcnkgYWJvdmUgNEdCIGFuZCB0aHVz
IDMyIGJpdCBhZGRyZXNzaW5nIGlzIHRoZSBtaW5pbXVtDQo+IHJlcXVpcmVkLiAgSWYgeW91
IGJvb3QgYSBtYWNoaW5lIHdpdGggPjRHQiBhbmQgWGVuIHN0aWxsIHJldHVybnMgYSAzMg0K
PiBiaXQgbWFzayBoZXJlLCB0aGVuIHdlIGhhdmUgYSBYZW4gcHJvYmxlbS4NCg0KRG9tMCBp
cyAobm9ybWFsbHkpIGEgUFYgZG9tYWluLCBzbyB0aGUgcGh5c2ljYWwgbWVtb3J5IGNhbiBi
ZSBzdGlsbCBhYm92ZQ0KNCBHQiBldmVuIHdpdGggZG9tMF9tZW0gc2V0IHRvIDRHQi4NCg0K
QnV0IHBsZWFzZSBzZWUgbXkgb3RoZXIgcmVwbHkgdG8gdGhpcyB0aHJlYWQuIEkgdGhpbmsg
YXQgbGVhc3Qgb25lIG9mIHRoZQ0KYmFja3BvcnRzIGlzIHBsYWluIHdyb25nLg0KDQoNCkp1
ZXJnZW4NCg==
--------------Cd4S1bW6l9Vep0Vez9WtewrK
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Cd4S1bW6l9Vep0Vez9WtewrK--

--------------mB8BSwhtZarR0gI4al0uD1q2--

--------------gOALCS2n06jZ1galIJq0LM4A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNWkSsFAwAAAAAACgkQsN6d1ii/Ey+2
4Qf/UAfTnu9pQMa1zwS/7U86zvqC37V71kwwlCH9EGA55zHHS86vLn81W7BIirwwvNI1Pap23nLb
zdOwW3Sr2LgVAVP3ybq3PWkk4qk87226wVGfik0jjR9VBYNjr4YWulW6EjWwhp6TAdx4cU7SVr8D
cmNNv4LFnSqyKCubLoaacDdqjK+6tUMT0jS9jGW7LqccgDoeK5gtSrZz3D1XEA2GZA2xZw5WchMA
3phzCdOGHtafYNDVAumtJI6zFEcB8iF7ceCylBtfA8aEQiNgu+3dC9ycCsDp4dc5qhYmW5vWnbeh
VzGSuo1Hx/1zBiYuWkPflLTuMkY6sXRDx0IH9JJA0w==
=w3zw
-----END PGP SIGNATURE-----

--------------gOALCS2n06jZ1galIJq0LM4A--
