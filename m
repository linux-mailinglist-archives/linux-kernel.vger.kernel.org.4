Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8A6B6752
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCLOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:53:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86731EF96;
        Sun, 12 Mar 2023 07:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AEFAECE069D;
        Sun, 12 Mar 2023 14:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD1C433EF;
        Sun, 12 Mar 2023 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678632780;
        bh=yd7yqh1vwSOJpxM4gHsDAaAWQeJmPNZpXxRvTN7GOC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=trcSuCKQdZ42hlM39kSq4pSG9r18PDrP2SPAhDuByuH4Ssj/vcNqIZQwYDPChslFF
         4dcwxAXGT/tAb9ccgfUrKzM5eAuTS7zEmVJ92yaUEFPnGu2oKAY9+m9APVlViKn89P
         ssZpbDLa7Man2XQwN3KeIfeWpTGk7fUDqWdZdUEgC5MUiRGDkI4BPeWd0CDvY6KTvh
         1uc00zQs67xg8f0TGISqWujRnFvRC5DfGxqCj1CG5Lp9VsT5yPlzWbaPJCYgDre0kQ
         Ov/Qwp2PzulsTcm/5dTo8t++KjphFjhmJEJ7L/9JOFdtIONSIGlb+/VNxr0Xp/u8iu
         V1laxh1ItxC9A==
Date:   Sun, 12 Mar 2023 14:53:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <20230312145304.3c9b9123@jic23-huawei>
In-Reply-To: <f91d6d0a-e197-a66b-61b7-f2ea668429f7@topic.nl>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
        <20230228063151.17598-2-mike.looijmans@topic.nl>
        <20230304175751.2daae308@jic23-huawei>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c6259f01-fccb-4a0c-a50a-69f2dcd4ea5b@emailsignatures365.codetwo.com>
        <f91d6d0a-e197-a66b-61b7-f2ea668429f7@topic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 12:21:44 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
> On 04-03-2023 18:57, Jonathan Cameron wrote:
> > On Tue, 28 Feb 2023 07:31:51 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >  
> >> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> >> The ADS1000 is similar, but has a fixed data rate.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>  
> > Hi Mike,
> >
> > A few minor things + one request for a test as trying to chase a possible
> > ref count overflow around the runtime_pm was giving me a enough of a headache
> > that it's easier to ask you just to poke it and see.  If it doesn't fail as
> > I expect I'll take a closer look!
> >
> > Jonathan
> >
> > ...  
> >> +	data->client = client;
> >> +	mutex_init(&data->lock);
> >> +
> >> +	indio_dev->name = "ads1100";
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +	indio_dev->channels = &ads1100_channel;
> >> +	indio_dev->num_channels = 1;
> >> +	indio_dev->info = &ads1100_info;
> >> +
> >> +	data->reg_vdd = devm_regulator_get(dev, "vdd");
> >> +	if (IS_ERR(data->reg_vdd))
> >> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> >> +				     "Failed to get vdd regulator\n");
> >> +
> >> +	ret = regulator_enable(data->reg_vdd);
> >> +	if (ret < 0)
> >> +		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
> >> +				     "Failed to enable vdd regulator\n");
> >> +
> >> +	ret = devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd);
> >> +	if (ret)
> >> +		return ret;  
> > Please could you check a subtle interaction of runtime pm and this devm managed
> > flow.
> >
> > I think we can hit the following flow.
> > 1) In runtime suspend (wait long enough for this to happen).
> > 2) Unbind the driver (rmmod will do)
> > 3) During the unbind we exit suspend then enter it again before we call remove
> >     (that's just part of the normal remove flow).
> > 4) We then end up calling regulator disable when it's already disabled.
> >
> > We've traditionally avoided that by having the remove explicitly call
> > pm_runtime_get_sync() before we then disable runtime pm.  I don't
> > think that happens with devm_pm_runtime_enable() but I could be missing
> > a path where it does.
> >
> > If the sequence goes wrong you should get a warning about an unbalanced regulator
> > disable.  The fix would be an extra devm_add_action_or_reset() before the
> > devm_iio_device_register() below that just calls pm_runtime_get_sync()
> > to force the state to on.
> >
> > Gah. These subtle paths always give me a headache.
> > We don't normally have too much problem with this because many
> > runtime_resume / suspend functions don't change reference counts.  
> 
> Just did this test, waited a few seconds, checked 
> /sys/kernel/debug/regulator... that the regulator had been disabled.
> 
> Then executed:
> echo -n 3-004a > /sys/bus/i2c/drivers/ads1100/unbind
> 
> to unload the driver, and no messages were added to the kernel log.
> 
> I could see the driver going away and removing itself from iio and 
> regulators.
> 
> Tried this a couple of times (using bind/unbind), and no problem reported.
> 
> Hopes this helps with your headaches...

Thanks!

> 

