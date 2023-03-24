Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC76C753D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCXBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXByz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:54:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807818AAD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:54:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id j7so570627ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679622893;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sjw9hF1VqdmoHrY7ec4dOnY8KEiWEpFK1tLrgDIDPDw=;
        b=ngpfi2XkevumsTXUHa6RpEijF7Tf9/a3e9CTq8xX5lhOlGN8SrKQw8xSUfFRxVDIGM
         a4lOBNLZoPKRCZUw1KgwODkyX6VrrjDqbJLwYxFb4jh904zeU66MoJ8Ze1GbJABvDSrz
         1AwFmJwMgcIeLhY6nkDS3oI/7AkPmHgHdPDMWLG9FXojyu6qljVdmqobrJQlFypVJ5ht
         2lzkZB6cX7tIWrXf8srF434FY9ZQTKqNc6GCIQFrm3cqhl1XzYailbXLE7Cvg0D2U+T1
         qo8HJKxnW0ydEqRtm8aVWuDGJbqycDUN4YZQcqhbSYe/ywoJ2KLpNgGu5ZWl2ywZUcuC
         bsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679622893;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjw9hF1VqdmoHrY7ec4dOnY8KEiWEpFK1tLrgDIDPDw=;
        b=jcAw5PhM16hJ5MykI8F6/oFrwZr1lMFUmEa1pOyih9QMTU6mFvHjpBlhSdAsLO42pN
         mAeMBrsUacULVpsnlmLwEvDoBwxjc/h8eCm7Uuu0ZUuub4Ek7xJsUQrkMDdGqQHtuhwK
         XOvDWG82nPAEaCwl/ckAqWo9RVEFoidu+aeH8fI2BrX7YMpjhh6jGGFjNUhUrqX6vkMw
         TW1K41g54uhcz0Srp1viwnrxbhJjp0PGYoGX4aNoXbnY+6eAzBSvFEUSswh+MHIDxdZY
         mM4KJhJcYtAnNBMsdZB62vj7Ok8BAP1W4pz8eMpwF6otSj6DjSCjZPNnaZuk6Oda9FXB
         5X7Q==
X-Gm-Message-State: AAQBX9fJXLpAgatJy3CU6fXQCN9u0lXzBCqAMh5Bbs8cKPUkZ9ytDP4v
        165Zm14/bIzqc6ubAUdyYwExZ3qbpf3tT1oZf2+ZFZvRRSu20ggl
X-Google-Smtp-Source: AKy350Ydyuz+4Fe/nk2NQpBJ8nMQgVF3kz9s37elFvOGqH1xZln2OSjULGSmp6b8rFccUS18mE9s9Csi7GtQ7aCOQUI=
X-Received: by 2002:a05:6902:1009:b0:b6b:e967:920d with SMTP id
 w9-20020a056902100900b00b6be967920dmr288549ybt.13.1679622893642; Thu, 23 Mar
 2023 18:54:53 -0700 (PDT)
MIME-Version: 1.0
From:   Zhu Ning <zhuning0077@gmail.com>
Date:   Fri, 24 Mar 2023 09:54:41 +0800
Message-ID: <CANPLYpBv82p-Fve-JgM=WDwUFp-VnKfG2yFvcGv8AT2roPEifw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables sound
 for systems with a ES8336 codec
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, posteuca@mutex.one,
        tiwai@suse.com, yangxiaohua <yangxiaohua@everest-semi.com>,
        Ning Zhu <zhuning0077@gmail.com>,
        Zhu Ning <zhuning@everest-semi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The GPIO thing on Huawei Intel platform is too complicated, they use two GPIOs
> > for headphone and speaker, and the headphone GPIO is inverted, which means low
> > means on and high means off. Luckily there should be only one hardware config
> > for the AMD acp3x platform GPIO and you may just choose the correct one.
>
> There being two different GPIOs sounds like it just allows the headphone
> and speaker to be controlled separately - that seems more flexible, not
> a problem?

Yes it's called multi stream in Windows. However, extra GPIO causes
more confusion
in the driver.

> > There is no such situation, and the system doesn't produce sound from speaker
> > when headphones are plugged in. The user may manually open speaker using
> > amixer sset 'Speaker' on or pavucontrol.
>
> Again, you're describing a specific configuration - someone might want
> to do something different.

Hi Marian Postevca you may want to separate the GPIO control by adding Headphone
Power SND_SOC_DAPM_SUPPLY. You may also want to change the gpio
handling function
in the acp3x_es83xx_jack_events function.

static const struct snd_soc_dapm_widget acp3x_es83xx_widgets[] = {
        SND_SOC_DAPM_SPK("Speaker", NULL),
        SND_SOC_DAPM_HP("Headphone", NULL),
        SND_SOC_DAPM_MIC("Headset Mic", NULL),
        SND_SOC_DAPM_MIC("Internal Mic", NULL),

+       SND_SOC_DAPM_SUPPLY("Headphone Power", SND_SOC_NOPM, 0, 0,
+                           acp3x_es83xx_headphone_power_event,
+                           SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
        SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
                            acp3x_es83xx_speaker_power_event,
                            SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
};

static const struct snd_soc_dapm_route acp3x_es83xx_audio_map[] = {
        {"Headphone", NULL, "HPOL"},
        {"Headphone", NULL, "HPOR"},
+       {"Headphone", NULL, "Headphone Power"},

        {"Speaker", NULL, "HPOL"},
        {"Speaker", NULL, "HPOR"},
        {"Speaker", NULL, "Speaker Power"},
};

+static int acp3x_es83xx_headphone_power_event(struct snd_soc_dapm_widget *w,
+                                           struct snd_kcontrol
*kcontrol, int event)
+{
+       struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
+
+       dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
+       if (SND_SOC_DAPM_EVENT_ON(event))
+               gpiod_set_value_cansleep(priv->gpio_headphone, true);
+       else
+               gpiod_set_value_cansleep(priv->gpio_headphone, false);
+
+       return 0;
+}
+
+static int acp3x_es83xx_speaker_power_event(struct snd_soc_dapm_widget *w,
+                                           struct snd_kcontrol
*kcontrol, int event)
+{
+       struct acp3x_es83xx_private *priv = get_mach_priv(w->dapm->card);
+
+       dev_dbg(priv->codec_dev, "speaker power event: %d\n", event);
+       if (SND_SOC_DAPM_EVENT_ON(event))
+               gpiod_set_value_cansleep(priv->gpio_speakers, true);
+       else
+               gpiod_set_value_cansleep(priv->gpio_speakers, false);
+
+       return 0;
+}
