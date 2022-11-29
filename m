Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F563C618
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiK2RFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiK2RFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:05:15 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043796D95F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:03:38 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1432a5f6468so17765489fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAXWficdb5Gh5FzYn9UMAwDhZ8CYJoMoqCIJ7//eDF4=;
        b=ljTM73sTaDXWg3oaSywePDjqX298nSKxGHlaRqrv/LsDQrh3Mk9juSNxGkuzLumWxy
         /O1+AvGM4FAywdTpyxCQGuYt9iKWmSXYzMbOF8AqODsFHqIaEIKHAcDeYgoOxqm3Fr4o
         TBRSen1aQi9VAoZMPuBILu+kBDk8UQm+R3FRy3pdzsmnDkxBuftdOqpEmxAanK+Th54j
         b8OVtjKBlDakl7FEtLr3q1dHi6yezL2+/uByMQUdbFwTiXZVM3v9O0eFVdNSo9ZoknNt
         vw3QrBqFV9EaNlDr4769W5eAGUfmEToEGJFnua/uUW+Qw2+N1owsFPR77QI/qPD9Wf6L
         rAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAXWficdb5Gh5FzYn9UMAwDhZ8CYJoMoqCIJ7//eDF4=;
        b=E1uzU6nDYc8Z4bo6f4WFilLA4Oj6lledVxIf4TtBCrVij5PAO6nmw5TzTJo4iZLcdI
         Ic57+V90P3LZyKfQvAScwlxePMyKrD1cda0Z/RwCD2c5ieB1kdSTMzbB/f4SOm2aqTml
         rIHbLLvA60+1/OUexf753RMX+/s/cAq6uhOL9lqaIt4/D7Lq+xmJgf5Z029C1RP2gje6
         xC8AT+iKCsahAwx+fEG9W8PsHOfZNRAAMGXEDX9SjKd/zSfharlYYaLhh7FaS5yCrPaW
         Xt/uIzTtK9jwO/0jBYmbfGTl2hgs0XpcFmvs9FctVW8p6tNwQk+X4lajxZusJowZta1t
         USDQ==
X-Gm-Message-State: ANoB5plfgPYleO7ljPFwdRVOHwpWbr4aWO9dSwmB0i5DRKzO7xHpjyQz
        g7IK2Bx46BYGJDqmlYjeWYTiGred/JnSKNtricTnVg==
X-Google-Smtp-Source: AA0mqf6Tdo6X8IWcObQq2o/3ErG6HPcwPrWCjYttmbMFTp3CWvG1wKOXHHCA+4UMzfOIMYG1UrxXlV2FAe3l3HjF3RI=
X-Received: by 2002:a05:6870:7988:b0:13c:84e6:96d2 with SMTP id
 he8-20020a056870798800b0013c84e696d2mr36802093oab.72.1669741416887; Tue, 29
 Nov 2022 09:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20221124085436.24900-1-jiaxin.yu@mediatek.com> <20221124085436.24900-3-jiaxin.yu@mediatek.com>
In-Reply-To: <20221124085436.24900-3-jiaxin.yu@mediatek.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 29 Nov 2022 18:03:26 +0100
Message-ID: <CAG3jFyvLAHfxtKVoFFUOwUacO+t+FC3x5J9Eg-qWOUVBnU8JfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: hdmi-codec: Add event handler for hdmi TX
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        kuninori.morimoto.gx@renesas.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        chunxu.li@mediatek.com, ajye_huang@compal.corp-partner.google.com,
        allen-kh.cheng@mediatek.com, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 at 09:54, Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> If the speaker and hdmi are connect to the same port of I2S,
> when try to switch to speaker playback, we will find that hdmi
> is always turned on automatically. The way of switching is
> through SOC_DAPM_PIN_SWITCH, however, such events can not be
> handled in hdmi-codec driver.
>
> So add event handler for hdmi TX to solve the above issue.
>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  include/sound/hdmi-codec.h    |  6 ++++++
>  sound/soc/codecs/hdmi-codec.c | 37 +++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 48ad33aba393..dcbc09254144 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -81,6 +81,12 @@ struct hdmi_codec_ops {
>                        struct hdmi_codec_daifmt *fmt,
>                        struct hdmi_codec_params *hparms);
>
> +       /*
> +        * PCM trigger callback.
> +        * Mandatory
> +        */
> +       int (*trigger)(struct device *dev, int cmd);
> +
>         /*
>          * Shuts down the audio stream.
>          * Mandatory
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 0b1cdb2d6049..cb4479372e09 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -276,7 +276,31 @@ struct hdmi_codec_priv {
>         u8 iec_status[AES_IEC958_STATUS_SIZE];
>  };
>
> +static int hdmi_tx_event(struct snd_soc_dapm_widget *w,
> +               struct snd_kcontrol *kcontrol, int event)

checkpatch --strict caught this alignment issue.

ASoC: hdmi-codec: Add event handler for hdmi TX
-:44: CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#44: FILE: sound/soc/codecs/hdmi-codec.c:280:
+static int hdmi_tx_event(struct snd_soc_dapm_widget *w,
+        struct snd_kcontrol *kcontrol, int event)



> +{
> +       struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +       struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> +
> +       switch (event) {
> +       case SND_SOC_DAPM_PRE_PMU:
> +               if (hcp->hcd.ops->trigger)
> +                       hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_START);
> +               break;
> +       case SND_SOC_DAPM_POST_PMD:
> +               if (hcp->hcd.ops->trigger)
> +                       hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_STOP);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct snd_soc_dapm_widget hdmi_widgets[] = {
> +       SND_SOC_DAPM_OUT_DRV_E("SDB", SND_SOC_NOPM, 0, 0, NULL, 0, hdmi_tx_event,
> +                              SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_PRE_PMU),
>         SND_SOC_DAPM_OUTPUT("TX"),
>         SND_SOC_DAPM_OUTPUT("RX"),
>  };
> @@ -808,18 +832,23 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
>         struct hdmi_codec_daifmt *daifmt;
>         struct snd_soc_dapm_route route[] = {
>                 {
> -                       .sink = "TX",
> +                       .sink = dai->driver->capture.stream_name,
> +                       .source = "RX",
> +               },
> +               {
> +                       .sink = "SDB",
>                         .source = dai->driver->playback.stream_name,
>                 },
>                 {
> -                       .sink = dai->driver->capture.stream_name,
> -                       .source = "RX",
> +                       .sink = "TX",
> +                       .source = "SDB",
>                 },
> +
>         };
>         int ret;
>
>         dapm = snd_soc_component_get_dapm(dai->component);
> -       ret = snd_soc_dapm_add_routes(dapm, route, 2);
> +       ret = snd_soc_dapm_add_routes(dapm, route, ARRAY_SIZE(route));
>         if (ret)
>                 return ret;
>
> --
> 2.18.0
>
