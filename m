Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F3745FED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGCPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4911D118;
        Mon,  3 Jul 2023 08:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D0460F7B;
        Mon,  3 Jul 2023 15:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992A8C433C9;
        Mon,  3 Jul 2023 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688398423;
        bh=e8uzFKn3JjmEEYVf6xvQtxaIGsrQL5C9R4nrho6k6oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcntmiAF3up6+h5CsvQ52u4Pyox4gyWJfpWYRwhixOvJkMJVcwbGolVokQ+4W4MAk
         WfPGWhNT0T9JPx6Yg0Ce6herIDTtXA134CWu+OUqBZEIT3ls2kK7PaW7d/HdfOilP8
         gFtGskxYusxtSUFFV2RaTtP6mizXN1PDk9etNtuVP/jR4cD0IWgG1njFj3beFjpi0O
         OVeoNhQs2Ax8ucrjx4tOrv9z65st/loEytD2wC78Yxp5cG2f8ISPl5AKd2Swceuuk9
         2Ji2dDw44IDar3E+1HoeKbTXGIqdmujYewTpfbXhYVUBhYGzjB28rjcAtLUlA/y4sJ
         tst3va7NVPNpg==
Date:   Mon, 3 Jul 2023 17:33:38 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5] HID: steelseries: Add support for Arctis 1 XBox
Message-ID: <ytk64symj6g2rsoy5jfe4gpojiska7plv5w4lmofm7vifrap5h@4lpu33rqodos>
References: <20230703102918.9941-1-hadess@hadess.net>
 <202307032208.b5brKeCt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307032208.b5brKeCt-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 03 2023, kernel test robot wrote:
> 
> Hi Bastien,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on hid/for-next]
> [also build test ERROR on linus/master v6.4 next-20230703]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/HID-steelseries-Add-support-for-Arctis-1-XBox/20230703-183124
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
> patch link:    https://lore.kernel.org/r/20230703102918.9941-1-hadess%40hadess.net
> patch subject: [PATCH v5] HID: steelseries: Add support for Arctis 1 XBox
> config: parisc-randconfig-r032-20230703 (https://download.01.org/0day-ci/archive/20230703/202307032208.b5brKeCt-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230703/202307032208.b5brKeCt-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307032208.b5brKeCt-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    hppa-linux-ld: drivers/hid/hid-steelseries.o: in function `.LC10':
> >> hid-steelseries.c:(.rodata.cst4+0x8): undefined reference to `hid_is_usb'

Bastien, you need a depends on USB_HID IIRC in your Kconfig (at
least CONFIG_USB_HID is not set in that kernel test bot run).

Cheers,
Benjamin

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
