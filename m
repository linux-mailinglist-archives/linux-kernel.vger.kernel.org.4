Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584AA6B7913
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCMNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:36:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B760AB4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678714576; x=1710250576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5h+QUXKm4/ckcXXvfA6HcIV4/4fXWXpzldKjSinPsqw=;
  b=g+JqeMQYP4xo/x4Yx9VWiouWTCTdoCKsM/AUy+9ZaR4bwb5/2q4Wx6W+
   GeSoQ3tU3ROYDrnd//2L4yVD+HILBuxAIr3TiXYbvF2Obgdmme+vvgz/N
   1gtX3utnpciDyetmO6nhNUgqPZ2Fx1dgf3QYNmRXzm3dOzyBK17ziaOG6
   aqwpKIjM6yg5mgKl8BrFW3XtZr/Vr9XJN79jvKTxNAcsGgFU0LpfYmbGU
   Mh2x1fzvQjl2tYy/QU6oXZJ0r4nBqT+LdPLoJmoxE++UPHlnRfMRyo0Hs
   xfL/cWsh0CT9jYQ7MM8Ihn1xOWOVeI7HVK0qPBIm6e0KKoWwQ2ZfVvgmJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364809168"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="364809168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="821963737"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="821963737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2023 06:36:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbiLV-002eIo-2i;
        Mon, 13 Mar 2023 15:36:13 +0200
Date:   Mon, 13 Mar 2023 15:36:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] devres: Pass unique name of the resource to
 devm_add_action() P.S.
Message-ID: <ZA8mzVSi8C13WVes@smile.fi.intel.com>
References: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
 <83bebd97-ba44-9e19-d66c-95b43b123797@alu.unizg.hr>
 <ZAs6nZz05C016l0E@smile.fi.intel.com>
 <b4c5a280-c619-4713-0295-75d67aefbaeb@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c5a280-c619-4713-0295-75d67aefbaeb@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:03:03AM +0100, Mirsad Goran Todorovac wrote:
> On 10. 03. 2023. 15:11, Andy Shevchenko wrote:

...

> In  particular, when comparing to the old test results without the last change:
> 
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ea28d384 action (16 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000cb0e6b1 devm_kzalloc_release (16 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000056043cc0 devm_kzalloc_release (40 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c904ae95 devm_kzalloc_release (24 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cd39c068 devm_kzalloc_release (40 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000918a0de4 devm_kzalloc_release (40 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000008192a378 devm_kzalloc_release (10 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000004090f288 action (16 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000004090f288 action (16 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000008192a378 devm_kzalloc_release (10 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000918a0de4 devm_kzalloc_release (40 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cd39c068 devm_kzalloc_release (40 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c904ae95 devm_kzalloc_release (24 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000056043cc0 devm_kzalloc_release (40 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000cb0e6b1 devm_kzalloc_release (16 bytes)
> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ea28d384 action (16 bytes)
> 
> .. there were these "action" calls with (16 bytes).
> 
> Now those look like this, if I figured it out well:
> 
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000567cd854 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000098394533 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000064c8d56b devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000007c05a459 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000056f5b5e6 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ab3f962b devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000c0a797cb devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000007ad662a5 gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000d12bc3dc devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000002de3d4c9 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000002de3d4c9 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000d12bc3dc devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000007ad662a5 gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000c0a797cb devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ab3f962b devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000056f5b5e6 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000007c05a459 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cbf11512 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000023cc8968 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cd9fed5b devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000e2c397e4 devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cb4dbe1d gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000065384fb9 devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000fe114c27 devm_kzalloc_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000001c3cf972 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000001c3cf972 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000fe114c27 devm_kzalloc_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000065384fb9 devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cb4dbe1d gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000e2c397e4 devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cd9fed5b devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000023cc8968 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000cbf11512 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000477f9c62 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000210ce87c devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000629819f6 devm_bitmap_free (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000023a7be05 devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000001723fc6e gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000b9b893b devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:00 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000493d92e3 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000493d92e3 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000b9b893b devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000001723fc6e gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 0000000023a7be05 devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000629819f6 devm_bitmap_free (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000210ce87c devm_bitmap_free (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000477f9c62 devm_bitmap_free (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000064ebe727 devm_bitmap_free (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 0000000050ab06c8 devm_bitmap_free (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000f848380a devm_bitmap_free (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000cca4b2d6 devm_irq_domain_remove_sim (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000008be0d08c gpio_sim_mutex_destroy (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000db6dfc59 devm_gpio_chip_release (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000000eaf3f56 gpio_sim_sysfs_remove (16 bytes)
> Mar 10 23:42:01 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000000eaf3f56 gpio_sim_sysfs_remove (16 bytes)
> 
> I hope this helps the big picture.

Yes, thanks! I have sent a formal patch with added Reported and Tested tags
(I hope you are fine with them, because it's what you actually did in this
 thread by all means).

-- 
With Best Regards,
Andy Shevchenko


