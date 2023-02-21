Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D969DC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjBUIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjBUIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:47:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9237234E9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:47:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DBE35C292;
        Tue, 21 Feb 2023 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676969245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fm3hPdB5PlDvDGKs2HpYZScsPgUDguT6fZOTv+Wh0PE=;
        b=VZW32+1BYbtgREkjm+6g0MuS+3gD7WRg/T7xGeI1/uwp4ani7JBqa8yEoQFOYjbAKRSfnd
        DdtEMw4ueW0i/CdD/LWkk58TJnpz9PJGNbc976k9QZV/o3GCAtt2JwtbTUH58sD+Ub11Og
        O6TX7f/2DIgmkqcC2Z6Ar9SZTxdOSzY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18E8C13481;
        Tue, 21 Feb 2023 08:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JJulBB2F9GPIEwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 21 Feb 2023 08:47:25 +0000
Message-ID: <cd9acc63-c352-93c8-56bf-52ef69e5e124@suse.com>
Date:   Tue, 21 Feb 2023 09:47:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx> <20230221041440.GA1934@templeofstupid.com>
 <20230221055117.GA1934@templeofstupid.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230221055117.GA1934@templeofstupid.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------01t2a227HP0z0isoz31TbdIv"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------01t2a227HP0z0isoz31TbdIv
Content-Type: multipart/mixed; boundary="------------aEejvVXcvRh3zvA1PUMyYEgB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Krister Johansen <kjlx@templeofstupid.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Jan Beulich <jbeulich@suse.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori
 <aliguori@amazon.com>, David Reaver <me@davidreaver.com>,
 Brendan Gregg <brendan@intel.com>
Message-ID: <cd9acc63-c352-93c8-56bf-52ef69e5e124@suse.com>
Subject: Re: [PATCH linux-next 2/2] x86/xen/time: cleanup
 xen_tsc_safe_clocksource
References: <cover.1676610413.git.kjlx@templeofstupid.com>
 <f6bab47230b00cecb67f2c5d94716c8236609967.1676610413.git.kjlx@templeofstupid.com>
 <87h6vgov2p.ffs@tglx> <20230221041440.GA1934@templeofstupid.com>
 <20230221055117.GA1934@templeofstupid.com>
In-Reply-To: <20230221055117.GA1934@templeofstupid.com>

--------------aEejvVXcvRh3zvA1PUMyYEgB
Content-Type: multipart/mixed; boundary="------------Nc2aeEGlKWS5cu0pOGONczrT"

