Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6B7461DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGCSMQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 14:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGCSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:12:13 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B983E5F;
        Mon,  3 Jul 2023 11:12:05 -0700 (PDT)
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
X-GND-Sasl: hadess@hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C6B01BF205;
        Mon,  3 Jul 2023 18:12:03 +0000 (UTC)
Message-ID: <0895ee64688ee3c839e6737dada9f17a7b92a39c.camel@hadess.net>
Subject: Re: [PATCH v5] HID: steelseries: Add support for Arctis 1 XBox
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <bentiss@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     linux-input@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 03 Jul 2023 20:12:03 +0200
In-Reply-To: <ytk64symj6g2rsoy5jfe4gpojiska7plv5w4lmofm7vifrap5h@4lpu33rqodos>
References: <20230703102918.9941-1-hadess@hadess.net>
         <202307032208.b5brKeCt-lkp@intel.com>
         <ytk64symj6g2rsoy5jfe4gpojiska7plv5w4lmofm7vifrap5h@4lpu33rqodos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-03 at 17:33 +0200, Benjamin Tissoires wrote:
> 
> On Jul 03 2023, kernel test robot wrote:
> > 
> > Hi Bastien,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on hid/for-next]
> > [also build test ERROR on linus/master v6.4 next-20230703]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:   
> > https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/HID-steelseries-Add-support-for-Arctis-1-XBox/20230703-183124
> > base:  
> > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-
> > next
> > patch link:   
> > https://lore.kernel.org/r/20230703102918.9941-1-hadess%40hadess.net
> > patch subject: [PATCH v5] HID: steelseries: Add support for Arctis
> > 1 XBox
> > config: parisc-randconfig-r032-20230703
> > (https://download.01.org/0day-ci/archive/20230703/202307032208.b5br
> > KeCt-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 12.3.0
> > reproduce:
> > (https://download.01.org/0day-ci/archive/20230703/202307032208.b5br
> > KeCt-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-kbuild-all/202307032208.b5brKeCt-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    hppa-linux-ld: drivers/hid/hid-steelseries.o: in function
> > `.LC10':
> > > > hid-steelseries.c:(.rodata.cst4+0x8): undefined reference to
> > > > `hid_is_usb'
> 
> Bastien, you need a depends on USB_HID IIRC in your Kconfig (at
> least CONFIG_USB_HID is not set in that kernel test bot run).

Yeah, I just get to undo the changes from v3 ;)
