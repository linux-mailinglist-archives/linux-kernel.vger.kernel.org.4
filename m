Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBD6651BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjAKC1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjAKC1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:27:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4864D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:27:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso18470857pjp.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdQ1c6eIJ8Pfh7VJVWDgTo7nFYYtcTyxyIymvuRY7c8=;
        b=OWz6nrL6Wuyi/TWAJns/mDs7pQZjgqFrZ9wUn5e/fzATmgMoVuVRsjAwmOSWW2+K+N
         z8zAIrFngkWZMTl1cShrD0INkGiavt+5wH/F0YAttPa9YJAH62VE9kTl5UuW+bXCLqEc
         H4K73gA1/jtHMuUOJkoIYBm8LvPP/GHCWxY4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdQ1c6eIJ8Pfh7VJVWDgTo7nFYYtcTyxyIymvuRY7c8=;
        b=bJyepcwm0w380x7f2XbfruP9XJTg73FJ0MGEqLNPaGLAyKrfR89g/uGJejJERQjTk7
         9KwgKOL/JVnP980We1QKotB8FfY3ftfnIJVrmQZvTHu6m4Vw0VDTJ79A7burGTCBoASj
         Yg5yDTZZZDClBSyfm+gBKgU+3zBLVoDlizSEmifmBcYkfpHsvYohYBQXnC5u3Ji7ng6h
         +pLTbOSFToBNH2EOV4x9gquH2qANEZxzT3tGVqbtzpA7pGpYCsXDDRjnXL71ESH/89nK
         PGrJQ7NaTfIE7DqWG2o5JgZsFtkkmkmnoREwI8/yGmcO93YeNlgkLsyhhVGxNeEGsF9g
         i7jA==
X-Gm-Message-State: AFqh2kqeFHNVdEMcr/MO9eWnfUVmG94sH+7WvdxFseXP101Xejxpje5W
        uewyXXpc8ek5qglaMs3/9paRrQ==
X-Google-Smtp-Source: AMrXdXvXToYtzezykd+4mKc0RKkAYBPN8uoLeLVJ1EmSVDKfwhrNLNUGBwdmAi/c8oZEsXTdioXOUw==
X-Received: by 2002:a05:6a20:548e:b0:ac:19cf:1553 with SMTP id i14-20020a056a20548e00b000ac19cf1553mr96271314pzk.61.1673404028343;
        Tue, 10 Jan 2023 18:27:08 -0800 (PST)
Received: from google.com (2001-b011-0003-1479-d038-ab51-d40d-2b1f.dynamic-ip6.hinet.net. [2001:b011:3:1479:d038:ab51:d40d:2b1f])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709027fc200b00192f9991e51sm8649128plb.251.2023.01.10.18.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:27:08 -0800 (PST)
Date:   Wed, 11 Jan 2023 10:27:01 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 09/23] clk: mediatek: mt8173: Remove
 mtk_clk_enable_critical()
Message-ID: <Y74edWvIF6I40ANt@google.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-10-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Hk8kguJ=joLXF3OrRXxGvuFAJFKYoK+y7q+wqDBS-wtQ@mail.gmail.com>
 <8bc4330b-0cfe-222b-7b8a-35fd15a30a52@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc4330b-0cfe-222b-7b8a-35fd15a30a52@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:32:34PM +0100, AngeloGioacchino Del Regno wrote:
> Il 30/12/22 05:58, Chen-Yu Tsai ha scritto:
> > On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > 
> > > The entire point of mtk_clk_enable_critical() is to raise the refcount
> > > of some clocks so that they won't be turned off during runtime, but
> > > this is the same as what the CLK_IS_CRITICAL flag does.
> > > 
> > > Set CLK_IS_CRITICAL on all of the critical clocks and remove the
> > > aforementioned function as a cleanup.
> > > 
> > > No functional changes.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > 
> > 
> > Looks good to me,
> > 
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > 
> > However, if you move this patch before the previous one ...
> > 
> > > ---
> > >   drivers/clk/mediatek/clk-mt8173.c | 41 ++++++++++++-------------------
> > >   1 file changed, 16 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> > > index 70cdc0719658..02231f8ba6d9 100644
> > > --- a/drivers/clk/mediatek/clk-mt8173.c
> > > +++ b/drivers/clk/mediatek/clk-mt8173.c
> 
> > > @@ -846,23 +852,8 @@ static const struct mtk_clk_rst_desc clk_rst_desc[] = {
> > >          }
> > >   };
> > > 
> > > -static struct clk_hw_onecell_data *mt8173_top_clk_data;
> > > -static struct clk_hw_onecell_data *mt8173_pll_clk_data;
> > 
> > You wouldn't have to touch these lines twice?
> > 
> 
> That's true, but please,  I prefer not to, as the patches are ordered for
> eas(y/ier) bisectability in case anything happens.

Got it.
