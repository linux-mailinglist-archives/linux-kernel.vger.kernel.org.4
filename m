Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8767167F90B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjA1PVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjA1PVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 10:21:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457945F66;
        Sat, 28 Jan 2023 07:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CD7060C1E;
        Sat, 28 Jan 2023 15:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A0DC433D2;
        Sat, 28 Jan 2023 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674919264;
        bh=THflW8TPo/fJYdaML386SVIsNIbxd9TvRqMvSD4rXtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NPuEjEd2OjTfpqkNkx6S4wEbBLp7PztC8ZjWkl6cR6iaIsKFqYRjK5iG/hm7iGbTW
         GMwluSBtliiAMj53P5rB3ELL4edC610CB0dDBq7LOGT+Uetj5PPstKVk+hRRmjyMFz
         1GhUmdrTl5s97HDQAinBE7GFrKmEAKOqjWLcFRSZoqETHkiuwohKIfHEeyoamDqwRl
         aN+Fuymi0Pkwpfbwn2SYDHcXfPRKXIVWJMtC+R86AWcnrD78tgOPSDrr2eaWsQ3JNX
         1nr7LJ1GOWWNpgAmSThabz6/CZn44ijf1J2NPXrvaicv7YSSJEk7sLAXxCNKZeUh3j
         YgziSWHOKETJg==
Date:   Sat, 28 Jan 2023 15:34:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230128153457.356691ae@jic23-huawei>
In-Reply-To: <Y9GFgseSx9A+rBY6@google.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
        <20230122172441.4f8d75f5@jic23-huawei>
        <22fa80f5-0cf0-85bd-03a4-e1eb80272420@linaro.org>
        <CAD=FV=WVEfi2u-uHcZAoMd4HXPcZrwb95HQzTE8V6YmAW9mhPA@mail.gmail.com>
        <Y9GFgseSx9A+rBY6@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Wed, 25 Jan 2023 19:39:46 +0000
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Mon, Jan 23, 2023 at 03:12:06PM -0800, Doug Anderson wrote:
> > Hi,
> > 
> > On Mon, Jan 23, 2023 at 8:35 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:  
> > >
> > > On 22.01.2023 18:24, Jonathan Cameron wrote:  
> > > > On Wed, 18 Jan 2023 12:06:23 +0200
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > >  
> > > >> The node name can contain an address part which is unused
> > > >> by the driver. Moreover, this string is propagated into
> > > >> the userspace label, sysfs filenames *and breaking ABI*.
> > > >>
> > > >> Cut the address part out before assigning the channel name.
> > > >>
> > > >> Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > > >> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > > >
> > > > LGTM, but given it will have ABI impact, I'd like to hear from
> > > > Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> > > > who has touched this driver fairly recently.  
> > > + Doug
> > >
> > > Unless the Chromium folks relied on the old names (they're the
> > > only ones I can think of that actually could have tapped into
> > > this), I say green light!  
> > 
> > Thanks for the CC. I _think_ the only place we use these ADCs is for
> > certain thermistors and I think that those are all just hooked up in
> > the device tree, so the channel name doesn't matter. I'll also note
> > that no Qualcomm Chromebooks are shipping with anything newer than
> > kernel 5.15 right now, and (I checked) the ChromeOS 5.15 tree doesn't
> > have commit 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device
> > properties"). Thus, even if I'm wrong and the name is used someplace
> > hidden then the "old" name would be better for us. I haven't tested
> > the patch myself, but it sounds as if ${SUBJECT} patch is actually
> > moving us back to the old name.
> > 
> > +Matthias to keep me honest since he's spent more time with the ADCs.  
> 
> Agreed that the channel name doesn't matter, Chrome OS currently only
> uses the ADCs for thermal zones controlled by the kernel.

Great.  Thanks for all the info. 

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan

> 
> > > > Mostly I want to be sure they know this exists before it causes surprise.
> > > >
> > > > Jonathan
> > > >  
> > > >> ---
> > > >> v2: rephrased commit message (Marijn), fixed compilation issue (Marijin)
> > > >>  drivers/iio/adc/qcom-spmi-adc5.c | 10 +++++++++-
> > > >>  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > > >> index e90c299c913a..c2d5e06f137a 100644
> > > >> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > > >> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > > >> @@ -628,12 +628,20 @@ static int adc5_get_fw_channel_data(struct adc5_chip *adc,
> > > >>                                  struct fwnode_handle *fwnode,
> > > >>                                  const struct adc5_data *data)
> > > >>  {
> > > >> -    const char *name = fwnode_get_name(fwnode), *channel_name;
> > > >> +    const char *channel_name;
> > > >> +    char *name;
> > > >>      u32 chan, value, varr[2];
> > > >>      u32 sid = 0;
> > > >>      int ret;
> > > >>      struct device *dev = adc->dev;
> > > >>
> > > >> +    name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> > > >> +    if (!name)
> > > >> +            return -ENOMEM;
> > > >> +
> > > >> +    /* Cut the address part */
> > > >> +    name[strchrnul(name, '@') - name] = '\0';
> > > >> +
> > > >>      ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> > > >>      if (ret) {
> > > >>              dev_err(dev, "invalid channel number %s\n", name);  
> > > >  

