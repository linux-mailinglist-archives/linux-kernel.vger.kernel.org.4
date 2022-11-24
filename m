Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4662A63783C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKXL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKXL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:58:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4DA56D6B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:58:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D505E1F889;
        Thu, 24 Nov 2022 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669291090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j0aO8PAkN3xexNS+Otd+dVRbhAe1llgFxK+CvUSCsdg=;
        b=XRNW9cdHIKsAe3Bi7eqeKZvj0V54ZOIWli3NcEud2pLKDAVLcNONXKyTvNDep/GGst4lfS
        71wOsTVI+06+85MDcY6ykoQ9rjHIDcH08SJ1TofCgY0JfpRBwNZKMgXfQstf1g1/gykZgM
        Y5ghbUQTDFSy5YLXB+0i5Ag78R1+BKs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BED113B4F;
        Thu, 24 Nov 2022 11:58:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SKS8FFJcf2OqcQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 11:58:10 +0000
Message-ID: <b792d2b4-1a80-6d17-a5bf-9bc052b0ad1c@suse.com>
Date:   Thu, 24 Nov 2022 12:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] x86/paravirt: Use relative reference for original
 instruction
Content-Language: en-US
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        virtualization@lists.linux-foundation.org
References: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------a0E30WGI16RYf0Ega3f5ytuz"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------a0E30WGI16RYf0Ega3f5ytuz
Content-Type: multipart/mixed; boundary="------------BY4O0H4zRDgpBgSINNNljwPo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Cc: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
 Nadav Amit <namit@vmware.com>, virtualization@lists.linux-foundation.org
Message-ID: <b792d2b4-1a80-6d17-a5bf-9bc052b0ad1c@suse.com>
Subject: Re: [PATCH v2] x86/paravirt: Use relative reference for original
 instruction
References: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>

--------------BY4O0H4zRDgpBgSINNNljwPo
Content-Type: multipart/mixed; boundary="------------VqSPC8JXoKW8AeqYfANx5nRo"

--------------VqSPC8JXoKW8AeqYfANx5nRo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMTI6NTEsIEhvdSBXZW5sb25nIHdyb3RlOg0KPiBTaW1pbGFyIHRvIHRo
ZSBhbHRlcm5hdGl2ZSBwYXRjaGluZywgdXNlIHJlbGF0aXZlIHJlZmVyZW5jZSBmb3Igb3Jp
Z2luYWwNCj4gaW5zdHJ1Y3Rpb24gcmF0aGVyIHRoYW4gYWJzb2x1dGUgb25lLCB3aGljaCBz
YXZlcyA4IGJ5dGVzIGZvciBvbmUgZW50cnkNCj4gb24geDg2XzY0LiAgQW5kIGl0IGNvdWxk
IGdlbmVyYXRlIFJfWDg2XzY0X1BDMzIgcmVsb2NhdGlvbiBpbnN0ZWFkIG9mDQo+IFJfWDg2
XzY0XzY0IHJlbG9jYXRpb24sIHdoaWNoIGFsc28gcmVkdWNlcyByZWxvY2F0aW9uIG1ldGFk
YXRhIG9uDQo+IHJlbG9jYXRhYmxlIGJ1aWxkcy4gQW5kIHRoZSBhbGlnbm1lbnQgY291bGQg
YmUgaGFyZCBjb2RlZCB0byBiZSA0IG5vdy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhvdSBX
ZW5sb25nIDxob3V3ZW5sb25nLmh3bEBhbnRncm91cC5jb20+DQoNClJldmlld2VkLWJ5OiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0KDQo=
--------------VqSPC8JXoKW8AeqYfANx5nRo
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------VqSPC8JXoKW8AeqYfANx5nRo--

--------------BY4O0H4zRDgpBgSINNNljwPo--

--------------a0E30WGI16RYf0Ega3f5ytuz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/XFEFAwAAAAAACgkQsN6d1ii/Ey8b
Hwf/Ynivyjj8IqkD6U3eqb62Xo6ckQfLrgMFSIPgvs2ruBQpBG8mHMPtxmC15dN/hiU0gV8cc17N
kntdMT/l4fDnL06kKUMUWtMwGtXnLzH8rPllR0nywykJmK+qmIjTsDMmnT1bWPRe7zhdqDOsHgso
srz+7e3N8CRxPoagvK/ReK7NuIpUdURIYvrCBiujXfojoVNb5bl/2Yfp5yQBjR0GyT04wMLX7RM9
cA3GZGw9owTJlXBnoNlg8JY/9RjzjqR16tSrossOzut8+YF2MHs70n9TTyh7CwX1kWoeFN4z6pZ+
lOPuO1W7carQCg3t9H79D9418MA8pjcJ74jntrZ4fA==
=sQ13
-----END PGP SIGNATURE-----

--------------a0E30WGI16RYf0Ega3f5ytuz--
