Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53874497F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGAOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGAOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:01:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F4E60;
        Sat,  1 Jul 2023 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688220076; x=1719756076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XALiU6KHKiv9lt5YCCAWpjAQMhP1DlQ7UoS+tkKoHmk=;
  b=b17qP4TyywJZubMsz6LZxTXsix5W5z6lpxxclbx3lhjLLxw4wIco0fG1
   Grd8FekX/DYhLriyZ4Xa26cZUd1HeuQIULX+Nm2eLvxy4cgcxC8C9LYZF
   UcIt3ZAk0uRj/hrs30nZ5HrpjU+tJRy+VAG6UFt/Wqo1RixHwjvB5lYjk
   vlRs5gqe/yPJExkfh+kLCuqm7Qqb/1i225KfIyyGF88AFtoCCfG/adaLT
   JkoCZo3NQfJZA5aYYGUCwIM3ObksL3FpTM/iganxH1q/uHolp9qnKRNc/
   1ntzkJwD6+B59j+cnLTXpLyTW8A8IiozoGVs9Nx7l9nlSemhH+6GRcEHI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="361448026"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="361448026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 07:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="712089546"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="712089546"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2023 07:01:13 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFbA0-000G3V-0O;
        Sat, 01 Jul 2023 14:01:12 +0000
Date:   Sat, 1 Jul 2023 22:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julius Zint <julius@zint.sh>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Julius Zint <julius@zint.sh>
Subject: Re: [PATCH 1/1] backlight: apple_bl_usb: Add Apple Studio Display
 support
