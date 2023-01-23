Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92ED677A78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAWMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAWMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:03:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A572384D;
        Mon, 23 Jan 2023 04:03:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d2so10554838wrp.8;
        Mon, 23 Jan 2023 04:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYHRTZ1ZlDHqoHQ79JmFn8fl8hS/HYnSK+DawMELKSk=;
        b=YKQ3YzUX6jTQIWyrFgboqYCNOhE4gU3Gz8GUlni2lBDaFxdRVULgJbjDwxSygJJpKa
         52CK3G6xvci4IggU+2YE0tNXQ7kp7AT226L0U3x8Y2Tq/AnfrThZa100Xc7PeCV0ji/z
         5R20spsze6sY9KJ5TQWVCA8XX3qCARDCfhVLeljIlQukmkqdREwMRGdsUmpTtvK3MApt
         GFng8CQpO829N6iCyw5+OPxWRzomgMYJWK4NkN8q6DMboTNTk6Lo9c2qguFh/KkSILPJ
         /oU0ACpHgeOA7C5MLJk6MdgbBuPswsIGmXvOhNV9RvHRpttWfyYheCmAxTDplHqk4Mvx
         KdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYHRTZ1ZlDHqoHQ79JmFn8fl8hS/HYnSK+DawMELKSk=;
        b=T1tMaRzMrzfmb/vtedGSuthSNrOi/6eDzAgTclzYGgf6LBP/yv9PSMVd/LC9420f3b
         x4OWEoQQo0lzu+2M9CM35LQff/suOcSvN+ottEpMrwv327PoTm6m0vrKH1aD36F5B+Zv
         22PRH9ImDdk5GcgMu8nNnJ41F4cHsKpu9ctmvTKABE3HbhQ0HxRrLBMlADewEiuJQTZH
         JMDOMOZ0zHHG073Dzi/gXADJ52WsbEvFktWMJa/3iF17aYI+u3SqDBdsD+OM9EUcn7Wd
         m06SKeLai20vMMHPK6Ce5m8pWN44u/ug0CnXKC7zJDSMtk5SlsGR4+GnUvZNF2Qc+hM/
         uMIQ==
X-Gm-Message-State: AFqh2koroRGyyaThSteII250zeN6l4coP+FCsUpFu7VogV/WX716AVsS
        yfOlV7mrVjAxil0qcIFDlO4=
X-Google-Smtp-Source: AMrXdXvx7UygUgM0uq3nK+NB+yluXw2BQSWnbrk55MSTF6b/P+Ia8PxHrQNLcHymVedWBMEBAb72nw==
X-Received: by 2002:a5d:6581:0:b0:2bb:dad4:9525 with SMTP id q1-20020a5d6581000000b002bbdad49525mr20099238wru.10.1674475431790;
        Mon, 23 Jan 2023 04:03:51 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d4487000000b002425be3c9e2sm4562280wrq.60.2023.01.23.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:03:51 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:03:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Jian Zhang <zhangjian210@huawei.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:2222 mxc_jpeg_probe()
 warn: missing unwind goto?
