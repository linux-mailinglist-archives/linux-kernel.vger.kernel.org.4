Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17069D944
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjBUD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjBUD0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:26:06 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F423D9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:26:05 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id e16so177520uav.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULibvphzro1D/98vWvfLMdiA81XUXKtqF+j4eYxfmic=;
        b=RrKZTF1jnLdV3a0kGJHaExjDHfO20XWEcPPkfAhXPb2Vk02cA7AfXQDSNzMx7JMS6B
         Uo5GVpZuNhRm/1SzVdI3tCMfZpZBvFKsNt3d3OBy+AhdIoDfcMPu16K4z8LfvvhmrveN
         wXw0WewUMcbD7nsvM9PKjAAJvwI6UplrjSS4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULibvphzro1D/98vWvfLMdiA81XUXKtqF+j4eYxfmic=;
        b=uu1K298eUWP8qXscWcrsaQTxes67h54ztQqcTYEoV7qq6kBxTVo3jWkoYdbWbg9JFG
         vNHfqKnxbvr2yR1cCCqZ7tFGsX2bOC4/VPP2gOBOY08gAQmfwXLi8abbGlNrZ6qHQQJX
         lgct1Q1m3g5NkideTUDAKCHBQNk3Ky4HkqBcwWGfVqOJ7VnTznTjXmV7u0czkXvYrmhB
         Q+fhtng4h+c8IH6S0q4rdThKbhEV0h5+kbe5nkMCiI5XvcAoN9q+7v3kBZbk1hyCtzy1
         NXdupakfVyTuMtmjlCFCPGOKV9wQAWOtayijJYfpKVlkWiW4fYU8uI4dX890GYm/U0yx
         InKg==
X-Gm-Message-State: AO0yUKUboThzH8thnJnJYJfkM7a2CnrutvkVsu1xsjxIsWnsD4pFlXwy
        55q5Am7BCpUMlaKE2y6R4W8eTvkeAL8SoVn/QEVxqg==
X-Google-Smtp-Source: AK7set8xWP4VDK1zpzVf35dhRjpPCPCvPMYTxP1UoLD3FNmbqHdbOhuvm16GTBZ9oS4Ysc0oQtkHPSJYnmTdH4nHLSs=
X-Received: by 2002:ab0:53d5:0:b0:68a:5c52:7f2b with SMTP id
 l21-20020ab053d5000000b0068a5c527f2bmr531329uaa.1.1676949964782; Mon, 20 Feb
 2023 19:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:25:53 +0800
Message-ID: <CAGXv+5GJqu_xE4EOTFmeNJxLPM7zL-z3Cg22t9mFd=-Yp8B9mw@mail.gmail.com>
Subject: Re: [PATCH v3 09/55] clk: mediatek: mt2712-apmixedsys: Add .remove()
 callback for module build
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a .remove() callback to the apmixedsys driver to allow full module
> build; while at it, also change the usage of builtin_platform_driver()
> to module_platform_driver() to actually make use of the new callback.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
