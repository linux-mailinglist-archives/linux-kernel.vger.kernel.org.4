Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0694612FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJaFiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaFiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:38:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B214C00;
        Sun, 30 Oct 2022 22:38:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 4so9864666pli.0;
        Sun, 30 Oct 2022 22:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/UHrfjKiovZQc+3fmk0jidTcvkQd82+qbKUFsraZYBE=;
        b=bUYKMiFON/+UE5LVAf6OaGkaCyF7WfivvqRu+3318rElHvQeGS7pRsYUSdXAxXW2rS
         +jx5o/Fk/rv4CH+zxbMrReDSYAdOPqi9FS+U56bJUJjkmRXioOQDuXeVPsutdfCIJk6v
         snQ9pG+qu2DBRRrEpzyJPChpPzEEFZb5h0KEKEmoQ9VKgIXD3ZVdE+1U/kaNN9RQAvln
         3AOM3d2DZt8GlYJWEdwoiUc+oPJ66O4qh75FJT7N7PaExSPLz2TEtZjY/gx3oADQs/KS
         zPJIegCI1tmZHkqjCpAHVb9vQL4o9cMGYoC5toN7P7kH7+x7DAJ+VGxUQzaELJXN+9D+
         +PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UHrfjKiovZQc+3fmk0jidTcvkQd82+qbKUFsraZYBE=;
        b=SSY78AUxGnLA4Qg1+z0Ne672zRPq+J64MB2LVUBH7umSVZSk+ei1WaNat7WGEaYpPE
         emVt93jjyRc24iwisnQliGvt35j/KwZnzdJVPeS7a7cgbTf6n9IdvGgZH7qP6If85qh/
         UR+12GaJA3CE/YB6nqGKITDJ2kmvqf+9HBO4Lfvme0n0j+OQUD8rO+m0X+X8Do0kuDZy
         XfO9zCT82zXWaNmexCl/rxkCddNClem/PNx+pZK085xWODahdLT8Cc2QqOfKWjFAXkec
         ajvGXYbff1mZU7URj7pnPguN4vkr6Jk5jKXmn5Co4bpkbZ5YF3H9UY2MrgpADC/oOPjc
         ir7Q==
X-Gm-Message-State: ACrzQf1w0A5JdvxiVIo766HAVto15LTe+K7po/PVJJ8jXsZxLZ0HhWNk
        C3UKqw6tRA3lLt8YqHNwj98=
X-Google-Smtp-Source: AMsMyM6ECFSRrJ8RFE/9nnWqZ59bDZQk1HMdwHi++AgaN63UnU1jJiELqNrKBYXy0xwumLK2CNUtEQ==
X-Received: by 2002:a17:902:f641:b0:17f:3633:5439 with SMTP id m1-20020a170902f64100b0017f36335439mr12865125plg.94.1667194700472;
        Sun, 30 Oct 2022 22:38:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001754064ac31sm3517555plj.280.2022.10.30.22.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:38:19 -0700 (PDT)
Date:   Sun, 30 Oct 2022 22:38:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/10] hda: cs35l41: Add support for CS35L41 in HDA
 systems
Message-ID: <Y19fSL2Z6xq8TCFS@google.com>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-8-tanureal@opensource.cirrus.com>
 <CAHp75VdQGBixkUStPiq3VuoL+9TJo946ObfRA-L-D72DaFHnrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdQGBixkUStPiq3VuoL+9TJo946ObfRA-L-D72DaFHnrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for resurrecting old thread...

On Thu, Jan 06, 2022 at 02:29:58PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 17, 2021 at 5:45 PM Lucas Tanure
> <tanureal@opensource.cirrus.com> wrote:
> >
> > Add support for CS35L41 using a new separated driver
> > that can be used in all upcoming designs

...

> > +       /* No devm_ version as CLSA0100, in no_acpi_dsd case, can't use devm version */
> 
> Can you elaborate why devm can't be used?
> 
> > +       cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", cs35l41->index,
> 
> Please, do not dereference fwnode pointers.
> Also, why can't you use the device instead of fwnode?

We are doing "acpi_dev_put(adev);" a few lines above, so using adev in
the call to fwnode_gpiod_get_index() is technically use-after-free,
isn't it?

Also, why can't we do

	cs35l41->reset_gpio = gpiod_get_index(acpi_dev, "reset",
					      cs35l41->index,
					      GPIOD_OUT_LOW);

since acpi_dev is device structure corresponding to adev and we are
getting the rest of the properties from it?

I saw downthread that there was supposed to be a patch addressing
several issues raised by Andy, was it ever submitted?

Thanks.

-- 
Dmitry