Message-ID: <202307012107.OW4d1gBR-lkp@intel.com>
References: <20230701120806.11812-2-julius@zint.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701120806.11812-2-julius@zint.sh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julius,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-backlight/for-backlight-next]
[also build test WARNING on lee-leds/for-leds-next drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.4 next-20230630]
[cannot apply to lee-backlight/for-backlight-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julius-Zint/backlight-apple_bl_usb-Add-Apple-Studio-Display-support/20230701-202142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git for-backlight-next
patch link:    https://lore.kernel.org/r/20230701120806.11812-2-julius%40zint.sh
patch subject: [PATCH 1/1] backlight: apple_bl_usb: Add Apple Studio Display support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230701/202307012107.OW4d1gBR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307012107.OW4d1gBR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307012107.OW4d1gBR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/video/backlight/apple_bl_usb.c:27:6: warning: no previous prototype for 'init_ctrl_msg_data' [-Wmissing-prototypes]
      27 | void init_ctrl_msg_data(struct brightness_ctrl_message_data *msg)
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:33:6: warning: no previous prototype for 'set_ctrl_message_brightness' [-Wmissing-prototypes]
      33 | void set_ctrl_message_brightness(struct brightness_ctrl_message_data *msg,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:39:5: warning: no previous prototype for 'get_ctrl_message_brightness' [-Wmissing-prototypes]
      39 | u16 get_ctrl_message_brightness(struct brightness_ctrl_message_data *msg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:44:5: warning: no previous prototype for 'apple_bl_usb_usb_get_brightness' [-Wmissing-prototypes]
      44 | int apple_bl_usb_usb_get_brightness(struct usb_interface *interface,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:79:5: warning: no previous prototype for 'apple_bl_usb_usb_set_brightness' [-Wmissing-prototypes]
      79 | int apple_bl_usb_usb_set_brightness(struct usb_interface *interface,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:113:5: warning: no previous prototype for 'apple_bl_usb_check_fb' [-Wmissing-prototypes]
     113 | int apple_bl_usb_check_fb(struct backlight_device *bd, struct fb_info *info)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:119:5: warning: no previous prototype for 'apple_bl_usb_get_brightness' [-Wmissing-prototypes]
     119 | int apple_bl_usb_get_brightness(struct backlight_device *bl)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/video/backlight/apple_bl_usb.c:135:5: warning: no previous prototype for 'apple_bl_usb_update_status' [-Wmissing-prototypes]
     135 | int apple_bl_usb_update_status(struct backlight_device *bl)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/init_ctrl_msg_data +27 drivers/video/backlight/apple_bl_usb.c

    26	
  > 27	void init_ctrl_msg_data(struct brightness_ctrl_message_data *msg)
    28	{
    29		memset(msg, 0, sizeof(struct brightness_ctrl_message_data));
    30		msg->unknown_1 = 0x01;
    31	}
    32	
  > 33	void set_ctrl_message_brightness(struct brightness_ctrl_message_data *msg,
    34					 u16 brightness_value)
    35	{
    36		msg->brightness = cpu_to_le16(brightness_value + 400);
    37	}
    38	
  > 39	u16 get_ctrl_message_brightness(struct brightness_ctrl_message_data *msg)
    40	{
    41		return le16_to_cpu(msg->brightness) - 400;
    42	}
    43	
  > 44	int apple_bl_usb_usb_get_brightness(struct usb_interface *interface,
    45					    struct usb_device *usb_dev,
    46					    int *brightness)
    47	{
    48		int err;
    49		u16 interface_nr;
    50		int msg_data_size;
    51		struct brightness_ctrl_message_data *msg_data;
    52	
    53		msg_data_size = sizeof(struct brightness_ctrl_message_data);
    54		msg_data = kzalloc(msg_data_size, GFP_KERNEL);
    55		memset(msg_data, 0x00, msg_data_size);
    56		interface_nr = interface->cur_altsetting->desc.bInterfaceNumber;
    57	
    58		err = usb_control_msg(usb_dev,
    59				      usb_rcvctrlpipe(usb_dev, 0),
    60				      HID_GET_REPORT,
    61				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
    62				      /* wValue: HID-Report Type and Report ID */
    63				      HID_REPORT_TYPE_FEATURE | 0x01,
    64				      interface_nr /* wIndex */,
    65				      msg_data,
    66				      msg_data_size,
    67				      HZ);
    68		if (err < 0) {
    69			dev_err(&interface->dev,
    70				"get: usb control message err: %d\n",
    71				err);
    72		}
    73		*brightness = get_ctrl_message_brightness(msg_data);
    74		kfree(msg_data);
    75		dev_dbg(&interface->dev, "get brightness: %d\n", *brightness);
    76		return 0;
    77	}
    78	
  > 79	int apple_bl_usb_usb_set_brightness(struct usb_interface *interface,
    80					    struct usb_device *usb_dev,
    81					    int brightness)
    82	{
    83		int err;
    84		u16 interface_nr;
    85		struct brightness_ctrl_message_data *msg_data;
    86	
    87		msg_data = kzalloc(sizeof(struct brightness_ctrl_message_data), GFP_KERNEL);
    88		interface_nr = interface->cur_altsetting->desc.bInterfaceNumber;
    89		init_ctrl_msg_data(msg_data);
    90		set_ctrl_message_brightness(msg_data, brightness);
    91	
    92		err = usb_control_msg(usb_dev,
    93				      usb_sndctrlpipe(usb_dev, 0),
    94				      HID_SET_REPORT,
    95				      USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
    96				      /* wValue: HID-Report Type and Report ID */
    97				      HID_REPORT_TYPE_FEATURE | 0x01,
    98				      interface_nr /* wIndex */,
    99				      msg_data,
   100				      sizeof(struct brightness_ctrl_message_data),
   101				      HZ);
   102		kfree(msg_data);
   103		if (err < 0) {
   104			dev_err(&interface->dev,
   105				"set: usb control message err: %d\n",
   106				err);
   107			return err;
   108		}
   109		dev_dbg(&interface->dev, "set brightness: %d\n", brightness);
   110		return 0;
   111	}
   112	
 > 113	int apple_bl_usb_check_fb(struct backlight_device *bd, struct fb_info *info)
   114	{
   115		dev_info(&bd->dev, "check fb\n");
   116		return 0;
   117	}
   118	
 > 119	int apple_bl_usb_get_brightness(struct backlight_device *bl)
   120	{
   121		int ret;
   122		struct apple_bl_usb_data *data;
   123		int hw_brightness;
   124	
   125		data = bl_get_data(bl);
   126		ret = apple_bl_usb_usb_get_brightness(data->usb_interface,
   127						      data->usb_dev,
   128						      &hw_brightness);
   129		if (!ret)
   130			ret = hw_brightness;
   131	
   132		return ret;
   133	}
   134	
 > 135	int apple_bl_usb_update_status(struct backlight_device *bl)
   136	{
   137		int err;
   138		struct apple_bl_usb_data *data;
   139	
   140		data = bl_get_data(bl);
   141		err = apple_bl_usb_usb_set_brightness(data->usb_interface,
   142						      data->usb_dev,
   143						      bl->props.brightness);
   144		return err;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
