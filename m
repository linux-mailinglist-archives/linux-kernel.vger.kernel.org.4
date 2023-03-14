Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640DF6B918F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCNLYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCNLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:24:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814315573;
        Tue, 14 Mar 2023 04:23:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E792C21A12;
        Tue, 14 Mar 2023 11:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678793015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vMwARrpSWwlbu+JNqwQgd6T6dnpANcZT/4XN88yKPs=;
        b=vBElblGnqZUNKDc+V7n4FdaEw5trIM3GdJDS9YSJ+OZcSKSv3uX0csyxQ+aEwZrcAAA6UA
        g3AaHzihoScL6Iu48fOVNlna4VwY3wleljWh9ztt+p8jr5U3k/8F/3DplXmALttJNu16D1
        C5ck2y0BvKLsyuxHiEsOtKU3GuA1NDI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84F8F13A1B;
        Tue, 14 Mar 2023 11:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ip8RHzdZEGQPMAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Mar 2023 11:23:35 +0000
Message-ID: <4c5de098-5cd3-116b-54cb-6972c6c06818@suse.com>
Date:   Tue, 14 Mar 2023 12:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Content-Language: en-US
To:     Joost Roeleveld <joost@antarean.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     jejb@linux.ibm.com, Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
 <Y1bEQMS5SNTbZO/3@infradead.org>
 <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
 <20230314111752.EGroupware.TiNRv1BSroWqKL7zQtfNLJ8@_>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230314111752.EGroupware.TiNRv1BSroWqKL7zQtfNLJ8@_>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OvWhcPNzpB5IFiX0ENVleu8u"
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
--------------OvWhcPNzpB5IFiX0ENVleu8u
Content-Type: multipart/mixed; boundary="------------2Q3vy6HJIm96Ptik5GhvztjE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Joost Roeleveld <joost@antarean.org>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: jejb@linux.ibm.com, Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Salvatore Bonaccorso <carnil@debian.org>, sathya.prakash@broadcom.com,
 suganath-prabu.subramani@broadcom.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 adi@kriegisch.at
Message-ID: <4c5de098-5cd3-116b-54cb-6972c6c06818@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <2fd505a07bd26d76f1166761fa50905414edb7ef.camel@linux.ibm.com>
 <30a056c8-071f-4259-3253-75e718af619d@suse.com>
 <Y1bEQMS5SNTbZO/3@infradead.org>
 <858a4288-46ac-d423-a529-b3b77b7fbc8a@citrix.com>
 <20230314111752.EGroupware.TiNRv1BSroWqKL7zQtfNLJ8@_>
In-Reply-To: <20230314111752.EGroupware.TiNRv1BSroWqKL7zQtfNLJ8@_>

--------------2Q3vy6HJIm96Ptik5GhvztjE
Content-Type: multipart/mixed; boundary="------------MsH0akIuaBxQwzn6Mj9DRLb4"

--------------MsH0akIuaBxQwzn6Mj9DRLb4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDMuMjMgMTI6MTcsIEpvb3N0IFJvZWxldmVsZCB3cm90ZToNCj4+IE9uIE1vbiwg
T2N0IDI0LCAyMDIyIGF0IDA1OjI4OjA1UE0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6
DQo+Pj4gSSBkb24ndCBrbm93IGV4YWN0bHkgaG93IHRoaXMgdHJhbnNsYXRlcyB0byBMaW51
eCBpbnRlcm5hbHMsIGJ1dCBtb3N0DQo+Pj4gZGV2aWNlcyBhcmUgZmluZSBhbmQgaXQncyBy
b3V0aW5lbHkgdGhlIG1wdDIvM3NhcyBkcml2ZXJzIHdoaWNoDQo+Pj4gZW5jb3VudGVyIHBy
b2JsZW1zLsKgIEl0IHdvdWxkIGJlIGxvdmVseSBpZiB3ZSBjb3VsZCBnZXQgdG8gdGhlIGJv
dHRvbSBvZg0KPj4+IHRoaXMgZm9yIG9uY2UgYW5kIGZvciBhbGwuDQo+Pg0KPj4gU28gdG8g
c3VtbWFyaXplIG15IHR3byBtYWlsczogSSB0aGluayB0ZSB1c2Ugb2YgZG1hX2dldF9yZXF1
aXJlZF9tYXNrDQo+PiBpbiBtcHQzc2FzIGlzIHdyb25nLCBhbmQgdGhlIGRtYV9nZXRfcmVx
dWlyZWRfbWFzayByZXR1cm4gdmFsdWUgZnJvbQ0KPj4geGVuLXN3aW90bGIgaXMgYWxzbyB3
cm9uZy4gRml4aW5nIGVpdGhlciBvbmUgc2hvdWxkIGZpeCB0aGlzIHByb2JsZW0sDQo+PiBh
bmQgSSB0aGluayB3ZSBzaG91bGQgZml4IGJvdGguDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBJ
cyB0aGVyZSBhbnl0aGluZyB0aGF0IGNhbiBiZSBkb25lIHRvIGdldCB0aGlzIGZpeGVkIGlu
IHhlbiBhbmQgdGhlIGtlcm5lbCBzb21laG93Pw0KPiBJIGtlZXAgaGF2aW5nIHRvIG1hbnVh
bGx5IHBhdGNoIHRoZSBtcHQzc2FzIGRyaXZlciB0byBwcmV2ZW50IGl0IGZyb20gYmVpbmcg
YWJsZSANCj4gdG8gc3dpdGNoIHRvIDMyYml0IG1vZGUgZWFjaCB0aW1lIEkgdXBncmFkZSB0
aGUga2VybmVsLg0KDQpKdXN0IHVzZSA1LjEwLjE3My4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------MsH0akIuaBxQwzn6Mj9DRLb4
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------MsH0akIuaBxQwzn6Mj9DRLb4--

--------------2Q3vy6HJIm96Ptik5GhvztjE--

--------------OvWhcPNzpB5IFiX0ENVleu8u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQQWTcFAwAAAAAACgkQsN6d1ii/Ey+T
Dwf7B0bjjfjWFw00vV/SZ0Q0qzfpahQ13HnDoy+ltbC9n+jn9wgVXdUp0TvVA0/NAYb/0UeOlibh
3eym1qP9oyYbhdeGmfqkg4ma7RQQN9dCFkQkHCnawnayu/xt3Zrh4qtYTsyTFm92Aowt8VwTCkYX
UXGM+sb1Gt8eo5PWVf7R2w1XSODvMEztUHi6ItQDmXS2KHHVR5TpA780V2oStMdQzSo6dWOA7CHs
4Pxzp5WOTiv/7sLbp12uPFPOszHt5PaQ62HYf9245lC6GTzKoHvPQJUG6UHgBsU3DVL/fwie3arJ
PJ8f65kRx6O3+nA8Xdzk/6LLLqZKx1PXztSe2a+7wA==
=AtOP
-----END PGP SIGNATURE-----

--------------OvWhcPNzpB5IFiX0ENVleu8u--
