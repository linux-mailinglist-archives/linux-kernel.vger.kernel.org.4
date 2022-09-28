Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9395ED5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiI1HEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiI1HET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:04:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E3895D5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:04:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so13301635ljr.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mwAW3kmbmDfR1+nb7qnTndxnvmh/2aETOKBevREMWrQ=;
        b=CNGqXtAcaIeBmAxYAJ0byEsnryDhT1j8LXtNEZC89v3C3ZmEx11TlPNXbVbeJLQ0Lb
         xIhneEaU10oxpfk88fXbYcTwQe3hGzB2EYECN/HuP8YBaU1jQWFORx5CmmNBDFkjqEV7
         5XspajX2oseOSGwGSJ5ZnZYOYJ7ABUV+EY7pyV0Chs9zaQVW5Vgb6ICcnGz0LDvqdMKQ
         5TL57IW5VFaGQOXb9yYZ5Ii5MMxWvCQU8BO6TymtTtCOeoZbC3PtqQ/iRQSRcg4ROyc5
         nGphflzOkRin+guhTtojX9Qw2rh42O2/AhWywFWGZi4MY1si46O+oHF25YBAnfHshgJn
         5muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mwAW3kmbmDfR1+nb7qnTndxnvmh/2aETOKBevREMWrQ=;
        b=NGXuWBZBlmB34byAGDWbocvt2oSTj+Yhtpy8jdg/fhU9JG9xHXQGqOmzP3BVJJ/k/U
         HeabD1vHuUbVr3Kv8jfVutoDHeJP1g60sQ2b0uqrBLMcIcWm/MuNrj+HJPKvO1G1rPHR
         q8Yu8vVMnoOlmF5pI4fZBDZ9NwPD0k4DmK8Ra0TofuODlmMlcESxKZ1W2tmRG6VS0FJu
         ZDXGGvXvBmHdOdVKHUUwlmxt8OyNF2krWSwX2IypNs5W90D2hURxOz2LwWYy881U3xmC
         KFMg15Rh6Wp4GLm3w/BLESwz0GxzZ40OVAOJlHUr7mOHKMl9OYHuHIMc4B/QvbJwQ7JA
         CLZA==
X-Gm-Message-State: ACrzQf1FzLCq+4HUPoPuixOaDeB5Dy8P6B0r8nAtcZxn7312gY0gN/PR
        LYdQQglt4TfMTqPZ3a7Xkts9NQ==
X-Google-Smtp-Source: AMsMyM7Iz+rfJ70a9QQjtzGMPQ27BPaw9Y+gbWPCPlqtyf14Xpi5T4/g+Oohx5FDgMEJ/lkDqJM73w==
X-Received: by 2002:a2e:a7cf:0:b0:26c:541a:e04c with SMTP id x15-20020a2ea7cf000000b0026c541ae04cmr10820108ljp.425.1664348657257;
        Wed, 28 Sep 2022 00:04:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be12-20020a056512250c00b00492ea54beeasm385297lfb.306.2022.09.28.00.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:04:16 -0700 (PDT)
Message-ID: <172e10ee-22fd-ccec-1a5a-7bd0a29dbfc4@linaro.org>
Date:   Wed, 28 Sep 2022 09:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220926105047.19419-1-allen-kh.cheng@mediatek.com>
 <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
 <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
 <05ed341b-2db3-620f-7a70-dcebfaa66f1a@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <05ed341b-2db3-620f-7a70-dcebfaa66f1a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 12:17, AngeloGioacchino Del Regno wrote:
>>>
>>
>> Sorry, my bad. I alsways run `make dtbs_check` to confirm dtb with
>> bindings. I just think we didn't limit node names in mtk-vodec
>> bindings. I will pay attention next time.
>>
>>
>> Since currently the vcodec lat and core nodes are absent from the mtk
>> dts, do you think the child node name should be changed to something
>> more general (ex: video-codec) in mediatek,vcodec-subdev-decoder
>> bindings?
> 
> The video codec is mt8192-vcodec-dec, while the other nodes are describing
> the VPU instances (and/or vpu cores)... I'm not sure.
> 
> Krzysztof, please, can you give your opinion on that?
> 

What's the difference between them? I understand parent device is entire
block of consisting of multiple processing units? If so, video-codec
actually could fit in both places. But feel free to call it a bit
different (video-codec-core, video-codec-lat, processing-unit, even
something less generic). Sometimes it's tricky to find nice name, so I
wouldn't worry too much in that case. Just not "mt8192-vcodec" :)

Best regards,
Krzysztof

