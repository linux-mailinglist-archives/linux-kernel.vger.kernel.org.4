Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC56F5F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjECTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:34:04 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C783D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683142434; bh=ey9VVE3Uq687XRWPjw9xJG0+/i9NqHt1pJf3+QQYMkU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dUrwv+E18P+1nqMvWWwiLyhz3vFaqYAUyJ4qQlquWBDPa2XITjS8mQAmnYGT/ADw7R6D9Y6Rn61nFaeyw5uQrUPsuh0P93Dof6VsMluYMDU0HgL9xKb7FqpEZlm6mrdoOZ8s5FOhGYZkohxFuhM1kFfljA3VxH5OHX9QMseeuMT+u1xLnFuBDm5CWoQ2KUEdxnHSRyrJCAev1mfLK3IA6dMPrl+rWbfSIyLcWVE3IJUv/N/CyfcEuNHxf0di1thyJhTf6uRSv1yCfM4pZBTxDVQOuRZmVcOGXW+RVCun5TdLZA9Gh4RwF/ndRapAPQX5IHPmjK0QhCf7F3ibc+Horg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683142434; bh=yA9jaGS7se1Bezm4p7uzrd4/l/t5BDw8oa/i6BT6E8G=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AG/gDbiLeZIp3xw1A1vd1kB5tyaAwgrdmqVLsHwkQVsJ2gfWoXGuTM8973huaKr9GJMra9il+20iRxQdBwKvUSp0B1yEg1/wq/pXYGt/FdrVfg9UH56Mn0jTuuqympWWuxEUe9fKTKtX07gSzDBYpAikv+d+ozMcfm25WXm/JiFpuDHTD/3QTqGgptsPzyZ9uIDhH4WgkjTDge8XBHC4c8ZBITOclahq5xPizu9b3C3+TvY6F/q77k6HFj5HlyBMyozYdUuOlbFkAEBop86Nu6fcsYwrRGQ9LHyiPR2wL0f73iICv4SjtWxpamzEQqHOUUhviLNJGyv32DA+m+DuRQ==
X-YMail-OSG: 9KVGGWEVM1mUcFY.b6obNje.xO7veIhWrPxAqQWlA0AFXwl2.j85fOQA86M62FV
 Goj7ryIWdOmpUeQ.n3zxZ5A4wIyFBWO02E79EBymFgGKCRaKmD9nAn3dcNlIzRfshFid6X9r5b2Z
 8x1RdNQiRjtWiY2zUswMqfWCnedDdu6goEKCWM.tWAGXpGQkxZuoFLgfaKhAJqQrlRiME9ZdXxOo
 b77if20wBzS1gvq33jnPdf5BZJBPg.m_PXlZsXNLLIUMHroUIfmeqvZrm1yxhVmHhv.K5bBt8EyZ
 t0kzaOU8vQA1Rbs_74HTrXjoImqFC4dTlZT1QIWEHeuU5Qf20.mEZNfFARGok6g4sUTXLMGBOmGX
 cegJEe.5tboUcF1h2Mbv3JXb9W2pGvaISXWOp2dLvud6F11S6rFvimm5xzstt5AyfkC_i8sD2RdW
 29_wNx5fR8e3fVlcEfn6uz9fcI4ozgNtwfwNxwkM41TAaG5Uy6TaSi48zFYx_Gfjdw6eeWmAH4fx
 TrOsO4J.RNA6SfrqketVgloMmbZkvJ_acws3kJ8Sr66wcT92VRoNubaIrqsFRF_y8KvZkpshVAYV
 vqQpGVQyY62ALLM7o4dmgv8AFm7gJELBE2Q.2PdFTrNMI5sXOe7UBbA.03ltFavKQWrfOCj7lxBO
 us0jJgQVl8ik4ehJzsCrYi1VrkqibrU4VgpzQVRcxoM75P5SnJiyfErNN7qKBkExNm8De37lxsuT
 9iodJ1BZAxR7zo0SGUFQnOks4W8g0oKkbIupRj4pMoX6zQiMM4SSf4obNHhPrR.IXzLrBh4fgbaA
 aiFxX9UelEk5GLSkw5I6vS8XjGv8AhngaN7M.14asWPsNB9NBgnvKz26cPI1r5Jh3LwTXtDGQMYB
 BvfsvvsrXW.xBASsA6MXY9J5pMEtCZYVbRVyVHHGkb0T0b4u8Rz1zJpTlqmN_NdBz14TKkPWScEo
 1LYnVh2bMom5_xurrJMEO7OumOVCLAdKgQ6I.t693ujbEIHDN62gKjPZCG.3CiAnkYZha86muEDy
 wNu_2FO4Xcg_J10TXFolzXhv9Or6EC.OrjQtZhTJwVjRkW_LlMPemXYwFH1gtypi9tL4sUyt0kIt
 ANxusOtpZ5H_8v9uqPkgr5Zx8ULJ_AaEkPOoWMuKWFOyqOm3Ap0mTvC2pZfh8hhXUvctEkhLSIGU
 MbUW0nrtbu.f_IZeoJHRDC9FK1cdVItE6H4ojroSKLZNJnmVasm.fEp8NcBcZ9b9t909FBjvTEkX
 ySmeRbOBW.tQ1hx1IydY2Ys1RZfZUR_FaLJ50cPnTk74mpyJbZj1PopNquUTO1p9iTLQNgLZrXK1
 k5bYMgVX23KrG6D86cbyAIHWulPoVWKWfB_VQlBp6CxtUabT87Hi5qolxPzqJKlUSQsIvzeiELZD
 .2o.6ho9gULDWNnKm8ULyam7beoS9aNffPlMi63o0sQ_pwmY5fjTLCXki4k9SzfRV7tLPpZ9ana3
 5uiiYEiK7FGk8sP.6uKZbK2QTjpUFOmRf2Xp3SUeqpQOfdag_cE7JNgh.TgJxFt7RACgBDZzo5kP
 o.U1cNuoaQLFarncmN8Z.LkuXFyu2kwWS2nXgMvSpWnMX6bQBvbXNqiG2nQefLi1StpNozMNS7AV
 DwsbfEUeIX0tN7i7wJUYodVw1OWDnateeTDXYZ_bLsQ4XQu6wdRWidk5R6khV8bqZJeXgBNImkQj
 kxSEnQ_qcN5tvnHkDmuC9hocfJzLI1w48W_1mpqG1_wWAnMemBVU2vZdwNiyafSe4uQAfuruWWPt
 bK3yRZ3QiXA6Y8aZ4X0OmQTwQ8u6Gsy4RmtsQ6xt8Q4JVdG5z88M0iNMQ4Fr2lAIcFNCmLbX83Fu
 rd5uQ1SngxL2FeAfts4ihqQlIascOYO0IwtUmwNU1wdZbKfk_y8.Vvhcg68MlnAnXCQCBuiG0AXX
 XpwE1OjWJXfkDpInnYgcCNTndXPyqqSR_S0_TjQVidjyMEqaRGGoZllvcmS8z05BIgJCE5N2dyId
 9CNUylSSfzEM8kJldkLgNkIexz0bPkhSj3pyUPLzYwLuAJHh2yI6T_dt6svL3lMFuYANyjNM5l1r
 9wEK.6ot5OT6XPfy.tu.rN6C2BuY2g_s7XBWUfQRgPOpVCTNKPk6g5IpmkvU6nZAiGpeHNMnTmwo
 hO5SXyW2pzO5JlGk10_lgC4bvU94S_osHG8HlCM5.xDZ1OUZSCm82M4TgmAu..qJM.HFZXzXe8kj
 csPgokK5PvoyJ1ATARcAkBM8XMWbgIQvGvXguVo03nHwWCKWEIo5P.8KIvIT_YYJtZ0hYxTlzGcn
 3Xt33wKyWn2O6MzMs
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 0780ab79-d664-433a-92c4-ec9a24601688
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Wed, 3 May 2023 19:33:54 +0000
Received: by hermes--production-ir2-74cd8fc864-qfvhg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c1dcf3a945446660b55a441263fb7e62;
          Wed, 03 May 2023 19:33:52 +0000 (UTC)
