Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137E6701E64
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjENRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjENRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:03:12 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C606F40C7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684083788; bh=6h5IkKUEUoX9E6nxBnlkDnGiDJ8yVFNbekJHapFZT/U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CHYBVQCsLbg/6oE7nhoDFdiAAeHZWPFrxfatMzPOD/RS5v0KIvAgFJd5zqodAfLggF+dSjUhvmgItYv+jW/zpIy4EWsUeyZqPozB/iYEphqpmQIJ06zRDME6VDRoO5lKvLDY2YHWYp//mTQ55mtMGoJJEgHZ9iily8sVyM5/RW7h8mdIFKvGnzMqIAmBV3wi0K2v/OI/ewSHr4Mpk07H7Z5dWvff2tIwcXE5KoPUJXdeWXC4FYqX4Sttf9sxOkMketwtRS60BuapWC4rvo4FOh4n5XjhkrWm+ncdbzRMEIJWlYnMhcuE6AwvNi8HuiIvtDzYqTiZKxiYsbPu6MPd2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684083788; bh=Tfl1rHf8qWQJ4lzDyjX9rz/Zca2rUFDRAvmFt/z20Fg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BjE2D0b9X9q69g9TIsXqxVdkiflXhN81YFB2JUnLccWJ6DMEl+Ph6/x8RCxv/XCHDWkfnVtP/7vkbWKy0s8rze+grIxhvDkwzN+louMuMcjg9whaqWflbP/s/UId/quVcdDeOUdaY4YZ8U7Ca6LW7439VRh+/HrtwBmFdYbkrr4FI4l3lIV1cqNqEhJ10jFU5zmtDpT1dlGSGiryL7lCFsWA6Qvkhl6fHB9sLxeYSD1GGGftxJbjARCwxqAK8vK9X4SGLdjm4ibqODOB07n9lJyY1rVu+xZbK8AefRtBBcVsBAjXgtlqqMGo73PXi/LjtODb7GpJa5zZAeOETXzFEA==
X-YMail-OSG: Yn9j8q8VM1l_5.pwGOk3I_H2VpxkxaALa4chWX6XZ0fmiy1K77ChCVlb26ng.Tl
 iyXfRyM5aoKUzvatXlqQF.L1Eh15r.xpUZ9tLamjdXZ09flE5w5gicSv1bK9Vz.U0WkNrMIQ2WxM
 h9WvtkqsT2mHnL0QbpmlO7hPiN851ZtCOAE_VKI78GqHzhxC0n_k6rnZlQ2nBCdHigfev9P28aSM
 4UC7fEiUoODpoliOqOxcvEDWrLQsFQr9c79tQQnlD7ihNeNfHtJa02iLDHIS4jFiOIDoV6yxX0Af
 av_NG8jpXKQfUBF9uDAS_m4llOYjF5CbHQ3oBCsB.vEmBD9fzps6iLFjP0HBilCV5VE4G9L7936J
 afTrh6MqdTVbaESXOPxq3ohCWrlMroX8rN7BivE7aesY7qssEvXY6hVRktVwbjTqgI8sDhvVE61K
 JAwqeOd3pYmzL0iB5bzOG3VnmH8YxvV9yJnstLJDZhlSj9iumjyrCWNy.wSbKNdAftvDdVEt0tSK
 21V4bT53diAAHOQBLI8D2hR7hu5Au9u1RTBYgJt34PuCOaTsHMiSCh9w8vAEsOnCCxkxj6Vr7_Jf
 QtJSxWp.ft.81wycTlPWvUOlLm6yeokI7Cpa54UkDqTej0FMCVDrWIa_HlOps9002q9TLEQp5.K5
 XAfouUiyHyCe8UZIx_Vxin7mUMEKvWmhQMx8X5NbW138Mg6mGxJ6oK7AHBh7hDynQEtmNk4ZBQFQ
 vplA4iOdfV.Pq9LVUTPDLQwgP1C0Btyo0egibQRqOePFtoqWPqYvUMDtPTAT6oxrELlxZjFq9AW_
 Rfr.b..RmWZdrtYqjlUMLo6.cLTxyY_9ilbuvvJBGGbF4IuG3dJYTjOLBijLQJiOmOWqMBDiR1J4
 1UwQpunSdAID2oBgpJeamRv7i34nVPtDxJqVUzNafXyGT43aH1wupiQSS4jk7qWhpa2t_LXeQ4rn
 ek.WrctzyEUvOtcA9Kax5M4_hZmph3qppNXvYo4TdbPXoQlSD6ij4hVGigFr64Fs.0CJHTWctmq.
 pRdIuxgfrLOzLjtNX_sZd2z5Ro4FE5sa77ih3x_y8wWddCkmWneYw0Js5C2NPr2qS.dLhNn4LvYA
 hp4IlcwuCjSthc5D8but7LxAN8qGmUGlXMzHJBUyiOv.dLRGTCliAyW3eJ8ACNxz9n4jlRB5tyKl
 MibMNtq2mjmObJnvWcHG6dBniG3qBP7uAtA0SyQXgtCD38qjVihQQvzdhPc98JsRTp6LzM5PJadi
 qbkG2IbvGXrhtLSnMBiG_mNQweI90Y9VfrgCKxw6cabvpA7snHIdFQ1Fa3nhHQKBDxdu49upQ1Uu
 qsZBz24ew6ujN8a3X_VSsmfdRzp1y5QwXyEi9Ozfwrgjh6ID4TjyRD0GF1ZLFHrW9yi0Ub3X5gmk
 q8634SczFJgYoJT0nOZK0e3gL0sC19wHRymHqKtslSBTAgy7SgEKKUbI.lQHSYZmNqL0t8g507rx
 8qVyv5mGJVep73sJa6i6UVjr.0zd07YBwtDZCQpPJYeXHxbhkAWMda6aNmhVwijXzVm9O4Q1PwlU
 AigkCAAc58vGU0_cTSLmFTiPJNW1Vz9E8YixUk2XBl_ayTo6LdctvEnduwlZRjKwa4hIjIdkfVX_
 p15IX8H8ALe_hqzuWWYIqZ8JzKkfEyMFIFj8XqU_LvYG.e8TnMJDRbCr7PydtWS.qgqZ2alutNzu
 zZaEgie7xj9HH3zEyPrKql6eIWZrC.S7qbNK6hlch8NuPuMOsypsJ7xb5kBcqrBkBRHAzThFzFWN
 t8vkvMDBy7CwGHhQU8uyufa2Kejf1_khlrFYXLS_MwPkZ1jlo7dCP0tnhAz7Xlypn8S3VynPChLI
 3ZEgfK40chP8U7aSxbHrmrHNl4CnJkiwOSu5IeXF2z584dYvCrbo_4K3W5jejBjy64_s6WTeOVRQ
 C7aLBBo.1eJpiu8CDa6sFqISeVEuB2ARa9FZRkSIPIVMnIMabT67tEVlDwHTLqSA4yzYy3UB3fOd
 Ax7JDJjUD3o2qJqpA99nTWYtZoUFTpgGMcAOiTUP1R1qT_YcxUvyNjMTK6eRAwUiDYay1Aze31GJ
 2W6.tUl.twh7PLO4iXqKXzpgEX_MBe9K0Bhc6.zZCWIR7pTWaSW.6OMt5qaImR50LQ8NVnUifzDV
 IUyKQmND2iR4t7utTfeB7MgkQBJcblfuVApLVptRAoH.g6hf3SRH6rR4gX8xeL15kjVCVVgd940l
 U1fV0oM87vpCaxi2F4eAEmTWDllIrMm53n00Ndq0tWKmMpDcnyCDi7EHFKFA3282e87hIAIJWwB2
 wSM5o5Kx_BxPpliMY
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 682acc6f-3072-4f77-816b-221062e396f0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 17:03:08 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc9dedf7246204bbef0975e75e26807f;
          Sun, 14 May 2023 17:03:07 +0000 (UTC)
