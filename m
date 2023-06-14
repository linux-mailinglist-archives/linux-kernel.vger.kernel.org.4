Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091FB730167
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbjFNONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjFNONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:13:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D255CD;
        Wed, 14 Jun 2023 07:13:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E695921A27;
        Wed, 14 Jun 2023 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686751992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXWk6CUvSgl2P4YJqAhXvTVbwqxUPGzo3E+LIQWooSI=;
        b=Uzm0HlGQ0v+BDSs40EBKzyurOvOS9Jev8U90j1YhQzVpaUHMOwQ9eQl5TsE6Ub/k1khjm0
        I2t7De+ZDz+yghYtyxDGJDOzkkTOebOlI1zUcfJwRLkAsu0INteoflheEP6ae4I8/IP9mP
        JvCZDVHceToTHPL3qp+24NEQHmMOFMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686751992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXWk6CUvSgl2P4YJqAhXvTVbwqxUPGzo3E+LIQWooSI=;
        b=tyKL14vhY7af13xcxWb/qt2Bg82IxT03rMqZnPv6npmXGpKMuCWJ1p61BtBeYdFgFN72s5
        0tJhND7fkwjTBrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BD461391E;
        Wed, 14 Jun 2023 14:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M+YTIfjKiWTCdAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 14 Jun 2023 14:13:12 +0000
Message-ID: <5720dbc1-a3e4-2b23-28cd-f889d3a5a4fc@suse.de>
Date:   Wed, 14 Jun 2023 16:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 01/38] backlight/bd6107: Compare against struct
 fb_info.device
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, dan.carpenter@linaro.org,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        stable@vger.kernel.org
References: <20230613110953.24176-1-tzimmermann@suse.de>
 <20230613110953.24176-2-tzimmermann@suse.de>
 <20230614135157.GU3635807@google.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230614135157.GU3635807@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jFKBPLLaVKDIAocIfs4ThSlI"
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
--------------jFKBPLLaVKDIAocIfs4ThSlI
Content-Type: multipart/mixed; boundary="------------qMR6e1eJ6r4sR49vitWQ2hp2";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Lee Jones <lee@kernel.org>
Cc: daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org, deller@gmx.de,
 geert+renesas@glider.be, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 dan.carpenter@linaro.org, michael.j.ruhl@intel.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 stable@vger.kernel.org
Message-ID: <5720dbc1-a3e4-2b23-28cd-f889d3a5a4fc@suse.de>
Subject: Re: [PATCH v3 01/38] backlight/bd6107: Compare against struct
 fb_info.device
References: <20230613110953.24176-1-tzimmermann@suse.de>
 <20230613110953.24176-2-tzimmermann@suse.de>
 <20230614135157.GU3635807@google.com>
In-Reply-To: <20230614135157.GU3635807@google.com>

