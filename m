Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4D5E74D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiIWHZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiIWHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:25:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC63A033D;
        Fri, 23 Sep 2022 00:25:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m3so16757471eda.12;
        Fri, 23 Sep 2022 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cO5rS1dpYfCGe3y3g2taPmcXnwSxGvvBdzhaTW2FSK8=;
        b=BKsgmxIELX+6q9foTzuzvmTBZPBXnOfyw7LrzBJx7JaQ0vq4gMQmg4gjXiX7vOxER8
         f8CkcZ1hY91ciyDXwPrdCgK2SEPNdOh+ueME2O1tprlON5Q1A7Qiica4Ut63CfIHMYR/
         lLrY53pDwmruhnhPfpBJP/EIk2do7XRhrwcnJ8Pc2+1iKkodKB/ZIcRYVhOgheaXOdAw
         sShkrCaEqqrP9s73g07HyM2wf2kTXYG6sOt74oAp6ts04o5fZmaxlw3+bGibLA9AzVkW
         58KsOymczEIpt5Q7Ef2PH9PxetTG6EZl2X84baILzopjXg4XvxpFab7OnYvLz1CqYB6J
         W7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cO5rS1dpYfCGe3y3g2taPmcXnwSxGvvBdzhaTW2FSK8=;
        b=bG6lrGlqKARtMh0X1iF8S4aS0drvslwKUtL0cmy4e7wFbo9VLlx/s++zR+yq4kar7J
         0yVnpCXirzWicDpto4UhSUFchcgVHLZKChiMB/+ToxHTkoHJNxdtBDspBqaKrgzvQsHD
         LJyZMciDAwqY6d/j1esBe8q2wEz6zcA7xTQolfUua1LcCTvFXvRQdc13nRxWFdqBskk+
         4og/vblrXSHUTwjlxVmgffmOKSExaocuNyxINFB7fS1q/qYhDQKVnY4JB90MD48DDpRf
         JHtP0djQmbuQSgJbQzIlUbgy1ohN6CPratsCrmFEvRIqhma7HbaXOK0tIjz32x8Vao/B
         Rqug==
X-Gm-Message-State: ACrzQf1yVLTTATkLmIdXWedsWWSgQhSXmM0oecTdhDa1mR3klrnqGbtv
        +EzyMIgfh4j58DHgHGk6nSlicYiA850gjFfusflczagCBeg=
X-Google-Smtp-Source: AMsMyM4vEP5MovWF2mKNzuevIZJumt+QjD3AID/N6sAyMInVo15N8KuLE/ZF+qrHAuNIoJCcbKltOJW4ZKwRptD7y3s=
X-Received: by 2002:a50:ea89:0:b0:453:8b7d:12e8 with SMTP id
 d9-20020a50ea89000000b004538b7d12e8mr7063352edo.148.1663917917718; Fri, 23
 Sep 2022 00:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220907132205.28021-1-andrea.merello@iit.it> <20220907132205.28021-9-andrea.merello@iit.it>
 <20220918182731.26de1a02@jic23-huawei>
In-Reply-To: <20220918182731.26de1a02@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 23 Sep 2022 09:25:06 +0200
Message-ID: <CAN8YU5O2z+dxmtLRkKsiXjZjne8rLLdMG57xQRE3SXFMx8YUcQ@mail.gmail.com>
Subject: Re: [v7 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andrea.merello@iit.it, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno dom 18 set 2022 alle ore 19:27 Jonathan Cameron
<jic23@kernel.org> ha scritto:

[...]
>
> Hi Andrea,
>
> I think this is looking to be in a good state now.
> There is some devm handling for clks now available that should avoid
> the need to open code that here.
>
> I've made that change whilst applying. Please take a look to make sure
> I didn't mess it up!

Hi, thank you for directly fixing, so that I can avoid a further
series version :)

I've looked at this change, and it looks good to me; also, I've run
some tests and nothing failed.

Andrea

> Jonathan
>
> > +
> > +static void bno055_clk_disable(void *arg)
> > +{
> > +     clk_disable_unprepare(arg);
> > +}
> > +
> > +int bno055_probe(struct device *dev, struct regmap *regmap,
> > +              int xfer_burst_break_thr, bool sw_reset)
> > +{
>
> ...
>
> > +     priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(priv->reset_gpio))
> > +             return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get reset GPIO\n");
> > +
> > +     priv->clk = devm_clk_get_optional(dev, "clk");
> > +     if (IS_ERR(priv->clk))
> > +             return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get CLK\n");
> > +
> > +     ret = clk_prepare_enable(priv->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = devm_add_action_or_reset(dev, bno055_clk_disable, priv->clk);
> > +     if (ret)
> > +             return ret;#
>
> devm_clk_get_optional_enabled() is now available and should work here I think?
>
> > +
> > +     if (priv->reset_gpio) {
> > +             usleep_range(5000, 10000);
> > +             gpiod_set_value_cansleep(priv->reset_gpio, 1);
> > +             usleep_range(650000, 750000);
> > +     } else if (!sw_reset) {
> > +             dev_warn(dev, "No usable reset method; IMU may be unreliable\n");
> > +     }
