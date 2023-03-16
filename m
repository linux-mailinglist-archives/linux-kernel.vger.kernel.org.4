Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24356BC28C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjCPAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjCPAbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:31:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F49F056;
        Wed, 15 Mar 2023 17:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678926677; x=1710462677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQjCpDdlBQOPYNMm3lvVMmFMiyKlXDKFGgNr7hy+Aoc=;
  b=hmmVXinuxSHfQ7ak7PaQlHrcZN77OxWDKGXpeQ3Re6EBoO5hAv6Vg22Q
   HIocIWoSHDD+h4TX3csbH/WXNzYXy7fioh8a8NBiUTI0QxCJN8Z1pl3MA
   y0t+JA0MI5k3eZMwUQGqh8P12bh3Kc3NY8r43aQVz3TDazofVFfLlCrv/
   I6ClO2Cjlui9pQUZVx/Emoz1kxyznpET2SCPaIqSXULIHCT0Rx9AtsNMp
   5rIkjIvbVSpfaYuulVNal+nx/5UKxpPcm5N+ZertKhkcrMMBs/JrVkgGU
   EDWIar1p3zHckoe90Mb7qWYddpTOhhfUmYL9zoLLrI1+wriUfk9XN32gy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="336540969"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="336540969"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="712126055"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="712126055"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2023 17:31:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcbWT-00089a-1r;
        Thu, 16 Mar 2023 00:31:13 +0000
Date:   Thu, 16 Mar 2023 08:30:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
Message-ID: <202303160838.j3Q18WnL-lkp@intel.com>
References: <20230315220246.951213-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315220246.951213-2-alvin@pqrs.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on chanwoo-extcon/extcon-next]
[cannot apply to linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alvin-ipraga/extcon-usbc-tusb320-add-usb_role_switch-support/20230316-060433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
patch link:    https://lore.kernel.org/r/20230315220246.951213-2-alvin%40pqrs.dk
patch subject: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230316/202303160838.j3Q18WnL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8ed7905410ebc9e2de0bd58d4cdd0a8225529f42
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alvin-ipraga/extcon-usbc-tusb320-add-usb_role_switch-support/20230316-060433
        git checkout 8ed7905410ebc9e2de0bd58d4cdd0a8225529f42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160838.j3Q18WnL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/extcon/extcon-usbc-tusb320.c: In function 'tusb320_typec_irq_handler':
>> drivers/extcon/extcon-usbc-tusb320.c:280:33: warning: unused variable 'role_sw' [-Wunused-variable]
     280 |         struct usb_role_switch *role_sw = priv->role_sw;
         |                                 ^~~~~~~


vim +/role_sw +280 drivers/extcon/extcon-usbc-tusb320.c

   277	
   278	static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
   279	{
 > 280		struct usb_role_switch *role_sw = priv->role_sw;
   281		struct typec_port *port = priv->port;
   282		struct device *dev = priv->dev;
   283		int typec_mode;
   284		enum usb_role usb_role;
   285		enum typec_role pwr_role;
   286		enum typec_data_role data_role;
   287		u8 state, mode, accessory;
   288		int ret, reg8;
   289		bool ori;
   290	
   291		ret = regmap_read(priv->regmap, TUSB320_REG8, &reg8);
   292		if (ret) {
   293			dev_err(dev, "error during reg8 i2c read, ret=%d!\n", ret);
   294			return;
   295		}
   296	
   297		ori = reg9 & TUSB320_REG9_CABLE_DIRECTION;
   298		typec_set_orientation(port, ori ? TYPEC_ORIENTATION_REVERSE :
   299						  TYPEC_ORIENTATION_NORMAL);
   300	
   301		state = FIELD_GET(TUSB320_REG9_ATTACHED_STATE, reg9);
   302		accessory = FIELD_GET(TUSB320_REG8_ACCESSORY_CONNECTED, reg8);
   303	
   304		switch (state) {
   305		case TUSB320_ATTACHED_STATE_DFP:
   306			typec_mode = TYPEC_MODE_USB2;
   307			usb_role = USB_ROLE_HOST;
   308			pwr_role = TYPEC_SOURCE;
   309			data_role = TYPEC_HOST;
   310			break;
   311		case TUSB320_ATTACHED_STATE_UFP:
   312			typec_mode = TYPEC_MODE_USB2;
   313			usb_role = USB_ROLE_DEVICE;
   314			pwr_role = TYPEC_SINK;
   315			data_role = TYPEC_DEVICE;
   316			break;
   317		case TUSB320_ATTACHED_STATE_ACC:
   318			/*
   319			 * Accessory detected. For debug accessories, just make some
   320			 * qualified guesses as to the role for lack of a better option.
   321			 */
   322			if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
   323			    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
   324				typec_mode = TYPEC_MODE_AUDIO;
   325				usb_role = USB_ROLE_NONE;
   326				pwr_role = TYPEC_SINK;
   327				data_role = TYPEC_DEVICE;
   328				break;
   329			} else if (accessory ==
   330				   TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP) {
   331				typec_mode = TYPEC_MODE_DEBUG;
   332				pwr_role = TYPEC_SOURCE;
   333				usb_role = USB_ROLE_HOST;
   334				data_role = TYPEC_HOST;
   335				break;
   336			} else if (accessory ==
   337				   TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP) {
   338				typec_mode = TYPEC_MODE_DEBUG;
   339				pwr_role = TYPEC_SINK;
   340				usb_role = USB_ROLE_DEVICE;
   341				data_role = TYPEC_DEVICE;
   342				break;
   343			}
   344	
   345			dev_warn(priv->dev, "unexpected ACCESSORY_CONNECTED state %d\n",
   346				 accessory);
   347	
   348			fallthrough;
   349		default:
   350			typec_mode = TYPEC_MODE_USB2;
   351			usb_role = USB_ROLE_NONE;
   352			pwr_role = TYPEC_SINK;
   353			data_role = TYPEC_DEVICE;
   354			break;
   355		}
   356	
   357		typec_set_vconn_role(port, pwr_role);
   358		typec_set_pwr_role(port, pwr_role);
   359		typec_set_data_role(port, data_role);
   360		typec_set_mode(port, typec_mode);
   361		usb_role_switch_set_role(priv->role_sw, usb_role);
   362	
   363		mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
   364		if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
   365			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_USB);
   366		else if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_MED)
   367			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_1_5A);
   368		else if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_HI)
   369			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_3_0A);
   370		else	/* Charge through accessory */
   371			typec_set_pwr_opmode(port, TYPEC_PWR_MODE_USB);
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
