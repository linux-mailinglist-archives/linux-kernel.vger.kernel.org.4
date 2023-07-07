Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E074AC36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjGGHrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGGHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:46:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D72736
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:46:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4F7D2279E;
        Fri,  7 Jul 2023 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688715973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Re48nnOP0rFJY+QyAtu3fiiB+DcqHGLNZij0w9041jg=;
        b=Vk8X8JKQWvKzzwnC9tk/h0Q2XXpt38rCNxYdW5Vqil2BMXlxcFXxyaKLRmNm2hg34UZDha
        vmmkmyp4ZLP23NAraiS6B/mbuOYReaUUOhXGVNePrlrk36OopdUEGvfF+llkJLPUfil7hi
        85TKv4hD4db0aOPKfzqr2I2DQxV/LoM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3FEC139E0;
        Fri,  7 Jul 2023 07:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BaiHJsXCp2QXJgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Jul 2023 07:46:13 +0000
Message-ID: <41893db4-cd66-a9f7-ffe5-d90fffb43657@suse.com>
Date:   Fri, 7 Jul 2023 09:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
In-Reply-To: <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jsXObnkNlf6I7A7Qe8ky0cRd"
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
--------------jsXObnkNlf6I7A7Qe8ky0cRd
Content-Type: multipart/mixed; boundary="------------9cgHzfhZcItFHAZOQ0DMtqQ7";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>
Message-ID: <41893db4-cd66-a9f7-ffe5-d90fffb43657@suse.com>
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>
In-Reply-To: <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>

--------------9cgHzfhZcItFHAZOQ0DMtqQ7
Content-Type: multipart/mixed; boundary="------------pU2zdqtIoiz6W8rchmw1TzCg"

