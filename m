Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B59F6F3997
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjEAVQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEAVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:16:44 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB9A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682975800; bh=nsSG1aaLpP1HwDmABEE5WbgGngpmEzR5CI8PTr0aSFg=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=nz+QiuRVXIiJbMBoYTJsul2ICXmRnIlY/uyOpUxydBSgWOXsw8HksIiwKu1EeZrGFWzwesTNNOjEQiK6ClnhepKuZP/xIkjPRYnWMwI6mEjlF/5l/Gd+jgZao6Ve1qlP/IJBCMXiZT+r1xDrI0bfwWAW6SWs4nuEd5fViqKAAan8+obQRp5Macw8Y2WyqH+pTivrKWXHez/KNhgB6DkfBCS/eeSKIudj3JD6j+2xcIAQAqNijGdfmVKzv2/q3mof8uZ0IZh9rEUwRitwoEW6yJ5c22D1r37GONWF3e1Y//9RF8/Lpp5KA4UjLIXb7JawGh3eqxHyx4wiYylaVJ8MXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682975800; bh=jTHe1BIEb13LeE1WCdOiZav/8rOoYFdJQZLVXxY4yYc=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=a6WxrUfPduBFVeLM2tj09K7N+RskgfgAhBxpiRCo5JaX2TySSK+HhsDQj21PFh0a15pYZQ4lYiT8RfFuIJnOXRSNktmFNMIWbV9Lsss2FuStgThVUc2SDvkn/RGXSBZm/uhiKMgVAh7NdN5ArKuCj3iuna1K6WzbhHvW4PSTlrZmbf7m54g6rV1D/txjEuEIcvQq4bJTxBXrzes4xsi+zXvSSPajMbpmFN5Bu+TarTU3WXjsAJKS5iScGWguYUc678FKdTSocwYGndG5wH2AQhAyWM9O5/ztzq+4wJoB4Rzil0KENb3NqK+tFMgUK+iFyehcvHHWeXK2tsMjBwXSGA==
X-YMail-OSG: 7BrGv1YVM1lhDcYdrZcSqvZHbFM5QPe5uUVJ4n3uFROi9S_7VtJqFcWWEH5pppC
 vX_t1_wzZro8xQOUHdt3iHEW5O9Z60uaRL9NaSZMkKPEY9ELLMFCCN_2SyoFs5vw3Vk4WXqtpH2C
 0XBGns_XO7fYqeyFhsyyFw3mNbQ2ejT82jsU0oe6q60Cm8WEDX_ImN9cI1DBtsa5HNXuCxOzpihB
 dQZH3R6Dt4PrLUpcrBEciKrkDNFsgWh2Tz33WKWDJH18Rlfca5c24QiuiSzabNkNJLJbt9pdZpD9
 YK6G63fFiSBbG1aSy1IDL2M.pKyEqgBgT65OX4uhJauCDE35Q4xjoTExVNEWouD3k3mcqFwnC4PK
 JJnUvNDH_n7sj73ZR1gTyKzUlf4_2Hg0orC.mgLouczkxMUgbJEI8XNb_kPIo21vtj5T1vxsnpbv
 MhO_yU9rUKHjvpaX.QIH3B.pkSvnO2_ExVYewFsrhKz7ycGGH23JxuN.Rs_u6vuzKW7Y0fEeGuJZ
 q9YiHOIV.juWicVfojkai.Kt374ADJnLPB.P66GRXgICYLyBZDeSX3AOPFyBd_9oUyKoegeB1CJb
 lyLoMPKCyWyMzNdlqsVgtNSk6vIkEFeIrIK32ZdgKwUgSDr4eIy.A8y0E2lI1qeye5kzKBD31uxK
 6.eKrAbMYz8oJxsj_lLCBVyXC7LTUdwKyGcL1RjOh3fwzDnIeG44TM0XhrQyTyGbOKSx2gPU1BAD
 IqCoDvOjEMliiZ5VebChhzue8..fKSpfTHG8DBH_yCcWwu4DxT_R9TNNChmEkPWT1M_cDjqHYQVa
 QYmSHLPZtGfG706HBC8jW54OXN.NwR2GfRp9NZZZ3oE5YPEi3ymoKSmnKam7Z5h44EHrhYbMK2d2
 vsTZLvpLvVBaWc3B6S1tmSkl7HEY8Xt65wnJt8e3UAiIbqNMDymioA15brsj5EFKjQZRR4qa8map
 Et3ESmtuB_ZqlI8Y8Ys8cdyS4wELwg3MoK04Fzq4RUq6PqOSs2TyZ2XtA20qo1vyeseYC1UdnHCl
 1_p80IQ51I99hQH91nVnWIwvW6YPd2uPjOX_ZurTn2QwUu20GANll6C777TyAuGp3L0VpuNGlJiB
 x1azyZ.F334VCUpeX5sk93Qxtj44AhZ4kBuEtStI8fu.BDA8CQafBQh2aqyUpSc6pd3DnRKsVE8q
 qQ1xgBMP.gErn5Vcz7oOERMJEzfj8LJFTi_siJjAHSMm1x1eJCLtiuijz6IY5VcNCeVrKsSj6Zhm
 dW4ilOupmsXag7YR0mH.NVGvEPMzltSoKbqmwTwwu45FIETpKWS1eLrIYCqNRaDbYOOU5DhkklWY
 DBrZ5CoulMG35bvXuqv_d7zFsONiEBl48wKObk42ec7uwhe22u.6SynqgA5UfTh7GVE8dFPx148h
 bs7aXmbrAc354BByRMoIoH3usvqLxv.o1scRFhmrzNxo2fWdHcRRHEJiSMSqUPeIXxL4sbGs6jMB
 gn8fjE7VtfU_wbMzl5XsV4INQd1Guv7bQI5RlBuJxwSJ7Ta070ifXoKxJ9jvwbdTogg8NCGnaAGa
 33NZ_ZQe95sPXFGlLWcKe3nD8pkfmMsAIJOCqDmpo5Eo2dCHQKm4FPKw8iLfuQKKQ6tvzcM1kOAA
 4Njyt1pTF8RjmS.gnxZTkXjF__kL_SA58SDmRi_hqo52UnHUGatd.kAVKkTtHlylFXPQALrI2a9.
 qv8yNo9pIJC4.rLkxRrMSFpPiztfD101C7lJRDq1Sv2efFWYBX5gRp3ASCrfLS01AzNUEXYtWmCp
 NtzDgCa2usnz3iUYK7BljD2rQjpw7b5CkXSICZgJEs0Fc7vlnvJxUa98vyjm0v0YoXoGM1dm_Hol
 8sCglp297AQdfLf9a7BUwlgIKJLdO1LsiII29kOkJgyKNZI6buijgfzYQErqXtZHdlK1TLdDzO4y
 YgQw7XR.nVGrRVxUwqRemgL47rCNymRQJtAAe.l09AiFIkJVBPjBtwhh.FhsRcgUWLGz3bGj2TU.
 LHc2lmPvxjduWOJDKUWHCTUFLUQPD1SMpZzYi5RbbTTQF6kW5O8EHahaQXCdLOp2wuotzTnAcNY3
 EO3p37P3ZDSQz5DZr77urmjkI0b5OTc234DnvPKCMiqCMIX_LNco4dPjtwqZ7htsQjKeoObFrNB9
 Mb6_QxZqhZdvSWcdFX.4QXe4OUgOOFeYgAlav0zoCyNeDpkzCkB7tI2z8_K2_YclQpHk1f4RBaA9
 exgC3.El_1nEJ7awxNXql2QVlSftUlT4j6bh7nW63kwGIYVH0lcqL8CRkXTztjileqmNuEUwTeBS
 Xt6T90l2kYEW91CmgS.15WJLLhI4cYCOB
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 89f262b5-b679-4ab4-b9c8-c39ce71caf69
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Mon, 1 May 2023 21:16:40 +0000
Received: by hermes--production-ir2-74cd8fc864-qfvhg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a93e2a8469151c72af88d9db244b6b03;
          Mon, 01 May 2023 21:16:35 +0000 (UTC)
