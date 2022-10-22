Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2F608D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJVM3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJVM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:29:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54332ED4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 05:29:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso3717892wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRO8HCoBqCcl0Go6lRdDGnZm8arfIjmfMrFhGRwKbpo=;
        b=MePstHCb8fX8v971JJ4iMdtEC1y6713B85zS+vXafVbm4ZPU5I9DP2T8RY+gP4yRoJ
         O8BTEY5p1hbkVsHf/UiDodotalTrkoFYQ/OA9fznt5lCKqihleXqsatC2C86f8s+ZPh+
         USxObwrTA8blR5bOzOp6UK6Kmz99Y8+VDtxMZYWfk2DSzoZ4dOUIXZ0UHl7rz2PO88xE
         XSMzlVuT6OSYbdAiipsAnUA+k1e3svUMXMKYhPd42r2nHuGu4lfO5tHwxlxwjfvMtvnE
         S+zMtrH17TG4c4UBfNP2RrrHZqMIvUDJoUoJEKCgvq23p0OrYsPZylZB9FILsBdQmvj+
         yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRO8HCoBqCcl0Go6lRdDGnZm8arfIjmfMrFhGRwKbpo=;
        b=yevLq9pzW5w9cuz1EcCPGf/bLSRcHbxOwz38BC0MBMaoJn+yqRQ9ocY6kGty+AYEMg
         pusw8tTFv4sidwxfmPHl2KhXiArIn9zdXkvQ/wOTuWBADPgb9W/xZhjLo+cu+C7j5yEC
         XEadp+/laYj/FMDnz8WOKmi349reb5qNeVYjz/j22m90GbQO0FMrMh/owmbGQFW7ebVa
         27aXF8pAGS7rYgtsrROnXWeXXfL4uAo7sCZFtkAvRkQ5UAK3Ner/yRmtojobIOh86KtA
         DIuulj89IoAr9J+Y5jAviHw559Fb6MkBt5S74hdxsf3W5bcc2kT+DlLA6tCBT4vD1Evz
         b4kQ==
X-Gm-Message-State: ACrzQf3nMLI/RnQDKnJ8fDLO3wrrIoWo1aXPT2sIBVNaTmyChx9PKf8G
        /YDhOfSEKmm8XII7sfvVXNESQQ==
X-Google-Smtp-Source: AMsMyM5rfjFg6EX2mdQ0H51lHOEFCd8F4UaUmdrql71YP0dU+ezrVI4ZXiGjfq47KPALDB7+ZKRuMA==
X-Received: by 2002:a05:600c:3c84:b0:3b4:eff4:ab69 with SMTP id bg4-20020a05600c3c8400b003b4eff4ab69mr37007484wmb.104.1666441761905;
        Sat, 22 Oct 2022 05:29:21 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c091d00b003c21ba7d7d6sm5125438wmp.44.2022.10.22.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:29:21 -0700 (PDT)
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
 <1jy1u3zfas.fsf@starbuckisacylon.baylibre.com>
 <095f1bd9-c390-196f-cccc-700d75c70cb0@amlogic.com>
