Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB9694AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBMPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBMPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:19:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23177CA18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:18:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 509072184E;
        Mon, 13 Feb 2023 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676301529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOb+IL5ig8z4xsMbFjVhjykQYYTP972M2IdLfnX2EYE=;
        b=qb6jdfYnMAlqhvt5ZDYk1BT/6dXxmjQGkLid4Y0S12liyTzpiy5KC7xN9I/qPgx7Ulq2k2
        AZiTMN2WCwtoujJPq/0COdnFb6nVBa2xS7+kzC5VkynjLrGC8SzUphDJFYY+8JV9duTTVz
        3aHxwlQXH+k22Qpux7J85eFLjlnM97c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE18B1391B;
        Mon, 13 Feb 2023 15:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /DK4ONhU6mP7HQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 15:18:48 +0000
Message-ID: <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
Date:   Mon, 13 Feb 2023 16:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
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
 <Y+pTDFQlX9qNL35z@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y+pTDFQlX9qNL35z@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X0wZ0FTBxSCMxPqZG36OLAI6"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X0wZ0FTBxSCMxPqZG36OLAI6
Content-Type: multipart/mixed; boundary="------------9AowkjKk7DGThMIvvGs92yrE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, lists@nerdbynature.de,
 mikelley@microsoft.com, torvalds@linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <85de8576-05b7-400d-6020-7dba519c1d2e@suse.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com> <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com> <Y+pRK6a419jenR9R@zn.tnic>
 <Y+pTDFQlX9qNL35z@zn.tnic>
In-Reply-To: <Y+pTDFQlX9qNL35z@zn.tnic>

--------------9AowkjKk7DGThMIvvGs92yrE
Content-Type: multipart/mixed; boundary="------------Bbwh0yUt0sy0cKFhuiAobGdU"

--------------Bbwh0yUt0sy0cKFhuiAobGdU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMTY6MTEsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBG
ZWIgMTMsIDIwMjMgYXQgMDQ6MDM6MDdQTSArMDEwMCwgQm9yaXNsYXYgUGV0a292IHdyb3Rl
Og0KPj4+IFdvdWxkbid0ICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0hZUEVS
VklTT1IpIGJlIGVub3VnaD8NCj4+Pg0KPj4+IEknbSBub3Qgc3VyZSB3ZSB3b24ndCBuZWVk
IHRoYXQgZm9yIFREWCBndWVzdHMsIHRvby4NCj4+DQo+PiBTZWUsIHRoYXQncyB0aGUgcHJv
YmxlbS4gSSB3YW5uYSBoYXZlIGl0IHNpbXBsZSB0b28uIExlbW1lIGNoZWNrIHdpdGgNCj4+
IGRoYW5zZW4uDQo+IA0KPiBIZSBzYXlzIE1UUlJzIGFyZSBlbmFibGVkIGluIFREWCBndWVz
dHM6ICJYODZfRkVBVFVSRV9NVFJSIGlzIGZpeGVkIHRvDQo+IDEgaW4gVERYIGd1ZXN0cy4i
DQo+IA0KPiBTbyB3ZSB3aWxsIGhhdmUgdG8gZG8gdGhlIG1vcmUgZmluZXItZ3JhaW5lZCBj
aGVjayBJIGd1ZXNzLg0KDQpJc24ndCB0aGUgY2hlY2sgZm9yICFYODZfRkVBVFVSRV9NVFJS
ICYmIFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IgZW5vdWdoDQp0aGVuPw0KDQpZZXMsIHlvdSBz
dGlsbCBjb3VsZCBjb25zdHJ1Y3QgY2FzZXMgd2hlcmUgaXQgd291bGQgZ28gd3JvbmcsIGJ1
dCBJIGRvbid0DQp0aGluayB3ZSBzaG91bGQgb3Zlci1lbmdpbmVlciBpdC4NCg0KDQpKdWVy
Z2VuDQoNCg==
--------------Bbwh0yUt0sy0cKFhuiAobGdU
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Bbwh0yUt0sy0cKFhuiAobGdU--

--------------9AowkjKk7DGThMIvvGs92yrE--

--------------X0wZ0FTBxSCMxPqZG36OLAI6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPqVNgFAwAAAAAACgkQsN6d1ii/Ey94
dQf+L93V4weQhgc3YmhXgdCIDnIf24O4ESovfr6JqqjfPaBxzL2Qs0lNieCNYCLDxckS3A+lIwym
Y3QIrdjcGNmVhqr8WCRCiOGVMlD7ut50P4jwJpet6QHZ1BYEneDuKt5/Ghg5ZB2eSLawvU336+IL
P51qf2ga3gKknK8KzrLMDtXI4BvSm5aojD0XhI2vth4A8To+4IIUwZU6gOtENpGCIab9yefpB8fS
+OBi/suTWQZ3YZsN2m/+WvgjrCv0jseo4C2zkSQNZUI+IkThMZPwMZZPuKQJ+aBnQtNDwi0X+tIA
jr6+nPczv7H+00oGwa2E8MnMajRJ/xiVnvUwMqTgsg==
=/t3R
-----END PGP SIGNATURE-----

--------------X0wZ0FTBxSCMxPqZG36OLAI6--
