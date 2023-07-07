Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85074B3A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjGGPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGGPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:07:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF41AA;
        Fri,  7 Jul 2023 08:07:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17FEA22119;
        Fri,  7 Jul 2023 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688742444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jBwtBpLbUYf3LM/NKeO7/tkOZqs6OnE7Weht0MWPrI=;
        b=xluMGhDdEdmQeD+p/G424NqPsXOIlT+3mv1x6X1osGvJ3UtYv4eR8Z9hvEMK4sSu263i+g
        jkks3cMZtj9usi/sIIKk20R8Z0rtbdVeDu3vNktGWsUrquU2KNkiCIRB4lzFDN0pSGHy0j
        GTn/XAkEe+MEk8QAChmQrjEuByk2Yho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688742444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jBwtBpLbUYf3LM/NKeO7/tkOZqs6OnE7Weht0MWPrI=;
        b=rEfCQ/agpsvog4ZlEopmxTzX/5gj+tQq+MPw6XcBUGsKTZBazGjAtwumTYwD/3VE44eS3j
        HlhwcMHTkD3kOBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCA60139E0;
        Fri,  7 Jul 2023 15:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uff6LCsqqGTDCQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 07 Jul 2023 15:07:23 +0000
Message-ID: <6a6baea8-c7ca-1399-97d8-b6cb8263829c@suse.de>
Date:   Fri, 7 Jul 2023 17:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] vgacon: rework Kconfig dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     javierm@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
References: <20230707095415.1449376-1-arnd@kernel.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230707095415.1449376-1-arnd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------c0jLEo3DrAkPUh5E8Wczlh0f"
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
--------------c0jLEo3DrAkPUh5E8Wczlh0f
Content-Type: multipart/mixed; boundary="------------9S6fOdJUZ2bMs72BaYhzIUVD";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: javierm@redhat.com, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
 linux-csky@vger.kernel.org
Message-ID: <6a6baea8-c7ca-1399-97d8-b6cb8263829c@suse.de>
Subject: Re: [PATCH 1/4] vgacon: rework Kconfig dependencies
References: <20230707095415.1449376-1-arnd@kernel.org>
In-Reply-To: <20230707095415.1449376-1-arnd@kernel.org>

