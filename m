Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3151F7469A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGDGZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGDGZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:25:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D20BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:25:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 655C221FD5;
        Tue,  4 Jul 2023 06:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688451922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qYP92va/e11rKWSltIXYM3dlSes1GmTJGZ6wryoMX4=;
        b=TUuaMWBGxuvaoFRIBs1rAuNC8sx6v8cuJ3oM8sRtjwBNbry8qnD9ictWPeYmIojVFOS9me
        qpslKGAZ6lP0/BNw48rLaQHOPkwLJvO1U+XfYLee0tZl/GVEI2oZp/ANxhSETwA1FP/sul
        mcfX8BV0HpCPVBvor6l7bcrlrgeTVHg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28502133F7;
        Tue,  4 Jul 2023 06:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yFN3CFK7o2QlcAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Jul 2023 06:25:22 +0000
Message-ID: <319b9f51-c833-49ef-f0e3-1fc5ddb8ae47@suse.com>
Date:   Tue, 4 Jul 2023 08:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------90RvH73Xi3vYjwiAKZs06GnN"
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
--------------90RvH73Xi3vYjwiAKZs06GnN
Content-Type: multipart/mixed; boundary="------------STn05AdcU5bge70lDfUXtYfY";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 vikram.garhwal@amd.com
Message-ID: <319b9f51-c833-49ef-f0e3-1fc5ddb8ae47@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>

--------------STn05AdcU5bge70lDfUXtYfY
Content-Type: multipart/mixed; boundary="------------W7OmSDerYdL9ey1DQ9qTYn1B"

