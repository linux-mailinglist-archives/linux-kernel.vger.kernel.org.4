Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA060C4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJYHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJYHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:17:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292CC786D;
        Tue, 25 Oct 2022 00:17:35 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 1so10077800vsx.1;
        Tue, 25 Oct 2022 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zg5ekEkGQyBExWxO4N/+w6IcGC29JHnmqKp59L1beUc=;
        b=IkZ3uca5Lhug0fWIA71T/QQjiHrzJM3bteiemgni7PXa2+8WbRVWjRYLPFwjWwxxeB
         S9scDXP35z8YWoUe87YffK1L7mx+reaB/v+hL32nGVxJA1P/tS6EqjtQQyVSfXnRwDUf
         B8mCYh4Z5/OH+/Y9AZ80nkqsykT19zWsLXzmhrIXvb18pMVLeHn5q+0EEKZW5U6PACvS
         Ue73slaFwERHHk2wkJkpuXkC9Jtgnovw3t07uSgmuILqYEePBKD4MwPWtcwoALblS/YR
         OIt9EoSBj3UVAuETl7cS8dEC3i+7LElUZrI4O+u7v1MfpmkF7qNM8CizWK7wD4iMddVC
         dk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg5ekEkGQyBExWxO4N/+w6IcGC29JHnmqKp59L1beUc=;
        b=UtzbG+7rSrX1s21A+HFI4QioUZhgDkE4xg2kGzSsHgT9QNVcwOFZUHelGdUhDFrxWT
         MoEU5x7Tb3ZahhpOA9DHTFikddbBj9pLHofz7hWVsLvfbdWZ7CUaxG/7mIMEXT5/yYuV
         Gf54OpxJTTdYh4z0LDMZMNnhaDm4rh1l3faGYBD6ob5u65utgVBgaHWWGEbAslB+VV6O
         /+ZFATVbBAD6APZSsK3R3wlce0o2k0HDlTIj2zEseBhh66Smr+dRPyRmK/MnNlEv+SQv
         wpWyzW8LLu2/qb7WEVrYllQ0v/9n+IW34LKJ3pPhMqWJHQHFOVyCpDn5qHPDN00DUH4I
         F9mg==
X-Gm-Message-State: ACrzQf1UVTf8QGWLsnexxt5Eb2S8pvGvQNdnSy3vBCjtLZaZGiU/ujJC
        mLfe+E3inZSJOCn7Pc1yfCSS1w27RAjKhs70tBgiqCUM
X-Google-Smtp-Source: AMsMyM5H3yUKav5/NDjew+CyMOD2U2jXjGiiFEsvkZZ0f/kvEVhTF5O+XfLV0VyXE3T+wwCax6KbzkCjEn+p2R/RPv4=
X-Received: by 2002:a67:d38f:0:b0:3a6:ff31:efe7 with SMTP id
 b15-20020a67d38f000000b003a6ff31efe7mr20904389vsj.33.1666682254387; Tue, 25
 Oct 2022 00:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <Y1dzCCMCDswQFVvO@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <Y1eGwtqbOhXCGoaM@paasikivi.fi.intel.com> <cd6eb645-4663-40a6-c238-7c82123db1a4@gmail.com>
In-Reply-To: <cd6eb645-4663-40a6-c238-7c82123db1a4@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Tue, 25 Oct 2022 10:17:21 +0300
Message-ID: <CANhJrGPzg9-14OhscgCv6P_9kUG8Nx3mZLEq41aSJ45qh6eaKg@mail.gmail.com>
Subject: Re: [PATCH] drivers: fwnode: fix fwnode_irq_get_byname() kerneldoc
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

ti 25. lokak. 2022 klo 10.06 Matti Vaittinen
(mazziesaccount@gmail.com) kirjoitti:
>
> Hi Sakari,
>
> On 10/25/22 09:48, Sakari Ailus wrote:
> > Moi,
> >
> > On Tue, Oct 25, 2022 at 08:24:24AM +0300, Matti Vaittinen wrote:
> >> The fwnode_irq_get_byname() may return zero on device-tree mapping
> >> error. Fix documentation to reflect this as current documentation
> >> suggests check:
> >>
> >> if (ret < 0)
> >> is enough to detect the errors. This is not the case.
> >>
> >> Add zero as a return value indicating error.
> >>
> >> Fixes: ca0acb511c21 ("device property: Add fwnode_irq_get_byname")
> >> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> ---
> >>   drivers/base/property.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/property.c b/drivers/base/property.c
> >> index 4d6278a84868..df437d10aa08 100644
> >> --- a/drivers/base/property.c
> >> +++ b/drivers/base/property.c
> >> @@ -960,7 +960,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
> >>    * string.
> >>    *
> >>    * Return:
> >> - * Linux IRQ number on success, or negative errno otherwise.
> >> + * Linux IRQ number on success, zero or negative errno otherwise.
> >
> > I wonder if it would be possible instead to always return a negative error
> > code on error. Returning zero on error is really unconventional and can be
> > expected to be a source of bugs.
>
> Agree, and I did also consider just adding:
>
> if (!ret)
>         return -EINVAL; (or another feasible errno)
>
> return ret;
>
> at the end of the fwnode_irq_get_byname().
>
> However, such a functional change would require auditing the existing
> callers which I have no time right now.

Oh. I just did grep the callers. It seems to me that there are only a
handful of callers in 6.1-rc2. Auditing those does not seem like a big
task after all. So I guess I can check them if changing the return
value is preferred.

Yours,
--Matti
