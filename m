Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68372B9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFLIJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFLIIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:08:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E371103
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:08:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A7C922850;
        Mon, 12 Jun 2023 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686557288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ViypVMM6Ql+Q7kEIBjYZ5SWJVF1Sy2SsNSnxUlPo2XY=;
        b=k3rIZKE3Blt2IKTzyW+KP2aNRW7sHhsTtJ3+SZRxqfbgiQqEw1mC4AtHQhzu5MA/K4qhET
        35nUTJS6EnU7G/ZDlwnwfdsSsfZz5byzXowmnoXJMTwTecVlYV6ZJdtnOPcdLD5D6Mu9U7
        xoybCO/Gs80FS/3LX3r07DK2a4hIoi8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3CA1138EC;
        Mon, 12 Jun 2023 08:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zWAmNmfShmQmbwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 12 Jun 2023 08:08:07 +0000
Message-ID: <afc27bd9-5426-d837-dbb2-ec9083bec240@suse.com>
Date:   Mon, 12 Jun 2023 10:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <20230518134253.909623-1-hch@lst.de>
 <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
 <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl>
 <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com>
 <20230607131257.GB19206@lst.de>
 <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling
In-Reply-To: <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------D0k5nQJXdvVYMcmF7Z7ilEQw"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------D0k5nQJXdvVYMcmF7Z7ilEQw
Content-Type: multipart/mixed; boundary="------------zBG5RQTbKLSbzBmNY9ngYHOz";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Message-ID: <afc27bd9-5426-d837-dbb2-ec9083bec240@suse.com>
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling
References: <20230518134253.909623-1-hch@lst.de>
 <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
 <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl>
 <c5defff8-882e-3482-0de1-e50a4bcdfa99@suse.com>
 <20230607131257.GB19206@lst.de>
 <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>
In-Reply-To: <79b26dac-b507-1c05-b499-784ca6ee3db0@suse.com>

--------------zBG5RQTbKLSbzBmNY9ngYHOz
Content-Type: multipart/mixed; boundary="------------m0sXaX0k2kxORrZ0SHmv0P9E"

