Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3321C729DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjFIPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjFIPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:08:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027035AC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:08:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86C721FDF7;
        Fri,  9 Jun 2023 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686323313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyXQdqFRmgObnfEOQbBv8T12i3muDroYiZVMZoQ7xA4=;
        b=AAkQV1lc0zKowuEDwSF71lAMUt6ug+Wf76t8n+l4ZPuEu+Zon6mXjNCCuhGXdOBeT0Xto8
        y01RJ7l/V14zr+3rlRy0fv5x4Kce65aOTT3jhkb3MNZDLuisXTs5plfF+e00Wq8O6VD+lT
        7c/BnWqvS0lIGO2p4VKqa66GLvwRj9w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3376613A47;
        Fri,  9 Jun 2023 15:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NnMoC3FAg2TjfAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 09 Jun 2023 15:08:33 +0000
Message-ID: <f2ccd563-4fac-084f-bd11-e6819dff5710@suse.com>
Date:   Fri, 9 Jun 2023 17:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-US
To:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MpO0aqOHPizWxQTFzinPIViv"
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
--------------MpO0aqOHPizWxQTFzinPIViv
Content-Type: multipart/mixed; boundary="------------VYzwh8M6sjS0dNkhphJsn5i2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Ross Lagerwall <ross.lagerwall@citrix.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org
Cc: Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Peter Jones
 <pjones@redhat.com>, Konrad Rzeszutek Wilk <konrad@kernel.org>
Message-ID: <f2ccd563-4fac-084f-bd11-e6819dff5710@suse.com>
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
In-Reply-To: <20230605102840.1521549-1-ross.lagerwall@citrix.com>

--------------VYzwh8M6sjS0dNkhphJsn5i2
Content-Type: multipart/mixed; boundary="------------FRRN0O07PbwvhNz4VuUV0kKu"

