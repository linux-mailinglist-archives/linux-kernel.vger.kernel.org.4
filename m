Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000035E6860
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIVQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIVQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:29:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA4E6A03
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:29:14 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYLG02zHlz67VyR;
        Fri, 23 Sep 2022 00:24:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 18:29:11 +0200
Received: from localhost (10.81.208.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 17:29:11 +0100
Date:   Thu, 22 Sep 2022 17:29:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, <jic23@kernel.org>
Subject: Re: [jic23-iio:testing 58/58] drivers/iio/adc/mcp3911.c:274:6:
 warning: variable 'tmp0' set but not used
Message-ID: <20220922172909.00005beb@huawei.com>
In-Reply-To: <YyyCJX374uWYrPTN@gmail.com>
References: <202209220845.GmS9zryR-lkp@intel.com>
        <20220922115925.00004ec9@huawei.com>
        <YyyCJX374uWYrPTN@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 17:41:25 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> On Thu, Sep 22, 2022 at 11:59:25AM +0100, Jonathan Cameron wrote:
> > On Thu, 22 Sep 2022 08:50:17 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >   
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > > head:   d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > > commit: d4e1a549566b9ea8b96e80f0cdcbe99714ac256e [58/58] iio: adc: mcp3911: add support to set PGA
> > > config: x86_64-randconfig-a012
> > > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > >         git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> > >         git fetch --no-tags jic23-iio testing
> > >         git checkout d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/adc/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > >   
> > > >> drivers/iio/adc/mcp3911.c:274:6: warning: variable 'tmp0' set but not used [-Wunused-but-set-variable]    
> > >            int tmp0, tmp1;
> > >                ^
> > >    1 warning generated.
> > > 
> > > 
> > > vim +/tmp0 +274 drivers/iio/adc/mcp3911.c
> > > 
> > >    268	
> > >    269	static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> > >    270	{
> > >    271		u32 ref = MCP3911_INT_VREF_MV;
> > >    272		u32 div;
> > >    273		int ret;  
> > >  > 274		int tmp0, tmp1;    
> > >    275		s64 tmp2;
> > >    276	
> > >    277		if (adc->vref) {
> > >    278			ret = regulator_get_voltage(adc->vref);
> > >    279			if (ret < 0) {
> > >    280				dev_err(&adc->spi->dev,
> > >    281					"failed to get vref voltage: %d\n",
> > >    282				       ret);
> > >    283				return ret;
> > >    284			}
> > >    285	
> > >    286			ref = ret / 1000;
> > >    287		}
> > >    288	
> > >    289		/*
> > >    290		 * For 24-bit Conversion
> > >    291		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> > >    292		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> > >    293		 *
> > >    294		 * ref = Reference voltage
> > >    295		 * div = (2^23 * 1.5 * gain) = 12582912 * gain
> > >    296		 */
> > >    297		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> > >    298			div = 12582912 * BIT(i);
> > >    299			tmp2 = div_s64((s64)ref * 1000000000LL, div);
> > >    300			tmp1 = div;
> > >    301			tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);  
> > 
> > Marcus, 
> > I'm guessing the intent here is just to get the remainder.  
> > Hence fix is probably just to drop tmp0?
> > 
> > If you confirm that I'll tweak the commit to do that.
> > 
> > Jonathan  
> 
> 
> Hum, Yes. I actually think we can drop div, tmp0, tmp1 and tmp2.
> I think they are remnats for when I did the calculation differently.
> 
> Do you want me to update the patchset?

No I'll roll this in a few minutes.

> 
>  static int mcp3911_calc_scale_table(struct mcp3911 *adc)
>  {
>         u32 ref = MCP3911_INT_VREF_MV;
> -       u32 div;
>         int ret;
> -       int tmp0, tmp1;
> -       s64 tmp2;
> 
> 
> ....
> 
> 
> 
>         for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> -               div = 12582912 * BIT(i);
> -               tmp2 = div_s64((s64)ref * 1000000000LL, div);
> -               tmp1 = div;
> -               tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
> -
>                 mcp3911_scale_table[i][0] = 0;
> -               mcp3911_scale_table[i][1] = tmp1;
> +               mcp3911_scale_table[i][1] = 12582912 * BIT(i);
>         }
> 
> 
> /Marcus
> 
> > 
> >   
> > >    302	
> > >    303			mcp3911_scale_table[i][0] = 0;
> > >    304			mcp3911_scale_table[i][1] = tmp1;
> > >    305		}
> > >    306	
> > >    307		return 0;
> > >    308	}
> > >    309	
> > >   
> >   
> 

