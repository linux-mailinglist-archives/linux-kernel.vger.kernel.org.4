Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537D067CB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjAZMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:45:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793812E83A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:45:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so1650926wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+R/6wadgRiiMD4sotvBbPRqjGYH9rID5eNd2RCXKPs=;
        b=hEmicxiLft6mvMiNadOB3g6r6SdiNxlmkaj21e3ooP32EUXZa2/dkOqb0XvONbqql8
         LBtKgQI/HboUVq6rUC2DRbpl2MmrNDbMc8A5Ml7XxbXr7xlVg//B3sfLPOQjR3DMHKwJ
         5WJyDMVusKkk6nv5QRgDe4S8G2ugGgaW7D5LXXlPuA87jz/8SSbRHJ7sfwbHLD4kGUXB
         h1IXAeh4faz8Qy3ThEaGjn33eZVCMTTzmZAf4+0QXGeFscecg31i/DrTNc1f5y6hff8d
         XMAmmMF6SVxzUlt7MUeodsPRcKYulfGkysY26/sL63OwWwLHZXxVEozhvlDZ2JiEj+mp
         yTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+R/6wadgRiiMD4sotvBbPRqjGYH9rID5eNd2RCXKPs=;
        b=ZFhUUbgsbJhYnyaa12bo8+lqJK4tTuU61oK5au9C3KuI43sNaQfr2XXoa5leD+d921
         I1TBKC2D7BJZHNOdK2Wll/OQvo4MZiGRW25WykI1zUo7ah/BEqLLMxRiDdGPPeP9Uswr
         UuXCmEpSFrDwmhm1CmLiikUvyjAPg2DLpgzitRTzve9UkKUzbimhSlC6baE+E7cNcMh2
         XOSJkoMJ2mMn/LR0u7CL+wTG1wMQ10pCFe6K913zN7f7JDHCq8nMd+Wq8jd72Dgk0ZXl
         xUe3t91N9pllau/Fzr5iwsj8WWTKwdBsNHc4CH6JRS+bCaDFIM1uVG+h0XHms9UFvq84
         mAuA==
X-Gm-Message-State: AFqh2kq1ryknbFiASLDTXTs74j9OmxiLIjitnWLaH+kK/qPkCAxUZZSb
        8ri+9e43U8n/WYYoR5OndKR2obckfzNICE8f
X-Google-Smtp-Source: AMrXdXusoUFXdnTyWscShwZ1Tx6N/LO2+JGiqmIfC810SDuaE1NHVLA55jYSHvTNmZn6F2vrSKXYDQ==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9468:340 with SMTP id g2-20020a5d46c2000000b002bf94680340mr19232086wrs.19.1674737124844;
        Thu, 26 Jan 2023 04:45:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4d0e000000b002bde537721dsm1205916wrt.20.2023.01.26.04.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:45:24 -0800 (PST)
Message-ID: <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
Date:   Thu, 26 Jan 2023 13:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR
 compatible strings
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <20230125083248.1305270-1-victor.liu@nxp.com>
 <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
 <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 03:54, Liu Ying wrote:
> On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
>> Hi Liu,
> 
> Hi Geert,
> 
>>
>> On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com> wrote:
>>> Freescale i.MX8qm/qxp CSR module matches with what the simple power
>>> managed bus driver does, considering it needs an IPG clock to be
>>> enabled before accessing it's child devices, the child devices need
>>> to be populated by the CSR module and the child devices' power
>>> management operations need to be propagated to their parent
>>> devices.
>>> Add the CSR module's compatible strings to simple_pm_bus_of_match[]
>>> table to support the CSR module.
>>>
>>> Suggested-by: Rob Herring <robh@kernel.org>
>>> Suggested-by: Lee Jones <lee@kernel.org>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>
>> Thanks for your patch!
> 
> Thanks for your review!
> 
>>
>>> ---
>>> The CSR module's dt-binding documentation can be found at
>>> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
>>>
>>> Suggested by Rob and Lee in this thread:
>>>
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C3fa98ff270534078019508dafeb34b10%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638102343312884116%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=zm8Z5gWt9yGXakYlxopUfZKLMUJRWTxq1kWHLyqhyww%3D&reserved=0
>>>
>>>  drivers/bus/simple-pm-bus.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-
>>> bus.c
>>> index 7afe1947e1c0..4a7575afe6c6 100644
>>> --- a/drivers/bus/simple-pm-bus.c
>>> +++ b/drivers/bus/simple-pm-bus.c
>>> @@ -120,6 +120,8 @@ static const struct of_device_id
>>> simple_pm_bus_of_match[] = {
>>>         { .compatible = "simple-mfd",   .data = ONLY_BUS },
>>>         { .compatible = "isa",          .data = ONLY_BUS },
>>>         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
>>> +       { .compatible = "fsl,imx8qm-lvds-csr", },
>>> +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
>>
>> I did read the thread linked above, and I still think you should just
>> add "simple-pm-bus" to the compatible value in DTS, so no driver
>> change
>> is needed, cfr.
>> Documentation/devicetree/bindings/bus/renesas,bsc.yaml.

I don't think we want to start putting specific compatibles here. We
don't do it for simple-mfd, syscon and simple-bus, so neither should we
do it here.

> 
> This means that i.MX8qm/qxp CSR module dt-binding documentation needs
> to be changed.  I'd like to know how Rob and Krzysztof think about
> that.

The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have device
specific bindings for non-simple device but use simple-mfd. You cannot.
simple-mfd means it is simple and none of the resources are needed for
children, but that binding contradicts it.

Now you kind of try to extend it even more make it more and more broken.

Rework the bindings keeping them backwards compatible. The combination
with simple-mfd should be deprecated and you can add whatever is needed
for a proper setup.

> 
>>
>> If that doesn't work due to DT binding constraints, the latter should
>> be fixed.
> 
> Adding "simple-pm-bus" to the compatible value in DTS doesn't work,
> because "simple-mfd" is matched first and "ONLY_BUS" is set for
> "simple-mfd".  s/simple-mfd/simple-pm-bus/ for the compatbile value in
> DTS does work, but it means that fsl,imx8qxp-csr.yaml needs to be
> changed and moved from mfd directory to bus directory...

Because the device is not simple-mfd and should have never been made
that. I am surprised it passed Rob's review, I guess it slipped through
the cracks.

Now you have to live with borken bindings. You have a lesson for future
- put some effort to design them correctly from the beginning, so you
won't have problems. Bindings should be complete from the beginning, not
"I'll develop whatever is needed to match my driver and I will not care
about future".

Best regards,
Krzysztof