--------------FRRN0O07PbwvhNz4VuUV0kKu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDUuMDYuMjMgMTI6MjgsIFJvc3MgTGFnZXJ3YWxsIHdyb3RlOg0KPiBUbyBmYWNpbGl0
YXRlIGRpc2tsZXNzIGlTQ1NJIGJvb3QsIHRoZSBmaXJtd2FyZSBjYW4gcGxhY2UgYSB0YWJs
ZSBvZg0KPiBjb25maWd1cmF0aW9uIGRldGFpbHMgaW4gbWVtb3J5IGNhbGxlZCB0aGUgaUJG
VC4gVGhlIHByZXNlbmNlIG9mIHRoaXMNCj4gdGFibGUgaXMgbm90IHNwZWNpZmllZCwgbm9y
IGlzIHRoZSBwcmVjaXNlIGxvY2F0aW9uIChhbmQgaXQncyBub3QgaW4gdGhlDQo+IEU4MjAp
IHNvIHRoZSBrZXJuZWwgaGFzIHRvIHNlYXJjaCBmb3IgYSBtYWdpYyBtYXJrZXIgdG8gZmlu
ZCBpdC4NCj4gDQo+IFdoZW4gcnVubmluZyB1bmRlciBYZW4sIERvbSAwIGRvZXMgbm90IGhh
dmUgYWNjZXNzIHRvIHRoZSBlbnRpcmUgaG9zdCdzDQo+IG1lbW9yeSwgb25seSBjZXJ0YWlu
IHJlZ2lvbnMgd2hpY2ggYXJlIGlkZW50aXR5LW1hcHBlZCB3aGljaCBtZWFucyB0aGF0DQo+
IHRoZSBwc2V1ZG8tcGh5c2ljYWwgYWRkcmVzcyBpbiBEb20wID09IHJlYWwgaG9zdCBwaHlz
aWNhbCBhZGRyZXNzLg0KPiBBZGQgdGhlIGlCRlQgc2VhcmNoIGJvdW5kcyBhcyBhIHJlc2Vy
dmVkIHJlZ2lvbiB3aGljaCBjYXVzZXMgaXQgdG8gYmUNCj4gaWRlbnRpdHktbWFwcGVkIGlu
IHhlbl9zZXRfaWRlbnRpdHlfYW5kX3JlbWFwX2NodW5rKCkgd2hpY2ggYWxsb3dzIERvbTAN
Cj4gYWNjZXNzIHRvIHRoZSBzcGVjaWZpYyBwaHlzaWNhbCBtZW1vcnkgdG8gY29ycmVjdGx5
IHNlYXJjaCBmb3IgdGhlIGlCRlQNCj4gbWFnaWMgbWFya2VyIChhbmQgbGF0ZXIgYWNjZXNz
IHRoZSBmdWxsIHRhYmxlKS4NCj4gDQo+IFRoaXMgbmVjZXNzaXRhdGVzIG1vdmluZyB0aGUg
Y2FsbCB0byByZXNlcnZlX2liZnRfcmVnaW9uKCkgc29tZXdoYXQNCj4gbGF0ZXIgc28gdGhh
dCBpdCBpcyBjYWxsZWQgYWZ0ZXIgZTgyMF9fbWVtb3J5X3NldHVwKCkgd2hpY2ggaXMgd2hl
biB0aGUNCj4gWGVuIGlkZW50aXR5IG1hcHBpbmcgYWRqdXN0bWVudHMgYXJlIGFwcGxpZWQu
IFRoZSBwcmVjaXNlIGxvY2F0aW9uIG9mDQo+IHRoZSBjYWxsIGlzIG5vdCB0b28gaW1wb3J0
YW50IHNvIEkndmUgcHV0IGl0IGFsb25nc2lkZSBkbWlfc2V0dXAoKSB3aGljaA0KPiBkb2Vz
IHNpbWlsYXIgc2Nhbm5pbmcgb2YgbWVtb3J5IGZvciBjb25maWd1cmF0aW9uIHRhYmxlcy4N
Cj4gDQo+IEZpbmFsbHkgaW4gdGhlIGlCRlQgZmluZCBjb2RlLCBpbnN0ZWFkIG9mIHVzaW5n
IGlzYV9idXNfdG9fdmlydCgpIHdoaWNoDQo+IGRvZXNuJ3QgZG8gdGhlIHJpZ2h0IHRoaW5n
IHVuZGVyIFhlbiwgdXNlIGVhcmx5X21lbXJlbWFwKCkgbGlrZSB0aGUNCj4gZG1pX3NldHVw
KCkgY29kZSBkb2VzLg0KPiANCj4gVGhlIHJlc3VsdCBvZiB0aGVzZSBjaGFuZ2VzIGlzIHRo
YXQgaXQgaXMgcG9zc2libGUgdG8gYm9vdCBhIGRpc2tsZXNzDQo+IFhlbiArIERvbTAgcnVu
bmluZyBvZmYgYW4gaVNDU0kgZGlzayB3aGVyZWFzIHByZXZpb3VzbHkgaXQgd291bGQgZmFp
bCB0bw0KPiBmaW5kIHRoZSBpQkZUIGFuZCBjb25zZXF1ZW50bHksIHRoZSBpU0NTSSByb290
IGRpc2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb3NzIExhZ2Vyd2FsbCA8cm9zcy5sYWdl
cndhbGxAY2l0cml4LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------FRRN0O07PbwvhNz4VuUV0kKu
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------FRRN0O07PbwvhNz4VuUV0kKu--

--------------VYzwh8M6sjS0dNkhphJsn5i2--

--------------MpO0aqOHPizWxQTFzinPIViv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSDQHAFAwAAAAAACgkQsN6d1ii/Ey/7
UAf6A1EdYB1UDIAliXeURevLWbCz1ll1QMq2+0LNbTntjftcBzNckEif5Ee8IniwRlmAK/pPkYG4
XIs0+zPlHTtdfK/7nQbd1DgaRB96W0AozwY0G2MroJ1cdWfOZ6N1KBggA21LvrzCO+Auxzj+Xwzi
0jUx6i4hnWsudjOARbJQNJWomylj6xz0XSq+img8UIq8BF5seX/LIxdUfYbKdkDm1xe3cd2R8wDT
f2cPijZUXJVw4nw4ip/svSR8pBx2H8Se1A8jbAfhH155Fvdlc0YnQ12JBUfWM3eaeZnxcvMXzF/R
kSxcO4ovE9UbRYaRfuglJkTxyWmXIZdXdeHTIjZ+6Q==
=WKT/
-----END PGP SIGNATURE-----

--------------MpO0aqOHPizWxQTFzinPIViv--
