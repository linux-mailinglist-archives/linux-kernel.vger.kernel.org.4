Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A253635273
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiKWIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiKWIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:24:58 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6AFFC72F;
        Wed, 23 Nov 2022 00:24:54 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id z192so20108642yba.0;
        Wed, 23 Nov 2022 00:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olonk8iFpg1UnUmS3Yq9vG//2BtL7EZzQMT3kacEImU=;
        b=KLsGgdN9rTVkVpm+hXOgeB+N+nXJVo9bbwpX2eQ2n2H9TGOXw6tuMmOzceQVnALi+d
         uOmNOHUt9vkapZQ6LuhnLQk5GZXwCgWc9NRp70KNbWbr3N9B687ZQU4MIIjVOTdAL/3p
         iyv+GcSZoGq1gXNgitUHvp4BO23ivbCAJvGk2vyFt+ZfPX/RoToXGj9EJox4FTq93jLf
         LIL7I0anwMal2s0EQWorwDZmamo7YcjGKip6WjDDfJ6KcH3LCDQN8FeC+R6j+wvGl1ea
         xqT2451dzBCbFg3NzPMfgc6mhsj+7Tdy/0ohi9KErU6a/P67CZaTAiBDgEqhznAUJrqR
         L7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olonk8iFpg1UnUmS3Yq9vG//2BtL7EZzQMT3kacEImU=;
        b=p1mU3MKaZr+qIBxJrggNCqhFqoQ4YlWVKLKR287haJxEh67aHzdBWaqvuVOrKaUbWL
         iSDNzWVewpAqzxNExtsXV9HaeavWrGU/Emv5QzdPuQX5SEcaUSMwr4hY9zqvhIa22uX1
         rsD2ERYwKdN7/6sqMyG3yvBhAhSSpK9GXMpZJmQDCvs69sjXyeIX36lbWLX7DAvTqLtM
         mVQaqih5Y6eiaUlYnwoMs8ZHNxmAllVWBH6jEan8dqEbYcZXDP304a39VG7+o4lAK7mQ
         iHE3Xq/1MWihBXRt5Zm/vLsSlwM/DOdt93bvwdmUb6Mfsx7rmYqaizwpkfyGeW8zuQ44
         xAvw==
X-Gm-Message-State: ANoB5pkYLMzX6CL6pzjf2zJmJVnn+KxoMOtjSympxnIWoBk7BcDK3EuA
        ib0ppwuf6NewL08/m7nBvTXlsdcIJnGtdK917H+0q7KB
X-Google-Smtp-Source: AA0mqf7FxKVxlcQdedGMWjmPDaH5Kle+PZ5/xN8+NrpA5ZuLYWkj3r4ItDHDAKnugJPl3XlvkdCWePR9AyVRgpXUWew=
X-Received: by 2002:a25:8189:0:b0:6ca:6bfb:3374 with SMTP id
 p9-20020a258189000000b006ca6bfb3374mr25479310ybk.175.1669191893411; Wed, 23
 Nov 2022 00:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20221122132330.30408-1-lukas.bulwahn@gmail.com>
 <20221122160937.GB39395@tom-ThinkPad-T14s-Gen-2i> <CAKXUXMxk-YoG4TdB8Em+cEMF8NA7rdMAboQz8nmhfVmVQ8oATA@mail.gmail.com>
 <20221123082148.GC39395@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20221123082148.GC39395@tom-ThinkPad-T14s-Gen-2i>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 23 Nov 2022 09:24:42 +0100
