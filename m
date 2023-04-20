Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD56E8FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjDTKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjDTKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:19:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71E5FEE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:18:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f939bea9ebso431368f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985889; x=1684577889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pw9A5+zsiMect2+0K0DcF9fBy0AzZZUeAaf+XrZGrao=;
        b=afy9EH6s0rirq7SWDYgJL6ui/k2P9RqWy9PbaDYLOo1XZtV1GwOZ5hsqOcX8Jjj+s3
         I6B9XMrvxHZ7q/Hj4mqiA7aU2GFfJphWAJrcGR470JSGI8mcQvX5b5RPjOjBmY8nPcK3
         hYWoc+AOheBDuCSiD2hZRVKQVk+AAa+p2w+qc4ctGyHYKSQtpTz280CCiNTTC6kqKT6Q
         0Zt/XXkganHv//YTDvErdJMcPv70hgvzmrwxyr7UHgaN46Ki9PiaPPuN/f5IBdo9ovgN
         7tAQn2xVjknqRH9dV9q+6M7CZDLxq1HFMbfRcrlrkOy3Mr6blSpgAnT3X//GUKC6nyJg
         IfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985889; x=1684577889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw9A5+zsiMect2+0K0DcF9fBy0AzZZUeAaf+XrZGrao=;
        b=XBP3JiqJqut2rKj5eJEhyN1NDDwqRrEytrbRUvric77d1jFAlUkxxIGCBhq2O4qNDn
         EjWb2nUJ6JOihI7lmq+2TaObEz9/yfeNJ8snUBhHiG19/TN55ingFaWmqrApjPdgKW0s
         12Mk9aKliSvhOp0YXMZow1+zmhlEN1XEBirC9a3m0TkNsXdyrhFuRG+nVvhFNBCH8hj3
         w82IrNCcGSDIOUTBODrigsIVZ+0mBRTNZ+/VDFLq3m1eJ8+JETXkZ72FaHxX1PJ0hC/5
         0G7+hpy0x9tWwQYhrWlE1nLLoD3nlbONSso6RIFdnmjE0FpRMCVQJ6Wi4bWbZJdoXXXG
         MSHA==
X-Gm-Message-State: AAQBX9cxltJnD0FZMKrBT7hnE4Y8S8AjY2qwCew5UoZIVWHQqP2Loqeo
        GZqjgmwsOSXquzkydrXxtvKFFw==
X-Google-Smtp-Source: AKy350aJN3ko2EWo+eWfwj+J89HRyw/epA6v2yJ4NbXNS8KwuC16UQVRPDOQLerGiLr2myJzPATEWg==
X-Received: by 2002:adf:efca:0:b0:2f5:5538:2589 with SMTP id i10-20020adfefca000000b002f555382589mr962090wrp.31.1681985889335;
        Thu, 20 Apr 2023 03:18:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w23-20020a05600c099700b003f17af4c4e0sm4925611wmp.9.2023.04.20.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:18:08 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:18:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Sumit Gupta <sumitg@nvidia.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: drivers/soc/tegra/cbb/tegra-cbb.c:96 tegra_cbb_err_debugfs_init()
 warn: passing zero to 'PTR_ERR'
Message-ID: <531e22c6-39e8-4a39-a190-c752c4d146be@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb0856346a60fe3eb837ba5e73588a41f81ac05f
commit: b7134422146692e096e807751656fc58ee1a717d soc/tegra: cbb: Add CBB 1.0 driver for Tegra194
config: arm64-randconfig-m041-20230419 (https://download.01.org/0day-ci/archive/20230420/202304201719.AnFYgA2p-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304201719.AnFYgA2p-lkp@intel.com/

smatch warnings:
drivers/soc/tegra/cbb/tegra-cbb.c:96 tegra_cbb_err_debugfs_init() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +96 drivers/soc/tegra/cbb/tegra-cbb.c

b7134422146692 Sumit Gupta 2022-05-12   88  static int tegra_cbb_err_debugfs_init(struct tegra_cbb *cbb)
b7134422146692 Sumit Gupta 2022-05-12   89  {
b7134422146692 Sumit Gupta 2022-05-12   90  	static struct dentry *root;
b7134422146692 Sumit Gupta 2022-05-12   91  
b7134422146692 Sumit Gupta 2022-05-12   92  	if (!root) {
b7134422146692 Sumit Gupta 2022-05-12   93  		root = debugfs_create_file("tegra_cbb_err", 0444, NULL, cbb, &tegra_cbb_err_fops);
b7134422146692 Sumit Gupta 2022-05-12   94  		if (IS_ERR_OR_NULL(root)) {
b7134422146692 Sumit Gupta 2022-05-12   95  			pr_err("%s(): could not create debugfs node\n", __func__);
b7134422146692 Sumit Gupta 2022-05-12  @96  			return PTR_ERR(root);
b7134422146692 Sumit Gupta 2022-05-12   97  		}
b7134422146692 Sumit Gupta 2022-05-12   98  	}
b7134422146692 Sumit Gupta 2022-05-12   99  
b7134422146692 Sumit Gupta 2022-05-12  100  	return 0;

Debugfs stopped returning NULL years ago.  Debugfs is weird, it's not
supposed to be checked for errors.  So the correct way to write this
is:

static void tegra_cbb_err_debugfs_init(struct tegra_cbb *cbb)
{
	static struct dentry *root;

	if (!root)
		root = debugfs_create_file("tegra_cbb_err", 0444, NULL, cbb, &tegra_cbb_err_fops);
}

regards,
dan carpenter

b7134422146692 Sumit Gupta 2022-05-12  101  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

