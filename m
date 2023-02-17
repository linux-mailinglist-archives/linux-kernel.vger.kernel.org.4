Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2036869A4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBQEXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBQEXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:23:02 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D70298F5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:23:00 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k4so4337856vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMJrW3rbhiV2WpI8udS44p8yxQXPp4OR7zwWUWrBLQY=;
        b=cb+NU7/hOrbeIcSAvzvU+tZuwXMCxS0dDxTkUfSdzU72XQQPcT8u+iahlUuOdzU6G+
         untKhF7BuSkJYwsQTHm2q81nQF5w/Vk7P/NK54b2hAojRwwkWbK/gDWpIWeVE6Wxlhyx
         yTIo8iQGaV/K4usRg+HpQ1zTWM40TWLc9vt3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMJrW3rbhiV2WpI8udS44p8yxQXPp4OR7zwWUWrBLQY=;
        b=26aMBBoKgKNGCs8Jaop+6K+i6ItHzwxlj/v0MklPgj/VOS0CnGbTQyQre1sncTf4X8
         FqNeZktuJcfBe34tskN/YTAAYYqsa2xbZrXsLv8PfwHtLlwIJKMOVk6Vm4g8gniEgFZ4
         kmt03h6z+mHx8r9k4QeYhVH2N465gR+4YHSC+rTVuIHca1o+LyRnD8wWmoWfRIsppa6I
         ADsS9CFKR+vOBbF5k/GPp9jhoEHMunkK/ENUJOL7R4OJMVRRSaUEggmapGxI5LxqRRq/
         Np16TQsWv92OnaXVYPtS+a50IJ3jv+BNtACxGXbIhlAq/SAjWMpSD5FXoDC7dKw/bBqm
         ukDw==
X-Gm-Message-State: AO0yUKXp7/2Gkf0C2iem2FzJl/wi1RslGaowAkk9IuUF+r9hkkoQQS01
        JkxJbLcDinXLfi9ichcC5pPAF0O+lcQ1TkJqS4RGXw==
X-Google-Smtp-Source: AK7set9vsLwX+gthcvL2Wxef+YafrTV4xzfWZkMbI8ss4V/DiE2fTut21H1Wtq3OHhxIlP71d2IMxXbDSdVrl7GcBi0=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1529005vso.60.1676607779821; Thu, 16 Feb
 2023 20:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-36-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-36-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:22:48 +0800
Message-ID: <CAGXv+5HHQ+ZQt6CVOKKvef5CQVWe1AW6N07GSUCBuFZc5P=59Q@mail.gmail.com>
Subject: Re: [PATCH v2 35/47] clk: mediatek: Add MODULE_LICENSE() where missing
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In order to successfully build clock drivers as modules it is required
> to declare a module license: add it where missing.
> While at it, also change the MODULE_LICENSE text from "GPL v2" to
> "GPL" (which means the same) on clk-mt7981-eth.c.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Looks like all files have it now.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