Message-ID: <CAKXUXMx81Mvo_H4KzkHXgPbYq07SbEuTcs9LBae5D5GRTK_T0Q@mail.gmail.com>
Subject: Re: [PATCH] media: imx: remove code for non-existing config IMX_GPT_ICAP
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 23, 2022 at 9:21 AM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
>
> Hi Lukas,
>
> On Wed, Nov 23, 2022 at 08:56:06AM +0100, Lukas Bulwahn wrote:
> > On Tue, Nov 22, 2022 at 5:09 PM Tommaso Merciai
> > <tommaso.merciai@amarulasolutions.com> wrote:
> > >
> > > Hi Lukas,
> > >
> > > On Tue, Nov 22, 2022 at 02:23:30PM +0100, Lukas Bulwahn wrote:
> > > > There never was a config IMX_GPT_ICAP in the repository. So remove the code
> > > > conditional on this config and simplify the callers that just called empty
> > > > functions.
> > > >
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > ---
> > > >  drivers/staging/media/imx/imx-media-fim.c | 54 -----------------------
> > > >  1 file changed, 54 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> > > > index 3a9182933508..19a48eb445fd 100644
> > > > --- a/drivers/staging/media/imx/imx-media-fim.c
> > > > +++ b/drivers/staging/media/imx/imx-media-fim.c
> > > > @@ -187,54 +187,6 @@ static void frame_interval_monitor(struct imx_media_fim *fim,
> > > >               send_fim_event(fim, error_avg);
> > > >  }
> > > >
> > > > -#ifdef CONFIG_IMX_GPT_ICAP
> > > > -/*
> > > > - * Input Capture method of measuring frame intervals. Not subject
> > > > - * to interrupt latency.
> > > > - */
> > > > -static void fim_input_capture_handler(int channel, void *dev_id,
> > > > -                                   ktime_t timestamp)
> > > > -{
> > > > -     struct imx_media_fim *fim = dev_id;
> > > > -     unsigned long flags;
> > > > -
> > > > -     spin_lock_irqsave(&fim->lock, flags);
> > > > -
> > > > -     frame_interval_monitor(fim, timestamp);
> > > > -
> > > > -     if (!completion_done(&fim->icap_first_event))
> > > > -             complete(&fim->icap_first_event);
> > > > -
> > > > -     spin_unlock_irqrestore(&fim->lock, flags);
> > > > -}
> > > > -
> > > > -static int fim_request_input_capture(struct imx_media_fim *fim)
> > > > -{
> > > > -     init_completion(&fim->icap_first_event);
> > > > -
> > > > -     return mxc_request_input_capture(fim->icap_channel,
> > > > -                                      fim_input_capture_handler,
> > > > -                                      fim->icap_flags, fim);
> > > > -}
> > > > -
> > > > -static void fim_free_input_capture(struct imx_media_fim *fim)
> > > > -{
> > > > -     mxc_free_input_capture(fim->icap_channel, fim);
> > > > -}
> > > > -
> > > > -#else /* CONFIG_IMX_GPT_ICAP */
> > > > -
> > > > -static int fim_request_input_capture(struct imx_media_fim *fim)
> > > > -{
> > > > -     return 0;
> > > > -}
> > > > -
> > > > -static void fim_free_input_capture(struct imx_media_fim *fim)
> > > > -{
> > > > -}
> > > > -
> > > > -#endif /* CONFIG_IMX_GPT_ICAP */
> > > > -
> > > >  /*
> > > >   * In case we are monitoring the first frame interval after streamon
> > > >   * (when fim->num_skip = 0), we need a valid fim->last_ts before we
> > > > @@ -435,14 +387,8 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
> > > >               spin_unlock_irqrestore(&fim->lock, flags);
> > > >
> > > >               if (icap_enabled(fim)) {
> > > > -                     ret = fim_request_input_capture(fim);
> > > > -                     if (ret)
> > > > -                             goto out;
> > > >                       fim_acquire_first_ts(fim);
> > > >               }
> > >
> > > As suggested by the checkpatch.pl:
> > > WARNING: braces {} are not necessary for single statement blocks
> > >
> > > > -     } else {
> > > > -             if (icap_enabled(fim))
> > > > -                     fim_free_input_capture(fim);
> > > >       }
> > > >
> > > >       fim->stream_on = on;
> > > > --
> > > > 2.17.1
> > > >
> > >
> >
> > Strangely, my checkpatch invocation on next-20221116 did not show that
> > warning and I am unaware that I made any specific changes to
> > checkpatch or its configuration.
> >
> > Anyway, checkpatch and you, Tommaso, are right and the patch can of
> > course be improved. I sent out a patch v2:
> >
> > https://lore.kernel.org/all/20221123075216.28193-1-lukas.bulwahn@gmail.com/
> >
> > I hope to get an Acked-by: tag from you now. Thanks.
>
> Sorry I miss the tag :)
>
> Acked-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>
> Apply the patch then run:
>  scripts/checkpatch.pl -f drivers/staging/media/imx/imx-media-fim.c
>

I see. I usually just run checkpatch.pl on the patch, but do not apply
the patch and run checkpatch on the file. That explains the difference
of observations. Good to know.

Lukas

> Regards,
> Tommaso
>
> >
> > Lukas
> >
> > > Apart of this, patch looks good to me.
> > > Thanks.
> > >
> > > Regards,
> > > Tommaso
> > >
> > > --
> > > Tommaso Merciai
> > > Embedded Linux Engineer
> > > tommaso.merciai@amarulasolutions.com
> > > __________________________________
> > >
> > > Amarula Solutions SRL
> > > Via Le Canevare 30, 31100 Treviso, Veneto, IT
> > > T. +39 042 243 5310
> > > info@amarulasolutions.com
> > > www.amarulasolutions.com
>
> --
> Tommaso Merciai
> Embedded Linux Engineer
> tommaso.merciai@amarulasolutions.com
> __________________________________
>
> Amarula Solutions SRL
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> T. +39 042 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com
