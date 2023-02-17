Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC4569A610
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBQH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBQH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:26:47 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C15DE1F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:41 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id c25so181160vko.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8fdxhdYgUrieRTHDHYg/VxkIsWyyrT4Lc3Lq1NP/cZ4=;
        b=ZZ7ZJuigvVz5KfSje/MdYNtDmS91EC9g9+auzcOt2EDXKzg1pv92alpsJtnuGu7XPz
         ySePv3EhuySbjAcK/wxIz3IiWls+IFVZgB7HmJUcKW/dIeZbAiHpIW9qE0P5vt3/OVFH
         behyGp/qka25mpBkg7FLpJL2Qf05w8Jr8KxS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fdxhdYgUrieRTHDHYg/VxkIsWyyrT4Lc3Lq1NP/cZ4=;
        b=Nor0nZ2kN7urPg0/jvIL6+PniiOAAAeNznHM3ZucZYUsNDBoAmRmeQ9Ya57JJQmhtg
         VPkyoNoIB4DwdJ1t16+NEOEHyjBcpnkS0yKZ4+GJuNE90gYQfhq2d+fvGUSbSt8qtWR9
         s/y9DjBqtneOK4+ZbiyvIRuApmij+hWaCiArK3hGxSyArP/Yan6RjqhDj1SOcZrg69V1
         vsJwZQLr3xEy5qNGKDkIJpDNntMnPy4iePxTWEeCqBwebMQ9LWSHgAlKYfWB0MjJKyR2
         uqjKg5lRFQVhDsWtbzXQwk6uUBqtt2Qfp/mhvMq5Sv0p/dpU1jlXAy5QO8MqOs5FV7v8
         Xp1A==
X-Gm-Message-State: AO0yUKXzmldZzAjuPb2jq9eg45EFhraiw54fSLEoc8unzHaDUi2Mzbpr
        BwB91EAtQLaS+MSsG8TNJqjBA8OPV0mPg4Ge6f/jig==
X-Google-Smtp-Source: AK7set8jPjsh41skslVXvudRd5O1/mU3tyaEp+bhxmI9s0f0Gj25wehb+e9KPewhiMMtyVT6ouBXY2+DbtziPqkuqsY=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr1392988vke.2.1676618800587; Thu, 16 Feb
 2023 23:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-44-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-44-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 15:26:29 +0800
Message-ID: <CAGXv+5EWRJNhw86-pAduob4Yjy83tdZPpBFbj-13Tg4=_Vkucg@mail.gmail.com>
Subject: Re: [PATCH v2 43/47] clk: mediatek: Allow building most MT6797 clock
 drivers as modules
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Most of the MT6797 clock drivers can be built as modules: change them
> to tristate to allow that.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
