Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B5743C74
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjF3NOH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjF3NOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:14:01 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266643AB2;
        Fri, 30 Jun 2023 06:13:55 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 924976000C;
        Fri, 30 Jun 2023 13:13:53 +0000 (UTC)
Message-ID: <3b3169620f6a8594a78d592a21153fda70edbfda.camel@hadess.net>
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 1 XBox
From:   Bastien Nocera <hadess@hadess.net>
To:     kernel test robot <lkp@intel.com>, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 30 Jun 2023 15:13:53 +0200
In-Reply-To: <202306300419.dmlkSoqD-lkp@intel.com>
References: <20230629172041.3771-1-hadess@hadess.net>
         <202306300419.dmlkSoqD-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-30 at 04:32 +0800, kernel test robot wrote:
> Hi Bastien,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on hid/for-next]
> [also build test ERROR on linus/master v6.4 next-20230629]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:   
> https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/HID-steelseries-Add-support-for-Arctis-1-XBox/20230630-012252
> base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
> patch link:   
> https://lore.kernel.org/r/20230629172041.3771-1-hadess%40hadess.net
> patch subject: [PATCH] HID: steelseries: Add support for Arctis 1
> XBox
> config: arc-randconfig-r035-20230629
> (https://download.01.org/0day-ci/archive/20230630/202306300419.dmlkSo
> qD-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 12.3.0
> reproduce:
> (https://download.01.org/0day-ci/archive/20230630/202306300419.dmlkSo
> qD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202306300419.dmlkSoqD-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arceb-elf-ld: drivers/hid/hid-steelseries.o: in function
> `steelseries_headset_raw_event':
> > > hid-steelseries.c:(.text+0x344): undefined reference to
> > > `usb_set_wireless_status'
> > > arceb-elf-ld: hid-steelseries.c:(.text+0x344): undefined
> > > reference to `usb_set_wireless_status'
>    arceb-elf-ld: drivers/hid/hid-steelseries.o: in function
> `steelseries_probe':
>    hid-steelseries.c:(.text+0x790): undefined reference to
> `usb_set_wireless_status'
>    arceb-elf-ld: hid-steelseries.c:(.text+0x790): undefined reference
> to `usb_set_wireless_status'

The KConfig was missing a dependency on USB (and not USB HID...), fixed
in v3.
