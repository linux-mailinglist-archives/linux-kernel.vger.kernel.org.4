Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9F65BBCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjACIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjACIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:15:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59DFDF09;
        Tue,  3 Jan 2023 00:15:32 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso12303824wmq.1;
        Tue, 03 Jan 2023 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D24Ke8emZUzBrFiO02JZq5KiuUcFxUJuSzFEhev76Dk=;
        b=m9Y9Ra7OKWDZ+nIeMqGzMbR1ZQO/8Z4xpUytyPON17FlDc5os+Nk4zB0IXdqf+LIp1
         vBbRVuIj4saUoXMpzcUyvUowViY2xwuFXmiCxNb5oBB9Pm04hFOZrDIEY7vEwrkPaCER
         XKm3/ll4P3wNxewGl3PFt/GDOU86w1pw6WOmxC1PtNJZfERjuimh2byO+cmYaf4kZ60/
         yOSdKx2GVrsQwc7nIfNdWc96rc69hlLoZbo53U//ReGmkdM/hN9/UqP6eeseFvMt/NTg
         39aZwmmQeeW3JNcb74VPmfpraRDo40yTkMXFJAp4CWgAxZ5sa5QJXTN4dnBzVdFr8tds
         hczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D24Ke8emZUzBrFiO02JZq5KiuUcFxUJuSzFEhev76Dk=;
        b=RzOHfgvPadpyx9TClTrxOlN6cEHVR5yYz6j3nknaibd+vH59z/zNonCXs+4vI0cE4h
         vHBUzSPdQa5cTENpSqQQO5CcwtOB9rTm4QxTJpq0vNjdNEaqZ+08tlEXQbCy3f9rmYRK
         S089dzE37bVBz7z7Ng+aADPK6YHynQKEm671UsiQMhqWsrVDKOBPInddlk7sfhuF8+2B
         yCOJYn7yjiCcZqO76A7e+weqm4f+rKrYALdr0ogmAJgVTBA8+fexSGYWpt7CnuDuPYcl
         L8SkqqEmlR8P0a66Obk6JkJFX4NwEYGLZEXzxhwz2+/MSNiJfaMOT2MLlDcX99P4ygA2
         pgEw==
X-Gm-Message-State: AFqh2kpHMtVdYEZ59sCk+1jYFolLjloIOBdfSZ6L4ncVfAjEA1RK2gra
        /5oz/Gf4WiS1zdM4kOXFfgY58QtPRu0cRWf0
X-Google-Smtp-Source: AMrXdXuB8XWVL5cQY2apWhtCvBxmcSiMLpwa3Q675GiAeD4bd3YkwTn/CJv6A52w9uEkJPyg+q1JrQ==
X-Received: by 2002:a05:600c:a4e:b0:3d1:baf7:ceae with SMTP id c14-20020a05600c0a4e00b003d1baf7ceaemr30459488wmq.39.1672733731471;
        Tue, 03 Jan 2023 00:15:31 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf5ec79bf9sm40588410wmo.40.2023.01.03.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:15:31 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:15:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Moudy Ho <moudy.ho@mediatek.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:992
 mdp_comp_config() warn: missing unwind goto?
Message-ID: <202301031311.h6InTjT3-lkp@intel.com>
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
head:   69b41ac87e4a664de78a395ff97166f0b2943210
commit: 61890ccaefaff89f5babd2c8412fd222c3f5fe38 media: platform: mtk-mdp3: add MediaTek MDP3 driver
config: ia64-randconfig-m041-20230101
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:992 mdp_comp_config() warn: missing unwind goto?

Old smatch warnings:
drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:872 mdp_comp_create() warn: passing devm_ allocated variable to kfree. 'comp'

vim +992 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c

