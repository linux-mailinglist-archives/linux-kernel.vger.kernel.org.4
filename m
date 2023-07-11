Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0B74E6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGKGA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGKGAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:00:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033D195;
        Mon, 10 Jul 2023 23:00:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0EB3520455;
        Tue, 11 Jul 2023 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689055222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+md8tCCcb/XcgwK2O8x/Jn0J6p717ThkC2lo0+nTZw=;
        b=UAFlabp9xOyAThJZecIPdU+uOM8qe7NMyksdL8t5Exrkbn/qCfI0YNPhtwnq8uY8Z2FrQ5
        5wAWNfwGTvVQNjpeEyVL1o0i4YkC5jFPQJ6z63ZL8aKppiNMSTdcve27QYlWvBgO3+ybGS
        VCbQ7Zm6HIQ1jG8+UAS484Gfeky7wiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689055222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+md8tCCcb/XcgwK2O8x/Jn0J6p717ThkC2lo0+nTZw=;
        b=M2SLNyPdAc+LORyma9dDAKNWsOUZYDeh8/97Zt1KJ8SVcYz7B2RGh2sjxflV4Kk2E2hI1c
        KR9YvZIfwDWeecCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7EA81391C;
        Tue, 11 Jul 2023 06:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jun1K/XvrGTuBAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 11 Jul 2023 06:00:21 +0000
Message-ID: <a0aa122d-38a1-d4be-edc1-a49b4e5e9b6b@suse.de>
Date:   Tue, 11 Jul 2023 08:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] of: Preserve "of-display" device name for compatibility
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cyril Brulebois <cyril@debamax.com>,
        dri-devel@lists.freedesktop.org
References: <20230710174007.2291013-1-robh@kernel.org>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230710174007.2291013-1-robh@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EJlFeu4ajUbibragQamf4Zcq"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EJlFeu4ajUbibragQamf4Zcq
Content-Type: multipart/mixed; boundary="------------rrE1gd9xgtDN66LPMEindtwb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Cyril Brulebois <cyril@debamax.com>,
 dri-devel@lists.freedesktop.org
Message-ID: <a0aa122d-38a1-d4be-edc1-a49b4e5e9b6b@suse.de>
Subject: Re: [PATCH] of: Preserve "of-display" device name for compatibility
References: <20230710174007.2291013-1-robh@kernel.org>
In-Reply-To: <20230710174007.2291013-1-robh@kernel.org>

