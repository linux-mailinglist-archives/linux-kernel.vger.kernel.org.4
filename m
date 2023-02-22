Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBF69EE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBVGHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBVGHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:07:36 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705762D159;
        Tue, 21 Feb 2023 22:07:35 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9431929e93=fe@dev.tdt.de>)
        id 1pUiHd-000K5O-FA; Wed, 22 Feb 2023 07:07:17 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pUiHc-000K5D-C8; Wed, 22 Feb 2023 07:07:16 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id CE2EB240049;
        Wed, 22 Feb 2023 07:07:15 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 2B019240040;
        Wed, 22 Feb 2023 07:07:15 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 846272CED9;
        Wed, 22 Feb 2023 07:07:14 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Feb 2023 07:07:14 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     kernel test robot <lkp@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v5 2/2] trigger: ledtrig-tty: add additional modes
In-Reply-To: <202302220740.2RKDHnof-lkp@intel.com>
References: <20230221081901.15557-3-fe@dev.tdt.de>
 <202302220740.2RKDHnof-lkp@intel.com>
Message-ID: <deee30ef43e397233dd15d11b86ae91a@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1677046037-E4E6EA38-2A030915/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-22 01:02, kernel test robot wrote:
> Hi Florian,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tty/tty-testing]
> [also build test WARNING on tty/tty-next tty/tty-linus
> staging/staging-testing staging/staging-next staging/staging-linus
> pavel-leds/for-next linus/master v6.2 next-20230221]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:
> https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230221-162126
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> tty-testing
> patch link:    
> https://lore.kernel.org/r/20230221081901.15557-3-fe%40dev.tdt.de
> patch subject: [PATCH v5 2/2] trigger: ledtrig-tty: add additional 
> modes
> reproduce:
>         #
> https://github.com/intel-lab-lkp/linux/commit/445b7555bccd279bf106995ee42f5dbef2e97c8b
>         git remote add linux-review 
> https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review
> Florian-Eckert/tty-new-helper-function-tty_get_mget/20230221-162126
>         git checkout 445b7555bccd279bf106995ee42f5dbef2e97c8b
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS,
> CONFIG_WARN_ABI_ERRORS
>         make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link:
> https://lore.kernel.org/oe-kbuild-all/202302220740.2RKDHnof-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Documentation/ABI/testing/sysfs-class-led-trigger-tty:9: WARNING: 
>>> Unexpected indentation.
>>> Documentation/ABI/testing/sysfs-class-led-trigger-tty:9: WARNING: 
>>> Block quote ends without a blank line; unexpected unindent.
> 
> vim +9 Documentation/ABI/testing/sysfs-class-led-trigger-tty
> 
>    > 9	Date:		January 2023

I apologies for the question! But I don't know what the test buildbot 
here wants from me.
I've looked at the other files and I can't find anything that stands 
out.

--
Regards Florian
