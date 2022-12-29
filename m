Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA0658AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiL2JD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2JD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:03:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84134EE3C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:03:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so15949833wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyVj5LH9lc5R7wzNC99DEtW9gJWq26S+ydaJBYHa66c=;
        b=nGnryUSoryGomgt8nHGcoY/0pJl0caVqvvbqMPzzGDGTcTNSbbwVU+7W/FOZV90bWA
         v864xgLGdYW27y8DZP2glw5LAoTKmcS5y3VGAj33ND7LZUR6koghisanQh5IZlCFl+RC
         ChzvwWqGnavPa3parvcjuPq1Qm8jCxCmky1LTh+9NOaGFaWrfhVV4OTvxFfOBHZAXlH4
         49vqIOoneLJbY9d6NTZIPr86zU5Iw/Hw5F+C/9ys+tYVAH/ayM+HuTdJajltHgMHmyEN
         IKh4sqeWtV3SXNxi/UWyA8N72B3GNbJfoksAs1gsnUDbTkMRl4N3HzxIBPWn54Elcp95
         tpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyVj5LH9lc5R7wzNC99DEtW9gJWq26S+ydaJBYHa66c=;
        b=oG62uDvwDPM7U9SO2wX40uHu/7S8lVNowdu+zh4k+tdL7oPQ6CDoG5a4U7sHWp5XmO
         fgrW5HTWaUt/u/wS3hTXH6A4V6jUhHbxa4Zl1AV1fRx9bASk2vxz6gCUSWvzW6ZPWez/
         /ij7yXlDDR4yu4wk5laRgl21WxX681FREKHj1dhWbFbgaWah/sTi1uhdcRfffupKRjcF
         h1xSrQIGUjiNGWXBjlayA8Vqz+fj4zEdHl14btSsfXLmkeCu1YmUsvAVMjRhTiwpgxBT
         pk/XfsnsGz34fzotT2I8V23/KFefzCXFE/Ig/EskiiCcAHfYJSde9KZvQw+YzVloNsdv
         9aog==
X-Gm-Message-State: AFqh2kp4bGk7+SIhFcvi3V2heCnLG+hbDiogSd4UgUM/IDIcce1AB1pJ
        67nzaJpvJdWMptYXFsdJAno=
X-Google-Smtp-Source: AMrXdXtpIqODpEHgej6L6Xp74mVfUhUn6G+xqzefJBC8ogeI1b5Wkv7e8GwxqwDQ/Mw4b4+1nVCM5Q==
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr22620882wmq.5.1672304634048;
        Thu, 29 Dec 2022 01:03:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003c70191f267sm30321247wmc.39.2022.12.29.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:03:53 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:03:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling
 ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
Message-ID: <202212290454.KjkzaEzK-lkp@intel.com>
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
head:   1b929c02afd37871d5afb9d498426f83432e71c2
commit: 24afc15dbe218f860994f627b4ba1fb09225a298 block/rnbd: Remove a useless mutex
config: powerpc-randconfig-m031-20221226
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?

vim +/max +1460 drivers/block/rnbd/rnbd-clt.c

f7a7a5c228d45e Jack Wang          2020-05-11  1436  static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
f7a7a5c228d45e Jack Wang          2020-05-11  1437  				      enum rnbd_access_mode access_mode,
2958a995edc946 Gioh Kim           2021-04-19  1438  				      const char *pathname,
2958a995edc946 Gioh Kim           2021-04-19  1439  				      u32 nr_poll_queues)
f7a7a5c228d45e Jack Wang          2020-05-11  1440  {
f7a7a5c228d45e Jack Wang          2020-05-11  1441  	struct rnbd_clt_dev *dev;
f7a7a5c228d45e Jack Wang          2020-05-11  1442  	int ret;
f7a7a5c228d45e Jack Wang          2020-05-11  1443  
f7a7a5c228d45e Jack Wang          2020-05-11  1444  	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, NUMA_NO_NODE);
f7a7a5c228d45e Jack Wang          2020-05-11  1445  	if (!dev)
f7a7a5c228d45e Jack Wang          2020-05-11  1446  		return ERR_PTR(-ENOMEM);
f7a7a5c228d45e Jack Wang          2020-05-11  1447  
2958a995edc946 Gioh Kim           2021-04-19  1448  	/*
2958a995edc946 Gioh Kim           2021-04-19  1449  	 * nr_cpu_ids: the number of softirq queues
2958a995edc946 Gioh Kim           2021-04-19  1450  	 * nr_poll_queues: the number of polling queues
2958a995edc946 Gioh Kim           2021-04-19  1451  	 */
2958a995edc946 Gioh Kim           2021-04-19  1452  	dev->hw_queues = kcalloc(nr_cpu_ids + nr_poll_queues,
2958a995edc946 Gioh Kim           2021-04-19  1453  				 sizeof(*dev->hw_queues),
f7a7a5c228d45e Jack Wang          2020-05-11  1454  				 GFP_KERNEL);
f7a7a5c228d45e Jack Wang          2020-05-11  1455  	if (!dev->hw_queues) {
f7a7a5c228d45e Jack Wang          2020-05-11  1456  		ret = -ENOMEM;
f7a7a5c228d45e Jack Wang          2020-05-11  1457  		goto out_alloc;
f7a7a5c228d45e Jack Wang          2020-05-11  1458  	}
f7a7a5c228d45e Jack Wang          2020-05-11  1459  
24afc15dbe218f Christophe JAILLET 2022-02-07 @1460  	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
You wrote this Smatch check...  But, this should probably be
(1 << (MINORBITS - RNBD_PART_BITS)) - 1, yeah?