--------------W7OmSDerYdL9ey1DQ9qTYn1B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDYuMjMgMDA6NDQsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVGh1
LCAyOSBKdW4gMjAyMywgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6DQo+PiBPbiAyOS4w
Ni4yMyAwNDowMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPj4NCj4+IEhlbGxvIFN0
ZWZhbm8NCj4+DQo+Pj4gT24gV2VkLCAyMSBKdW4gMjAyMywgT2xla3NhbmRyIFR5c2hjaGVu
a28gd3JvdGU6DQo+Pj4+IE9uIDIxLjA2LjIzIDE2OjEyLCBQZXRyIFBhdmx1IHdyb3RlOg0K
Pj4+Pg0KPj4+Pg0KPj4+PiBIZWxsbyBQZXRyDQo+Pj4+DQo+Pj4+DQo+Pj4+PiBXaGVuIGF0
dGVtcHRpbmcgdG8gcnVuIFhlbiBvbiBhIFFFTVUvS1ZNIHZpcnR1YWwgbWFjaGluZSB3aXRo
IHZpcnRpbw0KPj4+Pj4gZGV2aWNlcyAoYWxsIHg4Nl82NCksIGRvbTAgdHJpZXMgdG8gZXN0
YWJsaXNoIGEgZ3JhbnQgZm9yIGl0c2VsZiB3aGljaA0KPj4+Pj4gZXZlbnR1YWxseSByZXN1
bHRzIGluIGEgaGFuZyBkdXJpbmcgdGhlIGJvb3QuDQo+Pj4+Pg0KPj4+Pj4gVGhlIGJhY2t0
cmFjZSBsb29rcyBhcyBmb2xsb3dzLCB0aGUgd2hpbGUgbG9vcCBpbiBfX3NlbmRfY29udHJv
bF9tc2coKQ0KPj4+Pj4gbWFrZXMgbm8gcHJvZ3Jlc3M6DQo+Pj4+Pg0KPj4+Pj4gICAgICAj
MCAgdmlydHF1ZXVlX2dldF9idWZfY3R4IChfdnE9X3ZxQGVudHJ5PTB4ZmZmZjg4ODAwNzRh
ODQwMCwgbGVuPWxlbkBlbnRyeT0weGZmZmZjOTAwMDA0MTNjOTQsIGN0eD1jdHhAZW50cnk9
MHgwIDxmaXhlZF9wZXJjcHVfZGF0YT4pIGF0IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmM6MjMyNg0KPj4+Pj4gICAgICAjMSAgMHhmZmZmZmZmZjgxNzA4NmI3IGluIHZpcnRx
dWV1ZV9nZXRfYnVmIChfdnE9X3ZxQGVudHJ5PTB4ZmZmZjg4ODAwNzRhODQwMCwgbGVuPWxl
bkBlbnRyeT0weGZmZmZjOTAwMDA0MTNjOTQpIGF0IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmM6MjMzMw0KPj4+Pj4gICAgICAjMiAgMHhmZmZmZmZmZjgxNzVmNmIyIGluIF9f
c2VuZF9jb250cm9sX21zZyAocG9ydGRldj08b3B0aW1pemVkIG91dD4sIHBvcnRfaWQ9MHhm
ZmZmZmZmZiwgZXZlbnQ9MHgwLCB2YWx1ZT0weDEpIGF0IC4uL2RyaXZlcnMvY2hhci92aXJ0
aW9fY29uc29sZS5jOjU2Mg0KPj4+Pj4gICAgICAjMyAgMHhmZmZmZmZmZjgxNzVmNmVlIGlu
IF9fc2VuZF9jb250cm9sX21zZyAocG9ydGRldj08b3B0aW1pemVkIG91dD4sIHBvcnRfaWQ9
PG9wdGltaXplZCBvdXQ+LCBldmVudD08b3B0aW1pemVkIG91dD4sIHZhbHVlPTxvcHRpbWl6
ZWQgb3V0PikgYXQgLi4vZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6NTY5DQo+Pj4+
PiAgICAgICM0ICAweGZmZmZmZmZmODE3NjE4YjEgaW4gdmlydGNvbnNfcHJvYmUgKHZkZXY9
MHhmZmZmODg4MDA1ODVlODAwKSBhdCAuLi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUu
YzoyMDk4DQo+Pj4+PiAgICAgICM1ICAweGZmZmZmZmZmODE3MDcxMTcgaW4gdmlydGlvX2Rl
dl9wcm9iZSAoX2Q9MHhmZmZmODg4MDA1ODVlODEwKSBhdCAuLi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW8uYzozMDUNCj4+Pj4+ICAgICAgIzYgIDB4ZmZmZmZmZmY4MTk4ZTM0OCBpbiBjYWxs
X2RyaXZlcl9wcm9iZSAoZHJ2PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+
LCBkcnY9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4sIGRldj0weGZmZmY4
ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjU3OQ0KPj4+Pj4gICAgICAj
NyAgcmVhbGx5X3Byb2JlIChkZXY9ZGV2QGVudHJ5PTB4ZmZmZjg4ODAwNTg1ZTgxMCwgZHJ2
PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQgLi4v
ZHJpdmVycy9iYXNlL2RkLmM6NjU4DQo+Pj4+PiAgICAgICM4ICAweGZmZmZmZmZmODE5OGU1
OGYgaW4gX19kcml2ZXJfcHJvYmVfZGV2aWNlIChkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4
MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LCBkZXY9ZGV2QGVudHJ5PTB4ZmZmZjg4ODAwNTg1
ZTgxMCkgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6ODAwDQo+Pj4+PiAgICAgICM5ICAweGZm
ZmZmZmZmODE5OGU2NWEgaW4gZHJpdmVyX3Byb2JlX2RldmljZSAoZHJ2PWRydkBlbnRyeT0w
eGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwgZGV2PWRldkBlbnRyeT0weGZm
ZmY4ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjgzMA0KPj4+Pj4gICAg
ICAjMTAgMHhmZmZmZmZmZjgxOThlODMyIGluIF9fZHJpdmVyX2F0dGFjaCAoZGV2PTB4ZmZm
Zjg4ODAwNTg1ZTgxMCwgZGF0YT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xl
PikgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6MTIxNg0KPj4+Pj4gICAgICAjMTEgMHhmZmZm
ZmZmZjgxOThiZmIyIGluIGJ1c19mb3JfZWFjaF9kZXYgKGJ1cz08b3B0aW1pemVkIG91dD4s
IHN0YXJ0PXN0YXJ0QGVudHJ5PTB4MCA8Zml4ZWRfcGVyY3B1X2RhdGE+LCBkYXRhPWRhdGFA
ZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4sDQo+Pj4+PiAgICAg
ICAgICBmbj1mbkBlbnRyeT0weGZmZmZmZmZmODE5OGU3YjAgPF9fZHJpdmVyX2F0dGFjaD4p
IGF0IC4uL2RyaXZlcnMvYmFzZS9idXMuYzozNjgNCj4+Pj4+ICAgICAgIzEyIDB4ZmZmZmZm
ZmY4MTk4ZGI2NSBpbiBkcml2ZXJfYXR0YWNoIChkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4
MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzoxMjMz
DQo+Pj4+PiAgICAgICMxMyAweGZmZmZmZmZmODE5OGQyMDcgaW4gYnVzX2FkZF9kcml2ZXIg
KGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0
IC4uL2RyaXZlcnMvYmFzZS9idXMuYzo2NzMNCj4+Pj4+ICAgICAgIzE0IDB4ZmZmZmZmZmY4
MTk4ZjU1MCBpbiBkcml2ZXJfcmVnaXN0ZXIgKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgy
YmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0IC4uL2RyaXZlcnMvYmFzZS9kcml2ZXIuYzoy
NDYNCj4+Pj4+ICAgICAgIzE1IDB4ZmZmZmZmZmY4MTcwNmI0NyBpbiByZWdpc3Rlcl92aXJ0
aW9fZHJpdmVyIChkcml2ZXI9ZHJpdmVyQGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmly
dGlvX2NvbnNvbGU+KSBhdCAuLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYzozNTcNCj4+Pj4+
ICAgICAgIzE2IDB4ZmZmZmZmZmY4MzJjZDM0YiBpbiB2aXJ0aW9fY29uc29sZV9pbml0ICgp
IGF0IC4uL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jOjIyNTgNCj4+Pj4+ICAgICAg
IzE3IDB4ZmZmZmZmZmY4MTAwMTA1YyBpbiBkb19vbmVfaW5pdGNhbGwgKGZuPTB4ZmZmZmZm
ZmY4MzJjZDJlMCA8dmlydGlvX2NvbnNvbGVfaW5pdD4pIGF0IC4uL2luaXQvbWFpbi5jOjEy
NDYNCj4+Pj4+ICAgICAgIzE4IDB4ZmZmZmZmZmY4MzI3NzI5MyBpbiBkb19pbml0Y2FsbF9s
ZXZlbCAoY29tbWFuZF9saW5lPTB4ZmZmZjg4ODAwM2UyZjkwMCAicm9vdCIsIGxldmVsPTB4
NikgYXQgLi4vaW5pdC9tYWluLmM6MTMxOQ0KPj4+Pj4gICAgICAjMTkgZG9faW5pdGNhbGxz
ICgpIGF0IC4uL2luaXQvbWFpbi5jOjEzMzUNCj4+Pj4+ICAgICAgIzIwIGRvX2Jhc2ljX3Nl
dHVwICgpIGF0IC4uL2luaXQvbWFpbi5jOjEzNTQNCj4+Pj4+ICAgICAgIzIxIGtlcm5lbF9p
bml0X2ZyZWVhYmxlICgpIGF0IC4uL2luaXQvbWFpbi5jOjE1NzENCj4+Pj4+ICAgICAgIzIy
IDB4ZmZmZmZmZmY4MWY2NGJlMSBpbiBrZXJuZWxfaW5pdCAodW51c2VkPTxvcHRpbWl6ZWQg
b3V0PikgYXQgLi4vaW5pdC9tYWluLmM6MTQ2Mg0KPj4+Pj4gICAgICAjMjMgMHhmZmZmZmZm
ZjgxMDAxZjQ5IGluIHJldF9mcm9tX2ZvcmsgKCkgYXQgLi4vYXJjaC94ODYvZW50cnkvZW50
cnlfNjQuUzozMDgNCj4+Pj4+ICAgICAgIzI0IDB4MDAwMDAwMDAwMDAwMDAwMCBpbiA/PyAo
KQ0KPj4+Pj4NCj4+Pj4+IEZpeCB0aGUgcHJvYmxlbSBieSBwcmV2ZW50aW5nIHhlbl9ncmFu
dF9pbml0X2JhY2tlbmRfZG9taWQoKSBmcm9tDQo+Pj4+PiBzZXR0aW5nIGRvbTAgYXMgYSBi
YWNrZW5kIHdoZW4gcnVubmluZyBpbiBkb20wLg0KPj4+Pj4NCj4+Pj4+IEZpeGVzOiAwMzVl
M2E0MzIxZjcgKCJ4ZW4vdmlydGlvOiBPcHRpbWl6ZSB0aGUgc2V0dXAgb2YgInhlbi1ncmFu
dC1kbWEiIGRldmljZXMiKQ0KPj4+Pg0KPj4+Pg0KPj4+PiBJIGFtIG5vdCAxMDAlIHN1cmUg
d2hldGhlciB0aGUgRml4ZXMgdGFnIHBvaW50cyB0byBwcmVjaXNlIGNvbW1pdC4gSWYgSQ0K
Pj4+PiBhbSBub3QgbWlzdGFrZW4sIHRoZSBzYWlkIGNvbW1pdCBqdXN0IG1vdmVzIHRoZSBj
b2RlIGluIHRoZSBjb250ZXh0DQo+Pj4+IHdpdGhvdXQgY2hhbmdpbmcgdGhlIGxvZ2ljIG9m
IENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dSQU5ULCB0aGlzIHdhcw0KPj4+PiBpbnRyb2R1
Y2VkIGJlZm9yZS4NCj4+Pj4NCj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBldHIgUGF2
bHUgPHBldHIucGF2bHVAc3VzZS5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgICBkcml2ZXJz
L3hlbi9ncmFudC1kbWEtb3BzLmMgfCA0ICsrKy0NCj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYyBiL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYw0KPj4+Pj4gaW5kZXggNzZmNmYyNjI2NWEzLi4yOWVkMjdhYzQ1MGUgMTAw
NjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMNCj4+Pj4+ICsr
KyBiL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4+Pj4gQEAgLTM2Miw3ICszNjIs
OSBAQCBzdGF0aWMgaW50IHhlbl9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoc3RydWN0IGRl
dmljZSAqZGV2LA0KPj4+Pj4gICAgIAlpZiAobnApIHsNCj4+Pj4+ICAgICAJCXJldCA9IHhl
bl9kdF9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoZGV2LCBucCwgYmFja2VuZF9kb21pZCk7
DQo+Pj4+PiAgICAgCQlvZl9ub2RlX3B1dChucCk7DQo+Pj4+PiAtCX0gZWxzZSBpZiAoSVNf
RU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCkgfHwgeGVuX3B2X2RvbWFp
bigpKSB7DQo+Pj4+PiArCX0gZWxzZSBpZiAoKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJU
SU9fRk9SQ0VfR1JBTlQpIHx8DQo+Pj4+PiArCQkgICAgeGVuX3B2X2RvbWFpbigpKSAmJg0K
Pj4+Pj4gKwkJICAgIXhlbl9pbml0aWFsX2RvbWFpbigpKSB7DQo+Pj4+DQo+Pj4+IFRoZSBj
b21taXQgbGd0bSwganVzdCBvbmUgbm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4gSSB3b3VsZCBl
dmVuIGJhaWwgb3V0IGVhcmx5IGluIHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKCkg
aW5zdGVhZCwNCj4+Pj4gYXMgSSBhc3N1bWUgdGhlIHNhbWUgaXNzdWUgY291bGQgaGFwcGVu
IG9uIEFybSB3aXRoIERUIChhbHRob3VnaCB0aGVyZQ0KPj4+PiB3ZSBkb24ndCBndWVzcyB0
aGUgYmFja2VuZCdzIGRvbWlkLCB3ZSByZWFkIGl0IGZyb20gRFQgYW5kIHF1aXRlDQo+Pj4+
IHVubGlrZWx5IHdlIGdldCBEb20wIGJlaW5nIGluIERvbTAgd2l0aCBjb3JyZWN0IERUKS4N
Cj4+Pj4NCj4+Pj4gU29tZXRoaW5nIGxpa2U6DQo+Pj4+DQo+Pj4+IEBAIC00MTYsNiArNDIx
LDEwIEBAIGJvb2wgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2Moc3RydWN0DQo+Pj4+
IHZpcnRpb19kZXZpY2UgKmRldikNCj4+Pj4gICAgIHsNCj4+Pj4gICAgICAgICAgICBkb21p
ZF90IGJhY2tlbmRfZG9taWQ7DQo+Pj4+DQo+Pj4+ICsgICAgICAgLyogWGVuIGdyYW50IERN
QSBvcHMgYXJlIG5vdCB1c2VkIHdoZW4gcnVubmluZyBhcyBpbml0aWFsIGRvbWFpbiAqLw0K
Pj4+PiArICAgICAgIGlmICh4ZW5faW5pdGlhbF9kb21haW4oKSkNCj4+Pj4gKyAgICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4gKw0KPj4+PiAgICAgICAgICAgIGlmICgheGVu
X2dyYW50X2luaXRfYmFja2VuZF9kb21pZChkZXYtPmRldi5wYXJlbnQsDQo+Pj4+ICZiYWNr
ZW5kX2RvbWlkKSkgew0KPj4+PiAgICAgICAgICAgICAgICAgICAgeGVuX2dyYW50X3NldHVw
X2RtYV9vcHMoZGV2LT5kZXYucGFyZW50LCBiYWNrZW5kX2RvbWlkKTsNCj4+Pj4gICAgICAg
ICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4+PiAoRU5EKQ0KPj4+Pg0KPj4+Pg0KPj4+
Pg0KPj4+PiBJZiBzbywgdGhhdCBjb21taXQgc3ViamVjdCB3b3VsZCBuZWVkIHRvIGJlIHVw
ZGF0ZWQgYWNjb3JkaW5nbHkuDQo+Pj4+DQo+Pj4+IExldCdzIHNlZSB3aGF0IG90aGVyIHJl
dmlld2VycyB3aWxsIHNheS4NCj4+Pg0KPj4+IFRoaXMgZG9lc24ndCB3b3JrIGluIGFsbCBj
YXNlcy4gSW1hZ2luZSB1c2luZyBQQ0kgUGFzc3Rocm91Z2ggdG8gYXNzaWduDQo+Pj4gYSAi
cGh5c2ljYWwiIHZpcnRpbyBkZXZpY2UgdG8gYSBkb21VLiBUaGUgZG9tVSB3aWxsIHJ1biBp
bnRvIHRoZSBzYW1lDQo+Pj4gZXJyb3IsIHJpZ2h0Pw0KPj4+DQo+Pj4gVGhlIHByb2JsZW0g
aXMgdGhhdCB3ZSBuZWVkIGEgd2F5IGZvciB0aGUgdmlydGlvIGJhY2tlbmQgdG8gYWR2ZXJ0
aXNlDQo+Pj4gaXRzIGFiaWxpdHkgb2YgaGFuZGxpbmcgZ3JhbnRzLiBSaWdodCBub3cgd2Ug
b25seSBoYXZlIGEgd2F5IHRvIGRvIHdpdGgNCj4+PiB0aGF0IHdpdGggZGV2aWNlIHRyZWUg
b24gQVJNLiBPbiB4ODYsIHdlIG9ubHkgaGF2ZQ0KPj4+IENPTkZJR19YRU5fVklSVElPX0ZP
UkNFX0dSQU5ULCBhbmQgaWYgd2UgdGFrZQ0KPj4+IENPTkZJR19YRU5fVklSVElPX0ZPUkNF
X0dSQU5UIGF0IGZhY2UgdmFsdWUsIGl0IGFsc28gZW5hYmxlcyBncmFudHMgZm9yDQo+Pj4g
InBoeXNpY2FsIiB2aXJ0aW8gZGV2aWNlcy4gTm90ZSB0aGF0IGluIHRoaXMgY2FzZSB3ZSBh
cmUgZml4aW5nIGENCj4+PiBuZXN0ZWQtdmlydHVhbGl6YXRpb24gYnVnLCBidXQgdGhlcmUg
YXJlIGFjdHVhbGx5IHBoeXNpY2FsDQo+Pj4gdmlydGlvLWNvbXBhdGlibGUgZGV2aWNlcyBv
dXQgdGhlcmUuIENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dSQU5UIHdpbGwNCj4+PiBicmVh
ayB0aG9zZSB0b28uDQo+Pg0KPj4NCj4+IElmIHRoZXNlICJwaHlzaWNhbCIgdmlydGlvIGRl
dmljZXMgYXJlIGFsc28gc3Bhd25lZCBieQ0KPj4gZHJpdmVycy92aXJ0aW8vdmlydGlvLmM6
dmlydGlvX2Rldl9wcm9iZSgpLCB0aGVuIHllcywgb3RoZXJ3aXNlIEkgZG9uJ3QNCj4+IHNl
ZSBob3cgdGhpcyBjb3VsZCBldmVuIGJlIHBvc3NpYmxlLCBidXQgSSBtaWdodCBtaXNzIHNv
bWV0aGluZyBoZXJlLg0KPiANCj4gWWVzLCBJIHdvdWxkIGltYWdpbmUgdmlydGlvX2Rldl9w
cm9iZSgpIHdvdWxkIGJlIGNhbGxlZCBmb3IgdGhlbSB0b28NCj4gDQo+IA0KPiANCj4+IHhl
bl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKCkgZ2V0cyBjYWxsZWQgaW5kaXJlY3RseSBm
cm9tDQo+PiB2aXJ0aW9fZGV2X3Byb2JlKCktPnZpcnRpb19mZWF0dXJlc19vaygpLT4NCj4+
IHZpcnRpb19jaGVja19tZW1fYWNjX2NiKCkuIFNvIHRoZSBYZW4gZ3JhbnQgRE1BIG9wcyBh
cmUgb25seSBpbnN0YWxsZWQNCj4+IGZvciB0aG9zZS4NCj4+DQo+Pg0KPj4+DQo+Pj4gSSB0
aGluayB3ZSBuZWVkIHRvIGFkZCBhIHNlY29uZCB3YXk/IEl0IGNvdWxkIGJlIGFueXRoaW5n
IHRoYXQgY2FuIGhlbHANCj4+PiB1cyBkaXN0aW5ndWlzaCBiZXR3ZWVuIGEgbm9uLWdyYW50
cy1jYXBhYmxlIHZpcnRpbyBiYWNrZW5kIGFuZCBhDQo+Pj4gZ3JhbnRzLWNhcGFibGUgdmly
dGlvIGJhY2tlbmQsIHN1Y2ggYXM6DQo+Pj4gLSBhIHN0cmluZyBvbiB4ZW5zdG9yZQ0KPj4+
IC0gYSB4ZW4gcGFyYW0NCj4+PiAtIGEgc3BlY2lhbCBQQ0kgY29uZmlndXJhdGlvbiByZWdp
c3RlciB2YWx1ZQ0KPj4+IC0gc29tZXRoaW5nIGluIHRoZSBBQ1BJIHRhYmxlcw0KPj4+IC0g
dGhlIFFFTVUgbWFjaGluZSB0eXBlDQo+Pg0KPj4NCj4+IFllcywgSSByZW1lbWJlciB0aGVy
ZSB3YXMgYSBkaXNjdXNzaW9uIHJlZ2FyZGluZyB0aGF0LiBUaGUgcG9pbnQgaXMgdG8NCj4+
IGNob29zZSBhIHNvbHV0aW9uIHRvIGJlIGZ1bmN0aW9uYWwgZm9yIGJvdGggUFYgYW5kIEhW
TSAqYW5kKiB0byBiZSBhYmxlDQo+PiB0byBzdXBwb3J0IGEgaG90cGx1Zy4gSUlSQywgdGhl
IHhlbnN0b3JlIGNvdWxkIGJlIGEgcG9zc2libGUgY2FuZGlkYXRlLg0KPiANCj4geGVuc3Rv
cmUgd291bGQgYmUgYW1vbmcgdGhlIGVhc2llc3QgdG8gbWFrZSB3b3JrLiBUaGUgb25seSBk
b3duc2lkZSBpcw0KPiB0aGUgZGVwZW5kZW5jeSBvbiB4ZW5zdG9yZSB3aGljaCBvdGhlcndp
c2UgdmlydGlvK2dyYW50cyBkb2Vzbid0IGhhdmUuDQoNCkknbSBpbiBmYXZvciBvZiB1c2lu
ZyB4ZW5zdG9yZS4gRXNwZWNpYWxseSB0aGUgaG90cGx1ZyBzdXBwb3J0IHdvdWxkIGJlDQpt
dWNoIGVhc2llciB1c2luZyB4ZW5zdG9yZSAodGhlIGFsdGVybmF0aXZlIHdvdWxkIGJlIEFD
UEksIHdoaWNoIEkgZG9uJ3QNCnRoaW5rIHdlIHdhbnQgZm9yIFBWIGd1ZXN0cyBvciBtYW55
IEFybSBjb25maWd1cmF0aW9ucykuDQoNCg0KSnVlcmdlbg0K
--------------W7OmSDerYdL9ey1DQ9qTYn1B
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------W7OmSDerYdL9ey1DQ9qTYn1B--

--------------STn05AdcU5bge70lDfUXtYfY--

--------------90RvH73Xi3vYjwiAKZs06GnN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSju1EFAwAAAAAACgkQsN6d1ii/Ey9Z
8gf8CZDmIy6ODm7xebD8YeeabCWV1Hcc9/xof/0/fUBQFOJaRi7b2LJXFqQuWchw63v3gRHsPZqj
RrdOup2UxFtYLC2ZQDsjBqvFW1tf/NXlaFC00KBfHQd4tez/zpTlt4Y0AEEt98vCdd4DTcibnn1i
VL2bzyABH8huZTbdkn8n2vOJJzdHTR87gJrUod886ppM6b/3IPom6Kxq0xjmM712s2/7lMv7Cwg7
NM62DVpOCfbFcgHMWaCAC9XI3ccwvicTV/rXWbhhjebPCJCT5GC8l3H2hYfYRWLxKng42GOyAzOv
gsazPRmy6/PwFe3aERrrxmirz2BerfA2uZ5uDLergA==
=rBab
-----END PGP SIGNATURE-----

--------------90RvH73Xi3vYjwiAKZs06GnN--
