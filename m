Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D985E749BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGFMfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:35:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE51990
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:35:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so6593155e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688646905; x=1691238905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lGRta1DFJWgP2Ka3XUK1qfLkVKYTy4OhAMOsxkgoyQ=;
        b=t9T2EPPp9hbOjIHqqad9elRw73dzrHEK2qBF+VJuC8f9Y3/9oMFx31mNw37w8ibwcy
         52cdAg0Y7/Ozjn2LCoU9JJLD0kixWVjLFoeQwcSOWnSOGDJyiaHna6kf1NGSlP6EIHNB
         AWQQ573f791IbjtZMj4Pfai38KjablEBnkRW3fTVKJ9tmjDz+St1xrbdQjmcLwdKig/H
         wOIWU+6EHF/+4IvIFfRhyvcFdIwTfhJ5gK2gYQ4JfTH8N8yWiflC09nqE4vx2xuNmfLA
         W3KxngHtkuQWfYwyJN78GH7JZ3H3mggVoHkYCrGMzYmf0lEXaPqioQaGUnzRQqm6kN+g
         3I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688646905; x=1691238905;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lGRta1DFJWgP2Ka3XUK1qfLkVKYTy4OhAMOsxkgoyQ=;
        b=h5qqs8r3QVlehmoeY/z/eGV6GQXVa2QGiWZoxfS0CXbLblAncbTr8TjfHw/6vMnxlv
         +EsFYjIq1wEmdOyhKIISZ5kBIB3jygC3J67w1gdrlZfxg23ofQyvQU/8VmoSVOSnKq8w
         A/gQG09KQQgUFLxaRbT+/x7NGhkTbifXBPkpRRUdsxO269417SnJZ3JWKavIm5iGqe1m
         dEJlhxz6RboEULP8vKjcXPyaZ+xLM5/82nyDg0uNhcYKV48YhugTLj4Q6UYAdsGvqkoB
         +WRYxOB8nWcOYI255Kk4U3VkP9au/ylYChqbiKKZRuyJJsvBCPPEVee30R5pvOEHBRG6
         DV0g==
X-Gm-Message-State: ABy/qLY9/78b2YdHvZqYNLKO8cPoL8FC31HQcwY2HSbdo/WNY9x2aWgt
        VqgVFH3723sFwxPQ4O1KJo5IGQ==
X-Google-Smtp-Source: APBJJlFztCovuW8wVvfjzKQVaVRs6Fs31fNA/tQYgjyyw5T1md8AvL7PKf82FqXbSOSfVivrPPxFsQ==
X-Received: by 2002:a5d:618d:0:b0:30f:c7e4:d207 with SMTP id j13-20020a5d618d000000b0030fc7e4d207mr1293596wru.61.1688646904933;
        Thu, 06 Jul 2023 05:35:04 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id j14-20020a056000124e00b0031274a184d5sm1764357wrx.109.2023.07.06.05.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:35:04 -0700 (PDT)
Message-ID: <67e02d84-3b51-9973-225a-cf11fcd1aaf2@baylibre.com>
Date:   Thu, 6 Jul 2023 14:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix PM suspend/resume with
 venc clocks
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, yong.wu@mediatek.com,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230706095841.109315-1-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706095841.109315-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2023 11:58, AngeloGioacchino Del Regno wrote:
> Before suspending the LARBs we're making sure that any operation is
> done: this never happens because we are unexpectedly unclocking the
> LARB20 before executing the suspend handler for the MediaTek Smart
> Multimedia Interface (SMI) and the cause of this is incorrect clocks
> on this LARB.
> 
> Fix this issue by changing the Local Arbiter 20 (used by the video
> encoder secondary core) apb clock to CLK_VENC_CORE1_VENC;
> furthermore, in order to make sure that both the PM resume and video
> encoder operation is stable, add the CLK_VENC(_CORE1)_LARB clock to
> the VENC (main core) and VENC_CORE1 power domains, as this IP cannot
> communicate with the rest of the system (the AP) without local
> arbiter clocks being operational.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
