Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15295F7393
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 06:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJGEfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 00:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJGEfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 00:35:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83E60495
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 21:35:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 339432198D;
        Fri,  7 Oct 2022 04:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665117329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rtqEG3TKbIp/Bs82eo5+QVL5Q6EWc2OkEwlbTV6CZsE=;
        b=V3Q5dVhUFQJAStG5f1ZeNxan0/w3FdMhcGo04aceuv2a4mXRAe/7IVsq7XcMpHUZmxWnVD
        ou4Ww9kCfHqvsPzKP4w2XeqDOYTwKWHWZXL2kOi7SBaWYKqcH9XkAIX0hEIKvcGVQHmlcd
        JGjylrj9KtXvVlfKHLQLJdHwIaHOpzw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 029EC13A3D;
        Fri,  7 Oct 2022 04:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hE+POpCsP2NUHwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 04:35:28 +0000
Message-ID: <127d2641-2f5d-893f-dc81-3c6d52bc78ce@suse.com>
Date:   Fri, 7 Oct 2022 06:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] xen/virtio: restructure xen grant dma setup
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-2-jgross@suse.com>
 <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jbDsNvWt9tKelFdrMHX04e8u"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jbDsNvWt9tKelFdrMHX04e8u
Content-Type: multipart/mixed; boundary="------------TM20SFjXLoPtbcqvvVPlhLC1";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <127d2641-2f5d-893f-dc81-3c6d52bc78ce@suse.com>
Subject: Re: [PATCH 1/3] xen/virtio: restructure xen grant dma setup
References: <20221006071500.15689-1-jgross@suse.com>
 <20221006071500.15689-2-jgross@suse.com>
 <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>
In-Reply-To: <a8482a7b-0d89-861d-bc87-632d3230c173@epam.com>

--------------TM20SFjXLoPtbcqvvVPlhLC1
Content-Type: multipart/mixed; boundary="------------ODY5ITicvDsW0a1wocMhxzRz"

--------------ODY5ITicvDsW0a1wocMhxzRz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTAuMjIgMTg6MzUsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
T24gMDYuMTAuMjIgMTA6MTQsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IA0KPiBIZWxsbyBK
dWVyZ2VuDQo+IA0KPj4gSW4gb3JkZXIgdG8gcHJlcGFyZSBzdXBwb3J0aW5nIG90aGVyIG1l
YW5zIHRoYW4gZGV2aWNlIHRyZWUgZm9yDQo+PiBzZXR0aW5nIHVwIHZpcnRpbyBkZXZpY2Vz
IHVuZGVyIFhlbiwgcmVzdHJ1Y3R1cmUgdGhlIGZ1bmN0aW9ucw0KPj4geGVuX2lzX2dyYW50
X2RtYV9kZXZpY2UoKSBhbmQgeGVuX2dyYW50X3NldHVwX2RtYV9vcHMoKSBhIGxpdHRsZSBi
aXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KPiANCj4gDQo+IFBhdGNoIGxvb2tzIGdvb2QsDQo+IA0KPiBvbmUgTklULCB4ZW5f
ZHRfZ3JhbnRfc2V0dXBfZG1hX29wcygpIGRvd24gdGhlIGNvZGUgZG9lc24ndCBhY3R1YWxs
eQ0KPiBzZXR1cCBETUEgT1BTLCBpdCByZXRyaWV2ZXMgdGhlIGJhY2tlbmQgZG9taWQgdmlh
IGRldmljZS10cmVlIG1lYW5zIGFuZA0KPiBzdG9yZXMgaXQsDQo+IA0KPiBzbyBJIHdvdWxk
IHJlbmFtZSB0byBpdCwgbWF5YmUgc29tZXRoaW5nIGxpa2UNCj4geGVuX2R0X2dyYW50X3Nl
dHVwX2JhY2tlbmRfZG9taWQoKSBvciB4ZW5fZHRfZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlk
KCksDQo+IGJ1dCBJIGFtIG5vdCBzdXJlIGl0IHdvdWxkIGJlIGdvb2QgYWx0ZXJuYXRpdmUu
DQoNCkknbGwgZ28gd2l0aCB4ZW5fZHRfZ3JhbnRfaW5pdF9iYWNrZW5kX2RvbWlkKCkuDQoN
Cj4gDQo+IA0KPiBTbywgdy8gb3Igdy9vIHJlbmFtaW5nOg0KPiANCj4gUmV2aWV3ZWQtYnk6
IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4N
Cj4gDQo+IGFsc28NCj4gDQo+IFRlc3RlZC1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9s
ZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPiAjIEFybTY0DQo+IG9ubHkNCg0KVGhhbmtz
LA0KDQoNCkp1ZXJnZW4NCg0K
--------------ODY5ITicvDsW0a1wocMhxzRz
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ODY5ITicvDsW0a1wocMhxzRz--

--------------TM20SFjXLoPtbcqvvVPlhLC1--

--------------jbDsNvWt9tKelFdrMHX04e8u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmM/rJAFAwAAAAAACgkQsN6d1ii/Ey+t
CAf/Ql9KJJz61Kp8N/3/0XNMnr9nOK+qySKjXEeMeWYeH4jxYwV6v5P9K3cXX8nXuYWhcbTbL+4G
QsvDPQP0Ctz/1qENeuvzFpu3hYC4d0MCcVsqsLPEfuaevPdKfwZCVblzyVrvGkEs03E+pRJDKCU5
XYW/ULpP5BQ4Ou5BZ4OX2bK1Pj/DSZpWXThWtmo7CKiWxUOalTF4DB8Eez7m/mittiFoog659mFt
lRVvvP2lN7YgVOixetegTKmouJgt77pIC8unhCQdeNqplnyZ7ny82fT3ejUUKpnew6KpeNBYmGV/
HZpmmX9eqt4vBooradqIbi3e3q1DzxohhjvIJP0jhA==
=3p5t
-----END PGP SIGNATURE-----

--------------jbDsNvWt9tKelFdrMHX04e8u--
