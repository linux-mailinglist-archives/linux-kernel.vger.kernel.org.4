Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995115EE086
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiI1PdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiI1Pcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:32:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9E6B657
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:31:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id iv17so8748621wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:from:to:cc:subject:date;
        bh=kriaUEf4JEywb4Ib5jbgNEOAcF/BvPck0+JYhHyPu6g=;
        b=J5+w5EspMByoHZe03InWfai3nhk/OV+j39WSMUjmATdmIpwH7qM6CKFo9BtoHSklD2
         ejr5q69GRapkU+P/2M4khoigP7vN7vj9m0AlCh7gD3doBtkJv5jrCfqbnWsN4zhwr4PB
         Eu+C/UDh1UkI3Hg0eA1UBk6gKI+IUO0eMCg5vFeMM8BdSGju5cZzV19vOwV8ur98XQgE
         +uzEEYYchvXNgGOB9de2qMGAFP738L2YQJSlpHFZ2ECkVLI64j7lFFjMFC2jGsHDX3sS
         BeW4tIXVqQAdq+xJDCfVkLyYSMz5qVWCo88ystnlZwWQADl9phDXaINO3FyNRZotcNqj
         Q5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kriaUEf4JEywb4Ib5jbgNEOAcF/BvPck0+JYhHyPu6g=;
        b=4gYLrhhSEGh0YZGLtD+qaA//oWcbe348ZYK8cxJJlHohzpw4uS0DekDIKlcO7krbe9
         HITErbdxtMHt6CERtArGumTXFNP6f1m8w5eTT/KipLYn/rsQM/psv44qEWyQWc6pCAoE
         IOPSrX45f6VA4ccXsm5to6+3C13lHy0S4YC2dVTYPRS0fkSlKLALqBErWaaPyzJNkjJW
         T02PK6mMxSBylO6JvWNk+9/kCEOV2+TCiPBCEzYkdlTN3JWT1+Ap9YR4F1NDoyTeHxIS
         mHoLuzjMSWZgIqvRrXZaYhGEXhmRZy4Od4hYUkpgLKTGfJ9FD2nG8kCKjzGefZl/3VgW
         Vjqg==
X-Gm-Message-State: ACrzQf2ISGfb3GvVqnVIiUfbVAHMSNhBLwVJ2lptyPPwv7ZPxWq7IIYr
        RSvQjVl+Gmk9CMTTd5J1p18jTw==
X-Google-Smtp-Source: AMsMyM6UWDHYzfevSWZAOtA0vGyXDTwzRqc9tWhXsli4qp+wX94hkGdnUsaVdDb4E68WBlb6MhR1WA==
X-Received: by 2002:a05:600c:114f:b0:3b4:9a0a:6204 with SMTP id z15-20020a05600c114f00b003b49a0a6204mr7322303wmz.132.1664379085731;
        Wed, 28 Sep 2022 08:31:25 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0022acb7195aesm4514561wrq.33.2022.09.28.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:31:24 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-4-yu.tu@amlogic.com>
 <1jiln0yzgj.fsf@starbuckisacylon.baylibre.com>
 <ed4038fb-c230-fc27-800c-c99bd1770a1c@amlogic.com>
 <4e3cdd6b-5861-8a4f-1df7-af763f77bad5@amlogic.com>
 <1jsflftm1y.fsf@starbuckisacylon.baylibre.com>
 <0c7e6d90-2ce3-25ab-84b6-026ce8a238a8@amlogic.com>
 <1jtu5uz0ry.fsf@starbuckisacylon.baylibre.com>
 <9f9cf980-c0c6-d5c3-ced8-8ab50e392470@amlogic.com>
 <21e14cc1-6b34-e6b0-8da2-ad4b34dac149@amlogic.com>
