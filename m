Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB1A625D78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiKKOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiKKOuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:50:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA35B5B9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:50:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CC482250A;
        Fri, 11 Nov 2022 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668178205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mByjmISEKdalqe7JQPlupRP4g09wlWA9jjtuTrL9KpY=;
        b=F0Zo+/xJHagbEfqClZuEBxIS5uSdUGb/ZhWp9LJjKXcdzLi21N7iDjiAkTTpiyX0SlUOFD
        qAc1zY6MDng8twz4XKsSUdPuCR42jqlQsZ1cObmJUAv0G5bkBQHrrkClmurbJ/h1kcea92
        MmexqAT8bhdvKXsUIjodKUr9a8/wCRA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2077113357;
        Fri, 11 Nov 2022 14:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MsldBh1hbmMRHQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 11 Nov 2022 14:50:05 +0000
Message-ID: <7a7553b2-79c1-759d-b020-c75b3118661f@suse.com>
Date:   Fri, 11 Nov 2022 15:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
 <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
 <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
 <3cd62b0b-a131-b709-4244-0ae694c3d022@suse.com>
 <a5342914-e9fd-60be-50c3-60f29ee27b99@suse.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
In-Reply-To: <a5342914-e9fd-60be-50c3-60f29ee27b99@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0hRGbhcyHFwbcd61gAq87GYo"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0hRGbhcyHFwbcd61gAq87GYo
Content-Type: multipart/mixed; boundary="------------5FjtObaYiiDKaRpBY8HzAwLk";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Maximilian Heyne <mheyne@amazon.de>, xen-devel@lists.xenproject.org,
 LKML <linux-kernel@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <7a7553b2-79c1-759d-b020-c75b3118661f@suse.com>
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
 <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
 <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
 <3cd62b0b-a131-b709-4244-0ae694c3d022@suse.com>
 <a5342914-e9fd-60be-50c3-60f29ee27b99@suse.com>
In-Reply-To: <a5342914-e9fd-60be-50c3-60f29ee27b99@suse.com>

--------------5FjtObaYiiDKaRpBY8HzAwLk
Content-Type: multipart/mixed; boundary="------------eZPec4DGzN1q5kIEiQLZsg00"

