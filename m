Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9125C6A3A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjB0EZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0EZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:25:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31EEF87
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:25:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso1386793wmo.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKY+nM73n92PPNk57uTNynvXNt+CICVYCNxlZP1mrDg=;
        b=LmtQWJBHze3Ia9GRyyQvObT5COCtGlIGbDHu4nrcLEWds3cgWjt54fAM6XPL2HNGrH
         SIAF2DU6TLGPrpGEfUgwz7SdolMaLJ+Fu3+moyUSsy73hK8mBSBUJbzAZTFIAgCxBLQB
         2hp+9ZKBn080PrOhSYpDAf7odWHoHOM8ohp6GMftzAXNo3zP77ChH7FwnlUtjqSPns6q
         CvQ5ey+g75CO/gr42zA+vGvOLN8Z943WfsHnUKvnZIlJ1x9oX0FmWTjs41/I+UNK4wyn
         3BIJ+NZ4dLcCYHORGLH3MJjMi7PoN48i4sqIDyKVsKaNJ0IQ8pV9zNBoeNu+X/T0MFSD
         mGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKY+nM73n92PPNk57uTNynvXNt+CICVYCNxlZP1mrDg=;
        b=3DbzVo8eIsmbkE1LwASNOirE/zOguf2bRTlebOapGU29OqOX/kemRT5I086Z8guk4F
         5zjUBLLSpEAsSYZn5hDOUDwEgSYpKL8EsW4MJbRf+l2S2QVfgKj5VoMLFn0v7Y43EPT0
         YoKgr79rElmVt+YnMU935E2R0RIK4M4QO9yie9df6lyML8evYE+eIVFn1MHMVF4qHnYC
         74/spwVTJ1CwwkJioV1kjnXgQMDd883VKMMp7S2Njw0153wzmqBvSxF4d4x6Qch06OnM
         wDwqEStQtxJBOqd1tBP/02+pMKPNelwK1X9bzOoKtuSYgiZ2aGRlUssYJequ3PK64GM7
         Hk5Q==
X-Gm-Message-State: AO0yUKU8vE8jdxWp+Ln4p8yXvCMPyUM29iZkjE9OvJ+XO/iDOdMSob+L
        3n7XLaCwXgefxffhIOMnP+o=
X-Google-Smtp-Source: AK7set9oWKWHoPK378Dz39H2oIP6OLjKI/lm5WT5tSFlk4qAGO0cK8EJfXNPz67Cf15Re5mQAZrXHg==
X-Received: by 2002:a05:600c:1e1f:b0:3ea:fca4:8c48 with SMTP id ay31-20020a05600c1e1f00b003eafca48c48mr7590460wmb.23.1677471920607;
        Sun, 26 Feb 2023 20:25:20 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p13-20020a1c544d000000b003e208cec49bsm17688381wmi.3.2023.02.26.20.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:25:19 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:25:16 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Rashmica Gupta <rashmica.g@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: arch/powerpc/perf/mpc7450-pmu.c:422 init_mpc7450_pmu() warn: masked
 condition '((pvr >> 16) & 65535) != 2147483648' is always true.
Message-ID: <202302260657.7dM9Uwev-lkp@intel.com>
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
head:   116b41162f8b267987ea9a73eb7e73eaa7c2cce5
commit: ec3eb9d941a98f4c0dac263110729680a734279b powerpc/perf: Use PVR rather than oprofile field to determine CPU version
config: powerpc-randconfig-m031-20230226 (https://download.01.org/0day-ci/archive/20230226/202302260657.7dM9Uwev-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302260657.7dM9Uwev-lkp@intel.com/

smatch warnings:
arch/powerpc/perf/mpc7450-pmu.c:422 init_mpc7450_pmu() warn: masked condition '((pvr >> 16) & 65535) != 2147483648' is always true.

vim +422 arch/powerpc/perf/mpc7450-pmu.c

77c2342a578c11 arch/powerpc/kernel/mpc7450-pmu.c Dmitry Baryshkov 2011-06-29  418  static int __init init_mpc7450_pmu(void)
7325927e5a20bf arch/powerpc/kernel/mpc7450-pmu.c Paul Mackerras   2009-06-17  419  {
ec3eb9d941a98f arch/powerpc/perf/mpc7450-pmu.c   Rashmica Gupta   2022-07-07  420  	unsigned int pvr = mfspr(SPRN_PVR);
ec3eb9d941a98f arch/powerpc/perf/mpc7450-pmu.c   Rashmica Gupta   2022-07-07  421  
ec3eb9d941a98f arch/powerpc/perf/mpc7450-pmu.c   Rashmica Gupta   2022-07-07 @422  	if (PVR_VER(pvr) != PVR_7450)
                                                                                            ^^^^^^^^^^^^^^^^^^^^^^^^
Impossible.  Unclear what was intended.

7325927e5a20bf arch/powerpc/kernel/mpc7450-pmu.c Paul Mackerras   2009-06-17  423  		return -ENODEV;
7325927e5a20bf arch/powerpc/kernel/mpc7450-pmu.c Paul Mackerras   2009-06-17  424  
7325927e5a20bf arch/powerpc/kernel/mpc7450-pmu.c Paul Mackerras   2009-06-17  425  	return register_power_pmu(&mpc7450_pmu);
7325927e5a20bf arch/powerpc/kernel/mpc7450-pmu.c Paul Mackerras   2009-06-17  426  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

