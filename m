Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12E574BD4A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGHKyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 06:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 06:54:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA91994
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 03:54:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BFEE1F37E;
        Sat,  8 Jul 2023 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688813673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HxLicN1rT/Su3jbILv79MhV7rGLRLfJ+PIxlmM6KDyE=;
        b=Xs8r3g6LwCd1Uts4P25ZCzKABzY5FOmQHGC1XN9/Pa4l4Z/YWOLXMO3Ms2hKydnOooNcDG
        CLHC5Fl7lpcRt3yWT972SotIZIxwQzVcl0ANM2RWGyFHYFmhqupop2Ozp9MVuu6ATLE1OY
        AwGHGfsCx1bihG9WOulzIOxtCqsKBBA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDE00134BA;
        Sat,  8 Jul 2023 10:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GMMXOGhAqWTePgAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 08 Jul 2023 10:54:32 +0000
Message-ID: <bd194479-3799-58cb-7e4a-8619818cd03a@suse.com>
Date:   Sat, 8 Jul 2023 12:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>
 <41893db4-cd66-a9f7-ffe5-d90fffb43657@suse.com>
 <alpine.DEB.2.22.394.2307071351530.761183@ubuntu-linux-20-04-desktop>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <alpine.DEB.2.22.394.2307071351530.761183@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ylu0Ea877tbUcsC0rz2xMXGX"
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
--------------Ylu0Ea877tbUcsC0rz2xMXGX
Content-Type: multipart/mixed; boundary="------------MuHoh4bB3Z5967cGl5AyCaV8";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <bd194479-3799-58cb-7e4a-8619818cd03a@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>
 <41893db4-cd66-a9f7-ffe5-d90fffb43657@suse.com>
 <alpine.DEB.2.22.394.2307071351530.761183@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2307071351530.761183@ubuntu-linux-20-04-desktop>

--------------MuHoh4bB3Z5967cGl5AyCaV8
Content-Type: multipart/mixed; boundary="------------cBzbmcZKbZtOhYVPg88sWULc"

