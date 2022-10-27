Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8E60F1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiJ0H5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiJ0H4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:56:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73479F775;
        Thu, 27 Oct 2022 00:56:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9CEB1228A3;
        Thu, 27 Oct 2022 07:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666857410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Evqq0byI84PReYvRvM07SQEq8l1WooFes9CiMsDMDsM=;
        b=ATm+WMtLYDrgpAX8yQL3zutor5iNPX77ylX2+raW25SlEZWRq1oH4EvfeTecZA18UuDP5B
        zwqN2UfZyirsGCdJPLI83yyUvUnqYjrn5HZ31k1fsA88ebeaI3cjbq9D/6j7jbyoKp3FVN
        BDBYMJMEyIRrej1fc2JcqGhrwh1X2JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666857410;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Evqq0byI84PReYvRvM07SQEq8l1WooFes9CiMsDMDsM=;
        b=ctNvsTD5xPRMDUCO25122CICMpOHjZUarTtsba5tgYkmd1elQE0w/7ifbtV4qikEp2u0G7
        I7/WnQ4d4HNFamBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70D66134CA;
        Thu, 27 Oct 2022 07:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qw6FGsI5WmPBMQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 27 Oct 2022 07:56:50 +0000
Message-ID: <8a228fca-993b-154e-edaa-8d6044449631@suse.de>
Date:   Thu, 27 Oct 2022 09:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] fbdev/core: Avoid uninitialized read in
 aperture_remove_conflicting_pci_device()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e75323732bedc46d613d72ecb40f97e3bc75eea8.1666829073.git.mirq-linux@rere.qmqm.pl>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <e75323732bedc46d613d72ecb40f97e3bc75eea8.1666829073.git.mirq-linux@rere.qmqm.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gRU1oBovFLRWQNMpCU8tSiSN"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gRU1oBovFLRWQNMpCU8tSiSN
Content-Type: multipart/mixed; boundary="------------VnvR9JJDTyISABynCCLieTas";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <8a228fca-993b-154e-edaa-8d6044449631@suse.de>
Subject: Re: [PATCH] fbdev/core: Avoid uninitialized read in
 aperture_remove_conflicting_pci_device()
References: <e75323732bedc46d613d72ecb40f97e3bc75eea8.1666829073.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <e75323732bedc46d613d72ecb40f97e3bc75eea8.1666829073.git.mirq-linux@rere.qmqm.pl>