--------------qMR6e1eJ6r4sR49vitWQ2hp2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTQuMDYuMjMgdW0gMTU6NTEgc2NocmllYiBMZWUgSm9uZXM6DQo+IE9uIFR1
ZSwgMTMgSnVuIDIwMjMsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPiANCj4+IFN0cnVj
dCBiZDYxMDdfcGxhdGZvcm1fZGF0YSByZWZlcnMgdG8gYSBwbGF0Zm9ybSBkZXZpY2Ugd2l0
aGluDQo+PiB0aGUgTGludXggZGV2aWNlIGhpZXJhcmNoeS4gVGhlIHRlc3QgaW4gYmQ2MTA3
X2JhY2tsaWdodF9jaGVja19mYigpDQo+PiBjb21wYXJlcyBpdCBhZ2FpbnN0IHRoZSBmYmRl
diBkZXZpY2UgaW4gc3RydWN0IGZiX2luZm8uZGV2LCB3aGljaA0KPj4gaXMgZGlmZmVyZW50
LiBGaXggdGhlIHRlc3QgYnkgY29tcGFyaW5nIHRvIHN0cnVjdCBmYl9pbmZvLmRldmljZS4N
Cj4+DQo+PiBGaXhlcyBhIGJ1ZyBpbiB0aGUgYmFja2xpZ2h0IGRyaXZlciBhbmQgcHJlcGFy
ZXMgZmJkZXYgZm9yIG1ha2luZw0KPj4gc3RydWN0IGZiX2luZm8uZGV2IG9wdGlvbmFsLg0K
Pj4NCj4+IHYyOg0KPj4gCSogbW92ZSByZW5hbWVzIGludG8gc2VwYXJhdGUgcGF0Y2ggKEph
dmllciwgU2FtLCBNaWNoYWVsKQ0KPj4NCj4+IEZpeGVzOiA2N2I0M2U1OTA0MTUgKCJiYWNr
bGlnaHQ6IEFkZCBST0hNIEJENjEwNyBiYWNrbGlnaHQgZHJpdmVyIikNCj4+IFNpZ25lZC1v
ZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPj4gQ2M6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnQrcmVuZXNhc0BpZGVhc29uYm9h
cmQuY29tPg0KPj4gQ2M6IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+PiBDYzogRGFu
aWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4NCj4+IENjOiBKaW5n
b28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT4NCj4+IENjOiBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjMu
MTIrDQo+PiBSZXZpZXdlZC1ieTogSmF2aWVyIE1hcnRpbmV6IENhbmlsbGFzIDxqYXZpZXJt
QHJlZGhhdC5jb20+DQo+PiBSZXZpZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJv
cmcub3JnPg0KPj4gUmV2aWV3ZWQtYnk6IERhbmllbCBUaG9tcHNvbiA8ZGFuaWVsLnRob21w
c29uQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy92aWRlby9iYWNrbGlnaHQv
YmQ2MTA3LmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gQ2FuIHRoZSBCYWNrbGlnaHQgcGF0Y2hlcyBiZSBhcHBs
aWVkIHdpdGhvdXQgdGhlIG90aGVycyBhbmQgdmlzYSB2ZXJzYT8NCg0KVW5mb3J0dW5hdGVs
eSBub3QuIFRoZSByZXN0IG9mIHRoZSBzZXJpZXMgcmVxdWlyZXMgdGhlIGJhY2tsaWdodCBw
YXRjaGVzLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KDQotLSANClRob21hcyBa
aW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5i
ZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0Rv
bmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------qMR6e1eJ6r4sR49vitWQ2hp2--

--------------jFKBPLLaVKDIAocIfs4ThSlI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSJyvcFAwAAAAAACgkQlh/E3EQov+DO
uhAAsRBpTfNB2nRslH0VsoSwy6Po5YGk5E4vLJymwShH9bCMu2X+HxfG2JUWFVz7+LXPm/MYwZze
0NAeaWjs2ft9FCSEzYVlCnhkpjZsa2Gf1u79S3ZMJHTWuacUji/M2mL2IZZCtG+EsCJmHPqWP+oI
RRmzkZF3VLjE4nu8AKqSUF8P9d4CjOoTy7iUHhZ/OuAYv1pdHlJ6nLUv4m0gwsizgJNcF4Z9LeCa
oqAVidYe/TebhOgC6rv3C5gTZnMoBfT9ICYFrGhLUKublhYI+xFGkYk5sx6vQLMJXwSMNu7KK4L+
g4uoytQwFdTF+H1IhZS3ZQ3Le+9yX3HrQ82qqzKgKcTX370CCvX+qbC+EzcRzp6C2gyVkyMMTOVm
Rvugdp+Z5CLyMyd6YW3IrGnitajR1ZyM7oTuJNuVV6ErLbKsX0DV0pAwu5u/Ai3adOvuXcrzZV9f
pAbMBx7lXfMdy+3vVOQDyhoS5LltgbwcPq/yBZXLJkd6KtwFLNCqPYzPu0JzeVK5/Bb+ACsnA1be
6hq9h8Ga3DHeGNrQ9yU92vSfVF9PUC68y2Ei5sobO2WtgwtG9tG4XYexbumRo1waMuseZ9c+LS1s
0guFuxEWPTz4Kf96yXCzDPmz8NZ+reH2c+QqTlTnspHykEdA2O3QA5EHH4BFPSku3Ya0SX+LRkBE
Fek=
=elwI
-----END PGP SIGNATURE-----

--------------jFKBPLLaVKDIAocIfs4ThSlI--