--------------cBzbmcZKbZtOhYVPg88sWULc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDcuMjMgMjM6MDIsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gRnJp
LCA3IEp1bCAyMDIzLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMjYuMDYuMjMgMTU6
MTcsIFBldHIgUGF2bHUgd3JvdGU6DQo+Pj4gT24gNi8yMS8yMyAxOTo1OCwgT2xla3NhbmRy
IFR5c2hjaGVua28gd3JvdGU6DQo+Pj4+IE9uIDIxLjA2LjIzIDE2OjEyLCBQZXRyIFBhdmx1
IHdyb3RlOg0KPj4+Pj4gV2hlbiBhdHRlbXB0aW5nIHRvIHJ1biBYZW4gb24gYSBRRU1VL0tW
TSB2aXJ0dWFsIG1hY2hpbmUgd2l0aCB2aXJ0aW8NCj4+Pj4+IGRldmljZXMgKGFsbCB4ODZf
NjQpLCBkb20wIHRyaWVzIHRvIGVzdGFibGlzaCBhIGdyYW50IGZvciBpdHNlbGYgd2hpY2gN
Cj4+Pj4+IGV2ZW50dWFsbHkgcmVzdWx0cyBpbiBhIGhhbmcgZHVyaW5nIHRoZSBib290Lg0K
Pj4+Pj4NCj4+Pj4+IFRoZSBiYWNrdHJhY2UgbG9va3MgYXMgZm9sbG93cywgdGhlIHdoaWxl
IGxvb3AgaW4gX19zZW5kX2NvbnRyb2xfbXNnKCkNCj4+Pj4+IG1ha2VzIG5vIHByb2dyZXNz
Og0KPj4+Pj4NCj4+Pj4+ICAgICAgIzAgIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eCAoX3ZxPV92
cUBlbnRyeT0weGZmZmY4ODgwMDc0YTg0MDAsDQo+Pj4+PiBsZW49bGVuQGVudHJ5PTB4ZmZm
ZmM5MDAwMDQxM2M5NCwgY3R4PWN0eEBlbnRyeT0weDAgPGZpeGVkX3BlcmNwdV9kYXRhPikN
Cj4+Pj4+IGF0IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjMyNg0KPj4+Pj4g
ICAgICAjMSAgMHhmZmZmZmZmZjgxNzA4NmI3IGluIHZpcnRxdWV1ZV9nZXRfYnVmDQo+Pj4+
PiAoX3ZxPV92cUBlbnRyeT0weGZmZmY4ODgwMDc0YTg0MDAsIGxlbj1sZW5AZW50cnk9MHhm
ZmZmYzkwMDAwNDEzYzk0KSBhdA0KPj4+Pj4gLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYzoyMzMzDQo+Pj4+PiAgICAgICMyICAweGZmZmZmZmZmODE3NWY2YjIgaW4gX19zZW5k
X2NvbnRyb2xfbXNnIChwb3J0ZGV2PTxvcHRpbWl6ZWQNCj4+Pj4+IG91dD4sIHBvcnRfaWQ9
MHhmZmZmZmZmZiwgZXZlbnQ9MHgwLCB2YWx1ZT0weDEpIGF0DQo+Pj4+PiAuLi9kcml2ZXJz
L2NoYXIvdmlydGlvX2NvbnNvbGUuYzo1NjINCj4+Pj4+ICAgICAgIzMgIDB4ZmZmZmZmZmY4
MTc1ZjZlZSBpbiBfX3NlbmRfY29udHJvbF9tc2cgKHBvcnRkZXY9PG9wdGltaXplZA0KPj4+
Pj4gb3V0PiwgcG9ydF9pZD08b3B0aW1pemVkIG91dD4sIGV2ZW50PTxvcHRpbWl6ZWQgb3V0
PiwgdmFsdWU9PG9wdGltaXplZA0KPj4+Pj4gb3V0PikgYXQgLi4vZHJpdmVycy9jaGFyL3Zp
cnRpb19jb25zb2xlLmM6NTY5DQo+Pj4+PiAgICAgICM0ICAweGZmZmZmZmZmODE3NjE4YjEg
aW4gdmlydGNvbnNfcHJvYmUgKHZkZXY9MHhmZmZmODg4MDA1ODVlODAwKQ0KPj4+Pj4gYXQg
Li4vZHJpdmVycy9jaGFyL3ZpcnRpb19jb25zb2xlLmM6MjA5OA0KPj4+Pj4gICAgICAjNSAg
MHhmZmZmZmZmZjgxNzA3MTE3IGluIHZpcnRpb19kZXZfcHJvYmUgKF9kPTB4ZmZmZjg4ODAw
NTg1ZTgxMCkNCj4+Pj4+IGF0IC4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpby5jOjMwNQ0KPj4+
Pj4gICAgICAjNiAgMHhmZmZmZmZmZjgxOThlMzQ4IGluIGNhbGxfZHJpdmVyX3Byb2JlIChk
cnY9MHhmZmZmZmZmZjgyYmU0MGMwDQo+Pj4+PiA8dmlydGlvX2NvbnNvbGU+LCBkcnY9MHhm
ZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4sDQo+Pj4+PiBkZXY9MHhmZmZmODg4
MDA1ODVlODEwKSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzo1NzkNCj4+Pj4+ICAgICAgIzcg
IHJlYWxseV9wcm9iZSAoZGV2PWRldkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTAsDQo+Pj4+
PiBkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBh
dA0KPj4+Pj4gLi4vZHJpdmVycy9iYXNlL2RkLmM6NjU4DQo+Pj4+PiAgICAgICM4ICAweGZm
ZmZmZmZmODE5OGU1OGYgaW4gX19kcml2ZXJfcHJvYmVfZGV2aWNlDQo+Pj4+PiAoZHJ2PWRy
dkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwNCj4+Pj4+IGRl
dj1kZXZAZW50cnk9MHhmZmZmODg4MDA1ODVlODEwKSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQu
Yzo4MDANCj4+Pj4+ICAgICAgIzkgIDB4ZmZmZmZmZmY4MTk4ZTY1YSBpbiBkcml2ZXJfcHJv
YmVfZGV2aWNlDQo+Pj4+PiAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZp
cnRpb19jb25zb2xlPiwNCj4+Pj4+IGRldj1kZXZAZW50cnk9MHhmZmZmODg4MDA1ODVlODEw
KSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzo4MzANCj4+Pj4+ICAgICAgIzEwIDB4ZmZmZmZm
ZmY4MTk4ZTgzMiBpbiBfX2RyaXZlcl9hdHRhY2ggKGRldj0weGZmZmY4ODgwMDU4NWU4MTAs
DQo+Pj4+PiBkYXRhPTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdCAu
Li9kcml2ZXJzL2Jhc2UvZGQuYzoxMjE2DQo+Pj4+PiAgICAgICMxMSAweGZmZmZmZmZmODE5
OGJmYjIgaW4gYnVzX2Zvcl9lYWNoX2RldiAoYnVzPTxvcHRpbWl6ZWQgb3V0PiwNCj4+Pj4+
IHN0YXJ0PXN0YXJ0QGVudHJ5PTB4MCA8Zml4ZWRfcGVyY3B1X2RhdGE+LA0KPj4+Pj4gZGF0
YT1kYXRhQGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LA0KPj4+
Pj4gICAgICAgICAgZm49Zm5AZW50cnk9MHhmZmZmZmZmZjgxOThlN2IwIDxfX2RyaXZlcl9h
dHRhY2g+KSBhdA0KPj4+Pj4gLi4vZHJpdmVycy9iYXNlL2J1cy5jOjM2OA0KPj4+Pj4gICAg
ICAjMTIgMHhmZmZmZmZmZjgxOThkYjY1IGluIGRyaXZlcl9hdHRhY2gNCj4+Pj4+IChkcnY9
ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdA0KPj4+
Pj4gLi4vZHJpdmVycy9iYXNlL2RkLmM6MTIzMw0KPj4+Pj4gICAgICAjMTMgMHhmZmZmZmZm
ZjgxOThkMjA3IGluIGJ1c19hZGRfZHJpdmVyDQo+Pj4+PiAoZHJ2PWRydkBlbnRyeT0weGZm
ZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQNCj4+Pj4+IC4uL2RyaXZlcnMv
YmFzZS9idXMuYzo2NzMNCj4+Pj4+ICAgICAgIzE0IDB4ZmZmZmZmZmY4MTk4ZjU1MCBpbiBk
cml2ZXJfcmVnaXN0ZXINCj4+Pj4+IChkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBj
MCA8dmlydGlvX2NvbnNvbGU+KSBhdA0KPj4+Pj4gLi4vZHJpdmVycy9iYXNlL2RyaXZlci5j
OjI0Ng0KPj4+Pj4gICAgICAjMTUgMHhmZmZmZmZmZjgxNzA2YjQ3IGluIHJlZ2lzdGVyX3Zp
cnRpb19kcml2ZXINCj4+Pj4+IChkcml2ZXI9ZHJpdmVyQGVudHJ5PTB4ZmZmZmZmZmY4MmJl
NDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdA0KPj4+Pj4gLi4vZHJpdmVycy92aXJ0aW8vdmly
dGlvLmM6MzU3DQo+Pj4+PiAgICAgICMxNiAweGZmZmZmZmZmODMyY2QzNGIgaW4gdmlydGlv
X2NvbnNvbGVfaW5pdCAoKSBhdA0KPj4+Pj4gLi4vZHJpdmVycy9jaGFyL3ZpcnRpb19jb25z
b2xlLmM6MjI1OA0KPj4+Pj4gICAgICAjMTcgMHhmZmZmZmZmZjgxMDAxMDVjIGluIGRvX29u
ZV9pbml0Y2FsbCAoZm49MHhmZmZmZmZmZjgzMmNkMmUwDQo+Pj4+PiA8dmlydGlvX2NvbnNv
bGVfaW5pdD4pIGF0IC4uL2luaXQvbWFpbi5jOjEyNDYNCj4+Pj4+ICAgICAgIzE4IDB4ZmZm
ZmZmZmY4MzI3NzI5MyBpbiBkb19pbml0Y2FsbF9sZXZlbA0KPj4+Pj4gKGNvbW1hbmRfbGlu
ZT0weGZmZmY4ODgwMDNlMmY5MDAgInJvb3QiLCBsZXZlbD0weDYpIGF0DQo+Pj4+PiAuLi9p
bml0L21haW4uYzoxMzE5DQo+Pj4+PiAgICAgICMxOSBkb19pbml0Y2FsbHMgKCkgYXQgLi4v
aW5pdC9tYWluLmM6MTMzNQ0KPj4+Pj4gICAgICAjMjAgZG9fYmFzaWNfc2V0dXAgKCkgYXQg
Li4vaW5pdC9tYWluLmM6MTM1NA0KPj4+Pj4gICAgICAjMjEga2VybmVsX2luaXRfZnJlZWFi
bGUgKCkgYXQgLi4vaW5pdC9tYWluLmM6MTU3MQ0KPj4+Pj4gICAgICAjMjIgMHhmZmZmZmZm
ZjgxZjY0YmUxIGluIGtlcm5lbF9pbml0ICh1bnVzZWQ9PG9wdGltaXplZCBvdXQ+KSBhdA0K
Pj4+Pj4gLi4vaW5pdC9tYWluLmM6MTQ2Mg0KPj4+Pj4gICAgICAjMjMgMHhmZmZmZmZmZjgx
MDAxZjQ5IGluIHJldF9mcm9tX2ZvcmsgKCkgYXQNCj4+Pj4+IC4uL2FyY2gveDg2L2VudHJ5
L2VudHJ5XzY0LlM6MzA4DQo+Pj4+PiAgICAgICMyNCAweDAwMDAwMDAwMDAwMDAwMDAgaW4g
Pz8gKCkNCj4+Pj4+DQo+Pj4+PiBGaXggdGhlIHByb2JsZW0gYnkgcHJldmVudGluZyB4ZW5f
Z3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlkKCkgZnJvbQ0KPj4+Pj4gc2V0dGluZyBkb20wIGFz
IGEgYmFja2VuZCB3aGVuIHJ1bm5pbmcgaW4gZG9tMC4NCj4+Pj4+DQo+Pj4+PiBGaXhlczog
MDM1ZTNhNDMyMWY3ICgieGVuL3ZpcnRpbzogT3B0aW1pemUgdGhlIHNldHVwIG9mICJ4ZW4t
Z3JhbnQtZG1hIg0KPj4+Pj4gZGV2aWNlcyIpDQo+Pj4+DQo+Pj4+DQo+Pj4+IEkgYW0gbm90
IDEwMCUgc3VyZSB3aGV0aGVyIHRoZSBGaXhlcyB0YWcgcG9pbnRzIHRvIHByZWNpc2UgY29t
bWl0LiBJZiBJDQo+Pj4+IGFtIG5vdCBtaXN0YWtlbiwgdGhlIHNhaWQgY29tbWl0IGp1c3Qg
bW92ZXMgdGhlIGNvZGUgaW4gdGhlIGNvbnRleHQNCj4+Pj4gd2l0aG91dCBjaGFuZ2luZyB0
aGUgbG9naWMgb2YgQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQsIHRoaXMgd2FzDQo+
Pj4+IGludHJvZHVjZWQgYmVmb3JlLg0KPj4+DQo+Pj4gSSBzZWUsIHRoZSB0YWcgc2hvdWxk
IGJldHRlciBwb2ludCB0byA3MjI4MTEzZDFmYTAgKCJ4ZW4vdmlydGlvOiB1c2UNCj4+PiBk
b20wIGFzIGRlZmF1bHQgYmFja2VuZCBmb3IgQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JB
TlQiKSB3aGljaA0KPj4+IGludHJvZHVjZWQgdGhlIG9yaWdpbmFsIGxvZ2ljIHRvIHVzZSBk
b20wIGFzIGJhY2tlbmQuDQo+Pj4NCj4+PiBDb21taXQgMDM1ZTNhNDMyMWY3ICgieGVuL3Zp
cnRpbzogT3B0aW1pemUgdGhlIHNldHVwIG9mICJ4ZW4tZ3JhbnQtZG1hIg0KPj4+IGRldmlj
ZXMiKSBpcyByZWxldmFudCBpbiBzZW5zZSB0aGF0IGl0IGV4dGVuZGVkIHdoZW4gdGhpcyBs
b2dpYyBpcw0KPj4+IGFjdGl2ZSBieSBhZGRpbmcgYW4gT1IgY2hlY2sgZm9yIHhlbl9wdl9k
b21haW4oKS4NCj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ciBQ
YXZsdSA8cGV0ci5wYXZsdUBzdXNlLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAgIGRyaXZl
cnMveGVuL2dyYW50LWRtYS1vcHMuYyB8IDQgKysrLQ0KPj4+Pj4gICAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+DQo+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3Jh
bnQtZG1hLW9wcy5jDQo+Pj4+PiBpbmRleCA3NmY2ZjI2MjY1YTMuLjI5ZWQyN2FjNDUwZSAx
MDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4+Pj4g
KysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+Pj4+PiBAQCAtMzYyLDcgKzM2
Miw5IEBAIHN0YXRpYyBpbnQgeGVuX2dyYW50X2luaXRfYmFja2VuZF9kb21pZChzdHJ1Y3QN
Cj4+Pj4+IGRldmljZSAqZGV2LA0KPj4+Pj4gICAgIAlpZiAobnApIHsNCj4+Pj4+ICAgICAJ
CXJldCA9IHhlbl9kdF9ncmFudF9pbml0X2JhY2tlbmRfZG9taWQoZGV2LCBucCwNCj4+Pj4+
IGJhY2tlbmRfZG9taWQpOw0KPj4+Pj4gICAgIAkJb2Zfbm9kZV9wdXQobnApOw0KPj4+Pj4g
LQl9IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQp
IHx8DQo+Pj4+PiB4ZW5fcHZfZG9tYWluKCkpIHsNCj4+Pj4+ICsJfSBlbHNlIGlmICgoSVNf
RU5BQkxFRChDT05GSUdfWEVOX1ZJUlRJT19GT1JDRV9HUkFOVCkgfHwNCj4+Pj4+ICsJCSAg
ICB4ZW5fcHZfZG9tYWluKCkpICYmDQo+Pj4+PiArCQkgICAheGVuX2luaXRpYWxfZG9tYWlu
KCkpIHsNCj4+Pj4NCj4+Pj4gVGhlIGNvbW1pdCBsZ3RtLCBqdXN0IG9uZSBub3RlOg0KPj4+
Pg0KPj4+Pg0KPj4+PiBJIHdvdWxkIGV2ZW4gYmFpbCBvdXQgZWFybHkgaW4geGVuX3ZpcnRp
b19yZXN0cmljdGVkX21lbV9hY2MoKSBpbnN0ZWFkLA0KPj4+PiBhcyBJIGFzc3VtZSB0aGUg
c2FtZSBpc3N1ZSBjb3VsZCBoYXBwZW4gb24gQXJtIHdpdGggRFQgKGFsdGhvdWdoIHRoZXJl
DQo+Pj4+IHdlIGRvbid0IGd1ZXNzIHRoZSBiYWNrZW5kJ3MgZG9taWQsIHdlIHJlYWQgaXQg
ZnJvbSBEVCBhbmQgcXVpdGUNCj4+Pj4gdW5saWtlbHkgd2UgZ2V0IERvbTAgYmVpbmcgaW4g
RG9tMCB3aXRoIGNvcnJlY3QgRFQpLg0KPj4+Pg0KPj4+PiBTb21ldGhpbmcgbGlrZToNCj4+
Pj4NCj4+Pj4gQEAgLTQxNiw2ICs0MjEsMTAgQEAgYm9vbCB4ZW5fdmlydGlvX3Jlc3RyaWN0
ZWRfbWVtX2FjYyhzdHJ1Y3QNCj4+Pj4gdmlydGlvX2RldmljZSAqZGV2KQ0KPj4+PiAgICAg
ew0KPj4+PiAgICAgICAgICAgIGRvbWlkX3QgYmFja2VuZF9kb21pZDsNCj4+Pj4NCj4+Pj4g
KyAgICAgICAvKiBYZW4gZ3JhbnQgRE1BIG9wcyBhcmUgbm90IHVzZWQgd2hlbiBydW5uaW5n
IGFzIGluaXRpYWwgZG9tYWluDQo+Pj4+ICovDQo+Pj4+ICsgICAgICAgaWYgKHhlbl9pbml0
aWFsX2RvbWFpbigpKQ0KPj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+
PiArDQo+Pj4+ICAgICAgICAgICAgaWYgKCF4ZW5fZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlk
KGRldi0+ZGV2LnBhcmVudCwNCj4+Pj4gJmJhY2tlbmRfZG9taWQpKSB7DQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICB4ZW5fZ3JhbnRfc2V0dXBfZG1hX29wcyhkZXYtPmRldi5wYXJlbnQs
IGJhY2tlbmRfZG9taWQpOw0KPj4+PiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7
DQo+Pj4+IChFTkQpDQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IElmIHNvLCB0aGF0IGNvbW1p
dCBzdWJqZWN0IHdvdWxkIG5lZWQgdG8gYmUgdXBkYXRlZCBhY2NvcmRpbmdseS4NCj4+Pj4N
Cj4+Pj4gTGV0J3Mgc2VlIHdoYXQgb3RoZXIgcmV2aWV3ZXJzIHdpbGwgc2F5Lg0KPj4+DQo+
Pj4gT2ssIG1ha2VzIHNlbnNlLg0KPj4NCj4+IEkgdGhpbmsgdGhpcyBpcyBva2F5IGZvciBh
IGZpeCBvZiB0aGUgY3VycmVudCBwcm9ibGVtLg0KPj4NCj4+IFBhc3NpbmcgdGhyb3VnaCB2
aXJ0aW8gZGV2aWNlcyB0byBhIFBWIGRvbVUgaXMgbm90IGNvdmVyZWQgYnkgdGhpcyBmaXgs
IGJ1dA0KPj4gdGhpcw0KPj4gc2hvdWxkIGJlIGEgcmF0aGVyIHJhcmUgY29uZmlndXJhdGlv
biwgd2hpY2ggZG9lc24ndCB3b3JrIHRvZGF5IGVpdGhlci4gU28gdGhlDQo+PiBzdWdnZXN0
ZWQgcGF0Y2ggd291bGQgZml4IHRoZSBjdXJyZW50IGlzc3VlIHdpdGhvdXQgaW50cm9kdWNp
bmcgYSByZWdyZXNzaW9uLg0KPj4NCj4+IEFueXRoaW5nIGVsc2UgY2FuIGJlIGRvbmUgbGF0
ZXIuDQo+IA0KPiBXaHkgZG8geW91IHNheSB0aGF0IHBhc3NpbmcgdGhyb3VnaCB2aXJ0aW8g
ZGV2aWNlcyB0byBhIFBWIGRvbVUgZG9lc24ndA0KPiB3b3JrIHRvZGF5IGFueXdheT8gQWxz
bywgYXMgeW91IGtub3cgbWFueSBwZW9wbGUgdXNlIFhlbiBvdXRzaWRlIG9mDQo+IGRhdGFj
ZW50ZXIgZGVwbG95bWVudHMgKGxhcHRvcHMsIGVtYmVkZGVkIGV0Yy4pIHdoZXJlIGRyaXZl
cnMgZG9tYWlucw0KPiBhbmQgZGV2aWNlIGFzc2lnbm1lbnQgYXJlIHZlcnkgY29tbW9uLiBZ
b3UgY291bGQgYXNzaWduIGEgdmlydGlvIG5ldHdvcmsNCj4gY2FyZCB0byBhIGRvbVUgYW5k
IHVzZSBQViBuZXR3b3JrIHRvIHNoYXJlIHRoZSBuZXR3b3JrIHdpdGggb3RoZXINCj4gZ3Vl
c3RzLiBQaHlzaWNhbCB2aXJ0aW8gZGV2aWNlcywgZXNwZWNpYWxseSB2aXJ0aW8tbmV0IGRl
dmljZXMsIGV4aXN0LiBJDQo+IGNvdWxkIHByb2JhYmx5IHJlcHJvIHRoaXMgcHJvYmxlbSB0
b2RheSBpbiBhIGRvbVUganVzdCBpbnN0YWxsaW5nDQo+IFF1YmVzT1MgaW5zaWRlIFFFTVUu
IFF1YmVzT1MgdXNlcyBuZXR3b3JrIGRyaXZlciBkb21haW5zIGFuZCBpZiBRRU1VDQo+IHBy
b3ZpZGVzIGEgdmlydGlvLW5ldCBuZXR3b3JrIGNhcmQsIHRoaXMgd291bGQgYnJlYWsgZXZl
biB3aXRoIHRoaXMNCj4gcGF0Y2guDQoNCkkgbWlnaHQgYmUgd3JvbmcsIGJ1dCBJIGRvbid0
IHRoaW5rIGFsbCB2aXJ0aW8gZnJvbnRlbmRzIHdpbGwgd29yayBpbiB0aGF0DQpzY2VuYXJp
by4gVGhlIG1haW4gcmVhc29uIGlzIHRoZSBQRk4vTUZOIGRpZmZlcmVuY2U6IGEgZnJvbnRl
bmQgdXNpbmcgZ3Vlc3QNCmNvbnNlY3V0aXZlIG1lbW9yeSBmb3IgZG9pbmcgbGFyZ2UgSS9P
cyB3aWxsIGZhaWwgbWlzZXJhYmx5LiBUaGlzIHdhcyB0aGUNCm1haW4gcmVhc29uIHdoeSBJ
IGhhZCB0byBhZGQgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgY29uc2VjdXRpdmUgZ3JhbnRzIGZv
cg0KbGFyZ2UgSS9PIGJ1ZmZlcnMuIFRoZSBzYW1lIGdvZXMgZm9yIG11bHRpLXBhZ2Ugdmly
dGlvIHJpbmcgcGFnZXMuDQoNCg0KSnVlcmdlbg0K
--------------cBzbmcZKbZtOhYVPg88sWULc
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------cBzbmcZKbZtOhYVPg88sWULc--

--------------MuHoh4bB3Z5967cGl5AyCaV8--

--------------Ylu0Ea877tbUcsC0rz2xMXGX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSpQGgFAwAAAAAACgkQsN6d1ii/Ey8R
dAgAn47nMBuqYqQzHsT1q5Tx8a9QsoYx6IwjqZ06IrE7FopxaXueWEOiBlhyzhCpedSMnH9lmuzH
ku6BecBHOn5oXGhpakNgZzuvTi8nynniQ4J4vm/LJh9HJw9pFqE2Zd56LHAGBceKiSH9BlqmoQIP
OcCPl38LMRiEOezZ0YrVEqTftW8/eVplxYNhMjWYR3P60ZwC/NbrbNHUMeudKp6rMkla5e6CdrQP
nNSv2sXq/X2WWDV/D38NhfHXBu/rEbyAhRbiR9YQPF++eaG67XhM4u9zRjYvXgogGUP65oelhTCW
MhNHeQQXGclsrRrqFYBa+WbgDr2L8NLW5v/2LQTkeQ==
=yF+l
-----END PGP SIGNATURE-----

--------------Ylu0Ea877tbUcsC0rz2xMXGX--
