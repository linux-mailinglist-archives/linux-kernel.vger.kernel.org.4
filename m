Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E7694B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBMPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjBMPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:36:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E5712F37
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:36:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F3A521835;
        Mon, 13 Feb 2023 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676302573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7iLXBg6WNjTkP+gQPSNdpfq/WvDWsg0IABLgJDyTPV4=;
        b=fr+A4et96/JY0zm4pAE2w4BMOYVHpgmwX+S1VFdyIqMciFA1FFqV6O1OBkPgw7tGcJseQo
        GWzlLU0Rda8pGMA/qZxsFQsrCuka8KcOyZQ9w9s//J9sLGihAT5CdpHJfvrMQvWSplY2H6
        j6K64sdmxviWhIqBPsnBWA1OpUnZJW8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8FB31391B;
        Mon, 13 Feb 2023 15:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vw3KK+xY6mMIJwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 15:36:12 +0000
Message-ID: <13520f45-7f4d-417e-f9a2-40c32cd0e739@suse.com>
Date:   Mon, 13 Feb 2023 16:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
In-Reply-To: <Y+pRK6a419jenR9R@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ByQ5UyBJgnk2VYROo9yUT7ss"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ByQ5UyBJgnk2VYROo9yUT7ss
Content-Type: multipart/mixed; boundary="------------dOZgYE4xxhlTWtjl05596q7N";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <13520f45-7f4d-417e-f9a2-40c32cd0e739@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
In-Reply-To: <Y+pRK6a419jenR9R@zn.tnic>

--------------dOZgYE4xxhlTWtjl05596q7N
Content-Type: multipart/mixed; boundary="------------7UxLlLCvooXnrTvTqpboIHL0"

