Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9E678AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjAWWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjAWWqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:46:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7853756B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:46:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt14so34544401ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkAMX/B2MTCfyftMsOJJrPfYiTTByIZ9NFFUdVXdU30=;
        b=toQTimjh9JFaY0c8NR7V7CAHgYAmGPWU0zPNQKcBV45A1TksDVZMVBHM1dfYyPR4uV
         P7lau1IDWZuhTGzC9JI1QRbspZ6eyrioD8a5bv+VtaEQ9xPIVQqBycB2vX+SnKVQFcF4
         KIDzTApOE/BV8Hvx2GXO/X4IknOuhxk/NlrYg+V6T99YmRLoGTVFE8T1bX+ZkQvy7S2N
         eWJ8IEtU4WUtcLqTxLjGSm3wih3uWsYqZNrnRplLTVOB/aHWSOD5Vjf4YXHlhvsXTatB
         ev6TVlz8VoOTYewNwboW/C0phIqxBxDs8N9nVN9FDHwTKspBRBR1PNQzNkeaUEECy5HI
         ad/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkAMX/B2MTCfyftMsOJJrPfYiTTByIZ9NFFUdVXdU30=;
        b=GByr/zqG5mzmgG0yBsm4olyDwwsc4keGEQv2Rav0t4h3rwZVLe/Xm3YoRkdIYU1PWX
         E0d8P1cLwC5NgOoHiF/mwexFWHpUkmyze9mBE5I+7NpwMTOfF2KC60+sObUiRh2/7OFQ
         9WnnHOkyaAKCLAt5qYbEQhL1H4jJhB5P5RhANe4c8EIB7mqTdnpcT89YajHQJoAO8iNQ
         ihRT9knnP1AZ7q+exzYrEgEBs+Lv9OrmC9vQz1go19uIgtpOhfiEnkxOwvpZftUMT14e
         lqRRbc98DsEyZ1JLRuKbO37GE+L7OEvzxh7B6RvrRfepIv7Tbi5EyubMibSS2WmIc3TA
         TLGg==
X-Gm-Message-State: AFqh2koqiZTUjJtL485oZMK8eaAXT6ApHBle7Vw9fzslfZh953ahOiEB
        Bk6VRg03/6QMvmCE5ZYpxejpdQ==
X-Google-Smtp-Source: AMrXdXvCnMVkhpllRKGvsCpCjETEgJ4Wt4YF1bN+pOfSQ1n3bHPHoHJpqBhF/lapypJUpQ5RzS894g==
X-Received: by 2002:a17:906:5d1:b0:861:7a02:1046 with SMTP id t17-20020a17090605d100b008617a021046mr25353409ejt.37.1674513977548;
        Mon, 23 Jan 2023 14:46:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id lr26-20020a170906fb9a00b008566b807d8asm47194ejb.73.2023.01.23.14.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 14:46:16 -0800 (PST)
Message-ID: <e1521af3-ce93-8fec-bc1b-6d9db8f40e7e@linaro.org>
Date:   Tue, 24 Jan 2023 00:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 06/14] drm/msm/dp: add display compression related
 struct
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
 <1674498274-6010-7-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674498274-6010-7-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:24, Kuogee Hsieh wrote:
> Add display compression related struct to support variant compression
> mechanism. However, DSC is the only one supported at this moment.
> VDC may be added later.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_panel.h | 42 ++++++++++++++++++
>   drivers/gpu/drm/msm/msm_drv.h     | 89 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 131 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 1153e88..4c45d51 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -21,12 +21,54 @@ struct edid;
>   #define DP_DOWNSTREAM_PORTS		4
>   #define DP_DOWNSTREAM_CAP_SIZE		4
>   
> +
> +#define DP_PANEL_CAPS_DSC	BIT(0)
> +
> +enum dp_output_format {
> +	DP_OUTPUT_FORMAT_RGB,
> +	DP_OUTPUT_FORMAT_YCBCR420,
> +	DP_OUTPUT_FORMAT_YCBCR422,
> +	DP_OUTPUT_FORMAT_YCBCR444,
> +	DP_OUTPUT_FORMAT_INVALID,
> +};
> +
> +
> +struct dp_panel_info {
> +	u32 h_active;
> +	u32 v_active;
> +	u32 h_back_porch;
> +	u32 h_front_porch;
> +	u32 h_sync_width;
> +	u32 h_active_low;
> +	u32 v_back_porch;
> +	u32 v_front_porch;
> +	u32 v_sync_width;
> +	u32 v_active_low;
> +	u32 h_skew;
> +	u32 refresh_rate;
> +	u32 pixel_clk_khz;
> +	u32 bpp;
> +	bool widebus_en;
> +	struct msm_compression_info comp_info;
> +	s64 dsc_overhead_fp;
> +};
> +
>   struct dp_display_mode {
>   	struct drm_display_mode drm_mode;
> +	struct dp_panel_info timing;
>   	u32 capabilities;
> +	s64 fec_overhead_fp;
> +	s64 dsc_overhead_fp;
>   	u32 bpp;
>   	u32 h_active_low;
>   	u32 v_active_low;
> +	/**
> +	 * @output_format:
> +	 *
> +	 * This is used to indicate DP output format.
> +	 * The output format can be read from drm_mode.
> +	 */
> +	enum dp_output_format output_format;
>   };
>   
>   struct dp_panel_in {
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 9f0c184..f155803 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -1,6 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
>    * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023. Qualcomm Innovation Center, Inc. All rights reserved
>    * Copyright (C) 2013 Red Hat
>    * Author: Rob Clark <robdclark@gmail.com>
>    */
> @@ -70,6 +71,16 @@ enum msm_dp_controller {
>   #define MAX_H_TILES_PER_DISPLAY 2
>   
>   /**
> + * enum msm_display_compression_type - compression method used for pixel stream
> + * @MSM_DISPLAY_COMPRESSION_NONE:     Pixel data is not compressed
> + * @MSM_DISPLAY_COMPRESSION_DSC:      DSC compresison is used
> + */
> +enum msm_display_compression_type {
> +	MSM_DISPLAY_COMPRESSION_NONE,
> +	MSM_DISPLAY_COMPRESSION_DSC,
> +};
> +
> +/**
>    * enum msm_event_wait - type of HW events to wait for
>    * @MSM_ENC_COMMIT_DONE - wait for the driver to flush the registers to HW
>    * @MSM_ENC_TX_COMPLETE - wait for the HW to transfer the frame to panel
> @@ -82,6 +93,84 @@ enum msm_event_wait {
>   };
>   
>   /**
> + * struct msm_display_dsc_info - defines dsc configuration

This structure was removed. Please keep it this way. We are not going to 
reintroduce it unless it is really required for some reason. And up to 
now I don't see a good reason for adding it back.

> + * @config                   DSC encoder configuration
> + * @scr_rev:                 DSC revision.
> + * @initial_lines:           Number of initial lines stored in encoder.
> + * @pkt_per_line:            Number of packets per line.
> + * @bytes_in_slice:          Number of bytes in slice.
> + * @eol_byte_num:            Valid bytes at the end of line.
> + * @bytes_per_pkt            Number of bytes in DSI packet
> + * @pclk_per_line:           Compressed width.
> + * @slice_last_group_size:   Size of last group in pixels.
> + * @slice_per_pkt:           Number of slices per packet.
> + * @num_active_ss_per_enc:   Number of active soft slices per encoder.
> + * @source_color_space:      Source color space of DSC encoder
> + * @chroma_format:           Chroma_format of DSC encoder.
> + * @det_thresh_flatness:     Flatness threshold.
> + * @extra_width:             Extra width required in timing calculations.
> + * @pps_delay_ms:            Post PPS command delay in milliseconds.
> + * @dsc_4hsmerge_en:         Using DSC 4HS merge topology
> + * @dsc_4hsmerge_padding     4HS merge DSC pair padding value in bytes
> + * @dsc_4hsmerge_alignment   4HS merge DSC alignment value in bytes
> + * @half_panel_pu            True for single and dual dsc encoders if partial
> + *                           update sets the roi width to half of mode width
> + *                           False in all other cases
> + */
> +struct msm_display_dsc_info {
> +	struct drm_dsc_config drm_dsc;
> +	u8 scr_rev;
> +
> +	int initial_lines;
> +	int pkt_per_line;
> +	int bytes_in_slice;
> +	int bytes_per_pkt;
> +	int eol_byte_num;
> +	int pclk_per_line;
> +	int slice_last_group_size;
> +	int slice_per_pkt;
> +	int num_active_ss_per_enc;
> +	int source_color_space;
> +	int chroma_format;
> +	int det_thresh_flatness;
> +	u32 extra_width;
> +	u32 pps_delay_ms;
> +	bool dsc_4hsmerge_en;
> +	u32 dsc_4hsmerge_padding;
> +	u32 dsc_4hsmerge_alignment;
> +	bool half_panel_pu;
> +};
> +
> +/*
> + * conver from struct drm_dsc_config to struct msm_display_dsc_info
> + */
> +#define to_msm_dsc_info(dsc) container_of((dsc), struct msm_display_dsc_info, drm_dsc)
> +
> +/**
> + * Bits/pixel target >> 4  (removing the fractional bits)
> + * returns the integer bpp value from the drm_dsc_config struct
> + */
> +#define DSC_BPP(config) ((config).bits_per_pixel >> 4)
> +
> +/**
> + * struct msm_compression_info - defined panel compression
> + * @enabled:          enabled/disabled
> + * @comp_type:        type of compression supported
> + * @comp_ratio:       compression ratio
> + * @src_bpp:          bits per pixel before compression
> + * @tgt_bpp:          bits per pixel after compression
> + * @msm_dsc_info:     msm dsc info if the compression supported is DSC
> + */
> +struct msm_compression_info {
> +	bool enabled;
> +	enum msm_display_compression_type comp_type;
> +	u32 comp_ratio;
> +	u32 src_bpp;
> +	u32 tgt_bpp;
> +	struct msm_display_dsc_info msm_dsc_info;
> +};
> +
> +/**
>    * struct msm_display_topology - defines a display topology pipeline
>    * @num_lm:       number of layer mixers used
>    * @num_intf:     number of interfaces the panel is mounted on

-- 
With best wishes
Dmitry

