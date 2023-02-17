Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F969AFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjBQP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBQP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:56:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA9711BC;
        Fri, 17 Feb 2023 07:56:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eg30so5729527edb.7;
        Fri, 17 Feb 2023 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzFjOEEzaxMg0PoK9w/FYDQg5oh8fvu0qlQZTMdpOdc=;
        b=XS0MdCKYhSgWKheIOrss76W3LEfboar9PfOE2US+2XUg4vqQ837Gh64TtDVfvdsKsC
         1BnNCYdJkZBPOpyqbmLPqjnz64GvfOnWz4X9Dl9abcZH0d4+3v6v4Nrpw6NbymuRYxBO
         BkV5Do5S9co40LjM9xzUl6aj6UOGVHqJn1wtIKysUF1ehWXb+5umYNxyfW5B5Eq2DmUs
         h3PoyQUmecKJohCygBH3WWtdr6sALhLEfSe02TXtdtEfY4IjhzEQuvFuIc4LcN1JCSyN
         M+eHCoEINyG18cVfLcUO08XglToGPjZqdcsPEwmswRrnUNZUdF1DHFBY4S2K8AWupjWT
         9SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzFjOEEzaxMg0PoK9w/FYDQg5oh8fvu0qlQZTMdpOdc=;
        b=yGWE4vq3qm8ZwbZwoOm6DSSFtN/50irOf3Ck6NJppZDpxwWnfS+FTGmFZkI/RzKro6
         bySd6/vuG9BgsqZ3nSuHAAT7p5ij/0zIdH2TXNQWmBTl54q2A21mHK0SWI2XaGRmhYUL
         O/1Fwt/bF9DC9oe1C7d7g8N+7Vm5qJw35lhzKD206GiJ8lz2jARmxWHL8wdEIZl33IWx
         hmaCF5xmP0EkLm0ay0Dj5QfxVANI2eE7c1jpOEWA75NAW8FoajfAf/6yRbnbNNlVKXqM
         +1Ua1VEP1Ob15BH6mdKPUM5DZ5Le4vWGeZSaf5oNp8eNCCFt7XqZuz9DFcU19UN5I8oH
         2sUA==
X-Gm-Message-State: AO0yUKXD1PwdhucOksiQv7lEiCPqfMZCgD7CDMZRaurCig9MSMDaFk5F
        y1IV+yPV20Nflyj4y82EL4cWRkSD1iM=
