Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A079564996D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLLHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiLLHSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:18:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF67959D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:18:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r7-20020a1c4407000000b003d1e906ca23so3169896wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGxqg8TZMm49g0BWiI/JXtvuwzx1eHJNjb217uwEws0=;
        b=MG7fTijioGJwLqIRHKuW4dg+pgoJ+nnHKoIkqAHK6NPXqcyRbgHrImwu7B5+6p55G1
         UUuQ6AYO/4mjh8OdtYl336Qd4xQb1yfrIvZetGDzjhfB/MEIatjlzdupITduC8EdlYNK
         EPhH0y/6rvBA1VMbK+9Wqn0X5ZsELOhK7LqLxd6WldzmzQEG54KT7H/hgPOXH5tHpUmE
         a3X6lq97n55FD0CqdrmvH210yvUV62ReHSaBCbx3Y0ojdYDoCMAayP6OXQgZvXcENUBV
         h9lEfuYqx9+nDJyvwxbdEnbRSZsMG++EfNy8fkR/xWthxTUWzn6f2HEAldCVyCbEnN5E
         rbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGxqg8TZMm49g0BWiI/JXtvuwzx1eHJNjb217uwEws0=;
        b=Iq/KFzhrcgOua+2iPw7vgu9WmXdT+I8ZCvNkrj9shiSj4G3ezjjWqLkHZ5fCCTTTtG
         4knIDKE03ZJ4FrkbdUYT6f+QIZFzdvpVLiMpgYDHYBOdo+exz81v96mr+k9c93jKOYC5
         pwchQwKAwDaE++JxRcbmLBuRO5bjJP4yoUf79QkGTsLHhTS6EBUD3EwPB2re6ebCoOvu
         58i+ix2w8oDeFvamo9Se3IPyWo395b89Ir8mA6Le7QN5ZxpjEJn/NamrYx4Yx8kmmTsv
         H8yJ5DQT5iCFnDJxehjEcCmjv5w1FTDi9VQ/rZbes9E+t9pqdSlcBoSYkd+tK2caTOQ6
         nbdA==
X-Gm-Message-State: ANoB5pmqyv7Fvtlv14H/Kn6PC4k9NUHC4zl6OrH0LUz4DHRTt/osdtM7
        ngpN7iznnx9kgz9uXm5D1/Q=
X-Google-Smtp-Source: AA0mqf4qq7F1ik15fn539LwTAU5HkbgFDOb7ZdOnJBk6uNs/JbSjxrsJ1g1G2HHN6ej2JQcZeVKo/A==
X-Received: by 2002:a05:600c:35d3:b0:3c6:e63e:22e with SMTP id r19-20020a05600c35d300b003c6e63e022emr11630271wmq.5.1670829487954;
        Sun, 11 Dec 2022 23:18:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c359100b003c6b7f5567csm24600951wmq.0.2022.12.11.23.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 23:18:07 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:18:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Felix Fietkau <nbd@nbd.name>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mediatek/mtk_wed_debugfs.c:73 dump_wed_regs()
 error: uninitialized symbol 'val'.
Message-ID: <202212110120.ZqvaZrGs-lkp@intel.com>
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
head:   3ecc37918c80ffdbfa8f08d3e75a0a9fca1c1979
commit: 804775dfc2885e93a0a4b35db1914c2cc25172b5 net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)
config: openrisc-randconfig-m031-20221210
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/net/ethernet/mediatek/mtk_wed_debugfs.c:73 dump_wed_regs() error: uninitialized symbol 'val'.

vim +/val +73 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c

804775dfc2885e Felix Fietkau 2022-04-05  46  static void
804775dfc2885e Felix Fietkau 2022-04-05  47  dump_wed_regs(struct seq_file *s, struct mtk_wed_device *dev,
804775dfc2885e Felix Fietkau 2022-04-05  48  	      const struct reg_dump *regs, int n_regs)
804775dfc2885e Felix Fietkau 2022-04-05  49  {
804775dfc2885e Felix Fietkau 2022-04-05  50  	const struct reg_dump *cur;
804775dfc2885e Felix Fietkau 2022-04-05  51  	u32 val;
804775dfc2885e Felix Fietkau 2022-04-05  52  
804775dfc2885e Felix Fietkau 2022-04-05  53  	for (cur = regs; cur < &regs[n_regs]; cur++) {
804775dfc2885e Felix Fietkau 2022-04-05  54  		switch (cur->type) {
804775dfc2885e Felix Fietkau 2022-04-05  55  		case DUMP_TYPE_STRING:
804775dfc2885e Felix Fietkau 2022-04-05  56  			seq_printf(s, "%s======== %s:\n",
804775dfc2885e Felix Fietkau 2022-04-05  57  				   cur > regs ? "\n" : "",
804775dfc2885e Felix Fietkau 2022-04-05  58  				   cur->name);
804775dfc2885e Felix Fietkau 2022-04-05  59  			continue;
804775dfc2885e Felix Fietkau 2022-04-05  60  		case DUMP_TYPE_WED:
804775dfc2885e Felix Fietkau 2022-04-05  61  			val = wed_r32(dev, cur->offset);
804775dfc2885e Felix Fietkau 2022-04-05  62  			break;
804775dfc2885e Felix Fietkau 2022-04-05  63  		case DUMP_TYPE_WDMA:
804775dfc2885e Felix Fietkau 2022-04-05  64  			val = wdma_r32(dev, cur->offset);
804775dfc2885e Felix Fietkau 2022-04-05  65  			break;
804775dfc2885e Felix Fietkau 2022-04-05  66  		case DUMP_TYPE_WPDMA_TX:
804775dfc2885e Felix Fietkau 2022-04-05  67  			val = wpdma_tx_r32(dev, cur->base, cur->offset);
804775dfc2885e Felix Fietkau 2022-04-05  68  			break;
804775dfc2885e Felix Fietkau 2022-04-05  69  		case DUMP_TYPE_WPDMA_TXFREE:
804775dfc2885e Felix Fietkau 2022-04-05  70  			val = wpdma_txfree_r32(dev, cur->offset);
804775dfc2885e Felix Fietkau 2022-04-05  71  			break;

There are no DUMP_TYPE_WPDMA_RX and DUMP_TYPE_WED_RRO cases or a default
case.

804775dfc2885e Felix Fietkau 2022-04-05  72  		}
804775dfc2885e Felix Fietkau 2022-04-05 @73  		print_reg_val(s, cur->name, val);
804775dfc2885e Felix Fietkau 2022-04-05  74  	}
804775dfc2885e Felix Fietkau 2022-04-05  75  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

