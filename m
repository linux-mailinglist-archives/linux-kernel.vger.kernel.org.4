Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19D6654F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiLWKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiLWKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:54:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F38BB7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:54:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3266607wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jU7Gwtk5CThFB9C7hQa4t1t5QkALQrwN/aMPEyEycHY=;
        b=NnbnBxMT3mzDcYwCScVuTk2JginRHks6gpOOxrgQ5NROHKkPSseanaXLzaMFp6B9RW
         pu+xCH1gKdBujbLQKObdxV2F+IlCd/jf8i0vDeJlyTaYcWY7LZZxe03dO13k0XAt2C21
         e5MiYlsqbENI937PmhzDwklDT4OKd+c4+22Y/rOswPQKI68nQQwEdyRUbAKCTteRGSxt
         3j0iDse75OPtwdSWuwqOhBEl6mPfQ2qFEUOkMsrLRitqyaCNx3D1jF9mD2qhsa9iVACO
         RdmyfQmPoQ8yYE4cJgAT+NcaWDE1NtIqzDe5kZbK4icgbDa9OShHDZPtLlSPHRBxCwPR
         vSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU7Gwtk5CThFB9C7hQa4t1t5QkALQrwN/aMPEyEycHY=;
        b=wpABt3Je9LqlEl5Hog3TzeiBS2YfElrMgOMq/6xID16Wqs06VRVYIj2eUWQCM9mRwP
         L3fIfm3BWQWEsiOGsuI/QboDNGL8WbO/ChQnZbh9yFrDOiBFwidlH3Oh7fjCHcXL6dFl
         VPXCedYjei+lvRNu779EFUbZPou+yvnqM9p1NUCwWO3oMMFaWnKBYKLM/iO9AxeF0Wna
         HC6z+MHimgQFJzt0y+Xy6ETLzf1iIHinbe4aYW9QfLLEB8yxhDCQMCHQX2FqBG3wDxNz
         CkM7NGU1yftrpG0xW6gDMRSH0iaOxn6upjoo+EY0xuq4aO/l79YCR2cFHHfhZr0VpV2P
         VRdA==
X-Gm-Message-State: AFqh2ko799+pub1Z6T6ELvLg1Nsa8nno49ccGV+0R/BkOFn+UeZNDUFP
        Sifdydr1WS+u4r1jHOQoL7Y=
X-Google-Smtp-Source: AMrXdXtM/sYiCek0tFDZ1bpxTJeAEJkTBoHiCDsRzreP3WgShRJyCrh3oeueYOL/B5yXeRl7ux/UQA==
X-Received: by 2002:a05:600c:1e18:b0:3d2:5e4e:701 with SMTP id ay24-20020a05600c1e1800b003d25e4e0701mr6740482wmb.31.1671792889828;
        Fri, 23 Dec 2022 02:54:49 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003c6bbe910fdsm11322454wmc.9.2022.12.23.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:54:49 -0800 (PST)
Date:   Fri, 23 Dec 2022 13:54:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace
 divide condition 'pin / 8' with 'pin >= 8'
Message-ID: <202212181140.EAWl7FKx-lkp@intel.com>
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
head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPIO registers on cascaded chips
config: ia64-randconfig-m031-20221218
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'

vim +52 drivers/gpio/gpio-exar.c

696868d0a79c21 Bartosz Golaszewski 2020-09-30  47  static unsigned int
696868d0a79c21 Bartosz Golaszewski 2020-09-30  48  exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
696868d0a79c21 Bartosz Golaszewski 2020-09-30  49  {
5134272f9f3f71 Qingtao Cao         2022-09-02  50  	unsigned int pin = exar_gpio->first_pin + (offset % 16);
5134272f9f3f71 Qingtao Cao         2022-09-02  51  	unsigned int cascaded = offset / 16;
5134272f9f3f71 Qingtao Cao         2022-09-02 @52  	unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;

Why not change this to pin > 8 instead.  Comparisons are faster than
divide ops.  Way more readable too.

5134272f9f3f71 Qingtao Cao         2022-09-02  53  
5134272f9f3f71 Qingtao Cao         2022-09-02  54  	return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
696868d0a79c21 Bartosz Golaszewski 2020-09-30  55  }
696868d0a79c21 Bartosz Golaszewski 2020-09-30  56  
696868d0a79c21 Bartosz Golaszewski 2020-09-30  57  static unsigned int
696868d0a79c21 Bartosz Golaszewski 2020-09-30  58  exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
696868d0a79c21 Bartosz Golaszewski 2020-09-30  59  {
5134272f9f3f71 Qingtao Cao         2022-09-02  60  	unsigned int pin = exar_gpio->first_pin + (offset % 16);
5134272f9f3f71 Qingtao Cao         2022-09-02  61  	unsigned int cascaded = offset / 16;
5134272f9f3f71 Qingtao Cao         2022-09-02 @62  	unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
5134272f9f3f71 Qingtao Cao         2022-09-02  63  
5134272f9f3f71 Qingtao Cao         2022-09-02  64  	return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
696868d0a79c21 Bartosz Golaszewski 2020-09-30  65  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

