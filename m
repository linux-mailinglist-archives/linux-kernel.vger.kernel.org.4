Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69A46424F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLEIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiLEIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:45:15 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CED17A80;
        Mon,  5 Dec 2022 00:45:09 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 278291D08;
        Mon,  5 Dec 2022 09:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670229907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeNUztr539lKtOjkDPJXHLKWIhr1Ln9xNj0gAvIEWDo=;
        b=eHZzTkjLqogN3gV+suNRQjDiUzrbDtAegwFaGE9CWtjjDwHwqA6R0T/yPkZuyydQsyQmOS
        A0qoInVVcZjZcYD1VZ0g70g5BBpzn6bltAiuiJxdpf1aYZn1AQbZWSe3qjPyhpeQ4xkjS/
        R8Ubc+u0vEqS3IFdUI7aW54GIDZVLJq6M9Gr9/u6DjJ09F+yjX+I3WxEXSjVybJubCMPGE
        QpgpAxE2vfKByyc94cIM+TdRjnok7NEwt73SzoQODdwgAsJeCugfKdCY2R/rv8KhB0z3Cb
        56haCMLnp+xHRagVQPnOBvmgaMCPR5M8NZ09lNNoCgV6fVFv2CsHf4bOC4tX6A==
MIME-Version: 1.0
Date:   Mon, 05 Dec 2022 09:45:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 10/20] nvmem: core: use nvmem_add_one_cell() in
 nvmem_add_cells_from_of()
In-Reply-To: <202212030011.DQpDmsBb-lkp@intel.com>
References: <202212030011.DQpDmsBb-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a14ed4423ad9f0ce7bd931b33fd94810@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-12-03 09:30, schrieb Dan Carpenter:
> Hi Michael,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:
> https://github.com/intel-lab-lkp/linux/commits/Michael-Walle/nvmem-core-introduce-NVMEM-layouts/20221124-020554
> patch link:
> https://lore.kernel.org/r/20221123180151.2160033-11-michael%40walle.cc
> patch subject: [PATCH v4 10/20] nvmem: core: use nvmem_add_one_cell()
> in nvmem_add_cells_from_of()
> config: i386-randconfig-m021
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> New smatch warnings:
> drivers/nvmem/core.c:731 nvmem_add_cells_from_of() warn: possible
> memory leak of 'cell'
> 
> Old smatch warnings:
> drivers/nvmem/core.c:735 nvmem_add_cells_from_of() warn: possible
> memory leak of 'cell'
> 
> vim +/cell +731 drivers/nvmem/core.c
> 
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  689  static int
> nvmem_add_cells_from_of(struct nvmem_device *nvmem)
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  690  {
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  691  	struct device
> *dev = &nvmem->dev;
> 7ae6478b304bc0 Srinivas Kandagatla 2021-10-13  692  	struct
> nvmem_cell_entry *cell;
> 18f50dbcfd3676 Michael Walle       2022-11-23  693  	struct device_node 
> *child;
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  694  	const __be32 
> *addr;
> 18f50dbcfd3676 Michael Walle       2022-11-23  695  	int len, ret;
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  696
> 18f50dbcfd3676 Michael Walle       2022-11-23  697
> 	for_each_child_of_node(dev->of_node, child) {
> 18f50dbcfd3676 Michael Walle       2022-11-23  698  		struct
> nvmem_cell_info info = {0};
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  699
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  700  		addr =
> of_get_property(child, "reg", &len);
> 0445efacec75b8 Ahmad Fatoum        2021-01-29  701  		if (!addr)
> 0445efacec75b8 Ahmad Fatoum        2021-01-29  702  			continue;
> 0445efacec75b8 Ahmad Fatoum        2021-01-29  703  		if (len < 2 *
> sizeof(u32)) {
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  704  			dev_err(dev,
> "nvmem: invalid reg on %pOF\n", child);
> 63879e2964bcee Christophe JAILLET  2021-06-11  705  
> 			of_node_put(child);
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  706  			return -EINVAL;
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  707  		}
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  708
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  709  		cell =
> kzalloc(sizeof(*cell), GFP_KERNEL);
> 63879e2964bcee Christophe JAILLET  2021-06-11  710  		if (!cell) {
> 63879e2964bcee Christophe JAILLET  2021-06-11  711  
> 			of_node_put(child);
> e888d445ac33a5 Bartosz Golaszewski 2018-09-21  712  			return -ENOMEM;
> 63879e2964bcee Christophe JAILLET  2021-06-11  713  		}
> 
> Seems like "cell" is not used any more so this just leaks.

Damn, what a stupid bug from me. Thanks for catching this.

-michael
