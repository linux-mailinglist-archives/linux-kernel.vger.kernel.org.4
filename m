Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7872B74AB81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjGGHEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGGHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:04:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EE199F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:04:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C05D322769;
        Fri,  7 Jul 2023 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688713447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IoXUdX2e04LIweNsF6ClZzH9OgFHRhsLNVP6tEmGsWw=;
        b=qgj18C6+XUBNbQSQicOsnWh+9bRj30U8erf+D3FpJUmC6PQnZMuGX03Iprb60qfdNmKKbS
        Smvsqboihr9JBPuxUmd8yi6XJmVitlEyqiE9PBRJbHVhUFm3VvTL9+9sQcCHP4skXuXTvz
        0yb11ddJKsxBDR+pPa19qjWHK8H0RIo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D7C11346D;
        Fri,  7 Jul 2023 07:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ce8BIee4p2RuEgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 07:04:07 +0000
Message-ID: <f1a81ac1-5b9a-6d19-1a11-b98685bd2430@suse.com>
Date:   Fri, 7 Jul 2023 09:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oFLmLR3jxUNfFSepkKTBAW4N"
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
--------------oFLmLR3jxUNfFSepkKTBAW4N
Content-Type: multipart/mixed; boundary="------------ztc028cfnLYtqIaXIzboLI09";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <f1a81ac1-5b9a-6d19-1a11-b98685bd2430@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>

--------------ztc028cfnLYtqIaXIzboLI09
Content-Type: multipart/mixed; boundary="------------IZPK5gmaQ5zbpEG6t0uvm0MA"

