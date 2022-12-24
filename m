Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D06655B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 20:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLXTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 14:30:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D00C7E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 11:30:45 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h12so4274601wmq.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mofTUi3driuT1Kc5x++iqfijA+ZbuXFDPh6ffwSeT3U=;
        b=ECnyAIn4LF/xDizUZxrueyG4ejveMXeG0yUrU2qIMfTH7uMHMr8LCfPaZWWixbyU76
         t9yS14da4MpyzXREt7TIBw5BFOEHvMWbLmbT59MHob0t1MIV0uWXoU6J0DtPW7jHf+8O
         wrDO9VBOLhqfmNXmAO2KyCkDmv2rYGaV8yir8Yw0gR+kXaMPrShyRJw9O3P7LYHg8jeZ
         lVy/0Irr5CgZ3ohdBCMBfW4nCTt2dW53Hg2EacFCh6owLMBxEXrI0wd9mByW76IKaJE2
         MK+IszJOMcM5gZDpvO5fAQFW1fXpElO6XzJiM0m2IZqNidMqSC/ngEoeDbcp1nLybEZg
         yaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mofTUi3driuT1Kc5x++iqfijA+ZbuXFDPh6ffwSeT3U=;
        b=4diC0AfyGif/ITCnG3hEExSOuvrWMVIOhTLMIx4UhaIZhesgobkY9sb4dCYnD+vk5D
         am0XWXgIahN0srOJDBSwX9thoVBThJ7zsUUoKAZid9gP/nfVtilB0uYkjKTdGDbBm5d1
         0WY/W5nKGlQ1aLJ59Uj51FSNcQrHVtRpI14ck6Gn6k2n1DWF0kCqcvyMFgK8Dk7HkfgK
         LGzakrZytuzHo0W329EGxtr42reD9iznioXTyGk/6GUQP1qY37wiFJKE3xypiW99nB+5
         3t8kKFajGRSatemro68MWf6uDUq/QLh6o0AFa+DXjDzaIuICDlzNAH+MzQuamaty1YPn
         YSAw==
X-Gm-Message-State: AFqh2kpiVJVVb777qO5V9ixbTY/EKgSVOK8ThCPmw12BrmhEsmHBD4WV
        VOuWV4aVV7opPxJsOQREP5A=
X-Google-Smtp-Source: AMrXdXtjGKOzguoqURnHPzeA9K8hiZkkssjg4+BjvabqjFnsLtb1JwLeRcbswH/6c6GTd6s+6O9C/A==
X-Received: by 2002:a05:600c:1e11:b0:3d2:26e1:bd45 with SMTP id ay17-20020a05600c1e1100b003d226e1bd45mr11787321wmb.29.1671910243474;
        Sat, 24 Dec 2022 11:30:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003b49bd61b19sm14075726wms.15.2022.12.24.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 11:30:42 -0800 (PST)
Date:   Sat, 24 Dec 2022 22:30:39 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn:
 replace divide condition 'pin / 8' with 'pin >= 8'
Message-ID: <Y6dTX2wx/SXlswGC@kadam>
References: <202212181140.EAWl7FKx-lkp@intel.com>
 <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 05:19:27PM +0100, Andy Shevchenko wrote:
> 
> 
> Lähetetty iPhonesta
> 
> > Dan Carpenter <error27@gmail.com> kirjoitti 23.12.2022 kello 11.54:
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
> > commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPIO registers on cascaded chips
> > config: ia64-randconfig-m031-20221218
> > compiler: ia64-linux-gcc (GCC) 12.1.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > 
> > smatch warnings:
> > drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
> > drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
> > 
> 
> 
> 
> I don’t think this is a good advice. If we want to limit that, we need
> to check also upper limit. But. The GPIO framework does that. So,
> changing / to >= is bogus.


How is checking pin / 8 not mathematically equivalent to pin >= 8?

I don't understand this code at all.  The divide is inscrutable  Is it
storing something in in the lower 3 bits and something in bit 4?  In
that case it might be nicer to just check (pin & BIT(4)).

regards,
dan carpenter

> 
> 
> > vim +52 drivers/gpio/gpio-exar.c
> > 
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  47  static unsigned int
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  48  exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  49  {
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  50      unsigned int pin = exar_gpio->first_pin + (offset % 16);
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  51      unsigned int cascaded = offset / 16;
> > 5134272f9f3f71 Qingtao Cao         2022-09-02 @52      unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
> > 
> > Why not change this to pin > 8 instead.  Comparisons are faster than
> > divide ops.  Way more readable too.
> > 
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  53  
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  54      return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  55  }
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  56  
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  57  static unsigned int
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  58  exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  59  {
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  60      unsigned int pin = exar_gpio->first_pin + (offset % 16);
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  61      unsigned int cascaded = offset / 16;
> > 5134272f9f3f71 Qingtao Cao         2022-09-02 @62      unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  63  
> > 5134272f9f3f71 Qingtao Cao         2022-09-02  64      return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
> > 696868d0a79c21 Bartosz Golaszewski 2020-09-30  65  }
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> > 
