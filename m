Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337FB5FC85F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJLP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJLP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:26:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A544D17F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:26:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B422221C52;
        Wed, 12 Oct 2022 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665588370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W22no4UHHSLq7kZ7HGvm7b6REa1W65pcxdWLEl8piKk=;
        b=PTiQWe3U4bHLPCJI2dxB/KyCoAe4PJy9aRecJ5HW+crqwsRdiISGhSvGeYEpUpCPYGR0GC
        trHaSmrnxgLFY1/rwlqQj7vdVy0ePfHm+axtbmf+zOy15w1PyqD76Cd/k0y+cgbt/vzXUG
        N9wANPYoIFbi+FLljTE6Hx9DxN4ETx4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 384FE13ACD;
        Wed, 12 Oct 2022 15:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oA0CDJLcRmMMQQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 12 Oct 2022 15:26:10 +0000
Message-ID: <9fcdf79b-8956-b976-704a-3018542cc557@suse.com>
Date:   Wed, 12 Oct 2022 17:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
Content-Language: en-US
To:     Ross Philipson <ross.philipson@oracle.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        Jan Kiszka <jan.kiszka@siemens.com>,
        jailhouse-dev@googlegroups.com, xen-devel@lists.xenproject.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
 <Y0GTUg1ACpKZYMHY@nazgul.tnic>
 <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0IevKUioMcP602uAHkVuaiL3"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0IevKUioMcP602uAHkVuaiL3
Content-Type: multipart/mixed; boundary="------------oasnLHEdbuwWbRHotwxlosfR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Ross Philipson <ross.philipson@oracle.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, luto@amacapital.net, dave.hansen@linux.intel.com,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
 Jan Kiszka <jan.kiszka@siemens.com>, jailhouse-dev@googlegroups.com,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <9fcdf79b-8956-b976-704a-3018542cc557@suse.com>
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
 <Y0GTUg1ACpKZYMHY@nazgul.tnic>
 <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>
In-Reply-To: <201850b3-5126-cd79-637f-79f198dd409d@oracle.com>

--------------oasnLHEdbuwWbRHotwxlosfR
Content-Type: multipart/mixed; boundary="------------3wZ5tZFbtS6PNsirNBDZ207T"