Message-ID: <Y853pH0ClJq2VyPQ@kadam>
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
head:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
commit: 5b304046a81eda221b5d06a9c62f7b5e45530fa5 media: driver/nxp/imx-jpeg: fix a unexpected return value problem
config: mips-randconfig-m031-20230122 (https://download.01.org/0day-ci/archive/20230122/202301221146.nosxauaO-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:2222 mxc_jpeg_probe() warn: missing unwind goto?

vim +2222 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c

2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2155  static int mxc_jpeg_probe(struct platform_device *pdev)
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2156  {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2157  	struct mxc_jpeg_dev *jpeg;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2158  	struct device *dev = &pdev->dev;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2159  	int dec_irq;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2160  	int ret;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2161  	int mode;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2162  	const struct of_device_id *of_id;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2163  	unsigned int slot;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2164  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2165  	of_id = of_match_node(mxc_jpeg_match, dev->of_node);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2166  	mode = *(const int *)of_id->data;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2167  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2168  	jpeg = devm_kzalloc(dev, sizeof(struct mxc_jpeg_dev), GFP_KERNEL);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2169  	if (!jpeg)
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2170  		return -ENOMEM;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2171  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2172  	mutex_init(&jpeg->lock);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2173  	spin_lock_init(&jpeg->hw_lock);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2174  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2175  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2176  	if (ret) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2177  		dev_err(&pdev->dev, "No suitable DMA available.\n");
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2178  		goto err_irq;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2179  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2180  
a498a4e7af5022 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Cai Huoqing        2021-09-01  2181  	jpeg->base_reg = devm_platform_ioremap_resource(pdev, 0);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2182  	if (IS_ERR(jpeg->base_reg))
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2183  		return PTR_ERR(jpeg->base_reg);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2184  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2185  	for (slot = 0; slot < MXC_MAX_SLOTS; slot++) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2186  		dec_irq = platform_get_irq(pdev, slot);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2187  		if (dec_irq < 0) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2188  			ret = dec_irq;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2189  			goto err_irq;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2190  		}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2191  		ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2192  				       0, pdev->name, jpeg);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2193  		if (ret) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2194  			dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2195  				dec_irq, ret);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2196  			goto err_irq;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2197  		}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2198  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2199  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2200  	jpeg->pdev = pdev;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2201  	jpeg->dev = dev;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2202  	jpeg->mode = mode;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2203  
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2204  	/* Get clocks */
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2205  	jpeg->clk_ipg = devm_clk_get(dev, "ipg");
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2206  	if (IS_ERR(jpeg->clk_ipg)) {
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2207  		dev_err(dev, "failed to get clock: ipg\n");
5b304046a81eda drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c Jian Zhang         2022-06-20  2208  		ret = PTR_ERR(jpeg->clk_ipg);
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2209  		goto err_clk;
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2210  	}
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2211  
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2212  	jpeg->clk_per = devm_clk_get(dev, "per");
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2213  	if (IS_ERR(jpeg->clk_per)) {
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2214  		dev_err(dev, "failed to get clock: per\n");
5b304046a81eda drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c Jian Zhang         2022-06-20  2215  		ret = PTR_ERR(jpeg->clk_per);
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2216  		goto err_clk;
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2217  	}
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2218  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2219  	ret = mxc_jpeg_attach_pm_domains(jpeg);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2220  	if (ret < 0) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2221  		dev_err(dev, "failed to attach power domains %d\n", ret);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11 @2222  		return ret;

Direct return mixed into the middle of a bunch do nothing gotos...
Probably change "goto err_clk" and "goto err_irq" to direct returns?

