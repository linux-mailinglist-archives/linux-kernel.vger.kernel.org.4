Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3F602A17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJRL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJRL1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:27:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CAAC4B8;
        Tue, 18 Oct 2022 04:27:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a6so17478751ljq.5;
        Tue, 18 Oct 2022 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:from:references:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa+eXDAJ0qlLwO6v+r85uW+FsY3zgT9PTdehbfZD9zI=;
        b=gW3Hoz97ICmJVAoOhw9QJ+odnlU5iN2h7EKCF74pSmzU8glCgaA/7zeXGRijOVhoki
         B2N9Fd6t8UzC9LQx+nkFo8rtn8yd1mZZTVpMbI3f1G1CuN9qOybV60ODoHupHMSn2z6Z
         chU7uwW5F0qZvaw3tsDflvN7RDMlbhtan5Wox2bvCfjxENyUuUbq7U94Fv/MQxVgTitt
         ZAMm1V5GBtSvx8jLOgrY4lpXPbQ1zF0LYTm05Q8p8i3oC/pO8r7Km3a2fI6s005C4yOX
         ROoOEiZAJ2xhMVz416iA4ziysYDJB0CSJB3JupDVeJnuv1W2k+1RjdzgIeidd9bxOEFK
         Z50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:from:references:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wa+eXDAJ0qlLwO6v+r85uW+FsY3zgT9PTdehbfZD9zI=;
        b=6xt+nFPc3GnxUq4NLW+VOaOR56ZBsZRa/NNCVGilXu26i8W51j47rN1EK2iZX7NXWs
         BiOLqlwXWzjbUoifiR39rEIFHYpxYW1d7DEKlYnqD/yEk4sm75zShIRNjehSZovnerdc
         KbCgaLHzwH6CC7WztK+d5/9yA2bJq7C+fFEFUc1OwfJn7E/86QUHRhFiJkmbz5YX02w9
         TlTtuqDJsg6kBPyQbsvriK2cQBR9ZDMNMMpzdu197gOMvPv/3KuUc2xGUrcJVKoOwD2T
         3lFKrb9Gi++itfaU6OSZ1ISd8KE7I2CQeVOc6G7K6Ksz6TEMBZer2ZaN63DMoAkJ0V15
         4Xmg==
X-Gm-Message-State: ACrzQf0J+LJ5M+4uMvbZ8HSWHkdyzRRoo1H5KB8sw4dN/bNQsJ6yBj/p
        T9DaKmK/xFT1UMcTNvWSWeo=
X-Google-Smtp-Source: AMsMyM43YjuMwCaleKKs1cUD4azqm2z4uSNdjyP+In5n3rA6BzDa1T7rqoe5s3kpvH8ZJsuEftGT1w==
X-Received: by 2002:a2e:bd84:0:b0:261:e43c:bac3 with SMTP id o4-20020a2ebd84000000b00261e43cbac3mr948211ljq.198.1666092442765;
        Tue, 18 Oct 2022 04:27:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id a13-20020a056512200d00b00494747ba5f7sm871239lfb.272.2022.10.18.04.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 04:27:22 -0700 (PDT)
Message-ID: <b7017e04-83a0-da3e-4ea7-28a2d34febc8@gmail.com>
Date:   Tue, 18 Oct 2022 14:27:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com> <20221009133351.6ff4894b@jic23-huawei>
 <Y0O4fiQQX0M317h/@smile.fi.intel.com>
 <7abed64a-d544-a228-b5f1-4c7b5a3bd1be@fi.rohmeurope.com>
 <20221014142232.000038df@huawei.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
In-Reply-To: <20221014142232.000038df@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4gMv0C3L61qmx3ZacxO1Z5Jl"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4gMv0C3L61qmx3ZacxO1Z5Jl
Content-Type: multipart/mixed; boundary="------------0gI0QoRP0GR4Sjgy3w8XGLWs";
 protected-headers="v1"
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jagath Jog J <jagathjog1996@gmail.com>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Cosmin Tanislav <demonsingur@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <b7017e04-83a0-da3e-4ea7-28a2d34febc8@gmail.com>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com> <20221009133351.6ff4894b@jic23-huawei>
 <Y0O4fiQQX0M317h/@smile.fi.intel.com>
 <7abed64a-d544-a228-b5f1-4c7b5a3bd1be@fi.rohmeurope.com>
 <20221014142232.000038df@huawei.com>
