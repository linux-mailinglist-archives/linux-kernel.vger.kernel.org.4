Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF576EBEC1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDWKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWKzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D5126;
        Sun, 23 Apr 2023 03:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5061760BD3;
        Sun, 23 Apr 2023 10:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3904C433EF;
        Sun, 23 Apr 2023 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682247337;
        bh=U1hVuN/EU3hvOP97td74MooCnVJfng/ijuB6C4aIaGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTlbIubV9PpAtS12v1gxYiQywyRbvwLEhcN0pHctdmVDwZOu20wSGZaokQRAJ115U
         YayzDw8aKsItwbZo3rSxmDlEkqTRtCb35QLvkxWWkhNDBQuyU7TnVSuieiyeRw/xFn
         clSL5f/nE8No9cxGkedOGllk445tumFooZN8cDwZ/YB4CsqDmf1aa/6jmKJ/TAEIB0
         K3rhTC44tpnGjS82F2behH7Lb3+mK7kd8HK5hHmvQcjgycgYjfVCrnXvCIwrnhjynG
         VbSF8RGcDvegbYfWlL1bgpF09DkFl4XrA1K2yQG9aRbaWv35fUd/8qCezic+1cHJZO
         4e2bpt/ql1bWw==
Date:   Sun, 23 Apr 2023 12:11:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marius Hoch <mail@mariushoch.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: al3320a: Handle ACPI device CALS0001
Message-ID: <20230423121114.017d2b0b@jic23-huawei>
In-Reply-To: <6feb48c8-6d74-6605-b7d1-48103ca9187e@redhat.com>
References: <20230420232631.68864-1-mail@mariushoch.de>
        <6feb48c8-6d74-6605-b7d1-48103ca9187e@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 11:36:51 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 4/21/23 01:26, Marius Hoch wrote:
> > This sensor can be found as CALS0001 on the Lenovo Yoga
> > Tablet 2 series.
> > 
> > Tested on a Lenovo Yoga Tablet 2 1051-F.
> > 
> > Signed-off-by: Marius Hoch <mail@mariushoch.de>
> > ---
> > v2: Explicitly include <linux/mod_devicetable.h> (don't rely on
> > linux/i2c.h including it)  
> 
> Thanks, the patch looks good to me and I have
> tested this successfully on a Lenovo Yoga Tablet 2 851F :
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 
Ah..  I'll drop previous edited version that did the same thing.

In general if you are going to send a new version of a patch when there
has been not response to previous one, please just reply yourself to
that original thread.

Anyhow, now applied this one.

Thanks,

Jonathan

> 
> 
> > ---
> >  drivers/iio/light/al3320a.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> > index 9ff28bbf34bb..36214d790f71 100644
> > --- a/drivers/iio/light/al3320a.c
> > +++ b/drivers/iio/light/al3320a.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/mod_devicetable.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -247,11 +248,18 @@ static const struct of_device_id al3320a_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, al3320a_of_match);
> >  
> > +static const struct acpi_device_id al3320a_acpi_match[] = {
> > +	{"CALS0001"},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
> > +
> >  static struct i2c_driver al3320a_driver = {
> >  	.driver = {
> >  		.name = AL3320A_DRV_NAME,
> >  		.of_match_table = al3320a_of_match,
> >  		.pm = pm_sleep_ptr(&al3320a_pm_ops),
> > +		.acpi_match_table = al3320a_acpi_match,
> >  	},
> >  	.probe_new	= al3320a_probe,
> >  	.id_table	= al3320a_id,
> > 
> > base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f  
> 

