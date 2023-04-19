Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867206E851E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDSWnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDSWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:43:30 -0400
Received: from sonic310-12.consmr.mail.ir2.yahoo.com (sonic310-12.consmr.mail.ir2.yahoo.com [77.238.177.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0259C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681944121; bh=DiXiE/1gerU+3DYKDimYWGfxbF+vuI55TlPqE/rlYqU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SpzDdu0UZ/fGMv4/o4nLhY81fqstVeN+cyaiHe1Kz0AOYFuex8a7SPhZ4OTq2bhihEpDiEp2jdE3qOW0IQRZ8hXsfpyKqXUNdrcU5gQl5TCYSMGCpJWGFcaJixwWrWxySKS6zQONuqUCeuW6xnPSFVbuyh6bmgq2SI9MA7EtThCZWrhBPlGraDLr6/YFi1+G9hYVwmkG3XQvAQxwffF0EXyVv9HPTLgSWnBSXtt+6Wn4BkzZ4AxYHAtulQZS0shP5XMNsXOGrQogFuPV7qsja5O4JJNzD8izKqGtKBx2E9yG2nDe8dCgDR+QzQSYc1plavKNbO7QxXM1wMOJBhqTEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681944121; bh=ev/rs8vyiV8vNxalCiSkN1YU4QbzUCepxWOTZOTl8q8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=W+LZEFMA0tYPRbt/JA6w2EgbpO3y8VGSj6p56dDNGhY0PH6uYB0bbcMAz/yK6pTRd3vc4XiOW0N2If9boBCJ5NWYgFHCoaZof/nYqU41QcmBgX16ZxIpgxEBDJQ/qN2OB0Z6YU/K8NOmLlKo/ENd6Wc73RHSRhMSdBnLebeZKrlqjbkCubO1TQA96OrsS8gEvKR1coqagLbHmxgqNH44NVPZq7A93TLUpbE3JoWvUof0DpJ8HvaJ2TajJwPbQnCg4SOuWpRiv6A/POLUYmaXfjoJqlk+OFvkBlR8o+yLiT8wJMz9d300tAV6Tl+sFKabX7oZc61HzxWLnOlMkHUgmw==
X-YMail-OSG: fyVOcfEVM1m96XlvCFfN_FXkulnUCMmxIH0jD.3iNQ7unHvweOujjzZIy6mThZo
 xSY0_BzsNNE9c12d0cyVB0A.DdyQ.ZFfEtmqzxBFTCWaTkIL6h1fHx_YMo_FT.yRIe.WOIchlJHi
 FMeD29Oji1SuYAvWY_nV7avoliRzJb0Aqm9BNBXjiBu_pLW6NtC3q9w_sPgIdom86Oth7MR0XKgw
 6zuXESmZ1dubygpgfrE.klu0qLIU7__RCF0LdDOazUdbjaiGb4uH3EF.VQG.fAstM22FlQmnyygd
 rj.dqx5D84Y7liPhx0Z6jRyZWSL47G9CfCOWXGuerh_TQCuIl7Qmd0BWQgIK.qQo.FBHsPp9UQxM
 TuVENCZtpv5YxC0EwHYb2N5mEN4kZWNRTRm6jyyVBGHsuMc_15ocnvDlM9vrxfgoy6ltP1_Na90k
 h2fGzzCP716mHhCC..jkGXQF5h13UeHd0Ftf3PKtMskqWsf7GJIX7fc.E1Ovxj0ronRq_yay.QCb
 t6ufg35vN6kVikMxmjaM_lHvKD7JtmQVhmP.EE0RyLv5SckmVoxRA_eTpQgjS.YtqP.S9UR5DS6E
 bsQ6GnDth28GwPdqABhMi03k5EOSUpWa8cHL1tmPB3EXk5XUyf9izD6zTf17W5wdwlaoaCm8qjZU
 Rjw1kF6hK1c4961HgIONBMtxUN9NyKxu6rClzaOCQl1DrhYkjmC_N6RpgBAxhvo.8y9zjPdrIFrt
 RLNH9M19SyXoOV9BAxTII4RVhu.2YxKwAOVcSuRPpoeVpnLcW1Ln6Q1F9Pk6JG_biBqebMyrW0Yy
 glUtBD6o3w8Pz.582XNrLdPzHB4gGduT8zGew5_RVRRrDmITyDJDIAt_2HQeguFDvfEubVo2T2Un
 l0zrrZh6diqtPXLq2mE8fE8xQ6rsUtrynlctpaMOZvEmFrmt81DIRXd5.hK6uK.ckdSPFhtXRtiq
 jAB6xmAwonqhek38XaxbyN3ZBW_bwNZC0aCVaXa2ZNt3kaHbtPGSS4wrNbpK5440c0sb615b68Wh
 ZR4FB4RWasU6tbVEYPl3iPo3Cs0FU9fI4n4ipL0Q8iPPy4mdMGeoBI3n8bbeBaS2dVr0K3IkYYVm
 iqOxZHtZUX1AUcakdKTme5qnNqLEts5qTcCWNkRVQ22stahttqn2VxJL2SWPBj5zhwRi9wys8NsV
 gHQhf.Y5npV2OFm9r1ScA_uGK8QBJoe4rKT9nv.UsnUUNpecZXDycDyZk54.DDPl8ka8Kdelb1GV
 CYaL04yS87FkeHc2XCCWtBz6bNrwpVR0vVRqDtM38oifgXrApU.eEGVxX8Ag2Igw_mZyYeymmNWh
 xnSEF.Nglr4_jqlnZ6EKAmaSwApAS2J5stKewaaDomX_jRSpErdIC9YwfwM__oaV34.SqkOuzvs4
 YA9ptg8psZrT1Vtl5HJRwulX6puxJjBjMoVe2a.Ljcrf0Qob.505QJ9WyTo1OrzSuzUH_yobuKFd
 req9DaDgYp7qvrNJSvrzxePeka3YDuaWFtGzwHcAKcoxkGsGivkkDcsOMZO_S6.4Nhcurf9bbVCH
 HSumaz4JvJ5M6wKl_zFJqJJrbfKu3fzmRXwLDp3t8ZkbGTxpYFjrAQcz73qlSGsXi8A.MPUW.tjl
 e14DWbF17Uc_FbsT3ggE3z3Ngr7Im7vGBaBzx72vntUTM3GhuKBDLqZGW1SFoYOTatRGEtk6YSOD
 Y3tGJdB09qbKiXSbmIkLJ0ANKzAm5Qu2ENT4BVKj3GlZqR2YlNqKVHd5o_SdRLEFtlvc2apK38gE
 oreOPQvdRLXihvpI4QL5yJJH9FnMOIQhMNiaUYMI7sHXTUdQ4WX9Da6yn3DXeP5hY4M3eHqz.ilP
 TjuH9BAVx9Kim7MyuqJfrHQWioA3owvWO5gilx0QlAOTNC6Azy9eajgDoM7SL8hVtNeFE_5XP9vW
 VH0GaFzWSV5YFbpcd.bwYwc4tIjlCTb8qRQFGmFmC6akePXMXeUtkkh22SRAklkp9OMETf.UFk4o
 F_fkRBFeZ0ZGer9PC6Jo7zgVcqrtlrBTLHd6SQEC6vo.tjzUaqcezaksonQSTQeTrUTHBpjeytNW
 xDk_w6tk8anEM5gNsxwdQa7lgYz6z6x_FgZVsOAqsxou8nIWuvaTe7JGD2Aupkhm2MPtywa.nKAb
 z1.LcgIGTRIqsSgDjnbUO2itzZDs_AIewFT3xYdVdyfEEVFtQLGwuq5Avv0dgJp52uclOP8sPXxB
 ZrBpAoRJy_PxBxdoXV5MGmQvmpJzRs.99jMgQcxnLqnCalqZekT_D4d4g7GvtlOu_Jmvb7nPSEa0
 e8aID.YQTayNoBB7OHUyrhC2U8ISuUSs-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 1a39f33d-85a9-4766-b6a1-28c18b0e86e4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Wed, 19 Apr 2023 22:42:01 +0000
Received: by hermes--production-ir2-74cd8fc864-qfvhg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1848f5b565d7088490b56d0999a0e274;
          Wed, 19 Apr 2023 22:41:59 +0000 (UTC)
Message-ID: <457244a7-9d28-a19d-40a5-8d45861b709d@rocketmail.com>
Date:   Thu, 20 Apr 2023 00:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 9/9] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
 <5b41b54c-88d0-3666-9db2-9cbb90ba8183@linaro.org>
 <acb209ce-7cb6-9a07-c913-9931b980c8c7@rocketmail.com>
 <a638055a-97c2-49ce-f301-45d0ce897df4@linaro.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <a638055a-97c2-49ce-f301-45d0ce897df4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21416 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 19.04.23 10:42, Krzysztof Kozlowski wrote:
> On 18/04/2023 23:37, Jakob Hauser wrote:
> 
>>>> +properties:
>>>> +  compatible:
>>>> +    const: richtek,rt5033-charger
>>>> +
>>>> +  richtek,pre-microamp:
>>>> +    description:
>>>> +      Current of pre-charge mode. The pre-charge current levels are 350 mA to
>>>> +      650 mA programmed by I2C per 100 mA.
>>>
>>> minimum:
>>> maximum:
>>> multipleOf: 100
>>>
>>> Same for other cases.
>>
>> The "multipleOf: 100" doesn't seen appropriate to me when the choice is
>> 350, 450, 550, 650. Those are not multiples of 100. It's more of a step
>> size. I didn't find a general property for step size. Listing them as
>> "enum" would be another possibility, I guess, but not an elegant one.
>> Especially for property "richtek,const-microvolt" there are 30
>> possibilities.
> 
> Ahh, right. You can use enum here and min/max for other cases, where
> multipleOf cannot be used.
> 
>>>> +  richtek,eoc-microamp:
>>>> +    description:
>>>> +      This property is end of charge current. Its level ranges from 150 mA to
>>>> +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
>>>> +      in 100 mA steps.
>>>> +    maxItems: 1
>>
>> Here are two different step sizes. The first few are 50 mA steps (150,
>> 200, 250, 300 mA) and then it changes to 100 mA steps (300, 400, 500,
>> 600 mA). How to deal with that? Again I guess "enum" would be a
>> possibility, but again not a nice one.
> 
> enum

Thanks for the reply. Looking through the properties, I get the 
following result.

   richtek,pre-microamp:
     description:
       Current of pre-charge mode. The pre-charge current levels are
       350 mA to 650 mA programmed by I2C per 100 mA.
     maxItems: 1
     enum: [350000, 450000, 550000, 650000]

   richtek,fast-microamp:
     description:
       Current of fast-charge mode. The fast-charge current levels are
       700 mA to 2000 mA programmed by I2C per 100 mA.
     maxItems: 1
     minimum: 700000
     maximum: 2000000
     multipleOf: 100000

   richtek,eoc-microamp:
     description:
       This property is end of charge current. Its level ranges from
       150 mA to 600 mA. Between 150 mA and 300 mA in 50 mA steps,
       between 300 mA and 600 mA in 100 mA steps.
     maxItems: 1
     enum: [150000, 200000, 250000, 300000, 400000, 500000, 600000]

   richtek,pre-threshold-microvolt:
     description:
       Voltage of pre-charge mode. If the battery voltage is below the
       pre-charge threshold voltage, the charger is in pre-charge mode
       with pre-charge current. Its levels are 2.3 V to 3.8 V programmed
       by I2C per 0.1 V.
     maxItems: 1
     minimum: 2300000
     maximum: 3800000
     multipleOf: 100000

   richtek,const-microvolt:
     description:
       Battery regulation voltage of constant voltage mode. This voltage
       levels from 3.65 V to 4.4 V by I2C per 0.025 V.
     maxItems: 1
     minimum: 3650000
     maximum: 4400000
     multipleOf: 25000

Kind regards,
Jakob
