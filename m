Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2C46550A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiLWNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWNCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:02:13 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4011C1D;
        Fri, 23 Dec 2022 05:02:12 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u12so1252404ljj.11;
        Fri, 23 Dec 2022 05:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLiFI914zOkzkXTvAaxanO8GrrOqer4JEh858HAzIlc=;
        b=BcpfHL28XyAeo4JzL+ywLyxs+m/MC0a1vTSl/B7ufeEQIEuRAAroEZRbbIG9zDvUs8
         hEyMntDh6xroFZPksJAJnmCCWf5J9R/M8DgSzJSgvo11YVpedlee58evTVbCu+pLOin9
         ZjEbLbBjxADGy8LiOzDo4bL+WSvi+7Zm29gorb1PxLpDNI424kIot9ZCOIYSReHxIp9z
         ILslevOVoA2AOWiQbhYCHizq++A9L7HDtqmj1EqSOB2ux5AuVI3oij4W8DZhSAVndUcz
         TmxS3JXBM93DIigfgQsy4S4fWC+6fIsrnuaGo9N8VC/l0d6aO2Zm0wKb1+eOqAZkdSmK
         VY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLiFI914zOkzkXTvAaxanO8GrrOqer4JEh858HAzIlc=;
        b=AKLSYbvxW+MonN90dMNI/HhyEbDHSqQmNYUxWrR9CEPR7LQLexFrTYNhVKidd9ccOc
         lo59leg1RnB7Md89qHGPr/4wY+DWaP5czbEuBN8fedvJasYCxOesLI+PVlr9SfLDZfRn
         fln4ZM89NwU8/5k6W8WjksoaUQhWVl9rAaM9pQUilnULiwFJHH/FmQweKm3/0HTO7gKo
         +SPWeL+5q3vRIsMaTi88DwOvmvCBR9MkIVrZJzvn3cFJ+NAtcJuTCEH7NAazXK8FFaI2
         NT+0Ga2m3rIR8RGbkxfOi5U3hnRiNgRVmEuBnPSHGLrtS29i4PW8JIZWNhB9Uwft7cIf
         mXGQ==
X-Gm-Message-State: AFqh2kpL/tJ4hRk1MUWexKOH70bPxAvIXYnAJeofOkdA6bitB7au6YeG
        MlNnitkPBmvGOsbyslgJ/fI=
X-Google-Smtp-Source: AMrXdXsLOcTQ7NeTc/m34oj7a54PTtRcr1le6l/G1tmgK7dt/eeLaYYh3A8S8t5fFlJpdEveEY5v6Q==
X-Received: by 2002:a2e:98c3:0:b0:27f:1bd1:7c7a with SMTP id s3-20020a2e98c3000000b0027f1bd17c7amr2510045ljj.23.1671800531097;
        Fri, 23 Dec 2022 05:02:11 -0800 (PST)
Received: from [192.168.2.145] ([109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id z25-20020a2eb539000000b0027710117ebdsm421426ljm.121.2022.12.23.05.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 05:02:10 -0800 (PST)
Message-ID: <3c32ee42-2b75-ba16-dcd0-d12acd87b47f@gmail.com>
Date:   Fri, 23 Dec 2022 16:02:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 21/21] staging: media: tegra-video: add tegra20 variant
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-22-luca.ceresoli@bootlin.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221128152336.133953-22-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2022 18:23, Luca Ceresoli пишет:
> +static int tegra20_vip_start_streaming(struct tegra_vip_channel *vip_chan)
> +{
> +	struct tegra_vi_channel *vi_chan = v4l2_get_subdev_hostdata(&vip_chan->subdev);
> +	int width  = vi_chan->format.width;
> +	int height = vi_chan->format.height;
> +
> +	unsigned int main_input_format;
> +	unsigned int yuv_input_format;
> +
> +	tegra20_vi_get_input_formats(vi_chan, &main_input_format, &yuv_input_format);
> +
> +	tegra20_vi_write(vi_chan, TEGRA_VI_VI_CORE_CONTROL, 0);
> +
> +	tegra20_vi_write(vi_chan, TEGRA_VI_VI_INPUT_CONTROL,
> +			 VI_INPUT_VIP_INPUT_ENABLE | main_input_format | yuv_input_format);
> +
> +	tegra20_vi_write(vi_chan, TEGRA_VI_V_DOWNSCALE_CONTROL, 0);
> +	tegra20_vi_write(vi_chan, TEGRA_VI_H_DOWNSCALE_CONTROL, 0);
> +
> +	tegra20_vi_write(vi_chan, TEGRA_VI_VIP_V_ACTIVE, height << VI_VIP_V_ACTIVE_PERIOD_SFT);
> +	tegra20_vi_write(vi_chan, TEGRA_VI_VIP_H_ACTIVE,
> +			 roundup(width, 2) << VI_VIP_H_ACTIVE_PERIOD_SFT);
> +
> +	/*
> +	 * For VIP, D9..D2 is mapped to the video decoder's P7..P0.
> +	 * Disable/mask out the other Dn wires. When not in BT656
> +	 * mode we also need the V/H sync.
> +	 */
> +	tegra20_vi_write(vi_chan, TEGRA_VI_PIN_INPUT_ENABLE,
> +			 GENMASK(9, 2) << VI_PIN_INPUT_VD_SFT |
> +			 VI_PIN_INPUT_HSYNC | VI_PIN_INPUT_VSYNC);
> +	tegra20_vi_write(vi_chan, TEGRA_VI_VI_DATA_INPUT_CONTROL,
> +			 GENMASK(9, 2) << VI_DATA_INPUT_SFT);
> +	tegra20_vi_write(vi_chan, TEGRA_VI_PIN_INVERSION, 0);
> +
> +	tegra20_vi_write(vi_chan, TEGRA_VI_CONT_SYNCPT_OUT_1,
> +			 VI_CONT_SYNCPT_OUT_1_CONTINUOUS_SYNCPT |
> +			 host1x_syncpt_id(vi_chan->out_sp) << VI_CONT_SYNCPT_OUT_1_SYNCPT_IDX_SFT);

Wondering whether you also need to set up the sypct_incr condition to
op_done, it should be immediate by default. I see that T210 VI code sets
up the incr condition.
