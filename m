Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166706DBA0F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDHK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDHK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E98E1B0;
        Sat,  8 Apr 2023 03:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7CAA60C24;
        Sat,  8 Apr 2023 10:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45C9C433EF;
        Sat,  8 Apr 2023 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680949540;
        bh=WO8/ut7eSs00MBuh1VFQISY1mwz4+Sr58kEes4CQWU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ow45UjOX+U1eiQYdBsP1yZoISuVroORCNra6wM6XYFa2Nxx0RlpoVbduaQDp9TjVv
         aGcKBwxRHUtUn/bBzRVXI6A8G+utSZgAmsuOngueHy4BDIs7RiFw8L6EvGjW8BGtUm
         22zW+QvXFft6D0aZPQn7EadsUd6rY3qbFa3QsTQbDaJ8P0+VYQNGuZXnF+EwOLuoXs
         rhuHDelKS6eoRvQ71z9Q+xGXbd5BbFu5e0SU0Hff+LnFbRvqkpWKWZDPGEvQmgPsII
         ZPSCEZyM+DxEB7zt0ahnjdbcp9TNDW8SL5LjWLnv3tV5RuZ9CsvtoX6OKOBPl92J+k
         0Zy1RObBRRJnA==
Date:   Sat, 8 Apr 2023 11:40:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: max597x: Add support for max597x
Message-ID: <20230408114055.474a597a@jic23-huawei>
In-Reply-To: <c8f709d3-1a8e-c98c-6917-839a0ca4d4ff@9elements.com>
References: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
        <20230402180123.0fc1cfde@jic23-huawei>
        <c8f709d3-1a8e-c98c-6917-839a0ca4d4ff@9elements.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 15:37:21 +0530
Naresh Solanki <naresh.solanki@9elements.com> wrote:

> Hi Jonathan,
> 
> On 02-04-2023 10:31 pm, Jonathan Cameron wrote:
> > On Tue, 28 Mar 2023 11:44:14 +0200
> > Naresh Solanki <naresh.solanki@9elements.com> wrote:
> >   
> >> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >>
> >> max5970 & max5978 has 10bit ADC for voltage & current
> >> monitoring.
> >> Use iio framework to expose the same in sysfs.
> >>
> >> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> >> ...  
> > 
> > --- not ...
> > 
> > As I mentioned in my reply to v2 thread (which crossed with this v3)
> > I'd like this series to be cc'd to the list and maintainers for Hwmon
> > with a cover letter explaining the reasoning for it being an IIO driver
> > + the restrictions that potentially brings.  
> Sure.

A minor request from me for future replies to make things a little
more efficient. Note I'm not always great at this myself - this
is a case of do as I say rather than as I do!

Don't bother agreeing with stuff - reviewers assume you agree
unless you comment!

Crop out any sections of the email reply that have no new content.

e.g.

...

> >> +static int max597x_iio_probe(struct platform_device *pdev)
> >> +{
> >> +	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
> >> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
> >> +	struct iio_dev *indio_dev;
> >> +	struct max597x_iio *priv;
> >> +	int ret, i;
> >> +
> >> +	if (!regmap)
> >> +		return -EPROBE_DEFER;
> >> +
> >> +	if (!max597x || !max597x->num_switches)
> >> +		return -EPROBE_DEFER;
> >> +
> >> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> >> +	if (!indio_dev)
> >> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> >> +				     "failed to allocate iio device\n");
> >> +
> >> +	indio_dev->info = &max597x_adc_iio_info;
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +
> >> +	switch (max597x->num_switches) {  
> > 
> > Having a value 'num_switches' that maps to a set of enums called _TYPE_ is unusual.
> > Perhaps rename it to type.  
> Will add a local variable type to track the same within with driver.

Not totally sure what you mean. I'll look for it in newer versions.

Thanks,

Jonathan