--------------m0sXaX0k2kxORrZ0SHmv0P9E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDYuMjMgMTc6MzgsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDA3LjA2LjIz
IDE1OjEyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IE9uIE1vbiwgTWF5IDIyLCAy
MDIzIGF0IDEwOjM3OjA5QU0gKzAyMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4gSW4g
bm9ybWFsIGNhc2VzIFBDSSBwYXNzdGhyb3VnaCBpbiBQViBndWVzdHMgcmVxdWlyZXMgdG8g
c3RhcnQgdGhlIGd1ZXN0DQo+Pj4gd2l0aCBlODIwX2hvc3Q9MS4gU28gaXQgc2hvdWxkIGJl
IHJhdGhlciBlYXN5IHRvIGxpbWl0IGFsbG9jYXRpbmcgdGhlDQo+Pj4gNjRNQiBpbiBQViBn
dWVzdHMgdG8gdGhlIGNhc2VzIHdoZXJlIHRoZSBtZW1vcnkgbWFwIGhhcyBub24tUkFNIHJl
Z2lvbnMNCj4+PiBlc3BlY2lhbGx5IGluIHRoZSBmaXJzdCAxTUIgb2YgdGhlIG1lbW9yeS4N
Cj4+Pg0KPj4+IFRoaXMgd2lsbCBjb3ZlciBldmVuIGhvdHBsdWcgY2FzZXMuIFRoZSBvbmx5
IGNhc2Ugbm90IGNvdmVyZWQgd291bGQgYmUgYQ0KPj4+IGd1ZXN0IHN0YXJ0ZWQgd2l0aCBl
ODIwX2hvc3Q9MSBldmVuIGlmIG5vIFBDSSBwYXNzdGhyb3VnaCB3YXMgcGxhbm5lZC4NCj4+
PiBCdXQgdGhpcyBzaG91bGQgYmUgcmF0aGVyIHJhcmUgKGF0IGxlYXN0IEkgaG9wZSBzbyku
DQo+Pg0KPj4gU28gaXMgdGhpcyBhbiBBQ0sgZm9yIHRoZSBwYXRjaCBhbmQgY2FuIHdlIGdv
IGFoZWFkIHdpdGggaXQ/DQo+IA0KPiBBcyBsb25nIGFzIGFib3ZlIG1lbnRpb25lZCBjaGVj
ayBvZiB0aGUgRTgyMCBtYXAgaXMgZG9uZSwgeWVzLg0KPiANCj4gSWYgeW91IHdhbnQgSSBj
YW4gc2VuZCBhIGRpZmYgdG8gYmUgZm9sZGVkIGludG8geW91ciBwYXRjaCBvbiBNb25kYXku
DQoNCkF0dGFjaGVkIGlzIGEgcGF0Y2ggZm9yIGFkZGluZyBhIG5ldyBmbGFnIHhlbl9wdl9w
Y2lfcG9zc2libGUuIFlvdSBjYW4NCmVpdGhlciBhZGQgdGhlIHBhdGNoIHRvIHlvdXIgc2Vy
aWVzIG9yIG1lcmdlIGl0IGludG8geW91ciBwYXRjaCAyLg0KDQpZb3UgbmVlZCB0byBtb2Rp
ZnkgeW91ciBwYXRjaCBsaWtlIHRoaXM6DQoNCkBAIC0xMTEsNyArOTAsMTAgQEAgc3RhdGlj
IGlubGluZSB2b2lkIF9faW5pdCBwY2lfeGVuX3N3aW90bGJfaW5pdCh2b2lkKQ0KICB2b2lk
IF9faW5pdCBwY2lfaW9tbXVfYWxsb2Modm9pZCkNCiAgew0KICAJaWYgKHhlbl9wdl9kb21h
aW4oKSkgew0KLQkJaWYgKHhlbl9pbml0aWFsX2RvbWFpbigpIHx8IHg4Nl9zd2lvdGxiX2Vu
YWJsZSkNCisJCWlmICh4ZW5faW5pdGlhbF9kb21haW4oKSB8fA0KKwkJICAgIChJU19FTkFC
TEVEKENPTkZJR19YRU5fUENJREVWX0ZST05URU5EKSAmJg0KKwkJICAgICB4ZW5fcHZfcGNp
X3Bvc3NpYmxlKSB8fA0KKwkJICAgIHg4Nl9zd2lvdGxiX2VuYWJsZSkNCiAgCQkJcGNpX3hl
bl9zd2lvdGxiX2luaXQoKTsNCiAgCQlyZXR1cm47DQogIAl9DQoNCg0KSnVlcmdlbg0K
--------------m0sXaX0k2kxORrZ0SHmv0P9E
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-xen-pci-add-flag-for-PCI-passthrough-being-possible.patch"
Content-Disposition: attachment;
 filename*0="0001-xen-pci-add-flag-for-PCI-passthrough-being-possible.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSA3ZTg0YTg4MjQzYjU3YmM5MGQxZWY2YmQ0MjY2MWY0OTk4ODZlNjU5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IE1vbiwgMTIgSnVuIDIwMjMgMDk6NTc6MTggKzAyMDAKU3ViamVjdDogW1BBVENI