X-Google-Smtp-Source: AK7set/vxKzQWRPH6fDGnusk9+izTbvGUGGINVbSZdBFGVe8QIE5czO6u1CLDh4Ul2HyD2Qkzg68mA==
X-Received: by 2002:aa7:d910:0:b0:499:4130:fae with SMTP id a16-20020aa7d910000000b0049941300faemr1124872edr.10.1676649367080;
        Fri, 17 Feb 2023 07:56:07 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b0049ef70a2894sm2486213eda.38.2023.02.17.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:56:05 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:55:59 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: Re: [PATCH v5 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Message-ID: <202302172243.hKUsQl2q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676586588-25989-2-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elson,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elson-Roy-Serrao/usb-gadget-Properly-configure-the-device-for-remote-wakeup/20230217-063114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1676586588-25989-2-git-send-email-quic_eserrao%40quicinc.com
patch subject: [PATCH v5 1/5] usb: gadget: Properly configure the device for remote wakeup
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230217/202302172243.hKUsQl2q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302172243.hKUsQl2q-lkp@intel.com/

smatch warnings:
drivers/usb/gadget/composite.c:1016 set_config() error: we previously assumed 'c' could be null (see line 946)

vim +/c +1016 drivers/usb/gadget/composite.c

40982be52d8f64 David Brownell    2008-06-19   910  static int set_config(struct usb_composite_dev *cdev,
40982be52d8f64 David Brownell    2008-06-19   911  		const struct usb_ctrlrequest *ctrl, unsigned number)
40982be52d8f64 David Brownell    2008-06-19   912  {
40982be52d8f64 David Brownell    2008-06-19   913  	struct usb_gadget	*gadget = cdev->gadget;
d6f4663664cbd5 Jakob Koschel     2022-03-08   914  	struct usb_configuration *c = NULL, *iter;
40982be52d8f64 David Brownell    2008-06-19   915  	int			result = -EINVAL;
40982be52d8f64 David Brownell    2008-06-19   916  	unsigned		power = gadget_is_otg(gadget) ? 8 : 100;
40982be52d8f64 David Brownell    2008-06-19   917  	int			tmp;
40982be52d8f64 David Brownell    2008-06-19   918  
40982be52d8f64 David Brownell    2008-06-19   919  	if (number) {
d6f4663664cbd5 Jakob Koschel     2022-03-08   920  		list_for_each_entry(iter, &cdev->configs, list) {
d6f4663664cbd5 Jakob Koschel     2022-03-08   921  			if (iter->bConfigurationValue != number)
d6f4663664cbd5 Jakob Koschel     2022-03-08   922  				continue;
bdb64d727216b4 Tatyana Brokhman  2011-06-29   923  			/*
bdb64d727216b4 Tatyana Brokhman  2011-06-29   924  			 * We disable the FDs of the previous
bdb64d727216b4 Tatyana Brokhman  2011-06-29   925  			 * configuration only if the new configuration
bdb64d727216b4 Tatyana Brokhman  2011-06-29   926  			 * is a valid one
bdb64d727216b4 Tatyana Brokhman  2011-06-29   927  			 */
bdb64d727216b4 Tatyana Brokhman  2011-06-29   928  			if (cdev->config)
bdb64d727216b4 Tatyana Brokhman  2011-06-29   929  				reset_config(cdev);
d6f4663664cbd5 Jakob Koschel     2022-03-08   930  			c = iter;
40982be52d8f64 David Brownell    2008-06-19   931  			result = 0;
40982be52d8f64 David Brownell    2008-06-19   932  			break;
40982be52d8f64 David Brownell    2008-06-19   933  		}
40982be52d8f64 David Brownell    2008-06-19   934  		if (result < 0)
40982be52d8f64 David Brownell    2008-06-19   935  			goto done;
bdb64d727216b4 Tatyana Brokhman  2011-06-29   936  	} else { /* Zero configuration value - need to reset the config */
bdb64d727216b4 Tatyana Brokhman  2011-06-29   937  		if (cdev->config)
bdb64d727216b4 Tatyana Brokhman  2011-06-29   938  			reset_config(cdev);
40982be52d8f64 David Brownell    2008-06-19   939  		result = 0;
bdb64d727216b4 Tatyana Brokhman  2011-06-29   940  	}
40982be52d8f64 David Brownell    2008-06-19   941  
1cbfb8c4f62d66 Joel Stanley      2019-09-30   942  	DBG(cdev, "%s config #%d: %s\n",
e538dfdae85244 Michal Nazarewicz 2011-08-30   943  	    usb_speed_string(gadget->speed),
e538dfdae85244 Michal Nazarewicz 2011-08-30   944  	    number, c ? c->label : "unconfigured");
                                                                    ^

40982be52d8f64 David Brownell    2008-06-19   945  
40982be52d8f64 David Brownell    2008-06-19  @946  	if (!c)
                                                             ^
Check for NULL

40982be52d8f64 David Brownell    2008-06-19   947  		goto done;
40982be52d8f64 David Brownell    2008-06-19   948  
6027f3173e797b Peter Chen        2014-04-29   949  	usb_gadget_set_state(gadget, USB_STATE_CONFIGURED);
40982be52d8f64 David Brownell    2008-06-19   950  	cdev->config = c;
40982be52d8f64 David Brownell    2008-06-19   951  
40982be52d8f64 David Brownell    2008-06-19   952  	/* Initialize all interfaces by setting them to altsetting zero. */
40982be52d8f64 David Brownell    2008-06-19   953  	for (tmp = 0; tmp < MAX_CONFIG_INTERFACES; tmp++) {
40982be52d8f64 David Brownell    2008-06-19   954  		struct usb_function	*f = c->interface[tmp];
5242658d1b9777 Laurent Pinchart  2009-10-21   955  		struct usb_descriptor_header **descriptors;
40982be52d8f64 David Brownell    2008-06-19   956  
40982be52d8f64 David Brownell    2008-06-19   957  		if (!f)
40982be52d8f64 David Brownell    2008-06-19   958  			break;
40982be52d8f64 David Brownell    2008-06-19   959  
5242658d1b9777 Laurent Pinchart  2009-10-21   960  		/*
5242658d1b9777 Laurent Pinchart  2009-10-21   961  		 * Record which endpoints are used by the function. This is used
5242658d1b9777 Laurent Pinchart  2009-10-21   962  		 * to dispatch control requests targeted at that endpoint to the
5242658d1b9777 Laurent Pinchart  2009-10-21   963  		 * function's setup callback instead of the current
5242658d1b9777 Laurent Pinchart  2009-10-21   964  		 * configuration's setup callback.
5242658d1b9777 Laurent Pinchart  2009-10-21   965  		 */
f3bdbe36682631 John Youn         2016-02-05   966  		descriptors = function_descriptors(f, gadget->speed);
5242658d1b9777 Laurent Pinchart  2009-10-21   967  
5242658d1b9777 Laurent Pinchart  2009-10-21   968  		for (; *descriptors; ++descriptors) {
5242658d1b9777 Laurent Pinchart  2009-10-21   969  			struct usb_endpoint_descriptor *ep;
5242658d1b9777 Laurent Pinchart  2009-10-21   970  			int addr;
5242658d1b9777 Laurent Pinchart  2009-10-21   971  
5242658d1b9777 Laurent Pinchart  2009-10-21   972  			if ((*descriptors)->bDescriptorType != USB_DT_ENDPOINT)
5242658d1b9777 Laurent Pinchart  2009-10-21   973  				continue;
5242658d1b9777 Laurent Pinchart  2009-10-21   974  
5242658d1b9777 Laurent Pinchart  2009-10-21   975  			ep = (struct usb_endpoint_descriptor *)*descriptors;
5242658d1b9777 Laurent Pinchart  2009-10-21   976  			addr = ((ep->bEndpointAddress & 0x80) >> 3)
5242658d1b9777 Laurent Pinchart  2009-10-21   977  			     |  (ep->bEndpointAddress & 0x0f);
5242658d1b9777 Laurent Pinchart  2009-10-21   978  			set_bit(addr, f->endpoints);
5242658d1b9777 Laurent Pinchart  2009-10-21   979  		}
5242658d1b9777 Laurent Pinchart  2009-10-21   980  
40982be52d8f64 David Brownell    2008-06-19   981  		result = f->set_alt(f, tmp, 0);
40982be52d8f64 David Brownell    2008-06-19   982  		if (result < 0) {
40982be52d8f64 David Brownell    2008-06-19   983  			DBG(cdev, "interface %d (%s/%p) alt 0 --> %d\n",
40982be52d8f64 David Brownell    2008-06-19   984  					tmp, f->name, f, result);
40982be52d8f64 David Brownell    2008-06-19   985  
40982be52d8f64 David Brownell    2008-06-19   986  			reset_config(cdev);
40982be52d8f64 David Brownell    2008-06-19   987  			goto done;
40982be52d8f64 David Brownell    2008-06-19   988  		}
1b9ba000177ee4 Roger Quadros     2011-05-09   989  
1b9ba000177ee4 Roger Quadros     2011-05-09   990  		if (result == USB_GADGET_DELAYED_STATUS) {
1b9ba000177ee4 Roger Quadros     2011-05-09   991  			DBG(cdev,
1b9ba000177ee4 Roger Quadros     2011-05-09   992  			 "%s: interface %d (%s) requested delayed status\n",
1b9ba000177ee4 Roger Quadros     2011-05-09   993  					__func__, tmp, f->name);
1b9ba000177ee4 Roger Quadros     2011-05-09   994  			cdev->delayed_status++;
1b9ba000177ee4 Roger Quadros     2011-05-09   995  			DBG(cdev, "delayed_status count %d\n",
1b9ba000177ee4 Roger Quadros     2011-05-09   996  					cdev->delayed_status);
1b9ba000177ee4 Roger Quadros     2011-05-09   997  		}
40982be52d8f64 David Brownell    2008-06-19   998  	}
40982be52d8f64 David Brownell    2008-06-19   999  
40982be52d8f64 David Brownell    2008-06-19  1000  	/* when we return, be sure our power usage is valid */
bcacbf06c89137 Jack Pham         2021-07-20  1001  	if (c->MaxPower || (c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
bcacbf06c89137 Jack Pham         2021-07-20  1002  		power = c->MaxPower;
bcacbf06c89137 Jack Pham         2021-07-20  1003  	else
bcacbf06c89137 Jack Pham         2021-07-20  1004  		power = CONFIG_USB_GADGET_VBUS_DRAW;
bcacbf06c89137 Jack Pham         2021-07-20  1005  
a2035411fa1d12 Jack Pham         2020-01-30  1006  	if (gadget->speed < USB_SPEED_SUPER)
a2035411fa1d12 Jack Pham         2020-01-30  1007  		power = min(power, 500U);
a2035411fa1d12 Jack Pham         2020-01-30  1008  	else
a2035411fa1d12 Jack Pham         2020-01-30  1009  		power = min(power, 900U);
40982be52d8f64 David Brownell    2008-06-19  1010  done:
5e5caf4fa8d303 Thinh Nguyen      2020-02-03  1011  	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
5e5caf4fa8d303 Thinh Nguyen      2020-02-03  1012  		usb_gadget_set_selfpowered(gadget);
5e5caf4fa8d303 Thinh Nguyen      2020-02-03  1013  	else
5e5caf4fa8d303 Thinh Nguyen      2020-02-03  1014  		usb_gadget_clear_selfpowered(gadget);
5e5caf4fa8d303 Thinh Nguyen      2020-02-03  1015  
24ee47b2693b2d Elson Roy Serrao  2023-02-16 @1016  	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
                                                                                    ^^^^^^^^^^^^^^^
Unchecked dereference

24ee47b2693b2d Elson Roy Serrao  2023-02-16  1017  		usb_gadget_set_remote_wakeup(gadget, 1);
24ee47b2693b2d Elson Roy Serrao  2023-02-16  1018  	else
24ee47b2693b2d Elson Roy Serrao  2023-02-16  1019  		usb_gadget_set_remote_wakeup(gadget, 0);
24ee47b2693b2d Elson Roy Serrao  2023-02-16  1020  
40982be52d8f64 David Brownell    2008-06-19  1021  	usb_gadget_vbus_draw(gadget, power);
1b9ba000177ee4 Roger Quadros     2011-05-09  1022  	if (result >= 0 && cdev->delayed_status)
1b9ba000177ee4 Roger Quadros     2011-05-09  1023  		result = USB_GADGET_DELAYED_STATUS;
40982be52d8f64 David Brownell    2008-06-19  1024  	return result;
40982be52d8f64 David Brownell    2008-06-19  1025  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