--------------rrE1gd9xgtDN66LPMEindtwb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDEwLjA3LjIzIHVtIDE5OjQwIHNjaHJpZWIgUm9iIEhlcnJpbmc6DQo+IFNpbmNl
IGNvbW1pdCAyNDFkMmZiNTZhMTggKCJvZjogTWFrZSBPRiBmcmFtZWJ1ZmZlciBkZXZpY2Ug
bmFtZXMgdW5pcXVlIiksDQo+IGFzIHNwb3R0ZWQgYnkgRnLDqWTDqXJpYyBCb25uYXJkLCB0
aGUgaGlzdG9yaWNhbCAib2YtZGlzcGxheSIgZGV2aWNlIGlzDQo+IGdvbmU6IHRoZSB1cGRh
dGVkIGxvZ2ljIGNyZWF0ZXMgIm9mLWRpc3BsYXkuMCIgaW5zdGVhZCwgdGhlbiBhcyBtYW55
DQo+ICJvZi1kaXNwbGF5Lk4iIGFzIHJlcXVpcmVkLg0KPiANCj4gVGhpcyBtZWFucyB0aGF0
IG9mZmIgbm8gbG9uZ2VyIGZpbmRzIHRoZSBleHBlY3RlZCBkZXZpY2UsIHdoaWNoIHByZXZl
bnRzDQo+IHRoZSBEZWJpYW4gSW5zdGFsbGVyIGZyb20gc2V0dGluZyB1cCBpdHMgaW50ZXJm
YWNlLCBhdCBsZWFzdCBvbiBwcGM2NGVsLg0KPiANCj4gRml4IHRoaXMgYnkga2VlcGluZyAi
b2YtZGlzcGxheSIgZm9yIHRoZSBmaXJzdCBkZXZpY2UgYW5kICJvZi1kaXNwbGF5Lk4iDQo+
IGZvciBzdWJzZXF1ZW50IGRldmljZXMuDQo+IA0KPiBMaW5rOiBodHRwczovL2J1Z3ppbGxh
Lmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzMyOA0KPiBMaW5rOiBodHRwczovL2J1
Z3MuZGViaWFuLm9yZy8xMDMzMDU4DQo+IEZpeGVzOiAyNDFkMmZiNTZhMTggKCJvZjogTWFr
ZSBPRiBmcmFtZWJ1ZmZlciBkZXZpY2UgbmFtZXMgdW5pcXVlIikNCj4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEN5cmlsIEJydWxlYm9pcyA8Y3lyaWxAZGViYW1heC5j
b20+DQo+IENjOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4g
Q2M6IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IFRob21hcyBaaW1tZXJt
YW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvb2YvcGxh
dGZvcm0uYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL3BsYXRmb3JtLmMg
Yi9kcml2ZXJzL29mL3BsYXRmb3JtLmMNCj4gaW5kZXggMDUxZTI5YjdhZDJiLi4wYzM0NzVl
N2QyZmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvb2YvcGxhdGZvcm0uYw0KPiArKysgYi9k
cml2ZXJzL29mL3BsYXRmb3JtLmMNCj4gQEAgLTU1Miw3ICs1NTIsNyBAQCBzdGF0aWMgaW50
IF9faW5pdCBvZl9wbGF0Zm9ybV9kZWZhdWx0X3BvcHVsYXRlX2luaXQodm9pZCkNCj4gICAJ
CQlpZiAoIW9mX2dldF9wcm9wZXJ0eShub2RlLCAibGludXgsb3BlbmVkIiwgTlVMTCkgfHwN
Cj4gICAJCQkgICAgIW9mX2dldF9wcm9wZXJ0eShub2RlLCAibGludXgsYm9vdC1kaXNwbGF5
IiwgTlVMTCkpDQo+ICAgCQkJCWNvbnRpbnVlOw0KPiAtCQkJZGV2ID0gb2ZfcGxhdGZvcm1f
ZGV2aWNlX2NyZWF0ZShub2RlLCAib2YtZGlzcGxheS4wIiwgTlVMTCk7DQo+ICsJCQlkZXYg
PSBvZl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRlKG5vZGUsICJvZi1kaXNwbGF5IiwgTlVMTCk7
DQo+ICAgCQkJb2Zfbm9kZV9wdXQobm9kZSk7DQo+ICAgCQkJaWYgKFdBUk5fT04oIWRldikp
DQo+ICAgCQkJCXJldHVybiAtRU5PTUVNOw0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpH
cmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJt
YW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55
DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGll
biBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------rrE1gd9xgtDN66LPMEindtwb--

--------------EJlFeu4ajUbibragQamf4Zcq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSs7/QFAwAAAAAACgkQlh/E3EQov+By
PA/9EW57Zs5sk3iddg/7LyeGpSXcv35PnNZUpqCm6rBQ/bmDziTNKi2cPDvg/qC50cEwuH4RSJsH
MfKrUOVg7vxOwYKnTf3caz264mGVlI1xFwf9GiVeURyw5SnCVguOL5yObxfCveZtNWqyIkE+3NG0
aHzLnkjhNxoW6Pv69DyLxrIjMxAXQduWwG6+3Otajh8KFqC+3KeOJzyLqb/q/3kOknw5KhFlV/4E
QHCpBQ4Il3w2wazFi+53ePGgZyqwJOB/BLTyozq7f/2DBa5mXruqtUUT7j/IwI84eqYGWxXaIVPb
T0IfjhBXdoBAUpgtB4jT0paoWFhcKK7zq7I3MbyiIMT/7V8wuYfaI4rOC5AlpDYeJ7uPCQuB7Fgo
88xX9+2/rleh6zwYM+Y+rec90gkKS/AuUOPVfrPMi38Y0MpvX9/JY4eSEAkYzLxZ2ikbKScdg9c3
GktsZ3kEDo28Y6ZfRfk9lOfdl+xQHM22pd3pIBdy/cyR7y7Q2uCV9kkta6dHA8dUjANJONevcsW5
hda2NQYx4pzkFvJd+rPVfVEvdgqYvrfz+2jWmfJgM97O6coJqof3jd52Sob0yH2cRoGtV5T0AYMZ
us9FLSraDImc+FXkMqq5PHLbvKEGetHcpc+9uxeLST7AJ60KO3dpHzJd2W5gDFBHTFSMsQfdyhm7
eSI=
=KYfa
-----END PGP SIGNATURE-----

--------------EJlFeu4ajUbibragQamf4Zcq--
