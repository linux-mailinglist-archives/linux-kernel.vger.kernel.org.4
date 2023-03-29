Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F76CF01A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjC2RFm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2RFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:05:38 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D6230C2;
        Wed, 29 Mar 2023 10:05:37 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id ew6so66054812edb.7;
        Wed, 29 Mar 2023 10:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680109536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62e4+lmBq/lhs+cZOFYzhKCQ2kaGBP2Gx8PsA2GJi24=;
        b=brwTXAhpSqTEZUTTq2fbdAOQgP2fNMAkrmXFGqBFPZvgUtoV1PaGW3Du4zTljiTFKq
         N9DMw3kUENKj2MHsqhBn2YgWGanXtLgNwGHJudL8pvy6Jv98YYsOF4pP2oQ/p5QA8fZN
         hK/g/OZqVXkBarjZHKozBlBwZ/RMiSPv7Ymfo7LEMPLry7wd+mXNNiZxN6eledtMgJU+
         0aYPT+cKYzfGbapbk/6Vk5hMTLWnagjgoAswIBFvAeJ42XogID7gAbP7SYynmvFE/g9Q
         uN3S+V5oG4pDvGWfXEIsdBKP1pSTlXjXmBUkmsC8OPMse/OeMvu9bRS9BjqFwLasY4KA
         vDUA==
X-Gm-Message-State: AAQBX9d/zrUAnNeI3v2IObhpku0I7pfKwrzVp5WIJisnWoXNZ5CZ2cd+
        tUoUjGP8FOXMWPppL4I9GseXixie03d2Ip/pkNFWHGYG
X-Google-Smtp-Source: AKy350aHcjL7yz7Sbh4G6+sP7BBKgi6D6567dXMKOJGqJ8hG0xKM6j5+g367Xq7mJFaE2+NGl/RrLB2bq74A7x/17vg=
X-Received: by 2002:a17:907:160e:b0:946:a095:b314 with SMTP id
 hb14-20020a170907160e00b00946a095b314mr3933611ejc.2.1680109536322; Wed, 29
 Mar 2023 10:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <77da9d68-3cb2-f765-21d2-e427776dca44@linaro.org>
In-Reply-To: <77da9d68-3cb2-f765-21d2-e427776dca44@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 19:05:25 +0200
Message-ID: <CAJZ5v0jwrMKMSzVWkzSLBwWZGp0H0-GvnK+gPDtHEsw2XD8KKg@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 6:03 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/03/2023 11:00, Zhang Rui wrote:
> > When the hwmon device node of a thermal zone device is not found,
> > using hwmon->device causes a kernel NULL pointer dereference.
> >
> > Reported-by: Preble Adam C <adam.c.preble@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied, thanks!

> > ---
> > Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> > dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> > I'm not sure if the Fix tag applies to such commit or not.
> > ---
> >   drivers/thermal/thermal_hwmon.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> > index c59db17dddd6..261743f461be 100644
> > --- a/drivers/thermal/thermal_hwmon.c
> > +++ b/drivers/thermal/thermal_hwmon.c
> > @@ -229,7 +229,7 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
> >       hwmon = thermal_hwmon_lookup_by_type(tz);
> >       if (unlikely(!hwmon)) {
> >               /* Should never happen... */
> > -             dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
> > +             dev_dbg(&tz->device, "hwmon device lookup failed!\n");
> >               return;
> >       }
> >
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