--------------9S6fOdJUZ2bMs72BaYhzIUVD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCmZvciB0aGUgd2hvbGUgc2VyaWVzOg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIFpp
bW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFz
DQoNCkFtIDA3LjA3LjIzIHVtIDExOjUyIHNjaHJpZWIgQXJuZCBCZXJnbWFubjoNCj4gRnJv
bTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IFRoZSBsaXN0IG9mIGRl
cGVuZGVuY2llcyBoZXJlIGlzIHBocmFzZWQgYXMgYW4gb3B0LW91dCwgYnV0IHRoaXMgaXMg
bWlzc2luZw0KPiBhIGxvdCBvZiBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3QgYWN0dWFsbHkg
c3VwcG9ydCBWR0EgY29uc29sZXMsIGFuZCBzb21lDQo+IG9mIHRoZSBlbnRyaWVzIGFyZSBz
dGFsZToNCj4gDQo+ICAgLSBwb3dlcnBjIHVzZWQgdG8gc3VwcG9ydCBWR0EgY29uc29sZXMg
aW4gdGhlIG9sZCBhcmNoL3BwYyBjb2RlYmFzZSwgYnV0DQo+ICAgICB0aGUgbWVyZ2VkIGFy
Y2gvcG93ZXJwYyBuZXZlciBkaWQNCj4gDQo+ICAgLSBhcm0gbGlzdHMgZm9vdGJyaWRnZSwg
aW50ZWdyYXRvciBhbmQgbmV0d2luZGVyLCBidXQgbmV0d2luZGVyIGlzIGFjdHVhbGx5DQo+
ICAgICBwYXJ0IG9mIGZvb3RicmlkZ2UsIGFuZCBpbnRlZ3JhdG9yIGRvZXMgbm90IGFwcGVh
ciB0byBoYXZlIGFuIGFjdHVhbA0KPiAgICAgVkdBIGhhcmR3YXJlLCBvciBsaXN0IGl0IGlu
IGl0cyBBVEFHIG9yIERULg0KPiANCj4gICAtIG1pcHMgaGFzIGEgZmV3IHBsYXRmb3JtcyAo
amF6eiwgc2lieXRlLCBhbmQgc25pKSB0aGF0IGluaXRpYWxpemUNCj4gICAgIHNjcmVlbl9p
bmZvLCBvbiBldmVyeXRoaW5nIGVsc2UgdGhlIGNvbnNvbGUgaXMgc2VsZWN0ZWQgYnV0IGNh
bm5vdA0KPiAgICAgYWN0dWFsbHkgd29yay4NCj4gDQo+ICAgLSBjc2t5LCBoZXhnYWdvbiwg
bG9vbmdhcmNoLCBuaW9zMiwgcmlzY3YgYW5kIHh0ZW5zYSBhcmUgbm90IGxpc3RlZA0KPiAg
ICAgaW4gdGhlIG9wdC1vdXQgdGFibGUgYW5kIGRlY2xhcmUgYSBzY3JlZW5faW5mbyB0byBh
bGxvdyBidWlsZGluZw0KPiAgICAgdmdhX2NvbiwgYnV0IHRoaXMgY2Fubm90IHdvcmsgYmVj
YXVzZSB0aGUgY29uc29sZSBpcyBuZXZlciBzZWxlY3RlZC4NCj4gDQo+IFJlcGxhY2UgdGhp
cyB3aXRoIGFuIG9wdC1pbiB0YWJsZSB0aGF0IGxpc3RzIG9ubHkgdGhlIHBsYXRmb3JtcyB0
aGF0DQo+IHJlbWFpbi4gVGhpcyBpcyBlZmZlY3RpdmVseSB4ODYsIHBsdXMgYSBjb3VwbGUg
b2YgaGlzdG9yaWMgd29ya3N0YXRpb24NCj4gYW5kIHNlcnZlciBtYWNoaW5lcyB0aGF0IHJl
dXNlZCBwYXJ0cyBvZiB0aGUgeDg2IHN5c3RlbSBhcmNoaXRlY3R1cmUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiAtLS0NCj4gICBk
cml2ZXJzL3ZpZGVvL2NvbnNvbGUvS2NvbmZpZyB8IDYgKysrLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvS2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vY29u
c29sZS9LY29uZmlnDQo+IGluZGV4IGEyYTg4ZDQyZWRmMGMuLjQ3YzQ5OGRlZmMyMTEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlkZW8vY29uc29sZS9LY29uZmlnDQo+ICsrKyBiL2Ry
aXZlcnMvdmlkZW8vY29uc29sZS9LY29uZmlnDQo+IEBAIC03LDkgKzcsOSBAQCBtZW51ICJD
b25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQiDQo+ICAgDQo+ICAgY29uZmlnIFZHQV9D
T05TT0xFDQo+ICAgCWJvb2wgIlZHQSB0ZXh0IGNvbnNvbGUiIGlmIEVYUEVSVCB8fCAhWDg2
DQo+IC0JZGVwZW5kcyBvbiAhNHh4ICYmICFQUENfOHh4ICYmICFTUEFSQyAmJiAhTTY4SyAm
JiAhUEFSSVNDICYmICAhU1VQRVJIICYmIFwNCj4gLQkJKCFBUk0gfHwgQVJDSF9GT09UQlJJ
REdFIHx8IEFSQ0hfSU5URUdSQVRPUiB8fCBBUkNIX05FVFdJTkRFUikgJiYgXA0KPiAtCQkh
QVJNNjQgJiYgIUFSQyAmJiAhTUlDUk9CTEFaRSAmJiAhT1BFTlJJU0MgJiYgIVMzOTAgJiYg
IVVNTA0KPiArCWRlcGVuZHMgb24gQUxQSEEgfHwgSUE2NCB8fCBYODYgfHwgXA0KPiArCQko
QVJNICYmIEFSQ0hfRk9PVEJSSURHRSkgfHwgXA0KPiArCQkoTUlQUyAmJiAoTUlQU19NQUxU
QSB8fCBTSUJZVEVfQkNNMTEyWCB8fCBTSUJZVEVfU0IxMjUwIHx8IFNJQllURV9CQ00xeDgw
IHx8IFNOSV9STSkpDQo+ICAgCXNlbGVjdCBBUEVSVFVSRV9IRUxQRVJTIGlmIChEUk0gfHwg
RkIgfHwgVkZJT19QQ0lfQ09SRSkNCj4gICAJZGVmYXVsdCB5DQo+ICAgCWhlbHANCg0KLS0g
DQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkw
NDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBB
bmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJl
cmcpDQo=

--------------9S6fOdJUZ2bMs72BaYhzIUVD--

--------------c0jLEo3DrAkPUh5E8Wczlh0f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSoKioFAwAAAAAACgkQlh/E3EQov+Av
JA//QnTJ1dwQAnEXlldiURfrGPorNI75lYqV20fxNajAJDwvWnl6pHkB0LPysSaQYiJEf5nAwcjm
2OX8nkHJUQSvTGlaeaBElhEXluMbxzFiMLP9zoWfPh0AiyXG7NB8HunNlEB7fCIdlBvStTXz5Pfs
KaA+GshCKd7cOvp0LMOTZzY5kERZAq7uyc4E9AIrj4FSQHdaTeASdsiThgni7135x3hJ01/JS8qo
nHlDFNEbWSpGf7Oz+0TKqwEMRa4zL9najM/OllMTRQMKWirHthfNTgY//JVTh1HADoKBkUtmjGSc
oybH3jzaGjTvnNk+NbMpefoth5DDDrLAjzkF6PAzVnZVPIE0b674sdlA5Z99lEWA8uDsR96dWScf
SFzxZxITrYahaiJ3feSci43aeZDyOn/DSFwgo4+cPKdPd1DDAQ2pbpUkeB8tHVfZH7FZoWRcX+5J
zT2xzoXSVOuE19KfVW/AVGwTYgPgdlFOH77PwNlfVAqwGVQQXfwhDQQ7uURtV6OjavOi3EcAqOFr
JJBTH2xUn5zgyuLw9IFwssw6gIdafn0nuaWsYOmJUjPsfiXRiMKZG96t6AJtNwcxYQh/mcUPF1FG
RmOE423rFG9clEQIAR2NcOaI+vcjMJ4kUAnUzIFCoisTkmUAT9YZAEN+5K1f9NbXnPhpgQgKcQt4
EDg=
=YXVc
-----END PGP SIGNATURE-----

--------------c0jLEo3DrAkPUh5E8Wczlh0f--
