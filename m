Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC55D5E68B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiIVQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiIVQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:41:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E262895F5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51B94CE22B6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D66C433C1;
        Thu, 22 Sep 2022 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663864825;
        bh=YBELpWVHNAtQyyL198ts2WEhOetkzdKh6aKEzSXm2Tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qEORs6KIK6u3IiFl870v4jo3NdE7SB9eOQ91PRHanxYmienBDcAJeZuSWKdIzJWL/
         M/WSnXP8sPw+klJUW3MI1oHuEAzcW3fCtMhnTwTlgTMRX0oDCAdY8VCFei7i9Os5xP
         IxmBBNeF2lJaXJ3Qtf2zZY2MaOREgLyDM9y2ZLgzAehgV41Rf5GSD9s/7WU/GtmJkt
         lI6QrymuoEOc/HKpeZ135FkqMi3aFl1HL7+ZNOCD7jUqcEqkRlmTjdASI/AeC9StD3
         OLmW14l0z8qNEtz+oanV3XbkE9GIT/UBU9nypz7l39fuOkRM0OXo4B+kqSUMspbZjE
         llnrmxaRuMx1g==
Date:   Thu, 22 Sep 2022 17:40:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [jic23-iio:testing 58/58] drivers/iio/adc/mcp3911.c:274:6:
 warning: variable 'tmp0' set but not used
Message-ID: <20220922174031.7e8345e8@jic23-huawei>
In-Reply-To: <20220922172909.00005beb@huawei.com>
References: <202209220845.GmS9zryR-lkp@intel.com>
        <20220922115925.00004ec9@huawei.com>
        <YyyCJX374uWYrPTN@gmail.com>
        <20220922172909.00005beb@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 17:29:09 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 22 Sep 2022 17:41:25 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> 
> > On Thu, Sep 22, 2022 at 11:59:25AM +0100, Jonathan Cameron wrote:  
> > > On Thu, 22 Sep 2022 08:50:17 +0800
> > > kernel test robot <lkp@intel.com> wrote:
> > >     
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> > > > head:   d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > > > commit: d4e1a549566b9ea8b96e80f0cdcbe99714ac256e [58/58] iio: adc: mcp3911: add support to set PGA
> > > > config: x86_64-randconfig-a012
> > > > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > > >         git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> > > >         git fetch --no-tags jic23-iio testing
> > > >         git checkout d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/adc/
> > > > 
> > > > If you fix the issue, kindly add following tag where applicable
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All warnings (new ones prefixed by >>):
> > > >     
> > > > >> drivers/iio/adc/mcp3911.c:274:6: warning: variable 'tmp0' set but not used [-Wunused-but-set-variable]      
> > > >            int tmp0, tmp1;
> > > >                ^
> > > >    1 warning generated.
> > > > 
> > > > 
> > > > vim +/tmp0 +274 drivers/iio/adc/mcp3911.c
> > > > 
> > > >    268	
> > > >    269	static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> > > >    270	{
> > > >    271		u32 ref = MCP3911_INT_VREF_MV;
> > > >    272		u32 div;
> > > >    273		int ret;    
> > > >  > 274		int tmp0, tmp1;      
> > > >    275		s64 tmp2;
> > > >    276	
> > > >    277		if (adc->vref) {
> > > >    278			ret = regulator_get_voltage(adc->vref);
> > > >    279			if (ret < 0) {
> > > >    280				dev_err(&adc->spi->dev,
> > > >    281					"failed to get vref voltage: %d\n",
> > > >    282				       ret);
> > > >    283				return ret;
> > > >    284			}
> > > >    285	
> > > >    286			ref = ret / 1000;
> > > >    287		}
> > > >    288	
> > > >    289		/*
> > > >    290		 * For 24-bit Conversion
> > > >    291		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> > > >    292		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> > > >    293		 *
> > > >    294		 * ref = Reference voltage
> > > >    295		 * div = (2^23 * 1.5 * gain) = 12582912 * gain
> > > >    296		 */
> > > >    297		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> > > >    298			div = 12582912 * BIT(i);
> > > >    299			tmp2 = div_s64((s64)ref * 1000000000LL, div);
> > > >    300			tmp1 = div;
> > > >    301			tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);    
> > > 
> > > Marcus, 
> > > I'm guessing the intent here is just to get the remainder.  
> > > Hence fix is probably just to drop tmp0?
> > > 
> > > If you confirm that I'll tweak the commit to do that.
> > > 
> > > Jonathan    
> > 
> > 
> > Hum, Yes. I actually think we can drop div, tmp0, tmp1 and tmp2.
> > I think they are remnats for when I did the calculation differently.
> > 
> > Do you want me to update the patchset?  
> 
> No I'll roll this in a few minutes.

Actually I'll leave it to you to post a fixed version I can apply.
ref isn't used either in current code and nor is the regulator voltage.
That doesn't feel right...

Please send a fix asap.  For now I'm dropping the PGA patch
that introduces this.  If you can send an update of just that patch
that would be great.

Thanks,

Jonathan


> 
> > 
> >  static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> >  {
> >         u32 ref = MCP3911_INT_VREF_MV;
> > -       u32 div;
> >         int ret;
> > -       int tmp0, tmp1;
> > -       s64 tmp2;
> > 
> > 
> > ....
> > 
> > 
> > 
> >         for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> > -               div = 12582912 * BIT(i);
> > -               tmp2 = div_s64((s64)ref * 1000000000LL, div);
> > -               tmp1 = div;
> > -               tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
> > -
> >                 mcp3911_scale_table[i][0] = 0;
> > -               mcp3911_scale_table[i][1] = tmp1;
> > +               mcp3911_scale_table[i][1] = 12582912 * BIT(i);
> >         }
> > 
> > 
> > /Marcus
> >   
> > > 
> > >     
> > > >    302	
> > > >    303			mcp3911_scale_table[i][0] = 0;
> > > >    304			mcp3911_scale_table[i][1] = tmp1;
> > > >    305		}
> > > >    306	
> > > >    307		return 0;
> > > >    308	}
> > > >    309	
> > > >     
> > >     
> >   
> 

