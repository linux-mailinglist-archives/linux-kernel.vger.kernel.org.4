Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF26F4286
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjEBLTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEBLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:19:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E75C9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:19:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso21656705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683026353; x=1685618353;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMjdo4O02u+tpFEhZP9Wls75XLkok8xEL1r9/5OuF+Q=;
        b=WBdUYPakvTnEh67swv1MqMGVbXY2WvVli9Y51IR2me03hlxW1R+L2q1da6SltViBtZ
         ySz9yARFiAMriFbyyEbe2/wPoR/ngj+q8nrzRnE0d2C+XY9dWSCHHdKJyzUE4/PFo5HF
         16thIl5KC1DvL0OSuXE/W2GxYGuqMxFY6Z2sOccYBWHZYyF87Smsl1hw46M4F/AdXAt1
         YftSM5S/ybrujQfnRbbCXKM8SCIcNrhoNfQU3T/4yrX4LBIG0iIsPjEiozah2ENh6Wbk
         QDy+O8Z5YlM6EW29GM0qd/nmzck696MqrG8zmKaY4ODjCjpTpZDogYeAd9D8OBmGjVU2
         Kvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026353; x=1685618353;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMjdo4O02u+tpFEhZP9Wls75XLkok8xEL1r9/5OuF+Q=;
        b=e/+bnztqEtRTq4z4K31TwO5HcgCNper51JNHA9ZX9cjDdDacyYiScvge/afi2Y8cjr
         5ze7WhihE52acnF3ZbJHbAKXFqKRKJx/VIY11MdjHaTWxp9TCu3/rc/Crt7mCYH4LSOA
         b889CBUEqzGINKHfo5/tXitz5NQ+dPgNh/HmVm3rmSE7HXHSbxOt0ZdrVyyVn1qgxDT8
         XPtLcu9SjaQDlZUTfAswQN+FpAQk3j+/rEqRtuIzPLPye8U9Sy6Y1umNuWqOuZj/E8rg
         2wCYZNYcprNIe2nsv3UlSKpl4tznFM8v5u9NCaXunba/Is6jPAlNtn7Q8vEgS2/NK+9C
         q5pA==
X-Gm-Message-State: AC+VfDwUjid9fjvpvCx/u+YJ6r/n9FjxdiQY085qpBBctSGyamXbrgJM
        7IAZhlLD36+rqr2DgpyjhUGhDwAsr1F/+Zv7mIM=
X-Google-Smtp-Source: ACHHUZ6gWRtAX9s096mOp1U4DiSn5ZXBPTBKwOl+m0vTot2sXSiXUTpMGXlsbfXhGZCP0lSYDpA6/g==
X-Received: by 2002:a1c:7317:0:b0:3f1:89a2:e705 with SMTP id d23-20020a1c7317000000b003f189a2e705mr11654626wmb.0.1683026352943;
        Tue, 02 May 2023 04:19:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b002f00793bd7asm30572021wrm.27.2023.05.02.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:19:11 -0700 (PDT)
Date:   Tue, 2 May 2023 14:19:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: drivers/gpu/drm/udl/udl_main.c:259 udl_get_urb_locked() warn: can
 'unode' even be NULL?
Message-ID: <e35cd818-d2f7-4d5e-abf8-b3448ca224aa@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2caeeb9d4a1bccd923b7918427f9e9ef7151ddd8
commit: c5c354a3a4728045e1342166394c615d75d45377 drm/udl: Fix inconsistent urbs.count value during udl_free_urb_list()
config: parisc-randconfig-m031-20230421 (https://download.01.org/0day-ci/archive/20230423/202304230801.ncoG1XDr-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304230801.ncoG1XDr-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/udl/udl_main.c:259 udl_get_urb_locked() warn: can 'unode' even be NULL?

vim +/unode +259 drivers/gpu/drm/udl/udl_main.c

c5c354a3a47280 Takashi Iwai 2022-09-08  236  static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
5320918b9a8786 Dave Airlie  2010-12-15  237  {
c5c354a3a47280 Takashi Iwai 2022-09-08  238  	struct urb_node *unode;
5320918b9a8786 Dave Airlie  2010-12-15  239  
c5c354a3a47280 Takashi Iwai 2022-09-08  240  	assert_spin_locked(&udl->urbs.lock);
5320918b9a8786 Dave Airlie  2010-12-15  241  
acd45c56790a3b Takashi Iwai 2022-08-04  242  	/* Wait for an in-flight buffer to complete and get re-queued */
acd45c56790a3b Takashi Iwai 2022-08-04  243  	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
c5c354a3a47280 Takashi Iwai 2022-09-08  244  					 !udl->urbs.count ||
acd45c56790a3b Takashi Iwai 2022-08-04  245  					 !list_empty(&udl->urbs.list),
acd45c56790a3b Takashi Iwai 2022-08-04  246  					 udl->urbs.lock, timeout)) {
acd45c56790a3b Takashi Iwai 2022-08-04  247  		DRM_INFO("wait for urb interrupted: available: %d\n",
acd45c56790a3b Takashi Iwai 2022-08-04  248  			 udl->urbs.available);
c5c354a3a47280 Takashi Iwai 2022-09-08  249  		return NULL;
acd45c56790a3b Takashi Iwai 2022-08-04  250  	}
5320918b9a8786 Dave Airlie  2010-12-15  251  
c5c354a3a47280 Takashi Iwai 2022-09-08  252  	if (!udl->urbs.count)
c5c354a3a47280 Takashi Iwai 2022-09-08  253  		return NULL;
c5c354a3a47280 Takashi Iwai 2022-09-08  254  
acd45c56790a3b Takashi Iwai 2022-08-04  255  	unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);

Use list_first_entry_or_null() if this list can be empty.

ed9605a66b62f2 Takashi Iwai 2022-09-08  256  	list_del_init(&unode->entry);
                                                               ^^^^^^^^^^^^
dereference.

5320918b9a8786 Dave Airlie  2010-12-15  257  	udl->urbs.available--;
5320918b9a8786 Dave Airlie  2010-12-15  258  
acd45c56790a3b Takashi Iwai 2022-08-04 @259  	return unode ? unode->urb : NULL;

Returns from list_first_entry() should never be checked for NULL.

5320918b9a8786 Dave Airlie  2010-12-15  260  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

