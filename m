Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C5622EFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiKIPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiKIPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:24:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0981B7AF;
        Wed,  9 Nov 2022 07:24:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 13FEA1FB24;
        Wed,  9 Nov 2022 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668007489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/h/TMHEUTfyTfhuu2EMosENEOQ/VLbsKaCfth4fP9hw=;
        b=F+F+xEBuI0SlDyJJTea76CWeJ3zexPwfadkeMtTTowULPi9DNWW8N9dM3nCk0RjvdVCEPI
        OpBfKwUEEJ9teCb+tn4XOcmkF25ofQ/dIhFfh8QPw3fV32VktlXVTBEIMo/lKBL+fP4Rsa
        ubf2aFXheloI9N0ecgoPwN5Rkkleiek=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C454B139F1;
        Wed,  9 Nov 2022 15:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y0thLkDGa2MBTAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 09 Nov 2022 15:24:48 +0000
Message-ID: <4367a7a8-e6b8-bebe-b2df-0294a755dec8@suse.com>
Date:   Wed, 9 Nov 2022 16:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] platform/x86: don't unconditionally attach Intel PMC when
 virtualized
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <20221109151632.71495-1-roger.pau@citrix.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221109151632.71495-1-roger.pau@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2eyCm9MBjVdWXHgvB4E7RBQ8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2eyCm9MBjVdWXHgvB4E7RBQ8
Content-Type: multipart/mixed; boundary="------------ViX4Jc0TPFjRe3trbVD5etMB";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Mark Gross <markgross@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
Message-ID: <4367a7a8-e6b8-bebe-b2df-0294a755dec8@suse.com>
Subject: Re: [PATCH] platform/x86: don't unconditionally attach Intel PMC when
 virtualized
References: <20221109151632.71495-1-roger.pau@citrix.com>
In-Reply-To: <20221109151632.71495-1-roger.pau@citrix.com>

--------------ViX4Jc0TPFjRe3trbVD5etMB
Content-Type: multipart/mixed; boundary="------------0eTp3pkl7DlAXWEHTXDpsSqd"

