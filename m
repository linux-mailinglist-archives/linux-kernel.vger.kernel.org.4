Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A964D890
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLOJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiLOJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:28:03 -0500
X-Greylist: delayed 134053 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 01:28:02 PST
Received: from freundtech.com (freundtech.com [IPv6:2a01:4f8:c17:2d66::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC44B989;
        Thu, 15 Dec 2022 01:28:01 -0800 (PST)
Received: from [IPV6:2a00:1398:9:fb03:bb56:abd8:c620:48e2] (unknown [IPv6:2a00:1398:9:fb03:bb56:abd8:c620:48e2])
        by freundtech.com (Postfix) with ESMTPSA id C83461E38E3;
        Thu, 15 Dec 2022 10:27:59 +0100 (CET)
Message-ID: <3447483d-11bc-8ab2-8aba-96870b42281b@freund.io>
Date:   Thu, 15 Dec 2022 10:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] HID: amd_sfh: Add support for tablet-mode-switch sensor
To:     kernel test robot <lkp@intel.com>, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ivan Dovgal <iv.dovg@gmail.com>,
        "Luke D . Jones" <luke@ljones.dev>
References: <20221214214127.15347-1-adrian@freund.io>
 <202212151621.e3OmYctb-lkp@intel.com>
Content-Language: en-US
From:   Adrian Freund <adrian@freund.io>
In-Reply-To: <202212151621.e3OmYctb-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 09:22, kernel test robot wrote:
> Hi Adrian,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on hid/for-next]
> [also build test WARNING on linus/master v6.1 next-20221215]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Freund/HID-amd_sfh-Add-support-for-tablet-mode-switch-sensor/20221215-054325
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
> patch link:    https://lore.kernel.org/r/20221214214127.15347-1-adrian%40freund.io
> patch subject: [PATCH] HID: amd_sfh: Add support for tablet-mode-switch sensor
> config: x86_64-allyesconfig
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/9523955771c5517417b71bdcb1a19d8fadbc946d
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Adrian-Freund/HID-amd_sfh-Add-support-for-tablet-mode-switch-sensor/20221215-054325
>          git checkout 9523955771c5517417b71bdcb1a19d8fadbc946d
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hid/amd-sfh-hid/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     In file included from drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c:15:
>>> drivers/hid/amd-sfh-hid/sfh1_1/../hid_descriptor/amd_sfh_hid_report_desc.h:649:17: warning: 'tms_report_descriptor' defined but not used [-Wunused-const-variable=]
>       649 | static const u8 tms_report_descriptor[] = {
>           |                 ^~~~~~~~~~~~~~~~~~~~~
hid_descriptor/amd_sfh_hid_report_desc.h is included from both 
hid_descriptor/amd_sfh_hid_desc.c and sfh1_1/amd_sfh_desc.c, the first 
of which has 4 usages of tms_report_descriptor. The later is for sensor 
fusion hub 1.1. I don't have access to a devices using sfh1.1, so I 
can't add support for the tablet mode switch there, causing the variable 
to be unused for that import.
>
> vim +/tms_report_descriptor +649 drivers/hid/amd-sfh-hid/sfh1_1/../hid_descriptor/amd_sfh_hid_report_desc.h
>
>     646	
>     647	
>     648	/* TABLET MODE SWITCH */
>   > 649	static const u8 tms_report_descriptor[] = {
>     650	0x06, 0x43, 0xFF,  // Usage Page (Vendor Defined 0xFF43)
>     651	0x0A, 0x02, 0x02,  // Usage (0x0202)
>     652	0xA1, 0x01, // Collection (Application)
>     653	0x85, 0x11, //   Report ID (17)
>     654	0x15, 0x00, //   Logical Minimum (0)
>     655	0x25, 0x01, //   Logical Maximum (1)
>     656	0x35, 0x00, //   Physical Minimum (0)
>     657	0x45, 0x01, //   Physical Maximum (1)
>     658	0x65, 0x00, //   Unit (None)
>     659	0x55, 0x00, //   Unit Exponent (0)
>     660	0x75, 0x01, //   Report Size (1)
>     661	0x95, 0x98, //   Report Count (-104)
>     662	0x81, 0x03, //   Input (Const,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
>     663	0x91, 0x03, //   Output (Const,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
>     664	0xC1, 0x00, // End Collection
>     665	};
>     666	
>
Adrian