In-Reply-To: <20221014142232.000038df@huawei.com>

--------------0gI0QoRP0GR4Sjgy3w8XGLWs
Content-Type: multipart/mixed; boundary="------------bOnQeiGSDSF001z1S8pmOM0r"

--------------bOnQeiGSDSF001z1S8pmOM0r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMTQvMjIgMTY6MjIsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFR1ZSwg
MTEgT2N0IDIwMjIgMDk6MTA6MjEgKzAwMDANCj4gIlZhaXR0aW5lbiwgTWF0dGkiIDxNYXR0
aS5WYWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDEwLzEw
LzIyIDA5OjE1LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24gU3VuLCBPY3QgMDks
IDIwMjIgYXQgMDE6MzM6NTFQTSArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+
Pj4gT24gVGh1LCA2IE9jdCAyMDIyIDIxOjMyOjExICswMzAwIEFuZHkgU2hldmNoZW5rbw0K
Pj4+PiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+
IE9uIFRodSwgT2N0IDA2LCAyMDIyIGF0IDA1OjM4OjE0UE0gKzAzMDAsIE1hdHRpIFZhaXR0
aW5lbiB3cm90ZToNCj4+Pg0KPj4+IC4uLg0KPj4+ICAgIA0KPj4+Pj4+ICttb2R1bGVfcGFy
YW0oZ19reDAyMmFfdXNlX2J1ZmZlciwgYm9vbCwgMCk7DQo+Pj4+Pj4gK01PRFVMRV9QQVJN
X0RFU0MoZ19reDAyMmFfdXNlX2J1ZmZlciwgKwkJICJCdWZmZXIgc2FtcGxlcy4gVXNlDQo+
Pj4+Pj4gYXQgb3duIHJpc2suIEZpZm8gbXVzdCBub3Qgb3ZlcmZsb3ciKTsNCi8vIHNuaXAN
Cg0KPj4gVGhpcyB3b3VsZCBiZSBhIHdheSB0byBoYXZlIHRoZSBGSUZPIGRpc2FibGVkIGJ5
IGRlZmF1bHQgYW5kIHdhcm4gdXNlcnMNCj4+IHZpYSBkdC1iaW5kaW5nIGRvY3MgaWYgdGhl
eSBkZWNpZGUgdG8gZXhwbGljaXRseSBlbmFibGUgdGhlIEZJRk8uDQo+PiAoQmVzaWRlcywg
SSBiZWxpZXZlIHRoZSBGSUZPIGlzIHVzYWJsZSBvbiBhdCBsZWFzdCBzb21lIG9mIHRoZSBL
aW9uaXgNCj4+IHNlbnNvcnMgLSBiZWNhdXNlIEkndmUgaGVhcmQgaXQgaXMgdXNlZCBvbiBh
IGZldyBwbGF0Zm9ybXMpLg0KPj4NCj4+IFRoaXMgY291bGQgZ2l2ZSB1cyBzYWZlIGRlZmF1
bHRzIHdoaWxlIG5vdCBzaHV0dGluZyB0aGUgZG9vcnMgZnJvbSB0aG9zZQ0KPj4gd2hvIHdp
c2ggdG8gdXNlIHRoZSBGSUZPLiBTdXJlIHdlIG5lZWQgYSBidXktaW4gZnJvbSBLcnp5c3p0
b2YgLyBSb2IsDQo+PiBidXQgdGhhdCBtYXkgYmUgbGVzcyBvZiBhbiBvYnN0YWNsZSBjb21w
YXJlZCB0byB0aGUgbW9kdWxlIHBhcmFtIGlmIEdyZWcNCj4+IGlzIHNvIHN0cm9uZ2x5IG9w
cHNvaW5nIHRob3NlLiAoQW5kIHRoZSBkdC1wcm9wZXJ0eSBjb3VsZCBhbHNvIHByb3ZpZGUN
Cj4+IHNvbWUgdGVjaG5pY2FsIG1lcml0ZXMgYXMgdGhlc2Ugc2Vuc29ycyBzZWVtIHRvIHJl
YWxseSBoYXZlIGRpZmZlcmVuY2llcw0KPj4gaW4gRklGT3MpLg0KPiANCj4gSSdtIGR1Ymlv
dXMgYWJvdXQgaGF2aW5nIHRoaXMgZm9yIGtub3duIGJyb2tlbiBwYXJ0cyAtIGJ1dCBJIGd1
ZXNzIHlvdQ0KPiBjYW4gcHJvcG9zZSBpdCBhbmQgc2VlIHdoYXQgdGhlIGR0LW1haW50YWlu
ZXJzIHNheS4NCj4gDQo+IEkgZG9uJ3Qgd2FudCB0byBzZWUgZmlmbyBzaXplIGluIHRoZSBk
dCBiaW5kaW5nIHRob3VnaC4NCg0KLy8gc25pcA0KDQo+Pj4gQWxzbyBpdCBuZWVkcyBzb21l
IGNvbW11bmljYXRpb24NCj4+PiAgIHdpdGggYSB2ZW5kb3IgdG8gY2xhcmlmeSB0aGUgdGhp
bmdzLg0KPj4NCj4+IEkgZG8gY29tbXVuaWNhdGlvbiB3aXRoIHRoZSB2ZW5kb3Igb24gYSBk
YWlseSBiYXNpcyA6XSBOb3dhZGF5cyBLaW9uaXgNCj4+IGlzIHBhcnQgb2YgUk9ITSwgYW5k
IEZpbmxhbmQgU1dEQyBoYXMgYmVlbiBjb2xsYWJvcmF0aW9uIHdpdGggS2lvbml4DQo+PiBl
dmVuIGJlZm9yZSB0aGV5ICJtZXJnZWQiIChidXQgSSBoYXZlIG5vdCBiZWVuIHBhcnQgb2Yg
dGhlICJzZW5zb3IgdGVhbSINCj4+IGJhY2sgdGhlbikuDQo+Pg0KPj4gVW5mb3J0dW5hdGVs
eSwgcmVhY2hpbmcgdGhlIGNvcnJlY3QgcGVvcGxlIGluc2lkZSB0aGUgY29tcGFueSBpcyBo
YXJkDQo+PiBhbmQgb2NjYXNpb25hbGx5IGltcG9zc2libGUgLSBsb25nIHN0b3J5Li4uDQo+
IA0KPiA6KQ0KDQpKdXN0IGEgbm90ZS4gSSBoYXZlIGRvbmUgc29tZSBmdXJ0aGVyIGludmVz
dGlnYXRpb24gKGZ1cnRoZXIgdGVzdGluZyANCmNvbWJpbmVkIHdpdGggdHJhY2luZyB0aGUg
U1BJIGxpbmVzKSBhbmQgYWxzbyBnb3Qgc29tZSBhbnN3ZXIocykgZnJvbSANCnRoZSBBU0lD
IGRlc2lnbmVycy4gRmlyc3QgdGhpbmcgaXMgdGhhdCB0aGUgdW5kZXJseWluZyBGSUZPIGlz
IDI1OCBieXRlcyANCmFuZCBjYW4gaG9sZCB1cC10byA0MyBIaVJlcyBzYW1wbGVzLiBUaGlz
IGlzIGFsc28gZml4ZWQgaW4gdGhlIHJlY2VudCANCmRhdGEtc2hlZXQuIFRoZSByZWdpc3Rl
ciBpbmZvcm1pbmcgaG93IG1hbnkgYnl0ZXMgb2YgZGF0YSBpcyBzdG9yZWQgaW4gDQpGSUZP
IGlzIHN0aWxsIG9ubHkgOGJpdHMuIFdoZW4gRklGTyBpcyBmdWxsLCB0aGUgbWFnaWMgdmFs
dWUgMjU1IGlzIHVzZWQgDQp0byBpbmRpY2F0ZSB0aGUgMjU4IGJ5dGVzIG9mIGRhdGEuIFRo
aXMgZXhwbGFpbnMgdGhlIHN0cmFuZ2UgNDIsNSANCnNhbXBsZXMgKDI1NSBieXRlcykgb2Yg
ZGF0YSBiZWluZyByZXBvcnRlZC4NCg0KRnVydGhlcm1vcmUsIEkndmUgbm90aWNlZCB0aGF0
IHRoZSBGSUZPIGFwcGVhcmluZyB0byBiZSAic3R1Y2siLCBlZy4gDQphbW91bnQgb2YgZGF0
YSBzdG9yZWQgaW4gRklGTyBub3QgZGVjcmVhc2luZyB3aGVuIGRhdGEgaXMgcmVhZCBpcyAx
MDAlIA0KcmVwcm9kdWNpYmxlLiBUaGUgY29uZGl0aW9uIGlzIHRoYXQgdGhlIFBDMSBiaXQg
KGFjY2VsZXJvbWV0ZXIgc3RhdGUgDQpjb250cm9sKSBpcyB0b2dnbGVkIGJlZm9yZSB0aGUg
RklGTyBpcyByZWFkLiBUaGUgaXNzdWUgZG9lcyBub3Qgc2VlbSB0byANCmJlIHJlcHJvZHVj
aWJsZSBpZiB0aGUgUEMxIGlzIG5vdCB0b3VjaGVkLiBJIGhhdmUgYWxzbyBhc2tlZCBpZiB0
aGlzIGlzIA0KYSBrbm93biBsaW1pdGF0aW9uLg0KDQpBbnl3YXlzLCBpdCBzZWVtcyB3ZSBo
YXZlIGEgc29sdXRpb24gdG8gdGhlIHByb2JsZW0uIFdlIHNpbXBseSBoYW5kbGUgDQp0aGUg
Y2FzZSB3aGVuIDI1NSBieXRlcyBpcyByZXBvcnRlZCBjb3JyZWN0bHkgKGJ5IHJlYWRpbmcg
MjU4IGJ5dGVzIG9mIA0KdmFsaWQgZGF0YSkgLSBhbmQgd2UgcHJldmVudCBjaGFuZ2luZyB0
aGUgc2Vuc29yIGNvbmZpZ3VyYXRpb24gd2hlbiBGSUZPIA0KaXMgZW5hYmxlZC4NCg0KSSB3
aWxsIGltcGxlbWVudCB0aGVzZSBjaGFuZ2VzIHRvIHRoZSB2MyBhbmQgZHJvcCBib3RoIHRo
ZSBtb2R1bGUtcGFyYW0gDQphbmQgdGhlIGR0LXByb3BlcnR5LiBTb3JyeSBmb3IgdGhlIGhh
c3NsZSBhbmQgdGhhbmtzIGZvciB0aGUgDQpwYXRpZW5jZS9zdXBwb3J0IQ0KDQpZb3Vycw0K
CS0tIE1hdHRpDQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxv
cGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRo
aW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAh
IH5+DQoNCg==
--------------bOnQeiGSDSF001z1S8pmOM0r
Content-Type: application/pgp-keys; name="OpenPGP_0x40497F0C4693EF47.asc"
Content-Disposition: attachment; filename="OpenPGP_0x40497F0C4693EF47.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
bJdDT4nPrGpMQWvFLTScS7sTfKC8lx6/+/w=3D
=3DfJFG
-----END PGP PUBLIC KEY BLOCK-----

--------------bOnQeiGSDSF001z1S8pmOM0r--

--------------0gI0QoRP0GR4Sjgy3w8XGLWs--

--------------4gMv0C3L61qmx3ZacxO1Z5Jl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmNOjZgFAwAAAAAACgkQeFA3/03aocX0
IAf+Jkwe4d/cVohaolGpaIrsOHqicu+SCYyaJ6EaE23glvQ3GfMdQqOp8GyB/h9cw4Owq3ErI3Rg
39dxP+3cugtZz00iB/AsNi9qYX2IC01PcfaxdETNgmzbMqL8A6xRgBeqD/TtYiZxI8TCyhHNIJRh
Mxjj3O/nVx2rCQH1at2mVMxUugKY1+UMH6bQIphD8QZIE3ZbrFLCqNVQij6EPaWtRZZZQyISbCuY
1qqD6rXOwdjHQdRlVZrJA8Fm65zirA/r8RSobNd2ZwwCtfGKxsPB5ICMJHF+Ful/dxaAkcI2FknA
32MyUsuLoIYJGk+6we/dBLSmoZYOh8Nuhg9t1m5UzA==
=Ntnq
-----END PGP SIGNATURE-----

--------------4gMv0C3L61qmx3ZacxO1Z5Jl--
