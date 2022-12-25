Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA2655D5E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 15:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiLYOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 09:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLYOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 09:18:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4025FC;
        Sun, 25 Dec 2022 06:18:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m18so21778881eji.5;
        Sun, 25 Dec 2022 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niYqII/y6uSXj/qldxCx5zx8OzKaw3GEXnxBhhCFXOg=;
        b=hmkFiOteIM1MtZAN0cHoQuZiqcnf1HUhX+/5XHKscPDBWysXzEx6yjvwkqCT5jnowM
         PvrPbwzBPvbHb7Duwq+31mlctE60unvh+AYNG3f9psbome+U3ET1tloSdSlEiwyYnv2M
         eC7i4E76F5XZmkmhDJKVPIXRTaEU7Q/03mc1TczUEmsPKcVn26T6Y+D7q+YYUnHp3qp4
         ofz3EBf2BUrbH/LYagShvQCAD5BvN4JGWdxOnQncvVhlQD6E8FiSK4UlkmN1kL9ZHsJh
         yZsAfCtZKNbfoZDOOCEoq8lN0iYr9/TuMRqaAb5mwycy+Hevr5HXQljrAghD4z+9iLdv
         8HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niYqII/y6uSXj/qldxCx5zx8OzKaw3GEXnxBhhCFXOg=;
        b=06el0W+4Z/fu/riJ0Vwgv6j1Vha35g0tUzI5bXBN3aXQP98d3FupcTNUdRnexw3VRa
         v3tpRV2Ti3UT5pYjQEQSplYUyNS5KvlJyQvKptzpeBJdHoXde1070E2jQTHWwPDdEyHA
         ofozJmrSGEueKD5YYknpg7uImZIAxZRzFZ1qlqOny5fABg/62u6T0TtuWDVR+SiATaBj
         WkWXz7vGihug9mFjUbAyt/JrgUIap9vBQFcZxUz9+OfpmGHerq8wgl+V4zxkDqpv8Lrb
         YTJqB8Q8WvkQU6bmqFo1HyPqj3dB0D49SfiQuZSFUWEtL7lJE3IszPi6EkfPdELXbEKH
         Bhqg==
X-Gm-Message-State: AFqh2krI4PAm4OV8ara8F2fMpJjQ2RPg/JjR48uPy7YN6xx4TvCEBzRL
        2MbZ+UVhqcoz3YYFddHXpbXvv9Ft90xh+COBCHD2erF8
X-Google-Smtp-Source: AMrXdXtx0tvpEG7FURZMaljXjcQr9ggA/FmU+9dgktRDtX7TywqZ9zxo1uoAB+x6Qs1o0qDiPIwXD+rEzpXuWs/rz4Y=
X-Received: by 2002:a17:906:3989:b0:7c1:1f28:afed with SMTP id
 h9-20020a170906398900b007c11f28afedmr1265191eje.678.1671977917920; Sun, 25
 Dec 2022 06:18:37 -0800 (PST)
MIME-Version: 1.0
References: <202212222251.Xacx8c4D-lkp@intel.com> <CAFBinCAB0VuoKKm4YHv_zB1d1xN3nP0=-xg9EotiWMJ_vikc2w@mail.gmail.com>
 <20221222234148.GA2776378@roeck-us.net>
In-Reply-To: <20221222234148.GA2776378@roeck-us.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Dec 2022 15:18:27 +0100
Message-ID: <CAFBinCCr=Q0796zK09=uY_bhBTR-xpKegT3i48psjZEpSjxkww@mail.gmail.com>
Subject: Re: drivers/hwmon/jc42.c:477 jc42_readable_reg() warn: always true
 condition '(reg >= 0) => (0-u32max >= 0)'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
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

Hi Guenter,

On Fri, Dec 23, 2022 at 12:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Dec 22, 2022 at 10:20:13PM +0100, Martin Blumenstingl wrote:
> > Hi Guenter et al.,
> >
> > On Thu, Dec 22, 2022 at 3:36 PM kernel test robot <lkp@intel.com> wrote:
> > [...]
> > >    475  static bool jc42_readable_reg(struct device *dev, unsigned int reg)
> > >    476  {
> > >  > 477          return (reg >= JC42_REG_CAP && reg <= JC42_REG_DEVICEID) ||
> > >    478                  reg == JC42_REG_SMBUS;
> > The bot is right: we can omit "reg >= JC42_REG_CAP" as it's already
> > covered by the fact that:
> > - the reg variable is unsigned, which means the lower limit is zero
> > - reg <= JC42_REG_DEVICEID covers the upper limit
> >
> > Before I send a patch I'd like to hear if removal of "reg >=
> > JC42_REG_CAP" makes sense to other people.
> >
>
> The bot keeps complaining about it. Yes, it is technically unnecessary,
> but I left it in on purpose to indicate that JC42_REG_CAP is the first
> register and that it wasn't forgotten. Any modern C compiler notices
> that the check is unnecessary and drops it, so there is no runtime penalty.
Thanks for your feedback. Since I had to double check the bot's
complaint I'll just keep this as-is (and not send any patch for this
at all).

> This is one of those situations where I'd like to have a means to tell
> the checker to please stop complaining.
I see, in some cases this may be an actual logic error (for example:
accidentally using an unsigned data type instead of a signed one).


Best regards,
Martin
