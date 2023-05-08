Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C266FA320
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjEHJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:19:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213BCF5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:19:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f41dceb93bso10840935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683537573; x=1686129573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWWILWKzQK6TMLDhFStYmh9cgs1Ee4AfC8VZ2A5psHc=;
        b=zepka+QR+g/2xC9xN6lho0mYqW/9c/L93qnP3uJb2MyRmy9d+Cix6FiXrtP7oMPort
         jZM47KGJjHKNycjsX95yz0C6HWzXC1YswWDe90EjWVIR7MrXaCf0acLM2EN+P8SNKwWn
         u10IVWwREvgDIHQ8n2HELQiim3Ao/auzrxoWzJVmVBrpIwCE17MpSksetf+8/vpZm+z3
         O9MgFINHFH96Wg87vpjYCLChliuB/obYki61cb5Df1zeqTbRx5CYkBo8avtu0J4Uwl1/
         pFIrQhxPmpVJLtU0sfJrlSzNy/FlBJ5H17WS2D3pWdWN4HO6AUhl2dM+QLKRXziskJcG
         sRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537573; x=1686129573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWWILWKzQK6TMLDhFStYmh9cgs1Ee4AfC8VZ2A5psHc=;
        b=YoK2eGEBJ/1RUd6w2VGYO3pwJ+ekmTyOi+C2EANlzqOgJNDeIEF8Kng/sqVwn+cuXN
         swTgNMrUaIcoOSzWT2mgc/Kje0QLCLOkxnm9lkAl/pVYFzaFzsgB3A4Xls64jcYxcZlN
         nCXeBV851zgfV5II40Tjy3Ls9lZpLihHFvHXYA6SJv2fCD0dAOtR9dh8vihYGWasEdCl
         1xZm/YEJQMnLaXx2zkjsDqW9Z4jOAElGneCBMv5Dh/gj6NOybf2YI3VJegbknwfDRn04
         bBSrIpIjAbOiGb8zib4wgYb60vkcbBUUgbmNYremg7q9p+U0E0QzkpdQ2+rvhBKVBEO2
         if7Q==
X-Gm-Message-State: AC+VfDyJLcJCRKOU9kuT9QiUiZnu5etU0PjMYpU4a4bpsLhd9rdmFr0C
        ZGFN6WaN13vrmcOmstdTa9VF3A==
X-Google-Smtp-Source: ACHHUZ6FNnM/7T0TwX1UpEkyd2q2m5u8rebE8CJQsnenV2MO71Oov6aqiwILhEKTK5XhBe09hMae+g==
X-Received: by 2002:a1c:4c04:0:b0:3f4:2148:e8c5 with SMTP id z4-20020a1c4c04000000b003f42148e8c5mr3393758wmf.1.1683537573557;
        Mon, 08 May 2023 02:19:33 -0700 (PDT)
Received: from blmsp ([2001:4090:a246:80f3:ef71:25ff:df82:9cc9])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b003f07ef4e3e0sm19806283wms.0.2023.05.08.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:19:33 -0700 (PDT)
Date:   Mon, 8 May 2023 11:19:31 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, chun-jie.chen@mediatek.com,
        mandyjh.liu@mediatek.com, miles.chen@mediatek.com,
        zhaojh329@gmail.com, daniel@makrotopia.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        Garmin.Chang@mediatek.com, yangyingliang@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] clk: mediatek: Remove CLK_SET_PARENT from all MSDC
 core clocks
Message-ID: <20230508091931.yznppzp2ohham5ek@blmsp>
References: <20230505093733.221922-1-angelogioacchino.delregno@collabora.com>
 <20230505093733.221922-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505093733.221922-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Fri, May 05, 2023 at 11:37:33AM +0200, AngeloGioacchino Del Regno wrote:
> Various MSDC core clocks, used for multiple MSDC controller instances,
> share the same parent(s): in order to add parents selection in the
> mtk-sd driver to achieve an accurate clock rate for all modes, remove
> the CLK_SET_RATE_PARENT flag from all MSDC clocks for all SoCs: this
> will make sure that a clk_set_rate() call performed for a clock on
> a secondary controller will not change the rate of a common parent,
> which would result in an overclock or underclock of one of the
> controllers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt6765.c          | 12 +++++------
>  drivers/clk/mediatek/clk-mt6779.c          | 18 ++++++++--------
>  drivers/clk/mediatek/clk-mt7981-topckgen.c | 12 +++++------
>  drivers/clk/mediatek/clk-mt7986-topckgen.c | 12 +++++------
>  drivers/clk/mediatek/clk-mt8173-topckgen.c | 24 +++++++++++-----------
>  drivers/clk/mediatek/clk-mt8183.c          | 16 +++++++--------
>  drivers/clk/mediatek/clk-mt8186-topckgen.c | 12 +++++------
>  drivers/clk/mediatek/clk-mt8188-topckgen.c | 16 +++++++--------
>  drivers/clk/mediatek/clk-mt8192.c          | 17 +++++++--------
>  drivers/clk/mediatek/clk-mt8195-topckgen.c | 16 +++++++--------

This is missing clk-mt8365.c as well. Otherwise looks good to me:

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best,
Markus