2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2223  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2224  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2225  	/* v4l2 */
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2226  	ret = v4l2_device_register(dev, &jpeg->v4l2_dev);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2227  	if (ret) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2228  		dev_err(dev, "failed to register v4l2 device\n");
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2229  		goto err_register;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2230  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2231  	jpeg->m2m_dev = v4l2_m2m_init(&mxc_jpeg_m2m_ops);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2232  	if (IS_ERR(jpeg->m2m_dev)) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2233  		dev_err(dev, "failed to register v4l2 device\n");
fb3b597abdcec8 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Wei Yongjun        2021-03-23  2234  		ret = PTR_ERR(jpeg->m2m_dev);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2235  		goto err_m2m;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2236  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2237  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2238  	jpeg->dec_vdev = video_device_alloc();
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2239  	if (!jpeg->dec_vdev) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2240  		dev_err(dev, "failed to register v4l2 device\n");
fb3b597abdcec8 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Wei Yongjun        2021-03-23  2241  		ret = -ENOMEM;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2242  		goto err_vdev_alloc;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2243  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2244  	if (mode == MXC_JPEG_ENCODE)
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2245  		snprintf(jpeg->dec_vdev->name,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2246  			 sizeof(jpeg->dec_vdev->name),
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2247  			 "%s-enc", MXC_JPEG_NAME);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2248  	else
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2249  		snprintf(jpeg->dec_vdev->name,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2250  			 sizeof(jpeg->dec_vdev->name),
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2251  			 "%s-dec", MXC_JPEG_NAME);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2252  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2253  	jpeg->dec_vdev->fops = &mxc_jpeg_fops;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2254  	jpeg->dec_vdev->ioctl_ops = &mxc_jpeg_ioctl_ops;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2255  	jpeg->dec_vdev->minor = -1;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2256  	jpeg->dec_vdev->release = video_device_release;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2257  	jpeg->dec_vdev->lock = &jpeg->lock; /* lock for ioctl serialization */
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2258  	jpeg->dec_vdev->v4l2_dev = &jpeg->v4l2_dev;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2259  	jpeg->dec_vdev->vfl_dir = VFL_DIR_M2M;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2260  	jpeg->dec_vdev->device_caps = V4L2_CAP_STREAMING |
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2261  					V4L2_CAP_VIDEO_M2M_MPLANE;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2262  	if (mode == MXC_JPEG_ENCODE) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2263  		v4l2_disable_ioctl(jpeg->dec_vdev, VIDIOC_DECODER_CMD);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2264  		v4l2_disable_ioctl(jpeg->dec_vdev, VIDIOC_TRY_DECODER_CMD);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2265  	} else {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2266  		v4l2_disable_ioctl(jpeg->dec_vdev, VIDIOC_ENCODER_CMD);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2267  		v4l2_disable_ioctl(jpeg->dec_vdev, VIDIOC_TRY_ENCODER_CMD);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2268  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2269  	ret = video_register_device(jpeg->dec_vdev, VFL_TYPE_VIDEO, -1);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2270  	if (ret) {
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2271  		dev_err(dev, "failed to register video device\n");
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2272  		goto err_vdev_register;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2273  	}
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2274  	video_set_drvdata(jpeg->dec_vdev, jpeg);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2275  	if (mode == MXC_JPEG_ENCODE)
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2276  		v4l2_info(&jpeg->v4l2_dev,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2277  			  "encoder device registered as /dev/video%d (%d,%d)\n",
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2278  			  jpeg->dec_vdev->num, VIDEO_MAJOR,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2279  			  jpeg->dec_vdev->minor);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2280  	else
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2281  		v4l2_info(&jpeg->v4l2_dev,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2282  			  "decoder device registered as /dev/video%d (%d,%d)\n",
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2283  			  jpeg->dec_vdev->num, VIDEO_MAJOR,
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2284  			  jpeg->dec_vdev->minor);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2285  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2286  	platform_set_drvdata(pdev, jpeg);
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2287  	pm_runtime_enable(dev);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2288  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2289  	return 0;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2290  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2291  err_vdev_register:
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2292  	video_device_release(jpeg->dec_vdev);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2293  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2294  err_vdev_alloc:
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2295  	v4l2_m2m_release(jpeg->m2m_dev);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2296  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2297  err_m2m:
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2298  	v4l2_device_unregister(&jpeg->v4l2_dev);
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2299  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2300  err_register:
5c47dc6657543b drivers/media/platform/imx-jpeg/mxc-jpeg.c     Christophe JAILLET 2021-08-21  2301  	mxc_jpeg_detach_pm_domains(jpeg);
5c47dc6657543b drivers/media/platform/imx-jpeg/mxc-jpeg.c     Christophe JAILLET 2021-08-21  2302  
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2303  err_irq:
4c2e5156d9fa63 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-10-07  2304  err_clk:
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2305  	return ret;
2db16c6ed72ce6 drivers/media/platform/imx-jpeg/mxc-jpeg.c     Mirela Rabulea     2021-03-11  2306  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

