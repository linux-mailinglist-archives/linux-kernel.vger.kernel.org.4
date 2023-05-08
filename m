Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A26FAFDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjEHMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjEHMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:23:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8136109
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:23:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA3CF1FE6F;
        Mon,  8 May 2023 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683548591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JfEzsX5fFqzg3GqO4ASKIFVD991JJNu2nfu4iM95o4k=;
        b=XFWpOEXY9ZVf8KJ5PIJ5o270Wf4qzrXja2wsutqT1u5mtdTqr9CvN/1SUdZsVNQDFIoQxJ
        gGCupmNUTVbGhSzNKVjBEX1M1DjydDgF1wY/sDd8AXywAe4gYUuZu+sS/0jE5B3A4y+QaH
        VehOE8Kmiih8Ql+bnCAkyAmeMVCX4Jk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9044913499;
        Mon,  8 May 2023 12:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4FKFIa/pWGTjSQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 08 May 2023 12:23:11 +0000
Message-ID: <d90ee49b-bbd3-faf4-30be-0ed2cc9cb90d@suse.com>
Date:   Mon, 8 May 2023 14:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306123259.12461-1-jgross@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JaV9Rv4kS7mlwqX6vmj47y7E"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JaV9Rv4kS7mlwqX6vmj47y7E
Content-Type: multipart/mixed; boundary="------------UrDMQB0j5zAbZpAHvtC42DDR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d90ee49b-bbd3-faf4-30be-0ed2cc9cb90d@suse.com>
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
References: <20230306123259.12461-1-jgross@suse.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>

--------------UrDMQB0j5zAbZpAHvtC42DDR
Content-Type: multipart/mixed; boundary="------------0LN5Q0TgzrIHoNeC1a0ZPzpi"

