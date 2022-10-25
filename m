Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971E60C2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiJYEcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJYEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:32:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE41E099;
        Mon, 24 Oct 2022 21:32:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFC4A22055;
        Tue, 25 Oct 2022 04:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666672331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7slYQYXkLjxXSTb9Jmeg4pGsOIyxx4med/b1FY0v2wM=;
        b=OvRCnC/1X/LLTSN+t4KH5CIzknOCg51f0jnD6BYkfdeEo2k8YOJ/bTMPjZBHNWHZAx8SQr
        vUf9w+fvU0mrI84wOpke1m7Nj/DAcGFwnT06b4NBOqL5g/rzRdb3grXfouVeH+gNl6TMXS
        /GmE8IuWTBUb6CPstr6mIJw6OTUEI24=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78062134CA;
        Tue, 25 Oct 2022 04:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z5uIG8tmV2NWMgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 25 Oct 2022 04:32:11 +0000
Message-ID: <59eab6d2-6710-a941-6e7d-7efe8dcf0f1b@suse.com>
Date:   Tue, 25 Oct 2022 06:32:11 +0200
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
 <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
 <aa9ebdef1f1dbfceb5a32f5f437b865861976957.camel@linux.ibm.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
In-Reply-To: <aa9ebdef1f1dbfceb5a32f5f437b865861976957.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0rlDa9SQfT94UR4QIRjJLU0o"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0rlDa9SQfT94UR4QIRjJLU0o
Content-Type: multipart/mixed; boundary="------------nQfmobi3WurtVZY3p8acHADl";
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
Message-ID: <59eab6d2-6710-a941-6e7d-7efe8dcf0f1b@suse.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
 <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
 <aa9ebdef1f1dbfceb5a32f5f437b865861976957.camel@linux.ibm.com>
In-Reply-To: <aa9ebdef1f1dbfceb5a32f5f437b865861976957.camel@linux.ibm.com>

--------------nQfmobi3WurtVZY3p8acHADl
Content-Type: multipart/mixed; boundary="------------Tyxf3ySWUJiDFRHH0ip3jqDx"

