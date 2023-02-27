Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4786A3DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjB0JK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjB0JKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:10:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45828EC4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:02:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWYyM-0001rR-Ow; Mon, 27 Feb 2023 09:35:02 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWYyL-00049n-Bm; Mon, 27 Feb 2023 09:35:01 +0100
Date:   Mon, 27 Feb 2023 09:35:01 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used
 uninitialized
Message-ID: <20230227083501.nlep2r3ng5d4vkot@pengutronix.de>
References: <202302240951.roaFGUy5-lkp@intel.com>
 <20230224084559.x2ceoc6r24uh3wms@pengutronix.de>
 <CAMuHMdXOr5OFwte3FNVXRUERRwJiqxVXgwCjGC_y6jxmftxrLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXOr5OFwte3FNVXRUERRwJiqxVXgwCjGC_y6jxmftxrLA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 23-02-24, Geert Uytterhoeven wrote:
> Hi Marco,
> 
> On Fri, Feb 24, 2023 at 9:58 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > On 23-02-24, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   e4bc15889506723d7b93c053ad4a75cd58248d74
> > > commit: 80a21da360516fa602f3a50eb9792f9dfbfb5fdb media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver
> > > date:   4 months ago
> > > config: arc-randconfig-r031-20230223 (https://download.01.org/0day-ci/archive/20230224/202302240951.roaFGUy5-lkp@intel.com/config)
> > > compiler: arceb-elf-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80a21da360516fa602f3a50eb9792f9dfbfb5fdb
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 80a21da360516fa602f3a50eb9792f9dfbfb5fdb
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/media/i2c/
> >
> > This is still a false positive, should we initialize p_best to make the
> > compiler happy? I think Hans did this once, but he said that this will
> > be gone with gcc-13 if I remember correctly.
> 
> Are you sure this is a false positive?
> 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link: https://lore.kernel.org/oe-kbuild-all/202302240951.roaFGUy5-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    drivers/media/i2c/tc358746.c: In function 'tc358746_find_pll_settings':
> > > >> drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used uninitialized [-Wuninitialized]
> > >      817 |         u16 p_best, p;
> > >          |             ^~~~~~
> > > >> drivers/media/i2c/tc358746.c:816:13: warning: 'm_best' is used uninitialized [-Wuninitialized]
> > >      816 |         u16 m_best, mul;
> > >          |             ^~~~~~
> > >
> > >
> > > vim +/p_best +817 drivers/media/i2c/tc358746.c
> > >
> > >    805
> > >    806        static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
> > >    807                                                        unsigned long refclk,
> > >    808                                                        unsigned long fout)
> > >    809
> > >    810        {
> > >    811                struct device *dev = tc358746->sd.dev;
> > >    812                unsigned long best_freq = 0;
> > >    813                u32 min_delta = 0xffffffff;
> > >    814                u16 prediv_max = 17;
> > >    815                u16 prediv_min = 1;
> > >  > 816                u16 m_best, mul;
> > >  > 817                u16 p_best, p;
> > >    818                u8 postdiv;
> > >    819
> > >    820                if (fout > 1000 * HZ_PER_MHZ) {
> > >    821                        dev_err(dev, "HS-Clock above 1 Ghz are not supported\n");
> > >    822                        return 0;
> > >    823                }
> > >    824
> > >    825                if (fout >= 500 * HZ_PER_MHZ)
> > >    826                        postdiv = 1;
> > >    827                else if (fout >= 250 * HZ_PER_MHZ)
> > >    828                        postdiv = 2;
> > >    829                else if (fout >= 125 * HZ_PER_MHZ)
> > >    830                        postdiv = 4;
> > >    831                else
> > >    832                        postdiv = 8;
> > >    833
> > >    834                for (p = prediv_min; p <= prediv_max; p++) {
> > >    835                        unsigned long delta, fin;
> > >    836                        u64 tmp;
> > >    837
> > >    838                        fin = DIV_ROUND_CLOSEST(refclk, p);
> > >    839                        if (fin < 4 * HZ_PER_MHZ || fin > 40 * HZ_PER_MHZ)
> > >    840                                continue;
> > >    841
> > >    842                        tmp = fout * p * postdiv;
> > >    843                        do_div(tmp, fin);
> > >    844                        mul = tmp;
> > >    845                        if (mul > 511)
> > >    846                                continue;
> > >    847
> > >    848                        tmp = mul * fin;
> > >    849                        do_div(tmp, p * postdiv);
> > >    850
> > >    851                        delta = abs(fout - tmp);
> > >    852                        if (delta < min_delta) {
> 
> So you assume this branch will be taken at least once.
> However, if the smallest delta is 0xffffffff, this is never true.
> Moreover, tmp is u64, while delta is unsigned long, which is
> either 32-bit or 64-bit (it is 32-bit on ARC, I think).

You're right about the u64/unsigned long problem, I will check this :)
But for 'p_best' usaage I'm sure, since we initialze best_freq to zero
and set it only within this if where we set p_best too.

> So I think the code can definitely be improved by cleaning up
> the types, possibly killing the warning as well...
> 
> > >    853                                p_best = p;
> > >    854                                m_best = mul;
> > >    855                                min_delta = delta;
> > >    856                                best_freq = tmp;
> > >    857                        };
> > >    858
> > >    859                        if (delta == 0)
> > >    860                                break;
> > >    861                };
> > >    862
> > >    863                if (!best_freq) {
> > >    864                        dev_err(dev, "Failed find PLL frequency\n");
> > >    865                        return 0;
> > >    866                }

If the above if wasn't reached, we will never pass the above if.

Regards,
  Marco

> > >    867
> > >    868                tc358746->pll_post_div = postdiv;
> > >    869                tc358746->pll_pre_div = p_best;
> > >    870                tc358746->pll_mul = m_best;
> > >    871
> > >    872                if (best_freq != fout)
> > >    873                        dev_warn(dev, "Request PLL freq:%lu, found PLL freq:%lu\n",
> > >    874                                 fout, best_freq);
> > >    875
> > >    876                dev_dbg(dev, "Found PLL settings: freq:%lu prediv:%u multi:%u postdiv:%u\n",
> > >    877                        best_freq, p_best, m_best, postdiv);
> > >    878
> > >    879                return best_freq;
> > >    880        }
> > >    881
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
