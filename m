Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1959714383
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjE2EwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjE2Evk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:51:40 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7E49F5
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:45:10 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5148ebc4b89so3485743a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685335133; x=1687927133;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW9rXTpogXD/rMe9cbaMBiysRT/JUDf/+coLts4mkAk=;
        b=Rp5zsmuNwPkyMCEY4uXxxFzMocfa/fcighmwLZD9c7Ixn/sy9489EZUOTnRKqvD2Ku
         QKo2cLOnaB8nnkw+f+u5fwgSfxJFMc2+DUWG60m2D5QUBLKcN85kqyCotdiLJj2PJ0KX
         C7WGe+JreeVlxFzhFiWm39FnVEsFPgdeFbvSLjOjrxQhVy1IyRR21PQ90uIDrZbHoIh4
         Qgi6xiIWgA8NuWmsUl7kKzDsqKrwj+C0M82dGrRp5I/Azxsj5eB4QuFE9ZIgVs/Q97KI
         GPC6gR2zuaZzT4ZCZ9SmTBZpDggJm0Z63Ht4skUwfR5YfAvE00TJ+4TmXGntnET+z70A
         UvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685335133; x=1687927133;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PW9rXTpogXD/rMe9cbaMBiysRT/JUDf/+coLts4mkAk=;
        b=EblUdaZ/qZhS/4LeO6t6H/n3mXy0vkeWJQg6Q3mnjOhifRK7xadtqxdH/udRpKMdpX
         +isJASbJpOswp66tnPA0gayNw5aeq0+cA1gPMBpEQgPmO/SpI1PxcITQUTkTGarlINSr
         XhqrSYJaspefFpqnMLoI+1BBJNtg6h5X5wSOKsN2abpRtyVBWbf6KTtlbxxaY/lK0bIX
         TTGMx3mBnj2s2JQNkjJWi6HnvTw6jGfAKv/2wSQtzx5SxNQq+baNkOiOEF/LojLxLsvK
         srigYsu/CK1JTCowT3aQDFwSTGZjodnisFVo+dXbGv2hY/lSugzzVB3YmEJPhSe6kLgj
         Dnmw==
X-Gm-Message-State: AC+VfDyrQK7/cQj1XT4F0qizz8mbMYG9W4BjZiz2Fl2b1/TdPns4ePSC
        CjP4gybYgpFFYQf+NWc1DJY83cuB5q1KNk4oTHw=
X-Google-Smtp-Source: ACHHUZ74Ruy1qD4N//b4LHn76Hs7B/apj+Pk6hcrhVWNwYFuABqlUZ4+hycfm/BhR+5Q8FOAJN22Xw==
X-Received: by 2002:a5d:5274:0:b0:30a:ea63:855 with SMTP id l20-20020a5d5274000000b0030aea630855mr1578970wrc.31.1685334546387;
        Sun, 28 May 2023 21:29:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b0030ae4350212sm5956702wrr.66.2023.05.28.21.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 21:29:04 -0700 (PDT)
