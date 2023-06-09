Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90066729F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbjFIPzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbjFIPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:55:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591873588;
        Fri,  9 Jun 2023 08:55:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso15244685e9.0;
        Fri, 09 Jun 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686326137; x=1688918137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfZGvzdRD/l5yLMgvsdVKahWGO6FHg0piniB+Xd+cGM=;
        b=GydYsxqTMsV1AnT6xtJpF5qrUpoKk7/eRh724iVGlZmGVJWopxDM2dWOdj4wc/WtJ8
         304FpEqsNHr8J65elj3fq1UQltQ0/DEKxaHgqEJcfaeCJnG78/XhwbbyCmUhB2Kw8OYH
         TPtYI/xfrUVI+4V335YfNlqjt7cZWYAaIDs+HwikVKR81Y1mXfMHKJXl1kCJ8Kj7bIwj
         kFuRp4WHQ2EY4+if+pP4Sl8Oep1VN+FRtEBa2THN+7nNkbBJCVjTOHjglvxsN1CzPwK3
         qoedjZASMwYW5n8tEQgHgoEDJGxIAhzesofwJgYriC4d5txS9BU5OqC2Pyfi+XdZ8guF
         kHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326137; x=1688918137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfZGvzdRD/l5yLMgvsdVKahWGO6FHg0piniB+Xd+cGM=;
        b=l9UGX+oFYyczISV30d0KutXls+SyjqjazC+zvHRufwiq/3nMSO8ea8ZzCHGfHZH5Jl
         72XyZ2NrYN6c8YzaTK1PdizK/Vs3VJtHMRqZWWFp1wEJQie/oW54SUCNV3is6mV7eYXt
         Jek8t2q+jXKRnjdLZwhazJPfJMxIjZk3IJkoGSCpPLueHtDqyObrBO3iIORNjC/GAebo
         Wyve8s7UwFJdNK9eKyJSfs7yefT2UnD7WG5n11P75IW8g21XWyfoB/R/hCWr3Gy9/O57
         /dBJ3EQ1m2P04Rw2bpwwzOg7vtSnzqDK6u0GVCu5jeK3/CEw6Nc/UTcUfQYRAyfwnVyD
         55hA==
X-Gm-Message-State: AC+VfDxEJ40nZBOyM0ZVCFFiMj8QrIPWwo0tBpcmWuKaWUu30FMVrdkH
        8KFdrGBn5vTJd5nRa0hec4U=
X-Google-Smtp-Source: ACHHUZ53aa0PijCs3pVOvPjlOEclE5q6nHIdPiJjc7Yj8BpWt+E3VJUnUT0pprag+USViTAYQiiE9g==
X-Received: by 2002:a05:600c:880f:b0:3f7:148b:c310 with SMTP id gy15-20020a05600c880f00b003f7148bc310mr3999831wmb.13.1686326136568;
        Fri, 09 Jun 2023 08:55:36 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p17-20020a1c7411000000b003f61177faffsm3224902wmc.0.2023.06.09.08.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:55:35 -0700 (PDT)
Message-ID: <73937e6b-8b2a-8bd5-11d3-be56d02d23a0@gmail.com>
Date:   Fri, 9 Jun 2023 17:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/4] arm64: dts: mediatek: mt8186: More DVFS nodes
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230609072906.2784594-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230609072906.2784594-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 09:29, Chen-Yu Tsai wrote:
> Hi,
> 
> This adds more of the DVFS stuff at the SoC .dtsi level. This includes
> the CCI and GPU.
> 
> Changes since v1:
> - Dropped opp-level property from CPU and CCI OPP tables
> - Used "opp-supported-hw = <0xff>" for GPU base OPPs to denote "all
>    variations"
> 
> Please have a look and merge for this cycle if possible.
> 
> On another note, I'm still cleaning up the MT6366 regulator's binding.
> We shouldn't upstream the boards until the PMIC is ready.
> 
> ChenYu
> 
> Chen-Yu Tsai (4):
>    arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table
>    arm64: dts: mediatek: mt8186: Wire up CPU frequency/voltage scaling
>    arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM cells
>    arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling
> 
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 490 ++++++++++++++++++++++-
>   1 file changed, 489 insertions(+), 1 deletion(-)
> 

Series applied,
thanks!

