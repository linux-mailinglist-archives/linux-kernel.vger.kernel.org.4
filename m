Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA66351BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiKWH6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiKWH4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:56:33 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35926AD0;
        Tue, 22 Nov 2022 23:56:18 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3a7081e3b95so62949697b3.1;
        Tue, 22 Nov 2022 23:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+KTB0yCVy00ksfR0u4Zctg6mmMhF4ijcHC1EOhuum4=;
        b=ci9XwZGCABJJ8P+PbOMoIT+tN/dhXjJWbSRrY2gBs92AJpBEC9TUtqnwYYja0qnpau
         n467+caVA8Ir5xqj0D+47K9ZuAmHGV3qpy/kPa+igWfzvGIARrKeH+kBke87eb5gwWEP
         OxyWmZda7fEY1WYcyzoyZpnMbMUKx1ZZoWG9Hf/Ba/0qEVmRZkgyaTNjkjYdkY3gV97u
         /ZkfFVj6CiwNXENvnu6UYPiZ3GLZN9oNKKWj4BuvK4JHRi1OHjx05i3VmMc1aoBJtlpy
         X2KZRpm8Ed6pnjzNCqY897MShEgoSmCRM1T2hD6T9DtvcHfxifeYUI7lx+a4Y2q3TDbQ
         9Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+KTB0yCVy00ksfR0u4Zctg6mmMhF4ijcHC1EOhuum4=;
        b=A6wdwibztIijGSj2HYZYdQuKKrIIYrrwIGNzv+xDy/c4erqwwAV/Vv7pLmwj5V81a/
         Z+gKa211dBRBpLIDvKYY63wnv0NCD+uyLPOXyNecNM+icC/TTSCuQSnKTrh9mXYbNRCF
         DkJIuDMWWla0bL3WE0uNo4+GUGD2KhQ8bltWk+C9P6BNz9XbsQRsubUfazrzr/q9BGeu
         XXWaWTUcPJGTZ0pRNL9Mnln+H/BfMStMM6X59DwXPlQI7onVqCJu7yZggPW2R6hZ64pv
         DnOjAeQ0wRfJBGi0MELs4acaG3YScMzxjyUEZ1MSJk1l0Jw05YM3O1nZFsoXAfiUF9fa
         t7/A==
X-Gm-Message-State: ANoB5plYpdY2fkxkOIF2eUcIHIVmaPJk/f5j4azSR5CuDaoMSUi8gitH
        DDbUSc0pX62jNxKivPd7df8W7PkN8lW65NhzknxBBitsTjM=
X-Google-Smtp-Source: AA0mqf5edvqImTS8UzpZAtFMg2nLoHcI5qbM0dKiZrOF6BmRciK/NHIVS1ynbpnUNMdGvG6DNsiKTu6n+6Dz3kWq9vs=
X-Received: by 2002:a0d:ca05:0:b0:3af:60cc:7496 with SMTP id
 m5-20020a0dca05000000b003af60cc7496mr1903074ywd.510.1669190177606; Tue, 22
 Nov 2022 23:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20221122132330.30408-1-lukas.bulwahn@gmail.com> <20221122160937.GB39395@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20221122160937.GB39395@tom-ThinkPad-T14s-Gen-2i>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 23 Nov 2022 08:56:06 +0100
Message-ID: <CAKXUXMxk-YoG4TdB8Em+cEMF8NA7rdMAboQz8nmhfVmVQ8oATA@mail.gmail.com>
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

On Tue, Nov 22, 2022 at 5:09 PM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
>
> Hi Lukas,
>
> On Tue, Nov 22, 2022 at 02:23:30PM +0100, Lukas Bulwahn wrote:
> > There never was a config IMX_GPT_ICAP in the repository. So remove the code
> > conditional on this config and simplify the callers that just called empty
> > functions.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  drivers/staging/media/imx/imx-media-fim.c | 54 -----------------------
> >  1 file changed, 54 deletions(-)
> >
> > diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> > index 3a9182933508..19a48eb445fd 100644
> > --- a/drivers/staging/media/imx/imx-media-fim.c
> > +++ b/drivers/staging/media/imx/imx-media-fim.c
> > @@ -187,54 +187,6 @@ static void frame_interval_monitor(struct imx_media_fim *fim,
> >               send_fim_event(fim, error_avg);
> >  }
> >
> > -#ifdef CONFIG_IMX_GPT_ICAP
> > -/*
> > - * Input Capture method of measuring frame intervals. Not subject
> > - * to interrupt latency.
> > - */
> > -static void fim_input_capture_handler(int channel, void *dev_id,
> > -                                   ktime_t timestamp)
> > -{
> > -     struct imx_media_fim *fim = dev_id;
> > -     unsigned long flags;
> > -
> > -     spin_lock_irqsave(&fim->lock, flags);
> > -
> > -     frame_interval_monitor(fim, timestamp);
> > -
> > -     if (!completion_done(&fim->icap_first_event))
> > -             complete(&fim->icap_first_event);
> > -
> > -     spin_unlock_irqrestore(&fim->lock, flags);
> > -}
> > -
> > -static int fim_request_input_capture(struct imx_media_fim *fim)
> > -{
> > -     init_completion(&fim->icap_first_event);
> > -
> > -     return mxc_request_input_capture(fim->icap_channel,
> > -                                      fim_input_capture_handler,
> > -                                      fim->icap_flags, fim);
> > -}
> > -
> > -static void fim_free_input_capture(struct imx_media_fim *fim)
> > -{
> > -     mxc_free_input_capture(fim->icap_channel, fim);
> > -}
> > -
> > -#else /* CONFIG_IMX_GPT_ICAP */
> > -
> > -static int fim_request_input_capture(struct imx_media_fim *fim)
> > -{
> > -     return 0;
> > -}
> > -
> > -static void fim_free_input_capture(struct imx_media_fim *fim)
> > -{
> > -}
> > -
> > -#endif /* CONFIG_IMX_GPT_ICAP */
> > -
> >  /*
> >   * In case we are monitoring the first frame interval after streamon
> >   * (when fim->num_skip = 0), we need a valid fim->last_ts before we
> > @@ -435,14 +387,8 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
> >               spin_unlock_irqrestore(&fim->lock, flags);
> >
> >               if (icap_enabled(fim)) {
> > -                     ret = fim_request_input_capture(fim);
> > -                     if (ret)
> > -                             goto out;
> >                       fim_acquire_first_ts(fim);
> >               }
>
> As suggested by the checkpatch.pl:
> WARNING: braces {} are not necessary for single statement blocks
>
> > -     } else {
> > -             if (icap_enabled(fim))
> > -                     fim_free_input_capture(fim);
> >       }
> >
> >       fim->stream_on = on;
> > --
> > 2.17.1
> >
>

Strangely, my checkpatch invocation on next-20221116 did not show that
warning and I am unaware that I made any specific changes to
checkpatch or its configuration.

Anyway, checkpatch and you, Tommaso, are right and the patch can of
course be improved. I sent out a patch v2:

https://lore.kernel.org/all/20221123075216.28193-1-lukas.bulwahn@gmail.com/

I hope to get an Acked-by: tag from you now. Thanks.

Lukas

> Apart of this, patch looks good to me.
> Thanks.
>
> Regards,
> Tommaso
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
