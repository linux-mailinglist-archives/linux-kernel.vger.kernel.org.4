Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C16335B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiKVHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:11:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56E30F61
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:11:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n12so33612210eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YQZ2hTVZG//Smv0UAJil8HcNjDm9fqYOaWpiHV3raQ=;
        b=RIUIkfrIA9DeE/cXt6YCUZ14WVUaMQTT10RshgDoBVM0bqyZhY99kvEX1J8x0Trsit
         V/N+2Sn3MZuIEBmwrzUYlfSA+7hF+zw0eEZbW5rsidZnFIiFV43ym5oNIoKwvwzbSrDz
         0GRG8b3K7Rw0umPsICLDwJKfgMJmZYx5Yx4+VSFJOS+EPZG1uuvzDWCeTPhackYoGC1e
         2KzqByEDOt96I19cl5znJ0yGBUgnns7qJ7bODtMLLJJnSaf/OHyU1sg285qNfiaviy7A
         /Y2aqvMBmdCxTtVbTX7SJ0phTYROtGb4Nk9bVjn+l9UhrmT8i3C3+59AfZAYGP0g7FTI
         V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YQZ2hTVZG//Smv0UAJil8HcNjDm9fqYOaWpiHV3raQ=;
        b=edC09BJ3TX+7aUFUeQenXMg7BOMJ5bSR42slCEJXbNkTctFYR/S/tYOx8D1wlti8PB
         2WPzfygcFh8Pap8JtVehgrWlZ9lx/ZfxP8EPTaCCozXBd0jz9JlpKb5anE7qrni2BMqY
         fLxeUF2jceqb/A4oXbOp9zt1TEaBlSJG/xaHpEDhL93/GnM4QdGoUn2Firj1RvpTay+i
         qh0R8fY7C+487nJDJ7MuPZvxH8QLn+UjJgHMZdiA5hIxq6oyG539Zlx56BzZfVhPDeNA
         9moaQKUBl3aN1yCo9NduLLJ42E4M+XHmQ4ig2+EbFobHj3iBitqyuB0qkREih+/MZk1X
         Y40g==
X-Gm-Message-State: ANoB5pljv0Z66sKjK7+wD0vZ0vvUefFs+FImSUpy/pcxAq4koTNAery3
        +03NYHSGtykRUZUnEU4Dg4I=
X-Google-Smtp-Source: AA0mqf7wO9QHpkg9aMg6mqgapaLMG0G1cFWqGX1z0bJ8RWlMKLSg7ZGmwTP6HdXSPNhDDLLyazCFPQ==
X-Received: by 2002:a17:906:945a:b0:7a8:3597:34a8 with SMTP id z26-20020a170906945a00b007a8359734a8mr2136771ejx.628.1669101068857;
        Mon, 21 Nov 2022 23:11:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090676d000b0077d37a5d401sm5758693ejn.33.2022.11.21.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:11:08 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:11:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>
Subject: drivers/cpuidle/cpuidle-riscv-sbi.c:506 sbi_genpd_probe() warn:
 missing error code 'ret'
Message-ID: <202211220541.Ck9NkitJ-lkp@intel.com>
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
head:   eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
commit: f81f7861ee2aaa6f652f18e8f622547bdd379724 cpuidle: riscv: support non-SMP config
date:   7 months ago
config: riscv-randconfig-m031-20221121
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/cpuidle/cpuidle-riscv-sbi.c:506 sbi_genpd_probe() warn: missing error code 'ret'

vim +/ret +506 drivers/cpuidle/cpuidle-riscv-sbi.c

6abf32f1d9c500 Anup Patel 2022-02-10  481  static int sbi_genpd_probe(struct device_node *np)
6abf32f1d9c500 Anup Patel 2022-02-10  482  {
6abf32f1d9c500 Anup Patel 2022-02-10  483  	struct device_node *node;
6abf32f1d9c500 Anup Patel 2022-02-10  484  	int ret = 0, pd_count = 0;
6abf32f1d9c500 Anup Patel 2022-02-10  485  
6abf32f1d9c500 Anup Patel 2022-02-10  486  	if (!np)
6abf32f1d9c500 Anup Patel 2022-02-10  487  		return -ENODEV;
6abf32f1d9c500 Anup Patel 2022-02-10  488  
6abf32f1d9c500 Anup Patel 2022-02-10  489  	/*
6abf32f1d9c500 Anup Patel 2022-02-10  490  	 * Parse child nodes for the "#power-domain-cells" property and
6abf32f1d9c500 Anup Patel 2022-02-10  491  	 * initialize a genpd/genpd-of-provider pair when it's found.
6abf32f1d9c500 Anup Patel 2022-02-10  492  	 */
6abf32f1d9c500 Anup Patel 2022-02-10  493  	for_each_child_of_node(np, node) {
6abf32f1d9c500 Anup Patel 2022-02-10  494  		if (!of_find_property(node, "#power-domain-cells", NULL))
6abf32f1d9c500 Anup Patel 2022-02-10  495  			continue;
6abf32f1d9c500 Anup Patel 2022-02-10  496  
6abf32f1d9c500 Anup Patel 2022-02-10  497  		ret = sbi_pd_init(node);
6abf32f1d9c500 Anup Patel 2022-02-10  498  		if (ret)
6abf32f1d9c500 Anup Patel 2022-02-10  499  			goto put_node;
6abf32f1d9c500 Anup Patel 2022-02-10  500  
6abf32f1d9c500 Anup Patel 2022-02-10  501  		pd_count++;
6abf32f1d9c500 Anup Patel 2022-02-10  502  	}
6abf32f1d9c500 Anup Patel 2022-02-10  503  
6abf32f1d9c500 Anup Patel 2022-02-10  504  	/* Bail out if not using the hierarchical CPU topology. */
6abf32f1d9c500 Anup Patel 2022-02-10  505  	if (!pd_count)
6abf32f1d9c500 Anup Patel 2022-02-10 @506  		goto no_pd;

Error code?

6abf32f1d9c500 Anup Patel 2022-02-10  507  
6abf32f1d9c500 Anup Patel 2022-02-10  508  	/* Link genpd masters/subdomains to model the CPU topology. */
6abf32f1d9c500 Anup Patel 2022-02-10  509  	ret = dt_idle_pd_init_topology(np);
6abf32f1d9c500 Anup Patel 2022-02-10  510  	if (ret)
6abf32f1d9c500 Anup Patel 2022-02-10  511  		goto remove_pd;
6abf32f1d9c500 Anup Patel 2022-02-10  512  
6abf32f1d9c500 Anup Patel 2022-02-10  513  	return 0;
6abf32f1d9c500 Anup Patel 2022-02-10  514  
6abf32f1d9c500 Anup Patel 2022-02-10  515  put_node:
6abf32f1d9c500 Anup Patel 2022-02-10  516  	of_node_put(node);
6abf32f1d9c500 Anup Patel 2022-02-10  517  remove_pd:
6abf32f1d9c500 Anup Patel 2022-02-10  518  	sbi_pd_remove();
6abf32f1d9c500 Anup Patel 2022-02-10  519  	pr_err("failed to create CPU PM domains ret=%d\n", ret);
6abf32f1d9c500 Anup Patel 2022-02-10  520  no_pd:
6abf32f1d9c500 Anup Patel 2022-02-10  521  	return ret;
6abf32f1d9c500 Anup Patel 2022-02-10  522  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

