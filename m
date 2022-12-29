Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C591C658AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiL2IrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiL2IrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:47:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93100120AE;
        Thu, 29 Dec 2022 00:47:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so15928001wma.1;
        Thu, 29 Dec 2022 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRWUhYIq+SLDOvQiqrOVOP6g3Plcd0QA8Y2GhVoNHpY=;
        b=PMmPvJZJK2r6qP2rG7yBPRIYRvx2BDiE43Zlzgw1gDG+sj56JGlhCmiz59Ads3rrFw
         Rp1PFqxtnf+Dh/uSXrbNLt1WwQq/YFqM71Ew5SfdqyQSr2CvYMfrZeHYAa2lMorNalck
         e/89+1riqt1mZnOVftBxiIjfKXy643kUZe4qj6DoGNzoF54gTTqAXX9VG57Up8jcNHwd
         /LvbhlSfhGjSbHzO7Mm+z1bCdP01fyBE9Wr23jPWJG62klUveXG5eRAdjIPZrWAUYudh
         kCLHtW8ZlIznRK3PiS5AkRDVB5TOfUo+n6bmdgR9AtpS+tyGOI4m+n2ryhjewrVq6B3o
         8+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRWUhYIq+SLDOvQiqrOVOP6g3Plcd0QA8Y2GhVoNHpY=;
        b=xC88OGtp9x1e+crwn+/DL/xj6PJiXmYC8sYjW1f6Czc0NfZbjDT0vUHVwlfZwBJMH/
         w50hIjQNGRsg0rrF0A2sp2JuW6KJWJvU4qrbiKLQ7sXSPyCD5Q2mdpFRVhX4QNIs2eql
         cwrPV8KfwlcMBwVmqN4gc2kg/947Rgf5JnbpSNEIwQSwxpyVtmH611peUaJZrebfYaIF
         XIQRUaTdYtedLtYnGg5xBjvMXsxnOcjaXCFB/JvGF7vMUIn0eNYnA0qJrRXpftHjyiyd
         fqmB0kH0lSiXaQCrpIkjDmLmm/xuT7vSrag78Xew2r2E5pYDUyeVY+x8EPzIcLJT2xQt
         Na1w==
X-Gm-Message-State: AFqh2krFd6zm03K211UpITF9sfHOzuZAcDeZDVw7HxzO32C66cRaGaG0
        6hlNCKLztZoWYMA4isc3Ahw=
X-Google-Smtp-Source: AMrXdXs15dm23+E5UFcIdXUAKnnmmfv0pPZ4hEra6qNEnJIQ5Mnj58LgrCWanrudgmPOTIz4vAuhng==
X-Received: by 2002:a05:600c:54ef:b0:3d0:5254:8a43 with SMTP id jb15-20020a05600c54ef00b003d052548a43mr25267480wmb.38.1672303625992;
        Thu, 29 Dec 2022 00:47:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003b49bd61b19sm29848934wms.15.2022.12.29.00.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:47:05 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:46:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Haotien Hsu <haotienh@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Wayne Chang <waynec@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haotien Hsu <haotienh@nvidia.com>
Subject: Re: [PATCH] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <202212271237.LWXg8oOw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221083812.3363045-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haotien,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haotien-Hsu/ucsi_ccg-Refine-the-UCSI-Interrupt-handling/20221221-163923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20221221083812.3363045-1-haotienh%40nvidia.com
patch subject: [PATCH] ucsi_ccg: Refine the UCSI Interrupt handling
config: x86_64-randconfig-m001-20221226
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/usb/typec/ucsi/ucsi_ccg.c:708 ccg_irq_handler() error: uninitialized symbol 'cci'.

vim +/cci +708 drivers/usb/typec/ucsi/ucsi_ccg.c

247c554a14aa16 Ajay Gupta      2018-10-26  675  static irqreturn_t ccg_irq_handler(int irq, void *data)
247c554a14aa16 Ajay Gupta      2018-10-26  676  {
e32fd989ac1c45 Heikki Krogerus 2019-11-04  677  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CCI);
247c554a14aa16 Ajay Gupta      2018-10-26  678  	struct ucsi_ccg *uc = data;
e32fd989ac1c45 Heikki Krogerus 2019-11-04  679  	u8 intr_reg;
e32fd989ac1c45 Heikki Krogerus 2019-11-04  680  	u32 cci;
e32fd989ac1c45 Heikki Krogerus 2019-11-04  681  	int ret;
e32fd989ac1c45 Heikki Krogerus 2019-11-04  682  
e32fd989ac1c45 Heikki Krogerus 2019-11-04  683  	ret = ccg_read(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
e32fd989ac1c45 Heikki Krogerus 2019-11-04  684  	if (ret)
e32fd989ac1c45 Heikki Krogerus 2019-11-04  685  		return ret;
e32fd989ac1c45 Heikki Krogerus 2019-11-04  686  
e65232d7f1fccd Sing-Han Chen   2022-12-21  687  	if (!intr_reg)
e65232d7f1fccd Sing-Han Chen   2022-12-21  688  		return IRQ_HANDLED;
e65232d7f1fccd Sing-Han Chen   2022-12-21  689  	else if (!(intr_reg & UCSI_READ_INT))
e65232d7f1fccd Sing-Han Chen   2022-12-21  690  		goto err_clear_irq;

cci is uninitialized on this goto.

e65232d7f1fccd Sing-Han Chen   2022-12-21  691  
e32fd989ac1c45 Heikki Krogerus 2019-11-04  692  	ret = ccg_read(uc, reg, (void *)&cci, sizeof(cci));
e32fd989ac1c45 Heikki Krogerus 2019-11-04  693  	if (ret)
e32fd989ac1c45 Heikki Krogerus 2019-11-04  694  		goto err_clear_irq;
e32fd989ac1c45 Heikki Krogerus 2019-11-04  695  
e32fd989ac1c45 Heikki Krogerus 2019-11-04  696  	if (UCSI_CCI_CONNECTOR(cci))
e32fd989ac1c45 Heikki Krogerus 2019-11-04  697  		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
247c554a14aa16 Ajay Gupta      2018-10-26  698  
e65232d7f1fccd Sing-Han Chen   2022-12-21  699  	/* As per CCGx UCSI interface guide, copy CCI and MESSAGE_IN
e65232d7f1fccd Sing-Han Chen   2022-12-21  700  	 * to the OpRegion before clear the UCSI interrupt
e65232d7f1fccd Sing-Han Chen   2022-12-21  701  	 */
e65232d7f1fccd Sing-Han Chen   2022-12-21  702  	ccg_op_region_update(uc, cci);
e32fd989ac1c45 Heikki Krogerus 2019-11-04  703  
e32fd989ac1c45 Heikki Krogerus 2019-11-04  704  err_clear_irq:
e32fd989ac1c45 Heikki Krogerus 2019-11-04  705  	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
247c554a14aa16 Ajay Gupta      2018-10-26  706  
e65232d7f1fccd Sing-Han Chen   2022-12-21  707  	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
e65232d7f1fccd Sing-Han Chen   2022-12-21 @708  	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
e65232d7f1fccd Sing-Han Chen   2022-12-21  709  		complete(&uc->complete);
e65232d7f1fccd Sing-Han Chen   2022-12-21  710  
247c554a14aa16 Ajay Gupta      2018-10-26  711  	return IRQ_HANDLED;
247c554a14aa16 Ajay Gupta      2018-10-26  712  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

