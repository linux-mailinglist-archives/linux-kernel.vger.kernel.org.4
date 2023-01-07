Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D03660D0A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjAGIki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 03:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAGIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:40:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC61219F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:40:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z5so2194542wrt.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ5P1wDbIcvebvDNJyCuZSz2c6UHJpFAi9orkbFi7MM=;
        b=leCqRXHHtvImpioKXuPmV+IOcy9SOb9wS4z6tvDWf6KqJrNlJsprvE7e/xdY9fzttA
         naIyN9VOqlMaKRUOcBzXjLF2O7u1Snti9SoKcLmTPo+uG8nlQ/jdq+ZeZ9JHasgzsnm7
         iXG6UzXbNLUgg1ScTdSStVdVC8jk3OY9mofzNW3HUL/QzLbguCuJv0227/WDlUJBkgGM
         XFBk/akCv84yLse7uCMD98IaUWDnSfavsxXazVRw9AxQDCkKa32T982i8/6fgMSX4oX5
         7oQcwCdl4K0HQD6iRTWpZ4J3cv0fBlUTy/MobXazYwypMo/WdBVegXPBgGk6+x6I/bQl
         IIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ5P1wDbIcvebvDNJyCuZSz2c6UHJpFAi9orkbFi7MM=;
        b=jbJPS9bRQ1Lo7X0Y+6CkCVjtfqEIKjg/wQryT+EXUA9+NzhKNCZ2fUn1RNBVfA8SYr
         7rGnHaDpAsibuxRmwc+zXJN0Im327qJPlWpaha0dc/FRzu7yP0S4Yi8ZZ+KWhLTV+AVI
         8drstSd6mjlgo5opdBHmgY6IbgVcRYkUUNBuaJY7k2Hxpv3TIG/XIO8TMAZiKWsxXnnA
         Gt/ff+avoW+SRs5vVtK8xXD2DPeGJv+bfYH0B+n1eOQwRuP/ZLtwsd4iJYQ1KmOzLIT9
         o757os/UeUQg56DbCcFxdhQzcxUtY7r1AuK4iqwY/bcAHMNTAQ++oPu3VOiewl1rxwMd
         oJIw==
X-Gm-Message-State: AFqh2kq4qByN0LKzbICzgcThEY2Mf+dFptLpZ4d8ou4vWi3WpmAEMbYf
        +hfHe3CFEGpiGVVq2BMa+AclOo0o+gEtRBzl
X-Google-Smtp-Source: AMrXdXsFmifkZg4c4qh6fMJNAdtI0zXint4Zh6ArKFnFKBJ1HmcLjjvCz7WZOpw2l4AAvqYO0xE8jA==
X-Received: by 2002:a05:6000:982:b0:2a3:6f99:17d4 with SMTP id by2-20020a056000098200b002a36f9917d4mr8895076wrb.5.1673080834727;
        Sat, 07 Jan 2023 00:40:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d5408000000b0027973315213sm3233092wrv.89.2023.01.07.00.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 00:40:34 -0800 (PST)
Date:   Sat, 7 Jan 2023 11:40:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c:143
 primary_codec_init() warn: missing error code? 'ret'
Message-ID: <202301070814.uxRqe1Ox-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f5abbd77e2c1787e74b7c2caffac97def78ba52
commit: e14657c0f0022e02c8f25fa9c56afae3d3db9e77 ASoC: mediatek: mt8186-rt5682: Modify machine driver for two DMICs case
config: microblaze-randconfig-m041-20230106
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c:143 primary_codec_init() warn: missing error code? 'ret'

vim +/ret +143 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c

e14657c0f0022e Ajye Huang 2022-11-02  127  static int primary_codec_init(struct snd_soc_pcm_runtime *rtd)
e14657c0f0022e Ajye Huang 2022-11-02  128  {
e14657c0f0022e Ajye Huang 2022-11-02  129  	struct snd_soc_card *card = rtd->card;
e14657c0f0022e Ajye Huang 2022-11-02  130  	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
e14657c0f0022e Ajye Huang 2022-11-02  131  	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
e14657c0f0022e Ajye Huang 2022-11-02  132  	int ret;
e14657c0f0022e Ajye Huang 2022-11-02  133  
e14657c0f0022e Ajye Huang 2022-11-02  134  	ret = mt8186_mt6366_init(rtd);
e14657c0f0022e Ajye Huang 2022-11-02  135  
e14657c0f0022e Ajye Huang 2022-11-02  136  	if (ret) {
e14657c0f0022e Ajye Huang 2022-11-02  137  		dev_err(card->dev, "mt8186_mt6366_init failed: %d\n", ret);
e14657c0f0022e Ajye Huang 2022-11-02  138  		return ret;
e14657c0f0022e Ajye Huang 2022-11-02  139  	}
e14657c0f0022e Ajye Huang 2022-11-02  140  
e14657c0f0022e Ajye Huang 2022-11-02  141  	if (!priv->dmic_sel) {
e14657c0f0022e Ajye Huang 2022-11-02  142  		dev_info(card->dev, "dmic_sel is null\n");
e14657c0f0022e Ajye Huang 2022-11-02 @143  		return ret;

return -EIVNAL;?  return 0;?

e14657c0f0022e Ajye Huang 2022-11-02  144  	}
e14657c0f0022e Ajye Huang 2022-11-02  145  
e14657c0f0022e Ajye Huang 2022-11-02  146  	ret = snd_soc_dapm_new_controls(&card->dapm, dmic_widgets,
e14657c0f0022e Ajye Huang 2022-11-02  147  					ARRAY_SIZE(dmic_widgets));
e14657c0f0022e Ajye Huang 2022-11-02  148  	if (ret) {
e14657c0f0022e Ajye Huang 2022-11-02  149  		dev_err(card->dev, "DMic widget addition failed: %d\n", ret);
e14657c0f0022e Ajye Huang 2022-11-02  150  		/* Don't need to add routes if widget addition failed */
e14657c0f0022e Ajye Huang 2022-11-02  151  		return ret;
e14657c0f0022e Ajye Huang 2022-11-02  152  	}
e14657c0f0022e Ajye Huang 2022-11-02  153  
e14657c0f0022e Ajye Huang 2022-11-02  154  	ret = snd_soc_dapm_add_routes(&card->dapm, dmic_map,
e14657c0f0022e Ajye Huang 2022-11-02  155  				      ARRAY_SIZE(dmic_map));
e14657c0f0022e Ajye Huang 2022-11-02  156  
e14657c0f0022e Ajye Huang 2022-11-02  157  	if (ret)
e14657c0f0022e Ajye Huang 2022-11-02  158  		dev_err(card->dev, "DMic map addition failed: %d\n", ret);
e14657c0f0022e Ajye Huang 2022-11-02  159  
e14657c0f0022e Ajye Huang 2022-11-02  160  	return ret;
e14657c0f0022e Ajye Huang 2022-11-02  161  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

