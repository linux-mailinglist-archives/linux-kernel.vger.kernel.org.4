Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806A6558CC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiLXHOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:14:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B885FD2C;
        Fri, 23 Dec 2022 23:13:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so6153371wml.0;
        Fri, 23 Dec 2022 23:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRIB/uqq1D1ds14eihu2u9/Z/nUyFPPLNm+Ijo9Q/C8=;
        b=dJhcufzpI8v7auHG2F7vYYXvc4SKzUN3cGCkrzIwmcp8j/CDEqE6qve3Q7qfMsiCvB
         pj2xFJ9JrATBheS0CPByKqX7fhozBw7ONDd3Z6LQo47As9CiEyLHPHewEPQ0d12crCXG
         tLH7t760elDFi3wBXyYFkS1wpq28v5MFWUvuMFtBNILtP1p2GRhDCYsGOkPgeJfjFddQ
         r/2NIl7kDf3w/pOuuAH2NF+3jSE7KIKJSa1kfbiakwQ2aQpf9n4pSAC6TuMZ3THCbrnT
         6aQA/tMF7D6llq7+ROkxBVtbsZ9+rhxAzNFpMAnw0KlwuFyMhdefhzz7ZaRAy9eqQxyA
         3bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRIB/uqq1D1ds14eihu2u9/Z/nUyFPPLNm+Ijo9Q/C8=;
        b=d0FChr+4An8/cKnDKKG13zJ3djnhuOd95S/9o5EidoIdhpU5f7iYbkgbfw7ipziGg/
         Wkd60UCL9XroapK41kLQsWO9oNz3KCqicSKK/Xt2rQxEtHC26DSrxSD/2uz7HgRqGgcW
         IzscWM0z55D9QI5fC+GIAPn0CirOkR+91fAfiO7wOd+A0IJvqgMW70fn0xgZnAGnS2yL
         lv5fKMThgg32CXYVbrQMJWIKNDKNUlH016+dIblFPUJv+ouXuydW+x8fp32vuQZbw2ht
         gaTAtdXIppLAWF0aY6jO1RTSuOmU8Ip/OT9trMdtLv2Vs6F8Zcdao7aIrdDZmtUjAnr4
         2DDQ==
X-Gm-Message-State: AFqh2kqjn7N4psvZxPaE3S+B5U3h2MX64WhBQTaXMx28IqIWD3F+tglr
        7/hZC7vKXBLpnXJ9G6Hds7o=
X-Google-Smtp-Source: AMrXdXs1TWgBnGsltnpH+XplZfqjbDa61uyuzwMISc+4HbT/go1y6J3QQ9zAkCYFUJsj8oLlBzOzsA==
X-Received: by 2002:a05:600c:4f48:b0:3c6:f7ff:6f87 with SMTP id m8-20020a05600c4f4800b003c6f7ff6f87mr9065324wmq.11.1671866036633;
        Fri, 23 Dec 2022 23:13:56 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003b4a699ce8esm11568562wma.6.2022.12.23.23.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 23:13:56 -0800 (PST)
Date:   Sat, 24 Dec 2022 10:13:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, sboyd@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
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
Subject: Re: [PATCH v2 10/23] clk: mediatek: mt8173: Break down clock drivers
 and allow module build
Message-ID: <202212240437.1D3FXJyP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223094259.87373-11-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/clk-mediatek-mt8192-Correctly-unregister-and-free-clocks-on-failure/20221223-174705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20221223094259.87373-11-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 10/23] clk: mediatek: mt8173: Break down clock drivers and allow module build
config: parisc-randconfig-m031-20221219
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/clk/mediatek/clk-mt8173-apmixedsys.c:95 clk_mt8173_apmixed_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +95 drivers/clk/mediatek/clk-mt8173-apmixedsys.c

c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   85  static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   86  {
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   87  	struct device_node *node = pdev->dev.of_node;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   88  	struct clk_hw_onecell_data *clk_data;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   89  	void __iomem *base;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   90  	struct clk_hw *hw;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   91  	int r;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   92  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   93  	base = of_iomap(node, 0);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   94  	if (!base)
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  @95  		return PTR_ERR(base);

return -ENOMEM?

c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   96  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   97  	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   98  	if (IS_ERR_OR_NULL(clk_data))
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23   99  		return -ENOMEM;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  100  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  101  	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  102  	if (r)
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  103  		goto free_clk_data;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  104  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  105  	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  106  	if (IS_ERR(hw)) {
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  107  		r = PTR_ERR(hw);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  108  		dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  109  		goto unregister_plls;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  110  	}
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  111  	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  112  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  113  	hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  114  					  base + REGOFF_HDMI_REF, 16, 3,
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  115  					  CLK_DIVIDER_POWER_OF_TWO, NULL);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  116  	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  117  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  118  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  119  	if (r)
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  120  		goto unregister_ref2usb;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  121  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  122  	return 0;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  123  
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  124  unregister_ref2usb:
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  125  	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  126  unregister_plls:
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  127  	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  128  free_clk_data:
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  129  	mtk_free_clk_data(clk_data);
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  130  	return r;
c10b45573221c8 AngeloGioacchino Del Regno 2022-12-23  131  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