--------------Tyxf3ySWUJiDFRHH0ip3jqDx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTAuMjIgMjA6NTAsIEphbWVzIEJvdHRvbWxleSB3cm90ZToNCj4gT24gTW9uLCAy
MDIyLTEwLTI0IGF0IDE0OjU1ICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiBbLi4u
XQ0KPj4gUGxlYXNlIHJlY2hlY2sgdGhlIGJhY2twb3J0ZWQgcGF0Y2ggaW4gNS4xMC55LiBJ
dCBpcyBfd3JvbmdfLiBUaGUNCj4+IGJhY2twb3J0DQo+PiBoYXM6DQo+Pg0KPj4gLS0tIGEv
ZHJpdmVycy9zY3NpL21wdDNzYXMvbXB0M3Nhc19iYXNlLmMNCj4+ICsrKyBiL2RyaXZlcnMv
c2NzaS9tcHQzc2FzL21wdDNzYXNfYmFzZS5jDQo+PiBAQCAtMjk5Myw3ICsyOTkzLDcgQEAg
X2Jhc2VfY29uZmlnX2RtYV9hZGRyZXNzaW5nKHN0cnVjdA0KPj4gTVBUM1NBU19BREFQVEVS
ICppb2MsDQo+PiBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4+DQo+PiAgICAgICAgICAgaWYg
KGlvYy0+aXNfbWNwdV9lbmRwb2ludCB8fA0KPj4gICAgICAgICAgICAgICBzaXplb2YoZG1h
X2FkZHJfdCkgPT0gNCB8fCBpb2MtPnVzZV8zMmJpdF9kbWEgfHwNCj4+IC0gICAgICAgICAg
IGRtYV9nZXRfcmVxdWlyZWRfbWFzaygmcGRldi0+ZGV2KSA8PSAzMikNCj4+ICsgICAgICAg
ICAgIGRtYV9nZXRfcmVxdWlyZWRfbWFzaygmcGRldi0+ZGV2KSA8PSBETUFfQklUX01BU0so
MzIpKQ0KPj4gICAgICAgICAgICAgICAgICAgaW9jLT5kbWFfbWFzayA9IDMyOw0KPj4gICAg
ICAgICAgIC8qIFNldCA2MyBiaXQgRE1BIG1hc2sgZm9yIGFsbCBTQVMzIGFuZCBTQVMzNSBj
b250cm9sbGVycyAqLw0KPj4gICAgICAgICAgIGVsc2UgaWYgKGlvYy0+aGJhX21waV92ZXJz
aW9uX2JlbG9uZ2VkID4gTVBJMl9WRVJTSU9OKQ0KPj4NCj4+IFdoaWxlIHRoZSB1cHN0cmVh
bSBwYXRjaCBoYXM6DQo+Pg0KPj4gKyAgICAgICBpZiAoaW9jLT5pc19tY3B1X2VuZHBvaW50
IHx8IHNpemVvZihkbWFfYWRkcl90KSA9PSA0IHx8DQo+PiArICAgICAgICAgICBkbWFfZ2V0
X3JlcXVpcmVkX21hc2soJnBkZXYtPmRldikgPD0gMzIpIHsNCj4+ICAgICAgICAgICAgICAg
ICAgIGlvYy0+ZG1hX21hc2sgPSAzMjsNCj4+ICsgICAgICAgICAgICAgICBjb2hlcmVudF9k
bWFfbWFzayA9IGRtYV9tYXNrID0gRE1BX0JJVF9NQVNLKDMyKTsNCj4+DQo+IA0KPiBUaGF0
J3Mgbm90IHRoZSB1cHN0cmVhbSBjb21taXQuICBUaGUgcXVvdGVkIHVwc3RyZWFtIHBhdGNo
IGluIHRoZQ0KPiBzdGFibGUgY29tbWl0IGlzOg0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1p
dC8/aWQ9ZTBlMDc0N2RlMGVhM2RkODdjZGJiMDM5MzMxMWUxNzQ3MWE5YmFmMQ0KPiANCj4g
V2hpY2ggaGFzIHRoZSBzYW1lIGRpZmYgYXMgeW91IHF1b3RlZCBmb3IgdGhlIHN0YWJsZSB0
cmVlLg0KDQpIbW0sIHNvbWV0aGluZyBpcyBmaXNoeSBoZXJlLg0KDQpMb29raW5nIGF0IHRo
ZSBzb3VyY2UgaW4gY3VycmVudCBIRUFEIG9mIExpbnVzJyB0cmVlIHNob3dzIG1lOg0KDQpz
dGF0aWMgaW50DQpfYmFzZV9jb25maWdfZG1hX2FkZHJlc3Npbmcoc3RydWN0IE1QVDNTQVNf
QURBUFRFUiAqaW9jLCBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCnsNCiAgICAgICAgIHN0cnVj
dCBzeXNpbmZvIHM7DQogICAgICAgICB1NjQgY29oZXJlbnRfZG1hX21hc2ssIGRtYV9tYXNr
Ow0KDQogICAgICAgICBpZiAoaW9jLT5pc19tY3B1X2VuZHBvaW50IHx8IHNpemVvZihkbWFf
YWRkcl90KSA9PSA0IHx8DQogICAgICAgICAgICAgZG1hX2dldF9yZXF1aXJlZF9tYXNrKCZw
ZGV2LT5kZXYpIDw9IDMyKSB7DQogICAgICAgICAgICAgICAgIGlvYy0+ZG1hX21hc2sgPSAz
MjsNCiAgICAgICAgICAgICAgICAgY29oZXJlbnRfZG1hX21hc2sgPSBkbWFfbWFzayA9IERN
QV9CSVRfTUFTSygzMik7DQogICAgICAgICAvKiBTZXQgNjMgYml0IERNQSBtYXNrIGZvciBh
bGwgU0FTMyBhbmQgU0FTMzUgY29udHJvbGxlcnMgKi8NCg0KVGhpcyBkb2Vzbid0IGxvb2sg
bGlrZSBjb21taXQgZTBlMDc0N2RlMGVhM2RkIGhhcyBiZWVuIGFwcGxpZWQuDQoNCmdpdCBs
b2cgZHJpdmVycy9zY3NpL21wdDNzYXMvbXB0M3Nhc19iYXNlLmMgZG9lc24ndCBzaG93IGl0
IGVpdGhlci4NCg0KZ2l0IG5hbWUtcmV2IGUwZTA3NDdkZTBlYTNkZCB0ZWxscyBtZSBpdCBz
aG91bGQgYmUgaW4gdjYuMC1yYzcuDQoNCg0KSnVlcmdlbg0K
--------------Tyxf3ySWUJiDFRHH0ip3jqDx
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Tyxf3ySWUJiDFRHH0ip3jqDx--

--------------nQfmobi3WurtVZY3p8acHADl--

--------------0rlDa9SQfT94UR4QIRjJLU0o
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNXZssFAwAAAAAACgkQsN6d1ii/Ey/Y
3Af/efKnoC1Imin1iahcfGy7nwXfrkxVY6xpdMTvy7aPOpWfaGhNmhnHHXVtpJlO408kzc1Sy27U
Ko5KmC/Af6NLkqbvd6lW/INkvHOHPJ1XxIJyoncP3IFEbJL8xDCrl41d3dQ0w0ReohCPFXvkhgTN
OeJgohZxj1MIOS15J6Vk/EYYCz03s0IpsgWythrDdZ9VAnqbpCSHuQ/+cVaDthsRY+4eDzGKi/3O
PkBrDltkaB0L/Y2kzH1P6eRez+P+mfts3zUvhM1sVdTB4d0O+ZRiOV8wQxrkhpp1wMt+iu7qXg7Y
TmayCYxmAnUTqq6kibX7wtwHkqV768lMtNGknVo29Q==
=WgiH
-----END PGP SIGNATURE-----

--------------0rlDa9SQfT94UR4QIRjJLU0o--
