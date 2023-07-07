Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594D774AC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGGILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:11:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4908172B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:11:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 622CD2237F;
        Fri,  7 Jul 2023 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688717475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arIAW3OveDWr1GaHNZeCtrtLD9Pje9pa5DU23lYKgnE=;
        b=akqxqzaWpUxYBOkPhdHnx7NVUL6KokD8V1vWp7mJP3dcjCbg1zaNCHjCNryyS8NjVdX4Bz
        i5wGXPFfJ7c1Y9uuJez1CgMOqzza34PbA+oYeOL4u66OtOFS7JUY/NusPh4GgvaNOBvr+y
        dRQBGWI0vA+UZ34evXa9pzHRh9bcC3M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30DF6139E0;
        Fri,  7 Jul 2023 08:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JF/7CaPIp2SnMgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 08:11:15 +0000
Message-ID: <8b862919-296d-d0b6-d4c1-465b62cfa37f@suse.com>
Date:   Fri, 7 Jul 2023 10:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <f1a81ac1-5b9a-6d19-1a11-b98685bd2430@suse.com>
 <d5d6caa5-6ca6-b4b8-5334-fc156eeeb21d@epam.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <d5d6caa5-6ca6-b4b8-5334-fc156eeeb21d@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZRTo4Ebpgwa47mR0WqohChe9"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZRTo4Ebpgwa47mR0WqohChe9
Content-Type: multipart/mixed; boundary="------------0p72qKVXEjc8Akettz9hL15p";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <8b862919-296d-d0b6-d4c1-465b62cfa37f@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <f1a81ac1-5b9a-6d19-1a11-b98685bd2430@suse.com>
 <d5d6caa5-6ca6-b4b8-5334-fc156eeeb21d@epam.com>
In-Reply-To: <d5d6caa5-6ca6-b4b8-5334-fc156eeeb21d@epam.com>

--------------0p72qKVXEjc8Akettz9hL15p
Content-Type: multipart/mixed; boundary="------------kb0xkp33y6IjSL4ev99Cn3fp"