--------------Nc2aeEGlKWS5cu0pOGONczrT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDIuMjMgMDY6NTEsIEtyaXN0ZXIgSm9oYW5zZW4gd3JvdGU6DQo+IE9uIE1vbiwg
RmViIDIwLCAyMDIzIGF0IDA4OjE0OjQwUE0gLTA4MDAsIEtyaXN0ZXIgSm9oYW5zZW4gd3Jv
dGU6DQo+PiBPbiBNb24sIEZlYiAyMCwgMjAyMyBhdCAxMTowMToxOFBNICswMTAwLCBUaG9t
YXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4gT24gTW9uLCBGZWIgMjAgMjAyMyBhdCAwOToxNywg
S3Jpc3RlciBKb2hhbnNlbiB3cm90ZToNCj4+Pj4gQEAgLTQ5NSw4ICs0OTYsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCB4ZW5fdHNjX3NhZmVfY2xvY2tzb3VyY2Uodm9pZCkNCj4+Pj4gICAJ
LyogTGVhZiA0LCBzdWItbGVhZiAwICgweDQwMDAweDAzKSAqLw0KPj4+PiAgIAljcHVpZF9j
b3VudCh4ZW5fY3B1aWRfYmFzZSgpICsgMywgMCwgJmVheCwgJmVieCwgJmVjeCwgJmVkeCk7
DQo+Pj4+ICAgDQo+Pj4+IC0JLyogdHNjX21vZGUgPSBub19lbXVsYXRlICgyKSAqLw0KPj4+
PiAtCWlmIChlYnggIT0gMikNCj4+Pj4gKwlpZiAoZWJ4ICE9IFhFTl9DUFVJRF9UU0NfTU9E
RV9ORVZFUl9FTVVMQVRFKQ0KPj4+PiAgIAkJcmV0dXJuIDA7DQo+Pj4+ICAgDQo+Pj4+ICAg
CXJldHVybiAxOw0KPj4+DQo+Pj4gV2hhdCBhYm91dCByZW1vdmluZyBtb3JlIHN0dXBpZGl0
eSBmcm9tIHRoYXQgZnVuY3Rpb24/DQo+Pj4NCj4+PiBzdGF0aWMgYm9vbCBfX2luaXQgeGVu
X3RzY19zYWZlX2Nsb2Nrc291cmNlKHZvaWQpDQo+Pj4gew0KPj4+IAl1MzIgZWF4LCBlYngu
IGVjeCwgZWR4Ow0KPj4+ICAgDQo+Pj4gCS8qIExlYWYgNCwgc3ViLWxlYWYgMCAoMHg0MDAw
MHgwMykgKi8NCj4+PiAJY3B1aWRfY291bnQoeGVuX2NwdWlkX2Jhc2UoKSArIDMsIDAsICZl
YXgsICZlYngsICZlY3gsICZlZHgpOw0KPj4+DQo+Pj4gCXJldHVybiBlYnggPT0gWEVOX0NQ
VUlEX1RTQ19NT0RFX05FVkVSX0VNVUxBVEU7DQo+Pj4gfQ0KPj4NCj4+IEknbSBhbGwgZm9y
IHNpbXBsaWZ5aW5nLiAgSSdtIGhhcHB5IHRvIGNsZWFuIHVwIHRoYXQgcmV0dXJuIHRvIGJl
IG1vcmUNCj4+IGlkaW9tYXRpYy4gIEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uLCBwZXJo
YXBzIG1pc3Rha2VuLCB0aG91Z2gsIHRoYXQNCj4+IHRoZSBYODZfRkVBVFVSRV9DT05TVEFO
VF9UU0MsIFg4Nl9GRUFUVVJFX05PTlNUT1BfVFNDLCBhbmQNCj4+IGNoZWNrX3RzY191bnN0
YWJsZSgpIGNoZWNrcyB3ZXJlIGFjdHVhbGx5IHNlcnZpbmcgYSBwdXJwb3NlOiB0byBlbnN1
cmUNCj4+IHRoYXQgd2UgZG9uJ3QgcmVseSBvbiB0aGUgdHNjIGluIGVudmlyb25tZW50cyB3
aGVyZSBpdCdzIGJlaW5nIGVtdWxhdGVkDQo+PiBhbmQgdGhlIE9TIHdvdWxkIGJlIGJldHRl
ciBzZXJ2ZWQgYnkgdXNpbmcgYSBQViBjbG9jay4gIFNwZWNpZmljYWxseSwNCj4+IGt2bWNs
b2NrX2luaXQoKSBtYWtlcyBhIHZlcnkgc2ltaWxhciBzZXQgb2YgY2hlY2tzIHRoYXQgSSBh
bHNvIHRob3VnaHQNCj4+IHdlcmUgbG9hZC1iZWFyaW5nLg0KPiANCj4gQmFoLCB3aGF0IEkg
bWVhbnQgdG8gc2F5IHdhcyBlbXVsYXRlZCwgdW5zdGFibGUsIG9yIG90aGVyd2lzZSB1bnN1
aXRhYmxlDQo+IGZvciB1c2UgYXMgYSBjbG9ja3NvdXJjZS4gIElPVywgZXZlbiBpZiBUU0Nf
TU9ERV9ORVZFUl9FTVVMQVRFIGlzDQo+IHNldCwgaXQncyBwb3NzaWJsZSB0aGF0IGEgdXNl
ciBpcyBhdHRlbXB0aW5nIGEgbWlncmF0aW9uIGZyb20gYSBjcHUNCj4gdGhhdCdzIG5vdCBp
bnZhcmlhbnQsIGFuZCB3ZSdkIHN0aWxsIHdhbnQgdG8gY2hlY2sgZm9yIHRoYXQgY2FzZSBh
bmQNCj4gZmFsbCBiYWNrIHRvIGEgUFYgY2xvY2tzb3VyY2UsIGNvcnJlY3Q/DQoNCkJ1dCBU
aG9tYXMnIHN1Z2dlc3Rpb24gd2Fzbid0IGNoYW5naW5nIGFueSBiZWhhdmlvciBjb21wYXJl
ZCB0byB5b3VyDQpwYXRjaC4gSXQganVzdCBtYWtlcyBpdCBlYXNpZXIgdG8gcmVhZC4NCg0K
SWYgeW91IGFyZSB1bnN1cmUgeW91ciBwYXRjaCBpcyBjb3JyZWN0LCBwbGVhc2UgdmVyaWZ5
IHRoZSBjb3JyZWN0bmVzcw0KYmVmb3JlIHNlbmRpbmcgaXQuDQoNCg0KSnVlcmdlbg0K
--------------Nc2aeEGlKWS5cu0pOGONczrT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Nc2aeEGlKWS5cu0pOGONczrT--

--------------aEejvVXcvRh3zvA1PUMyYEgB--

--------------01t2a227HP0z0isoz31TbdIv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmP0hRwFAwAAAAAACgkQsN6d1ii/Ey+J
MQf/REaZWsbBxqfUfWrsv5p352OpZ30WPmQLE0zlyV2JQRAtiv0Wx18En8w2yPvjexkGD6PGjMoH
jdIBmRxHl6erwOgVXvi39/AR0HP7EewwQhdY22so4BHELHeDNiOTB6mUM7AojUB0D97wTnMmAevw
3Bbh0mMs3CtFf9QOIiQk7StDoo+eTp6p3ufD0OKSPjB/vkBKv0QTZnGY2gvAolLxeblSgvtQvsjf
/Ii478peLPJDnNLiT1CqDQMsGlG6o2+ChiJ8ZYBGT+71W0oLjF3OdARNDSY3dKo8nvt0MUVPLTYR
Cwie64GZMwrHIk2Gbc9GmM9wYaIwXBUAuqU9kUr00g==
=PQf+
-----END PGP SIGNATURE-----

--------------01t2a227HP0z0isoz31TbdIv--
