Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB496414F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiLCIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 03:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLCIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 03:31:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9B55A8D;
        Sat,  3 Dec 2022 00:31:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f18so11264244wrj.5;
        Sat, 03 Dec 2022 00:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NKv/juivSPtw+aSJEGk+J2nIXdK+8epwWiah37thoY=;
        b=UlVTP+QiJPPdoGqx7EM454TEl2WZS4s66zkACqW1nk2OToEU3frEbgcS1U7zlTlZ26
         byYXR6wJx1BwrdURsOkZfKYPtn9vTnaAGQKCImcJ6Xjdu3qhDN8YZiKYZeYdTbMcWLlR
         dWQgcMd764cSA/m5ARIsVuz/81E3zt8uP+1L7rMyPOfxVGml56uPe4nv5VanIfVNn0KG
         xIdC4KAGYt4dLbsSJJBSbte9odteS+wAbiOciZuRuA77/rPc1Q2up1WUoPJuQcSwKzC+
         dW+HyL0icWQA4+ZiIwpK8Z9rLjVlr4JVyYfyodNT4R16ffd7EQWe6JbbrR+KTzvjTI1g
         8BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NKv/juivSPtw+aSJEGk+J2nIXdK+8epwWiah37thoY=;
        b=zzrcRioz11WvpOYg9x+E3yIl4NlHM36/VWotA1EhKYuoISKHxZNDqc5FBSkeaCdpAD
         M4JQp2FG8Z4hH/0m0aAc4tbOqqCeFBuSf//2raoE1cxjdAmdmN42GJfs3/robohp3Wui
         Fz7tQ1VesoaIl9l4n8OcDeJPCgm8tvWV7uS37hWSkyAKWBirvGWzjPLJMEeXWTGUNxRO
         U8NatWnubXd/qdceqF1+Hc5WVNiiKtXzVUKkMsoJ7l0u1JCs1PClwfbprfX3xplv9X9+
         H2is+qvwQwtB/kKn05QYEk3ughbFgg82LyQ3fb5RTqN5wx7pwnW/R17KTSwmN2fga8up
         dbNQ==
X-Gm-Message-State: ANoB5pkkb+SROAx5xO9z/aWf+oWXJYbT1uZ/AmriA8XPZFWwlyZuR6pS
        xcSu6qekGeYSXbu33gRnBbU=
X-Google-Smtp-Source: AA0mqf62BdI2xnqr2YWZgf8DeQsDV3h1bynzlzvldMbkq4bFo4a8TdN2KNYSngbjVCxn59mZWwm2cQ==
X-Received: by 2002:a5d:59c5:0:b0:241:e4cf:30d9 with SMTP id v5-20020a5d59c5000000b00241e4cf30d9mr18546698wry.186.1670056258593;
        Sat, 03 Dec 2022 00:30:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm8745910wrw.105.2022.12.03.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 00:30:58 -0800 (PST)
Date:   Sat, 3 Dec 2022 11:30:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Michael Walle <michael@walle.cc>,
        Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 10/20] nvmem: core: use nvmem_add_one_cell() in
 nvmem_add_cells_from_of()
Message-ID: <202212030011.DQpDmsBb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123180151.2160033-11-michael@walle.cc>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Walle/nvmem-core-introduce-NVMEM-layouts/20221124-020554
patch link:    https://lore.kernel.org/r/20221123180151.2160033-11-michael%40walle.cc
patch subject: [PATCH v4 10/20] nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
config: i386-randconfig-m021
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/nvmem/core.c:731 nvmem_add_cells_from_of() warn: possible memory leak of 'cell'

Old smatch warnings:
drivers/nvmem/core.c:735 nvmem_add_cells_from_of() warn: possible memory leak of 'cell'

vim +/cell +731 drivers/nvmem/core.c

e888d445ac33a5 Bartosz Golaszewski 2018-09-21  689  static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  690  {
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  691  	struct device *dev = &nvmem->dev;
7ae6478b304bc0 Srinivas Kandagatla 2021-10-13  692  	struct nvmem_cell_entry *cell;
18f50dbcfd3676 Michael Walle       2022-11-23  693  	struct device_node *child;
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  694  	const __be32 *addr;
18f50dbcfd3676 Michael Walle       2022-11-23  695  	int len, ret;
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  696  
18f50dbcfd3676 Michael Walle       2022-11-23  697  	for_each_child_of_node(dev->of_node, child) {
18f50dbcfd3676 Michael Walle       2022-11-23  698  		struct nvmem_cell_info info = {0};
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  699  
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  700  		addr = of_get_property(child, "reg", &len);
0445efacec75b8 Ahmad Fatoum        2021-01-29  701  		if (!addr)
0445efacec75b8 Ahmad Fatoum        2021-01-29  702  			continue;
0445efacec75b8 Ahmad Fatoum        2021-01-29  703  		if (len < 2 * sizeof(u32)) {
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  704  			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
63879e2964bcee Christophe JAILLET  2021-06-11  705  			of_node_put(child);
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  706  			return -EINVAL;
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  707  		}
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  708  
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  709  		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
63879e2964bcee Christophe JAILLET  2021-06-11  710  		if (!cell) {
63879e2964bcee Christophe JAILLET  2021-06-11  711  			of_node_put(child);
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  712  			return -ENOMEM;
63879e2964bcee Christophe JAILLET  2021-06-11  713  		}

Seems like "cell" is not used any more so this just leaks.

e888d445ac33a5 Bartosz Golaszewski 2018-09-21  714  
18f50dbcfd3676 Michael Walle       2022-11-23  715  		info.offset = be32_to_cpup(addr++);
18f50dbcfd3676 Michael Walle       2022-11-23  716  		info.bytes = be32_to_cpup(addr);
18f50dbcfd3676 Michael Walle       2022-11-23  717  		info.name = kasprintf(GFP_KERNEL, "%pOFn", child);
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  718  
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  719  		addr = of_get_property(child, "bits", &len);
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  720  		if (addr && len == (2 * sizeof(u32))) {
18f50dbcfd3676 Michael Walle       2022-11-23  721  			info.bit_offset = be32_to_cpup(addr++);
18f50dbcfd3676 Michael Walle       2022-11-23  722  			info.nbits = be32_to_cpup(addr);
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  723  		}
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  724  
18f50dbcfd3676 Michael Walle       2022-11-23  725  		info.np = of_node_get(child);
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  726  
18f50dbcfd3676 Michael Walle       2022-11-23  727  		ret = nvmem_add_one_cell(nvmem, &info);
18f50dbcfd3676 Michael Walle       2022-11-23  728  		kfree(info.name);
18f50dbcfd3676 Michael Walle       2022-11-23  729  		if (ret) {
63879e2964bcee Christophe JAILLET  2021-06-11  730  			of_node_put(child);
18f50dbcfd3676 Michael Walle       2022-11-23 @731  			return ret;
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  732  		}
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  733  	}
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  734  
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  735  	return 0;
e888d445ac33a5 Bartosz Golaszewski 2018-09-21  736  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