61890ccaefaff8 Moudy Ho 2022-08-23   939  int mdp_comp_config(struct mdp_dev *mdp)
61890ccaefaff8 Moudy Ho 2022-08-23   940  {
61890ccaefaff8 Moudy Ho 2022-08-23   941  	struct device *dev = &mdp->pdev->dev;
61890ccaefaff8 Moudy Ho 2022-08-23   942  	struct device_node *node, *parent;
61890ccaefaff8 Moudy Ho 2022-08-23   943  	struct platform_device *pdev;
61890ccaefaff8 Moudy Ho 2022-08-23   944  	int ret;
61890ccaefaff8 Moudy Ho 2022-08-23   945  
61890ccaefaff8 Moudy Ho 2022-08-23   946  	memset(mdp_comp_alias_id, 0, sizeof(mdp_comp_alias_id));
61890ccaefaff8 Moudy Ho 2022-08-23   947  
61890ccaefaff8 Moudy Ho 2022-08-23   948  	parent = dev->of_node->parent;
61890ccaefaff8 Moudy Ho 2022-08-23   949  	/* Iterate over sibling MDP function blocks */
61890ccaefaff8 Moudy Ho 2022-08-23   950  	for_each_child_of_node(parent, node) {
61890ccaefaff8 Moudy Ho 2022-08-23   951  		const struct of_device_id *of_id;
61890ccaefaff8 Moudy Ho 2022-08-23   952  		enum mdp_comp_type type;
61890ccaefaff8 Moudy Ho 2022-08-23   953  		int id, alias_id;
61890ccaefaff8 Moudy Ho 2022-08-23   954  		struct mdp_comp *comp;
61890ccaefaff8 Moudy Ho 2022-08-23   955  
61890ccaefaff8 Moudy Ho 2022-08-23   956  		of_id = of_match_node(mdp_comp_dt_ids, node);
61890ccaefaff8 Moudy Ho 2022-08-23   957  		if (!of_id)
61890ccaefaff8 Moudy Ho 2022-08-23   958  			continue;
61890ccaefaff8 Moudy Ho 2022-08-23   959  
61890ccaefaff8 Moudy Ho 2022-08-23   960  		if (!of_device_is_available(node)) {
61890ccaefaff8 Moudy Ho 2022-08-23   961  			dev_dbg(dev, "Skipping disabled component %pOF\n",
61890ccaefaff8 Moudy Ho 2022-08-23   962  				node);
61890ccaefaff8 Moudy Ho 2022-08-23   963  			continue;
61890ccaefaff8 Moudy Ho 2022-08-23   964  		}
61890ccaefaff8 Moudy Ho 2022-08-23   965  
61890ccaefaff8 Moudy Ho 2022-08-23   966  		type = (enum mdp_comp_type)(uintptr_t)of_id->data;
61890ccaefaff8 Moudy Ho 2022-08-23   967  		alias_id = mdp_comp_alias_id[type];
61890ccaefaff8 Moudy Ho 2022-08-23   968  		id = mdp_comp_get_id(type, alias_id);
61890ccaefaff8 Moudy Ho 2022-08-23   969  		if (id < 0) {
61890ccaefaff8 Moudy Ho 2022-08-23   970  			dev_err(dev,
61890ccaefaff8 Moudy Ho 2022-08-23   971  				"Fail to get component id: type %d alias %d\n",
61890ccaefaff8 Moudy Ho 2022-08-23   972  				type, alias_id);
61890ccaefaff8 Moudy Ho 2022-08-23   973  			continue;
61890ccaefaff8 Moudy Ho 2022-08-23   974  		}
61890ccaefaff8 Moudy Ho 2022-08-23   975  		mdp_comp_alias_id[type]++;
61890ccaefaff8 Moudy Ho 2022-08-23   976  
61890ccaefaff8 Moudy Ho 2022-08-23   977  		comp = mdp_comp_create(mdp, node, id);
61890ccaefaff8 Moudy Ho 2022-08-23   978  		if (IS_ERR(comp)) {
61890ccaefaff8 Moudy Ho 2022-08-23   979  			ret = PTR_ERR(comp);
61890ccaefaff8 Moudy Ho 2022-08-23   980  			goto err_init_comps;
61890ccaefaff8 Moudy Ho 2022-08-23   981  		}
61890ccaefaff8 Moudy Ho 2022-08-23   982  
61890ccaefaff8 Moudy Ho 2022-08-23   983  		/* Only DMA capable components need the pm control */
61890ccaefaff8 Moudy Ho 2022-08-23   984  		comp->comp_dev = NULL;
61890ccaefaff8 Moudy Ho 2022-08-23   985  		if (!is_dma_capable(comp->type))
61890ccaefaff8 Moudy Ho 2022-08-23   986  			continue;
61890ccaefaff8 Moudy Ho 2022-08-23   987  
61890ccaefaff8 Moudy Ho 2022-08-23   988  		pdev = of_find_device_by_node(node);
61890ccaefaff8 Moudy Ho 2022-08-23   989  		if (!pdev) {
61890ccaefaff8 Moudy Ho 2022-08-23   990  			dev_warn(dev, "can't find platform device of node:%s\n",
61890ccaefaff8 Moudy Ho 2022-08-23   991  				 node->name);
61890ccaefaff8 Moudy Ho 2022-08-23  @992  			return -ENODEV;

Presumably this should be "goto err_init_comps;" but I have not looked
at the context out side of this email.  Normally for loops it's better
to clean up the partial iteration before doing the goto.  So undo the
mdp_comp_create() and then goto.  But again I have no context for this
code.

61890ccaefaff8 Moudy Ho 2022-08-23   993  		}
61890ccaefaff8 Moudy Ho 2022-08-23   994  
61890ccaefaff8 Moudy Ho 2022-08-23   995  		comp->comp_dev = &pdev->dev;
61890ccaefaff8 Moudy Ho 2022-08-23   996  		pm_runtime_enable(comp->comp_dev);
61890ccaefaff8 Moudy Ho 2022-08-23   997  	}
61890ccaefaff8 Moudy Ho 2022-08-23   998  
61890ccaefaff8 Moudy Ho 2022-08-23   999  	ret = mdp_comp_sub_create(mdp);
61890ccaefaff8 Moudy Ho 2022-08-23  1000  	if (ret)
61890ccaefaff8 Moudy Ho 2022-08-23  1001  		goto err_init_comps;
61890ccaefaff8 Moudy Ho 2022-08-23  1002  
61890ccaefaff8 Moudy Ho 2022-08-23  1003  	return 0;
61890ccaefaff8 Moudy Ho 2022-08-23  1004  
61890ccaefaff8 Moudy Ho 2022-08-23  1005  err_init_comps:
61890ccaefaff8 Moudy Ho 2022-08-23  1006  	mdp_comp_destroy(mdp);
61890ccaefaff8 Moudy Ho 2022-08-23  1007  	return ret;
61890ccaefaff8 Moudy Ho 2022-08-23  1008  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

