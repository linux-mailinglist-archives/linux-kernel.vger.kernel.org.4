Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2B6F9147
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjEFKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjEFKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:48:36 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C7E5D
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683370112; bh=34POWJfYWl8FSDgSOXM7AEN6MSN18FWEKbOGON9u4j8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Zutrm/IV9A1MpuFwX9SN0Jr7OogIyb54kRnrHDqSZMb7HXbooZfbtOLR7kCQbwVTxWXBpZMDiYecISoYGoZrTiJCnF20oCK/RcS4qwfPAU5x6Z4WDrwuBIrUUADU0JsdmR9s0llG7byw9RSBhioiAeEd3SAn/wC7NfLbspdYTFhWUlZG7FxA9C6eckMR0JSXEhbYUJurt5aivQJkfhL0OjTX7Lw/CnTe/qbhqHYYBY/ZGHf8g/TdLvKZb72I6Q5mNRXooecCvaytD33biX6QQmbwdmHmTjTcmOsLd/r6yzyTpHn0yebgoSbF7vNzXpJ8Otq2r4saoSTJjir27ixvNg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683370112; bh=TIWkndNT70CXVpf6Mu0SgJ7Uwic1X4aMTtTtqzRqMNH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RVmAEPRFn6Gi6U5t8V3KOsUhIiRADO+mdwPi/pawvcK/3DRTymnK1JOOQrrxnG12dh2cRR7P1HaRfLFfutC3yAQWTKssZQM+IUjgi0M5Twbv7su7CLuSMKMvNKFYfb+AOmY9S8msD93TQD7WkFnf46JEIjQbSof5axYkDyY6V0D6fowPgGDZVXKqn7wPM3doBtiFXc3/53v7PdQjTCdKUTQcfKXf4p7tQS5zbSgdnps5pUoiHYTo0ekrMNTMD4fSgZ9FZp2q/pAXfmMc96DrRycVA03mj3EXwYNBke9wZgGHRl/H6iRbgSwTnBRwkSnoWDxnUwC+7V8GRN3MSoU+3w==
X-YMail-OSG: CIBSjdkVM1kniNdyxwVcFNGw.KZ13EWraHHyR7IJgWxBLDDRck5.HssO5C5kwXu
 q_XSn6djpihEoRrLVipaiPbgXJqtW3p0xPYMklY.MwqnTLT3cCXh3UvRnePp2IVVXCXVfBkP95FP
 J5fTV6RWybkqR0_LAzkaMay9ZmOeq.cUDKUHfaWssl4Wmcd7LcJSxujXy9HSbxVVfrjiUTtmylmw
 867RAX9y6KFsqQSBg93xheo9cddjkoD3U1_3y.jLKvjFtoD0ohlonV5HiDt1t8kk8Mc.UJeuKX07
 o4KXWBgENp7cYfn1.cKwBl8VEYG0wPIeRT4oHxuSLp.TOizu9OeGzr2c1_gHqlMzHATavbxhRPi5
 RRzgGumlM7RKVkj7VHjj4NcgDKl1ZRFbQAI3gUc316.BDS9y4_b7TIfkhDnf7bvXA4CvQzId0Hc0
 soAZdXpxkMG4WginqbqhWfakRmxcl6uO2dBG4DFxvZ4314Hqo145k0G0RukwOWeY5tQWnlHwsy0I
 4iauBktQOZJpU24zvcCvVi3N7UwW00Wmxera3WntaeqlwCtZJJ15DQ4CpVbilFlGcB2HT4U.jW4K
 cI0GiWoqB70TvUrWFZroErTRHAJXKS9_kjTiovW0WQoPHgcFxFU.5hiK.4sN4LV0xg5L_GGvzPbN
 SJWHsyDzB5VMpnfLspM8sYn1VEui.ZGWd76.vvqdyIJBttGaWW3v4aEQ0v6CaEMQHRNn_xpx6OY6
 AjaZIafEgqIyEbXIVAu28bOk9SpqEacn8uONqMKL0el18BjXHRAoC2E1.wI5yRh0J7rD.e.swaXv
 riBtVxyrXD3FMqJ9iGORGt4kZ9J5G32THeRxegzbwIdEvv0ZfOoK0owQNfwdBbDP8_nvzCBZab3N
 3OhnFKDao0Dwkq7WsS8FvacD6fENjGE0hO4rQawE5W8hlqjzEurHVKMi0L0JSwW1bjby0O6rR65a
 z0B2saLBOnvLlfLyQGJ6907mEUqigLIHJKvBf6W9liLuM7mtzWUvKPFTVP87QjYZT65LLNx0x6MP
 8HTgHwkTHcIKLU1yGlklibv9x2Vc6jbbNq6B0JbHjyfvPiCTc.uut4xCwCYx.2.7lWPPovya7opn
 tXqJPr8gEL49xZq0CuY1DIsTSa6FGHCTBzVNG0whneb6ZpPrASli95qBNKOrg0._.38A3iU3x_xX
 2GP2gw8VMSGLn1ZymKYlfteN7cnFQJazumALNjtZ3GrQBDCFvUBLHm_9MdBDTVBTU8KsBSFkwc_.
 V3DVkQqArVaaJTOIALfNuuCoG2cR.lxZFk0eWqPBiCjliv1IODE49c71z.zF8DOrEdbGJaxw9DVp
 Q7aQZG.oOLE2zdosFdPWLydj9JyZEsUWyCl4bSvGkJjz2opj6yS3ykvB2woBpkjK0BpdSzGbkTkB
 Zs5.pmwQFXBO9UNJsxyP7nLd7f2NYtvR6PstAqCSVhtYzgtd_RS_9f0BngVe9D_TFc9GWwcj9IAH
 gcmLYzrzvpt4.ZdNpEV4lQiMY_.ZrncA79Dp9ADr0MQHkQfJw67miVWmEyoR7MGkQ3wpPurYYXsK
 Pg_Sxu50mN6arYB7_jQY8oBMe6CwJHCwe9RowVqLATXP03w7KdQrgyWpYr.kmLdwPPqAadgBbHp6
 IC_B0m_FGT6x.yJNY2RpBmF7QdblTr8yveyX92LU2D_T5umjSCKcmaXXVK_gp3GvA80fSCQlmyWB
 AqH.AGC51mXqm4f4fWyMYUjXxpUjDOgY.mpdjHps0.n5q1PfGQmYIp7g28zjwr0rr9Gqpj.2ZLvj
 oU.9V0b0RyiBvRuW4anmRk1LK.YgBKkTGq30RVIIPs.UnYl6Yzl1notaIM8RrtSoddufmFqdJO7i
 OxyORgRPue1DUT5wvJ69H9Mkel7K86_LrJ46X.XUaFquSKOuSdjF5T5QNjN2rzZxhTOrPtH9NnAd
 cJE2SI.K0_dji1YuHIz._rKurnVjRtbhGBZrA9Xx3lhtI_KjlYmzG4.A_CskzjXFORH3TUuPX_Vm
 U7ORxVFgLibsj9GV4CbywEDyKpjsh1PK4FCDRz96hkQT6ENeTpwN9ZIdB51yXKllPxal4tcQoypB
 Ft6R_FpNYYn_InDkEnx4Lbn9dw.Pg3iv.6Q5fIBBWYD4drTUeXW_xkJmHuD8F3lJHUQcN7qAvj67
 4e.ObN3tBUSwYDdcBL5FYXfxJ3TQC0C8pe9GpuD1zRNYZVJNKiPQxdfOY1uG1.Jp86iA4qPNdxy8
 nSsb_uBQKQtLTViKgCDxv4hraWHK7Ge5oFbsv5g1kMdOZeUJZtI8tEQ07UaT.5xMWqsPi6ijhO7M
 Hbd32BsJUAZUz_ctqsyMgfs6K
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 5c1a8a68-86df-492d-aee9-94ebdef5cd72
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 10:48:32 +0000
Received: by hermes--production-ir2-74cd8fc864-db5p9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9a7e9e2dbdf1abecded434fe1bb5c8d4;
          Sat, 06 May 2023 10:48:28 +0000 (UTC)