--------------IZPK5gmaQ5zbpEG6t0uvm0MA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UmUtcmVhZGluZyB0aGUgd2hvbGUgdGhyZWFkIGFnYWluIC4uLg0KDQpPbiAyOS4wNi4yMyAw
MzowMCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPiBPbiBXZWQsIDIxIEp1biAyMDIz
LCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToNCj4+IE9uIDIxLjA2LjIzIDE2OjEyLCBQ
ZXRyIFBhdmx1IHdyb3RlOg0KPj4NCj4+DQo+PiBIZWxsbyBQZXRyDQo+Pg0KPj4NCj4+PiBX
aGVuIGF0dGVtcHRpbmcgdG8gcnVuIFhlbiBvbiBhIFFFTVUvS1ZNIHZpcnR1YWwgbWFjaGlu
ZSB3aXRoIHZpcnRpbw0KPj4+IGRldmljZXMgKGFsbCB4ODZfNjQpLCBkb20wIHRyaWVzIHRv
IGVzdGFibGlzaCBhIGdyYW50IGZvciBpdHNlbGYgd2hpY2gNCj4+PiBldmVudHVhbGx5IHJl
c3VsdHMgaW4gYSBoYW5nIGR1cmluZyB0aGUgYm9vdC4NCj4+Pg0KPj4+IFRoZSBiYWNrdHJh
Y2UgbG9va3MgYXMgZm9sbG93cywgdGhlIHdoaWxlIGxvb3AgaW4gX19zZW5kX2NvbnRyb2xf
bXNnKCkNCj4+PiBtYWtlcyBubyBwcm9ncmVzczoNCj4+Pg0KPj4+ICAgICAjMCAgdmlydHF1
ZXVlX2dldF9idWZfY3R4IChfdnE9X3ZxQGVudHJ5PTB4ZmZmZjg4ODAwNzRhODQwMCwgbGVu
PWxlbkBlbnRyeT0weGZmZmZjOTAwMDA0MTNjOTQsIGN0eD1jdHhAZW50cnk9MHgwIDxmaXhl
ZF9wZXJjcHVfZGF0YT4pIGF0IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjMy
Ng0KPj4+ICAgICAjMSAgMHhmZmZmZmZmZjgxNzA4NmI3IGluIHZpcnRxdWV1ZV9nZXRfYnVm
IChfdnE9X3ZxQGVudHJ5PTB4ZmZmZjg4ODAwNzRhODQwMCwgbGVuPWxlbkBlbnRyeT0weGZm
ZmZjOTAwMDA0MTNjOTQpIGF0IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjMz
Mw0KPj4+ICAgICAjMiAgMHhmZmZmZmZmZjgxNzVmNmIyIGluIF9fc2VuZF9jb250cm9sX21z
ZyAocG9ydGRldj08b3B0aW1pemVkIG91dD4sIHBvcnRfaWQ9MHhmZmZmZmZmZiwgZXZlbnQ9
MHgwLCB2YWx1ZT0weDEpIGF0IC4uL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jOjU2
Mg0KPj4+ICAgICAjMyAgMHhmZmZmZmZmZjgxNzVmNmVlIGluIF9fc2VuZF9jb250cm9sX21z
ZyAocG9ydGRldj08b3B0aW1pemVkIG91dD4sIHBvcnRfaWQ9PG9wdGltaXplZCBvdXQ+LCBl
dmVudD08b3B0aW1pemVkIG91dD4sIHZhbHVlPTxvcHRpbWl6ZWQgb3V0PikgYXQgLi4vZHJp
dmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6NTY5DQo+Pj4gICAgICM0ICAweGZmZmZmZmZm
ODE3NjE4YjEgaW4gdmlydGNvbnNfcHJvYmUgKHZkZXY9MHhmZmZmODg4MDA1ODVlODAwKSBh
dCAuLi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYzoyMDk4DQo+Pj4gICAgICM1ICAw
eGZmZmZmZmZmODE3MDcxMTcgaW4gdmlydGlvX2Rldl9wcm9iZSAoX2Q9MHhmZmZmODg4MDA1
ODVlODEwKSBhdCAuLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYzozMDUNCj4+PiAgICAgIzYg
IDB4ZmZmZmZmZmY4MTk4ZTM0OCBpbiBjYWxsX2RyaXZlcl9wcm9iZSAoZHJ2PTB4ZmZmZmZm
ZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LCBkcnY9MHhmZmZmZmZmZjgyYmU0MGMwIDx2
aXJ0aW9fY29uc29sZT4sIGRldj0weGZmZmY4ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMv
YmFzZS9kZC5jOjU3OQ0KPj4+ICAgICAjNyAgcmVhbGx5X3Byb2JlIChkZXY9ZGV2QGVudHJ5
PTB4ZmZmZjg4ODAwNTg1ZTgxMCwgZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAg
PHZpcnRpb19jb25zb2xlPikgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6NjU4DQo+Pj4gICAg
ICM4ICAweGZmZmZmZmZmODE5OGU1OGYgaW4gX19kcml2ZXJfcHJvYmVfZGV2aWNlIChkcnY9
ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LCBkZXY9ZGV2
QGVudHJ5PTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6ODAw
DQo+Pj4gICAgICM5ICAweGZmZmZmZmZmODE5OGU2NWEgaW4gZHJpdmVyX3Byb2JlX2Rldmlj
ZSAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwg
ZGV2PWRldkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTApIGF0IC4uL2RyaXZlcnMvYmFzZS9k
ZC5jOjgzMA0KPj4+ICAgICAjMTAgMHhmZmZmZmZmZjgxOThlODMyIGluIF9fZHJpdmVyX2F0
dGFjaCAoZGV2PTB4ZmZmZjg4ODAwNTg1ZTgxMCwgZGF0YT0weGZmZmZmZmZmODJiZTQwYzAg
PHZpcnRpb19jb25zb2xlPikgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6MTIxNg0KPj4+ICAg
ICAjMTEgMHhmZmZmZmZmZjgxOThiZmIyIGluIGJ1c19mb3JfZWFjaF9kZXYgKGJ1cz08b3B0
aW1pemVkIG91dD4sIHN0YXJ0PXN0YXJ0QGVudHJ5PTB4MCA8Zml4ZWRfcGVyY3B1X2RhdGE+
LCBkYXRhPWRhdGFAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4s
DQo+Pj4gICAgICAgICBmbj1mbkBlbnRyeT0weGZmZmZmZmZmODE5OGU3YjAgPF9fZHJpdmVy
X2F0dGFjaD4pIGF0IC4uL2RyaXZlcnMvYmFzZS9idXMuYzozNjgNCj4+PiAgICAgIzEyIDB4
ZmZmZmZmZmY4MTk4ZGI2NSBpbiBkcml2ZXJfYXR0YWNoIChkcnY9ZHJ2QGVudHJ5PTB4ZmZm
ZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQu
YzoxMjMzDQo+Pj4gICAgICMxMyAweGZmZmZmZmZmODE5OGQyMDcgaW4gYnVzX2FkZF9kcml2
ZXIgKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4p
IGF0IC4uL2RyaXZlcnMvYmFzZS9idXMuYzo2NzMNCj4+PiAgICAgIzE0IDB4ZmZmZmZmZmY4
MTk4ZjU1MCBpbiBkcml2ZXJfcmVnaXN0ZXIgKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgy
YmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0IC4uL2RyaXZlcnMvYmFzZS9kcml2ZXIuYzoy
NDYNCj4+PiAgICAgIzE1IDB4ZmZmZmZmZmY4MTcwNmI0NyBpbiByZWdpc3Rlcl92aXJ0aW9f
ZHJpdmVyIChkcml2ZXI9ZHJpdmVyQGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlv
X2NvbnNvbGU+KSBhdCAuLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYzozNTcNCj4+PiAgICAg
IzE2IDB4ZmZmZmZmZmY4MzJjZDM0YiBpbiB2aXJ0aW9fY29uc29sZV9pbml0ICgpIGF0IC4u
L2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jOjIyNTgNCj4+PiAgICAgIzE3IDB4ZmZm
ZmZmZmY4MTAwMTA1YyBpbiBkb19vbmVfaW5pdGNhbGwgKGZuPTB4ZmZmZmZmZmY4MzJjZDJl
MCA8dmlydGlvX2NvbnNvbGVfaW5pdD4pIGF0IC4uL2luaXQvbWFpbi5jOjEyNDYNCj4+PiAg
ICAgIzE4IDB4ZmZmZmZmZmY4MzI3NzI5MyBpbiBkb19pbml0Y2FsbF9sZXZlbCAoY29tbWFu
ZF9saW5lPTB4ZmZmZjg4ODAwM2UyZjkwMCAicm9vdCIsIGxldmVsPTB4NikgYXQgLi4vaW5p
dC9tYWluLmM6MTMxOQ0KPj4+ICAgICAjMTkgZG9faW5pdGNhbGxzICgpIGF0IC4uL2luaXQv
bWFpbi5jOjEzMzUNCj4+PiAgICAgIzIwIGRvX2Jhc2ljX3NldHVwICgpIGF0IC4uL2luaXQv
bWFpbi5jOjEzNTQNCj4+PiAgICAgIzIxIGtlcm5lbF9pbml0X2ZyZWVhYmxlICgpIGF0IC4u
L2luaXQvbWFpbi5jOjE1NzENCj4+PiAgICAgIzIyIDB4ZmZmZmZmZmY4MWY2NGJlMSBpbiBr
ZXJuZWxfaW5pdCAodW51c2VkPTxvcHRpbWl6ZWQgb3V0PikgYXQgLi4vaW5pdC9tYWluLmM6
MTQ2Mg0KPj4+ICAgICAjMjMgMHhmZmZmZmZmZjgxMDAxZjQ5IGluIHJldF9mcm9tX2Zvcmsg
KCkgYXQgLi4vYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUzozMDgNCj4+PiAgICAgIzI0IDB4
MDAwMDAwMDAwMDAwMDAwMCBpbiA/PyAoKQ0KPj4+DQo+Pj4gRml4IHRoZSBwcm9ibGVtIGJ5
IHByZXZlbnRpbmcgeGVuX2dyYW50X2luaXRfYmFja2VuZF9kb21pZCgpIGZyb20NCj4+PiBz
ZXR0aW5nIGRvbTAgYXMgYSBiYWNrZW5kIHdoZW4gcnVubmluZyBpbiBkb20wLg0KPj4+DQo+
Pj4gRml4ZXM6IDAzNWUzYTQzMjFmNyAoInhlbi92aXJ0aW86IE9wdGltaXplIHRoZSBzZXR1
cCBvZiAieGVuLWdyYW50LWRtYSIgZGV2aWNlcyIpDQo+Pg0KPj4NCj4+IEkgYW0gbm90IDEw
MCUgc3VyZSB3aGV0aGVyIHRoZSBGaXhlcyB0YWcgcG9pbnRzIHRvIHByZWNpc2UgY29tbWl0
LiBJZiBJDQo+PiBhbSBub3QgbWlzdGFrZW4sIHRoZSBzYWlkIGNvbW1pdCBqdXN0IG1vdmVz
IHRoZSBjb2RlIGluIHRoZSBjb250ZXh0DQo+PiB3aXRob3V0IGNoYW5naW5nIHRoZSBsb2dp
YyBvZiBDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCwgdGhpcyB3YXMNCj4+IGludHJv
ZHVjZWQgYmVmb3JlLg0KPj4NCj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ciBQYXZsdSA8
cGV0ci5wYXZsdUBzdXNlLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBkcml2ZXJzL3hlbi9ncmFu
dC1kbWEtb3BzLmMgfCA0ICsrKy0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94
ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+Pj4g
aW5kZXggNzZmNmYyNjI2NWEzLi4yOWVkMjdhYzQ1MGUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJp
dmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+Pj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQt
ZG1hLW9wcy5jDQo+Pj4gQEAgLTM2Miw3ICszNjIsOSBAQCBzdGF0aWMgaW50IHhlbl9ncmFu
dF9pbml0X2JhY2tlbmRfZG9taWQoc3RydWN0IGRldmljZSAqZGV2LA0KPj4+ICAgIAlpZiAo
bnApIHsNCj4+PiAgICAJCXJldCA9IHhlbl9kdF9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQo
ZGV2LCBucCwgYmFja2VuZF9kb21pZCk7DQo+Pj4gICAgCQlvZl9ub2RlX3B1dChucCk7DQo+
Pj4gLQl9IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JB
TlQpIHx8IHhlbl9wdl9kb21haW4oKSkgew0KPj4+ICsJfSBlbHNlIGlmICgoSVNfRU5BQkxF
RChDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCkgfHwNCj4+PiArCQkgICAgeGVuX3B2
X2RvbWFpbigpKSAmJg0KPj4+ICsJCSAgICF4ZW5faW5pdGlhbF9kb21haW4oKSkgew0KPj4N
Cj4+IFRoZSBjb21taXQgbGd0bSwganVzdCBvbmUgbm90ZToNCj4+DQo+Pg0KPj4gSSB3b3Vs
ZCBldmVuIGJhaWwgb3V0IGVhcmx5IGluIHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNj
KCkgaW5zdGVhZCwNCj4+IGFzIEkgYXNzdW1lIHRoZSBzYW1lIGlzc3VlIGNvdWxkIGhhcHBl
biBvbiBBcm0gd2l0aCBEVCAoYWx0aG91Z2ggdGhlcmUNCj4+IHdlIGRvbid0IGd1ZXNzIHRo
ZSBiYWNrZW5kJ3MgZG9taWQsIHdlIHJlYWQgaXQgZnJvbSBEVCBhbmQgcXVpdGUNCj4+IHVu
bGlrZWx5IHdlIGdldCBEb20wIGJlaW5nIGluIERvbTAgd2l0aCBjb3JyZWN0IERUKS4NCj4+
DQo+PiBTb21ldGhpbmcgbGlrZToNCj4+DQo+PiBAQCAtNDE2LDYgKzQyMSwxMCBAQCBib29s
IHhlbl92aXJ0aW9fcmVzdHJpY3RlZF9tZW1fYWNjKHN0cnVjdA0KPj4gdmlydGlvX2Rldmlj
ZSAqZGV2KQ0KPj4gICAgew0KPj4gICAgICAgICAgIGRvbWlkX3QgYmFja2VuZF9kb21pZDsN
Cj4+DQo+PiArICAgICAgIC8qIFhlbiBncmFudCBETUEgb3BzIGFyZSBub3QgdXNlZCB3aGVu
IHJ1bm5pbmcgYXMgaW5pdGlhbCBkb21haW4gKi8NCj4+ICsgICAgICAgaWYgKHhlbl9pbml0
aWFsX2RvbWFpbigpKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsN
Cj4+ICAgICAgICAgICBpZiAoIXhlbl9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoZGV2LT5k
ZXYucGFyZW50LA0KPj4gJmJhY2tlbmRfZG9taWQpKSB7DQo+PiAgICAgICAgICAgICAgICAg
ICB4ZW5fZ3JhbnRfc2V0dXBfZG1hX29wcyhkZXYtPmRldi5wYXJlbnQsIGJhY2tlbmRfZG9t
aWQpOw0KPj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAoRU5EKQ0KPj4N
Cj4+DQo+Pg0KPj4gSWYgc28sIHRoYXQgY29tbWl0IHN1YmplY3Qgd291bGQgbmVlZCB0byBi
ZSB1cGRhdGVkIGFjY29yZGluZ2x5Lg0KPj4NCj4+IExldCdzIHNlZSB3aGF0IG90aGVyIHJl
dmlld2VycyB3aWxsIHNheS4NCj4gDQo+IFRoaXMgZG9lc24ndCB3b3JrIGluIGFsbCBjYXNl
cy4gSW1hZ2luZSB1c2luZyBQQ0kgUGFzc3Rocm91Z2ggdG8gYXNzaWduDQo+IGEgInBoeXNp
Y2FsIiB2aXJ0aW8gZGV2aWNlIHRvIGEgZG9tVS4gVGhlIGRvbVUgd2lsbCBydW4gaW50byB0
aGUgc2FtZQ0KPiBlcnJvciwgcmlnaHQ/DQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdl
IG5lZWQgYSB3YXkgZm9yIHRoZSB2aXJ0aW8gYmFja2VuZCB0byBhZHZlcnRpc2UNCj4gaXRz
IGFiaWxpdHkgb2YgaGFuZGxpbmcgZ3JhbnRzLiBSaWdodCBub3cgd2Ugb25seSBoYXZlIGEg
d2F5IHRvIGRvIHdpdGgNCj4gdGhhdCB3aXRoIGRldmljZSB0cmVlIG9uIEFSTS4gT24geDg2
LCB3ZSBvbmx5IGhhdmUNCj4gQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQsIGFuZCBp
ZiB3ZSB0YWtlDQo+IENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dSQU5UIGF0IGZhY2UgdmFs
dWUsIGl0IGFsc28gZW5hYmxlcyBncmFudHMgZm9yDQo+ICJwaHlzaWNhbCIgdmlydGlvIGRl
dmljZXMuIE5vdGUgdGhhdCBpbiB0aGlzIGNhc2Ugd2UgYXJlIGZpeGluZyBhDQo+IG5lc3Rl
ZC12aXJ0dWFsaXphdGlvbiBidWcsIGJ1dCB0aGVyZSBhcmUgYWN0dWFsbHkgcGh5c2ljYWwN
Cj4gdmlydGlvLWNvbXBhdGlibGUgZGV2aWNlcyBvdXQgdGhlcmUuIENPTkZJR19YRU5fVklS
VElPX0ZPUkNFX0dSQU5UIHdpbGwNCj4gYnJlYWsgdGhvc2UgdG9vLg0KDQpJbiBjYXNlIHlv
dSB3YW50IHZpcnRpbyBkZXZpY2UgcGFzc3Rocm91Z2gsIHlvdSBzaG91bGRuJ3QgdXNlIGEg
a2VybmVsDQpidWlsdCB3aXRoIENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dSQU5ULg0KDQpB
bmQgc3VwcG9ydGluZyBwYXNzaW5nIHRocm91Z2ggdmlydGlvIGRldmljZXMgb2YgdGhlIGhv
c3QgdG8gcHYtZG9tVXMgaXMNCmEgc2VjdXJpdHkgcmlzayBhbnl3YXkuDQoNCldlIF9jb3Vs
ZF8gZHJvcCB0aGUgcmVxdWlyZW1lbnQgb2YgdGhlIGJhY2tlbmQgbmVlZGluZyB0byBzZXQN
ClZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBmb3IgUFYgZ3Vlc3RzIGFuZCBhbGxvdyBncmFu
dC1sZXNzIHZpcnRpbw0KaGFuZGxpbmcgZm9yIGFsbCBndWVzdHMuIEZvciB0aGlzIHRvIHdv
cmsgeGVuX3ZpcnRpb19yZXN0cmljdGVkX21lbV9hY2MoKQ0Kd291bGQgbmVlZCB0byBjaGVj
ayBmb3IgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGFuZCByZXR1cm4gdHJ1ZSBpZiBzZXQu
DQpNYXliZSB3ZSdkIHdhbnQgdG8gZW5hYmxlIHRoYXQgcG9zc2liaWxpdHkgdmlhIGEgYm9v
dCBwYXJhbWV0ZXI/DQoNCg0KSnVlcmdlbg0K
--------------IZPK5gmaQ5zbpEG6t0uvm0MA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------IZPK5gmaQ5zbpEG6t0uvm0MA--

--------------ztc028cfnLYtqIaXIzboLI09--

--------------oFLmLR3jxUNfFSepkKTBAW4N
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSnuOcFAwAAAAAACgkQsN6d1ii/Ey/X
8Af+NwPpz0TB3BM1z5Djv0L7plCw3hMXblF/noHfYWfPB22y0jQ7088bwHnCXHGL8nK/2uhttXlQ
fdBYuMX43o0c8pDbLdnSmRr2q55GUG0/30Ej6NoSocxVVjt5vbvXjzxrsA5w4CWI2y4YNzfsknc/
avK33PlfZnsVyfLYG6QTKhfQdiWZel394vy2uaBsw1r7k/gXPXZDOXBqL6VI3bc7m446bp5/MNFA
MiLYFAAsmmo3O91dS4hkV5rzvkjUDJmhGVbbH2p2FrvXZkTBGqBm8ZHHGyY/1U4Bua/uKrvyZBlZ
pKvJLWViGPiuH1gMRR+FTDgCNMx3lYEFDioav7Smng==
=/3nz
-----END PGP SIGNATURE-----

--------------oFLmLR3jxUNfFSepkKTBAW4N--
