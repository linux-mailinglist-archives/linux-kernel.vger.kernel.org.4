Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5C625373
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKKGPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiKKGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:15:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1913FB8;
        Thu, 10 Nov 2022 22:15:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h133-20020a1c218b000000b003cf4d389c41so4944727wmh.3;
        Thu, 10 Nov 2022 22:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B94q4jNiGCMWVtJXsHfPt5LdUhSURj2oOrD7tCm/2SA=;
        b=ET0NmDoNZJqG4JRrhaqz15lZlQbETJs+3yutHAnV3UNX/vUL0aGEkXLcttdT0JIbPJ
         nDK0jKpexehUZ4TTaTvL3Mg1W4txYCCgGsloVUNEBwXvnglq/8m6rZsOO2hWzmovGaOq
         TGWnQDplZwjHS/tFsIuAfsfJ+DhXKjd9gqKihnk0kuByEr6TB5AecL42B2RBo1O8WFNK
         p8OQ3NjtZ8ojjq4HMtk5Xnb1Eh9iH29DKTvxbGyyNMmGOLDlx3HLsshhbU4fsygTL7rV
         CtpUKAIM37ej5931tEc713uuBuOiOVihugvYgENAbur406B2jxUmXC+NK03QdIX5Cima
         SMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B94q4jNiGCMWVtJXsHfPt5LdUhSURj2oOrD7tCm/2SA=;
        b=pEgJ/LxjvN5ZPiZ+8lx1CL2FagxqpOnudMk/d6hrxuvbXfUrYM4rQPXPbV0JlGmHXP
         R+lazr3rhsw2/324O3F+JanJgdDn/GMFr8buxwhy7SPMn+P4NAgvUSVwKAVZQFGxMU1Z
         zjvqsgYfiNlvegX5kopMSSBJlS0Y1SvnI1/y8W8hmJgC6NxatiorshbZQQbvGyNAmCaa
         wCHbRaIUpGobI4jA65z2O59u35v+cNHr599nt81dXE8V3D6mnlnXE8fCdhmD8n5Nxlz9
         Xkmx0pzlc0q/bxn809uIiSvFb8aFYZ7vEYUSvTUyrdDElMU/ghKUoplvfVRLWuK47M+S
         4XWQ==
X-Gm-Message-State: ANoB5pmy/z9T6IMaigz0LxOIE0XqDr4kFtqXQkF2RhkvFrrkSMQUNvw2
        nAJutlS+Dr2Zghj7V012VqU=
X-Google-Smtp-Source: AA0mqf6G+CMhcwHvr4uRwGEk29EQaGnPzGMD9T/xzNVGljgG1kM5S//P5RVh4apJDOByreT+pVHRnw==
X-Received: by 2002:a05:600c:2d05:b0:3b4:8603:e2ae with SMTP id x5-20020a05600c2d0500b003b48603e2aemr154973wmf.148.1668147313345;
        Thu, 10 Nov 2022 22:15:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003b4cba4ef71sm7685721wmb.41.2022.11.10.22.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 22:15:12 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:15:10 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, sre@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too
 frequently
Message-ID: <202211111240.LORXimo8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1667647544-12945-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivaylo,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivaylo-Dimitrov/power-supply-cpcap-battery-improvements/20221105-192758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/1667647544-12945-2-git-send-email-ivo.g.dimitrov.75%40gmail.com
patch subject: [PATCH 1/3] power: cpcap-battery: Do not issue low signal too frequently
config: m68k-randconfig-m041-20221110
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/power/supply/cpcap-battery.c:1084 cpcap_battery_lowbph_enable() warn: iterator used outside loop: 'd'

vim +/d +1084 drivers/power/supply/cpcap-battery.c

ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1072  static void cpcap_battery_lowbph_enable(struct work_struct *work)
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1073  {
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1074  	struct delayed_work *d_work = to_delayed_work(work);
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1075  	struct cpcap_battery_ddata *ddata = container_of(d_work,
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1076  			struct cpcap_battery_ddata, low_irq_work);
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1077  	struct cpcap_interrupt_desc *d;
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1078  
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1079  	list_for_each_entry(d, &ddata->irq_list, node) {
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1080  		if (d->action == CPCAP_BATTERY_IRQ_ACTION_BATTERY_LOW)
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1081  			break;
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1082  	}
ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1083  
ce48d112324af4 Ivaylo Dimitrov 2022-11-05 @1084  	enable_irq(d->irq);

If we exit the loop without hitting a break then "d" is not a valid
pointer and "enable_irq(d->irq);" will do something bad.

ce48d112324af4 Ivaylo Dimitrov 2022-11-05  1085  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