--------------eZPec4DGzN1q5kIEiQLZsg00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMTEuMjIgMTQ6MTcsIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAxMS4xMS4yMDIy
IDEzOjQ0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gT24gMTEuMTEuMjIgMTA6MDEsIEp1
ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4gT24gMDguMTEuMjIgMTc6MjYsIEphbiBCZXVsaWNo
IHdyb3RlOg0KPj4+PiBPbiAwMy4xMS4yMDIyIDE2OjQxLCBKYW4gQmV1bGljaCB3cm90ZToN
Cj4+Pj4+IE9uIDAzLjExLjIwMjIgMTQ6MzgsIEphbiBCZXVsaWNoIHdyb3RlOg0KPj4+Pj4+
IE9uIDI5LjA3LjIwMjIgMDk6MDQsIEphbmUgTWFsYWxhbmUgd3JvdGU6DQo+Pj4+Pj4+IEBA
IC0xMjUsNiArMTMwLDkgQEAgREVGSU5FX0lEVEVOVFJZX1NZU1ZFQyhzeXN2ZWNfeGVuX2h2
bV9jYWxsYmFjaykNCj4+Pj4+Pj4gIMKgIHsNCj4+Pj4+Pj4gIMKgwqDCoMKgwqAgc3RydWN0
IHB0X3JlZ3MgKm9sZF9yZWdzID0gc2V0X2lycV9yZWdzKHJlZ3MpOw0KPj4+Pj4+PiArwqDC
oMKgIGlmICh4ZW5fcGVyY3B1X3VwY2FsbCkNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFj
a19BUElDX2lycSgpOw0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICDCoMKgwqDCoMKgIGluY19pcnFf
c3RhdChpcnFfaHZfY2FsbGJhY2tfY291bnQpOw0KPj4+Pj4+PiAgwqDCoMKgwqDCoCB4ZW5f
aHZtX2V2dGNobl9kb191cGNhbGwoKTsNCj4+Pj4+Pj4gQEAgLTE2OCw2ICsxNzYsMTUgQEAg
c3RhdGljIGludCB4ZW5fY3B1X3VwX3ByZXBhcmVfaHZtKHVuc2lnbmVkIGludCBjcHUpDQo+
Pj4+Pj4+ICDCoMKgwqDCoMKgIGlmICgheGVuX2hhdmVfdmVjdG9yX2NhbGxiYWNrKQ0KPj4+
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4+Pj4+PiArwqDCoMKgIGlm
ICh4ZW5fcGVyY3B1X3VwY2FsbCkgew0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmMgPSB4
ZW5fc2V0X3VwY2FsbF92ZWN0b3IoY3B1KTsNCj4+Pj4+Pg0KPj4+Pj4+ICDCoEZyb20gYWxs
IEkgY2FuIHRlbGwgYXQgbGVhc3QgZm9yIEFQcyB0aGlzIGhhcHBlbnMgYmVmb3JlIHNldHVw
X2xvY2FsX2FwaWMoKS4NCj4+Pj4+PiBXaXRoIHRoZXJlIGJlaW5nIEFQSUMgaW50ZXJhY3Rp
b24gaW4gdGhpcyBvcGVyYXRpb24gbW9kZSwgYXMgc2VlbiBlLmcuIGluDQo+Pj4+Pj4gdGhl
IGVhcmxpZXIgaHVuayBhYm92ZSwgSSB0aGluayB0aGlzIGlzIGxvZ2ljYWxseSB3cm9uZy4g
QW5kIGl0IGxlYWRzIHRvDQo+Pj4+Pj4gYXBpY19wZW5kaW5nX2ludHJfY2xlYXIoKSBpc3N1
aW5nIGl0cyB3YXJuaW5nOiBUaGUgdmVjdG9yIHJlZ2lzdHJhdGlvbiwgYXMNCj4+Pj4+PiBh
biBpbnRlbnRpb25hbCBzaWRlIGVmZmVjdCwgbWFya3MgdGhlIHZlY3RvciBhcyBwZW5kaW5n
LiBVbmxlc3MgSVJRcyB3ZXJlDQo+Pj4+Pj4gZW5hYmxlZCBhdCBhbnkgcG9pbnQgYmV0d2Vl
biB0aGUgcmVnaXN0cmF0aW9uIGFuZCB0aGUgY2hlY2ssIHRoZXJlJ3MNCj4+Pj4+PiBzaW1w
bHkgbm8gd2F5IGZvciB0aGUgY29ycmVzcG9uZGluZyBJUlIgYml0IHRvIGJlIGRlYWx0IHdp
dGggKGJ5DQo+Pj4+Pj4gcHJvcGFnYXRpbmcgdG8gSVNSIHdoZW4gdGhlIGludGVycnVwdCBp
cyBkZWxpdmVyZWQsIGFuZCB0aGVuIGJlaW5nIGNsZWFyZWQNCj4+Pj4+PiBmcm9tIElTUiBi
eSBFT0kpLg0KPj4+Pj4NCj4+Pj4+IFdpdGggUm9nZXIncyBoZWxwIEkgbm93IGhhdmUgYSBw
b2ludGVyIHRvIG9zc3Rlc3QgYWxzbyBleHBvc2luZyB0aGUgaXNzdWU6DQo+Pj4+Pg0KPj4+
Pj4gaHR0cDovL2xvZ3MudGVzdC1sYWIueGVucHJvamVjdC5vcmcvb3NzdGVzdC9sb2dzLzE3
NDU5Mi90ZXN0LWFtZDY0LWFtZDY0LXhsLXB2aHYyLWludGVsL2h1eGVscmViZTAtLS12YXIt
bG9nLXhlbi1jb25zb2xlLWd1ZXN0LWRlYmlhbi5ndWVzdC5vc3N0ZXN0LmxvZy5neg0KPj4+
Pg0KPj4+PiBJJ3ZlIG5vdGljZWQgb25seSBub3cgdGhhdCBteSBtYWlsIHRvIEphbmUgYm91
bmNlZCwgYW5kIEknbSBub3cgdG9sZA0KPj4+PiBzaGUncyBubyBsb25nZXIgaW4gaGVyIHJv
bGUgYXQgQ2l0cml4LiBTaW5jZSBJIGRvbid0IGV4cGVjdCB0byBoYXZlIHRpbWUNCj4+Pj4g
dG8gaW52ZXN0aWdhdGUgYW4gYXBwcm9wcmlhdGUgc29sdXRpb24gaGVyZSwgbWF5IEkgYXNr
IHdoZXRoZXIgb25lIG9mDQo+Pj4+IHRoZSB0d28gb2YgeW91IGNvdWxkIGxvb2sgaW50byB0
aGlzLCBiZWluZyB0aGUgbWFpbnRhaW5lcnMgb2YgdGhpcyBjb2RlPw0KPj4+DQo+Pj4gSSB0
aGluayB0aGUgY29ycmVjdCB3YXkgdG8gaGFuZGxlIHRoaXMgd291bGQgYmU6DQo+Pj4NCj4+
PiAtIHJlbmFtZSBDUFVIUF9BUF9BUk1fWEVOX1NUQVJUSU5HIHRvIENQVUhQX0FQX1hFTl9T
VEFSVElORw0KPj4+IC0gbW92ZSB0aGUgeGVuX3NldF91cGNhbGxfdmVjdG9yKCkgY2FsbCB0
byBhIG5ldyBob3RwbHVnIGNhbGxiYWNrDQo+Pj4gICDCoCByZWdpc3RlcmVkIGZvciBDUFVI
UF9BUF9YRU5fU1RBUlRJTkcgKHRoaXMgY2FuIGJlIGRvbmUgZXZlbg0KPj4+ICAgwqAgY29u
ZGl0aW9uYWxseSBvbmx5IGlmIHhlbl9wZXJjcHVfdXBjYWxsIGlzIHNldCkNCj4+Pg0KPj4+
IFdyaXRpbmcgYSBwYXRjaCBub3cgLi4uDQo+Pg0KPj4gRm9yIHRoZSBBUHMgdGhpcyBpcyB3
b3JraW5nIGFzIGV4cGVjdGVkLg0KPj4NCj4+IFRoZSBib290IHByb2Nlc3NvciBzZWVtcyB0
byBiZSBoYXJkZXIgdG8gZml4LiBUaGUgcmVsYXRlZCBtZXNzYWdlIGlzIGJlaW5nDQo+PiBp
c3N1ZWQgZXZlbiB3aXRoIGludGVycnVwdHMgYmVpbmcgb24gd2hlbiBzZXR1cF9sb2NhbF9B
UElDKCkgaXMgY2FsbGVkLg0KPiANCj4gSG1tLCBwdXp6bGluZzogSSBkb24ndCByZWNhbGwg
aGF2aW5nIHNlZW4gdGhlIG1lc3NhZ2UgZm9yIHRoZSBCU1AuIFdoaWNoDQo+IG1hZGUgbWUg
YXNzdW1lICh3aXRob3V0IGhhdmluZyBhY3R1YWxseSBjaGVja2VkKSB0aGF0IC4uLg0KPiAN
Cj4+IEkndmUgdHJpZWQgdG8gcmVnaXN0ZXIgdGhlIGNhbGxiYWNrIG9ubHkgYWZ0ZXIgdGhl
IHNldHVwX2xvY2FsX0FQSUMoKSBjYWxsLA0KPiANCj4gLi4uIGl0J3MgYWxyZWFkeSBoYXBw
ZW5pbmcgYWZ0ZXJ3YXJkcyBpbiB0aGF0IGNhc2UuDQo+IA0KPj4gYnV0IHRoaXMgcmVzdWx0
cyBpbiBhIHN5c3RlbSBoYW5nIHdoZW4gdGhlIEFQcyBhcmUgc3RhcnRlZC4NCj4+DQo+PiBB
bnkgaWRlYXM/DQo+IA0KPiBOb3QgcmVhbGx5LCB0byBiZSBob25lc3QuDQoNCkkgbWlnaHQg
YmUgd3JvbmcgaGVyZSwgYnV0IGlzIGEgYml0IHNldCBpbiBJUlIgcGx1cyBpbnRlcnJ1cHRz
IGVuYWJsZWQNCmVub3VnaCB0byBtYWtlIHRoZSBrZXJuZWwgaGFwcHk/IFRoZSBsb2NhbCBB
UElDIGlzbid0IGVuYWJsZWQgeWV0IHdoZW4NCmFwaWNfcGVuZGluZ19pbnRyX2NsZWFyKCkg
aXMgYmVpbmcgY2FsbGVkLCBzbyBJTUhPIHRoZSBoeXBlcnZpc29yIHdpbGwNCm5ldmVyIHBy
b3BhZ2F0ZSB0aGUgYml0IHRvIElTUi4NCg0KSSBkaWRuJ3QgZmluZCBhbnkgc3BlY2lmaWMg
aW5mb3JtYXRpb24gaW4gdGhlIFNETSByZWdhcmRpbmcgImFjY2VwdGluZw0KYW4gaW50ZXJy
dXB0IiBvZiBhIGRpc2FibGVkIGxvY2FsIEFQSUMsIGJ1dCBtYXliZSBJIGRpZG4ndCBmaW5k
IHRoZQ0KcmVsZXZhbnQgcGFydCBvZiB0aGUgbWFudWFsLg0KDQoNCkp1ZXJnZW4NCg==
--------------eZPec4DGzN1q5kIEiQLZsg00
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------eZPec4DGzN1q5kIEiQLZsg00--

--------------5FjtObaYiiDKaRpBY8HzAwLk--

--------------0hRGbhcyHFwbcd61gAq87GYo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmNuYRwFAwAAAAAACgkQsN6d1ii/Ey/E
Zgf/eU++OBDGUwnTkMOfDChOoHfGUWCh6/cnwF9FScf3bB8ujsf3/rDr6FjQQIkqInEWQ9i7ijIE
/tAxEcNHI6olYq1BKBlvWo06REPOj02JEK484iOk0lbdmtH6PFZnkQxud7nc0xNsyUGD8VEHMOb0
1C2JKj5QLIc8JU06TQx6P7BslA1LkzIFPSQcm9I5Gi71OGA+DsD+1+gmxecUm+8WOIqLxhsuH8eL
0vW/LxUMREVGemthAVglbcPREtUtu84TpQOTNVmw4cSK+Li/GmQ72CerOqLTk7+fEJ1WOda7+inC
ju53yIgXpru9Nvp2LY9pIBJgDOn7n3pGmXccAcQroQ==
=+tSq
-----END PGP SIGNATURE-----

--------------0hRGbhcyHFwbcd61gAq87GYo--