Date:   Mon, 29 May 2023 07:28:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <8c442b03-bff3-4d25-96e0-eb297e280797@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523100239.307574-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/ABI-sysfs-nvmem-cells-Expose-cells-through-sysfs/20230523-203042
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230523100239.307574-3-miquel.raynal%40bootlin.com
patch subject: [PATCH 2/2] nvmem: core: Expose cells through sysfs
config: i386-randconfig-m021-20230525 (https://download.01.org/0day-ci/archive/20230528/202305280054.NloN5RLk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305280054.NloN5RLk-lkp@intel.com/

smatch warnings:
drivers/nvmem/core.c:380 nvmem_cell_attr_read() error: uninitialized symbol 'read_len'.

vim +/read_len +380 drivers/nvmem/core.c

22c370b2163e59 Miquel Raynal       2023-05-23  328  static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
22c370b2163e59 Miquel Raynal       2023-05-23  329  					    const char *id, int index);
22c370b2163e59 Miquel Raynal       2023-05-23  330  
22c370b2163e59 Miquel Raynal       2023-05-23  331  static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
22c370b2163e59 Miquel Raynal       2023-05-23  332  				    struct bin_attribute *attr, char *buf,
22c370b2163e59 Miquel Raynal       2023-05-23  333  				    loff_t pos, size_t count)
22c370b2163e59 Miquel Raynal       2023-05-23  334  {
22c370b2163e59 Miquel Raynal       2023-05-23  335  	struct nvmem_cell_entry *entry;
22c370b2163e59 Miquel Raynal       2023-05-23  336  	struct nvmem_cell *cell = NULL;
22c370b2163e59 Miquel Raynal       2023-05-23  337  	struct nvmem_device *nvmem;
22c370b2163e59 Miquel Raynal       2023-05-23  338  	size_t cell_sz, read_len;
22c370b2163e59 Miquel Raynal       2023-05-23  339  	struct device *dev;
22c370b2163e59 Miquel Raynal       2023-05-23  340  	void *content;
22c370b2163e59 Miquel Raynal       2023-05-23  341  
22c370b2163e59 Miquel Raynal       2023-05-23  342  	if (attr->private)
22c370b2163e59 Miquel Raynal       2023-05-23  343  		dev = attr->private;
22c370b2163e59 Miquel Raynal       2023-05-23  344  	else
22c370b2163e59 Miquel Raynal       2023-05-23  345  		dev = kobj_to_dev(kobj);
22c370b2163e59 Miquel Raynal       2023-05-23  346  	nvmem = to_nvmem_device(dev);
22c370b2163e59 Miquel Raynal       2023-05-23  347  
22c370b2163e59 Miquel Raynal       2023-05-23  348  	mutex_lock(&nvmem_mutex);
22c370b2163e59 Miquel Raynal       2023-05-23  349  	list_for_each_entry(entry, &nvmem->cells, node) {
22c370b2163e59 Miquel Raynal       2023-05-23  350  		if (strncmp(entry->name, attr->attr.name, XATTR_NAME_MAX))
22c370b2163e59 Miquel Raynal       2023-05-23  351  			continue;
22c370b2163e59 Miquel Raynal       2023-05-23  352  
22c370b2163e59 Miquel Raynal       2023-05-23  353  		cell = nvmem_create_cell(entry, entry->name, 0);
22c370b2163e59 Miquel Raynal       2023-05-23  354  		if (IS_ERR(cell)) {
22c370b2163e59 Miquel Raynal       2023-05-23  355  			mutex_unlock(&nvmem_mutex);
22c370b2163e59 Miquel Raynal       2023-05-23  356  			return PTR_ERR(cell);
22c370b2163e59 Miquel Raynal       2023-05-23  357  		}
22c370b2163e59 Miquel Raynal       2023-05-23  358  
22c370b2163e59 Miquel Raynal       2023-05-23  359  		break;
22c370b2163e59 Miquel Raynal       2023-05-23  360  	}
22c370b2163e59 Miquel Raynal       2023-05-23  361  	mutex_unlock(&nvmem_mutex);
22c370b2163e59 Miquel Raynal       2023-05-23  362  
22c370b2163e59 Miquel Raynal       2023-05-23  363  	if (!cell)
22c370b2163e59 Miquel Raynal       2023-05-23  364  		return -EINVAL;
22c370b2163e59 Miquel Raynal       2023-05-23  365  
22c370b2163e59 Miquel Raynal       2023-05-23  366  	content = nvmem_cell_read(cell, &cell_sz);
22c370b2163e59 Miquel Raynal       2023-05-23  367  	if (IS_ERR(content)) {
22c370b2163e59 Miquel Raynal       2023-05-23  368  		count = PTR_ERR(content);
22c370b2163e59 Miquel Raynal       2023-05-23  369  		goto destroy_cell;

read_len not initialized on this goto path.

22c370b2163e59 Miquel Raynal       2023-05-23  370  	}
22c370b2163e59 Miquel Raynal       2023-05-23  371  
22c370b2163e59 Miquel Raynal       2023-05-23  372  	read_len = min_t(unsigned int, cell_sz - pos, count);
22c370b2163e59 Miquel Raynal       2023-05-23  373  	memcpy(buf, content + pos, read_len);
22c370b2163e59 Miquel Raynal       2023-05-23  374  	kfree(content);
22c370b2163e59 Miquel Raynal       2023-05-23  375  
22c370b2163e59 Miquel Raynal       2023-05-23  376  destroy_cell:
22c370b2163e59 Miquel Raynal       2023-05-23  377  	kfree_const(cell->id);
22c370b2163e59 Miquel Raynal       2023-05-23  378  	kfree(cell);
22c370b2163e59 Miquel Raynal       2023-05-23  379  
22c370b2163e59 Miquel Raynal       2023-05-23 @380  	return read_len;
                                                        ^^^^^^^^^^^^^^^

22c370b2163e59 Miquel Raynal       2023-05-23  381  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

