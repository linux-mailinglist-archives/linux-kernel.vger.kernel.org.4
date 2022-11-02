Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008C616E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKBUS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKBUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:18:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB310B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:18:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o8so13268093qvw.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7qHySYZS0PwVla6hd8xMiHelx/ePWY/te6ufsokZBF4=;
        b=BJ2sE7+f0yBn9uvu92/Q+FtcoQkZAIo20XyEOQtK0/Z7LFjPplvx9+1aPEeFZ4W2Wl
         DMWZoV+O4X4HcEElq+pBevUi8tiaqsVFUz1Xju/6coMeUC5b7KqokR2Yps4vR4EtA8ro
         82GeR8WFcPuF5qITLwegn7imsB0+ekzvctadpPspYLfDvjIhho0m7JrYNdAci+21hnc6
         iUvGDvVXtRs7Woqi9kxFx8CdjtWfyTvh6uECkyMW7RnmwmN0XGUg1uEsytEDi5imnipS
         KDSGpRE9m5/CexQOAbGG5yhfahSiUs2ML5urOCvEgJjlBZbRAsMLMQ9jI3PJW+UbCkuv
         TFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qHySYZS0PwVla6hd8xMiHelx/ePWY/te6ufsokZBF4=;
        b=8OCYmACInvLOspS+LBsce5FRiHTsdTSyGAcylKvZAgQQjJdTWA904AAj4i9rtyCyZS
         5GzzXovimbViL1YZ1ywFtbEB+EStP3kd65X3SNgaG74YnJ0/xTJzV4wy1oJekiaYhnAV
         6m29OVLHseVri9vnCwDVlM9/p05SSbAG4Vi1LbfFqfRgng8IjEJMsGSxpzq5e/0K839w
         EAJPsmB51qgk1mc+OV7AuxY2nTk91d7xqCE/E7977aa2xAGg2FvygN6oBq0y3S6F0Beq
         NhZ3Wb7TaZV5p0EDF2G65lkmAKmJ31tT9hy5TwFPSGyjg91bOSjktr6JMbU2WAvCPeUU
         w2Ag==
X-Gm-Message-State: ACrzQf2VuWWmQHRVieVm0JowUg5qfzmaEcSL55JNgpFLWe+XHhT44iIc
        sveQFveUHavp8nETF0GtgY2T3ZnzvoUEgQ==
X-Google-Smtp-Source: AMsMyM6COPGJLY6ZtME4RzzhQZhXwMHalxHjg9eJIAHAf33PmoH6M4eHXss+dbvlH0mKPCx6K2vxRg==
X-Received: by 2002:a05:6214:5182:b0:4bb:a323:4ca5 with SMTP id kl2-20020a056214518200b004bba3234ca5mr22968700qvb.121.1667420303098;
        Wed, 02 Nov 2022 13:18:23 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id bp6-20020a05620a458600b006cf9084f7d0sm9085317qkb.4.2022.11.02.13.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:18:22 -0700 (PDT)
Message-ID: <f984b1b4-c9a5-bbcf-65f2-08e3f231dc96@linaro.org>
Date:   Wed, 2 Nov 2022 16:18:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCHv1 0/8] Add support for sam9x60 curiosity board
To:     Claudiu.Beznea@microchip.com, Durai.ManickamKR@microchip.com,
        Nicolas.Ferre@microchip.com, Cristian.Birsan@microchip.com,
        Hari.PrasathGE@microchip.com, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org, alexandre.belloni@bootlin.com,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Manikandan.M@microchip.com,
        Kavyasree.Kotagiri@microchip.com, Horatiu.Vultur@microchip.com
References: <20221031033653.43269-1-durai.manickamkr@microchip.com>
 <2902eb0e-815a-9147-49e4-182376df378d@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2902eb0e-815a-9147-49e4-182376df378d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 06:20, Claudiu.Beznea@microchip.com wrote:
> On 31.10.2022 05:36, Durai Manickam KR wrote:
>> This patch series addresses the following:
>> - Moving of flexcom definitions from board file to SoC file and
>>   some minor changes to its properties.
>> - Add support for the new sam9x60 curiosity board based on the
>>   existing sam9x60 SoC.
>>
>> Changes in v1:
> 
> This series is actually v2. Also I cannot locate your patches on
> lore.kernel.org don't know why...
> 

I was not cced on this submission - I got only reply from yours. As you
pointed out this v1 which is v2 ignores several of my comments.

Best regards,
Krzysztof