Message-ID: <73c02d98-c306-5e9d-2737-ff2d4a7393d1@rocketmail.com>
Date:   Wed, 3 May 2023 21:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
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
 <14daa006-5260-81a8-8ba0-4122e0c0509a@rocketmail.com>
 <a0f4252d-7f27-6dd9-dea0-f8d242011f70@linaro.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <a0f4252d-7f27-6dd9-dea0-f8d242011f70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Hi all,

On 02.05.23 12:59, Krzysztof Kozlowski wrote:
...
> Apologies for this, just very busy times. :)
> 

Thanks for letting me know. Take the time you need.

Writing towards the list:

I think there is a misunderstanding here.

The connector node provides information about the installed USB 
hardware. E.g. property "usb-role-switch" means "Indicates that the 
device is capable of assigning the USB data role (USB host or USB 
device) for a given USB connector [...]" [5]. To my understanding, in 
relation with a port node this actually says that this port has this 
capability. This is not relevant to the rt5033-charger driver.

The rt5033-charger driver needs to pair with the extcon chip because it 
needs the information about *external* connectors being attached [6].

Extcon devices like SM5502 or SM5504 are real hardware. I'm not adding 
new properties. The way of getting an excton device from the devicetree 
by phandle is part of the extcon subsystem:
  - function to get the excton device by phandle: [7]
  - line that's looking for the property "extcon": [8]

The connector node is the wrong approach, as far as I can tell on my 
current state of knowledge. It doesn't provide the information needed by 
the rt5033-charger driver.

[5] 
https://github.com/torvalds/linux/blob/v6.3/Documentation/devicetree/bindings/usb/usb-drd.yaml#L51-L55
[6] 
https://github.com/torvalds/linux/blob/v6.3/include/linux/extcon.h#L32-L60
[7] 
https://github.com/torvalds/linux/blob/v6.3/drivers/extcon/extcon.c#L1361-L1392
[8] 
https://github.com/torvalds/linux/blob/v6.3/drivers/extcon/extcon.c#L1381

Kind regards,
Jakob
