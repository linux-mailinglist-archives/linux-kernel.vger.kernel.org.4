Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBCC65506C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiLWMgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiLWMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:36:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA28FBC9B;
        Fri, 23 Dec 2022 04:36:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s10so4903814ljg.1;
        Fri, 23 Dec 2022 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3UKnhEZQUn5GYS/RbUjSz4ZcQWY1ixwYwswiqDVqN4=;
        b=ZMj8Y/j8X8EoTO+KuKX8colZn+dhXdx8X1p3IZfbkZGh1LneEu7csBHwCLpu/89mdh
         VA57l0Ls/nQDnDIcDSTcQRx6mVOsUT4YNgY/E2Up3vxOxjW0xgk1pF1JRe4hI8WEhPwa
         dOYkY6OJZuJLGrNkxJzC7Y0CoGnozi6s6k8fafoQ80XGnbDOHlHLGIb8LsQKPXCpqt3Q
         mr9P0WahGP8y0eaQkkPbzgGvBQoUJgINgUufJ6Z94cu/nOSHLJHa8edCHdEXz+kzJi9l
         d9VUpbqTfEhP7dfmPKXBtpnVGfeZfoZPEVDQY/u5X9sinrM+4dKtk+fR6JyIaUAY+DbJ
         U/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3UKnhEZQUn5GYS/RbUjSz4ZcQWY1ixwYwswiqDVqN4=;
        b=HNbTJ5LtJYQW/73/87TtJZdPydo4mlZ31JcRDmfrTPemGC4eipnZGdmCqeD57EN8y+
         wNr1WjLqlur4bTIzIyQssYPHXStI6YX8QMXyaVpUMMsnCCr0iQrofBySTzaA5SvTDfCE
         NjdY0nKHkur6K3rfirNgrnejVyvkKw+BWfnaP5VH3PDVxF8PJiZx2SIF6WcdRIoBy/AM
         bmBsYBp0T/+5P3di8YmN3hWKmgyTR4TVYb/PV5zWMikg2N96zmwo83qXNV6GwB7XCgt2
         Unz2zQtjxmTTCxqlvUu90sdb8Hj5zYI+6/IRpTeVbAkhuct8xuvtosDG/PoC5pcdyI4k
         y7vA==
X-Gm-Message-State: AFqh2krpVxOzuBXGBuOGo3X52CZlrbwZBGRehcL85hUhDuKYQBepH3AN
        XO7vHvQv8kIB1X73vaSI/9s=
X-Google-Smtp-Source: AMrXdXvhITzwpOd2W35sRsxL4USYcqWShDT+nWnLh4NFjRnjHAGbmI41tTpVVmFbTBCc3uqKHwW4TQ==
X-Received: by 2002:a2e:8197:0:b0:27d:e218:a528 with SMTP id e23-20020a2e8197000000b0027de218a528mr3813756ljg.12.1671798960143;
        Fri, 23 Dec 2022 04:36:00 -0800 (PST)
Received: from [192.168.2.145] ([109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id z8-20020a2eb528000000b0027a026088b6sm405599ljm.95.2022.12.23.04.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 04:35:59 -0800 (PST)
Message-ID: <44d2d972-1cdf-fdb2-5dc0-cc493f79b3da@gmail.com>
Date:   Fri, 23 Dec 2022 15:35:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 21/21] staging: media: tegra-video: add tegra20 variant
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
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
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
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
> +/* --------------------------------------------------------------------------
> + * VIP
> + */
> +
> +/*
> + * VIP-specific configuration for stream start.
> + *
> + * Whatever is common among VIP and CSI is done by the VI component (see
> + * tegra20_vi_start_streaming()). Here we do what is VIP-specific.
> + */
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
> +
> +	tegra20_vi_write(vi_chan, TEGRA_VI_CAMERA_CONTROL, VI_CAMERA_CONTROL_STOP_CAPTURE);
> +
> +	return 0;
> +}
> +
> +static const struct tegra_vip_ops tegra20_vip_ops = {
> +	.vip_start_streaming = tegra20_vip_start_streaming,
> +};
> +
> +const struct tegra_vip_soc tegra20_vip_soc = {
> +	.ops = &tegra20_vip_ops,
> +};

Shouldn't this be placed in vip.c? Also looks like patch #20 won't link
because tegra20_vip_soc is defined in patch #21.