Message-ID: <b2a52060-6727-b91d-79aa-55cdb3cbc63c@rocketmail.com>
Date:   Sun, 14 May 2023 19:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 05/10] power: supply: rt5033_charger: Add RT5033
 charger device driver
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-6-jahau@rocketmail.com>
 <2e0f37ef-b80c-1a4d-2159-29598ac11156@wanadoo.fr>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <2e0f37ef-b80c-1a4d-2159-29598ac11156@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoZSwgSGkgYWxsLA0KDQpPbiAxNC4wNS4yMyAxNjozMSwgQ2hyaXN0b3Bo
ZSBKQUlMTEVUIHdyb3RlOg0KPiBMZSAxNC8wNS8yMDIzIMOgIDE0OjMxLCBKYWtvYiBIYXVz
ZXIgYSDDqWNyaXTCoDoNCg0KLi4uDQoNCj4+ICtzdGF0aWMgaW50IHJ0NTAzM19jaGFyZ2Vy
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiArew0KPj4gK8KgwqDC
oCBzdHJ1Y3QgcnQ1MDMzX2NoYXJnZXIgKmNoYXJnZXI7DQo+PiArwqDCoMKgIHN0cnVjdCBw
b3dlcl9zdXBwbHlfY29uZmlnIHBzeV9jZmcgPSB7fTsNCj4+ICvCoMKgwqAgaW50IHJldDsN
Cj4+ICsNCj4+ICvCoMKgwqAgY2hhcmdlciA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBz
aXplb2YoKmNoYXJnZXIpLCBHRlBfS0VSTkVMKTsNCj4+ICvCoMKgwqAgaWYgKCFjaGFyZ2Vy
KQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gK8KgwqDC
oCBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBjaGFyZ2VyKTsNCj4+ICvCoMKgwqAgY2hh
cmdlci0+ZGV2ID0gJnBkZXYtPmRldjsNCj4+ICvCoMKgwqAgY2hhcmdlci0+cmVnbWFwID0g
ZGV2X2dldF9yZWdtYXAocGRldi0+ZGV2LnBhcmVudCwgTlVMTCk7DQo+PiArDQo+PiArwqDC
oMKgIHBzeV9jZmcub2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPj4gK8KgwqDCoCBw
c3lfY2ZnLmRydl9kYXRhID0gY2hhcmdlcjsNCj4+ICsNCj4+ICvCoMKgwqAgY2hhcmdlci0+
cHN5ID0gZGV2bV9wb3dlcl9zdXBwbHlfcmVnaXN0ZXIoJnBkZXYtPmRldiwNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcnQ1MDMz
X2NoYXJnZXJfZGVzYywNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAmcHN5X2NmZyk7DQo+PiArwqDCoMKgIGlmIChJU19FUlIoY2hh
cmdlci0+cHN5KSkNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZGV2X2Vycl9wcm9iZSgm
cGRldi0+ZGV2LCBQVFJfRVJSKGNoYXJnZXItPnBzeSksDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiRmFpbGVkIHRvIHJlZ2lzdGVyIHBvd2VyIHN1
cHBseVxuIik7DQo+PiArDQo+PiArwqDCoMKgIGNoYXJnZXItPmNoZyA9IHJ0NTAzM19jaGFy
Z2VyX2R0X2luaXQoY2hhcmdlcik7DQo+PiArwqDCoMKgIGlmIChJU19FUlJfT1JfTlVMTChj
aGFyZ2VyLT5jaGcpKQ0KPiANCj4gSGksDQo+IA0KPiBOaXQ6IGNoYXJnZXItPmNoZyBjYW4n
dCBiZSBOVUxMLg0KPiANCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4g
DQo+IFdoeSBib3RoZXIgcmV0dXJuaW5nIHNwZWNpZmljIGVycm9yIGNvZGUgaW4gcnQ1MDMz
X2NoYXJnZXJfZHRfaW5pdCgpIGlmIA0KPiB0aGV5IGFyZSBlYXRlbiBoZXJlLg0KPiANCj4g
cmV0dXJuIFBUUl9FUlIoY2hhcmdlci0+Y2hnKT8NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGhl
YWRzLXVwLg0KDQouLi4NCg0KV3JpdGluZyB0b3dhcmRzIHRoZSBsaXN0Og0KDQpUaGUgd2F5
IGl0IGlzIGRvbmUgaW4gdGhlIGN1cnJlbnQgcGF0Y2hzZXQgaXMgdGFrZW4gZnJvbSB0aGUg
b3JpZ2luYWwgDQpwYXRjaHNldCBvZiBNYXJjaCAyMDE1IFsyXS4gSSBrZXB0IHRoZSBvcmln
aW5hbCBhcyBmYXIgYXMgcG9zc2libGUuDQoNCkJ5IG5vdyBJJ20gbm90IGhhcHB5IHdpdGgg
dGhlIHdheSBvZiBpbml0aWFsaXppbmcgInN0cnVjdCANCnJ0NTAzM19jaGFyZ2VyX2RhdGEi
LiBJIHJlYWxpemVkIHRoaXMgaW4gdGhlIGNvdXJzZSBvZiB0aGUgcmV2aWV3LiBBcyBJIA0K
ZGlkbid0IHdhbnQgdG8gZGlzdHVyYiB0aGUgcmV2aWV3IHdpdGggdGhpcywgSSBoYWQgcGxh
bm5lZCBhIHNtYWxsIA0KY2xlYW4tdXAgcGF0Y2ggYWZ0ZXIgdGhpcyByZXZpZXcgaXMgZmlu
aXNoZWQuDQoNClRoZSBjYXVzZSBvZiB0aGUgY29tcGxpY2F0ZWQgaGFuZGxpbmcgb2YgInN0
cnVjdCBydDUwMzNfY2hhcmdlcl9kYXRhIiANCmxpZXMgaW5zaWRlIG9mIHRoZSAic3RydWN0
IHJ0NTAzM19jaGFyZ2VyIi4gVGhlcmUgdGhlICJzdHJ1Y3QgDQpydDUwMzNfY2hhcmdlcl9k
YXRhIiBpcyBpbml0aWFsaXplZCBhcyBwb2ludGVyICpjaGcuDQoNClRoZSBjbGVhbi11cCB3
b3VsZCBiZToNCg0KICAtIEluc2lkZSBvZiAic3RydWN0IHJ0NTAzM19jaGFyZ2VyIiBjaGFu
Z2UgdGhlDQogICAgInN0cnVjdCBydDUwMzNfY2hhcmdlcl9kYXRhIiB0byBub24tcG9pbnRl
ciAiY2hnIi4gSXQgaXMgdGhlbg0KICAgIGluaXRpYWxpemVkIHJpZ2h0IGF3YXkuDQoNCiAg
ICAgICBzdHJ1Y3QgcnQ1MDMzX2NoYXJnZXJfZGF0YSAgICAgIGNoZzsNCg0KICAtIENoYW5n
ZSBmdW5jdGlvbiBydDUwMzNfY2hhcmdlcl9kdF9pbml0KCkgZnJvbSB0eXBlDQogICAgInN0
cnVjdCBydDUwMzNfY2hhcmdlcl9kYXRhIiB0byB0eXBlICJpbnQiLg0KDQogICAgICAgc3Rh
dGljIGludCBydDUwMzNfY2hhcmdlcl9kdF9pbml0KHN0cnVjdCBydDUwMzNfY2hhcmdlciAq
Y2hhcmdlcikNCg0KICAtIEluIHRoZSBwcm9iZSBmdW5jdGlvbiwgY2FsbCB0aGUgZnVuY3Rp
b24gcnQ1MDMzX2NoYXJnZXJfZHRfaW5pdCgpIGluDQogICAgdGhlIHNhbWUgd2F5IGxpa2Ug
ZS5nLiB0aGUgZm9sbG93aW5nIHJ0NTAzM19jaGFyZ2VyX3JlZ19pbml0KCk6DQoNCiAgICAg
ICByZXQgPSBydDUwMzNfY2hhcmdlcl9kdF9pbml0KGNoYXJnZXIpOw0KICAgICAgICAgICAg
ICAgaWYgKHJldCkNCiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCg0KICAt
IFdpdGhpbiBmdW5jdGlvbiBydDUwMzNfY2hhcmdlcl9kdF9pbml0KCkgYW5kIGFsbCBvdGhl
ciBmdW5jdGlvbnMNCiAgICB1c2luZyB0aGUgY2hhcmdlciBkYXRhLCBnZXQgdGhlIGFkZHJl
c3Mgb2YgdGhlIGFscmVhZHktaW5pdGlhbGl6ZWQNCiAgICBzdHJ1Y3QgJmNoYXJnZXItPmNo
Zy4NCg0KICAgICAgIHN0cnVjdCBydDUwMzNfY2hhcmdlcl9kYXRhICpjaGcgPSAmY2hhcmdl
ci0+Y2hnOw0KDQpUaGlzIHdvdWxkIGFsc28gc29sdmUgdGhlIGlzc3VlIHJlcG9ydGVkIGJ5
IENocmlzdG9waGUgYmVjYXVzZSB0aGUgDQplcnJvcnMgaW5zaWRlIGZ1bmN0aW9uIHJ0NTAz
M19jaGFyZ2VyX2R0X2luaXQoKSB3b3VsZCBiZSBwYXNzZWQgdG8gdGhlIA0KcHJvYmUgZnVu
Y3Rpb24gYnkgdGhlICJyZXQgPSIgYW5kIGJlaW5nIHJldHVybmVkIHRoZXJlIHdpdGggInJl
dHVybiByZXQiLg0KDQpJJ20gbm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGlzIG5vdy4gSSB3
b3VsZCBwcmVmZXIgdG8gZ2V0IHRoZSByZXZpZXcgb2YgDQp0aGlzIHBhdGNoc2V0IGZpbmlz
aGVkIGFuZCBzZW5kIGEgY2xlYW4tdXAgcGF0Y2ggYWZ0ZXJ3YXJkcy4NCg0KWzJdIA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNDI1ODY0MTkxLTQxMjEtMS1naXQtc2VuZC1l
bWFpbC1iZW9taG8uc2VvQHNhbXN1bmcuY29tL1QvI3UNCg0KS2luZCByZWdhcmRzLA0KSmFr
b2INCg==