User-agent: mu4e 1.8.10; emacs 28.2
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
Date:   Sat, 22 Oct 2022 14:22:15 +0200
In-reply-to: <095f1bd9-c390-196f-cccc-700d75c70cb0@amlogic.com>
Message-ID: <1j4jvwavoe.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUgMjkgU2VwIDIwMjIgYXQgMTU6MDcsIFl1IFR1IDx5dS50dUBhbWxvZ2ljLmNvbT4g
d3JvdGU6DQoNCj4gSGkgSmVyb21lLA0KPiAJVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KPg0K
PiBPbiAyMDIyLzkvMjggMjM6MjcsIEplcm9tZSBCcnVuZXQgd3JvdGU6DQo+PiBbIEVYVEVSTkFM
IEVNQUlMIF0NCj4+IE9uIFdlZCAyMSBTZXAgMjAyMiBhdCAxNjo0MCwgWXUgVHUgPHl1LnR1QGFt
bG9naWMuY29tPiB3cm90ZToNCj4+IA0KPj4+IEhpIEplcm9tZe+8jA0KPj4+DQo+Pj4gT24gMjAy
Mi84LzMwIDE1OjM3LCBZdSBUdSB3cm90ZToNCj4+Pj4gT24gMjAyMi84LzMwIDE0OjQ0LCBKZXJv
bWUgQnJ1bmV0IHdyb3RlOg0KPj4+Pj4gWyBFWFRFUk5BTCBFTUFJTCBdDQo+Pj4+Pg0KPj4+Pj4N
Cj4+Pj4+IE9uIFR1ZSAzMCBBdWcgMjAyMiBhdCAxNDoxMywgWXUgVHUgPHl1LnR1QGFtbG9naWMu
Y29tPiB3cm90ZToNCj4+Pj4+DQo+Pj4+Pj4gT24gMjAyMi84LzI5IDE3OjQ4LCBKZXJvbWUgQnJ1
bmV0IHdyb3RlOg0KPj4+Pj4+PiBbIEVYVEVSTkFMIEVNQUlMIF0NCj4+Pj4+Pj4gT24gTW9uIDE1
IEF1ZyAyMDIyIGF0IDIxOjIwLCBZdSBUdSA8eXUudHVAYW1sb2dpYy5jb20+IHdyb3RlOg0KPj4+
Pj4+Pg0KPj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4gK3N0YXRpYyBzdHJ1Y3QgY2xrX3JlZ21h
cCBzNF9oZG1pX3BsbF9kY28gPSB7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgIC5kYXRhID0gJihzdHJ1
Y3QgbWVzb25fY2xrX3BsbF9kYXRhKXsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuZW4g
PSB7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVnX29mZiA9IEFOQUNU
UkxfSERNSVBMTF9DVFJMMCwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5z
aGlmdMKgwqAgPSAyOCwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53aWR0
aMKgwqAgPSAxLA0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0sDQo+Pj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLm0gPSB7DQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAucmVnX29mZiA9IEFOQUNUUkxfSERNSVBMTF9DVFJMMCwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5zaGlmdMKgwqAgPSAwLA0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLndpZHRowqDCoCA9IDgsDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
fSwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAubiA9IHsNCj4+Pj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLA0KPj4+
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnNoaWZ0wqDCoCA9IDEwLA0KPj4+Pj4+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLndpZHRowqDCoCA9IDUsDQo+Pj4+Pj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuZnJhYyA9
IHsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RS
TF9IRE1JUExMX0NUUkwxLA0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnNo
aWZ0wqDCoCA9IDAsDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAud2lkdGjC
oMKgID0gMTcsDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCAubCA9IHsNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLA0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLnNoaWZ0wqDCoCA9IDMxLA0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLndpZHRowqDCoCA9IDEsDQo+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
fSwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAucnN0ID0gew0KPj4+Pj4+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJlZ19vZmYgPSBBTkFDVFJMX0hETUlQTExfQ1RSTDAsDQo+
Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2hpZnTCoMKgID0gMjksDQo+Pj4+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAud2lkdGjCoMKgID0gMSwNCj4+Pj4+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCB9LA0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoCB9LA0KPj4+Pj4+Pj4+
Pj4gK8KgwqDCoCAuaHcuaW5pdCA9ICYoc3RydWN0IGNsa19pbml0X2RhdGEpew0KPj4+Pj4+Pj4+
Pj4gK8KgwqDCoMKgwqDCoMKgIC5uYW1lID0gImhkbWlfcGxsX2RjbyIsDQo+Pj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqAgLm9wcyA9ICZtZXNvbl9jbGtfcGxsX3JvX29wcywNCj4+Pj4+Pj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoCAucGFyZW50X2RhdGEgPSAoY29uc3Qgc3RydWN0IGNsa19wYXJlbnRf
ZGF0YSBbXSkgew0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeyAuZndfbmFt
ZSA9ICJ4dGFsIiwgfQ0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0sDQo+Pj4+Pj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgLm51bV9wYXJlbnRzID0gMSwNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCAvKg0KPj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBEaXNwbGF5IGRpcmVj
dGx5IGhhbmRsZSBoZG1pIHBsbCByZWdpc3RlcnMgQVRNLCB3ZSBuZWVkDQo+Pj4+Pj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoCAqIE5PQ0FDSEUgdG8ga2VlcCBvdXIgdmlldyBvZiB0aGUgY2xvY2sg
YXMgYWNjdXJhdGUgYXMNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogcG9zc2libGUN
Cj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+
IElzIGl0IHJlYWxseSA/DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEdpdmVuIHRoYXQgSERNSSBz
dXBwb3J0IGZvciB0aGUgczQgaXMgdGhlcmUgeWV0LCB0aGUNCj4+Pj4+Pj4+Pj4gYWRkcmVzc2Vz
IGhhdmUgY2hhbmdlcyBhbmQgdGhlIHJlZ2lvbiBpcyBubyBsb25nZXIgYSBzeXNjb24sIGl0IGlz
DQo+Pj4+Pj4+Pj4+IHRpbWUNCj4+Pj4+Pj4+Pj4gZm9yIHRoZSBIRE1JIGRyaXZlciB0byBnZXQg
Zml4ZWQuDQo+Pj4+Pj4+PiBUaGUgSERNSSBQTEwgaXMgY29uZmlndXJlZCBpbiB0aGUgVWJvb3Qg
cGhhc2UgYW5kIGRvZXMgbm90IGNoYW5nZSB0aGUNCj4+Pj4+Pj4+IGZyZXF1ZW5jeSBpbiB0aGUg
a2VybmVsIHBoYXNlLiBTbyB3ZSB1c2UgdGhlIE5PQ0FDSEUgZmxhZyBhbmQNCj4+Pj4+Pj4+ICJy
b19vcHMiLg0KPj4+Pj4+PiBUaGF0J3Mgbm8gcmVhc29uIHRvIHB1dCBOT0NBQ0hFIG9yIHJvLW9w
cw0KPj4+Pj4+PiBJZiB5b3Ugd2FudCB0aGUgZnJlcXVlbmNpZXMgdG8gYmUgc3RhdGljYWxseSBh
c3NpbmdlZCwgdGhlIGNvcnJlY3Qgd2F5DQo+Pj4+Pj4+IHdvdWxkIGJlIHRocm91Z2ggYXNzaWdu
ZWQtcmF0ZSBpbiBEVCBJIGd1ZXNzLg0KPj4+Pj4+DQo+Pj4+Pj4gT2theS4gWW91J3JlIHJpZ2h0
LiBIb3dldmVyLCB3aGVuIHJlZ2lzdGVyaW5nIHdpdGggT1BTLCBIRE1JIFBMTCB3aWxsIGJlDQo+
Pj4+Pj4gcmVzZXQuIEl0IHRha2VzIHRpbWUgZm9yIFBMTCB0byBzdGFiaWxpemUgdGhlIG91dHB1
dCBmcmVxdWVuY3ksIHdoaWNoDQo+Pj4+Pj4gd2lsbA0KPj4+Pj4+IGxlYWQgdG8gdGhlIHN0YXJ0
dXAgc2NyZWVuIGZsYXNoaW5nLg0KPj4+Pj4+DQo+Pj4+Pj4gSSB3b3VsZCBsaWtlIHRvIGtub3cg
aG93IHRvIHNvbHZlIHRoaXMgcHJvYmxlbSBpZiBub3QgdXNpbmcgcm9fb3BzLg0KPj4+Pj4+DQo+
Pj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gWW91IGNhbiBhZGQgbmV3IG9wcyBvciB0d2VhayB0aGUgY3Vy
cmVudCBpbml0IGZ1bmN0aW9uLg0KPj4+PiBIRE1JIFBMTCBpcyBub3QgZGlmZmVyZW50IGZyb20g
b3RoZXIgUExMUywgc28gSSB0aGluayBhZGRpbmcgT1BTIGlzDQo+Pj4+IHdlaXJkLg0KPj4+Pg0K
Pj4+Pj4NCj4+Pj4+IFNhZmVzdCB3b3VsZCBiZSB0byBkbyB0aGUgZm9sbG93aW5nIDoNCj4+Pj4+
ICDCoCAqIENoZWNrIGlmIHRoZSBQTExzIGlzIGFscmVhZHkgb24uDQo+Pj4+PiAgwqAgKiBDaGVj
ayBpZiB0aGUgJ3BsbC0+aW5pdF9yZWdzJyBtYXRjaGVzIHdoYXQgaXMgYWxyZWFkeSBzZXQNCj4+
Pj4+ICDCoMKgwqAgLSBpZiBzbywgeW91IGNhbiBza2lwIHRoZSByZXNldA0KPj4+Pj4gIMKgwqDC
oCAtIGlmIG5vdCwgeW91IG5lZWQgdG8gcmVzZXQgYXMgdXN1YWwNCj4+Pj4gc3RhdGljIGludCBt
ZXNvbl9jbGtfcGxsX2luaXQoc3RydWN0IGNsa19odyAqaHcpDQo+Pj4+IHsNCj4+Pj4gICDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgY2xrX3JlZ21hcCAqY2xrID0gdG9fY2xrX3JlZ21hcChodyk7DQo+
Pj4+ICAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1lc29uX2Nsa19wbGxfZGF0YSAqcGxsID0gbWVz
b25fY2xrX3BsbF9kYXRhKGNsayk7DQo+Pj4+ICAgwqDCoMKgwqDCoMKgwqAgaWYgKHBsbC0+aW5p
dF9jb3VudCkgew0KPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZXNvbl9w
YXJtX3dyaXRlKGNsay0+bWFwLCAmcGxsLT5yc3QsIDEpOw0KPj4+PiAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZWdtYXBfbXVsdGlfcmVnX3dyaXRlKGNsay0+bWFwLCBwbGwtPmlu
aXRfcmVncywNCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoCBwbGwtPmluaXRfY291bnQpOw0KPj4+
PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZXNvbl9wYXJtX3dyaXRlKGNsay0+
bWFwLCAmcGxsLT5yc3QsIDApOw0KPj4+PiAgIMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gICDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+Pj4gfQ0KPj4+PiBCZWNhdXNlIHRoZSBpbml0IGZ1bmN0
aW9uIGxvb2tzIGxpa2UgdGhpcy4gVGhlcmVmb3JlLCBIRE1JIFBMTCBpbml0X2NvdW50DQo+Pj4+
IGlzIG5vdCBnaXZlbi4NCj4+IEkgZG9uJ3QgZ2V0IHRoZSByZW1hcmsuIFlvdSd2ZSBnb3QgcGxs
LT5pbml0X2NvdW50IHJpZ2h0IHRoZXJlLg0KPj4gDQo+Pj4+IENhbiBJIGNoYW5nZSBpdCBsaWtl
IHRoaXM/DQo+PiBXaGF0IGNoYW5nZSA/IFRoZSBmdW5jdGlvbiBhYm92ZSBsb29rcyBhIGxvdCBs
aWtlICBtZXNvbl9jbGtfcGxsX2luaXQoKQ0KPj4gaW4gdGhlIGFjdHVhbCBzb3VyY2UNCj4+IA0K
Pj4+DQo+Pj4gSSBkb24ndCBrbm93IGlmIHRoaXMgY2hhbmdlIG1lZXRzIHlvdXIgcmVxdWlyZW1l
bnRzPyBQbGVhc2UgZ2l2ZSB1cyB5b3VyDQo+Pj4gdmFsdWFibGUgYWR2aWNlLg0KPj4gV2hhdCBj
aGFuZ2UgPw0KPg0KPiBzdGF0aWMgc3RydWN0IGNsa19yZWdtYXAgczRfaGRtaV9wbGxfZGNvID0g
eyAgICAgICAgICAuZGF0YSA9ICYoc3RydWN0DQo+IG1lc29uX2Nsa19wbGxfZGF0YSl7ICAgICAg
ICAgICAgICAgICAgLmVuID0gew0KPiAucmVnX29mZiA9IEFOQUNUUkxfSERNSVBMTF9DVFJMMCwg
ICAgICAgICAgICAgICAgICAgICAgICAgIC5zaGlmdCAgID0gMjgsDQo+IC53aWR0aCAgID0gMSwg
ICAgICAgICAgICAgICAgICB9LCAgICAgICAgICAgICAgICAgIC5tID0gew0KPiAucmVnX29mZiA9
IEFOQUNUUkxfSERNSVBMTF9DVFJMMCwgICAgICAgICAgICAgICAgICAgICAgICAgIC5zaGlmdCAg
ID0gMCwNCj4gLndpZHRoICAgPSA4LCAgICAgICAgICAgICAgICAgIH0sICAgICAgICAgICAgICAg
ICAgLm4gPSB7DQo+IC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLCAgICAgICAgICAg
ICAgICAgICAgICAgICAgLnNoaWZ0ICAgPSAxMCwNCj4gLndpZHRoICAgPSA1LCAgICAgICAgICAg
ICAgICAgIH0sICAgICAgICAgICAgICAgICAgLmZyYWMgPSB7DQo+IC5yZWdfb2ZmID0gQU5BQ1RS
TF9IRE1JUExMX0NUUkwxLCAgICAgICAgICAgICAgICAgICAgICAgICAgLnNoaWZ0ICAgPSAwLA0K
PiAud2lkdGggICA9IDE3LCAgICAgICAgICAgICAgICAgIH0sICAgICAgICAgICAgICAgICAgLmwg
PSB7DQo+IC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLCAgICAgICAgICAgICAgICAg
ICAgICAgICAgLnNoaWZ0ICAgPSAzMSwNCj4gLndpZHRoICAgPSAxLCAgICAgICAgICAgICAgICAg
IH0sICAgICAgICAgICAgICAgICAgLnJzdCA9IHsNCj4gLnJlZ19vZmYgPSBBTkFDVFJMX0hETUlQ
TExfQ1RSTDAsICAgICAgICAgICAgICAgICAgICAgICAgICAuc2hpZnQgICA9IDI5LA0KPiAud2lk
dGggICA9IDEsICAgICAgICAgICAgICAgICAgfSwgICAgICAgICAgICAgICAgICAucmFuZ2UgPQ0K
PiAmczRfZ3AwX3BsbF9tdWx0X3JhbmdlLCAgICAgICAgICB9LCAgICAgICAgICAuaHcuaW5pdCA9
ICYoc3RydWN0DQo+IGNsa19pbml0X2RhdGEpeyAgICAgICAgICAgICAgICAgIC5uYW1lID0gImhk
bWlfcGxsX2RjbyIsDQo+IC5vcHMgPSAmbWVzb25fY2xrX3BsbF9vcHMsICAgICAgICAgICAgICAg
ICAgLnBhcmVudF9kYXRhID0gKGNvbnN0IHN0cnVjdA0KPiBjbGtfcGFyZW50X2RhdGEgW10pIHsg
ICAgICAgICAgICAgICAgICAgICAgICAgIHsgLmZ3X25hbWUgPSAieHRhbCIsIH0NCj4gfSwgICAg
ICAgICAgICAgICAgICAubnVtX3BhcmVudHMgPSAxLCAgICAgICAgICB9LCB9Ow0KDQpJJ20gc29y
cnkgYnV0IEkgY2FuJ3QgcmVhZCB0aGlzDQoNCj4NCj4gVGhpcyBpcyBteSBjb2RlIHJpZ2h0IG5v
dy4gQmVjYXVzZSBpbml0X2NvdW50IGFuZCBpbml0X3JlZ3MgYXJlIG5vdA0KPiBkZWZpbmVkLCBI
RE1JIFBMTCBpcyBub3QgcmVzZXQuIEluIHRoaXMgd2F5LCB0aGUga2VybmVsIHdpbGwgbm90IGJs
aW5rIHdoZW4NCj4gdGhlIFVib290IHN0YXJ0cy4gVGhlbiBpbiB0aGUga2VybmVsIHN0YWdlLCBp
ZiB3ZSB3YW50IHRvIGNoYW5nZSB0aGUgSERNSQ0KPiBQTEwgZnJlcXVlbmN5IHZhbHVlLCB3ZSBj
YW4gZGlyZWN0bHkgY2hhbmdlIE0sIE4gYW5kIE9ELiBJbiBmYWN0LCB3ZSB3aWxsDQo+IG5vdCBj
aGFuZ2UgdGhlIEhETUkgUExMIGZyZXF1ZW5jeSB2YWx1ZSBsYXRlci4NCj4NCj4gSSB3b25kZXIg
aWYgeW91IGFjY2VwdCB0aGlzIGNoYW5nZT8NCg0KSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIg
dG8gc2VwYXJhdGUgdGhpcyB0b3BpYyBmcm9tIHlvdXIgbmV3IFNvQyBzdXBwb3J0DQoNCkkgdGhp
bmsgeW91IGNhbiBtYWtlIGFub3RoZXIgdmVyc2lvbiBvZiB0aGUgY2xvY2sgY29udHJvbGxlciBm
b3IgdGhlIG5ldw0KU29DLCBrZWVwaW5nIHRoZSBwbGxfb3BzIGFzIGl0IGlzIG5vdy4NCg0KV2l0
aCBhbm90aGVyIHNlcmllcywgeW91IG1heSBzdWJtaXQgc29tZXRoaW5nIHRvIGF2b2lkIHJlc2V0
aW5nIHRoZSBQTEwgaWYNCmlzIGFscmVhZHkgY29ycmVjdGx5IGluaXRpYWxpemVkLiBUaGlzIGNh
biBiZSB1c2VmdWwgdG8gYWxsIHRoZSBTb0MsIG5vdA0KanVzdCB0aGUgbGFzdCBvbmUuIEl0IHdp
bGwgYmUgZWFzaWVyIHRvIGRpc2N1c3Mgb24gcHJvcGVybHkgZm9ybWF0dGVkDQpwYXRjaGVzDQo=
