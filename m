Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F380069D96C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjBUDnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBUDnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:43:19 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02D24494
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:42:31 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id j14so2974696vse.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676950947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULibvphzro1D/98vWvfLMdiA81XUXKtqF+j4eYxfmic=;
        b=CaOM5YB4iZnIvNmgu7WWEY1Axx37zudaWsr7ZFhe+E8rAJJY88Qgu42VCYNZnzG8eA
         FNv4LTyy2b3xusy/T3zF7ByXkY34hW/V7gfny6LgnSuTFVgKa2XcgcCXXdfsAggJB3d1
         LlFaSlzwjAoXIHImNkWEFyR5zHnl0rP8dIsA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676950947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULibvphzro1D/98vWvfLMdiA81XUXKtqF+j4eYxfmic=;
        b=lAWm6d/wCFdQ9NboqRADglsYihVroVfxrwwQ2rkMN8GE5HmHsAAoSqXA9C4rFzxcfU
         DlAQoYxFSRS25bbF8+AXLKjGDELPBrRsKfigYhioYp5a65GYu9ONfT9rIUtHUKcqtivp
         lna00VsqxQ1ELYy6jcZDR7RYM60bXqa/8nGVHWi9KUo9GwfFCOMgmCPwQmKpB6X8gyrx
         3+4y21OFLA9YSy80gHl5YVCswtLNsJ/VamKVyOBdY46pxfrvXcNtbum+m97xvWfel8Ub
         emXuZbQo+9b9H9HXKofjOiHXU8uC/UAoXH3W62n+rfAhxWeNnL0Yzy7buhle+6AMFaF+
         aBPw==
X-Gm-Message-State: AO0yUKVjorAq+6NiVnwceWeDI/QeOK25SHOB+Ak/xw4pJkbx3vFkODih
        7kyaNP3q9wRcw3jai3rA2yvRm0YSLjNbW44rkO697A==
X-Google-Smtp-Source: AK7set9Q3lgwHVzF0syYp34gQZFO/Wte245q8zd/k4th0GEwW7W3ggn8c4BEtNK75Xiff4H41OKOyL6E6Myn9WzQCZU=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr829329vso.44.1676950947315; Mon, 20 Feb
 2023 19:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-26-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-26-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:42:16 +0800
Message-ID: <CAGXv+5Gt+05x4ZnuW0Bda=eEbqSyG+3fArpvq6-Qi41FO4wH9w@mail.gmail.com>
Subject: Re: [PATCH v3 25/55] clk: mediatek: mt7622-apmixedsys: Add .remove()
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