--------------VnvR9JJDTyISABynCCLieTas
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KdGhhbmtzIGZvciB0aGUgcGF0Y2guIEFkZGVkIHRvIGRybS1taXNjLWZpeGVzLg0K
DQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQpBbSAyNy4xMC4yMiB1bSAwMjowNiBzY2hyaWVi
IE1pY2hhxYIgTWlyb3PFgmF3Og0KPiBSZXR1cm4gb24gZXJyb3IgZGlyZWN0bHkgZnJvbSB0
aGUgQkFSLWl0ZXJhdGluZyBsb29wIGluc3RlYWQgb2YNCj4gYnJlYWsrcmV0dXJuLg0KPiAN
Cj4gVGhpcyBpcyBhY3R1YWxseSBhIGNvc21ldGljIGZpeCwgc2luY2UgaXQgd291bGQgYmUg
aGlnaGx5IHVudXN1YWwgdG8NCj4gaGF2ZSB0aGlzIGNhbGxlZCBmb3IgYSBQQ0kgZGV2aWNl
IHdpdGhvdXQgYW55IG1lbW9yeSBCQVJzLg0KPiANCj4gRml4ZXM6IDlkNjllZjE4MzgxNSAo
ImZiZGV2L2NvcmU6IFJlbW92ZSByZW1vdmVfY29uZmxpY3RpbmdfcGNpX2ZyYW1lYnVmZmVy
cygpIikNCj4gU2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhA
cmVyZS5xbXFtLnBsPg0KPiAtLS0NCj4gICBkcml2ZXJzL3ZpZGVvL2FwZXJ0dXJlLmMgfCA1
ICstLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYXBlcnR1cmUuYyBiL2Ry
aXZlcnMvdmlkZW8vYXBlcnR1cmUuYw0KPiBpbmRleCA5ZTZiY2MwM2ExYTQuLjQxZTc3ZGUx
ZWE4MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92aWRlby9hcGVydHVyZS5jDQo+ICsrKyBi
L2RyaXZlcnMvdmlkZW8vYXBlcnR1cmUuYw0KPiBAQCAtMzQwLDEyICszNDAsOSBAQCBpbnQg
YXBlcnR1cmVfcmVtb3ZlX2NvbmZsaWN0aW5nX3BjaV9kZXZpY2VzKHN0cnVjdCBwY2lfZGV2
ICpwZGV2LCBjb25zdCBjaGFyICpuYQ0KPiAgIAkJc2l6ZSA9IHBjaV9yZXNvdXJjZV9sZW4o
cGRldiwgYmFyKTsNCj4gICAJCXJldCA9IGFwZXJ0dXJlX3JlbW92ZV9jb25mbGljdGluZ19k
ZXZpY2VzKGJhc2UsIHNpemUsIHByaW1hcnksIG5hbWUpOw0KPiAgIAkJaWYgKHJldCkNCj4g
LQkJCWJyZWFrOw0KPiArCQkJcmV0dXJuIHJldDsNCj4gICAJfQ0KPiAgIA0KPiAtCWlmIChy
ZXQpDQo+IC0JCXJldHVybiByZXQ7DQo+IC0NCj4gICAJLyoNCj4gICAJICogV0FSTklORzog
QXBwYXJlbnRseSB3ZSBtdXN0IGtpY2sgZmJkZXYgZHJpdmVycyBiZWZvcmUgdmdhY29uLA0K
PiAgIAkgKiBvdGhlcndpc2UgdGhlIHZnYSBmYmRldiBkcml2ZXIgZmFsbHMgb3Zlci4NCg0K
LS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2No
w6RmdHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------VnvR9JJDTyISABynCCLieTas--

--------------gRU1oBovFLRWQNMpCU8tSiSN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmNaOcAFAwAAAAAACgkQlh/E3EQov+Ds
nRAAl8KNToBD5+ADiAmVEnTE48c5Aw5xyI/4oB5ybf2onmE5GKahNQ6XeXLxFfOyef79QXWC5MyX
sMQxSM72ICjQH9NHqRUpLuC41lBqh4Ml3YMQTQuzSjyE1fcnovOD1aXxql9gyIQtLUs3Vu/8mO08
QMuUpQpSd3FHvullxmk4AcAMc92IjgYiHi1cKlP7YxMVQV26iNLL3oOHak2b8lZyIpgv9Wk1m5SH
9fkre849lekn5GiIQALfESuWbs5Nb8bgVpCtzfPOLcBawcfjdG36HUSfsfOzXDGe5dzUXH/z7snE
I9U1K5cuW+KwqPqQZLNXR7nPN1Ha2PGliZ9PqlIyO28u8aoU+oT79eHvVfsbrFC4tyUGxYOwaTua
oXM8mBiCfSy8gzQVnC++DT9snzgRuwWHvk8FAeu2p/CAH9lAwr9WAY+LhcCpEP8N6NGYfW6td2Cp
Ua288UVFDrYxNBK7UNWhWiHgG5ktviXbkhqfIWwOR0uloxdKHVOZy8wQxhBa27U6sNl7W5cftYuE
iSFjOWhF967ijlGfoGghv0wa7tFdS3UYsG6HsqiddwO1vTVpp/YA2jzw0K/6vP242Nvgn9gpko1X
t7KUrZztu3CJ5I+o00W2GHDeWowRwrA5vNT0JTHZ0smINiUOPIfs6oGDDORWU0w5oEj568kXm1gU
W4Q=
=q2Aa
-----END PGP SIGNATURE-----

--------------gRU1oBovFLRWQNMpCU8tSiSN--
