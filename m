Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B512270DB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjEWK6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjEWK6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:58:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DA8FD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:58:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f608074b50so15153825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684839515; x=1687431515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6w3sPrSomaK6vYQVMgu/kzGmiGHSmd5gsIIpynPqCg=;
        b=ZqWAbyEakVKPpFD/J/z3kYo7lHMPrxJjYYN7fnLelta0e/YR9Xmz3GMlu5Ym+Zr2pK
         ouFcbNJFQknKe98Zw+zI8kbqTwTPY6eLMWhFxiCcav6cBhxAlYya8e7aJifoqv0YAQzU
         fqpJjF/TVcp938OLCWo5wRRGjYd1aLzQskm3YZ/H1fsua80DSr8LOwtPOSAFSfUcYw3z
         LSIYmux9uryyokaXuXLYEvDl5CAxAu4mGn9Kb6kFhXm+Zq+FUdatjGkmMo43fAjnaKD3
         Sj39zh1BKS0x+qo2iOwFlMoYkW3UXJZ1dgius2stQHDAsri6U35E6rETfSLp0N6DFzc9
         sYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839515; x=1687431515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6w3sPrSomaK6vYQVMgu/kzGmiGHSmd5gsIIpynPqCg=;
        b=iTroyqSM2ucBRYHUT/vnNJugxnz7oYGlHQ2ZkXHlTi0gdsv1fi1AcsPkUyr4VmS5EL
         y25p/yJfRua9yX8HQAAQMpIhW7GnXJuvHoYGnNebj23tkKI3PUjU8CIdqRty2k006Mb5
         G9tBIvL3tK8oGEYkbBxGo3kQMV2ld9x6PIWp5XW774Ofqyit8BMApPzsSOXQ6WhZAiB5
         lnLguKn9cQyM6JyrsPE8UVf3Wk12PXRhgb6vXvlYznG/bHL+zAFSueu0dhwQE9ro7mmL
         vNNow1LLP3nZtLWaDxof617YPTVBKuxh5fZUS1sLDAY9PLiYvI8R4AIhOsGkD3Vm3INf
         nxdg==
X-Gm-Message-State: AC+VfDxIGvli7UQx6SrR8Lc3Fnvlql3TeApeJHBss2Q9vjaPCiR4B05H
        YtuNHWbzXbxDqL1mRSxip7xLnQ==
X-Google-Smtp-Source: ACHHUZ7S/7Vokqqrj6HwXGeGDqC/4hlfaVpowDnOSEx8UktgQIfdViz/chTBaLrC2s80+i7yUZqCxA==
X-Received: by 2002:a1c:f402:0:b0:3f4:23a4:7a93 with SMTP id z2-20020a1cf402000000b003f423a47a93mr10738378wma.25.1684839514687;
        Tue, 23 May 2023 03:58:34 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bcd95000000b003f4e8530696sm11286717wmj.46.2023.05.23.03.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:58:34 -0700 (PDT)
Message-ID: <af25cbbe-bfa9-3d29-360e-e4f932d286c8@baylibre.com>
Date:   Tue, 23 May 2023 12:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] clk: mediatek: Remove CLK_SET_PARENT from all MSDC
 core clocks
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, mandyjh.liu@mediatek.com,
        miles.chen@mediatek.com, zhaojh329@gmail.com,
        daniel@makrotopia.org, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, Garmin.Chang@mediatek.com,
        msp@baylibre.com, yangyingliang@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230516135205.372951-1-angelogioacchino.delregno@collabora.com>
 <20230516135205.372951-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230516135205.372951-3-angelogioacchino.delregno@collabora.com>
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

On 16/05/2023 15:52, AngeloGioacchino Del Regno wrote:
> Various MSDC core clocks, used for multiple MSDC controller instances,
> share the same parent(s): in order to add parents selection in the
> mtk-sd driver to achieve an accurate clock rate for all modes, remove
> the CLK_SET_RATE_PARENT flag from all MSDC clocks for all SoCs: this
> will make sure that a clk_set_rate() call performed for a clock on
> a secondary controller will not change the rate of a common parent,
> which would result in an overclock or underclock of one of the
> controllers.
> 
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger<matthias.bgg@gmail.com>
> Reviewed-by: Markus Schneider-Pargmann<msp@baylibre.com>

Tested on mt8365-evk board.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
