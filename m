Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81F5FEE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJNNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJNNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:22:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC72D1DA;
        Fri, 14 Oct 2022 06:22:36 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mpn940Ssnz6HJMW;
        Fri, 14 Oct 2022 21:21:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 15:22:34 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 14:22:33 +0100
Date:   Fri, 14 Oct 2022 14:22:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221014142232.000038df@huawei.com>
In-Reply-To: <7abed64a-d544-a228-b5f1-4c7b5a3bd1be@fi.rohmeurope.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
        <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
        <20221009133351.6ff4894b@jic23-huawei>
        <Y0O4fiQQX0M317h/@smile.fi.intel.com>
        <7abed64a-d544-a228-b5f1-4c7b5a3bd1be@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Tue, 11 Oct 2022 09:10:21 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 10/10/22 09:15, Andy Shevchenko wrote:
> > On Sun, Oct 09, 2022 at 01:33:51PM +0100, Jonathan Cameron wrote:  
> >> On Thu, 6 Oct 2022 21:32:11 +0300 Andy Shevchenko 
> >> <andriy.shevchenko@linux.intel.com> wrote:  
> >>> On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:  
> > 
> > ...
> >   
> >>>> +module_param(g_kx022a_use_buffer, bool, 0); 
> >>>> +MODULE_PARM_DESC(g_kx022a_use_buffer, +		 "Buffer samples. Use
> >>>> at own risk. Fifo must not overflow");  
> >>> 
> >>> Why?! We usually do not allow module parameters in the new code.  
> >> 
> >> Badly broken hardware - was my suggestion.  Alternatives if there 
> >> are usecases that need to use the fifo, but it can wedge hard in a
> >>  fashion that is impossible to prevent from the driver?  My gut 
> >> feeling is still drop the support entirely with a strong comment in
> >> the code that the hardware is broken in a fashion we don't know how
> >> to work around.  
> 
> I did some quick study regarding couple of other Kionix sensors. (like 
> KX122 and old KX022 - without the 'A'). It seems to me that the register 
> interfaces between many of the sensors are largely identical. Extending 
> the driver to support those seems pretty straightforward (scales and 
> resolution may need tweaking, as does the FIFO size) but register 
> contents and even offsets are largely identical.

Last kionix part I had was a kxsd9 and I don't recall that having a fifo
so obviously didn't hit this issue.

> 
> As said, it seems the Kionix sensors may have different size of internal 
> FIFOs, or even no FIFO at all. So, maybe we could provide a 
> "kionix,fifo-enable" flag (or even "kionix,fifo-size") from device-tree? 

For device where we don't have reports of this issue, that should be derived
from the compatible (or even better a whoami register if there is one).
The driver should know the fifo-size if it isn't discoverable.

> This would be a way to have the FIFO disabled by default and warn users 
> via dt-binding docs if they decide to explicitly enable the FIFO. 
> (Besides, I believe the FIFO is usable on at least some of the Kionix 
> sensors - because I've heard it is used on a few platforms).
> 
> This could give us safe defaults while not shutting the doors from those 
> who wish to use the FIFO. Sure we need a buy-in from Krzysztof / Rob, 
> but that may be less of an obstacle compared to the module param if Greg 
> is so strongly oppsoing those. (And the dt-property could also provide 
> some technical merites as these sensors seem to really have differencies 
> in FIFOs).

I'm dubious about having this for known broken parts - but I guess you
can propose it and see what the dt-maintainers say.

I don't want to see fifo size in the dt binding though.
> 
> > 
> > I also would drop this from upstream and if anybody curious, provide
> >  some kind of GitHub gist for that.  
> 
> Well, I think we all agree that downstream code hosted in some 
> unofficial github repositories are rarely that valuable. They're less 
> reliable, less tested, less reviewed, less secure and pretty much 
> impossible to maintain in a way that interested user could get a version 
> matching his preferred kernel.
> 
> There are reasons why I (people) keep sending the drivers to upstream - 
> and why some companies even spend $$ for that. Having this feature in 
> downstream repo is not nearly on same page for user's point of view as 
> is having the support upstream.

It's not really support if it comes with big warnings and potentially we
even taint the kernel of someone turns it on...

> 
> > Also it needs some communication
> >  with a vendor to clarify the things.  
> 
> I do communication with the vendor on a daily basis :] Nowadays Kionix 
> is part of ROHM, and Finland SWDC has been collaboration with Kionix 
> even before they "merged" (but I have not been part of the "sensor team" 
> back then).
> 
> Unfortunately, reaching the correct people inside the company is hard 
> and occasionally impossible - long story...

:)

Jonathan
