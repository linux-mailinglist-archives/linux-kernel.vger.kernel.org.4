Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAC6D370E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjDBKKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjDBKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:10:00 -0400
Received: from sonic304-21.consmr.mail.ir2.yahoo.com (sonic304-21.consmr.mail.ir2.yahoo.com [77.238.179.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B52CAD6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1680430122; bh=VP9fEHfdfBiQREs0QLzsecg1hWXI8OPlygsg7Lg/Fl8=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=gjdq7MgHxHjEoISpqSTZQLRu5HdB2NJyevjLf0FyUCoqL/MnwQV3lIqLh5W1AfML6sdgvSU/AZoeCwPpb7Q0xtZ5uOQxE+NBbn9oIQQ998ZaxbVMjRKHY7ZGif7Gjl8gIQA221JJPbPrOJ375BFgUoO0ZK9OsBcpIRtGL53ixxxGeskLXPzZz6RaSMuutSsFldKB9CVCgul+0wjoqs/u83q5MyiJrN6et+/MSET9vrr8VqrI4IaGneumM19ec8/GVDek9sO5GFBYloLm6dkhBbNKj8q/8GyvgFZVOyqzOpz8x+wQUrdz/e0fAwy2Bo57vDvRjOrxnnqnMBSDY26aXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680430122; bh=Rt+F0NRzUFfHbMHrhu6ai7Ki96f0nc0rlKqG9nM6/8p=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=qhNWPZV8lWU1F/LDofvddKNzWed6EaGc5wfuWdkwnN5Mh/AFDxBFaWvJiXaL+JVarTt0zcpW1E6qTjh17c+l5c+Os4avDkM/Xx009Uihwl3M8vpJ1Y0SBCpzvIDOBcX+ra7n4YxmbooDg87+qAmloSJe4E6OZNjBj3ix16UVjlX6drc7tvoRnuZUMmmaSmaDXzuklmrFjfouhX8bBLXqFCA0M9uBA1wQCYi4X+dsfeXSmmCBoZeoylFtm8eOI8dwZWjNYLZ0U4+NMPRHxlSOvbX3RtyiII40oTWpaA4RUDNb7tK+oLuMmq7M5P/lJNWzPVijeQ/3ZwXCB3++XXFqhA==
X-YMail-OSG: 77DPRhQVM1k1o2aOJFxYHkBk0jSDrwqNLy7xQhA9K_X8oWiN04yj4tWUuIPuD24
 zIPMABMbs8HZseRolfIGiCgY.26lTAwwC7C8lKHoajcHzkhQBmQpNAvKKyliuhNCEJ2KP14ZzOce
 pZ6mUqz.9VF84Zj2VeIPvgBb_IZ8Sgj6_YEFCTF4HQtk.wNiVMGEybdZo3M7zb8KoNpjskl5QH5L
 rENalP040TaIqQhRfq5tQ5gO8eY116ggAYrF4MWbeKzCh_S2cMB0OnWrq55TMUOhCxnEk1Z3HVnV
 ZesGRm0nMqhErKW_b.T0K.cNLkn1rmtVBsS9BP6guazNDbEQPBf5aqm8rT3yYG79izGE3Q2ArVMG
 1xa78rygbnayCwoMeIq6A4KI5HNLVSszYEvhEHtoPirDxE0WZgteJP7sIvpK12inkbuAUAp93Fvl
 zy9LSyyhdanKqPZ8gRqOYxJ2MrWXN9VmS1rfxEOSjpoU3cPXOzsMe3ofQfLkRBd.aUi_2hVZPIPf
 hhCY5V_zANJ88.Xc0ZbIwrH5op4gL2iqAWc_d3zjR6j8LIQdKPB1UriHzJKbq8Ik.L.3Ae5_n8IU
 dVRqNk.AkuvaKvMSKtiA3N5jUNFB9ezl52QMbomlsq7hBFZjQJ02FFB.63ycBA404yXSgfo612hl
 tkSNUj_moaPZglQlaE9OhkognS87VTiZf5RFikYJuzBt1YfykqeYEt0el2N2vOtz4k4zxgo5cF27
 0u37qQkNLXGAteTLcYA.k8LwBLuH79pjnGxx34ZgIE2Vftrd1n6qT23KcgvHPoqU51zQkaJfH9ja
 UF3uR_Q7gYYOq5gT1TC5JbJD0ykkRx6L9b0UP7IpVxC0V5mm.0VwcTaLV6oQDTiLJz4Z5a_WHOIO
 tNQicIl3d7DAX.w_fl09gBJFijsioza6uQH_N5s3Pxs8HYpgLIc.6F587y8Vm1DfJBiaG.cQ8UkQ
 tqYWRq8xBn2AT41q100wIL0FEtO_woxSvhE31uZGkgO2HVWV9r7uIo71djoHBJR6jPuxCChpEFfw
 yu7u6Ks9zqg_SM.sWce2.fQvKrAwdVgBzusInxIsXgZlW7QGg4vX39xNamcHewmiv5P_cikinIU1
 NMk.hUb9klXmnhSl_2yZQ.uqLDmTHIh49ZdXrEyAwjGfATCXTajkD.p.w46FHrleKv.9zywi5gx5
 5CoZJ6uIUJgY79Mg355wzID3bjU09BMwp8JFI2b8y6fOWiAA_k86r8cXf4EGnPwGVmByO.ns2T1H
 ASSRsSKlIkX8opvqPgk0jQm1X0nT1p0JSQ0DLjpN1rhNhU6FI5mIDrgzIxi3Wvxr_.QFVnUdZRt4
 sDOpwOH.t3vK7oi8bDom3o10ybLB3kv2ECQAtlK4b7RsD1eYEQbbbMc7u70g08ge_mlMAcaNjn25
 29OcqpmtFP7TkLNtdT3IbHZYIuLZHEE67cCCqDQuWwo1tJn.37QMYsvDxSeeA0WufoseSf3saT9B
 kgAHUDNZPSc2xSNWkQihkwdi2cARwLQY0R40br6EbYhMxDZedC3BBZDR6xXtoYE7ec8El6jN9noO
 VsBlZAhwc.sDplIDmh.A85cMvMp2uNzWRHcUWb2OrVZ_HGuY4PDRLlKmUiiOyhlY5wptB.JMyv8s
 7tylQor.A7Xr073Cr8TwIMewX6Xx6.bO.sWjvU5nrMdBXIAKATOCG.MK2BPGDw6_TO54O.PPHwny
 36OsTBYB2gjtQalLTVve7cRHgdgg_u1eQexo_XAAK4C.WCew5ZeH7VGvvgE4rJi0aTub1Oie51jm
 nU3WIZw1EjrYa9ZSTU45iMe3xkr1cUF0k7zEbu5gLTzhhJT1hCuJ0zojsiaocESDv.aO9FE1JaKt
 xQUW11rykVyjY4NtGWJkjOMo03zfM3Lo73UVA0_W_YBaK_X_LWcGscxSOORnPcp.MQ9gz0deEBSA
 m6yx9ielMVxqOcad_G9wqN5F2fnkMHR6cKtVcGGl2AOqolD.rgl0QPMMART9637.IOTRDOd2_vz1
 ajU2m8BaBoO0yh_dClYSdztWBhA2VrW4MA8XR5ltnom9CfxqGv.bvnSNKA7YXKCbrZCsw0go8Dhe
 fECnNVFOC5mEbwK0Bqoov9vsTlfwRDuHOqOwWyRfpVUwkEmbsLIKzb4jyKorvr.RUZr0ZHM2OzA1
 UpejomjOPxW68KtQ0mY_ty6B7l3V5KqtBC9NPRL9AecdhKKYj3sdJ3ZGrpt181LdUU4NNJAeoe3I
 hw.Feq_0lfj139litJ4WHzyiOurtDNDaFqzv4BXvTFv3EhIlhlCcD.Dju08WgFsRad5r5COGKGnY
 zwDcSC1X2JlZLZmWZKUeR.B2gBQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: afab1648-eb6c-426c-b560-1c510a39a440
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 2 Apr 2023 10:08:42 +0000
Received: by hermes--production-ir2-74cd8fc864-qfvhg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f3b62af774e1e251386fdd08ee73976a;
          Sun, 02 Apr 2023 10:08:38 +0000 (UTC)
Message-ID: <64840676-b779-8ebb-3a7b-27d58e0e0346@rocketmail.com>
Date:   Sun, 2 Apr 2023 12:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/10] mfd: rt5033: Apply preparatory changes before
 adding rt5033-charger driver
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1677620677.git.jahau@rocketmail.com>
 <4edfef7fdf129185355d4dd2d3928d63c04bac73.1677620677.git.jahau@rocketmail.com>
 <20230305105551.GJ2574592@google.com>
 <9ce4110c-eaff-3f8b-65da-8407e05af493@rocketmail.com>
Content-Language: en-US
In-Reply-To: <9ce4110c-eaff-3f8b-65da-8407e05af493@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpPbiAwNS4wMy4yMyAxNzoxNCwgSmFrb2IgSGF1c2VyIHdyb3RlOg0KPiBP
biAwNS4wMy4yMyAxMTo1NSwgTGVlIEpvbmVzIHdyb3RlOg0KPj4gT24gVHVlLCAyOCBGZWIg
MjAyMywgSmFrb2IgSGF1c2VyIHdyb3RlOg0KPj4NCj4+PiBPcmRlciB0aGUgcmVnaXN0ZXIg
YmxvY2tzIHRvIGhhdmUgdGhlIG1hc2tzIGluIGRlc2NlbmRpbmcgbWFubmVyLg0KPj4+DQo+
Pj4gQWRkIG5ldyBkZWZpbmVzIGZvciBjb25zdGFudCB2b2x0YWdlIHNoaWZ0IChSVDUwMzNf
Q0hHQ1RSTDJfQ1ZfU0hJRlQpLA0KPj4+IE1JVlIgbWFzayAoUlQ1MDMzX0NIR0NUUkw0X01J
VlJfTUFTSyksIHByZS1jaGFyZ2UgY3VycmVudCBzaGlmdA0KPj4+IChSVDUwMzNfQ0hHQ1RS
TDRfSVBSRUNfU0hJRlQpLCBpbnRlcm5hbCB0aW1lciBkaXNhYmxlDQo+Pj4gKFJUNTAzM19J
TlRfVElNRVJfRElTQUJMRSksIHRlcm1pbmF0aW9uIGRpc2FibGUgKFJUNTAzM19URV9ESVNB
QkxFKSwNCj4+PiBDRk8gZGlzYWJsZSAoUlQ1MDMzX0NGT19ESVNBQkxFKSwgVVVHIGRpc2Fi
bGUgDQo+Pj4gKFJUNTAzM19DSEFSR0VSX1VVR19ESVNBQkxFKS4NCj4+Pg0KPj4+IFRoZSBm
YXN0IGNoYXJnZSB0aW1lciB0eXBlIG5lZWRzIHRvIGJlIHdyaXR0ZW4gb24gbWFzayAweDM4
DQo+Pj4gKFJUNTAzM19DSEdDVFJMM19USU1FUl9NQVNLKS4gVG8gYXZvaWQgYSBiaXQgc2hp
ZnQgb24gYXBwbGljYXRpb24sIA0KPj4+IGNoYW5nZSB0aGUNCj4+PiB2YWx1ZXMgb2YgdGhl
IHRpbWVyIHR5cGVzIHRvIGZpdCB0aGUgbWFzay4gQWRkZWQgdGhlIHRpbW91dCBkdXJhdGlv
biANCj4+PiBhcyBhDQo+Pj4gY29tbWVudC4gQW5kIHRoZSB0aW1lciBiZXR3ZWVuIFRJTUVS
OCBhbmQgVElNRVIxMiBpcyBtb3N0IGxpa2VseSANCj4+PiBUSU1FUjEwLCBzZWUNCj4+PiBl
LmcuIFJUNTAzNiBbMV0gcGFnZSAyOCBib3R0b20uDQo+Pj4NCj4+PiBBZGQgdmFsdWUgb3B0
aW9ucyBmb3IgTUlWUiAoTWluaW11bSBJbnB1dCBWb2x0YWdlIFJlZ3VsYXRpb24pLg0KPj4+
DQo+Pj4gTW92ZSBSVDUwMzNfVEVfRU5BQkxFX01BU0sgdG8gdGhlIGJsb2NrICJSVDUwMzMg
Q0hHQ1RSTDEgcmVnaXN0ZXIiLCANCj4+PiBpbiBvcmRlcg0KPj4+IHRvIGhhdmUgdGhlIG1h
c2tzIG9mIHRoZSByZWdpc3RlciBjb2xsZWN0ZWQgdGhlcmUuIFRvIGZpdCB0aGUgbmFtaW5n
IA0KPj4+IHNjaGVtZSwNCj4+PiByZW5hbWUgaXQgdG8gUlQ1MDMzX0NIR0NUUkwxX1RFX0VO
X01BU0suDQo+Pj4NCj4+PiBNb3ZlIFJUNTAzM19DSEdfTUFYX0NVUlJFTlQgdG8gdGhlIGJs
b2NrICJSVDUwMzMgY2hhcmdlciBmYXN0LWNoYXJnZSANCj4+PiBjdXJyZW50Ii4NCj4+Pg0K
Pj4+IEFkZCBuZXcgZGVmaW5lcyBSVDUwMzNfQ1ZfTUFYX1ZPTFRBR0UgYW5kIFJUNTAzM19D
SEdfTUFYX1BSRV9DVVJSRU5UIA0KPj4+IHRvIHRoZQ0KPj4+IGJsb2NrcyAiUlQ1MDMzIGNo
YXJnZXIgY29uc3RhbnQgY2hhcmdlIHZvbHRhZ2UiIGFuZCAiUlQ1MDMzIGNoYXJnZXIgDQo+
Pj4gcHJlLWNoYXJnZQ0KPj4+IGN1cnJlbnQgbGltaXRzIi4NCj4+Pg0KPj4+IEluIGluY2x1
ZGUvbGludXgvbWZkL3J0NTAzMy5oLCB0dXJuIHBvd2VyX3N1cHBseSAicHN5IiBpbnRvIGEg
cG9pbnRlciANCj4+PiBpbiBvcmRlcg0KPj4+IHRvIHVzZSBpdCBpbiBkZXZtX3Bvd2VyX3N1
cHBseV9yZWdpc3RlcigpLg0KPj4NCj4+IEFyZSB0aGVyZSBubyBwcmVzZW50IHVzZXJzIHRv
IGFjY291bnQgZm9yPw0KPiANCj4gQXQgbGVhc3Qgbm9uZSBJJ20gYXdhcmUgb2YuIFdpdGhp
biB0aGUgdXBzdHJlYW0ga2VybmVsIHRoZSANCj4gcnQ1MDMzX2NoYXJnZXIgcG93ZXJfc3Vw
cGx5IGRpZG4ndCBleGlzdCBzbyBmYXIsIHRoZSBwYXRjaHNldCBpcyBhYm91dCANCj4gdG8g
aW1wbGVtZW50IGl0Lg0KDQpJcyB0aGVyZSBhbnl0aGluZyB5b3Ugd2FudCBtZSB0byBjaGFu
Z2Ugb3IgaW1wcm92ZSBvbiB0aGlzIHBhdGNoPw0KDQo+Pj4gWzFdIA0KPj4+IGh0dHBzOi8v
bWVkaWEuZGlnaWtleS5jb20vcGRmL0RhdGElMjBTaGVldHMvUmljaHRlayUyMFBERi9SVDUw
MzYlMjAlMjBQcmVsaW1pbmFyeS5wZGYNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpha29i
IEhhdXNlciA8amFoYXVAcm9ja2V0bWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgaW5jbHVk
ZS9saW51eC9tZmQvcnQ1MDMzLXByaXZhdGUuaCB8IDUzICsrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPj4+IMKgIGluY2x1ZGUvbGludXgvbWZkL3J0NTAzMy5owqDCoMKgwqDC
oMKgwqDCoCB8wqAgMiArLQ0KPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9u
cygrKSxgIDE5IGRlbGV0aW9ucygtKQ0KDQpLaW5kIHJlZ2FyZHMsDQpKYWtvYg0K
