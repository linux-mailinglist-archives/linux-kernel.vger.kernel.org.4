Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED45E6D098A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjC3P3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjC3P27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:28:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E172D53A;
        Thu, 30 Mar 2023 08:28:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so12044532wmq.3;
        Thu, 30 Mar 2023 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680190074;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugAmLJblkYMugEo7tfI+icr2H8SDN/QMTqfPS9Pdgjo=;
        b=A44BlkQDQ7N2zVdqRxC0isCQGdigI1SNxHICLB5Te0OaNAhTzUqOU3fXpGMpN9Mrrx
         16wpg/ZDZzSZbMB+PZyzz5LjPXiWSRX5nKCXvRlbMxxbvP839agd1ifIDZy9TAysKPWD
         V5kC908V8ZkcCScJZ9Br8fhwrtH22KblL7nGQwijPSIn5N1MDo4eQxXeNLJFhMjKDga/
         5J1c3KtjAxa8fJZzsP2Go+oPHw3yIy0odwD/AtgxawbSTbTkE+X0+5ZM290469AK/QUf
         PsvIDvanw8B+VkULGYhmkO6VkqILXrAjGiJDL/pkC96KnGgUjIn5SmqQbCIm0VVDvFaF
         iZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190074;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugAmLJblkYMugEo7tfI+icr2H8SDN/QMTqfPS9Pdgjo=;
        b=ryOEs8pJcEMp61YGfRn1f7887Cq5nRSzUhp6OZ45DBeJ4Q/g471thQTa3cS2oxx8u/
         BG+dODHmR1bDgyRTj2amVRDEP6Po68jhHeW5Bg3e5e+jOq04pfUGioyYCCuuxCM7El+p
         TCk+5Gtt/hPQru7hGdHu6g5ZfBj+JxdwkPWKWFkttEDs4l663bl9Hs9zKWW6pwd2enjF
         5AK+uFtX8kyn1eD1n/07rDtgtOaxzTBPtZNkTPcm9TtFS+hveyyd0IpLqX1JU+SmSExd
         xgLDvO+IuFdDHgNW3hHofMIZDkVml2h048V3mXG3ObrDgVR3k3D0i8LXeC1MY2WBy2r9
         Q5hA==
X-Gm-Message-State: AO0yUKUti1CD5/+6uO/OcSa2qinrqn0cpqJoh3i5I8N8jb2sG/dUAzbK
        6nmpO4VbJHPgt6aJx+Bxz9DoEfKUe8g=
X-Google-Smtp-Source: AK7set9CzWMbpFkxw8byP8zOEJzHj/hUibEgy5nYYaciVm0s2mkNKVRPXh1b2EftFefmV84mZU6tQA==
X-Received: by 2002:a05:600c:2110:b0:3ed:2b27:5bcc with SMTP id u16-20020a05600c211000b003ed2b275bccmr17827101wml.38.1680190074112;
        Thu, 30 Mar 2023 08:27:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003ede6540190sm6788865wmq.0.2023.03.30.08.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:27:53 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:27:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, ChiaEn Wu <chiaen_wu@richtek.com>,
        jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, peterwu.pub@gmail.com,
        cy_huang@richtek.com, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: Re: [PATCH] iio: adc: mt6370: Fix ibus and ibat scaling value of
 some specific vendor ID chips
Message-ID: <75f27c56-5e35-40dc-a320-66bf6a8ed36f@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679667167-16261-1-git-send-email-chiaen_wu@richtek.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiaEn,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ChiaEn-Wu/iio-adc-mt6370-Fix-ibus-and-ibat-scaling-value-of-some-specific-vendor-ID-chips/20230324-221545
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/1679667167-16261-1-git-send-email-chiaen_wu%40richtek.com
patch subject: [PATCH] iio: adc: mt6370: Fix ibus and ibat scaling value of some specific vendor ID chips
config: m68k-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230330/202303302231.gNdPKrtD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303302231.gNdPKrtD-lkp@intel.com/

smatch warnings:
drivers/iio/adc/mt6370-adc.c:306 mt6370_adc_probe() error: uninitialized symbol 'priv'.

vim +/priv +306 drivers/iio/adc/mt6370-adc.c

c1404d1b659fe3d ChiaEn Wu 2022-10-11  294  static int mt6370_adc_probe(struct platform_device *pdev)
c1404d1b659fe3d ChiaEn Wu 2022-10-11  295  {
c1404d1b659fe3d ChiaEn Wu 2022-10-11  296  	struct device *dev = &pdev->dev;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  297  	struct mt6370_adc_data *priv;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  298  	struct iio_dev *indio_dev;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  299  	struct regmap *regmap;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  300  	int ret;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  301  
c1404d1b659fe3d ChiaEn Wu 2022-10-11  302  	regmap = dev_get_regmap(pdev->dev.parent, NULL);
c1404d1b659fe3d ChiaEn Wu 2022-10-11  303  	if (!regmap)
c1404d1b659fe3d ChiaEn Wu 2022-10-11  304  		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
c1404d1b659fe3d ChiaEn Wu 2022-10-11  305  
9822359d5de2dba ChiaEn Wu 2023-03-24 @306  	ret = mt6370_get_vendor_info(priv);

"priv" is uninitialized.

9822359d5de2dba ChiaEn Wu 2023-03-24  307  	if (ret)
9822359d5de2dba ChiaEn Wu 2023-03-24  308  		return dev_err_probe(dev, ret, "Failed to get vid\n");
9822359d5de2dba ChiaEn Wu 2023-03-24  309  
c1404d1b659fe3d ChiaEn Wu 2022-10-11  310  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
c1404d1b659fe3d ChiaEn Wu 2022-10-11  311  	if (!indio_dev)
c1404d1b659fe3d ChiaEn Wu 2022-10-11  312  		return -ENOMEM;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  313  
c1404d1b659fe3d ChiaEn Wu 2022-10-11  314  	priv = iio_priv(indio_dev);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^

c1404d1b659fe3d ChiaEn Wu 2022-10-11  315  	priv->dev = dev;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  316  	priv->regmap = regmap;
c1404d1b659fe3d ChiaEn Wu 2022-10-11  317  	mutex_init(&priv->adc_lock);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