--------------kb0xkp33y6IjSL4ev99Cn3fp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMTA6MDAsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDA3LjA3LjIzIDEwOjA0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gSGVs
bG8gSnVlcmdlbg0KPiANCj4gDQo+PiBSZS1yZWFkaW5nIHRoZSB3aG9sZSB0aHJlYWQgYWdh
aW4gLi4uDQo+Pg0KPj4gT24gMjkuMDYuMjMgMDM6MDAsIFN0ZWZhbm8gU3RhYmVsbGluaSB3
cm90ZToNCj4+PiBPbiBXZWQsIDIxIEp1biAyMDIzLCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3
cm90ZToNCj4+Pj4gT24gMjEuMDYuMjMgMTY6MTIsIFBldHIgUGF2bHUgd3JvdGU6DQo+Pj4+
DQo+Pj4+DQo+Pj4+IEhlbGxvIFBldHINCj4+Pj4NCj4+Pj4NCj4+Pj4+IFdoZW4gYXR0ZW1w
dGluZyB0byBydW4gWGVuIG9uIGEgUUVNVS9LVk0gdmlydHVhbCBtYWNoaW5lIHdpdGggdmly
dGlvDQo+Pj4+PiBkZXZpY2VzIChhbGwgeDg2XzY0KSwgZG9tMCB0cmllcyB0byBlc3RhYmxp
c2ggYSBncmFudCBmb3IgaXRzZWxmIHdoaWNoDQo+Pj4+PiBldmVudHVhbGx5IHJlc3VsdHMg
aW4gYSBoYW5nIGR1cmluZyB0aGUgYm9vdC4NCj4+Pj4+DQo+Pj4+PiBUaGUgYmFja3RyYWNl
IGxvb2tzIGFzIGZvbGxvd3MsIHRoZSB3aGlsZSBsb29wIGluIF9fc2VuZF9jb250cm9sX21z
ZygpDQo+Pj4+PiBtYWtlcyBubyBwcm9ncmVzczoNCj4+Pj4+DQo+Pj4+PiAgwqDCoMKgICMw
wqAgdmlydHF1ZXVlX2dldF9idWZfY3R4IChfdnE9X3ZxQGVudHJ5PTB4ZmZmZjg4ODAwNzRh
ODQwMCwNCj4+Pj4+IGxlbj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEzYzk0LCBjdHg9Y3R4
QGVudHJ5PTB4MA0KPj4+Pj4gPGZpeGVkX3BlcmNwdV9kYXRhPikgYXQgLi4vZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYzoyMzI2DQo+Pj4+PiAgwqDCoMKgICMxwqAgMHhmZmZmZmZm
ZjgxNzA4NmI3IGluIHZpcnRxdWV1ZV9nZXRfYnVmDQo+Pj4+PiAoX3ZxPV92cUBlbnRyeT0w
eGZmZmY4ODgwMDc0YTg0MDAsIGxlbj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEzYzk0KQ0K
Pj4+Pj4gYXQgLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzoyMzMzDQo+Pj4+PiAg
wqDCoMKgICMywqAgMHhmZmZmZmZmZjgxNzVmNmIyIGluIF9fc2VuZF9jb250cm9sX21zZyAo
cG9ydGRldj08b3B0aW1pemVkDQo+Pj4+PiBvdXQ+LCBwb3J0X2lkPTB4ZmZmZmZmZmYsIGV2
ZW50PTB4MCwgdmFsdWU9MHgxKSBhdA0KPj4+Pj4gLi4vZHJpdmVycy9jaGFyL3ZpcnRpb19j
b25zb2xlLmM6NTYyDQo+Pj4+PiAgwqDCoMKgICMzwqAgMHhmZmZmZmZmZjgxNzVmNmVlIGlu
IF9fc2VuZF9jb250cm9sX21zZyAocG9ydGRldj08b3B0aW1pemVkDQo+Pj4+PiBvdXQ+LCBw
b3J0X2lkPTxvcHRpbWl6ZWQgb3V0PiwgZXZlbnQ9PG9wdGltaXplZCBvdXQ+LA0KPj4+Pj4g
dmFsdWU9PG9wdGltaXplZCBvdXQ+KSBhdCAuLi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNv
bGUuYzo1NjkNCj4+Pj4+ICDCoMKgwqAgIzTCoCAweGZmZmZmZmZmODE3NjE4YjEgaW4gdmly
dGNvbnNfcHJvYmUNCj4+Pj4+ICh2ZGV2PTB4ZmZmZjg4ODAwNTg1ZTgwMCkgYXQgLi4vZHJp
dmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6MjA5OA0KPj4+Pj4gIMKgwqDCoCAjNcKgIDB4
ZmZmZmZmZmY4MTcwNzExNyBpbiB2aXJ0aW9fZGV2X3Byb2JlDQo+Pj4+PiAoX2Q9MHhmZmZm
ODg4MDA1ODVlODEwKSBhdCAuLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYzozMDUNCj4+Pj4+
ICDCoMKgwqAgIzbCoCAweGZmZmZmZmZmODE5OGUzNDggaW4gY2FsbF9kcml2ZXJfcHJvYmUN
Cj4+Pj4+IChkcnY9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4sIGRydj0w
eGZmZmZmZmZmODJiZTQwYzANCj4+Pj4+IDx2aXJ0aW9fY29uc29sZT4sIGRldj0weGZmZmY4
ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjU3OQ0KPj4+Pj4gIMKgwqDC
oCAjN8KgIHJlYWxseV9wcm9iZSAoZGV2PWRldkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTAs
DQo+Pj4+PiBkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNv
bGU+KSBhdA0KPj4+Pj4gLi4vZHJpdmVycy9iYXNlL2RkLmM6NjU4DQo+Pj4+PiAgwqDCoMKg
ICM4wqAgMHhmZmZmZmZmZjgxOThlNThmIGluIF9fZHJpdmVyX3Byb2JlX2RldmljZQ0KPj4+
Pj4gKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4s
DQo+Pj4+PiBkZXY9ZGV2QGVudHJ5PTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJpdmVy
cy9iYXNlL2RkLmM6ODAwDQo+Pj4+PiAgwqDCoMKgICM5wqAgMHhmZmZmZmZmZjgxOThlNjVh
IGluIGRyaXZlcl9wcm9iZV9kZXZpY2UNCj4+Pj4+IChkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZm
ZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LA0KPj4+Pj4gZGV2PWRldkBlbnRyeT0weGZm
ZmY4ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjgzMA0KPj4+Pj4gIMKg
wqDCoCAjMTAgMHhmZmZmZmZmZjgxOThlODMyIGluIF9fZHJpdmVyX2F0dGFjaA0KPj4+Pj4g
KGRldj0weGZmZmY4ODgwMDU4NWU4MTAsIGRhdGE9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0
aW9fY29uc29sZT4pDQo+Pj4+PiBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzoxMjE2DQo+Pj4+
PiAgwqDCoMKgICMxMSAweGZmZmZmZmZmODE5OGJmYjIgaW4gYnVzX2Zvcl9lYWNoX2RldiAo
YnVzPTxvcHRpbWl6ZWQgb3V0PiwNCj4+Pj4+IHN0YXJ0PXN0YXJ0QGVudHJ5PTB4MCA8Zml4
ZWRfcGVyY3B1X2RhdGE+LA0KPj4+Pj4gZGF0YT1kYXRhQGVudHJ5PTB4ZmZmZmZmZmY4MmJl
NDBjMCA8dmlydGlvX2NvbnNvbGU+LA0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgIGZuPWZuQGVu
dHJ5PTB4ZmZmZmZmZmY4MTk4ZTdiMCA8X19kcml2ZXJfYXR0YWNoPikgYXQNCj4+Pj4+IC4u
L2RyaXZlcnMvYmFzZS9idXMuYzozNjgNCj4+Pj4+ICDCoMKgwqAgIzEyIDB4ZmZmZmZmZmY4
MTk4ZGI2NSBpbiBkcml2ZXJfYXR0YWNoDQo+Pj4+PiAoZHJ2PWRydkBlbnRyeT0weGZmZmZm
ZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQNCj4+Pj4+IC4uL2RyaXZlcnMvYmFz
ZS9kZC5jOjEyMzMNCj4+Pj4+ICDCoMKgwqAgIzEzIDB4ZmZmZmZmZmY4MTk4ZDIwNyBpbiBi
dXNfYWRkX2RyaXZlcg0KPj4+Pj4gKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMw
IDx2aXJ0aW9fY29uc29sZT4pIGF0DQo+Pj4+PiAuLi9kcml2ZXJzL2Jhc2UvYnVzLmM6Njcz
DQo+Pj4+PiAgwqDCoMKgICMxNCAweGZmZmZmZmZmODE5OGY1NTAgaW4gZHJpdmVyX3JlZ2lz
dGVyDQo+Pj4+PiAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19j
b25zb2xlPikgYXQNCj4+Pj4+IC4uL2RyaXZlcnMvYmFzZS9kcml2ZXIuYzoyNDYNCj4+Pj4+
ICDCoMKgwqAgIzE1IDB4ZmZmZmZmZmY4MTcwNmI0NyBpbiByZWdpc3Rlcl92aXJ0aW9fZHJp
dmVyDQo+Pj4+PiAoZHJpdmVyPWRyaXZlckBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZp
cnRpb19jb25zb2xlPikgYXQNCj4+Pj4+IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jOjM1
Nw0KPj4+Pj4gIMKgwqDCoCAjMTYgMHhmZmZmZmZmZjgzMmNkMzRiIGluIHZpcnRpb19jb25z
b2xlX2luaXQgKCkgYXQNCj4+Pj4+IC4uL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5j
OjIyNTgNCj4+Pj4+ICDCoMKgwqAgIzE3IDB4ZmZmZmZmZmY4MTAwMTA1YyBpbiBkb19vbmVf
aW5pdGNhbGwgKGZuPTB4ZmZmZmZmZmY4MzJjZDJlMA0KPj4+Pj4gPHZpcnRpb19jb25zb2xl
X2luaXQ+KSBhdCAuLi9pbml0L21haW4uYzoxMjQ2DQo+Pj4+PiAgwqDCoMKgICMxOCAweGZm
ZmZmZmZmODMyNzcyOTMgaW4gZG9faW5pdGNhbGxfbGV2ZWwNCj4+Pj4+IChjb21tYW5kX2xp
bmU9MHhmZmZmODg4MDAzZTJmOTAwICJyb290IiwgbGV2ZWw9MHg2KSBhdA0KPj4+Pj4gLi4v
aW5pdC9tYWluLmM6MTMxOQ0KPj4+Pj4gIMKgwqDCoCAjMTkgZG9faW5pdGNhbGxzICgpIGF0
IC4uL2luaXQvbWFpbi5jOjEzMzUNCj4+Pj4+ICDCoMKgwqAgIzIwIGRvX2Jhc2ljX3NldHVw
ICgpIGF0IC4uL2luaXQvbWFpbi5jOjEzNTQNCj4+Pj4+ICDCoMKgwqAgIzIxIGtlcm5lbF9p
bml0X2ZyZWVhYmxlICgpIGF0IC4uL2luaXQvbWFpbi5jOjE1NzENCj4+Pj4+ICDCoMKgwqAg
IzIyIDB4ZmZmZmZmZmY4MWY2NGJlMSBpbiBrZXJuZWxfaW5pdCAodW51c2VkPTxvcHRpbWl6
ZWQgb3V0PikNCj4+Pj4+IGF0IC4uL2luaXQvbWFpbi5jOjE0NjINCj4+Pj4+ICDCoMKgwqAg
IzIzIDB4ZmZmZmZmZmY4MTAwMWY0OSBpbiByZXRfZnJvbV9mb3JrICgpIGF0DQo+Pj4+PiAu
Li9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjMwOA0KPj4+Pj4gIMKgwqDCoCAjMjQgMHgw
MDAwMDAwMDAwMDAwMDAwIGluID8/ICgpDQo+Pj4+Pg0KPj4+Pj4gRml4IHRoZSBwcm9ibGVt
IGJ5IHByZXZlbnRpbmcgeGVuX2dyYW50X2luaXRfYmFja2VuZF9kb21pZCgpIGZyb20NCj4+
Pj4+IHNldHRpbmcgZG9tMCBhcyBhIGJhY2tlbmQgd2hlbiBydW5uaW5nIGluIGRvbTAuDQo+
Pj4+Pg0KPj4+Pj4gRml4ZXM6IDAzNWUzYTQzMjFmNyAoInhlbi92aXJ0aW86IE9wdGltaXpl
IHRoZSBzZXR1cCBvZg0KPj4+Pj4gInhlbi1ncmFudC1kbWEiIGRldmljZXMiKQ0KPj4+Pg0K
Pj4+Pg0KPj4+PiBJIGFtIG5vdCAxMDAlIHN1cmUgd2hldGhlciB0aGUgRml4ZXMgdGFnIHBv
aW50cyB0byBwcmVjaXNlIGNvbW1pdC4gSWYgSQ0KPj4+PiBhbSBub3QgbWlzdGFrZW4sIHRo
ZSBzYWlkIGNvbW1pdCBqdXN0IG1vdmVzIHRoZSBjb2RlIGluIHRoZSBjb250ZXh0DQo+Pj4+
IHdpdGhvdXQgY2hhbmdpbmcgdGhlIGxvZ2ljIG9mIENPTkZJR19YRU5fVklSVElPX0ZPUkNF
X0dSQU5ULCB0aGlzIHdhcw0KPj4+PiBpbnRyb2R1Y2VkIGJlZm9yZS4NCj4+Pj4NCj4+Pj4N
Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBldHIgUGF2bHUgPHBldHIucGF2bHVAc3VzZS5jb20+
DQo+Pj4+PiAtLS0NCj4+Pj4+ICDCoMKgIGRyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyB8
IDQgKysrLQ0KPj4+Pj4gIMKgwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9n
cmFudC1kbWEtb3BzLmMgYi9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4+Pj4+IGlu
ZGV4IDc2ZjZmMjYyNjVhMy4uMjllZDI3YWM0NTBlIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJp
dmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+Pj4+PiArKysgYi9kcml2ZXJzL3hlbi9ncmFu
dC1kbWEtb3BzLmMNCj4+Pj4+IEBAIC0zNjIsNyArMzYyLDkgQEAgc3RhdGljIGludCB4ZW5f
Z3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlkKHN0cnVjdA0KPj4+Pj4gZGV2aWNlICpkZXYsDQo+
Pj4+PiAgwqDCoMKgwqDCoMKgIGlmIChucCkgew0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IHhlbl9kdF9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoZGV2LCBucCwNCj4+
Pj4+IGJhY2tlbmRfZG9taWQpOw0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mX25v
ZGVfcHV0KG5wKTsNCj4+Pj4+IC3CoMKgwqAgfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJ
R19YRU5fVklSVElPX0ZPUkNFX0dSQU5UKSB8fA0KPj4+Pj4geGVuX3B2X2RvbWFpbigpKSB7
DQo+Pj4+PiArwqDCoMKgIH0gZWxzZSBpZiAoKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJU
SU9fRk9SQ0VfR1JBTlQpIHx8DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5f
cHZfZG9tYWluKCkpICYmDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgIXhlbl9pbml0
aWFsX2RvbWFpbigpKSB7DQo+Pj4+DQo+Pj4+IFRoZSBjb21taXQgbGd0bSwganVzdCBvbmUg
bm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4gSSB3b3VsZCBldmVuIGJhaWwgb3V0IGVhcmx5IGlu
IHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKCkgaW5zdGVhZCwNCj4+Pj4gYXMgSSBh
c3N1bWUgdGhlIHNhbWUgaXNzdWUgY291bGQgaGFwcGVuIG9uIEFybSB3aXRoIERUIChhbHRo
b3VnaCB0aGVyZQ0KPj4+PiB3ZSBkb24ndCBndWVzcyB0aGUgYmFja2VuZCdzIGRvbWlkLCB3
ZSByZWFkIGl0IGZyb20gRFQgYW5kIHF1aXRlDQo+Pj4+IHVubGlrZWx5IHdlIGdldCBEb20w
IGJlaW5nIGluIERvbTAgd2l0aCBjb3JyZWN0IERUKS4NCj4+Pj4NCj4+Pj4gU29tZXRoaW5n
IGxpa2U6DQo+Pj4+DQo+Pj4+IEBAIC00MTYsNiArNDIxLDEwIEBAIGJvb2wgeGVuX3ZpcnRp
b19yZXN0cmljdGVkX21lbV9hY2Moc3RydWN0DQo+Pj4+IHZpcnRpb19kZXZpY2UgKmRldikN
Cj4+Pj4gIMKgwqAgew0KPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWlkX3QgYmFja2Vu
ZF9kb21pZDsNCj4+Pj4NCj4+Pj4gK8KgwqDCoMKgwqDCoCAvKiBYZW4gZ3JhbnQgRE1BIG9w
cyBhcmUgbm90IHVzZWQgd2hlbiBydW5uaW5nIGFzIGluaXRpYWwNCj4+Pj4gZG9tYWluICov
DQo+Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKHhlbl9pbml0aWFsX2RvbWFpbigpKQ0KPj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4+ICsNCj4+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXhlbl9ncmFudF9pbml0X2JhY2tlbmRfZG9t
aWQoZGV2LT5kZXYucGFyZW50LA0KPj4+PiAmYmFja2VuZF9kb21pZCkpIHsNCj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGVuX2dyYW50X3NldHVwX2RtYV9v
cHMoZGV2LT5kZXYucGFyZW50LA0KPj4+PiBiYWNrZW5kX2RvbWlkKTsNCj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+Pj4+IChFTkQp
DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IElmIHNvLCB0aGF0IGNvbW1pdCBzdWJqZWN0IHdv
dWxkIG5lZWQgdG8gYmUgdXBkYXRlZCBhY2NvcmRpbmdseS4NCj4+Pj4NCj4+Pj4gTGV0J3Mg
c2VlIHdoYXQgb3RoZXIgcmV2aWV3ZXJzIHdpbGwgc2F5Lg0KPj4+DQo+Pj4gVGhpcyBkb2Vz
bid0IHdvcmsgaW4gYWxsIGNhc2VzLiBJbWFnaW5lIHVzaW5nIFBDSSBQYXNzdGhyb3VnaCB0
byBhc3NpZ24NCj4+PiBhICJwaHlzaWNhbCIgdmlydGlvIGRldmljZSB0byBhIGRvbVUuIFRo
ZSBkb21VIHdpbGwgcnVuIGludG8gdGhlIHNhbWUNCj4+PiBlcnJvciwgcmlnaHQ/DQo+Pj4N
Cj4+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIG5lZWQgYSB3YXkgZm9yIHRoZSB2aXJ0aW8g
YmFja2VuZCB0byBhZHZlcnRpc2UNCj4+PiBpdHMgYWJpbGl0eSBvZiBoYW5kbGluZyBncmFu
dHMuIFJpZ2h0IG5vdyB3ZSBvbmx5IGhhdmUgYSB3YXkgdG8gZG8gd2l0aA0KPj4+IHRoYXQg
d2l0aCBkZXZpY2UgdHJlZSBvbiBBUk0uIE9uIHg4Niwgd2Ugb25seSBoYXZlDQo+Pj4gQ09O
RklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQsIGFuZCBpZiB3ZSB0YWtlDQo+Pj4gQ09ORklH
X1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQgYXQgZmFjZSB2YWx1ZSwgaXQgYWxzbyBlbmFibGVz
IGdyYW50cyBmb3INCj4+PiAicGh5c2ljYWwiIHZpcnRpbyBkZXZpY2VzLiBOb3RlIHRoYXQg
aW4gdGhpcyBjYXNlIHdlIGFyZSBmaXhpbmcgYQ0KPj4+IG5lc3RlZC12aXJ0dWFsaXphdGlv
biBidWcsIGJ1dCB0aGVyZSBhcmUgYWN0dWFsbHkgcGh5c2ljYWwNCj4+PiB2aXJ0aW8tY29t
cGF0aWJsZSBkZXZpY2VzIG91dCB0aGVyZS4gQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JB
TlQgd2lsbA0KPj4+IGJyZWFrIHRob3NlIHRvby4NCj4+DQo+PiBJbiBjYXNlIHlvdSB3YW50
IHZpcnRpbyBkZXZpY2UgcGFzc3Rocm91Z2gsIHlvdSBzaG91bGRuJ3QgdXNlIGEga2VybmVs
DQo+PiBidWlsdCB3aXRoIENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dSQU5ULg0KPj4NCj4+
IEFuZCBzdXBwb3J0aW5nIHBhc3NpbmcgdGhyb3VnaCB2aXJ0aW8gZGV2aWNlcyBvZiB0aGUg
aG9zdCB0byBwdi1kb21VcyBpcw0KPj4gYSBzZWN1cml0eSByaXNrIGFueXdheS4NCj4+DQo+
PiBXZSBfY291bGRfIGRyb3AgdGhlIHJlcXVpcmVtZW50IG9mIHRoZSBiYWNrZW5kIG5lZWRp
bmcgdG8gc2V0DQo+PiBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gZm9yIFBWIGd1ZXN0cyBh
bmQgYWxsb3cgZ3JhbnQtbGVzcyB2aXJ0aW8NCj4+IGhhbmRsaW5nIGZvciBhbGwgZ3Vlc3Rz
LiBGb3IgdGhpcyB0byB3b3JrIHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKCkNCj4+
IHdvdWxkIG5lZWQgdG8gY2hlY2sgZm9yIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBhbmQg
cmV0dXJuIHRydWUgaWYgc2V0Lg0KPj4gTWF5YmUgd2UnZCB3YW50IHRvIGVuYWJsZSB0aGF0
IHBvc3NpYmlsaXR5IHZpYSBhIGJvb3QgcGFyYW1ldGVyPw0KPiANCj4gDQo+IE1heWJlLCB5
ZXMuIEkgZG9uJ3Qgc2VlIGF0IHRoZSBtb21lbnQgd2h5IHRoaXMgd29uJ3Qgd29yay4NCj4g
DQo+IEF0IHRoZSBzYW1lIHRpbWUgSSB3b25kZXIsIGNvdWxkIHdlIGp1c3QgbW9kaWZ5IHhl
bl9wdl9pbml0X3BsYXRmb3JtKCkNCj4gdG8gY2FsbCB2aXJ0aW9fbm9fcmVzdHJpY3RlZF9t
ZW1fYWNjKCkgaWYgZm9yY2libHkgZGlzYWJsZWQgYnkgYm9vdA0KPiBwYXJhbWV0ZXIgaXJy
ZXNwZWN0aXZlIG9mIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBwcmVzZW5jZT8NCg0KVGhp
cyB3b3VsZG4ndCB3b3JrIGZvciB0aGUgY2FzZSB3aGVyZSBhIGhvc3QgdmlydGlvIGRldmlj
ZSBpcyBwYXNzZWQgdGhyb3VnaA0KdG8gdGhlIHB2IGRvbVUgYW5kIGF0IHRoZSBzYW1lIHRp
bWUgYW5vdGhlciB2aXJ0aW8gZGV2aWNlIGlzIHVzaW5nIGRvbTAgYXMgYQ0KYmFja2VuZC4g
SSB0aGluayB3ZSBzaG91bGQgdXNlIGdyYW50cyBpZiBwb3NzaWJsZS4NCg0KDQpKdWVyZ2Vu
DQoNCg==
--------------kb0xkp33y6IjSL4ev99Cn3fp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------kb0xkp33y6IjSL4ev99Cn3fp--

--------------0p72qKVXEjc8Akettz9hL15p--

--------------ZRTo4Ebpgwa47mR0WqohChe9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSnyKIFAwAAAAAACgkQsN6d1ii/Ey8E
7Qf/dm40PExD3UqKQhXcgaO4Ovhc9Mu7fzOlT5fy0Iut6lsSOrp1C+fwqJgMlOnet29zuzOLMT9e
Z39TWsdq8gFKE72yOtg5Dvd8JQXTNDpAR50D2sd7VqzEDd5t3n7BI6wMxIw89z8vJOBpPbhLkOsg
bnskPBRjv5AemY+cq8TVYGxuU96OYIh+G6yT9PpxGqvTWpiE58bzIo7KfPwn5WtYAHOAOk6zKFlM
frA5oEDVsXyTtzR8G/87K7I3Rs1rG163Fs4bCl3y/5plVF9e7ZWfX8c119hCTfZj7OTNZ9ifU0eZ
FTDvAaBiXyNA5mr1uHcp8SaNPnT2qn+7/lhSSu8Vxw==
=e86j
-----END PGP SIGNATURE-----

--------------ZRTo4Ebpgwa47mR0WqohChe9--