XSB4ZW4vcGNpOiBhZGQgZmxhZyBmb3IgUENJIHBhc3N0aHJvdWdoIGJlaW5nIHBvc3NpYmxl
CgpXaGVuIHJ1bm5pbmcgYXMgYSBYZW4gUFYgZ3Vlc3RzIHBhc3NlZCB0aHJvdWdoIFBDSSBk
ZXZpY2VzIG9ubHkgaGF2ZSBhCmNoYW5jZSB0byB3b3JrIGlmIHRoZSBYZW4gc3VwcGxpZWQg
bWVtb3J5IG1hcCBoYXMgc29tZSBQQ0kgc3BhY2UKcmVzZXJ2ZWQuCgpBZGQgYSBmbGFnIHhl
bl9wdl9wY2lfcG9zc2libGUgd2hpY2ggd2lsbCBiZSBzZXQgaW4gZWFybHkgYm9vdCBpbiBj
YXNlCnRoZSBtZW1vcnkgbWFwIGhhcyBhdCBsZWFzdCBvbmUgYXJlYSB3aXRoIHRoZSB0eXBl
IEU4MjBfVFlQRV9SRVNFUlZFRC4KClNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpn
cm9zc0BzdXNlLmNvbT4KLS0tCiBhcmNoL3g4Ni94ZW4vc2V0dXAuYyB8IDYgKysrKysrCiBp
bmNsdWRlL3hlbi94ZW4uaCAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vc2V0dXAuYyBiL2FyY2gv
eDg2L3hlbi9zZXR1cC5jCmluZGV4IGMyYmUzZWZiMmJhMC4uNzE2Zjc2YzQxNDE2IDEwMDY0
NAotLS0gYS9hcmNoL3g4Ni94ZW4vc2V0dXAuYworKysgYi9hcmNoL3g4Ni94ZW4vc2V0dXAu
YwpAQCAtNDMsNiArNDMsOSBAQCBzdHJ1Y3QgeGVuX21lbW9yeV9yZWdpb24geGVuX2V4dHJh
X21lbVtYRU5fRVhUUkFfTUVNX01BWF9SRUdJT05TXSBfX2luaXRkYXRhOwogLyogTnVtYmVy
IG9mIHBhZ2VzIHJlbGVhc2VkIGZyb20gdGhlIGluaXRpYWwgYWxsb2NhdGlvbi4gKi8KIHVu
c2lnbmVkIGxvbmcgeGVuX3JlbGVhc2VkX3BhZ2VzOwogCisvKiBNZW1vcnkgbWFwIHdvdWxk
IGFsbG93IFBDSSBwYXNzdGhyb3VnaC4gKi8KK2Jvb2wgeGVuX3B2X3BjaV9wb3NzaWJsZTsK
KwogLyogRTgyMCBtYXAgdXNlZCBkdXJpbmcgc2V0dGluZyB1cCBtZW1vcnkuICovCiBzdGF0
aWMgc3RydWN0IGU4MjBfdGFibGUgeGVuX2U4MjBfdGFibGUgX19pbml0ZGF0YTsKIApAQCAt
ODA0LDYgKzgwNyw5IEBAIGNoYXIgKiBfX2luaXQgeGVuX21lbW9yeV9zZXR1cCh2b2lkKQog
CQljaHVua19zaXplID0gc2l6ZTsKIAkJdHlwZSA9IHhlbl9lODIwX3RhYmxlLmVudHJpZXNb
aV0udHlwZTsKIAorCQlpZiAodHlwZSA9PSBFODIwX1RZUEVfUkVTRVJWRUQpCisJCQl4ZW5f
cHZfcGNpX3Bvc3NpYmxlID0gdHJ1ZTsKKwogCQlpZiAodHlwZSA9PSBFODIwX1RZUEVfUkFN
KSB7CiAJCQlpZiAoYWRkciA8IG1lbV9lbmQpIHsKIAkJCQljaHVua19zaXplID0gbWluKHNp
emUsIG1lbV9lbmQgLSBhZGRyKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUveGVuL3hlbi5oIGIv
aW5jbHVkZS94ZW4veGVuLmgKaW5kZXggMGVmZWI2NTJmOWI4Li41ZWIwYTk3NGExMWUgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUveGVuL3hlbi5oCisrKyBiL2luY2x1ZGUveGVuL3hlbi5oCkBA
IC0yOSw2ICsyOSwxMiBAQCBleHRlcm4gYm9vbCB4ZW5fcHZoOwogCiBleHRlcm4gdWludDMy
X3QgeGVuX3N0YXJ0X2ZsYWdzOwogCisjaWZkZWYgQ09ORklHX1hFTl9QVgorZXh0ZXJuIGJv
b2wgeGVuX3B2X3BjaV9wb3NzaWJsZTsKKyNlbHNlCisjZGVmaW5lIHhlbl9wdl9wY2lfcG9z
c2libGUJMAorI2VuZGlmCisKICNpbmNsdWRlIDx4ZW4vaW50ZXJmYWNlL2h2bS9zdGFydF9p
bmZvLmg+CiBleHRlcm4gc3RydWN0IGh2bV9zdGFydF9pbmZvIHB2aF9zdGFydF9pbmZvOwog
Ci0tIAoyLjM1LjMKCg==
--------------m0sXaX0k2kxORrZ0SHmv0P9E
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------m0sXaX0k2kxORrZ0SHmv0P9E--

--------------zBG5RQTbKLSbzBmNY9ngYHOz--

--------------D0k5nQJXdvVYMcmF7Z7ilEQw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSG0mcFAwAAAAAACgkQsN6d1ii/Ey/c
4wf/QMdhTsNnA4kSAlXW/ipcsvIEuOEIOKMTB4VUwf7MAwC9ocVX3iCqd9SGwjoB9QZsGMNO8TWn
APr6CQ7QB+Up4Zli1zi/peGDz1rqFuCVdUDZ2KTy9a5/di7p2c9tk8Scll+cGeMRcP/LDVG0TT3h
P7eP8BuyJx7Gs/2+kHAeJtqzxpEApcSX4JNwBBAFn3LBkhWMn9lkzBrDeZ2U3KbEcfTa2zbqglyI
lS9BwXxneDnrJHXtojciajwEUBUNjagYHqj1dZlJyYX0LuMX9L2fH2veLLoGDINOJZtPltWyDMwe
0GEeOTbp9YlpOEhIy6QO2cOJS/I4jUa57++qTJp0jg==
=N0Xo
-----END PGP SIGNATURE-----

--------------D0k5nQJXdvVYMcmF7Z7ilEQw--