Message-ID: <14daa006-5260-81a8-8ba0-4122e0c0509a@rocketmail.com>
Date:   Mon, 1 May 2023 23:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1682636929.git.jahau@rocketmail.com>
 <5bd8b90713a61129acf292a941eb7fb5ccaa3db4.1682636929.git.jahau@rocketmail.com>
 <1d187f41-ad9a-4e82-8557-20694a8294d0@linaro.org>
 <e9d75e57-bdea-593d-7b05-136c9ad2e2fe@rocketmail.com>
Content-Language: en-US
In-Reply-To: <e9d75e57-bdea-593d-7b05-136c9ad2e2fe@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiAwMS4wNS4yMyAxOTozNSwgSmFrb2IgSGF1c2VyIHdyb3Rl
Og0KPiBPbiAwMS4wNS4yMyAwOToyMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+
IE9uIDI4LzA0LzIwMjMgMDE6MzAsIEpha29iIEhhdXNlciB3cm90ZToNCj4+PiBBZGQgZGV2
aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBydDUwMzMgbXVsdGlmdW5jdGlv
biANCj4+PiBkZXZpY2UsIHZvbHRhZ2UNCj4+PiByZWd1bGF0b3IgYW5kIGJhdHRlcnkgY2hh
cmdlci4NCj4+Pg0KPj4+IENjOiBCZW9taG8gU2VvIDxiZW9taG8uc2VvQHNhbXN1bmcuY29t
Pg0KPj4+IENjOiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBKYWtvYiBIYXVzZXIgPGphaGF1QHJvY2tldG1haWwuY29tPg0KPj4N
Cj4+DQo+PiAoLi4uKQ0KPj4NCj4+PiArDQo+Pj4gK3JlcXVpcmVkOg0KPj4+ICvCoCAtIG1v
bml0b3JlZC1iYXR0ZXJ5DQo+Pj4gKw0KPj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4+PiArDQo+Pj4gK2V4YW1wbGVzOg0KPj4+ICvCoCAtIHwNCj4+PiArwqDCoMKgIGNo
YXJnZXIgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInJpY2h0ZWsscnQ1
MDMzLWNoYXJnZXIiOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBtb25pdG9yZWQtYmF0dGVyeSA9
IDwmYmF0dGVyeT47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGV4dGNvbiA9IDwmbXVpYz47DQo+
Pg0KPj4NCj4+IEV2ZXJ5dGhpbmcgdXAgdG8gaGVyZSBsb29rZWQgb2ssIGJ1dCBleHRjb24g
aXMgbm90IGEgaGFyZHdhcmUgcHJvcGVydHkuDQo+PiBQbGVhc2UgZG8gbm90IG1peCBhZGRp
bmcgbWlzc2luZyBiaW5kaW5ncyBmb3IgZXhpc3RpbmcgZGV2aWNlIHdpdGgNCj4+IGFkZGlu
ZyBuZXcgcHJvcGVydGllcy4gWW91IHNob3VsZCB1c2UgY29ubmVjdG9yIGZvciB0aGUgVVNC
IHBvcnQuDQo+Pg0KDQouLi4NCg0KPiBBbmQgaG93IHRvIHNldCB1cCB0aGUgcnQ1MDMzLWNo
YXJnZXIgdG8gcmV0cmlldmUgdGhlIGluZm9ybWF0aW9uIG9mIHRoZSANCj4gZXh0Y29uL211
aWMgZHJpdmVyIGluIHRoYXQgY2FzZT8NCj4gDQoNCi4uLg0KDQpUbyBhZGQgbW9yZSBjb250
ZXh0Og0KQWNjb3JkaW5nIHRvIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBleHRjb24gc3Vic3lz
dGVtIHByb3ZpZGVzIHRocmVlIHdheXMgDQp0byBnZXQgYW4gZXh0Y29uIGRldmljZSBbM106
DQotIGJ5IG5hbWUNCi0gYnkgZGV2aWNldHJlZSBub2RlDQotIGJ5IHBoYW5kbGUNCg0KRm9y
IHJ0NTAzMy1jaGFyZ2VyLCB0aGUgZXh0Y29uIGRldmljZSBuYW1lIGNhbiBiZSBkaWZmZXJl
bnQgZGVwZW5kaW5nIG9uIA0KdGhlIGNvbnN1bWVyIGRldmljZS4gRm9yIHRoZSBub2RlIEkg
d291bGRuJ3Qga25vdyBob3cgdG8gZ2V0IGZyb20gdGhlIA0KY2hhcmdlci9tZmQgbm9kZSB0
byB0aGUgZXh0Y29uIG5vZGUsIEkgZG9uJ3Qgc2VlIGEgZGlyZWN0IHJlbGF0aW9uIGluIA0K
Y2FzZSBvZiBydDUwMzMtY2hhcmdlciAoaXQncyBubyBwYXJlbnQgbm9kZSBvciBzb21ldGhp
bmcgbGlrZSB0aGF0KS4gDQpUaGVyZWZvcmUgSSBjaG9zZSB0aGUgdGhpcmQgb3B0aW9uOiBw
aGFuZGxlLg0KDQpJbiB0aGUgcnQ1MDMzLWNoYXJnZXIgZHJpdmVyLCB0aGUgbG9jYXRpb24g
b2YgdGhlIA0KZXh0Y29uX2dldF9lZGV2X2J5X3BoYW5kbGUoKSBjYWxsIGlzIHNob3duIGlu
IGxpbmsgWzRdLCBpdCBnZXRzIGFkZGVkIGluIA0KcGF0Y2ggNi4NCg0KWzNdIA0KaHR0cHM6
Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvdjYuMy9pbmNsdWRlL2xpbnV4L2V4
dGNvbi5oI0wyMjMtTDIyOQ0KWzRdIA0KaHR0cHM6Ly9naXRodWIuY29tL0pha2tvMy9saW51
eC9ibG9iL3J0NTAzMy1jaGFyZ2VyX3YzL2RyaXZlcnMvcG93ZXIvc3VwcGx5L3J0NTAzM19j
aGFyZ2VyLmMjTDY3Nw0KDQpLaW5kIHJlZ2FyZHMsDQpKYWtvYg0K