--------------0LN5Q0TgzrIHoNeC1a0ZPzpi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UElORyAoM3JkIG9uZSwgYWZ0ZXIgMiBtb250aHMgb2YgZ2V0dGluZyBubyBmZWVkYmFjaykh
DQoNCkknbSBpbmNsaW5lZCB0byBjYXJyeSBpdCBqdXN0IHZpYSB0aGUgWGVuIHRyZWUgaWYg
eDg2IG1haW50YWluZXJzIGNvbnRpbnVlDQp0byBpZ25vcmUgaXQgLi4uDQoNCg0KSnVlcmdl
bg0KDQpPbiAwNi4wMy4yMyAxMzozMiwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gTm9ybWFs
bHkgX19zd3BfZW50cnlfdG9fcHRlKCkgaXMgbmV2ZXIgY2FsbGVkIHdpdGggYSB2YWx1ZSB0
cmFuc2xhdGluZw0KPiB0byBhIHZhbGlkIFBURS4gVGhlIG9ubHkga25vd24gZXhjZXB0aW9u
IGlzIHB0ZV9zd2FwX3Rlc3RzKCksIHJlc3VsdGluZw0KPiBpbiBhIFdBUk4gc3BsYXQgaW4g
WGVuIFBWIGd1ZXN0cywgYXMgX19wdGVfdG9fc3dwX2VudHJ5KCkgZGlkDQo+IHRyYW5zbGF0
ZSB0aGUgUEZOIG9mIHRoZSB2YWxpZCBQVEUgdG8gYSBndWVzdCBsb2NhbCBQRk4sIHdoaWxl
DQo+IF9fc3dwX2VudHJ5X3RvX3B0ZSgpIGRvZXNuJ3QgZG8gdGhlIG9wcG9zaXRlIHRyYW5z
bGF0aW9uLg0KPiANCj4gRml4IHRoYXQgYnkgdXNpbmcgX19wdGUoKSBpbiBfX3N3cF9lbnRy
eV90b19wdGUoKSBpbnN0ZWFkIG9mIG9wZW4NCj4gY29kaW5nIHRoZSBuYXRpdmUgdmFyaWFu
dCBvZiBpdC4NCj4gDQo+IEZvciBjb3JyZWN0bmVzcyBkbyB0aGUgc2ltaWxhciBjb252ZXJz
aW9uIGZvciBfX3N3cF9lbnRyeV90b19wbWQoKS4NCj4gDQo+IEZpeGVzOiAwNTI4OTQwMmQ3
MTcgKCJtbS9kZWJ1Z192bV9wZ3RhYmxlOiBhZGQgdGVzdHMgdmFsaWRhdGluZyBhcmNoIGhl
bHBlcnMgZm9yIGNvcmUgTU0gZmVhdHVyZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L2luY2x1ZGUv
YXNtL3BndGFibGVfNjQuaCB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vcGd0YWJsZV82NC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJs
ZV82NC5oDQo+IGluZGV4IDc5MjkzMjdhYmUwMC4uYTYyOWIxYjlmNjVhIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmgNCj4gKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oDQo+IEBAIC0yMzcsOCArMjM3LDggQEAgc3Rh
dGljIGlubGluZSB2b2lkIG5hdGl2ZV9wZ2RfY2xlYXIocGdkX3QgKnBnZCkNCj4gICANCj4g
ICAjZGVmaW5lIF9fcHRlX3RvX3N3cF9lbnRyeShwdGUpCQkoKHN3cF9lbnRyeV90KSB7IHB0
ZV92YWwoKHB0ZSkpIH0pDQo+ICAgI2RlZmluZSBfX3BtZF90b19zd3BfZW50cnkocG1kKQkJ
KChzd3BfZW50cnlfdCkgeyBwbWRfdmFsKChwbWQpKSB9KQ0KPiAtI2RlZmluZSBfX3N3cF9l
bnRyeV90b19wdGUoeCkJCSgocHRlX3QpIHsgLnB0ZSA9ICh4KS52YWwgfSkNCj4gLSNkZWZp
bmUgX19zd3BfZW50cnlfdG9fcG1kKHgpCQkoKHBtZF90KSB7IC5wbWQgPSAoeCkudmFsIH0p
DQo+ICsjZGVmaW5lIF9fc3dwX2VudHJ5X3RvX3B0ZSh4KQkJKF9fcHRlKCh4KS52YWwpKQ0K
PiArI2RlZmluZSBfX3N3cF9lbnRyeV90b19wbWQoeCkJCShfX3BtZCgoeCkudmFsKSkNCj4g
ICANCj4gICBleHRlcm4gdm9pZCBjbGVhbnVwX2hpZ2htYXAodm9pZCk7DQo+ICAgDQoNCg==

--------------0LN5Q0TgzrIHoNeC1a0ZPzpi
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0LN5Q0TgzrIHoNeC1a0ZPzpi--

--------------UrDMQB0j5zAbZpAHvtC42DDR--

--------------JaV9Rv4kS7mlwqX6vmj47y7E
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRY6a8FAwAAAAAACgkQsN6d1ii/Ey9i
xwf9FKWh0RZnx7cNg3pFU8zCWb3kfDXtdYMW/G3Wpfq5gsGTFuOTqVbRXETi0nu3zZd0wwrX5Fpu
zu0tpk1n1ClD5zlqeBsqY0D/cmbMQxldhqZ6WO748YqAIde9+ptyo8bRS2kA/Ep12QEtirzkCg4o
Go6hNa5YqZTl3TbFxTct+ZYzgAqCl0DjyweqLvqxGl6BQzzri9mCiz2ltmiy0nyhhtuMtAkX5NLq
sMiWauA8pOamiDWo19dFAlm/iLU7JpK89wXWagpx8CpKj5aDZe3qxMKOqOuMRWCrR93Yv1yF1s8I
K0VLHN2Mjkba3A1pFDsTSepx1j9Y2FTqU5DO+oU+Og==
=I+Tg
-----END PGP SIGNATURE-----

--------------JaV9Rv4kS7mlwqX6vmj47y7E--
