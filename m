Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1336FB846
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjEHU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjEHU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:27:43 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C449DC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683577660; bh=nJW1ESaV1kmgLBW5VxiFmpc8abef90KqglXhu6OWXx4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RUeDIQ9Xvs4liUJu2VwqK9VFRmrEydL4idAkqcCZWsneqdvX9RaDMJynSIIekEWJfsP5gQdRxpIPQbbb/daGywp/fpCoGvFVi3zbKzVzlJulqmxM0ho0YgTL1MpxT5/+ilAhXYk/x8HpdO6u9tFmVIRZqkgjLe6gtidj9XkwCpweaQLLxmkxgDVxnMiGsZD8tNDatszL2sS5poFGcPe3PDGpqCcak9spxPK3V+FcsPiRs7RN8On8uwFa/0q3QWIEWjA/2+NgjaNoarjGn95M+KYMtYgKE7OwwSlSQajx8mKQ3QWz6ZPRjFPtRT1eTDIaeUOYdeMI2uN0g76qMx2wqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683577660; bh=HKSOp/2MDc3dHaUiV1Fj4vGEBbeUEbno2uUKu4Vtm8M=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lAvqd8kSI3IE0nYvzAWwCAITbL9dnpmNsrS/MwxcAHMk6fzKEhSXO1/0jfpVm9ZvKyI/23XB/xhhNME9+qX4859EASeBzQWTrR9y4m77EfwRM7geHE0omKzP5PaE/rFKBz9ipD3WkBU/g27o1TkOEYUpUrh+FmuQolSXpzcY+Qzq497GOiAgVKft8F2ZwPiFzsAvs+8d91x4etpupx9R9S6Ky01YoMx9ENLfyb43ofQ+YRVJiRuGanUNj+KIl9hS+11s34ffiYrtd7NTCCDnr/01ePrUbjV6vshgruIh5Be+aCYaEBr23OGqQJ+iA+7dTWIHCqOpJzVHiPmHMCG5DA==
X-YMail-OSG: Q1uO4FcVM1mucj433GE8R..WUafEy49fnHwgRP.XZ2SfJJO9lLAWhAI5rFQlR1g
 hM9HiRs3.udspbnpZF7atNUXcPGwellQHAXXROXlrUyaNp31Rg7qDdwbqf032V.pcO7RJkuaxV5L
 tFsoSTf2SCzo8ik8XGG03GKAdiYsNFJIfF6tzCzwNIVH8qLq1PGAfjQSTIAyg5qA454xTetXsJ_7
 Y.ggxdRdko7JR0X1L9o8xxqJb4Su2.Zzrmu8a2WDB0jhy9bmslkhjougDTYisScLO5t5vHptgEtd
 hmh.q_CUfSToACDVNHmdqqzP9Lk3gFVJh3dZQxsPyjq0QcNXmPxP1Ir4K7yp7SdxffsfP3ZLMRNO
 C6dZiwb.estptPgh6BPVsD26UZngLms2TpwKCkePiPWDzrqtxqPkO5ZbR338IEQpWXITzaB.IhgG
 0ZzoMMaBV_9ul_tDwwwk.E8MvTZ3hh18IvhMAyKWLL2n_ShYnvF0XeGiOmQhqR6phUJsC9ABb1gD
 aVuQkfUdW9dvk9Cv_n599Z05LkfMnRaS_RdajTUaeD.YMCqRo4d_TVQXqCBmHFFLSkBduacK9Rda
 WDlG0AD_L_dbLtJfzoQtD6y2PKImm_swSR89vjte01Q5mS8LkPqRRneckiqRky_ofzGBcpwj2DZ1
 Gw_BJY7NTAY56YZoZA5YKEyhdYBx9qqgBAhQNuEymPrA_qWHYFBWo.RnQ34_Bka3FvjMg0CIQXNV
 p.j7REsqHSyv8NWvLZ42HEwqdgxp09ZCkiIyv5mDwLc5wHPvAGIkUrvPNLTxAuGIJN4.Vv3.KeIX
 i0n__YlSnGwngQNZpG6bNDlNe7zAZrmaZh_4c4lZsuIzoqjMzBjmyiRWOptGDlje2CV6m8y149Mz
 lLSTmbPeqB_hjUqXxOLjUJMhTXPW74vM096Ea5PlyWhimtFAgYDpa2vpxOzh2fbBQoPQKVjYAwWM
 M8_GzIS56dY6yQoUj08i5Fz3EB9vl3tCm7Azi8Eq6EHAbSLX8FMq3dBC6Ak3xVbaBKLYmkOCNS0l
 9dRA7vsBxSP2CMd9xkVEv0q0mlMnAL_Lt.R9IEmobdjuggWgJerdxC_AlNdHO0rPUHPmR2mafkob
 Pxs99MCD_cvAmhEyX0klm7Ud8DCuoLAav4xv9.ZV9P0bNzxKkk4116QguwxcKH0CJVnebSqRF6OY
 D4tyUSEGq.cYfaPOReAVbuwFpi9spN9.P08FiPnxhBrvCGNmFLZ4Ch9zoPulXOwIrrdahOPwciB2
 41c5PaboNNZ_fUbao_0aklvJ0Y1dMJMA7Kan6HCeFvB7X4f3KwALDvwjVIIWkqX_lOaIdFxnkMtD
 AL1dQSAJlYqtW924wFH5RekMzy8NZFdSyHbHnMWZOrghCeMov87D2x10VtDOqC5Re6qemI2eqXZm
 oBZfqzUvhDUiC5IPxTSEZp.INsEjyg6anf1w6E.RA1Wu7hT4iK6cM.iQZma5L4QxBNMHYylyMfJ_
 nQ7VREACKvnnH5bTDnYtpOY5hsF6.RZqzFYh7tgf2DDj0RqZH3DRYAKZuVxFyrDuv9vQFi6mBU_J
 QYAoH0yQGsw3tuofGELlHPqMDZ8MMIIuCJ_2dFULQ_jYNa6jTKNCvsg_v4O388U_nbN8iuIKii7M
 35f5iAeIB2Qs1jA9SQsA0bGKbWrlcLPh0KBSHpk3M0JEsoXEu.KfN3AbJ2JzZu77UJa4BdwTmFyT
 NqeKyX0xw6CzyTam6ruV_RPd9QJr4xxIK02ZsMZWcTw8OGU3ZG24_CkUAwcFAVfzXogs6EKxAfz4
 xv5SXrTczWG0OVwmgipoPCcDmwo8UPRZnCOWVN9ciQv7RssM5_Ol_1L2gqBP.0VhOgztUY0CRHbk
 bPaiR.0C.FQTzMF1wwv4ZoBaq73CmDXME9LGCjcWACqQ29_0C7zEL288xdlysL9RWOwosyJaZ4y2
 Y.MgQiFbK9y6MDvx82dNsU6FqQQc..0iUfADPy8NLHqxmSzMWoVOfNccw0qxRQenr_lo7Y4jSSdh
 gx_I83SY.dwOuMWO_pRtCZ_MxGUn8gMMrAGCoSttIM.qWxAmTqcCUaA1hVfSOSQEYZeuGSU9ztHQ
 sgQq8uuv86kXecPsS6js9ct0nmx5nN8Yu7KEyqKnea0d7Nuy5ZwwftrWaG_HZWUKONLvOKojKtWM
 LzsCBTbA3c38lucCFu2zpr1U__nmrFfCk7DrKA8MOiJU4akO9cVVjXNuqUiSKHcDDrQzMjqKAkLW
 CdL9s9WVDqt0QoL50A_prCxX.X1f4ixoWlDiqi9qeDBWpFvNvjm5.PI.xBUWKzYjVAo71T35VfEz
 _kB7Pe_zEPw--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 2ed4212a-6c18-47e0-856d-ff8715f6eb18
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Mon, 8 May 2023 20:27:40 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 51bd34991e3aa17df81be9381000d656;
          Mon, 08 May 2023 20:27:36 +0000 (UTC)
Message-ID: <4c99e915-b067-367d-bdbe-095b7f244aa4@rocketmail.com>
Date:   Mon, 8 May 2023 22:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 5/8] power: supply: rt5033_charger: Add RT5033 charger
 device driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
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
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-6-jahau@rocketmail.com>
 <20230508065014.xfftu6vorxgqdh7h@mercury.elektranox.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230508065014.xfftu6vorxgqdh7h@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 08.05.23 08:50, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, May 06, 2023 at 05:54:32PM +0200, Jakob Hauser wrote:
>> This patch adds device driver of Richtek RT5033 PMIC. The driver supports
>> switching charger. rt5033 charger provides three charging modes. The charging
>> modes are pre-charge mode, fast charge mode and constant voltage mode. They
>> vary in charge rate, the charge parameters can be controlled by i2c interface.
>>
>> Cc: Beomho Seo <beomho.seo@samsung.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
> 
> Driver looks mostly good. I still found a couple of small things
> though. Please find them inline.

...

The change requests look reasonable. Thanks for additional hints. I'll 
implement them in v5.

Kind regards,
Jakob