Message-ID: <295bb56a-bd40-abe2-4469-c38827ea3069@rocketmail.com>
Date:   Sat, 6 May 2023 12:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 8/8] dt-bindings: Add rt5033 mfd, regulator and charger
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
 <73c02d98-c306-5e9d-2737-ff2d4a7393d1@rocketmail.com>
 <20230505201334.GA3459327-robh@kernel.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230505201334.GA3459327-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 05.05.23 22:13, Rob Herring wrote:
> On Wed, May 03, 2023 at 09:33:49PM +0200, Jakob Hauser wrote:
>> Hi Krzysztof, Hi all,
>>
>> On 02.05.23 12:59, Krzysztof Kozlowski wrote:
>> ...
>>> Apologies for this, just very busy times. :)
>>>
>>
>> Thanks for letting me know. Take the time you need.
>>
>> Writing towards the list:
>>
>> I think there is a misunderstanding here.
>>
>> The connector node provides information about the installed USB hardware.
>> E.g. property "usb-role-switch" means "Indicates that the device is capable
>> of assigning the USB data role (USB host or USB device) for a given USB
>> connector [...]" [5]. To my understanding, in relation with a port node this
>> actually says that this port has this capability. This is not relevant to
>> the rt5033-charger driver.
>>
>> The rt5033-charger driver needs to pair with the extcon chip because it
>> needs the information about *external* connectors being attached [6].
>>
>> Extcon devices like SM5502 or SM5504 are real hardware. I'm not adding new
>> properties. The way of getting an excton device from the devicetree by
>> phandle is part of the extcon subsystem:
>>   - function to get the excton device by phandle: [7]
>>   - line that's looking for the property "extcon": [8]
> 
> extcon as a binding is inadequate for handling the increasing
> complexities of connectors. Whether we need another property to link
> things to connector nodes, perhaps.

Thanks for clarifying.

>> The connector node is the wrong approach, as far as I can tell on my current
>> state of knowledge. It doesn't provide the information needed by the
>> rt5033-charger driver.
> 
> What information is that?
> 
> You need information from the DT or run-time information from the
> 'extcon chip driver'? In the latter case, I'd expect the charger driver
> to get its connector node (either TBD phandle or search the DT if
> there's only 1 possible connector), and from that get the driver
> controlling the connector.

Yes, the latter case: run-time information from the 'extcon chip driver'.

Hm, so I need to add a connector node below the extcon node, search for 
that connector and go one level up to get the extcon. In the specific 
case that's an unnecessary detour, I'm not too happy about it :/ Though 
I understand that in a broader perspective the connector thing can be 
more stringent.

I'll prepare something like this for v4 then...

Kind regard,
Jakob
