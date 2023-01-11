Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119746651FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAKCr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjAKCr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:47:26 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D013F6A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:47:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d15so15306356pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzr0JKU+WrNNdmNSTbtISsg/fn4Ggbon1eEakhCke7s=;
        b=my34k4t+99yjolbLsD13HKjZiz4mbCXBtKZRvjbd1uNo6TqWY8H5Nt9Oa4qK+Bt0D/
         TCD4Yg2iATIrTq4MpUN1tyH1Cf5tpAPkV2K8U7YoJzAzgajcd6WtnkN7Xz3ShYG6fL0B
         GJXnSmQ5fx6kLUxyz5afXwBgl+LRZhJqJXXwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzr0JKU+WrNNdmNSTbtISsg/fn4Ggbon1eEakhCke7s=;
        b=Xof6prZLd5HVD2jkSOVgvTNAgCRoKXr27/qVm5DKZalIwHXiIaqxeWGTzHk90n7LmT
         fwjWDd8Aq3qzlQ3zYjGuJguTSpok/0JSMbwy3jR1Xrp/0x/To/antFeqTZC9fwOxU8xI
         sZ59XI4wmPLSNoIrIBINDWNzvVwEWeebJVOcNXZO30R5q13J1vTWx1g9pDU2e2XwbuaG
         z2HHrv4FoM+dIKceQLDs+v1aYhRKWMK/EvD++dM08p5f3GGBCclFaE0INTCyACHTNbD+
         G6l1Nt7oCRhiV41Uf3gKQuY0J+k5zLGHxtiWw16THKHBjAdnMMSTi2uoJ3bwcf+1crS4
         cbMQ==
X-Gm-Message-State: AFqh2kqW0K4LT3G8ahm5Uuy9RZa9kheNOWBycVk4AncJWgIwljEsCQ2u
        x3PJz8pAzeiCFLwXvsUqEMNpoJ//56oEAHDS
X-Google-Smtp-Source: AMrXdXtGHAZBhJxYvt5LLbcwXUDRmIA/eYlKMycH8TioarHtdcbhq3RUtLvz2hTlhRLdWdZsW/nG2A==
X-Received: by 2002:a05:6a20:13a6:b0:af:9c75:6699 with SMTP id w38-20020a056a2013a600b000af9c756699mr115021236pzh.1.1673405244494;
        Tue, 10 Jan 2023 18:47:24 -0800 (PST)
Received: from google.com (2001-b011-0003-1479-d038-ab51-d40d-2b1f.dynamic-ip6.hinet.net. [2001:b011:3:1479:d038:ab51:d40d:2b1f])
        by smtp.gmail.com with ESMTPSA id r2-20020a634402000000b0046ffe3fea77sm7356985pga.76.2023.01.10.18.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 18:47:24 -0800 (PST)
Date:   Wed, 11 Jan 2023 10:47:17 +0800
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
Subject: Re: [PATCH v2 11/23] clk: mediatek: Switch to mtk_clk_simple_probe()
 where possible
Message-ID: <Y74jNZbjpopT2rNY@google.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-12-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GYk2wr-UnnshT3R2uDUSn7-i5KifyJ4qDDZbptSQ9G7A@mail.gmail.com>
 <cba61b03-7e54-09e2-b1bd-8352f583a81b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba61b03-7e54-09e2-b1bd-8352f583a81b@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:31:40PM +0100, AngeloGioacchino Del Regno wrote:
> Il 30/12/22 06:12, Chen-Yu Tsai ha scritto:
> > On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > > 
> > > mtk_clk_simple_probe() is a function that registers mtk gate clocks
> > > and, if reset data is present, a reset controller and across all of
> > > the MTK clock drivers, such a function is duplicated many times:
> > > switch to the common mtk_clk_simple_probe() function for all of the
> > > clock drivers that are registering as platform drivers.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/clk/mediatek/clk-mt2701-aud.c   | 26 +++----
> > >   drivers/clk/mediatek/clk-mt2701-eth.c   | 34 +++------
> > >   drivers/clk/mediatek/clk-mt2701-g3d.c   | 56 +++-----------
> > >   drivers/clk/mediatek/clk-mt2701-hif.c   | 36 +++------
> > >   drivers/clk/mediatek/clk-mt2712.c       | 83 ++++++++-------------
> > >   drivers/clk/mediatek/clk-mt6779.c       | 42 ++++++-----
> > >   drivers/clk/mediatek/clk-mt7622-aud.c   | 49 +++----------
> > >   drivers/clk/mediatek/clk-mt7622-eth.c   | 82 ++++-----------------
> > >   drivers/clk/mediatek/clk-mt7622-hif.c   | 85 ++++-----------------
> > >   drivers/clk/mediatek/clk-mt7629-hif.c   | 85 ++++-----------------
> > >   drivers/clk/mediatek/clk-mt8183-audio.c | 19 +++--
> > >   drivers/clk/mediatek/clk-mt8183.c       | 75 ++++++++-----------
> > >   drivers/clk/mediatek/clk-mt8192-aud.c   | 25 +++----
> > >   drivers/clk/mediatek/clk-mt8192.c       | 98 ++++++++-----------------
> > >   14 files changed, 236 insertions(+), 559 deletions(-)
> > 
> > This looks mostly good, however ...
> > 
> > > diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
> > > index ab13ab618fb5..1fd6d96b34dc 100644
> > > --- a/drivers/clk/mediatek/clk-mt2701-aud.c
> > > +++ b/drivers/clk/mediatek/clk-mt2701-aud.c
> > > @@ -76,6 +76,7 @@ static const struct mtk_gate_regs audio3_cg_regs = {
> > >   };
> > > 
> > >   static const struct mtk_gate audio_clks[] = {
> > > +       GATE_DUMMY(CLK_DUMMY, "aud_dummy"),
> > >          /* AUDIO0 */
> > >          GATE_AUDIO0(CLK_AUD_AFE, "audio_afe", "aud_intbus_sel", 2),
> > >          GATE_AUDIO0(CLK_AUD_HDMI, "audio_hdmi", "audpll_sel", 20),
> > > @@ -138,29 +139,26 @@ static const struct mtk_gate audio_clks[] = {
> > >          GATE_AUDIO3(CLK_AUD_MEM_ASRC5, "audio_mem_asrc5", "asm_h_sel", 14),
> > >   };
> > > 
> > > +static const struct mtk_clk_desc audio_desc = {
> > > +       .clks = audio_clks,
> > > +       .num_clks = ARRAY_SIZE(audio_clks),
> > > +};
> > > +
> > >   static const struct of_device_id of_match_clk_mt2701_aud[] = {
> > > -       { .compatible = "mediatek,mt2701-audsys", },
> > > -       {}
> > > +       { .compatible = "mediatek,mt2701-audsys", .data = &audio_desc },
> > > +       { /* sentinel */ }
> > >   };
> > > 
> > >   static int clk_mt2701_aud_probe(struct platform_device *pdev)
> > >   {
> > > -       struct clk_hw_onecell_data *clk_data;
> > > -       struct device_node *node = pdev->dev.of_node;
> > >          int r;
> > > 
> > > -       clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
> > > -
> > > -       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> > > -                              clk_data, &pdev->dev);
> > > -
> > > -       r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> > > +       r = mtk_clk_simple_probe(pdev);
> > >          if (r) {
> > >                  dev_err(&pdev->dev,
> > >                          "could not register clock provider: %s: %d\n",
> > >                          pdev->name, r);
> > > -
> > > -               goto err_clk_provider;
> > > +               return r;
> > >          }
> > > 
> > >          r = devm_of_platform_populate(&pdev->dev);
> > > @@ -170,13 +168,13 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
> > >          return 0;
> > > 
> > >   err_plat_populate:
> > > -       of_clk_del_provider(node);
> > > -err_clk_provider:
> > > +       mtk_clk_simple_remove(pdev);
> > >          return r;
> > >   }
> > > 
> > >   static struct platform_driver clk_mt2701_aud_drv = {
> > >          .probe = clk_mt2701_aud_probe,
> > > +       .remove = mtk_clk_simple_remove,
> > 
> > I'm not a big fan of mixing devres and non-devres teardown code. Automatic
> > devres teardown happens after the remove callback returns, so in this
> > case you could have child devices being unregistered that touch clocks
> > or resets that have already been unregistered and freed in the remove
> > callback.
> > 
> 
> I'll add a custom remove function that calls of_platform_depopulate() and
> tears everything down manually in the correct order.
> 
> Thanks for catching this one, I didn't notice at all!
> 
> > >          .driver = {
> > >                  .name = "clk-mt2701-aud",
> > >                  .of_match_table = of_match_clk_mt2701_aud,
> > 
> > [...]
> > 
> > > --- a/drivers/clk/mediatek/clk-mt2712.c
> > > +++ b/drivers/clk/mediatek/clk-mt2712.c
> > 
> > [...]
> > 
> > > @@ -1482,7 +1459,11 @@ static struct platform_driver clk_mt2712_drv = {
> > > 
> > >   static int __init clk_mt2712_init(void)
> > >   {
> > > -       return platform_driver_register(&clk_mt2712_drv);
> > > +       int ret = platform_driver_register(&clk_mt2712_drv);
> > > +
> > > +       if (ret)
> > > +               return ret;
> > > +       return platform_driver_register(&clk_mt2712_simple_drv);
> > >   }
> > > 
> > >   arch_initcall(clk_mt2712_init);
> > 
> > Would this get cleaned up even more? I.e. have just one driver left and
> > we could have the nice *_platform_driver() macros.
> > 
> 
> In the future, yes - granted that I find someone that can help with the testing,
> as I don't have any MT2712 hardware here.
> 
> Not in this series though (please!).

Got it.

Maybe Miles has access to some EVBs, or knows someone who does.

ChenYu