--------------pU2zdqtIoiz6W8rchmw1TzCg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjYuMDYuMjMgMTU6MTcsIFBldHIgUGF2bHUgd3JvdGU6DQo+IE9uIDYvMjEvMjMgMTk6
NTgsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPj4gT24gMjEuMDYuMjMgMTY6MTIs
IFBldHIgUGF2bHUgd3JvdGU6DQo+Pj4gV2hlbiBhdHRlbXB0aW5nIHRvIHJ1biBYZW4gb24g
YSBRRU1VL0tWTSB2aXJ0dWFsIG1hY2hpbmUgd2l0aCB2aXJ0aW8NCj4+PiBkZXZpY2VzIChh
bGwgeDg2XzY0KSwgZG9tMCB0cmllcyB0byBlc3RhYmxpc2ggYSBncmFudCBmb3IgaXRzZWxm
IHdoaWNoDQo+Pj4gZXZlbnR1YWxseSByZXN1bHRzIGluIGEgaGFuZyBkdXJpbmcgdGhlIGJv
b3QuDQo+Pj4NCj4+PiBUaGUgYmFja3RyYWNlIGxvb2tzIGFzIGZvbGxvd3MsIHRoZSB3aGls
ZSBsb29wIGluIF9fc2VuZF9jb250cm9sX21zZygpDQo+Pj4gbWFrZXMgbm8gcHJvZ3Jlc3M6
DQo+Pj4NCj4+PiAgICAgIzAgIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eCAoX3ZxPV92cUBlbnRy
eT0weGZmZmY4ODgwMDc0YTg0MDAsIGxlbj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEzYzk0
LCBjdHg9Y3R4QGVudHJ5PTB4MCA8Zml4ZWRfcGVyY3B1X2RhdGE+KSBhdCAuLi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jOjIzMjYNCj4+PiAgICAgIzEgIDB4ZmZmZmZmZmY4MTcw
ODZiNyBpbiB2aXJ0cXVldWVfZ2V0X2J1ZiAoX3ZxPV92cUBlbnRyeT0weGZmZmY4ODgwMDc0
YTg0MDAsIGxlbj1sZW5AZW50cnk9MHhmZmZmYzkwMDAwNDEzYzk0KSBhdCAuLi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jOjIzMzMNCj4+PiAgICAgIzIgIDB4ZmZmZmZmZmY4MTc1
ZjZiMiBpbiBfX3NlbmRfY29udHJvbF9tc2cgKHBvcnRkZXY9PG9wdGltaXplZCBvdXQ+LCBw
b3J0X2lkPTB4ZmZmZmZmZmYsIGV2ZW50PTB4MCwgdmFsdWU9MHgxKSBhdCAuLi9kcml2ZXJz
L2NoYXIvdmlydGlvX2NvbnNvbGUuYzo1NjINCj4+PiAgICAgIzMgIDB4ZmZmZmZmZmY4MTc1
ZjZlZSBpbiBfX3NlbmRfY29udHJvbF9tc2cgKHBvcnRkZXY9PG9wdGltaXplZCBvdXQ+LCBw
b3J0X2lkPTxvcHRpbWl6ZWQgb3V0PiwgZXZlbnQ9PG9wdGltaXplZCBvdXQ+LCB2YWx1ZT08
b3B0aW1pemVkIG91dD4pIGF0IC4uL2RyaXZlcnMvY2hhci92aXJ0aW9fY29uc29sZS5jOjU2
OQ0KPj4+ICAgICAjNCAgMHhmZmZmZmZmZjgxNzYxOGIxIGluIHZpcnRjb25zX3Byb2JlICh2
ZGV2PTB4ZmZmZjg4ODAwNTg1ZTgwMCkgYXQgLi4vZHJpdmVycy9jaGFyL3ZpcnRpb19jb25z
b2xlLmM6MjA5OA0KPj4+ICAgICAjNSAgMHhmZmZmZmZmZjgxNzA3MTE3IGluIHZpcnRpb19k
ZXZfcHJvYmUgKF9kPTB4ZmZmZjg4ODAwNTg1ZTgxMCkgYXQgLi4vZHJpdmVycy92aXJ0aW8v
dmlydGlvLmM6MzA1DQo+Pj4gICAgICM2ICAweGZmZmZmZmZmODE5OGUzNDggaW4gY2FsbF9k
cml2ZXJfcHJvYmUgKGRydj0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPiwg
ZHJ2PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LCBkZXY9MHhmZmZmODg4
MDA1ODVlODEwKSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzo1NzkNCj4+PiAgICAgIzcgIHJl
YWxseV9wcm9iZSAoZGV2PWRldkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTAsIGRydj1kcnZA
ZW50cnk9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0IC4uL2RyaXZl
cnMvYmFzZS9kZC5jOjY1OA0KPj4+ICAgICAjOCAgMHhmZmZmZmZmZjgxOThlNThmIGluIF9f
ZHJpdmVyX3Byb2JlX2RldmljZSAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAg
PHZpcnRpb19jb25zb2xlPiwgZGV2PWRldkBlbnRyeT0weGZmZmY4ODgwMDU4NWU4MTApIGF0
IC4uL2RyaXZlcnMvYmFzZS9kZC5jOjgwMA0KPj4+ICAgICAjOSAgMHhmZmZmZmZmZjgxOThl
NjVhIGluIGRyaXZlcl9wcm9iZV9kZXZpY2UgKGRydj1kcnZAZW50cnk9MHhmZmZmZmZmZjgy
YmU0MGMwIDx2aXJ0aW9fY29uc29sZT4sIGRldj1kZXZAZW50cnk9MHhmZmZmODg4MDA1ODVl
ODEwKSBhdCAuLi9kcml2ZXJzL2Jhc2UvZGQuYzo4MzANCj4+PiAgICAgIzEwIDB4ZmZmZmZm
ZmY4MTk4ZTgzMiBpbiBfX2RyaXZlcl9hdHRhY2ggKGRldj0weGZmZmY4ODgwMDU4NWU4MTAs
IGRhdGE9MHhmZmZmZmZmZjgyYmU0MGMwIDx2aXJ0aW9fY29uc29sZT4pIGF0IC4uL2RyaXZl
cnMvYmFzZS9kZC5jOjEyMTYNCj4+PiAgICAgIzExIDB4ZmZmZmZmZmY4MTk4YmZiMiBpbiBi
dXNfZm9yX2VhY2hfZGV2IChidXM9PG9wdGltaXplZCBvdXQ+LCBzdGFydD1zdGFydEBlbnRy
eT0weDAgPGZpeGVkX3BlcmNwdV9kYXRhPiwgZGF0YT1kYXRhQGVudHJ5PTB4ZmZmZmZmZmY4
MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+LA0KPj4+ICAgICAgICAgZm49Zm5AZW50cnk9MHhm
ZmZmZmZmZjgxOThlN2IwIDxfX2RyaXZlcl9hdHRhY2g+KSBhdCAuLi9kcml2ZXJzL2Jhc2Uv
YnVzLmM6MzY4DQo+Pj4gICAgICMxMiAweGZmZmZmZmZmODE5OGRiNjUgaW4gZHJpdmVyX2F0
dGFjaCAoZHJ2PWRydkBlbnRyeT0weGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xl
PikgYXQgLi4vZHJpdmVycy9iYXNlL2RkLmM6MTIzMw0KPj4+ICAgICAjMTMgMHhmZmZmZmZm
ZjgxOThkMjA3IGluIGJ1c19hZGRfZHJpdmVyIChkcnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4
MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdCAuLi9kcml2ZXJzL2Jhc2UvYnVzLmM6Njcz
DQo+Pj4gICAgICMxNCAweGZmZmZmZmZmODE5OGY1NTAgaW4gZHJpdmVyX3JlZ2lzdGVyIChk
cnY9ZHJ2QGVudHJ5PTB4ZmZmZmZmZmY4MmJlNDBjMCA8dmlydGlvX2NvbnNvbGU+KSBhdCAu
Li9kcml2ZXJzL2Jhc2UvZHJpdmVyLmM6MjQ2DQo+Pj4gICAgICMxNSAweGZmZmZmZmZmODE3
MDZiNDcgaW4gcmVnaXN0ZXJfdmlydGlvX2RyaXZlciAoZHJpdmVyPWRyaXZlckBlbnRyeT0w
eGZmZmZmZmZmODJiZTQwYzAgPHZpcnRpb19jb25zb2xlPikgYXQgLi4vZHJpdmVycy92aXJ0
aW8vdmlydGlvLmM6MzU3DQo+Pj4gICAgICMxNiAweGZmZmZmZmZmODMyY2QzNGIgaW4gdmly
dGlvX2NvbnNvbGVfaW5pdCAoKSBhdCAuLi9kcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUu
YzoyMjU4DQo+Pj4gICAgICMxNyAweGZmZmZmZmZmODEwMDEwNWMgaW4gZG9fb25lX2luaXRj
YWxsIChmbj0weGZmZmZmZmZmODMyY2QyZTAgPHZpcnRpb19jb25zb2xlX2luaXQ+KSBhdCAu
Li9pbml0L21haW4uYzoxMjQ2DQo+Pj4gICAgICMxOCAweGZmZmZmZmZmODMyNzcyOTMgaW4g
ZG9faW5pdGNhbGxfbGV2ZWwgKGNvbW1hbmRfbGluZT0weGZmZmY4ODgwMDNlMmY5MDAgInJv
b3QiLCBsZXZlbD0weDYpIGF0IC4uL2luaXQvbWFpbi5jOjEzMTkNCj4+PiAgICAgIzE5IGRv
X2luaXRjYWxscyAoKSBhdCAuLi9pbml0L21haW4uYzoxMzM1DQo+Pj4gICAgICMyMCBkb19i
YXNpY19zZXR1cCAoKSBhdCAuLi9pbml0L21haW4uYzoxMzU0DQo+Pj4gICAgICMyMSBrZXJu
ZWxfaW5pdF9mcmVlYWJsZSAoKSBhdCAuLi9pbml0L21haW4uYzoxNTcxDQo+Pj4gICAgICMy
MiAweGZmZmZmZmZmODFmNjRiZTEgaW4ga2VybmVsX2luaXQgKHVudXNlZD08b3B0aW1pemVk
IG91dD4pIGF0IC4uL2luaXQvbWFpbi5jOjE0NjINCj4+PiAgICAgIzIzIDB4ZmZmZmZmZmY4
MTAwMWY0OSBpbiByZXRfZnJvbV9mb3JrICgpIGF0IC4uL2FyY2gveDg2L2VudHJ5L2VudHJ5
XzY0LlM6MzA4DQo+Pj4gICAgICMyNCAweDAwMDAwMDAwMDAwMDAwMDAgaW4gPz8gKCkNCj4+
Pg0KPj4+IEZpeCB0aGUgcHJvYmxlbSBieSBwcmV2ZW50aW5nIHhlbl9ncmFudF9pbml0X2Jh
Y2tlbmRfZG9taWQoKSBmcm9tDQo+Pj4gc2V0dGluZyBkb20wIGFzIGEgYmFja2VuZCB3aGVu
IHJ1bm5pbmcgaW4gZG9tMC4NCj4+Pg0KPj4+IEZpeGVzOiAwMzVlM2E0MzIxZjcgKCJ4ZW4v
dmlydGlvOiBPcHRpbWl6ZSB0aGUgc2V0dXAgb2YgInhlbi1ncmFudC1kbWEiIGRldmljZXMi
KQ0KPj4NCj4+DQo+PiBJIGFtIG5vdCAxMDAlIHN1cmUgd2hldGhlciB0aGUgRml4ZXMgdGFn
IHBvaW50cyB0byBwcmVjaXNlIGNvbW1pdC4gSWYgSQ0KPj4gYW0gbm90IG1pc3Rha2VuLCB0
aGUgc2FpZCBjb21taXQganVzdCBtb3ZlcyB0aGUgY29kZSBpbiB0aGUgY29udGV4dA0KPj4g
d2l0aG91dCBjaGFuZ2luZyB0aGUgbG9naWMgb2YgQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0Vf
R1JBTlQsIHRoaXMgd2FzDQo+PiBpbnRyb2R1Y2VkIGJlZm9yZS4NCj4gDQo+IEkgc2VlLCB0
aGUgdGFnIHNob3VsZCBiZXR0ZXIgcG9pbnQgdG8gNzIyODExM2QxZmEwICgieGVuL3ZpcnRp
bzogdXNlDQo+IGRvbTAgYXMgZGVmYXVsdCBiYWNrZW5kIGZvciBDT05GSUdfWEVOX1ZJUlRJ
T19GT1JDRV9HUkFOVCIpIHdoaWNoDQo+IGludHJvZHVjZWQgdGhlIG9yaWdpbmFsIGxvZ2lj
IHRvIHVzZSBkb20wIGFzIGJhY2tlbmQuDQo+IA0KPiBDb21taXQgMDM1ZTNhNDMyMWY3ICgi
eGVuL3ZpcnRpbzogT3B0aW1pemUgdGhlIHNldHVwIG9mICJ4ZW4tZ3JhbnQtZG1hIg0KPiBk
ZXZpY2VzIikgaXMgcmVsZXZhbnQgaW4gc2Vuc2UgdGhhdCBpdCBleHRlbmRlZCB3aGVuIHRo
aXMgbG9naWMgaXMNCj4gYWN0aXZlIGJ5IGFkZGluZyBhbiBPUiBjaGVjayBmb3IgeGVuX3B2
X2RvbWFpbigpLg0KPiANCj4+DQo+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBldHIgUGF2bHUg
PHBldHIucGF2bHVAc3VzZS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy94ZW4vZ3Jh
bnQtZG1hLW9wcy5jIHwgNCArKystDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
eGVuL2dyYW50LWRtYS1vcHMuYyBiL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4+
IGluZGV4IDc2ZjZmMjYyNjVhMy4uMjllZDI3YWM0NTBlIDEwMDY0NA0KPj4+IC0tLSBhL2Ry
aXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPj4+ICsrKyBiL2RyaXZlcnMveGVuL2dyYW50
LWRtYS1vcHMuYw0KPj4+IEBAIC0zNjIsNyArMzYyLDkgQEAgc3RhdGljIGludCB4ZW5fZ3Jh
bnRfaW5pdF9iYWNrZW5kX2RvbWlkKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+PiAgICAJaWYg
KG5wKSB7DQo+Pj4gICAgCQlyZXQgPSB4ZW5fZHRfZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlk
KGRldiwgbnAsIGJhY2tlbmRfZG9taWQpOw0KPj4+ICAgIAkJb2Zfbm9kZV9wdXQobnApOw0K
Pj4+IC0JfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19YRU5fVklSVElPX0ZPUkNFX0dS
QU5UKSB8fCB4ZW5fcHZfZG9tYWluKCkpIHsNCj4+PiArCX0gZWxzZSBpZiAoKElTX0VOQUJM
RUQoQ09ORklHX1hFTl9WSVJUSU9fRk9SQ0VfR1JBTlQpIHx8DQo+Pj4gKwkJICAgIHhlbl9w
dl9kb21haW4oKSkgJiYNCj4+PiArCQkgICAheGVuX2luaXRpYWxfZG9tYWluKCkpIHsNCj4+
DQo+PiBUaGUgY29tbWl0IGxndG0sIGp1c3Qgb25lIG5vdGU6DQo+Pg0KPj4NCj4+IEkgd291
bGQgZXZlbiBiYWlsIG91dCBlYXJseSBpbiB4ZW5fdmlydGlvX3Jlc3RyaWN0ZWRfbWVtX2Fj
YygpIGluc3RlYWQsDQo+PiBhcyBJIGFzc3VtZSB0aGUgc2FtZSBpc3N1ZSBjb3VsZCBoYXBw
ZW4gb24gQXJtIHdpdGggRFQgKGFsdGhvdWdoIHRoZXJlDQo+PiB3ZSBkb24ndCBndWVzcyB0
aGUgYmFja2VuZCdzIGRvbWlkLCB3ZSByZWFkIGl0IGZyb20gRFQgYW5kIHF1aXRlDQo+PiB1
bmxpa2VseSB3ZSBnZXQgRG9tMCBiZWluZyBpbiBEb20wIHdpdGggY29ycmVjdCBEVCkuDQo+
Pg0KPj4gU29tZXRoaW5nIGxpa2U6DQo+Pg0KPj4gQEAgLTQxNiw2ICs0MjEsMTAgQEAgYm9v
bCB4ZW5fdmlydGlvX3Jlc3RyaWN0ZWRfbWVtX2FjYyhzdHJ1Y3QNCj4+IHZpcnRpb19kZXZp
Y2UgKmRldikNCj4+ICAgIHsNCj4+ICAgICAgICAgICBkb21pZF90IGJhY2tlbmRfZG9taWQ7
DQo+Pg0KPj4gKyAgICAgICAvKiBYZW4gZ3JhbnQgRE1BIG9wcyBhcmUgbm90IHVzZWQgd2hl
biBydW5uaW5nIGFzIGluaXRpYWwgZG9tYWluICovDQo+PiArICAgICAgIGlmICh4ZW5faW5p
dGlhbF9kb21haW4oKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAr
DQo+PiAgICAgICAgICAgaWYgKCF4ZW5fZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlkKGRldi0+
ZGV2LnBhcmVudCwNCj4+ICZiYWNrZW5kX2RvbWlkKSkgew0KPj4gICAgICAgICAgICAgICAg
ICAgeGVuX2dyYW50X3NldHVwX2RtYV9vcHMoZGV2LT5kZXYucGFyZW50LCBiYWNrZW5kX2Rv
bWlkKTsNCj4+ICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4gKEVORCkNCj4+
DQo+Pg0KPj4NCj4+IElmIHNvLCB0aGF0IGNvbW1pdCBzdWJqZWN0IHdvdWxkIG5lZWQgdG8g
YmUgdXBkYXRlZCBhY2NvcmRpbmdseS4NCj4+DQo+PiBMZXQncyBzZWUgd2hhdCBvdGhlciBy
ZXZpZXdlcnMgd2lsbCBzYXkuDQo+IA0KPiBPaywgbWFrZXMgc2Vuc2UuDQoNCkkgdGhpbmsg
dGhpcyBpcyBva2F5IGZvciBhIGZpeCBvZiB0aGUgY3VycmVudCBwcm9ibGVtLg0KDQpQYXNz
aW5nIHRocm91Z2ggdmlydGlvIGRldmljZXMgdG8gYSBQViBkb21VIGlzIG5vdCBjb3ZlcmVk
IGJ5IHRoaXMgZml4LCBidXQgdGhpcw0Kc2hvdWxkIGJlIGEgcmF0aGVyIHJhcmUgY29uZmln
dXJhdGlvbiwgd2hpY2ggZG9lc24ndCB3b3JrIHRvZGF5IGVpdGhlci4gU28gdGhlDQpzdWdn
ZXN0ZWQgcGF0Y2ggd291bGQgZml4IHRoZSBjdXJyZW50IGlzc3VlIHdpdGhvdXQgaW50cm9k
dWNpbmcgYSByZWdyZXNzaW9uLg0KDQpBbnl0aGluZyBlbHNlIGNhbiBiZSBkb25lIGxhdGVy
Lg0KDQoNCkp1ZXJnZW4NCg==
--------------pU2zdqtIoiz6W8rchmw1TzCg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------pU2zdqtIoiz6W8rchmw1TzCg--

--------------9cgHzfhZcItFHAZOQ0DMtqQ7--

--------------jsXObnkNlf6I7A7Qe8ky0cRd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSnwsUFAwAAAAAACgkQsN6d1ii/Ey/d
Vgf/VingAtLDJrq6HyMAe7N2oDCv6Ol+1mg1aaM1GORybX4idbxO4bYSnsO20jzksQAN20ZnjXhk
nlh2NjBBsLONDbhTbOYhoebwVK4BQuHBrVtqlpmxoa7obWf8LtRUQ+HvjQmXMe8Eea/hT4PR4j8h
pu2GuiHmpGbJHRPNra1VQblNQcqNGNjQvmV/elevtlpMbNd1e9xwaBONBz6XzVqM67d1ROaEvV2/
G7g3p4/6bG4BvXk1ZybaDMYhL2zSLl3EeH/WWCdlHwzYRWhi6mD+VoOD4X/qSf75jImi8RGF/Tyg
omVwE1p36r0WfY8FnYY/3G2PX7WQkA4/j8JaS8cJjw==
=tBuV
-----END PGP SIGNATURE-----

--------------jsXObnkNlf6I7A7Qe8ky0cRd--
