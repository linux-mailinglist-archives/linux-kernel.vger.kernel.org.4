Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3845F88A3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJIAs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJIAsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 20:48:55 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40420357E5;
        Sat,  8 Oct 2022 17:48:54 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r20so4194117ilt.11;
        Sat, 08 Oct 2022 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5HaFroFXHgbxThoT0RIR6rsbRVYC8ZGOScKtFyRa64=;
        b=FnUB16h8kIXSKk8rS8AZG3S1iJ1AU1VMvwgRkl5zRkeyT+qG6TW9bpQDZ0bqlWLK54
         KKZvD9wPHUExyUaVu4rj7wRNyIjW/U2Qywofk7FIDZlbNrA0aHGMX6nrLnom08JS1geJ
         1wHiW9QVTYZSNCxr2bvPlDc0Lbib/s1sjqY1d5/7lopTTQu5cLaIbAu6TD90l9OQy/KD
         4pRMoyHNjywJaUamq91j6Bzzgh04fXOCcR1Yqy2J4kov055d8QcazOs+ipUNwFetbutJ
         yo6MVQ4Ed2AonUgIIIQFuSx0Ad8uJ10B8RFLzE+nCuDPe4JOTY19rYIHTpH+me3ghe0D
         t2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5HaFroFXHgbxThoT0RIR6rsbRVYC8ZGOScKtFyRa64=;
        b=5Tuf+7lHVN8rrZiafWyeKhOJZ0dkJSVU/GW+Fx42ZWsdL4HhNUn44GqpMXdnLyGWki
         0Dv4lqVQURB/Rjob90WaTJITz0VySCbqxwG9I3+VpJF7JBOTP6IOxWXpyy1UcFj4P5SJ
         3iL2zeN1gxCxGuuB4zHyh6vWp93jvPIXqcEY3pcRiKiDAKnnvllIdzmk98Ozkv1mtic5
         JJhG1ikzxoHkforcjqk8As9cYZSMepkvOVr3M2g8B2QgToftoCVnnBvBGjky4JZTophN
         xq6DcErWsglrQhzxIwUQYEjBEizWCx/X4cqKc0WC6H7VM9cspnnWmvf8fMMQdlEFBmXH
         YMQA==
X-Gm-Message-State: ACrzQf1685zdfdMAlzTLe/2LHKx48FQWauxpXnp9nLgANKyqnouB6THW
        NEtVUeagWXBQPA+brDbVttG+vYLtOE8=
X-Google-Smtp-Source: AMsMyM7qM3gqM9HPQdOkSys+xwBl/2X+WibEuPYH38zUCJH+qBIXkC5OkQVZc5p0Wn6UqZN2D2DOKQ==
X-Received: by 2002:a05:6e02:1bc7:b0:2fa:876e:95a7 with SMTP id x7-20020a056e021bc700b002fa876e95a7mr5798035ilv.240.1665276533543;
        Sat, 08 Oct 2022 17:48:53 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id t22-20020a026416000000b00349c45fd3a8sm2546894jac.29.2022.10.08.17.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 17:48:53 -0700 (PDT)
Message-ID: <36657a31-2d34-e5eb-f7c4-ffcf86481c9d@gmail.com>
Date:   Sat, 8 Oct 2022 19:48:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] sound: soc: codecs: wcd-mbhc-v2: expose ALSA control
 for jack
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20221007155716.10594-1-me@dylanvanassche.be>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <20221007155716.10594-1-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can confirm that this is required for Pulseaudio to pick up the
headphones properly. I tested this in my Xiaomi Poco F1 running
postmarketOS (Phosh Mobile Desktop Environment). You can check the
following pulseaudio issue for some more info.

Link: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1377

Tested-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>

On 07/10/22 10:57, Dylan Van Assche wrote:
> Jack detection is currently fully functional via the input
> interface together with multimedia buttons, but is not exposed
> as an ALSA control. Therefore, ALSA clients such as PulseAudio
> do not pick up the jack detection events as they only support
> one of the possible interface (ALSA control or input interface,
> but not both). Expose the jack events as an ALSA control and input
> interface to provide ALSA clients both interfaces.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  sound/soc/codecs/wcd-mbhc-v2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index 1911750f7445..1b75f49b2858 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -725,6 +725,10 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
>  
>  	mutex_lock(&mbhc->lock);
>  
> +	ret = snd_jack_add_new_kctl(mbhc->jack->jack, "Headset Jack", WCD_MBHC_JACK_MASK);
> +	if (ret)
> +		dev_warn(component->dev, "failed creating Headset Jack kctl with err: %d\n", ret);
> +
>  	/* enable HS detection */
>  	if (mbhc->mbhc_cb->hph_pull_up_control_v2)
>  		mbhc->mbhc_cb->hph_pull_up_control_v2(component,
