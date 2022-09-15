Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6095B9504
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIOHBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIOHA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:00:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CB6EF24;
        Wed, 14 Sep 2022 23:59:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FE6834408;
        Thu, 15 Sep 2022 06:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663225184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdnXllucHTBxA/9FI9xK/SZO/LJMpNDoSBwXpB+lP/U=;
        b=iij8+nSqwufZdvdJ2t334oHkzyxe58whIyBuaEg0+Bsh+w9NBTymS7lTSjW35nSwVIkcYN
        jW7kBeB1HQmshMtjLZuMFzf1TvvTBcHe0HVncT3ZvjlYH1htoPbfVSElrmDjwvyc1nWFTp
        LeyZlh5G4xs1eL+OuFdwF+ON3WYeA1I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF2F2139C8;
        Thu, 15 Sep 2022 06:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4k04NF/NImN8VQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 15 Sep 2022 06:59:43 +0000
Message-ID: <fa6df43b-8a1a-8ad1-0236-94d2a0b588fa@suse.com>
Date:   Thu, 15 Sep 2022 08:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/1] x86/paravirt: write paravirt ident function in
 assembly
Content-Language: en-US
To:     Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220914162149.71271-1-morbo@google.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20220914162149.71271-1-morbo@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0vgYhJCAdT99yLwH4iU1YHhU"
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0vgYhJCAdT99yLwH4iU1YHhU
Content-Type: multipart/mixed; boundary="------------xYaDk5VXNS0yYjga337i39Ay";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>
Message-ID: <fa6df43b-8a1a-8ad1-0236-94d2a0b588fa@suse.com>
Subject: Re: [PATCH v2 1/1] x86/paravirt: write paravirt ident function in
 assembly
References: <20220902213750.1124421-1-morbo@google.com>
 <20220914162149.71271-1-morbo@google.com>
In-Reply-To: <20220914162149.71271-1-morbo@google.com>

--------------xYaDk5VXNS0yYjga337i39Ay
Content-Type: multipart/mixed; boundary="------------auY0lbM04uuXeWa1GPAl40xG"

