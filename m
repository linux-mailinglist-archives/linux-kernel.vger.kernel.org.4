Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A81729E86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbjFIPaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjFIPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:30:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532719B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:30:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1BA721A52;
        Fri,  9 Jun 2023 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686324635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d94E8AgYIhh2TcR8GAa4pqXaKEyMXrp9qtcGnxmJ05Q=;
        b=FYARqL8+eFPf9B9O0l/vajm2HuBacoui0nQU6yR5BMtWOvEOdzC07XDO0HpVhAPLxOkTfl
        o7GduvkREDwPMh0RYmFlGwmj3BOyFA4bOXtz1IKyDHM522GWwTb2c1uh+g990XJczdCYEn
        Re+5TumIsxGtK0+6mUbdy/TQTi8C3p0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B4F213A47;
        Fri,  9 Jun 2023 15:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 15IlBZtFg2TCBQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 09 Jun 2023 15:30:35 +0000
Message-ID: <6d725c37-9612-ab87-3fea-04ab8b1086ed@suse.com>
Date:   Fri, 9 Jun 2023 17:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-US
To:     konrad@darnok.org, Dave Hansen <dave.hansen@intel.com>
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
 <2e28fcdb-f0ff-dca4-3dc4-34b11cc7e469@intel.com>
 <CAPbh3rtGXiQbzETmK3NdUt-R8D67+V907Rd+nX-OjQ6DNSfyWA@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <CAPbh3rtGXiQbzETmK3NdUt-R8D67+V907Rd+nX-OjQ6DNSfyWA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YdUb71KwJ80UEkQ6kOl4hleq"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YdUb71KwJ80UEkQ6kOl4hleq
Content-Type: multipart/mixed; boundary="------------Da5MB78BOV6dm0E1QoP0oX5u";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: konrad@darnok.org, Dave Hansen <dave.hansen@intel.com>
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>,
 LKML <linux-kernel@vger.kernel.org>, xen-devel@lists.xenproject.org,
 Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Peter Jones
 <pjones@redhat.com>, Konrad Rzeszutek Wilk <konrad@kernel.org>
Message-ID: <6d725c37-9612-ab87-3fea-04ab8b1086ed@suse.com>
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
 <2e28fcdb-f0ff-dca4-3dc4-34b11cc7e469@intel.com>
 <CAPbh3rtGXiQbzETmK3NdUt-R8D67+V907Rd+nX-OjQ6DNSfyWA@mail.gmail.com>
In-Reply-To: <CAPbh3rtGXiQbzETmK3NdUt-R8D67+V907Rd+nX-OjQ6DNSfyWA@mail.gmail.com>

--------------Da5MB78BOV6dm0E1QoP0oX5u
Content-Type: multipart/mixed; boundary="------------AalVfgcSf6WC5ftLUErmhx3J"

--------------AalVfgcSf6WC5ftLUErmhx3J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDYuMjMgMTc6MjcsIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3cm90ZToNCj4gVXN1
YWxseSBJIHB1dCBpdCBpbiBteSB0cmVlIChpYmZ0KSBidXQgc2luY2UgaXQgaXMgc28gc2lt
cGxlIGFuZCB0aGUgdXNlciBpcyBYZW4gDQo+IGl0IHdvdWxkIG1ha2UgbW9yZSBzZW5zZSB0
byBkbyBpdCB2aWEgdGhlIFhlbiB0cmVlIChKdWVyZ2VuKS4NCg0KV29ya3MgZm9yIG1lLg0K
DQoNCkp1ZXJnZW4NCg0KPiANCj4gVGh4DQo+IA0KPiBPbiBGcmksIEp1biA5LCAyMDIzLCAx
MToxNiBBTSBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tIA0KPiA8bWFpbHRv
OmRhdmUuaGFuc2VuQGludGVsLmNvbT4+IHdyb3RlOg0KPiANCj4gICAgIE9uIDYvNS8yMyAw
MzoyOCwgUm9zcyBMYWdlcndhbGwgd3JvdGU6DQo+ICAgICAgPiBUaGUgcmVzdWx0IG9mIHRo
ZXNlIGNoYW5nZXMgaXMgdGhhdCBpdCBpcyBwb3NzaWJsZSB0byBib290IGEgZGlza2xlc3MN
Cj4gICAgICA+IFhlbiArIERvbTAgcnVubmluZyBvZmYgYW4gaVNDU0kgZGlzayB3aGVyZWFz
IHByZXZpb3VzbHkgaXQgd291bGQgZmFpbCB0bw0KPiAgICAgID4gZmluZCB0aGUgaUJGVCBh
bmQgY29uc2VxdWVudGx5LCB0aGUgaVNDU0kgcm9vdCBkaXNrLg0KPiANCj4gICAgIEFja2Vk
LWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tDQo+ICAgICA8
bWFpbHRvOmRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4+ICMgZm9yIHg4Ng0KPiANCj4g
ICAgIFRoZSB3b3JrIGluIHRoaXMgcGF0Y2ggc2VlbXMgcHJldHR5IGV2ZW5seSBzcGxpdCBi
ZXR3ZWVuIHg4NiBhbmQgaVNDU0kuDQo+ICAgICBBbnkgcHJlZmVyZW5jZXMgb24gd2hvIHBp
Y2tzIGl0IHVwPw0KPiANCg0K
--------------AalVfgcSf6WC5ftLUErmhx3J
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------AalVfgcSf6WC5ftLUErmhx3J--

--------------Da5MB78BOV6dm0E1QoP0oX5u--

--------------YdUb71KwJ80UEkQ6kOl4hleq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSDRZoFAwAAAAAACgkQsN6d1ii/Ey8g
KAf9GS4tYCjeixFx5AZsFx6igVAUnOEQ0lKrYmt8EqYspuYkKQeZC4N2P/3v6rZYsDfgIDSr8+m6
Xbm/dgVUXJszvjuONQylQD+xJ/wJe+OJntTZAcDo7Q97vnSjGHY3igFNcTq8FX7XCR++aQUZovQR
EhgSCXDJzT8QoMKMW/yO8fXIWqZA4xWCfHsV/nb+uNlF7j785jVjnKGja2D1Y5I7sEXokwrqSSRN
nLkyY3nFZZyeUkLfMWTzprf1CUT66AaQ0xma8UdkOdPx22jVoGLm6JcfNTKAq/5GviGE7yan/H9I
9P09rAkpaiIgMJ+qCRkeX/7gP3tVAaPlZAgShaH/ag==
=IhaL
-----END PGP SIGNATURE-----

--------------YdUb71KwJ80UEkQ6kOl4hleq--