--------------7UxLlLCvooXnrTvTqpboIHL0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTY6MDMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBG
ZWIgMTMsIDIwMjMgYXQgMDM6MDc6MDdQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEZpeGVkIGluIHRoZSBzZW5zZSBvZiBzdGF0aWMuDQo+IA0KPiBXZWxsLCB5b3UgY2Fu
J3QgdXNlICJmaXhlZCIgdG8gc2F5ICJzdGF0aWMiIHdoZW4gZm9ybWVyIG1lYW5zIHNvbWV0
aGluZw0KPiB2ZXJ5IHNwZWNpZmljIGFscmVhZHkgaW4gTVRSUiBsYW5kLg0KPiANCj4+IFdv
dWxkbid0ICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpIGJl
IGVub3VnaD8NCj4+DQo+PiBJJ20gbm90IHN1cmUgd2Ugd29uJ3QgbmVlZCB0aGF0IGZvciBU
RFggZ3Vlc3RzLCB0b28uDQo+IA0KPiBTZWUsIHRoYXQncyB0aGUgcHJvYmxlbS4gSSB3YW5u
YSBoYXZlIGl0IHNpbXBsZSB0b28uIExlbW1lIGNoZWNrIHdpdGgNCj4gZGhhbnNlbi4NCj4g
DQo+PiBZZXMsIGl0IGlzIG9ubHkgcmVsZXZhbnQgZm9yIFBWIGRvbTAuDQo+IA0KPiBSaWdo
dCwgSSB3YXMgYXNraW5nIHdoZXRoZXIgIlBWIGRvbTAiID09IFg4Nl9GRUFUVVJFX1hFTlBW
Pw0KDQpObywgeW91IGNhbiBoYXZlIFBWIGd1ZXN0cyBub3QgYmVpbmcgZG9tMC4NCg0KPiAN
Cj4gOikNCj4gDQo+PiBUaGUgbnVtYmVyIG9mIGZpeGVkIE1UUlJzIGlzIG5vdCBkeW5hbWlj
IEFGQUlLLg0KPiANCj4gQnV0IG5vdGhpbmcgZ3VhcmFudGVlcyB0aGF0IHRoZSBjYWxsZXIg
d291bGQgcGFzcyBhbiBhcnJheSAibXRycl90eXBlDQo+ICpmaXhlZCIgb2Ygc2l6ZSBNVFJS
X05VTV9GSVhFRF9SQU5HRVMsIHJpZ2h0Pw0KDQpSaWdodC4NCg0KSW4gdGhlIGVuZCBJIHdv
dWxkbid0IG1pbmQgZHJvcHBpbmcgdGhlIGZpeGVkIE1UUlJzIGZyb20gdGhlIGludGVyZmFj
ZSwgYXMNCnRoZXkgYXJlIGN1cnJlbnRseSBub3QgbmVlZGVkIGF0IGFsbC4NCg0KPiANCj4+
IEEgc2luZ2xlIGludGVyZmFjZSBtYWtlcyBpdCBlYXNpZXIgdG8gYXZvaWQgbXVsdGlwbGUg
Y2FsbHMuDQo+Pg0KPj4gSW4gdGhlIGVuZCBJJ20gZmluZSB3aXRoIGVpdGhlciB3YXkuDQo+
IA0KPiBZZWFoLCBJIGtub3cuIFF1ZXN0aW9uIGlzLCBob3cgbXVjaCBvZiB0aGlzIGZ1bmN0
aW9uYWxpdHkgd2lsbCBiZQ0KPiBuZWVkZWQvdXNlZCBzbyB0aGF0IHdlIGNhbiBnbyBhbGwg
b3V0IG9uIHRoZSBpbnRlcmZhY2UgZGVzaWduIG9yIHdlIGNhbg0KPiBkbyBhIHNpbmdsZSBv
bmUgYW5kIGZvcmdldCBhYm91dCBpdC4uLg0KDQpJJ2Qgc2F5IHdlIGdvIHdpdGggd2hhdCBp
cyBuZWVkZWQgcmlnaHQgbm93LiBBbmQgaGF2aW5nIGEgc2luZ2xlIGludGVyZmFjZQ0KbWFr
ZXMgYWxsIHRoZSBzYW5pdHkgY2hlY2tpbmcgeW91IGFyZSBhc2tpbmcgZm9yIGVhc2llci4N
Cg0KPiANCj4+PiBDYW4gWGVuIHVzZSB4ODZfaHlwZXJfdHlwZSgpIHRvbz8NCj4+DQo+PiBJ
dCBkb2VzLg0KPiANCj4gVGhlbiBwbHMgYWRkIGEgeDg2X2h5cGVyX3R5cGUgY2hlY2sgdG9v
IHRvIG1ha2Ugc3VyZSBhIHBvdGVudGlhbCBtb3ZlIG9mDQo+IHRoaXMgY2FsbCBpcyBjYXVn
aHQgaW4gdGhlIGZ1dHVyZS4NCg0KV2hhdCBhcmUgeW91IGVzcGVjaWFsbHkgYXNraW5nIGZv
cj8NCg0KV2l0aCBteSBjdXJyZW50IHBhdGNoZXMgWGVuIFBWIGRvbTAgd2lsbCBjYWxsIG10
cnJfb3ZlcndyaXRlX3N0YXRlKCkgYmVmb3JlDQp4ODZfaHlwZXJfdHlwZSBpcyBzZXQsIHdo
aWxlIGEgSHlwZXItViBTRVYtU05QIGd1ZXN0IHdpbGwgbWFrZSB0aGUgY2FsbCBhZnRlcg0K
aXQgaGFzIGJlZW4gc2V0LiBCb3RoIGNhbGxzIGhhcHBlbiBiZWZvcmUgY2FjaGVfYnBfaW5p
dCgpLg0KDQpTbyBJIGNvdWxkIG1vdmUgdGhlIG10cnJfb3ZlcndyaXRlX3N0YXRlKCkgY2Fs
bCBmb3IgWGVuIFBWIGRvbTAgaW50byBpdHMNCmluaXRfcGxhdGZvcm0oKSBjYWxsYmFjayBh
bmQgY2hlY2sgaW4gbXRycl9vdmVyd3JpdGVfc3RhdGUoKSB4ODZfaHlwZXJfdHlwZQ0KdG8g
YmUgc2V0LCBvciBJIGNvdWxkIHJlamVjdCBhIGNhbGwgb2YgbXRycl9vdmVyd3JpdGVfc3Rh
dGUoKSBhZnRlciB0aGUgY2FsbA0Kb2YgY2FjaGVfYnBfaW5pdCgpIGhhcyBoYXBwZW5lZCwg
b3IgSSBjb3VsZCBkbyBib3RoLg0KDQoNCkp1ZXJnZW4NCg==
--------------7UxLlLCvooXnrTvTqpboIHL0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------7UxLlLCvooXnrTvTqpboIHL0--

--------------dOZgYE4xxhlTWtjl05596q7N--

--------------ByQ5UyBJgnk2VYROo9yUT7ss
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPqWOwFAwAAAAAACgkQsN6d1ii/Ey9H
Gwf/TmExUazq7VxNG8vKmroAIpKAOKm7C2zYLkJB4ZUVwO9eWupV+JvzBMzwK6kMiVKNNgzeDhZX
O5SPIj523NvIWfhRV5dOT4h3A1BGihV7BAKHqZxjKWOHJvzJHAJtvNBDTmF9G3IDCiPk4Scgb1mo
t/qK9IfUUzU2X1mbxHTSD4gFxcd6NwjZcn9FwSaALaKVjjWiKbG5vdR40eYvD+pUy+gQgIgAbiz2
YuaRdwq0KM7F48hA3d1O6RdLt0EsvJEGq4YL1m86bHbbVCuMl+1BcChzfBWIhgtA9O9SG/fzJjtz
F8qYdh9hZz4SVuPuuGuea+SZCMzdQFT5NQt4M4hmiw==
=MKcq
-----END PGP SIGNATURE-----

--------------ByQ5UyBJgnk2VYROo9yUT7ss--
