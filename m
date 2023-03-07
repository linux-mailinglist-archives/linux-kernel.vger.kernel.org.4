Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42C6AD7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCGHFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:05:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C6058C26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:05:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so48525389edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678172746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpUEW/RC3/zFSVTvrW+Z36YKDcQplwHx/uRumD1mPLk=;
        b=a88g5kQQjM8x/NzrClbfCKEpIWiUNL7uouSY1sRu0GKwCHahbX1uQW+TycHAgTBUFg
         lcSCrUeoriOJNvcFyqrVfrgq8CbwFN493pnHKlIb8GBhG7fqVHBZ8YWDKrykldhMPICZ
         z2xsPPA9Zr9pyMXvrLUvq/aEV2APGblUJMp4Du2HU2ALxMFE/3WcJxcIKPUSkePVpnH5
         HeDd8rxuT3IfvMPQNF5HyVxLqC6Plf+oB1gS94T9IMsTHQBmX+PmvSeq2AAk5fns7bXo
         0qbDutBjpC1XvY8QhcUldh9q5dq3UYoJ1ESNHsTx6DX4dYQ2R5okGfm2g7OLpp3zozZ/
         eDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpUEW/RC3/zFSVTvrW+Z36YKDcQplwHx/uRumD1mPLk=;
        b=0sdvJBc/V18fkQ6T3yAYzqf/Z5booi6IIHz++KeIP5lN5rDKARns+oaX4GfRVRlUUH
         Or39TTrTEyy4dycPSWzcMMrXmISCH6A6NCOtIR94CbCsbytcJBRwrtjUzqYAzfCW5PLp
         Pv0q5Z+KWX8GCids3GFKGRy1sXh87rMcsDloMfdM3wtA2fv4chfV/H4KRHTY+uibTt3B
         man9mWFFEZrFkvQnWvXME0v9VlSND7/vOYChWcnpps0ouamouzTZUdELdAtDkiUSTjuM
         QjKMrVFAi6tv66jvaB15HsnngKuQc0uJHZih/96kV+TtthZMO5XqFwb16fijFiEMwIwI
         WNkQ==
X-Gm-Message-State: AO0yUKUclvmxCPtvOuCHKQZ+5LlE/6HmF25H+6LgMAJPXHAJIqnPdNju
        LxT33N/v+SdbzssozOqfz34JBwabjGs=
X-Google-Smtp-Source: AK7set+alCrQYLxCmOKnOoPgy9z5/Niq4vxUiEcPT8ixTNeVz2DWX5qCT48Lw4CexzkqUSXGUYH6Qg==
X-Received: by 2002:a17:907:8e9a:b0:8f1:da18:c6ca with SMTP id tx26-20020a1709078e9a00b008f1da18c6camr16199041ejc.3.1678172746513;
        Mon, 06 Mar 2023 23:05:46 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d27-20020a50f69b000000b004acb696a0f6sm6184329edn.91.2023.03.06.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 23:05:46 -0800 (PST)
Date:   Tue, 7 Mar 2023 10:05:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/mediatek/clk-mt8173-apmixedsys.c:95
 clk_mt8173_apmixed_probe() warn: passing zero to 'PTR_ERR'
Message-ID: <4dcf17f2-a74d-47fa-968e-67deb7d2498f@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
commit: 4c02c9af3cb9449cd176300b288e8addb5083934 clk: mediatek: mt8173: Break down clock drivers and allow module build
config: microblaze-randconfig-m031-20230305 (https://download.01.org/0day-ci/archive/20230307/202303070207.8wVd9MFI-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303070207.8wVd9MFI-lkp@intel.com/

smatch warnings:
drivers/clk/mediatek/clk-mt8173-apmixedsys.c:95 clk_mt8173_apmixed_probe() warn: passing zero to 'PTR_ERR'
drivers/clk/mediatek/clk-mt8173-apmixedsys.c:130 clk_mt8173_apmixed_probe() warn: 'base' from of_iomap() not released on lines: 99.

vim +/PTR_ERR +95 drivers/clk/mediatek/clk-mt8173-apmixedsys.c

4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   85  static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   86  {
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   87  	struct device_node *node = pdev->dev.of_node;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   88  	struct clk_hw_onecell_data *clk_data;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   89  	void __iomem *base;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   90  	struct clk_hw *hw;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   91  	int r;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   92  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   93  	base = of_iomap(node, 0);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   94  	if (!base)
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  @95  		return PTR_ERR(base);

return -ENOMEM;  This currently returns success.

4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   96  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   97  	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   98  	if (IS_ERR_OR_NULL(clk_data))

This IS_ERR_OR_NULL() is kind of wrong.  It should just be if (!clk_data).
I wrote a blog about this:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20   99  		return -ENOMEM;

of_iounmap(base)?

4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  100  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  101  	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  102  	if (r)
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  103  		goto free_clk_data;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  104  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  105  	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  106  	if (IS_ERR(hw)) {
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  107  		r = PTR_ERR(hw);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  108  		dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  109  		goto unregister_plls;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  110  	}
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  111  	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  112  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  113  	hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  114  					  base + REGOFF_HDMI_REF, 16, 3,
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  115  					  CLK_DIVIDER_POWER_OF_TWO, NULL);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  116  	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  117  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  118  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  119  	if (r)
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  120  		goto unregister_ref2usb;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  121  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  122  	return 0;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  123  
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  124  unregister_ref2usb:
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  125  	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  126  unregister_plls:
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  127  	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  128  free_clk_data:
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  129  	mtk_free_clk_data(clk_data);
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20 @130  	return r;
4c02c9af3cb944 AngeloGioacchino Del Regno 2023-01-20  131  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

