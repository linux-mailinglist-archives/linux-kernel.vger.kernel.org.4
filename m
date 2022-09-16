Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C15BA850
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIPIiu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Sep 2022 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIPIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:38:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D29A74DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:38:46 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MTS6G33Mtz67nLn;
        Fri, 16 Sep 2022 16:34:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 10:38:43 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 09:38:43 +0100
Date:   Fri, 16 Sep 2022 09:38:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [jic23-iio:testing 149/150] drivers/iio/dac/ad5593r.c:87
 ad5593r_gpio_read() error: uninitialized symbol 'val'.
Message-ID: <20220916093842.0000535c@huawei.com>
In-Reply-To: <SJ0PR03MB6778F73D1F3C08012C6B277299489@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <202209160614.IE7ciPMN-lkp@intel.com>
        <SJ0PR03MB6778F73D1F3C08012C6B277299489@SJ0PR03MB6778.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
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

On Fri, 16 Sep 2022 07:11:54 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Dan,
> 
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > Sent: Friday, September 16, 2022 8:56 AM
> > To: kbuild@lists.01.org; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Cc: lkp@intel.com; kbuild-all@lists.01.org; linux-kernel@vger.kernel.org;
> > Jonathan Cameron <Jonathan.Cameron@huawei.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>
> > Subject: [jic23-iio:testing 149/150] drivers/iio/dac/ad5593r.c:87
> > ad5593r_gpio_read() error: uninitialized symbol 'val'.
> > 
> > [External]
> > 
> > tree:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g
> > it/jic23/iio.git__;!!A3Ni8CS0y2Y!94Jf_eIoy5zwbmsSRdWgugxbqkbgHFd0A88T
> > z4SKRufGLX24YYSEzKlB13AXeYzsBWzd5HW-SqPpIzc8hvh-6w$   testing
> > head:   62a6e699f4669b2c51f408273756f93b21c9f1a1
> > commit: 53b6e3b2164c5807669fbf6b3df0e1494b4d03b8 [149/150] iio: dac:
> > ad5593r: Fix i2c read protocol requirements
> > config: x86_64-randconfig-m001
> > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/iio/dac/ad5593r.c:87 ad5593r_gpio_read() error: uninitialized symbol
> > 'val'.
> > 
> > vim +/val +87 drivers/iio/dac/ad5593r.c
> > 
> > 56ca9db862bf3d7 Paul Cercueil     2016-04-05  79  static int
> > ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
> > 56ca9db862bf3d7 Paul Cercueil     2016-04-05  80  {
> > 56ca9db862bf3d7 Paul Cercueil     2016-04-05  81  	struct i2c_client *i2c =
> > to_i2c_client(st->dev);
> > 53b6e3b2164c580 Michael Hennerich 2022-09-13  82  	u16 val;
> > 53b6e3b2164c580 Michael Hennerich 2022-09-13  83  	int ret;
> > 56ca9db862bf3d7 Paul Cercueil     2016-04-05  84
> > 53b6e3b2164c580 Michael Hennerich 2022-09-13  85  	ret =
> > ad5593r_read_word(i2c, AD5593R_MODE_GPIO_READBACK, &val);
> > 56ca9db862bf3d7 Paul Cercueil     2016-04-05  86
> > 56ca9db862bf3d7 Paul Cercueil     2016-04-05 @87  	*value = (u8) val;
> > 
> > 
> > In the original code the error checking prevented reading uninitialized
> > variables.  It's not really a problem, because ad5593r_read_word() can't
> > actually fail but, you know?  Technically the checker is correct.  
> 
> Hmm, in theory, it can if one of the i2c functions (for some reason) return error.
> Not sure how to handle this... Given this is still in the testing branch should I
> just re-spin another version of the series? Jonathan?

Either a fix patch or a respin is fine as long as I haven't pushed it out as togreg
(once that happens I would almost always want a fix on top).

Separate fix is slightly easier for me.

Jonathan

> 
> - Nuno Sá