User-agent: mu4e 1.8.7; emacs 28.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 3/6] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Wed, 28 Sep 2022 17:27:07 +0200
In-reply-to: <21e14cc1-6b34-e6b0-8da2-ad4b34dac149@amlogic.com>
Message-ID: <1jy1u3zfas.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQgMjEgU2VwIDIwMjIgYXQgMTY6NDAsIFl1IFR1IDx5dS50dUBhbWxvZ2ljLmNvbT4g
d3JvdGU6DQoNCj4gSGkgSmVyb21l77yMDQo+DQo+IE9uIDIwMjIvOC8zMCAxNTozNywgWXUgVHUg
d3JvdGU6DQo+PiBPbiAyMDIyLzgvMzAgMTQ6NDQsIEplcm9tZSBCcnVuZXQgd3JvdGU6DQo+Pj4g
WyBFWFRFUk5BTCBFTUFJTCBdDQo+Pj4NCj4+Pg0KPj4+IE9uIFR1ZSAzMCBBdWcgMjAyMiBhdCAx
NDoxMywgWXUgVHUgPHl1LnR1QGFtbG9naWMuY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBPbiAyMDIy
LzgvMjkgMTc6NDgsIEplcm9tZSBCcnVuZXQgd3JvdGU6DQo+Pj4+PiBbIEVYVEVSTkFMIEVNQUlM
IF0NCj4+Pj4+IE9uIE1vbiAxNSBBdWcgMjAyMiBhdCAyMToyMCwgWXUgVHUgPHl1LnR1QGFtbG9n
aWMuY29tPiB3cm90ZToNCj4+Pj4+DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICtzdGF0aWMgc3Ry
dWN0IGNsa19yZWdtYXAgczRfaGRtaV9wbGxfZGNvID0gew0KPj4+Pj4+Pj4+ICvCoMKgwqAgLmRh
dGEgPSAmKHN0cnVjdCBtZXNvbl9jbGtfcGxsX2RhdGEpew0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCAuZW4gPSB7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJlZ19vZmYg
PSBBTkFDVFJMX0hETUlQTExfQ1RSTDAsDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLnNoaWZ0wqDCoCA9IDI4LA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53
aWR0aMKgwqAgPSAxLA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9LA0KPj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCAubSA9IHsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAu
cmVnX29mZiA9IEFOQUNUUkxfSERNSVBMTF9DVFJMMCwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAuc2hpZnTCoMKgID0gMCwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAud2lkdGjCoMKgID0gOCwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgLm4gPSB7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLnJlZ19vZmYgPSBBTkFDVFJMX0hETUlQTExfQ1RSTDAsDQo+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLnNoaWZ0wqDCoCA9IDEwLA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC53aWR0aMKgwqAgPSA1LA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9
LA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuZnJhYyA9IHsNCj4+Pj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAucmVnX29mZiA9IEFOQUNUUkxfSERNSVBMTF9DVFJMMSwNCj4+Pj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2hpZnTCoMKgID0gMCwNCj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAud2lkdGjCoMKgID0gMTcsDQo+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0sDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5sID0gew0KPj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkww
LA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zaGlmdMKgwqAgPSAzMSwNCj4+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAud2lkdGjCoMKgID0gMSwNCj4+Pj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLnJzdCA9IHsN
Cj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVnX29mZiA9IEFOQUNUUkxfSERN
SVBMTF9DVFJMMCwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2hpZnTCoMKg
ID0gMjksDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLndpZHRowqDCoCA9IDEs
DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0sDQo+Pj4+Pj4+Pj4gK8KgwqDCoCB9LA0KPj4+
Pj4+Pj4+ICvCoMKgwqAgLmh3LmluaXQgPSAmKHN0cnVjdCBjbGtfaW5pdF9kYXRhKXsNCj4+Pj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgLm5hbWUgPSAiaGRtaV9wbGxfZGNvIiwNCj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLm9wcyA9ICZtZXNvbl9jbGtfcGxsX3JvX29wcywNCj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLnBhcmVudF9kYXRhID0gKGNvbnN0IHN0cnVjdCBjbGtfcGFyZW50X2Rh
dGEgW10pIHsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IC5md19uYW1lID0g
Inh0YWwiLCB9DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0sDQo+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIC5udW1fcGFyZW50cyA9IDEsDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8q
DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBEaXNwbGF5IGRpcmVjdGx5IGhhbmRsZSBo
ZG1pIHBsbCByZWdpc3RlcnMgQVRNLCB3ZSBuZWVkDQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBOT0NBQ0hFIHRvIGtlZXAgb3VyIHZpZXcgb2YgdGhlIGNsb2NrIGFzIGFjY3VyYXRlIGFz
DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBwb3NzaWJsZQ0KPj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgICovDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSXMgaXQgcmVhbGx5ID8NCj4+Pj4+
Pj4+DQo+Pj4+Pj4+PiBHaXZlbiB0aGF0IEhETUkgc3VwcG9ydCBmb3IgdGhlIHM0IGlzIHRoZXJl
IHlldCwgdGhlDQo+Pj4+Pj4+PiBhZGRyZXNzZXMgaGF2ZSBjaGFuZ2VzIGFuZCB0aGUgcmVnaW9u
IGlzIG5vIGxvbmdlciBhIHN5c2NvbiwgaXQgaXMNCj4+Pj4+Pj4+IHRpbWUNCj4+Pj4+Pj4+IGZv
ciB0aGUgSERNSSBkcml2ZXIgdG8gZ2V0IGZpeGVkLg0KPj4+Pj4+IFRoZSBIRE1JIFBMTCBpcyBj
b25maWd1cmVkIGluIHRoZSBVYm9vdCBwaGFzZSBhbmQgZG9lcyBub3QgY2hhbmdlIHRoZQ0KPj4+
Pj4+IGZyZXF1ZW5jeSBpbiB0aGUga2VybmVsIHBoYXNlLiBTbyB3ZSB1c2UgdGhlIE5PQ0FDSEUg
ZmxhZyBhbmQNCj4+Pj4+PiAicm9fb3BzIi4NCj4+Pj4+IFRoYXQncyBubyByZWFzb24gdG8gcHV0
IE5PQ0FDSEUgb3Igcm8tb3BzDQo+Pj4+PiBJZiB5b3Ugd2FudCB0aGUgZnJlcXVlbmNpZXMgdG8g
YmUgc3RhdGljYWxseSBhc3NpbmdlZCwgdGhlIGNvcnJlY3Qgd2F5DQo+Pj4+PiB3b3VsZCBiZSB0
aHJvdWdoIGFzc2lnbmVkLXJhdGUgaW4gRFQgSSBndWVzcy4NCj4+Pj4NCj4+Pj4gT2theS4gWW91
J3JlIHJpZ2h0LiBIb3dldmVyLCB3aGVuIHJlZ2lzdGVyaW5nIHdpdGggT1BTLCBIRE1JIFBMTCB3
aWxsIGJlDQo+Pj4+IHJlc2V0LiBJdCB0YWtlcyB0aW1lIGZvciBQTEwgdG8gc3RhYmlsaXplIHRo
ZSBvdXRwdXQgZnJlcXVlbmN5LCB3aGljaA0KPj4+PiB3aWxsDQo+Pj4+IGxlYWQgdG8gdGhlIHN0
YXJ0dXAgc2NyZWVuIGZsYXNoaW5nLg0KPj4+Pg0KPj4+PiBJIHdvdWxkIGxpa2UgdG8ga25vdyBo
b3cgdG8gc29sdmUgdGhpcyBwcm9ibGVtIGlmIG5vdCB1c2luZyByb19vcHMuDQo+Pj4+DQo+Pj4+
Pg0KPj4+DQo+Pj4gWW91IGNhbiBhZGQgbmV3IG9wcyBvciB0d2VhayB0aGUgY3VycmVudCBpbml0
IGZ1bmN0aW9uLg0KPj4gSERNSSBQTEwgaXMgbm90IGRpZmZlcmVudCBmcm9tIG90aGVyIFBMTFMs
IHNvIEkgdGhpbmsgYWRkaW5nIE9QUyBpcw0KPj4gd2VpcmQuDQo+PiANCj4+Pg0KPj4+IFNhZmVz
dCB3b3VsZCBiZSB0byBkbyB0aGUgZm9sbG93aW5nIDoNCj4+PiDCoCAqIENoZWNrIGlmIHRoZSBQ
TExzIGlzIGFscmVhZHkgb24uDQo+Pj4gwqAgKiBDaGVjayBpZiB0aGUgJ3BsbC0+aW5pdF9yZWdz
JyBtYXRjaGVzIHdoYXQgaXMgYWxyZWFkeSBzZXQNCj4+PiDCoMKgwqAgLSBpZiBzbywgeW91IGNh
biBza2lwIHRoZSByZXNldA0KPj4+IMKgwqDCoCAtIGlmIG5vdCwgeW91IG5lZWQgdG8gcmVzZXQg
YXMgdXN1YWwNCj4+IHN0YXRpYyBpbnQgbWVzb25fY2xrX3BsbF9pbml0KHN0cnVjdCBjbGtfaHcg
Kmh3KQ0KPj4gew0KPj4gIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjbGtfcmVnbWFwICpjbGsgPSB0
b19jbGtfcmVnbWFwKGh3KTsNCj4+ICDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWVzb25fY2xrX3Bs
bF9kYXRhICpwbGwgPSBtZXNvbl9jbGtfcGxsX2RhdGEoY2xrKTsNCj4+ICDCoMKgwqDCoMKgwqDC
oCBpZiAocGxsLT5pbml0X2NvdW50KSB7DQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG1lc29uX3Bhcm1fd3JpdGUoY2xrLT5tYXAsICZwbGwtPnJzdCwgMSk7DQo+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZ21hcF9tdWx0aV9yZWdfd3JpdGUoY2xrLT5tYXAs
IHBsbC0+aW5pdF9yZWdzLA0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgIHBsbC0+aW5pdF9jb3VudCk7
DQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lc29uX3Bhcm1fd3JpdGUoY2xr
LT5tYXAsICZwbGwtPnJzdCwgMCk7DQo+PiAgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gIMKgwqDCoMKg
wqDCoMKgIHJldHVybiAwOw0KPj4gfQ0KPj4gQmVjYXVzZSB0aGUgaW5pdCBmdW5jdGlvbiBsb29r
cyBsaWtlIHRoaXMuIFRoZXJlZm9yZSwgSERNSSBQTEwgaW5pdF9jb3VudA0KPj4gaXMgbm90IGdp
dmVuLg0KDQpJIGRvbid0IGdldCB0aGUgcmVtYXJrLiBZb3UndmUgZ290IHBsbC0+aW5pdF9jb3Vu
dCByaWdodCB0aGVyZS4NCg0KPj4gQ2FuIEkgY2hhbmdlIGl0IGxpa2UgdGhpcz8NCg0KV2hhdCBj
aGFuZ2UgPyBUaGUgZnVuY3Rpb24gYWJvdmUgbG9va3MgYSBsb3QgbGlrZSAgbWVzb25fY2xrX3Bs
bF9pbml0KCkNCmluIHRoZSBhY3R1YWwgc291cmNlDQoNCj4NCj4gSSBkb24ndCBrbm93IGlmIHRo
aXMgY2hhbmdlIG1lZXRzIHlvdXIgcmVxdWlyZW1lbnRzPyBQbGVhc2UgZ2l2ZSB1cyB5b3VyDQo+
IHZhbHVhYmxlIGFkdmljZS4NCg0KV2hhdCBjaGFuZ2UgPw0K
