Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461496D3C77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjDCEb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjDCEb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:31:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210886BD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:31:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so112101888ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680496283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkRESlJbZe0LvYDM0XBspGnFIPtDURNWtIWiJ2X5SjE=;
        b=ZbHv2r8Ktd5QiZrnBtOxT7Mk+h1xwmbWqaCifz8aaEuh5wVoqBA3W6yZ9UfuBVK1Jm
         qkeuc3aOOr2M8WsZeH3v9Jy7EdpZ0UojMHZwwsMK2rdNs+wIFqdBiZGPGtEY9wj/xCxZ
         zRFRAI17/IeJf2hoLgbX87BCRHpQQV5tGYxe0bxJu4TRumN2Muk7u0Mq4eiQ8H8s1cpq
         utvDWACs6rQQrKMdDH3wZ839QjPyGXoIQHbQbgs1fBAjUOCqrJq2/oDX2+UPMCKMVpM3
         dgDxUYQ8LYQcCM5oG1W/FLwuAIQK6Hdi+nfrlQLi6U1tqp9ekAlolwF80LnMiJU1ZGb2
         4w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkRESlJbZe0LvYDM0XBspGnFIPtDURNWtIWiJ2X5SjE=;
        b=UXlyo6jRXDzNUsP3/hv7p7bgzTdcdBt0JKrMnYjekLYdu0muAx0hubsdFoHokKuw69
         AAS3F0Zm87BnJmOIxayqgRXFY5rCZHOmwYuJpraUFJRU1WeucZdkQj+SXmYf2IKs7eWI
         /5DWciFRxbO56zvgkj9s6b29WZuvbznHSyh4ONbiv5D7uc1jnDViMMw/4CqQ8Q476j+N
         S9F3+DCoX8ZKCt4oi4qlGd2sieDiz7WMHcZ0sYPz7GP7sybXcuh223zGf+dcuh44r98g
         zV9KwC1JhSTiB9GLWm9zxu/WC9ALjCuj7ILQusqzPBP266Qz0UoekKiatlCvdBkhQquH
         bKEg==
X-Gm-Message-State: AAQBX9cH2laFec4pKC2/nGcD5WZuaIrr1QM2iSF/pB43hgxQRVQ7WhdS
        yf1yikQ3sMyijeL619PTD+o=
X-Google-Smtp-Source: AKy350aSFhOtVydWaJqjb11e28VLkg7kXSNCAvSug1OMlJ64zoMZT5BufdmLmdwKcl6y/x15x+6TqQ==
X-Received: by 2002:a17:906:5646:b0:930:7d8f:15a4 with SMTP id v6-20020a170906564600b009307d8f15a4mr34497884ejr.53.1680496283252;
        Sun, 02 Apr 2023 21:31:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709063ac800b00947ed087a2csm2829652ejd.154.2023.04.02.21.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:31:22 -0700 (PDT)
Date:   Mon, 3 Apr 2023 07:31:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/clocksource/exynos_mct.c:635 mct_init_dt() warn: missing
 error code? 'ret'
Message-ID: <20bf4e9b-c78d-4e6a-a5af-6accdd20a499@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: e8550f0e7bde9bd31697e3c534d386f7f3b5787b clocksource/drivers/exynos_mct: Support frc-shared property
config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230402/202304021446.46XVKag0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304021446.46XVKag0-lkp@intel.com/

smatch warnings:
drivers/clocksource/exynos_mct.c:635 mct_init_dt() warn: missing error code? 'ret'

vim +/ret +635 drivers/clocksource/exynos_mct.c

5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  613  static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
228e3023eb0430 drivers/clocksource/exynos_mct.c Arnd Bergmann      2013-04-09  614  {
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  615  	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  616  	int ret;
36ba5d527e9567 arch/arm/mach-exynos/mct.c       Thomas Abraham     2013-03-09  617  
7cd925a8823d16 drivers/clocksource/exynos_mct.c Marek Szyprowski   2021-11-01  618  	ret = exynos4_timer_resources(np);
7cd925a8823d16 drivers/clocksource/exynos_mct.c Marek Szyprowski   2021-11-01  619  	if (ret)
7cd925a8823d16 drivers/clocksource/exynos_mct.c Marek Szyprowski   2021-11-01  620  		return ret;
3a062281129229 arch/arm/mach-exynos4/mct.c      Changhwan Youn     2011-10-04  621  
7cd925a8823d16 drivers/clocksource/exynos_mct.c Marek Szyprowski   2021-11-01  622  	ret = exynos4_timer_interrupts(np, int_type);
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  623  	if (ret)
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  624  		return ret;
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  625  
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  626  	ret = exynos4_clocksource_init(frc_shared);
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  627  	if (ret)
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  628  		return ret;
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  629  
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  630  	/*
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  631  	 * When the FRC is shared with a main processor, this secondary
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  632  	 * processor cannot use the global comparator.
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  633  	 */
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  634  	if (frc_shared)
e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09 @635  		return ret;

This is zero, but it looks like it should be a negative.  Changing this
to either "return 0;" or "return -EINVAL;" would clean up the ambiguity.

e8550f0e7bde9b drivers/clocksource/exynos_mct.c Vincent Whitchurch 2022-06-09  636  
5e558ebd3d88d3 drivers/clocksource/exynos_mct.c Daniel Lezcano     2016-05-31  637  	return exynos4_clockevent_init();
30d8bead5a3094 arch/arm/mach-exynos4/mct.c      Changhwan Youn     2011-03-11  638  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

