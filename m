Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78517695B90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjBNH6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjBNH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:58:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804ED222ED;
        Mon, 13 Feb 2023 23:58:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j23so14738336wra.0;
        Mon, 13 Feb 2023 23:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJeol2eNvunQmmGVUes1HrblFwzhntE5hKnDqonygF8=;
        b=J5nuyajfuT3ZldBj6d+ClBLuVhstXvY5W7g+kXaliIlrTpWkojYbic0hC4PQD0N7em
         pdI0K3sXYWqBkPeXlk1H2wTi1kZwW3eMODYrAk9BDW0XYmmfsL5Mwt5S39IdunvFZDYa
         AXE9qUOqrH4ijhFVOHtEfxXMUpbMCg6L5n573Wq9LSzw9aBotxpZEVVGfPW3iHFeKj/V
         RR9+rxNxsVA0w9Obz8kp1d2TjryTHRPu4bELc+XYZ2aaCSyItvyftWRsHgLk5814xVSs
         4K+uv3XYwIKrmcf8GdHyu3C6P7y2lknnNeddWJ8Im3usNZoSTq8rAWNVJIypGtyvDm44
         Rleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJeol2eNvunQmmGVUes1HrblFwzhntE5hKnDqonygF8=;
        b=MJ3B+elXFUepWWP014NFwmceGlDOh2QQdOSYfWAWvLU9YPDv2FddkmxKPtSFlakbBV
         3eLtwlM3DLU7v9yU5Hau1jBvMuX1muqS5QzI2bSG6+RaK4SZspLohM4R4gWX7bPAcGVq
         rJq9Oe+pJ5Jpt++F7c8+AH5WuDDdKA986+4l57VPR54BacRyUV98mC+5QodVgWnjxOEu
         rFA82JzuCkvurbBcfeyLTYHPrbHtC0DpbrUJrmzoEXcw+1oqE2QmExDh0EwPBpjrXgev
         nCkicqwGj3r2gR6hijilUl6pZZa7SmmUA6IA+QWf9H47u9Cv/grOrvViPDx/Qe6j5CzU
         yNcg==
X-Gm-Message-State: AO0yUKX/ffrtvPLaqbf0Sz6KF6+VtTbR3Ft3097Y3fBI9sQ0QEijo5ai
        RGsaL/4/KlUP2YeffSj4Ypg=
X-Google-Smtp-Source: AK7set+JwcQI+vO5QHy7CPTkFgxpNyvViFhZkVwGUzelkyHThhU3yIENvt2tzNpyjDGPROYHfJExhA==
X-Received: by 2002:a5d:538a:0:b0:2c5:58aa:633b with SMTP id d10-20020a5d538a000000b002c558aa633bmr1246932wrv.20.1676361487037;
        Mon, 13 Feb 2023 23:58:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d6088000000b002c5539171d1sm5786557wrt.41.2023.02.13.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:58:06 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:58:02 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
Subject: Re: [PATCH v3 2/2] HID: asus: use spinlock to safely schedule workers
Message-ID: <202302141039.anZLT940-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-hid-unregister-leds-v3-2-0a52ac225e00@diag.uniroma1.it>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pietro,

url:    https://github.com/intel-lab-lkp/linux/commits/Pietro-Borrello/HID-bigben-use-spinlock-to-safely-schedule-workers/20230210-080058
base:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
patch link:    https://lore.kernel.org/r/20230125-hid-unregister-leds-v3-2-0a52ac225e00%40diag.uniroma1.it
patch subject: [PATCH v3 2/2] HID: asus: use spinlock to safely schedule workers
config: riscv-randconfig-m031-20230212 (https://download.01.org/0day-ci/archive/20230214/202302141039.anZLT940-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302141039.anZLT940-lkp@intel.com/

smatch warnings:
drivers/hid/hid-asus.c:532 asus_kbd_backlight_work() warn: sleeping in atomic context

vim +532 drivers/hid/hid-asus.c

af22a610bc3850 Carlo Caione    2017-04-06  521  static void asus_kbd_backlight_work(struct work_struct *work)
af22a610bc3850 Carlo Caione    2017-04-06  522  {
af22a610bc3850 Carlo Caione    2017-04-06  523  	struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
af22a610bc3850 Carlo Caione    2017-04-06  524  	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
af22a610bc3850 Carlo Caione    2017-04-06  525  	int ret;
31e578b641b3b3 Pietro Borrello 2023-02-09  526  	unsigned long flags;
af22a610bc3850 Carlo Caione    2017-04-06  527  
31e578b641b3b3 Pietro Borrello 2023-02-09  528  	spin_lock_irqsave(&led->lock, flags);
                                                        ^^^^^^^^^^^^^^^^^
Holding a spinlock.

af22a610bc3850 Carlo Caione    2017-04-06  529  
af22a610bc3850 Carlo Caione    2017-04-06  530  	buf[4] = led->brightness;
af22a610bc3850 Carlo Caione    2017-04-06  531  
af22a610bc3850 Carlo Caione    2017-04-06 @532  	ret = asus_kbd_set_report(led->hdev, buf, sizeof(buf));
                                                              ^^^^^^^^^^^^^^^^^^^
asus_kbd_set_report() does a GFP_KERNEL allocation.


af22a610bc3850 Carlo Caione    2017-04-06  533  	if (ret < 0)
af22a610bc3850 Carlo Caione    2017-04-06  534  		hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
31e578b641b3b3 Pietro Borrello 2023-02-09  535  
31e578b641b3b3 Pietro Borrello 2023-02-09  536  	spin_unlock_irqrestore(&led->lock, flags);
af22a610bc3850 Carlo Caione    2017-04-06  537  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