f7a7a5c228d45e Jack Wang          2020-05-11  1461  			    GFP_KERNEL);
f7a7a5c228d45e Jack Wang          2020-05-11  1462  	if (ret < 0) {
f7a7a5c228d45e Jack Wang          2020-05-11  1463  		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
f7a7a5c228d45e Jack Wang          2020-05-11  1464  		       pathname, sess->sessname, ret);
f7a7a5c228d45e Jack Wang          2020-05-11  1465  		goto out_queues;
f7a7a5c228d45e Jack Wang          2020-05-11  1466  	}
64e8a6ece1a5b1 Md Haris Iqbal     2020-11-26  1467  
e7508d48565060 Md Haris Iqbal     2020-12-10  1468  	dev->pathname = kstrdup(pathname, GFP_KERNEL);
64e8a6ece1a5b1 Md Haris Iqbal     2020-11-26  1469  	if (!dev->pathname) {
64e8a6ece1a5b1 Md Haris Iqbal     2020-11-26  1470  		ret = -ENOMEM;
64e8a6ece1a5b1 Md Haris Iqbal     2020-11-26  1471  		goto out_queues;
64e8a6ece1a5b1 Md Haris Iqbal     2020-11-26  1472  	}
64e8a6ece1a5b1 Md Haris Iqbal     2020-11-26  1473  
f7a7a5c228d45e Jack Wang          2020-05-11  1474  	dev->clt_device_id	= ret;
f7a7a5c228d45e Jack Wang          2020-05-11  1475  	dev->sess		= sess;
f7a7a5c228d45e Jack Wang          2020-05-11  1476  	dev->access_mode	= access_mode;
2958a995edc946 Gioh Kim           2021-04-19  1477  	dev->nr_poll_queues	= nr_poll_queues;
f7a7a5c228d45e Jack Wang          2020-05-11  1478  	mutex_init(&dev->lock);
f7a7a5c228d45e Jack Wang          2020-05-11  1479  	refcount_set(&dev->refcount, 1);
f7a7a5c228d45e Jack Wang          2020-05-11  1480  	dev->dev_state = DEV_STATE_INIT;
f7a7a5c228d45e Jack Wang          2020-05-11  1481  
f7a7a5c228d45e Jack Wang          2020-05-11  1482  	/*
f7a7a5c228d45e Jack Wang          2020-05-11  1483  	 * Here we called from sysfs entry, thus clt-sysfs is
f7a7a5c228d45e Jack Wang          2020-05-11  1484  	 * responsible that session will not disappear.
f7a7a5c228d45e Jack Wang          2020-05-11  1485  	 */
f7a7a5c228d45e Jack Wang          2020-05-11  1486  	WARN_ON(!rnbd_clt_get_sess(sess));
f7a7a5c228d45e Jack Wang          2020-05-11  1487  
f7a7a5c228d45e Jack Wang          2020-05-11  1488  	return dev;
f7a7a5c228d45e Jack Wang          2020-05-11  1489  
f7a7a5c228d45e Jack Wang          2020-05-11  1490  out_queues:
f7a7a5c228d45e Jack Wang          2020-05-11  1491  	kfree(dev->hw_queues);
f7a7a5c228d45e Jack Wang          2020-05-11  1492  out_alloc:
f7a7a5c228d45e Jack Wang          2020-05-11  1493  	kfree(dev);
f7a7a5c228d45e Jack Wang          2020-05-11  1494  	return ERR_PTR(ret);
f7a7a5c228d45e Jack Wang          2020-05-11  1495  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