--------------auY0lbM04uuXeWa1GPAl40xG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMDkuMjIgMTg6MjEsIEJpbGwgV2VuZGxpbmcgd3JvdGU6DQo+IFRoZSBaRVJPX0NB
TExfVVNFRF9SRUdTIGZlYXR1cmUgbWF5IHplcm8gb3V0IGNhbGxlci1zYXZlZCByZWdpc3Rl
cnMNCj4gYmVmb3JlIHJldHVybmluZy4gSG93ZXZlciwgYWx0ZXJuYXRlIGNvZGUgbWF5IGNh
bGwgdGhpcyBmdW5jdGlvbiB3aXRob3V0DQo+IGZpcnN0IHNhdmluZyAlW3JlXWRpLCBiZWNh
dXNlIHRoZSBwcm9wZXIgY2xvYmJlcnMgYXJlbid0IHRha2VuIGludG8NCj4gYWNjb3VudC4N
Cj4gDQo+IFRoaXMgc2hvd3MgdXAgaW4gc3B1cmlvdXNfa2VybmVsX2ZhdWx0KCkgd2hlcmUg
dGhlICJwdGVfb2Zmc2V0X2tlcm5lbCgpIg0KPiBjYWxsIHJlc3VsdHMgaW4gdGhpcyBhc3Nl
bWJseSBjb2RlOg0KPiANCj4gLkx0bXAxNTE6DQo+ICAgICAgICAgICNBUFANCj4gICAgICAg
ICAgIyBBTFQ6IG9sZG5zdHINCj4gLkx0bXAxNTI6DQo+IC5MdG1wMTUzOg0KPiAuTHRtcDE1
NDoNCj4gICAgICAgICAgLnNlY3Rpb24gICAgICAgIC5kaXNjYXJkLnJldHBvbGluZV9zYWZl
LCIiLEBwcm9nYml0cw0KPiAgICAgICAgICAucXVhZCAgIC5MdG1wMTU0DQo+ICAgICAgICAg
IC50ZXh0DQo+IA0KPiAgICAgICAgICBjYWxscSAgICpwdl9vcHMrNTM2KCVyaXApDQo+IA0K
PiAuTHRtcDE1NToNCj4gICAgICAgICAgLnNlY3Rpb24gICAgICAgIC5wYXJhaW5zdHJ1Y3Rp
b25zLCJhIixAcHJvZ2JpdHMNCj4gICAgICAgICAgLnAyYWxpZ24gICAgICAgIDMsIDB4MA0K
PiAgICAgICAgICAucXVhZCAgIC5MdG1wMTUzDQo+ICAgICAgICAgIC5ieXRlICAgNjcNCj4g
ICAgICAgICAgLmJ5dGUgICAuTHRtcDE1NS0uTHRtcDE1Mw0KPiAgICAgICAgICAuc2hvcnQg
IDENCj4gICAgICAgICAgLnRleHQNCj4gLkx0bXAxNTY6DQo+ICAgICAgICAgICMgQUxUOiBw
YWRkaW5nDQo+ICAgICAgICAgIC56ZXJvICAgKC0oKCguTHRtcDE1Ny0uTHRtcDE1OCktKC5M
dG1wMTU2LS5MdG1wMTUyKSk+MCkpKigoLkx0bXAxNTctLkx0bXAxNTgpLSguTHRtcDE1Ni0u
THRtcDE1MikpLDE0NA0KPiAuTHRtcDE1OToNCj4gICAgICAgICAgLnNlY3Rpb24gICAgICAg
IC5hbHRpbnN0cnVjdGlvbnMsImEiLEBwcm9nYml0cw0KPiAuTHRtcDE2MDoNCj4gICAgICAg
ICAgLmxvbmcgICAuTHRtcDE1Mi0uTHRtcDE2MA0KPiAuTHRtcDE2MToNCj4gICAgICAgICAg
LmxvbmcgICAuTHRtcDE1OC0uTHRtcDE2MQ0KPiAgICAgICAgICAuc2hvcnQgIDMzMDQwDQo+
ICAgICAgICAgIC5ieXRlICAgLkx0bXAxNTktLkx0bXAxNTINCj4gICAgICAgICAgLmJ5dGUg
ICAuTHRtcDE1Ny0uTHRtcDE1OA0KPiAgICAgICAgICAudGV4dA0KPiANCj4gICAgICAgICAg
LnNlY3Rpb24gICAgICAgIC5hbHRpbnN0cl9yZXBsYWNlbWVudCwiYXgiLEBwcm9nYml0cw0K
PiAgICAgICAgICAjIEFMVDogcmVwbGFjZW1lbnQgMQ0KPiAuTHRtcDE1ODoNCj4gICAgICAg
ICAgbW92cSAgICAlcmRpLCAlcmF4DQo+IC5MdG1wMTU3Og0KPiAgICAgICAgICAudGV4dA0K
PiAgICAgICAgICAjTk9fQVBQDQo+IC5MdG1wMTYyOg0KPiAgICAgICAgICB0ZXN0YiAgICQt
MTI4LCAlZGlsDQo+IA0KPiBUaGUgJWRpbCByZWdpc3RlciB3YXMgemVyb2VkIG91dCBieSB0
aGUgY2FsbCB0byAiKnB2X29wcys1MzYoJXJpcCkiLg0KPiANCj4gSW4gZ2VuZXJhbCwgdGhl
IF9wYXJhdmlydF9pZGVudF82NCgpIGZ1bmN0aW9uIGFwcGVhcnMgbGlrZSBpdCBzaG91bGRu
J3QNCj4gaGF2ZSBhbnkgaW5zdHJ1bWVudGF0aW9uIG9yIG90aGVyIG1vZGlmaWNhdGlvbnMg
YXBwbGllZCB0byBpdC4gVGh1cyBqdXN0DQo+IHdyaXRlIGl0IGluIGFzc2VtYmx5IHRvIGF2
b2lkIGhhdmluZyB0byBjb250aW51YWxseSBtb2RpZnkgaXQgd2hlbmV2ZXIgYQ0KPiBuZXcg
ZmVhdHVyZSBjb21lcyBhbG9uZy4NCj4gDQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9L
U1BQL2xpbnV4L2lzc3Vlcy8xOTINCj4gQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21p
dW0ub3JnPg0KPiBDYzogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5j
b20+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IENjOiAiU3Jp
dmF0c2EgUy4gQmhhdCAoVk13YXJlKSIgPHNyaXZhdHNhQGNzYWlsLm1pdC5lZHU+DQo+IENj
OiBBbGV4ZXkgTWFraGFsb3YgPGFtYWtoYWxvdkB2bXdhcmUuY29tPg0KPiBDYzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiBJbmdvIE1vbG5hciA8bWlu
Z29AcmVkaGF0LmNvbT4NCj4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0K
PiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6
ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQo+IENjOiBWTXdhcmUgUFYtRHJp
dmVycyBSZXZpZXdlcnMgPHB2LWRyaXZlcnNAdm13YXJlLmNvbT4NCj4gQ2M6IHg4NkBrZXJu
ZWwub3JnDQo+IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
Zw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGx2bUBsaXN0
cy5saW51eC5kZXYNCj4gU2lnbmVkLW9mZi1ieTogQmlsbCBXZW5kbGluZyA8bW9yYm9AZ29v
Z2xlLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+DQo+IFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IE5hdGhhbiBDaGFuY2VsbG9y
IDxuYXRoYW5Aa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------auY0lbM04uuXeWa1GPAl40xG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------auY0lbM04uuXeWa1GPAl40xG--

--------------xYaDk5VXNS0yYjga337i39Ay--

--------------0vgYhJCAdT99yLwH4iU1YHhU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMizV8FAwAAAAAACgkQsN6d1ii/Ey+S
ngf6AiUmo44nTAiwuyj5V7vut20xvukrRy36fFE4rN0XcEe+T7S2FyXNgKHuFyg8yhBDQYJRPk1k
vh399GNEFTCZv2N+OoNydC9GbUnjoI1bc7u1ePak3ECVuJhsuqN7S+8DjSBaIBMY6zevMo/lj0fc
h6SakTejcSXZHV59n8cNvSqXdRPL4OlhN8uu2SlF2kJh3fadPlixGLFJ7x5HtV4fAe0JQoEDPjGa
1YJyLUoT1p1qxb1kpSRy4z0ivyGug02xUILR2NLB2AjdXYz5fHEDrt+cfW83Mlbex+ldx9016e8J
EXjNCdMhgQ3G7MUobi7lmvDZRY+oR6EXJ7Itd5zSpw==
=MqkD
-----END PGP SIGNATURE-----

--------------0vgYhJCAdT99yLwH4iU1YHhU--
