Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB96682BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAaLmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjAaLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:42:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15201244A8;
        Tue, 31 Jan 2023 03:42:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t7so5566638wrp.5;
        Tue, 31 Jan 2023 03:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbuaZt7lhM/9Ln5zNse1ilA+2En9FQ3goK6JMsF3RXU=;
        b=iBJRXcXOfNlS/bNMALXBSUsoDCg0SbyFWLXapD05y0OOSL874mHMqfAuh5vd3VO45r
         79VWiPhfRAG9Eofp5QQRhQ/UZycsbplEOhl4uVpMf0wt4dJyeACIBclsRv+d37nKitcE
         uc4pAYt2yyiNb2quuXfViTLCPU2RaLPvSjmfL0ho+O90QmI3CA/2zdHYXYWRvsoZqjuO
         JAr09yk0QaYpF1xzZ1D8A4wnJBKVaCVdlrhzoAf3BtIlIXpV5GxIAxxMqYEdIHlBTb0h
         I07gxQ3kMf0GeBlKEYRX+h/xc3KVTsSiyczyehePJnrWBhn4oEJpRHM0OZCHpPsxPo7n
         +4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbuaZt7lhM/9Ln5zNse1ilA+2En9FQ3goK6JMsF3RXU=;
        b=dtqlxjwHHZh4wLtBQ/3O4x2st9Qqbsc0Mvz3V+MKe6tcM12PtGqYsd/Btw4xXEEVx1
         Wkaq590SdvSJpENVayEC+TYIK05NnJa6+Bn6Q4+In8fSMbY8uD6aTYeNjqCg5k8qlLeH
         PWI6y2rrXZ5AfPx4Du62qPs/f1r+oBbjT0CGi3jHHroXUwIWfr+z2pfgwHJ5PY+hVijN
         ECx1UNgGjYbix+VJfkjJvEZLWBQ/aXRTdHuaMFFC5RAaJ6xwDRb9ONAufrjpjKINcvsE
         VnF5a/rIBAYAc5aqxQbKpMCpF+bhd85dY0UnO/bKGosOnXqdgBV9mMaokEcME3xAyMwG
         nkEQ==
X-Gm-Message-State: AO0yUKWK50xFtGTzXNAdgHXgjjjMK9CkXRbYTT6v/VkGhx9qkTC1ieii
        W1tPJ4SpnT1KZTf2ZhkL0aE=
X-Google-Smtp-Source: AK7set9v+XGRdhbhRoauvb60itN4l43MujdWvSVRCtJ9jAJS7r5kiHvWKLHYDuoX5hwD0pmfNEG/hQ==
X-Received: by 2002:a5d:5e93:0:b0:2bf:cba5:6add with SMTP id ck19-20020a5d5e93000000b002bfcba56addmr2898145wrb.58.1675165358589;
        Tue, 31 Jan 2023 03:42:38 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4d0e000000b002bde537721dsm14408352wrt.20.2023.01.31.03.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:42:38 -0800 (PST)
Message-ID: <2a091926-653c-6deb-12b9-85ae5ecef8cc@gmail.com>
Date:   Tue, 31 Jan 2023 12:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/6] Fix MT8186/92/95 topology and idle state names
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        seiya.wang@mediatek.com, tinghan.shen@mediatek.com,
        allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230126103526.417039-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2023 11:35, AngeloGioacchino Del Regno wrote:
> MT8186, MT8192 and MT8195 use ARM DynamIQ, which combines big and
> LITTLE cores in one single cluster! A two cluster topology is simply
> wrong in this case.
> 
> While at it, after some research, I've also noticed that the names
> assigned to the idle states are misleading, so I went on changing
> them to reflect the actual function.
> 
> The names change commits, unlike the CPU map ones, didn't get any
> Fixes tag, as naming changes aren't fixing anything that would be
> meaningful for functionality (it's cosmetic, nothing else).
> 
> AngeloGioacchino Del Regno (6):
>    arm64: dts: mt8195: Fix CPU map for single-cluster SoC
>    arm64: dts: mt8192: Fix CPU map for single-cluster SoC
>    arm64: dts: mt8186: Fix CPU map for single-cluster SoC
>    arm64: dts: mt8195: Change idle states names to reflect actual
>      function
>    arm64: dts: mt8186: Change idle states names to reflect actual
>      function
>    arm64: dts: mt8192: Change idle states names to reflect actual
>      function
> 

Whole series applied, thanks!
Matthias

>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 30 ++++++++++----------
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 35 +++++++++++-------------
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 34 +++++++++++------------
>   3 files changed, 46 insertions(+), 53 deletions(-)
> 
