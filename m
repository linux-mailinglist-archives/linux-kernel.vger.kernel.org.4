Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AC76321B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKUMRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKUMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:17:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360E167E8;
        Mon, 21 Nov 2022 04:17:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so19579534wrb.4;
        Mon, 21 Nov 2022 04:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dau72eMFobVjeX858MKpIQt+w+Vj109653tn0bOEToE=;
        b=LZ9ntN+4DTSrbOgtfOrnpUBwBrbpV7qmRH/ljp2H/dZdMQuirrWvAdZk2R/bGkpO9p
         qC11WmNqXSMvmjgG7ofh8dwut6KCDI2MVrANuQg1egUOPzNFHakWsZ6fR88Nryg/7gzi
         DXSZUc61z46nnPxXGxqoL3rIsG2jkL997JUWk6wyWodMIBjdZ1K/nd6gaYEYNtVygHz3
         dIEaeNdSjezKh5Kzt2l0j+tTscWRhu+dKN/rVmpRtleKI5mx/w5GqWUIi+y2SkAGSw03
         zluYjzYDXohiwomidyNMjAOiXEFbr1LAFEzJxDoYzW1wT7fYyBDWQlzBCHnq5eRekgvR
         Of4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dau72eMFobVjeX858MKpIQt+w+Vj109653tn0bOEToE=;
        b=mQsqnF+5AhKDFCH6ZcAXbXQxq9q58TE5HtkFWq6wiMdzxmD25fmoc4+I22RkKR4DWe
         f3/pQ8zeEyCxzmLvpSESO2JuPOdm8R3RhsgqA0FK6EhSVssHe2oXKpYx7/HF7pWlzxVf
         ADtd4jt53AQYj344nMMwbbcp3t5/oz4bF+ybMGeWfaSJGBACsV+tzRmZufitoK8xVD5m
         yqKjPnFiyacRmEKgjMUDVMqE2//POr4ovVY47udi0QTsRXRqwBgAuKHT7rPwSaE/4Q1D
         EIppgC0RG9T5CxtcGEkfXLlp74qsJXUcV1zN383TA6NDgjRUxIo2tLBns9yF//PJWeIA
         6QNA==
X-Gm-Message-State: ANoB5pkeksuy1IUtv6C7F0x0jhLy/Q5r24kI7Uovs1DIvlE672AUuhGp
        PmbGF/Gdlk0GiiD1IrFBdzg=
X-Google-Smtp-Source: AA0mqf5fGkC5GjLrWjBo6zV31RUokHzCtGY/Ltn3f1prZofGpBm/8pSWUcDd/u4xQilm5VMtM63W1A==
X-Received: by 2002:adf:ff89:0:b0:22e:38b:95ff with SMTP id j9-20020adfff89000000b0022e038b95ffmr1287478wrr.202.1669033057477;
        Mon, 21 Nov 2022 04:17:37 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003cf894dbc4fsm13444667wme.25.2022.11.21.04.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:17:24 -0800 (PST)
Message-ID: <065b5ff5-fbae-2ec5-a06a-8aad015612f9@gmail.com>
Date:   Mon, 21 Nov 2022 13:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 0/4] Add dp-intf and dp nodes
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221110063716.25677-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 07:37, Bo-Chen Chen wrote:
> This series add MediaTek dp-intf nodes and dp nodes.
> This series is based on linux-next-20220915.
> 
> Changes for v4:
> 1. Rebase to linux-next 20221109.
> 
> Changes for v3:
> 1. Update commit message for "arm64: dts: mediatek: cherry: Add edptx and dptx support".
> 
> Changes for v2:
> 1. Update commit messages.
> 2. reorder the place of "status = "disabled";"
> 3. reorder the place of dp-intf.
> 
> Bo-Chen Chen (4):
>    arm64: dts: mt8195: Add dp-intf nodes
>    arm64: dts: mt8195: Add edptx and dptx nodes
>    arm64: dts: mediatek: cherry: Add dp-intf ports
>    arm64: dts: mediatek: cherry: Add edptx and dptx support
> 

Whole series applied, thanks!

>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 86 +++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 48 +++++++++++
>   2 files changed, 134 insertions(+)
> 
