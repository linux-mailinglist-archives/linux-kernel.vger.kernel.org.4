Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A87622642
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiKIJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKIJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:06:30 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA71F9F7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:06:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s24so24755034ljs.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAIqD6fevNU2ysBmc6NrEkExviwo1SE6p2O/ba4TniI=;
        b=ZZIOvoPN3XWUmTBwXPxySE0A6nDNX65bFXipg3QJFRMvU4ERoAwFmqVhEJq6+TCW4x
         ZSnt8/CBwB6yg1VK6DWuoRv1TMTGqsSS5Y1cko4EFkDaQ7u6UC0WP5hEMqF1I7A4oQ4+
         K/32jfI6ANpdVdgKcXWtzy5Ycn89sBIwCEt8BBuhDG/nsuPbRfeqfwKSMA+IX793lgV9
         MxKn6oMX2WCOaosPpmNaKf8AKCf2jXojc0P+QqI7jLhUlK4tHm72ECo3nMZDWWjqdqU0
         tYOQfjTrFrPxlKvyF2wZIluukGi1odlYPdc092iUCdHBCnPDBkTwimeVt7VBqaxTMRMk
         h1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAIqD6fevNU2ysBmc6NrEkExviwo1SE6p2O/ba4TniI=;
        b=hunpfg22gH0YGQCBO79cxuHF3Xld5vl2BbmoZE8z+tEIYB8GJYdrv51xg8VBg1dlWx
         plXXkd3M5zTt8ZtpGD0IUac7Cki0Qm6O7NsK/pFlP+Z+UrbyMT3fL7u1C5gz/nvJuj3C
         4ZXxZO6G+jRQsztdBX5Dc7RyJQZjLkXFrit5W+AxR3h6+LH/8gi3Kyeg1HLU33joj2Xg
         +Bb8o4LW3MZA/vMUF6KRoMZk328iuNCzEu6Jbkb2SDKTvkilnT1O8QvZj/4F2EqTasrU
         Iu/umfUUjONqc5L7aRorUrUXa4a7XXozMGeeQbFYr5oiteXjg6x6GYvbgHZfeID3wLLm
         N65A==
X-Gm-Message-State: ACrzQf3ALfsTxawwwMna2O3gvGG/KUfhF+4dJUb1J5o+I9g/hb39ULpd
        +IhqClpWJUiX5NG3Hzs7K0kZsw==
X-Google-Smtp-Source: AMsMyM5Et39pUkC7cb+0cPBYdelkabU9kfXbUVTnOw/VYSehiZovMGPQRxT4hgCFPq9vH1CLB/59fg==
X-Received: by 2002:a2e:7311:0:b0:277:295:982e with SMTP id o17-20020a2e7311000000b002770295982emr7226212ljc.11.1667984786509;
        Wed, 09 Nov 2022 01:06:26 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id k8-20020ac24f08000000b004b18698c558sm2132647lfr.46.2022.11.09.01.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:06:25 -0800 (PST)
Message-ID: <345da452-ebe5-1618-dc09-591c9675dfa8@linaro.org>
Date:   Wed, 9 Nov 2022 10:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/13] arm64: defconfig: Enable ATH10K_SDIO
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221108232228.1177199-1-nfraprado@collabora.com>
 <20221108232228.1177199-3-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221108232228.1177199-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 00:22, Nícolas F. R. A. Prado wrote:
> Enable support for the ATH10K wireless adapter when connected through a
> SDIO/MMC bus. It is used by mt8183-kukui based devices.
> 
> By enabling this on the defconfig we make it effortless to test the
> relevant hardware on CI systems like KernelCI.

You duplicate this reason in every commit. I propose to skip it.
Defconfig is not for KernelCI strictly. Defconfig is for developers, but
KernelCI is a system which can easily customize before deployments.
While it is an argument, I am not sure if it is worth keeping in these
13 commits...

Best regards,
Krzysztof

