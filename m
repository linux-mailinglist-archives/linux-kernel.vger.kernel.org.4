Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4576D373B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjDBKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDBKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:22:09 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A883C6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1680430925; bh=m9L6SZ5prf8E0bdWOCcSl1DF9QdE18Gzz3G/D+l45J8=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=Fe+kUy+FMJHpmtp7EpCHy/c3ZzImzEaC/Oo9vSc5qB3ncql6PrlXp0C+fW9vTybLcL4mAZ3LzcHFdGHU5Y5n6KlxoGICVvfGADcGizX2iXhufeuyU6GJbAu2VmQkWheAlMzQGXIuSoR827SyNVuU3B3JBcA+s2fGogkTutq/prFXbItCroDfZG0DB/ltoZsVhnZTje7r0902xovO/c13PRjj/YYq4A7aMoz/YV8BjvBoFjiXzqSKuVbCF3H+TB8jkb4YZLfLg9YW8fDkif4csmu8ME8Wzu3dowDkntTmm2RTUF58mgPapMH6zZdtcTRyRwADi3iBXLEf57EUVapxUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680430925; bh=F/4Pnn3aSI+X00MBI5dS3hofxq1QFccgzo/Oc3jIODQ=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=kpmTmTGW2wKHaLPmodaipDa/GgEXslY0wigcHsLKpUa5l7csZFSLYgXtLhEa4D8z80i/4y8mDQ2RUTIMbfJ5a8Dmdj91Fjdri5n0dXM9jN4JdqQUl3M24QoKUQyVSQiUtR2gjoy2sPUzI2mbupHZgBLTCquV7tn/p8msF0VRYkoZn6mqkHLBXCUq8jrsvfthFbnBpnFbvP59juNCehr826ZFFpbshoGLrrFvobI6iQ+/rLPHAoA/5EGYFanx3gVMS5W051/PCBscX1BhwUhVL5Mp1miM7K73JSJeUJvRuw2uUDiN2l6aadKk9fTlRigHAO06x61ucdt6BkQew0ty2w==
X-YMail-OSG: _ZBZPRAVM1kiZGdvFyyB6rIO4OuuH9PrNxvjQlpcSuVNcPVABDhLa3qzWgYdmpE
 UKenx3zafUVP533sF331SGm3GLRB5yTtpVX3CuAQ6QE7s6dgVRfxJeOjCuP9pJGJPVggKsHnrXmD
 OTz4grHGLcDV2WfdbK3DxnXP5YEw11pfMln8QVsj70kBSMlup4HiBFYq8eMt4LuVPzSE3pEeoybl
 0fZli7rbDRAqq4N7SxaBUk8.phfZwvWsJvhluKX.gGIn1GqpZKA_6zwiDHBVaU5EzZ5KgY1d3VEb
 RZOmmJ0rFoGzvQvHUsxo_OS_10f4ZUQ2sY6nnzGGRf81VOakkamtTprsVi2bcwQKe9kk8yVSJsjb
 VSMzS306amCBPlbI8Ba3N0J.scr9PTfX4l..L_TazxU5Wsnb40IkmCm8ZrA3vcPZuvdW0KkqdIex
 yijQ5oUBbmBGgDMMpnExfh1RByavKv6OJQnqoisL5U68Uge1gmqMUzczuPh2oQMjyhEOVaFQTubK
 HT.0s9Vf.RrW4OJ5TxFLcQu.UGu0_q3ltrgagQWIhido0jYwzRIUt80o95PUqr1msgPsvGdSWw0Z
 vf21Zavc3gwWz16WNppLG82ik0tDXlsrJrFx2em7RhrID6wgu7E3talbr4FcOqcDibwk.cgnsaFz
 YvxzVWJNgqgrdKGneNxuV7t4r4AJlv94lt9EgFtaubOLew6qITfWTGG5nHX00XM5Rap2ntJuT56z
 bUJayNsKBHFVaBPPlCqTmqma3KL1e2CpmrBkNjQ6O5RXLpFOu5INm2J6hGH7Y6JR8G15yc9iNyT3
 t4yxyN1Ize5d8YMoO5_ydnNkDmZwOJSSuTAXv1L7e6DFU2kUDCTQGlrD27R8JEZGG3ZBg69fhJnO
 aauEf.OrQVhNk6OgMcPcJJCU5NyHgj2L3PAww4B4K6DzfnvHSrl.TzDe6UShjbpNvqtxNIDe3qgU
 uo.kDvMD4BKjmdwNnc2ChyqK6ENYRP.BisEgNScuNoefBnEfT8WwVFYDvJSt50_v6qypNL2DmUQA
 W5Rc.eQQ6htI3CGmfgN2HFU8Z1BOpCRBm8sKL0vyWJKCoT09NSCEFusfNebfnIN.gxp31JV_yMEa
 uqnrHbQ5nGGZ2l3HthopDvbPnmcJfy3tDFOpM3_YG6S9XjRk3R1bm3nqT2x5rPEhv8vXg9LCAytN
 m222pGhFysHBrn6fch3Qhj9QW_rl3lZ1YyjBw7XJhvlPGbHgELrQKhwYXNn5cMk7I5Y0far5nh5m
 GLp.o566WbJZVf3v.iFMnX2Ym98J4j7MLyEFv2ygmGYzu7FPHeGcB8d8Ps8IJi1MkijHtAB1qO6w
 L7ftqYE6Bmtm_6HuE7B6Zm1X5ra0jffNcL7Tq6Hc_L4SZQBNLO7CX0p99TiH3cO0hlkDda.KuLnv
 2skrF8WjpEAfRcxtRGzFGaDhl34E_DqJF4C8XGOz7Uk27zrV4BHuNH0fVLAJ6jDbnm2GjoQBMyoz
 Y4ckI_dA.KqwMWqctwuAvXSVGP2bNQrk4oEabYIpF7a70D7yWsFtOKJRJ.DItn3hKjddatlWR.Te
 PBusFvJspTucYDprMB1dkXh4sdoUWI2Aebd.UWlYnsQWz774rO2i2zI1p0PXTHlpQzAe9Eifg6Sq
 nYdpeYsRS1IzGcxaE4iYUUv1Y87y3dJymq_TuOdSUezq15sXj06xmDcI0uWUuQE5YhCpzUCFvIdK
 1OsCTBl6gcIt7KUdTid3tsA9Ii.FXB6mcio6mw_xlIPTXa0Tf1sK1mwBGnKHxOlK6qcDG6SdRYq8
 _qYFVD6gVssxIfbR.GSsJYR7AoQixmahWcSfglrQMKmWxTI_uvVIeWy4tcavkaCmBW8.7DM0v7Gr
 UNbDb9kjI93.da1avw7getdxexZPIiGuVV.rg.wEMZC2t188Rc9nowxVVKwXmCuqJ8ZMNro8.IHX
 qltEdL54kDiaAhdorZnb2TV4zPhs5FdCp6N0rvf1FiOzaNm4SDjtFRhZWpaNDmJhSLn1Cn0a51SF
 vHZS6ilpTKrRxNwCXGRhFSCpfzh.VbyACLGTA5gDse66WwCqdxmQCZVzKgS6mvWJv08ud0nTgpL0
 AjDHQL6BVsgRwuWlMI4E64jOAkCY7acYa25OKpMGj3lTuBqlWTCvw9eguPb9pusLiGQErzngZFQ2
 jn7kH8ei3QOQVuUARMrmYDQyn87LzVVZtNCpq4TGkEabMNBYrRKzUb1s7WuJIynsef_jUTX3tOXL
 NL2BgTq86dDGgDACkZxYULnxzIjURM4R5HWr5djjKCPzC_xdH.oxpujKQqkwYi13X_ZwpCb7hAve
 u_mZJ3zZgRBL9j2LlG4.tuSwrJnM1
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: aa6b6124-f94c-47a7-aced-8e1f47f37f04
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 2 Apr 2023 10:22:05 +0000
Received: by hermes--production-ir2-74cd8fc864-jl5bm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9d737d6ab1f22b3307aa97ae1e45a223;
          Sun, 02 Apr 2023 10:22:01 +0000 (UTC)