--------------0eTp3pkl7DlAXWEHTXDpsSqd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMTEuMjIgMTY6MTYsIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToNCj4gVGhlIGN1cnJl
bnQgbG9naWMgaW4gdGhlIEludGVsIFBNQyBkcml2ZXIgd2lsbCBmb3JjZWZ1bGx5IGF0dGFj
aCBpdA0KPiB3aGVuIGRldGVjdGluZyBhbnkgQ1BVIG9uIHRoZSBpbnRlbF9wbWNfY29yZV9w
bGF0Zm9ybV9pZHMgYXJyYXksDQo+IGV2ZW4gaWYgdGhlIG1hdGNoaW5nIEFDUEkgZGV2aWNl
IGlzIG5vdCBwcmVzZW50Lg0KPiANCj4gVGhlcmUncyBubyBjaGVja2luZyBpbiBwbWNfY29y
ZV9wcm9iZSgpIHRvIGFzc2VydCB0aGF0IHRoZSBQTUMgZGV2aWNlDQo+IGlzIHByZXNlbnQs
IGFuZCBoZW5jZSBvbiB2aXJ0dWFsaXplZCBlbnZpcm9ubWVudHMgdGhlIFBNQyBkZXZpY2UN
Cj4gcHJvYmVzIHN1Y2Nlc3NmdWxseSwgZXZlbiBpZiB0aGUgdW5kZXJseWluZyByZWdpc3Rl
cnMgYXJlIG5vdCBwcmVzZW50Lg0KPiBQcmV2aW91cyB0byAyMWFlNDM1NzA5NDAgdGhlIGRy
aXZlciB3b3VsZCBjaGVjayBmb3IgdGhlIHByZXNlbmNlIG9mIGENCj4gc3BlY2lmaWMgUENJ
IGRldmljZSwgYW5kIHRoYXQgcHJldmVudGVkIHRoZSBkcml2ZXIgZnJvbSBhdHRhY2hpbmcg
d2hlbg0KPiBydW5uaW5nIHZpcnR1YWxpemVkLg0KPiANCj4gRml4IGJ5IG9ubHkgZm9yY2Vm
dWxseSBhdHRhY2hpbmcgdGhlIFBNQyBkZXZpY2Ugd2hlbiBub3QgcnVubmluZw0KPiB2aXJ0
dWFsaXplZC4gIE5vdGUgdGhhdCB2aXJ0dWFsaXplZCBwbGF0Zm9ybXMgY2FuIHN0aWxsIGdl
dCB0aGUgZGV2aWNlDQo+IHRvIGxvYWQgaWYgdGhlIGFwcHJvcHJpYXRlIEFDUEkgZGV2aWNl
IGlzIHByZXNlbnQgb24gdGhlIHRhYmxlcw0KPiBwcm92aWRlZCB0byB0aGUgVk0uDQo+IA0K
PiBNYWtlIGFuIGV4Y2VwdGlvbiBmb3IgdGhlIFhlbiBpbml0aWFsIGRvbWFpbiwgd2hpY2gg
ZG9lcyBoYXZlIGZ1bGwNCj4gaGFyZHdhcmUgYWNjZXNzLCBhbmQgaGVuY2UgY2FuIGF0dGFj
aCB0byB0aGUgUE1DIGlmIHByZXNlbnQuDQo+IA0KPiBGaXhlczogMjFhZTQzNTcwOTQwICgn
cGxhdGZvcm0veDg2OiBpbnRlbF9wbWNfY29yZTogU3Vic3RpdHV0ZSBQQ0kgd2l0aCBDUFVJ
RCBlbnVtZXJhdGlvbicpDQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFBhdSBNb25uw6kgPHJv
Z2VyLnBhdUBjaXRyaXguY29tPg0KPiBDYzogUmFqbmVlc2ggQmhhcmR3YWogPGlyZW5pYy5y
YWpuZWVzaEBnbWFpbC5jb20+DQo+IENjOiBEYXZpZCBFIEJveCA8ZGF2aWQuZS5ib3hAaW50
ZWwuY29tPg0KPiBDYzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4g
Q2M6IE1hcmsgR3Jvc3MgPG1hcmtncm9zc0BrZXJuZWwub3JnPg0KPiBDYzogQW5keSBTaGV2
Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IENjOiBTcmlu
aXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4N
Cj4gQ2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAg
IGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9wbHRkcnYuYyB8IDEwICsrKysrKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9wbHRkcnYuYyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9wbHRkcnYuYw0KPiBpbmRleCAxNWNhOGFmZGQ5
NzMuLmUyODRmZDM0ZmZkZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
aW50ZWwvcG1jL3BsdGRydi5jDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVs
L3BtYy9wbHRkcnYuYw0KPiBAQCAtMTgsNiArMTgsOCBAQA0KPiAgICNpbmNsdWRlIDxhc20v
Y3B1X2RldmljZV9pZC5oPg0KPiAgICNpbmNsdWRlIDxhc20vaW50ZWwtZmFtaWx5Lmg+DQo+
ICAgDQo+ICsjaW5jbHVkZSA8eGVuL3hlbi5oPg0KPiArDQo+ICAgc3RhdGljIHZvaWQgaW50
ZWxfcG1jX2NvcmVfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgew0KPiAgIAlr
ZnJlZShkZXYpOw0KPiBAQCAtNTMsNiArNTUsMTQgQEAgc3RhdGljIGludCBfX2luaXQgcG1j
X2NvcmVfcGxhdGZvcm1faW5pdCh2b2lkKQ0KPiAgIAlpZiAoYWNwaV9kZXZfcHJlc2VudCgi
SU5UMzNBMSIsIE5VTEwsIC0xKSkNCj4gICAJCXJldHVybiAtRU5PREVWOw0KPiAgIA0KPiAr
CS8qDQo+ICsJICogU2tpcCBmb3JjZWZ1bGx5IGF0dGFjaGluZyB0aGUgZGV2aWNlIGZvciBW
TXMuIE1ha2UgYW4gZXhjZXB0aW9uIGZvcg0KPiArCSAqIFhlbiBkb20wLCB3aGljaCBkb2Vz
IGhhdmUgZnVsbCBoYXJkd2FyZSBhY2Nlc3MuDQo+ICsJICovDQo+ICsJaWYgKGJvb3RfY3B1
X2hhcyhYODZfRkVBVFVSRV9IWVBFUlZJU09SKSAmJg0KDQpQbGVhc2UgdXNlIGNwdV9mZWF0
dXJlX2VuYWJsZWQoKSBpbnN0ZWFkIG9mIGJvb3RfY3B1X2hhcygpLg0KDQoNCkp1ZXJnZW4N
Cg==
--------------0eTp3pkl7DlAXWEHTXDpsSqd
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0eTp3pkl7DlAXWEHTXDpsSqd--

--------------ViX4Jc0TPFjRe3trbVD5etMB--

--------------2eyCm9MBjVdWXHgvB4E7RBQ8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNrxkAFAwAAAAAACgkQsN6d1ii/Ey/s
GAf/XsXiKrC6O+S2CjUR8ee4Puaw4qjDIqnNlHQa3bAl+sM0Kc5ehnRKfp6C+spKXD0zTMju5kG0
ZFyniMKBxQ/wiAPDevSEoSqacmLKrEWoK23vhdJHDaLS71nSmmgIy/BsU7RkEuhgBHREIIbbAdoT
jGRAUlMAp2eotK7z5tJSzmpwgu0Xcy22zotpRx1+gVEmIXNtwR7kpoXI3t1XNuaqfNUkbRJWf1oH
6T7OcwBrBZgrdW4IflL3DHmyDU40xjTGZEFZxGhsqyOXdc2hcQCHtsxIrorapkH2qNuZ7+00X0Pw
5PGmWkuLNpxHz5hoiEEfwFbrKDEe0s3FKX9yEISfSg==
=mTb2
-----END PGP SIGNATURE-----

--------------2eyCm9MBjVdWXHgvB4E7RBQ8--
