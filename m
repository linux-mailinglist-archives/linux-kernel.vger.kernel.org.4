Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C56A45E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjB0PUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjB0PUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:20:35 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B271E5C5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:20:31 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n6so5676195plf.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7CxT7maXE4+pidPAMkM9znIPx7DmvYeMr4os2ZnvJsM=;
        b=izMRXnHobH+nj88rGRGHpgvEY9C07iVbeZCRPJIgyyN9IQD0z2CnMhZ+tED1RK6UT9
         dZ0fB2R1sIA0HlzlXIHGUwUhP3HAPJ259RVO2+HLcUi4wn+7B1BeN9Q7cJB9yd7Er7x3
         VaM+M/vT5d1aWqTLRGSVlYH6ocR2L5Y8/D2s3cq2X7GD6mrZHui7cGG/oo8aYYZ7y7zF
         1yyhXQCC9hJbxncOtHG8/H6OmSU1UBFDycWFHP15CmQXHU9V9rpsK1YjJZg/KVP6/tz/
         Xk+H25CjA3mP/YFDjQSyngYm0cVnpanNpEibcTqyohmscxflohZ3/YjoP6cLUZt+SR/Q
         qXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CxT7maXE4+pidPAMkM9znIPx7DmvYeMr4os2ZnvJsM=;
        b=weANI7H6TFcOMxTnfk/OX9gi8vkH7jkdixy9Ykvlftl2v79Xw+CZCaeRjcB8VAjDlu
         +rCeddmt653mXdQymOEPKrTpg6RO+doq9ZCZSD6TvbqHY6aJS+/r3fxc4s+G50Ob0nUS
         d4Weva8jM/TvJtJGIxIHRfLeqiPksWi4MJ26Wan0bvvZ9zPaWAhukB0pd/jdSE267CFG
         nk0OoIKF+WnDSvE068UBGazpeubsjVWHS/bD4y/b6lDaGPqec+8J0aWYuwlM9nuwlZf6
         o6qBugEu2EvAamTD8/lA+IGZdBPtg1W4L10rDUJCOqSEJgtUJWoogL9A0Mexc3cUQqH2
         fT9Q==
X-Gm-Message-State: AO0yUKXINWFJXExQQ7JBt41fNtwlOcf1boirvmrL++fycvQIDIDFVNSj
        zGCALJPfnWBHq+2sBgn1pCkmwnEJtJ+/ZLhqQti9e8nlc617h2a/
X-Google-Smtp-Source: AK7set8yjmcZcTLVPyNHSf80KkO2QksidRYt34IMu+5x+REpBxdpDlrh8uB0k0VO/Lqs8GC5fdJ6RcYATrKwiom87mc=
X-Received: by 2002:a17:90b:3b44:b0:22c:89b:8e97 with SMTP id
 ot4-20020a17090b3b4400b0022c089b8e97mr5282702pjb.1.1677511230837; Mon, 27 Feb
 2023 07:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-7-victor.shih@genesyslogic.com.tw> <CAPDyKFoV3Ch-xzXxiT2RnDeLvsO454Pwq1vQL_bdNLptM+amAg@mail.gmail.com>
 <CAK00qKDKA1h2O92HHDKhhWY3rwmGGHXQfTpuajs2RcobAaFzqA@mail.gmail.com>
In-Reply-To: <CAK00qKDKA1h2O92HHDKhhWY3rwmGGHXQfTpuajs2RcobAaFzqA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 16:19:54 +0100
Message-ID: <CAPDyKFquNQ4GpanTDpbgheYVL9N9GJCa60p0iqN6R7ydjYy3fw@mail.gmail.com>
Subject: Re: [PATCH V6 06/24] mmc: core: Support UHS-II card control and access
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > +}
> > > +
> > > +/*
> > > + * Mask off any voltages we don't support and select
> > > + * the lowest voltage
> > > + */
> > > +u32 sd_uhs2_select_voltage(struct mmc_host *host, u32 ocr)
> > > +{
> > > +       int bit;
> > > +       int err;
> > > +
> > > +       /*
> > > +        * Sanity check the voltages that the card claims to
> > > +        * support.
> > > +        */
> > > +       if (ocr & 0x7F) {
> > > +               dev_warn(mmc_dev(host), "card claims to support voltages below defined range\n");
> > > +               ocr &= ~0x7F;
> > > +       }
> > > +
> > > +       ocr &= host->ocr_avail;
> > > +       if (!ocr) {
> > > +               dev_warn(mmc_dev(host), "no support for card's volts\n");
> > > +               return 0;
> > > +       }
> > > +
> > > +       if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> > > +               bit = ffs(ocr) - 1;
> > > +               ocr &= 3 << bit;
> > > +               /* Power cycle */
> > > +               err = sd_uhs2_power_off(host);
> > > +               if (err)
> > > +                       return 0;
> > > +               err = sd_uhs2_reinit(host);
> >
> > As also pointed out by Adrian, this path becomes circular and doesn't
> > work as expected.
> >
> > At this point, I would prefer to keep things as simple as possible, so
> > I suggest that we drop this path entirely for UHS2.
> >
>
> Can we use sd_uhs2_power and sd_uhs2_power_up instead of the
> sd_uhs2_reinit after I reference the mmc_power_cycle function?

Sorry, but I don't quite understand how that would help to make this work!?

Anyway, please have a look at the corresponding comment below too. The
point is, I think it's better if we can update (or refactor) and make
use of mmc_select_voltage() instead.

>
> > > +               if (err)
> > > +                       return 0;
> > > +       } else {
> > > +               bit = fls(ocr) - 1;
> > > +               ocr &= 3 << bit;
> >
> > Note that, in mmc_select_voltage() the corresponding code has been
> > updated in commit 39a72dbfe188 ("mmc: core: properly select voltage
> > range without power cycle") that fixes a real problem for us.
> >
> > By taking the above observations into consideration, it looks like it
> > may be better to reuse mmc_select_voltage() for UHS-II after all. To
> > prevent the power cycle path for UHS-II, we can just add a check for
> > the ios->timings in there. That should work, I think.
> >
> > > +               if (bit != host->ios.vdd)
> > > +                       dev_warn(mmc_dev(host), "exceeding card's volts\n");
> > > +       }
> > > +
> > > +       return ocr;
> > > +}
> > > +

[...]

Kind regards
Uffe
