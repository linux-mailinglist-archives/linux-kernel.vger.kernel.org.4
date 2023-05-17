Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A92706ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEQQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEQQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:53:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F03E10F5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:53:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41dceb9caso1980405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684342379; x=1686934379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dOJVIGMX/56gfv9vT65ZzraMpImyEbSMTyJtUPlCLo=;
        b=2BVmhZvz4oCFmI5/DV5GvMVrMDeSuoxTJrL4iNd3Jxd8RMgHHaG2zBP3QGXd4XOrKH
         hnCaxYsoji/6w9ykNXsu7Fi6zdPHszF1Q4gQwaYtYi+alCroMmK3dTCvf76H24m0hBNH
         uPYMxYIcvwsv9oLoqcnRqkuJqG160ovtznAlXlPoISd+6G5FUe39gNEpXnHhlVhKSgAr
         j7cJBOpVpVr6bIWkD/AWH7j1IIm/DQGL+hgxy/nADAKFAC150PQwk4fwE0f01qyGHD+P
         Cp76uAflMqRUWC6k9pvk/7rn+QHXpv19LDYyCPOIgLeWLoQ8+IfQ09AyPHmlKEGKrCXG
         SwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342379; x=1686934379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dOJVIGMX/56gfv9vT65ZzraMpImyEbSMTyJtUPlCLo=;
        b=btHrxSnYqVU6TaoqKnK4koFch/nGPnod6ER1onyBVeBRb5rvgxd9i0xUjkgoNNFeTX
         xjagZFB4Xy1uurNWnKluGZw4i7tEFiA8LS+TtfWflPVQUKlQK1NDNvidE0TqFP39WWHW
         dbkOjDZB/KmB9K5bkpGSjwMsJJTPo3atUcnZ56SIfgjDtXYM7czs2XMl0sX3MLpjX5SN
         u3iMsedFjC+mC64PgiinXLTsbT10/Z58KTdwJwsC9YA97mTdou5FGumWmYgutD6se2i9
         JTq4zQAYeRtsrQGFW0k7R9gVkiK61Opb7zAe97t02FvO5kArKuNQXZYS4la6dCsa5BlC
         NE+w==
X-Gm-Message-State: AC+VfDw93cNaU2qB30ANWg2fSTmNK+WNMSvJtwxG+nEmOz2MXW9MThRx
        qhBxgsYddCI+FtIR/pZaPZk2HQ==
X-Google-Smtp-Source: ACHHUZ5oWXHIEKdFAwIxANhWR9lMlqKmEiYA0FORJIMDBWG4zKRbrOzb0ppHIUnnzPT2YmO1WjO6DQ==
X-Received: by 2002:a7b:cd01:0:b0:3f4:fe7f:3d18 with SMTP id f1-20020a7bcd01000000b003f4fe7f3d18mr2318552wmj.2.1684342378813;
        Wed, 17 May 2023 09:52:58 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id u15-20020adfed4f000000b00307c46f4f08sm3267555wro.79.2023.05.17.09.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:52:58 -0700 (PDT)
Message-ID: <94f8af4a-2555-052d-d04a-a0e54e0e2d13@baylibre.com>
Date:   Wed, 17 May 2023 18:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] clk/mediatek: Adjustments for MSDC rate accuracy
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
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230516135205.372951-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:52, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>    - Extended the changes in this series to MT8365 clocks
> 
> This series stops unconditionally forcing CLK_SET_RATE_PARENT on
> MediaTek muxes, as that should be set in the clock driver for each
> clock requiring it, and removes CLK_SET_PARENT from all MSDC core
> clocks to allow mtk-sd to select the right clock parent when doing
> mclk setting, improving the rate accuracy and avoiding both under
> and overclocks of the eMMC/SD/SDIO card, both improving performance
> and stability of the attached storage.
> 
> This series was successfully tested on MT8173, MT8192, MT8195.
> 
> AngeloGioacchino Del Regno (2):
>    clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT flag
>    clk: mediatek: Remove CLK_SET_PARENT from all MSDC core clocks
> 
>   drivers/clk/mediatek/clk-mt6765.c          | 20 +++++-----
>   drivers/clk/mediatek/clk-mt6779.c          | 24 +++++------
>   drivers/clk/mediatek/clk-mt7981-topckgen.c | 12 +++---
>   drivers/clk/mediatek/clk-mt7986-topckgen.c | 12 +++---
>   drivers/clk/mediatek/clk-mt8173-topckgen.c | 24 +++++------
>   drivers/clk/mediatek/clk-mt8183.c          | 22 ++++++-----
>   drivers/clk/mediatek/clk-mt8186-topckgen.c | 24 +++++------
>   drivers/clk/mediatek/clk-mt8188-topckgen.c | 40 +++++++++++--------
>   drivers/clk/mediatek/clk-mt8192.c          | 23 +++++------
>   drivers/clk/mediatek/clk-mt8195-topckgen.c | 46 +++++++++++++---------
>   drivers/clk/mediatek/clk-mt8365.c          | 38 +++++++++---------
>   drivers/clk/mediatek/clk-mux.c             |  2 +-
>   12 files changed, 155 insertions(+), 132 deletions(-)
> 

I will try to test it next week on MT8365 SoC.

-- 
Regards,
Alexandre