--------------3wZ5tZFbtS6PNsirNBDZ207T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMTAuMjIgMTc6MTMsIFJvc3MgUGhpbGlwc29uIHdyb3RlOg0KPiBPbiAxMC84LzIy
IDExOjEyLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBBZGRpbmcgWGVuIGFuZCBKYWls
aG91c2UgcGVvcGxlIGFuZCBNTHMgdG8gQ2MuDQo+Pg0KPj4gRm9sa3MsIHRocmVhZCBzdGFy
dHMgaGVyZToNCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzE2NTAwMzU0MDEt
MjI4NTUtMS1naXQtc2VuZC1lbWFpbC1yb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tDQo+Pg0K
Pj4gT24gRnJpLCBBcHIgMTUsIDIwMjIgYXQgMTE6MTA6MDBBTSAtMDQwMCwgUm9zcyBQaGls
aXBzb24gd3JvdGU6DQo+Pj4gVGhlcmUgYXJlIGEgbnVtYmVyIG9mIHBsYWNlcyB3aGVyZSBl
YXJseV9tZW1yZW1hcCBpcyBjYWxsZWQNCj4+PiBidXQgdGhlIHJldHVybiBwb2ludGVyIGlz
IG5vdCBjaGVja2VkIGZvciBOVUxMLiBUaGUgY2FsbA0KPj4+IGNhbiByZXN1bHQgaW4gYSBO
VUxMIGJlaW5nIHJldHVybmVkIHNvIHRoZSBjaGVja3MgbXVzdA0KPj4+IGJlIGFkZGVkLg0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUm9zcyBQaGlsaXBzb24gPHJvc3MucGhpbGlwc29u
QG9yYWNsZS5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgYXJjaC94ODYva2VybmVsL2RldmljZXRy
ZWUuYyB8IDEwICsrKysrKysrKysNCj4+PiDCoCBhcmNoL3g4Ni9rZXJuZWwvZTgyMC5jwqDC
oMKgwqDCoMKgIHzCoCA1ICsrKysrDQo+Pj4gwqAgYXJjaC94ODYva2VybmVsL2phaWxob3Vz
ZS5jwqAgfMKgIDYgKysrKysrDQo+Pj4gwqAgYXJjaC94ODYva2VybmVsL21wcGFyc2UuY8Kg
wqDCoCB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqAgYXJjaC94ODYva2Vy
bmVsL3NldHVwLmPCoMKgwqDCoMKgIHzCoCA1ICsrKysrDQo+Pj4gwqAgYXJjaC94ODYveGVu
L2VubGlnaHRlbl9odm0uYyB8wqAgMiArKw0KPj4+IMKgIGFyY2gveDg2L3hlbi9tbXVfcHYu
Y8KgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKysrKysrDQo+Pj4gwqAgYXJjaC94ODYveGVuL3Nl
dHVwLmPCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsrDQo+Pj4gwqAgOCBmaWxlcyBjaGFuZ2Vk
LCA2MSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gT2ssIGEgY291cGxlIG9mIG5vdGVzOg0KPj4N
Cj4+IDEuIHRoZSBwcl8qKCI8cHJlZml4PjoiIC4uLiApDQo+Pg0KPj4gdGhpbmcgaXMgZG9u
ZSB1c2luZyBwcl9mbXQoKSAtIGdyZXAgdGhlIHRyZWUgZm9yIGV4YW1wbGVzLg0KPiANCj4g
SSBhbSBhbHJlYWR5IHVzaW5nIHRoZSBwcl8qIG1hY3JvcyBpbiB0aGUgcGF0Y2hlcy4gQXJl
IHlvdSBhc2tpbmcgbWUgdG8gZG8gDQo+IHNvbWV0aGluZyBvciBpcyB0aGlzIGp1c3QgaW5m
b3JtYXRpb25hbD8NCj4gDQo+Pg0KPj4gMi4gSSB0aGluayB5b3Ugc2hvdWxkIG5vdCBwYW5p
YygpIHRoZSBtYWNoaW5lIGJ1dCBpc3N1ZSBhIHRoZQ0KPj4gd2FybmluZy9lcnJvciBhbmQg
bGV0IHRoZSBtYWNoaW5lIGRpZSBhIHBhaW5mdWwgZGVhdGggYW55d2F5LiBCdXQgWGVuDQo+
PiBmb2xrcyB3aWxsIGtub3cgYmV0dGVyIHdoYXQgd291bGQgYmUgdGhlIG9wdGltYWwgdGhp
bmcgdG8gZG8uDQo+IA0KPiBXaGVuIEkgd2FzIHdvcmtpbmcgb24gdGhlIHBhdGNoZXMgSSBh
c2tlZCBBbmRyZXcgQ29vcGVyIGF0IENpdHJpeCB3aGF0IGFjdGlvbiBJIA0KPiBzaG91bGQg
dGFrZSBpZiBhbnkgb2YgdGhlIGNhbGxzIGluIHRoZSBYZW4gY29kZSBmYWlsZWQuIEkgYmVs
aWV2ZSBoZSB0b2xkIG1lIGl0IA0KPiB3YXMgYmFzaWNhbGx5IGZhdGFsIGFuZCB0aGF0IHBh
bmljKCkgd291bGQgYmUgZmluZSB0aGVyZS4NCg0KcGFuaWMoKSBpcyB0aGUgd2F5IHRvIGdv
LiBFdmVyeXRoaW5nIGVsc2Ugd291bGQgbWFrZSB0aGUgZXJyb3IgaGFyZGVyDQp0byBhbmFs
eXplLg0KDQpCVFcsIENDLWluZyB0aGUgbWFpbnRhaW5lcnMgb2YgdGhlIG1vZGlmaWVkIGNv
ZGUgaXMgZ29vZCBwcmFjdGljZS4NCg0KDQpKdWVyZ2VuDQo=
--------------3wZ5tZFbtS6PNsirNBDZ207T
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------3wZ5tZFbtS6PNsirNBDZ207T--

--------------oasnLHEdbuwWbRHotwxlosfR--

--------------0IevKUioMcP602uAHkVuaiL3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNG3JEFAwAAAAAACgkQsN6d1ii/Ey/k
lgf+IDHKz+H4WUZuhhBLYi/ie36DnrSYs3Q85onru8DhPm/nkXNghvChcB6XlT7+MJjrdZlkJQap
+WEVoJXXUDDuR+ngE9Ewn2Ua+XApqTW8YfvCz64rpgP1N8sksRf7rfb66/KNlHnmtwLnmVgnNFba
EK4PEjMXBt2k70dNlLxEY7Z03RCahwo/q60L9cHBcRE66uopoKx+COv/HWFeduP8RgZfPA8W3aFb
Rp3/sotWNLIy/oFvPpo/ILyJifzUUnWWn9/l+GyU2oFXsIHYG7F21mbpQfiGK3YUX2LzGILc2JhT
ax7ux5jmcS421T6ek9ozk5lML3l3+Ev38Idr4gUykQ==
=54GQ
-----END PGP SIGNATURE-----

--------------0IevKUioMcP602uAHkVuaiL3--
