Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B66FA221
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjEHIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjEHIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:24:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7942705
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:24:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so16722035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683534263; x=1686126263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5LglcJTmAOL674iFSW91v8iQ+c+VWN66eezYdcY/eo=;
        b=FkoBtct+K+FHjRPlHL9ykOQXt4jjYt99V2O+8Vje8XlvSQzc6v+6j4rXJJruHwHd5I
         wj2Hp+C2JBQLstF/iJcFcUWQRCc1HgKdzlVL4cXoWSeXlt0Z5chr0kXEnr/CttPDrlbY
         x2QIlOimiAyMBchumS0veYf//2RtScWx9T2KoBIqrvzBuKroy1jh6B5sGhEZg3rpDDwW
         4JtorSK0X+Dzb8JNk9ZJ4KEx3ovHxrpZF3/S01fHY/WUoBD8Iy3Xff68c6hi21Ii+H/1
         51Bt4xy/tufm5jMIKbRql0n/WodjbVuz0M9OOYXrUP1Y5dTSFRLbwg5KNCSV0fIg2hbg
         ERbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534263; x=1686126263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5LglcJTmAOL674iFSW91v8iQ+c+VWN66eezYdcY/eo=;
        b=ObukBHWKAezzfACTyZasvGedidYsK2Pt4UGltnuhRr4J/ZsORgm9o4P0n0G28COJF3
         f1aU4QcBiW6G+yAMIO086+cJkQqqn/BH0tquGxkBV+KEBjCP47qplqL3f+LNmaCqoe3k
         lNLcsf0K9Ol3lvPsy1jcgqgDbOQKJn3R2h5oHZUtWxFZ+RXjc4+e71ok1Ccr78if4nJe
         dQmNAShdhRDenQ25yV6IsybTcyDji0iu++MZTgIYqqDgXtr7kqmlw6erVemyk6s3JcRP
         xCYegBH0u/q90pudZ5YinhpjvVpVObRfO34mM7tWmdavmGn2qo3BEoE0ctU60lexbY+u
         bmpw==
X-Gm-Message-State: AC+VfDx+FpzoABKgZaspz+e1axCPR1PBP5kUs5u+vuEOezUX2E6EiX1U
        tXLHED816fPZJVuMWoeGZQ8=
X-Google-Smtp-Source: ACHHUZ7qgZXuInT52CBe2fdIODHvN3TsFZFGNC53yWfuzxRIbJsq0WD/6yJNKLgPzMeJ/5eb9LSI8A==
X-Received: by 2002:a05:600c:2191:b0:3f4:1a97:ab1d with SMTP id e17-20020a05600c219100b003f41a97ab1dmr4138816wme.1.1683534262558;
        Mon, 08 May 2023 01:24:22 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c45cd00b003f1738d0d13sm19383989wmo.1.2023.05.08.01.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 01:24:21 -0700 (PDT)
Message-ID: <f5cf30b2-c29c-03ac-e7fc-4c7da2cd0c5b@gmail.com>
Date:   Mon, 8 May 2023 10:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] phy: mediatek: fix returning garbage
Content-Language: en-US, ca-ES, es-ES
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        kishon@kernel.org, angelogioacchino.delregno@collabora.com,
        nathan@kernel.org, ndesaulniers@google.com, granquet@baylibre.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230414122253.3171524-1-trix@redhat.com>
 <ZFTMPWp8LhwA9uHz@matsya> <db9c3190-28d8-199f-f4f0-a12524d0451e@gmail.com>
 <ZFipVfhLVyye/eud@matsya>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ZFipVfhLVyye/eud@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/2023 09:48, Vinod Koul wrote:
> On 05-05-23, 17:37, Matthias Brugger wrote:
>>
>>
>> On 05/05/2023 11:28, Vinod Koul wrote:
>>> On 14-04-23, 08:22, Tom Rix wrote:
>>>> clang reports
>>>> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
>>>>     'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>>>>           if (ret)
>>>>               ^~~
>>>> ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.
>>>
>>> I have applied "phy: mediatek: hdmi: mt8195: fix uninitialized variable
>>> usage in pll_calc"
>>
>> Thanks Vinod, that was on my list for today as well. I was a bit puzzled
>> because you took the patch that added it, but I wasn't sure if you would
>> take the fix. How do you want to handle things like this in the future?
> 
> Fixes should be sent as Fixes patch
> 

I'm not sure what do you mean. Patch subject includes the word fix and the patch 
has a fixes tag. What was missing here?

Does this mean you will take fixes for this driver in the future or do you want 
me to take care of them?

Regards,
Matthias
