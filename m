Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C774E605F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJTLls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJTLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:41:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC21DB8AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:41:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5CE1FD3F;
        Thu, 20 Oct 2022 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666266103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6I+YxKK/S0zNtNkARnSZrYfff5kmB3ES2zI+J4f4Co=;
        b=SyngHn68Jf/MsSgqzkpUHw/+ySnRwv57RteCu8ANICjJpIjMg8f3P+tHZkQoPb+BIFd103
        U/WOPiYkAcKrlWR9y9g1Yb/bVvUdJKmDM4DhOK9OiAAKeVlbS3Kch/JX5FfXw4vZPUR0Na
        mrjK/35p7dE15VQjgAoxETH+L271GWc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F116C13494;
        Thu, 20 Oct 2022 11:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fyx0OfYzUWMiCQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 11:41:42 +0000
Message-ID: <87deb6d1-b2e3-2560-4b49-d50819d3c4a7@suse.com>
Date:   Thu, 20 Oct 2022 13:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/xen: simplify sysenter and syscall setup
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20221020113619.17204-1-jgross@suse.com>
 <Y1EzXQP3/Pn3bme+@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <Y1EzXQP3/Pn3bme+@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vtDvH23fSoPYeW7IhPhy6DE0"
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
--------------vtDvH23fSoPYeW7IhPhy6DE0
Content-Type: multipart/mixed; boundary="------------bwGP5d4dr6G0cwG7AfrgUIIv";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel@lists.xenproject.org
Message-ID: <87deb6d1-b2e3-2560-4b49-d50819d3c4a7@suse.com>
Subject: Re: [PATCH] x86/xen: simplify sysenter and syscall setup
References: <20221020113619.17204-1-jgross@suse.com>
 <Y1EzXQP3/Pn3bme+@zn.tnic>
In-Reply-To: <Y1EzXQP3/Pn3bme+@zn.tnic>

--------------bwGP5d4dr6G0cwG7AfrgUIIv
Content-Type: multipart/mixed; boundary="------------HmUrsrQGm7kygNSsiWRZ0Rnj"

--------------HmUrsrQGm7kygNSsiWRZ0Rnj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMTAuMjIgMTM6MzksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBP
Y3QgMjAsIDIwMjIgYXQgMDE6MzY6MTlQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IHhlbl9lbmFibGVfc3lzZW50ZXIoKSBhbmQgeGVuX2VuYWJsZV9zeXNjYWxsKCkgY2Fu
IGJlIHNpbXBsaWZpZWQgYSBsb3QuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L3hlbi9zZXR1
cC5jIHwgMjMgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L3hlbi9zZXR1cC5jIGIvYXJjaC94ODYveGVuL3NldHVwLmMNCj4+IGluZGV4
IGNmYTk5ZThmMDU0Yi4uMGYzM2VkNmQzYTdiIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYv
eGVuL3NldHVwLmMNCj4+ICsrKyBiL2FyY2gveDg2L3hlbi9zZXR1cC5jDQo+PiBAQCAtOTEw
LDE3ICs5MTAsOSBAQCBzdGF0aWMgaW50IHJlZ2lzdGVyX2NhbGxiYWNrKHVuc2lnbmVkIHR5
cGUsIGNvbnN0IHZvaWQgKmZ1bmMpDQo+PiAgIA0KPj4gICB2b2lkIHhlbl9lbmFibGVfc3lz
ZW50ZXIodm9pZCkNCj4+ICAgew0KPj4gLQlpbnQgcmV0Ow0KPj4gLQl1bnNpZ25lZCBzeXNl
bnRlcl9mZWF0dXJlOw0KPj4gLQ0KPj4gLQlzeXNlbnRlcl9mZWF0dXJlID0gWDg2X0ZFQVRV
UkVfU1lTRU5URVIzMjsNCj4+IC0NCj4+IC0JaWYgKCFib290X2NwdV9oYXMoc3lzZW50ZXJf
ZmVhdHVyZSkpDQo+PiAtCQlyZXR1cm47DQo+PiAtDQo+PiAtCXJldCA9IHJlZ2lzdGVyX2Nh
bGxiYWNrKENBTExCQUNLVFlQRV9zeXNlbnRlciwgeGVuX2VudHJ5X1NZU0VOVEVSX2NvbXBh
dCk7DQo+PiAtCWlmKHJldCAhPSAwKQ0KPj4gLQkJc2V0dXBfY2xlYXJfY3B1X2NhcChzeXNl
bnRlcl9mZWF0dXJlKTsNCj4+ICsJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9TWVNF
TlRFUjMyKSAmJg0KPiANCj4gQ2FuIHlvdSBzd2l0Y2ggdGhhdCBhbmQgYmVsb3cgdG8gY3B1
X2ZlYXR1cmVfZW5hYmxlZCgpIHdoaWxlIGF0IGl0LCBwbHM/DQo+IA0KPj4gKwlpZiAoYm9v
dF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1NZU0NBTEwzMikgJiYNCj4gCV5eXl5eXl5eXl5eXl5e
Xl5eXg0KDQpZZXMsIG9mIGNvdXJzZS4NCg0KDQpKdWVyZ2VuDQo=
--------------HmUrsrQGm7kygNSsiWRZ0Rnj
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------HmUrsrQGm7kygNSsiWRZ0Rnj--

--------------bwGP5d4dr6G0cwG7AfrgUIIv--

--------------vtDvH23fSoPYeW7IhPhy6DE0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNRM/YFAwAAAAAACgkQsN6d1ii/Ey8U
wwf+MqIhga3kLFK72rcr8wgUGEftDN6xfKkEp7YjwYdRQwDcav68bu3qQpyuGT4kFCSiBFnKSO2A
ca/91jZ2ly6Xv+CZuaTZ5aDjDVIkZWyIlvfUi0VPRMmTZj5CFCvjvZ31gArIPiQUe2L7pqZW6/WT
oHS6qYTvjuyCNxNCahgwSKiIsejTsc5D+Xl/NtYfld2y7qQQOG3kTMn3+9fzkLDv3lxakUKtl5WH
LHdoQaM/FOPih/yzHiIFr0MKEknSGCmy7L4RcuAqrzbT4bhzP4DzVMFkad2zoJmFpwciswgMSrxa
Heonb2lOas2Fo9cWIaA3/RneJbrEawV+rWDLADrJIw==
=+9Xr
-----END PGP SIGNATURE-----

--------------vtDvH23fSoPYeW7IhPhy6DE0--