Message-ID: <b517db01-f60b-bc71-830a-d72c5cfed81f@rocketmail.com>
Date:   Sun, 2 Apr 2023 12:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/10] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1677620677.git.jahau@rocketmail.com>
 <a698f524106e0eb7db5cbd7e73e77ecd5ac8ad7f.1677620677.git.jahau@rocketmail.com>
 <20230301023545.GA235322-robh@kernel.org>
 <0e008725-66bd-5c3b-e641-1bcf9dcc24e4@rocketmail.com>
Content-Language: en-US
In-Reply-To: <0e008725-66bd-5c3b-e641-1bcf9dcc24e4@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAwNS4wMy4yMyAxNjo1NCwgSmFrb2IgSGF1c2VyIHdyb3RlOg0KLi4u
DQo+IE9uIDAxLjAzLjIzIDAzOjM1LCBSb2IgSGVycmluZyB3cm90ZToNCj4+IE9uIFR1ZSwg
RmViIDI4LCAyMDIzIGF0IDExOjMyOjI3UE0gKzAxMDAsIEpha29iIEhhdXNlciB3cm90ZToN
Cg0KLi4uDQoNCj4+PiArwqAgcmljaHRlayxwcmUtdGhyZXNob2xkLXV2b2x0Og0KPj4+ICvC
oMKgwqAgZGVzY3JpcHRpb246IHwNCj4+PiArwqDCoMKgwqDCoCBWb2x0YWdlIG9mIHByZS1j
aGFyZ2UgbW9kZS4gSWYgdGhlIGJhdHRlcnkgdm9sdGFnZSBpcyBiZWxvdyANCj4+PiB0aGUg
cHJlLWNoYXJnZQ0KPj4+ICvCoMKgwqDCoMKgIHRocmVzaG9sZCB2b2x0YWdlLCB0aGUgY2hh
cmdlciBpcyBpbiBwcmUtY2hhcmdlIG1vZGUgd2l0aCANCj4+PiBwcmUtY2hhcmdlIGN1cnJl
bnQuDQo+Pj4gK8KgwqDCoMKgwqAgSXRzIGxldmVscyBhcmUgMi4zIFYgdG8gMy44IFYgcHJv
Z3JhbW1lZCBieSBJMkMgcGVyIDAuMSBWLg0KPj4+ICvCoMKgwqAgbWF4SXRlbXM6IDENCj4+
PiArDQo+Pj4gK8KgIHJpY2h0ZWssY29uc3QtdXZvbHQ6DQo+Pj4gK8KgwqDCoCBkZXNjcmlw
dGlvbjogfA0KPj4+ICvCoMKgwqDCoMKgIEJhdHRlcnkgcmVndWxhdGlvbiB2b2x0YWdlIG9m
IGNvbnN0YW50IHZvbHRhZ2UgbW9kZS4gVGhpcyANCj4+PiB2b2x0YWdlIGxldmVscyBmcm9t
DQo+Pj4gK8KgwqDCoMKgwqAgMy42NSBWIHRvIDQuNCBWIGJ5IEkyQyBwZXIgMC4wMjUgVi4N
Cj4+PiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+Pj4gKw0KPj4+ICvCoCBleHRjb246DQo+Pg0K
Pj4gVGhpcyBpcyBkZXByZWNhdGVkLiBUaGVyZSdzIHN0YW5kYXJkIGNvbm5lY3RvciBiaW5k
aW5ncyBub3cuDQo+IA0KPiBIb3cgZG9lcyB0aGlzIHdvcms/IEkgY291bGRuJ3QgZmluZCBh
biBleGFtcGxlLg0KPiANCj4gSSBmb3VuZCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvY29ubmVjdG9yL3VzYi1jb25uZWN0b3IueWFtbCANCj4gWzJdIGJ1dCBJIGRvbid0
IHNlZSBob3cgdGhpcyB3b3VsZCBiZSBhcHBsaWVkIGhlcmUuDQo+IA0KPiBUaGUgZXh0Y29u
IGRldmljZSBlbnRyeSBpbiB0aGUgc2Ftc3VuZy1zZXJyYW5vdmUgZGV2aWNldHJlZSBbM10g
bG9va3MgbGlrZToNCj4gDQo+IGkyYy1tdWljIHsNCj4gIMKgwqDCoMKgwqDCoMKgIGNvbXBh
dGlibGUgPSAiaTJjLWdwaW8iOw0KPiAgwqDCoMKgwqDCoMKgwqAgc2RhLWdwaW9zID0gPCZt
c21ncGlvIDEwNSAoR1BJT19BQ1RJVkVfSElHSHxHUElPX09QRU5fRFJBSU4pPjsNCj4gIMKg
wqDCoMKgwqDCoMKgIHNjbC1ncGlvcyA9IDwmbXNtZ3BpbyAxMDYgKEdQSU9fQUNUSVZFX0hJ
R0h8R1BJT19PUEVOX0RSQUlOKT47DQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCj4gIMKgwqDCoMKgwqDCoMKgIHBpbmN0cmwtMCA9IDwmbXVp
Y19pMmNfZGVmYXVsdD47DQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ICDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gDQo+ICDC
oMKgwqDCoMKgwqDCoCBtdWljOiBleHRjb25AMTQgew0KPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAic2lsaWNvbm1pdHVzLHNtNTUwNC1tdWljIjsN
Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxND47DQo+IA0K
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVwdC1wYXJlbnQgPSA8
Jm1zbWdwaW8+Ow0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVw
dHMgPSA8MTIgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gDQo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaW5jdHJsLTAgPSA8Jm11aWNfaXJxX2RlZmF1
bHQ+Ow0KPiAgwqDCoMKgwqDCoMKgwqAgfTsNCj4gfTsNCj4gDQo+IFsyXSANCj4gaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGlu
dXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nvbm5lY3Rv
ci91c2ItY29ubmVjdG9yLnlhbWw/aD12Ni4yDQo+IFszXSANCj4gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3Ry
ZWUvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL21zbTg5MTYtc2Ftc3VuZy1zZXJyYW5vdmUu
ZHRzP2g9djYuMiNuMTIzDQoNCkNvdWxkIHlvdSBhZGQgbW9yZSBpbmZvcm1hdGlvbiBvbiB3
aGF0IHlvdSBtZWFuIGJ5IHN0YW5kYXJkIGNvbm5lY3RvciANCmJpbmRpbmdzPyBJdCdzIG5v
dCBjbGVhciB0byBtZS4NCg0KPj4+ICvCoMKgwqAgZGVzY3JpcHRpb246IHwNCj4+PiArwqDC
oMKgwqDCoCBQaGFuZGxlIHRvIHRoZSBleHRjb24gZGV2aWNlLg0KPj4+ICvCoMKgwqAgbWF4
SXRlbXM6IDENCj4+PiArDQo+Pj4gK3JlcXVpcmVkOg0KPj4+ICvCoCAtIHJpY2h0ZWsscHJl
LXVhbXANCj4+PiArwqAgLSByaWNodGVrLGZhc3QtdWFtcA0KPj4+ICvCoCAtIHJpY2h0ZWss
ZW9jLXVhbXANCj4+PiArwqAgLSByaWNodGVrLHByZS10aHJlc2hvbGQtdXZvbHQNCj4+PiAr
wqAgLSByaWNodGVrLGNvbnN0LXV2b2x0DQo+Pj4gKw0KPj4+ICthZGRpdGlvbmFsUHJvcGVy
dGllczogZmFsc2UNCj4+PiArDQo+Pj4gK2V4YW1wbGVzOg0KPj4+ICvCoCAtIHwNCj4+PiAr
wqDCoMKgIGNoYXJnZXIgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInJp
Y2h0ZWsscnQ1MDMzLWNoYXJnZXIiOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCByaWNodGVrLHBy
ZS11YW1wID0gPDQ1MDAwMD47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpY2h0ZWssZmFzdC11
YW1wID0gPDEwMDAwMDA+Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoCByaWNodGVrLGVvYy11YW1w
ID0gPDE1MDAwMD47DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpY2h0ZWsscHJlLXRocmVzaG9s
ZC11dm9sdCA9IDwzNTAwMDAwPjsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmljaHRlayxjb25z
dC11dm9sdCA9IDw0MzUwMDAwPjsNCj4+PiArwqDCoMKgwqDCoMKgwqAgZXh0Y29uID0gPCZt
dWljPjsNCj4+PiArwqDCoMKgIH07DQoNCi4uLg0KDQpLaW5kIHJlZ2FyZHMsDQpKYWtvYg0K

