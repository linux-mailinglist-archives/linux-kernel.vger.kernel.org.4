Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01D70DAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbjEWKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbjEWKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:54:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4293B121
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:54:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f607839b89so13199235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684839287; x=1687431287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpbiziC971fCgdwZTyN3rsD98IhVaUnm83YTaNKNO9U=;
        b=Im2BC/cZZs/nLmwVnIFV9v2x4XddTP6s/jNYrRuPb3xtg9NZgt5845Wuc5CCzJxvqt
         jyU6XsT6NRj8lu7AJ5J4YVMk12Iq/b/NmbZG8HNvsD0OrGAuphe1ipnH+3MBZDws5+3G
         oaMhKoymv3iCrZVy6I7p9okVdADL8bMeeBKnFDHpjsJ9WGRlv9VklsgCniJ8Ods85TJk
         v0i0DgcH37rrtDFdpazXkVThlpPpN87h/v5/HOe8gTu8hKN+f+k6drBg7tK7d/XqsUBk
         l/cYOlh4HFLLgPauWUTOWMeZyyNlx7EDF6Eg+AInEETIWnW00/ZOF9MWNopq3qI/3HY2
         wx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839287; x=1687431287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpbiziC971fCgdwZTyN3rsD98IhVaUnm83YTaNKNO9U=;
        b=aA484X8JGIGNmVnMWns3R/l2/NaoIswughjxYDQRf18soV0mmaeS/ZjCpG53pFb+ZW
         QPEf3wiBZjj3iQOY43EQDK7M0Ux4X+EA+SZ6HjRQa8It7IoVJGmweNW9DW0oOK6L+To7
         FBM/je31j2gsgItiwOqzJB5VuGH2QUVnc0cvHlMw0kqvB98QPF+k64waoMoLbJ5dB51c
         uNZkvNSIh/LPGxeXONHgjIy/KoglRMU6Fh/LYb2tQjo0crz0W2OjxAHx8hkbwRDFWAKY
         Y1N46tvUdKgmMW8kWZg4fF1XPq8sC0JMnOzQj9iOkEkcpWmUV4ArJ4lzs99hHwxLrP9X
         KnWA==
X-Gm-Message-State: AC+VfDz/NcrrSF4cIVKW6ZVMVaShvC+XLMe+enSe3AZm4TaoHFHDTWDs
        9RlGXQjmmVlpR2MsiCb0xPfH+w==
X-Google-Smtp-Source: ACHHUZ4OkQbxZxWJnqMxYZkGGL+kAn4S+slV+wc6xaUCOai6Uyf3iG710FbrcdEtIc85NncyWLqDTQ==
X-Received: by 2002:adf:f409:0:b0:2fe:e137:dbad with SMTP id g9-20020adff409000000b002fee137dbadmr8403815wro.51.1684839287494;
        Tue, 23 May 2023 03:54:47 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id w13-20020adfd4cd000000b0030497b3224bsm10633223wrk.64.2023.05.23.03.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:54:47 -0700 (PDT)
Message-ID: <b91a60a8-0f9e-9020-8b06-e78f21ef1fed@baylibre.com>
Date:   Tue, 23 May 2023 12:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] clk: mediatek: mux: Stop forcing
 CLK_SET_RATE_PARENT flag
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
 <20230516135205.372951-2-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230516135205.372951-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:52, AngeloGioacchino Del Regno wrote:
> The clk-mux driver was forcing the CLK_SET_RATE_PARENT flag even for
> the GATE_CLK_SET_UPD_FLAGS() macro, as in mtk_clk_register_mux() the
> flag was unconditionally added.
> 
> In preparation for a change on MSDC clock muxes, stop forcing this
> flag and, where necessary, update clock drivers to add it so that
> with this commit we introduce no functional changes for the currently
> supported SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger<matthias.bgg@gmail.com>
> Reviewed-by: Markus Schneider-Pargmann<msp@baylibre.com>

Tested on mt8365-evk board.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>


